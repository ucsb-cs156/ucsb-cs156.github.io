---
parent: Topics
layout: default
title: "Stryker"
description:  "Mutation testing for JavaScript"
category_prefix: "Stryker: "
has_children: true
---


Stryker-JS is a mutation framework for JavaScript.

* It is documented here: <https://stryker-mutator.io/docs/stryker-js/introduction>
* It was previously just called Stryker, but then the framework grew to incorporate mutation testing
  for C# and and Scala programs as well, so they rebranded Stryker as Stryker-JS to avoid confusion.
  
# Running Stryker on CS156 projects

To run stryker for CS156 projects, where the JavaScript code is in a directory called `frontend`:

* Make sure you are in the `frontend` directory and have already done `npm install`
* Run `npx stryker run`

# To do mutation testing on only a single file

If you know that all of your current changes are in a specific file, it is much faster to run mutation testing only on that single file instead of the entire project. 

For example, if your changed file is `src/main/components/Nav/AppNavbar.js` you can restrict stryker to this file by running:

```
npx stryker run -m npx stryker run -m src/main/components/Nav/AppNavbar.js 
```