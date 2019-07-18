@us#24 @announce
Feature: US#16 Check that the version in development is greater the last existing tag.
  As a pipeline manager,
  I want to check that the version in development is greater the last existing tag,
  In order to ensure we always publish a correct version

  Changed by User Story #37:

  As a ruby developer,
  In order to check version consistency in Ruby apps,
  I want to be able validate the current version against released version on non-gem projects

  Scenario: Check if version on development is greater that the existing tag
    Given I copy the directory named "../../resources/gem_project_2.0.1" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value        |
      | CUCUMBER_FORMAT |              |
      | CUCUMBER_OPTS   |              |
      | CI_PROJECT_ID   | 255          |
      | GITLAB_TOKEN    | gitlab_token |

    When I run `rake qat:devel:gitlab:check_version_tags`
    Then the exit status should be 0
    And the stdout should contain:
    """
    This version (2.0.1) is greater than that the last released version (tag)!
    """


  Scenario: Check if version on development is greater that the existing tag fails
    Given I copy the directory named "../../resources/gem_project_1.5.0" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value        |
      | CUCUMBER_FORMAT |              |
      | CUCUMBER_OPTS   |              |
      | CI_PROJECT_ID   | 255          |
      | GITLAB_TOKEN    | gitlab_token |

    When I run `rake qat:devel:gitlab:check_version_tags`
    Then the exit status should be 1
    And the stderr should contain:
    """
    This version 1.5.0 is lesser or equal to the last released version (tag) 1.5.0!
    """


  @user_story#37
  Scenario: Check if a specific version is greater than that the existing tag
    Given I copy the directory named "../../resources/gem_project_1.5.0" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value        |
      | CUCUMBER_FORMAT |              |
      | CUCUMBER_OPTS   |              |
      | CI_PROJECT_ID   | 255          |
      | GITLAB_TOKEN    | gitlab_token |

    When I run `rake qat:devel:gitlab:check_version_tags[1.6.0]`
    Then the exit status should be 0
    And the stdout should contain:
    """
    This version (1.6.0) is greater than that the last released version (tag)!
    """


  @bug#39
  Scenario: Verify tags in a project without repository
    Given I copy the directory named "../../resources/gem_project_1.5.0" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value        |
      | CUCUMBER_FORMAT |              |
      | CUCUMBER_OPTS   |              |
      | CI_PROJECT_ID   | 331          |
      | GITLAB_TOKEN    | gitlab_token |

    When I run `rake qat:devel:gitlab:check_version_tags`
    Then the exit status should be 1
    And the stderr should contain:
    """
    Project has no repository or access was denied!
    """


  @bug#39
  Scenario: Verify tags in a project with a repository without tags
    Given I copy the directory named "../../resources/gem_project_1.5.0" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value        |
      | CUCUMBER_FORMAT |              |
      | CUCUMBER_OPTS   |              |
      | CI_PROJECT_ID   | 549          |
      | GITLAB_TOKEN    | gitlab_token |

    When I run `rake qat:devel:gitlab:check_version_tags`
    Then the exit status should be 0
    And the stdout should contain:
    """
    This repository still has no tags!
    """