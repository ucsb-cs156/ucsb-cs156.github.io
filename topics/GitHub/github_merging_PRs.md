---
parent: GitHub
grand_parent: Topics
layout: default
title: "github: merging PRs"
description:  "Some things that can be surprising"
---

# {{page.title}} - {{page.description}}

## One surprising scenario

In the context of CMPSC 156, this section is mainly for courses staff dealing with merging PRs during the legacy code phase, but it
describes a scenario that can happen in *any project that uses Github Pull Requests*.

Suppose that you have: commits  `c1->c2`

Further, suppose branch `b1` points to `c2`.

Further suppose the students opens a `PR1`  on branch `b1`.. and is running into problems (say CI failures)_

They then make a new branch off of `b1` called `b2`, and add to more commits, `c3`, and `c4`.

Now we have:
```
c1 -> c2  -> c3  -> c4
       ^            ^
       |            |
       b1(PR1)      b2
```

Now suppose the student makes a new pull request, `PR2` from branch `b2`, which is green on CI, looks great. It's code reviewed by both team and staff, merged by staff member X, and awarded points.

All is well, right?

Here's the sneaky part... `PR1` will *also show up as having been merged* by staff member X.

And it will show up as a PR that was merged but had unreviewed code, CI failures, etc.   In short, it will appears that staff member X did something ... "not great"... by merging code that shouldn't have been merged.   But in fact, they really didn't intend that, and in some ways, they really didn't.  It's just a "quirk" of how github treats this situation.

It might be better if github had a special case for this, and didn't show it as "merged", but rather, "merged by later PR" or something like that.

But since this does happen, here's the takeaway for CMPSC 156 staff:

* When you merge a PR, always *look to see if something else got inadvertently merged* by the mechanism described above.
* One way to tell: when you merge a PR, either (a) assign points immediately, or (b) add a tag that says: "Points Pending". 
* Then, you can look to see if there are any other PRs that got merged that don't have points or a "Points Pending" tag.
* If there are, add a tag for "0" points, and then add an explanation in the comments.
