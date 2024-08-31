---
parent: "Spring/React"
grand_parent: Topics
layout: default
title: "Spring/React: Github Actions"
description:  "The specific Github actions in our stack"
---

# {{page.title}} - {{page.description}}

In the code bases associated with CMPSC 156, we have a standard set of Github Actions.  This pages describes each of those.  For some, there
is also advice on what to do if this job fails.

Note that while these are *mostly* standardized across the code bases, there may be minor variations.  Eventually, it may be
helpful to factor out some of these into custom actions so that there is less duplicate code to maintain.

## Overview

| File | Brief Description |
|-|-|
| `01-gh-pages-pr-table.yml` | Refreshes the main page from the list of PRs |
| `02-gh-pages-rebuild-part-1.yml` | Rebuilds all content for both main branch and PRs and caches it. Operates in parallel.  Stores content in cache rather than deploying to reduce contention for `gh-pages` branch. |
| `04-gh-pages-redeploy-part-2.yml` | Redeploys all content from cache; operates sequentially to reduce contention for `gh-pages` branch |
| `10-backend-unit.yml` | JUnit tests for Java backend |
| `12-backend-jacoco.yml` | Code Coverage for Java Backend |
| `13-backend-incremental-pitest.yml` | Mutation Coverage for Java backend (only on changed files) |
| `14-backend-pitest.yml` | Mutation Coverage for Java backend (on all files) |
| `15-backend-format.yml` | Formatting check on backend; Run `mvn git-code-format:format-code` from root directory to fix failures |
| `30-frontend-tests.yml` | Frontend unit tests (jest) |
| `32-frontend-coverage.yml` | Frontend code coverage (nyc) |
| `33-frontend-pr-mutation-testing.yml` | Frontend Mutation Testing (Stryker), incremental |
| `34-frontend-main-mutation-testing.yml` | Frontend Mutation Testing (Stryker), full |
| `35-frontend-format.yml` | Formatting check on frontend; Run `npm run format` from `frontend` directory to fix failures |
| `36-frontend-eslint.yml` | Linter for frontend code; Run `npx eslint --fix src` from `frontend` directory to list issues to fix |
| `40-check-production-build.yml` | Makes sure that when the backend and frontend are built with `PRODUCTION=true` that the build succeeds. |
| `52-storybook-main-branch.yml` | Build the storybook for the main branch |
| `54-storybook-pr.yml` | Build the storybook for a PR |
| `55-chromatic-pr` | Update chromatic (online storybook and visual difference testing) for a pr to main |
| `56-javadoc-main-branch.yml` | Build the javadoc for the main branch |
| `58-javadoc-pr.yml` | Build the javadoc for a PR |
| `82-pull-request-slack-msg.yml` | When there is a Pull Request, send a slack message |
| `98-copy-issue-by-number.yml` | Copy an issue by number from the original repo |
| `99-copy-issues.yml` | Copy all issues for this quarter from the original repo |

## Details

For details on each job, click the triangle.


<details markdown="1">
<summary markdown="1">
`01-gh-pages-pr-table.yml`
</summary>
Refreshes the main page from the list of PRs.

*If it fails*: Just try rerunning, especially if it fails on the Deploy step.
</details>



<details markdown="1">
<summary markdown="1">`02-gh-pages-rebuild-part-1.yml`</summary>
Rebuilds all content for both main branch and PRs and caches it. Operates in parallel.  Stores content in cache rather than deploying to reduce contention for `gh-pages` branch.

The purpose of this job is to refresh all of the content on the github pages site in the event that the entire site needs to be rebuilt.  Accordingly, it is made up of many smaller jobs.

*If it fails*: Look for which part of it failed, and then consult the advice for the job that's closest in function to the part that failed.  For example, if it failed at the javadoc step, look at the advice about the javadoc jobs (further down on this page.)
</details>



<details markdown="1">
<summary markdown="1">
`04-gh-pages-redeploy-part-2.yml`
</summary>
Redeploys all content from cache; operates sequentially to reduce contention for `gh-pages` branch.

*If it fails*: This one fails often at the Deploy step due to contention for the `gh-pages` branch, so just re-running it often fixes the problem.
</details>



<details markdown="1">
<summary markdown="1">
`10-backend-unit.yml`
</summary>
JUnit tests for Java backend.

*If it fails*: Try running `mvn test` or `mvn clean test` to determine which unit test is failing.  Fix the tests, then run again.
</details>



<details markdown="1">
<summary markdown="1">
`12-backend-jacoco.yml`
</summary>
Code Coverage for Java Backend.

*If it fails*: First, make sure that `mvn test` has a green test suite.  Then try `mvn test jacoco:report` to determine what is failing.  You can also just consult the github pages site for the repo and look under `jacoco` for the PR in question.
</details>



<details markdown="1">
<summary markdown="1">
`13-backend-incremental-pitest.yml`
</summary>
Mutation Coverage for Java backend (only on changed files).

*If it fails*: First, make sure that `mvn test` has a green test suite.  Then try `mvn pitest:mutationCoverage` to determine what is failing.  You can also just consult the github pages site for the repo and look under `pitest` for the PR in question.
</details>



<details markdown="1">
<summary markdown="1">
`14-backend-pitest.yml`
</summary>
Mutation Coverage for Java backend (on all files).

*If it fails*: First, make sure that `mvn test` has a green test suite.  Then try `mvn pitest:mutationCoverage` to determine what is failing.  You can also just consult the github pages site for the repo and look under `pitest` for the PR in question.
</details>



