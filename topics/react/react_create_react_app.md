---
parent: React
grand_parent: Topics
layout: default
title: "React: Create React App"
description:  "A tool to set up a new React App"
category_prefix: "React: "
indent: true;
---

A tool known as `Create React App` (documented at <https://create-react-app.dev/>) 
can be used to create a new React web application.  

Here's how you use it:

```
npx create-react-app my-app-name
```

This create a new directory `my-app-name` that is also a `git` repo (note: plain `git`, not GitHub, 
though you can link it to a GitHub repo by defining a remote).  This repo contains the code for a basic
React app.

The repo <https://github.com/ucsb-cs156-w22/demo-cra-plain> contains an example of the application
you get by running the sequence of commands:

```
npx create-react-app demo-cra-plain
cd demo-cra-plain
git remote add origin git@github.com:ucsb-cs156-w22/demo-cra-plain.git
git checkout -b main
git push origin main
```

The only modification is to add a few lines to the top of the `README.md` explaining this fact.

The `README.md` file in that repo explains how to start up the application on `http://localhost:3000`.

# Modified versions of the Create-React-App base

The staff of CMPSC 156 have created several modified version of the basic `Create React App` application
that illlustrate how to incorporate additional conventions and tools into the basic structure.

* <https://github.com/ucsb-cs156-w22/demo-cra-customized> adds:
  - directory structure with everything in `frontend` so that it can live inside a repo that follows Maven 
    directory conventions
  - has a directory structure mirroring that of Maven (with separation of `main` and `test`) for consistency
    between front and backend code.
  - has GitHub actions scripts for tests (Jest), test coverage (also Jest), and linting (ESLint).

Later versions also add 
- Storybook
- Stryker Mutation testing
