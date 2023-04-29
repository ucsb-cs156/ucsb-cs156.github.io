---
parent: Dokku
grand_parent: Topics
layout: default
title: "Getting Started"
description:  "How to deploy a Hello World Spring Boot app to Dokku"
ssh_key_form: https://docs.google.com/forms/d/e/1FAIpQLSemcZiZ7B8v5zxlWmaWw-YRkr4dip_t6qgpinYoo9xchw_IOg/viewform
nav_order: 1
---

# {{page.title}} - {{page.description}}

This describes how to get deploy a "Hello World" type Spring Boot app such as <https://github.com/ucsb-cs156-s23/STARTER-jpa02> on the Dokku platform
provided by UCSB ECI.


## Preliminaries

You will need:
* A CSIL account, with an public/private ssh key pair set up (explained below)
* To be assigned to a team such as `s23-5pm-3`
* To have had your ssh key associated with one or more of the thirteen Dokku servers (explained below)

First, you need an ssh key in your CSIL account. If you have one, you'll have these files in your CSIL account:
* `~/.ssh/id_rsa.pub` (public key; may be freely shared with anyone)
* `~/.ssh/id_rsa` (private key; *never* share with anyone)

If these files don't exist in your account, you can run `ssh-keygen` at the CSIL shell prompt; just hit enter to accept all defaults.  After running the `ssh-keygen` command,
if you use the defaults, those files should then exist.

Second, you'll need to have provided your ssh *public* key (i.e. the contents of `~/.ssh/id_rsa.pub`) to whomever is setting up the access to the Dokku
servers; currently this is a manual process done by ECI staff directly.   Instructors may like to collect these using a [form similar to this one]({{page.ssh_key_form}})
and then provide the list of keys as a spreadsheet to ECI staff.

Finally, you'll need to know which Dokku server you were given access to.  There will typically be a mapping from your team name to your Dokku instance such
as the one below.  Staff have access to the `dokku-00.cs.ucsb.edu` instance, and all other servers.  Students typically have access to only one server, namely 
the one for their team.

Here is an example mapping of teams to Dokku servers from S23:

| Host | Team | 
|------|------|
| `dokku-00.cs.ucsb.edu` | Course staff |
| `dokku-01.cs.ucsb.edu` | s23-5pm-1 |
| `dokku-02.cs.ucsb.edu` | s23-5pm-2 |
| `dokku-03.cs.ucsb.edu` | s23-5pm-3 |
| `dokku-04.cs.ucsb.edu` | s23-5pm-4 |
| `dokku-05.cs.ucsb.edu` | s23-6pm-1 |
| `dokku-06.cs.ucsb.edu` | s23-6pm-2 |
| `dokku-07.cs.ucsb.edu` | s23-6pm-3 |
| `dokku-08.cs.ucsb.edu` | s23-6pm-4 |
| `dokku-09.cs.ucsb.edu` | s23-7pm-1 |
| `dokku-10.cs.ucsb.edu` | s23-7pm-2 |
| `dokku-11.cs.ucsb.edu` | s23-7pm-3 |
| `dokku-12.cs.ucsb.edu` | s23-7pm-4 |

## Logging into the Dokku instance

To login, first login to your CSIL account.

Then use, for example, `ssh username@dokku-xx.cs.ucsb.edu` where `xx` is replaced by `00` through `12`.

You should get access to a shell prompt on the Dokku server.

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

## Deploying an app 

To link your app to a GitHub repo, **you actually need two terminal windows**
* one on the **Dokku Server**
* another on **`csil.cs.ucsb.edu`**

