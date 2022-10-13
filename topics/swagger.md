---
parent: Topics
layout: default
title: Swagger
description:  "Automatic documentation of Spring Boot Restful APIs"
---

# {{page.title}}

The backend of a Spring Boot web app can be documented using a package called Swagger.

Here are some resources that describe how this works:

* <https://www.baeldung.com/swagger-2-documentation-for-spring-rest-api>: Basic tutorial
* <https://springframework.guru/spring-boot-restful-api-documentation-with-swagger-2/>  Shows some examples of customizing the entries through annotations.
* <https://dzone.com/articles/spring-boot-restful-api-documentation-with-swagger> 
* <https://www.springboottutorial.com/spring-boot-swagger-documentation-for-rest-services>
* <https://www.dariawan.com/tutorials/spring/documenting-spring-boot-rest-api-swagger/>
* <https://howtodoinjava.com/swagger2/swagger-spring-mvc-rest-example/>

# Tips

For certain errors with implementing Swagger, the following fix may help.

In your `main`, i.e. the `public static void main` method that is annotated with `@SpringBootApplication`, add this annotation (as described in this [Stack Overflow answer](https://stackoverflow.com/a/54941282)

```
@EnableSwagger2
```

The import is this:

```
import springfox.documentation.swagger2.annotations.EnableSwagger2;
```
