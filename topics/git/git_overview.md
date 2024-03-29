---
parent: Git
grand_parent: Topics
layout: default
title: "git: overview"
description:  "An introduction. git vs. github.com vs. github.ucsb.edu, repos, etc."
indent: true
---

# A few basics facts about git, github.com

In addition to learning Java, one of the major goals of this course is to get really comfortable 
with "version control", using a tool called "git" and a website called "github.com". 



# What is git and what is a repo?

The software package "git" is an example of a "version control system". (Others include SVN, Mercurial, and in a previous generations, CVS, RCS, and SCCS).

A git repo (short for repository) is nothing more than a collection of files and directories (folders), along with a special subdirectory called `.git` (stored only once in the top level directory of the repo) that keeps track of the complete history of the files and directories contained in the repo. To some extent, the `.git` directory stays out of your way, and you use the files and directories in the repository exactly the same way you'd use files and directories in a regular directory.

You might not see the `.git` subdirectory if your system doesn't show you hidden files:
* On Linux (or at a bash shell on Mac or Windows) use `ls -a` to see hidden files
* There are also ways to adjust the Windows Explorer or Mac Finder to show hidden files

Keeping files in a git repository has many advantages over a plain old directory/folder:

-   making it easier to collaborate with others on a project (whether that's an open source or closed source project)
-   making it easier to recover from screwups (like deleting important files, messing up code that was previously working, complete failure of your hard drive)
-   making it easier to share "works in progress" with TAs and instructors and fellow students to get help during lab, office hours, or by email
-   making it easier to share "open source" projects with others on the internet.

# What is `github.com`, and what is it's relationship to `git`

A git repository can be local, on your file system, or it can be
remote on a server somewhere on the Internet. 

We might say, using
terminology that is trendy these days, that a repo on the internet is
"in the cloud" if we get to remain blissfully ignorant of exactly how
that service is being provided to us&mdash;i,.e. someone else is worrying
about all the system management issues like keeping that server up and
running, keeping it free of malware and defending from Denial of
Service attacks, managing backups, etc.

GitHub is a for-profit company (acquired by Microsoft in 2018)   that runs a web application and
web service
called `github.com`. The `github.com` site provides hosting for git
repositories "in the cloud". 

They host open source
projects for free (via free public repositories) and makes money by
charging users for hosting closed source projects in private
repositories.   

# GitHub Student Developer Pack

The GitHub Student Developer Pack is a package of free stuff that you can get if you are a university student.

Create a GitHub account on the free plan, then visit <https://education.github.com/students> to sign up.

You may need those additional benefits for some of the assignments in this course.

