---
parent: Pull Requests
grand_parent: Topics
layout: default
title: "Pull Requests: Labels"
description:  "Meaning of the standard labels used in CMPSC 156 for PRs"
indent: true
---

# {{page.title}} - {{page.description}}

We have developed a standard set of labels that the staff use when reviewing PRs during the legacy code phase of the course.

This page is a guide to what those labels mean, and how to work with them.

## Points Labels

Labels that use the color gold (#FBCA04), <img width="29" alt="color #FBCA04" src="https://github.com/user-attachments/assets/2ff53b01-c31e-4b72-83e9-dea1fafbf521">
should be added only by the staff, and signify the number of points that a PR is worth towards the project grade for the team.

| Label | Label Text | Description | Interpretation |
|-------|------------|-------------|----------------|
|  <img width="43" alt="5" src="https://github.com/user-attachments/assets/6cb7ef28-846f-4d9e-adde-32332346ba5d">  | 5   | 5 points | A very straightforward, relatively simple change |
|  <img width="52" alt="10" src="https://github.com/user-attachments/assets/755debee-dd1e-43cb-9007-765a3db30d13"> | 10 | 10 points | A reasonably complex change (the normal case for most PRs) |
|  <img width="57" alt="20" src="https://github.com/user-attachments/assets/016b9e5c-92b7-45ed-a28a-c627fc2d2b6f">  |20  | 20 points | *Rarely used*.  Reserved for changes that show signficiant initiative or effort, typically something beyond the normal expectations for the course.|

There is also a 0 points value label (<img width="52" alt="0" src="https://github.com/user-attachments/assets/fc3515e4-6aa8-43b7-a262-df060befcde9">), which is sometimes used to mark:

* PRs where the target is not the main branch
* PRs that restore a previously merged PR that earned points, but was temporarily reversed for some reason.
* In some cases, for PRs that fix a bug with previously merged code (this is at the discretion of the staff; these are decided on a case-by-case basis).


## FIXME labels

These are used to indicate that the staff are blocked from proceeding with this PR for one of several reasons.  The actions that the team needs to take
are explained in the table below:

| Label | Label Text | Description | Interpretation |
|-------|------------|-------------|----------------|
|       | FIXME-PR Title | Please improve the PR Title | See [guidelines for PRs titles](https://ucsb-cs156.github.io/topics/pull_requests/#pr-titles) |
|       | FIXME-PR Description | Please improve the PR Description | See [guidelines for PRs descriptions](https://ucsb-cs156.github.io/topics/pull_requests/#pr-descriptions) |
|       | FIXME-Team CR | Please get a code review from a member of the team | Every PR needs an up-to-date [code review](https://ucsb-cs156.github.io/topics/code_reviews/) from a member of the team before staff will review it.  |
|       | FIXME-Team CR | Please get a code review from a member of the team | Every PR needs an up-to-date code review from a member of the team before staff will review it  |
|       | FIXME-Commented-Out-Code | PRs into main should not contain commented out code | See: [Commented Out Code](https://ucsb-cs156.github.io/topics/code_reviews/commented_out_code.html) |


