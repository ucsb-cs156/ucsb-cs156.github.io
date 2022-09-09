---
parent: Heroku
grand_parent: Topics
layout: default
title: "Heroku: Tips"
description:  "Quick reference for how to get certain things done"
category_prefix: "Heroku:"
indent: true
---

# Postgres SQL command line

Use:

```
heroku pg:psql --app my-app-name
```

You may need certain sofware installed on your local system to make this work.

Commands:

* `\dt` describe tables (list names of tables)
* `select * from users limit 1;` show first row in `users` table
* `select * from users where username='cgaucho';` show one row of the table
* `select * from roster_students,users where username='cgaucho' and roster_students.user_id = users.id;` join two tables
