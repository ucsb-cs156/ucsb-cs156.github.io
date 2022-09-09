---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: Wrapper"
description:  "The mvnw file that you see in some repos: what is it, and why do you need it"
category_prefix: "Maven: "
indent: true
---

In some repos that use Maven, you'll find a file called `mvnw` that appears to be a shell script.  Sometimes there is even an `mvnw.bat`, that appears
to be a Windows/DOS old-school `.bat` file designed to run on Windows.  It may be entirely unclear why this is there, or why you'd need it.

This article is here to clear up that mystery.

# What is `mvnw`

The `mvnw` file is a "Maven Wrapper".  Simply put, it allows you to use Maven on systems where Maven has not been installed.

Maven is:
* installed on CSIL
* easily installable on Mac, Windows, Linux

You might therefore conclude that you don't need the `mvnw` file.  And often that's true.  There is at least 
one circumstance, however, where we've found it to be vital.

#  Using `mvnw` on Heroku with Flyway Database migrations

On Heroku, there are various *phases* of bringing up an application, for example:

* build: it runs the compile commands for your stack (e.g. `mvn compile`) 
  and collect all of your dependencies and executables into what Heroku calls a *slug*
* release: usually, if you don't specify any actions in this phase, nothing happens.  
  But if you have any actions in the release phase, the release is not made available until these actions succeed.
* startup: this is when Heroku actually starts up the application (for a web app, 
  this means starting up your server to listen for connections on a port.)

When running Flyway migrations, for reasons discussed elsewhere (e.g. in our documentation on Flyway), it is preferable to run these
migrations during the release phase.

That leads us back to `mvnw`.   The way in which we have chosen to setup Flyway migrations, we are using Maven commands.  However, 
the Maven that is built into Heroku is only available during the "build" phase.   Adding `mvnw` to a repo makes Maven also available during
the release phase.


# The wrapper downloader

The wrapper downloader (e.g. `.mvn/wrapper/MavenWrapperDownloader.java`) is a file that helps the `mvnw` command to work properly.  You can see an example in this pull request:

* <https://github.com/ucsb-cs56-w20/open-lab-scheduler/pull/155/files>

You may also need a file called `.mvn/wrapper/maven-wrapper.properties`.



