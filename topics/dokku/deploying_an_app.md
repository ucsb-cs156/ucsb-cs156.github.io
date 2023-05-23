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

## Deploying an app 

Once you've set up any environment variables and/or databases that you need, here's how you get
your app deployed.

You will need **two terminal windows**
* one on the **Dokku Server**
* another on **`csil.cs.ucsb.edu`**

1. In the ordinary **csil** window, create a directory where you can clone your repo.  
   - NOTE: we are not going to *run* our app on CSIL.  We are just using a CSIL command line as the place from which
     we can push to dokku.
   - So in general, you'll only do `git` command on CSIL.  You'll do your main editing and localhost testing on your
     own laptop, or in a Github Codespace.
   - The reason for this is that the dokku servers are configured to accept connections from your CSIL account, using
     your CSIL ssh public key.
3. Clone your repo in the directory on your CSIL account.  
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


# An alternative way to deploy your app

Here is a new way to deploy your app on Dokku that may be more straightforward than the approach described above.

This requires *only* an ssh shell on the Dokku machine.  You still need to login to csil, then dokku, but you do *not* have to do anything at the command line on csil.

1. `ssh username@csil.cs.ucsb.edu` then to your dokku machine (e.g. `ssh dokku-01.cs.ucsb.edu`) substituting your dokku number in place of `01`.

2. To set the git branch that your dokku app will deploy on its next build, do this:
   ```
   dokku git:sync your-app-name https://github.com/ucsb-cs156-s23/your-repo-name.git branch-to-deploy
   ```

   For example:
   ```
   dokku git:sync team03-qa https://github.com/ucsb-cs156-s23/team03-s23-7pm-4.git KT-add-hotels
   ```

   This doesn't deploy the app, but it does set things up so that the command below will deploy from
   the specified repo and this branch.

3. Then, to deploy, use `dokku ps:rebuild app-name`
   
   For example:
   ```
   dokku ps:rebuild team03-qa
   ```
   You should see then see the output from the deployment of the branch specified in the earlier `dokku git:sync ...` step.
   
  
