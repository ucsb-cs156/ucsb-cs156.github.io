---
parent: Dokku
grand_parent: Topics
layout: default
title: "Deploying an App from a private repo"
description:  "How to deploy a Hello World Spring Boot app to Dokku from a private repo"
nav_order: 3
---

# {{page.title}} - {{page.description}}

These instructions assume you have already followed the instructions 
on the [Getting Started](https://ucsb-cs156.github.io/topics/dokku/getting_started.html) page, and have also:

* Configured your app with any necessary [Environment Variables](/topics/dokku/environment_variables.html) (e.g. `GOOGLE_CLIENT_ID` and/or `GOOGLE_CLIENT_SECRET` for OAuth)
* Configured your [Postgres Database](/topics/dokku/postgres_database.html) if your app requires one.



# Important Note!

PLEASE NOTE: this will *not work* unless the instructor has set up your private keys to be able to push to dokku.

For CMPSC 156, we *typically do not do this*, since we only work with web apps that have open source (public) repos.

Please check with the instructor before proceeding to make sure this instructions are applicable to your use case.

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
   =====> Application deployed:
    http://jpa02-cgaucho.dokku-07.cs.ucsb.edu
    https://jpa02-cgaucho.dokku-07.cs.ucsb.edu
   ```

