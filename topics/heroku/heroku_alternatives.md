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
  
* [replit.com](https://replit.com)
  - A simple Spring Boot RESTFul API app seems to work; example here: <https://replit.com/@phtcon/SpringBootApplicationStarter#README.md>
  - No testing beyond that yet  
  
* [heliohost.org](https://heliohost.org/)
  - NOT YET TESTED
  - PROS:
    - Non profit... see: <https://www.hostingadvice.com/blog/heliohost-provides-free-hosting-to-a-tight-knit-community/>
    
  
# Postgres Hosting alternatives
  
* [bit.io](https://bit.io/)
  - NOT TESTED YET
  - PROS: 
    - Has a free tier [pricing](https://bit.io/pricing)
    - 3 Databases, 3GB storage
  - CONS:
    - Databases are "public".. not sure what that means.
    - If it's read only, could work for SOME apps, but not all
    - If it's public read/write, that's a deal breaker (unusable)

    
* [www.elephantsql.com](www.elephantsql.com)
  - NOT TESTED YET
  - PROS: 
    - Has a free tier [pricing](https://www.elephantsql.com/plans.html)
    - 20MB Data, 5 concurrent connections

  
