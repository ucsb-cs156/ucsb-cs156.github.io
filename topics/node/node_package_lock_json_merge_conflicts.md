---
parent: Node
grand_parent: Topics
layout: default
title: "Node: package-lock.json merge conflicts"
description:  "Installing and working with Node, npm, nvm on Linux"
indent: true
category_prefix: "Node: "
---

A merge conflict in package-lock.json is a special case.  It looks like this:

<img width="950" alt="image" src="https://user-images.githubusercontent.com/1119017/154364907-01b9e567-72ab-4745-88c4-0958045c2f92.png">


Here's how you go about resolving it.

1.  Checkout the branch in question.  For example, in this case the branch is: `rh-subjects_menu_page`

    <img width="813" alt="image" src="https://user-images.githubusercontent.com/1119017/154365102-900baf48-b20e-4a90-a961-1e3d24d67566.png">
    
    ```
    pconrad@169-231-112-36 team03-w22-7pm-2 % git checkout rh-subjects_menu_page
    Branch 'rh-subjects_menu_page' set up to track remote branch 'rh-subjects_menu_page' from 'origin'.
    Switched to a new branch 'rh-subjects_menu_page'
    pconrad@169-231-112-36 team03-w22-7pm-2 % 
    ```
    
 2. Make sure the branch is up-to-date with what's on github by pulling from the branch:

    ```
    git pull origin rh-subjects_menu_page
    ```

3.  Next, type the command to rebase your branch on origin main, like this:

    ```
    git pull --rebase origin main
    ```
    
    Heres what that would look like. Note that the `git` command line is telling us the same thing that GitHub did, namely that we have
    a merge conflict in `package.lock.json`
    
    ```
    pconrad@169-231-112-36 team03-w22-7pm-2 % git pull --rebase origin main
    From github.com:ucsb-cs156-w22/team03-w22-7pm-2
     * branch            main       -> FETCH_HEAD
    First, rewinding head to replay your work on top of it...
    Applying: created menu and pages
    Using index info to reconstruct a base tree...
    M	frontend/package-lock.json
    .git/rebase-apply/patch:35850: trailing whitespace.

    warning: 1 line adds whitespace errors.
    Falling back to patching base and 3-way merge...
    Auto-merging frontend/package-lock.json
    CONFLICT (content): Merge conflict in frontend/package-lock.json
    error: Failed to merge in the changes.
    Patch failed at 0001 created menu and pages
    hint: Use 'git am --show-current-patch' to see the failed patch
    Resolve all conflicts manually, mark them as resolved with
    "git add/rm <conflicted_files>", then run "git rebase --continue".
    You can instead skip this commit: run "git rebase --skip".
    To abort and get back to the state before "git rebase", run "git rebase --abort".
    pconrad@169-231-112-36 team03-w22-7pm-2 % 
    ```
4.  Next, type `git status` and you should see that the conflicted files are in red, while the non-conflicted files are in green:

    ```
    pconrad@169-231-112-36 team03-w22-7pm-2 % git status
    rebase in progress; onto da679f5
    You are currently rebasing branch 'rh-subjects_menu_page' on 'da679f5'.
      (fix conflicts and then run "git rebase --continue")
      (use "git rebase --skip" to skip this patch)
      (use "git rebase --abort" to check out the original branch)

    Changes to be committed:
      (use "git restore --staged <file>..." to unstage)
        modified:   frontend/src/App.js
        modified:   frontend/src/main/components/Nav/AppNavbar.js
        modified:   frontend/src/main/pages/Todos/TodosIndexPage.js
        new file:   frontend/src/main/pages/UCSBSubjects/UCSBSubjectsCreatePage.js
        new file:   frontend/src/main/pages/UCSBSubjects/UCSBSubjectsIndexPage.js

    Unmerged paths:
      (use "git restore --staged <file>..." to unstage)
      (use "git add <file>..." to mark resolution)
        both modified:   frontend/package-lock.json

    pconrad@169-231-112-36 team03-w22-7pm-2 % 
    ```
    
