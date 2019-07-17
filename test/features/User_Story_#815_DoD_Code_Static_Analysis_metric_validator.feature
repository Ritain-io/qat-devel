@user_story#815 @announce
Feature: User Story #815: DoD Code Static Analysis metric validator
  In order to validate developed code quality
  as a qat-devel user,
  I want to have a rake task to validate the rating given by static analysis

  Scenario: Validate RubyCritic report for items with rating of "A"
    Given I copy the directory named "../../resources/calculator_test1" to "project"
    And I cd to "project"
    When I run `rake qat:devel:static_analysis:validation['A']`
    Then the exit status should be 0
    And the stdout should contain:
    """
    Ratings OK!
    """

  Scenario: Validate RubyCritic report for items with rating of "B" and "A" with parametrized value
    Given I copy the directory named "../../resources/calculator_test2" to "project"
    And I cd to "project"
    When I run `rake qat:devel:static_analysis:validation['B']`
    Then the exit status should be 0
    And the stdout should contain:
    """
    Ratings OK!
    """

  Scenario: Validate RubyCritic report for items with rating of "B" and "A" with default value
    Given I copy the directory named "../../resources/calculator_test2" to "project"
    And I cd to "project"
    When I run `rake qat:devel:static_analysis:validation`
    Then the exit status should be 0
    And the stdout should contain:
    """
    Ratings OK!
    """

  Scenario: Validate RubyCritic report for item rating of "C" with default value
    Given I copy the directory named "../../resources/calculator_test3" to "project"
    And I cd to "project"
    When I run `rake qat:devel:static_analysis:validation`
    Then the exit status should be 1
    And the stderr should contain:
    """
    There are ratings under 'B'.

     Modules:
    Calculator\t\tC
    """

  Scenario: Validate RubyCritic report for item rating of "C"
    Given I copy the directory named "../../resources/calculator_test3" to "project"
    And I cd to "project"
    When I run `rake qat:devel:static_analysis:validation['C']`
    Then the exit status should be 0
    And the stdout should contain:
    """
    Ratings OK!
    """
