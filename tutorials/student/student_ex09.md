---
title: "Student: ex09"
parent: Student
grand_parent: Tutorials
description: "Covering toString with a test and excluding Main gets us to 100% coverage"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex09
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# Overview

In this example we show how to use the 
code coverage and mutation testing reports
to find which tests are missing and get to 100%
test coverage.

In the case of `Student.java` we add the missing
unit tests for the toString method. 

In the case of `Main.java`, we exclude the class
from the code coverage analysis altogether.

Both of these are important things to know how to
do; sometimes it's important to have code covered by
tests, and other times, it's important not to waste time
getting test coverage for code where it isn't really
adding any value.

# Starting where we left off

Let's start by running the mutation
testing report on the code in branch `ex08`

```
ucsb-cs156/student-tutorial % git checkout ex08
Already on 'ex08'
ucsb-cs156/student-tutorial % mvn test org.pitest:pitest-maven:mutationCoverage
...
=======================================================
- Statistics
=======================================================
>> Generated 10 mutations Killed 2 (20%)
>> Ran 2 tests (0.2 tests per mutation)
```

When we open up the reports (as we did in ex08) we
see that the line of code not covered in `Student.java` 
is the line for the `toString` method:

* Remember: the file to open up to see the reports is this one: <tt>target/pit-reports/<i>yyyymmddhhmmss</i>/index.html</tt> where <tt><i>yyyymmddhhmmss</i></tt> is a date/time stamp.

![student.java-50.png](student.java-50.png)

So, let's write a JUnit test for the `toString` method.

We'll add that to `StudentTest.java` which is located in the folder `src/test/java/edu/ucsb/cs156/student/`

Here's what the code looks like:

```java
 @Test
    public void test_toString1() {
        Student s = new Student();
        String expected = "[name: Sample Student, perm:9999999]";
        assertEquals(expected, s.toString());
    }
```

Note that we always start a JUnit test with `@Test`.  This is what marks the method as one that should be
run when we type `mvn test`.

The `assertEquals` method takes two parameters, the
first of which should be the expected value, and the
second of which should be the actual value computed
by the unit under test, in this case, the `toString` method.

With this test in place, the first thing to do is run
`mvn test` to ensure it compiles and passes:

On our first run, we get this:

```
Failed tests:   test_toString1(edu.ucsb.cs156.student.StudentTest): expected:<...ample Student, perm:[]9999999]> but was:<...ample Student, perm:[ ]9999999]>
```

This tells us that we have an extra space in our *actual* output that wasn't there in the expected output.  We can adjust either the expected or the
actual output to match; we'll adjust the expected
output in this case.

We modify the test like this:

```java
String expected = "[name: Sample Student, perm: 9999999]";
```

We run again and get this:

```
Tests run: 4, Failures: 0, Errors: 0, Skipped: 0
```

Now we can run the mutation tests and see if we were successful.  We'll add `clean` to the line so that
we only have one pit report:

```
mvn clean test org.pitest:pitest-maven:mutationCoverage
```

The result is this:

```
>> Generated 10 mutations Killed 3 (30%)
>> Ran 3 tests (0.3 tests per mutation)
```

That's better than before.  And when we open up the file, we see that Student.java now has 100% test
coverage, while Main.java has 0% test coverage.

```
Breakdown by Class
Name          Line Coverage 	Mutation Coverage
Main.java       0%     0/17           0%   0/7
Student.java 	100%  11/11         100%   3/3
```

Now the question arises: should we write tests for this Main?

If we look at what this Main is doing, we can see that it's purposes were really only to:

1. Serve as an example of a class with a `main` method.
2. Serve as an example of how to pass command line parameters
3. Serve as an example of how to convert a `String` to an `int`
4. Provide a way of testing our `Studnet` class before we had JUnit testing set up.

So while we *could* write test cases for this `main`
method and this `Main` class, it may be better to instead either:
* Remove the file from the project altogether.
* Mark it as an exception, a file to be excluded when
  we compute test coverage, *or*

Because it is handy to keep the file around,
we'll try the second approach instead.  

In the `pom.xml`, we find this `<plugin>` element
for Pitest:

```xml
            <plugin>
                <groupId>org.pitest</groupId>
                <artifactId>pitest-maven</artifactId>
                <version>1.7.3</version>
                <!-- this is needed to run pitest with JUnit 5 -->
                <dependencies>
                    <dependency>
                        <groupId>org.pitest</groupId>
                        <artifactId>pitest-junit5-plugin</artifactId>
                        <version>0.14</version>
                    </dependency>
                </dependencies>
                <configuration>
                    <verbose>true</verbose>
                    <targetClasses>
                        <param>edu.*</param>
                    </targetClasses>
                    <targetTests>
                        <param>edu.*</param>
                    </targetTests>
                    <outputFormats>
                        <outputFormat>HTML</outputFormat>
                        <outputFormat>CSV</outputFormat>
                        <outputFormat>XML</outputFormat>
                    </outputFormats>
                </configuration>
            </plugin>
```

The part to focus on is this:

```xml
                    <targetClasses>
                        <param>edu.*</param>
                    </targetClasses>
```

As a sibling to this `<targetClasses>` element, we can
add an `<excludedClasses>` element (as described in 
[this post](https://groups.google.com/g/pitusers/c/R_HOHUTgSRk)):


```xml
                    <targetClasses>
                        <param>edu.*</param>
                    </targetClasses>
                    <excludedClasses>
                        <param>edu.ucsb.cs156.student.Main</param>
                    </excludedClasses>
```

We simply specify the name of the class we want to exclude, using it's full package name.  When we run
pit again, we see that we now have 100% coverage

```
>> Generated 3 mutations Killed 3 (100%)
>> Ran 3 tests (1 tests per mutation)
```

If you open up the full report, you'll see that
`Main.java` no longer appears.

Our jacoco report, however, still shows `Main.java`
as having no coverage.  We can take a similar step
to configure the jacoco report in the `pom.xml`
as highlighted in [this post](https://ngeor.com/2018/04/21/exclude-class-from-jacoco-coverage.html).

This code can go inside the `<plugin>` element
for jacoco, just before the closing `</plugin>`
tag:

```xml
                <configuration>
                    <excludes>
                      <exclude>edu/ucsb/cs156/student/Main.class</exclude>
                    </excludes>
                </configuration>
```

This excludes the `Main`.  Note that for jacoco, we
need to specify `.class` on the end, while for Pit,
we leave that out.

Now that we have 100% test coverage both in our
jacoco and our pit report, we can proceed to
actually adding some more functionality to our
Student class.  We'll do that in ex10.
