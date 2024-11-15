---
parent: Jenv
grand_parent: Topics
layout: default
title: "jenv: MacOS"
description:  "Managing multiple Java versions on MacOS"
---

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

## Step 2: Run `jenv doctor`

The command `jenv doctor` will check to see if your installation is correct.  It may tell you that you need to do this command:

```
echo 'eval "$(jenv init -)"' >> /Users/pconrad/.zshrc
```

If so, do it, and *then close and reopen your terminal window*.  That step is very important.

At this stage, don't worry about these messages, which may also appear:

```
[OK]	No JAVA_HOME set
[ERROR]	Java binary in path is not in the jenv shims.
[ERROR]	Please check your path, or try using /path/to/java/home is not a valid path to java installation.
```

## Step 3: Install java versions

The next step is to install the java versions that you need, which is also done with `brew`.

* To install Java 17: `brew install openjdk@17`
* To install Java 21: `brew install openjdk@21`

## Step 4: Find your java versions

The exact directory where the java versions are stored may depend on your specific system configuration (OS version, machine architecture, etc.).  But somewhere on your system, there will be a directory where the various java versions live.

One way to find this is to type `which java`.  On my system, that results in this:

```
pconrad@Phillips-MacBook-Air-2 proj-courses % which java
/opt/homebrew/opt/openjdk@21/bin/java
```

NOTE: If `which java` gives you a path like `/usr/bin/java` without `openjdk@21` or `openjdk@17`, run the following two commands to modify your `.zshrc` files:
```
echo 'export PATH="/usr/local/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="/usr/local/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```
Then, try running `which java` again to get the proper path.

This path gives me a clue that the java versions live in `/opt/homebrew/opt/` and sure enough if I list that directory with `openjdk*` I see this:

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


## Step 5: Add Java Versions into jenv

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

Unfortunately, you may have hardcoded Java 21 in your startup files earlier in the course. So we'll need to undo that before `jenv` can do it's job.

## Step 6: Fix the path in your startup files

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

To find this, you might find it helpful to type this: `grep openjdk .*` or `grep 21 .*`

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

## Step 7: Uninstall and reinstall maven

We first need to set maven back to its clean original settings.  Easiest way is with:

```
brew uninstall maven
brew install maven
```
## Step 8: Install two plugins for `jenv`

Now do this to install two jenv plugins:

```
jenv enable-plugin export
jenv enable-plugin maven
```

Finally, do `jenv doctor` and then close your terminal and reopen it.

If all goes well, you will now be able to switch between Java projects and when you do `mvn --version`, you'll see the correct Java version.

To test this, try this:

1. `cd` into the directory for the repo where you worked on a Java 21 project (e.g. your `team02` directory).
2. Type `mvn --version`.  You should see Java 21
3. `cd` into the directory where you cloned a Java 17 project (e.g. `proj-happycows`)
4. Type `mvn --version`.  You should see Java 17

If it still doesn't work, ask for help from the staff.


## Resources

* <https://medium.com/javarevisited/manage-java-versions-with-jenv-6b8228552661>
* <https://stackoverflow.com/questions/28615671/set-java-home-to-reflect-jenv-java-version>








