---
parent: Topics
layout: default
title: "github: markdown"
description:  "Working with GitHub Markdown"
indent: true
category_prefix: "Git/Github: "
---

# Emacs Tip

If you have lots of images in your Markdown that were the result of
pasting images into `.md` files in GitHub that look like this:

```
![image](https://user-images.githubusercontent.com/1119017/152721387-3c76426f-d131-4ab5-84b5-638ed9ccefed.png)
```

You can turn them into this:

```
<img alt="" src="https://user-images.githubusercontent.com/1119017/152721387-3c76426f-d131-4ab5-84b5-638ed9ccefed.png" width="800" />
```

With the following emacs command:

```
Query replace regexp
\!\[image\](\([^\)]+\)
<img alt="" src="\1" width="800" />)
```