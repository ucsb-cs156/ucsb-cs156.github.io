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

(Note that the other two uncovered lines in this example, lines 17-18 in `BasicCourseSearchForm.js` were another instance of the same problem, and the solution was nearly identical.)


# Mutation Coverage

To test for mutation coverage locally, we can `cd frontend` and then run `npx stryker run`

Shortly before the table of percentages, we'll get a list of the surviving mutations, such as this one:

```
#4. [Survived] OptionalChaining
src/main/components/BasicCourseSearch/BasicCourseSearchForm.js:17:20
-     const startQtr = systemInfo?.startQtrYYYYQ || "20211";
+     const startQtr = systemInfo.startQtrYYYYQ || "20211";
Ran all tests for this mutant.

#5. [Survived] StringLiteral
src/main/components/BasicCourseSearch/BasicCourseSearchForm.js:17:49
-     const startQtr = systemInfo?.startQtrYYYYQ || "20211";
+     const startQtr = systemInfo?.startQtrYYYYQ || "";
Ran all tests for this mutant.

#9. [Survived] OptionalChaining
src/main/components/BasicCourseSearch/BasicCourseSearchForm.js:18:18
-     const endQtr = systemInfo?.endQtrYYYYQ || "20214";
+     const endQtr = systemInfo.endQtrYYYYQ || "20214";
Ran all tests for this mutant.

#10. [Survived] StringLiteral
src/main/components/BasicCourseSearch/BasicCourseSearchForm.js:18:45
-     const endQtr = systemInfo?.endQtrYYYYQ || "20214";
+     const endQtr = systemInfo?.endQtrYYYYQ || "";
Ran all tests for this mutant.

#178. [Survived] OptionalChaining
src/main/components/PersonalSchedules/PersonalScheduleForm.js:15:22
-       const startQtr = systemInfo?.startQtrYYYYQ || "20211";
+       const startQtr = systemInfo.startQtrYYYYQ || "20211";
Ran all tests for this mutant.

#183. [Survived] OptionalChaining
src/main/components/PersonalSchedules/PersonalScheduleForm.js:16:20
-       const endQtr = systemInfo?.endQtrYYYYQ || "20214";
+       const endQtr = systemInfo.endQtrYYYYQ || "20214";
Ran all tests for this mutant.
```

Here's an analysis of each of these individually:

```
#4. [Survived] OptionalChaining
src/main/components/BasicCourseSearch/BasicCourseSearchForm.js:17:20
-     const startQtr = systemInfo?.startQtrYYYYQ || "20211";
+     const startQtr = systemInfo.startQtrYYYYQ || "20211";
```

The `-` and `+` show lines that were deleted and added.  In this case, the change (i.e. the mutation) is that we removed the `?` after `systemInfo`, replacing the `?.` operator with the `.` operator. 

The thing is, we don't really need a separate test for this.  Regardless of whether systemInfo is undefined, or systemInfo.startQtrYYYYQ is undefined, we want the same behavior.  So this is an example of a mutation we may want to simply ignore, rather than catching with a test.

To do this, we can use a special comment like this one:

```
// Stryker disable next-line OptionalChaining
```

We put this immediately before the line about which Stryker is complaining (in this case, line 16 of `src/main/components/PersonalSchedules/PersonalScheduleForm.js`):

```
    const { data: systemInfo } = useSystemInfo();
    // Stryker disable next-line OptionalChaining
    const startQtr = systemInfo?.startQtrYYYYQ || "20211";
    const endQtr = systemInfo?.endQtrYYYYQ || "20214";
    const quarters = quarterRange(startQtr, endQtr);
```

However, noting that the same problem occurs on the following line, instead we can do this, which disables `OptionalChaining` until we enable it again, two lines later:

