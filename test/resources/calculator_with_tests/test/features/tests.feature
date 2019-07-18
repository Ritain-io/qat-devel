Feature: Test Calculator
  In order to avoid silly mistakes
  As a math idiot
  I want to be told the result of operations with two numbers

  Scenario: Add two numbers

    Given I have entered 50 into the calculator
    And I have entered 70 into the calculator
    When I press add
    Then the result should be 120 on the screen

  Scenario: Divide two numbers

    Given I have entered 6 into the calculator
    And I have entered 3 into the calculator
    When I press div
    Then the result should be 2 on the screen

  Scenario: Multiply two numbers

    Given I have entered 20 into the calculator
    And I have entered 20 into the calculator
    When I press mult
    Then the result should be 400 on the screen


  Scenario: Subtract two numbers

    Given I have entered 70 into the calculator
    And I have entered 50 into the calculator
    When I press sub
    Then the result should be 20 on the screen


  Scenario: Add two float numbers

    Given I have entered 50,5 into the calculator
    And I have entered 70,5 into the calculator
    When I press floatadd
    Then the result should be 121 on the screen


   Scenario: Multiple Operation

     Given I have entered 50 into the calculator
     And I have entered 70 into the calculator
     When I press add
     Then the result should be 120 on the screen
     And I have entered 80 into the calculator
     When I press add
     Then the result should be 200 on the screen


  Scenario: Multiple Operation 2

    Given I have entered 50 into the calculator
    And I have entered 70 into the calculator
    When I press add
    Then the result should be 120 on the screen
    And I have entered 80 into the calculator
    When I press sub
    Then the result should be 40 on the screen

  Scenario: Multiple Operation 3

    Given I have entered 2,2 into the calculator
    And I have entered 2,2 into the calculator
    When I press mult
    Then the result should be 4,84 on the screen

  Scenario: Multiple Operation 2

    Given I have entered 50 into the calculator
    And I have entered 70 into the calculator
    When I press add
    Then the result should be 120 on the screen
    And I have entered 80 into the calculator
    When I press sub
    Then the result should be 40 on the screen
    And I have entered 2 into the calculator
    When I press mult
    Then the result should be 80 on the screen
    And I have entered 10 into the calculator
    When I press div
    Then the result should be 8 on the screen