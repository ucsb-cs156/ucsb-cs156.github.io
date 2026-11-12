---
parent: "Code Reviews"
grand_parent: Topics
layout: default
title: "Code Reviews: Checking  Deployment, and Testing the PR"
description:  "Code review is more than just the code"
---

# {{page.title}}
## {{page.description}}

There are a variety of practices regarding the relationship between two things:
* reviewing the source code for style, patterns/anti-patterns, etc.
* reviewing the deployed app for correctness by actually running it and testing it.

In some organizations, these are entirely separate, done by separate people at separate times.

In others, these are considered part of the same activity, i.e. **code review includes reviewing the deployed code for correctness by testing it**.

**In this course, we adopt the second practice**.

That means that except in a very few corner cases (described below):
* **every PR needs a dokku deployment**
* **every PR needs a test plan**, i.e. a description of a series of steps to take on the deployment to show that the PR works properly
* every code reviewer needs to **check that the deployment is on the same SHA as the PR**
* every code reviewer needs to **actually run the code** on this deployment before marking it LGTM and approving it.

## Checking that the SHA matches

All of our legacy code apps have a feature called "Admin/Developer Info" to show the SHA of the commit that is being run.  

To access this feature, login as an admin, go to the admin menu, and find "Developer Info".

Then, check that the SHA matches the one on the PR.

Here's what that looks like on our apps:

| courses | dining | frontiers | happycows |
|-|-|-|-|
| <img width="231" height="256" alt="image" src="https://github.com/user-attachments/assets/d6ad635a-b0c4-4956-a8e9-d540f193d7c4" />|  <img width="326" height="187" alt="image" src="https://github.com/user-attachments/assets/6a349190-9c07-43de-8aba-e67aa74a153c" />|  <img width="311" height="211" alt="image" src="https://github.com/user-attachments/assets/40708168-a917-44cf-b4e3-e8faae115369" />| <img width="254" height="216" alt="image" src="https://github.com/user-attachments/assets/ccdd938e-0aa4-407a-9a0e-3ff7be33915a" />|

Once you open this page, you can find a section like this:

<img width="605" height="207" alt="image" src="https://github.com/user-attachments/assets/5b4f7c5e-a8e2-49a0-bb00-dcefb3a8dc07" />

The commit hash is what you are looking for, for example `ee08b74` in the screenshot above.

You want to see whether this matches the SHA on the PR, which you can find by clicking on "commits" on the PR:

<img width="992" height="385" alt="image" src="https://github.com/user-attachments/assets/5ae4d26a-9dfe-46cd-905a-154f1df6dbe1" />

In this example, the last SHA is `f7efa30`, so that's the number that should match what's on the deployment.

If the numbers don't match, and you are the code reviewer, **you don't need to go back to the original author to fix this**.  You can **fix it yourself**.   Here's how:
* First, *notify your team member on your team slack channel*, since you are going to do something to "their" deployment.
* Next, log in to your dokku machine, and use a command like this (change the deployment name, quarter, and team name, and the project name as needed)
  ```
  dokku git:sync deployment-name https://github.com/ucsb-cs156-f26/proj-whatever-f26-xx the-branch-name-from-the-PR --build
  ```
When this finishes, the deployment **will** be on the same sha as the PR, and you'll be able to test the PR.

## Test Plan

The test plan should describe the steps you can take, in the app, to show that the
proposed change works as intended.

For simple changes like: "Add a button that allows you to download a CSV of users",
the test plan can be relatively simple, something like:
* Login as an Admin
* Navigate to such and such a page
* Find the button that says: "Download Users as CSV", and click it
* You should get a CSV of the users.

Sometimes, for more complex changes, you may need to:
* Do some set up first ("create a course", "review a menu item", "create a game and enable the chat function") 
* Actually [examine the Postgres database tables](https://ucsb-cs156.github.io/topics/dokku/postgres_command_line.html), or [Mongo database tables](https://ucsb-cs156.github.io/topics/mongodb/mongodb_dokku.html#mongo-command-line).

The point is: you need to be able to show that the changes work properly. 

If you have a PR where it is not obvious how to do that, reach out to your team members for help, or ask the staff.

## PRs where a dokku deployment is not needed

Here are a few cases where you don't need a dokku deployment

### A brand new React Component, not yet integrated into the app

When the change is simply to **_add_ a _brand new_ React component,** along with its Storybook stories, and tests, one that is not _yet_ incorporated into the actual app, you don't need a dokku deployment, because the deployment won't even contain this component. 

In this case, instead of a dokku deployment, go to the Github Pages link for the app. It's found on the main page of your repo on github, and has a link like <https://ucsb-cs156-f26.github.io/proj-courses-f26-01/>.  Then beside your PR number, there is a link for `chromatic`.  This takes you to deployment of the storybook that is specific to the branch from _your PR_.  Go into this storybook, and find the deep links that navigate directly to the story or stories for the new component(s) you created.

### Documentation only changes

Perhaps you are only making changes to the markdown files that document something about the app.  In this case, a dokku deployment is not needed.

### Changes only to workflow files (e.g. `.github/workflows/xx-filename.yml`)

In this case, in place of a dokku deployment, explain how to test the workflow.  Perhaps link to the page where it can be launched, and/or link to the log of a successful run.

### Other cases

There may be other cases I haven't accounted for here. The key rule is: could the running app be affected by what you did?

As an example: if you changed files such as the `Dockerfile or `pom.xml`, this *can* impact the running app, so it is necessary to have a deployment from the branch that shows that when the branch is merged into main, the app can still be deployed without errors.

In this case, testing can be fairly limited; this is sometimes called a "smoke test", which is a throwback to tests in electrical engineering when the most basic test is: "(1) turn on power (2) does it start smoking? If no: then pass.  If yes: then fail.".  In a smoke test, you want to just explore a few basic features of the app: login, try a few things, and make sure everything looks "normal".

