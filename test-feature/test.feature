#features/search.feature
Feature: Search
  In order to find out about Behat
  As a googler
  I need to be able to search for Behat

  Scenario: Google search
    Given I am on "http://www.google.com"
    When I fill in "q" with "Behat"
    And I press "Google Search"
    Then I should see "BDD for PHP"
