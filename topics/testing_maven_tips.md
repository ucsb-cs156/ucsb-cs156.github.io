---
parent: Topics
layout: default
title: "Testing: Maven Tips"
description:  "Tips on running tests with Maven for Spring/React projects"
category_prefix: "Testing: "
indent: true
---

| Command | What it does | 
|-|-|
| `mvn test` | Run all tests (front end and backend) |
| `mvn test -Dskip.npm` | Run only backend tests |
| `mvn test jacoco:report -Dskip.npm` | Run only backend tests, and generate jacoco report |
| In web browser: `target/site/jacoco/index.html` | The detailed backend coverage report |
| `mvn test -Dskip.npm -DFooTests ` | Run just a single test file from the backend (specify filename) |
