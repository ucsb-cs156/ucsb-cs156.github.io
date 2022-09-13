---
title: "Student: ex04"
parent: Student
grand_parent: Tutorials
description: "Adding JUnit tests"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex04
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# Overview

In this example we introduce JUnit 5 tests.

JUnit tests allow us to automate the testing of our code.

Rather than having to run a driver class and manually inspect
whether the output is correct, we can write code that does this
for us.

This involves three steps:

- Setting up a directory for test code, following the
  Maven directory conventions.
- Adding a _dependencies_ for JUnit to our `pom.xml`
  - This tells Maven to download the `.jar` files for
    JUnit from `maven.org` and include them in the files
    for the project.
- Setting up the actual test code.

# Setting up the directory

To our existing Maven directory structure, we add the
directory `src/test/java` as shown in the diagram below.

Maven separates test code from regular code so that:

- Test code can be compiled in a different environment that includes
  extra dependencies (e.g. JUnit)
- Test code can be excluded when the code is packaged to send to
  a customer.

We can create this directory with:

- `mkdir -p src/test/java`

# Adding the dependency

The dependency goes into the `pom.xml` in a section called
`dependencies`. Here's what the entire `pom.xml` looks like
with the new dependency added.

```xml
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>edu.ucsb.cs156</groupId>
    <artifactId>student</artifactId>
    <version>1.0.0</version>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.0</version>
                <configuration>
                    <release>17</release>
                </configuration>
            </plugin>
        </plugins>
    </build>

    <dependencies>
         <!-- https://mvnrepository.com/artifact/org.junit.jupiter/junit-jupiter-api -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-api</artifactId>
            <version>5.8.2</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-engine</artifactId>
            <version>5.8.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

</project>

```

You may wonder: how do we know what to put into the `pom.xml`
for any given dependency? The answer is that the documentation
for the package will usually tell you. If you don't know,
you can look up the code at the website: <https://mvnrepository.com>.

The ` <scope>test</scope>` means that these jar files will only be in the `CLASSPATH` when we are working
with testing; this is one of the reasons that Maven requires us to have separate directory
trees for `src/main/java` and `src/test/java`.

# Adding Tests

We can now add tests using JUnit.

Here is an example of what writing tests looks like with JUnit.

We put the tests in a class called `StudentTest`, in a file called `StudentTest.java` under
`src/test/java`.  The full listing is followed by an explanation of the content:

```java
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

public class StudentTest {

    @Test
    public void test_getName1() {
        Student s = new Student();
        assertEquals("Sample Student", s.getName());
    }

    @Test
    public void test_getName2() {
        Student s = new Student("Chris Gaucho", 1234567);
        assertEquals("Chris Gaucho", s.getName());
    }

    @Test
    public void test_getPerm1() {
        Student s = new Student();
        assertEquals(9999999, s.getPerm());
    }

}
```

The first two lines are imports.  

```
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;
```

The first of these imports indicate that 
we will be using `assertEquals`, a method that comes
from the class `org.junit.jupiter.api.Assertions`.

* It is important to note that we *do not have to use
  an import statement* if we are willing to type out the
  full name `org.junit.jupiter.api.Assertions.assertEquals` every time we
  refer to this method.   However, it is much simpler to just
  be able to type `assertEquals`.
* The first import is an `import static` because it refers to
  importing a method rather than a class.
* The second import, ` org.junit.jupiter.api.Test` imports a class, and allows
  us to use the `@Test` annotation to mark which methods are
  test methods.  Marking these works with Maven and JUnit so that
  these method are invoked when we type `mvn test`

We then have `public class StudentTest {` which names the class.
It is a very typical naming convention to use the name of the class
followed by `Test` in camel case to name classes that run
tests on another class.
* As a rule, put tests for `Foo.java` in `FooTest.java` 

Finally, we have the test methods.  It is traditional
to test only *one unit* at a time when writing unit tests
(hence the name).    However, to create an object,
we have to invoke the constructor, and then to inspect the
object we typically have to invoke at least one other method.

Accordingly, since we have two different constructors,
we create two different tests for the `getName` method.
Arguably, each of these tests is a test both of one of the
constructors, and the `getName` method.

We have only written one of the tests that is needed for the
`getPerm` method; this is intentional.    Througout the tutorial,
we are going to leave a few things out so that (a) you see what happens when we do, and (b) you have some work to try for yourself.

# Running the tests

To run the tests, we can use `mvn test` as shown here:

```
pconrad@Phillips-MacBook-Pro student-tutorial % mvn test
[INFO] Scanning for projects...
[INFO] 
[INFO] -----------------------< edu.ucsb.cs156:student >-----------------------
[INFO] Building student 1.0.0
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ student ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /Users/pconrad/github/ucsb-cs156/student-tutorial/src/main/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.0:compile (default-compile) @ student ---
[INFO] Nothing to compile - all classes are up to date
[INFO] 
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ student ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /Users/pconrad/github/ucsb-cs156/student-tutorial/src/test/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.0:testCompile (default-testCompile) @ student ---
[INFO] Nothing to compile - all classes are up to date
[INFO] 
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ student ---
[INFO] Surefire report directory: /Users/pconrad/github/ucsb-cs156/student-tutorial/target/surefire-reports

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running StudentTest
Tests run: 3, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.038 sec

Results :

Tests run: 3, Failures: 0, Errors: 0, Skipped: 0

[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.822 s
[INFO] Finished at: 2020-10-12T14:07:01-07:00
[INFO] ------------------------------------------------------------------------
pconrad@Phillips-MacBook-Pro student-tutorial % 
```

The part of this output that we really want to pay attention to
is this part:


```
Tests run: 3, Failures: 0, Errors: 0, Skipped: 0
```

To see what it would look like if there were a test
failure, we'll temporarily change our default consructor
by putting in a different value from the one the test
expects:

```java
  public Student() {
        name = "Eleanor Shelstrop";
        perm = 9999999;
    }
```

Now when we test, we get this output. You can see that the part
that is different is in square brackets (`[]`)

```
Results :

Failed tests:   test_getName1(StudentTest): expected:<[Sample Student]> but was:<[Eleanor Shelstrop]>

Tests run: 3, Failures: 1, Errors: 0, Skipped: 0
```

Changing it back restores the tests output to zero failures:

```
Tests run: 3, Failures: 0, Errors: 0, Skipped: 0
```

Now, this is good, but this still relies on us to remember to run the tests.   In the next tutorial, we'll see that we can use GitHub Actions to automate this process for us.

(updated for JUnit 5/Java 17, 01/05/22)
