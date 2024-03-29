---
grand_parent: Topics
parent: Unix
layout: default
title: "Unix: X11"
description:  "Dealing with X11 DISPLAY issues"
---

# {{page.title}}

When running graphics programs on CSIL in a terminal session on your own computer, you may run into X11 DISPLAY issues.

The reason is that CSIL machines run Linux and graphics are typically provided on Linux via a system called either `X11` 
(or sometimes *XWindows*).

X11 users a network connection to send graphics information between programs and an "X11 Server".  The X11 Server has to be 
running on the machine where the physical display screen, mouse and keyboard are located.  

So, if you are using a laptop, for example to access CSIL over an ssh connection, the video display, mouse and keyboard
are the ones on your laptop. So the X11 Server has to be running *there*, and the CSIL machine has to know how to connect
to it.

The way you make this happen is different on Linux, Mac, and Windows.

# Linux

If you are running a linux laptop, probably all you have to do to make things work is add the `-X` or `-Y` flag to your ssh command,
like this:

-   GOOD: `ssh` `-X` `username@csil.cs.ucsb.edu`
-   GOOD: `ssh` `-Y` `username@csil.cs.ucsb.edu`
-   WON'T WORK FOR GRAPHICS: `ssh` `username@csil.cs.ucsb.edu`

If you ask me the difference between the `-X` and the `-Y`, I'll just shrug and say: sometimes one works, sometimes the other.  Try one,
and if it does work, try the other one.

# Mac

Same answer as for Linux, except on recent versions of Mac OS, you might also have to download and install XQuartz.

You get that from here: https://www.xquartz.org/

Note that unlike most Mac Software, you really *do* need to *reboot* after you install before the software will work properly.

# Windows

For Windows, the best solution currently is a program called [MobaXTerm](http://mobaxterm.mobatek.net/).  You use this instead of PuTTY, and it all just works.

The older solution is to use XMing together with PuTTY.  This is more complicated, and so unless you have a good reason to 
prefer it to MobaXTerm, I suggest sticking with MobaXTerm.

Here are instructions for using XMing with PuTTY.

Installation:

* If you don't have it yet, download and install PuTTY by following the instructions here:  <http://www.cs.ucsb.edu/~pconrad/topics/CSILviaPutty/>

* Download and Install XMing from: http://sourceforge.net/projects/xming/


<b>Using XMing:</b>

* You must run XMing before you start PuTTY. When you double click on it, nothing will appear to happen, but XMing is running.
* Inside PuTTY, find the options menu, then "ssh", then "X11" and click the box for "X11 forwarding".
* For best results, instead of connecting to `csil.cs.ucsb.edu`, pick one of the CSIL machines by number, 
   e.g. `csil-01.cs.ucsb.edu` through `csil-48.cs.ucsb.edu`.  You'll get less lag that way.

