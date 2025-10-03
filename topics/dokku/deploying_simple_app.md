---
parent: Dokku
grand_parent: Topics
layout: default
title: "Deploying a Simple App"
description:  "How to deploy a Hello World Spring Boot app to Dokku"
nav_order: 1
---

# {{page.title}} - {{page.description}}

These instructions are for a simple app that:

* Requires no environment variables
* Does not need a database
* Does not use OAuth

## Deploying an app (public repo)


1. `ssh username@csil.cs.ucsb.edu` then to your dokku machine (e.g. `ssh dokku-01.cs.ucsb.edu`) substituting your dokku number in place of `01`.

2. To create an app with the name `app-name`, use the command `dokku apps:create app-name`.

   For example, if your app name is `jpa01-cgaucho`, use the command:

   ```
   dokku apps:create jpa01-cgaucho
   ```

   If your github id has uppercase letters or other symbols are are not legal in a dokku app name, just modify it slightly so that it
   conforms to the rules.  You won't lose points as long as we can reasonably figure out which app is yours.

2. To set the git branch that your dokku app will deploy on its next build, do this, using the https link for your repo. (Note that this only works
   for public repos; for private repos, there is a slightly different procedure documented below.)
   
   ```
   dokku git:sync your-app-name https://github.com/ucsb-cs156-f25/your-repo-name.git branch-to-deploy
   ```

   For example:
   ```
   dokku git:sync jpa01-cgaucho https://github.com/ucsb-cs156-f25/jpa02-cgaucho.git main
   ```

   This doesn't deploy the app, but it does set things up so that the command below will deploy from
   the specified repo and this branch.

   If you get the following error, check that the repo is public and not private.  (It is possible to deploy private repos to dokku, but you have to use a [different process](https://ucsb-cs156.github.io/topics/dokku/deploy_app_from_private_repo.html)
   ```
   Fatal: could not read Username for 'https://github.com': terminal prompts disabled
   ```


4. Then, to deploy, use `dokku ps:rebuild app-name`
   
   For example:
   ```
   dokku ps:rebuild jpa02-cgaucho
   ```
   You should see then see the output from the deployment of the branch that looks something like this:
   
  
   ```
    Enumerating objects: 1578, done.
    Counting objects: 100% (1578/1578), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (465/465), done.
    Writing objects: 100% (1578/1578), 699.17 KiB | 139.83 MiB/s, done.
    Total 1578 (delta 995), reused 1578 (delta 995), pack-reused 0
    remote: Resolving deltas: 100% (995/995), done.
    -----> Set main to DOKKU_DEPLOY_BRANCH.
    -----> Cleaning up...
    -----> Building jpa01-cgaucho from Dockerfile
    remote: build context to Docker daemon  39.42kB
    Step 1/26 : FROM bellsoft/liberica-openjdk-alpine:21
    
    ... *** MANY LINES OF OUTPUT OMITTED ***
    
    =====> Application deployed:
       http://jpa01-cgaucho.dokku-07.cs.ucsb.edu

    [pconrad@csilvm-07 jpa01-cgaucho]$ 
   ```
5. Now you should be able to open the app on the URL shown, e.g. <http://jpa02-cgaucho.dokku-07.cs.ucsb.edu>

   Note that at this point, the app is running over `http` only.

6. To add `https` support, type these commands, substituting your email in place of `cgaucho@ucsb.edu` and your app name in place of `app-name`

    ```
    dokku letsencrypt:set app-name email cgaucho@ucsb.edu
    dokku letsencrypt:enable app-name
    ```
    
