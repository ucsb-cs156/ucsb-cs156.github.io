---
title: "Student: ex14"
parent: Student
grand_parent: Tutorials
description: "Sorting with Comparable (natural order), and introduction to interfaces in java"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex14
---


# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# NOTE: NOT YET UPDATED FOR JAVA 17 and JUNIT 5 (TODO for W22, 01/05/22)


In earlier CS courses, you probably learned about algorithms to sort arrays, including:
* Selection Sort
* Insertion Sort
* Heap Sort
* Mergesort
* Quicksort
* etc.

While it is important to study these algorithms as part of your computing education, **in practice, you should likely almost never be implementing them yourself**. 

That is because nearly every programming language has *built-in sort routines*
that you should take advantage of instead.  These are likely written to be as efficient, or more efficient, than any sort you would write yourself.

The key is to know how to take advantage of these algorithms.

As you may know, while sorting algorithms differ, most have, embedded in them somewhere, a step where they *compare* elements and *swap them* when they are out of order.

While swapping is pretty much always the same, it's the *comparison* that is different when you are comparing, say, integers, vs. floats, vs. strings, vs. `Student` objects.

The key to using built-in sorts, therefore, whether in Java, or C++, Python, Ruby etc., typically involves providing a *comparison function* for the object that you want to sort.

In ex14 and ex15, we'll look at two ways to do that.

In ex14, we'll look at implementing the `java.lang.Comparable<T>` interface.  This allows us to define what Java calls a *natural order* for a class.   

If you have an `ArrayList<Foo> myarray;` for any class `Foo` that implements the `java.lang.Comparable<Foo>` interface, you can sort that array  can be sorted by simply invoking `myarray.sort();`.    

However, the limitation of the `Comparable<T>` method is that you can only define *one way* to sort a particular class.  For example, if we define sorting by perm, ascending, as the *natural order* for `Student`, then `myarray.sort()` will only every sort in this specific order.

In ex15, we'll look at a more flexible way to define sort orders using something called a `java.util.Comparator<T>`.  This is a special object that, as the saying goes *has one job*.  That job is to define a way of comparing two objects of type `T`.    Each `Comparator` can be defined to sort by a different field; for example:

* One Comparator might sort by perm, ascending.
* Another Comparator might sort by name, in alphabetical order
* Another Comparator might sort (if we add `gpa` to the Student object) by GPA descending.

Consider also, a `Course` object that might have attributes `department`, and `course number` and `section number`.  We might make a single comparator that sorts first by department, then by course number, and finally by section number.

But we are getting ahead of ourselves. Let's focus for now just on the case of the simple `Comparable<T>` interface, and modifying the `Student` class so that it implements this interface.

# What is an `interface` in Java?

In Java, an `interface` is typically simply a collection of method signatures.

* In early versions of Java, this statement basically was all there was to it.  An interface had method signatures and nothing more.

* (As an aside: more recent versions of Java allow interfaces to also have *default implementations* of some methods.   However, we'll set aside that detail for now.)

As an example, the interface with which we are concerned in this exercise, the `java.lang.Comparable<T>` interface, consists of this method signature:

```java
int	compareTo​(T o)
```

You can see this for yourself at the javadoc for `java.lang.Comparable<T>`, at this link: <https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Comparable.html>

Also, note that `java.lang.Comparable<T>` is a *parameterized interface*, also known as a *generic interface*.  The parameter `<T>` indicates that we pass in some class (e.g. `Student`) when we mention the interface.

So, our class `Student` will not be implementing `java.lang.Comparable<T>`, but rather `java.lang.Comparable<Student>`.

Also, as a note: for any class or interface in the `java.lang.` package, we can leave off the `java.lang.`.   All classes and interfaces in `java.lang.` are automatically imported by default, as if we wrote `import java.lang.*;` at the top of our file.

So from here on out, we'll just write `Comparable<T>` and know that we are referring to `java.lang.Comparable<T>`.


# What does it mean to `implement` and interface?

In Java, when we want to modify a class so that it *implements an interface*, we need to do two things:

1. Add `implements InterfaceName` to the class declaration, e.g.
   ```java
   public class Foo {
       ...
   }
   ```
   becomes:
   ```java
   public class Foo implements Bar {
       ...
   }
   ```

2. We need to find out what methods are part of the interface `Bar`, and we need to add implementations of those methods to class `Foo`.

In the situation at hand here, we are going to modify `Student` to implement `Student<T>` so we modify the top line of the class to read:

```java
public class Student implements Comparable<Student> {
    ...
}
```

And we must therefore add a method to our class with the signature:

```java
int	compareTo​(Student o)
```

What should this method do?

We can find out from the Javadoc for the `Comparable<T>` interface.  You should read the entire thing, but here's the 
most important part:

* Compares this object with the specified object for order. Returns a negative integer, zero, or a positive integer as this object is less than, equal to, or greater than the specified object.

So, in this exercise


* We'll add that method to Student
* Add test case coverage for it
* Use it to demonstrate sorting by perm inside `ReadStudents.java`
