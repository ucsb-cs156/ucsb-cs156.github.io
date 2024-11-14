---
parent: jenv
grand_parent: Topics
layout: default
title: "jenv: MacOS"
description:  "Managing multiple Java versions on MacOS"
--

# {{page.title}} - {{page.description}}

Here's how to work with `jenv` on MacOS to manage multiple Java versions.

Note that this assumes you already have Homebrew installed on your Mac.  If you don't, consult <https://ucsb-cs156.github.io/topics/macos/macos_homewbrew.html>

## Step 1: Install `jenv` using: `brew install jenv` 

On MacOS, the first step is to install `jenv` with `brew` like this:

```
brew install jenv
```

After this completes, you'll be able to type `jenv versions` to see the versions you have installed.  At first, it may show something like this:

```
pconrad@Phillips-MacBook-Air-2 ~ % jenv versions
* system (set by /Users/pconrad/.jenv/version)
pconrad@Phillips-MacBook-Air-2 ~ % 
```

## Step 2: Install java versions

The next step is to install the java versions that you need, which is also done with `brew`.

* To install Java 17: `brew install openjdk@17`
* To install Java 21: `brew install openjdk@21`

## Step 3: Find your java versions

The exact directory where the java versions are stored may depend on your specific system configuration (OS version, machine architecture, etc.).  But somewhere on your system, there will be a directory where the various java versions live.

One to find this is to type `which java`.  On my system, that results in this:

```
pconrad@Phillips-MacBook-Air-2 proj-courses % which java
/opt/homebrew/opt/openjdk@21/bin/java
```

That gives me a clue that the java versions live in `/opt/homebrew/opt/` and sure enough if I list that directory with `openjdk*` I see this:

```
pconrad@Phillips-MacBook-Air-2 proj-courses % ls -ld /opt/homebrew/opt/openjdk*
lrwxr-xr-x  1 pconrad  admin  20 Oct 23 09:29 /opt/homebrew/opt/openjdk -> ../Cellar/openjdk/23
lrwxr-xr-x  1 pconrad  admin  28 Nov  8 10:40 /opt/homebrew/opt/openjdk@11 -> ../Cellar/openjdk@11/11.0.25
lrwxr-xr-x  1 pconrad  admin  28 Nov 14 14:17 /opt/homebrew/opt/openjdk@17 -> ../Cellar/openjdk@17/17.0.13
lrwxr-xr-x  1 pconrad  admin  27 Oct 23 09:32 /opt/homebrew/opt/openjdk@21 -> ../Cellar/openjdk@21/21.0.5
lrwxr-xr-x  1 pconrad  admin  20 Oct 23 09:29 /opt/homebrew/opt/openjdk@23 -> ../Cellar/openjdk/23
pconrad@Phillips-MacBook-Air-2 proj-courses %
```

This shows me that I have Java 11, 17, 21, and 23 all available on my system.

The next step is to add each of these into jenv.

## Step 4: Add Java Versions into jenv

For each Java version that you need to work with, add it in to jenv like this:

```
jenv add /opt/homebrew/opt/openjdk@17
jenv add /opt/homebrew/opt/openjdk@21
```

Here's what the output of that looks like:

```
pconrad@Phillips-MacBook-Air-2 proj-courses % jenv add /opt/homebrew/opt/openjdk@17
openjdk64-17.0.13 added
17.0.13 added
17.0 added
17 added
pconrad@Phillips-MacBook-Air-2 proj-courses % jenv add /opt/homebrew/opt/openjdk@21
openjdk64-21.0.5 added
21.0.5 added
21.0 added
21 added
pconrad@Phillips-MacBook-Air-2 proj-courses %
```

## Step 5: List the versions you have available

Now use `jenv versions` to list the versions you have available

```
pconrad@Phillips-MacBook-Air-2 ~ % jenv versions
* system (set by /Users/pconrad/.jenv/version)
  17
  17.0
  17.0.13
  21
  21.0
  21.0.5
  openjdk64-17.0.13
  openjdk64-21.0.5
pconrad@Phillips-MacBook-Air-2 ~ %
```



## Step 6: cd into any of the ucsb-cs156 repos

Now, if all goes properly, anytime you cd into a directory that has a `.java-version` file in it (which all of the CS156 projects do), the java versions will be
set automatically.

For example, at the time I wrote this, `proj-courses` had a `.java-version` file containing `21` while `proj-happycows` had a `.java-version` file containing `17`.

