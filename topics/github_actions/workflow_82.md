---
parent: "Github Actions"
grand_parent: Topics
layout: default
title: "Github Actions: Workflow 82"
description:  "Post Kanban board summary to team slack channels"
central_wf82: "[`membership-scripts/.github/workflows/82-kanban-slack-update.yml`](https://github.com/ucsb-cs156-f26/membership-scripts/blob/main/.github/workflows/82-kanban-slack-update.yml)"
central_py: "[`membership-scripts/kanban_slack_update.py`](https://github.com/ucsb-cs156-f26/membership-scripts/blob/main/kanban_slack_update.py)"
---

# {{page.title}} - {{page.description}}

Workflow 82 was originally written by Ahsun Tariq as part of his research into the impact of reflection on Software Engineering Education, with contributions from Phill Conrad.

The purpose of the workflow is to give each team a periodic summary of the state of its Kanban board: a table showing, for each team member, how many issues they have in each column of the board, plus an `UNASSIGNED` row and a `TOTAL` row. The table is posted to the team's Slack channel.

```
📋 *Kanban Board Status* ✔️ (team02-f26-01)
| login            | Back | Read | In p | In r | Done |
|------------------|------|------|------|------|------|
| cgaucho          |    8 |    0 |    1 |    0 |    0 |
| ldelplaya        |    9 |    0 |    0 |    0 |    0 |
| UNASSIGNED       |    0 |    6 |    0 |    0 |    0 |
|==================|======|======|======|======|======|
| TOTAL            |   17 |    6 |    1 |    0 |    0 |
```

## Where the code lives (changed October 2026)

From Fall 2024 to Fall 2026 this workflow lived **in every team repo**: first as a 300-line self-contained copy, then (October 2026) as a thin wrapper calling a reusable workflow in `ucsb-cs156/workflows`. Both versions had the same problem: every change meant one pull request per team repo, the copies drifted between assignments (team01 and team02 ended up with different schedules and different secret names), each scheduled firing started seven jobs in each of fifteen or sixteen repos, and the legacy code project, whose teams start from several different repos, would have needed the file kept in sync across all of them.

Since October 2026 the summary runs **once, centrally**, from the term's staff repo:

* {{page.central_wf82}}: the schedule, the daylight-saving-time check, and a single step that runs the script.
* {{page.central_py}}: all of the logic. One run handles every team of every assignment whose date window is open.

Team repos no longer contain a workflow 82 at all. If you still see `.github/workflows/82-kanban-slack-update.yml` in a starter or team repo, it is a leftover and can be deleted (the reusable workflow it calls is marked superseded and will be removed after one quarter).

The number 82 is kept for the Kanban summary because every starter since F24 has used it. The standup *participation* statistics bot in `membership-scripts`, which briefly also used 82, is now workflow 83.

## How a run works

