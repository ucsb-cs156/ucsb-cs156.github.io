---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Integration and End-to-End Testing"
description:  "Integration and End-to-end testing in our stack"
category_prefix: "Testing: "
indent: true
---

# In the Context of our Stack

In our applications, we run end to end tests using these tools:

* Playwright (the Java version), to simulate how a user interacts with the application in a browser
* Wiremock, to simulate OAuth2 authentication with external OAuth providers (e.g. Google, Github) so that we don't have to hardcode real usernames and passwords
* H2 to set up a database for these end-to-end tests.

This article describes various aspects about these tools that you may need to know when working with our stack.

## Playwright

[Playwright](https://playwright.dev/java/docs/intro) is an automation library for browser testing that allows us to simulate actions that a user might perform when interacting with our web application. You may have heard of similar libraries like Cypress and Selenium. 

Playwright, like other similar librarires, allows us to perform tests on our application in an instance of a real browser. We use it to click buttons, fill out fields, and make assertions about the contents of the page we are viewing.

Using our simplest team03 Playwright test, [`HomePageWebIT.java`](https://github.com/ucsb-cs156-s24/STARTER-team03/blob/main/src/test/java/edu/ucsb/cs156/example/web/HomePageWebIT.java) as an example, we'll break down some important code blocks that allow Playwright to work.

The class annotation `@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)` tells the test to load the application onto our `DEFINED_PORT` of 8080 so that we can interact with the web application from that port on localhost.

```
@Value("${app.playwright.headless:true}")
private boolean runHeadless;

@LocalServerPort
private int port;

private Browser browser;
private Page page;

@BeforeEach
public void setup() {
    browser = Playwright.create().chromium().launch(new BrowserType.LaunchOptions().setHeadless(runHeadless));

    BrowserContext context = browser.newContext();
    page = context.newPage();
}

@AfterEach
public void teardown() {
    browser.close();
}
```

This is the core of what allows us to use Playwright in our end-to-end tests...

## Wiremock

The projects in this course all use third party authentication providers, in most cases Google, and in the case of [Organic](https://github.com/ucsb-cs156/proj-organic), Github. Using authentication providers gives a secure way of implementing a user system without having to involve ourselves with the implementation of our own authenitication service, with all of the security and logistical considerations that come with it. What that also means, is that when we want to do things like end-to-end testing, if we wanted to use Google's oauth, it would require us to use legitimate user information which would be unwise. To make up for this, without having to implement an oauth provider for ourselves, we use [Wiremock](https://wiremock.org/).

Wiremock is a tool that allows for the mocking of API calls. We use it to mock the API calls our application makes that interact with Google's service, so instead of getting the Google account sign in screen, we get our own fake sign in screen and the app uses the fake user info that we have specified.

Regular Google login:

![regularlogin](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/56096744/8bd2c64c-0f45-4938-bdbf-a54a738ce955)

Using Wiremock:

![wiremocklogin](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/56096744/f95c958d-b443-4719-8973-981a3df17bfb)

Wiremock runs on its own port, in our applications it is on 8090, and when requests are made to our mocked APIs, the API call is redirected to Wiremock server on port 8090 which fulfills the request to our specificiation.

In our applications Wiremock is used in two profiles, a dedicated `WIREMOCK` profile, and the `INTEGRATION` profile...

## H2

H2 is a SQL database that can be embedded into Java applications, which we use in many of this course's applications for localhost development.

One of the very important considerations when using a database in integration tests is to ensure that the contents of the database from one test don't interfere with the contents of the database in another test.  We want to maintain control over the database so that we can make deterministic assertions about its contents before and after a test. This can mean either wiping the database clean after each test run or giving each test its own "private copy" of the database to work with.

That would allow us to do things like start with a table of Users that has 5 rows, delete 2 users, and then assert that the number of rows in the table is 3.

Clearly, if there were more than one test running against the same database, adding and deleting users, with the tests running in parallel, this has the potential to get dodgy.

The way we accomplish this in the code is with the following lines in the code base:

1. The line: `spring.datasource.url=jdbc:h2:mem:${random.uuid}` in `src/main/resources/application-integration.properties`. When running in the `INTEGRATION` profile, this line instructs the application, when assigning a database, to choose a random uuid.
2. The annotation `@DirtiesContext(classMode = ClassMode.BEFORE_EACH_TEST_METHOD)` in the tests themselves. This tells the application to "mark" the "context" (database) as dirty before each test. 

The combination of these two lines allows us to get a clean database for each test. When the database is marked as "dirty" before each test, the application sets up a new database with a new uuid. Now this is not perfect as there is still a chance that the same uuid is selected when spinning up a new databse.

## Running the Integration and End-to-end Tests

You may be used to running `mvn test` in order to run the test suite for the application, but integration and end-to-end tests run with a seperate command.

In order to run the integration and end-to-end test suite you should use the following series of commands.

```
mvn clean
```

To make sure that we do not have anything lingering from previous test runs. Running `mvn clean` is important because the tests are highly sensitive and can fail if this is not done before the next steps.

```
INTEGRATION=true mvn test-compile
```

This step is this test compile command that has this `INTEGRATION=true` command at the front. What this does is specifies that the program should run in the profile for integration tests. This command may take a while becuase it compiles the frontend with the backend.

```
INTEGRATION=true mvn failsafe:integration-test
```

This command actually runs the test suite. If you have previously gone through these three commands and have **ONLY** modified the test cases then you may just use the last command,`INTEGRATION=true mvn failsafe:integration-test`. Otherwise you may need to recompile. 

## Debugging the End-to-end Tests

End-to-end test can typically be run in two modes.

1.  "headless", where there is no real browser being rendered on a screen; it's all just simulated in memory.  This is the usual way of running end-to-end tests because its a lot faster.

2. "not headless" where the tester can actually watch all of the interactions happen on screen (albeit very quickly) as the tests are being run. This is typically only used when developing or debugging the end-to-end tests.

Our tests run "headless" by default and you can configure the tests to run "not headless" with the following:

```
INTEGRATION=true HEADLESS=false mvn failsafe:integration-test
```

Here is a gif of what it looks like to run "not headless" for the team03 tests.

![notheadlessexample](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/56096744/8242de41-1b1d-4335-8730-422e197655e6)
