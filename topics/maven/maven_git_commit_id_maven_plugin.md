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
* Baeldung Article: <https://www.baeldung.com/spring-git-information>

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

### Step 2: Add this to the file with your `main`

Every Spring Boot application has exactly one `main` class, the one that
contains a `public static void main(String[] args)` method.

Find that class, and include these imports:

```java
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.io.ClassPathResource;
```


And this method:
```java
  /** 
   *  See: https://www.baeldung.com/spring-git-information
   *  @return a propertySourcePlaceholderConfigurer for git.properties
   */
  @Bean
  public static PropertySourcesPlaceholderConfigurer placeholderConfigurer() {
    PropertySourcesPlaceholderConfigurer propsConfig = new PropertySourcesPlaceholderConfigurer();
    propsConfig.setLocation(new ClassPathResource("git.properties"));
    propsConfig.setIgnoreResourceNotFound(true);
    propsConfig.setIgnoreUnresolvablePlaceholders(true);
    return propsConfig;
  }
}
```

### Step 3: Pull the properties in your `SystemInfoService.java`:

In SystemInfoService.java, use this:

```
  @Value("${app.sourceRepo:https://github.com/ucsb-cs156/proj-courses}")
  private String sourceRepo;

  @Value("${git.commit.message.short:unknown}")
  private String commitMessage;

  @Value("${git.commit.id.abbrev:unknown}")
  private String commitId;

  public static String githubUrl(String repo, String commit) {
    return commit != null && repo != null ? repo + "/commit/" + commit : null;
  }
```

and then later, initialize the fields in the `SystemInfo` object:

```java
SystemInfo si = SystemInfo.builder()
        .springH2ConsoleEnabled(this.springH2ConsoleEnabled)
        .showSwaggerUILink(this.showSwaggerUILink)
        .oauthLogin(this.oauthLogin)
        .sourceRepo(this.sourceRepo)
        .commitMessage(this.commitMessage)
        .commitId(this.commitId)
        .githubUrl(githubUrl(this.sourceRepo, this.commitId))
        .build();
```


### Step 4: Be sure that the environment variable SOURCE_REPO is defined

Define a default for the source repo in `application.properties`, e.g.

```
app.sourceRepo=${SOURCE_REPO:${env.SOURCE_REPO:https://github.com/ucsb-cs156/proj-frontiers}}
```

Then, if needed, you can override it in your `.env` for a more specific source repo:

```
SOURCE_REPO=https://github.com/ucsb-cs156-f25/proj-frontiers-f25-17
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
