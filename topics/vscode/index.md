---
parent: Topics
layout: default
title: "VS Code"
description:  "Visual Studio Code, a lightweight free editor from Microsoft with many IDE features"
has_children: true
---

# How to get it

* On CSIL, type `code` to access the VS Code editor.
* For your own machine, download it from here: <https://code.visualstudio.com/>

# Customizing it

You'll likely need to add some "extensions" for the programming languages that you want to use (Java, C++, etc.)

# Tips and Tricks

* Multiline Editing: (copied [from here](https://stackoverflow.com/a/30039968))
   * On Windows, you hold Ctrl+Alt while pressing the up ↑ or down ↓ arrow keys to add cursors. 
   * On Mac, ⌥ Opt+⌘ Cmd+↑/↓
   * On Linux, Shift+Alt+↑/↓
   
* Format / Indent Code: (copied [from here](https://stackoverflow.com/a/29973358))

  The code formatting is available in Visual Studio Code through the following shortcuts:

  * On Windows Shift + Alt + F
  * On Mac Shift + Option + F
  * On Linux Ctrl + Shift + I

  Alternatively, you can find the shortcut, as well as other shortcuts, through the 'Command Palette' provided in the editor with Ctrl +Shift+ P (or   Command + Shift + P on Mac), and then searching for format document.

* Remove Unused Imports (per <https://medium.com/@mdkayesh777/how-to-remove-unused-imports-organize-in-vs-code-ed67f50e194f>)
  * On Windows and Linux: Shift + Alt + O (the letter O, not zero)
  * On Mac: Shift + Option + O (the letter O, not zero).
   
# Settings for Java Formatting

If you want to use the "fluent" format for code such as:

```java
@Override
  protected void configure(HttpSecurity http) throws Exception {
    http
        .authorizeRequests()
        .antMatchers("/", "/greeting", "/login**", "/webjars/**", "/error**", "/searchResults**", "/search/**")
        .permitAll()
        .anyRequest()
        .authenticated()
        .and()
        .oauth2Login()
        .loginPage("/login")
        .and()
        .logout()
        .deleteCookies("remove")
        .invalidateHttpSession(true)
        .logoutUrl("/logout")
        .logoutSuccessUrl("/")
        .permitAll();
  }
```

then check out this post: <https://github.com/redhat-developer/vscode-java/issues/1126>

# Mac OS Specific

On MacOS, if you want to be able to type `code .` at the Terminal command line
to open vscode in the current directory, here's what you need to do:
* Open the Command Palette (⇧⌘P) and type `shell command` to find the `Shell Command: Install 'code' command in PATH command` option
* Select that option, and behind the scenes, it will do the needed stuff to update your path.
* You will need to open a new Terminal window to see that take effect.
* Source: <https://code.visualstudio.com/docs/setup/mac>

# Windows Specific

On Windows, if you are using the "Git Bash Shell", and you want to be able to use VSCode by typing `code .` 
a the shell prompt, there are several approaches to getting that to work.

One approach is to try to get the code executable into your path.

Another approach, which worked for one student, is to create an `alias` in your `.bashrc` file.  Edit your `.bashrc` file
and insert the following line.  Note that the expression in `""` on the right hand side of the `=` may need to be customized based on the location of the `code` executable for VSCode on your machine.   Also note that any spaces in the filename have to be quoted with backslash (i.e. `\` as in the example below.)

```
alias code="/c/Users/hidde/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"
```

After this, if you close the git bash shell and reopen it, it should work. You may have to close and reopen the git bash shell more than once, as the system may need to automatically set up a `.bash_profile` that references your `.bashrc` if you don't already have one.
