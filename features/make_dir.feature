Feature: make_directory

Scenario: not logged in user calls make dir
    Given user not loged in
    When unauthorised user tries to make directory
    Then user should get log in error
    
  
Scenario: logged in user calls make directory
    Given user is logged in
    When user tries make directory
    Then user directory should change
