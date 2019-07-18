@user_story#667 @announce
Feature: User Story #667: DoD Code documentation metric validator
  In order to validate all code is documented
  as a qat-devel user,
  I want to have a rake task to validate code documentation percentage


  Scenario: Validate documentation for undocumented project
    Given I copy the directory named "../../resources/calculator_undoc" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value |
      | CUCUMBER_FORMAT |       |
      | CUCUMBER_OPTS   |       |
    When I run `rake qat:devel:validate_yard_doc[calculator]`
    Then the exit status should be 1
    And the stderr should contain:
    """
    Files:           1
    Modules:         0 (    0 undocumented)
    Classes:         1 (    1 undocumented)
    Constants:       0 (    0 undocumented)
    Attributes:      0 (    0 undocumented)
    Methods:         6 (    6 undocumented)
     0.00% documented

    Undocumented Objects:

    (in file: lib/calculator.rb)
    Calculator
    Calculator#add
    Calculator#div
    Calculator#mult
    Calculator#push
    Calculator#sub
    Calculator#val
    """


  Scenario: Validate documentation for partially documented project
    Given I copy the directory named "../../resources/calculator_doc50" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value |
      | CUCUMBER_FORMAT |       |
      | CUCUMBER_OPTS   |       |
    When I run `rake qat:devel:validate_yard_doc[calculator]`
    Then the exit status should be 1
    And the stderr should contain:
    """
    Files:           1
    Modules:         0 (    0 undocumented)
    Classes:         1 (    1 undocumented)
    Constants:       0 (    0 undocumented)
    Attributes:      0 (    0 undocumented)
    Methods:         6 (    2 undocumented)
     57.14% documented

    Undocumented Objects:

    (in file: lib/calculator.rb)
    Calculator
    Calculator#push
    Calculator#val
    """


  Scenario: Validate documentation for fully documented project
    Given I copy the directory named "../../resources/calculator_doc100" to "project"
    And I cd to "project"
    And I set the environment variables to:
      | variable        | value |
      | CUCUMBER_FORMAT |       |
      | CUCUMBER_OPTS   |       |
    When I run `rake qat:devel:validate_yard_doc[calculator]`
    Then the exit status should be 0
    And the stdout should contain:
    """
    Files:           1
    Modules:         0 (    0 undocumented)
    Classes:         1 (    0 undocumented)
    Constants:       0 (    0 undocumented)
    Attributes:      0 (    0 undocumented)
    Methods:         6 (    0 undocumented)
     100.00% documented
    """
