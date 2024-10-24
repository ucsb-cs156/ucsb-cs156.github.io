---
parent: Dokku
grand_parent: Topics
layout: default
title: "Enabling HTTPS"
description:  "Configuring a certificate for your dokku app"
---

# {{page.title}}
## {{page.description}}

Google OAuth requires that applications (other than those running on localhost) use `https` to encrypt the traffic that goes over the network.

## Before configurating HTTPS, deploy over HTTP

Note that *before* you can enable https, you must *first* deploy your app at least once using `http`
* If your app requires a database, you'll have to configure *at least that* first, or the app won't come up.
* You will *not* be able to login to the app using OAuth.
* To bring the app up, use the `dokku git sync ...` and `dokku ps:rebuild ...` steps first.

## Enabling HTTPS (after HTTP is working)

Once you've got at least a basic home page up  using `http`, you can enable `https`.

The commands below show <tt><b><i>app-name</i></b></tt> as the name of your app; be sure to
substitute in <tt><b><i>jpa03-cgaucho</i></b></tt>, for example.

On your assigned dokku machine, at the prompt, type these two commands, substituting in your UCSB email in place of `cgaucho@ucsb.edu`

*  <tt>dokku letsencrypt:set <b><i>app-name</i></b> email <b><i>cgaucho@ucsb.edu</i></b></tt>
*  <tt>dokku letsencrypt:enable <b><i>app-name</i></b></tt>

