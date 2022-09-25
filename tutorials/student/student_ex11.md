---
title: "Student: ex11"
parent: Student
grand_parent: Tutorials
description: "More on Exceptions, static methods, tdd"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex11
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}



# Overview

In this example we show how to write a static method
to compute the [Luhn Checksum](https://en.wikipedia.org/wiki/Luhn_algorithm) and how to test it.

To illustrate the Test-Driven Development approach (tdd) we start by
first writing some tests.  To set up our tests, we start by doing
the Lund calculation by hand on a few six digit perms.   This does two things:
* It gives us some data for our tests
* It gives us practice in applying the algorithm; this will help us
  understand how to write the code.

Take `123456`.  Applying the [Luhn algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm), we get:
 
```
1 + 2x2 + 3 + 4x2 + 5 + 6x2 =
1 +  4  + 3 +  8  + 5 + (1+2)  =  24
```

To get to a number divisble by 10, we need to add 6,
so the check digit is 6: `1234566`

(Another algorithm that gets to the same result: `(sumOfDigits * 9 ) % 10`.  For example, `24*9 = 216, 216%10 = 6`)


For another example, consider: `111111`

```
1 + 1x2 + 1 + 1x2 + 1 + 1x2 = 
1 +  2  + 1 +  2 +  1 +  2  = 9
```

To get to a number divisible by 10, we need to add 1,
so the check digit is 1: `1111111`.

(Using the formula  `(sumOfDigits * 9 ) % 10` again:   `9*9 = 81, 81%10 = 1`)

To check our work, we can use this [online Luhn calculator](https://simplycalc.com/luhn-calculate.php).

With this in mind, we now have at least two test cases
for computing check digits over six digit numbers.

So, we can write some test cases for a utility method
that we'll put into its own class called `Luhn.java`.

* We'll write a stub for it first
* Then we'll write some tests
* Finally we'll write an implementation
* Then we'll check the mutations testing.

Here's what a stub for the Luhn.java class would look like.  The idea is that we the static member function `checkDigit` will take a number as it's argument that lacks a check digit, and it will compute the check digit that needs to be placed at the end.   We return `-1` as the stub value, since that should fail every test.

```java
package edu.ucsb.cs156.student;

public class Luhn {

    public static int checkDigit(int num) {
    	return -1; // stub
    }

}
```

Note: We could also have used any number other than the values `0`
through `9` since those are values that could sometimes be a correct
return value for the function; ideally, a stub value will *always*
fail the tests.


Now we also write some tests:

```java
package edu.ucsb.cs156.student;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class LuhnTest {

    @Test
    public void test_luhn_111111() {
        assertEquals(1, Luhn.checkDigit(111111));
    }

    @Test
    public void test_luhn_123456() {
        assertEquals(6, Luhn.checkDigit(123456));
    }

    @Test
    public void test_luhn_182734() {
        assertEquals(4, Luhn.checkDigit(182734));
    }

}
```

We observe that these tests fail on the stub, then we replace the stub
with what we beleive to be a correct implementation:

```java
public static int checkDigit(int num) {
        
        int currentPlace = 0;
        int sumOfDigits = 0;

        while (num > 0) {
            currentPlace += 1;
            int leastSigDigit = num % 10;
            int thisValue = leastSigDigit;

            if (currentPlace % 2 == 1) {
                thisValue = leastSigDigit * 2;
            }

            if (thisValue <= 9)
                sumOfDigits += thisValue;
            else
                sumOfDigits += 1 + (thisValue % 10);
            num = num / 10;
        }

        return ( sumOfDigits * 9 ) % 10;
    }
```

The tests pass.    We then refactor our `Student` class with
a static member function to test whether a perm number is valid.

This static member function incorporates all of the logic about
valid perm numbers into one place.

Here's the constructor before our refactor:


```java
public Student(String name, int perm) {

        if (perm < 1 || perm > 9999999) {
            throw new IllegalArgumentException("Unacceptable value for perm: " + perm);
        }

        this.name = name;
        this.perm = perm;
    }

```


And here's the constructor after:

```java
 public Student(String name, int perm) {

        if (!validPerm(perm)) {
            throw new IllegalArgumentException("Unacceptable value for perm: " + perm);
        }

        this.name = name;
        this.perm = perm;
    }
```

Here's a first implementation of `validPerm` that only
takes the existing check into consideration.  Ordinarily we might
apply DeMorgan's law to this and convert it into a one liner, i.e. `return perm >= 1 && perm <= 9999999;`, however in this case, since we are going to
be adding more logic, keeping it in this form makes sense for now.

```java
 public static boolean validPerm(int perm) {
        if (perm < 1 || perm > 9999999) {
            return false;
        }
	return true;
    }
```

We now add test cases for `validPerm` to our `StudentTest` class, as shown in the examples below.   We use `assertTrue(actual)` rather than `assertEquals(true, actual)`, and `assertFalse(actual)` rather than `assertEquals(false,actual)`; this is a matter of style for JUnit tests.   Two additional imports are required to define these methods.

```java

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertFalse;

...

    @Test
    public void test_validPerm_1111111() {
        assertTrue(Student.validPerm(1111111));
    }

    @Test
    public void test_validPerm_neg1_false() {
        assertFalse(Student.validPerm(-1));
    }
```

We can now add additional logic to the `validPerm` method,
incorporating a call to the `checkDigit` method of our `Luhn` class:

```java
    public static boolean validPerm(int perm) {
        if (perm < 1 || perm > 9999999) {
            return false;
        }
        if (perm <= 999999)
           return true;
        int lastDigit = perm % 10;
        int firstSix = perm / 10;
        return lastDigit == Luhn.checkDigit(firstSix);
    }
```

Some refactoring now has to result, because, for example, the perm of
`9999999` in our default constructor is now an invalid perm; the
checkdigit for `999999` is actually `6`.  Similarly, some of the other
perms we had in our test cases are no longer legal, so we have to make
some adjustments.

Eventually, however, we get to a point where all of the test cases
are passing, and we can check the test coverage.

As we see from the report archived at the link below,
we now have some gaps in our test coverage.  In ex12, we will
discuss how to address those.

* [`target/pit-reports/202201051554/index.html`](https://ucsb-cs156.github.io/tutorials/student/student_ex11/target/pit-reports/202201051554/index.html)
