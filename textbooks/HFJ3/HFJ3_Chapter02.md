---
parent: HFJ3
grand_parent: Textbooks
title: "HFJ3: Chapter 2"
chapter: 2
sort_key: "02"
textbook: HFJ3
description: "A Trip to Objectville: Classes and Objects"
---

# {{page.title}}—{{page.desc}}

## The big picture

This chapter explores some basic ideas of Object Oriented Programming that should be review for your from CS24 and CS32 (or whatever equivalent courses you may have taken if you took those courses elsewhere.)  Along the way, there is some introduction of Java concepts, including the idea of inheritance.

The reading should go quickly.

## By Sections

### Chair Wars

This section presents something that kind of the "trademark" of the Head First books: a silly story with some characters, conflict and drama to try to pull you into a story.  Along the way, it makes some points about Object Oriented Design, and the idea of inheritance.

### What’s the difference between a class and an object?

This is a basic concept, but it's worth reviewing.

### Making your first object

Note the syntax differences from C++.

In C++, it would be:

```cpp
  Dog fido; // creates dog fido on Stack
  Dog *princess = new Dog; // creates new Dog on heap
```

But in Java:

``` 
  Dog fido;  // creates an uninitialized reference 
             // to a dog, but does not create a dog
             // the reference fido is on the stack, and uninitialized
  fido = new Dog(); // the () is required! and fido is on the heap
```

### Making and testing Movie objects

The code in this section uses data members in the Movie object that are neither `private` nor `public`; this is actually not considered good practice in Java.

I suppose that the authors are trying to ease you into Java without introducing too much syntax, but typically, we would create private data members, and use getters and setters, which we'll see later in the book.

### Quick! Get out of main!

I often see beginning Java programmers that write all of their code in a single `public static  void main(String [] args)` method, because that is how they were trained in a High School java course. 

We won't be writing much code in main in this course.  Java is intended to be an Object Oriented programming language, and most of the work should be done by implementing classes with methods.

Having said that, this code is still not the best Java style.  Instead of:

```
public class GuessGame {

   Player p1;
   Player p2
   Player p3;
   ...
```

It probably should be:

```
public class GuessGame {

   private Player p1;
   private Player p2
   private Player p3;
   ...
```

And there are other issues with the code as well, but let's not get too bogged down.   We'll see better code in later chapters.


### Running the Guessing Game

In this section, pay attention to the part labeled "There are no dumb questions" near the end of the section.

There are some good nuggets of information in this section, including:

* What is the closest thing to a "global variable" in Java?
* What do you "deliver" when you deliver a Java application?  (Hint: it's not an "executable file" in the same way that it is for a C++ program).
* What if you have an application with hundreds of classes in it?

