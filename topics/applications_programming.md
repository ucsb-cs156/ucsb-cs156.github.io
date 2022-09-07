---
parent: Topics
layout: default
title: Applications Programming
description:  "A compendium of knowledge and skills applications programmers (software developers) need"
category_prefix: "Applications Programming: "
---

This is a _compendium_† of the knowledge and skills that applications progammers (software developers) typically need 
to be effective contributors in software development internships and jobs.    This was compiled based on 
direct observation, and conversations with recent graduates at interships and jobs.

†_compendium_: a collection of concise but detailed information about a particular subject

# Practices

* Acceptance Criteria
* Code Review
* Dev/QA/Test/Prod separation
   * In Spring Boot, these are called [profiles](https://stackabuse.com/spring-boot-profiles-for-dev-and-prod-environments/)
   * In Rails, they are set via the `RAILS_ENV` environment variable
   * In Python Flask, it's the `FLASK_ENV=development` or `FLASK_ENV=production` variable. 
* Continuous Integration / Continuous Delivery
   * [CI/CD for SpringBoot on TravisCI](https://sivalabs.in/2018/01/ci-cd-springboot-applications-using-travis-ci/)
* Grooming
* Pairing (including strong-style pairing) and Mobbing
* Retrospectives (retros)
* Stories
* Standup
* [Teamwork](/topics/teamwork) including *Team Alliances*

# Concepts/Terminology

* Database Migrations
* Minimum Viable Product
* Product Manager (not the same as Project Manger)
* Spike
* Technical Debt
* Thin Slice
* User Interface (UI) and User Experience (UX)

# Git Skills

* branches and pull requests
* Amending a commit (`git commit --amend`)
* Proper use of `git push -f`
* Interactive rebase (`git rebase -i`)
* Fixup commit (`git commit --fixup sha`)
* Proper use of `git reset --hard sha`
* Proper use of `git clean`
* Proper use of `git stash` and `git stash pop`
* Proper use of `git pull --rebase origin master`
* Proper use of `git rebase --onto base target`
* A decorated graph: `git log --oneline --graph --decorate --all`
   * And a config `git config --global alias.lol 'log --oneline --graph --decorate --all'`

# Unix Skills
* Manipulating environment variables
* Using grep to search files
