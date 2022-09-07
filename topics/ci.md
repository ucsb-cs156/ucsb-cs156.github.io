---
parent: Topics
layout: default
title: "CI: "
description:  "Continuous Integration--automatically testing after every commit"
category_prefix: "CI: "
---

Continuous Integration (CI) is an industry standard practice for professional software development.

In short, CI refers to running an automated test suite on the entire code base every time you push a change to any part of that code base.

It's called *Continuous Integration* because:
* It's *Continuous*: you do it as you push commits into your branch
* It's an *Integration*: you are looking at the impact of your changes *not just* on the parts of the code base you think you are impacting, but on the entire code base as an integral whole.

Some commonly used CI systems include:
* Jenkins
* Travis-CI
* GitHub Actions

Starting from Fall 2020, we are using GitHub Actions for CI in this course.

# GitHub Actions

GitHub actions is controlled by files that appear in a subdirectory called `.github/workflows`.    

We'll document more about it as the course proceeds.




# Travis-CI

NOTE: This information is included because some past versions of CS56, the course that preceeded CS156, used Travis-CI, so there
may still be references in some parts of the course materials to Travis-CI.  However, as of Fall 2020, we are pivoting to
using GitHub Actions instead.

You can use Travis-CI for free on pretty much any open source github.com repo that has a `.travis.yml` file in it.

You log into <http://travis-ci.org> with your github.com username/password in order to set it up.

