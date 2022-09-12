---
title: Java in a Nutshell, 7th Edition
layout: default
desc: Additional Source for Advanced Java Topics
custom_sort_order: 2
used_this_quarter: true
---

# {{page.title}}

## Reading Notes, by Chapter

{% assign jn7_chapters = site.jn7 | sort: "sort_key" %}
{% for chapter in jn7_chapters %}
* [Chapter {{chapter.chapter}}]({{chapter.url}})&mdash;{{chapter.title}}{%if chapter.desc %}&mdash;{{ chapter.desc }}{% endif %}
{% endfor %}
