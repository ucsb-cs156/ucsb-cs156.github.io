---
parent: "Github Actions"
grand_parent: Topics
layout: default
title: "Github Actions: Workflow 82"
description:  "Post Kanban board summary to team slack channel"
wf82: "[`82-kanban-slack-update.yml`](https://github.com/ucsb-cs156-f24/team02-f24-00/blob/main/.github/workflows/82-kanban-slack-update.yml)"
---

# {{page.title}} - {{page.description}}

The workflow {{page.wf82}} was written by Ahsun Tariq as part of his research into the impact of reflection on Software Engineering Education.  Phill Conrad also made
contributions.

The purpose of the workflow is to provide the team with a summary of the state of the Kanban board at periodic intervals, showing the number of issues each team member has
in the various columns of the Kanban board.

## Installation

To install this in your project, you need to take several steps.

### Step 1: Copy workflow

Copy the workflow file into your repo, in the `.github/workflows` directory.

### Step 2: Configure Org to allow fine-grained personal access tokens

Go to the settings for the organization, and navigate to `Personal Access Tokens / Settings`:

<img width="318" alt="image" src="https://github.com/user-attachments/assets/00a40d78-b76e-4999-8340-11858d22c3ba">

You can also use this link (editing the organization as needed):
* <https://github.com/organizations/ucsb-cs156-f24/settings/personal-access-tokens-onboarding>

### Step 3: Create a fine-grained Personal Access Token (`PAT`)

Create a fine grained personal access token for the organization.

Under organizations, it should have read-only permission on projects.

### Step 4: Add Secret `PAT` to Organization Secrets

### Step 5: Create a Slack bot user 

### Step 6: Add the OAuth access token in the organization secrets with the name SLACK_BOT_USER_OAUTH_ACCESS_TOKEN.

### Step 7: Update the TEAM_TO_CHANNEL environment variable with the mapping of team names to Slack channel IDs.

### Step 8: Update the ORG_NAME environment variable with your GitHub organization name.

### Step 9: Update the END_DATE environment variable with the end date for the workflow to stop running the workflow forever.

### Step 10: Update the COLUMNS environment variable with the column names in your project board.

### Step 11: Update the branch name in the on section to match the branch you want to trigger the workflow on.

### Step 12: Commit the changes to the main branch to trigger the workflow.

### Step 13. The workflow will run and post the Kanban board status to the Slack channel associated with the team name.
