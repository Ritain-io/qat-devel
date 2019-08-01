require 'gitlab'
require_relative '../../version'

module QAT
  module Devel
    # GitLab global namespace
    module GitLab
      # Defines methods related to milestones.
      class Client

        attr_reader :client, :issues


        # New QAT::Devel::GitLab::Client
        def initialize(token=nil, project_id=nil)
          @token = token || ENV['GITLAB_TOKEN']
          raise ArgumentError.new "No definition of mandatory environment variable 'GITLAB_TOKEN'" unless @token

          @project_id = project_id || ENV['CI_PROJECT_ID']
          raise ArgumentError.new "No definition of mandatory environment variable 'CI_PROJECT_ID'" unless @project_id

          #Change
          @client     = Gitlab.client endpoint:      'https://gitlab.readinessit.com/api/v4',
                                      private_token: @token
          @issues     = {}
          @milestones = {}
        end

        # Gets the id of a given milestone title.
        #
        # @example
        #   client.get_milestone_id('2.0.0')
        #
        # @param  [String] title The title of a milestone.
        # @return [Integer] id
        def get_milestone_id(title)
          # log.debug "Getting milestone id for: #{title}"

          @milestones = client.milestones(@project_id)

          milestone = @milestones.select { |milestone| milestone.title == title }.first

          raise(MilestoneNotFoundError, "Milestone with title #{title} not found in GitLab!") unless milestone

          milestone.id
        end

        # Gets the issues of a given milestone id.
        #
        # @example
        #   client.get_all_milestone_issues(531)
        #
        # @param  [Integer] milestone_id The ID of a milestone.
        # @return [Array]
        def get_all_milestone_issues(milestone_id)
          return @issues[milestone_id] if @issues[milestone_id]
          raise(IssueNotFoundError, "Found 0 issues of Milestone with title #{title}!") unless @issues
          @issues[milestone_id] = client.milestone_issues(@project_id, milestone_id)

        end

        # Checks closed state on issues of a given milestone id.
        #
        # @example
        #   client.all_milestone_issues_closed?(531)
        #
        # @param  [Integer] milestone_id The ID of a milestone.
        # @return [Boolean]
        def all_milestone_issues_closed?(milestone_id)
          issues = get_all_milestone_issues(milestone_id)

          issues.all? do |issue|
            issue.state == 'closed'
          end
        end


        # Create a new issue
        #
        # @example
        #   client.create_issue(123, "New Issue", {description: "Test"})
        #
        # @param  [Integer] project The ID of a project.
        # @param  [String] title The title of new issue.
        # @param  [Hash] options The hash of options.
        # @return [Array] Values of new issue
        def create_issue(project, title, options={})
          client.create_issue(project, title, options)
        end


        # Create a new Issue Release
        #
        # @example
        #   client.create_issue(123, "New Issue", {description: "Test"})
        #
        # @param  [String] milestone The name of milestone
        # @return [Array] Values of new issue release
        def create_issue_release(milestone)
          milestone_id = get_milestone_id(milestone)
          raise(IssueReleaseError, "Found issues with Milestone #{milestone} open!") unless all_milestone_issues_closed?(milestone_id)

          issues      = get_all_milestone_issues(milestone_id)
          description = nil
          issues.all? do |issue|
            i           = 0
            labels_text = nil
            issue.labels.all? do |label|
              if i == 0
                labels_text = "~#{label}"
                i           = i + 1
              else
                labels_text = "#{labels_text} ~#{label}"
              end
            end
            description =
              "" "#{description}
- #{labels_text} ##{issue.iid} #{issue.title}" ""
          end
          gemspec      = Dir.glob('../*.gemspec').first
          gemspec_spec = Gem::Specification::load(gemspec)
          gemspec_spec.name.to_s

          description =
            "" "## #{gemspec_spec.name.to_s} 2.0.0

**Milestone** \"%#{milestone}\"

### Issues solved in this release
#{description}
            " ""

          create_issue(@project_id, "Release #{milestone}", options = { description: description })
        end

        # Remove a issue
        #@param issue_id [Integer] The ID of a issue.
        def delete_issue(issue_id)
          client.delete_issue(@project_id, issue_id)
        end

        # Create a release tag
        #@param tag_name [String] tag name
        #@param release_note [String] release note content
        def create_release_tag(tag_name, release_note)
          # GitLab gem post to create a tag is not correct.
          # Field containing release note content should be 'release_description' and not 'description'

          response = client.post("/projects/#{client.url_encode(@project_id)}/repository/tags",
                                 body: { tag_name:            tag_name,
                                         ref:                 'master',
                                         message:             "Release #{tag_name}",
                                         release_description: release_note })
          puts "\nTAG Creation Response:\n#{response.to_h}\n"
        end

        # Gets a list of project repository tags.
        #
        # @param  [Hash] options A customizable set of options. Optional, default is nil.
        # @option options [Integer] :page The page number.
        # @option options [Integer] :per_page The number of results per page.
        # @return [Array<Gitlab::ObjectifiedHash>]
        def get_tags(options={})
          client.tags(@project_id, options)
        end

        # Error class for rescuing milestones not found errors
        class MilestoneNotFoundError < StandardError
        end
        class IssueNotFoundError < StandardError
        end
        class IssueReleaseError < StandardError
        end
      end
    end
  end
end