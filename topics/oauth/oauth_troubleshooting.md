---
parent: OAuth
grand_parent: Topics
layout: default
title: "OAuth: Troubleshooting"
description:  "What to do when things go wrong?"
---

## Troubleshooting

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
  

