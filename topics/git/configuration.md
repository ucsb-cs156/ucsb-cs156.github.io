---
parent: Git
grand_parent: Topics
layout: default
title: "git: configuration"
description:  "Initial configuration of git"
---


This page has three sections:

* *How* to configure your computer for git
* *Why* you need to configure your computer for git
* *What about GUI* options for git?

How
---

This section describes how to configure your computer for git.


To set up your computer for using command line git, type the following commands, substituting your real name (e.g. Chris Gaucho) in place of "Your Name" and your email address (e.g. cgaucho@umail.ucsb.edu) in place of "you@example.com".

* **DO NOT** just copy and paste all three commands at once.
* **DO** copy them one at a time, and edit the `"Your Name"` part and/or `youremail` parts as needed.
```
git config --global user.name "Your Name"
git config --global user.email youremail@ucsb.edu
git config --global push.default simple
```

You should only have to ever do these steps once for any given computer system. The values of these global configuration options are stored in a file called .gitconfig in your home directory. Take a look by cd'ing into your home directory, and using the more command to list the contents of .gitconfig:

```
$ cd
$ more .gitconfig
[push]
    default = simple
[user]
    name = Chris Gaucho
    email = cgaucho@umail.ucsb.edu
$
```

The `~/.gitconfig` file is a plain text file, and the options in it can also be set by just editing this file. Using the git config command is an alternative to hand editing this file, and is really just a way to be sure that the syntax ends up being right.

## Why

* Without the name/email configuration, many of your commits may have incorrect metadata attached to them.  
* Without the default push configuration, you may get odd messages popping up when you try to push to github

What about a GUI for git
------------------------

Even if you normally use a GUI interface for git, or a git plug in for an IDE such as VSCode, it is important to learn the git commad line interface.

The official trainers from github.com themselves, emphasize strongly:

* git is fundamentally a command line tool
* We recommend that you learn the git command line so that if/when the GUI does something weird, you can get under the hood and fix things.
* Again to emphasize: "To learn git, you need to learn the command line interface."  
