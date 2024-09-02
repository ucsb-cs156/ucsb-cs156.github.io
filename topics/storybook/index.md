---
parent: Topics
layout: default
title: "Storybook"
description:  "A framework for documenting and testing React components"
has_children: true
---

# {{page.title}}
## {{page.description}}

A common problem in web development is that you may want to separate out development of the frontend and backend components, and work on them in parallel.
But it can be difficult to develop these parts in isolation.  This is where tools such as Swagger (for the backend) and Storybook (for the frontend) can be of help.

Storybook provides a way to construct a visual catalog of your React components and try them out with different inputs (props).

It can serve as both documentation, and a way to prototype, demonstrate, and interactively test React components in isolation from the 
rest of your web application.

## Storybook Hints

1. When debugging storybooks, the following command is helpful. It runs `npx eslint --fix src` to check for syntax issues, and formats the code before running the storybook, and if either fails, it stops so you can fix the problem first.  This is helpful because otherwise, you may forget these steps after fixing the storybook issue, and therefore you end up taking longer to get the PR green on CI.

   ```
   npx eslint --fix src && npm run format && npm run storybook
   ```

2. Try to only have one storybook tab open in your browser.  If you have multiple storybook tabs open (say, from previous runs of `npm run storybook`, or from checking the storybook on <https://chromatic.com>), they can interfere with one another, and result in phantom errors, especially if they are from different version of the same set of stories.
