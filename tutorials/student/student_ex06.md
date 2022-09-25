---
title: "Student: ex06"
parent: Student
grand_parent: Tutorials
description: "Setting up jacoco and Codecov.io"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex06
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# Overview

In this example we add Jacoco for computing *test case coverage*,
which is also known as *code coverage*.

The basic idea is that when we write tests, we want to make 
sure that we cover as much of our code as possible.

One way to do that is to use a tool to keep track of which lines of code are
executed when we run our test suite.  These tools are called "test case coverage"
or "code coverage" tools.

For Java, one such tool is called *JaCoCo*, which stands for **Ja**va **Co**de **Co**verage.

To add this tool to our workflow, we start by adding a plugin to our `pom.xml`.  This plugin goes into the `<plugins>` section,
as a "sibling" to the existing
`<plugin>` that we are using for the `maven-compiler-plugin`.

```xml
<!-- Test case coverage report -->
	<plugin>
		<groupId>org.jacoco</groupId>
		<artifactId>jacoco-maven-plugin</artifactId>
		<version>0.8.7</version>
		<executions>
		    <execution>
			<goals>
			    <goal>prepare-agent</goal>
			</goals>
		    </execution>
		    <execution>
			<id>report</id>
			<phase>prepare-package</phase>
			<goals>
			    <goal>report</goal>
			</goals>
		    </execution>
		</executions>
	</plugin>
```

After adding this to our `pom.xml`, we can now 
run this command:

* `mvn test jacoco:report`

The `jacoco:report` does nothing unless the test cases
all pass; but assuming they do, we get a report. That report is in the following file, and can be opened
in a web browser:

* `target/site/jacoco/index.html`

Unfortunately, that file is only visible on the computer
where you are running `mvn`.   

So to make it easier
for teams to work together, as well as for course staff
to see the reports of students, we can use a service
called `codecov.io`.   In the next step, we'll configure that.

# Configuring for Codecov.io

Codecov.io is a commerical service
that enables users to upload code coverage reports
in a variety of formats (including those produced by
popular programming languages).  The `codecov.io` service uses the same permissions as GitHub for private
repos; that is, everyone that can see the private repo
can see the coverage report.  Those folks that cannot
see the private repo, can't see the coverage report
either.

This is important because the coverage report
contains the full source code of the project.
Each line in the report is highlighted in either
green, yellow or red, to indicated the level
of code coverage for that line.   As such, we would
not want to make the coverage reports for private repos public.

To enable codecov for our repo, there are several steps.

* Students should get the GitHub Student Developer 
  Pack at the link <https://education.github.com/students>.  This enables you to get access to Codecov
  features for private repos at no cost.

* Students should login to Codecov and request
  activation of their account.  (The activation
  has to be done by course staff, but only once
  for the entire course, not once per assignment.)
  
  Login with your GitHub account at: <https://codecov.io/>

  * Note to course staff: You authorize students at the link: <https://codecov.io/account/gh/ucsb-cs156-f22/users>.  Be sure that the student has the blue "Student" tag next to their name (indicating that they have the GitHub Student Developer Pack).   
  
  (Note 
  that after Fall 2022, you may need to edit that URL
  to point to the correct organization instead of
  `ucsb-cs156-f22`.)

* Once your account is activated, you can get the 
  *Upload Token* for your repo by visiting this link
  (note that you must edit the link, replacing
  the organization and repo name as needed:)

  <https://codecov.io/gh/ucsb-cs156-f22/repo-name-here>

* Once you have your Upload Token, you need to
  add that as a *secret* on your GitHub repo.

  On that page, there should be a so-called *upload-token value*, a series of letters and numbers like a very long password. You'll need to copy/paste that value, so keep that window open.

* Visit your repo, go to the Settings tab for the 
  repo (not the Settings tab for your GitHub account) and then find Secrets in the left navigation, and click on it.

  Or, equivalently, visit the URL <https://github.com/ucsb-cs156-f22/YOUR-REPO-NAME-HERE/settings/secrets>

  You should see a `New Secret` button at the upper right. Click on this, and add a new secret called `CODECOV_TOKEN` (must be all uppercase, with underscore). The value of the secret will be the one you found on the codecov.io page.

  Adding this token gives your GitHub Action the permission it needs to upload code coverage results to https://codecov.io.


# Modifying the `pom.xml` to produce a code coverage report

To get a code coverage report uploaded to Codecov,
we need to add some code to the `.github/workflows/maven.yml` file.


Here's the file *before*:

```yml
name: Java CI

on:
  pull_request:
  push:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Set up JDK 17
        uses: actions/setup-java@v1
        with:
          java-version: 17.0.x
      - name: Build with Maven
        run: mvn test 
```

Here's the file *after*:

```yml
name: Java CI

on:
  pull_request:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v1
      - name: Set up JDK 17
        uses: actions/setup-java@v1
        with:
          java-version: 17.0.x
      - name: Build with Maven
        run: mvn -B test jacoco:report
      - name: Upload to Codecov
        env:
          CODECOV_TOKEN: ${{ secrets.CODECOV_TOKEN }}
        run: bash <(curl -s https://codecov.io/bash)
```

The change is all in the last five lines.  First, we change:

```
        run: mvn test
```
To:

```     
        run: mvn test jacoco:report
```

This just changes the command that actually runs in the `Build with Maven` step.

Then, we add these four lines at the end.  These lines add another step in the workflow to upload the report to
Codecov:

```
      - name: Upload to Codecov
        env:
          CODECOV_TOKEN: ${{ secrets.CODECOV_TOKEN }}
        run: bash <(curl -s https://codecov.io/bash)
```

# Seeing your code coverage report

Once everything above is done, you should be able to
see a code coverage report by doing one of two things:

1. To generate a report that only you can see on your
   local machine, use:

   `mvn test jacoco:report`

   Then only this file in a web browser:

   `target/site/jacoco/index.html`

2. To generate a report that both you *and* the course
   staff (and later in the course, any pair partner or 
   team that you are working with): push a change to 
   a branch, or do a pull request.

   Then you should be able to see a report for the `main` branch here:

   * <https://codecov.io/gh/ucsb-cs156-w22/REPO-NAME-HERE>

   To see a report for another branch, use:
   * <https://codecov.io/gh/ucsb-cs156-w22/REPO-NAME-HERE/branch/BRANCH-NAME-HERE>

Here's a link to an example report:
* <https://codecov.io/gh/ucsb-cs156/student-tutorial/src/ex06/src/main/java/Student.java>

And here's a screenshot of that report, in case it doesn't load:

<img width="578" alt="coverage-report-50.png" src="https://user-images.githubusercontent.com/1119017/192169961-6a956910-6192-45ea-8c74-9ef08e41b654.png">

That's all for this exercise.  In future exercises,
we'll use the test results and test coverage results
as we add additional features to the `Student` class.