What what happens when I switch between them (here I'm using `java version` to show the currently selected version):

```
pconrad@Phillips-MacBook-Air-2 ~ % cd ~/github/ucsb-cs156/proj-courses
pconrad@Phillips-MacBook-Air-2 proj-courses % jenv version
21 (set by /Users/pconrad/github/ucsb-cs156/proj-courses/.java-version)
pconrad@Phillips-MacBook-Air-2 proj-courses % java --version
openjdk 21.0.5 2024-10-15
OpenJDK Runtime Environment Homebrew (build 21.0.5)
OpenJDK 64-Bit Server VM Homebrew (build 21.0.5, mixed mode, sharing)
pconrad@Phillips-MacBook-Air-2 proj-courses % cd ~/github/ucsb-cs156/proj-happycows 
pconrad@Phillips-MacBook-Air-2 proj-happycows % jenv version
17 (set by /Users/pconrad/github/ucsb-cs156/proj-happycows/.java-version)
pconrad@Phillips-MacBook-Air-2 proj-happycows % java --version
openjdk 21.0.5 2024-10-15
OpenJDK Runtime Environment Homebrew (build 21.0.5)
OpenJDK 64-Bit Server VM Homebrew (build 21.0.5, mixed mode, sharing)
pconrad@Phillips-MacBook-Air-2 proj-happycows % 
```

But, as you can see, there's still a problem.  While `jenv` detects the change in version, the path to `javac` is still set to Java 21 in both cases.

To fix this, we may have to undo some steps we took earlier in the course to get Java 21 set up as our default version.


## Step 7: Fix the path in your startup files

`cd` into your home directory by just typing `cd` by itself.

Then list the files there with `ls -a`.  You should see some files that start with `.`; these are your "hidden files".

```
pconrad@Phillips-MacBook-Air-2 ~ % ls -a 
.			.gem			.mkshrc			.zlogin			Movies
..			.gitconfig		.npm			.zprofile		Music
.CFUserTextEncoding	.gnupg			.nvm			.zsh_history		Pictures
.DS_Store		.h2.server.properties	.profile		.zsh_sessions		Public
.Trash			.jenv			.rvm			.zshrc			ULA
.bash_profile		.lemminx		.ssh			Desktop			github
.bashrc			.lesshst		.viminfo		Documents
.bundle			.local			.vscode			Downloads
.config			.m2			.zcompdump		Library
pconrad@Phillips-MacBook-Air-2 ~ % 
```

The files that we are interested in here are the "startup files", typically ones with names such as these:

```
.bash_profile
.bashrc
.zshrc
.zlogin
.zprofile
```

Somewhere in one or more of these files, you may find some code that is adding a particular Java version into your path--code like this:

```
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
```

Youll need to find this and replace it with this:

```
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
```

Now, if you *open a new terminal window* after saving this file, it should be the case that when you switch between directories that have different `.java-version` files, the default `javac` switches, like this:

```
pconrad@Phillips-MacBook-Air-2 proj-happycows % cd ~/github/ucsb-cs156/proj-courses 
pconrad@Phillips-MacBook-Air-2 proj-courses % jenv version
21 (set by /Users/pconrad/github/ucsb-cs156/proj-courses/.java-version)
pconrad@Phillips-MacBook-Air-2 proj-courses % java --version
openjdk 21.0.5 2024-10-15
OpenJDK Runtime Environment Homebrew (build 21.0.5)
OpenJDK 64-Bit Server VM Homebrew (build 21.0.5, mixed mode, sharing)
pconrad@Phillips-MacBook-Air-2 proj-courses % cd ~/github/ucsb-cs156/proj-happycows 
pconrad@Phillips-MacBook-Air-2 proj-happycows % jenv version
17 (set by /Users/pconrad/github/ucsb-cs156/proj-happycows/.java-version)
pconrad@Phillips-MacBook-Air-2 proj-happycows % java --version
openjdk 17.0.13 2024-10-15
OpenJDK Runtime Environment Homebrew (build 17.0.13+0)
OpenJDK 64-Bit Server VM Homebrew (build 17.0.13+0, mixed mode, sharing)
pconrad@Phillips-MacBook-Air-2 proj-happycows %
```

Just one problem!  When using `mvn`, the Java versions isn't switching!  That because we now have to undo one more bit of setup that we previously did to 
get Java 21 integrated with Maven.

## Step 8: Locate your mvn script

First, you need to locate the script that runs the `mvn` command.  To do that, type `which mvn`.

Here's what that looks like:

```
pconrad@Phillips-MacBook-Air-2 ~ % which mvn
/opt/homebrew/bin/mvn
pconrad@Phillips-MacBook-Air-2 ~ %
```

As you can see, on my system, `/opt/homebrew/bin/mvn` is the location of mvn.  I can now use an editor (VSCode, vim, whatever) to open up this file:

```
code /opt/homebrew/bin/mvn
```

This is what I find inside:

```
#!/bin/bash
#JAVA_HOME="${JAVA_HOME:-/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home}" exec "/opt/homebrew/Cellar/maven/3.9.9/libexec/bin/mvn"  "$@"
JAVA_HOME="${JAVA_HOME:-$(/usr/libexec/java_home 21)}" exec "/opt/homebrew/Cellar/maven/3.9.9/libexec/bin/mvn" "$@"
```

As you can see, we edited this file to always link up mvn to Java 21.  Instead, we want to edit this so that `mvn` picks up the Java version that was
selected by `jenv`.  We'll do that in the next step.










