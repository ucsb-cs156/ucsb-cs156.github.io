---
parent: GitHub
grand_parent: Topics
layout: default
title: "github: adding collaborators"
description:  "giving individual users access to a private repo"
indent: true
---


The following instructions can be used to provide write access to a shared repo.  These instructions are
written using  a private repo as an example, but they work equally well on public repos.

Here's how, described as both a list of steps, and a list of images.  In this example:

* The first pair partner is Chris Gaucho, github id `cgaucho`
* The second pair partner is Lauren del Playa, github id `ldelplaya`
* Chris has create a repo called lab02-cgaucho-ldelplaya under the github organization {{site.curr_qtr_github_org}} and wants to give Lauren access to this repo as well.

These are the steps Chris should take to invite Lauren as a collaborator:

1. Navigate to the repo page, and click on <b>Settings</b> for the repo

1. Select <b>Collaborators &amp; Teams</b> from the menu at the left side of the page.

1. On the lower half of the page, in the "Add Collaborator" section, start typing in the github id
    of the pair partner that you want to add as a collaborator.

    Click the github id when it appears.  BE SURE IT IS ACCURATE.    Otherwise, you'll be sharing your repo with
    some perfect stranger.  That would be very bad.  So don't do that please.

    Note: in some browsers, you have to *actually click* on the name that pops up&mdash;it is not
    sufficient to simply type in the full name.  Your experience may vary.

    ![add-ldelplaya99-as-collaborator-50.png](add-ldelplaya99-as-collaborator-50.png){: title="add ldelplaya99 as collaborator"}

1.  When inviting a user to be a collaborator, the default permission
    level is <b>Write</b>.  If you are working with a pair partner,
    you should probably change that to <b>Admin</b>.  

    The following
    image indicates how to do that.  If you accidentally omit this
    step, then the user you are inviting will not have access to the
    <b>Settings<b> menu for the repo.  (If that happens, there is
    information later on this page about how to fix that.)


    ![adjust-permissions-50.png](adjust-permissions-50.png){: title="adjust permissions"}


# Accepting the invitation to Collaborate

Suppose Chris has created the repo using the `cgaucho` account, and has invited `ldelplaya` as a collaborator.

This is not sufficient for Lauren to immediately have access.   Lauren must first *accept* the invitation.

Since the repo in question is a private repo, it will not automatically appear as a repo
that Lauren has access to under Lauren' github account.

Instead, when Chris invited Lauren as a collaborator, an email similar to the following 
was generated and send to whatever email Lauren verified for Lauren' github account.
The email contains a link that Lauren can click to review the invitation. 

Note that if Chris provided <b>Admin</b> access, Lauren will have full privileges over
the repo.  If Chris only provided <b>Write</b> access (as in the example shown below), Lauren's
repo page will not have the <b>Setting</b> page.    To fix that, see the section "Changing access levels for collaborators", later on this page.

# What if Lauren doesn't get an invitation email?

It isn't strictly necessary for Lauren to find the invitation email.
Instead, Chris can simply provide Lauren with invitation url.

There is a place to copy the invitation url on the repo's settings page, 
under <b>Collaborators and Teams</b>.

# Changing Access Levels for Collaborators

Invitations can be issued for different levels of access.  

* <b>Read</b> access means "Read Only".  It signifies that the contents of a private repo can be read, but not changed.
   In CS56, we use this for the FEEDBACK repos: Mentors and Instructors have write
   access to these repos, and we invite each student or pair with 

* <b>Write</b> access means that the user can write to the repo, but cannot change the 
   things on the settings page.  This means, among other things, that the user cannot:
    * Change the name of the repo
    * Complete delete the repo
    * Add other collaborators to the repo

* <b>Admin</b> access is the highest level of access with which a user can be invited.
    It gives the same kind of access as the original person that sent the invitation.
    You have to have Admin access in order to invite another user to be a collaborator.

If you've been invited to a repo, you can check your level of access:

* If you have a settings menu on the repo's page, you have admin access
* If you don't have a settings menu, you either have read, or write access.  You could try
    editing the README.md to see if you can add a single space.  

    If you can, then
    you have write access.  

    If instead, when you try to do that, it tries to create a 
    "fork" of the repo, then you have read only access.    



