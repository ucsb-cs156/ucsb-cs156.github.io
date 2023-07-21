---
parent: Dokku
grand_parent: Topics
layout: default
title: "Deploying an App"
description:  "How to deploy a Hello World Spring Boot app to Dokku"
ssh_key_form: https://docs.google.com/forms/d/e/1FAIpQLSemcZiZ7B8v5zxlWmaWw-YRkr4dip_t6qgpinYoo9xchw_IOg/viewform
nav_order: 1
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
   dokku apps:create jpa02-yourGithubId
   ```

   For example:
   
   ```
   dokku apps:create jpa02-cgaucho
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
   dokku git:sync jpa02-cgaucho https://github.com/ucsb-cs156-m23/jpa02-cgaucho.git main
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
5. Now you should be able to open the app on the URL shown, e.g. <http://jpa02-cgaucho.dokku-07.cs.ucsb.edu>

# Deploying an app from a private repo

To deploy an app from a private repo, first, create the app the same way as described above for public repos, i.e. 
`dokku apps:create my-app-name`.

All of the other steps including https, database setup, config variables, etc. are the same; the only difference is that
instead of using `dokku git:sync app-name ...` and `dokku ps:rebuild app-name`, we use a git remote as explained below.

### Deploying Private Repo: One time set up steps

1. Clone your repo on either:
   * csil.cs.ucsb.edu, or
   * your dokku machine.

   Note that these are equivalent, since they both use the same home directories, and the same logins.

   Also note that you *do not have to do your localhost development* on CSIL/dokku, and you probably shouldn't try (the disk quota, file quota, and     file descriptor limits don't play nicely with Spring Boot and React).   But you do have to have *cloned* the repo on CSIL/dokku.

2. `cd` into the directory where you cloned your repo.
3.  Add a remote for dokku, like this, where <tt><b><i>xx</i></b></tt> is replaced with the number of your dokku machine, and
    <tt><b><i>my-app-name</i></b></tt> is replaced with your app name.

    <p><tt>git remote add dokku dokku@dokku-<b><i>xx</i></b>.cs.ucsb.edu:<b><i>my-app-name</i></b></tt></p> 

### Deploying Private Repo: Each time you deploy

1. Make sure the branch you want to deploy is up-to-date on Github.  Typically, you'll be working on your own machine (i.e. not on CSIL), and
   you'll push from there to github:

   ```
   git push origin branch-name
   ```

2. Login to CSIL or dokku, and `cd` into the directory where you cloned your repo
3. Update the local branch pointers by typing:
   ```
   git fetch
   ```

   This makes sure that the local pointers to all of the branches in your CSIL/dokku clone of the repo are up-to-date with Github.
4. Pull the latest copy of your branch (substitute your branch name in place of `branch-name`):
   ```
   git pull origin branch-name
   ```

5. Push the branch to dokku, (substitute your branch name in place of `branch-name`, but `main` should literally be `main`):
   ```
   git push dokku branch-name:main
   ```

   For example:
   ```
   git push dokku brian-newCustomerForm:main
   ```

   The syntax `branch-name:main` means: find `branch-name` in the local repo, and push it to `main` on the remote repo (i.e. in this case,
   the repo on the dokku server).

   You should see the output from the deploy start to echo at the command line.  Do not close this terminal session, or the deploy
   may not complete.  If there is an error, you'll see it; otherwise, the output should end with something like:

   ```
   App my-app-name deployed to https://my-app-name.dokku-13.cs.ucsb.edu
   ```

