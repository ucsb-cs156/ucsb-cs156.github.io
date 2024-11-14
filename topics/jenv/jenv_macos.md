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
