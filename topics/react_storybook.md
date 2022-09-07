---
parent: Topics
layout: default
title: "React: Storybook"
description:  "A tool for previewing and testing React components in isolation"
category_prefix: "React: "
indent: true
---

# Adding React Storybook to a project

If you have a Create React App project that doesn't yet have React Storybook (e.g. inside the `javascript` directories) of our legacy code apps,
the simplest way to get started is to simply type, on a new clean feature branch:

```
cd javascript
npx sb init
```

After doing this, you should see the following changes:

```
On branch staff-w21-add-storybook
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   package-lock.json
	modified:   package.json

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.storybook/
	src/stories/

no changes added to commit (use "git add" and/or "git commit -a")
```

If after doing this, you type `npm run storybook`, a server will be started (by default, on <http://localhost:6006>) where
you can see your storybook.

The storybook is populated, by default, with some example stories, which you should delete so that they don't get confused with the real 
stories that you want to implement.   These are under `javascript/src/stories/`.   

We will end up adding directories under `javascript/src/stories` that match 
the directory structure under `javascript/src/main` and `javascript/src/test`.
