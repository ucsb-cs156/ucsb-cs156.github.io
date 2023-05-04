---
parent: Dokku
grand_parent: Topics
layout: default
title: "Environment Variables"
description:  "How to define environment variables"
---

# {{page.title}} - {{page.description}}

These instructions assume you are already familiar with the instructions on the [Getting Started](https://ucsb-cs156.github.io/topics/dokku/getting_started.html) page.

Suppose your app called `my-app` requires you to define an environment variable such as `PRODUCTION` and set it to the value `true`

To do this, we can use this command:

```
dokku config:set --no-restart my-app PRODUCTION=true
```

# Typical configuration

Our apps typically also require you to set the environment variables for OAuth, such as these. 
* Note that these are example values
* You need to change these commands to the values appropriate to your app.
* The `my-app` values is your application name
* The values for the variables are the same as those you used in your `.env` file on `localhost`

```
dokku config:set --no-restart my-app PRODUCTION=true
dokku config:set --no-restart my-app GOOGLE_CLIENT_ID=26622685272-ofq4729s9nt8loednuuv5c0opja1vaeb.apps.googleusercontent.com
dokku config:set --no-restart my-app GOOGLE_CLIENT_SECRET=GOCSPX-fakeCredentials99_fakefake-_fake
dokku config:set --no-restart my-app ADMIN_EMAILS=phtcon@ucsb.edu,cgaucho@ucsb.edu,avishekde@ucsb.edu,vivianross@ucsb.edu
```

Our apps also typically require some environment variables for postgres; see this article for details: [Postgres Database](/topics/dokku/postgres_database.html) 

# `PRODUCTION=true`

The code base that we use for most of the apps in CMPSC 156 requires that you set `PRODUCTION=true` when 
deploying on a service such as Dokku, Heroku or Render:

```
dokku config:set --no-restart my-app PRODUCTION=true
```

<details markdown="1">
<summary markdown="1">What does this do? (click triangle to find out)</summary>

What this does is to tell the `pom.xml` file that when building the app, it should also build an optimized version of the frontend code and bundle it together with the backend, to deliver it from one endpoint.

If this is not set, it tries to launch only the backend, expecting the frontend to be launched separately (as we do when running in development mode.)

</details>

# `ADMIN_EMAILS=phtcon.ucsb.edu,...`

The code base that we use for most of the apps in CMPSC 156 requires that you set the variable `ADMIN_EMAILS` to a
comma-separated list of emails that will be given admin privileges, e.g.

```
ADMIN_EMAILS=phtcon@ucsb.edu,cgaucho@ucsb.edu,ldelplaya@ucsb.edu
```

You set this like this:

```
dokku config:set --no-restart my-app ADMIN_EMAILS=phtcon@ucsb.edu,cgaucho@ucsb.edu,ldelplaya@ucsb.edu
```

Generally speaking, this list should contain your instructor's email, your mentor's email, and each member of your team, separated by commas (no spaces).

*Do not separate emails with spaces*; only commas:
* ❌ WRONG: `ADMIN_EMAILS=phtcon@ucsb.edu, cgaucho@ucsb.edu, ldelplaya@ucsb.edu`
* ✅ Correct: `ADMIN_EMAILS=phtcon@ucsb.edu,cgaucho@ucsb.edu,ldelplaya@ucsb.edu`

* Add your own UCSB email address
* Add `phtcon@ucsb.edu` (your instructor)
* Add the mentor for your team (look up the mentor's name on the course team listing, then ask them in your channel)
* Add everyone else on your team

I suggest that, as a team, you collaborate in your team slack channel on getting a standard list of these, and then
that you pin that post in your team slack channel for easy reference.

The `ADMIN_EMAILS` value is used to determine which users have access to administrative features in the app.  One of those
is the ability to list the users that have logged in.

# Listing the Environment variables

To list the environment variables for a given app, we can use 

```
dokku config:show my-app
```

Example (with sensitive info changed to avoid security leaks):

```
pconrad@dokku:~$ dokku config:show pconrad-jpa03
=====> pconrad-jpa03 env vars
DATABASE_URL:          postgres://postgres:a6cbThisPasswordIsFakeb@dokku-postgres-pconrad-jpa03-db:5432/pconrad_jpa03_db
DOKKU_APP_RESTORE:     1
DOKKU_APP_TYPE:        herokuish
DOKKU_PROXY_PORT:      80
DOKKU_PROXY_PORT_MAP:  http:80:5000
GIT_REV:               631f1ac48d19d9c39d28bb071fed1ec8fdee0aaf
GOOGLE_CLIENT_ID:      26622685272-ofq4729s9nt8loednuuv5c0opja1vaeb.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET:  GOCSPX-fakeCredentials99_fakefake-_fake
POSTGRES:              true
PRODUCTION:            true
pconrad@dokku:~$ 
```

