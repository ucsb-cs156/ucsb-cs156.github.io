---
parent: Topics
layout: default
title: Auth0
description:  "A third-party commerical service to help manage authentication"
category_prefix: "Auth0: "
---

For some projects in this course, we've used Auth0, a commerical service that has a "free tier", to help manage authentication.

You can create an account on the free tier at <https://auth0.com>.   
* For simplicity of course management, we suggest you create this account using your `userid@ucsb.edu` email address.
* The first step is to create a _tenant_, as explained below.

# What is an Auth0 _tenant_ 

A tenant is simply a related group of applications.  Think of a tenant as way to segment your Auth0 account
into multiple subaccounts for different purposes. For example, you might have:
* One tenant for all of your individual work in this course
* A separate tenant that your entire team shares, for your group work in this course.
* Another tenant for personal projects
* Yet another for a personal group project you undertake for a "hackathon"

Tenants can be private to just one user, or shared among multiple users.

We suggest that you name your initial tenant `ucsb-cs156-cgaucho` where `cgaucho` is the `userid` part of your `userid@ucsb.edu`.

# Switching your tenant

There is a pull-down menu at the upper right hand side of the Auth0 dashboard where you can create a new tenant, switch your tenant, or add additional admins to one of the tenants that you are currently an admin on.

There is a "default tenant" that is the one that is selected when you first log in.  If that tenant is not the one you use most often,
you can change the default tenant by selecting "View Profile" from the pull down menu at the upper right of the dashboard.  On that screen, there is a place where you can select the default tenant for your account.
