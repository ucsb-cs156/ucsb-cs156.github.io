---
parent: Ant
grand_parent: Topics
layout: default
title: "Ant: Comparing files"
description:  "Doing something like a unix 'diff -q' via Ant"
indent: true
---

There are three approaches you can use in Ant to compare two files:

* Use built-in features of Ant, with no add-ons, and no external dependencies
* Use third-party add-ons for Ant (which may require extra .jar files, and some tricky configuration)
* Rely on the system "diff" command (which might make your `build.xml` file non-portable across operating systems)

This file will focus on the first approach: a way of doing file comparison that uses ONLY features built into standard
Apache Ant, with no extra add ons.

# Example of how to implement something like `diff -q`

Below is an excerpt from an example `build.xml` that shows how to make an Ant file do different things depending on whether
two files match or not.   This example uses this to check whether the output of a program matches the expected output.

Note that this example ONLY depends on whether the files match or not; it does NOT
do the full diff behavior of showing the lines that do or do not match.  So, it reality, it is more like 
the unix `diff -q` than a true Unix `diff`.)

The `diff-test` target shown uses the `java` task to run a program from a jar file, taking standard input from `testdata/test01.input.txt`, and writing its
standard output into a temporary directory called `temp.d`, in a file called `test01.output.txt`.  

It then compares the files `testdata/test01.expected.txt` and `temp.d/test01.output.txt` to see if they match.  If they do,
then the property `test01passed` is set to `"true"`.   

Then, `echo` tasks with the `if:set` and `unless:set` attributes are used to print output conditionally based on 
whether the `test01passed` property has been set or not.   Note that the following must appear in the opening
`<project>` tag of the `build.xml` file if the if `if:set` and `unless:set` tags are to be used (more information at: 
<https://ant.apache.org/manual/ifunless.html>)

```xml
   xmlns:if="ant:if" xmlns:unless="ant:unless"                                              
```

Here's a partial listing of the `build.xml` that implements the file comparison.

```xml

<project default="compile" xmlns:if="ant:if" xmlns:unless="ant:unless">
...
<target name="diff-test" depends="compile" description="run tests using CLI, diffing actual and expected output ">
    <delete dir="temp.d" quiet="true" />
    <mkdir dir="temp.d" />
    <java jar="${jar.file}" fork="true">
      <redirector 
         input="testdata/test01.input.txt" 
         output="temp.d/test01.output.txt" />
    </java>
    <condition property="test01passed" value="true">
       <filesmatch file1="testdata/test01.expected.txt" 
                   file2="temp.d/test01.output.txt" />
    </condition>
   <echo if:set="test01passed">test01 passed</echo>
   <echo unless:set="test01passed">test01 failed</echo>
</target>
```
