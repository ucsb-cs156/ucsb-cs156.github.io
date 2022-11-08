---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Jest Testing"
description:  "Testing and Test Coverage for JavaScript code"
category_prefix: "Testing: "
indent: true
---


# Local Conventions

To run jest on repos set up using the Spring/React conventions used in CS156, use these commands:

Note: All of these are run from the `javascript` subdirectory of the project.

| Command | Description |
|-|-|
|`npm test`| runs the test suite |
|`npm run coverage`| generates a coverage report |


The detailed coverage report (with line-by-line reports for each source file) can be found by opening this file in a web browser:
* `javascript/coverage/lcov-report/index.html`


# Hiding the "Wall Of Red"

When testing with Jest, especially when mocking 404 errors, you can get a wall of red error messages, even on a passing test, like this:

<img width="1124" alt="image" src="https://user-images.githubusercontent.com/1119017/166522677-98da7cf9-f386-4691-b888-f14d6b7aa8c7.png">

To avoid it, you can temporarily redirect the output of console.error.  Note that this can hide error messages that you might sometimes *need* to see,
so use this sparingly.

* <https://dev.to/martinemmert/hide-red-console-error-log-wall-while-testing-errors-with-jest-2bfn>

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


