---
parent: Topics
layout: default
title: "Spring/React: Directory Structure"
description:  "Where to find what"
category_prefix: "Spring React: "
indent: true
---

NOTE: THIS PAGE IS STILL A WORK IN PROGRESS AS OF 02/17/2021

In the Spring/React projects for this course:

* the top level directory structure follows conventions for Spring Boot projects
* there is a `javascript` subdirectory that contains code for a React app

# Directory Structure under `/src/main/java/.../`

Under the `src/main/java` directory, under a package name suitable for the project, you'll find this directory structure:

* `advice`
* `config`
* `controllers`
* `documents`
* `entities`
* `models`
* `repositories`
* `services`

A parallel structure under `src/test/java` has the test cases for this code.

# Directory Structure under `javascript`

Under the `javascript` directory, you'll find this directory structure:

* `build` (a temporary directory that is in `.gitignore`)
* `node_modules` (a temporary directory that is in `.gitignore`)
* `public` 
* `src`

Under `src` you'll find this hierarchy:

* `main`
* `test`

Under `main`, you'll find these files directly:

* `App.js`
* `App.css`

And these directories:

* `assets`
* `components`
* `pages`
* `utils`

There are also a variety of files directly in `javascript/src`

* `index.css`
* `index.js`
* `logo.svg`
* `serviceWorker.js`
* `setupTests.js`





