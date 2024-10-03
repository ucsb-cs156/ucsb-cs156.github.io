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

These instructions assume you have already followed the instructions 
on the [Getting Started](https://ucsb-cs156.github.io/topics/dokku/getting_started.html) page, and have also:

* Configured your app with any necessary [Environment Variables](/topics/dokku/environment_variables.html) (e.g. `GOOGLE_CLIENT_ID` and/or `GOOGLE_CLIENT_SECRET` for OAuth)
* Configured your [Postgres Database](/topics/dokku/postgres_database.html) if your app requires one.

## Deploying an app (public repo)

Once you've set up any environment variables and/or databases that you need, here's how you get
your app deployed.

This requires *only* an ssh shell on the Dokku machine.  You still need to login to csil, then dokku, but you do *not* have to do anything at the command line on csil.

1. `ssh username@csil.cs.ucsb.edu` then to your dokku machine (e.g. `ssh dokku-01.cs.ucsb.edu`) substituting your dokku number in place of `01`.

2. To create your app, use the command:

   ```
   dokku apps:create jpa01-yourGithubId
   ```

   For example:
   
   ```
   dokku apps:create jpa01-cgaucho
   ```

   If your github id has uppercase letters or other symbols are are not legal in a dokku app name, just modify it slightly so that it
   conforms to the rules.

2. To set the git branch that your dokku app will deploy on its next build, do this, using the https link for your repo. (Note that this only works
   for public repos; for private repos, there is a slightly different procedure documented below.)
   
   ```
   dokku git:sync your-app-name https://github.com/ucsb-cs156-m23/your-repo-name.git branch-to-deploy
   ```

   For example:
   ```
   dokku git:sync jpa01-cgaucho https://github.com/ucsb-cs156-m23/jpa02-cgaucho.git main
   ```

   OR

   ```
   dokku git:sync team03-qa https://github.com/ucsb-cs156-s23/team03-s23-7pm-4.git KT-add-hotels
   ```

   This doesn't deploy the app, but it does set things up so that the command below will deploy from
   the specified repo and this branch.

4. Then, to deploy, use `dokku ps:rebuild app-name`
   
   For example:
   ```
   dokku ps:rebuild jpa01-cgaucho
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
    -----> Building jpa02-cgaucho from Dockerfile
    remote: build context to Docker daemon  39.42kB
    Step 1/26 : FROM bellsoft/liberica-openjdk-alpine:17.0.2
    
    ... *** MANY LINES OF OUTPUT OMITTED ***
    
    =====> Application deployed:
       http://jpa01-cgaucho.dokku-07.cs.ucsb.edu
   
    To dokku.engr.ucsb.edu:jpa02-cgaucho
     * [new branch]      main -> main
    [pconrad@csilvm-07 jpa01-pconrad]$ 
   ```
5. Now you should be able to open the app on the URL shown, e.g. <http://jpa01-cgaucho.dokku-07.cs.ucsb.edu>

## Enabling https for your app

In order to use Google OAuth in production mode, we need to enable https for our apps; here's how:

The commands below show <tt><b><i>app-name</i></b></tt> as the name of your app; be sure to
substitute in <tt><b><i>jpa03-cgaucho</i></b></tt>, for example.

On your assigned dokku machine, at the prompt, type these two commands, substituting in your UCSB email in place of `cgaucho@ucsb.edu`

*  <tt>dokku letsencrypt:set <b><i>app-name</i></b> email <b><i>cgaucho@ucsb.edu</i></b></tt>
*  <tt>dokku letsencrypt:enable <b><i>app-name</i></b></tt>

Then, in order for the certificate to be used, you must rebuild your app. So, we again use:

```
dokku ps:rebuild jpa01-cgaucho
```

You should now be able to open the app at either of the urls shown, e.g. <http://jpa01-cgaucho.dokku-07.cs.ucsb.edu> or <https://jpa01-cgaucho.dokku-07.cs.ucsb.edu>


