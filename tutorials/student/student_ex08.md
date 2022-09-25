---
title: "Student: ex08"
parent: Student
grand_parent: Tutorials
description: "Setting up pitest mutation testing"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex08
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# Overview

In this example we go beyond line and branch coverage,
to an even better way of checking the rigor of a test suite:
mutation testing.


# What is mutation testing

The website for [pitest](https://pitest.org) has a nice summary
of what mutation testing is, so I'm just going to quote from it:

> ## What is mutation testing?
> How it works in 51 words
>
> Mutation testing is conceptually quite simple.
>
> Faults (or mutations) are automatically seeded into your code, 
> then your tests are run. If your tests fail then the mutation 
> is killed, if your tests pass then the mutation lived.
>
> The quality of your tests can be gauged from the percentage of 
> mutations killed.
> 
> ## What?
> Really it is quite simple
>
> To put it another way - PIT runs your unit tests against 
> automatically modified versions of your application code. When
> the application code changes, it should produce different 
> results and cause the unit tests to fail. If a unit test does
> not fail in this situation, it may indicate an issue with the
>  test suite.
>
> #Why?
> What's wrong with line coverage?
>
> Traditional test coverage (i.e line, statement, branch, etc.)
> measures only which code is executed by your tests. It does
>  not check that your tests are actually able to detect faults
> in the executed code. It is therefore only able to identify
> code that is definitely not tested.
>
> The most extreme examples of the problem are tests with no 
> assertions. Fortunately these are uncommon in most code bases.
> Much more common is code that is only partially tested by its
> suite. A suite that only partially tests code can still
> execute all its branches (examples).
>
> As it is actually able to detect whether each statement is 
> meaningfully tested, mutation testing is the gold standard
> against which all other types of coverage are measured.

# So how does this work in practice?

So, to clarify, you will run mutation testing once you've
gotten to 100% line/branch coverage, or as close to it as
you can get.  At that point, you run:

```
mvn test org.pitest:pitest-maven:mutationCoverage
```

(Yeah, no one is going to expect you to memorize that command.
We might expect you to know `mvn compile`, `mvn package`, and `mvn test`, and maybe even `mvn test jacoco:report`, but not this one.)

When you run that command, each of the java files under `src/main/java` will be *mutated*; the pitest software will create mutant versions of that code in an attempt to deliberately introduce bugs.

Then, each of those mutants meets one of two fates:
* *killed* if test suite finds it (i.e. if if fails some test in the test suite)
* *survives* if the test suite doesn't detect the mutation

There is also a third possibility: if the portion of the code mutated is never even run by the test suite, you might get a report that
there was *no coverage*.

As an aside, this highlights the justification for separating out the
`src/main/java` code from the `/src/test/java` code: 
* We use the code in `src/test/java` to check the correctness of
  the code under `src/main/java`
* We mutate the code under `src/main/java` in order to evaluate the
  tests under `src/test/java`.

  
The output of the pitest report will show you how many mutants are killed, survived, or had no coverage.  The goal is to kill 100% of the mutants.

# How to set up pitest coverage for a Maven project

To set up pitest coverage for Maven project, we only need to make some
change to the `pom.xml`.

We need a new `<plugin>` in our `<plugins>` section.  Note that as configured,
this will only target classes under the `edu.` package.  If we are 
working with code from other packages, we'll need to modify
the configuration of this plugin:

```xml
      <plugin>
          <groupId>org.pitest</groupId>
          <artifactId>pitest-maven</artifactId>
          <version>1.7.3</version>
          <!-- this is needed to run pitest with JUnit 5 -->
          <dependencies>
              <dependency>
                  <groupId>org.pitest</groupId>
                  <artifactId>pitest-junit5-plugin</artifactId>
                  <version>0.14</version>
              </dependency>
          </dependencies>
          <configuration>
              <verbose>true</verbose>
              <targetClasses>
                  <param>edu.*</param>
              </targetClasses>
              <targetTests>
                  <param>edu.*</param>
              </targetTests>
              <outputFormats>
                  <outputFormat>HTML</outputFormat>
                  <outputFormat>CSV</outputFormat>
                  <outputFormat>XML</outputFormat>
              </outputFormats>
          </configuration>
      </plugin>

```
# Running pitest 

To generate the mutation testing coverage
using pitest, we use the following command.

```
mvn test org.pitest:pitest-maven:mutationCoverage
```

(Don't worry that I'll expect you to memorize that.  I don't plan to try to memorize that one myself.  You should know `mvn compile`, `mvn test`, `mvn clean`, and `mvn package`, and even `mvn test jacoco:report`, but this one is beyond what one can expect to memorize.)

This produces some output on the console, as well
as a more detailed report in a file that you can
open in a web browser.

The first thing you should look at is the
summary at the end of the console report:

```
====================================================
- Statistics
====================================================
>> Generated 10 mutations Killed 2 (20%)
>> Ran 2 tests (0.2 tests per mutation)
```

A score of 100% is a perfect score, and we are only at 20%.  So we have some work to do.

# The detailed report of which mutations survived

The output you get on your console will tell you a summary
of the fate of each mutant.   You can see more detailed output by using a web browser to open up the file:

* <tt>target/pit-reports/<i>yyyymmddhhmm</i>/index.html</tt>

Note that <tt><i>yyyymmddhhmm</i></tt> will be replaced by a date/timestamp; each time you run the Maven command to run
pitest, it will produce a new version of the report with a new timestamp.  

It may be convenient to use `mvn clean` before running a pitest mutation report; that way there will only be one such directory rather than multiple ones.

Here's an example of what that report looks like:

<img width="364" alt="pit-report-example-50.png" src="https://user-images.githubusercontent.com/1119017/192170019-05bb5dfb-9d93-462c-be36-88191660f53b.png">

As you can see, this a web page that contains a link to the package `edu.ucsb.cs156.student`.  I made a copy of the entire report at this link so that you can explore the entire report, including how it looks when you click on the links:
* [target/pit-reports/202010201137/index.html](https://ucsb-cs156.github.io/tutorials/student/student_ex08/target/pit-reports/202010201137/index.html)

As you click on the package name, you see this screen
which shows you the two source files in the package:

<img width="274" alt="package-50.png" src="https://user-images.githubusercontent.com/1119017/192170028-607f58ba-5e63-40ce-9207-f4996aaf14d9.png">


Clicking on the link for `Student.java`, we see
that it's only the body of the `toString` method
that is showing up in red as not being covered
by tests.   We'll add this test coverage in ex09.

<img width="390" alt="student.java-50.png" src="https://user-images.githubusercontent.com/1119017/192170032-632b8b15-b44c-47a6-994b-e3e8581b448a.png">

Clicking on the link for `Main.java`, we see
that the entire Main method is uncovered.  We'll
discuss that in ex09 as well.

<img width="410" alt="main.java-50.png" src="https://user-images.githubusercontent.com/1119017/192170039-e095a0a3-b9e6-413c-b48f-74f46df1cae4.png">


# Adding pitest to our GitHub workflow

Though it isn't required for using pitest, it can be handy to add this into our
GitHub workflow (i.e. our [CI pipeline](/topics/CI))

To add pitest to our GitHub workflow, we only need to add a small number of lines 
to the bottom of our existing `.github/workflow/maven.yml` file.

Here are the new lines.  These add two new steps to the workflow; each line that
starts with a `-` introduces a new step to the list of steps (this is YAML notation
for elements in a list).  An explanation of these steps follows the yaml listing

```yaml
      - name: Pitest
        run: mvn test org.pitest:pitest-maven:mutationCoverage
      - name: Upload Pitest to Artifacts
        uses: actions/upload-artifact@v2
        with:
          name: pitest-mutation-testing
          path: target/pit-reports/**/*  
```

The first two lines introduces a step that just runs the maven command to produce
the pitest reports:

```
    - name: Pitest
      run: mvn test org.pitest:pitest-maven:mutationCoverage
```

The second two uses a predefined GitHub action that can be used to upload
artifacts.  It uploads everything under `target/pit-reports/`.  The `**/*` notation
means "everything, no matter how many levels of directory it might be.".

```yaml
    - name: Upload Pitest to Artifacts
      uses: actions/upload-artifact@v2
      with:
        name: pitest-mutation-testing
        path: target/pit-reports/**/*  
```


# Another way to see the Pitest report: GitHub Actions artifacts

Another way to see the pitest report is to let the GitHub Actions run for your
repo (which happens each time you push a change to GitHub).   When you do, you should
see that there is a link for "Artifacts" when you examine the Github Actions results.

If you download the artifacts, you'll get a .zip file that you can download, and
open.  Inside that zip file, you'll find an `index.html` file that you can open in a
web browser.  That will show you the Pitest mutation report.


<img width="318" alt="click-green-check-50.png" src="https://user-images.githubusercontent.com/1119017/192170063-669ae0e5-334a-4fe2-87f2-e84d7b71b9d5.png">

<img width="237" alt="click-details-50.png" src="https://user-images.githubusercontent.com/1119017/192170091-f4e1bcd5-7c0f-46bc-8cec-881ef703de60.png">

<img width="442" alt="click-artifacts-50.png" src="https://user-images.githubusercontent.com/1119017/192170094-95cbfc38-d145-4f51-969b-039fc38f46ac.png">

<img width="223" alt="click-to-download-zip-50.png" src="https://user-images.githubusercontent.com/1119017/192170102-bad87141-f6c4-4930-8eaa-5627794903db.png">


# So now what?

The mutation testing report on the code in the ex08 branch shows that
we have a lot of room for improvement.  We see that out of 10 mutations generated, only two of them (20%) were killed by our tests.

So, in the next few exercises, we'll go about showing how to improve
on that.

```
>> Generated 10 mutations Killed 2 (20%)
>> Ran 2 tests (0.2 tests per mutation)
```
