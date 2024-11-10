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



 Go to the settings for the organization, and navigate to `Personal Access Tokens / Settings` 
 
 <img width="318" alt="image" src="https://github.com/user-attachments/assets/00a40d78-b76e-4999-8340-11858d22c3ba"> |

You can also use this link (editing the organization as needed):
* <https://github.com/organizations/ucsb-cs156-f24/settings/personal-access-tokens-onboarding>

### Step 3: Create a fine-grained Personal Access Token (`PAT`)

Create a fine grained personal access token for the organization.

Under organizations, it should have read-only permission on projects.

### Step 4: Add Secret `PAT` to Organization Secrets

### Step 5: Create a Slack bot user 

To create a slack bot user, start here: <https://api.slack.com/apps/>


| Instructions | Screenshot |
|--------------|------------|
| You'll see this screen.  Click <img width="119" alt="Create New App" src="https://github.com/user-attachments/assets/502347ac-0eb9-457f-a1ee-94ad35918446">. | <img width="862" alt="image" src="https://github.com/user-attachments/assets/99349b5a-e923-4420-b8a4-5747165a310d"> |
| You'll see this modal. Choose "From Scratch" | <img width="420" alt="image" src="https://github.com/user-attachments/assets/ee4cb932-ecc6-4908-96f4-55e450af8080"> |
| For `App Name`, choose something like `Kanban Board Update`, and then select your Slack workspace, and click <img width="93" alt="Create App" src="https://github.com/user-attachments/assets/a6ce6138-1030-45ac-8a05-d68bc8f51f05"> | <img width="405" alt="image" src="https://github.com/user-attachments/assets/37d80fbc-b295-47f5-97e9-796fb53e28ff"> |
| That will take you to this screen. You'll then need to scroll down to the heading `App Level Tokens` | <img width="772" alt="image" src="https://github.com/user-attachments/assets/0b4945f3-c765-4dba-883e-0a834894d211"> } |
| This is the section you want. Click <img width="178" alt="Generate Token and Scopes" src="https://github.com/user-attachments/assets/3c7af6b2-f6b6-40d4-a1f6-1569d81e21f5">
 | <img width="554" alt="image" src="https://github.com/user-attachments/assets/0866ac98-47a4-46a8-89f2-a10aa92cbbe3"> |








### Step 6: Add the OAuth access token in the organization secrets with the name SLACK_BOT_USER_OAUTH_ACCESS_TOKEN.

### Step 7: Update the TEAM_TO_CHANNEL environment variable with the mapping of team names to Slack channel IDs.

### Step 8: Update the ORG_NAME environment variable with your GitHub organization name.

### Step 9: Update the END_DATE environment variable with the end date for the workflow to stop running the workflow forever.

### Step 10: Update the COLUMNS environment variable with the column names in your project board.

### Step 11: Update the branch name in the on section to match the branch you want to trigger the workflow on.

### Step 12: Commit the changes to the main branch to trigger the workflow.

### Step 13. The workflow will run and post the Kanban board status to the Slack channel associated with the team name.
