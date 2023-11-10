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

As you may already know, you can access the postgres command line for a database service (e.g. `happycows-db` by typing <code>dokku postgres:connect <i>service-name</i></code> (using `\q` to quit):

```
pconrad@dokku-00:~$ dokku postgres:connect happycows-db
psql (15.2 (Debian 15.2-1.pgdg110+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
Type "help" for help.

happycows_db=# 
```

You can also connect outside of dokku with the `psql` command by finding the ip address and password from the <code>dokku postgres:info <i>service-name</i></code> dokku command, like this (use `\q` to quit):

```
pconrad@dokku-00:~$ psql --host 172.17.0.19 --port 5432 -U postgres
Password for user postgres: 
psql (15.4 (Ubuntu 15.4-1.pgdg22.04+1), server 15.2 (Debian 15.2-1.pgdg110+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
Type "help" for help.

postgres=# 
```

The password that you need comes from the output of `dokku postgres:info ...` as shown below (the password has been changed to a fake value).  The password
is the value in between the `:` and the `@` on the line marked `Dsn:`, i.e. in this case: `23d453c5b7d486fc48520f3e5b7977019a1ed6a`.  You'll need to copy/paste
that and put it in when prompted for the password.  It will not echo on the screen; you'll just have to have faith that it is going in, and then press enter.

```
=====> happycows-db postgres service information
       Config dir:          /var/lib/dokku/services/postgres/happycows-db/data
       Config options:                               
       Data dir:            /var/lib/dokku/services/postgres/happycows-db/data
       Dsn:                 postgres://postgres:23d453c5b7d486fc48520f3e5b7977019a1ed6a@dokku-postgres-happycows-db:5432/happycows_db
       Exposed ports:       -                        
       Id:                  0bbae7efa24b7fd3973e5a14a3c4a4e85bc8970b5f84c852e9cccf9ccc90199c
       Internal ip:         172.17.0.19              
       Initial network:                              
       Links:               happycows                
       Post create network:                          
       Post start network:                           
       Service root:        /var/lib/dokku/services/postgres/happycows-db
       Status:              running                  
       Version:             postgres:15.2            
pconrad@dokku-00:~$
```

If that command succeeds in connecting, then you can use `\q` to quit, and then change the `psql` command to `pgdump` and redirect the result into a file to get a backup of the data, like this:

```
pconrad@dokku-00:~$ pg_dump --host 172.17.0.19 --port 5432 -U postgres > happycows-backup.sql
```

The resulting file is a series of SQL commands that will rebuild the database contents.  Here is just the first few lines of the resulting file:

```
--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.4 (Ubuntu 15.4-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
...
``` 

# When making backups, note the SHA of the commit the production app is running at the time you make the backup

When making a backup, it's a good idea to store the sha of the commit that the app is running at the time the backup was made; you'll need this information later if you want to restore the application to the state it was in when the backup was made.

Otherwise, you might be restoring the data to a version of the code that is incompatible with the code.

While the simplest case is to restore both the code and and the data to exactly the same state, there may be specific circumstances where you may need to restore a backup and deploy it to a different commit  us
than the one that was in place when the backup was made.  In that case you want to pay careful attention to any changes to the database schema between the commit at the time the backup was made, and the commit
at the time you are restoring the data.  If your app uses a database migration tool (e.g. liquibase), examine any migrations that happened between one commit and the other, so that you can apply these in the appropriate way
to the restored data.

To determine that sha of the commit that the app is running, use the command  <code>dokku git:report <i>service-name</i></code>, like this:

```
pconrad@dokku-00:~$ dokku git:report happycows
=====> happycows git information
       Git deploy branch:             main                     
       Git global deploy branch:      master                   
       Git keep git dir:              false                    
       Git rev env var:               GIT_REV                  
       Git sha:                       82eeec6fe1               
       Git source image:                                       
       Git last updated at:           1696979162               
pconrad@dokku-00:~$ 
```

Note that while it is helpful to know that the branch that was deployed was `main`, that's not enough information since the `main` branch may changed.  We need the specific SHA, in this case `82eeec6fe1`.  

The value marked` Git last updated at:`, which in this case is `1696979162` is a date/time stamp; you can use a tool such as <https://www.epochconverter.com/> to convert this to a human readable date/time.  In this case, `1696979162` corresponds to `Tuesday, October 10, 2023 4:06:02 PM GMT-07:00 DST`.   This can be helpful information as well.

# How do you restore the data?

## Practice Run

If you are restoring data to a production application, it's a good idea to practice first on a separate qa instance.

Start by creating a brand new dokku deployment with an empty database.

Using `dokku git:sync ...`, sync this deployment to a carefully chosen commit, either:
* Exactly the same github repo/commit that the production instance was running at the time the backup was made (see above)
* Or, a specific commit that is early or later than the commit at the time of the backup; in this case, you need to make sure that you understand the changes to the database schema, if any, and what you'll need to do to the database after restoring the data to ensure that it is compatible with the commit you are deploying.

Then, *before* you deploy any code (i.e. before doing `dokku ps:rebuild ...`) but *after* creating and linking the database (`dokku postgres:create ...`; `dokku postgres:link ...`), use theomman following command to 
load the file with the SQL commands into the database:

TODO: Document how to backup and restore data on dokku
