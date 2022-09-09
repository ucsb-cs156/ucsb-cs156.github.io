---
parent: Java
grand_parent: Topics
layout: default
title: "Java: Garbage Collection: Under the Hood"
description:  "Can we peek under the hood at how garbage collection is done"
indent: true
---

# Peeking under the hood of Java GC is tricky, and NOT 100% reliable

First, it should be stressed, and stressed again: the techniques noted below are HACKS, and are not 100% reliable.

Having said that, for simple cases, they've sometimes worked pretty well.

As the saying goes, [your mileage may vary!](https://en.wiktionary.org/wiki/your_mileage_may_vary)

# Seeing when an object becomes eligible for garbage collection

The code in this repo shows how we can peek under the hood a bit and see when objects become eligible for garbage collection.

* <https://github.com/UCSB-CS56-pconrad/java-garbage-collection-demo>

The basic technique is to include a static method in the class that does its best to "strongly encourage" the garbage collector to run,
invoking the `finalize()` method of all objects eligible for garbage collection.     We pass an integer to this method that corresponds to
whatever line number we are trying to track.    We call `System.gc()` and `System.runFinalization()` twice to *really, really, strongly encourage* garbage collection to happen, but I can't stress this enough: we can't 100% guarantee that the JVM will do as we ask.

```java
public static void gc(int i) {
	System.out.println("Line " + i);
	System.gc();
	System.runFinalization ();
	System.gc();
	System.runFinalization ();
}
```

This shows how we can try to verify the answers for exam questions such as:

* [Question 6 on Midterm Exam CS56-M16-E01](https://ucsb-cs56-f16.github.io/exam/e01/cs56_m16_e01/)

# A slightly more sophisticated version

This version eliminates the need to manually keep track of the line numbers.  It uses a hack that inspects the stack to see the current line number in the source.    We need to have compiled with that tracking in place.

