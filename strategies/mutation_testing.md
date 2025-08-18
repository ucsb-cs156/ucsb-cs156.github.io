---
parent: Strategies
layout: default
title: Mutation Testing 
description:  "Hints for dealing with surviving mutants"
---

# Mutation Testing 


## Focus on one file at a time

If you have a large number of surviving mutations, it's best to focus on one at a time.

In the frontend, you can run stryker on one file at a time like this:

```
npx stryker run -m /full/path/to/the/file/being/mutated.jsx
```

You can copy this full path by right clicking on the top of the tab in VSCode.  Remember that you want:
* the path of the implementation of the component (e.g. `FooTable.js`) ✅  
* *not* the path for the test of the component (e.g. `FooTable.test.js`) ❌ 

For the backend instructions for running pitest on only a portion of the code
can typically be found in the README.md, for example

* [ucsb-cs156-f25/STARTER-team02](https://github.com/ucsb-cs156-f25/STARTER-team02?tab=readme-ov-file#partial-pitest-runs)
* [proj-courses](https://github.com/ucsb-cs156/proj-courses?tab=readme-ov-file#partial-pitest-runs)
* [proj-dining](https://github.com/ucsb-cs156/proj-dining?tab=readme-ov-file#partial-pitest-runs)
* [proj-frontiers](https://github.com/ucsb-cs156/proj-frontiers?tab=readme-ov-file#partial-pitest-runs)
* [proj-rec](https://github.com/ucsb-cs156/proj-rec?tab=readme-ov-file#partial-pitest-runs)


