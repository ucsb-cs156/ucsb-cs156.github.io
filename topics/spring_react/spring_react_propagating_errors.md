---
parent: "Spring/React"
grand_parent: Topics
layout: default
title: "Spring/React: Propagating Errors"
description:  "Getting errors from backend to a nice message in the frontend"
indent: true
---

# {{ page.title }} &mdash; {{ page.description }}

Sometimes you are in the middle of a controller method, and something goes wrong, and you want to convey a message
to the frontend user.

Here's how to do that:

(1) Throw an exception in the controller.  Pass the error message you want the user to see as a parameter to the exception.

e.g.

```java
throw new IllegalArgumentException("Cannot remove admin from currently logged in user; ask another admin to do that.");
```

(2) Make sure that the `ApiController` has an error handler for the type of exception you threw, e.g. 

https://github.com/ucsb-cs156/proj-courses/blob/ebaff85a99f71f8162cb41da17b0f5ff75d2c0d7/src/main/java/edu/ucsb/cs156/courses/controllers/ApiController.java#L35

```java
  @ExceptionHandler({IllegalArgumentException.class})
  @ResponseStatus(HttpStatus.BAD_REQUEST)
  public Object handleIllegalArgumentException(Throwable e) {
    return Map.of(
        "type", e.getClass().getSimpleName(),
        "message", e.getMessage());
  }
```

(3) In the frontend, be sure that you  pass an `onError` error handler to the `backendMutation` call like this:

https://github.com/ucsb-cs156/proj-courses/blob/ebaff85a99f71f8162cb41da17b0f5ff75d2c0d7/frontend/src/main/pages/PersonalSchedules/PersonalSchedulesCreatePage.js#L24

```javascript
  const mutation = useBackendMutation(
    objectToAxiosParams,
    { onSuccess, onError },
    // Stryker disable next-line all : hard to set up test for caching
    ["/api/personalschedules/all"],
  );
```

(4) Write the `onError` function to get the message and show it to the user in a toast: 

https://github.com/ucsb-cs156/proj-courses/blob/ebaff85a99f71f8162cb41da17b0f5ff75d2c0d7/frontend/src/main/pages/PersonalSchedules/PersonalSchedulesCreatePage.js#L20C1-L22C5

```javascript
  const onError = (error) => {
    toast(`Error: ${error.response.data.message}`);
  };
```
