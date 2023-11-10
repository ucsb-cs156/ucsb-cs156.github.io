---
parent: Dokku
grand_parent: Topics
layout: default
title: "Postgres Database: Backup/Restore"
description:  "How to deploy a postgres database"
---

# Backup/Restore

In development and qa instances of an application, the data in the database is only for testing, so it's
not a big deal if it gets corrupted or lost.  

However, once you start serving real users, it's essential to 
make sure that the data on which users are depending doesn't get lost or corrupted due to human error or
system crashes.

Therefore it's important to make periodic backups of the data.  It's equally important to make sure
that you know how to restore the data from one of these backups; otherwise, backing up the data is worse
than useless; without a proper restore protocol that's been documented and tested, backups give the illusion
of safety without providing any actual benefit in a data loss scenario.

# TODO: Document how to backup and restore data on dokku
