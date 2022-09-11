---
parent: Legacy Code
grand_parent: Topics
layout: default
title: "Legacy Code: Projects"
description:  "A list of legacy code projects associated with this course"
category_prefix: "Legacy Code: "
indent: true
apps: 
  - org: ucsb-cs156-w21
    repo: demo-spring-react-minimal
    heroku-prod: demo-spring-react-minimal
    heroku-qa: demo-spring-react-minimal-qa
    purpose: Minimal Starter Code for new apps
  - org: ucsb-cs156-w21
    repo: demo-spring-react-todo-app
    heroku-prod: demo-spring-react-todo-app
    heroku-qa: demo-spring-react-todo-app-qa
    purpose: Todo manager  
  - org: ucsb-cs156-w21
    repo: proj-ucsb-courses-search
    heroku-prod: proj-ucsb-courses-search
    heroku-qa: proj-ucsb-courses-search-qa
    purpose: UCSB Courses Search  
  - org: ucsb-cs156-w21
    repo: proj-ucsb-cs-las
    heroku-prod: proj-ucsb-cs-las
    heroku-qa: proj-ucsb-cs-las-qa
    purpose: UCSB CS Dept Learning Assistant Program  
---

This page provides a list of some of the legacy code repos associated with this course.  This is not necessarily a complete list; we provide links to the ones that 
have active development.

| Repo | Prod | QA | Dashboard (prod) | Dashboard (qa) | Purpose |    
|------|-----------------|-------------|---------------|-----------|----------|
{% for app in page.apps %}| [{{app.repo}}](https://github.com/{{app.org}}/{{app.repo}}){:target="_blank"} | [Prod](https://{{app.heroku-prod}}.herokuapp.com){:target="_blank"} | [QA](https://{{app.heroku-qa}}.herokuapp.com){:target="_blank"} | [Prod Heroku Dashboard](https://dashboard.heroku.com/apps/{{app.heroku-prod}}){:target="_blank"} | [QA Heroku Dashboard](https://dashboard.heroku.com/apps/{{app.heroku-qa}}){:target="_blank"} | {{app.purpose}} |
{% endfor %}{:.table .table-sm .table-striped .table-bordered}



