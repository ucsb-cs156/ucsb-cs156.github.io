---
parent: "Github Actions"
grand_parent: Topics
layout: default
title: "Github Actions: Workflow 04"
description:  "Rebuild content of gh-pages branch (part 2)"
wf02: "[`02-gh-pages-rebuild-part-1.yml`](https://ucsb-cs156.github.io/topics/github_actions/workflow_02.html)"
download_artifact: "[`dawidd6/action-download-artifact@v6`](https://github.com/dawidd6/action-download-artifact)"
gh_deploy: "[`JamesIves/github-pages-deploy-action@v4`](https://github.com/JamesIves/github-pages-deploy-action)"
---

# {{page.title}} - {{page.description}}

Workflow `04-gh-pages-rebuild-part-1.yml` is triggered immediately after {{page.wf02}} completes.

The purpose of `04-gh-pages-rebuild-part-2.yml` is to copy the artifacts built by {{page.wf02}} to where they belong on the `gh-pages` branch so that the site can be deployed.

It uses these Github Action frequently:
* {{page.download_artifact}} is used to retrieve files from the key/value store to which they were saved in the steps of {{page.wf02}}.
* {{page.gh_deploy}} is used to copy those files into the gh-pages branch.

## {{page.download_artifact}}

The action {{page.download_artifact}} is used to retrieve the artifacts stored by {{page.wf02}} into the working disk storage of the virtual machine running the Github Action.

Here's an example:

```yml
    - name: a-javadoc Download artifact
      uses: dawidd6/action-download-artifact@v6
      with:
        workflow: 02-gh-pages-rebuild-part-1.yml
        github_token: ${{secrets.GITHUB_TOKEN}}
        name: javadoc
        path: ${{env.javadoc_dest }}
        check_artifacts: true
        if_no_artifact_found: error
```

Here:
* `name` should match the name in {{page.wf02}} under which the artifact was stored
* `path` should match where the contents of the `.zip` file in the artifact should be unzipped and stored in the temporary file storage of the virtual machine running the job.  

## {{page.gh_deploy}}

The action {{page.gh_deploy}} is used to take the unzipped contents from the {{page.download_artifact}} step, and store them somewhere in the `gh-pages` branch
for deployment to the Github Pages site.

Here's an example:

```yml
    - name: a-javadoc Deploy Javadoc (Main) 🚀
      uses: JamesIves/github-pages-deploy-action@v4
      with:
        branch: gh-pages # The branch the action should deploy to.
        folder: ${{ env.javadoc_dest }} # The folder where we put the files
        clean: true # Automatically remove deleted files from the deploy branch
        target-folder: javadoc # The folder that we serve our files from
```

Here: 
* `folder` is the place where the previous step (i.e. the {{page.download_artifact}} step) put the files on the local temporary file system where the workflow is running)
* `target-folder` is where the files should be placed on the `gh-pages` branch.

