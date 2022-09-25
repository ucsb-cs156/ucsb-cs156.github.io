---
title: "Student: ex03"
parent: Student
grand_parent: Tutorials
description: "Converting to Maven"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex03
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}


# Overview

In this example we introduce the use of Maven for compiling.

The example code that supports this lesson is in a repository ("repo" for short) at this link.  Note that this link is showing the branch <tt>{{page.code_branch}}</tt>, *not* the <tt>main</tt> branch of the repo.

* <{{page.code_repo}}/tree/{{page.code_branch}}>

If you have already cloned this repo and are at the command line, you can switch to the <tt>{{page.code_branch}}</tt> branch with this command:

* <tt>git checkout {{page.code_branch}}</tt>


# Converting to Maven

While it's good to know how to work with plain old Java code using `java` and `javac`, once
 you get beyond relatively small projects, you need more powerful tools.

There's a dillema:
* It's easiest to switch to these more powerful tools when the project is still relatively small.
* On the other hand, the *value* of doing so can be tough to see when the project is still small.

To help make the case for the value of Maven, shortly after introducing it, we'll show how to
use some sophisticated tools to do testing, measure test coverage, and measure the effectiveness of
a suite of test cases.   This can all be shown on a relatively small code base, but would be difficult
to accomplish without using a tool such as Maven.

In this example, we will not change any of the code; we are *only* showing how to convert the
repo to using Maven.

We are also not yet introducing *packages*, that too will be done in a later tutorial.

# What do you need to convert to Maven?

To convert a regular Java project to a Maven project, you really only need to do three things:

* Create the directory structure that Maven expects
* Put the code into that directory structure
* Create a `pom.xml` for the project.

# The directory structure

The directory structure needed by Maven is shown here:

<img width="454" alt="maven-basic-directory-structure" src="https://user-images.githubusercontent.com/1119017/192168376-a83ccc1a-4a0b-49d9-97e4-ad88f671b40d.png">

To turn a "flat" project where everything is in one directory into a Maven project, the first
thing we do is create the `src/main/java` directory tree.  We can do this in an IDE such as VSCode by pointing and
clicking, or with this Unix command.  The `mkdir` command makes directories, and the `-p` flag indicates to create
an entire *path* all at once.

* `mkdir -p src/main/java`

We can then move all of the Java files into that directory using a wildcard (i.e. a `*`)

* `mv *.java src/main/java`

We can remove any .class files hanging out in the top level directory; maven will automatically clean those up for us
once we switch to Maven:

* `rm -f *.class`

Finally, we need a `pom.xml` file.  Here's a minimal one.  An explanation of this file, which you are
*strongly encouraged to read*, can be found
here: <https://ucsb-cs156.github.io/topics/maven_hello_world/>.

Seriously, go read that.  I would have included it in the tutorial here, but it seemed redundant to copy/paste,
when you can just go read it.

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

</project>
```

With these changes, we can now use Maven commands to compile and package our code.

* `mvn compile`
* `mvn package`

To run, it's the same as before, except we use `-cp target/student-1.0.0.jar` to point the Java Virtual Machine (jvm) to
load the `.class` files from the indicated `.jar` file instead of from the current directory.

* `java -cp target/student-1.0.0.jar Main Chris 1234567`

Here's what it looks like when we've done those things:

```
pconrad@Phillips-MacBook-Pro student-tutorial % mvn clean
[INFO] Scanning for projects...
[INFO] 
[INFO] -----------------------< edu.ucsb.cs156:student >-----------------------
[INFO] Building student 1.0.0
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ student ---
[INFO] Deleting /Users/pconrad/github/ucsb-cs156/student-tutorial/target
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.197 s
[INFO] Finished at: 2020-10-12T13:20:49-07:00
[INFO] ------------------------------------------------------------------------
pconrad@Phillips-MacBook-Pro student-tutorial % mvn compile
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
[INFO] Changes detected - recompiling the module!
[WARNING] File encoding has not been set, using platform encoding UTF-8, i.e. build is platform dependent!
[INFO] Compiling 2 source files to /Users/pconrad/github/ucsb-cs156/student-tutorial/target/classes
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.093 s
[INFO] Finished at: 2020-10-12T13:20:54-07:00
[INFO] ------------------------------------------------------------------------
pconrad@Phillips-MacBook-Pro student-tutorial % mvn package
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
[INFO] No sources to compile
[INFO] 
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ student ---
[INFO] No tests to run.
[INFO] 
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ student ---
[INFO] Building jar: /Users/pconrad/github/ucsb-cs156/student-tutorial/target/student-1.0.0.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.750 s
[INFO] Finished at: 2020-10-12T13:20:58-07:00
[INFO] ------------------------------------------------------------------------
pconrad@Phillips-MacBook-Pro student-tutorial % java -cp target/student-1.0.0.jar Main Chris 1234567
s1 = [name: Sample Student, perm: 9999999]
s2 = [name: Chris, perm: 1234567]
pconrad@Phillips-MacBook-Pro student-tutorial % 
```

# If we want to pass a first and last name

To run with a student name that has a space in it such as `Mary Ann` or a full name like `Chris Gaucho`, we can use `""` on the 
command line, as shown below.   As you can see, if you don't,
it will take `Gaucho` as the perm number, and the program
will print an error message.  (This message comes from the
fact that `argv.length` is now 3 rather than 2.)

```
pconrad@Phillips-MacBook-Pro student-tutorial % java -cp target/student-1.0.0.jar Main "Chris Gaucho" 1234567
s1 = [name: Sample Student, perm: 9999999]
s2 = [name: Chris Gaucho, perm: 1234567]
pconrad@Phillips-MacBook-Pro student-tutorial % java -cp target/student-1.0.0.jar Main Chris Gaucho 1234567 
Usage: java Main name perm
  perm should be a positive integer between 1 and 9999999
pconrad@Phillips-MacBook-Pro student-tutorial % 
```




