---
parent: Dokku
grand_parent: Topics
layout: default
title: "Dokku: Deploy Problems"
description:  "When your dokku deployment fails and you are stumped"
---

# {{page.title}} - {{page.description}}

A frequently posted question on `#help-lecture-discussion` is one like this:

![image](https://github.com/user-attachments/assets/77f35a22-e7a2-48d3-b857-c8d11b080081)

```
My dokku deployment failed.  What went wrong?
```

The problem is: from just a screenshot of the last page of output from the `dokku ps:rebuild` command, we can tell you pretty much *nothing at all*, most of the time.

The root cause, if it appears at all in the output, is going to be hundreds or thousands of lines of output above this point.

What can help is if you tell us:

* What sequence of commands did you type?
* What repo are you deploying, and what branch?
* What is the dokku machine number?
* What is the dokku app name?


