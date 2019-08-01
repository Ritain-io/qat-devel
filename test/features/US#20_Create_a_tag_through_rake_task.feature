@us#20 @announce @env
Feature: Create a tag through rake task execution

  Background:
    Given environment variables:
      | variable        | value        |
      | CUCUMBER_FORMAT |              |
      | CUCUMBER_OPTS   |              |
      | CI_PROJECT_ID   | 255          |
      | GITLAB_TOKEN    | gitlab_token |

  @tag_creation
  Scenario: Run rake task to create a tag with success
    Given I copy the directory named "../../resources/gem_project_2.0.0" to "project"
    And I cd to "project"
    When I run `rake qat:devel:gitlab:milestone_tag`
    Then the exit status should be 0
    And a tag "2.0.0" should exist
    And the tag is correct