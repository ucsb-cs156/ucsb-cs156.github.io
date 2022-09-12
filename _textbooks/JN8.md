---
title: Java in a Nutshell, 8th Edition
layout: default
desc: Additional Source for Advanced Java Topics
custom_sort_order: 1
used_this_quarter: false
---

# {{page.title}}

## Reading Notes, by Chapter

{% assign jn8_chapters = site.jn8 | sort: "sort_key" %}
{% for chapter in jn8_chapters %}
* [Chapter {{chapter.chapter}}]({{chapter.url}})&mdash;{{chapter.title}}{%if chapter.desc %}&mdash;{{ chapter.desc }}{% endif %}
{% endfor %}
