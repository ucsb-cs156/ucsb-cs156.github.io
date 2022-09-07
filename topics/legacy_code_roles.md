---
parent: Topics
layout: default
title: "Legacy Code: Roles"
description:  "Role management in the legacy code apps for this course"
category_prefix: "Legacy Code: "
indent: true 
---

In the legacy code apps for CMPSC 156 that use Spring and React, there is a particular pattern that is used for managing roles.

One common symptom that can arise when these apps are not configured propertly is that the "role" that shows up on the Profile screen says `Loading Role` instead
of showing a badge with either `Guest`, `Member`, or `Admin`.

If that's happening, it often indicates a misalignment of these values
* `app.namespace`  in `secrets-localhost.properties` and `secrets-heroku.properties`
* `security.oauth2.resource.id` in the same two files (make sure it is identical to `app.namespace` or set to exactly `${app.namespace}` and 
   that there isn't a trailing slash, or something like `/api` on the end.
* `REACT_APP_AUTH0_AUDIENCE` in `javascript/.env.local`

Also check:
* the value that you set in the second field in the "API" setting in Auth0.
* the value that is in the key in the "Rule" in Auth0.

All five of these must be identical for the Role to load properly.
