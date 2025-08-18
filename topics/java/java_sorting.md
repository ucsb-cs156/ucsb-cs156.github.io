---
parent: Java
grand_parent: Topics
layout: default
title: "Java: Sorting"
description:  "Comparable, Comparators, and sorting ArrayLists and such"
indent: true
---

<style>
div.nice-table table {
     border-collapse: collapse;
     border: 1px solid black;
}

div.nice-table table * td {
    border: 1px solid black;
}

div.nice-table table * th {
    border: 1px solid black;
}


</style>

For code examples in this lesson, see: <https://github.com/UCSB-CS56-pconrad/java-sorting-and-comparators>


# Don't write your own sort

If you are writing your own sorting algorithm in Java, *unless* you are doing so for the purpose of *learning* how to write a sorting algorithm (e.g. Insertion Sort, Quicksort, Mergesort, etc.), then you are probably doing something wrong.

To be honest, that's true in most languages.  For any given language and system, there is already, most likely, a built-in way of sorting things that need to be sorted. You just need to hook into that.

You write sorting algorithms in courses such as CMPSC 24 and CMPSC 130A so that you understand how sorting algorithms work, and how algorithms work in general    But you should hardly ever write your own sort after that, ever again---certainly not if the purpose is to put things in order.

# What you need to understand to do sorting in Java

To understanding sorting in Java, you need to understand these concepts:

* The interface `java.lang.Comparable`
* The interface `java.util.Comparator`

It is also super handy if you understand the concept called *lambda Expressions*, because it makes the code for using `java.lang.Comparable` and `java.util.Comparator` much cleaner, shorter, and more clear.

I'll walk you through what you need to know.

# `ArrayList` yes, but `Vector` and `LinkedList` too

All of my examples in this lesson use `ArrayList` since that's the class that is most familiar to students from the classes that implement the `java.util.List` interface.  However, everything we illustrate here works on `java.util.Vector` and `java.util.LinkedList` as well.   

# How to Sort an `ArrayList<String>`

Sorting an `ArrayList<String>` so that all of the strings appear in alphabetical order (or more correctly, *lexicographic order*) is super easy in Java.   

It's easy because `String` implements the `java.util.Comparable<String>` interface.

That is, it has a method: `int	compareTo(String o)` that allows us to compare one String to another and determine whether:
* `this` string should come before `o` in lexicographic order, i.e. `this` string is "less than" `o` 
* `this` string and `o` are equal
* `this` string should come after `o` in lexicographic, i.e. `this` string is "greater than" `o` 

Anytime you have an `ArrayList<T>` where `T` is a type that implements `Comparable`, you can just use the method `java.util.Collections.sort` to sort the list.  Here's some sample code:

```java
import java.util.ArrayList;
public class SortArrayListString {

        public static void main(String [] args) {
                ArrayList<String> things = new ArrayList<String>();

                things.add("Cup");
                things.add("Stapler");
                things.add("Pencil");
                things.add("Plate");
                things.add("Ball");

                System.out.println("Not sorted: " + things);

                java.util.Collections.sort(things);
                
                System.out.println("Sorted? " + things);
        }
}
```

Running it, we get:

```
$ java SortArrayListString
Not sorted: [Cup, Stapler, Pencil, Plate, Ball]
Sorted? [Ball, Cup, Pencil, Plate, Stapler]
$ 
```

# Sorting `ArrayList<Dog>`: First Attempt

What if we try the same thing with one of our own classes?  Here's a simple Dog class:

```java
public class Dog {
    private String name;
    private double weight;
    public String getName() { return name; }
    public double getWeight() { return weight; }
    public Dog(String name, double weight) {
        this.name = name;
        this.weight = weight;
    }
    public String toString () {
        return "[" + name + "," + weight + "]";
    }
}
```

And here's some code that tries to sort it:

```
import java.util.ArrayList;
public class SortDogs {
    
    public static void main(String [] args) {
        ArrayList<Dog> kennel = new ArrayList<Dog>();
        
        kennel.add(new Dog("Fido",15));
        kennel.add(new Dog("Spot",20));
        kennel.add(new Dog("Puddles",8));
        kennel.add(new Dog("Doge",45));
        kennel.add(new Dog("Catepillar",90));
        
        System.out.println("Not sorted: " + kennel);
        java.util.Collections.sort(kennel);
        System.out.println("Sorted by name " + kennel); 
    }   
}
```

