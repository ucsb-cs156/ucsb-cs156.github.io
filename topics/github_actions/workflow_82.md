---
parent: "Github Actions"
grand_parent: Topics
layout: default
title: "Github Actions: Workflow 82"
description:  "Post Kanban board summary to team slack channel"
reusable_wf82: "[`ucsb-cs156/workflows/.github/workflows/82-kanban-slack-update.yml`](https://github.com/ucsb-cs156/workflows/blob/main/.github/workflows/82-kanban-slack-update.yml)"
wrapper_wf82: "[`STARTER-team02/.github/workflows/82-kanban-slack-update.yml`](https://github.com/ucsb-cs156-f26/STARTER-team02/blob/main/.github/workflows/82-kanban-slack-update.yml)"
---

# {{page.title}} - {{page.description}}

Workflow 82 was originally written by Ahsun Tariq as part of his research into the impact of reflection on Software Engineering Education, with contributions from Phill Conrad.

The purpose of the workflow is to give each team a periodic summary of the state of its Kanban board: a table showing, for each team member, how many issues they have in each column of the board, plus an `UNASSIGNED` row and a `TOTAL` row. The table is posted to the team's Slack channel.

```
| login            | Todo | In P | In R | Done |
|------------------|------|------|------|------|
| cgaucho          |    3 |    1 |    0 |    2 |
| ldelplaya        |    4 |    1 |    1 |    0 |
| UNASSIGNED       |   20 |    0 |    0 |    0 |
|==================|======|======|======|======|
| TOTAL            |   27 |    2 |    1 |    2 |
```

**Note on numbering:** the staff repo `ucsb-cs156-f26/membership-scripts` also has a workflow numbered 82 (`82-standup-stats-bot.yml`, which posts standup *participation* statistics). That is a different workflow; this page is about the Kanban board summary that runs in each team repo.

## Where the code lives (changed in F26)

Until Fall 2026 the whole workflow (about 300 lines of shell and Python) was copied into every starter repo and from there into every team repo, so every fix meant one PR per repo. As of October 2026 it is split in two:

1. **The reusable workflow** {{page.reusable_wf82}} in the `ucsb-cs156/workflows` repository. This holds all of the logic (date check, finding the project, counting issues, building the table, finding the Slack channel, posting). Fixes to the logic are made here, once, and every caller picks them up because they reference it at `@main`.
2. **A thin wrapper** in each starter repo and each team repo, e.g. {{page.wrapper_wf82}}. The wrapper only holds the schedule, a time-of-day check, and the `uses:` line that calls the reusable workflow with the start/end dates and the two secrets. It is about 80 lines, most of which are comments.

The wrapper is copied from the starter into the team repos when they are created. When the wrapper itself changes (for example the schedule), the easiest way to update the team repos is one small PR per repo that replaces just that file; because the file is identical everywhere, those PRs do not conflict with student work.

## How a run works

Each scheduled run of the wrapper does the following (job names are from the two workflow files):

