---
parent: Topics
layout: default
title: "CSIL: via ssh from Windows"
description:  "Connecting via ssh (PuTTY, XMing, Command Line) or remote desktop"
indent: true
---

There are four main ways to connect to the CSIL machines from Windows. 

1.  Using an ssh client for a terminal connection *with no graphics*.  Examples include using PuTTY, or MobaXTerm withot  This is sufficient if you only need to do small edits or file maniupulations, but
    is not ideal if you need graphics, e.g. to start up a web browser, use a more sophisticated editor (such as VSCode).
    
    This is likely *the best approach if your network connection is slow*.
      
2.  Using Remote Desktop.  This approach is new for Fall 2020 (it was beta tested during Spring 2020).  In this approach, you open a window on your Windows machine
    that shows the entire Linux Desktop of the remote system.  More on this below.

3.  Using Samba to mount your CSIL home directory as if it were a local directory on your local machine.  

    This approach can be used in combination with the other approaches listed above, and may be the best way to use VSCode to edit files on CSIL.  With this approach, you install VSCode on your local machine, and run it on your local machine, but you edit the files directly on CSIL *as if* they were local files on
    your computer.
   

4.  Using an ssh client with X11 forwarding (e.g. with XMing, or MobaXTerm).  Note that while you may have used this method in the past, and it still likely works,
    it is now considered *deprecatd* by ECI (according to this article) in favor of the *Remote Desktop* solution described below.
    
    Because this approach is deprecated, we'll actually discuss it last.

# Simple ssh client

If you have a newer version of Windows, you may find that at the Windows command line, you can simply type the following just as one would on Mac or Linux,
and it will just work:

Open a windows command line, and type the following, replacing `cgaucho` with your ECI/CSIL username:

```
ssh cgaucho@csil.cs.ucsb.edu
```

NOTE: For Fall 2020, we are asked to no longer use `csil-01 through csil-48`, but only `csil.cs.ucsb.edu`.  This is a change from previous quarters.

If you get a message that the `ssh` command is not found, you have a few options:

1.  (Recommended) Install [`git for windows`](https://git-scm.com/download/win), and use the `git shell`.  It has the `ssh` command built in.
2.  (Older alternatives you might already be familiar with) Use an ssh client such as [PuTTY](https://www.putty.org/) or [MobaXTerm](http://mobaxterm.mobatek.net/) 

The hostname to use is `csil.cs.ucsb.edu`, and the username/password is your ECI username (maintained here: <https://accounts.engr.ucsb.edu>


# Remote Desktop

Follow the instructions here: <https://doc.engr.ucsb.edu/display/EPK/Remote+Access+to+Computer+Science+Computing+Labs>


# Using Samba to Mount your CSIL Home Directory

See: <https://ucsb-cs156.github.io/topics/csil_mount_drive_to_windows_using_samba/>

# X11 via MobaXTerm

Note that this method of connection is now deprecated by ECI according to [this article](https://doc.engr.ucsb.edu/pages/viewpage.action?pageId=5112076), but we provide documentation for it anyway so that it is here as an alternative if the other methods fail.

The most commonly used ssh client in the past has been a program called PuTTY.

PuTTY works fine for any program that doesn't use graphics.  However, to access the graphics capabilities of the 
CSIL machines, you also need a piece of software known as an *X11 server*, such as XMing.

Configuring PuTTY and XMing to work together can be tedious.   Why bother, when there is now a free program that
combines both, called MobaXTerm.

You can download MobaXterm from this link: 

# How to use MobaXTerm to connect to CSIL

Once you have downloaded it, you want to use it to create a new session.  The [demo shown at this link](http://mobaxterm.mobatek.net/demo.html) pretty much illustrates the process.  

* Click "new session"
* Select "ssh"
* For "remote host", instead of `192.168.56.86` you'll enter `csil.cs.ucsb.edu` 
  * NOTE: Yes, `csil.cs.ucsb.edu` for Fall 2020, not `csil-01.cs.ucsb.edu` through  `csil-48.cs.ucsb.edu`.  That's new for Fall 2020.
* For "username", instead of `root`, you'll enter your CSIL username.
* The first time you connect to a particular system, you may be asked 
* It should then prompt you for your password.  (I do not recommend "saving the password".)

# SSH Port Forwarding

*When you want to access a `localhost:8080` web app running on CSIL from a non-CSIL computer, e.g. your laptop*

At a command prompt (terminal prompt on MacOS, Linux, WSL, Windows 10, or git bash shell on Windows), you can type this:

`ssh -L 8080:localhost:8080 username@csil.cs.ucsb.edu`

where:
* `username` is your actual CSIL username

That will set up port 8080 on your local machine as a tunnel to "localhost:8080" on the CSIL machine.    Then, if you put `localhost:8080` in your browser, you should be getting access to `localhost:8080` on the CSIL machine you are ssh'ing into.

NOTE HOWEVER, that only one user at a time can be using port 8080 on the CSIL side.  So, if you port 8080 isn't available on the CSIL side, you may need to use a different port number.  Be aware that if you are using OAuth authentication, the port number may be baked into the OAuth credentials, so you might have to make changes to your OAuth config if you use a different port.

