---
parent: Topics
layout: default
title: "OAuth: Authorizing GitHub Third Party Apps"
description:  "Gradescope, and GitHub OAuth Apps you build yourself"
category_prefix: "OAuth: "
indent: true
---

Sometimes, you may want to use  GitHub OAuth for third party apps with an organization, such as:
* Gradescope
* Apps that you are developing yourself

When you do this, you may find that the app doesn't work unless and until you either
* Remove all restrictions from the Organization
* Get an admin for the organization to authorize the specific app

# Removing all restrictions from the organization

Removing all restrictions from the organization for third-party apps may not be advisable, in general. But if you are trying to rule
out this as the source of problem, it may be something you want to do at least temporarily.

To do it, go to this link (substituting your own organization in place of `ucsb-cs56-f19` for example):

* <https://github.com/organizations/ucsb-cs56-f19/settings/oauth_application_policy>

# Requesting Third Party Access for a specific app to an organization

On that same link, i.e. <https://github.com/organizations/ucsb-cs56-f19/settings/oauth_application_policy>, it is
possible for organization owners to allow third-party access for specific apps.  This is a better solution.

However, on this page, you can only authorize applications that have *requested* third-party app access.

How do you request this access? That is explained on this web page:
* [GitHub Help: Requesting Organization Approval For Oauth Apps](https://help.github.com/en/github/setting-up-and-managing-your-github-user-account/requesting-organization-approval-for-oauth-apps)


