---
parent: Topics
layout: default
title: "OAuth: "
description:  "The way we implement the 'login with Google, Facebook, or Github' thing you see on some websites"
category_prefix: "OAuth: "
---

When implementing a login feature (i.e. usernames/passwords, and a "logged in" vs "not logged in" status), we have two choices:
* Roll our own authentication, storing the usernames/passwords ourselves.
* Delegate that to some other identify provider.

The second choice is almost always preferable.  Maintaining a database
of usernames/passwords is an invitation to be hacked.  And, even if
your webapp is nothing special, people have a bad habit of reusing
passwords across many different websites.

A common way of delegating authentication is via a protocol called OAuth.   
This is the protocol that allows the "login with Facebook", "login with Google", etc. functionality
you see on many websites.

