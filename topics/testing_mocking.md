---
parent: Topics
layout: default
title: "Testing: Mocking"
description:  "What is mocking?"
category_prefix: "Testing: "
indent: true
---

The idea of mocking sometimes confuses students.

Let's examine mocking as it pertains to a Spring Boot backend controller method as an example.  
* Though the specifics are different, the general principles apply to other kinds of units under test, including React components in the front end.

A few key ideas about unit testing:
* We want to test the unit under test in isolation
* By unit, we typically mean a single method, function or constructor
* That is, ideally, we want to test the code inside the unit


What we typically do NOT want is for the outcome of the test to rely on the correctness of other units of code we've written, such as:
* APIs or services that this unit calls
* the state of database tables
* etc.

So, we _mock_ these external dependencies.

As an example, suppose that a controller method for looking up information about a student's course schedule does the following:
* It takes a parameter which is the id of the students schedule
* It uses that parameter to look up in the database the quarter in which that schedule takes place, and which user is associated with that schedule
* It then uses that information to look up database records to get the id of each course (e.g. the "enrollCd")
* It then uses those enrollCd values to get details about each course from the curriculum API

A good unit test has three parts:
* Arrange
* Act
* Assert


In the arrange part of this test, we'll need to set up mocks for:
* The database call that looks up the schedule by its id
* The database call(s) that look up each of the courses on that schedule
* The API calls(s) that look up each of the courses.

In Java/Spring Boot code this is typically done with the Mockito `when` method:


Here's an example of mocking an call to a database:

```java
        when(personalscheduleRepository.findByIdAndUser(eq(7L), eq(u)))
           .thenReturn(Optional.of(personalschedule1));
```

Here's an example of mocking an API call to a service:

```java
 when(ucsbCurriculumService.getJSON(any(String.class), any(String.class), any(String.class)))
                .thenReturn(expectedResult);
```

Then, we act: a call to `mockMvc` is used because we don't call a controller method directly; instead, it gets called
whenever the Spring Boot web server receives an HTTP request of a certain type at a certain endpoint.

```java
   MvcResult response = mockMvc.perform(get("/api/personalschedules?id=7"))
                .andExpect(status().isOk()).andReturn();

```

Finally, we assert.  It's typical in any unit test to do assertions on the return value:

```
 String expectedJson = mapper.writeValueAsString(personalschedule1);
        String responseString = response.getResponse().getContentAsString();
        assertEquals(expectedJson, responseString);
```

But, when using mocks, it's typically good practice to _also_ use `verify` to check whether the mocks that we set up using `when` were called in the way 
we expected them to be called:

```
 verify(personalscheduleRepository, times(1)).findByIdAndUser(7L, u);
```

