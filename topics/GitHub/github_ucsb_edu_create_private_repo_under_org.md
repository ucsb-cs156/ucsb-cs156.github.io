---
parent: GitHub
grand_parent: Topics
layout: default
title: "github.ucsb.edu: creating private repos under an organization"
description:  "for closed source class assignments"
indent: true
---

We use organizations such as <https://github.ucsb.edu/UCSB-CS56-F16> to set up a space
on github.ucsb.edu where every repo that you create can automatically be seen by your instructors and TAs without you having to add them manually as collaborators.

Eventually, we'll be able to do that on github.com as well&nbsp;at the moment, out "academic discount" is running
a bit late.

To create a private repo for a Java assignment on github.ucsb.edu, follow this procedure.

# Login to <github.ucsb.edu>

For this assignment, be sure it is github.ucsb.edu, and not github.com.

Then, select "create repository".

If you have been added to the organization for the course (e.g. UCSB-CS56-F16), you should see that you can
create the repository either:

* under your own name (DO NOT DO THIS), or
* under the UCSB-CS56-F16 organization (this is what you want!)

The reason this is important is that creating the repo under the UCSB-CS56-F16 organization ensures that
your instructors, mentors and TAs will be able to see it.

# Choosing a name

* Unless you are told otherwise, the naming convention is `labxx-githubusername`
* For example, `lab00-jgaucho`

Use EXACTLY that name, because that will be how your TAs find it to give you a grade.    

If you don't use the right letters, punctuation, capitalization, etc. it makes your TAs life more difficult. Your TA 
may therefore decide to make your life difficult by giving you a lower grade for "not following directions". 
They will have my full support.                         

# Filling in the rest

-   Under description, you may write anything you like, within reason.                           
    -   For example, something like "lab00 for Joe Schmoe" (if your name is Joe Schmoe) would be reasonable.                                                                                     
-   Select "private".                                                                            
-   Check the box that says "Initialize this repository with a README.                           
    -   This is important because if you don't do this, the repo may have no content, and you can't clone a repo with no content.
-   Click the pull-down menu for "Add .gitignore" and select Java.

Then create the repo.
