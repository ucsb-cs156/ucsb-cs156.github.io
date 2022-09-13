---
title: "Student: ex02"
parent: Student
grand_parent: Tutorials
description: "Overriding the toString method, @Override"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex02
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# Overview

In this example we introduce:

* overriding the toString method

The example code that supports this lesson is in a repository ("repo" for short) at this link.  Note that this link is showing the branch <tt>{{page.code_branch}}</tt>, *not* the <tt>main</tt> branch of the repo.

* <{{page.code_repo}}/tree/{{page.code_branch}}>

If you have already cloned this repo and are at the command line, you can switch to the `ex02` branch with this command:

* `git checkout ex02`

# Note: this branch uses simple directory structure

Note that the `ex01` branch used the full Maven directory structure.  By constrast, this branch uses a simple plain directory structure, for contrast.

In `ex03` we'll explain more about the Maven directory structure.  For this branch, you can compile and run with with the simple `javac/java` commands explained in the `ex01` branch of the tutorial.

# Overriding `toString`

The problem we are trying to solve is that the code:

```
        System.out.println("s1 = " + s1); // implicit: r1.toString()
        System.out.println("s2 = " + s2); // implicit: r2.toString()
```

produces the output:

```
s1 = Student@38cccef
s2 = Student@64b8f8f4
```

What we want is something more like this:

```
s1 = [name: Sample Student, perm: 9999999]
s2 = [name: Chris, perm: 1234567]
```

To achieve this, we need to override the `toString` method from `java.lang.Object` that
is producing the values that look like this: `Student@38cccef`.

Here's one way to do it:

```java
   @Override
    public String toString() {
        return "[name: " + this.name + ", perm: " + this.perm + "]";
    }
```

Here, we return literal strings such as `"[name: "` and `", perm: "` concatenated with the value of `this.name` and `this.perm`.

Java automatically converts the integer value of `this.perm` is automatically converted to a `String`.

Note that it would
be *incorrect* to say that this is done by "a call to the `toString` method of the `this.perm` value"; the reason that's incorrect
is that `this.perm` is of type `int`, and is therefore *not an object* in Java.  Only objects have methods.

We also see `@Override` before the declaration of the method.  This is an example of an *annotation*; annotations in Java
start with the at sign `@`, and are used to mark something special about a method or class.   In this case, we are telling
the Java compiler: "I think I'm overriding a method.  If I'm not, please throw an error so that I'll know."

This optional, but very much recommended practice. The reason is that if you were to define the following
method, without the `@Override`, you'd get no error message, but it would *not do what you want*.  The reason
is that the method is spelled `to_string`, which is different from `toString`.   Therefore, it would *not*
override the `toString` method of `java.lang.Object`, and we'd still get values like `Student@38cccef` showing up.

```
    public String to_string() {
        return "[name: " + this.name + ", perm: " + this.perm + "]";
    }

```

That's the only change we are going to make for this example.

