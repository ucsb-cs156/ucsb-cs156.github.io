---
parent: Topics
layout: default
title: Chromatic
description:  "A web-based user interface visualization/testing tool that integrates with Storybook"
has_children: true
---

# {{page.title}}

## What is Chromatic?

According to their [website](https://chromatic.com): 

> Chromatic is a visual testing & review tool that scans every possible UI state across browsers to catch visual and functional bugs. Assign reviewers and resolve discussions to streamline team sign-off.

[Storybook](/topics/storybook) version 8 (which we are migrating to during Summer 2024) integrates with the Chromatic webapp.

## Creating an account

You'll need to create an account on Chromatic.com; we suggest using your Github id so that you'll be able to integrate Chromatic with the Github based projects
you'll be working on in this course.

## Creating a project

When you create a project on Chromatic, it is typically aligned with a specific repo on Github.   

You need to do this in order to obtain a project specific token; this value is placed in both:
* The variable `CHROMATIC_PROJECT_TOKEN` in the `.env` file at the top level of the repo (for using the `npm run chromatic` command from the `frontend` directory)
* The repository Github Actions Secret  value for `CHROMATIC_PROJECT_TOKEN`.

To create a project, navigate to the page <https://chromatic.com> and login.  If you see the following, click at the right hand side of the top navigation where it says *Go to app →*

<img width="925" alt="image" src="https://github.com/user-attachments/assets/bc23ae73-9d95-4d37-b21e-e2ae8d9ea205">
