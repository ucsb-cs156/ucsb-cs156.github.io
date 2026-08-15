---
parent: "Postgres"
grand_parent: Topics
layout: default
title: "Postgres: promote"
description:  "When you have DOKKU_POSTGRES_AQUA_URL instead of DATABASE_URL"
---

Sometimes when you are deleting and recreating databases, instead of DATABASE_URL
pointing to the correct database, you end up with DOKKU_POSTGRES_AQUA_URL.

The old way to fix this problem was this line of code in our `startup.sh` script:

```
if [ -n "$DOKKU_POSTGRES_AQUA_URL" ]; then
DATABASE_URL="$DOKKU_POSTGRES_AQUA_URL"
fi
```

But there's a better way.

Just run this command:

```
dokku postgres:promote appname-db appname
```

This will ensure that the database you reference (e.g. `appname-db`) is the one that `DATABASE_URL` actually points to.


