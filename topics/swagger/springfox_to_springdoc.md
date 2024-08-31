---
parent: Swagger
grand_parent: Topics
layout: default
title: "Swagger: SpringFox to Springdoc"
description:  "How to migrate"
---

# {{page.title}} &mdash; {{page.description}}

When we first incorporated Swagger into the CMPSC 156 code bases, we used a package called SpringFox.  However, it came to pass that SpringFox was no longer being supported, and when a security vulnerability in SpringFox was discovered, it became necessary to migrate to SpringDoc 1.7.0.

Note that the most current version of SpringDoc as of August 2023 was [Springdoc 2.1.0](https://springdoc.org/), but that version only supports Spring Boot 3.x, and we
are still currently using Spring Boot 2.x, so we are using
[Springdoc 1.7.0](https://springdoc.org/v1/) which can be 
found on GitHub [here](https://github.com/springdoc/springdoc-openapi/tree/v1.7.0).

Note that the javadoc links here for the Springdoc annotations
come from the 2.1.0 version; I was unable to find javadoc
for the 1.7.0 version online.  However, my impression
is that the annotations referred to here are largely unchanged between
1.7.0 and 2.1.0.

This page describes the steps to take when migrating a CMPSC 156 code base from SpringFox to SpringDoc.

This page may also be helpful:
* <https://springdoc.org/#migrating-from-springfox>

## Step 1: Replace `@Api` with `@Tag` in Controllers

Under SpringFox, controllers use the `@Api` annotation ([javadoc](https://docs.swagger.io/swagger-core/v1.5.0/apidocs/io/swagger/annotations/Api.html)).  This annotation is found at the top of each controller class.

```
import io.swagger.annotations.Api;
...
@Api(description = "Commons")
``` 


Under SpringDoc, `@Api` is replaced with `@Tag` ([javadoc](https://docs.swagger.io/swagger-core/v2.0.9/apidocs/index.html?io/swagger/v3/oas/annotations/tags/Tag.html)), like this:

```
import io.swagger.v3.oas.annotations.tags.Tag;
...
@Tag(name = "Restaurants")
```

So the two search and replaces needed are:

| Find | Replace |
|------|---------|
| `@Api(description` | `@Tag(name` |
| `import io.swagger.annotations.Api;` | `import io.swagger.v3.oas.annotations.tags.Tag;` |

Be sure afterwards to look for any other instances of `@Api` that your search/replace may have missed (for example `@Api(` that might omit `description` or have a space between the `(` and the `d`, etc.)

## Step 2: Replace `@ApiOperation` with `@Operation`

Under SpringFox, controller methods that
provide an endpoint use the `@ApiOperation` annotation ([javadoc](https://docs.swagger.io/swagger-core/v1.5.0/apidocs/io/swagger/annotations/ApiOperation.html)).  

```
import io.swagger.annotations.ApiOperation;
...
@ApiOperation(value = "Get a list of all commons")
``` 


Under SpringDoc, `@ApiOperation` is replaced with `@Operation` ([javadoc](https://docs.swagger.io/swagger-core/v2.0.9/apidocs/index.html?io/swagger/v3/oas/annotations/Operation.html)), like this:

```
import io.swagger.v3.oas.annotations.tags.Operation;
...
@Operation(summary = "Restaurants")
```

So the two search and replaces needed are:

| Find | Replace |
|------|---------|
| `@ApiOperation(value` | `@Operation(summary` |
| `import io.swagger.annotations.ApiOperation;` | `import io.swagger.v3.oas.annotations.Operation;` |

Be sure afterwards to look for any other instances of
 `@ApiOperation(` that your search/replace may have missed.


## Step 3: Replace `@ApiParam` with `@Parameter`

Under SpringFox, parameters are annotated with 
 `@ApiParam`  ([javadoc](https://docs.swagger.io/swagger-core/v1.5.0/apidocs/io/swagger/annotations/ApiParam.html)).  

```
import io.swagger.annotations.ApiParam;
...
  @ApiParam("id") @RequestParam long id)
``` 


Under SpringDoc, `@ApiParam` is replaced with `@Parameter` ([javadoc](https://docs.swagger.io/swagger-core/v2.0.9/apidocs/index.html?io/swagger/v3/oas/annotations/Parameter.html)), like this:

```
import io.swagger.v3.oas.annotations.tags.Operation;
...
    @Parameter(name = "id") @RequestParam Long id,
```

So the two search and replaces needed are:

| Find | Replace |
|------|---------|
| `@ApiParam(` | `@Parameter(name=` |
| `import io.swagger.annotations.ApiParam;` | `import io.swagger.v3.oas.annotations.Parameter;` |

Be sure afterwards to look for any other instances of
 `@ApiParam(` that your search/replace may have missed.

## Step 4: Other search/replaces

The search/replaces in Steps 1,2,3 are likely enough to pick up most or all of the SpringFox annotations that we
used, but you may want to look for these as well;
you may need to look at the javadoc for each to find the
details of any parameter names you need to adjust:

Here are the ones you already did in steps 1-3:


| [SpringFox](https://docs.swagger.io/swagger-core/v1.5.0/apidocs/) | [SpringDoc](https://docs.swagger.io/swagger-core/v2.0.9/apidocs/index.html) |
|-----------|-----------|
| `@Api` |  `@Tag` |
| `@ApiOperation(value = "foo", notes = "bar")` | `@Operation(summary = "foo", description = "bar")
| `@ApiParam` | `@Parameter

Here are the others you could run into. The headers to the table take you to the javadoc for each.

Rather than searching for each, it may be easier to just skip this step for now, and come back to it
if you find you have compilation errors at a later stage, since the use of any of these in our codebase
is rare.  

| [SpringFox](https://docs.swagger.io/swagger-core/v1.5.0/apidocs/) | [SpringDoc](https://docs.swagger.io/swagger-core/v2.0.9/apidocs/index.html) |
|-----------|-----------|
| `@ApiIgnore` | `@Parameter(hidden = true)` or `@Operation(hidden = true)` or `@Hidden` |
| `@ApiImplicitParam` | `@Parameter` |
| `@ApiImplicitParams` | `@Parameters` |
| `@ApiModel` | `@Schema` |
| `@ApiModelProperty(hidden = true)` | `@Schema(accessMode = READ_ONLY)` |
| `@ApiModelProperty` | `@Schema` |
| `@ApiResponse(code = 404, message = "foo")` | `@ApiResponse(responseCode = "404", description = "foo")` |

## Step 4: Change pom.xml

Remove references to springfox from the `pom.xml` such as these:

```xml 
        <!-- https://www.baeldung.com/swagger-2-documentation-for-spring-rest-a
pi -->
        <dependency>
            <groupId>io.springfox</groupId>
            <artifactId>springfox-boot-starter</artifactId>
            <version>3.0.0</version>
        </dependency>

        <dependency>
            <groupId>io.springfox</groupId>
            <artifactId>springfox-swagger-ui</artifactId>
            <version>3.0.0</version>
        </dependency>

```

Replace with this:

```xml
   <dependency>
      <groupId>org.springdoc</groupId>
      <artifactId>springdoc-openapi-ui</artifactId>
      <version>1.7.0</version>
   </dependency>
```

## Step 5: `Replace SpringFoxConfig.java` (or equivalent) with `OpenApiConfig.java`

Look for a file with the name `SpringFoxConfig.java` or something similar.  It should have content such as this:

```
@Configuration
public class SpringFoxConfig {
    @Bean
    public Docket api() {
    ...
```

Remove this file entirely.  Instead, under the `config` directory, create a file called `OpenAPIConfig.java`
with the following contents (adjusted as appropriate 
for your project).  The HTML under `description` will
be placed at the top of your Swagger page. 

In this example,
I put links to the home page of the application,
and a link to the H2-Console; you may put whatever
links or information you think will be useful to developers
working with the Swagger page.  Note that the `class` definition is deliberately empty; the `OpenAPIDefinition` annotation is doing all of the work here.

Also be sure to replace the `package` name with one appropriate to your application.

```java
package edu.ucsb.cs156.yourappname.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.servers.Server;

@OpenAPIDefinition(
  info = @Info(
  title = "Name of Your Project goes here",
  description = """
    <p><a href='/'>Home Page</a></p>
    <p><a href='/h2-console'>H2 Console (only on localhost)</a></p>
    """     
    ),
  servers = @Server(url = "/")
)
class OpenAPIConfig {}

```

## Step 6: Update `application.properties`

In `src/main/resources/application.properties`, locate the application properties associated with swagger and springfox:

```
springfox.documentation.swagger.v2.path=/api/docs
```

Remove the lines that start with `springfox` such as the one above.

Add these lines:

```
management.endpoints.web.exposure.include=mappings
springdoc.swagger-ui.tryItOutEnabled=true
springdoc.swagger-ui.csrf.enabled=true
```

This article explains the last line:
*  <https://medium.com/@thecodinganalyst/configure-spring-security-csrf-for-testing-on-swagger-e9e6461ee0c1>

## Step 7: Test it

Now, you should be able to fire up the application
on localhost and test your swagger page.


* `mvn spring-boot:run` in first window
* `cd frontend; npm start` in the second window 

In the second window, as a reminder, you may need to first type <tt>nvm use <i>version-number</i></tt> and <tt>npm install</tt>, depending on how your dev environment is set up.

If you have compilation errors, review the steps above.  If not, then look for the Swagger page.

Note that the page may be at either of these links; you may need to try both to get things to work properly.

* `http://localhost:8080/swagger-ui`
* `http://localhost:8080/swagger-ui/index.html`

Note also that many swagger endpoints require authentication, which is why we include a link to the
home page on our swagger header, and we suggest firing up the frontend (where you can authenticate
with OAuth prior to trying any given swagger endpoint.)

