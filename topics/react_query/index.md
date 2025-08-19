---
parent: Topics
layout: default
title: React Query
description:  "The library that lies beneath useBackend and useBackendMutation"
has_children: true
---

# {{page.title}}

Our CS156 code bases contain two custom hooks: `useBackend` and `useBackendMutation` that are wrappers around hooks provided by a library called *React Query*.

* `useBackend` is a wrapper around `useQuery`
* `useBackendMutation` is a wrapper around `useMutation`

## Mocking React Query

Note: There is another article that shows what may be an easier way to deal with Stryker Mutations on these calls here:
* <https://ucsb-cs156.github.io/topics/stryker/stryker_useBackend_stryker_exceptions.html>

We're leaving this up for now, because it still provides some useful background information on React Query, and because
there is at least one place in the code base that uses this approach.

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

Before we discuss how to get rid of the Stryker exception, we need to understand what the query key parameters to `useBackend` and `useBackendMutation` are all about.

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

To do this, we need to spy on the `QueryClient` object, and ensure the `["/api/personalschedules/all"]` parameter is passed through to it with an call to the method that
invalidates the query key.

First, we will need this import.   

```
import { QueryClient, QueryClientProvider } from "@tanstack/react-query"; // or just `react-query` in older code bases
```

Then, we need two variables to set up our query client mock: `queryClient` and `invalidateQueriesSpy`:

```
describe("Tests for (insert component name here), () => {
  let queryClient;
  let invalidateQueriesSpy;
```

We need a `beforeEach` and `afterEach` block like this.  Note that you may already have
beforeEach and afterEach blocks, in which case you should combine this new code with what's
already there:

```js
 beforeEach(() => {
    queryClient = new QueryClient({
      defaultOptions: {
        queries: {
          retry: false,
          refetchOnWindowFocus: false,
        },
      },
    });
    invalidateQueriesSpy = jest.spyOn(queryClient, "invalidateQueries");
    // ... anything else you need in your beforeEach, e.g. stuff for AxiosMock
  });

  // After each test, restore the original axios implementation and clean up.
  afterEach(() => {
    invalidateQueriesSpy.mockRestore(); // Restore original implementation of the spy
    queryClient.clear(); // Clear the React Query cache
    // ... anything else you might need in your afterEach
  });
```

When you render the component, be sure it is wrapped in a `<QueryClientProvider>`, like this:

```
      <QueryClientProvider client={queryClient}>
        <YourComponentGoesHere />
      </QueryClientProvider>,
```

Depending on the context, there may be other wrappers, e.g. `<MemoryRouter>` or `<BrowserRouter>`.  The `<QueryClientProvider>` goes on the outside of the other wrappers.

Now you can make tests such as these, replacing `["/api/personalschedules/all"]` with whatever query key you are testing for.

```
    expect(invalidateQueriesSpy).toHaveBeenCalledTimes(1);
    expect(invalidateQueriesSpy).toHaveBeenCalledWith({
      queryKey: ["/api/personalschedules/all"]
    });
```


