---
parent: Unix
grand_parent: Topics
layout: default
title: "Unix: Customize shell Prompt"
description:  "Customize your shell prompt with helpful info"
indent: true
category_prefix: "Unix: "
---

# {{page.title}}

You can customize your Unix prompt.  The technique changes depending on which shell you are using, so the first step is to figure that out.

Type:

```
echo $SHELL
```

* If the output is `/bin/bash`, you are using `bash`
* If the output is `/bin/zsh`, you are using `zsh`

Scroll to the correct directions below.


# Customizing the `bash` shell prompt

You can customize your bash prompt by redefining the special variable `PS1`

Examples:

| Command | Sample Prompt | Explanation |
|--|--|--|
| `export PS1="\u >"` | `pconrad >` | `\u` shows username |
| `export PS1="\u@\h > "` | `pconrad@csilvm-01 > ` | `\u` shows username, `@` gives a literal `@` sign, <br /> and `\h` shows `hostname` (machine where you are logged in)  |


You can put this line in your bash startup files to make this change happen every time you login.

* Basic: <https://phoenixnap.com/kb/change-bash-prompt-linux>
* Advanced: <https://wiki.archlinux.org/index.php/Bash/Prompt_customization>

# Customizing the `zsh` shell prompt


| Command | Sample Prompt | Explanation |
|--|--|--|
| `PROMPT='%2~ %# '` | `ucsb-cs156/student-ex01 % ` | `%2~` shows up to two directory levels of current directory. `%#` shows up as `%` in a normal shell, and `#` in a root shell.  |

See: <https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/>
