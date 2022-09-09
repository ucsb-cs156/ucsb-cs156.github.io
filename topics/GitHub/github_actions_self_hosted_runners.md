---
parent: GitHub
grand_parent: Topics
layout: default
title: "github: actions self hosted runners"
description:  "If you run out of GitHub minutes, you can set up your own servers"
indent: true
---

If you run out of GitHub actions minutes, you can set up your own servers until the minutes reset.

# How do I know if I'm out of minutes

You'll see something like this on your organization's billing page:

![image](https://user-images.githubusercontent.com/1119017/153475562-d40f0135-7960-4388-9db3-f2a40b99610c.png)


You can also monitor when you are getting close here:

![image](https://user-images.githubusercontent.com/1119017/153475496-9ecc6b7f-ec0a-4e5a-a79f-589f9f5baace.png)


Self Hosted Runners can be either on your own hardware, or on a platform such as AWS

# Setting up a self hosted runner on your own hardware

TODO: Update this for java 17, and other version changes...  Perhaps make it generic to say "version of X being used in the course".

## Prerequisites

* A computer with a fresh installation of [Ubuntu 20.04 LTS](https://ubuntu.com/download)
  * If this computer is a dedicated computer for GitHub Actions, I recommend Ubuntu Server
  * If you're using Ubuntu Server, you'll need another computer with access to a terminal to assist with downloading Java JDK
* A persistent internet connection to the computer, preferably Ethernet
* Owner privileges in the GitHub organization
* An Oracle account, if downloading Java JDK directly from Oracle

This tutorial assumes that you have basic Unix CLI skills and you have a fresh installation of Ubuntu 20.04 LTS.

These are the installation steps I followed, there may be other ways to do the steps below.

## Step 1: Download Java JDK 11

First, visit [this website](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) in your browser to download Java JDK 11. You'll likely want the "Linux x64 Debian Package" variant of JDK 11.

Note that since we are downloading JDK directly from Oracle, and this isn't the latest version of the JDK, we need an Oracle account in order to download the file. You will be asked to sign in here. 

If you're using Ubuntu Server or otherwise don't have access to a web browser, use another computer to download the file, then use SCP to transfer it over to the original computer.

## Step 2: Install and Setup Java JDK 11

Extract the JDK

```
tar -xzvf jdk-11.0.10_linux-x64_bin.tar.gz
```

Create the following folder if it doesn't already exist

```
sudo mkdir /usr/lib/jvm
```

Move your extracted JDK into the newly created directory

```
sudo mv jdk-11.0.10 /usr/lib/jvm/
```

Add the following line to the end of `~/.bashrc`

```
export JAVA_HOME="/usr/lib/jvm/jdk-11.0.10"
```

Add the following directory into the PATH in `/etc/environment` (using sudo): `:/usr/lib/jvm/jdk-11.0.10/bin`

Your new PATH should look something like this:

```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/jvm/jdk-11.0.10/bin"
```

Source the two previous files, or log out and log back in

```
source ~/.bashrc
source /etc/environment
```

Lastly, use `java --version` to verify a successful install. 

The output should look something like this:

```
java 11.0.10 2021-01-19 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.10+8-LTS-162)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.10+8-LTS-162, mixed mode)
```

## Step 3: Install Maven

Use the following commands to install Maven

```
sudo apt update
sudo apt install maven
```

Then, use `mvn --version` to verify a successful install.

The output should look something like this:

```
Apache Maven 3.6.3
Maven home: /usr/share/maven
Java version: 11.0.10, vendor: Oracle Corporation, runtime: /usr/lib/jvm/jdk-11.0.10
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.4.0-72-generic", arch: "amd64", family: "unix"
```

## Step 4: Install Node and npm

Visit the [NodeSource distributions page](https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions) and find the Ubuntu installation commands for Node.js v14.x. As of the time of writing, it looks like this:

```
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
```

Run those commands on your machine.

Then, use `node -v` and `npm -v` to verify successful installs. Your Node version should be `v14.16.1`, and your npm version should be `6.14.12` (or above for both).

## Step 5: Install the GitHub Actions Runner

Visit your organization on GitHub, and click "Settings". Then, on the left bar, click on "Actions".

Scroll down to the bottom of the page and look for the "Self-hosted runners" section, click "Add new", and select "New runner".

Select "Linux" as the operating system, and select your architecture. (Most computers use X64)

Then, run the instructions listed in the "Download" and "Configure" sections. 

See the below notes for running the config script:
* When asked for a runner name, I suggest naming it with something along the lines of `githubid-desc_of_machine`
* When asked to provide additional labels, add `ubuntu-latest`
* Keep the default value for your work folder

Once you run `./run.sh`, your Actions runner should start and you should see the following output:

```
√ Connected to GitHub

2021-04-20 00:24:52Z: Listening for Jobs
```

You have now set up your Actions runner!

## (Optional) Step 6: Run the Actions Runner Automatically on Boot

First, run `pwd` in your `actions-runner` directory and copy the output path.

Then, open `/etc/rc.local` in your favorite text editor using sudo.

```
sudo vim /etc/rc.local
```

Add the following line to the file, substituting your account username for `\<USERNAME\>` and the copied path for `\<RUNNER_DIR\>`:

```
sudo -i -u <USERNAME> <RUNNER_DIR>/run.sh >> <RUNNER_DIR>/output.txt
```

Additionally, if the file was initially empty, add the following line as the very first line of the file:

```
#!/bin/bash
```

Save the file and exit.

Set the correct permissions for that file:

```
sudo chmod a+x /etc/rc.local
```

Then, reboot your machine. When your machine boots up, the Actions runner should start in the background. You can follow the output of the runner by using the following command in your runner directory:

```
tail -f output.txt
```

You now have an Actions runner that runs on its own!

# Setting up a self hosted runner on AWS

TODO
