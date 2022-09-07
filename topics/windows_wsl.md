---
parent: Topics
layout: default
title: "Windows: WSL"
description:  "Setting up a development environment under Windows Subsystem for Linux"
indent: true
category_prefix: "Windows: "
maven_version: 3.8.5
---

For advanced users who are looking to have a full Linux command-line interface on their Windows machine (which may be helpful for CMPSC 156 work), we recommend using Windows Subsystem for Linux (WSL). WSL is a tool that basically creates a separate Linux environment alongside your Windows environment, with access to your local filesystem. This will allow you to access package managers (such as `apt-get` for Ubuntu/Debian) and the full suite of UNIX commands.

Note that the reference platform for the course remains "CSIL"; we cannot commit to being "tech support" for every conceivable platform. On your own machine, you *are* your own tech support. But we'll help as best we can, given the time constraints we are under.

## Compatibility

The first step is ensuring that you have a compatible machine. You will need:
* One of the following operating systems:
   * Windows 11, any build
   * Windows 10, build 16215 or later (but we recommend 18917 or later to use new [WSL 2 features](https://devblogs.microsoft.com/commandline/announcing-wsl-2/) and the new [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701)).
* Administrator privileges on your machine

## Install WSL

On Windows 11 machines and Windows 10 machines with build 19041 or higher, installing WSL is very simple:

1. Open Command Prompt or PowerShell as administrator
   * This can be done by searching for either program in the Start Menu, right-clicking on the result, and selecting "Run as administrator"
2. Run the following command: `wsl --install`
   * This will enable and install WSL with the default configuration:
      * WSL 2
      * The latest LTS release of Ubuntu (currently 20.04 LTS)
3. Once installation is complete, launch your distribution from the Windows Start Menu

More information on the above steps can be found [here](https://docs.microsoft.com/en-us/windows/wsl/install).

If your machine doesn't meet the criteria to use the one-line install command, you can follow the manual installation instructions [here](https://docs.microsoft.com/en-us/windows/wsl/install-manual). Unless you know exactly what you're doing, we recommend Ubuntu 20.04 LTS as your distribution. The rest of these instructions assume you installed Ubuntu.

The better / safer solution is to update your Windows 10 machine to a more recent build, so we recommend doing that and using the one-line install command instead.

## (Recommended) Install Windows Terminal

For users who want a nicer looking terminal, complete with tabs, full Unicode support (for emojis!), custom colors / fonts, and more customization features, you can optionally install the new Windows Terminal.

Windows Terminal is already the default terminal for Windows 11 users, so no further installation is needed.

For Windows 10 users, you can install Windows Terminal from the [Microsoft Store](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701).

## A note about Line Endings on Windows

Keep in mind that WSL uses UNIX line endings (LF) while Windows uses CRLF line endings. If you check out your code natively in Windows (i.e. using Git Bash or GitHub Desktop), your checked-out code will use CRLF line endings, and therefore may cause Shell scripts (and other programs that parse based on line endings) and Git commits to act differently or fail.

Since most of our work will be done in WSL, you should try to use LF line endings whenever possible.

## Install / Update Git on WSL

Ubuntu should come with `git`, but the pre-installed version is usually outdated (you can check by running `git --version`).

If the pre-installed version is out-of-date or not installed, run the following commands:

```
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git
```

Successfully running the above commands should install the latest version of Git, which is 2.35.1 as of the time of writing. To verify that the install was successful, run the following command:

```
git --version
```

Your output should look like this:

```
git version 2.35.1
```

You are now ready to set up your Git environment using the steps below.

## Set Up Git on WSL

One thing to note is that Git on WSL does NOT operate in the same environment as native Git on Windows. This means that you will have to generate a new global config and SSH key specific to the WSL environment.

Start by setting your name and email by running the following commands with the appropriate values:

```
git config --global user.name "Joe Gaucho"
git config --global user.email "joegaucho@ucsb.edu"
```

**Be sure that the listed email is linked to your GitHub account.** This is how GitHub is able to attribute a commit to your account, and this will be necessary to receive credit for the code you write. You can check the emails associated with your GitHub account [here](https://github.com/settings/emails).

Next, we will need to generate new SSH keys specific to the WSL environment. For instructions on how to do that, take a look at [this page](/topics/github_ssh_keys/). You are welcome to use any type of key pair you would like - GitHub should support most of them, including those backed by physical security keys.

Note: While it's not entirely necessary to set up SSH keys, since you can always work remotely with repos via HTTPS, using SSH keys just makes using Git easier since you will not have to re-enter your GitHub login information whenever you want to clone a repo or push/pull.

## Install Java on WSL

The projects in this class use **Java 17**, which is the latest LTS release of Java.

To install the latest version of Java 17 JDK, run the following commands:

```
sudo apt-get update
sudo apt-get install openjdk-17-jdk
```

Successfully running the above commands should install Java 17 JDK. To verify that the install was successful, run the following command:

```
java --version
```

Your output should look something like this:

```
openjdk 17.0.2 2022-01-18
OpenJDK Runtime Environment (build 17.0.2+8-Ubuntu-120.04)
OpenJDK 64-Bit Server VM (build 17.0.2+8-Ubuntu-120.04, mixed mode, sharing)
```

## Install Maven on WSL

The projects in this class use Maven 3.8.x, which is necessary for Java 17.

The `apt` package manager does not yet have Maven 3.8.x, so we need to manually download and extract Maven.

(As of this writing, the current version of Maven is 3.8.5; but it is possible that by the time you are reading
these instructions, the current version may have been updated, and the links to this version will no longer work.  If the links appear broken, see if there is a newer version available.)

Here are two links that have been reported to work for downloading Maven 3.8.5 (the only difference is `downloads` vs. `dlcdn`)
* <https://downloads.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz>
* <https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz>

If the first one doesn't work, try the second.

```sh
export MAVEN_VERSION=3.8.5
curl -O https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
tar -zxvf apache-maven-${MAVEN_VERSION}-bin.tar.gz
mv apache-maven-${MAVEN_VERSION} /opt/maven
```

You may need to prefix some of the above commands with `sudo` to grant necessary permissions.

Then, add Maven to your PATH by adding the following line to `~/.bashrc`:

```sh
export PATH=$PATH:/opt/maven/bin
```

Successfully running the above commands should install Maven 3.8.x. To verify that the install was successful, open a new terminal and run the following command:

```
mvn --version
```

Your output should look something like this:

```
Apache Maven 3.8.5 (3599d3414f046de2324203b78ddcf9b5e4388aa0)
Maven home: /opt/maven
Java version: 17.0.2, vendor: Private Build, runtime: /usr/lib/jvm/java-17-openjdk-amd64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.4.0-72-generic", arch: "amd64", family: "unix"
```

## Install nvm and Node on WSL

The projects in this class use Node 14.x LTS and npm 8.x.

While we could install Node 14.x directly, a better way to install Node on development computers is through Node Version Manager, or `nvm`. This is a program that allows you to easily install and switch between different versions of Node.

To install `nvm`, run the following command. As of the time of writing, the latest version is 0.39.1.

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

The install script should add the following lines to the end of your `~/.bashrc` file. If the following lines are not present, add them:

```sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

Successfully running the above commands should install nvm 0.39.1. To verify that the install was successful, open a new terminal and run the following command:

```
nvm -v
```

Your output should say `0.39.1`.

Now that we have `nvm` installed, we can use `nvm` to install the latest version of Node 14 with the following command. As of the time of writing, the latest version of Node 14 LTS is 14.19.1.

```
nvm install 14
```

Successfully running the above command should install the latest version of Node 14. To verify that the install was successful, run the following command:

```
node -v
```

Your output should say `v14.19.1` or something similar.

## Update npm on WSL

Node Package Manager (`npm`) is a package / dependency manager for Node projects, similar to Maven for Java projects. `npm` comes bundled with Node, but the version of `npm` provided with Node 14 - version 6.14.15 - is too low for our project, due to some major changes introduced in `npm` version 7.

Run the following command to update `npm` to the latest version (which is 8.5.5 as of the time of writing):

```
npm install -g npm
```

Successfully running the above command should install the latest version of npm 8. To verify that the install was successful, run the following command:

```
npm -v
```

Your output should say `8.5.5` or something similar.

**Keep in mind that each version of Node installed through `nvm` has its own installation of `npm`.** This means that, whenever you install a new version of Node, you will need to update `npm` to the correct version. The pre-bundled versions of `npm` tend to be out-of-date.

## Install and Setup Heroku on WSL

Heroku is the deployment platform used for the projects in this class. Some of the scripts in the projects make use of the Heroku CLI.

To install Heroku CLI, run the following command:

```
curl https://cli-assets.heroku.com/install.sh | sh
```

Successfully running the above command should install the latest version of the Heroku CLI. To verify that the install was successful, run the following command:

```
heroku --version
```

Your output should say `heroku/7.59.4 linux-x64 node-v12.21.0` or something similar.

Now that we have Heroku installed, we can log in. Run the following command to log in:

```
heroku login
```

You will be asked to log in through a web browser. The CLI will attempt to open your browser for you, but if it is unable to do so, a link will be visible in the terminal for you to manually copy and paste into your web browser.

## WSL with VS Code

If you are currently a VS Code user (or are considering becoming one), you can install an extension to be able to access, edit, and track files in the WSL from VS Code. Follow the instructions [here](https://code.visualstudio.com/docs/remote/wsl) to get started.
