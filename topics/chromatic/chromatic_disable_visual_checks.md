---
parent: Chromatic
grand_parent: Topics
layout: default
title: "Chromatic: Disable UI Review"
description:  "How to disable UI review for a project"
---

# {{page.title}} - {{page.description}}

Our suggestion for now is to **routinely disable UI Review checks** when working with Chromatic.com.  This will avoid the "never ending yellow circle" problem.

The page below shows you how to do it, and then provides some background explanation on why we are taking this action at this point.

## How to disable UI Review

1. Log on to chromatic.com
2. Go to your project
3. Click on the "Manage" icon (<img width="60" alt="image" src="https://github.com/user-attachments/assets/79467af0-d9c9-4f46-a2a0-f9e6acde8b50">) at left
4. On the "Mangage" screen, you should see tabs for `Automate`, `Collaborate` and `Configure`.  You want to be on the `Automate` tab (as shown below).
5. Under `Automate`, there should be a panel for `UI Review`.  If it shows as enabled (the default) click the `Disable` button.
   
   <img width="865" alt="image" src="https://github.com/user-attachments/assets/794adfe7-b77a-4330-b32d-0f725360656a">

This should address the problems with never ending yellow circles.

## Explanation 

Starting with F24, we upgraded storybook to a version that is integrated with visual difference testing for user interfaces (UI Review) using Chromatic. 

Visual difference testing is awesome, and I'm glad to have it as a part of our toolbox.

As it turns out, integrating visual UI testing into our workflows is a bit complex.  

Students and staff alike have been running into various problems with 
Github Actions workflows not completing (e.g. the [never ending yellow circle](https://ucsb-cs156.github.io/topics/chromatic/chromatic_yellow_circle.html) problem).

Accordingly, it is sometimes easier to just *disable UI Review* for your Chromatic.com project, either temporarily, or permanently.

This allows you to work with the Storybook publishing features of Chromatic, without getting hung up on the visual testing features.

So, our suggestion for now is to **routinely disable UI Review** until the course staff works out a better workflow for visual testing.  We hope to have that in place for
F24, but if not, then hopefully by S25.


