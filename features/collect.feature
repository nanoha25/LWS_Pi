# Created by hakur at 22/09/2017
Feature: Collect body fat data
  As a user
  I want to get my body fat data
  So that I can use it to track my health condition

  Scenario: User uses the weight scale with bare foot
    Given I have a weight scale with body fat measure feature
    When I step onto that scale with both bare feet touching the metal plates
    Then The scale will measure my body fat

  Scenario: User uses the weight scale with shoes
    Given I have a weight scale with body fat measure feature
    When I step onto that scale wearing shoes
    Then The scale will not measure my body fat