But it doesn't compile.  We get this terrible looking error.  What's gone wrong?

```
$ javac SortDogs.java 
SortDogs.java:14: error: no suitable method found for sort(ArrayList<Dog>)
	java.util.Collections.sort(kennel);
	                     ^
    method Collections.<T#1>sort(List<T#1>) is not applicable
      (inference variable T#1 has incompatible bounds
        equality constraints: Dog
        upper bounds: Comparable<? super T#1>)
    method Collections.<T#2>sort(List<T#2>,Comparator<? super T#2>) is not applicable
      (cannot infer type-variable(s) T#2
        (actual and formal argument lists differ in length))
  where T#1,T#2 are type-variables:
    T#1 extends Comparable<? super T#1> declared in method <T#1>sort(List<T#1>)
    T#2 extends Object declared in method <T#2>sort(List<T#2>,Comparator<? super T#2>)
1 error
$ 
```

The problem is that Dog doesn't implement `java.lang.Comparable<Dog>`.   Here's a fixed version.

Note that:
* We declare on line 1 that `Dog implements Comparable<Dog>`.   
* We can leave off the `java.lang.` on `java.lang.Comparable`; you can always leave off `java.lang.`  
* Implementing `Comparable<Dog>` involves writing the `compareTo` method that appears in the code below:

```java
public class Dog implements Comparable<Dog>  {

        private String name;
        private double weight;
        public String getName() { return name; }
        public double getWeight() { return weight; }
        public Dog(String name, double weight) {
                this.name = name;
                this.weight = weight;
        }
        public String toString () {
                return "[" + name + "," + weight + "]";
        }
                                                  
        public int compareTo(Dog otherDog) {
                // return negative number if this < otherDog, according to my "order"
                // return 0 if this == otherDog, according to my "order"
                // return positive if this > otherDog, according to my "order"
                
                // return this.name.compareTo(otherDog.name);

                if (this.name.compareTo(otherDog.name) < 0) {
                        return -1;
                } else if (this.name.equals(otherDog.name)) {
                        return 0; 
                } else {
                        return 1;
                }                       
        }
}
```

Now our code compiles, and sorting works:

```
$ java SortDogs
Not sorted: [[Fido,15.0], [Spot,20.0], [Puddles,8.0], [Doge,45.0], [Catepillar,90.0]]
Sorted by name [[Catepillar,90.0], [Doge,45.0], [Fido,15.0], [Puddles,8.0], [Spot,20.0]]
$ 
```

# Sorting in more than one way

But, our `Dog` class has both `name` and `weight`.  What if we want to sort by weight instead of by name?

The problem with sorting based on `Comparable` is that we can only define one way of sorting.    We typically choose, when we implement `Comparable`, the most "obvious" way of sorting our class.  The javadoc calls this the "natural order", though to be honest, there is nothing "natural" about it; it's just the way the programmer decides is the most "reasonable" way to be the default ordering for the class.   

But, we typically want to sort in many different ways, and we may not even be able to anticipate all of them in advance.  We don't want to have to change the source code for the `Dog` class to be able to sort in new ways.  That's where `java.util.Comparator<T>` comes in.

A class that implements the `Comparator<T>` interface is one that implements the method:

```
int compareTo(T o1, T o2);
```

That method looks a lot like the `int compare(T o)` method, except that it is not a method of class `T`; instead, it's an instance method of some other class.  It may help to think of a `Comparator<T>` object as a kind of "plugin" or "add-on" that you use whenever you want to compare two objects of type `T`.  As the meme goes, this class  literally "has only one job".

Here's what a Comparator class for comparing Dog objects by weight would look like.  


```java
public class DogWeightComparator implements java.util.Comparator<Dog> {
    @Override
    public int compare(Dog o1, Dog o2) {
        return Double.compare(o1.getWeight(),o2.getWeight());
    }
}
```

