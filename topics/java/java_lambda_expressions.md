---
parent: Java
grand_parent: Topics
layout: default
title: "Java: Lambda Expressions"
description:  "Shorter, cleaner code using anonymous functions"
indent: true
---

Lambda expressions were introduced in Java 8.  They provide a much cleaner syntax than previous Java versions for the solution to 
several common programming tasks in Java. Here are some examples

* writing a custom sort for an `ArrayList` of objects (or any `Collection` of objects)
* writing event handlers for Swing GUIs
* writing event handlers for web applications

# References:

* [Oracle lesson on Lambda Expressions](https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html)

# Example of Lambda Expressions

One of the most common examples of lambdas expressions is to specify an instance of a class that implements the Comparator<T> interface.
  
Suppose you have a `Dog` object with getters  for `name` and `weight`:

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

A `Comparator<Dog>` would look like this:

```java
public class DogWeightComparator implements java.util.Comparator<Dog> {
    @Override
    public int compare(Dog o1, Dog o2) {
        return Double.compare(o1.getWeight(),o2.getWeight());
    }
}
```

But if this class is only going to ever be instantiated once, e.g. in a sort like this one:

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
        java.util.Collections.sort(kennel,new DogWeightComparator());
        System.out.println("Sorted by weight " + kennel);       
    }   
}
```

Then it is much easier to specify the comparator as a lambda function like this:

```
Comparator<Dog> sortByWeight = (dog1, dog2) -> Double.compare(dog1.getWeight(),dog2.getWeight());
```

The lambda expression:

```
(dog1, dog2) -> Double.compare(dog1.getWeight(),dog2.getWeight())
```

Can be interpreted this way:
* Recall that the `compare` method of [`Comparator<T>`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Comparator.html) has this signature:

  ```java
  int	compare (T o1, T o2)
  ```

  and is expected to return a `int` value that is:
  - less than zero if `o1 < o2`,  that is `o1` should appear before `o2` when sortig in ascending order.
  - equal to zero if `o1.equals(o2)` (that is, `o1` and `o2` can appear in either order when sorting)
  - greater than zero if `o1 > o2`, that is `o1` should appear after `o2` when sortig in ascending order.


Because the lambda expression must have the type `Comparator<Dog>`, we immediately know that this is an implementation of the `compare` method of
the interface `Comparator<Dog>`.   

- It has to be: `Comparator<T>` is marked with the annotation `@FunctionalInterface`, which means it is an interface
  with *exactly one abstract method *(no more than one, no fewer than one).
- Therefore, we can infer that `(dog1, dog2)` is the parameter list for the `compare` method.
- We don't have to specify `(Dog dog1, Dog dog2)`; that would be redundant, since we can *infer* the types of `dog1` and `dog2`
- Similarly, with a lambda, the value on the right hand side of the arrow (`->`) is the return value.  
- For lambdas that are single line
  implementations, i.e. `return expression;`, we can omit the braces `{}` and the `return` statement, and just put the `expression` on the 
  right hand side of the arrow (`->`).
    
    
# Variations on Lambdas:

It all comes down to the method that you are implementing.

Arguments:

* If there are no parameters to the method, you write `()->expression`.  The empty parameter list `()` shows that there are no arguments.
* There can be any number of arguments, e.g. `(x)->expression`, `(x,y)->expression`, `(x,y,z)->expression`, etc.

Return value:

* If the implementation is just `return expression`, you can leave out the braces and the keyword `return`.
* But optionally, you can put a set of braces, and as many statements as you want.  For example, these are both valid:

First version:

```java
Comparator<Dog> sortByWeight = (dog1, dog2) -> Double.compare(dog1.getWeight(),dog2.getWeight());
```

Second version:

```java
Comparator<Dog> sortByWeight = (dog1, dog2) -> {
   System.out.println("I'm inside the sortByWeight comparator.  Hi there!");
   double dogWeight1 = dog1.getWeight();
   double dogWeight2 = dog2.getWeight();
   return Double.compare(dogWeight1, dogWeight2);
}
```


