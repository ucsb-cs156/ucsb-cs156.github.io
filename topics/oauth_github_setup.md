---
parent: Topics
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

2.  You now have a form to fill in.

    * Application name: Fill in something users will recognize. 
      
      If it's a lab assignment, use the name of your app, e.g. lab06-githubid
     
    * Homepage URL: Typically either something like:
       * `http://localhost:8080` or
       * `https://cs56-f19-lab06-githubid.herokuapp.com`
       
    * Application Description is optional.  If you fill it in, users will see it when they are asked to authorize access to their GitHub account.
    
    * Authorization callback URL.  
       * For some applications this is exactly the same as the Homepage URL.  
       * For others, it is the Homepage URL plus some extra path.  Follow the instructions you were given.
       
3.  Once you enter this information, you'll get a client id and a client secret.
    It is important to NOT put the client secret into a file that is committed to GitHub.
    
    You typically need to enter these values into some configuration file.  Follow the instructions you were given. 
   
