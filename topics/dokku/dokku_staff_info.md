---
parent: Dokku
grand_parent: Topics
layout: default
title: "Staff Info"
description:  "Information about dokku for course staff"
---

# {{page.title}} - {{page.description}}

## Troubleshooting Dokku Access

If a staff member or student is unable to access dokku, check these things:

1. Is there entry in the List of Users correct (see below, i.e. `/home/eci/dokku_users_list`)
2. Are they over their CSIL disk quota? (This will prevent them from logging in to dokku for obscure reasons). If so, check <https://ucsb-cs156.github.io/topics/CSIL/csil_disk_quota.html>
3. Check that student has a valid public key: `ls ~/.ssh/id_rsa.pub` *and* a valid private key in `~/.ssh/id_rsa`
4. Check that the student has added that key to their authorized keys:
   
   ```text
   touch ~/.ssh/authorized_keys
   cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
   ``` 

## List of Users

The file `/home/eci/dokku_users_list` should be editable by the CMPSC 156 instructor; if it isn't, contact ECI.

That file has one user per line, and a dokku machine they are authorized for.
