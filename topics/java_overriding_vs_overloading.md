---
parent: Topics
layout: default
title: "Java: Overriding vs. Overloading"
description:  The difference between these
indent: true
---

# What is overloading

Overloading is when a name or symbol has different meanings in different contexts.

You overload a method or construtor when a class has have two methods (or constructors) with the same name but different number, type, order of parameters.

Java doesn't allow programmer defined operator overloading (the way C++ and Python do), but there is (at least) one overloaded operator built into the definition of the language: the `+` operator means addition when its operands are numeric, but string concatenation when at least one of its operands is of type `java.lang.String`.

# What is overriding

Overriding is when you override a method in a subclass that would otherwise be inherited from a superclass.

It is good practice to include the [annotation] `@Override` to indicate your intention to override the method.  That way if you get the spelling, case, or method signature wrong (number and type of params), you'll get a compiler error, and catch your mistake early.


# More
<http://www.programmerinterview.com/index.php/java-questions/method-overriding-vs-overloading/>
