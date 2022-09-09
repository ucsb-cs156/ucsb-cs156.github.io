---
parent: "VS Code"
grand_parent: Topics
layout: default
title: "vscode: CR/LF"
description:  "CR/LF issues with VS Code, especially on Windows and WSL"
---

There are different conventions on different systems for line endings.

| Symbol | Name | Escape Sequence | ASCII/Unicode Value | Control Char |
|--------|------|-----------------|---------------------|--------------|
| CR     | Carriage Return | `\r` | 13 | `^M` | 
| LF     | Line Feed | `\n` | 10 | `^J` | 
{:.table .table-sm .table-striped .table-bordered}

* Mac and Linux systems usually just put a LF character at the end of every line.
* Windows systems usually put a CR followed by an LF at the end of every line.
* With WSL, it's anyone's guess.

# Why do we care?

This can create havoc.  One thing we do in this course that is particularly vulnerable to this 
problem is the way we set environment variables for Heroku by doing:

```
heroku config:set `cat .env` --app app-name
```

If the `.env` file has `LF` line endings, this works fine.  But if it has `CR/LF` line endings,
it will not work; you'll get an extra newline character at the end of every variable value, and this
causes OAuth to simply not work.

# How to fix it

Fortunately, in VSCode, there's a handy way to tell which line endings a file is using.

Look at the bottom right hand corner, and you'll see something like this:


<img alt="Lower Right of VSCode Screen" src="https://user-images.githubusercontent.com/1119017/150617886-00e2100b-d06a-4a69-a513-5d554389fa8d.png" width="500" />

Notice the `LF`?  That tells us that this file has `LF` as the end of line character. This is normal one
for Linux and Mac.

If you click on that LF, you can switch the line endings.  A pop-up appears at the center top of the screen that looks like this:


<img alt="CRLF vs LF selector box in VS code" src="https://user-images.githubusercontent.com/1119017/150618113-270e8ac4-2977-4bcd-b940-ffe1ad339eec.png" width="500" />


# Why is it is like this?

This is a throwback to the very early days of computing.

Back in the day, when computers were hooked up to teletypwriters, the carriage return literally
moved the print head back to the start of a line.

The line feed moved the paper up by one line.