5.  Now, let's take stock of what's happening here.

    The file `package-lock.json` is a file that is produced whenever we type `npm install`.  What it represents is the *transitive closure* (yes, in the CS40, CS138 Math 8 discrete math sense of *transitive closure*) of the dependencies that you have listed in `package.json`.  

    For example, if your package.json listed these three dependencies:
    
    ```
    "axios": "^0.21.1",
    "babel-loader": "8.1.0",
    "bootstrap": "^5.0.0-beta3",
    ```
    
    Each of these may depend on something else which in turn depends on something else, and so on, and so on.
    
    The transitive closure is the set of all things that `axios`, `babel-loader` and `bootstrap` depend on, either directly, or transitiveily.  It's computed by continuing to calculate the dependency graph until nothing new is added to the set.
    
    At that point, you have the list of dependencies, *and* you have the specific versions that `npm` went out and found.   
    
    THAT is what is listed in the `package-lock.json`.
    
    So, when you have a merge conflict in `package-lock.json`, rather than trying to resolve it the usual way, which is to go line by line, and try to 
    choose between the `incoming` and `current` change, it is better to just regenerate it from scrtach.
    
    The manual way is to do this:
    
    ```
    cd frontend
    rm package-lock.json
    rm -rf node_modules
    npm install
    ```
    
    Don't be surprised if the `rm -rf node_modules` step takes a good long time, as evidenced by [this cartoon from Reddit](https://www.reddit.com/r/ProgrammerHumor/comments/6s0wov/heaviest_objects_in_the_universe/?utm_source=share&utm_medium=web2x&context=3)
    
    <img src="https://user-images.githubusercontent.com/1119017/154366826-37cb26f0-e040-4661-bbd2-cbab834307fe.png" alt="Heaviest objects in universe, showing sun, black hole, and node_modules as the heaviest." width="800" />

    
