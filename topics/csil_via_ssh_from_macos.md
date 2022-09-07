---
parent: Topics
layout: default
title: "CSIL: Via MacOS"
description:  "Accessing CSIL from your MacOS system"
indent: true
---

# Accessing CSIL from MacOS

To access CSIL from MacOS, you can use the Terminal command, and type the following, replacing `cgaucho` with your ECI/CSIL username:

```
ssh cgaucho@csil.cs.ucsb.edu
```

NOTE: For Fall 2020, we are asked to no longer use `csil-01 through csil-48`, but only `csil.cs.ucsb.edu`.  This is a change from previous quarters.

# What about the `no $DISPLAY environment variable` error?

If  try to run a program that uses a Java GUI, or any other type of graphics window,
and you get this message:

```
no display name and no $DISPLAY environment variable
```

then there are two options:

1.  Use the Remote Desktop option (see below)
2.  Use X11 with XQuartz (see below)(though ECI notes that X11 is deprecated as of Fall 2020)

then you need to install XQuartz as explained below, log out, log in, and try again.

# Connecting with Remote Desktop

With this option, you have a window on your local computer that shows the entire Linux Desktop on the remote machine.  It is different from the X11 options we used in the past.

Instructions for connecting to CSIL via Remote Desktop appear here: 
* <https://doc.engr.ucsb.edu/display/EPK/Remote+Access+to+Computer+Science+Computing+Labs>
* MacOS specific instructions are here: <https://doc.engr.ucsb.edu/display/EPK/CS+Lab+RDP+Access+-+MacOS+Client>
* You will also need the Campus VPN Client (Pulse Secure) which you can install here: <https://dev-it-ucsb-edu-v01.pantheonsite.io/get-connected-vpn/pulse-secure-vpn-client-mac-os>


# Using Samba with MacOS

Another option is to mount your CSIL home directory *as if* it were a local directory on your Mac.

This allows you, for example, to edit files on CSIL using VSCode running on your Mac.

To do this, see the instructions here: <https://doc.engr.ucsb.edu/pages/viewpage.action?pageId=3342386>




# Using X11 with XQuartz

Note that this option is now considered deprecated by ECI in favor of the Remote Desktop option (per [this article](https://doc.engr.ucsb.edu/pages/viewpage.action?pageId=5112076)


## Installing XQuartz

First: What is XQuartz and why do I need to install it?

When you use the `ssh` command to access CSIL in a terminal window, essentially you are running all your software on CSIL in a terminal
window on CSIL, and just connecting your Mac's terminal window to the CSIL terminal window over the internet.  That's what the ssh
command does.

This works just fine <em>until</em> you try to do something involving graphics, or windows, such as the `idle3` program.  On CSIL, `idle3` brings
up a window in the Linux windowing system, which is called X11.  However, MacOS does not have the capability to display that kind of window
built into it.  You need an extra piece of software called an X11 Server&mdash;that's exactly what XQuartz provides.

By installing XQuartz, and using the `-X` flag when you connect to CSIL with the `ssh` command, you allow your CSIL terminal window to 
open up graphics windows on your Mac for programs such as `idle`.   If you don't have a program like this in place, you get the
`NODISPLAY` error message.

## Where do I get it

Go to <http://xquartz.org>, and look for the link to download and install the latest version.   Follow the instructions.

At the end, you will need to logout and log back in to your Mac session (not just your ssh session, 
but your entire MacOS session.)  To do this, go to the Apple menu, i.e.  at upper left of your desktop
where it says "Log Out Chris Gaucho" or whatever your name is.   Log back in, and then try terminal again with the `ssh -X ...` command
listed above.


https://www.xquartz.org/

Then, to use ssh with X11, you need to add the `-X` flag to your ssh command like this:

```
ssh -X cgaucho@csil.cs.ucsb.edu
```

