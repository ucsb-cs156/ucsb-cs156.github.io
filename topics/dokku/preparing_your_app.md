---
parent: Dokku
grand_parent: Topics
layout: default
title: "Preparing Your App"
description:  "Converting an existing Spring Boot app to use Dokku"
---

# {{page.title} - {{page.description}}

Here are things that must be true about your app in order to deploy it on [UCSB ECI's](https://eci.ucsb.edu/) implementation of Dokku:

## Define `spring.port` in `application.properties`

In the file `src/main/resources/application.properties` you will need this line:

```
server.port=${PORT:8080}
```

This line says: if the variable `PORT` is defined, use that value; otherwise use `8080`.  This is necessary because in the Dokku environment, the server runs on port
assigned by the environment variable `PORT`, and then that server is proxied through Nginx and exposed on the internet on port 80.

Failing to set this up is one of the reasons you might end up with the following screen:

<img width="653" alt="image" src="https://user-images.githubusercontent.com/1119017/235317133-a97450a8-cab0-4ed2-ae0b-351fae0a4e15.png">

Seeing that the server is running on port `8080` in your Dokku log can be another indication that this wasn't done properly.

## Define `PRODUCTION=true`

You will need to do this command at the command line on your assigned `dokku-nn.cs.ucsb.edu` server:


<tt>dokku config:set <b><i>app-name-here</i></b> PRODUCTION=true</tt>


Where <tt><b><i>app-name-here</i></b></tt> is the name of the application that shows up when you do `dokku apps:list` (e.g. `jpa03-cgaucho` or `team02-prod`).

If you don't, you'll get something like this:

```
Failed to connect to the frontend server...
On Dokku, be sure that PRODUCTION=true is defined
```
