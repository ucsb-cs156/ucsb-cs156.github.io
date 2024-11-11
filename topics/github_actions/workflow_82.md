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

Once you have the secret, keep the browser window open, since you'll need this value in the next step,
and once you navigate away from the window, the value is no longer available.

### Step 4: Add Secret `PAT` to Organization Secrets

In a different web browser, navigate to your Organization Secrets, found here:

<img width="321" alt="image" src="https://github.com/user-attachments/assets/2aadc91e-aca6-4233-94e9-59cf6e0001d0">

Or, use this link (editing to replace the organization): 
* <https://github.com/organizations/ucsb-cs156-f24/settings/secrets/actions>

Click <img width="211" alt="New Organization Secret" src="https://github.com/user-attachments/assets/812f9f43-3782-4a5a-8a58-d8769b86959b">, and add the secret with the name 
`PAT`, and the value of the fine grained personal access token from the previous step.

Choose either `All Repositories` or select the repositorires to which this should be applied.


### Step 5: Create a Slack bot user 

To create a slack bot user, start here: <https://api.slack.com/apps/>


| Instructions | Screenshot |
|--------------|------------|
| You'll see this screen.  Click <img width="119" alt="Create New App" src="https://github.com/user-attachments/assets/502347ac-0eb9-457f-a1ee-94ad35918446">. | <img width="862" alt="image" src="https://github.com/user-attachments/assets/99349b5a-e923-4420-b8a4-5747165a310d"> |
| You'll see this modal. Choose "From Scratch" | <img width="420" alt="image" src="https://github.com/user-attachments/assets/ee4cb932-ecc6-4908-96f4-55e450af8080"> |
| For `App Name`, choose something like `Kanban Board Update`, and then select your Slack workspace, and click <img width="93" alt="Create App" src="https://github.com/user-attachments/assets/a6ce6138-1030-45ac-8a05-d68bc8f51f05"> | <img width="405" alt="image" src="https://github.com/user-attachments/assets/37d80fbc-b295-47f5-97e9-796fb53e28ff"> |
| That will take you to this screen. Now you need to look for `OAuth and Permission` in the left navigation| <img width="772" alt="image" src="https://github.com/user-attachments/assets/0b4945f3-c765-4dba-883e-0a834894d211"> } |
| Click on this | <img width="228" alt="image" src="https://github.com/user-attachments/assets/3c945f66-1706-4248-932b-c8009f0cfa3e"> |
| Scroll down to here | <img width="666" alt="image" src="https://github.com/user-attachments/assets/f4f42255-937e-4879-ba10-031de4bfa82d"> |
| Add these scopes: |  <img width="679" alt="image" src="https://github.com/user-attachments/assets/cadb028e-e8a1-4d97-8552-fcaf854f4ee3"> |
| Then scroll back up to `OAuth Tokens` and click the <img width="220" alt="Install" src="https://github.com/user-attachments/assets/584412f5-06fb-46a6-8925-8291114661ab"> button | <img width="650" alt="image" src="https://github.com/user-attachments/assets/4259ebcd-d9e2-438d-9df5-456fc5312d4e"> |
| You'll see a screen like this. Click `Allow` | <img width="593" alt="image" src="https://github.com/user-attachments/assets/08b313ee-c41e-4c8b-b995-dd567f59223e"> |
| You'll then be shown the OAuth Token value (redacted here).  Leave this window open so that you can copy this value in the next step. | <img width="553" alt="image" src="https://github.com/user-attachments/assets/980de542-7e4b-4a38-ab2a-58f22ea0dcde"> |


### Step 6: Copy OAuth token to org secrets as `SLACK_BOT_USER_OAUTH_ACCESS_TOKEN`

In a different web browser, navigate to your Organization Secrets, found here:

<img width="321" alt="image" src="https://github.com/user-attachments/assets/2aadc91e-aca6-4233-94e9-59cf6e0001d0">

Or, use this link (editing to replace the organization): 
* <https://github.com/organizations/ucsb-cs156-f24/settings/secrets/actions>

Click <img width="211" alt="New Organization Secret" src="https://github.com/user-attachments/assets/812f9f43-3782-4a5a-8a58-d8769b86959b">, and add the secret with the name 
`SLACK_BOT_USER_OAUTH_ACCESS_TOKEN`, and the value of the OAuth token from Slack from the previous step.

Choose either `All Repositories` or select the repositorires to which this should be applied.

### Step 7: Update the TEAM_TO_CHANNEL environment variable

Now, you need to collect the Slack Channel Ids of each team channel. For example, if your teams are named `f24-00`, `f24-01`, f24-02`, you need to construct a JSON object that looks like this:

```json
{ "f24-00" : "C08018C6ZUY", "f24-01" : "C07PYJKCWEL", "f24-02" : "C07P9QKLCSW" }
```

To obtain the channel numbers, you can right click on each team channel in Slack, and select `View Channel Details`:

<img width="306" alt="image" src="https://github.com/user-attachments/assets/1622d2d3-129f-40d5-858b-c0c417e2fd7b">

The window that comes up has the channel id as the very bottom, with a widget you can click to copy it.

<img width="565" alt="image" src="https://github.com/user-attachments/assets/a55cbc69-6872-4e1c-bdff-0462fdcc6d5c">

Assemble this JSON object; you'll need it for the next step.

### Step 8: Update the TEAM_TO_CHANNEL environment variable

Under the organization settings, find `Secrets and Variables / Actions`

<img width="298" alt="image" src="https://github.com/user-attachments/assets/1626a75b-a627-46d2-a855-f8522e945a5e">

On the page that comes up, choose the second tab, `Variables`:

Or, use this direct link (changing the organization name as needed):

* <https://github.com/organizations/ucsb-cs156-f24/settings/variables/actions>

Create a new variable called `TEAM_TO_CHANNEL` with the settings from the JSON object you created in the previous step.

### Step 9: Update the ORG_NAME environment variable with your GitHub organization name.

### Step 10: Update the END_DATE environment variable with the end date for the workflow to stop running the workflow forever.

### Step 11: Update the COLUMNS environment variable with the column names in your project board.

### Step 12: Update the branch name in the on section to match the branch you want to trigger the workflow on.

### Step 13: Commit the changes to the main branch to trigger the workflow.

### Step 14. The workflow will run and post the Kanban board status to the Slack channel associated with the team name.
