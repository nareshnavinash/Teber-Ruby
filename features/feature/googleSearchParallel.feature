@TC_Google_Search
Feature: Search for a term in google search
  Entering a term in google search and verifying result page is displayed

  @scenario_001 @regression @sanity
  Scenario: Single term serach
    Given I navigate to google search page
    When I type the term in google search bar and click on serach results
    Then I should get the results page