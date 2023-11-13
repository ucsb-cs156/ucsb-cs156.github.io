---
parent: Liquibase
grand_parent: Topics
layout: default
title: "liquibase: adding a table"
description:  "How to add a new table"
indent: true
---

# {{page.title}}

When not using liquibase, to add a new table, you simple create the `@Entity` class and the `@Repository` class.

When using liquibase, there is an additional step: you must generate the changelog file and store it in `src/main/resources/db`

You can generate the changelog by hand, but it is easier to use a tool to do it.   

TODO: continue from here.
