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

