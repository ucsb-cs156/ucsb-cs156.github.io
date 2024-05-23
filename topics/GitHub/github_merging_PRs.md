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

Here's a specific example to illustrate the problem that can occur:

Here's a specific example so you can see what this looks like in the wild:

* [This PR](https://github.com/ucsb-cs156-s24/proj-gauchoride-s24-5pm-5/pull/35) was merged by an course staff member who did everything right.  The code was good, reviewed, passing on CI/CD.  He definitely did the right thing to merge it and assign points, and I'm grateful for his help.
* But this also inadvertently merged [This PR](https://github.com/ucsb-cs156-s24/proj-gauchoride-s24-5pm-5/pull/31), one that on the face of it, had some problematic code and test failures.
* So, it *looked like* the staff member had merged a PR with test failures and bad code.  They did nothing of the kind, but it sure looked like they had!

To be clear, there was never any harm to the code base.   From the standpoint of whether this would "be a problem in the real world", the answer is "not really".

But from the standpoint of managing the class *as an academic class*, it *appeared* that:
* a PR had been merged (which normally earns a team points), but points had not been assigned (which would lead students to question their grade)
* that PR was one that had significant problems that should have *prevented* it from passing the quality assurance controls that the staff are supposed to be enforcing both from the standpoint of good practice, but also *from the standpoint of teaching good practice*, which in an academic context, is crucial.

Bottom line:
* It's helpful to try to prevent this by teaching good practices for managing branches and PRs (for example, [here](https://ucsb-cs156.github.io/topics/git/git_feature_branch_workflow.html))
* But staff also need to be on the lookout for this scenario to avoid confusion.
