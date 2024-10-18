---
parent: Dokku
grand_parent: Topics
layout: default
title: "Getting Started"
description:  "How to deploy a Hello World Spring Boot app to Dokku"
nav_order: 2
---

# {{page.title}} - {{page.description}}

This describes how to get deploy a "Hello World" type Spring Boot app such as <https://github.com/ucsb-cs156-s23/STARTER-jpa02> on the Dokku platform
provided by UCSB ECI.


## Preliminaries

You will need:
* A CSIL account, with an public/private ssh key pair set up (explained below)
* To be assigned to a team such as `m23-9am-3`

## Which server?

The first two steps are to
* determine which of the dokku servers you are assigned to (`dokku-01.cs.ucsb.edu`, `dokku-02.cs.ucsb.edu`, etc.)
* log in to the unix command line on that server

This page explains how:
* [Dokku: Logging In](/topics/dokku/logging_in.html)

## The `dokku` command

Most functions of Dokku will be accessed via the `dokku` command.  You can see a complete list of dokku commands by typing `dokku --help`, like this (the output has been shortened):

```
pconrad@dokku:~$ dokku --help
Usage: dokku [--quiet|--trace|--force] COMMAND <app> [command-specific-options]

Primary help options, type "dokku COMMAND:help" for more details, or dokku help --all to see all commands.

Commands:

    app-json                 Manage app-json settings for an app
    apps                     Manage apps
    builder                  Manage builder settings for an app
    builder-dockerfile       Manage the dockerfile builder integration for an app
    builder-lambda           Manage the lambda builder integration for an app
    ... [**** MANY LINES OF OUTPUT OMITTED ****]
    url                      Show the first URL for an application (compatibility)
    urls                     Show all URLs for an application
    version                  Print dokku's version

Community plugin commands:

    letsencrypt   Manage the letsencrypt integration
    postgres      Plugin for managing Postgres services
pconrad@dokku:~$ 
```

Make sure you can access the `dokku` command by trying `dokku --help`

## Creating a new app

To create a new app called `jpa02-cgaucho`, type:

That will look like this:

```
pconrad@dokku:~$ dokku apps:create jpa02-cgaucho
-----> Creating jpa02-cgaucho...
-----> Creating new app virtual host file...
pconrad@dokku:~$ 
```

Once you've created a new app, you should be able to see it by typing `dokku apps:list`, like this:

```
pconrad@dokku:~$ dokku apps:list
=====> My Apps
christian-frontend
christian-try-dokku
jpa02-cgaucho
julia-try-dokku
my-new-app
pconrad-jpa02
pconrad-jpa03
pconrad-try-dokku
rn-ruby-getting-started
ziv-try-dokku
pconrad@dokku:~$ 
```


## Before deploying your app

If you are deploying a simple "Hello World" app, you may be able to skip this section.  

If the instructions for your app indicate that you need to configure any of the following,
you'll need to do that first, or your app may not deploy properly:

* Environment Variables (e.g. `GOOGLE_CLIENT_ID` and/or `GOOGLE_CLIENT_SECRET` for OAuth)
  - To configure these, see: [Environment Variables](/topics/dokku/environment_variables.html)
* Postgres Database
  - To configure the database, see: [Postgres Database](/topics/dokku/postgres_database.html)

## Deploying an app 

Now you are ready to follow the instructions here to deploy your app:

* [Deploying an App](https://ucsb-cs156.github.io/topics/dokku/deploying_an_app.html)

## Setting up https for your app

In order to use Google OAuth in production mode, we need to enable https for our apps

Note that you cannot set up `https` until your app is first up and running with at least a home page on plain old `http`; the commands below will *fail* if you try.

So get the app up and running an `http` link first. Then, use these commands:

The commands below show <tt><b><i>app-name</i></b></tt> as the name of your app; be sure to
substitute in <tt><b><i>jpa03-cgaucho</i></b></tt>, for example.

On your assigned dokku machine, at the prompt, type these two commands, substituting in your UCSB email in place of `cgaucho@ucsb.edu`

*  <tt>dokku letsencrypt:set <b><i>app-name</i></b> email <b><i>cgaucho@ucsb.edu</i></b></tt>
*  <tt>dokku letsencrypt:enable <b><i>app-name</i></b></tt>

## Changing your shell to bash

If you find that command line editing (e.g. the up-arrow, etc.) isn't working, it's probably because your default shell is `/bin/sh` instead of `/bin/bash`. Here's how to change it:

```
$ chsh
Password: 
Changing the login shell for pconrad
Enter the new value, or press ENTER for the default
	Login Shell [/bin/sh]: /bin/bash
$ 
```

Then logout and log back in again.
