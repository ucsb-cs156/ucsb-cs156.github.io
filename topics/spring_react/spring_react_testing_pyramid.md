---
parent: "Spring/React"
grand_parent: Topics
layout: default
title: "Spring/React: Testing Pyramid"
description:  "How to go beyond just unit testing, and do integration and end-to-end tests"
---

# {{page.title}} - {{page.description}}

Initially, the code bases for each of our Spring/React projects had only unit tests.

Starting in Spring 2024, we began to slowly add integration and end-to-end tests to each of these (led by the work of MS Student Andrew Peng). This is an effort to complete the [testing pyramid](https://ucsb-cs156.github.io/topics/testing/testing_pyramid.html).

This guide explains, step-by-step, how to introduce integration and end-to-end testing in to one of these code bases, including:

* Changes to the pom.xml
* Changes to the `/resources` directory
* Services that you need to add (support code)
* Adding the integration tests themselves
* Adding the end-to-end tests themselves
* Adding Github workflow(s) for the tests
* What you need to add to the documentation to explain the new tests
* Considerations neccessary for future work

For this tutorial we are using the `proj-happycows` codebase as an example.

I highly recommend reading the following article prior to getting started with this guide, as man of the new tools and techincal details are broken down in the article, as opposed to repeated in this guide.

[Integration and End-to-end Testing in our Stack](https://ucsb-cs156.github.io/topics/testing/testing_integration_e2e_tests.html)

## Step 1: Packages and Maven Profiles

We must first start by adding the neccessary dependencies and profiles to our `pom.xml`. You may want to use the latest versions instead.

Playwright and Wiremock dependencies:

```
<dependency>
  <groupId>com.microsoft.playwright</groupId>
  <artifactId>playwright</artifactId>
  <version>1.41.0</version>
  <scope>test</scope>
</dependency>

<dependency>
  <groupId>com.github.tomakehurst</groupId>
  <artifactId>wiremock-jre8-standalone</artifactId>
  <version>2.35.1</version>
</dependency>
```

The next thing to add is an additional plugin, `maven-surefire-plugin` which enables us to use the command `mvn failsafe:integration-test` which runs all of our integration and end-to-end tests. Some projects may already have this plugin added, please use the following if possible.

```
<!-- This fixes a problem as explained in this SO article:
https://stackoverflow.com/a/61936537/13960329
-->
<plugin>
  <artifactId>maven-surefire-plugin</artifactId>
  <version>3.0.0-M5</version>
  <configuration>
    <!-- Activate the use of TCP to transmit events to the plugin -->
    <forkNode implementation="org.apache.maven.plugin.surefire.extensions.SurefireForkNodeFactory"/>
  </configuration>
</plugin>
```

Lastly we add the following two profiles, wiremock and integration. The wiremock profile is for localhost debugging of any mocked API's and the integration profile is for running our new tests.

```
<!-- to run with this profile use "WIREMOCK=true mvn spring-boot:run" -->
<profile>
  <id>wiremock</id>
  <activation>
    <property>
      <name>env.WIREMOCK</name>
    </property>
  </activation>
  <properties>
    <springProfiles>wiremock,development</springProfiles>
  </properties>
  <dependencies>
    <dependency>
      <groupId>com.h2database</groupId>
      <artifactId>h2</artifactId>
      <scope>runtime</scope>
    </dependency>
  </dependencies>
</profile>

<!-- to run with this profile use "INTEGRATION=true mvn spring-boot:run" -->
<profile>
  <id>integration</id>
  <activation>
    <property>
      <name>env.INTEGRATION</name>
    </property>
  </activation>
  <properties>
    <springProfiles>integration</springProfiles>
  </properties>
  <dependencies>
    <dependency>
      <groupId>com.h2database</groupId>
      <artifactId>h2</artifactId>
      <scope>runtime</scope>
    </dependency>
  </dependencies>
  <build>
    <plugins>
      <plugin>
        <groupId>com.github.eirslett</groupId>
        <artifactId>frontend-maven-plugin</artifactId>
        <version>1.12.1</version>
        <configuration>
            <workingDirectory>frontend</workingDirectory>
            <installDirectory>${project.build.directory}</installDirectory>
        </configuration>
        <executions>
          <execution>
            <id>install node and npm</id>
            <goals>
              <goal>install-node-and-npm</goal>
            </goals>
            <configuration>
              <nodeVersion>v16.20.0</nodeVersion>
            </configuration>
          </execution>
          <execution>
            <id>npm install</id>
            <goals>
              <goal>npm</goal>
            </goals>
            <configuration>
              <arguments>ci</arguments>
            </configuration>
          </execution>
          <execution>
            <id>npm run build</id>
            <goals>
              <goal>npm</goal>
            </goals>
            <configuration>
              <arguments>run build</arguments>
            </configuration>
          </execution>
        </executions>
          </plugin>
          <plugin>
          <artifactId>maven-antrun-plugin</artifactId>
          <version>3.0.0</version>
          <executions>
            <execution>
              <phase>generate-resources</phase>
              <configuration>
                <target>
                  <copy todir="${project.build.outputDirectory}/public">
                    <fileset dir="${project.basedir}/frontend/build" />
                  </copy>
                </target>
              </configuration>
              <goals>
                <goal>run</goal>
              </goals>
            </execution>
          </executions>
        </plugin>
    </plugins>
  </build>
</profile>
```

## Step 2: Spring Profiles

Now that we have added additional Maven profiles, we must add some `.properties` to support the Spring profiles that they depend on.

These properties files are not application generic and require some attention to detail. Under `src/main/resources`, both of the two new files have the same intial contents and `application-development.properties` with the required changes for each new file below.

Create `application-wiremock.properties` with the same contents as `application-development.properties` however you must add the following.

```
spring.security.oauth2.client.registration.my-oauth-provider.client-id=integrationtest
spring.security.oauth2.client.registration.my-oauth-provider.client-secret=secret
spring.security.oauth2.client.registration.my-oauth-provider.client-name=Client to Mock Oauth2 Server
spring.security.oauth2.client.registration.my-oauth-provider.provider=my-oauth-provider
spring.security.oauth2.client.registration.my-oauth-provider.scope=https://www.googleapis.com/auth/userinfo.email,https://www.googleapis.com/auth/userinfo.profile
spring.security.oauth2.client.registration.my-oauth-provider.redirect-uri=http://localhost:8080/login/oauth2/code/my-oauth-provider
spring.security.oauth2.client.registration.my-oauth-provider.client-authentication-method=basic
spring.security.oauth2.client.registration.my-oauth-provider.authorization-grant-type=authorization_code

spring.security.oauth2.client.provider.my-oauth-provider.authorization-uri=http://localhost:8090/oauth/authorize
spring.security.oauth2.client.provider.my-oauth-provider.token-uri=http://localhost:8090/oauth/token
spring.security.oauth2.client.provider.my-oauth-provider.user-info-uri=http://localhost:8090/userinfo
spring.security.oauth2.client.provider.my-oauth-provider.user-info-authentication-method=header
spring.security.oauth2.client.provider.my-oauth-provider.user-name-attribute=sub

app.oauth.login=${OAUTH_LOGIN:${env.OAUTH_LOGIN:/oauth2/authorization/my-oauth-provider}}
app.admin.emails=admingaucho@ucsb.edu
```

Create `application-integration.properties` now with the same contents as the newly created `application-wiremock.properties`, and add the following line:

```
app.playwright.headless=${HEADLESS:${env.HEADLESS:true}}
```

You will also want to modify this:

```
spring.datasource.url=jdbc:h2:file:./target/db-development
```

To this:

```
spring.datasource.url=jdbc:h2:mem:${random.uuid}
```

Add the following line to `application.properties`.

```
app.oauth.login=${OAUTH_LOGIN:${env.OAUTH_LOGIN:/oauth2/authorization/google}}
```

## Step 3: Wiremock Service

Now we are going to introduce the `WiremockService`. This service is used in the `Wiremock` profile for localhost debugging of the mocked oauth flow, and in the `Integration` profile in each of our end-to-end tests.

The addition of this service requires multiple new files as well as changes to a number of files in both the frontend and backend.

First, under `src/test/resources/__files` (create the necessary folders if they do not exist) create a file `login.html` with:

```
<html>
<body>
Login page for wiremock oauth
<br />
<form method="POST" action="/login">
    <input type="hidden" name="state" value="{{request.query.state}}"/>
    <input type="hidden" name="redirectUri" value="{{request.query.redirect_uri}}"/>

    <p>Note: username and password are currently ignored when using wiremock</p>
    <input id=username type="text" name="username" />
    <input id=password type="password" name="password" />

    <input id=submit type="submit" value="Login" />
</form>
</body>
</html>
```

This HTML page serves as our 'login' page. At this point in time, the fields do not affect the result.

Next we'll add the three files that make up the `WiremockService`. 

* [`WiremockService.java`](https://github.com/ucsb-cs156-s24/STARTER-team03/blob/main/src/main/java/edu/ucsb/cs156/example/services/wiremock/WiremockService.java)
* [`WiremockServiceDummy.java`](https://github.com/ucsb-cs156-s24/STARTER-team03/blob/main/src/main/java/edu/ucsb/cs156/example/services/wiremock/WiremockServiceDummy.java)
* [`WiremockServiceImpl.java`](https://github.com/ucsb-cs156-s24/STARTER-team03/blob/main/src/main/java/edu/ucsb/cs156/example/services/wiremock/WiremockServiceImpl.java)

In order to utilize the service we have added, we need to add two application runners to `_Application.java`, in our case `HappierCowsApplication.java`.

```
@Autowired
WiremockService wiremockService;

@Profile("wiremock")
@Bean
public ApplicationRunner wiremockApplicationRunner() {
  return arg -> {
    log.info("wiremock mode");
    wiremockService.init();
    log.info("wiremockApplicationRunner completed");
  };
}

@Profile("development")
@Bean
public ApplicationRunner developmentApplicationRunner() {
  return arg -> {
    log.info("development mode");
    log.info("developmentApplicationRunner completed");
  };
}
```

The first uses our new service when in the Spring profile 'wiremock' and the second does not have any functionality but rather serves as an example.

Now that we have added this new service, we must update our test case parent class `ControllerTestCase.java` and any tests that do not use it as a parent, including a mock bean:

```
@MockBean
WiremockService mockWiremockService;
```

Next, one of the functions we desire from the 'wiremock' profile is the ability to click the login button on the navbar and be directed to our 'fake' login page. To do this we must add a field `private String oauthLogin;` to our `SystemInfo.java` so that we can use the value in our navbar. In `SystemInfoServiceImpl.java` we extract this value from the properties files we addeed earlier using the following annotation.

```
@Value("${app.oauth.login:/oauth2/authorization/google}")
private String oauthLogin;
```

We must also approprirately update the `getSystemInfo()` method as well as the `SystemInfoControllerTests.java`.

Now, to the frontend navbar `AppNavbar.js`, we'll add a variable that extracts this value from the `systemInfo` passed to the navbar component, and we'll change the href of our login button to use this variable instead of the hardcoded string we have.

```
var oauthLogin = systemInfo?.oauthLogin || "/oauth2/authorization/google";
```

For proj-happycows, we also have a login page that replaces the home page if the user is not yet logged in. We must also modify that. With these frontend changes we must also update the unit tests.

Now to test whether or not the `wiremock` profile works, we can deploy the application using:

```
WIREMOCK=true mvn spring-boot:run
```

and in the `/frontend` directory

```
npm start
```

If our login button redirects us correctly to our html page, and we are able to succesfully login with the fake user (admingaucho@ucsb.edu) then this step is complete.

## Step 4: Integration Tests

Finally, after all that setup, we can begin working on adding some integration tests.

Mockcurrentuserserviceimpl

## Step 5: End-to-end Tests

## Step 6: New Github Workflow

Now that we have added some integration and end-to-end tests, we must add an additional github workflow to our actions suite that runs them.

Create a file called `XX-backend-integration.yml` in the `.github/workflows` directory with the following contents, replacing `XX` with an appropriate, non-conflicting number. In our case, 11.

```
# This workflow will build a Java project with Maven
# For more information see: https://help.github.com/actions/language-and-framework-guides/building-and-testing-java-with-maven

name: "11-backend-integration: Java Integration tests"

on:
  workflow_dispatch:
  pull_request:
    paths: [src/**, pom.xml, lombok.config]
  push:
    branches: [ main ]
    paths: [src/**, pom.xml, lombok.config]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 10

    steps:
    - uses: actions/checkout@v3.5.2
    - name: Set up Java (version from .java-version file)
      uses: actions/setup-java@v3
      with:
         distribution: semeru # See: https://github.com/actions/setup-java#supported-distributions
         java-version-file: ./.java-version

    - name: Run tests with Maven
      run: INTEGRATION=true mvn -B test-compile failsafe:integration-test
```

## Step 7: Testing Documentation

## Considerations for Future Work

This guide to adding integration and end-to-end testing to a CS156 Spring/React application was based on the `proj-happycows` codebase. Additional codebases may offer additional challenges and require some considerations. For example, `proj-courses` will need:

* Wiremock endpoints for the UCSB API
* Equivalent in-memory implementation of MongoDB, smiilar to the in-memory H@ for the SQL database (see: [MongoDB in-memory storage engine](https://www.mongodb.com/docs/manual/core/inmemory/) )
