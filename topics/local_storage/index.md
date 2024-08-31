---
parent: Topics
layout: default
title: "Local Storage"
description:  "A way to cache some state in the browser"
has_children: true
---

# {{page.title}} 

## {{page.description}}

In full-stack web development, the phrase *local storage* refers to the ability of frontend code to store some information client side
in each browser instance.

This page from w3schools.com summarizes the API, which is essentialy a key value store:
* <https://www.w3schools.com/jsref/prop_win_localstorage.asp>

But essentially, it's just a key-value store for strings.  There's a separate key/value store associated with each web site that the browser
visits.  

Local storage is not shared across browsers or websites.   

You can clear local storage in your browser, though the exact way of doing this varies from browser to browser.

## Example use case from proj-courses

The [proj-courses](https://github.com/ucsb-cs156/proj-courses) code base has several examples of use cases for local storage.

As an example, the most basic feature offered by proj-courses is "as a user, I can search for courses by quarter, subject area and level".

If a users searched recently for courses for `F24`, `MATH`, "Lower Division" it is likely that the next time
they do a search, they will want to search for the same quarter, subject area and level; that's at least a good guess as to what they want.

So, we cache their selections in browser local storage so that the next time they visit the page, the default selections are "the ones they
chose last time they visited the page"


