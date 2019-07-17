require 'gitlab'
require 'rake'
require 'rubygems'
require 'cucumber/rake/task'
require_relative '../lib/gitlab/client'
require_relative '../lib/gitlab/release_note'

namespace :qat do
  namespace :devel do
    namespace :gitlab do

      def get_project_version
        gemspec      = Dir.glob('*.gemspec').first
        gemspec_spec = Gem::Specification::load(gemspec)
        gemspec_spec.version.to_s
      end

      def get_project_name
        gemspec                = Dir.glob('*.gemspec').first
        gemspec_spec           = Gem::Specification::load(gemspec)
        base_name, module_name = gemspec_spec.name.to_s.split('-')

        if module_name
          "#{base_name.upcase} #{module_name.capitalize}"
        else
          base_name.upcase
        end
      end

      desc 'Validates that all issues in the current milestone are closed'
      task :milestone_issues_closed do
        milestone_title = get_project_version

        client = QAT::Devel::GitLab::Client.new

        milestone_id = client.get_milestone_id(milestone_title)
        all_closed   = client.all_milestone_issues_closed?(milestone_id)

        if all_closed
          puts "All issues in milestone #{milestone_title} are closed."
        else
          fail("There are open issues in milestone #{milestone_title}!")
        end
      end

      desc 'Create release note for milestone'
      task :milestone_release_note do
        milestone_title = get_project_version

        client = QAT::Devel::GitLab::Client.new

        milestone_id = client.get_milestone_id(milestone_title)
        issues       = client.get_all_milestone_issues(milestone_id)

        release_note = QAT::Devel::GitLab::ReleaseNote.new(get_project_name, milestone_title, issues)

        if release_note.text.empty?
          fail("Failed to generate release note for milestone #{milestone_title}!")
        else
          puts release_note.text
        end
      end

      desc 'Create a tag for the release of the milestone (includes Release Note generation)'
      task :milestone_tag => [:milestone_release_note] do
        milestone_title = get_project_version

        release_note = File.read(File.join(Dir.pwd, 'public', "release_note_#{milestone_title}.md"))

        client = QAT::Devel::GitLab::Client.new

        client.create_release_tag(milestone_title, release_note)
      end

      desc 'Check that the version in development is greater the last existing tag'
      task :check_version_tags, :version do |_, params|
        begin
          client = QAT::Devel::GitLab::Client.new

          version = params[:version] || get_project_version

          tags         = client.get_tags
          last_version = tags.first.to_h['name']

          if last_version.nil?
            puts "This repository still has no tags!"
          elsif Gem::Version.new(last_version) < Gem::Version.new(version)
            puts "This version (#{version}) is greater than that the last released version (tag)!"
          else
            fail("This version #{version} is lesser or equal to the last released version (tag) #{last_version}!")
          end
        rescue Gitlab::Error::Forbidden
          fail("Project has no repository or access was denied!")
        end
      end
    end
  end
end
