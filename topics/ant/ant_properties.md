---
parent: Ant
grand_parent: Topics
layout: default
title: "Ant: Properties"
description:  "The variable like things in Ant files (but they aren't really variables)"
indent: true
---

* Apache Ant Manual page for Properties: <https://ant.apache.org/manual/properties.html>

In an Ant `build.xml` file, you'll often see lines such as these:

```xml
   <property name="jar.file" value="build/jar/CS56Parser.jar"/>
```

The idea here is that `jar.file` becomes the name of a property that stands for the filename `build/jar/CS56Parser.jar`

The general idea is that if you later want to change the name of jar file created by this build.xml file, you 
only have to change it in one place.  You can then write code such as this in your `jar` task (the one that creates the
jar file)

```xml
  <jar destfile="${jar.file}" basedir="build/classes">
  ...
```

and this when you want to use the `java` task to run the jar file:

```xml
 <java jar="${jar.file}" fork="true"/>
```

These bits of your code never have to change from one build.xml file to another, and if/when you change the name of your jar file, you 
only have to change it in once place.   

You can think of the `${}` syntax as a dereference operation.

# A common idiom: `<property name="src" location="src"/>`, etc.

A common idiom, which looks a bit odd at first, is this one:

```xml
  <property name="src" location="src"/>
  <property name="build" location="build"/>
  <property name="dist" location="dist"/>
```

This may seem redundant.   In fact, if you are strongly committed to the convention that the source directory is caled `src`, the build directory is called `build` and the 
distribution directory is called `dist`, then this these property settings are unnecessary.

Their purpose is to decouple the roles of source, build, and distribution from these specific names, so that if you later, you decide to
change those names in practice, you only have to change them in one place in your code.

That is, later in your code, instead of putting:

```xml
<target name="compile" description="compile the source">
    <javac srcdir="src" destdir="build"/>
</target>
```

Instead, you write:

```xml
<target name="compile" description="compile the source">
    <javac srcdir="${src}" destdir="${build}"/>
</target>
```

The `${src}` syntax means to substitute the value of the property `src` in place of the `${src}` expression.  

If you decide to go with the name `source` instead of `src`, or you have a  nested directory structure such as `src/main/java`,
you can define the property accordingly:

* ` <property name="src" location="source"/>`
* ` <property name="src" location="src/main/java"/>`

Note that in this case, the second attribute of the XML element is `location` rather than `value`.   This indicates that the property
refers to a file or directory.  

# Properties are immutable

Something that can be confusing is that if you set a property in a build.xml file, and than later set it to something else, the second
property setting is *simply ignored*.

Consider this example:

```xml
<project>

 <property name="foo" value="fiddle" />
 <property name="foo" value="bar" />

 <target name="baz">
  <echo> foo has the value ${foo}</echo>
 </target>

</project>
```

We run this, and get the following output.  Note that the first value of `foo` is the one that gets printed, and there is no error messages
indicating that the second property setting was ignored.

```
Phills-MacBook-Pro:~ pconrad$ ant baz
Buildfile: /Users/pconrad/build.xml

baz:
     [echo]  foo has the value fiddle

BUILD SUCCESSFUL
Total time: 0 seconds
Phills-MacBook-Pro:~ pconrad$ 
```

If we reverse the order of the property assignments, we see again that the first property value set is the one that sticks:

```xml
<project>

 <property name="foo" value="bar" />
 <property name="foo" value="fiddle" />

 <target name="baz">
   <echo> foo has the value ${foo}</echo>
 </target>

</project>
```

Result:

```
Phills-MacBook-Pro:~ pconrad$ ant baz
Buildfile: /Users/pconrad/build.xml

baz:
     [echo]  foo has the value bar

BUILD SUCCESSFUL
Total time: 0 seconds
Phills-MacBook-Pro:~ pconrad$ 
```
