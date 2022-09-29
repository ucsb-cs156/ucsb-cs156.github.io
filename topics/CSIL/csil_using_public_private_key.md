---
parent: CSIL
grand_parent: Topics
layout: default
title: "CSIL: using public/private key"
description:  "Logging in via ssh without a password"
indent: true
---

This article explains how you can set things up to automatically login to your CSIL account without having to type a password.

This is a tradeoff off between convenience and security:
* The convenient thing is that if you are connecting from your own laptop, you don't need a password
* The security risk is that if your laptop is unattended, or if it's stolen and someone can break through the OS security and get to a shell, then your
  CSIL account is also potentially compromised.

So proceed at your own risk.

# Background

To connect to the CSIL machines from Linux, you just use the `ssh` command at command line.

```
ssh username@csil.cs.ucsb.edu
```

In general, this works for any `username@host` (e.g. `username@host`).

Normally, this will prompt you for a password.  If you follow the instructions below, the password prompt goes away.

# First, generate a public/private key pair

If you already have a public/private key pair, you'll see it when you use `ls ~/.ssh` as the files `id_rsa` and `id_rsa.pub`. For example:

```
pconrad@Phillips-MacBook-Pro ~ % ls ~/.ssh
id_rsa			id_rsa.pub		known_hosts
pconrad@Phillips-MacBook-Pro ~ % 
```

The `id_rsa` file is the private key, and the `id_rsa.pub` file is the public key.

If you don't already have one, use the command `ssh-keygen` to create one.   If you are new to this, you can just hit enter at each prompt, and take all of the defaults.
* If you want to learn more about the other options available to you, you can do a web search on `ssh public private key` and there are many articles that will explain the various 
options.

# Next, login to CSIL (or whatever the target machine is)

You'll need to login at least once the old fashioned way.  You need to go to the `~/.ssh` directory on the target machine.

* If there isn't one, create it with: `mkdir ~/.ssh`.  
* Note that you do *not necessarily* need to run `ssh-keygen` on the target machine.  It doesn't hurt anything, but we don't need that for this setup.


In the `~/.ssh` subdirectory, if there isn't already a file called `authorized_keys`, create one by doing this:

```
touch ~/.ssh/authorized_keys
```

The `touch` command creates a zero-length file if the file doesn't already exist; if it does exist, it reads one byte from the file and writes it back unchanged, so that the
"last modified" time of the file is updated.

Now that we have a file called `~/.ssh/authorized_keys`, we are simply going to take:
* the public key from the machine you are using to connect *from* (e.g. `~/.ssh/id_rsa.pub` on your *laptop*)
* append those contents to the `~/.ssh/authorized_keys` file on the machine you are connecting *to* (e.g. `~/.ssh/authorized_keys` on *CSIL*).

There is one more step: we need to make sure that the permissions for all of the files are correct.

Type these commands on **both** machines to set the permissions correctly.

```
chmod 711 ~
chmod 700 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/authorized_hosts
```

At this point, you should be able to ssh from your laptop to CSIL without having to type in a password.

# For more information

Here are several articles with more details.  The above instructions are just one approach; there are others, as you'll learn if you do the reading below.

* <https://serverpilot.io/docs/how-to-use-ssh-public-key-authentication/>
* <https://www.ssh.com/academy/ssh/public-key-authentication>
* <https://kb.iu.edu/d/aews>

