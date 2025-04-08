---
parent: OAuth
grand_parent: Topics
layout: default
title: "Google: OAuth Consent Screen"
description:  "One time step before you can create client-id/client-secret"
---

# {{page.title}} - {{page.description}}

Before you [set up your first Google OAuth application](/topics/oauth/oauth_google_setup.html), you need to:
* First: [Create a Google Developer Project](/topics/oauth/google_create_developer_project.html)
* Second: Configure the Google OAuth consent screen, described below.
   
# How to configure the OAuth Consent Screen

1. Navigate to <https://console.cloud.google.com/>.  The upper left hand corner of the page should look like this:

   
   <img width="395" alt="console.cloud.google.com, project selection dropdown" src="https://user-images.githubusercontent.com/1119017/235321850-aba152e7-4179-40e0-a63f-093f50136fff.png">
   
2. Make sure the project showing (`cmpsc156-s23` in the example) is the one you want to work with. If not, click on the dropdown and select
   the correct project.  If you don't have a project, click `New Project` and [follow the instructions here to create one](topics/oauth/google_create_google_developer_project.html).
   
3. Use the so-called "hamburger menu" (the icon with three vertical lines like this ☰) to reveal these menus, and select `APIs & Services / OAuth consent screen`.

   <img width="400" alt="image" src="https://user-images.githubusercontent.com/1119017/235322045-f45a7438-5b24-433c-a0ac-1a698b6b1dd0.png">
   
4. Now you are ready to start filling in the information for the OAuth Consent Screen, as explained below.

## What is the OAuth Consent Screen?

The idea is that when your application authenticates using Google OAuth OAuth, 
it will share certain information/permissions with the application; at a minimum, your name and Google email address.  

Before Google allows this, it wants to be sure that you give your permission.   
For this reason, you need to configure what will be shown to the user when this happens.

## What information am I asked for when configuring the OAuth Consent Screen?

You will only need to fill this in once for the project; you may be able to get away with filling this in just once for the entire course (unless
you run into some limit on the number of apps you can create in your project.)

Fill in these values on the screen that appears.  Use the name of the course and the quarter, and fill in your UCSB email:

<img width="735" alt="image" src="https://github.com/user-attachments/assets/193204d1-82dc-4058-96f9-933123e0c24b">


On this screen, click External, then Next:
<img width="729" alt="image" src="https://github.com/user-attachments/assets/effc5f7e-9f4b-4fa7-993c-cf379ff4667e">

 Fill in your UCSB email where it says:  `Contact information`

<img width="652" alt="image" src="https://github.com/user-attachments/assets/2fd0feec-785d-405d-820e-1e6ebe9bba0f">

Then click "Next", and agree to the Google API services policy before clicking "continue" and "create".

After you click Create, you can set up Scopes.

# What are Scopes?

Scopes are various kinds of permission that you give to the app to work with your Google data.  The minimum is typically the ability to see your Google email address, and some basic information about you as a user.  Other examples (which we will not show at the moment) might include the ability to work with you Google Calendar, Google Docs, GMail, etc.

To access the scopes, select the `Data Access` tab on the left side of the screen.

<img width="400" alt="image" src="https://github.com/user-attachments/assets/05cf753a-9b9c-455f-92fa-1f140f6cabe7">

To add a basic scope, click "Add or Remove Scopes" which brings up this page:

<img width="400" alt="image" src="https://user-images.githubusercontent.com/1119017/159813656-30755f02-d386-49ff-8efc-7908daf1b6ac.png">


You can click to select the first two basic scopes; that should be sufficient. Then click the Update Button:

<img width="400" alt="image" src="https://user-images.githubusercontent.com/1119017/159813741-754b1f6b-4f92-4647-a369-823d316e9a8d.png">

It should then look like this after updating:

<img width="400" alt="image" src="https://github.com/user-attachments/assets/e69a384f-77e8-4db4-aa97-8e883247b5a2">


## Test Mode vs. Production Mode

There are two possible modes for a Google OAuth Application

| Mode | Protocols Allows | Users Allowed |
|------|------------------|---------------|
| Test Mode | `http` or `https` | Only a specfific subset which must be specfied in the OAuth Consent Screen settings |
| Production Mode | `https` only, except for `localhost` | Any user with a Google Account (with an option to restrict to only @ucsb.edu users |

For this course, we typically prefer Production Mode.

You change from Test Mode to Production Mode by navigating to the `Audience` tab on the left side of the screen, clicking the `Publish App` button, followed by `Confirm`

<img width="400" alt="image" src="https://github.com/user-attachments/assets/329ee006-c2b6-4560-937f-7e7f9443889d">

<img width="400" alt="image" src="https://user-images.githubusercontent.com/1119017/159960531-7911ba19-ccbe-465b-a37c-c46f98614c13.png">
 
That should change the screen to look like this.

<img width="400" alt="image" src="https://github.com/user-attachments/assets/7f970ea0-f1c5-4e16-9fe8-da6752e5856a">

# What's next

A typical next step is to set up a Google OAuth app so that you can obtain a `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` values, [as 
described here](/topics/oauth/oauth_google_setup.html).
