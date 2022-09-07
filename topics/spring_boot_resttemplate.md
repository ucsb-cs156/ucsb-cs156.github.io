---
parent: Topics
layout: default
title: "Spring Boot: RestTemplate"
description:  "When you need to access other APIs from the backend of your Spring Boot Application"
category_prefix: "Spring Boot: "
indent: true
---

Suppose you are in the backend code of your Spring Boot application and you want to access some other API, e.g. the <https://developer.ucsb.edu> API.

What code can you use?

Here is a tutorial on the REST client built into Spring Boot called `RestTemplate`:

* <https://howtodoinjava.com/spring-boot2/resttemplate/spring-restful-client-resttemplate-example/>
* <https://www.baeldung.com/rest-template>
* <https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/client/RestTemplate.html>

This one covers the Maven dependencies that need to be in the `pom.xml`

* <https://www.baeldung.com/how-to-use-resttemplate-with-basic-authentication-in-spring>

# Setting Headers 

Many APIs (including, for example, <https://developer.ucsb.edu>) require setting headers.

For example, <https://developer.ucsb.edu> requires you to set: 

```
accept: application/json
ucsb-api-version: 1.0
ucsb-api-key: value-specific-to-each-api-user
```

How do you set these headers?  This article explains:

* <https://stackoverflow.com/questions/32623407/add-my-custom-http-header-to-spring-resttemplate-request-extend-resttemplate/32623548>
