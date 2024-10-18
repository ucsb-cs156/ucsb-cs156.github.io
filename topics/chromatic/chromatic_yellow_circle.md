---
parent: Chromatic
grand_parent: Topics
layout: default
title: "Chromatic: Yellow Circle"
description:  "When you have UI Tests pending preventing you from getting the green check on Github Actions"
---

# {{page.title}} - {{page.description}}

If you are experiencing the "never ending yellow circle" like this:

<img width="309" alt="image" src="https://github.com/user-attachments/assets/0a0615b5-f473-444f-9e29-84d1f8a4238c">

<img width="185" alt="image" src="https://github.com/user-attachments/assets/bc3efebc-3c9b-414c-b43f-bdc988ba85f0">


## If the organization is over it's quota/budget, you can't.

If the organization is over it's quota/budget, then you simply can't fix it: that looks like this:

<img width="440" alt="image" src="https://github.com/user-attachments/assets/a8a6ea4e-d5a4-4818-9a4c-50492b925c56">

Chromatic offers a free plan with 5000 Snapshots per month.   Chromatic.com has generously increased the quota for our course organization as a courtesy to support education, however, we still occasionally exceed our quota.  In that case, we may need a workaround so that this doesn't hold up the CI/CD pipeline.

## But: even if you got the over quota/budget, try running the CI/CD job for Chromatic again

Because if the quota was reset since it last ran (this typically happens on the first day of the month), it might work.

That's typically a Github Action with a title such as:
* `53-chromatic-main-branch`
* `55-chromatic-pr`

You might then get this instead: 



