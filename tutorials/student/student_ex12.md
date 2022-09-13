---
title: "Student: ex12"
parent: Student
grand_parent: Tutorials
description: "Adding more test coverage"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex12
pit_report: target/pit-reports/202201051554
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}



<style>
.pop {
    outline:none;
}

.pop strong {
    line-height: 30px;
}

.pop {
    text-decoration: none;
}

.pop span {
    z-index: 10;
    display: none;
    padding: 14px 20px;
    margin-top: -30px;
    margin-left: 28px;
    width: 800px;
    line-height: 16px;
    word-wrap: break-word;
    border-radius: 4px;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;
    -moz-box-shadow: 5px 5px 8px #CCC;
    -webkit-box-shadow: 5px 5px 8px #CCC;
    box-shadow: 5px 5px 8px #CCC;
}

.pop:hover span {
    display: inline;
    position: absolute;
    color: #111;
    border: 1px solid #DCA;
    background: #fffAF0;
}


.covered {
    background-color: #ddffdd;
}

.uncovered {
    background-color: #ffdddd;
}

.killed, .KILLED {
    background-color: #aaffaa;
}

.survived, .SURVIVED {
    background-color: #ffaaaa;
}
</style>

For this exercise, we focus on the report from ex11, and what needs to be done to resolve the gaps in test coverage.

A snapshot of the mutation coverage report can be found here:

* [`../student_ex11/target/{{page.pit_report}}/index.html`](../student_ex11/{{page.pit_report}}/index.html)


# Uncovered lines in `Student.java` 

We can see that there are three places in `Student.java` that are not covered by tests; we've marked those lines with comments `//RED` below, based on the [report for `Student.java`](../student_ex11/target/{{page.pit_report}}/edu.ucsb.cs156.student/Student.java.html)


```java
    public static boolean validPerm(int perm) {	
        if (perm < 1 || perm > 9999999) {    // RED
            return false;
        }
        if (perm <= 999999) // RED
           return true;
        int lastDigit = perm % 10;
        int firstSix = perm / 10;
        return lastDigit == Luhn.checkDigit(firstSix); // RED
    }
```

What we need to is to write tests that cover these lines.
Consider this line:

```
        if (perm < 1 || perm > 9999999) {    // RED
```

Looking at the mutation report more closely, we can see what
it says this about this line.  Next to line 35, there is a 4 that, if you hover over it, brings up a pop up.

The 4 means that there were four different mutations of this line of code; and the fact that the line is red and not green, means that
at least one of those mutants survived.  We can see which one, exactly, by hovering over the 4 and looking at the pop up:

The popup looks like this:

```
1. changed conditional boundary → KILLED 
2. changed conditional boundary → SURVIVED
3. negated conditional → KILLED 
4. negated conditional → KILLED
```

This shows us that the mutation that survived is one where the mutation was `changed conditional boundary`.  This  means changing:

<div style="max-width:15em;" markdown="1">

| From | To |
|------|----|
| `<` | `<=` |
| `<=` | `<` |
| `>` | `>=` |
| `>=` | `>` |
{:.table .table-sm .table-striped .table-bordered}

</div>

So the mutations of this line under this rule could be:

* `if (perm <= 1 || perm > 9999999) {   `
* `if (perm < 1 || perm >= 9999999) {   `

