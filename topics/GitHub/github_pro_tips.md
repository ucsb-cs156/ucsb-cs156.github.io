---
parent: GitHub
grand_parent: Topics
layout: default
title: "github: pro tips"
description:  "A few extras to help you work with GitHub more effectively"
indent: true
category_prefix: "Git/Github: "
---

# Quick Command Line access to branch and pull request

The following code, if you put it into your `~/.bashrc` on Mac OS, will
give you two new command line commands (actually bash functions) called `gh` 
and `newpr`, that, respectively, will open up Github in a window on the current
branch, and open a new pull request on the current branch.

Notes on adapting these for Linux and Windows after the code snippet.

```
function current_branch() { # Gets current branch
    git rev-parse --abbrev-ref HEAD
}

function gh_remote_path() { # Parses the 'remote path' of the repo:  username/repo
    GH_PATH=`git remote -v | grep 'origin' | tr ':' ' '  | awk '/push/ {print $3}' | sed 's/.git$//'`
    echo ${GH_PATH}
}

function gh() { # Opens current branch on Github, works for all repos
    echo 'Opening branch on Github...'
    open "https://github.com/$(gh_remote_path)/tree/$(current_branch)"
}
function newpr() { # Opens current branch on Github in the "Open a pull request" compare view
  echo 'Opening compare on Github...'
  open "https://github.com/$(gh_remote_path)/compare/$(current_branch)?expand=1"
}

```

Use on non-Mac systems:
* The only part of this that is likely to be Mac OS specific is the `open` command.
* These functions could be modified to work on the CSIL Linux systems by
   modifying the `open` command to one that opens a web page in a browser.
* For Windows, these might work if you are using a bash shell; you'd also 
   need to modify the `open` command to one that works on Windows.

