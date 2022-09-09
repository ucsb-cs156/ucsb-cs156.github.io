---
parent: Git
grand_parent: Topics
layout: default
title: "git: copy branch to new repo"
description:  "Creating a new repo with a branch from another repo"
indent: true
---

Thanks for Chris Hundhausen for writing this up.  Additional notes added by P. Conrad

# Copying a Branch from a Repo to a Branch in Another Repo

Sometimes, you might want to establish a new repository whose main branch points to a copy of a branch (“desired-branch”) 
from another repository (the “source” repository). 

This is different from simply cloning the source repository because you want to copy one particular branch from the original 
repository, not the entire repository. Here is one approach to getting this done.


	
1. Create the new repository on GitHub:

2. Clone the new repo to your local machine:


   ```
   $ git clone https://github.com/wsu-cpts489-fa20/my-new-repo.git
   ```

3. Establish a main branch in your new repo:

   ```
   $ git checkout -b main
   ```

4. Establish the source repo as a remote for the new repo:

   ```
   $ git remote add sourcerepo https://wsu-cpts4890-fa20/my-source-repo.git
   ```
   
5. Fetch the target branch from the source repo that you want to establish as the main branch in your new repo:

   ```
   $ git fetch sourcerepo
   remote: Enumerating objects: 282, done.
   remote: Counting objects: 100% (282/282), done.
   remote: Compressing objects: 100% (93/93), done.
   remote: Total 282 (delta 183), reused 282 (delta 183), pack-reused 0
   Receiving objects: 100% (282/282), 319.52 KiB | 1.06 MiB/s, done.
   Resolving deltas: 100% (183/183), done.
   From https://github.com/wsu-cpts489-fa20/my-source-repo
   * [new branch]      desiredBranch -> sourcerepo/desiredBranch
   * [new branch]      master           -> sourcerepo/master
   ```

   Notes:
   * The local repo has a set of branches (pointers to commits). It also keeps a cached of the current values of 
     the branch pointers in each of the remotes (including `origin`, the repo from which it was cloned.).
   * A `git fetch` command updates the cached values of these pointers (by default, for the `origin` remote).
   * A `git fetch sourcrepo` updates the cached values of these pointers specifically from the `sourcerepo` remote.

6. Reset the main branch of the new repo to point to the `desiredBranch` branch from the source repo:

   ```
   $ git reset --hard sourcerepo/desiredBranch
   HEAD is now at 56316c6 desiredBranch
   ```

   Notes:
   * The `git reset` command is like a pointer assignment for the current branch.  Recall that a git *branch* is nothing 
     more than a *pointer to a commit*.  The `git reset` command assigns that pointer (the current branch) to wherever the
     argument of the `git reset` command points.  
   * So if the current branch is `main` then `git reset --hard sourcerepo/desiredBranch` would be like a pointer assignment:
     ```
     main = sourceRepo.desiredBranch;
     ```
   * The `--hard` means that we also want to update the file system.  This causes the  directory of the local repo to be populated
     with the files from `sourceRepo/desiredBranch`
   * The alternative is `--soft` which updates the pointers, but leaves the file system untouched.
   
7. Finally, push the new repo’s local repository to its remote repository to complete the process:

   ```
   $ git push origin main
   Enumerating objects: 56, done.
   Counting objects: 100% (56/56), done.
   Delta compression using up to 16 threads
   Compressing objects: 100% (38/38), done.
   Writing objects: 100% (56/56), 203.19 KiB | 101.59 MiB/s, done.
   Total 56 (delta 17), reused 46 (delta 16), pack-reused 0
   remote: Resolving deltas: 100% (17/17), done.
   To https://github.com/wsu-cpts489-fa20/my-new-repo.git
   * [new branch]      main -> main
   ```

8. If you go to `my-new-repo` on GitHub, you should now see that its main branch points to a copy of the `desiredBranch` in `my-source-repo`.

