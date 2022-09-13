---
title: "Student: ex15"
parent: Student
grand_parent: Tutorials
description: "Sorting with Comparators, and introduction to Lambda expressions"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex15
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# NOTE: NOT YET UPDATED FOR JAVA 17 and JUNIT 5 (TODO for W22, 01/05/22)


In ex14, we looked at implementing the `java.lang.Comparable<T>` interface.  This allows us to define what Java calls a *natural order* for a class.   

If you have an `ArrayList<Foo> myarray;` for any class `Foo` that implements the `java.lang.Comparable<Foo>` interface, you can sort that array  can be sorted by simply invoking `myarray.sort();`.    

However, the limitation of the `Comparable<T>` method is that you can only define *one way* to sort a particular class.  For example, if we define sorting by perm, ascending, as the *natural order* for `Student`, then `myarray.sort()` will only every sort in this specific order.

In ex15, we'll look at a more flexible way to define sort orders using something called a `java.util.Comparator<T>`.  This is a special object that, as the saying goes *has one job*.  That job is to define a way of comparing two objects of type `T`.    Each `Comparator` can be defined to sort by a different field; for example:

* One Comparator might sort by perm, ascending.
* Another Comparator might sort by name, in alphabetical order
* Another Comparator might sort (if we add `gpa` to the Student object) by GPA descending.

Consider also, a `Course` object that might have attributes `department`, and `course number` and `section number`.  We might make a single comparator that sorts first by department, then by course number, and finally by section number.

In this exercise

* We'll look at the `java.util.Comparator<T>` interface
* We'll discuss how it differs from `java.lang.Comparable<T>`
* We'll implement a `java.util.Comparator<Student>` to sort by name instead of by perm.  

In our first attempt at a comparator, we'll define it as a separate named class.

**In practice, since Java 8, this is almost never done**. Instead, comparators are usually defined at lambda expressions, which we'll get to in ex17.

But, for this exercise, defining it as a separate named class will give us a good basis to understand how a comparator works, using methods that are familiar to us.

# Looking Ahead

Our `Student` class is kind of boring at the moment; it just has `name` and `perm`; and we've already built ways to sort on both of those.

To make it more interesting, so that we can look at more exotic ways of sorting, we'll first do some updating to the `Student` class itself.

In ex16, we'll:
* split `name` into `first` and `last`
* add `units` as another field

Then in `ex17`, we'll look at three other ways to define comparators:
* As a named inner class
* As a "defined on the fly" instance of a class 
* As a lambda expression

And finally, we'll look at composite compartors, where we combine comparators using `thenComparing` and `reversed`.

