---
parent: jenv
grand_parent: Topics
layout: default
title: "jenv: Windows Subsystem for Linux/WSL"
description:  "Managing multiple Java versions on WSL"
---

# {{page.title}} - {{page.description}}

Here's how to work with `jenv` on MacOS to manage multiple Java versions.

## Step 1: Install `jenv`:
You'll need to run a couple of commands to install `jenv`:
```
git clone https://github.com/jenv/jenv.git ~/.jenv
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(jenv init -)"' >> ~/.bashrc
source ~/.bashrc
```

Then you should be able to run `jenv doctor` which should return something like this:

```
[OK]    No JAVA_HOME set
[ERROR] Java binary in path is not in the jenv shims.
[ERROR] Please check your path, or try using `jenv add /path/to/java/home`.
```

Next, you'll want to allow jenv to control your $JAVA_PATH variable with the following commands:
```
jenv enable-plugin export
source ~/.bashrc
```

Note: the `source ~/.bashrc` step is very important!  Don't skip that!

## Step 2: Install Java Versions
You'll want to install the java versions you need to manage. You can do so with the following commands:
```
sudo apt-get update
sudo apt-get install openjdk-17-jdk
sudo apt-get install openjdk-21-jdk
```

## Step 3: Add Java Versions to Jenv
To add the java versions to Jenv, you'll want to locate them. On Ubuntu, they usually are in the directory `/usr/lib/jvm`.

You can see the directories in this folder by typing `ls` which will return something like this:
```
java-1.17.0-openjdk-amd64  java-17-openjdk-amd64  openjdk-17
java-1.21.0-openjdk-amd64  java-21-openjdk-amd64  openjdk-21
```

The folders you are looking for are of the format `java-17-openjdk-amd64` and `java-21-openjdk-amd64`.

Then, using their full file location, you can add them to jenv with the following commands (if yours is in a different directory, use those locations instead):
```
jenv add /usr/lib/jvm/java-21-openjdk-amd64/
jenv add /usr/lib/jvm/java-17-openjdk-amd64/
```

You can see if they've been added correctly by running `jenv versions` which will return something like the following:
```
* system (set by /home/djensen/.jenv/version)
  17
  17.0
  17.0.13
  21
  21.0
  21.0.4
  openjdk64-17.0.13
  openjdk64-21.0.4
```

## Step 4: cd into any of the ucsb-cs156 repos

Now, if all goes properly, anytime you cd into a directory that has a `.java-version` file in it (which all of the CS156 projects do), the java versions will be
set automatically.

For example, at the time I wrote this, `proj-courses` had a `.java-version` file containing `21` while `proj-happycows` had a `.java-version` file containing `17`.

What what happens when I switch between them (here I'm using `mvn -v` to show the currently selected version):
```
djensen@Laptop-Daniel:~/cs156/proj-courses$ mvn -v
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: /opt/maven
Java version: 21.0.4, vendor: Ubuntu, runtime: /usr/lib/jvm/java-21-openjdk-amd64
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "5.15.167.4-microsoft-standard-wsl2", arch: "amd64", family: "unix"
djensen@Laptop-Daniel:~/cs156/proj-courses$ cd ../proj-happycows/
djensen@Laptop-Daniel:~/cs156/proj-happycows$ mvn -v
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: /opt/maven
Java version: 17.0.13, vendor: Ubuntu, runtime: /usr/lib/jvm/java-17-openjdk-amd64
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "5.15.167.4-microsoft-standard-wsl2", arch: "amd64", family: "unix"
djensen@Laptop-Daniel:~/cs156/proj-happycows$
```

As you can see, proj-courses is using java 21, while proj-happycows is using Java 17!

