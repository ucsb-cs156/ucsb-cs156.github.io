---
parent: HFJ3
grand_parent: Textbooks
title: "HFJ3: Chapter 5"
chapter: 4
sort_key: "05"
textbook: HFJ3
description: "Chapter 5. Extra-Strength Methods: Writing A Program"
---

# {{page.title}}—{{page.desc}}

## The big picture

To be honest, most of the material in this chapter is probably a bit basic if you are a solid programmer.

Even if you havent' seen Java before, this should be easy reading.

Nevertheless, there may be a few points worth noticing.

One of them is an introduction to the idea of test-driven development.

We see the Java "for each" style loop, e.g.

```
for (int cell: locationCells) {
  // do something with cell
}
```

There are also introductions to 
* using `Math.random()`
* using type casts on primitive types

## Sections

### Let’s build a Battleship-style game: “Sink a Startup”

This section just introduces the application that forms the basis of the chapter.  It's basically "battleship", but they've decided to call it "sink a startup" to be trendy, I guess.

### First, a high-level design

This shows the basic approach to the code.

### The “Simple Startup Game” a gentler introduction

This section explains that before solving a more complex version of the problem, we solve a simplified version of the problem: a one-dimensional version instead of a two-dimensional version.

### Developing a Class

In this section, they explain a particular approach to designing and writing code.

I wouldn't get too hung on up their particular approach; I'm neither recommending it, nor critisizing it too harshly.  It is helpful to understand though, since they use this approach throughout the book.

### Writing the method implementations

Ok, this is a good section to read carefully, since it helps to reinforce the idea of test-driven development.

### Writing test code for the SimpleStartup class

I don't love the fact that they aren't using JUnit here; you'd think that by now, that would be standard.   But at least they are doing testing.

In this course, we'll use a more professional approach to testing (specifically, the JUnit framework). That's covered in the student tutorial here: <https://ucsb-cs156.github.io/tutorials/student/student_ex04.html>

### Test code for the SimpleStartup class



### The checkYourself() method

### Just the new stuff

### Final code for SimpleStartup and SimpleStartupTestDrive

### Prep code for the SimpleStartupGame class Everything happens in main()

### The game’s main() method

### random() and getUserInput()

### One last class: GameHelper

### Let’s play

### What’s this? A bug ?

### More about for loops

### Trips through a loop

### The enhanced for loop

### Casting primitives
