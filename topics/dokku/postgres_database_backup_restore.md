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

# Tools for accessing data on dokku

You can access the postgres command line for a database service (e.g. `happycows-db` by typing <code>dokku postgres:connect <i>service-name</i></code>, e.g.

```
pconrad@dokku-00:~$ dokku postgres:connect happycows-db
psql (15.2 (Debian 15.2-1.pgdg110+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
Type "help" for help.

happycows_db=# 
```

You can also connect outside of dokku with the `psql` command by finding the ip address and password from the <code>dokku postgres:info <i>service-name</i></code> dokku command, like this:

```
pconrad@dokku-00:~$ psql --host 172.17.0.19 --port 5432 -U postgres
Password for user postgres: 
psql (15.4 (Ubuntu 15.4-1.pgdg22.04+1), server 15.2 (Debian 15.2-1.pgdg110+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
Type "help" for help.

postgres=# 
```

# TODO: Document how to backup and restore data on dokku
