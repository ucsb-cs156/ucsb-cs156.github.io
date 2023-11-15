---
parent: OAuth
grand_parent: Topics
layout: default
title: "OAuth: GitHub Setup"
description:  "Setting up a GitHub OAuth App to obtain client id and client secret"
category_prefix: "OAuth: "
indent: true
---

To configure an OAuth App for Github:

First note that you need to set up a "Github App", not an "OAuth App".  The difference is subtle, but important.


1. This link should take you directly to the page to create a new OAuth App: <https://github.com/settings/apps/new>
   
   Or you can navigate to it this way:
      * Go to the Settings page for your own github account
      * Find the tab down the left column that says "Developer Settings"
      * Click the tab for `Github Apps`
      * Click the button `New Github App`

3.  You now have a form to fill in that looks like this:

    The top of the form looks like this. Fill in a name such as: `organic on localhost` or `organic-qa on dokku-07`

    <img width="577" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/f6a5e0b4-20c1-43c5-ae1b-94c7214eab0f">


    Then scroll down to Homepage URL and fill in something like either `http://localhost:8080` or `https://organic-qa.dokku-07.cs.ucsb.edu`

    <img width="566" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/9be65a2b-61e6-48c5-b54e-82786fddae25">

    Then scroll down to `Callback URL` and fill in something like this.
    * For localhost, enter: `http://localhost:8080/login/oauth2/code/github` (Note: on `localhost`, *must* be `http` )
    * For Dokku, enter: `https://myappname.dokku-xx.cs.ucsb.edu/login/oauth2/code/github` (on dokku, *must* be `https` )
    * Note that you should substitute in *your* app name in place of `my-app-name` and your dokku number for `xx`

    <img width="870" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/8f614a11-a8ea-4288-9f9d-ef4cefdc14b2">

    Be sure that the buttons just under `Callback URL` are click/unclicked exactly like this:

    <img width="838" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/4bfbf77e-1a8c-47dd-b2ec-696dd2672458">
       
    Scroll down to where it says Webhook, and unclick the button so that it looks like this:

    <img width="620" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/1bb82d87-a11e-4ddb-ac91-75f2d6b3c971">

    Now scroll down to `Account Permissions` and click the triangle to open up the box.  For proj-organic, you'll need
    to select `Read-Only` next to `Emails`.  Leave everything else as `No access`.

    <img width="868" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/b5a35475-4e25-498e-87a9-aa900731c37d">
  
    Finally, scroll to the bottom and select `Any Account` like this:

    <img width="530" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/820c906c-79f9-4c2a-87ac-83e3ad3df5e8">

    You are now finally ready to click `Create Github App`.  When you do, you should see the client id, something like this:

    <img width="381" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/5aa3deb1-73f3-4379-ba2b-ca3de615fca9">

    To get the client secret, scroll down to this part of the page, and click the `Generate a New Client Secret` button.

    <img width="875" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/25663171-2fba-404a-aec3-00e901128cbe">

    After you do, you'll see sometnhing like this:

    <img width="847" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/8a4b7395-0258-45af-8994-c1da15cddfd7">

    (Note that the above client secret has been deleted, so don't bother trying to use it to hack my account.)
     
    Keep this window open, since you'll need these values in the next step.
   
5.  You now have a client id and a client secret for your `.env` file, or for the `dokku config:set ...` command.

    It is important to NOT put the client secret into a file that is committed to GitHub.
    

   
