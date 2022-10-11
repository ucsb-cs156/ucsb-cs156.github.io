---
parent: Heroku
grand_parent: Topics
layout: default
title: "Heroku: Alternatives"
description:  "Where else can we deploy our apps?"
---

In November 2022, Heroku will shut down its free tier.  

Projects in CMPSC 56 and CMPSC 156 have relied on that service for many years.  We will need to find viable alternatives.

Heroku provided at least two separate services for us:

* Hosting of Spring Boot web applications
* Provision of Postgres databases

It may very well be that we end up replacing Heroku with multiple services: 
* One for web app hosting
* Another for database hosting

# Web App Hosting Alternatives

* [Render.com](https://render.com)
  - HAS BEEN TESTED, AND WORKS
  - PROS: 
    - Has been shown to work for Spring Boot
    - Has completely free tier (no credit card, indefinite usage)
  - CONS:
    - Very, very slow (as compared to Heroku)
    - Spring Boot is not documented; it's trial and error with Docker
  - ADJUSTMENTS:
    - Requires separate Postgres provision
    - Requires a Dockerfile to be setup
  
  # Postgres Hosting alternatives
  
  * [bit.io](https://bit.io/)
    - NOT TESTED YET
    - PROS: 
      - Has a free tier
    