1. In the ordinary **csil** window, create a directory where you can clone your repo.
2. Clone your repo there.  
   - For instance, suppose we want to deploy the repo <https://github.com/ucsb-cs156-s23/jpa02-pconrad>.  
   - We start by cloning this repo at the shell prompt on CSIL and cd'ing into this directory.  For example:

     ```
     [pconrad@csilvm-07 ucsb-cs156-s23]$ pwd
     /cs/faculty/pconrad/github/ucsb-cs156-s23
     [pconrad@csilvm-07 ucsb-cs156-s23]$ git clone https://github.com/ucsb-cs156-s23/jpa02-pconrad
     Cloning into 'jpa02-pconrad'...
     remote: Enumerating objects: 1578, done.
     remote: Counting objects: 100% (1578/1578), done.
     remote: Compressing objects: 100% (471/471), done.
     remote: Total 1578 (delta 995), reused 1572 (delta 989), pack-reused 0
     Receiving objects: 100% (1578/1578), 699.17 KiB | 2.17 MiB/s, done.
     Resolving deltas: 100% (995/995), done.
     [pconrad@csilvm-07 ucsb-cs156-s23]$ cd jpa02-pconrad/
     [pconrad@csilvm-07 jpa02-pconrad]$ pwd
     /cs/faculty/pconrad/github/ucsb-cs156-s23/jpa02-pconrad
     [pconrad@csilvm-07 jpa02-pconrad]$ 
     ```
 3. Now add a remote for `dokku`. The remote url will be formed as follows:

    <tt>dokku@dokku-<b><i>xx</i></b>.cs.ucsb.edu:<b></i>app-name</i></b></tt>

    Note that:
    * The part at the beginning, <tt>dokku@dokku-</tt>, should be literally that, always
    * The <tt><b><i>xx</i></b></tt> part should be one of <tt>00</tt> through <tt>12</tt>, i.e. the number for the Dokku server you are using.
    * The <tt><b><i>app-name</i></b></tt> part should be the name of the app you created with `dokku apps:create app-name`; this may or may not
      be the same as your repo name.
  
    For example, if you are running on `dokku-07.cs.ucsb.edu` and your  app is `jpa02-cgaucho`, you'll create a remote for dokku with:

    ```
    git remote add dokku dokku@dokku-07.cs.ucsb.edu:jpa02-cgaucho
    ```

    Then, any time you want to deploy the app, you simply do:

    ```
    git push dokku main
    ```

    The first time you do this, you might get this output; if so, type `yes` and hit enter, and you'll never get that question again.

    ```
    pconrad@dokku:~/jpa02-pconrad$ git push dokku main
    The authenticity of host 'dokku.engr.ucsb.edu (128.111.27.65)' can't be established.
    ECDSA key fingerprint is SHA256:vFS3l4zh+M2oVksNJFwo5/vQTQBHll3l9Lf5ecm8b3o.
    Are you sure you want to continue connecting (yes/no)? yes
    ```

    That should start the deploy as shown here:
    ```
    [pconrad@csilvm-07 jpa02-pconrad]$ git push dokku main
    Enumerating objects: 1578, done.
    Counting objects: 100% (1578/1578), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (465/465), done.
    Writing objects: 100% (1578/1578), 699.17 KiB | 139.83 MiB/s, done.
    Total 1578 (delta 995), reused 1578 (delta 995), pack-reused 0
    remote: Resolving deltas: 100% (995/995), done.
    -----> Set main to DOKKU_DEPLOY_BRANCH.
    -----> Cleaning up...
    -----> Building jpa02-cgaucho from Dockerfile
    remote: build context to Docker daemon  39.42kB
    Step 1/26 : FROM bellsoft/liberica-openjdk-alpine:17.0.2
    
    ... *** MANY LINES OF OUTPUT OMITTED ***
    
    =====> Application deployed:
       http://jpa02-cgaucho.dokku-07.cs.ucsb.edu

    To dokku.engr.ucsb.edu:jpa02-cgaucho
     * [new branch]      main -> main
    [pconrad@csilvm-07 jpa02-pconrad]$ 
    ```
 4. Now you should be able to open the app on the URL shown, e.g. <http://jpa02-cgaucho.dokku-07.cs.ucsb.edu>

For a simple `Hello World` type Spring Boot app, this should be sufficient to get started.

Refer to the main Dokku help page for apps that have more complex requirements, such as:
* Setting up a [Postgres Database](/topics/dokku/postgres_database.html)
* Setting up [Environment Variables](/topics/dokku/environment_variables.html)


