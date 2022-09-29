---
parent: CSIL
grand_parent: Topics
layout: default
title: "CSIL: via ssh from Linux"
description:  "Connecting via ssh from the command line"
indent: true
---

To connect to the CSIL machines from Linux, you just use the `ssh` command at command line.


```
ssh username@csil.cs.ucsb.edu
```

If you are using an X11 desktop, you may find it helpful to use one of these so that you can access graphic programs on your Linux machine:


```
ssh -X username@csil.cs.ucsb.edu
```

or

```
ssh -Y username@csil.cs.ucsb.edu
```
