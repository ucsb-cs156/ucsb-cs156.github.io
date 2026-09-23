---
parent: Staff
layout: default
title: "Tools"
description:  "Tools to automate tedious tasks and make the course run more smoothly"
---

# {{page.title}} - {{page.description}}


## TeamFolderCreator

In the repo <https://github.com/ucsb-cs/TeamFolderCreator> you will find the scripts that we use to create the Team Google Drive folders.

This script relies on the Canvas groups being set up as the "source of truth" for which students are on which teams.

You can populate the Canvas groups from Frontiers; there is a backend endpoint `PUSH /api/courses/canvas/teams/push` that can push the teams in Frontiers into Canvas.   (By the time you read this, perhaps there will be a convenient frontend feature to replace having to do this manually through Swagger.)

The script can optionally also add a link to each team's folder to the Bookmarks in the Slack channel.