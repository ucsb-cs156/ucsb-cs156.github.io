---
parent: HFJ3
grand_parent: Textbooks
title: "HFJ3: Chapter 1"
chapter: 1
sort_key: "01"
textbook: HFJ3
description: "Breaking The Surface"
layout: default
---

The big picture
---------------

If you are brand new to Java, this chapter is here to give you a
really quick introduction to what Java looks like, and how it works.

If you have worked with Java before, this chapter is mainly just to
remind you of some things--but its still worth reading through just to
dust off the cobwebs of your knowledge.  Who knows, there might be
something that is new, or presented in a new light.


## By Sections

### The way Java works

Get familiar with the terms:
* Source code
* Compiler
* Bytecode
* Virtual Machine

### What you’ll do in Java

Note the role of:
* `javac` command
* `java` command
* `Party.java` file
* `Party.class` file

### A very brief history of Java

In this class, we'll be using Java 17 (even though there are higher versions of Java available.)   The reason is that Java 17 is a "Long Term Support" version.

Also note that Java is much faster than it used to be, thanks mostly to improvements in the Java Virtual Machine.


### Code structure in Java

Get familiar with the basic ideas here:
* One class == One file
* The top level is typically a file `Dog.java` containing one class called Dog:
  ```java
  public class Dog {

  }

Later in the course, we'll see a few examples of something called inner classes:  "classes inside other classes", but there is still typically just one top level public class per file. 

Like many rules of thumb, it turns out the real situation is a bit messier: see this [Stack Overflow Discussion](http://stackoverflow.com/questions/2336692/java-multiple-class-declarations-in-one-file).

But, at least for now, its best to stick to one class per file.


### Anatomy of a class

Not every class has to have a `public static void main(String [] args)` method, but you need a `main()` method to get a Java application started.

Contrast this with C++ where:
* the `int main()` method stands alone outside any class
* There can only be one `main()` method per application

In Java, by contrast:
* Every `main` method has to live inside some class
* There can be many classes that *have* a `main` method

The one that gets invoked is specified when you start up the JVM with,for example, the command `java Dog`
* This looks for a class file `Dog.class` and starts executing the `main` method of that class
* Where it looks for `Dog.class` is determined by something called the `CLASSPATH`, which we'll get into later.

### Writing a class with a main()

You definitely need to know how to write a simple Java `Hello World!` type program, and this section will teach you how.

### What can you say in the main method?

This goes over some of the basics of Java syntax, which as you'll notice, are pretty similar to C++ in many ways.

### Looping and looping and...

Again, basic syntax details that are pretty similar to C++, but worth reviewing.

The main content here is again nothing too surprising, but the Q and A
in this section is worth taking a little time with.

In particular, it is good to know about the way that in Java, unlike
C/C++, you CANNOT just treat ints as if they were booleans. Good to
know!

Will the following code print foo forever? Or is it a syntax error? Explain. (Assume it appears inside a main function)

    int x = 1;
    while (x) { 
      System.out.println("foo");
    } 


### Conditional branching

More basic syntax details that are pretty similar to C++, but worth reviewing.

Also covered, and something to notice: the difference between:

* `System.out.println`
* `System.out.print`

### Coding a serious business application

This is just a version of "99 bottles of beer on the wall"; it's worth
reviewing to make sure the syntax makes sense to you.

### Monday morning at Bob’s Java-enabled house

This is a pretty silly section, not gonna lie.

### Phrase-O-Matic

This is also kind of silly, but does introduce a few useful Java concepts, such as:

* the syntax for hard coded arrays of `String` values
* how to find the length of an array
* how to select a random element of an array
* working with String concatenation
