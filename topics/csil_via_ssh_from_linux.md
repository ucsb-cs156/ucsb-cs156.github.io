---
parent: Topics
layout: default
title: "CSIL: via ssh from Linux"
description:  "Connecting via ssh from the command line"
indent: true
---

To connect to the CSIL machines from Linux, you just use the `ssh` command at command line.

Example (in this case `csil-05` could be any of `csil-01` through `csil-48`)

```
ssh username@csil-05.cs.ucsb.edu
```

If you are using an X11 desktop, you may find it helpful to use one of these so that you can access graphic programs on your Linux machine:


```
ssh -X username@csil-05.cs.ucsb.edu
```

or

```
ssh -Y username@csil-05.cs.ucsb.edu
```
