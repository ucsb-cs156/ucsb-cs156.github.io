---
parent: OAuth
grand_parent: Topics
layout: default
title: "OAuth: Google Setup"
description:  "Setting up a Google OAuth App to obtain client id and client secret"
category_prefix: "OAuth: "
indent: true
---

# {{page.title}} - {{page.description}}

Before you set up your first Google OAuth application you need to do these one-time steps:

* First: [Create a Google Developer Project](/topics/oauth/google_create_developer_project.html)
* Second: [Configure the OAuth Consent Screen](topics/oauth/google_oauth_consent_screen.html),

If you've already done these, then you are ready to set up a Google OAuth app so that you can get a `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` as described below:
   
# Steps

1. Login to the Google Developer Console at <https://console.cloud.google.com/>
   - You probably want to open this in a separate tab so that you can still see these instructions.

2. Select the project you would like to create your OAuth app in.  You do this in the little dropdown with the triangle, upper left
   next to the "Google Cloud" logo:
   
   <img width="200" alt="image" src="https://user-images.githubusercontent.com/1119017/235767833-66131e44-78e9-4014-a09d-0f506b7dcec1.png">


2. On the upper left, there is a hamburger menu icon that provides a left navigation menu.
   
   * Look for `APIs and Services` then `Credentials`.
   * On that page, near the top, click the button for `+ CREATE CREDENTIALS`
   * This makes a pull-down menu where you can select `OAuth Client ID`
   * For Application Type, select `Web Application`
   * For name, choose something you will remember; I suggest using the name of your repo, or the name of the Dokku/Heroku application (e.g. `jpa03-cgaucho` `5pm-3-happycows-qa`)
   * Scroll down to the part of the page that says: `Authorized redirect URIs`

3. Under `Authorized redirect URIs`, you'll need to click the `+ ADD URI` button twice to enter at least two addresses:

   * For localhost, enter: <tt>http://localhost:8080/login/oauth2/code/google</tt>
     - Note that this *must* be `http` not `https`
   * For Dokku, enter: <tt>https://<b><i>myappname</i></b>.dokku-<b><i>xx</i></b>.cs.ucsb.edu/login/oauth2/code/google</tt>
     - Note that you should substitute your app name in place of <b><i>myappname</i></b>
     - Be sure to also change <b><i>xx</i></b> to your actual dokku server number (`01` through `16`)
     - Note that this *must* be `https` not `http`.
   * If you also have a `qa` deployment or additional personal dev deployments, you can add them; they may share the same Google OAuth client id and secret.

   <img width="504" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/dbbc5fe5-8b80-49c6-be1f-50d5036c7a47">

   Then click the blue `CREATE` button.
   
   You will now see the values that we need for `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET`
   
   You will **NOT** be able to view this secret after you close this window.
   Since you'll need these values to configure your application, make sure to store them in a safe location.

5. For localhost, these values typically go in the `.env` file, replacing the placeholder values you see there. 
   * The `.env` file is created by *copying* (not renaming!) the file `.env.SAMPLE` to `.env`
   * Do not make the rookie mistake of deleting the `.env.SAMPLE` file from the repo!
   * Also, do not commit the `.env` file to GitHub; it contains the `GOOGLE_CLIENT_SECRET` which, as the name suggests, needs to be kept secret!

6. For Dokku, the values are set using the `dokku config:set ... ` command; 
   see <https://ucsb-cs156.github.io/topics/dokku/environment_variables.html> for more information.
   
Once you have configured your app with these values, restart the application (the backend, specifically) and you should be able to login using your Google OAuth account. 