Let's consider what happens in these scenarios by first asking:
* Will these mutations introduce a bug?
  - It turns out that, 
    [as explained here](https://blog.scottlogic.com/2017/09/25/mutation-testing.html#excellent-is-there-anything-mutation-testing-cant-do), there are cases
    where mutations do not change the correctness of the code.  If the mutation
    doesn't change the correctness of the code, we can't expect our unit tests
    to catch the problem.
  - In those cases, we may have to simply live with less than 100% as a result,
    or consider if there is a way to rewrite the code without sacrificing
    readability.

* If the mutation *does* introduce a bug, what bug is it, and how can we
  catch it with a test?

Consider first the case of: 
* `if (perm <= 1 || perm > 9999999) {   `

Here, if we want to treat `1` as a valid perm, then this mutation *should*
introduce a bug where `1` is rejected when it should be accepted as a valid
perm.  So the test that should catch
*this* mutation is this one, which is indeed a test not yet present
in ex11:

```java
    @Test
    public void test_validPerm_1() {
      assertTrue(Student.validPerm(1));
    }
```

However consider this line:

* `if (perm < 1 || perm >= 9999999) {   `

If this were the only test of what is a valid perm, then by changing `>` to
`>=`, we would be rejecting the valid perm `9999999` instead of accepting it.The trouble is, we now know that after introducing the Luhn check, that in fact
the highest valid perm is `9999996` rather than `9999999`. So introducing
a test for `9999999` will not change our outcome.  

What will work is to first change our code to a more correct boundary:

```java
    public static boolean validPerm(int perm) {	
        if (perm < 1 || perm > 9999996) {   
            return false;
        }
        ...
    }
```

Then we change our test to this new boundary, `9999996`:

```java
    @Test
    public void test_validPerm_9999996() {
      assertTrue(Student.validPerm(9999996));
    }
```

We run our tests again with:

```
mvn test org.pitest:pitest-maven:mutationCoverage
```

And we see that this takes care of the first line that was red.  Now we proceed
to this one:

```java
        if (perm <= 999999) // RED
```

Again, we look at the type of mutation that survived and discover
that it is again a "changed condition boundary".   The first thing
to try is a test for the exact value in the condition.  As we saw
above, this doesn't always work, but it often does, so its the first
thing we try:

```java
    @Test
    public void test_validPerm_999999() {
      assertTrue(Student.validPerm(999999));
    }
```

That leaves us with just one line left in `Student.java`, this one:

```java
        return lastDigit == Luhn.checkDigit(firstSix); // RED
```

Look at the coverage report, we see that this time the mutation
that survived was this:

```
1. replaced boolean return with true for edu/ucsb/cs156/student/Student::validPerm → SURVIVED
```

That is to say, the mutation was to *always return true*.  Thus we need a
test case where the the correct result for the unit under test is to
return `false` on this exact line of code, i.e. a test where all of the 
other checks will lead us to this line, but the check digit will fail.

We know from previous work that the six digit perm `1111111` has the check digit `1`, so if we use `1111119`, that should cause this mutation to be
killed (why? because we expect the result `false`, but the mutation will
force the method to return `true`).

So here is the test case needed:

```java
    @Test
    public void test_validPerm_1111119() {
      assertFalse(Student.validPerm(1111119));
    }
```

Let's run again with:

```
mvn test org.pitest:pitest-maven:mutationCoverage
```

This gets us 100% coverage in `Student.java`

# The `main` function in `Luhn.java` 

We see first that the `main` function
in `Luhn.java` is not covered by
tests.

However, since the only purpose
of this main was to do quick
checks (interactive testing) while
developing, one simple fix is to
just comment it out.  If it were needed
again during development,
it would be easy to restore it.

```java
    // public static void main(String [] args) {
    //     System.out.println(checkDigit(Integer.parseInt(args[0])));
    // }
```

This gets us *almost* to 100% code coverage



# `Luhn.java` still has pink on the opening line of the class

The `Luhn.java` file still shows, after all this, that the first
line of the class is "uncovered".

We speculate that this is because the class likely has a default constructor,
and that default constructor is not being tested.

So we try this.  It's a bit of hack, but as it turns out, it works:

```java
    @Test
    public void test_luhn_defaultConstructor() {
       Luhn l = new Luhn();
    }
```

It could be argued that this "hack" of a test adds no value because nothing is being asserted, and the code that is "tested" (though not really) does nothing useful.

On the other hand, we could also argue that the test is a *sign* the fact that
the developer has considered the test coverage of `Luhn.java` and ruled out the possibility that the default constructor would be a problem.

In any case, this gets us to 100% test coverage

# Could we do something else instead of commenting out the main?

Note that leaving commented out code in the source code files
is a controversial choice here.  Some organizations would frown on this
in production code.   So here are two other options we could have chosen:

* Refactor it into it's own class, and then specify that class in the `pom.xml` as one that is excluded from pit testing. (As of October 2020, pitest does not have an official way to mark specfic methods in a class as ones to skip over when computing pit mutation testing; this can only be done reliably at the class level.)

* Just remove the main method completely.  

# What's next?

That's it for ex12.   In the next exercise, we start to look at reading
student records from files into an ArrayList, as preparation for sorting.





