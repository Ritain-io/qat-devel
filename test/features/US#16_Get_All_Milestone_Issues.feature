@us#16 @announce
Feature: US#16 Run Get All Milestone Issues
  As a QAT release manager, In order to save time,
  I want to have a Continuous Delivery pipeline

  Background:
    Given environment variables:
      | variable        | value                          |
      | CI_PROJECT_ID   | 255                            |
      | GITLAB_TOKEN    | gitlab_token                   |
      | GITLAB_ENDPOINT | https://gitlab.host.com/api/v4 |

  Scenario: Validate all milestone issues are closed
    Given I initialize the client
    And I get all issues from milestone "2.0.0"
    When all milestone issues are closed
