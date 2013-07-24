#features/search.feature
Feature: Search
  In order to see a word definition
  As a website user
  I need to be able to search for a word

  Scenario: Searching for a page that does exist
    Given I am on "http://www.google.com"
    When I fill in "search" with "Behat"
    And I press "I'm Feeling Lucky"
    Then I should see "BDD for PHP"
