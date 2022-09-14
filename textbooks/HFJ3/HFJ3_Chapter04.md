---
parent: HFJ3
grand_parent: Textbooks
title: "HFJ3: Chapter 4"
chapter: 4
sort_key: "04"
textbook: HFJ3
description: "How Objects Behave: Methods Use Instance Variables"
---

# {{page.title}}—{{page.desc}}

## The big picture

This chapter reviews and reinforces some basic concepts of Object
Oriented programming—concepts that should already be familiar to you
from CS24 and CS32 (in C++).

So, while the *concepts* in this chapter should be review for you,
they are important enough that it is worth going over them again,
especially because:

-   We can now see them in the context of Java (emphasizing that they are universal to 
    OOP, and not specific to C++).
-   We can remind you of these things in case you have been away from OOP for a while 
    (perhaps taking CS40 and CS64?).
-   We can give you a second shot at this stuff in case it didn't quite sink in the 
    first time (because you were drowning in a sea of C++ syntax details, 
    segmentation faults, etc.).

The concepts we want to review here are the ideas of:

-   Instance variables (and their connection with state)
-   Methods (and their connection with behavior)

In Computer Science, we often talk about things being "stateful" or
"stateless"—and this can be sort of an abstract concept. This chapter
is designed to make it more concrete, so that, as the authors of the
Head First books are fond of saying it "sticks in your head".



## Sections

### Remember: a class describes what an object knows and what an object does


The main point of this page is to get you thinking about how instance
variables and methods interact with each other.

It may seem like an "obvious" point, but nevertheless, let it sink
in—the values of instance variables affect what happens when you
invoke a method on an object.

One other thing to pay attention to on this page: the UML-ish
diagrams, like this one:

<img width="216" alt="image" src="https://user-images.githubusercontent.com/1119017/190053064-e01634f2-b39c-439f-8a4f-35d884b0c638.png">


[UML](/topics/uml) stands for "Unified Modeling Language".  UML is a
language, but not in the sense that Java, or C++ is a language. One
has to take a broader view of the word "language" to understand how
UML is a language. It isn't quite as free-wheeling as English or
Spanish, but it isn't a language that can be strictly expressed in
ASCII (or even Unicode) characters in a text editor.

Instead, UML includes rules for creating diagrams that represent
various things that software designers need to express in order to
capture and communicate a software design—things like classes (in the
OOP sense), interactions of users with a system, etc.

We aren't going to try to take on learning UML in this course, but I
want you to at least be familiar with what UML is, in case you
encounter it (or someone asks you about it at a job interview.)

The UML diagrams in this book are pretty simple to understand—they
have the following structure:

<img width="491" alt="image" src="https://user-images.githubusercontent.com/1119017/190052961-159ed230-3b37-4f63-afc1-59a2053d6070.png">

When you encounter this type of diagram, I want you to be able to
understand what it means. You may encounter diagrams like this in the
"real world" too, as well as in later courses, so it is good to get
used to what they mean.


### The size affects the bark

Ok, so now that we understand how these UML-ish diagrams work, the
example on this page should be pretty clear.

And, these pages have some pretty simple code that reinforces the
ideas that the state of an object (e.g. the size of a dog) is stored
in its instance variables—and that affects the behavior of the
object's methods.

This is, of course, a silly example—but the authors are trying to use
it to make a point that will stick in your head.


### You can send things to a method

One of the interesting points that the author makes here that I try to
emphasize in my courses, but sometimes gets glossed over is this:

Inside a method in Java (or a function in C/C++/Python), a formal
parameter acts like a local variable—one that is initialized with the
value of the argument to the function (the value the caller passes
in.)

This idea of "formal parameter" as "just a special case of local
variable" is a very useful one—and one we'll encounter later on as we
talk about some common programming errors (like unintentional
shadowing of instance variables, parameters, etc.)

Another important point on this page is to establish some conventions
that the authors will use later about how the words **parameter** and
**argument** are going to be used.

The author's choices here are fairly standard ones, though not
entirely universal. Some authors use:

-   Formal parameter: the thing inside the method.
-   Actual parameter: the thing the caller passes when invoking the method.

I'll try to stick to the author's choices this quarter.

I assume you understand parameters and arguments from CS8 and CS16, so
we don't need to dwell on this further.

### You can get things back from a method

Just like in C/C++, methods can return things, and they have a return
type.

Since this is not different from C/C++, again, we won't belabor the
point.

### You can send more than one thing to a method


Ok, you can have multiple parameters to a method. Again, nothing very
surprising here.

### Java is pass-by-value. That means pass-by-copy.

