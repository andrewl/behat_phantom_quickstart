#features/search.feature
Feature: Search
  In order to find out about BDD
  As a wikipedia users
  I need to be able to search for BDD

  Scenario: Wikipedia search
    Given I am on "/wiki/Main_Page"
    When I fill in "search" with "BDD"
    And I press "searchButton"
    Then I should see "agile software development"