1. **Time check.** GitHub cron only speaks UTC, so each intended Pacific time is scheduled twice (see [Schedule and daylight saving time](#schedule-and-daylight-saving-time)); a first step converts "now" to `America/Los_Angeles` and skips the run that is not at an intended local time. Manual runs skip this step.
2. **Which assignments are active.** For each assignment in `KANBAN_ASSIGNMENTS` (default `team01,team02,legacy`) the script reads the organization variables `<ASSIGNMENT>_START_DATE` and `<ASSIGNMENT>_END_DATE` (`TEAM02_START_DATE`, `LEGACY_END_DATE`, ...). An assignment is processed only if today (Pacific) is inside its window; missing variables are reported and the assignment skipped.
3. **Which repos.** Team repos are found by name in the quarter organization: `team01-f26-NN`, `team02-f26-NN`, or `proj-<anything>-f26-NN` for `legacy`. The quarter code (`f26`) comes from the organization name. The **team code is the last six characters** of the repo name (`f26-01`).
4. **Which board.** The team's Kanban board is the organization project **titled exactly like the repo** (`team02-f26-01`). If no project has that title, the script falls back to the project number recorded for the team in the public term website config, `https://github.com/ucsb-cs156/f26/blob/main/_config.yml`, under `teams:` (`team01_project`, `team02_project`, `legacy_kanban`), so a board with a different title still works as long as its number is filled in there.
5. **Columns and counts.** The columns are the options of the board's `Status` single-select field, in board order, so renaming or adding a column needs no change here. Every item on the board is counted once per assignee (or once as `UNASSIGNED`) under its current column.
6. **Which channel.** The Slack channel is `team-` + team code (`team-f26-01`). The channel list is fetched once per run (public and private channels; private ones need the bot to have `groups:read` and to be a member).
7. **Post, and report.** Each team is processed independently, so one team's problem does not stop the others. The run writes a table of per-team results to the job summary (visible on the run's page in the Actions tab) and ends with a failure if any team failed, so a red X means "look at the summary", not "nothing was posted".

## Setup for a new quarter

Everything is configured in the quarter organization (for example `ucsb-cs156-f26`) and in its `membership-scripts` repo; nothing is edited in team repos.

### Step 1: Two secrets, visible to `membership-scripts`

Set these as organization secrets (*Settings / Secrets and variables / Actions* in the organization, <https://github.com/organizations/ucsb-cs156-f26/settings/secrets/actions> with the organization name changed as needed) with a repository access policy that includes `membership-scripts`, or as repository secrets of `membership-scripts`. Both are already needed by the other `membership-scripts` workflows, so they usually exist.

<img width="321" alt="Organization secrets" src="https://github.com/user-attachments/assets/2aadc91e-aca6-4233-94e9-59cf6e0001d0">

**(a) `CLASSIC_PAT`**: a *classic* GitHub personal access token with the `read:project` scope, owned by someone who can see the organization's repositories and projects. (The script lists repos and reads projects through the GraphQL API; `read:project` is the scope that grants Projects v2 read access.) The token value is shown only once, so paste it into the secret before leaving the page.

**(b) `SLACK_BOT_USER_OAUTH_ACCESS_TOKEN`**: the Slack bot token. The bot needs the scopes `channels:read` and `chat:write`, plus `groups:read` if any team channel is private, and **it must be a member of every `team-*` channel**. The `membership-scripts` workflows 61 to 63 create the channels and add the bot and the students.

If you need to create the Slack app from scratch:

| Instructions | Screenshot |
|--------------|------------|
| Start at <https://api.slack.com/apps/> and click <img width="119" alt="Create New App" src="https://github.com/user-attachments/assets/502347ac-0eb9-457f-a1ee-94ad35918446">. | <img width="862" alt="image" src="https://github.com/user-attachments/assets/99349b5a-e923-4420-b8a4-5747165a310d"> |
| Choose "From Scratch" | <img width="420" alt="image" src="https://github.com/user-attachments/assets/ee4cb932-ecc6-4908-96f4-55e450af8080"> |
| For `App Name`, choose something like `Kanban Board Update`, select your Slack workspace, and click <img width="93" alt="Create App" src="https://github.com/user-attachments/assets/a6ce6138-1030-45ac-8a05-d68bc8f51f05"> | <img width="405" alt="image" src="https://github.com/user-attachments/assets/37d80fbc-b295-47f5-97e9-796fb53e28ff"> |
| Look for `OAuth and Permissions` in the left navigation and click it | <img width="228" alt="image" src="https://github.com/user-attachments/assets/3c945f66-1706-4248-932b-c8009f0cfa3e"> |
| Scroll down to `Scopes` and add the bot token scopes listed above | <img width="679" alt="image" src="https://github.com/user-attachments/assets/cadb028e-e8a1-4d97-8552-fcaf854f4ee3"> |
| Scroll back up to `OAuth Tokens` and click the <img width="220" alt="Install" src="https://github.com/user-attachments/assets/584412f5-06fb-46a6-8925-8291114661ab"> button, then `Allow` | <img width="650" alt="image" src="https://github.com/user-attachments/assets/4259ebcd-d9e2-438d-9df5-456fc5312d4e"> |
| Copy the Bot User OAuth Token (redacted here) into the secret `SLACK_BOT_USER_OAUTH_ACCESS_TOKEN`. | <img width="553" alt="image" src="https://github.com/user-attachments/assets/980de542-7e4b-4a38-ab2a-58f22ea0dcde"> |

### Step 2: Date windows as organization variables

Under *Settings / Secrets and variables / Actions / Variables* in the organization (<https://github.com/organizations/ucsb-cs156-f26/settings/variables/actions>), create, in `YYYY-MM-DD` form:

| Assignment | Variables |
|---|---|
| team01 | `TEAM01_START_DATE`, `TEAM01_END_DATE` |
| team02 | `TEAM02_START_DATE`, `TEAM02_END_DATE` |
| legacy code project | `LEGACY_START_DATE`, `LEGACY_END_DATE` |

<img width="298" alt="image" src="https://github.com/user-attachments/assets/1626a75b-a627-46d2-a855-f8522e945a5e">

**Make sure each variable's repository access includes `membership-scripts`.** Organization variables are only visible to the repositories you select; variables created earlier for the team repos may not include the staff repo, and then the script will report `TEAM02_START_DATE / TEAM02_END_DATE not set` and skip that assignment.

Optional repository variables on `membership-scripts`: `SLACK_CHANNEL_PREFIX` (default `team-`) and `KANBAN_STATUS_FIELD` (default `Status`).

### Step 3: Boards and channels named so they can be found

* One GitHub Project per team, **titled exactly like the repo** (`team02-f26-01`), with a single-select `Status` field whose options are the Kanban columns. (`membership-scripts` workflow 45 links the projects to the repos.) If a board must have a different title, record its project number in the term website's `_config.yml` under the team's `team01_project` / `team02_project` / `legacy_kanban` entry; the script uses that as a fallback.
* One Slack channel per team named `team-` + team code (`team-f26-01`), with the bot added.

### Step 4: Check the schedule

The schedule in the workflow file is 4:30 PM Pacific every day plus 7:00 PM Pacific on Tuesday, Wednesday and Thursday. Change it as described in the next section if the class meets at other times.

### Step 5: Dry run, then a real run

In `membership-scripts`, *Actions / 82 - Kanban Slack Update / Run workflow*:

1. First with **dry_run** checked and **team_filter** set to a couple of teams (for example `f26-0[1-3]`). The log shows, for each team, which project was used and how it was found (`by title` or `_config.yml team02_project=22`), the columns, and the table that would be posted; the job summary lists every team as `ok` or `FAILED` with a reason. Nothing is posted.
2. Then without dry_run. Check one team channel.

Scheduled runs then take care of themselves within the date windows.

## Schedule and daylight saving time

GitHub Actions cron schedules are always UTC and do not follow daylight saving time, so a single cron entry drifts by an hour twice a year relative to Pacific time. The workflow uses the same technique as `membership-scripts` workflow 81:

* Each intended local time is scheduled **twice**, once at the UTC time that is correct during PDT (UTC-7) and once at the time that is correct during PST (UTC-8).
* The first step converts the current time to `America/Los_Angeles` and lets the run continue only if it falls in a one-hour window starting at an intended local time (and, for class-day-only runs, on the right day of week). The cron for the "other" offset always lands exactly one hour earlier or later, so it is skipped. The window is an hour wide so that a run GitHub delays by a few minutes still counts.

```yaml
    - cron: "30 23 * * *"       # 4:30 PM PDT (UTC-7), every day
    - cron: "30 0 * * *"        # 4:30 PM PST (UTC-8), every day (next day in UTC)
    - cron: "0 2 * * 3,4,5"     # 7:00 PM PDT (UTC-7), Tue/Wed/Thu (next day in UTC)
    - cron: "0 3 * * 3,4,5"     # 7:00 PM PST (UTC-8), Tue/Wed/Thu (next day in UTC)
```

To change the times, update the cron entries **and** the windows in the time-check step together (the target minutes and the day-of-week test). For evening Pacific times the UTC day is already the next day, so Tue/Wed/Thu Pacific is `3,4,5` in the cron. The skipped firings still appear in the Actions tab with the remaining steps skipped; that is expected.

## Troubleshooting

The job summary (bottom of the run page) is the first place to look; it has one line per team. Messages you may see in it or in the log:

| Message | Cause and fix |
|---|---|
| `Not one of the target Pacific times. Skipping.` | Normal: this firing was the cron for the other UTC offset. |
| `[team02] skipped: TEAM02_START_DATE / TEAM02_END_DATE not set` | The org variables do not exist, or their repository access does not include `membership-scripts`. |
| `[team02] skipped: today ... is after END_DATE ...` | The window has closed; extend `TEAM02_END_DATE` if the assignment was extended. |
| `[legacy] repos matching ^proj-[a-z0-9]+-f26-\d\d$ ...: 0` | No legacy team repos exist yet, or they are named differently. |
| `no project titled 'team02-f26-01' in ucsb-cs156-f26, and no usable team02_project for team f26-01 in _config.yml` | The board's title does not match the repo and the project number in `_config.yml` is still `tbd`; rename the board or fill in the number. If the title does match, `CLASSIC_PAT` may lack `read:project` or may not be able to see the organization. |
| `project #22 'team02-f26-01' has no single-select field named 'Status'` | The board's status field was renamed; set the repository variable `KANBAN_STATUS_FIELD`. |
| `no Slack channel named 'team-f26-01' (channels containing 'f26-01': [...])` | Channel missing or named differently, or the bot is not in it (private channels also need `groups:read`). |
| `posting to #team-f26-01 failed: not_in_channel` | Add the bot to the channel (workflow 63a or `/invite`). |
| `SLACK_BOT_USER_OAUTH_ACCESS_TOKEN is not set` | The secret is missing or not visible to `membership-scripts`. |
| `Query failed: 401` | `CLASSIC_PAT` is missing, expired, or not visible to `membership-scripts`. |
| Run is red but most teams show `ok` | By design: any failed team makes the run fail so it is noticed. Fix the listed teams; the others were posted. |

To reproduce a run on your own machine (read-only, nothing is posted):

```
cd membership-scripts
python3 -m venv venv && source venv/bin/activate && pip install requests slack_sdk pyyaml
ORG_NAME=ucsb-cs156-f26 GITHUB_TOKEN=$(gh auth token) DRY_RUN=true \
  TEAM02_START_DATE=2026-10-01 TEAM02_END_DATE=2026-12-31 TEAM_FILTER='f26-0[1-3]' \
  python3 kanban_slack_update.py
```

## History

* F24 (Ahsun Tariq, Phill Conrad): self-contained workflow copied into every team repo; Slack channels looked up through a hand-maintained `TEAM_TO_CHANNEL` JSON variable of channel ids; dates, org name and columns edited as constants in each copy.
* October 2026: logic moved to a reusable workflow in `ucsb-cs156/workflows`; dates moved to organization variables; channels found by name; columns discovered from the board. Team repos kept a thin wrapper.
* Late October 2026: moved to one central run in `membership-scripts` (this page). Wrappers removed from the starters and team repos; the reusable workflow marked superseded.
