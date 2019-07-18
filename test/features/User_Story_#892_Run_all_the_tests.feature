@user_story#892 @announce
Feature: User Story #892 Run all the tests
  In order to easily run the tests of a project
  as a qat-devel user,
  I want to have a rake task to run all existing tests


  Scenario: Run all the tests in a project with tests
    Given I copy the directory named "../../resources/calculator_with_tests" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value |
      | CUCUMBER_FORMAT |       |
      | CUCUMBER_OPTS   |       |
    When I run `rake qat:devel:tests:run`
    Then the exit status should be 0
    And the stdout should contain:
    """
    9 scenarios (9 passed)
    """


  Scenario: Run all the tests in a project without tests
    Given I copy the directory named "../../resources/calculator_undoc" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value |
      | CUCUMBER_FORMAT |       |
      | CUCUMBER_OPTS   |       |
    When I run `rake qat:devel:tests:run`
    Then the exit status should be 0
    And the stdout should contain:
    """
    0 scenarios
    """


  @bug#1336
  Scenario: Run all the tests in a project without tests
    Given I copy the directory named "../../resources/calculator_undoc" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value |
      | CUCUMBER_FORMAT |       |
      | CUCUMBER_OPTS   |       |
    And the following files should exist:
      | public/this_is_garbage.txt |
    When I run `rake qat:devel:tests:run`
    Then the following files should not exist:
      | public/this_is_garbage.txt |
    And the exit status should be 0
    And the stdout should contain:
    """
    0 scenarios
    """