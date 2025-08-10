---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: git-commit-id-maven-plugin"
description:  "Inject information about the current commit into the Spring Boot backend"
---

# {{page.title}} - {{page.description}}

We use the []() to inject information about the latest commit into the backend.

## Documentation

* Repo: <https://github.com/git-commit-id/git-commit-id-maven-plugin>

## What you need in your code to get this to work on localhost

### Step 1: Add `git-commit-id-maven-plugin` to `pom.xml`

First, you need code like this in your `pom.xml`.  Note that you may want to consult
[the project repo](https://github.com/git-commit-id/git-commit-id-maven-plugin) to make sure
you are using the latest version instead of what is listed below:

```xml
      <plugin>
        <groupId>io.github.git-commit-id</groupId>
        <artifactId>git-commit-id-maven-plugin</artifactId>
        <version>8.0.2</version>
        <executions>
          <execution>
            <id>get-the-git-infos</id>
            <goals>
              <goal>revision</goal>
            </goals>
            <phase>initialize</phase>
          </execution>
        </executions>
        <configuration>
          <generateGitPropertiesFile>true</generateGitPropertiesFile>
          <generateGitPropertiesFilename>${project.build.outputDirectory}/git.properties</generateGitPropertiesFilename>
          <commitIdGenerationMode>full</commitIdGenerationMode>
        </configuration>
      </plugin>
```

## Additional steps so it works on dokku as well:

### Step 1: Configure dokku app to save git directory

Configure your dokku app like this.  Note that this plug is the only reason we need to do this:

```
dokku git:set appname keep-git-dir true
```

### Step 2: Make sure that Dockerfile is configured to copy entire git directory 

Copy the `.git` directory that was saved into the Docker container so that the .git repository is
available when the app is being built and run.   This is true on `localhost` by default, but isn't
the default configuration for dokku; we have to do these extra steps to make that work:

```
COPY . /home/app
```
