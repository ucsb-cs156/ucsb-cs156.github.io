---
parent: Stryker
grand_parent: Topics
layout: default
title: "Stryker: useBackend stryker exceptions (also useBackendMutation)"
description:  "Getting rid of `// Stryker disable next-line all` on `useBackend` and `useBackendMutation` calls"
---

# {{page.title}} - {{page.description}}

Throughout the CS156 code bases , you'll find Stryker exceptions on our calls to `useBackend` and `useBackendMutation`.

Here's an example from `proj-courses`:

```js
  // Stryker disable all : hard to test for query caching
  const deleteMutation = useBackendMutation(
    cellToAxiosParamsDelete,
    { onSuccess: onDeleteSuccess },
    ["/api/personalschedules/all"],
  );
  // Stryker restore all
```

These were legitimate at the time they first appeared in the code base, as the team did not yet understand how to
set up testing for these lines of code that would survive mutation testing.  *But that is no longer the case*.
This article describes how to set up tests for these that will survive mutation testing.
* These should be removed as they are found
* Adding new ones to the code base is *strongly discouraged*

## Some background

Before we discuss how to get rid of the Stryker exception, it's helpful to understand what the query key parameters to `useBackend` and `useBackendMutation` are all about.

Let's take this example from: [PersonalSchedulesTable.js from proj-courses](https://github.com/ucsb-cs156/proj-courses/blob/1cbfb990c1d156256f1694397ed4e62189b2715b/frontend/src/main/components/PersonalSchedules/PersonalSchedulesTable.js#L1)

* Note that the link above is a "permalink" to a specfic commit; the code may or may not look like this in the `main` branch at the time you read this.)
 
```js
  // Stryker disable all : hard to test for query caching
  const deleteMutation = useBackendMutation(
    cellToAxiosParamsDelete,
    { onSuccess: onDeleteSuccess },
    ["/api/personalschedules/all"],
  );
  // Stryker restore all
```

This is from a component called `PersonalSchedulesTable`, which appears on the `PersonalSchedulesIndexPage`.  The table is populated on that page with a call to `/api/personalschedules/all`.
This `useBackendMutation` is making a `DELETE` call to the backend to delete a row in the `PersonalSchedules` table.   When that happens, we want to trigger the `/api/personalschedules/all` endpoint to 
reload the table from the backend so that the deleted line disappears.   We want to do a similar thing when we use `POST` or `PUT` to add rows to a table, or change rows in a table.

The library that is making all of this work is called *React Query*.  It uses a component called a `QueryClientProvider` that you'll find in only one place in the code (apart from code for stories and tests): 
namely in `frontend/src/index.js` (as shown below).

The file `index.js` is called for *every single page in the frontend*, and it wraps `App.js`
which is what renders the application.   By having `<QueryClientProvider client={queryClient}>` and `</QueryClientProvider>` wrapped around `<App />`, every page in the application can utilize
the features of React Query.

```js
ReactDOM.render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <ToastContainer />
      <App />
    </QueryClientProvider>
  </React.StrictMode>,
  document.getElementById("root"),
);
```

You'll also find this in  `frontend/.storybook/preview.js` where it provides a way for Storybook stories to mimic the behavior of components embedded in the application.

The idea is that when you do the `useBackend` call in `PersonalSchedulesIndexPage`, the first parameter sets up the key associated with caching the result of the
call to the backend.  The key can be any string, but we typically use the url of the endpoint as the query key, in this case `"/api/personalschedules/all"`

```js
  } = useBackend(
    // Stryker disable next-line all : don't test internal caching of React Query
    ["/api/personalschedules/all"],
    { method: "GET", url: "/api/personalschedules/all" },
    [],
  );
```

Then, when we make the call to `useBackendMutation`, we pass in this same query key as the one to be *invalidated*, causing the page refresh.

Now that we've covered what's happening in this code, let's discuss how we set up mocks so that we can test for this behavior.  Essentially, we want to ensure that
the correct query key is invalidated when we do the useBackendMutation call.

## Setting up the correct mocks for the test that kills the mutant

The mutation that we want to kill is typically changing the "query key to invalidate" parameter to `useBackendMutation` from a value such as `["/api/personalschedules/all"]` to some other value, which might be any of these:
* `null`, `[]`, `[""]`, `["Stryker was here"]`

To do this, we can simply spy on the calls to `useBackend` and `useBackendMutation` and check that they are called with the correct parameters.



First, we need a variables to set up our spies:

```
// use vi.spyOn instead of jest.spyOn if using vitest 
const useBackendSpy = jest.spyOn(require("main/utils/useBackend"), "useBackend"); 
const useBackendMutationSpy = jest.spyOn(require("main/utils/useBackend"), "useBackendMutation"); 
```


Now you can make tests such as these, replacing `["/api/personalschedules/all"]` with whatever query key you are testing for.

```js
     expect(useBackendSpy).toHaveBeenCalledWith(
        ["/api/UCSBSubjects/all"],
        {"method": "GET", "url": "/api/UCSBSubjects/all"},
        []
      );
```

For `useBackendMutation`, we can use something like this.  This will not test for the exact values of the functions, but it will test for 
arrays and strings:

```
    expect(useBackendMutationSpy).toHaveBeenCalledWith(
      expect.any(Function),
      { onSuccess: expect.any(Function) },
      [],
    );
```

### Important: restore after spying on useBackend or useBackendMutation

It is important that after you set up a `spyOn` for `useBackend` and/or `useBackendMutation` that you restore things to normal, either:
*  at the end of your test
*  in an `afterEach()` block

The code you need is this:

```
    useBackendSpy.mockRestore();
```

or:

```
    useBackendMutationSpy.mockRestore();
```
