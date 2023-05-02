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

2. Select the project you would like to create your OAuth app in.

2. On the upper left, there is a hamburger menu icon that provides a left navigation menu.
   
   * Look for `APIs and Services` then `Credentials`.
   * On that page, near the top, click the button for `+ CREATE CREDENTIALS`
   * This makes a pull-down menu where you can select `OAuth Client ID`
   * For Application Type, select `Web Application`
   * For name, choose something you will remember; I suggest using the name of your repo, or the name of the Heroku application
   * Scroll down to the part of the page that says: `Authorized redirect URIs`

3. Under `Authorized redirect URIs`, you'll need to click the `+ ADD URI` button twice to enter two addresses:

   * For localhost, enter: <tt>http://localhost:8080/login/oauth2/code/google</tt>
     - Note that this *must* be `http` not `https`
   * For Dokku, enter: <tt>http://<b><i>myappname</i></b>.dokku-<b><i>xx</i></b>.cs.ucsb.edu/login/oauth2/code/google</tt>
     - Note that you should substitute your app name in place of <b><i>myappname</i></b>, and your dokku server number in place of <b><i>xx</i></b>.
     - Note that this *must* be `http` not `https`, and requires that the OAuth Consent Screen be in "Test Mode".
   * We are not currently using Heroku, but if we were you would enter: <tt>https://<b><i>myappname</i></b>.herokuapp.com/login/oauth2/code/google</tt>
     - Note that you should substitute in *your* Heroku app name in place of `my-app-name`
     - Note that this *must* be `https` not `http`
   
   ![image](https://user-images.githubusercontent.com/1119017/149854295-8e1c4c63-929c-4706-972d-1962c644a40a.png)

   Then click the blue `CREATE` button.
   
   You will now see the values that we need for `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET`
   
   Keep this window open, since you'll need these values to configure your application.  If you do close the window,
   you can always return later and get the values.

4. For localhost, these values typically go in the `.env` file, replacing the placeholder values you see there. 
   * The `.env` file is created by *copying* (not renaming!) the file `.env.SAMPLE` to `.env`
   * Do not make the rookie mistake of deleting the `.env.SAMPLE` file from the repo!
   * Also, do not commit the `.env` file to GitHub; it contains the `GOOGLE_CLIENT_SECRET` which, as the name suggests, needs to be kept secret!

5. For Dokku, the values are set using the `dokku config:set ... ` command; 
   see <https://ucsb-cs156.github.io/topics/dokku/environment_variables.html> for more information.
   
Once you have configured your app with these values, restart the application (the backend, specifically) and you should be able to login using your Google OAuth account. 
