---
parent: Topics
layout: default
title: Liquibase
description:  "Database migration framework"
has_children: true
---

Liquibase is a framework utilized to automate changes to existing databases while working on a live codebase.

## Overview
Liquibase allows the users to describe changes and maintain a version-controlled log of a live database, which allows the users to roll back unwanted changes as well as evolve the existing tables to support a constant integration cycle.

## Changelog
The `changelog` in the main file to know about liquibase. It is used to describe the database changes to liquibase and should be maintained throughout the project.

## Multi-file vs Master file
There are essentially 2 ways to describe the changes on `changelog`. The first way is to use a master file approach where all changes are described in a single file, this method could be useful for an evolving database that contains few or one table. The other approach to be used is the multi-file approach, where the user will have one master `changelog` that points to other changelogs, this approach is useful because it can keep the changes more organized making it easier to look for changes to a specific table if the needs arises.

## How to describe changes
The changes on the `changelog` can be described in `XML`, `YAML`, and `JSON`. Each of the languages has its pros and cons and it will be ultimately up to the developer to choose what will fit the project they are working on.

## ChangeSet
Inside each `changelog` will be a collection of `ChangeSets` each `ChangeSet` describes a sequence of changes to be applied to the database, and each will have its unique ID as well as the author of that particular `ChangeSet`. The ID will be used to let liquibase know which change sets have been applied to the database already to avoid all changes being reapplied every time the project is started.

## Changes
A Change is something you want to do with the database like `createTable`, `addColumn` etc. Multiple changes can be described in a single `ChangeSet` just like multiple `ChangeSets` can be described in each `ChangeLog`. For all possible change types, you can check [Changes](https://docs.liquibase.com/change-types/home.html)

## Preconditions
Preconditions are conditions you can specify that need to be met in order to run a certain change or to specify what liquibase should do in case a certain change fails to be applied, for example when it tries to create a table that already exists, instead of failing it should mark that change as complete

## DATABASECHANGELOG
the `DATABASECHANGELOG` table contains a log of all `ChangeSets` that have been applied to the database and in which order, as well as their ID and author

## Commands
Liquibase has multiple commands that can be used to modify the database, roll back changes, verify the changelogs, sync the database to changes, verify which changes will be run on the next update, etc. For all commands check [Commands](https://docs.liquibase.com/commands/home.html)
