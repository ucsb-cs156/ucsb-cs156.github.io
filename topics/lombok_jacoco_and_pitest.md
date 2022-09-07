---
parent: Topics
layout: default
title: "Lombok: Jacoco and pitest"
description:  "Avoid doing code coverage and mutation testing on generated code"
category_prefix: "Lombok: "
indent: true
---

When Lombok generates code, we shouldn't really need to write tests for that code.  That would be testing Lombok, and that's not really our job (that's the job of the 
Lombok developers.)

I mean, we could do that testing if we had reason to suspect that Lombok had bugs in it, but ordinarily, we don't test other people's code; we rely 
on them to do that.

So, how do we avoid:
* Having Jacoco complain that there's code we aren't covering (the generated code from Lombok?)
* Having pitest doing mutation testing on the generated code? (and complaining that the mutations aren't caught by tests?)

The trick is to have Lombok mark all of it's generated code, at the bytecode level, with an annotation `@Generated`.  
* Recent versons of Jacoco and pitest both exclude code with this annotaion 
* But, that annotation isn't enabled by default.

To enable it, you need to put a file called `lombok.config` in the root of your project with these contents:

```
config.stopBubbling = true
lombok.addLombokGeneratedAnnotation = true
```

The `config.stopBubbling` tells Lombok not to look any higher than this directory for `lombok.config` files (they can be placed at any level in the directory hierarchy
if you want to override settings for a particular package under your `src` directory hierarchy.)

The `lombok.addLombokGeneratedAnnotation` is what tells Lombok that we want the `Generated` annotation so that we can avoid computing code coverage and mutation testing
for the generated code.

(You may wonder how Jacoco and Pitest even know about the generated code.  It is because they work on the bytecode level, not on the source code level.)
