---
parent: Stryker
grand_parent: Topics
layout: default
title: "Stryker: console.log surviving mutants"
description:  "Hints on resolving these"
---

Here is an example of a mutation report showing that a mutation eliminating a console.log message survived:

<img width="453" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/a65b6eec-7c02-487f-b972-37f6d61d009e">

To cover this with a test, we can use `mockConsole`
