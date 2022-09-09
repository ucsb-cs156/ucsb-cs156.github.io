---
parent: Heroku
grand_parent: Topics
layout: default
title: "Heroku: Billing and Quotas"
description:  "You should not need to enter a credit card for your work in this course"
category_prefix: "Heroku:"
indent: true
---

We have tried to carefully design our use of Heroku in this course so that we only use the services available on the
tier of Heroku that is **free, and does not require the user of a credit card.**

(Note: the quotas below are accurate, as far as we were able to determine, as of 12/18/2020, but are subject to change at any time,
subject to Heroku/Salesforce's discretion.)

* Each user on this tier gets 550 hours per month. 
* You can monitor your usage on the page <https://dashboard.heroku.com/account/billing> under the heading `Free Dyno Billing`.
* You can also monitor usage at the command line with either this command which measures in hours:
  ```
  $ heroku ps -a app-name

  Free dyno hours quota remaining this month: 799h 43m (79%)
  Free dyno usage for this app: 200h 16m (20%)
  ```
  
  or this command which measures in seconds:
  ```
  $ heroku user:info
  . . .
  account_quota:             3600000
  quota_used:                614439
  ```
  
Source: <https://help.heroku.com/FRHZA2YG/how-do-i-monitor-my-free-dyno-hours-quota>

Deployments for the legacy code apps have to be linked by course staff that have "admin access" on the repos.   Accordingly, those deployments might be linked
to the free hours of course staff accounts, rather than the free hours of individual students in the course.   We will need to do further study of how these
restrictions interact to come up with the best approach.

One work around for giving students access to manage their own deployments of the legacy code repos is to have them work in forks of the main project repos
rather than on the main repo.  

Advantages:
* Students have admin access, and can manage their own deployments.  
  As a result, the hours charged to these deployments are spread over the student accounts, 
  rather than being concentrated in the accounts of staff, which may quickly run out.
* Students gain access with forks
* Students can still do pull requests from forks.

Disadvantages:
* For the students: additional cognitive load of understanding forks.
* For the staff: it becomes harder to track student work, as it can appear in a variety of places; not just in many forks within the original repo, but across an entire
  network of forks.
* If a repo that has been forked is accidentally deleted, restoring it requires cooperation of *everyone* that has done a fork.  This is
  an artifact of how GitHub manages forks and restoration after deletion.
  

# Idling


Heroku will put your web process to sleep after a period of inactivity (it might be 30 minutes to an hour). This shuts down your website until the next request happens; unfortunately, this means the next visitor will incur a *very long delay* while the entire app startup process happens.

This suggests a strategy: set up a script that sends a request to your server periodically to keep it alive.

This comes at a cost; the idling of your application is part of how Heroku is able to provide free service.   I am not 100% sure whether setting up such a script violates Heroku's terms of service for free tier apps.  That should be investigated before anyone adopts this strategy.

In any case, here is a link to an article that explains how to do this using a service called New Relic.  I'm definitely not endorsing this approach unless and until we can be sure it doesn't violate Heroku's TOS.  It's worth noting that the approach taken here (i.e. adding the New Relic add on) requires entering a credit card even if it is "free", since Heroku only allows a very limited number of "add-ons" on the free/no-credit-card tier, and New Relic is not among those.

* <https://coderwall.com/p/u0x3nw/avoid-heroku-idling-with-new-relic-pings>