This pages emphasizes the way that parameters are passed in Java—this
notion that when you pass something into a method, it *gets copied
into a local variable*, but the variable back in the main program is
not affected.

That's true with primitive types (boolean, char, byte, short, int,
long, float, double) and with immutable reference types such as
String. But as we'll see, if the thing copied in is a reference to a
mutable object like an ArrayList, then although the parameter passing
is pass-by-value (i.e. pass-by-copy), it can seem to be behave more
like pass-by-reference.

Understanding how parameter passing works with primitive types
vs. immutable references vs. mutable references is a really important
part of understanding how to avoid making mistakes and introducing
difficult to find bugs in your Java code!

We'll try to spend some time on decoding this mystery.

For now, let's just say that you may want to experiment with some code
that passes an `int`, a `String`, and an `ArrayList` into a method and makes
a change to the parameter inside the method. See what (if anything)
has happened to the original object when you come back from the
method. This will help you begin to understand the subtleties involved
here.

The first Q: and A: in the "There are no dumb questions" section on
this page is particularly important (they are all good, but the first
one is particularly so—it reinforces the ideas we started to get at earlier in the chapter.)

The bullet points are also worth reviewing—some of them are obvious,
and "duh" sorts of things, but there are a few subtle tricky ones,
such as the "implicit promotion" and "explicit cast" stuff.

### Reminder: Java cares about type!

Review the Bullet Points here.

### Cool things you can do with parameters and return types

Ok, getters and setters—again, review from CS24 and CS32—same as in
C++, right?

Mostly.

There is this "note" next to the UML-ish diagram that talks about
"using naming conventions" and "following an important Java
standard!".

There is something called a "Java Bean", which is a particular kind of
Java object—one with getters and setter methods that follow **this
exact naming convention**.

That is, if we have an instance variable `brand`:

-   The getter MUST be `getBrand()`, NOT `get_brand()` or `getbrand()` or `brandOf()`.
-   The setter MUST be `setBrand()`, NOT `set_brand()` or `setbrand()` or `changeBrand()`.

Don't misunderstand—it is true that you can choose whatever names you
like for your methods, and the alternative names shown above *will*
compile, and *will* work.   They just don't comply with the "Java Bean" standard.

And if you stick with the standard name, then you get certain benefits:

-   Certain database packages (such as Hibernate) will 
    make it easy for you to store and retrieve objects 
    in a database without having to write custom SQL code.
-   The Spring framework can use a package called Jackson to automate conversion of objects between JSON and Java.
-   IDEs such as VSCode etc. may be better able to automate certain parts of 
    your application development cycle.
-   In general, lots of tools will "understand what you are trying to do" and can help you 
    with your coding.
-   Other human beings that are accustomed to the Java naming standards
    are more likely to follow what you are trying to do.

So, as a result, I'm going to strongly encourage you to follow this
particular naming convention.


### Encapsulation

"Encapsulation", the way the authors are using the word here,
basically means making sure that your instance variables are private,
and are only accessible through methods (e.g. getters and setters).

I was taught that this was actually called "information hiding". The
way I learned it, the word "encapsulation" referred to the idea that
the instance variables and methods were both stored in a single
"syntactic construct", i.e. a "class".

But, what the heck—these are all just words. The idea that instance
variables should be private, and only accessed through methods is the
key idea here—no matter what buzzword you use to describe that idea.

Again, probably not a new idea if you were paying attention in CS24
and CS32—but worth reviewing.



### How do objects in an array behave?

This page talks about plain old Java arrays, e.g.

```java
    Dog [] pets = new Dog[7]; 
```

Note the difference in syntax between Java and C/C++ in both how we
declare, and how we allocate space for the array:

In Java, if we declare `Dog [] pets;` we are declaring a variable that can store a reference to an array
of Dogs.  Initially, though, there *is no such array*.  

If we then initialize that variable by instantiating the array, as shown below, we create an array
of seven "references to Dog", but still *we have not created any Dog objects*.  We have created *one*
object only, referred to by the reference `pets`, which is of type `Dog []`.   That object is an array
containg *seven null references*.

```java
   pets = new Dog [7];
```

Only if we write a for loop that iterates through the array, allocating `Dog` objects, do we create any
`Dog` objects at all, e.g.

```java
   for (int i=0; i<pets.length; i++) {
     pets[i] = new Dog();
   }
``` 

Note that unlike in C++, where the `()` is optional here, in Java, the `()` must appear.

Contrast this with C++.  In C++, we can:

* Create an array of Dog objects on the stack
* Create an array of Dog objects on the heap
* Create an array of Dog * (pointers to Dog) on the stack
* Create an array of Dog * (pointers to Dog) on the heap

