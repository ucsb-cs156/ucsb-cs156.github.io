---
parent: Topics
layout: default
title: "Node: MacOS"
description:  "Installing and working with Node, npm, nvm on MacOS"
indent: true
category_prefix: "Node: "
---

You can install node (which installs `npm` and `npx` along with it) either by
* Directly obtaining an installer from: <https://nodejs.org/en/download/>
* With the `brew` package manager (see below).

# Installing node via brew

One of the easiest ways to do this on MacOS is via the brew package manager.

## Installing `brew`

* To install `brew`, visit <https://brew.sh> and follow the instructions
* Before installing anything with `brew`, it's good practice to run `brew update` first.
* If your `brew` install is messed up, `brew doctor` can help restore a proper install.

## Using `brew` to install node

This command will install `node` using `brew`

```
brew install node
```

To test if it worked, you can try:

```
npm --version
```

# Error: `gyp: No Xcode or CLT version detected!`

If you get an error like this one when you try to do `npm install`, then you may need to reinstall your XCode tools.

```
> node-gyp rebuild
No receipt for 'com.apple.pkg.CLTools_Executables' found at '/'.
No receipt for 'com.apple.pkg.DeveloperToolsCLILeo' found at '/'.
No receipt for 'com.apple.pkg.DeveloperToolsCLI' found at '/'.
gyp: No Xcode or CLT version detected!
```
Here are the instructions for doing so:

* <https://medium.com/flawless-app-stories/gyp-no-xcode-or-clt-version-detected-macos-catalina-anansewaa-38b536389e8d>
  * NOTE however that there is a missing step in those instructions.  After removing the old version of the XCode command line tools, to start the
    process of reinstalling the XCode command line tools, type `git` at the command prompt.

If that doesn't work, here's another option:

>    This worked for me.
>
>    Install full Xcode
>    Open Xcode and the CLT will install
>    Then run sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
>
>    This uses the full Xcode CLT and node-gyp works.

# Install npm packages globally without sudo on macOS 

These instructions work for Linux too.

<https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md>

# Should I install npm or nvm?

Most node tutorials suggest installing node and then using the tool `npm`.

It's probably a better idea to work with `nvm` if you are using your own computer, as that will allow you to maintain separate node environments for
different projects.   

This StackOverflow answer explains more: <http://stackoverflow.com/questions/16151018/npm-throws-error-without-sudo>

# Installing `nvm`

See: <https://github.com/creationix/nvm#install-script>

# npm install wants root / sudo.  What should I do?

See this StackOverflow answer: <http://stackoverflow.com/questions/16151018/npm-throws-error-without-sudo>

