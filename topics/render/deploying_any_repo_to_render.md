---
parent: Render
grand_parent: Topics
layout: default
title: "Deploying a public repo to Render"
description:  "Getting started"
---

# {{ page.title }}

These instructions allow you to deploy any repo to render, even if it is a private repo.

To deploy a private repo, you need to first add the organization to your render account; the instructions below explain how to do this.

## Step 1: Create Render.com account if you do not already have one.

First, create a Render.com account.  We suggest using either "Login with Google" or "Login with GitHub" to create your Render.com account.

## Step 2: Create a new app

To create a new app, first the blue New button

<img width="1137" alt="image" src="https://user-images.githubusercontent.com/1119017/194428576-e6aa67ca-730e-4102-bd8a-9cdedea54870.png">

Then, chooose "Web Service" from the menu

<img width="450" alt="image" src="https://user-images.githubusercontent.com/1119017/194428627-5392ac6c-43bc-4899-953b-411b2417b1df.png">

## Step 3: Connect a repo

The next screen asks you to choose a repository.  You'll see a box like this one:

<img width="834" alt="image" src="https://user-images.githubusercontent.com/1119017/194430958-a2b6ca8c-e8e9-4a6b-9b63-97b0260097a4.png">

If the user or organization that you want to select a repo from isn't already listed in the list at right that looks like this, you may first
need to click where it says "Configure Account"

<img width="264" alt="image" src="https://user-images.githubusercontent.com/1119017/194433361-890d99cd-bffb-4ee2-88c8-d296101b03cd.png">

And then add the organization (e.g. `ucsb-cs156-f22`) to your account.

Assuming the organization is there, you shoudl be able to select the repo you want to deploy.

## Step 4: Name your app

Next, choose a name for your app.  I suggest that you start all of your names with your githubid, since that will ensure they are unique; for example, if your GitHub id is `cgaucho` and you are working on `jpa03`, you might enter:

<img width="820" alt="image" src="https://user-images.githubusercontent.com/1119017/194431338-e7862c05-a4ca-4792-aff0-bfa0137983dd.png">

Then, for Spring Boot projects, leave `Root Directory` empty, select `Docker` for the Runtime Environment, and select the default for the Region (e.g. `Oregon (US West)`)

Scroll down, and leave the branch as `main` (or select a different branch if you like.)

Choose the free plan: 

<img width="388" alt="image" src="https://user-images.githubusercontent.com/1119017/194431591-e9379343-9163-4e0f-84ff-6ee6290fb033.png">


Then scroll down and click `Create Web Service`

<img width="242" alt="image" src="https://user-images.githubusercontent.com/1119017/194431620-1f4a3b87-d7ba-4c8c-a577-49f46b2f1e9a.png">


## Step 5: Watch the build

That will take you to this screen where you can monitor the build:

<img width="1108" alt="image" src="https://user-images.githubusercontent.com/1119017/194431707-ed338ff4-f512-4bdd-8d3f-9e534fb5bc2c.png">
