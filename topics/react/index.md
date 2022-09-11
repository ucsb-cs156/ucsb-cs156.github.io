---
parent: Topics
layout: default
title: "React"
description:  "A front-end framework for webapps and native apps"
category_prefix: "React: "
has_children: true
---

Main page: <https://reactjs.org/>

# React Naming Conventions

See: <https://maxrozen.com/guidelines-improve-react-app-folder-structure/>

# Linting your react code

To check your code for style issues, you can use `eslint`.

Install it with `npm install eslint --save-dev` then run this command, where `directory` is a directory containing
your React code:

```
npx eslint directory
```

Be careful that you don't run eslint on code in a `build` directory (i.e. the generated JavaScript); you only want to run it on your JavaScript source code.

If you get the error:

```
Error: Failed to load parser '@typescript-eslint/parser'...
```

then, try installing `typescript` manually:

```
npm install --save-dev typescript
```