| Job | Where | What it does |
|---|---|---|
| `time-check` | wrapper | Checks the current Pacific time and day of week, and skips the run if this cron firing is not one of the intended local times (see [Schedule and daylight saving time](#schedule-and-daylight-saving-time)). Manual runs skip this check. |
| `check_date` | reusable | Stops if today is outside `START_DATE`..`END_DATE`, if the repo is in the `ucsb-cs156` organization, or if the repo name starts with `STARTER`. |
| `get_team_name` | reusable | The team name is the **last 6 characters of the repository name** (`f26-01` for `team02-f26-01`); the Slack channel is `SLACK_CHANNEL_PREFIX` + team name, by default `team-f26-01`. |
| `get_project_id` | reusable | Finds the GitHub Project (v2) in the organization whose **title equals the repository name** (so the Kanban board for `team02-f26-01` must be titled exactly `team02-f26-01`), discovers the board's columns from the options of its `Status` single-select field, and counts issues per column and assignee. |
| `generate_ascii_table` | reusable | Formats the counts as the table shown above. Column headers are abbreviated to four characters unless that would make two headers identical. |
| `find_slack_channel` | reusable | Looks up the channel id for `team-f26-01` by name through the Slack API (public and private channels; the bot must be a member of private channels). |
| `send-to-slack` | reusable | Posts the table to that channel. |

Consequences of this design that are easy to trip over:

* The project title must match the repo name exactly, and the Slack channel must be named `team-` followed by the last six characters of the repo name. There is no longer a `TEAM_TO_CHANNEL` JSON variable mapping teams to channel ids; the earlier version of this page described one, and it is obsolete.
* Columns are read from the board, so renaming or adding a column needs no code change. Pass the `COLUMNS` input (comma separated) from the wrapper only if you want to report on a subset.

## Setup for a new quarter

### Step 1: Create the two organization secrets

Both secrets live in the **quarter organization** (e.g. `ucsb-cs156-f26`) under *Settings / Secrets and variables / Actions*, so that every team repo can use them:

* <https://github.com/organizations/ucsb-cs156-f26/settings/secrets/actions> (edit the organization name as needed)

<img width="321" alt="Organization secrets" src="https://github.com/user-attachments/assets/2aadc91e-aca6-4233-94e9-59cf6e0001d0">

Choose either `All Repositories` or select the repositories to which each secret should be applied.

**(a) A GitHub personal access token with read access to the organization's Projects.** The reusable workflow documents this as a *classic* personal access token (scope `read:project`; the token owner must be able to see the team projects). Store it under the name that the wrapper passes as the `PAT` secret:

| Starter | Secret name the wrapper passes |
|---|---|
| `STARTER-team01` (F26) | `PAT` |
| `STARTER-team02` (F26) | `CLASSIC_PAT` |

(These should be made consistent; until then, make sure the name used by the wrapper you are installing actually exists as an org secret. Also note that the generated token value is only shown once, so keep that browser tab open until the secret is saved.)

**(b) The Slack bot token**, stored as `SLACK_BOT_USER_OAUTH_ACCESS_TOKEN`. The bot needs the OAuth scopes `channels:read` and `chat:write`; add `groups:read` if any team channels are private. The bot must be added to every team channel it posts to (the `membership-scripts` repo has workflows 61 to 63 for creating channels and adding the bot and users).

If you need to create the Slack app from scratch:

| Instructions | Screenshot |
|--------------|------------|
| Start at <https://api.slack.com/apps/> and click <img width="119" alt="Create New App" src="https://github.com/user-attachments/assets/502347ac-0eb9-457f-a1ee-94ad35918446">. | <img width="862" alt="image" src="https://github.com/user-attachments/assets/99349b5a-e923-4420-b8a4-5747165a310d"> |
| Choose "From Scratch" | <img width="420" alt="image" src="https://github.com/user-attachments/assets/ee4cb932-ecc6-4908-96f4-55e450af8080"> |
| For `App Name`, choose something like `Kanban Board Update`, select your Slack workspace, and click <img width="93" alt="Create App" src="https://github.com/user-attachments/assets/a6ce6138-1030-45ac-8a05-d68bc8f51f05"> | <img width="405" alt="image" src="https://github.com/user-attachments/assets/37d80fbc-b295-47f5-97e9-796fb53e28ff"> |
| Look for `OAuth and Permissions` in the left navigation and click it | <img width="228" alt="image" src="https://github.com/user-attachments/assets/3c945f66-1706-4248-932b-c8009f0cfa3e"> |
| Scroll down to `Scopes` and add the bot token scopes listed above | <img width="679" alt="image" src="https://github.com/user-attachments/assets/cadb028e-e8a1-4d97-8552-fcaf854f4ee3"> |
| Scroll back up to `OAuth Tokens` and click the <img width="220" alt="Install" src="https://github.com/user-attachments/assets/584412f5-06fb-46a6-8925-8291114661ab"> button, then `Allow` | <img width="650" alt="image" src="https://github.com/user-attachments/assets/4259ebcd-d9e2-438d-9df5-456fc5312d4e"> |
| Copy the Bot User OAuth Token (redacted here) into the org secret `SLACK_BOT_USER_OAUTH_ACCESS_TOKEN`. | <img width="553" alt="image" src="https://github.com/user-attachments/assets/980de542-7e4b-4a38-ab2a-58f22ea0dcde"> |

The same bot token is also used by the Slack workflows in `membership-scripts`; one app per workspace is enough.

### Step 2: Set the start and end dates as organization variables

The wrapper passes the dates from **organization variables**, not from constants in the file, so the dates are set once per assignment and never edited in team repos:

| Assignment | Variables |
|---|---|
| team01 | `TEAM01_START_DATE`, `TEAM01_END_DATE` |
| team02 | `TEAM02_START_DATE`, `TEAM02_END_DATE` |
| (later assignments) | same pattern, e.g. `TEAM03_START_DATE`, `TEAM03_END_DATE` |

Format is `YYYY-MM-DD`. Set them under *Settings / Secrets and variables / Actions / Variables* in the quarter organization:

* <https://github.com/organizations/ucsb-cs156-f26/settings/variables/actions>

<img width="298" alt="image" src="https://github.com/user-attachments/assets/1626a75b-a627-46d2-a855-f8522e945a5e">

If either variable is missing or empty, `check_date` stops the run with a message saying so, which is the usual reason the workflow "does nothing" at the start of a quarter.

### Step 3: Make sure the projects and channels are named correctly

* One GitHub Project per team, titled exactly like the repo (`team02-f26-01`), with a single-select `Status` field whose options are the Kanban columns. `membership-scripts` workflow 45 links the projects to the repos.
* One Slack channel per team named `team-` + team (`team-f26-01`), with the bot added.

### Step 4: Have the wrapper in the starter, and let it flow to the team repos

Nothing needs to be edited inside the wrapper for a new quarter as long as the org secret names match. Check that the schedule is what you want (next section), and that the comment at the top names the right variables.

When team repos are created from the starter they get the wrapper. If you change the wrapper afterwards, open one PR per team repo that replaces only `.github/workflows/82-kanban-slack-update.yml` with the starter's copy (a short shell loop over `team02-f26-01` .. `team02-f26-NN` with `gh pr create` does this in a minute).

### Step 5: Test with a manual run

In a team repo, *Actions / 82-kanban-slack-update.yml / Run workflow*. Manual (`workflow_dispatch`) runs skip the time-of-day check but still go through `check_date`, so the org variables must already be set and today must be inside the date range.

## Schedule and daylight saving time

GitHub Actions cron schedules are always in UTC and do not follow daylight saving time, so a single cron entry drifts by an hour twice a year relative to Pacific time. Since October 2026 the wrapper uses the same technique as workflows 81 and 82 in `membership-scripts`:

* Each intended local time is scheduled **twice**, once at the UTC time that is correct during PDT (UTC-7) and once at the time that is correct during PST (UTC-8).
* A first job, `time-check`, converts the current time to `America/Los_Angeles` and lets the run continue only if it falls in a one-hour window starting at an intended local time (and, for class-day-only runs, on the right day of week). The cron for the "other" offset always lands exactly one hour earlier or later, so it is skipped. The window is an hour wide so that a run GitHub delays by a few minutes still counts.

The F26 team02 wrapper targets 4:30 PM Pacific every day plus 7:00 PM Pacific on Tuesday, Wednesday and Thursday:

```yaml
    - cron: "30 23 * * *"       # 4:30 PM PDT (UTC-7), every day
    - cron: "30 0 * * *"        # 4:30 PM PST (UTC-8), every day (next day in UTC)
    - cron: "0 2 * * 3,4,5"     # 7:00 PM PDT (UTC-7), Tue/Wed/Thu (next day in UTC)
    - cron: "0 3 * * 3,4,5"     # 7:00 PM PST (UTC-8), Tue/Wed/Thu (next day in UTC)
```

To change the times, update the cron entries **and** the windows in the `time-check` job together (the target minutes and the day-of-week test). Remember that for evening Pacific times the UTC day is already the next day, so Tue/Wed/Thu Pacific is `3,4,5` in the cron.

The skipped runs still appear in the Actions tab (with the reusable-workflow job shown as skipped), which is expected.

## Why does this not run on STARTER repos or legacy repos?

The reusable workflow's `check_date` job contains:

```yml
if [[ "$OWNER" == "ucsb-cs156" ]]; then
  echo "This workflow should not run on repos in the ucsb-cs156 organization"
  echo "continue=false" >> "$GITHUB_OUTPUT"
fi
if [[ "$REPOSITORY" == STARTER* ]]; then
  echo "This workflow should not run on STARTER repos"
  echo "continue=false" >> "$GITHUB_OUTPUT"
fi
```

Some background: the legacy code projects are maintained in what we call "legacy repos" in the `ucsb-cs156` organization, for example <https://github.com/ucsb-cs156/proj-courses> and <https://github.com/ucsb-cs156/proj-dining>. (We avoid "main repo" or "master repo" because those get confused with the main or master *branch*.) Those, and the `STARTER-*` repos in the quarter organization, are the starting point for team repos such as `ucsb-cs156-f26/team02-f26-01`. The same wrapper file exists in all of them, but in the legacy and STARTER repos there is no team, no project titled like the repo, and no Slack channel, so the date check also refuses to run there. Along with the date range, this keeps the workflow from wasting Actions minutes where it cannot do anything useful.

## Troubleshooting

| Symptom in the run log | Cause |
|---|---|
| `Not one of the target Pacific times. Skipping execution.` | Normal: this was the cron firing for the other UTC offset. |
| `START_DATE ('') or END_DATE ('') is empty. Stopping workflow.` | The `TEAMxx_START_DATE` / `TEAMxx_END_DATE` org variables are not set, or the wrapper names the wrong ones. |
| `This workflow should not run on STARTER repos` | Expected on the starter; it only runs in team repos. |
| `No project titled 'team02-f26-01' found in org` | The Kanban board's title does not exactly match the repo name, or the PAT cannot see the org's projects. |
| `No columns found. Check that the project has a single-select field named 'Status'` | The board's status field was renamed; pass `STATUS_FIELD` from the wrapper. |
| `No Slack channel named 'team-f26-01' found` | Channel is missing or named differently, or the bot is not in it (for private channels, the bot needs `groups:read` and membership). |
| `Error reading JToken from JsonReader` | You are looking at a pre-F26 copy of the old self-contained workflow that still reads the obsolete `TEAM_TO_CHANNEL` variable; replace it with the wrapper. |

## Known inconsistencies and future direction

* As of October 2026 the `STARTER-team01` wrapper (and the sixteen `team01-f26-NN` repos) still have the PST-only crons and pass the secret as `PAT`, while `STARTER-team02` has the DST-aware schedule and passes `CLASSIC_PAT`. The team01 copies are only harmless because `TEAM01_END_DATE` has passed; align them before team01 runs again.
* The header comment of the reusable workflow still shows the old PST-only crons as its example invocation.
* Each scheduled firing starts a separate workflow run in every team repo (seven jobs each, half of the firings skipped by `time-check`). Since all the logic is now in one place anyway, the natural next step is to run the summary **once**, centrally, from `membership-scripts`, iterating over the team repos and channels the way workflows 81 and 82 there already do, and to drop the per-repo wrapper. That would remove the per-repo PR step from this page entirely.
* The legacy code project is a further reason to centralize: there the teams start from several different repos (`ucsb-cs156/proj-courses`, `proj-dining`, `proj-frontiers`, `proj-happycows`, `proj-rec`, ...) rather than one starter, so keeping a wrapper in sync across all of them is more work than for team01/team02. A central job does not need the wrapper at all; it only needs to find each team's board, which it can do either from the naming scheme (repo `proj-courses-f26-01` and project titled `proj-courses-f26-01`) or from the project numbers that the course website already records per team in `_config.yml` of the term repo (`team01_project`, `team02_project`, `legacy_kanban` under `teams:` in <https://github.com/ucsb-cs156/f26/blob/main/_config.yml>, a public file).
