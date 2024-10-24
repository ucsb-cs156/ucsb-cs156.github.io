---
parent: "Github Actions"
grand_parent: Topics
layout: default
title: "Github Actions: Workflow 02"
description:  "Rebuild content of gh-pages branch (part 1)"
---

# {{page.title}} - {{page.description}}

Workflow `02-gh-pages-rebuild-part-1.yml` consists of three parts:

* Preliminaries
* Six jobs that rebuild the gh-pages site for the main branch, and run in parallel
* A matrix of six jobs that rebuild the gh-pages site for each PR, and also run in parallel

## Uploading Artifacts

The workflow [`actions/upload-artifact`](https://github.com/actions/upload-artifact) is used in various places to upload artifacts that are then downloaded and deployed to the
gh-pages branch in the workflow `04-gh-pages-rebuild-part-2.yml`.

Here's an example:



