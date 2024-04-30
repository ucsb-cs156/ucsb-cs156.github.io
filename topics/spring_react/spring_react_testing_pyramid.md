---
parent: "Spring/React"
grand_parent: Topics
layout: default
title: "Spring/React: Testing Pyramid"
description:  "How to go beyond just unit testing, and do integration and end-to-end tests"
---

# {{page.title}} - {{page.description}}

Initially, the code bases for each of our Spring/React projects had only unit tests.

Starting in Spring 2024, we began to slowly add integration and end-to-end tests to each of these (led by the work of MS Student Andrew Peng).

This guide explains, step-by-step, how to introduce integration and end-to-end testing in to one of these code bases, including:

* Changes to the pom.xml
* Changes to the `/resources` directory
* Services that you need to add (support code)
* Adding the integration tests themselves
* Adding the end-to-end tests themselves
* Adding Github workflow(s) for the tests
* What you need to add to the documentation to explain the new tests

# TODO: Andrew continue from here. 
