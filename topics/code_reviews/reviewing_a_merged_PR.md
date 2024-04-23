---
parent: "Code Reviews"
grand_parent: Topics
layout: default
title: "Code Reviews: Reviewing a merged PR"
description:  "What that looks like on Github"
---

# {{page.title}}

It is unusual to do a code review on a PR that has already been merged.  

However, there are times during the *course* when, as an exercise, a student may need to do a code review to satisfy the requirements of an assignment,
and there are no open pull requests to review.  In that case, here is a workaround: you can do a review on a merged PR. It looks a little different from the
normal workflow though, so this page exists to show what that looks like.

Steps: 
1. Navigate to the PR
2. Select the `Files Changed` tab.
3. Click the `Review Changes` button at right.
4. Write a comment in the box, e.g. `LGTM` or `I wonder if it would have been better to do it this way ... (explanation goes here)`
5. Click `Submit`

This animation shows what that looks like:

![reviewing-a-merged-PR](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/837c2da7-0f8e-47f1-b1eb-74f094b8c4bd)


And here's what that looks like in the timeline of the PR:

<img width="1033" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/8fcb09a6-4b35-40b2-8fc4-be411f14ea27">

Note the difference:

By contrast, this is what a regular comment looks like:

<img width="1034" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/4c93aa00-a06a-40df-8609-16fbe6cfad89">

## Why does it matter?

It may seem "picky" that we are making a distinction between these two things, but it does actually matter&mdash;one difference is that when you set up something
called [branch protection rules]() in Github, a proper approving "code review" will make a PR *eligble to be merged*, while a simple "LGTM" comment will not.

In the case of an already merged PR, of course it *doesn't* matter.  But we want to make sure that you do understand the difference, so that you don't end up doing it the wrong way at an internship or job later on.
