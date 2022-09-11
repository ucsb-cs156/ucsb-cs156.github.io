---
parent: Selenium
grand_parent: Topics
layout: default
title: "Selenium: Driver Setup"
description:  "Setting up your driver"
category_prefix: "Selenium: "
indent: true
---

# How do I get a selenium driver?

## Chrome

<http://chromedriver.chromium.org/getting-started>

If you follow the link for Downloads, and Linux you'll find a file called `chromedriver_linux64.zip` which you can download, unzip and then use directly on CSIL.  Be sure you are downloading it from a reputable source.   See the instructions below for what to do with that binary under <b>What to do with the binary to get it to work</b>

Since you will not have permission to install it in the "standard location" (since you are not root), you'll need to follow the instructions given for a [installing the driver in a non-standard location](http://chromedriver.chromium.org/capabilities#TOC-Using-a-Chrome-executable-in-a-non-standard-location)


## Firefox

<https://github.com/mozilla/geckodriver/releases>

You can download the executable for Linux and use it directly on CSIL.  Be sure you are downloading it from a reputable source.

# What to do with the binary to get it to work

You'll also probably need to add the driver to your executable path, i.e

* Create a directory ~/bin
* Put the executable into ~/bin
* Then do:

```
export PATH=${PATH}:/cs/student/youruserid/bin
```

You'll have to do that `export` command every time you open a new CSIL shell.

The bin here is the DIRECTORY in which the executable is located, not the executable itself. It should be a directory named `bin` that has in it only programs that you want to be part of your path.

Or, download a version for your Mac, Windows or Linux laptop.

