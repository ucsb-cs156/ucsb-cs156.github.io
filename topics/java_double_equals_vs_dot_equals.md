---
parent: Topics
layout: default
title: "Java: == vs. .equals(), and hashCode()"
description:  "the difference, and how to override .equals and .hashCode()"
indent: true
p86 : 4dot-methods-use-instance-variables-how-objects-behave/comparing_variables_open_parenthesis_pri
---

The difference between `==` and `.equals` is:

* a common source of bugs in both beginner and real-world Java code
* accordingly, both a common exam and job interview question
* a topic about which there is frequent misunderstanding, because it can be more subtle than
  appears at first glance.


# What `==` does

<b>With primitive variables:</b> `==` does exactly what you would expect; it compares for equality.  No suprises here.  And for primitive
variables, you can *only* use `==`.  That makes sense: `equals()` is a method, and you can't invoke a method on a primitive in Java.

<b>With reference variables:</b> `==` compares the references to see if they refer to the same object or not.   It is similar to the idea of comparing "pointer values" in C/C++.    That means that if I create:

```
Student s1 = new Student(1234567,"Chris","Gaucho");
Student s2 = new Student(1234567,"Chris","Gaucho");
Integer i1 = new Integer(42);
Integer i2 = new Integer(42);
```

Then both `s1==s2` and `i1==i2` will evaluate to `false`.   In both cases, even though the object instances referred to the two references contain identical values, they are different objects on the heap.  So `==` returns `false`.

By contrast, if I do this:

```
Student s1 = new Student(1234567,"Chris","Gaucho");
Student s2 = s1;
Integer i1 = new Integer(42);
Integer i2 = i1;
```

Now both `s1==s2` and `i1==i2` will evalute to `true`.   Both references refer to the same object on the heap, so the references have the same value.

# What `.equals()` does

The situation for the `.equals()` method depends greatly on whether we are talking about classes that are part of the standard Java API, or classes that have been coded by an application programmer.

The first thing to know is the default behavior of `.equals()` for the class `java.lang.Object` is *identical* 
to the behavior of the `== ` operation on references.

Here is a portion of the javadoc for .equals says on this point:

> The equals method for class `Object` implements the most discriminating possible 
> equivalence relation on objects; that is, for any non-null reference values `x` and `y`, 
> this method returns true if and only if `x` and `y` refer to the same object (`x == y` has the value `true`).

The second thing to know is that what classes that extend `java.lang.Object` are supposed to do (and recall that *every* class extends 
`java.lang.Object`, so that means every class!) is to override `.equals()` in a way that "makes sense" for the particular object in
question.     Note that the javadoc expresses this idea by putting "equals" literally in "quotation marks".   The one liner for 
the meaning of the `.equals()` method for `java.lang.Object` indicates that "equal" is some kind of "term of art".  

> Indicates whether some other object is "equal to" this one.

That's easy to understand when, for example, we are talking about `java.lang.String` or `java.util.ArrayList<E>`:

* For `String a` and `String b`, `a.equals(b)` if and only if `a` and `b` have identical content.
* For `java.util.ArrayList<E> a` and java.util.ArrayList<E> b`, then `a.equals(b)` if and only if `a` and `b` are of the same length `len`, and for all `i` between `0` and `len-1`, `a.get(i).equals(b.get(i))`

(At least, I hope that's easy to understand.   We typically use the language of CMPSC 40 (our Discrete Math course) to express these ideas, because that language has a precise and unambiguous meaning to Computer Scientists and Applied Mathematicians.     There is a reason that CMPSC 40 is called "Foundations of Computer Science".   You'll be hearing that kind of language over and over again in your CS courses.  And indeed, if you thought it was just professors that talked this way, now look!  It's showing up in the documentation of the fundamental object of one of the "real world's" most widely used Object-Oriented Programming languages.   Go figure.)

In any case, the idea of what `.equals()` means for `String` and `ArrayList` is hardly surprising.

But, if we implement our own class Student, with attributes `int perm`, `String fname` and `String lname`, then what does it mean for one Student object to be "equal" to another student object?

* Is it sufficient that the perm numbers be identical?
* Or is it necessary that "all" of the attributes of the object be identical to one another?

The answer is nuanced.   It truly depends on what we are using the `.equals` method for in our application for this particular object.

But the first and most important thing to remember *here* is that *unless the programmer overrides* the java.lang.Object` version of `.equals()` then you will get a version of `.equals()` that behaves *identically* to the `==` operator.

So we should pretty much always override .equals for any class we implement.   

How we do it is application and context dependent.  But four things are always crystal clear, and spelled out in the javadoc for the `equals()` method of `java.lang.Object`:

1. We should implement it as an *equivalence relation*, in the CMPSC 40, MATH 8, sense of an equivance relation (that is, we need to remember our Discrete Math course, and recall what a binary relation is that is reflexive, symmetric and transitive) 
2. We should make sure it behaves *consistently*; in the words of the javadoc:  "For any non-null reference values `x` and `y`, multiple invocations of `x.equals(y)` consistently return `true` or consistently return `false`, provided no information used in `equals` comparisons on the objects is modified.
3. We should make sure that if `x` isn't null, then `x.equals(null)` always returns `false` (rather than a null-pointer exception, or true).
4. We should likely also be overriding the hashCode() function as well.

# Overriding the hashCode function.

So, let's take a look at the javadoc for the `hashCode` function of `java.lang.Object`.

It says: 

> The general contract of hashCode is:
>
> * Whenever it is invoked on the same object more than once during an execution of a Java application, the hashCode method must consistently return the same integer, provided no information used in equals comparisons on the object is modified. This integer need not remain consistent from one execution of an application to another execution of the same application.
> * If two objects are equal according to the equals(Object) method, then calling the hashCode method on each of the two objects must produce the same integer result.
> * It is not required that if two objects are unequal according to the equals(java.lang.Object) method, then calling the hashCode method on each of the two objects must produce distinct integer results. However, the programmer should be aware that producing distinct integer results for unequal objects may improve the performance of hash tables.
>
>

We can summarize: 

* `hashCode()` should be consistent in the same way that .equals() is consistent.
* If `a.equals(b)` then it should be true that `a.hashCode()==b.hashCode()`
* But it is ok for `c.hashCode()==d.hashCode()` to be true in some cases where `c.equals(d)` is `false`.

How we do this depends on the object.   

* Suppose we already have an integer that is unique for each object (e.g. `int perm` in the case of a `Student` object), then we can just return that integer.
* Suppose we have a String, or a concatenation of String values that is unique for the object.  For example, for a `UCSBCourse` object, it might be `String dept` (e.g. `"CMPSC"`) and `String courseNum` (e.g. `"130A"`).   In that case, we could concatenate the strings, and take the `hashCode` of the resulting object.  Here we are relying on the `java.lang.String` implementation of `hashCode` to give us the properties we are looking for in a good `hashCode`.


# Reading in HFJ

* p. 86
  [on-campus]({{site.on_campus}}/{{site.hfj_url}}/{{page.p86}})
  [off-campus]({{site.off_campus}}/{{site.hfj_url}}/{{page.p86}})	


