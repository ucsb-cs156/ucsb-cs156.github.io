---
parent: OAuth
grand_parent: Topics
layout: default
title: "Google: OAuth Consent Screen"
description:  "One time step before you can create client-id/client-secret"
---

# {{page.title}} - {{page.description}}

Before you [set up your first Google OAuth application](topics/oauth/oauth_google_setup.html), you need to:
* First: [created a Google Developer Project](topics/oauth/google_create_google_developer_project.html)
* Second: configured the Google OAuth consent screen, described below.

# How to create a new Google Developer Project

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

   
# How to configure the OAuth Consent Screen

1. Navigate to <https://console.cloud.google.com/>.  The upper left hand corner of the page should look like this:

   <img width="395" alt="console.cloud.google.com, project selection dropdown" src="https://user-images.githubusercontent.com/1119017/235321850-aba152e7-4179-40e0-a63f-093f50136fff.png">
   
2. Make sure the project showing (`cmpsc156-s23` in the example) is the one you want to work with. If not, click on the dropdown and select
   the correct project.  If you don't have a project, click `New Project` and [follow the instructions here to create one](topics/oauth/google_create_google_developer_project.html).
   
3. Use the so-called "hamburger menu" (the icon with three vertical lines like this ☰) to reveal these menus, and select `APIs & Services / OAuth consent screen`.

   <img width="439" alt="image" src="https://user-images.githubusercontent.com/1119017/235322045-f45a7438-5b24-433c-a0ac-1a698b6b1dd0.png">
   
4. Now you are ready to start filling in the information for the OAuth Consent Screen, as explained below.

## What is the OAuth Consent Screen?

The idea is that when your application authenticates using Google OAuth OAuth, 
it will share certain information/permissions with the application; at a minimum, your name and Google email address.  

Before Google allows this, it wants to be sure that you give your permission.   
For this reason, you need to configure what will be shown to the user when this happens.

## What information am I asked for when configuring the OAuth Consent Screen?

Here is a screen shot that shows what I filled in for a sample application running on Heroku called `demo-spring-react-example-s22`:

<img width="687" alt="image" src="https://user-images.githubusercontent.com/1119017/159813247-16ff80dc-cc56-42fa-8f10-42dcda021327.png">
<img width="676" alt="image" src="https://user-images.githubusercontent.com/1119017/159813299-1122efe4-8940-4aa7-9878-fcfcb9d17d6f.png">
<img width="606" alt="image" src="https://user-images.githubusercontent.com/1119017/159813319-cbf35953-b7eb-489a-84c2-69a85934515a.png">

After you click Save and Continue, you'll be asked about Scopes.

# What are Scopes?

Scopes are various kinds of permission that you give to the app to work with your Google data.  The minimum is typically the ability to see your Google email address, and some basic information about you as a user.  Other examples (which we will not show at the moment) might include the ability to work with you Google Calendar, Google Docs, GMail, etc.

<img width="765" alt="image" src="https://user-images.githubusercontent.com/1119017/159813614-051f1182-c517-49a8-9a9b-b1e461ddd8ca.png">

To add a basic scope, click "Add or Remove Scopes" which brings up this page:

<img width="740" alt="image" src="https://user-images.githubusercontent.com/1119017/159813656-30755f02-d386-49ff-8efc-7908daf1b6ac.png">


You can click to select the first two basic scopes; that should be sufficient. Then click the Update Button:

<img width="597" alt="image" src="https://user-images.githubusercontent.com/1119017/159813741-754b1f6b-4f92-4647-a369-823d316e9a8d.png">

It should then look like this; click "Save and Continue":

<img width="652" alt="image" src="https://user-images.githubusercontent.com/1119017/159813845-72f300d4-093d-4d89-be7e-db29bd1a6421.png">

## Test Mode vs. Production Mode

There are two possible modes for a Google OAuth Application

| Mode | Protocols Allows | Users Allowed |
|------|------------------|---------------|
| Test Mode | `http` or `https` | Only a specfific subset which must be specfied in the OAuth Consent Screen settings |
| Production Mode | `https` only, except for `localhost` | Any user with a Google Account (with an option to restrict to only @ucsb.edu users |

For this course, we typically prefer Production Mode, but if you are deploying on platform where you don't have
the ability to use `https`, you may need to use Test Mode.

<img width="558" alt="image" src="https://user-images.githubusercontent.com/1119017/159813939-04063b66-e0ce-4421-b608-3dd2a7134265.png">

You change from Test Mode to Production Mode by clicking the `Publish App` button, followed by `Confirm`

<img width="535" alt="image" src="https://user-images.githubusercontent.com/1119017/159960185-05c176d5-0cee-4800-bce3-b80c619f8f38.png">

<img width="739" alt="image" src="https://user-images.githubusercontent.com/1119017/159960531-7911ba19-ccbe-465b-a37c-c46f98614c13.png">
 
That should change the screen to look like this.
 
<img width="740" alt="image" src="https://user-images.githubusercontent.com/1119017/159813656-30755f02-d386-49ff-8efc-7908daf1b6ac.png">

<img width="540" alt="image" src="https://user-images.githubusercontent.com/1119017/159960643-dc95bec9-bfd7-4a1d-87c6-4d0da32d6ab7.png">
