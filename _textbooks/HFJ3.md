---
title: Head First Java, 3rd Edition
layout: default
desc: Main textbook for learning Java
custom_sort_order: 1
used_this_quarter: true
---

# {{page.title}}

## Reading Notes, by Chapter

{% assign hfj3_chapters = site.hfj3 | sort: "sort_key" %}
{% for chapter in hfj3_chapters %}
* [Chapter {{chapter.chapter}}]({{chapter.url}})&mdash;{{chapter.title}}{%if chapter.desc %}&mdash;{{ chapter.desc }}{% endif %}
{% endfor %}
