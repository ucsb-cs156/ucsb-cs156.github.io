---
parent: Topics
layout: default
title: "Thymeleaf"
description:  "A Templating Engine for Spring Boot"
---


# {{page.title}}

The CMPSC 156 code bases no longer use Thymeleaf.  Thymeleaf is a templating engine for when the Java Spring Boot backend handles the formatting of the client HTML, and there it little to no JavaScript code.   We have moved all frontend processing to the client side using React.

This page is here only for historical reasons, in case we need to decipher an older code base that uses Thymeleaf.

## Introduction to Thymeleaf

In web applications, we typically need to render HTML pages that are a mixture of static HTML plus computed data.

It's not very convenient to have to render this with statements such as the following:

```java
String page="<html><head></head><body><h1>My name is" + name + "</h1></body></html>";
```

So, most web application frameworks have some kind of *Templating System*.   A templating system allows you to write HTML pages but at various places insert values from some object in the program.   

The templating system we'll be using in CMPSC 56 is called *Thymeleaf*.  Thymeleaf  has a particular advantage over other templating systems in that that every `.html` file that uses Thymeleaf is also valid HTML that can be displayed in a browser.   The parts of the file that do the templating *will not work* if you just open the file in a browser, but you can at least see if the HTML looks reasonable or not.

## Thymeleaf dependency for Maven `pom.xml`

The first step if you want to use Thymeleaf is a Spring Boot application is that you must include Thymeleaf as a dependency in the `dependencies` section of the Maven `pom.xml` file.  Here is the dependency that you need:

```xml
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-thymeleaf</artifactId>
  </dependency>
```

This is typically used in the comnbination with this `parent` element:

```xml
  <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.0.5.RELEASE</version>
   </parent>
```

## Setting up a controller

A controller action that uses Thymeleaf will return the name of a `.html` file that is:
* located in `src/main/resources/templates`
* does not have the `.html` at the end
* is a path that does not start with `/` and is relative to  `src/main/resources/templates`

For example:

| To use this file | Put this in the Java code |
|------------------|---------------------------|
| `src/main/resources/templates/index.html` | `return "index";` |
| `src/main/resources/templates/courses/form.html` | `return "courses/form";` |
| `src/main/resources/templates/tutors/add/result.html` | `return "tutors/add/result";` |

An example controller that that returns `src/main/resources/templates/index.html` as the home page for the application looks like this:

```java
package edu.ucsb.cs56.example.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class HomeController {

    private Logger logger = LoggerFactory.getLogger(HomeController.class);

    @GetMapping("/")
    public String getHomepage() {
        logger.info("Getting Home Page");
        return "index";
    }
}

```



## References

* <https://www.thymeleaf.org/doc/articles/standarddialect5minutes.html>
