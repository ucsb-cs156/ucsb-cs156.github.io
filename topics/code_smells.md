---
parent: Topics
layout: default
title: "Code Smells"
description:  "Common problems that arise in code"
---

The term "code smell" was introduced in a book by Martin Fowler, in a chapter he co-authored with Kent Beck (the designer of JUnit) in a book
called "Refactoring: Improving the Design of Existing Code".

In Fowler's book, he introduces twenty-two specific "code smells", along with specific guidance for fixing the smelly code and replacing it
with better code.

Since that time, the phrase "code smell" has taken on a much broader sense: basically anything about your code that someone looking at it doesn't like.

Ok, maybe that was a bit snarky. The point is that "code smell" originally had a very technical, specific meaning, and it would be
nice to to reclaim some of that meaning.

# A Refactoring Exercise

You are invited, at various stages in the evolution of your project, 
to take on a refactoring exercise as a team.

1.  Look through your code, and see if you can find the "smelliest" part.

   It's up to you as a team to decide what the criteria are for "smelliness", but
   here are some suggestions.    For each of these, consider how and whether you can 
   make it specific enough to measure, quantitatively.  For example "length of methods"
   is fairly easy to quantify: you could simply measure the number of lines of code.
   
   For others, it may be more challenging, but see what you can do.
   
   * Length of methods
   * Methods that rely on too much global state rather than on parameter values
   * Comments instead of self-documenting code (If you replaced the method name like `update()` with
       something more description like `update_customer_database_from_csv_file`, would you be able
       to eliminate the comment?)
   * Classes that are too "tightly coupled" with each other (the [Inappropriate Intimacy](http://wiki.c2.com/?InappropriateIntimacy) code smell).  (How much intimacy is too much?  Can you quantify it in some way?)


