---
parent: Legacy Code
grand_parent: Topics
layout: default
title: "Legacy Code: Staff Epic Planning"
description:  "Description of the process course staff uses to plan epics"
category_prefix: "Legacy Code: "
indent: true 
---

This page is intended for course staff.  Having said that, there's no harm in reading it if you are student and interested in the process.

# Epic Planning

The design of the course is based on teams of students working on legacy code projects.   A few baseline assumptions:

* There are typically between 1-4 teams working on any given project, with the usual number being 3 or 4.
* Each team is typically 4-6 students, with the usual number being 5 or 6.
* Students will complete issues and get the code for the issue merged into `main`, and in doing so they earn points for their teams.
* Teams need to earn 100 points over the course of the project.

# Point Values

Issues are estimated by staff in terms of their point value.  
- The most trivial issues that require almost no research and can be done quickly are worth 5 points.
- Point values go up from there, but typically are 10 points, 20 points, and 40 points.

Similar to the point values in Agile Point Poker, or Story Point Estimation, the scale is not necessarily linear, and not necessarily directly related to time.  
* 10 points stories tend to be straightforward,  isolated to a single aspect of the code,  impact  relatively few files or lines of code. Testing is straightforward.
* 20 points stories tend to be a bit more complex, and perhaps involve the interaction between mutiple areas or aspects of the code, or require complex
  mocking and stubbing to acheive good test coverage.
* 40 points stories should be rare, in the sense that is is usually best practice to take anything that complicated, and break it down into multiple 10 and 20
  point stories.    
  
  However, if a particular story breaks new ground (i.e. a student team has taken on a new technology, new approach, or new kind of feature
  that was not in the code base before), it may be a good candidate to be a 40 point story.  A good rule of thumbs is that in 10 and 20 point stories,
  the students are learning from the staff.  If a team completes a story where the staff is learning from the students, that might be a good candidate
  to be a 40 point story.
  
We avoid other point values, in order to keep things simple.   One corner case, though is when two different issue get combined into a single PR; in this case,
perhaps one of those is a 10 point story, and another is a 20 points story.  In this case, the team might be awarded (10 + 20) = 30 points for the PR; but at the
story level, we are still sticking to 5,10,20,40 as our point values.


# "Starter Stories"

We typically look for two kinds of issues/stories that students can work on:

* Good First Issues (sometimes called "Starter Stories" or "low hanging fruit").   These are intended to be stories that students can complete during their first sprint, 
  when the primary learning objective is *the process*, rather than detailed coding skills or domain knowledge.   

  These issues tend to be worth 5 points if they
  are truly trivial (5 points is the minimum we award for getting a story through the pipeline).   Rarely, if one ends up being more complicated than we thought,
  or the student takes special initiative to go beyond what was outlined, these may blossom into 10 points stories.

* Regular Issues: Ones that might require some signficant learning and effort, and will typically be worth 10,20 or 40 points.

With starter stories, the emphasis is on keeping the story as simple as possible, so that students in their first sprint 
get used to and learn *the process* rather than learning specific coding skills.

By *the process*, in this case, what we mean is: taking on a story, tracking on the Kanban board, making feature branches, commits, a pull request, getting
code reviews, and finally seeing the PR merged into `main`.
  
Starter stories therefore are best when they are almost completely "cookbook", in the sense that the actual code changes are fairly trivial to make,
and/or the code changes and/or tests that need to be written are either 
* spelled out in detail within the story itself (written by the staff), or
* can be inferred by looking at the PR for a similar issue.

Some examples:
- Adding or replacing a `favicon`
- Fixing some text on a page
- Minor CSS adjustments
- Changes to configuration or minor code changes that have predicable effects and have been well-tested on other projects, or are directly analogous to
  the types of code changes students have already experienced in practice exercises.
    
 
