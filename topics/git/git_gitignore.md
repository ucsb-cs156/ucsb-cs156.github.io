---
parent: Git
grand_parent: Topics
layout: default
title: "git: .gitignore files"
description:  "What they are for and what to put in them"
indent: true
---

The `.gitignore` file is a hidden file in a Git repository that tells Git which files should NOT be committed to the repository.

Examples of files that should NOT be committed:

* Artifacts of compiling that can be obtained from source code, such as:
   * `.class` files in Java
   * `.jar` files produced from the source in the repo (as opposed to .jar files that are stored in the repo permanently
       because they are dependencies of the project)
   * dependencies that are automatically downloaded, e.g. by Maven
* Backup files or temporary files produced by editors, such as:
    * `*~` files such as `Foo.java~` produced by Emacs
    * `*.swp` files produced by vi/vim
* Artifacts of working on various Operating Systems
    * `.DS_Store` files on MacOS
    
   
Each language has its own set of file patterns, e.g.

* For C/C++, `*.o` 
* For Python, `*.pyc`

Some tools, too, have their own set of files that should be in the .gitignore.    Github has .gitignore files predefined for
frameworks such as Rails and Jekyll (which are both written in the programming language Ruby), the Unity game engine (folks typically
write C++ code for this), as well as the Maven version control system.

You can find examples of the files that should be in the .gitignore for various systems by doing a web search on ".gitignore name-of-system-or-tool".

The repo [https://github.com/github/gitignore](https://github.com/github/gitignore) also has a nice collection 
of these.

A few useful ones for this course:

* [Android](https://github.com/github/gitignore/blob/master/Android.gitignore)
* [Java](https://github.com/github/gitignore/blob/master/Java.gitignore)
* [Maven](https://github.com/github/gitignore/blob/master/Maven.gitignore)

# A candidate `.gitignore` for CS56 Maven Projects

```
# Emacs/vim

*~
*.swp

# VSCode

.vscode
.classpath
.project
.settings/


# MacOS

.DS_Store

# CS56 specific: Secrets files

localhost.json
heroku.json

# Maven (from: https://github.com/github/gitignore/blob/master/Maven.gitignore)

target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties
.mvn/timing.properties
# https://github.com/takari/maven-wrapper#usage-without-binary-jar
.mvn/wrapper/maven-wrapper.jar

# Java (from: https://github.com/github/gitignore/blob/master/Java.gitignore)

# Compiled class file
*.class

# Log file
*.log

# BlueJ files
*.ctxt

# Mobile Tools for Java (J2ME)
.mtj.tmp/

# Package Files #
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar

# virtual machine crash logs, see http://www.java.com/en/download/help/error_hotspot.xml
hs_err_pid*

```
