---
parent: "Spring Boot"
grand_parent: Topics
layout: default
title: "Spring Boot: Secrets"
description:  "Ways of keepings database credentials and OAuth client secrets out of Github"
category_prefix: "Spring Boot: "
indent: true
---

Sometimes there are credentials that instructions tell you should be put into your `application.properties` file, however those
credentials are sensitive information that should NOT go into Github, such as:
* passwords
* authorization tokens
* OAuth client secrets

What can you do?

This repo has one solution:

* <https://github.com/ucsb-cs56-pconrad/spring-boot-app-config>
