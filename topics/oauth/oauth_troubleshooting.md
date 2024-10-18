---
parent: OAuth
grand_parent: Topics
layout: default
title: "OAuth: Troubleshooting"
description:  "What to do when things go wrong?"
---

# {{page.title}} - {{page.description}}

If you are having issues with logging into OAuth, here's a checklist of things to look at:

1. Unless you are on `localhost:8080`, be sure you are using the `https` link and not the `http` link.  OAuth only works with `http` on `localhost`, not on other platforms such as dokku.
2. If you are using `https` and you are working with a dokku server (e.g. `https://myapp.dokku-17.cs.ucsb.edu`), check the Google Developer to make sure your callback urls have the correct address.
   * The callback url should start with `https`
   * It should then have your app name, followed by the dokku hostname. Be sure you got the correct dokku number, and not `dokku-xx` or something like that.
   * It should end in `/login/oauth2/code/google` for [Google OAuth](https://ucsb-cs156.github.io/topics/oauth/oauth_google_setup.html) (which is the common cases for `jpa` and `team` type assignments, and most of the `proj` series assignments.
   * For `proj-organic` only, where [Github OAuth](https://ucsb-cs156.github.io/topics/oauth/oauth_github_setup.html) is used, it should end in `/login/oauth2/code/github` instead.
3. Check that your have the `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` set correctly
   * For `localhost`, check settings in `.env`
   * For dokku, check settings using <tt>dokku config show <i>appname</i></tt>

There is more detail below on a specific example of troubleshooting.

## Troubleshooting Example

If you see this:

<img src="https://user-images.githubusercontent.com/1119017/149856156-575fb638-7db8-460a-a344-9069145aa242.png" alt="Redirect URI Mismatch" width="600" />


Try clicking the little arrow to open up the additional message:

<img src="https://user-images.githubusercontent.com/1119017/149856193-512acb25-2bfc-4e53-991b-f61de37f1ed6.png" alt="Request Details" width="600" />

Now, you'll see  the Redirect URI that the app is expecting.

If you go back to the [Google Developer Console](https://console.cloud.google.com/) you can see what you really entered.

For example, when I was getting this error message, it's because I put in this for my Redirect URI:

![image](https://user-images.githubusercontent.com/1119017/149856340-98acd5e4-8712-4723-a899-e3bf2f06d3fa.png)

Rookie mistake!  I literally had `my-heroku-app` instead of `demo-spring-react-example`. 

Change it to the correct URI, click save.  Then go back to the URL for the home page of your app and refresh the page (you don't need to restart the application backend; just refresh your browser page.)  Click login again, and you should get something like this:

<img src="https://user-images.githubusercontent.com/1119017/149856532-b1cda813-bd3f-4fd1-a79e-630e5929d7be.png" alt="Choose an Account" width="600" />


Success!
  

