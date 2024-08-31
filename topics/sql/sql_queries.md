---
parent: SQL
grand_parent: Topics
layout: default
title: "SQL: Queries"
description:  "Let the database do the work for you"
---

# {{page.title}}

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

        if(!isStaff)
          throw new StaffNotFoundException(u.getGithubId(), courseId);
```

The answer is: yes, this will work.  This gets all of the members of the course staff, and then searches that list with a linear search to 
see if the user is part of that list. 

This works, *but it's not the best approach*; it is doing way more work that you need to. 

It should typically not be necessary to do a linear search through the results of a database query like the one above.  In this case, you can simply create a database query function
to do the job with one line of code.

In the `StaffRepository`, we add this line of code:

```
    Optional<Staff> findByCourseIdAndGithubId(Long courseId, Integer githubId);
```

Through a technology known as [Reflection](https://docs.oracle.com/javase/tutorial/reflect/) which allows Java code to inspect itself at runtime and create new code, the Spring Data framework will look at the name of this method and *automatically create the necessary SQL query* that backs up this method.  You don't have to even write any code; just declare the method, and Spring Data does the rest.

If you are interested in learning about the various naming conventions and what is possible, you can read more at these links:
* <https://docs.spring.io/spring-data/commons/docs/current/reference/html/#repositories>
* <https://www.baeldung.com/the-persistence-layer-with-spring-data-jpa>

This section is particularly useful, since it shows many examples of the naming conventions:
* <https://docs.spring.io/spring-data/commons/docs/current/reference/html/#repositories.query-methods.query-creation>

With the definition of `findByCourseIdAndGithubId` in the `StaffRepositry`, we can now replace the code above with the much more short and compact:

```java

        User u = getCurrentUser().getUser();
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new EntityNotFoundException(Course.class, courseId.toString()));
        Optional<Staff> staffMember = staffRepository.findById(courseId, u.getGithubId())
                .orElseThrow(() -> new StaffNotFoundException(u.getGithubId(), courseId);
```
