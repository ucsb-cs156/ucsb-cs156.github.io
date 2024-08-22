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

Then, you should see a page with a top navigation bar like this one:

<img width="1016" alt="image" src="https://github.com/user-attachments/assets/121837fe-0f70-4ddc-8557-f9bfc4cc8083">

Click upper left to expose the menu, and you should see a menu like this:

<img width="262" alt="image" src="https://github.com/user-attachments/assets/d520d7df-0084-41af-ade6-7d3a42beaa50">

Select either your github account, or the github organization that contains the project you want to create.  Note the the repo for this project should already exist.

You should then see a page like this.  Note that `blank-storybook` might not appear; that's a project that I had already created.  

<img width="827" alt="image" src="https://github.com/user-attachments/assets/1d1f446e-f5de-4f5e-ba21-7b072eec77f2">

To create a new project, click the `Add Project` button.  You'll see a list of repos that you can choose from, something like this.  Select the correct repo:

<img width="403" alt="image" src="https://github.com/user-attachments/assets/a6750c8e-f9d4-4fa1-9914-6ca56adff07d">

Youll then see this page.  Click on "Storybook"

<img width="669" alt="image" src="https://github.com/user-attachments/assets/89c4fde4-b395-448f-9171-ece9559ebeec">

On the next page, you'll see some `npm` and `npx` commands; for repos in this course, you typically won't need to use the `npm` commands since support for Storybook and Chromatic will already be built into the project. 

<img width="640" alt="image" src="https://github.com/user-attachments/assets/e903bb97-cc72-4e94-aea3-9c7abe95e641">

However, if you look at the second command, you should go ahead and run it to connect the project to Chromatic.

```
npx chromatic --project-token=chpt_beef1234567890a  
```

In addition, you should copy the value after the `=` sign (e.g. `chpt_beef1234567890a`) and use this as the value of `CHROMATIC_PROJECT_TOKEN`; put it in the `.env` file (which does NOT get committed to Github), and define it as a Github Actions Repository Secret.  (Note that the value above is a fake example value.)

# For more information

See: <https://www.chromatic.com/docs/cli/#chromatic-options>
