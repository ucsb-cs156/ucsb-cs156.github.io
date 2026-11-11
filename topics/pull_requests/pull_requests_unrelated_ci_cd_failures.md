---
parent: Pull Requests
grand_parent: Topics
layout: default
title: "Pull Requests: Unrelated CI/CD Failures"
description:  "When someone else's problem is delaying your PR"
---

# {{page.title}}
## {{page.description}}

One of the more frustrating things that can happen when you are going through the whole "pull request" / "code review" process
in an environment with CI/CD checks is this:

* You have an open PR
* It fails a CI/CD check
* The failure is in an area of the code base that has nothing to do with your code
* The failure might even be happening on the main branch

This is frustrating, because you are trying to make progress on "your" issue, and the thing that is holding you up "isn't your fault".

The temptation is to suggest: "we should go ahead and merge this, because my code is fine, actually".

This motivation is understandable.

Under some circumstances, this may be the way to go, for example:
* If the change is one that is urgently required for some business reason (e.g. it fixes a real bug in prod
that is preventing users from getting things done, or that could cause a paying customer to cancel their account).
* If delaying the change would holding up progress for many other developers

However, under most circumstances, the better approach is to "press pause" on your change, and divert your efforts to 
fixing the underlying bug in a separate, clean issue and PR that you merge separately.

## Why is this my responsibility?

It can be extraordinarily frustrating to be in this position.  You didn't create the mess.  Why is it "your job" to clean it up?

This is where a change in perspective is helpful.

In school, we are each responsible for our own work, and our own "grade" in a course.

And it's true that at a company, so-called "individual contributors" (ICs)--which is the industry jargon for anyone that
isn't a manager--are indeed evaluated periodically as *individuals*.

However, in a real world Agile development environment, one of the typical values is:
* **The responsibility for the code base is a _shared_ responsibility.**

That is, everyone pitches in where there's a problem in the code base.

## Avoid "normalizing" merging broken builds

There is a strong temptation to merge a "broken build" (one that has a red X from CI/CD) when the error in the broken build is unrelated to the changes in the PR.

However, over time, this tends to lead to a sense that "it's ok to ignore CI/CD", because of the "false positives".

When failures that are not treated as failures, it normalizes ignoring the signals.

Eventually, someone merges something into main that is legitimately broken, because everyone got comfortable with ignoring the red X's.

At this point, all of the effort that goes into CI/CD testing starts to become wasted effort.

## What is the relationship to "flaky tests"?

A "flaky test" is one that sometimes passes, and sometimes fails.   ([Wikipedia article on Flaky Tests](https://en.wikipedia.org/wiki/Flaky_test)).

Flaky tests can be caused by many things, but a very common cause is some kind of "race condition", where
multiple threads or processes are involved, and they can complete in different orders, or with different timing that results
in different outcomes (pass vs. fail).

When your code base has flaky tests, there is a risk that folks start ignoring the failures of the tests in question.
This can lead to the same problems as the ones discussed above, that it's not good to "normalize" merging broken builds.

