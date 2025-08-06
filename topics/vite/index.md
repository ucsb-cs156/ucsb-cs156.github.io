---
parent: Topics
layout: default
title: Vite
description:  "A Javascript framework; a successor to create-react-app"
has_children: true
---

# {{page.topic}} - {{page.description}}

This page describes vite, a Javascript framework for building web applications.

* <https://vite.dev/> is the official home page for the project.
* [Vite (Software)](https://en.wikipedia.org/wiki/Vite_(software)) (Wikipedia page)

CMPSC 156 begain transitioning the course projects and legacy code applications from Create React App to Vite during Summer 2025 in preparation for Fall 2025.

## Background: What is Create React App, and why do we have to replace it?

CMPSC 156 first started incorporating the React framework into the coursein Fall 2019, one of the most straightforward ways to create a new React app was a framework known as Create React App.

In 2019, getting a new React project could be a real hassle. Developers had to manually configure a complex set of tools like Webpack and Babel just to get a basic "Hello, World" app running. This was tedious, error-prone, and a major barrier for beginners.

Create React App (CRA) was a solution to this problem. It provided a simple command-line interface to  set up a new React project with a pre-configured development environment. 

In recent years though, Create React App has became outdated, and on February 25, 2025, it was [offically deprecated](https://react.dev/blog/2025/02/14/sunsetting-create-react-app), meaning
that the developers of Create React App are officially discouraging people from contining to use it, and actively encouraging people to migrate to other alternatives.

A few of the problems:

* Slow performance: CRA uses an older build system (Webpack) that is slow to start and reload after code changes, especially as projects grow larger.
* No active maintenance: The project lacked active maintainers, which meant it couldn't keep up with new changes in the React ecosystem.
* Lack of modern features: CRA was designed for single-page applications (SPAs) and lacks support for crucial modern features like Server-Side Rendering (SSR) and static site generation (SSG), which are important for performance and SEO.

## What is Vite, and why is it a good replacement?

Vite (pronounced "veet," like "fast" in French) has emerged as a leading successor to Create React App. 
It addresses the problems that led to CRA's deprecation and provides a better developer experience.

A few advantages:

* Speed: Unlike CRA, Vite leverages native ES Modules (ESM) in modern browsers during development. This means it doesn't have to bundle your entire application before running, leading to instant server starts and near-instant hot module replacement (HMR).
* Flexibility: Vite has a modular, plugin-based architecture that makes it easy to add new features and customize your setup without the hassle of "ejecting" like you had to with CRA. It's also framework-agnostic, supporting not just React but also Vue, Svelte, and more.
* Optimized for production: When you're ready to deploy, Vite uses a highly optimized build tool called Rollup to create a lightweight and efficient bundle for your users, ensuring fast load times.

## What are some of the challenges when migrating the CMPSC 156 codebases from CRA to Vite?

This is not a complete list, but it's a good high level overview:

* Filenames: vite is more particular about filenames. If your code contains JSX syntax, vite expects your file to have  `.jsx` as the filename extension.   
  While it may be possible to configure vite to use `.js`, that's "fighting with the framework", which is seldom a good idea.
* Tests: Our code base used `jest` as the testing framework for frontend code.  Vite has it's own testing framework called `vitest`.  While `vitest` is mostly
  a drop in replacement for `jest`, there are a few differences in syntax and how mocking is handled.  The code has to be adjusted for these differences.
* Code Coverage: while jest used separate tools (`nyc`, `istanbul`) for code coverage, with `vitest`, code coverage is built in to the tool.  This will require
  some adjustments to our scripts and processes.
* Eslint: Eslint needs to be reconfigured for vite and vitest.
* Storybook: Storybook needs to be reconfigured for vite and vitest.
* Stryker: Stryker needs to be reconfigured for vite and vitest.
* Generally, as we are updating these various dependencies, it's also an opportunity to move to newer versions of most of our tools, including the latest versions of node, React, etc.

The details each of these is deserving of it's own page; we'll add those pages as we gain more experience with the migration path, 
and have the time to flesh things out.




