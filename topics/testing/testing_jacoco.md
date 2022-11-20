---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Jacoco"
description:  "How to interpret the reports (red, yellow, green)"
indent: true
category_prefix: "Testing:"
---

# Jacoco: Java Code Coverage

Jacoco (*Ja*va *Co*de *Co*verage)  is a tool for measing code coverage in Java.

* Jacoco Home Page: <http://www.jacoco.org>
* The [documentation for Jacoco](http://www.jacoco.org/jacoco/trunk/doc/index.html) can be difficult to follow.

Here are some additional articles:

* <https://www.codeproject.com/Articles/832744/Getting-Started-with-Code-Coverage-by-Jacoco>
* <http://www.baeldung.com/jacoco>
* <https://github.com/powermock/powermock/wiki/Code-coverage-with-JaCoCo>


# How to read the test coverage reports

First, read about test coverage in general to understand line vs branch coverage: <https://ucsb-cs156.github.io/topics/testing_coverage/>

* If any line of code is red, that means it is not tested at all&mdash;it is being missed by *line coverage*
* If a line of code is yellow, it means there are multiple ways to execute the line.
   * it may have an if/else, or a boolean expression involving `&&` or `||`, and thus there are multiple paths through the code (multiple branches).  
   * Yellow means it is being missed by *branch coverage*; some branches are covered, and others are not.   
   * Think about the multiple paths through the code and be sure your tests cover all of them.

# Getting Test Coverage Reports from GitHub Actions

When Jacoco fails on CI/CD, i.e. on GitHub Actions, it can be difficult to determine what went wrong from the logs.  Instead, you can download what are
called *artifacts*.  Here's how:

* In this example, I added a bit of stupid code to one of the controllers, code that has no test coverage.  (Note that this code serves no useful purpose other than to illustrate some code that isn't covered by tests.)  Here's the code I added for which I added no tests:
  ```java
        if (psId == 9999) {
          throw new Exception("test for code coverage");
        }
  ```
* Let's see what happened when I submitted this to CI/CD (i.e. did a pull request and GitHub Actions ran jacoco).  Sure enough, it failed, as we can see from the red X in this screen shot
  <img width="532" alt="image" src="https://user-images.githubusercontent.com/1119017/202889944-755f8dbf-7835-4b32-8a4d-ab8fdde848e1.png">
* We then go into the PR in more detail to see which part of the GitHub Actions failed, and we see that Jacoco was one of the parts that failed, as seen in this screen shot:
  <img width="890" alt="image" src="https://user-images.githubusercontent.com/1119017/202889971-15a390cc-bd9a-479e-a85a-1fea4e088479.png">
* Now what?  The log is too long.  But if we follow the steps shown in this animation, we can click "Summary", then "Artifacts". This downloads a zip file
  which, when uncompressed, contains the files for the Jacoco report.  If we open `index.html` in a web browser, we can read the report and see
  exactly which lines are not covered by tests:
  
  ![download-artifacts](https://user-images.githubusercontent.com/1119017/202890020-f8d7e34c-c67b-47c8-9bf5-f5e93590bd6f.gif)


