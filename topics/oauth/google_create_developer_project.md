---
parent: OAuth
grand_parent: Topics
layout: default
title: "Google: Create Developer Project"
description: "One time step to get started with Google Developer Console"
---

# {{page.title}} - {{page.description}}

Before you [set up your first Google OAuth application](topics/oauth/oauth_google_setup.html) or do any other actions with the Google Developer
Console, you need to **create a new project**.  This page describes how to do that.

# Steps to Create a New Project

1. Navigate to <https://console.cloud.google.com/cloud-resource-manager> and login with your UCSB Google Account.
   
   If you haven't already [created a Google Developer Project](topics/oauth/google_create_google_developer_project.html), you'll need to do that first.
   
   You'll see something like this, except you might not have anything under the `UnPaid` folder.  (That is where you'll create your projecct).
   
   <img width="698" alt="Google Developer Console Project List" src="https://user-images.githubusercontent.com/1119017/235321567-ada58904-ce9e-41eb-b7f7-6d4ceff71cb8.png">

2. Click the `Create Project` button (<img width="147" alt="Create Project Button" src="https://user-images.githubusercontent.com/1119017/235321614-e4e663dc-34c7-494f-8e97-ba2b3caaa6be.png">).  
   You should then see a page like this one.  
   * Fill in the name of the project with something meaningful such as the course and quarter (e.g. `cs156-s23, `cs156-m23`, etc.)  
   * The organization should be `ucsb.edu`
   * Under `Location` click `Browse` and then select `UnPaid` so that it looks like the image below

   <img width="564" alt="Create Project form (filled in)" src="https://user-images.githubusercontent.com/1119017/235321749-ed77039d-101e-418e-a9a8-2bd267f130b2.png">

# What's next

Typical next steps are: 

* First, [Configuring the OAuth Consent Screen](topics/oauth/google_oauth_consent_screen.html),
* Followed by [Setting up a `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` for an OAuth app](/topics/oauth/oauth_google_setup.html)
  

