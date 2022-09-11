---
parent: Node
grand_parent: Topics
layout: default
title: "Node: Windows"
description:  "Installing and working with Node, npm, nvm on Windows"
indent: true
category_prefix: "Node: "
---

_Note that these instructions may be slightly outdated, as they were written in March / April for CS 48, but they should stil work. We're working on verifying that these instructions are still up-to-date._

There are various methods of using Node on Windows:

# Windows (via Command Prompt)

This method is the simplest to setup, but restricts you to using Node in the Windows Command Prompt.

To install Node for the Windows Command Prompt, download an installer from <https://nodejs.org/en/download/>.

After installing Node, open Command Prompt and run `node -v` and `npm -v` to verify that the version numbers for Node and npm match the installer that you downloaded.

You should now be able to open a Command Prompt window and run `node` and `npm` commands as usual. 

**Keep in mind that Command Prompt does not support most UNIX commands.** As a result, Node scripts that utilize system commands (like the setup script in CS 48's [demo-nextjs-app](https://github.com/ucsb-cs48-s20/demo-nextjs-app)) will not run properly. Because of this, we strongly discourage this method and recommend one of the other methods.

# Windows (via Git Bash)

This method requires you to install one additional program, but gives you the ability to use Node in a UNIX-like environment with access to a limited number of UNIX commands.

First, install Node using the same method as above (by downloading and running the installer).

Then, download and install Git for Windows from <https://git-scm.com/downloads>.

When running the installer, we recommend the following options:

* When prompted for a default editor, select the code editor that you use on your machine. The course staff recommends [Visual Studio Code](/topics/vscode/), but you are free to select the editor that you are most comfortable with, given that it is already installed on your machine. 
  * The default option is Vim, but we don't recommend it unless you know how to use it well.
* You can leave the other options to their default values, but you are welcome to change them if your project requires it and you know what you're doing.

After installing both Node and Git, open Git Bash and run `node -v` and `npm -v` to verify that the version numbers for Node and npm match the installer that you downloaded.

You should now be able to open a Git Bash window and run `node`, `npm`, and basic UNIX commands as usual. 

# Windows Subsystem for Linux (WSL)

For users who are looking to use Node with packages installed from package managers (such as `apt-get` for Ubuntu/Debian) and use the  full suite of UNIX commands, we recommend using Windows Subsystem for Linux (WSL).

First, install WSL using the instructions here: [Windows: WSL](/topics/windows_wsl/). This guide assumes that you have installed a Debian-based Linux distribution (like Ubuntu).

Next, remove all previous versions of Node that you may have installed through `apt` in WSL by running this command:
```
sudo apt-get purge --auto-remove nodejs
```
(Source: <https://askubuntu.com/questions/786015/how-to-remove-nodejs-from-ubuntu-16-04>)

Visit the [NodeSource Node.js Binary Distributions page](https://github.com/nodesource/distributions/blob/master/README.md), navigate to "Installation and Instructions" under "Debian and Ubuntu based distributions", and run the commands listed for your desired Node version. This will install the requested version of Node and npm.

After installing, run `node -v` and `npm -v` to verify that the version numbers for Node and npm match the installer that you downloaded.

You should now be able to open your Linux distribution and run `node`, `npm`, and UNIX commands as usual. 

## Alternative WSL installation method

If the above method didn't work, one alternative method for installing Node on WSL is to use the Node Version Manager (`nvm`). 

The linked page from Microsoft has information on installing Node for WSL using `nvm`: <https://docs.microsoft.com/en-us/windows/nodejs/setup-on-wsl2>

* Note that this guide includes the entire process of installing a distribution. If you have already done that, you can skip to the part "[Install nvm, node.js, and npm](https://docs.microsoft.com/en-us/windows/nodejs/setup-on-wsl2#install-nvm-nodejs-and-npm)"
* As of the time I wrote this, none of the course staff has used this alternative method to install Node using WSL. As a result, we may not be able to offer much help, should you come across problems.
