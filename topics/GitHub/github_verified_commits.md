---
parent: GitHub
grand_parent: Topics
layout: default
title: "github: verified badge on commits"
description:  "adding extra security to your commit messages"
indent: true
---

When you set your git configuration to use an email address with a command like this, github puts that email address on your
commmits:
```
 git config --global user.email "cgaucho@ucsb.edu"
```

But what is to stop you from typing this:

```
git config --global user.email "billgates@microsoft.com"
```

Well, nothing really.  If that really is an email address associated with a GitHub account, you could totally put in commit messages 
that look as if they were made by Bill Gates.  And Bill Gates could impersonate "Chris Gaucho" in return.

While there is nothing in place to stop this impersonation, it is possible to configure 
Commit Signature Verification so that when you make commits, they are identified
with a special badge indicating that the commit is verified as having come from you.

Shout out to our friends at AppFolio: this is one of the tips Phill Conrad picked up while interning there.

# Enabling Verified Commits
First, you'll need an ssh key. If you haven't made one, start [here](/topics/GitHub/github_ssh_keys.html).

Once you've made an ssh key, you have to tell github it exists. For most students, the commands will be below. If you set a custom location for your public/private key pair, replace `~/.ssh/id_rsa.pub` with your public key location. Run the following commmands:

```bash
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_rsa.pub
```

So that you don't have to remember to sign each commit as you make it, you can run the following command:
```bash
git config --global commit.gpgsign true
```

After that, you have to tell GitHub about your signing key.

VERY IMPORTANT: you want to upload your `id_rsa.pub` file to `github.com`

You do NOT upload your `id_rsa` file to github.com. That file is your private key, and needs to stay private and protected.

You don't actually "upload" your `id_rsa.pub` to github.com.   You actually just copy and paste the value. `cd` into the `~/.ssh` directory and use the command `cat id_rsa.pub` to have the file be printed in the terminal like this

```
    (~/.ssh)$ cat ~/.ssh/id_rsa.pub
    ssh-rsa 
    AAAAB3NzaC1yc2EAAAADAQABAAABAQDYySoh7b1uGpI7saLozpgXz184YYgC9k22zLH8TqKiSLAcNCO5hEzgC0kZoytCMtw/hUx3kto8
    apPS4ORL6HebWXuGfzQ3nQslPpBNmto0hdo446wBu/Hl5a7pC3SZUzti4YbUjRDOBgM5zQMaopTXhtqNY/tRB8/lSSYaEtIxLN5twk29
    IQUoA2wdPTmU/fRPc3PUdD9/KHJfBIL/ROsOb73tGOxqZoMnzV0ElmLhjq6WEqNWypaFrI0YU8OmIvxmlDXn0gkr3oYHqrbz5qznSust
    ucWBEFZ3lekvZiXrqizFplYZF+LiG9TOGjhxujOJ+sIcCy0BCN4msb1/lguN hamstra@csil.cs.ucsb.edu
    (~/.ssh)$
```

Then you want to copy the text contents of the file, starting with 'ssh-rsa AAAAA...' and ending with '...@csil.cs.ucsb.edu or the name of your computer'.

* Keep in mind that uploading a public SSH key gives access to your github account to whoever has access to the matching private SSH key on his/her computer.
* So make sure that you are using YOUR OWN public ssh key—and not the key shown in the example above.

To do this, login to the page <http://github.com>

Look for the gear icon in upper right to take you to the settings screen.

Click on the tool icon, and it should take you to a screen like this—you are looking for the SSH Keys menu item on the left:

<div style='border:1px solid black;' markdown="1">
<img src="http://i.imgur.com/xXESmRI.png" alt="ssh" />
</div>

Click on that, and you'll be taken to this screen, where you can upload a new public key:

<div style='border:1px solid black;' markdown="1">
<img src="http://i.imgur.com/z8blAzI.png" alt="ssh" />
</div>

Select "Signing Key"
![image](https://github.com/user-attachments/assets/0dad096a-d717-41fb-ad7b-54b4ef31eaa8)

Paste the key you copied into the key field.

Once the key is uploaded, you're all set to be able to sign your commits!

# Signing already made commits
If you forgot to sign commits you already made, there's a couple things you can do:

## Signing the last commit
If you only forgot to sign the last commit, you can sign it with the following command:
```bash
git commit --amend -S
```

## Signing an entire branch
If you need to sign an entire branch, you can rebase and sign every commit. You can specify any branch, tag, or hash to start with. In this case, we use `main`, as that it where most branches originate from.
```bash
git rebase --signoff -S main
```

# Rejected Commits
If your commits are still being rejected for signing violations, make sure your username and email are properly set. Your git email must be an email associated with your Github account, or it will reject your commits as unverified.

To set your name and email for your whole git installation, run the following commands:
```bash
git config --global user.name <name>
git config --global user.email <email> 
```

# Learn More
To learn more, consult these links:

* <https://help.github.com/en/articles/generating-a-new-gpg-key>
* <https://help.github.com/en/articles/adding-a-new-gpg-key-to-your-github-account>
* <https://help.github.com/en/articles/telling-git-about-your-signing-key>
* <https://www.linode.com/docs/security/authentication/gpg-key-for-ssh-authentication/>
