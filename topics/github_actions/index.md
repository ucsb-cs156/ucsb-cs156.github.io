---
parent: Topics
layout: default
title: "GitHub Actions"
description:  "CI/CD pipeline hosted on Github, aka workflows or checks"
has_children: true
---

# {{page.title}} - {{page.description}}

## Workflows Commonly Found in CS 156 projects

Note that our code based is constantly being updated.  If the documentation and code disagree, beleive the code and update the documentation.

| Workflow Name | Description | 
|---------------|-|
|`01-gh-pages-pr-table.yml`| Resets the collection of Pull Requests used to build the GH Pages site. |
|`02-gh-pages-rebuild-part-1.yml`| Rebuilds all of the elements of the GH pages site (in parallel), but does not deploy them |
|`04-gh-pages-redeploy-part-2.yml`| Deploys all parts of the GH pages site sequentially (to avoid conflicts). |
|`10-backend-unit.yml`| Unit tests for backend Java code |
|`11-backend-integration.yml`| Integration tests (not really backend; should be renamed) |
|`12-backend-jacoco.yml`| Test coverage for backend Java code |
|`13-backend-incremental-pitest.yml`| Mutation Coverage (incremental) for backend Java Code |
|`14-backend-pitest.yml`| Mutation coverage (full) for backend java code  |
|`30-frontend-tests.yml`| Unit tests for frontend code |
|`32-frontend-coverage.yml`| Test Coverage for Frontend Code |
|`33-frontend-pr-mutation-testing.yml`| Mutation Coverage for Frontend code for Pull Requests |
|`34-frontend-main-mutation-testing.yml`| Mutation Coverage for Frontend code for main branch |
|`35-frontend-format.yml`| Format the frontend code (prettier) |
|`36-frontend-eslint.yml`| Run eslint on frontend code |
|`40-check-production-build.yml`| Check that a production build works properly |
|`52-storybook-main-branch.yml`| Build storybook for the main branch (is this obsolete?) |
|`53-chromatic-main-branch.yml`| Build chromatic for the main branch  |
|`55-chromatic-pr.yml`| Build chromatic for a PR |
|`56-javadoc-main-branch.yml`| Build javadoc for the main branch (backend Java code) |
|`58-javadoc-pr.yml`| Build Javadoc for a Pull Request |
|`99-team01.yml`| Create the issues for team01 |
|`99-team02.yml`| Create the issues for team02 |
