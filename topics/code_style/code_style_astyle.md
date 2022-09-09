---
parent: Code Style
grand_parent: Topics
layout: default
title: "Code Style: astyle"
description:  "automatic code indenting tool available on CSIL"
indent: true
---

Artistic Style (command line: `astyle`) is a tool to format Java code (i.e. fix your indentation and new lines).

It also works on: C, C++, C++/CLI, Objective‑C, and C#.

# Quick start: `astyle *.java`

Type `astyle *.java` at the command line on CSIL to use a software package called "Artistic Style" to automatically fix the
indentation of your Java code to match a variety of style conventions.

As an example, if your directory contains:

```
cs56-rational-ex01 pconrad$ ls
LICENSE   Rational.java    Main.java    README.md
cs56-rational-ex01 pconrad$ 
```

After you run `astyle *.java`, you'll have:

```
cs56-rational-ex01 pconrad$ ls
LICENSE     Main.java.orig    Rational.java
Main.java   README.md         Rational.java.orig
cs56-rational-ex01 pconrad$ 
```
where the `.java.orig` file are the originals, and the `.java` files are the newly formatted files.

# Advanced usage

You can use command line arguments to control which style is used, and to apply `astyle` recursively to an entire directory tree:

For example:

<style>
  table * code { white-space: pre }  
  table * td { padding-left: 1em; padding-right: 1em; }
  table * td { border: 1px solid black; }
  table { border-collapse: collapse; }
</style>

| Command | Explanation |
|-|-|
| `astyle --style=google --recursive src` | Apply Google style to all files under the `src` directory (and all subdirectories of `src`) |





# Install on Mac

To install on Mac, first install [MacOS: Homebrew](/topics/macos_homebrew/), then type:

```
brew install astyle
```
