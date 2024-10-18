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

## How do I get rid of this?

If you are experiencing the "never ending yellow circle" like this:

<img width="309" alt="image" src="https://github.com/user-attachments/assets/0a0615b5-f473-444f-9e29-84d1f8a4238c">

<img width="185" alt="image" src="https://github.com/user-attachments/assets/bc3efebc-3c9b-414c-b43f-bdc988ba85f0">

Here's how to fix it: <https://ucsb-cs156.github.io/topics/chromatic/chromatic_yellow_circle.html>

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


Now, in order to fully connect your project to Chromatic, we need to do a couple things:

in your repository, enter the `frontend` folder:
```
cd frontend
```

Then, run the following command to ensure you have all the files you need for Chromatic to work:
```
npm install
```

Now, back to the Chromatic page: if you look at the second command, you should go ahead and run it to connect the project to Chromatic. **Make sure to use the command Chromatic provides you, and *not the one on this page***

```
npx chromatic --project-token=chpt_beef1234567890a  
```

When this command completes, npm will ask you if you'd like to add Chromatic to `package.json`. Make sure you **click no**, because we do not want to expose this token on Github.

In addition, you should copy the value after the `=` sign (e.g. `chpt_beef1234567890a`) and use this as the value of `CHROMATIC_PROJECT_TOKEN`; put it in the `.env` file (which does NOT get committed to Github), and define it as a Github Actions Repository Secret.  (Note that the value above is a fake example value.)

To add a Github Actions Repo Secret, navigate to the Setting page for the repo, and find this in the side navigation:

<img width="322" alt="image" src="https://github.com/user-attachments/assets/f76e4073-a8d0-4839-ba0e-44e239ef9a4c">

Click `New Repository Secret`

<img width="603" alt="image" src="https://github.com/user-attachments/assets/fa94e858-b4a7-4f34-92fe-0a92d5660f54">

Paste in `CHROMATIC_PROJECT_TOKEN` as the name, and the token value, then click 'Add secret'

<img width="427" alt="image" src="https://github.com/user-attachments/assets/39a8dafd-1aa4-4cc6-a587-cfb5635f1044">

Now, in order to get the green check mark on Github, we need to review our project's changes on Chromatic. Click on your Chromatic project, and click on the latest build. It will present you with a list of visual changes to your repo to approve. Go ahead and look through them, and if they look alright, approve each of them. You should now have a green check mark on Github, but you may need to reload the page.

## Finding the Project Token Later

If you've already created the project on Chromatic and are looking for the project token, here's how to find it.

1. Login to Chromatic.com
2. Find your project and click on it, e.g. `jpa03-pconrad` as shown below:

   <img width="512" alt="image" src="https://github.com/user-attachments/assets/7e06485e-7b2a-4f76-b503-201e7afc8497">
3. The project page should look like this.
   <img width="347" alt="image" src="https://github.com/user-attachments/assets/1ca7c963-61b0-4e76-b362-2d249b1163c5">
   Find the `Manage` icon at left and click it.
4. The project token will appear on the page that comes up.

# For more information

See: <https://www.chromatic.com/docs/cli/#chromatic-options>
