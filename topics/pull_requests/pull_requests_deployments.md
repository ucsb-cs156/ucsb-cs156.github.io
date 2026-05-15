---
parent: Pull Requests
grand_parent: Topics
layout: default
title: "Pull Requests: Deployments"
description:  "Link your PRs to a deployment"
---

# {{page.title}} - {{page.description}}


When you submit a PR that could change the functionality of the application, it is necessary to deploy it to one of your dev deployments and then include a link to that deployment. For example:

> Deployed on https://courses-dev-cgaucho.dokku-xx.cs.ucsb.edu


Note that only one branch can be deployed to a given deployment at any time!  So once you have an open PR on your dev deployment, you need to leave that dev deployment alone until that PR gets merged.  You can create additional  deployments as needed if you have multiple open PRs.  One good strategy is to have a series of qa deployments shared by the team such as:

* <https://courses-qa01.dokku-xx.cs.ucsb.edu>
* <https://courses-qa02.dokku-xx.cs.ucsb.edu>
* <https://courses-qa03.dokku-xx.cs.ucsb.edu>
* etc ...

You may find it helpful to keep a Google Drive spreadsheet in your team folder showing what 
PR each of these is linked to.  When a PR is closed, you can reuse that qa deployment for another PR.     

The number of these that you need will depend on the maximum number of PRs you have at any given time.
