---
parent: SQL
grand_parent: Topics
layout: default
title: "SQL: Liquibase"
description:  "A database migration framework"
---


# {{page.topic}}

Suppose you have a database table of users, a database table of courses, and a database table of staff members that has these columns:
* id (for the staff table)
* courseId (the id in the course table of the course the staff member is affiliated with)
* githubId (the id in the users table of the staff member)

You want to determine whether or not a given user is a member of the course staff.  Ask yourself: will the following code work?

```java

        User u = getCurrentUser().getUser();
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new EntityNotFoundException(Course.class, courseId.toString()));
        Iterable<Staff> courseStaff = courseStaffRepository.findByCourseId(courseId);

        //check if the user is a staff member of the course
        boolean isStaff = false;
        for (Staff staff : courseStaff) {
            if (staff.getGithubId().equals(u.getGithubId())) {
                isStaff = true;
                break;
            }
        }
```

The answer is: yes, this will work.  This gets all of the members of the course staff, and then searches that list with a linear search to 
see if the user is part of that list. 

This works, *but it's not the best approach*; it is doing way more work that you need to. 

It should typically not be necessary to do a linear search through the results of a database query like the one above; instead, you should be able to create
a SQL query to do the job.

Here's an example of what that might look like.  
