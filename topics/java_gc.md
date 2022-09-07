---
parent: Topics
layout: default
title: "Java: Garbage Collection"
description:  "How and when does memory allocated on heap get reused?"
indent: true
---

In C/C++ programming, one of the trickiest things to keep track of is making sure that your program doesn't have a memory leak.
In conventional C/C++ programming, every time you allocate memory on the heap with `new` (in C++) or `malloc()` (in C), The programmer is responsible for manually deallocating it at the correct time
with either `delete` (in C++) or `free()` (in C).  (Side note: some more modern features of C++11 and C++14 provide features such as those in Java described below, which 
is why this paragraph refers to "conventional C++ code, since most legacy C++ code you will encounter is likely still using the old techniques.)

Java, by contrast, has a feature called *automatic garbage collection*.  Automatic Garbage Collection first appeared in LISP in 1959 (John McCarthy was the programming
that invented the technique.)    Other commonly used languages with automatic garbage collection include Ruby, PHP, Scheme, JavaScript, Python, and many others.

To implement automatic garbage collection:

* The Java Virtual Machine keeps track of the *live references* to objects i.e. any reference that can be reached from some live variable, or from some method or attribute reachable from that 
live variable, etc. (recursively).
* By live variable, we mean variables on the stack of any currently executing thread, or variables that are static variables reachable in
any currently loaded class, or variables reachable from those variables (recursively).
* When an object on the heap is no longer reachable from any live reference, it is "eligible for garbage collection", because it is clearly no longer useful.  At some convenient point, the "garbage collector" runs, 
   and reclaims this memory.

## What is garbage?

Objects that are not reachable from any live reference are considered *garbage*.  In C/C++, if we substitute the word "pointer or reference", the definition of garbage
is the same.   

In C/C++ the existence of garbage is the very definition of "memory leak".  But in Java, the JVM keeps track of that for us, and periodically automatically 
frees those objects.    When it frees those objects, it also frees any objects to which those objects refer (recursively), essentially doing automatically
what we have to do manually when writing a C++ destructor.

## Do objects eligible for garbage collection get recycled immediately? NO.

IMPORTANT POINT: Just because an object becomes eligible for garbage collection does NOT mean that it immediately gets garbage collected.

Over the years since Java was first introduced in 1995, many improvements have been made in how garbage collection is done.
To improve overall performance in any language with garbage collection, the compiler writer and the designer of the run time system (e.g. the virtual machine or interpreter) 
must make smart choices about how to divide up the 
work of the system between running the actual
application code and housekeeping tasks such as garbage collection.

There can be a delay between when an object becomes eligible for garbage collection and when it is actually garbage collected.

And the system has the freedom to collect those objects in a different order from the one in which they become eligible for garbage
collection.

Having said that, there are some hacks we can do to try to "force" garbage collection to happen so that we can get a peek under the hood and
see what is going on.  More on that at this article: [Java: Garbage Collection: Under the Hood](/topics/java_gc_under_the_hood/)

## Homework Exercises and Exam Questions related to Java Garbage Collection

In order to check students' understanding of garbage collection, the Head First Java textbook has an exercise related to Garbage Collection
in which you are asked to determine the order in which objects become eligible for garbage collection.

Note that the wording here is important&mdash;we say *"become eligible for garbage collection"* rather than "*get garbage collected*", because
in fact, as we noted above, the JVM is free to implement garbage collection in many different ways.    

# More information

* <https://www.lucidchart.com/techblog/2017/10/30/the-dangers-of-garbage-collected-languages/?utm_content=buffer56941&utm_medium=social&utm_source=facebook.com&utm_campaign=buffer>
