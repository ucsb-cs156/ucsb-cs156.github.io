---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: Profiles"
description:  "Making your pom.xml do different things on localhost vs heroku, for example"
indent: true
---

Sometimes you want your pom.xml to do different things on `localhost` vs. when running on heroku.

Maven profiles, along with the Spring Boot `*.properties` files are one way to acheive this.

The code below, when added to a Maven `pom.xml` creates two different profiles called `localhost` and `heroku`:

Note that:
*  You can put a `localhost.properties` file in `src/main/config/localhost` that will override the shared properties in `application.properties`, and
   a `heroku.properties` in the `src/main/config/heroku` directory.
*  You can specify different dependencies, e.g. to use the H2 database on localhost, but postgres on heroku.
*  You can put a `data.sql` file in `src/main/resources`, but use these settings to control when it does and
   does not get loaded:
   * In `localhost.properties`: `spring.datasource.initialization-mode=always`
   * In `heroku.properties`: `spring.datasource.initialization-mode=never`

However, Maven profiles have limitations: As the jar is usually packaged and run separately at runtime, the profile will behave however it is configured at packaging/build time rather than runtime, when the jar is already fully built. 

Notably, multiple profiles can be active at once--this does come with some additional complications: once a property is set for a Maven lifecycle stage, it cannot change. This can lead to odd resolutions if multiple maven profiles overlap. 

Additionally, Maven profiles differ from Spring profiles in that Maven profiles instruct Maven how to behave, and can have the same or differing names from Spring profiles. A Maven profile can be used to set a Spring profile.

```xml
   <profiles>
        <profile>
            <id>localhost</id>
            <build>
                <resources>
                    <resource>
                        <directory>src/main/resources</directory>
                    </resource>
                    <resource>
                        <directory>src/main/config/localhost</directory>
                    </resource>
                </resources>
            </build>
            <dependencies>
                <dependency>
                    <groupId>com.h2database</groupId>
                    <artifactId>h2</artifactId>
                    <scope>runtime</scope>
                 </dependency>
            </dependencies>
        </profile>
        <profile>
            <id>heroku</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <build>
                <resources>
                    <resource>
                        <directory>src/main/resources</directory>
                    </resource>
                    <resource>
                        <directory>src/main/config/heroku</directory>
                    </resource>
                </resources>

            </build>
            <dependencies>
                <dependency>
                    <groupId>org.postgresql</groupId>
                    <artifactId>postgresql</artifactId>
                </dependency>

                <dependency>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-jdbc</artifactId>
                </dependency>
            </dependencies>
        </profile>
    </profiles>
```    

# How can I tell which profile(s) is/are active?

This command tells you which profile(s) are active:

```
mvn help:active-profiles
```


# More on Profiles

Maven profiles have limitations: As the jar is usually packaged and run separately at runtime, the profile will behave however it is configured at packaging/build time rather than runtime, when the jar is already fully built. 

Notably, multiple profiles can be active at once--this does come with some additional complications: once a property is set for a Maven lifecycle stage, it cannot change. This can lead to odd resolutions if multiple maven profiles overlap. 

Additionally, Maven profiles differ from Spring profiles in that Maven profiles instruct Maven how to behave, and can have the same or differing names from Spring profiles. A Maven profile can be used to set a Spring profile.

* <https://devcenter.heroku.com/articles/using-a-custom-maven-settings-xml#defining-the-maven_settings_path-config-variable>
* <http://maven.apache.org/guides/introduction/introduction-to-profiles.html>
