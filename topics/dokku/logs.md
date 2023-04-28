---
parent: Dokku
grand_parent: Topics
layout: default
title: "logs"
description:  "How to get access to logs"
---

For access to the logs for an app running on dokku:

* ssh into `dokku-xx.cs.ucsb.edu`
* use:
  * `dokku logs app-name` for a snapshot of the logs
  * `dokku logs app-name --tail` for a continuously running view of the logs
