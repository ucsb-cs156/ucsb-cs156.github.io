---
parent: GitHub
grand_parent: Topics
layout: default
title: "github: verified badge on commits"
description:  "adding extra security to your commit messages"
indent: true
---

When you set your git configuration to use an email address with a command like this, github puts that email address on your
commmits:
```
 git config --global user.email "cgaucho@ucsb.edu"
```

But what is to stop you from typing this:

```
git config --global user.email "billgates@microsoft.com"
```

Well, nothing really.  If that really is an email address associated with a GitHub account, you could totally put in commit messages 
that look as if they were made by Bill Gates.  And Bill Gates could impersonate "Chris Gaucho" in return.

While there is nothing in place to stop this impersonation, it is possible to configure 
Commit Signature Verification so that when you make commits, they are identified
with a special badge indicating that the commit is verified as having come from you.

To learn more, consult these links:

* <https://help.github.com/en/articles/generating-a-new-gpg-key>
* <https://help.github.com/en/articles/adding-a-new-gpg-key-to-your-github-account>
* <https://help.github.com/en/articles/telling-git-about-your-signing-key>
* <https://www.linode.com/docs/security/authentication/gpg-key-for-ssh-authentication/>

Shout out to our friends at AppFolio: this is one of the tips Phill Conrad picked up while interning there.

