@us#17 @announce
Feature: Validates issues status through rake task execution
  Check version,
  fetch milestone,
  and check all issues closed


  Scenario: Run rake task to create release note with success
    Given I copy the directory named "../../resources/gem_project_2.0.0" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value        |
      | CUCUMBER_FORMAT |              |
      | CUCUMBER_OPTS   |              |
      | CI_PROJECT_ID   | 255          |
      | GITLAB_TOKEN    | gitlab_token |

    When I run `rake qat:devel:gitlab:milestone_release_note`
    Then the exit status should be 0
    And a file named "public/release_note_2.0.0.md" should contain:
  """
## DUMMY Gem 2.0.0

**Milestone** %"2.0.0"

### Issues solved in this release
- ~Story #22 Release 2.0.0
- ~Story #21 Release 2.0.0
- ~Story #20 Release 2.0.0
- ~Story #19 Release 2.0.0
- ~Task #13 Issue aberta milestone 2.0.0
- ~Story #7 Issue 04
- ~Story #2 Issue 02
- ~Bug #1 Issue 01

  """
    And the stdout should contain:
    """
## DUMMY Gem 2.0.0

**Milestone** %"2.0.0"

### Issues solved in this release
- ~Story #22 Release 2.0.0
- ~Story #21 Release 2.0.0
- ~Story #20 Release 2.0.0
- ~Story #19 Release 2.0.0
- ~Task #13 Issue aberta milestone 2.0.0
- ~Story #7 Issue 04
- ~Story #2 Issue 02
- ~Bug #1 Issue 01

    """