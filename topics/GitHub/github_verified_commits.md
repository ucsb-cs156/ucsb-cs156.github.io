---
parent: GitHub
grand_parent: Topics
layout: default
title: "github: verified badge on commits"
description:  "adding extra security to your commit messages"
indent: true
---

# {{page.title}} - {{page.description}}

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

## Enabling Verified Commits

To set your name and email for your whole git installation, run the following commands. The email will need to be one associated with your GitHub Account.
```bash
git config --global user.name <name>
git config --global user.email <email> 
```

Next, you'll need an ssh key. If you haven't made one, start [here](/topics/GitHub/github_ssh_keys.html).

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

## Signing already made commits
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

If this doesn't work, here's a slightly more involved process:

## A more involved process to sign every commit

CAUTION: The following process rewrites your entire git history, so use it very sparingly.

Also, this assumes that you've configured your account with the steps shown in this lab:

* <https://ucsb-cs156.github.io/s25/lab/jpa05.html>

Also, be sure you are comfortable with `vim` or whatever editor is the one that comes up when git
throws you into the editor, because you are going to need to do a search/replace in a moment.

Run this command

```
git rebase -i --root
```

Now do a global search replace on "pick" to "edit".  Here's what that looks like in vim:

* Press escape
* Press colon (`:`)
* Enter `%s/^pick/edit/g`
  * This changes every occurence of `pick` that occurs at the start of a line to `edit` 
* To save and exit vim: `:wq`

Now, use this command to sign every commit:

```
while true; do
  git commit --amend -S --no-edit || break
  git rebase --continue || break
done
```

This goes in a loop trying to sign commits until finally an error condition is reached.  If it worked, you should see output of many successful signed commits, followed
by an error at the bottom.  Here's an example of correct output (shortened considerably).

```
Stopped at 8ef8b97...  Initial commit
You can amend the commit now, with
  git commit --amend '-S'
Once you are satisfied with your changes, run
  git rebase --continue
[detached HEAD 003e595] Update README.md
 Author: Daniel Jensen <djensen2@outlook.com>
 Date: Tue Apr 1 16:58:30 2025 -0700
 1 file changed, 1 insertion(+), 1 deletion(-)
Successfully rebased and updated refs/heads/main.
[main 003e595] Update README.md
 Author: Daniel Jensen <djensen2@outlook.com>
 Date: Tue Apr 1 16:58:30 2025 -0700
 1 file changed, 1 insertion(+), 1 deletion(-)
fatal: No rebase in progress?
(venv) pconrad@Phillips-MacBook-Air-2 STARTER-jpa05 %
```

At this point, to test whether it worked, run this command:

```
git log --show-signature
```

You should see output like this:

<img width="1069" alt="image" src="https://github.com/user-attachments/assets/850e4996-3b5e-4576-ab04-7be3a09dc8e8" />

You can now force push the main branch:

```
git push origin main -f
```

If the repo doesn't allow force pushes of the main branch, you may need to override those rules temporarily and then restore them.

## Learn More
To learn more, consult these links:

* <https://help.github.com/en/articles/generating-a-new-gpg-key>
* <https://help.github.com/en/articles/adding-a-new-gpg-key-to-your-github-account>
* <https://help.github.com/en/articles/telling-git-about-your-signing-key>
* <https://www.linode.com/docs/security/authentication/gpg-key-for-ssh-authentication/>

## Enabling Signed Commits on a Repo
To enable signed commits on a repo, select "Settings" on the repository. Then, select "Rulesets"
![image](https://github.com/user-attachments/assets/0680ac60-f7b8-4cb3-b7e5-d7bdd90e9745)
Select "New Ruleset"
![image](https://github.com/user-attachments/assets/be3eac7d-7a9f-49e6-95da-8b4b9c6bedab)

For branches, select include all branches
![image](https://github.com/user-attachments/assets/b87a8278-351a-45b7-becb-bbb41379a313)

Then, scroll down and select "Require Signed Commits"

### Excluding the `gh-pages` branch

![image](https://github.com/user-attachments/assets/72d96ddb-ec1e-4ed1-b4d0-4cf6b9216f07)

If your repo uses Github Actions to build the gh-pages branch (as most repos in CMPSC 156 do), then you'll need to exclude
the gh-pages branch from the rule as shown below. This is because while signing commits in a Github Actions script is *possible*, it's not at all straightforward or easy to configure as of March 2025.  (There are proposals to make it easier, and if/when we find a workable solution, we might implement that instead of making the `gh-pages` branch an exception:

<img width="806" alt="image" src="https://github.com/user-attachments/assets/5d2df232-2036-41c1-b38c-1b3ba703c2cb" />


