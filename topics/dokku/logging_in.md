---
parent: Dokku
grand_parent: Topics
layout: default
title: "Logging In"
description:  "How to login to the dokku server unix command line"
nav_order: 1
---

# {{page.title}} - {{page.description}}

This page explains how to login to the Dokku command line.

If you already know your dokku host, and have configured your account to access dokku, it should be as simple as this:

1. Login to CSIL
2. From there, type <tt>ssh dokku-<b><i>nn</i></b>.cs.ucsb.edu</tt> where you replace <tt><b><i>nn</i></b></tt> with the correct number.

If that doesn't work for you, then consult the instructions below; you may have missed one of the set up steps.

# Which Host?

You'll need to know which Dokku server you were given access to.  There will typically be a mapping from your team name to your Dokku instance such
as the one below.  Staff have access to the `dokku-00.cs.ucsb.edu` instance, and all other servers.  Students typically have access to only one server, namely 
the one for their team.

From F24 forward, we typically map the dokku servers by team number, e.g.

* team `01` is assigned to `dokku-01.cs.ucsb.edu`
* team `02` is assigned to `dokku-01.cs.ucsb.edu`
* ...
* team `16` is assigned to `dokku-16.cs.ucsb.edu`

## SSH setup 

There are three steps you need to do to get your account set up for access to Dokku:

1. Make sure your CSIL account has the following files in place:

   * `~/.ssh/id_rsa.pub` (public key; may be freely shared with anyone)
   * `~/.ssh/id_rsa` (private key; *never* share with anyone)

   If these files don't exist in your account, you can run `ssh-keygen` at the CSIL shell prompt;
   just hit enter to accept all defaults.  After running the `ssh-keygen` command, if you use the defaults, those files should then exist.

2. Type these two commands after you create your ssh public key:

   ```text
   touch ~/.ssh/authorized_keys
   cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
   ```

   These commands allow you to login to any CSIL machine from any other without having to supply a password
   (more precisely, from any CSIL machine to another that mounts your same home directory)  This is what will permit you to
   login to your dokku machine.

3. Try logging in with:

   <tt>ssh dokku-<b><i>nn</i></b>.cs.ucsb.edu</tt> where you replace <tt><b><i>nn</i></b></tt> with the correct number.

   If it still doesn't work, ask for help





