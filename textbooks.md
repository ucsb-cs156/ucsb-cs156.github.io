---
layout: default
title: "Textbooks"
nav_order: 3
description: "Textbooks used in CMPSC 156"
---


# Note about the textbooks for the course

The textbooks for this course are available in "full text", at no charge, to UCSB students (see below).

There is a "catch": In past years, there were a limited number of "seats" for access to the UC subscription to the O'Reilly library that provides this access.

If you login at a time when "too many" folks from across the UC System (yes, all nine campuses), you might get an error.  This hasn't happened in a while, so maybe it's no longer a problem, but **be warned**; there may be a benefit to having your own paper copy.

The books tend to be much less expensive than
traditional textbooks, so if you can afford it, there is benefit to purchasing your own physical copy.

## Textbooks Used This Quarter

{% assign textbooks = site.textbooks | sort: 'custom_sort_order' %}
{% for textbook in textbooks %}
{% if textbook.used_this_quarter %}
* [{{ textbook.title }}]({{textbook.url | relative_url }})&mdash;{{textbook.desc}}
{% endif %}
{% endfor %}


## Other Textbooks

{% assign textbooks = site.textbooks | sort: 'custom_sort_order' %}
{% for textbook in textbooks %}
{% if textbook.used_this_quarter %}
{% else %}
* [{{ textbook.title }}]({{textbook.url | relative_url }})&mdash;{{textbook.desc}}
{% endif %}
{% endfor %}


## How to access the textbooks online

### Official way

[The UCSB Libary Page for the O'Reilly for Higher Education library](https://www.library.ucsb.edu/research/db/918) has a link on it that says `Search Now`.  Click this link, follow the login instructions, and then search for "Head First Java" or "Java in a Nutshell".

### Faster way

* The easy to remember alias: <https://bit.ly/ucsb-or> can be used to jump right to the place where you get the login instructions.
* Once you are logged in, these easy to remember aliases will get to you to the textbooks for the course:
  - [bit.ly/or-hfj3](https://bit.ly/or-hfj3) HFJ3 (Head First Java, 3rd Edition)
  - [bit.ly/or-jn7](https://bit.ly/or-jn7) JN7 (Java in a Nutshell, 7th Edition)