```
    const { data: systemInfo } = useSystemInfo();
    // Stryker disable OptionalChaining
    const startQtr = systemInfo?.startQtrYYYYQ || "20211";
    const endQtr = systemInfo?.endQtrYYYYQ || "20214";
    // Stryker enable OptionalChaining
    const quarters = quarterRange(startQtr, endQtr);
 ```
 
 We might then want to see whether this worked. We note that running Stryker on a large code base takes a very long time.  
 
 But, if we have the previous stryker report handy, we can take a short cut: we can just mutate the files that we *know* had problems, and skip the others!  For example, based on this report, we'd only need to do mutation testing on two files.  Can you see which ones?
 
 ```
 -----------------------------------|---------|----------|-----------|------------|----------|---------|
File                               | % score | # killed | # timeout | # survived | # no cov | # error |
-----------------------------------|---------|----------|-----------|------------|----------|---------|
All files                          |   99.14 |      605 |        83 |          6 |        0 |       0 |
 components                        |   97.46 |      205 |        25 |          6 |        0 |       0 |
  BasicCourseSearch                |   63.64 |        7 |         0 |          4 |        0 |       0 |
   BasicCourseSearchForm.js        |   63.64 |        7 |         0 |          4 |        0 |       0 |
  Courses                          |  100.00 |       28 |         0 |          0 |        0 |       0 |
   BasicCourseTable.js             |  100.00 |       25 |         0 |          0 |        0 |       0 |
   CourseForm.js                   |  100.00 |        2 |         0 |          0 |        0 |       0 |
   CourseTable.js                  |  100.00 |        1 |         0 |          0 |        0 |       0 |
  Levels                           |  100.00 |        9 |         0 |          0 |        0 |       0 |
   SingleLevelDropdown.js          |  100.00 |        9 |         0 |          0 |        0 |       0 |
  Nav                              |  100.00 |       22 |        13 |          0 |        0 |       0 |
   AppNavbar.js                    |  100.00 |       19 |        13 |          0 |        0 |       0 |
   AppNavbarLocalhost.js           |  100.00 |        1 |         0 |          0 |        0 |       0 |
   Footer.js                       |  100.00 |        2 |         0 |          0 |        0 |       0 |
  PersonalSchedules                |   88.89 |       16 |         0 |          2 |        0 |       0 |
   PersonalScheduleForm.js         |   83.33 |       10 |         0 |          2 |        0 |       0 |
   PersonalSchedulesTable.js       |  100.00 |        6 |         0 |          0 |        0 |       0 |
  Profile                          |  100.00 |        6 |         0 |          0 |        0 |       0 |
   RoleBadge.js                    |  100.00 |        6 |         0 |          0 |        0 |       0 |
  Quarters                         |  100.00 |        9 |         0 |          0 |        0 |       0 |
   SingleQuarterDropdown.js        |  100.00 |        9 |         0 |          0 |        0 |       0 |
  Sections                         |  100.00 |       57 |         0 |          0 |        0 |       0 |
   SectionsTable.js                |  100.00 |       57 |         0 |          0 |        0 |       0 |
  Subjects                         |  100.00 |        8 |         2 |          0 |        0 |       0 |
   SingleSubjectDropdown.js        |  100.00 |        8 |         2 |          0 |        0 |       0 |
  UCSBSubjects                     |  100.00 |        3 |         0 |          0 |        0 |       0 |
   UCSBSubjectsTable.js            |  100.00 |        3 |         0 |          0 |        0 |       0 |
  Users                            |  100.00 |       19 |         0 |          0 |        0 |       0 |
   UsersTable.js                   |  100.00 |       19 |         0 |          0 |        0 |       0 |
  OurTable.js                      |  100.00 |       10 |        10 |          0 |        0 |       0 |
  SectionsTableBase.js             |  100.00 |       11 |         0 |          0 |        0 |       0 |
 layouts                           |  100.00 |        0 |         1 |          0 |        0 |       0 |
  BasicLayout                      |  100.00 |        0 |         1 |          0 |        0 |       0 |
   BasicLayout.js                  |  100.00 |        0 |         1 |          0 |        0 |       0 |
 pages                             |  100.00 |       80 |         0 |          0 |        0 |       0 |
  Courses                          |  100.00 |       18 |         0 |          0 |        0 |       0 |
   PSCourseCreatePage.js           |  100.00 |       13 |         0 |          0 |        0 |       0 |
   PSCourseIndexPage.js            |  100.00 |        5 |         0 |          0 |        0 |       0 |
  PersonalSchedules                |  100.00 |       22 |         0 |          0 |        0 |       0 |
   PersonalSchedulesCreatePage.js  |  100.00 |       15 |         0 |          0 |        0 |       0 |
   PersonalSchedulesDetailsPage.js |  100.00 |        1 |         0 |          0 |        0 |       0 |
   PersonalSchedulesEditPage.js    |  100.00 |        1 |         0 |          0 |        0 |       0 |
   PersonalSchedulesIndexPage.js   |  100.00 |        5 |         0 |          0 |        0 |       0 |
  SectionSearches                  |  100.00 |        8 |         0 |          0 |        0 |       0 |
   SectionSearchesIndexPage.js     |  100.00 |        8 |         0 |          0 |        0 |       0 |
  AdminLoadSubjectsPage.js         |  100.00 |       10 |         0 |          0 |        0 |       0 |
  AdminPersonalSchedulePage.js     |  100.00 |        1 |         0 |          0 |        0 |       0 |
  AdminUsersPage.js                |  100.00 |        5 |         0 |          0 |        0 |       0 |
  HomePage.js                      |  100.00 |        8 |         0 |          0 |        0 |       0 |
  ProfilePage.js                   |  100.00 |        8 |         0 |          0 |        0 |       0 |
 utils                             |  100.00 |      320 |        57 |          0 |        0 |       0 |
  arrayUtils.js                    |  100.00 |        2 |         0 |          0 |        0 |       0 |
  CoursesUtils.js                  |  100.00 |        6 |         0 |          0 |        0 |       0 |
  currentUser.js                   |  100.00 |       24 |        25 |          0 |        0 |       0 |
  PersonalScheduleUtils.js         |  100.00 |        6 |         0 |          0 |        0 |       0 |
  quarterUtilities.js              |  100.00 |       64 |        12 |          0 |        0 |       0 |
  sectionUtils.js                  |  100.00 |       96 |         0 |          0 |        0 |       0 |
  sortHelper.js                    |  100.00 |       26 |         0 |          0 |        0 |       0 |
  systemInfo.js                    |  100.00 |       10 |         9 |          0 |        0 |       0 |
  timeUtils.js                     |  100.00 |       74 |         0 |          0 |        0 |       0 |
  UCSBSubjectUtils.js              |  100.00 |        6 |         0 |          0 |        0 |       0 |
  useBackend.js                    |  100.00 |        6 |        11 |          0 |        0 |       0 |
-----------------------------------|---------|----------|-----------|------------|----------|---------|

 ```
 
 If you said these two, you are correct:
 
 * `components/BasicCourseSearch/BasicCourseSearchForm.js` 
 * `components/PersonalSchedules/PersonalScheduleForm.js`

