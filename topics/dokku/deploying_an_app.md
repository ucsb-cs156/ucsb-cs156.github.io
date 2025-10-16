---
parent: Dokku
grand_parent: Topics
layout: default
title: "Deploying an App"
description:  "How to deploy a Hello World Spring Boot app to Dokku"
ssh_key_form: https://docs.google.com/forms/d/e/1FAIpQLSemcZiZ7B8v5zxlWmaWw-YRkr4dip_t6qgpinYoo9xchw_IOg/viewform
nav_order: 2
---

# {{page.title}} - {{page.description}}

## Is your app a simple app?

For very simple apps (no frontend, no database, no OAuth logins), use these simplified instructions instead: 
<https://ucsb-cs156.github.io/topics/dokku/deploying_simple_app.html>

This version of the instructions is for apps where any of the following is true:
* The app has a frontend
* The app requires a database
* The app requires OAuth logins

## Overview

Here's an overview of the steps involved

1. Login to your dokku machine
2. Create the app
3. Define Environment Variables
4. Define Settings
5. Create and Link Postgres Database
6. Sync with Github Repo
7. Build App with http
8. Enable https
9. Test OAuth

We'll now cover each of these one at a time.

## Step 1: Log in to your dokku machine

See: <https://ucsb-cs156.github.io/topics/dokku/logging_in.html> for details.

## Step 2: Create the app (`dokku apps:create ...`)

Create the app with this command

<p><tt>dokku apps:create <i>appname</i></tt></p>

where <tt><i>appname</i></tt> is typically something like one of the following:
* <tt><i>jpa03-cgaucho</i></tt>
* <tt><i>courses-qa</i></tt>
* <tt><i>happycows-dev-cgaucho</i></tt>

We'll use <tt><i>appname</i></tt> throughout the rest of these instructions without further explanation.

## Step 3: Define Environment Variables (`dokku config:set ...`)

Each Spring Boot app that we cover in this course will have specific requirements for environment variables and settings, so you'll need to consult the specific documentation for the app to determine which settings are needed.

But you'll typically *always* need to define `PRODUCTION=true` as follows:

<p><tt>dokku config:set --no-restart <i>appname</i> PRODUCTION=true</tt></p>

This command enables the frontend code to be served from the same server that serves the backend; when running on `localhost`, these are separate, but on dokku these are integrated into a single server.

In addition, there will be specific environment variables for such things as the following.  The precise list will depend on your application, but typically include at least the following:

* `GOOGLE_CLIENT_ID`
* `GOOGLE_CLIENT_SECRET`
* `ADMIN_EMAILS`
* `SOURCE_REPO`  (set this to the repo from which you are pulling the source code)

For `proj-courses` and `proj-dining`, you'll also need a value for [`UCSB_API_KEY`](https://ucsb-cs156.github.io/topics/apis/apis_ucsb_developer_api.html)

You'll find the values in your `.env` file, where you've typically configured these as part of setting up your application to run on `localhost`, which you typically do *before* setting it up to run on dokku.

For each of these values, copy the value into the command below:

<p><tt>dokku config:set <i>appname</i> --no-restart <i>VARIABLE_NAME</i>=<i>value</i></tt></p>

where:
* <tt><i>VARIABLE_NAME</i></tt> is the variable name from `.env`
* <tt><i>value</i></tt> is the value from `.env`

## Step 4: Define Settings (`dokku git:set ...`)

Some of the code bases we work with in this course are configured based on an assumption that
the `.git` directory is retained when `dokku` pulls it in to the Docker container where the app is deployed.

We configure it this way so that we can display the `git branch` information  in the running app.

For these apps, it is necessary to do the following one time setting:

<tt>dokku git:set <i>appname</i> keep-git-dir true</tt>

This setting indicates that the `.git` directory should be retained after the repo is cloned when setting up the app.    

This is done, in part, so that the `git-commit-id-maven-plugin` can be used to get information about the current git branch that is deployed.

## Step 5: Create and Link Postgres Database (`dokku postgres:create ...`)

