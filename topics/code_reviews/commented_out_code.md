---
parent: "Code Reviews"
grand_parent: Topics
layout: default
title: "Code Reviews: Commented Out Code"
description:  "Why commented out code should typically be removed"
---

## {{page.title}

When working on an issue, you may, from time to time, comment out some code, like this:

```
import React, {useState} from "react";
import { Container, CardGroup, Button } from "react-bootstrap";
import { useParams } from "react-router-dom";
// import { toast } from "react-toastify";

import BasicLayout from "main/layouts/BasicLayout/BasicLayout";
```

But by the time you are doing a pull request, **commented out code should be removed**.

## Why should commented out code be removed?

Perhaps the best way to answer this question is with a series of questions.
* If you don't remove it now, when do you expect that to happen?
* Do you think that folks in the future will have *more* knowledge of the situation than you do now?
* What purpose is the commented out code serving?
* Why are you hesitating to delete it?

The experience of most developers is that commented out code just stays around for years, or even decades, cluttering up the code because *no one feels empowered to remove it*.
They all assume that it's there for some good reason (otherwise, why would the past developers have left it there?).  But no one knows what that reason is.

The fact is: commented out code almost never serves any good purpose, and detracts from readability. It's just clutter.

## Get :clap: rid :clap: of :clap: it! :clap:

I can't say it any more plainly that this.

You can leave commented out code in while you are working.  But once you are at the stage of making a PR, look over your own PR, and if you see commented out code, then:
* Get :clap: rid :clap: of :clap: it! :clap:

And if you see it as a reviewer, you should flag it as an issue, with something diplomatic such as:
> I wonder if we can remove this commented out code?

This brings me to the final point:

## It should not "Look Good To You" if there is commented out code.

When doing a code review, you should *certainly* be doing more than just looking for commented out code.

But, if there's commented out code and you *miss* it,  but the staff review catches it, that's not good.

So far, I haven't made this an issue that affects student's grades because I haven't found a good mechanism to do this, but I feel as if I should, because it's important; if you want to make a good 
impression as a developer, it's important to not leave commented out code in your PRs, *and to not miss it when you are a reviewer*.

Please make sure that you scan the code for this and if you find it, diplomatically point it out and mark the review as needing changes:

You can be diplomatic.  Here's a suggested approach:

<img width="579" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/1cc8c442-dfae-47a1-a358-287ffb98c959">

<img width="634" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/8bf7a70b-700e-4a8f-99c6-d18bb43eb4b0">

