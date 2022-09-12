---
parent: Topics
layout: default
title: "Refactoring"
description:  ""
---

# {{page.title}}

See Also: [Code Smells]({{ '/topics/code_smells/' | relative_url }})

Martin Fowler and Kent Beck (the designer of JUnit) are the authors of a very influential book called  “Refactoring: Improving the Design of Existing Code”.

In Fowler’s book, he introduces twenty-two specific “code smells”, along with specific guidance for fixing the smelly code and replacing it with better code; this process is called "refactoring".

In general, in the context of software development, *refactoring* refers to the process of making changes to code that:
* do not change the functionality of the code, but
* make it easier to understand and maintain: i.e. make it easier to fix bugs and add new features.

The "refactor" step in the "Red-Green-Refactor" cycle of [Test-Driven Development]({{ '/topics/tdd/' | relative_url }}) refers
to this kind of refactoring.  The idea is that once you have tests for your code, and a candidate solution that passes the tests, you are much more free to experiment with refactoring the code because:
* you'll get immediate feedback on whether your refactoring broke anything or not
* you at least have a candidate "correct" solution you can fall back on if your refactoring ends up not working out
