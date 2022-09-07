---
parent: Topics
layout: default
title: "javafx: XQuartz on Mac"
description:  "when JavaFX doesn't work over X11 forwarding on Mac, how to fix it"
category_prefix: "javafx: "
indent: true
---

When using X11 forwarding over XQuartz on Mac, JavaFX programs sometimes result in the
following error:

```
-bash-4.3$ java HelloJavaFX 
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
X Error of failed request:  BadValue (integer parameter out of range for operation)
  Major opcode of failed request:  149 (GLX)
  Minor opcode of failed request:  24 (X_GLXCreateNewContext)
  Value in failed request:  0x0
  Serial number of failed request:  28
  Current serial number in output stream:  29
-bash-4.3$
```

This magic command line that you run <b>at the Mac command line</b> seems to fix the problem,
as suggested 
by [this internet discussion](https://github.com/ControlSystemStudio/cs-studio/issues/1828), which
referenced [this other bug report](https://bugs.freedesktop.org/show_bug.cgi?id=96260)

```
defaults write org.macosforge.xquartz.X11 enable_iglx -bool true
```

