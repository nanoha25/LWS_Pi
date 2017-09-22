# Created by hakur at 22/09/2017
Feature: Store body fat data
  As a user
  I want my body fat data can be stored outside weight scale
  So that I do not need scale to look up data

  Scenario: Store body fat data
    Given I have a device capable of storing data
    When The scale transmit data to that device
    Then The device will store data