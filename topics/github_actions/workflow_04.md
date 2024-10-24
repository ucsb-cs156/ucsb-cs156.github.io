---
parent: "Github Actions"
grand_parent: Topics
layout: default
title: "Github Actions: Workflow 04"
description:  "Rebuild content of gh-pages branch (part 2)"
workflow_02: "[`02-gh-pages-rebuild-part-1.yml`]()"
---

# {{page.title}} - {{page.description}}

Workflow `04-gh-pages-rebuild-part-1.yml` is triggered immediately after {{page.wf02}} completes.

The purpose of `04-gh-pages-rebuild-part-2.yml` is to copy the artifacts built by {{page.wf02}} to where they belong on the `gh-pages` branch so that the site can be deployed.

It uses these Github Action frequently:
* [`dawidd6/action-download-artifact@v6`](https://github.com/dawidd6/action-download-artifact) is used to retrieve files from the key/value store to which they were saved in the steps of {{page.wf02}}.
* [`JamesIves/github-pages-deploy-action@v4`](https://github.com/JamesIves/github-pages-deploy-action) is used to copy those files into the gh-pages branch.