Side note: 
* The example above of `DogWeightComparator.java` is an example of writing a class that implements `Comparator<Dog>` as a separate standalone class, in it's own file.  In practice, that is *almost never done*.
* Instead, we typically make these little `Comparator` classes be inner classes, anonymous inner classes, or lambda expressions; but we'll get to that. One thing at a time!

Ok, so with a `DogWeightComparator` class present, we can now write this code:

```java
import java.util.ArrayList;
public class SortDogs2 {
    
    public static void main(String [] args) {
        ArrayList<Dog> kennel = new ArrayList<Dog>();
        
        kennel.add(new Dog("Fido",15));
        kennel.add(new Dog("Spot",20));
        kennel.add(new Dog("Puddles",8));
        kennel.add(new Dog("Doge",45));
        kennel.add(new Dog("Catepillar",90));
        
        System.out.println("Not sorted: " + kennel);
        java.util.Collections.sort(kennel);
        System.out.println("Sorted by name " + kennel);
        java.util.Collections.sort(kennel,new DogWeightComparator());
        System.out.println("Sorted by weight " + kennel);       
    }   
}

```

And when we run it, we get:

```
$ java SortDogs2
Not sorted: [[Fido,15.0], [Spot,20.0], [Puddles,8.0], [Doge,45.0], [Catepillar,90.0]]
Sorted by name [[Catepillar,90.0], [Doge,45.0], [Fido,15.0], [Puddles,8.0], [Spot,20.0]]
Sorted by weight [[Puddles,8.0], [Fido,15.0], [Spot,20.0], [Doge,45.0], [Catepillar,90.0]]
$ 
```

# Using the `sort` method of `ArrayList`

Now that we have a class that implements `Comparator<Dog>` we could nalso use the built in `sort` method of `java.util.ArrayList`.  That is instead of: 

```java
   java.util.Collections.sort(kennel,new DogWeightComparator());
```

We can write: 

```java
   kennel.sort(new DogWeightComparator());
```

Note that if we `import java.util.Collections` then we can just write this for the first one:

```java
   Collections.sort(kennel, new DogWeightComparator());
```

An important thing to recognize is that if we invoke `Collections.sort(kennel);` without passing in a `Compartor<Dog>` object,
we are using the "natural ordering", i.e. the `compareTo` method of `Dog`, and that `Dog` must implement `Comparable<Dog>` in that case.

If we instead, use the `sort` method of `ArrayList` (e.g. `kennel.sort(comparator)`) than we have to pass in a suitable object
of a class that implements `Comparator<Dog>`.

At one level, that's all you need to know.   The rest, i.e. the stuff about Lambda Expressions, is all just stuff that makes writing the code easier.  It may not seem that way on first read; it may seem awfully complicated. But once you really *get* it, it's not complicated at all, and it makes your life so much easier if you spend a lot of time writing Java code.  So, let's dive in.

# Easier sorting with Lambda Expressions

Lambda expressions give us a way to create a Comparator with much less bother.  

* They are NOT more efficient in terms of memory, or run time or anything to do with computational efficiency
* But they are are more efficient for the human programmer.

They are a shorthand syntax.   The best way to understand what they are is to consider four options for creating a comparator, each one moving us close to lambda expresions in stages.

<div class="nice-table" markdown="1">

| Stage | Explanation | Example Code |
|-------|-------------|--------------|
| Stage 1 | Comparator as a separate standalone class, like we did with `DogWeightComparator`, and instantiate it with `new DogWeightComparator()` when we need a comparator object. | See `DogWeightComparator` above |
| Stage 2 | Comparator as a named static inner class.  The difference between this and Stage 1, is that we don't need a separate `.java` source file. | See `DogWeightInnerClass` below |
| Stage 3 | We create an instance of an anonymous inner class.  This one is the most "mysterious"; it appears that we are doing something illegal, i.e. invoking a constructor on an interface, which we all "know" isn't permitted, right?  Except that we are actually, in that moment declaring a class (one with no name) and instantiating it, all at the same time.    I know: that sounds confusing.  It will make sense when we get there. | See `DogWeightAnonymousInnerClass` below |
| Stage 4 | We realize that most of the syntax we wrote in Stage 3 is unnecessary; that is, the compiler can figure out most of what we wrote, so a shorter syntax makes things easier. | See `DogWeightLambda` below |

