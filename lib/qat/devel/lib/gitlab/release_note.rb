require 'gitlab'
require_relative '../../version'

module QAT
  module Devel
    # GitLab global namespace
    module GitLab
      # Creates a new release note
      class ReleaseNote
        attr_reader :text

        TAGS = ['Story', 'Bug', 'Task', 'Deploy', 'Release']

        class InvalidTagsError < StandardError
        end

        #@param issue_list [Array] list of issues for generating the release note
        def initialize(project, version, issue_list)
          @project = project
          @version = version
          @issues  = parse_issues(issue_list)

          template = File.join(File.dirname(__FILE__), 'release_note', 'template.md.erb')

          content = ERB.new(File.read(template), nil, '-').result(binding)

          FileUtils.mkdir_p(File.join(Dir.pwd, 'public'))
          File.write(File.join(Dir.pwd, 'public', "release_note_#{@version}.md"), content)

          @text = content
        end

        private
        def parse_issues(issue_list)
          parsed = issue_list.to_a.map do |issue|
            {
              id:    issue.to_h['iid'],
              title: issue.to_h['title'],
              tag:   (TAGS & issue.to_h['labels']).first
            }
          end

          invalid_tags = parsed.select { |issue| issue[:tag].nil? }
          raise(InvalidTagsError, "Issues exist without valid tags: #{invalid_tags.map { |issue| issue[:id] }.sort.join(', ')}") if invalid_tags.any?

          parsed
        end
      end
    end
  end
end