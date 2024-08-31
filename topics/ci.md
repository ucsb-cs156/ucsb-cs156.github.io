---
parent: Topics
layout: default
title: "CI"
description:  "Continuous Integration--automatically testing after every commit"
---

# Continuous Integration (CI)

Continuous Integration (CI) is an industry standard practice for professional software development.

In short, CI refers to running an automated test suite on the entire code base every time you push a change to any part of that code base.

It is often mentioned in combination with Continuous Delivery, as a combined strategy: "CI/CD".

## Why is it called Continuous Integration?


CI is called *Continuous Integration* because:

* It's *Continuous*: you do it as you push commits into your branch
* It's an *Integration*: you are looking at the impact of your changes *not just* on the parts of the code base you think you are impacting, but on the entire code base as an integral whole.

## What about Continuous Delivery?

CD (Continuous Delivery) has to do with the idea of how often new code "ships" to customers.  Decades ago, when it was typical for new software to be delivered on floppy disks or CD-ROMs, software providers would "ship" (i.e. mail) new software to customers.  Depending on the system, this might happen once a year, three or four times a year, or even monthly.  In this era, even though large internal systems on mainframe computers, in principle, had the ability to update their software at any time, organizations typically emulated the "shipping" model with new releases coming out every three months.

However, as web and mobile applications came online, and the software development methodology shifted from the waterfall model towards more agile models, release cycles shortened, with two week sprints being typical.  This gradually shifted to weekly releases, then daily released, and eventually to the idea of "continous delivery" where new code is deployed to production on an ongoing continous basis as soon as it is tested.

Some commonly used CI systems include:

* Jenkins
* Travis-CI
* GitHub Actions

Starting from Fall 2020, we are using GitHub Actions for CI in this course.

## GitHub Actions

GitHub actions is controlled by files that appear in a subdirectory called `.github/workflows`.

It's the part that controls the "checks" on a PR, for example:

<img width="1013" alt="image" src="https://github.com/user-attachments/assets/00e9017a-80e0-4d40-baa7-e92b3f262df4">

For more information, see: [/topics/GitHub/github_actions.html](/topics/GitHub/github_actions.html)

For specific information on the jobs associated with many code bases in CMPSC 156, see: 

## Travis-CI

NOTE: This information is included because some past versions of CS56, the course that preceeded CS156, used Travis-CI, so there
may still be references in some parts of the course materials to Travis-CI.  However, as of Fall 2020, we are pivoting to
using GitHub Actions instead.

You can use Travis-CI for free on pretty much any open source github.com repo that has a `.travis.yml` file in it.

You log into <http://travis-ci.org> with your github.com username/password in order to set it up.

