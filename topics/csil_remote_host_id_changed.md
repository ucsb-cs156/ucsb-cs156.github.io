---
parent: Topics
layout: default
title: "CSIL: Remote Host Id Changed"
description:  "The scary REMOTE HOST ID CHANGED message with mention of SOMETHING NASTY"
indent: true
---

# What does this mean?

Suppose you are trying to ssh into `csil.cs.ucsb.edu`, and you see the following
thing pop up on your screen:

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the RSA key sent by the remote host is
ab:cd:ef:12:34:56:78:90:ab:cd:ef:01:23:7:55:68.
Please contact your system administrator.
Add correct host key in /Users/ChrisGaucho/.ssh/known_hosts to get rid of this message.
Offending RSA key in /Users/ChrisGaucho/.ssh/known_hosts:12
RSA host key for csil.cs.ucsb.edu has changed and you have requested strict checking.
Host key verification failed.
```

It is *possible* but <b>not very likely</b>, that someone is launching a man-in-the-middle attack on your connection to CSIL.

Far more likely: the Engineering staff has replaced the physical hardware for the machine known as csil.cs.ucsb.edu with another machine.

Here's what you should do:

1.  First, starting with Fall 2016, you probably shouldn't be accessing
    `csil.cs.ucsb.edu` in the first place.  You can, but instead, use csil-01.cs.ucsb.edu,
    `csil-02.cs.ucsb.edu`, etc. through `csil-48.cs.ucsb.edu`.  You'll likely get better
    performance.

2.  Despite what the message says, you don't need to contact the system administrator.

3.  Instead, just delete the `known_hosts` file that the system tells you contains
    the problem.  The system will recreate the file for you:

    E.g. in the message above, the file is:

    ```
    /Users/ChrisGaucho/.ssh/known_hosts
    ```

    The file in your message will be different, but will have a similar name.
    Find this file on your system, and delete it.


# What is this `known_hosts` file, and why am I deleting it?

What this file contains are numbers that get cached when you answer `yes`
to this question, which you get asked, once, the first time you connect to
any system over ssh:

```
The authenticity of host 'csil.cs.ucsb.edu (128.111.43.14)' can't be established.
RSA key fingerprint is 4a:0e:85:b5:7c:c4:1c:af:3f:02:c5:75:61:da:ae:55.
Are you sure you want to continue connecting (yes/no)? 
```

If you were paranoid, or your ssh connection were likely to contain sensitive 
information that made it the target of 
state-sponsored surveillance or hackers connected to organized crime, you might
send a highly trusted and armed person over to Harold Frank Hall to verify using
paper, or carrier pigeon, or some other secure form of communication, that
this RSA key fingerprint, `4a:0e:85:b5:7c:c4:1c:af:3f:02:c5:75:61:da:ae:55`
was indeed the correct one.   

But it is far more expedient to simply "assume" it is correct, and let the system
store it in the `known_hosts` file, where you'll never hear another peep about it
unless and until the number changes again.

When you get rid of this file, the system will ask you about each host again the
first time you connect to it.  It will take a while to build up all of the
`known_host` RSA key fingerprints again.  But then, you'll be golden&mdash;at least
until the next major hardware upgrade to all the systems to which you connect.


 
