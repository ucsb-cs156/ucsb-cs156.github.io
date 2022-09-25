---
title: "Student: ex05"
parent: Student
grand_parent: Tutorials
description: "Setting up GitHub Actions"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex05
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# Overview

In this example we introduce GitHub Actions as a way to automate running a suite of JUnit tests.

GitHub Actions is a platform for "continuous integration" of our
code, i.e. automatically testing our *entire code base* after every commit.

In the top level of every GitHub repo, the developer can create a special directory called `.github` that contains files that configure special features of GitHub.  

Under that `.github` directory, the developer can put files into a directory called `workflows` that define scripts that can be run when certain GitHub events occur.  For now, we'l focus on a workflow that runs any time code is pushed to any branch of the repo.

As an example, we can define a script that will run all of the JUnit tests in the repo every time a push is made.

This is part of a strategy commonly used in professional software development organizations called *Continuous Integration*.

It’s called Continuous Integration because:

* It’s *Continuous*: you do it as you push commits into your branch
* It’s an Integration: you are looking at the impact of 
  your changes not just on the parts of the code base you think you are impacting, but on the entire code base as an integral whole.

You can read more about CI systems here: <https://ucsb-cs156.github.io/topics/ci/>

To set up GitHub Actions for any repo, we take two steps:
* Create a directory called `.github/workflows`.  
  - To create it, we can type `mkdir -p .github/workflows`
  - Note that
    because the directory name `.github` starts with a `.`, it
    will be a hidden directory on many systems.

    On Unix, you use `ls -a` to show hidden files/directories.

* Into the directory `.github/workflows`, we put a file
  that specifies the actions to be taken, using a syntax
  called YAML (pronounced "Yam-el"; it rhymes with "Camel")
  - `.yml` is the file extension for YAML files.
  - `.yml` syntax is used by many systems, not just GitHub Actions 
  
Note that, at least for now, you are not required to learn the special syntax of the `.yml` files used
for GitHub actions; we'll provide the contents and modifications needed.   We may learn little bits and pieces
of it as needed.   But if you want a reference for it, you can find
one here: 
* [Workflow Syntax for GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-syntax-for-github-actions)
  


Here is a `.yml` file that will run JUnit tests on a Java 11 Maven project.  We'll call it `.github/workflows/maven.yml` since it is a workflow for Maven.

```
name: Java CI

on:
  pull_request:
  push:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Set up JDK 11
        uses: actions/setup-java@v1
        with:
          java-version: 11.0.x
      - name: Build with Maven
        run: mvn test 
```
  
The directory structure should look like this:

<img width="638" alt="maven-dir-with-github-actions-50.png" src="https://user-images.githubusercontent.com/1119017/192169886-198412c4-f15d-4547-9bf7-42d7da185e30.png">


With this in place, if we commit a change and put it to GitHub, we should see that our commit has either a yellow circle, green check or red X next to it, as illustrated by these three images:

Green check indicates all tests passed:

<img width="471" alt="green-check-50.png" src="https://user-images.githubusercontent.com/1119017/192169902-3450aef9-3f13-47a7-b2e3-bd7e0bfed549.png">


Yellow circle indicates tests are still running (no results yet):

<img width="474" alt="yellow-circle-50.png" src="https://user-images.githubusercontent.com/1119017/192169910-e180f35f-69ab-42ff-8b0a-cde4eab1191b.png">

Red X indicates either that at least one test failed, or the 
entire testing script failed in some way:

<img width="485" alt="red-x-50.png" src="https://user-images.githubusercontent.com/1119017/192169917-db665a61-917f-458d-9664-a16c88ffa71e.png">

If you click on the green check, yellow circle, or red X, you'll 
get a pop up with more information, and a link to the details.

That's all we are going to cover this in this example.
In the next example, we'll add some plugins to our `pom.xml`
and modify our script so that it can also perform test coverage,
which is also known as code coverage.

