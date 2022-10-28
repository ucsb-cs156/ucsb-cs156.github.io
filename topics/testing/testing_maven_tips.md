---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Maven Tips"
description:  "Tips on running tests with Maven for Spring/React projects"
category_prefix: "Testing: "
indent: true
---

| Command | What it does | 
|-|-|
| `mvn test` | Run only backend tests |
| `mvn test jacoco:report` | Run only backend tests, and generate jacoco report |
| In web browser: `target/site/jacoco/index.html` | The detailed backend coverage report |
| `mvn test pitest:mutationCoverage` | Run only backend tests, and generate mutation coverage |
| `mvn test -DFooTests ` | Run just a single test file from the backend (specify filename) |
| `mvn test -DFooTests\#test_method_name ` | Run just a single *test*  from the backend (specify filename, then `\#`, then method name of test) |
