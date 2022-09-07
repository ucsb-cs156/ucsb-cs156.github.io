---
parent: Topics
layout: default
title: "Spring Boot: ControllerAdvice"
description:  "A place to factor out common ExceptionHandler, ModelAttribute and InitBinder code across multiple controllers"
category_prefix: "Spring Boot: "
indent: true
---

If you want certain attributes of your `Model` to be present in every controller method that processes a web request,
a class annotated with `@ControllerAdvice` may be helpful. 

* <https://www.logicbig.com/tutorials/spring-framework/spring-web-mvc/controller-advice-with-model-attribute.html>
