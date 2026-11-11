---
parent: Pull Requests
grand_parent: Topics
layout: default
title: "Pull Requests: Merge Candidates"
description:  "What does it mean if my PR is a 'Merge Candidate'?"
---

# {{page.title}} - {{page.description}}

During the legacy code phase of the course, you may see this label on one of your PRs:

<img width="134" height="43" alt="image" src="https://github.com/user-attachments/assets/720a1a4b-8bd5-4a74-b571-80fdd66eec0c" />

It may be paired with a points estimate:

<img width="172" height="33" alt="image" src="https://github.com/user-attachments/assets/e6a80b88-8acf-4c84-924c-12dcc02f7fd3" />

This typically happens when the staff member that was reviewing your PR likes everything they saw, but had to restart CI/CD because this button appeared:

<img width="1320" height="168" alt="image" src="https://github.com/user-attachments/assets/97ea9b5e-856c-4b4a-95c5-d7719d5b2321" />

When this appears, it means that the `main` branch has moved since the time you started the branch for the PR, so we have to merge in the latest changes from `main` before your 
branch is mergeable.  (`Rebasing on main` is another way to address this; that's different in terms of how the commit history will look, but the same in terms of the impacts discussed here.)

This restarts the entire CI/CD process.  
* Typically, CI/CD passes, and then your PR gets merged.
* Less often (but it does happen), a new test failure emerges, and the PR has to go back for more changes and a new code review.

When you see this, no action is needed from you or the team, unless CI/CD fails.

If you see that it passes, though, you could ping a staff member and ask them to merge your PR and record the points.
