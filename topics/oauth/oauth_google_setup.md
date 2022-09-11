---
parent: OAuth
grand_parent: Topics
layout: default
title: "OAuth: Google Setup"
description:  "Setting up a Google OAuth App to obtain client id and client secret"
category_prefix: "OAuth: "
indent: true
---


# How to set up Google OAuth

1. Navigate to <https://developers.google.com/identity/sign-in/web/sign-in> to create a Google OAuth Application.
    - If you are asked "Where are you calling from", select "Web Server"

    - Set the *Authorized Redirect URI* to: `http://localhost:8080/login/oauth2/code/google`
2. Add the following items to your `localhost.json` file, filling out the `client-id` and `client-secret` with the values from 
your Google OAuth application:
```
"spring.security.oauth2.client.registration.google.client-id":"ENTER-GOOGLE-ID",
"spring.security.oauth2.client.registration.google.client-secret":"ENTER-GOOGLE-SECRET"
```
    - **NOTE**: If you want Heroku to also support Google OAuth, you'll need to do the same in `heroku.json`, hopefully with a set of production credentials from a production Google OAuth app.
3. Run `source env.sh` to update your environment.
4. Run `mvn -P localhost spring-boot:run` and see that your application is now configured to support Google OAuth!.

# Configuring the OAuth Consent Screen

The first time you create a new OAuth application, you'll be asked to configure the OAuth Consent Screen.

**What is the OAuth Consent Screen?** The idea is that when your application authenticates using Google OAuth OAuth, it will share certain information/permissions with the application; at a minimum, your name and Google email address.  Before Google allows this, it wants to be sure that you give your permission.   For this reason, you need to configure what will be shown to the user when this happens.



**What information am I asked for when configuring the OAuth Consent Screen?**  Here is a screen shot that shows what I filled in for a sample application running on Heroku called `demo-spring-react-example-s22`:

<img width="687" alt="image" src="https://user-images.githubusercontent.com/1119017/159813247-16ff80dc-cc56-42fa-8f10-42dcda021327.png">
<img width="676" alt="image" src="https://user-images.githubusercontent.com/1119017/159813299-1122efe4-8940-4aa7-9878-fcfcb9d17d6f.png">
<img width="606" alt="image" src="https://user-images.githubusercontent.com/1119017/159813319-cbf35953-b7eb-489a-84c2-69a85934515a.png">

After you click Save and Continue, you'll be asked about Scopes.

**What are Scopes?** Scopes are various kinds of permission that you give to the app to work with your Google data.  The minimum is typically the ability to see your Google email address, and some basic information about you as a user.  Other examples (which we will not show at the moment) might include the ability to work with you Google Calendar, Google Docs, GMail, etc.

<img width="765" alt="image" src="https://user-images.githubusercontent.com/1119017/159813614-051f1182-c517-49a8-9a9b-b1e461ddd8ca.png">

To add a basic scope, click "Add or Remove Scopes" which brings up this page:

<img width="740" alt="image" src="https://user-images.githubusercontent.com/1119017/159813656-30755f02-d386-49ff-8efc-7908daf1b6ac.png">


You can click to select the first two basic scopes; that should be sufficient. Then click the Update Button:

<img width="597" alt="image" src="https://user-images.githubusercontent.com/1119017/159813741-754b1f6b-4f92-4647-a369-823d316e9a8d.png">

It should then look like this; click "Save and Continue":

<img width="652" alt="image" src="https://user-images.githubusercontent.com/1119017/159813845-72f300d4-093d-4d89-be7e-db29bd1a6421.png">


**Test Users** It is possible to restrict the users that can access your app to a small subset.  We typically don't do that for our
apps in CMPSC 156, so I suggest just clicking "Save and Continue"

<img width="558" alt="image" src="https://user-images.githubusercontent.com/1119017/159813939-04063b66-e0ce-4421-b608-3dd2a7134265.png">

That should bring us to this summary page showing all of the data we entered. There is one more step; we see that this app is in 
"testing mode".


<img width="535" alt="image" src="https://user-images.githubusercontent.com/1119017/159960185-05c176d5-0cee-4800-bce3-b80c619f8f38.png">

 Unless you want to restrict the app to specific users, change this to "production mode" by clicking "Publish App", and then "Confirm":
 
 <img width="739" alt="image" src="https://user-images.githubusercontent.com/1119017/159960531-7911ba19-ccbe-465b-a37c-c46f98614c13.png">
 
 That should change the screen to look like this.
 
<img width="740" alt="image" src="https://user-images.githubusercontent.com/1119017/159813656-30755f02-d386-49ff-8efc-7908daf1b6ac.png">

<img width="540" alt="image" src="https://user-images.githubusercontent.com/1119017/159960643-dc95bec9-bfd7-4a1d-87c6-4d0da32d6ab7.png">
