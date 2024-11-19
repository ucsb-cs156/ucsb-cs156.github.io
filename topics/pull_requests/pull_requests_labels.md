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

These are used to indicate that the staff are blocked from proceeding with this PR for one of several reasons.  The actions that the team needs to take are explained in the table below.

Once the team member has addressed the concern, they should *remove the label* to signal to the staff to take a new look.

These labels use the color bright red, `#D93F0B`, <img width="27" alt="bright red" src="https://github.com/user-attachments/assets/7f98c821-101c-4e56-b2a5-6d3631e3a622">


| Label | Label Text | Description | Interpretation |
|-------|------------|-------------|----------------|
| <img width="125" alt="FIXME-PR Title" src="https://github.com/user-attachments/assets/e89990d0-9f4f-4190-bf7f-201435d64c8c">  | FIXME-PR Title | Please improve the PR Title | See [guidelines for PRs titles](https://ucsb-cs156.github.io/topics/pull_requests/#pr-titles) |
| <img width="162" alt="FIXME-PR Description " src="https://github.com/user-attachments/assets/8f0776ad-70c1-409c-bb9f-1dcc57ad10e0">     | FIXME-PR Description | Please improve the PR Description | See [guidelines for PRs descriptions](https://ucsb-cs156.github.io/topics/pull_requests/#pr-descriptions) |
| <img width="137" alt="FIXME-Team CR |" src="https://github.com/user-attachments/assets/8f627e7e-8e95-4fda-9af0-1906b703e645">    | FIXME-Team CR | Please get a code review from a member of the team | Every PR needs an up-to-date [code review](https://ucsb-cs156.github.io/topics/code_reviews/) from a member of the team before staff will review it.  |
| <img width="212" alt="FIXME-Commented-Out-Code" src="https://github.com/user-attachments/assets/107c37a1-1755-4af2-b610-0e2a4615c45a">    | FIXME-Commented-Out-Code | PRs into main should not contain commented out code | See: [Commented Out Code](https://ucsb-cs156.github.io/topics/code_reviews/commented_out_code.html) |
|   <img width="112" alt="FIXME-deploy" src="https://github.com/user-attachments/assets/ff45cd93-5d36-41c5-a319-6a813dbf72a1"> | FIXME-deploy | Please deploy to dokku and put link in PR description  | For PRs with complex logic changes, staff may want to test the code on a dokku deployment before merging |
|  <img width="136" alt="FIXME-storybook" src="https://github.com/user-attachments/assets/763956cb-7951-4321-aa06-d385981017aa">  FIXME-storybook  |  | Please link to a storybook deployment | For PRs that impact frontend changes, please link to a storybook entry (or entries) that is available fromthe gh-pages website and hosted on chromatic.com (not localhost). Link(s) should go straight to the storybook page(s) for the components/pages changed | 
|       | FIXME-screenshots | Please add a screenshot to the PR description | For PRs that change the user interface, please include screenshots in the PR description | 
|       | FIXME-testplan | Please add a `## Test Plan` section to PR description | For PRs with complex logic changes, code reviewers will need the developer to specify how to test the changes on a localhost or dokku deployment, step-by-step | 
|       | FIXME-link-to-issue | Please link to one or more issues | Use the `Closes #xx` keyword in the PR description | 
|       | FIXME-assign-PR | Please assign the PR to one or more team members | Use the right side-bar on the PR page to assign to one or more team members. | 
|       | FIXME-assign-issue | Please assign the linked issue(s) to one or more team members | Use the right side-bar on the PR page to assign the linked issue(s) to one or more team members. | 


