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

1. This link should take you directly to the page to create a new OAuth App: <https://github.com/settings/applications/new>
   
   Or you can navigate to it this way:
      * Go to the Settings page for your own github account
      * Find the tab down the left column that says "Developer Settings"
      * Click the tab for `OAuth Apps`
      * Click the button `New OAuth App`

2.  You now have a form to fill in that looks like this:

     <img width="300" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/4f8479e7-d715-4a58-b600-8a6845ff2deb">

    * Application name: Fill in something users will recognize. 
      
      For CMPSC 156 assignments, this will typically be something like `jpa03`, `team02`, `team03`, `proj-organic`, `proj-courses`, etc.
     
    * Homepage URL: Typically either something like:
       * `http://localhost:8080` or
       * `https://organic.dokku-xx.cs.ucsb.edu` (where `xx` is replaced with your dokku number)

       Note that unlike Google OAuth configuration where you can specify multiple URLs that all share the same Client Id and Client Secret,
       for Github OAuth, each app (e.g. localhost, prod, qa) must be a
       *separate* Github OAuth App with its own client id and client secret.
       
    * Application Description is optional.  If you fill it in, users will see it when they are asked to authorize access to their GitHub account.
    
    * Authorization callback URL.  
       * For localhost, enter: `http://localhost:8080/login/oauth2/code/github` (Note: on `localhost`, *must* be `http` )
       * For Dokku, enter: `https://myappname.dokku-xx.cs.ucsb.edu/login/oauth2/code/github` (on dokku, *must* be `https` )
       * Note that you should substitute in *your* app name in place of `my-app-name` and your dokku number for `xx`
    
    Click to create the OAuth App.

    You will now see the client id and client secret values.
   
    Keep this window open, since you'll need these values in the next step.
   
4.  You now have a client id and a client secret for your `.env` file, or for the `dokku config:set ...` command.

    It is important to NOT put the client secret into a file that is committed to GitHub.
    

   