6.  At this point, if you type `git status`, you'll see that `package-lock.json` is still marked as "in conflict".  BUT, you've just regenerated a clean
    up-to-date version of the file.  So follow the instructions on the screen, and use `git add package-lock.json` to mark it as resolved:
    
    ```
    pconrad@169-231-112-36 frontend % git status
    rebase in progress; onto da679f5
    You are currently rebasing branch 'rh-subjects_menu_page' on 'da679f5'.
      (fix conflicts and then run "git rebase --continue")
      (use "git rebase --skip" to skip this patch)
      (use "git rebase --abort" to check out the original branch)

    Changes to be committed:
      (use "git restore --staged <file>..." to unstage)
        modified:   src/App.js
        modified:   src/main/components/Nav/AppNavbar.js
        modified:   src/main/pages/Todos/TodosIndexPage.js
        new file:   src/main/pages/UCSBSubjects/UCSBSubjectsCreatePage.js
        new file:   src/main/pages/UCSBSubjects/UCSBSubjectsIndexPage.js

    Unmerged paths:
      (use "git restore --staged <file>..." to unstage)
      (use "git add <file>..." to mark resolution)
        both modified:   package-lock.json
    ```
    
    That looks like this:
    
    ```
    pconrad@169-231-112-36 frontend % git add package-lock.json
    pconrad@169-231-112-36 frontend % git status
    rebase in progress; onto da679f5
    You are currently rebasing branch 'rh-subjects_menu_page' on 'da679f5'.
      (all conflicts fixed: run "git rebase --continue")

    Changes to be committed:
      (use "git restore --staged <file>..." to unstage)
        modified:   package-lock.json
        modified:   src/App.js
        modified:   src/main/components/Nav/AppNavbar.js
        modified:   src/main/pages/Todos/TodosIndexPage.js
        new file:   src/main/pages/UCSBSubjects/UCSBSubjectsCreatePage.js
        new file:   src/main/pages/UCSBSubjects/UCSBSubjectsIndexPage.js

    pconrad@169-231-112-36 frontend %    
    ```

    So now, we again follow the instructions on the screen and type `git rebase --continue`
    
    What happens next will depend on how many commits you have on your branch.  In the case of the branch I used to 
    make these insructions, we got this:
    
    ```
    pconrad@169-231-112-36 frontend % git rebase --continue
    Applying: created menu and pages
    Applying: storybook
    Applying: fixed
    Using index info to reconstruct a base tree...
    M	frontend/package-lock.json
    Falling back to patching base and 3-way merge...
    CONFLICT (modify/delete): frontend/package-lock.json deleted in fixed and modified in HEAD. Version HEAD of frontend/package-lock.json left in tree.
    error: Failed to merge in the changes.
    Patch failed at 0003 fixed
    hint: Use 'git am --show-current-patch' to see the failed patch
    Resolve all conflicts manually, mark them as resolved with
    "git add/rm <conflicted_files>", then run "git rebase --continue".
    You can instead skip this commit: run "git rebase --skip".
    To abort and get back to the state before "git rebase", run "git rebase --abort".
    pconrad@169-231-112-36 frontend % 
    ```
    
    So, here, if we type `git status`, we see: 
    
    ```
    pconrad@169-231-112-36 frontend % git status
    rebase in progress; onto da679f5
    You are currently rebasing branch 'rh-subjects_menu_page' on 'da679f5'.
      (fix conflicts and then run "git rebase --continue")
      (use "git rebase --skip" to skip this patch)
      (use "git rebase --abort" to check out the original branch)

    Unmerged paths:
      (use "git restore --staged <file>..." to unstage)
      (use "git add/rm <file>..." as appropriate to mark resolution)
        deleted by them: package-lock.json

    no changes added to commit (use "git add" and/or "git commit -a")
    pconrad@169-231-112-36 frontend % 
    ```
    
    This is saying that someone deleted `package-lock.json`, and that's no good!  Let's bring it back!  To that we type: `npm install` to recalculated it
    and create a new version of it.  We'll then add that, and type `git rebase --continue` again!
    
    ```
    pconrad@169-231-112-36 frontend % npm install

    up to date, audited 2871 packages in 7s

    321 packages are looking for funding
      run `npm fund` for details

    37 vulnerabilities (22 moderate, 15 high)

    To address issues that do not require attention, run:
      npm audit fix

    To address all issues (including breaking changes), run:
      npm audit fix --force

    Run `npm audit` for details.
    pconrad@169-231-112-36 frontend % git status
    rebase in progress; onto da679f5
    You are currently rebasing branch 'rh-subjects_menu_page' on 'da679f5'.
      (fix conflicts and then run "git rebase --continue")
      (use "git rebase --skip" to skip this patch)
      (use "git rebase --abort" to check out the original branch)

    Unmerged paths:
      (use "git restore --staged <file>..." to unstage)
      (use "git add/rm <file>..." as appropriate to mark resolution)
        deleted by them: package-lock.json

    no changes added to commit (use "git add" and/or "git commit -a")
    pconrad@169-231-112-36 frontend % 
    pconrad@169-231-112-36 frontend %  git add .
    pconrad@169-231-112-36 frontend % git status
    rebase in progress; onto da679f5
    You are currently rebasing branch 'rh-subjects_menu_page' on 'da679f5'.
      (all conflicts fixed: run "git rebase --continue")

    nothing to commit, working tree clean
    pconrad@169-231-112-36 frontend % git rebase --continue
    Applying: fixed
    No changes - did you forget to use 'git add'?
    If there is nothing left to stage, chances are that something else
    already introduced the same changes; you might want to skip this patch.
    Resolve all conflicts manually, mark them as resolved with
    "git add/rm <conflicted_files>", then run "git rebase --continue".
    You can instead skip this commit: run "git rebase --skip".
    To abort and get back to the state before "git rebase", run "git rebase --abort".
    pconrad@169-231-112-36 frontend % 
    ```

 7. So, now we type `git rebase --skip` to go to the next commit.

    And guess what, we have the merge conflict in `package-lock.json` yet again.  It's like the movie Groundhog Day.
    
    But, we just do the same thing again: once again:
    * `rm package-lock.json`
    * `npm install
    * `git add package-lock.json`
    * `git rebase --continue`

    We may have to repeat this several times:
    * sometimes doing `git rebase --continue` 
    * sometimes doing `git rebase --skip`
    
    Until eventually, we get to the point where the rebase is concluded.

    When you see this, do `git rebase --skip`:
    
    ```
    pconrad@169-231-112-36 frontend % git rebase --continue
    Applying: fixed
    No changes - did you forget to use 'git add'?
    If there is nothing left to stage, chances are that something else
    already introduced the same changes; you might want to skip this patch.
    Resolve all conflicts manually, mark them as resolved with
    "git add/rm <conflicted_files>", then run "git rebase --continue".
    You can instead skip this commit: run "git rebase --skip".
    To abort and get back to the state before "git rebase", run "git rebase --abort".
    pconrad@169-231-112-36 frontend %    
    ```
  
    Eventually, when you type either `git rebase --skip` or `git rebase --continue`, you'll get back something that looks clean, like this:
    
    ```
    pconrad@169-231-112-36 frontend % git rebase --skip
    pconrad@169-231-112-36 frontend %
    ```

    Or, it might look like this:
    
    ```
    ❯ git rebase --continue
    [detached HEAD 5b85f9d] fixed
     1 file changed, 447 insertions(+), 1752 deletions(-)
    Successfully rebased and updated refs/heads/rh-subjects_menu_page.
    ```

    In either case, you have an indication that the rebase is successful, and you have resolved all merge conflicts.
    
    Now you are ready for the scariest part of the whole thing.  You are going to a *force push*.
    
8.  In a force push, you are telling GitHub: "I know that you think the branch should be somewhere else.  But I'm telling you I know better!"

    It is potentially a destructive act, because it "rewrites history".  You've "rebased your branch" on the current version of `origin main` which means
    you've clipped off all of your commits, and "replayed them" on top of the new version of main.
    
    And you've resolved the conflicts along the way.
    
    So now, do this:
    
    ```
    git push origin rh-subjects_menu_page -f
    ```
    
    At that point, go to GitHub and look at your pull request again.
    
    It should restart all of the GitHub Actions scripts.  And, the "merge conflict" message should have gone away:

    <img width="971" alt="image" src="https://user-images.githubusercontent.com/1119017/154369300-9238cf1c-10eb-42a7-8c33-0511278a602e.png">

    