Here's some code to illustrate this:



```cpp
#include <string>

class Dog {
private:
  std::string name;
public:
  Dog() { name = "fido"; }
};
  
int main() {
  Dog dogsOnStack[7];
  Dog * dogsOnHeap = new Dog[7];
  Dog * dogPtrsOnStack[7];
  Dog ** dogPtrsOnHeap = new Dog *[7];
}
```

In Java, we *cannot* create an array of Dog objects at all, neither on the stack, nor on the heap. 

And we cannot create an array of Dog references that is "stored" on the stack.

The reason is that arrays themselves are objects in Java, and in Java *all*, and I do mean *all* objects
live on the heap.    The only variables that can be on the stack in Java are the eight primitive types, and
reference variables.  

So, in Java a Dog object itself, can never be on the stack, and neither can any array.  

The only thing related to Dogs or Arrays that can be on the stack is a reference.

That can be a reference to a single Dog, as in:

```java
  Dog fido = new Dog();
```

Or it can be a reference to an array of *`Dog` references*, initially `null`

```java
  Dog [] dogs = new Dog [7]; // seven null references
``` 

But, strictly speaking, you can NEVER create an "array of Dog" in Java, as in a contiguous chunk of memory with Dog objects laid end to end.  That just doesn't exist in Java.

Now, we *can* have an array of int in Java (or any other primitive type):

    int [] numbers = new int[10]; // 10 ints

BUT, if we want an array of some kind of object, it is always an array
of references (analogous to an array of pointers in C/C++), never an
array of objects:


So, no dogs created here:

```java
    Dog [] pets = new Dog[7];
```

The pictures on p. 83 make this point very clear, so please study until you understand. Allocating the Dog objects is a separate step:

```java
    pets[0] = new Dog();
    pets[1] = new Dog();
    ...
```

When dealing with "plain old arrays" in Java, you can have an array of primitives, or an array of references to objects (similar to an "array of pointers" in C/C++). These are your only choices.

You cannot create an "array of objects" as you can in C/C++.


### Declaring and initializing instance variables

This page makes a very important point about instance variables. Rather than tell you what point that is, I'm going to phrase it in the form of a question that you need to answer by reading:

Consider the following Java code.

-   Will this code produce an error message, when compiled with `javac` `*.java` and if so what? (I don't need a detailed character by character account of the error messsage—just a general description of what the error is will be sufficient.)
-   If it does compile: will this code produce an error message, when run with `java` `StudentTestDrive` and if so what? (same as the previous question—just a general description of the error is sufficient.)
-   If this code does NOT produce an error message when compiled or run, what will be the resulting output when this code is run?

Contents of `Student.java`

```java
    class Student {
        private int perm; 
        private String name;
     
        public int getPerm() {
        return perm;
        } 
        public String getName() {
        return name;
        }
    }
```

Contents of `StudentTestDrive.java`

```java
    public class StudentTestDrive {
        public static void main (String[] args) {
        Student s = new Student() ;
        System.out.println("Student's perm is " + s.getPerm() ) ;
        System.out.println("Student's name is " + s.getName() ) ;
        }
    }
```


### Comparing variables (primitives or references)

This section discusses `==` vs. `.equals()`, which is one of the most
common sources of error in Java, especially among Java noobs.

So read it—over and over again, until it sinks in.

Then, skip ahead to Chapter 11, and read these three sections (the links will work as long as you login via <https://bit.ly/ucsb-or> first.)

* [Chapter 11: What makes two objects equal?](https://learning.oreilly.com/library/view/head-first-java/9781492091646/ch11.html#:-:text=What%20makes%20two,the%20same%20title%3F)
* [Chapter 11: How a HashSet checks for duplicates: hashCode() and equals()](https://learning.oreilly.com/library/view/head-first-java/9781492091646/ch11.html#:-:text=How%20a%20HashSet%20checks%20for%20duplicates%3A%20hashCode()%20and%20equals())
* [Chapter 11: The Song class with overridden hashCode() and equals()](https://learning.oreilly.com/library/view/head-first-java/9781492091646/ch11.html#:-:text=The%20Song%20class%20with%20overridden%20hashCode()%20and%20equals())

Those three sections are a bit advanced, and if not all of it makes sense on first reading, that's ok.  But to really understand the difference between `==` and `.equals`, and what it *means* for two objects to be "equal" in Java, it's important to have that other part of the picture.


(I'm not sure why the authors waited until Chapter 11 to cover the rest of
the story—I think that discussion should be moved to Chapter 4.  That's
why your pay tuition, and the UC pays my salary—so I can read ahead
and help you find things like this.)

We may discuss this in lecture or in a video as well.


