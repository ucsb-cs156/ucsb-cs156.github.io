---
parent: Agile
grand_parent: Topics
layout: default
title: "Agile: Acceptance Criteria"
description:  "What should be true when a user story is successfully implemented"
indent: true
category_prefix: "Agile: "
---


Suppose you are working on a GitHub issue to implement a [User Story](https://ucsb-cs156.github.io/topics/agile_user_stories/).

How do you know when you are finished?

It is helpful if there is a checklist of _acceptance criteria_:
* Each acceptance criterion is a statement that can be _observed to be true by a user_ when then the story is finished.
* As a group, the acceptance criteria should define what it means for the story to be finished&mdash;that is, the story is finished if and only if _all_ of the acceptance criteria are complete.

Example:

User Story: As a user, I can add a course to one of my personal schedules, so that I can track my schedule quarter by quarter in the ucsb-courses-search app.

Acceptance Criteria:
- [ ] When a user is logged in, on each course listing that can be added to a schedule, there is an "add to schedule" button.
- [ ] "Add to schedule" buttons do NOT appear when the user is not logged in.
- [ ] "Add to schedule" buttons appear on discussion sections for courses with discussion sections ("secondaries"). They appear on the lecture (the "primary") for courses that don't have secondaries.
- [ ] When you click the "Add to Schedule" button, you are presented with a way to select which of your personal schedules you want to add the course to.   If you have no personal schedules defined, there is a suitable error message (possibly with a link to the page where you can create new personal schedules).  This might be in a modal, for example.
- [ ] When you select a schedule from the list of schedules you are presented with, your course is added to that schedule, and you get some kind of visual feedback that the add was successful.  This might be in the form of a "toast message" or it might be that you are redirected to the show page for the selected personal schedule.

Note that the Acceptance Criteria try to stay at a high level; they don't necessarily pin down every implementation detail.

# Acceptance Criteria (ACs) are NOT TODO items

A common misunderstanding / misconception is revealed when developers put "todo" items in the list of acceptance criteria (ACs).

Issues may have a list of TODOs that the developers know need to be done in order to finish the issue.  But this is separate from the list of ACs.

Note that acceptance criteria should be _observerable by a user_.

The following are NOT acceptance criteria:
- [ ] There is a database table that stores `schedules` that stores each of the users personal schedules
      - Database tables are not observable by an end user.  Instead say what the user can see: describe the create/read/update/destroy (CRUD) operations that the user can
        do on personal schedules.
- [ ] Add a new database table `scheduled_courses` that contains information about a course.  Should have a foreign key link to the `schedules` table.
      - This is fine as a "TODO" item but not as an AC
      

