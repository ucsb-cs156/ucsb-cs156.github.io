---
parent: Dokku
grand_parent: Topics
layout: default
title: "Getting Started"
description:  "How to deploy a Hello World Spring Boot app to Dokku"
ssh_key_form: https://docs.google.com/forms/d/e/1FAIpQLSemcZiZ7B8v5zxlWmaWw-YRkr4dip_t6qgpinYoo9xchw_IOg/viewform
---

# {{page.title}} - {{page.description}}

This describes how to get deploy a "Hello World" type Spring Boot app such as <https://github.com/ucsb-cs156-s23/STARTER-jpa02> on the Dokku platform
provided by UCSB ECI.


## Preliminaries

You will need:
* A CSIL account, with an public/private ssh key pair set up (explained below)
* To be assigned to a team such as `s23-5pm-3`
* To have had your ssh key associated with one or more of the thirteen Dokku servers (explained below)

First, you need an ssh key in your CSIL account. If you have one, you'll have these files in your CSIL account:
* `~/.ssh/id_rsa.pub` (public key; may be freely shared with anyone)
* `~/.ssh/id_rsa` (private key; *never* share with anyone)

If these files don't exist in your account, you can run `ssh-keygen` at the CSIL shell prompt; just hit enter to accept all defaults.  After running the `ssh-keygen` command,
if you use the defaults, those files should then exist.

Second, you'll need to have provided your ssh *public* key (i.e. the contents of `~/.ssh/id_rsa.pub`) to whomever is setting up the access to the Dokku
servers; currently this is a manual process done by ECI staff directly.   Instructors may like to collect these using a [form similar to this one]({{page.ssh_key_form}})
and then provide the list of keys as a spreadsheet to ECI staff.

Finally, you'll need to know which Dokku server you were given access to.  There will typically be a mapping from your team name to your Dokku instance such
as the one below.  Staff have access to the `dokku-00.cs.ucsb.edu` instance, and all other servers.  Students typically have access to only one server, namely 
the one for their team.

Here is an example mapping of teams to Dokku servers from S23:

| Host | Team | 
|------|------|
| `dokku-00.cs.ucsb.edu` | Course staff |
| `dokku-01.cs.ucsb.edu` | s23-5pm-1 |
| `dokku-02.cs.ucsb.edu` | s23-5pm-2 |
| `dokku-03.cs.ucsb.edu` | s23-5pm-3 |
| `dokku-04.cs.ucsb.edu` | s23-5pm-4 |
| `dokku-05.cs.ucsb.edu` | s23-6pm-1 |
| `dokku-06.cs.ucsb.edu` | s23-6pm-2 |
| `dokku-07.cs.ucsb.edu` | s23-6pm-3 |
| `dokku-08.cs.ucsb.edu` | s23-6pm-4 |
| `dokku-09.cs.ucsb.edu` | s23-7pm-1 |
| `dokku-10.cs.ucsb.edu` | s23-7pm-2 |
| `dokku-11.cs.ucsb.edu` | s23-7pm-3 |
| `dokku-12.cs.ucsb.edu` | s23-7pm-4 |

## Logging into the Dokku instance

To login, first login to your CSIL account.

Then use, for example, `ssh username@dokku-xx.cs.ucsb.edu` where `xx` is replaced by `00` through `12`.

You should get access to a shell prompt on the Dokku server.

