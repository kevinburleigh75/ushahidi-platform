@oauth2
Feature: Testing OAuth2 endpoints

    Scenario: Requesting an Authorization code
        Given I am on "/oauth/authorize?response_type=code&client_id=demoapp&state=testing&scope=basic&redirect_uri=http://ushv3.dev/oauth/debug"
        And I press "authorizeButton"
        Then the response status code should be 200
        Then the full url should match "\?code=.*&state=testing"

    Scenario: Cancelled request for an Authorization code
        Given I am on "/oauth/authorize?response_type=code&client_id=demoapp&state=testing&scope=basic&redirect_uri=http://ushv3.dev/oauth/debug"
        And I follow "cancelButton"
        Then the response status code should be 200
        Then the full url should match "\?error=access_denied&state=testing"

    Scenario: Requesting access token with authorization code
        Given that I want to make a new "access_token"
        And that the request "data" is:
        """
          code=4d105df9a7f8645ef8306dd40c7b1952794bf368&grant_type=authorization_code&client_id=demoapp&client_secret=demopass
        """
        And that the api_url is ""
        Then I request "/oauth/token"
        Then the response is JSON
        And the response has a "access_token" property
        Then the guzzle status code should be 200

    Scenario: Requesting access token with password
        Given that I want to make a new "access_token"
        And that the request "data" is:
        """
          grant_type=password&client_id=demoapp&client_secret=demopass&username=robbie&password=testing
        """
        And that the api_url is ""
        Then I request "/oauth/token"
        Then the response is JSON
        And the response has a "access_token" property
        Then the guzzle status code should be 200

    Scenario: Requesting access token with client credentials
        Given that I want to make a new "access_token"
        And that the request "data" is:
        """
          grant_type=client_credentials&client_id=demoapp&client_secret=demopass
        """
        And that the api_url is ""
        Then I request "/oauth/token"
        Then the response is JSON
        And the response has a "access_token" property
        Then the guzzle status code should be 200

    Scenario: Requesting an access token with implicit flow
        Given I am on "/oauth/authorize?response_type=token&client_id=demoapp&state=testing&scope=basic&redirect_uri=http://ushv3.dev/oauth/debug"
        And I press "authorizeButton"
        Then the response status code should be 200
        Then the full url should match "\#access_token=.*&expires_in=[0-9]*&token_type=bearer&scope=basic&state=testing"

    Scenario: Authorized Posts Request
        Given that I want to get all "Posts"
        And that the request "Authorization" header is "Bearer testingtoken"
        When I request "/posts"
        Then the response is JSON
        And the response has a "count" property
        And the type of the "count" property is "numeric"
        Then the response status code should be 200
