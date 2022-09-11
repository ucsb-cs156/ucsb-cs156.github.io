---
parent: MongoDB
grand_parent: Topics
layout: default
title: "MongoDB: Staff Setup"
description:  "Information for Course Staff on settig up the MongoDB instances for the project repos"
category_prefix	: "MongoDB: "
indent: true
---

Each of the three legacy code projects (proj-ucsb-courses-search, proj-ucsb-cs-las, and proj-mapache-search) uses MongoDB, but in different ways, and requires
different setup.

This page is intended for the course staff as documentation on how to do this setup.


# proj-ucsb-courses-search

For the courses search application, the MongoDB database is used as a data warehouse for historical data.  The same data can always be obtained through the UCSB Courses Search API, however the API limits searches to only a single quarter at a time.   Thus searches across multiple quarters are quite inefficient.

For now, proj-ucsb-courses-search app only requires read-only access to the MongoDB instance, and a single MongoDB instance can be persisted from course instance to course instance.  

Accordingly, the process for a new quarter is to just create read-only-credentials for each team, and distribute them to the teams working on proj-ucsb-courses-search.

For now, updating the database is a manual process done by staff, using scripts from this repo: 

In the future, it may be helpful to implement some new features that would require the app to have read/write access:
* a feature where query that obtains information from the UCSB API also stores that data in the MongoDB database (to keep it up to date on a rolling basis)
* a caching feature where the MongoDB database tables have a notion of the "current quarter" vs. past or future quarters, and always use the MongoDB database
  for any queries for past quarters.
* a "background jobs" feature built into the app that can obtain data (slowly) from the API and populate the MongoDB database (as the script does), but built
  into the app as an Admin only feature.
  
  
## Onboarding new teams and devs

There is a MongoDB Organization called "ucsb-cs156", which has under it, a project `ucsb-courses-search`.  The production database for `ucsb-courses-search` is shared by all instances of the repo (prod, qa, dev) since it is read only.    To onboard a new course instance:

* Navigate under [cloud.mongodb.com](https://cloud.mongodb.com) to Organization `ucsb-cs156`, Project `ucsb-courses-search`.
* Create a new database user for each team with names such as `team-s21-5pm-1`, `team-s21-5pm-2`, etc., each with the privilege level `readAnyDatabase`
* Distribute the MongoDB credentials to the teams' slack channels.   You can use a message like this one:
  ```
  In the reply to this message, you will find a MongoDB username/password with read-only access
  to the for the database used by proj-ucsb-courses-search, one specific to your team.  
  
  You'll need this for an upcoming team activity; 
  the instructions will tell you to look for this message in your team's Slack channel.
  ```
  
  Then something like this.  Note that if you just copy the URL from the MongoDB interface, it may have `myFirstDatabase` as a placeholder for the database name; you'll need to change this as well before sharing the URL with the student teams (or else specify the true database name separately, and advise them to substitute it in.)
  
  ```
  Password: `paste-it-here`
  Username: `team-s21-5pm-1`
  Url: `mongodb+srv://<username>:<password>@cluster0.ulqcw.mongodb.net/database?retryWrites=true&w=majority`
  
  You should substitute in the username and password into the Url.  Remove the <> characters around the words <username>  and <password> as well. 
  ```

# proj-ucsb-cs-las

In proj-ucsb-cs-las, the MongoDB database is used to track logins.   MongoDB is used because of the feature of a "capped collection", where the most recent
data is retained, and older data is automatically deleted.

For proj-ucsb-cs-las, we need to create new databases for each quarter, and for each team, since read/write access is required.


## Onboarding new teams and devs

1. Create a new organization for the quarter, e.g. `ucsb-cs156-s21`.  Add all staff members with admin access.
2. Create a project for each team, e.g. `team-s21-6pm-1`, `team-s21-6pm-2`, etc. and then immediately create a cluster. (You can skip adding users for now)

   Under each project, you'll need to also create a new cluster, and
   this takes some time, so it's a good idea to batch this so that the cluster creation can happen in parallel; you can then return to the first team
   to do the credential generation while the others are generating.
3. If it doesn't already exist, create a "Team" at the "Organization" level.  This is done in the `Access Manager` tab near the top of the page.
4. For each cluster, use the "Use My Own Data" option.  Create a database called `database` and a capped collection called `logins` (`2000000 bytes`).
5. For each project, click `Network Access`, then `Add IP Address`, then `Allow Access from Anywhere` then `Confirm`.
6. For each project, click `Database Access`, then `Add New Database User` then put in:
   * username: `dbuser`
   * password: Autogenerate
   * Click `Add User`
7. Get the URl from each cluster from `Clusters`, then `CONNECT` then `Connect your application`.  Paste the url into the slack channel with these instructions:

   * Initial message: `MongoDB credentials in reply to this message`
   * Reply 1: paste url
   * Reply 2: paste these instructions: 
     ```
     Replace `<password>` with the password for the `dbuser` user, coming in a future message (take out the `<>`).  Replace `myFirstDatabase` with `database`
     ```
   * Reply 3 will have the password, and comes after step 8.
8. For each project, reset the password for the `dbuser`, copy it, and paste it into each of the reply 3's  

# proj-mapache-search

For mapache-search, the MongoDB database is used to store information from a Slack workspace.   MongoDB is chosen because the data originates as hierarchical data in JSON; flattening it into data suitable for a relational database (i.e. flat tables) would be quite cumbersome.

A new database instance should be created for each quarter, since the database contains data from the current slack workspace.



For proj-mapache-search, the app has read-only access to the data; the data is updated by a script run by the staff.   

## Onboarding new teams and devs

1. Set up a new cluster for the Mapache database under the current quarter organization.
2. Set up database called `slack` and regular collections called `channels` and `messages` and `users` (not capped).
3. To populate the database, see [TODO INSERT THESE INSTRUCTIONS]
4. Add an index on the `messages` collection that has this mapping: `"text":"text"`
5. Create a new database user for each team with names such as `team-s21-7pm-1`, `team-s21-7pm-2`, etc., each with the privilege level `readAnyDatabase`

Then, distribute the MongoDB credentials to the teams' slack channels.   You can use a message like this one:

```
In the reply to this message, you will find a MongoDB username/password with read-only access
to the for the database used by proj-ucsb-courses-search, one specific to your team.  

You'll need this for an upcoming team activity; 
the instructions will tell you to look for this message in your team's Slack channel.
```
  
Then something like this.  Note that if you just copy the URL from the MongoDB interface, it may have `myFirstDatabase` as a placeholder for the database name; you'll need to change this to `slack` as well before sharing the URL with the student teams (or else specify the true database name separately, and advise them to substitute it in.)
  
```
Password: `paste-it-here`
Username: `team-s21-7pm-1`
Url: `mongodb+srv://<username>:<password>@cluster0.ulqcw.mongodb.net/slack?retryWrites=true&w=majority`

You should substitute in the username and password into the Url.  Remove the <> characters around the words <username>  and <password> as well.  
```

