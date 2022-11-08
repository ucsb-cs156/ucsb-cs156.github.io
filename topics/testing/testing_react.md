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

# Test Coverage for React Components

To check the test coverage for React components (or any JavaScript code), we use `npm run coverage`, and we get a report such as this one.

The things to pay attention to are the numbers that are less than `100` in the `%` columns, and the `Uncovered Line #s`.

In the example below, there are just four lines in two files that have coverage issues:

* `components/BasicCourseSearch/BasicCourseSearchForm.js`, lines `17-18`
* `components/PersonalSchedules/PersonalScheduleForm.js`, lines `15-16`

```
----------------------------------|---------|----------|---------|---------|-------------------
File                              | % Stmts | % Branch | % Funcs | % Lines | Uncovered Line #s 
----------------------------------|---------|----------|---------|---------|-------------------
All files                         |     100 |    97.84 |     100 |     100 |                   
 components                       |     100 |      100 |     100 |     100 |                   
  OurTable.js                     |     100 |      100 |     100 |     100 |                   
  SectionsTableBase.js            |     100 |      100 |     100 |     100 |                   
 components/BasicCourseSearch     |     100 |       80 |     100 |     100 |                   
  BasicCourseSearchForm.js        |     100 |       80 |     100 |     100 | 17-18             
 components/Courses               |     100 |      100 |     100 |     100 |                   
  BasicCourseTable.js             |     100 |      100 |     100 |     100 |                   
  CourseForm.js                   |     100 |      100 |     100 |     100 |                   
  CourseTable.js                  |     100 |      100 |     100 |     100 |                   
 components/Levels                |     100 |      100 |     100 |     100 |                   
  SingleLevelDropdown.js          |     100 |      100 |     100 |     100 |                   
 components/Nav                   |     100 |      100 |     100 |     100 |                   
  AppNavbar.js                    |     100 |      100 |     100 |     100 |                   
  AppNavbarLocalhost.js           |     100 |      100 |     100 |     100 |                   
  Footer.js                       |     100 |      100 |     100 |     100 |                   
 components/PersonalSchedules     |     100 |    83.33 |     100 |     100 |                   
  PersonalScheduleForm.js         |     100 |    77.77 |     100 |     100 | 15-16             
  PersonalSchedulesTable.js       |     100 |      100 |     100 |     100 |                   
 components/Profile               |     100 |      100 |     100 |     100 |                   
  RoleBadge.js                    |     100 |      100 |     100 |     100 |                   
 components/Quarters              |     100 |      100 |     100 |     100 |                   
  SingleQuarterDropdown.js        |     100 |      100 |     100 |     100 |                   
 components/Sections              |     100 |      100 |     100 |     100 |                   
  SectionsTable.js                |     100 |      100 |     100 |     100 |                   
 components/Subjects              |     100 |      100 |     100 |     100 |                   
  SingleSubjectDropdown.js        |     100 |      100 |     100 |     100 |                   
 components/UCSBSubjects          |     100 |      100 |     100 |     100 |                   
  UCSBSubjectsTable.js            |     100 |      100 |     100 |     100 |                   
 components/Users                 |     100 |      100 |     100 |     100 |                   
  UsersTable.js                   |     100 |      100 |     100 |     100 |                   
 layouts/BasicLayout              |     100 |      100 |     100 |     100 |                   
  BasicLayout.js                  |     100 |      100 |     100 |     100 |                   
 pages                            |     100 |      100 |     100 |     100 |                   
  AdminLoadSubjectsPage.js        |     100 |      100 |     100 |     100 |                   
  AdminPersonalSchedulePage.js    |     100 |      100 |     100 |     100 |                   
  AdminUsersPage.js               |     100 |      100 |     100 |     100 |                   
  HomePage.js                     |     100 |      100 |     100 |     100 |                   
  ProfilePage.js                  |     100 |      100 |     100 |     100 |                   
 pages/Courses                    |     100 |      100 |     100 |     100 |                   
  PSCourseCreatePage.js           |     100 |      100 |     100 |     100 |                   
  PSCourseIndexPage.js            |     100 |      100 |     100 |     100 |                   
 pages/PersonalSchedules          |     100 |      100 |     100 |     100 |                   
  PersonalSchedulesCreatePage.js  |     100 |      100 |     100 |     100 |                   
  PersonalSchedulesDetailsPage.js |     100 |      100 |     100 |     100 |                   
  PersonalSchedulesEditPage.js    |     100 |      100 |     100 |     100 |                   
  PersonalSchedulesIndexPage.js   |     100 |      100 |     100 |     100 |                   
 pages/SectionSearches            |     100 |      100 |     100 |     100 |                   
  SectionSearchesIndexPage.js     |     100 |      100 |     100 |     100 |                   
 utils                            |     100 |      100 |     100 |     100 |                   
  CoursesUtils.js                 |     100 |      100 |     100 |     100 |                   
  PersonalScheduleUtils.js        |     100 |      100 |     100 |     100 |                   
  UCSBSubjectUtils.js             |     100 |      100 |     100 |     100 |                   
  arrayUtils.js                   |     100 |      100 |     100 |     100 |                   
  currentUser.js                  |     100 |      100 |     100 |     100 |                   
  minMax_NoStryker.js             |     100 |      100 |     100 |     100 |                   
  quarterUtilities.js             |     100 |      100 |     100 |     100 |                   
  sectionUtils.js                 |     100 |      100 |     100 |     100 |                   
  sortHelper.js                   |     100 |      100 |     100 |     100 |                   
  systemInfo.js                   |     100 |      100 |     100 |     100 |                   
  timeUtils.js                    |     100 |      100 |     100 |     100 |                   
  useBackend.js                   |     100 |      100 |     100 |     100 |                   
----------------------------------|---------|----------|---------|---------|-------------------
Jest: "global" coverage threshold for branches (100%) not met: 97.84%

Test Suites: 44 passed, 44 total
Tests:       200 passed, 200 total
Snapshots:   0 total
Time:        6.075 s
Ran all test suites.
pconrad@Phillips-MacBook-Air frontend % 
```

