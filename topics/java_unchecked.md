---
parent: Topics
layout: default
title: "Java: Unchecked Operations"
description:  "That message that says blah.java uses unchecked or unsafe operations. Recompile with -Xlint:unchecked for details."
indent: true
---

What do you do when you get this message after doing `ant compile`?

```
compile:
    [javac] Compiling 8 source files to /Users/pconrad/github/hfj-chap15/build
    [javac] Note: /Users/pconrad/github/hfj-chap15/src/VerySimpleChatServer.java uses unchecked or unsafe operations.
    [javac] Note: Recompile with -Xlint:unchecked for details.
```

# How do you `Recompile with -Xlint:unchecked` 

The error message says to `Recompile with -Xlint:unchecked` but how?

* If you are using plain old `javac`, you do it like this:
   ```
   javac -Xlint:unchecked foo.java
   ```
   
* If you are using Ant, you add a `<compilerarg value="-Xlint:unchecked"/>` element to your `javac`
   task, like this:

   ```xml
    <javac srcdir="${src.dir}"
            destdir="${classes.dir}"
            classpathref="libraries">
       <compilerarg value="-Xlint:unchecked"/>
     </javac> 
   ```

# Then what happens?

Here's the output of runing via the first method (simple `javac`).   

* The file in question is available here: [VerySimpleChatServer.java](VerySimpleChatServer/)
* That code comes from Chapter 15 of [Head First Java](/textbooks/HFJ/)

```
169-231-163-224:src pconrad$ javac -Xlint:unchecked VerySimpleChatServer.java 
VerySimpleChatServer.java:46: warning: [unchecked] unchecked call to add(E) as a member of the raw type ArrayList
                clientOutputStreams.add(writer);
                                       ^
  where E is a type-variable:
    E extends Object declared in class ArrayList
1 warning
169-231-163-224:src pconrad$ 
```

Here's the same example run via an Ant build.xml:

```
169-231-163-224:hfj-chap15 pconrad$ ant compile
Buildfile: /Users/pconrad/github/hfj-chap15/build.xml

prepare:

compile:
    [javac] Compiling 8 source files to /Users/pconrad/github/hfj-chap15/build
    [javac] /Users/pconrad/github/hfj-chap15/src/VerySimpleChatServer.java:46: warning: [unchecked] unchecked call to add(E) as a member of the raw type ArrayList
    [javac]                 clientOutputStreams.add(writer);
    [javac]                                        ^
    [javac]   where E is a type-variable:
    [javac]     E extends Object declared in class ArrayList
    [javac] 1 warning

BUILD SUCCESSFUL
Total time: 0 seconds
169-231-163-224:hfj-chap15 pconrad$ 
```


# What's the underlying problem?

The underlying problem will vary dependig on your specific code. 

In this particular example, the problem is that `clientOutputStreams` is an `ArrayList` when it should be an `ArrayList<E>` of some specific type, i.e .the type that `writer` is an instance of.

In particular, `writer` is an instance of `PrintWriter`.  So we replace lines as follows:


```diff
- line 9:  ArrayList clientOutputStreams;
+ line 9:  ArrayList<PrintWriter> clientOutputStreams;

- line 40:   clientOutputStreams = new ArrayList();
+ line 40:   clientOutputStreams = new ArrayList<PrintWriter>();
```

With these changes, we get a clean compile.



# More information

* <https://stackoverflow.com/questions/23749786/uses-unchecked-or-unsafe-operations>
