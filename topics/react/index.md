---
parent: Topics
layout: default
title: "React"
description:  "A front-end framework for webapps and native apps"
category_prefix: "React: "
has_children: true
---

Main page: <https://reactjs.org/>

# React Learning Resources 

**Important**: These resources available to UCSB students/faculty/staff by **first** logging in at https://bit.ly/ucsb-or **then** navigating to the links below.

Online Books:

* [React Key Concepts](https://learning.oreilly.com/library/view/react-key-concepts/9781803234502/)
  - A decent basic textbook for React suitable for beginners
* [Fluent React](https://learning.oreilly.com/library/view/fluent-react/9781098138707/)
  - A slightly deeper dive into some of the technical concepts of React
  - Good if you already know some React, and want a deeper understanding of how the pieces work together

Video Courses:

* [React JS Masterclass - Go From Zero To Job Ready (34 hours)](https://learning.oreilly.com/videos/react-js-masterclass/9781805125549/)
  - I suggest that if you use this resources, don't necessarily expect to do all 34 hours!
  - Instead, use it to help you get past the point of being "lost in the syntax"
  - A few good videos to start with:
    - [React Behind the Scenes (11m34s)](https://learning.oreilly.com/videos/react-js-masterclass/9781805125549/9781805125549-video2_4/)
    - [JSX: In-Depth Introduction (12m11s)](https://learning.oreilly.com/videos/react-js-masterclass/9781805125549/9781805125549-video2_7/)
    - [Why We Need States? (10m2s](https://learning.oreilly.com/videos/react-js-masterclass/9781805125549/9781805125549-video3_1/)

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