</div>

# Stage 2: Using a named inner class (`DogWeightInnerClass`)

In the directory `DogWeightInnerClass`, we see that the file `SortDogs3.java` illustrates how we can move the compartor inside the class where we declare our main program, like this:

```
import java.util.ArrayList;
public class SortDogs3 {
    
    static class DogWeightComparator implements java.util.Comparator<Dog> {
        @Override
        public int compare(Dog o1, Dog o2) {
            return Double.compare(o1.getWeight(),o2.getWeight());
        }
    }
    
    public static void main(String [] args) {
        ArrayList<Dog> kennel = new ArrayList<Dog>();
        
        kennel.add(new Dog("Fido",15));
        kennel.add(new Dog("Spot",20));
        kennel.add(new Dog("Puddles",8));
        kennel.add(new Dog("Doge",45));
        kennel.add(new Dog("Catepillar",90));
        
        System.out.println("Not sorted: " + kennel);
        java.util.Collections.sort(kennel);
        System.out.println("Sorted by name " + kennel);
        java.util.Collections.sort(kennel,new DogWeightComparator());
        System.out.println("Sorted by weight " + kennel);       
    }   
}
```

It still sorts!

```
$ java SortDogs3
Not sorted: [[Fido,15.0], [Spot,20.0], [Puddles,8.0], [Doge,45.0], [Catepillar,90.0]]
Sorted by name [[Catepillar,90.0], [Doge,45.0], [Fido,15.0], [Puddles,8.0], [Spot,20.0]]
Sorted by weight [[Puddles,8.0], [Fido,15.0], [Spot,20.0], [Doge,45.0], [Catepillar,90.0]]
$ 
```

But we can do better than this.

# Stage 3:  Anonymous Inner Class Instance (`DogWeightAnonymousInnerClass`)

In this example, we are almost at the stage of introducing Lambda Expressions; indeed, prior to Java 8, the syntax I'm about to show
you was considered the "best" way of making Comparator objects.

If we are only going to use our inner class once, rather than give it a name, and declare it far away from where it is used, we
can declare it like this:

```java
        Comparator<Dog> sortByWeight= new Comparator<Dog>(){
                @Override
                public int compare(Dog o1, Dog o2) {
                    return Double.compare(o1.getWeight(),o2.getWeight());
                }               
            };

```

Here's that code in context.  Note that we are importing `java.util.Comparator` on line 2 so that we don't have to specify the full package name each time we refer to a `Comparator`.  Also note how we use the `sortByWeight` object of type `Comparator<Dog>` on line xx as the parameter to `kennel.sort(sortByWeight)`

{% highlight java linenos %}
import java.util.ArrayList;
import java.util.Comparator;
public class SortDogs4 {

    public static void main(String [] args) {
        ArrayList<Dog> kennel = new ArrayList<Dog>();
        
        kennel.add(new Dog("Fido",15));
        kennel.add(new Dog("Spot",20));
        kennel.add(new Dog("Puddles",8));
        kennel.add(new Dog("Doge",45));
        kennel.add(new Dog("Catepillar",90));
        
        System.out.println("Not sorted: " + kennel);
        java.util.Collections.sort(kennel);
        System.out.println("Sorted by name " + kennel);

        Comparator<Dog> sortByWeight= new Comparator<Dog>(){
                @Override
                public int compare(Dog o1, Dog o2) {
                    return Double.compare(o1.getWeight(),o2.getWeight());
                }               
            };
        kennel.sort(sortByWeight);
        System.out.println("Sorted by weight " + kennel);       
    }   
}
{% endhighlight %}

It still sorts:

```
$ java SortDogs4
Not sorted: [[Fido,15.0], [Spot,20.0], [Puddles,8.0], [Doge,45.0], [Catepillar,90.0]]
Sorted by name [[Catepillar,90.0], [Doge,45.0], [Fido,15.0], [Puddles,8.0], [Spot,20.0]]
Sorted by weight [[Puddles,8.0], [Fido,15.0], [Spot,20.0], [Doge,45.0], [Catepillar,90.0]]
$
```

