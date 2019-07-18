@us#16 @announce
Feature: Validates issues status through rake task execution
  Check version,
  fetch milestone,
  and check all issues closed


  Scenario: Run rake task to validate all issues closed with success
    Given I copy the directory named "../../resources/gem_project_2.0.0" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value        |
      | CUCUMBER_FORMAT |              |
      | CUCUMBER_OPTS   |              |
      | CI_PROJECT_ID   | 255          |
      | GITLAB_TOKEN    | gitlab_token |

    When I run `rake qat:devel:gitlab:milestone_issues_closed`
    Then the exit status should be 0
    And the stdout should contain:
    """
    All issues in milestone 2.0.0 are closed.
    """

  Scenario: Run rake task to validate all issues closed fails
    Given I copy the directory named "../../resources/gem_project_2.0.1" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value        |
      | CUCUMBER_FORMAT |              |
      | CUCUMBER_OPTS   |              |
      | CI_PROJECT_ID   | 255          |
      | GITLAB_TOKEN    | gitlab_token |

    When I run `rake qat:devel:gitlab:milestone_issues_closed`
    Then the exit status should be 1
    And the stderr should contain:
    """
    There are open issues in milestone 2.0.1!
    """