---
parent: Render
grand_parent: Topics
layout: default
title: "Set Environment Variables"
description:  "How to set up environment variables on Render.com"
---

Previous versions of instructions for CS156 projects (from before F22) will have instructions for setting up environment variables on Heroku.com

Here is how you do it on Render.com.  Note that in this example, we set up temporary values for the `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET`; these values will not be valid for logging into web apps that use OAuth, but they should at least allow the
app to get up and running.   The values can then later to be adjusted to correct values.

To run on Render, you need to:
* set `PORT` to 8080 so that the port 8080 is mapped to the `https` service that is exposed to the outside world via 
* set `PRODUCTION` to `true` so that the the frontend will build and mount, integrated with the Spring Boot backend (instead of running on a separate port) (this is triggered by code in the `pom.xml` file)
* set whatever other environment variables are needed by the specific application (in this example, those are `ADMIN_EMAILS`, `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET`

![cs156-render-environment-vars](https://user-images.githubusercontent.com/1119017/194436920-e8bd0361-7c8c-48ef-91c5-035373029c7c.gif)

# Details

* For a backend only application that does not use OAuth or a Database (e.g. the team01 exercise used in W22 and S22), you only need
  to define `PORT 8080` so that (a) the server starts on port 8080, and (b) port 8080 is mapped to the https port that is exposed to the 
  public internet.
  
