---
parent: Topics
layout: default
title: "Codecov: Transfering Repos "
description:  "Steps to take When transferring repos from one owner/org to another"
category_prefix: "Codecov: "
indent: true
---

In CS156, we have had the practice of transferring the project repos for legacy code projects from one course org to another, e.g
* from <https://github.com/ucsb-cs156-f20> to <https://github.com/ucsb-cs156-w21>
* from <https://github.com/ucsb-cs156-w21> to <https://github.com/ucsb-cs156-s21>
* etc.

When this happens, codecov loses its context; i.e. there is no 'baseline' for calculating the difference in code coverage for subsequent PRs.

This causes symptoms such as these:

* The badge reports an "unknown" status: <img width="196" alt="image" src="https://user-images.githubusercontent.com/1119017/116011385-9454be00-a5d9-11eb-8da6-eecf391ee1b5.png">
* CI/CD runs get stuck at the yellow dot like this: <img width="875" alt="image" src="https://user-images.githubusercontent.com/1119017/116011350-653e4c80-a5d9-11eb-834e-0277699293d5.png">

To remedy this, you can make a "dummy" commit, PR, and merge to establish the baseline, by taking these steps:

1. Checkout a fresh copy of the `main` branch:
   ```
   git fetch
   git checkout main
   git pull origin main
   ```
2. Create a new branch
   ```
   git checkout -b pc-dummyPRToEstablishCodeCovBaseline
   ```
3. Make a dummy commit and push this to the branch
   ```
   git commit --allow-empty -m "pc - dummy commit, PR, and merge to establish baseline for codecov"
   git push origin pc-dummyPRToEstablishCodeCovBaseline
   ```
4. Open a PR for this branch.  Here's a sample description:

   * Title: `pc - dummy commit, PR, and merge to establish baseline for codecov`
   * Description: 
     ```
     After moving a repo between owners (e.g. from one org to another) codecov can show some anomalies:
     * the coverage badge shows "unknown", like this: <img width="196" alt="image" src="https://user-images.githubusercontent.com/1119017/116011385-9454be00-a5d9-11eb-8da6-eecf391ee1b5.png">
     * the CI/CD pipeline for Codecov can get stuck, perseverating on the yellow dot, like this: <img width="875" alt="image" src="https://user-images.githubusercontent.com/1119017/116011350-653e4c80-a5d9-11eb-834e-0277699293d5.png">

     The fix is a PR such as this one.

     This PR contains no code changes; it contains only an empty commit.  When merged into main, it will establish a new baseline on codecov so that:

     * the CI/CD pipeline for codecov gets unstuck for pending PRs
     * the badge for the new repo shows the correct coverage.
     ```

 5. Merge the PR
 6. Then, check the badge and the CI/CD runs.  Note that you might also need to take these additional steps:
    - Getting a new `CODECOV_TOKEN` for the repo and updating the Secret on the GitHub settings for the repo.  
      
      To obtain this token, visit: <https://app.codecov.io/gh/org-name/repo-name/settings/general> (substituting in the values of `org-name` and `repo-name`). 
    
    - Getting the new Markdown for the badge from Codecov (it is not longer a matter of just updating the markdown, since codecov now also has a token built into the markdown.)   

      To obtain this markdown, visit <https://app.codecov.io/gh/org-name/repo-name/settings/badge> (substituting in the values of `org-name` and `repo-name`). 
    
    
