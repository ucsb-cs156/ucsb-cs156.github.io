---
title: "Student: ex17"
parent: Student
grand_parent: Tutorials
description: "Sorting"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex17
---


# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# NOTE: NOT YET UPDATED FOR JAVA 17 and JUNIT 5 (TODO for W22, 01/05/22)



In this exercise, we build on ex15, where we showed writing a `java.util.Compartor<Student>` that allows us to sort by name.

The Comparator in ex15 was implemented as a separate named class.  However, since Java 8, it is much easier to write Comparators as
lambda expressions.

However, that's only true if you understand what a lambda expression in Java represents.

A lambda expression is:
* a *simplified notation* 
* for an *instance of an anonymous inner class*
* that implements a *functional interface*

That's a lot to unpack, so we'll tackle it a little a time.

First, we tackle *inner class*.  We'll first implement a Comparator that is a named (non-anonymous) inner class of `Student`.

Next, we tackle *anonymous inner class*.  The second new Compartor in this exercise will be an anonymous inner class of `ReadStudents`.

At that point we are ready to see a lambda expression. This is a simplified notation for an instance of an anonymous inner class, and it will be implemented inside `ReadStudent`.

Finally, we can see that with these concepts in place, we can compose new Comparators from ones that already exist using `thenComparing` and `reversed`.