To do that, we'd run these two commands sequentially:

* `npx stryker run -m src/main/components/BasicCourseSearch/BasicCourseSearchForm.js`
* `npx stryker run -m src/main/components/PersonalSchedules/PersonalScheduleForm.js`

Where running mutation testing on this entire codebase took 15 minutes on my Macbook Air, running mutation testing on just these two files took 9 seconds, and 7 seconds (respectively).  

The code above took care of the mutation test failures from the original report except for these:

```
#5. [Survived] StringLiteral
src/main/components/BasicCourseSearch/BasicCourseSearchForm.js:18:49
-     const startQtr = systemInfo?.startQtrYYYYQ || "20211";
+     const startQtr = systemInfo?.startQtrYYYYQ || "";
Ran all tests for this mutant.

#10. [Survived] StringLiteral
src/main/components/BasicCourseSearch/BasicCourseSearchForm.js:19:45
-     const endQtr = systemInfo?.endQtrYYYYQ || "20214";
+     const endQtr = systemInfo?.endQtrYYYYQ || "";
```

In this case, the test that we don't have is one that ensures that the values  20211 and 20214 are the ones that are used in the case that we need to use the "fallback" values that appear after the `||` operator; i.e. Stryker is telling us that the test outcomes would be no different if we didn't have this fallback at all.

So we need a test that actually uses these fallback values.

The following page shows how to test dropdowns (which is what these values are used to populate on the screen):

* <https://cathalmacdonnacha.com/how-to-test-a-select-element-with-react-testing-library>

We can use the techniques explained there to write a test that will check that when we use the fallback values, the dropdown for selecting a quarter starts with `20211` (i.e. Winter 2021) and ends with `20214` (Fall 2021).  One way to do that is to assert that there are exactly four quarters in the dropdown.  This actually tests a lot of things at the same time (including whether the `quarterRange` function works properly, so from a "purist" standpoing, one might reasonably question whether this is the best approach.  But we are going to forge ahead and leave that question for another day.

We already have a test that is set up to do most of what we need; it is a test we wrote to get coverage for the fallback values.  

```
test("renders without crashing when fallback values are used", () => {

    axiosMock
      .onGet("/api/systemInfo")
      .reply(200, {
        "springH2ConsoleEnabled": false,
        "showSwaggerUILink": false,
        "startQtrYYYYQ": null, // use fallback value
        "endQtrYYYYQ": null  // use fallback value
      });

    render(
      <QueryClientProvider client={queryClient}>
        <MemoryRouter>
          <BasicCourseSearchForm />
        </MemoryRouter>
      </QueryClientProvider>
    );
  });
```

 Now we need to go further than coverage; we also want to make sure that we can actually use the values.  So we assert that the dropdown contains exactly four quarters (Winter, Spring, Summer and Fall of 2021 to be precise):

```
test("renders without crashing when fallback values are used", () => {

    axiosMock
      .onGet("/api/systemInfo")
      .reply(200, {
        "springH2ConsoleEnabled": false,
        "showSwaggerUILink": false,
        "startQtrYYYYQ": null, // use fallback value
        "endQtrYYYYQ": null  // use fallback value
      });

    render(
      <QueryClientProvider client={queryClient}>
        <MemoryRouter>
          <BasicCourseSearchForm />
        </MemoryRouter>
      </QueryClientProvider>
    );
  });
```
