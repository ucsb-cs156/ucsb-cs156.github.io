---
parent: Topics
layout: default
title: "git: git/github troubleshooting"
description:  "Various problems and their solution"
indent: true
---

# `X11 forwarding request failed on channel 0`

If you run into issues with `X11 Forwarding` while pushing/pulling from GitHub, you can try the following:

```
echo $'Host github.com\n    ForwardX11 no' >> ~/.ssh/config
```

This turns off X11 forwarding to `github.com` ssh connections.

(H/T to Scott Chow, F19 TA for this tip)


# Help! I committed changes to my local master when they should have been on a feature branch

Suppose you intended to create a feature branch called `cg-myFeature` and put three commits on it.

But you forgot!  You put those three commits on the `master` branch instead!  And you do NOT want to push those
directly to `master`&mdash;instead, you want to:

* put those commits on the `gc-myFeature` branch, and 
* get your local `master` branch back in sync with the `master` of the `origin`.  

Why? 

* Because you want to do a **pull request** for your new commits.  
* You do **not** want them to just go to `master` directy.

What can you do?

The important thing to rememebr is what a branch **is**.  

* A branch is nothing more, and nothing less, than a pointer to a commit.

How? 

First, do a  `git status` followed by a `git log` command at the shell prompt in your local repo.   


Suppose that looks like this:

```

$ git status
On branch master
Your branch and 'origin/master' have diverged,
and have 2 and 4 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)
nothing to commit, working tree clean
$ git log
commit 6902efff2938412834123487129384719232ea98
Author: Chris Gaucho <cgaucho@umail.ucsb.edu>
Date:   Tue Jan 28 11:33:29 2020 -0800
    cg - added file for team questions
commit 0d066b54aacd684f11642c1881a5755e25fae037
Author: Chris Gaucho <cgaucho@umail.ucsb.edu>
Date:   Tue Jan 28 11:29:31 2020 -0800
    cg - added file for qa questions
commit fd91befce9897845d996ccdb17cebeb948529368 (origin/cg-myFeature)
Author: ldelplaya <59632440+ldelplaya@users.noreply.github.com>
Date:   Tue Jan 28 11:11:54 2020 -0800
    Initial commit
$
```

Also go to the repo on GitHub (i.e. the website, and under commits, find out what the SHA (that long hexadecimal number) is for the latest up-to-date commit on master.  Suppose that number is: `c547d12`.  (Note that the full number is longer, but you can typically shorten SHAs on GitHub to the first seven digits and it works fine.)

What we want, is to end up with the commits shown above (i.e. the last commit being `6902eff`, which has the message `cg - added file for team questions`) to be on the branch `cg-myFeature`, and for our local master to be back pointing to c547d12`).

So, here's what we do.



| Command | Explanation |
|---------|---------------|
|`git fetch` | This updates the branch pointers for all our `origin/master`, `origin/branch`, `origin/branch2`, etc. for all the branches that exists on `origin`.  It doesn't pull anything; it just makes sure our local repo knows where all the pointers are.  We'll need that later.
|`git checkout cg-myFeature`   | This puts us on the feature branch |
|`git reset --hard 6902eff`  | This should move the feature branch point to be pointing at the last commit that we want to be on the feature branch.  At this point, both `master` and `cg-myFeature` point to that last commit |
|`git push -f origin cg-myFeature ` | This does a "force push" on the `cg-myFeature` branch.  This forces GitHub's pointer for that branch to be pointing to the commit we insist on.  This is something you should only do when you are pretty confident that your local branch is pointing to the correct spot, and that the branch on GitHub is not.  | 
| `git status` | It's a good idea to do a git status now, as well as checking things on GitHub to be sure they look sane |
| `git checkout master` | Now we are going to fix our local master branch |
| `git reset --hard origin/master` | This says: make the current branch (which happens to be our local `master`) point wherever `origin/master` points.  That's going to make our local branch be in sync with master.|
| git status | You should now see the message: <br> `On Branch Master` <br> `Your branch is up-to-date with 'origin/master'`<br><br>`nothing to commit, working tree clean` |
