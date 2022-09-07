---
parent: Topics
layout: default
title: "Unix: Search/Replace across multiple files"
description:  "from the command line, using grep, sed, etc."
indent: true
category_prefix: "Unix: "
---

# Quick One Liners

Replace foo with bar in every .java file in current directory (based on [this source](http://stackoverflow.com/questions/11392478/how-to-replace-a-string-in-multiple-files-in-linux-command-line))  (Does NOT WORK ON MAC... see below for alternate version).


```
cd /path/to/your/folder
sed -i 's/foo/bar/g' *.java
```

Note that on Mac, the second line should be:

```
sed -i .backup -e 's/foo/bar/g' *.java
```

Replace old-word with new-word in every file in current directory tree (based on [this source](http://stackoverflow.com/questions/11392478/how-to-replace-a-string-in-multiple-files-in-linux-command-line))

```
grep -rli 'old-word' . | xargs -i@ sed -i 's/old-word/new-word/g' @
```

# Longer articles

* Replace a String in Multiple Files in Linux Using Grep and Sed: <http://vasir.net/blog/ubuntu/replace_string_in_multiple_files>
