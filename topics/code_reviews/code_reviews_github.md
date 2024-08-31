---
parent: "Code Reviews"
grand_parent: Topics
layout: default
title: "Code Reviews: GitHub"
description:  "The right (and wrong) way to do a code review in GitHub "
---

# {{page.title}}

There is another page that talks about the _content_ of a code review here:
* <https://ucsb-cs156.github.io/topics/code_reviews/>

This page talks about the _process_ of doing a code review in GitHub, meaning the series of mouseclicks in the GitHub web interface that you need to 
do so that the code review "counts".

# Doing it properly

Do it like this:
* Go to the `Files Changed` menu
* Scroll through and look at the changes
* If they all look good, click the <img width="184" alt="Review Changes" src="https://user-images.githubusercontent.com/1119017/170560166-0161b8a5-c0ff-4941-a1b6-798d64d36dc1.png"> button
* Enter `LGTM` and _click on Approve Changes_, i.e. <img width="451" alt="Approve Changes" src="https://user-images.githubusercontent.com/1119017/170560341-51be368c-12a7-4365-8e54-570e54348d35.png">
* Then click <img width="154" alt="Submit Review" src="https://user-images.githubusercontent.com/1119017/170560387-a33029a1-2358-4626-be23-41203f88b182.png"> (Submit Review).

The animation below shows the process for doing a correct "LGTM" code review.

![lgtm-code-review](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/494d9027-bc9b-40b6-a8f8-cac4d3899207)

# Requesting Changes (properly)

Here's how to do a code review that requests changes:

![request-changes-code-review](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/0114dcdf-4474-44ef-a60b-1ca99cd6be1b)

# A _comment_ that says `LGTM` is _not_ a code review.

Not a code review:

![dont-do-this](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/67b1fe6b-c9f3-4cc1-a058-ca58d223f3a4)

I mean, it _is_, but not from the standpoint of GitHub.  If there are _branch protection_ rules in place that require a code review before 
the PR can be merged, a _comment_ does not trigger the PR to be mergeable.

Only a properly done code review does.

