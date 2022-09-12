---
parent: Topics
layout: default
title: Bug Reports
description:  "The typical format: STR, observed, desired"
---

# {{page.title}}

There are certain conventions about writing in software development.  One example is a "bug report", which typically has three parts:

* Steps to Reproduce:   This is a list of steps that, if a user takes those steps in the software, the bug will show up.  It's like a recipe for the bug.
* Observed Behavior: This describes the thing that shows up that led the person reporting the bug to be dissatisfied with the software's behavior.
* Desired Behavior: This describes what should have happened, instead of what did happen.

This convention is so widely used, that frequently a bug report would just look like this:

```
Bug: New Admins don't get admin privileges
* STR:
  * Log in as an admin.
  * Add a new admin with email, e.g. `foo@example.org`
  * Then log out, and log back in as `foo@example.org`
* Observed: When logged in as `foo@example.org`, the admin menu does NOT show up;.
* Desired: When logged in as `foo@example.org`, the admin menu DOES show up.
```
