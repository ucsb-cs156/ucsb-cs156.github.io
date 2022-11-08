---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: React"
description:  "How to use Jest and React Testing Library for various scenarios"
category_prefix: "Testing: "
indent: true
---

# Testing for presence of a link

Here's an example:

```javascript
 test("Links are correct", () => {
    const { getByText } = render(<AppFooter />);
    expect(getByText('CMPSC 156').closest('a')).toHaveAttribute('href', 'https://ucsb-cs156.github.io')
    expect(getByText('UCSB').closest('a')).toHaveAttribute('href', 'https://ucsb.edu')
    expect(getByText('GitHub').closest('a')).toHaveAttribute('href', 'https://github.com/ucsb-cs156-w21/proj-ucsb-courses-search')
  });
```

# `No QueryClient set, use QueryClientProvider to set one`; what does this mean?

In this section, we'll explain what this error means and how to address it:

```
    No QueryClient set, use QueryClientProvider to set one
```

Here's an example in context:

<img width="948" alt="failing test with No QueryClient set, use QueryClientProvider to set one" src="https://user-images.githubusercontent.com/1119017/200691434-f33e6119-afc7-458b-9b1c-7c25b7ac697c.png">

In short, what this means is that you are are running a test that is requiring a use of the `useQuery` hook, but the test environment isn't (yet) set up
properly for that.   This might happen if you have a pre-existing test of a React component that didn't previously use the `useQuery` hook, but you made a change to add that, so now the test is failing.  

Here's the test that is failing in the example above:

```jsx
 test("renders correctly", async () => {
        render(
            <Router>
                <PersonalScheduleForm />
            </Router>
        );

        expect(await screen.findByText(/Name/)).toBeInTheDocument();
        expect(screen.getByText(/Description/)).toBeInTheDocument();
        expect(screen.getByText(/Quarter/)).toBeInTheDocument();
        expect(screen.getByText(/Create/)).toBeInTheDocument();
    });
```

The two lines that changed in the `<PersonalScheduleForm />` component that led to the issue were these:

```
import { useSystemInfo } from "main/utils/systemInfo";
```

and

```
    const { data: systemInfo } = useSystemInfo();
```

When we look into `main/utils/systemInfo`, we see that the `useSystemInfo` hook is a wrapper around `useQuery`:

```
return useQuery("systemInfo", async () => {
```

And, as a rule, any React component that uses `useQuery`, needs to be wrapped in a `QueryClientProvider`.  By searching our code base for `QueryClientProvider` we can find some examples of such tests; here's a simple one from `frontend/src/tests/components/BasicCourseSearch/BasicCourseSearchForm.test.js`.  Note that the variable `queryClient` has top level scope inside the `describe("BasicCourseSearchForm tests", () => {` block:

```jsx

describe("BasicCourseSearchForm tests", () => {
 
 ... // several lines omitted
 
 const queryClient = new QueryClient();

 test("renders without crashing", () => {
    render(
      <QueryClientProvider client={queryClient}>
        <MemoryRouter>
          <BasicCourseSearchForm />
        </MemoryRouter>
      </QueryClientProvider>
    );
  });
```

So, our fix is to add this import to our test:

```
import { QueryClient, QueryClientProvider } from "react-query";
```

And then add:
* A declaration for `const queryClient = new QueryClient();`
* Wrapping our test in a `<QueryClientProvider>` element like this:

```jsx

const queryClient = new QueryClient();

test("renders correctly", async () => {
        render(
            <QueryClientProvider client={queryClient}>
                <Router>
                    <PersonalScheduleForm />
                </Router>
            </QueryClientProvider>
        );

        expect(await screen.findByText(/Name/)).toBeInTheDocument();
        expect(screen.getByText(/Description/)).toBeInTheDocument();
        expect(screen.getByText(/Quarter/)).toBeInTheDocument();
        expect(screen.getByText(/Create/)).toBeInTheDocument();
    });
```

# `Error: connect ECONNREFUSED`: what is this?

Another error you may encounter is this one: 

```
 console.error
      Error: Error: connect ECONNREFUSED ::1:80
```

As in this example:

<img width="1086" alt="ECONNREFUSED stack trace" src="https://user-images.githubusercontent.com/1119017/200693681-9fdef873-1b32-43d9-b837-cdae57d1f6e1.png">

At a basic level, this means that the test tried to connect to some network resources, and the connection was refused.  This often means that the frontend component being tested is trying to actually contact a backend endpoint *for real*, when what we probably should be doing in a *unit test* is mocking that dependency.   During a *unit* test (in contradistiction to, for example, an *integration* test or an *end-to-end* test), 
the "real" backend is not running, so *of course* we get a connection refused!

If the diagnosis of the problem leads to the conclusion in the sentence above, i.e. that the frontend component is trying to contact a backend endpoint, the solution is to mock that backend endpoint.  If this is a test that was passing before a change to the code was made, look for a new kind of network request that may be happening. For example, if you added code that would result in a `GET` call to `/api/systeminfo` than you may need to mock that network call.   

We can verify that hypothesis by looking further into the output, where we find this:

```
  Error invoking axios.get:  Error: Network Error
          at createError (/Users/pconrad/github/ucsb-cs156/proj-courses/frontend/node_modules/axios/lib/core/createError.js:16:15)
          at XMLHttpRequest.handleError (/Users/pconrad/github/ucsb-cs156/proj-courses/frontend/node_modules/axios/lib/adapters/xhr.js:99:14)
          
          [ MANY LINES OF OUTPUT REMOVED HERE]
          
          at processTicksAndRejections (node:internal/process/task_queues:83:21) {
        config: {
          url: '/api/systemInfo',
          method: 'get',
``` 

Note the value of `url` and `method`: this confirms what we need to mock.

Note: Another approach would be to mock the call to `useSystemInfo`; that would arguably be a better approach, since mocking the GET to `/api/systeminfo` is really causing the test to depend on implementation details of `useSystemInfo`.   

However: we already have examples in the code base of mocking the GET call to `/api/systeminfo` so that may be more straightforward, even though it's arguably not the "best" approach in terms of testing principles.  Specifically, here's an example from `frontend/src/tests/components/BasicCourseSearch/BasicCourseSearchForm.test.js` of how to mock a call to a GET on `/api/systeminfo`:

```jsx
 const axiosMock = new AxiosMockAdapter(axios);
  beforeEach(() => {
    axiosMock
      .onGet("/api/currentUser")
      .reply(200, apiCurrentUserFixtures.userOnly);
    axiosMock
      .onGet("/api/systemInfo")
      .reply(200, systemInfoFixtures.showingNeither);
  });
```

The `systemInfoFixtures` show different values for the systemInfo, in case we need to set up specific conditions for our test.  In the example used
in this case, we are adding a start quarter and end quarter to values that returned by the `/api/systemInfo` endpoint, so we may need to adjust those
test fixtures.

Here is the final code we added to fix the `ECONNREFUSED` problem in this case:

These two imports:

```jsx
import axios from "axios";
import AxiosMockAdapter from "axios-mock-adapter";
```

And this `beforeEach` function:

```jsx
 const axiosMock = new AxiosMockAdapter(axios);
    beforeEach(() => {
      axiosMock
        .onGet("/api/systemInfo")
        .reply(200, {
            "springH2ConsoleEnabled": false,
            "showSwaggerUILink": false,
            "startQtrYYYYQ": "20154",
            "endQtrYYYYQ": "20162"
        });
    });
```

