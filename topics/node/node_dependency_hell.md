---
parent: Node
grand_parent: Topics
layout: default
title: "Node: Dependency Hell"
description:  "Dealing with deprecation, security, notices etc. for node dependencies"
---

# {{page.title}} - {{page.description}}

A common situation that arises with projects that use node is the "dependency hell" situation.

This is common to all node based projects whether it's React or any other Javascript based framework that uses node, regardless of whether you are using `npm` or `yarn` or one of the newer
alternatives.

## What is dependency hell?

You start with something innocent looking like this:

```
pconrad@Phillips-MacBook-Air-2 frontend % npm ci                         
npm warn deprecated inflight@1.0.6: This module is not supported, and leaks memory. Do not use it. Check out lru-cache if you want a good and tested way to coalesce async requests by a key value, which is much more comprehensive and powerful.
npm warn deprecated rimraf@3.0.2: Rimraf versions prior to v4 are no longer supported
npm warn deprecated glob@7.2.3: Glob versions prior to v9 are no longer supported
...
```

And you think: well, I should take care of this!  I should upgrade these packages!

The problem is that when you upgrade one package, you start to get more warnings, or even errors.   It soon spirals out of control.

You are in dependency hell.

## Strategies for dealing with dependency hell

The first thing to realize is that there is *no perfect strategy* to dependency hell.  

Do *not* make it your goal to try to get and maintain a "perfect" warning free node environment for your project.  This is not a realistic goal.

A more realisitic goal is to *prioritize*:

* The highest priority is to eliminate high priority security warnings.
* A second priority is a make the list of warnings as short as it can be with reasonable effort

## An approach 

Here's an approach.  It may or may not be the best approach, but it's worked reasonably well for our projects.

First, get a report of what versions are available by using this command:

```
npx npm-check-updates 
```

Here's an example of the output:

<img width="593" height="626" alt="image" src="https://github.com/user-attachments/assets/f0e76fb8-1b4e-48b0-a3dd-f39ea6a4a9d7" />

You can see here that there are newer versions of many packages available, and the command is suggesting that you do this

```
Run npx npm-check-updates -u to upgrade package.json
```

THIS SELDOM WORKS except on very small, not very complex projects.  The problem is that there is *very frequently* some incompatibilities if you go to the *latest* version of *everything* all at once.

Nor should you try to upgrade things *one at a time*.   This also tends to introduce incompatibilities.  

Instead, do things in *groups* of related functionality.  For example, here are some commands to upgrade groups of related modules together.

```
npx npm-check-updates -u -f "vite vitest @vitest/coverage-v8"
npx npm-check-updates -u -f "react react-dom react-hook-form react-router"
npx npm-check-updates -u -f "@vitejs/plugin-react @vitejs/plugin-react-swc  @vitejs/eslint-plugin eslint eslint-plugin-react-hooks eslint-plugin-react-refresh eslint-plugin-react-refresh" 
```

After each of these commands, try doing various smoke test to make sure things are still working:

```
npm install
npm ci
npm test
npm start
npm run storybook
```

And if it works, do a separate commit and make each commit run through the full CI/CD pipeline before committing or merging to main.


## More thoughts

* Upgrade to the latest minor versions of the major versions your dependencies are on, incrementally, where you can do so without running into problems.
* Do so in a branch, not on main
* Upgrade things in small steps that you can reverse, making a commit with a *useful* commit message after each set of changes that results in something that is reasonably better than what you had before.
 
