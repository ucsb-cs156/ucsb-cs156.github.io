---
parent: Dokku
grand_parent: Topics
layout: default
title: "Automatic Deployment Script"
description:  "Deploying to dokku automatically by tagging a PR"
---

# {{page.title}} - {{page.description}}

For proj-frontiers, the team has set up a Github Action so that if you put a dokku link
in any PR description, and then add the special tag `Dokku Deploy`, a Github Action will
run that deploys the branch for that PR on that Dokku Deployment.

In addition, it uses the relevant Github API so that the "Deployment" features of the PR
are invoked; that is, you can scroll down and see the progress and status of the deployment
right in the PR.

## Example Screenshots

TODO

## Maintance of Secrets

The workflow described above depends on certain secrets and scripts and credentials being configured
properly.  If the workflow stops working at some point, it may be that the credentials need to be updated.

* `GOOGLE_SERVICE_ACCOUNT`: A Google Service Account as part of a Google Cloud project is required for the spreadsheet to be automatically updated. The steps for creating one are here: <https://docs.cloud.google.com/iam/docs/service-accounts-create#creating>
The JSON file containing the secrets should then be added to the [ucsb-cs156/workflows](https://github.com/ucsb-cs156/workflows) repository as `GOOGLE_SERVICE_ACCOUNT`. You should be able to simply copy and paste the entire file into the secret. 

## Spreadsheet of Deployments

The proj-frontiers team also maintains a spreadsheet of dokku instances where PRs can be deployed, here (note that there isn't necessarily
public access to this spreadsheet):

* <https://docs.google.com/spreadsheets/d/1-IQJ0kTyenqZFeS1qeUZvD6oKls2WnlYwSts9IwwtHQ/edit?gid=0#gid=0>