Most apps in this course will use a Postgres Database.  

Postgres database configuration requires several steps, so we've factored it out into it's own page.

* [Postgres Database](/topics/dokku/postgres_database.html) 

Follow these steps before proceeding.

## Step 5a: (`proj-courses` only!) Create and Link MongoDB (`dokku mongo:create ...`)

Only one of the apps we use in this course requires a MongoDB database in addition to the postgres database, namely `proj-courses`.

If you are not working with `proj-courses`, just move on to the next step.

Otherwise, follow the steps here to configure your app for MongoDB:

* <https://github.com/ucsb-cs156/proj-courses/blob/main/docs/mongodb.md>

## Step 6: Sync with Github Repo (`dokku git:sync...`)

Next, sync with your github repo, like this:

<tt>dokku git:sync <i>appName</i> https://github.com/<i>owner</i>/<i>repo</i>.git main</tt>

Where:
* <tt>https://github.com/<i>owner</i>/<i>repo</i>.git</tt> is the `https` link to your repo, which should be public.(

Note: For private repos see [these instructions](https://ucsb-cs156.github.io/topics/dokku/deploy_app_from_private_repo.html)).

## Step 7: Build App with http (`dokku ps:rebuild ...`)

Next, to build your app the first time with `http`, type:

<tt>dokku ps:rebuild <i>appname</i></tt>

Note that:
* you *will not be able to login with OAuth* when the app is served only with `http`
* however, *you cannot configure the app for `https` until it first is running with `http`

So we have to enable it with http first.

## Step 8: Enable https (`dokku letsencrypt...`)

Now enable https with these commands:

<tt>dokku letsencrypt:set <i>appname</i> email <i>yourEmail</i>@ucsb.edu</tt><br />
<tt>dokku letsencrypt:enable <i>appname</i></tt>


## Step 9: Test OAuth

You should now be able to login to your app using https, so test that you can login with OAuth.

Try logging in at:

<tt>https://<i>appname</i>.dokku-<i>xx</i>.cs.ucsb.edu</tt>

where <tt><i>xx</i></tt> is your dokku number.



## A short cut

There is a shortcut for the `dokku config:set` rather than setting the values one at a time.
  
The idea of this step is to copy/paste the values
from from your `.env` file into a file in your Dokku account
and then load the values all at once.

You could use file transfer, but because of various firewall settings, it may be easier to just copy/paste like this:

1. On the system where you are doing development, 
   use `cat .env` to list out the contents, e.g.

   ```
   pconrad@Phillips-MacBook-Air STARTER-jpa03 % cat .env
   GOOGLE_CLIENT_ID=26622685272-ofq4729s9nt8loednuuv5c0opja1vaeb.apps.googleusercontent.com
   GOOGLE_CLIENT_SECRET=GOCSPX-fakeCredentials99_fakefake-_fake
   ADMIN_EMAILS=phtcon@ucsb.edu
   pconrad@Phillips-MacBook-Air STARTER-jpa03 % 
   ```

2. At the shell prompt on your dokku server (e.g. dokku-07.cs.ucsb.edu), type this, where `jpa03-cgaucho` is the name of your
app:

   ```
   cat > jpa03-gaucho.env
   ```

   Then, copy paste the contents of the `.env` file into the window, followed by hitting enter, and then Control-D.

   If you then do an `ls` you should see that you have
   a file called `jpa03-gaucho.env` containing the values
   you want to set.

3. Now type the following (assuming that `jpa03-cgaucho` is
   your Dokku app name).

   ```
   dokku config:set --no-restart jpa03-cgaucho `cat jpa03-gaucho.env`
   ```

   In this command, the part in backticks (<tt>\`cat jpa03-gaucho.env\`</tt>) specfies that the output of that command should be placed on the command line.

   Accordingly, this sets all of the environment variables at once.

   Note that on Dokku, you also typically need to set this
   value (this typically does *not* go in your .env)

   <tt>dokku config:set --no-restart <b></i>app-name</i></b> PRODUCTION=true</tt>
   