We can zero in on these lines by opening up the file `coverage/lcov-report/index.html` in a web browser.  Here's a (partial) screen shot of what that looks like:

<img width="1029" alt="partial screenshot of jest coverage report" src="https://user-images.githubusercontent.com/1119017/200697518-2c98a0a2-ced3-4801-beec-d59eac6575e7.png">

Note the yellow shading shows the coverage gaps; we can then click on the links to the files to get to the listings:

That leads to this screenshot:

<img width="621" alt="image" src="https://user-images.githubusercontent.com/1119017/200697676-cbbdcd24-8496-45fc-8455-df36c7ffa9e7.png">

As we can see, the lines of code that are uncovered are these, and not the entire lines; just the right operands of the logical or operators (`||`):

```jsx
  const startQtr = systemInfo?.startQtrYYYYQ || "20211";
  const endQtr = systemInfo?.endQtrYYYYQ || "20214";
```

The values `"20211"` and `"20214"` here are default fallback values used in the case that either `systemInfo` or `systemInfo.startQtrYYYYQ` doesn't evalute to a "truthy" value (like, not undefined, not null, not false, not empty string).  So to have full test coverage, we'd need to set up a test 
where systemInfo is null, or else doesn't contain the values `startQtrYYYYQ` and `endQtrYYYYQ`.

So we can add a test that includes this:

``` 
          axiosMock
            .onGet("/api/systemInfo")
            .reply(200, {
                "springH2ConsoleEnabled": false,
                "showSwaggerUILink": false,
                "startQtrYYYYQ": null, // use fallback value
                "endQtrYYYYQ": null  // use fallback value
            });

```

