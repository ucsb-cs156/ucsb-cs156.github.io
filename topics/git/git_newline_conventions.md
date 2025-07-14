---
parent: Git
grand_parent: Topics
layout: default
title: "git: newline conventions"
description:  "The whole CR/LF thing"
indent: true
---

# {{page.title}}

## {{page.description}}

If you run `npm run format` and it changes every single file, you probably 
are suffering from a CR/LF problem.

Especially if, when you do a `git status` you see this:

```
LF will be replaced by CRLF the next time Git touches it
```

Short version: To fix it, you need this command:

```
git config --global core.autocrlf input
```

Longer version: See this page: <https://ucsb-cs156.github.io/topics/vscode/vscode_crlf.html>