<details markdown="1">
<summary markdown="1">
`15-backend-format.yml`
</summary>
Formatting check on backend.

*If it fails*: Run `mvn git-code-format:format-code` from root directory to fix failures.  Be sure to commit the result.
</details>



<details markdown="1">
<summary markdown="1">
`30-frontend-tests.yml`
</summary>
Frontend unit tests (jest).

*If it fails*: In the frontend directory, run `npm test`. You may need to press `a` to run all tests.  

You also may first need to do these commands if you haven't done them in your `frontend` shell recently:
```
nvm use --lts
npm ci
```
</details>



<details markdown="1">
<summary markdown="1">
`32-frontend-coverage.yml`
</summary>
Frontend code coverage (nyc).


*If it fails*: In the frontend directory, run `npm run coverage`.  

* If tests are failing, fix that first.
* Then address any coverage gaps

You also may first need to do these commands if you haven't done them in your `frontend` shell recently:
```
nvm use --lts
npm ci
```

</details>



<details markdown="1">
<summary markdown="1">
`33-frontend-pr-mutation-testing.yml`
</summary>
Frontend Mutation Testing (Stryker), incremental.

*If it fails*: In the frontend directory, run `npm stryker run`.  

* If tests are failing, fix that first (`npm test`)
* Then address any coverage gaps

You also may first need to do these commands if you haven't done them in your `frontend` shell recently:
```
nvm use --lts
npm ci
```
</details>



<details markdown="1">
<summary markdown="1">
`34-frontend-main-mutation-testing.yml`
</summary>
Frontend Mutation Testing (Stryker), full.
*If it fails*: In the frontend directory, run `npm stryker run`.  

* If tests are failing, fix that first (`npm test`)
* Then address any coverage gaps

You also may first need to do these commands if you haven't done them in your `frontend` shell recently:
```
nvm use --lts
npm ci
```
</details>



<details markdown="1">
<summary markdown="1">
`35-frontend-format.yml`
</summary>
Formatting check on frontend;

*If it fails*:  Run `npm run format` from `frontend` directory to fix problems.  Be sure to commit the result.

You also may first need to do these commands if you haven't done them in your `frontend` shell recently:
```
nvm use --lts
npm ci
```
</details>



<details markdown="1">
<summary markdown="1">
`36-frontend-eslint.yml`
</summary>
Linter for frontend code;

*If it fails*:  Run `npx eslint --fix src` from `frontend` directory to list issues to fix.

You also may first need to do these commands if you haven't done them in your `frontend` shell recently:
```
nvm use --lts
npm ci
```

</details>



<details markdown="1">
<summary markdown="1">
`40-check-production-build.yml`
</summary>
Makes sure that when the backend and frontend are built with `PRODUCTION=true` that the build succeeds.

*If it fails*: Try running the following command from the top level directory, which should produce the same
result as the failing CI/CD run:

```
PRODUCTION=true mvn spring-boot:run
```

Determine what is failing, and fix it.

</details>



<details markdown="1">
<summary markdown="1">
`52-storybook-main-branch.yml`
</summary>
Build the storybook for the main branch.

*If it fails*: From the frontend directory, use: `npm run storybook`.  The Storybook should appear on <http://localhost:6006>.  Determine the problems, and fix them.

</details>



<details markdown="1">
<summary markdown="1">
`54-storybook-pr.yml`
</summary>
Build the storybook for a PR.

*If it fails*: From the frontend directory, use: `npm run storybook`.  The Storybook should appear on <http://localhost:6006>.  Determine the problems, and fix them.

</details>




<details markdown="1">
<summary markdown="1">
`55-chromatic-pr``
</summary>
Update chromatic (online storybook and visual difference testing) for a pr to main. 
  
*If it fails*: It may be an issue with setting the `CHROMATIC_PROJECT_TOKEN`; see <https://ucsb-cs156.github.io/topics/chromatic/> for details.

Locally: Make sure you have a value for`CHROMATIC_PROJECT_TOKEN` set in `.env`, then from the frontend directory, use: `npm run chromatic`.   

On Github Actions, you need to set the `CHROMATIC_PROJECT_TOKEN`  as a repository secret.

</details>


<details markdown="1">
<summary markdown="1">
`56-javadoc-main-branch.yml`
</summary>
Build the javadoc for the main branch.

*If it fails*: From the root directory, run `mvn javadoc:javadoc`.  Look for the errors and fix them.
</details>



<details markdown="1">
<summary markdown="1">
`58-javadoc-pr.yml`
</summary>
Build the javadoc for a PR.

*If it fails*: From the root directory, run `mvn javadoc:javadoc`.  Look for the errors and fix them.
</details>



<details markdown="1">
<summary markdown="1">
`82-pull-request-slack-msg.yml`
</summary>
When there is a Pull Request, send a slack message.

*If it fails*: This is typically something fixed by the staff, so report issues to the staff via the course slack.

Staff: Check that the organization level environment variables are set properly.
</details>



<details markdown="1">
<summary markdown="1">
`98-copy-issue-by-number.yml`
</summary>
Copy an issue by number from the original repo.

*If it fails*: This is typically something fixed by the staff, so report issues to the staff via the course slack.
</details>



<details markdown="1">
<summary markdown="1">
`99-copy-issues.yml`
</summary>
Copy all issues for this quarter from the original repo.

*If it fails*: This is typically something fixed by the staff, so report issues to the staff via the course slack.
</details>




