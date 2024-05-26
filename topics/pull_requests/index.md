---
parent: Topics
layout: default
title: "Pull Requests"
description:  "aka PRs; a checklist for doing them properly"
has_children: true
---

# {{page.title}}

## PR Checklist

(Revised with input from TA Anika Arora, S24)

Here are a few tips when working on PRs. We won't review PRs until all these items have been taken care of, so please read this carefully and ask us if you have any questions!

1.  Remove commented out code (as explained [here](https://ucsb-cs156.github.io/topics/code_reviews/commented_out_code.html)).
2.  Each PR should deal with only *one concern* (i.e. one feature or bug fix).   This makes PRs easier to review and merge. If you have a very large PR, it may not be clear to the reviewers what it's achieving and may take longer to review and merge. [Smaller PRs are better PRs.](https://ucsb-cs156.github.io/topics/pull_requests/#did-i-mention-keep-them-small)
3.  PR Title:
    - Is it descriptive enough that someone familiar with the project can understand it at first glance?
    - Is it short enough to be readable at a glance? (For example, don't try to put the entire "As an X I can Y so that Z" story into the title field.)
    - See also: <https://code-review.tidyverse.org/author/submitting.html#title>
4.  In your PR descriptions, lead with a sentence about what a *user or developer will notice is different*, e.g. 
    * "This PR adds an button to the Foobar table that allows the user to delete a Foobar.  This table is only available to Admins and users with the Wizard role".
    * "In this PR, we bump the version of the jabberwocky npm module to 3.5.1 to avoid a security vulnerability".
    * "We've refactored code in the `BandersnatchController`, factoring out common copy/pasted code into a `validateBanderSnatch` method".
    You can *include* "what you did" (e.g. "I added a button to the form, a deleteParams function in the utilties, etc.")  but don't *lead* with that. That's the "how".  In the first sentence, give us the "what" (what's different?) and the "why" (why is this change helpful?)
    Then be clear about about the original functionality, the changes, and the new functionality. See [below](https://ucsb-cs156.github.io/topics/pull_requests/#pr-descriptions) for more detail.  Include before and after screenshots where possible.
5.  Fix merge conflicts.
    - Merge conflicts with `package-lock.json` are a special case covered here: <https://ucsb-cs156.github.io/topics/spring_react_package_lock_json_merge_conflicts/>
    - If you have other merge conflicts that you don't know how to resolve, ask for help.
6.  Deploy it and link to your deployment:
    * For any change that's even moderately complex, deploy it to a dokku dev instance, and include a link to that in the PR description.  
    * If and only if it's a frontend only change to components not yet accessiblle in the app, link to the Storybook for that PR. Note that it's *automatically published* to the Github Pages page associated with your repo.
7.  Always **start with a new branch** that is an **up to date copy of main** (as described [here](https://ucsb-cs156.github.io/topics/git/git_feature_branch_workflow.html#more-detail-about-creating-feature-branches)), so that we can avoid merge conflicts.
    * The only exception is when it is *absolutely necessary* to branch off an existing branch.  See [here](https://ucsb-cs156.github.io/topics/git/git_feature_branch_workflow.html#more-detail-about-creating-feature-branches) for more details.
8.  Each PR is linked to a branch, so if you're waiting for a PR to be reviewed and starting something else in the meantime, make sure to *make a new branch from main* and then start working on the next issue.  If you don't, then the branch you are working on (and which the staff is trying to review) *becomes a moving target* and you are likely to find that it won't get merged promptly or easily.
9. Linked to an Issue?
    - You can link to an issue with certain magic words such as `Closes #15`, `Fixes #27`
    - But if you don't phrase it just right, the link doesn't happen.
    - In that case, use the manual feature for linking to an issue (see below)
    - If you link to an issue with words like "Closes" or "Fixes", be sure that your PR *entirely* addresses the issue, becuase it will be automatically "closed" (marked as done) when the PR is merged.  If it doesn't close the issue completely use languages like "Partially addresses #5" and then explain in the PR description what is and is NOT addressed.
10.  Linked Issue is in the "In Review" column on team's Kanban board.
11.  PR is tagged with the Team's tag, like this one:
     ![image](https://user-images.githubusercontent.com/1119017/202531598-e935a3eb-98dd-4816-8b0c-434e512e9207.png)
12.  Test cases all pass.
     - If you have difficulty with this one, ask for help from a team member first.
     - Then ask for help on the Slack help channel associated with the project, e.g. `#proj-ucsb-courses-search`, `#proj-ucsb-cs-las`, `#proj-mapache-search` on the slack.
     - Then ask for help during staff office hours or during lecture/discussion work time.

For advice from industry folks, see also: 
* <https://code-review.tidyverse.org/>
* <https://google.github.io/eng-practices/review/developer/> but note that everywhere you see `CL` think `PR` instead (`CL` is Google's internal terminology and stands for "Change List", i.e. a list of the changes in the Pull Request.)

## Code Review Phase
   
Now you are ready for code review, so next steps:

1. Is it still a "draft PR"?  If so, you need to convert it to a regular PR before it can be code reviwed and merged.
2.  Get a code review from a fellow team members.
3.  Get a code review from a member of staff (i.e. an LA, TA, or the instructor)
     - Please consult the page with team assignments (e.g. for W21 that's here: ) to see which LA and TA are assigned to your team. 
     - Request those members of staff first; however anyone on staff can review your PR.
4.  Address all concerns brought up in the code review. This doesn't mean that you have to do exactly as the code reviewer says, but it does mean
    that you can't just ignore what they suggest.  Acceptable ways of resolving a code review concern include:
    - Doing what the code reviewer asks
    - Presenting a good case why you are not going to do that (e.g. "that's a good point, but let's do that in a different issue", or "I see the situation differently; here's my point of view; let's discuss.")
   
# Keeping PRs small and focused

It's good to avoid PRs that have changes to many files in them; fewer than 10 files is ideal.    Especially true if the files span both front and backend.

Sometimes though, it's unavoidable.  In that case, a guide to the changes, as shown in this PR description, can be really helpful to your code reviewers:
* <https://github.com/ucsb-cs156/proj-courses/pull/9>

# Linking a PR to an issue

 You can link to an issue automatically with certain magic words such as `Closes #15`, `Fixes #27`.
 
 But if that doesn't work, here's how to do it manually:
 
![link-PR](https://user-images.githubusercontent.com/1119017/202532386-2108c4b7-3d01-4594-9a50-665d07556c35.gif)
 
 
# Doing a Code Review
 
Many companies use "branch protection" rules in GitHub for their `main` branch (or `master` branch, if using the older convention).

Rules may include the number of code reviews that must be done.  In our case, we are requiring two code reviews, one from the team, and one from a member of staff.

For these code reviews to "count", i.e. to make the PR mergeable, the code review needs to be done *with the right set of mouse clicks* in GitHub. (It isn't enough, for example, to just put a "comment" `LGTM` ("Looks Good To Me"); that comment has to be done *as an approving code review*. 

Here's what that looks like. 

![LGTM-Code-Review](https://user-images.githubusercontent.com/1119017/202532159-d2ea281f-873f-45fc-8c44-b338f3e4f244.gif)


# What to look for in a Code Review?

Students often ask what they should look for in a code review.  

In general, you are looking for any opportunities to make the code better, and/or to find things the developer may have missed. It should be approached in a spirit of "helpful suggestions".

1. It can be helpful to test the code on your team's Heroku deployment at the same time you are reviewing the code.
2. It's good to look for any "commented out code" that the developer may have left in the code while they were debugging, and suggest that it be removed.
3. It's helpful to look for opportunities to make the code "DRYer", i.e. to follow the rule "Don't Repeat Yourself".   Is there copy/pasted code that could be factored out into a common function or method?
4. It's helpful to look for opportunities to improve naming.  Are the variables names, class names, and method names chosen meaningful and helpful to others reading the code?

These are just a few examples to give the idea of the kinds of things you can be looking for.

# Did I mention: Keep them small?

I want to strongly encourage everyone on all teams to submit smaller PRs.

This is an important real world skill, and it's also really, really, helpful to success in this course.
What I would prefer to see:

* A separate PR for the @Entity and @Repository class for a new database table, with nothing else in the PR  (5 pts)
* A separate PR for the frontend fixtures that match a new Entity from the backend, or an anticipated api endpoint. (5 pts)
* A separate PR for a form and/or table component along with the storybook entry and tests for it.  (10 pts)
* A separate PR for the GET/POST endpoints for a new database table entry for CRUD operations. (10 pts)
* A separate PR for DELETE endpoint for a new database table entry. (10 pts)
* A separate PR for UPDATE endpoint for a new database table entry (10 pts)
* A separate PR for any additional backend endpoints; one PR per one or two new endpoints. (10 pts)
* A separate PR for a new frontend Page that brings together preexisting components and calls to a backend api that now exists (and was merged in an earlier PR), including the App.js and AppNavbar modifications  (10 pts)

That's a total of 70 points, and these PRs sail through the review process like sports cars.  They are dead simple to review, and test.

What I'm getting instead, often, is one PR that tries to do 5 or 6 things from the list above, or even ALL of them.  That maxes out at 20 points, leaving points on the table.  It's also much, much, much, harder to code review and test.

It requires dedicated concentration by one of the staff members for perhaps up to an hour.   We try to spread out time among multiple teams, and we also have other tasks.  This will be true of your real world software engineering colleagues too.   It's much easier to get five colleagues to each do a 10 minute code review than to get one colleague to do a 50 minute code review.

Plus: if there are rounds of "revise and resubmit" for your PRs after code reviews find issues, these go much faster on smaller PRs.
Please, please, please take this to heart!

# PR Descriptions

See also: <https://ucsb-cs156.github.io/topics/GitHub/github_pull_requests.html#pr-descriptions>

## PR Descriptions are an important professional skill

One of the things you have an opportunity to practice and master in this class is a super important professional skill.

I'm speaking of the ability to write:
* concise and clear descriptions of issues and pull requests that:
* set up code reviewers immediately to know what to look for
* set up folks testing your code to know immediately how to test and what to test.

If you get a reputation for being good at that, your colleagues will *really* appreciate you.  

But why? Why is this skill so valued?

**Concise, clear PR Descriptions are important for efficient code review and testing**.  

In this course, as in a professional sw dev shop, the folks doing code review and testing are juggling dozens of issues, PRs, parts of the application, even different applications, all day.  Folks need to get through reviewing your PR quickly.  Therefore, they need your help to set the context.   

That's a big part of what the PR description is for: tell the person that's reviewing and/or testing what they need to do to demonstrate that your code works properly.

In this course there are 72-96 of you on 12-16 teams.  Many of you have multiple PRs.  The number of issues across all of the apps and teams is pretty staggering; it's not something that you can expect the instructor, TAs, or LAs to have in their head.  

This isn't a class where "everyone is working on the same problem".  Instead, by design its set up to be a class that tries to simulate the complexity of a large real-world software development organization.  There are four apps, and dozens and dozens of issues. Even when multiple students on different teams are working on the same issue for the same app, they may take very different approaches.

The point is: it if takes me 5 minutes of reading to figure out what you were trying to do, the PR reviewing is going to go very slowly. That's going to be frustating for you, but in actually *has an impact on everyone in the course*. 

Whereas, if you help me by writing a very clear concise summary of what I need to know in order to review and test your code, with me having to click on another page where the issue is described, that's super helpful, again, not just to you, but to *everyone in the course*.


## PR Descriptions need to start with non-technical language

Furthemore, in many organizations, PR descriptions are read by both programmers and non-programmers.

What are the non-programmers doing reading PR descriptions?  They may be going through them to:
* put together updates about what has changed in the app in the past week, month or quarter that are provided to tech support, sales, and customers
* determine what extra testing may need to be done before cutting a new branch from main to  deploy  to prod (i.e. to live customers)
* find "what changed recently" if there is suddenly a big change in performance, new bugs, etc.

So it is important that your PR descriptions include, first, a *brief description of the impact on the end user*, in terms that an end user (or a non-programmer that's very, very familiar with the app from an end user perspective) would understand.

It's ok if you then go on to provide some technical details.   But lead with the *non-technical description*.


See also: <https://code-review.tidyverse.org/author/submitting.html#sec-body>



# Screenshots, Storybook, Swagger, etc.

When doing a frontend PR, you should include, where applicable (and it almost always is):
* Active before and after links to the published storybook.  
  - Before typically comes from the storybook for the main branch that is published on the Github pages site
  - After typically comes from the storybook link for the PR
* Screenshots of before and after; these may seem redundant with the storybook links, but they are not for these reasons:
  - The storybooks will change over time; after your PR is merged, the "before" becomes the "after", and the "after" link for the PR will eventually be purged.
  - The screenshots, though, become a permanent record of what was changed.
  - Plus: the screenshots give your code reviewers an idea of what's in your frontend PR at a glance: "a picture is worth a 1000 words".
 
When doing a backend PR that involves changes to backend API endpoints, especially when you are adding or changing the API, you should include, where applicable:
* Screen shots of the swagger api endpoints affected (before and after if applicable, or just after if it's new)
* Advice on a suggested sequence of actions to test the backend endpoints (e.g. sample values to use).

# PR Titles

On the left are PR titles submitted by actual CMPSC 156 students (with small details 
changed to protect student identity).

| Unhelpful PR titles                          | More helpful PR titles                              |
|----------------------------------------------|-----------------------------------------------------|
| Add CRUD operations                          | Add backend for CRUD operations for RideRequests    |
| Add GET/POST to backend                      | Add GET/POST for CowLots                            |
| Fix PUT route                                | Fix PUT route for personal schedule                 |
| Fred Schools                                 | Frontend for CRUD operations for Schools            |
| Emily Staff                                  | Backend CRUD operations for Staff                   |
| Carly rider frontend part 3 of Epic #17      | Carly: Improve user experience on Driver Shift Create Page |

Do you see the difference? 

The improved titles convey **at a glance** the main information that someone needs to know about your PR.

Who will be looking at these in the real world?
* Your fellow team members
* Folks code reviewing your work
* Folks testing your work
* Tech support folks investigating bugs
* Managers assessing your contributions

It turns out: these titles are really important!  Learning how to write them well is an important job skill.

That's why I'm picky about them.  Your colleagues at your internship and/or job will judge you and your work,
in part, based on (or that the very least, in the context of) your PR titles, so I want you do learn good habits now.
