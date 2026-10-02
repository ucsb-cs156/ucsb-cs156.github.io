---
parent: OAuth
grand_parent: Topics
layout: default
title: "Google: Create Developer Project"
description: "One time step to get started with Google Developer Console"
---

# {{page.title}} - {{page.description}}

Before you [set up your first Google OAuth application](/topics/oauth/oauth_google_setup.html) or do any other actions with the Google Developer
Console, you need to **create a new project**.  This page describes how to do that.

# Steps to Create a New Project

1. Navigate to <https://console.cloud.google.com/cloud-resource-manager> and login with your UCSB Google Account.
      
   You'll see something like this, except you might not have anything under the `Sandbox Unfunded` folder.  (That is where you'll create your projecct).
   
      <img width="907" height="537" alt="Google Developer Console Project List" src="https://github.com/user-attachments/assets/59bbd2be-c76d-4d87-88c0-c9e27e18ee21" />

2. Click the `Create Project` button (<img width="147" alt="Create Project Button" src="https://user-images.githubusercontent.com/1119017/235321614-e4e663dc-34c7-494f-8e97-ba2b3caaa6be.png">).  
   You should then see a page like this one.  
   * Fill in the name of the project with something meaningful such as the course and quarter (e.g. `ucsb-cs156`) 
   * The organization should be `ucsb.edu`
   * Under `Location` click `Browse` and then select `Sandbox Unfunded` as in the animation below:

   <img width="1000" height="461" alt="google-create-project-demo" src="https://github.com/user-attachments/assets/e8eca0a1-625b-4a64-90ea-4c960670462e" />

   * Click `Create`

# What's next

Typical next steps are: 

* First, [Configuring the OAuth Consent Screen](/topics/oauth/google_oauth_consent_screen.html),
* Followed by [Setting up a `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` for an OAuth app](/topics/oauth/oauth_google_setup.html)
  

