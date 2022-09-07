---
parent: Topics
layout: default
title: "Spring Boot: Actuator"
description:  "Checking the endpoint mappings, health or other info about your Spring Boot app"
category_prefix: "Spring Boot: "
indent: true
---

When building a web app it is useful to be able to:
* See a list of all the endpoints in your application, and what controller they map to (similar to a `rails routes` in the Ruby on Rails framework)
* Check on the health of your application
* Get other arbitrary info 

You might *not* want to do this with a production version of the application, but during development, it is quite reasonable.

One way to accomplish this is to include the Spring Boot Actuator as one of your dependencies, by including this in your `pom.xml`

```
   <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-actuator</artifactId>
   </dependency>
```                

You can then put this in your `src/main/resources/applicaion.properties`:

```
management.endpoint.mappings.enabled=true
management.endpoints.web.exposure.include=mappings,health,info
```

This allows you to visit endpoints called `/mappings`, `/health` and `/info` to get various kinds of information about your application.

These work best if you have loaded a JSON formatter extension to your browser such as
[JSONView for Chrome](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc) 
or [JSONView for Firefox](https://addons.mozilla.org/en-US/firefox/addon/jsonview/)
since those will allow you to see the JSON in an easily readable format.

# More information

* <https://www.callicoder.com/spring-boot-actuator/>
* <https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-endpoints.html#production-ready-endpoints>
* Injecting git commit information: <https://www.baeldung.com/spring-git-information>
