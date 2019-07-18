Given(/^environment variables:$/) do |table|
  table.hashes.each do |line|
    override_env(line['variable'], line['value'])
  end
end

Given(/^I initialize the client$/) do
  @gitlab_client = QAT::Devel::GitLab::Client.new
end

And(/^I get all issues from milestone "([^"]*)"$/) do |milestone_title|
  @milestone_id = @gitlab_client.get_milestone_id(milestone_title)
end

When(/^all milestone issues are closed$/) do
  @gitlab_client.all_milestone_issues_closed?(@milestone_id)
end

Then(/^create a release note from all issues of milestone "([^"]*)"$/) do |milestone|
  @issue_release = @gitlab_client.create_issue_release(milestone)
end

Then(/^Issue with a name "([^"]*)" is created$/) do |issue_title|
  raise("Issue not created") unless issue_title == @issue_release.title
  @gitlab_client.delete_issue(@issue_release.iid)
end

And(/^a tag "([^"]*)" should exist$/) do |version|
  @tag_name    = version
  @created_tag = QAT::Devel::GitLab::Client.new(nil, 255).client.tag(255, @tag_name)

  puts "\nTAG Created:\n#{@created_tag.to_h}\n"

  assert_equal(@tag_name, @created_tag.to_h['name'])
end

And(/^the tag is correct$/) do
  tag = @created_tag.to_h

  assert_equal("Release #{@tag_name}", tag['message'])
  refute_empty(tag.dig('release', 'description').to_s)
end