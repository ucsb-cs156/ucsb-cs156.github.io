---
parent: Legacy Code
grand_parent: Topics
layout: default
title: "Legacy Code: Setup"
description:  "What the staff needs to do to setup a new legacy code project"
---


# {{page.title}}

## {{page.description}}

Setting up a legacy code project for CMPSC 156 involves many steps. This page focuses on just the steps needed to get the starter code set up for a new quarter.

## What we are trying to set up

This article starts by describing how the legacy code phase in CMPSC 156 runs, and what the starting state needs to look like. (The rest of the article describes what steps are needed to set that up.)

* At the start of the legacy code phase in the project, there is a starter repo containing a working legacy code app.
  * These repos live in in the github org <https://github.com/ucsb-cs156> and have names such a `proj-courses`, `proj-happycows`, `proj-gauchoride`, and `proj-organic`.  We will call these repos the *main project repos*, to
  * distinguish them from the student team repos.
  * Along with the starter code, there is also a github project that has a variety of Github issues.
  * A *subset* of those issues will be tagged with a tag corresponding to the quarter (e.g. `w24`, `s24`, `f24`, etc.).  These are the issues that will get copied to the
    Kanban boards of the individual student teams.
* Students are provided a clone of the `proj-xxx` repo in the course organization, for example, `https://github.com/ucsb-cs156-w24/proj-organic-w24-6pm-4`
  * This repo is pre-populated with the starter code
  * It also has a Kanban board that has been populated by manually running a Github Action (workflow) that copies the issues from the main project repo's Kanban board that are tagged with the current quarter.
  * In case issues are added to the main kanban board here is also a workflow to bring over new issues one at a time that are added later on.

For each legacy code project (e.g.  `proj-courses`) there are typically multiple teams that will be working on that project (typically four), each of which is working from the same set of issues, and in a sense, 
competing with the other teams working on the same project. At the end of the quarter, there is a process involving both peer review by students, as well as review by the course staff that culminates in choosing one 
of the four code bases as the one that continues as the basis of the next quarter's project.

So, the process of setting up a new quarter starts with choosing the "winning" team for each of the projects that will be set up.

## Step 1: Choosing the winning teams

The process of choosing a winning team starts with an activity where each of the student teams presents:
* Their final main branch, deployed to both prod (with only staff and the team having admin access) and qa (with all students in the course having admin access)
* A set of release notes, explaining all of the PRs that were merged into main over the course of the quarter, with an empahsis on the impact on the end user, and secondarily the impact on developers of any refactoring of the code or improvements that are developer focused.
* A 5-8 minute video demonstrating the work of the team.

These are all assessed both by students in the class, and the course staff (instructor, TA, LA).

The results are compiled.  In the case where there is a clear winner, that team's work is chosen. In cases where there is not a clear winner, the course staff takes a closer look (this could be the course staff of the
previous quarter or the new quarter, depending on timing.)

Eventually the winners are identified, and a pinned post can be made in the staff slack channel such as this one: 

<img width="459" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/f407c0d1-ac3d-4299-8f8b-89f06da2ad85">

## Step 2: Set up PR for each of the winning teams code

Next, for each of the project repos, make a PR for that teams code. Here's what the sequence of commands might look like:

```
cd github/ucsb-cs156/proj-happycows
git checkout main
git pull origin main
git remote add w24-4pm-2 git@github.com:ucsb-cs156-w24/proj-happycows-w24-4pm-2.git
git fetch w24-4pm-2
git checkout -b w24-4pm-2
git reset --hard w24-4pm-2/main
git push origin w24-4pm-2
```

Then create a Pull Request by opening the url, for example: <https://github.com/ucsb-cs156/proj-happycows/pull/new/w24-4pm-2>
```

The pull request might have a description such as this one.  Note that `url-goes-here` is a placeholder; we'll discuss getting those release notes into the repo
in a moment.

```
In this PR, we bring over all of the work of the CS156 team w24-4pm-2.

[Release Notes](url-goes-here)
```

## Step 3: Release Notes

Note: starting with S24/F24, this step may become less necessary, since we'll try to incorporate the PDF of the release notes into the workflow, or else ask that the release notes be in markdown format.

Now, find the release notes from the winning team, and if they are not in markdown format (e.g. if they are in a Google Drive document), convert them to PDF.

Working in the branch for the winning team in the main project repo, add a commit that adds a `docs/release-notes/w24-4pm-2.pdf` file.

Then, get the link to that file (on the new branch) and replace it in the PR description; for example:

```
This PR incroporates all of the changes from the CS156 team w24-4pm-2.

[Release Notes](https://github.com/ucsb-cs156/proj-happycows/blob/w24-4pm-2/docs/release-notes/w24-4pm-2.pdf)

```

## Step 4: Code review, Test, Fix PR to get ready to merge

The next step is a bit onerous, because you now have a massive PR to review.  Fortunately, it should have been reviewed in smaller pieces during the previous quarter, so this is mostly a spot check.

Make sure also that the team didn't adjust things in the README that are specific to the team (e.g. links to their own deployments, etc.) and that there aren't any stray files that got included in their main branch.

Try deploying the app to qa, and throughouly testing. Make sure that the various links on the Github pages for the PR work, especially the Storyboard.

## Step 5: Merge PR to main

When all is ready, merge the PR to main.

## Step 6: Prepare issues

Now work on the issues lists.  For each issue from the previous quarter, determine whether *all* of the acceptance criteria are met. Sometimes the team only got halfway through an issue, or their work leads to
a logical next issue.  Close what should be closed, and make new issues where needed.  Where appropriate, you can close issues with `Addressed in PR #x`where `x` is the number of the PR for the winning team's work.

In the end, you want to be sure that there is a good set of issues tagged with the next quarter, and that any obsolete issues have been closed

## Step 7: Setup team repos

When the issues list looks good, you can set up kanban boards and team repos in the normal way (similar to how they were set up for team01, team02, and team03), and then run the Github action to populate the Kanban boards.


Then, you are ready for the new quarter!


## Side note: Why not forks?

Readers that are familiar with Github's *fork* feature may be wondering why we do not use forks in CMPSC 156; more specifically: why do we not create the student team repos as *forks* of the main project repo?

There are several reasons:

* The most important reason is that if a student repo is a fork of the main repo, then each time a student creates a pull request, *by default*, that pull request goes to the main project repo, and not the forked student team repo.
  * While it is *possible* to specify that the PR goes to the forked repo, the fact that this is not the default presents a barrier to novices and experienced Github users alike.
  * A fork to the main project repo is not what we 
    want, because it creates a situation where many teams are trying to merge PRs into the same repo.  This is only feasible if each of the teams is given *separate* issues to work on.  If the teams are working from the *same* set of issues,
    then once the first team's PR is merged, the other PRs are useless/meaningless.   So we need the PRs during the legacy code phase to be to separate PRs.
* Another reason is that the default fork workflow makes it difficult to have more than one fork of a repo within a given organization.  Having a single Github organization correspond to a specific offering of course
  in a specific term (i.e. a specific course roster of students that are all getting grades for the same course) provides many conveniences.  But the limitation of only a single fork of a repo (without extensive strange workarounds)
  makes the fork workflow less attractive.
   
