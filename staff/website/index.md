---
parent: Staff
layout: default
title: "Website"
description:  "Maintaining the https://ucsb-cs156.github.io website"
---

# {{page.title}} - {{page.description}}

The website <https://ucsb-cs156.github.io> is publsihed using Github Pages.

Accordingly, the main part of the website is published with a repo at <https://github.com/ucsb-cs156/ucsb-cs156.github.io/>.   

Course staff may makes changes in one of two ways:

* Fork and make a PR (anyone can do this, actually, since it's a public repo)
* Request to be added with write access to make updates directly.

However, there are a few parts of the website that use a different convention, so it's helpful to be aware of that.

## Course Instance websites

Each instance of the course (e.g. `f26`, `s26`, etc.) has a separate repo, and the default github pages mapping works so that this can be maintained in it's own repo.

For example:

| Pages under | Are maintained in this repo |
|-------------|-----------------------------|
| `/f26`     | <https://github.com/ucsb-cs156/f26> |
| `/s26`     | <https://github.com/ucsb-cs156/s26> |

and so forth.

The distinction is:
* The main repo  <https://github.com/ucsb-cs156/ucsb-cs156.github.io/> is used for information that seldom changes from quarter to quarter, such as documentation about technologies, techniques, etc.
* The instance repos are used for things that are different each quarter such as homework assignments, programming assignments, advice about what software to install, etc.

As with the main repo, course staff may makes changes in one of two ways:

* Fork and make a PR (anyone can do this, actually, since it's a public repo)
* Request to be added with write access to make updates directly.

## Setting up Channels

There is a Github Action, "60a - compute-slack-channels-as-yaml" in the `membership-scripts` repo that will compute yaml suitable for appending to the `_config.yml` of the course instance repo (e.g. <https://github.com/ucsb-cs156/f26>).

This allows referring to channels by doing things like this syntax:

```
[`#help-lecture-discussion`]({{site.channels.help-lecture-discussion.url}})
```

