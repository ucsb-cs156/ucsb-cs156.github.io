---
parent: Dokku
grand_parent: Topics
layout: default
title: "Enabling HTTPS"
description:  "Configuring a certificate for your dokku app"
---

Google OAuth requires that applications (other than those running on localhost) use `https` to encrypt the traffic that goes over the network.

Here's how to enable https on Dokku apps.  The commands below show <tt><b><i>app-name</i></b></tt> as the name of your app; be sure to
substitute in <tt><b><i>jpa03-cgaucho</i></b></tt>, for example.

On your assigned dokku machine, at the prompt, type these two commands, substituting in your UCSB email in place of `cgaucho@ucsb.edu`

*  <tt>dokku letsencrypt:set <b><i>app-name</i></b> email <b><i>cgaucho@ucsb.edu</i></b></tt>
*  <tt>dokku letsencrypt:enable <b><i>app-name</i></b></tt>

