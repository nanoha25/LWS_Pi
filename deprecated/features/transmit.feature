# Created by hakur at 22/09/2017
Feature: Transmit body fat data to another device
  As a user
  I want to send my body fat data to another device
  So that I can use the data for further processing

  Scenario: Weight scale sends the data
    Given I have a weight scale with body fat measure feature
    When I stand onto the scale a bit longer
    Then The weight scale will send data to another device

  Scenario: A device receives the data
    Given I have a device with bluetooth capability
    When I turn on bluetooth on that device
    Then The device will receive body fat data