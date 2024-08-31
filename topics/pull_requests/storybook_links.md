---
parent: Pull Requests
grand_parent: Topics
layout: default
title: "Pull Requests: Storybook Links"
description:  "Please include a link to the storybook when UX changes"
indent: true
---

# {{page.title}}

It is very helpful to add a link to the storybook any time you are:
* Adding new storybook story source code files
* Modifying existing React components

The repos we work with in CS156 typically have a github action that publishes a storybook to the repo's Github Pages site every 
time you make a PR to the main branch.

You can find this page by navigating to the repos main page, e.g.

<img width="1165" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/c344733a-1fcd-44d0-a01f-dbe592c392f3">

When you click there, you'll see a page like this one.  Find the storybook link that corresponds to your PR

<img width="880" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/a2586450-ba5c-41d7-a2bf-f2e872e992f3">

Click to go to that storybook.  Then, look in the navigation at left and find the *specific* stories that are relevant to the files added
or changed in your PR.  For example, if adding a new component CoursesTable, you want to find the story for that new component, and bring it up:

<img width="235" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/35d68fc6-0fac-4b4f-b4b8-bcaeee3bac76">

Such as this:

<img width="1146" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/58f9ce6b-3a36-418d-8916-0b91b5e738d0">

Grab that URL, and put it into the PR description, like this:

<img width="831" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/c0d264bc-9b77-4959-bd44-cb4686bce5b8">

This allows folks that are reviewing the PR to immediately go to a deployed example of what the component looks like.
