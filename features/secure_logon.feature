Feature: secure_logon   

Scenario: Unsuccessful secure login
	Given a user tries to connect with secure environment
    When the user log in with invalid information
    Then the user should see an log in error message

Scenario: Successful secure login
    Given a user tries to connect with secure environment
    When the user logs in
    Then the user should see an secure log in success message
    