# Stage 4: Using Lambdas (`DogWeightLambda`)

Here, finally, we see that we can make the declaration of the anonymous inner class much shorter.

Instead, of:

```
   Comparator<Dog> sortByWeight= new Comparator<Dog>(){
                @Override
                public int compare(Dog o1, Dog o2) {
                    return Double.compare(o1.getWeight(),o2.getWeight());
                }               
            };
```

We can write the single line of code:

```
        Comparator<Dog> sortByWeight = (o1,o2) ->  Double.compare(o1.getWeight(),o2.getWeight());
```

Here's how to interpret this:

<div class="nice-table" markdown="1">

| New Syntax |  Replaces |  Explanation |
|------------|-----------|--------------|
| `(o1, o2)` |  `(Dog o1, Dog o2)` | We need to give names to the variables that are parameters to the `compare` method.  But the types are implied.  Since it's a `Comparator<Dog>`, it is understood that the method we are defining is `compare`, and the types of the two parameters are both `Dog`. | 
| ` -> ` | `return` | The `->` indicates that what follows is the expression that will come after the return |
| `Double.compare(o1.getWeight(),o2.getWeight())` | (same) | We need to specify what the `compare` method returns, in terms of `o1` and `o2` |

</div>

It's as simple as that.    To make a comparator, we just specify an expression of this form, where `T` is some type:

<tt>Comparator&lt;T&gt; myComparator  = (o1, o2) -&gt; <em> expression </em>;</tt>

If computing the return value is more complicated, we can also put a full block of code in braces after the `->`.  Here's an example 
of what that would look like:

```
Comparator<T> myComparator  = (o1, o2) -> {
    if (o1.equals(o2)) {
        return 0;
    } else if (o1.isLessThan(o2)) {
        return -1;
    } else {
        return 1
    }
}
```

# Another Example, for Review: `StudentSort01.java`

To review everything, consider this program, which uses all of the techniques we've discussed:

{% highlight java linenos %}
import java.util.ArrayList;
import java.util.Comparator;

public class SortStudents01 {
    
    public static void main(String [] args) {
	
	ArrayList<Student> roster = Student.makeRoster();
	
	System.out.println("Orig: \n"+ roster);
	
	// this works if/only if roster "is-a" List<T>, and
	// T implements Comparable.
	
	java.util.Collections.sort(roster);
	
	System.out.println("Sorted using Student compareTo: \n" + roster);

	// the second argument is an instance of an anonymous inner class
	// that implements java.util.Comparator<Student>
	
	// byName compares by last name, then uses first to break ties.
	Comparator<Student> byLastName = new Comparator<Student> () {
		public int compare(Student s1, Student s2) {
		    if (s1.getLast().equals(s2.getLast())) {
			return s1.getFirst().compareTo(s2.getFirst());
		    } else {
			return s1.getLast().toUpperCase().compareTo(s2.getLast().toUpperCase());
		    }
		    
		}
	    };
	
	roster.sort(byLastName); // ArrayList has a sort method 
	System.out.println("Sort by lastName: \n" + roster);

	// the second argument is an instance of an anonymous inner class
	// that implements java.util.Comparator<Student>, specified as
	// a Lambda Expression
	
	java.util.Collections.sort(roster,
				   (s1,s2)->(Double.compare(s1.getGpa(),
							    s2.getGpa())));
	System.out.println("Sorted using gpa: \n" + roster);
    }
    
}
{% endhighlight %}

# Advanced Comparators

Once you understand the idea of a Comparator and a lambda, you can get more advanced.


* Automatic generation of comparators from getters (<https://howtodoinjava.com/java/sort/sort-on-multiple-fields/>)
* using `.thenComparing()` to sort on multiple fields  (<https://howtodoinjava.com/java/sort/sort-on-multiple-fields/>)
* using `.reversed()` to reverse the order of an existing comparator (https://howtodoinjava.com/java/sort/collections-sort/)

