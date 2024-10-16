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

<img width="626" alt="image" src="https://github.com/user-attachments/assets/89f29519-451d-4141-9558-b9662d80fba0">

That's good!  That means that Chromatic is working as it should.  The message `13 changes must be accepted as baselines` means that there are 13 changes to the visual appearance of the application that you need to review and accept.  Here's how:

1. Click the "Details" button.
   * Alternatively, you can go to <https://chromatic.com>, login (or click where it says `Go to App`), find your project, and click on the latest build page.
   * Also, if the link to `build info` is working on your Github Pages site, this is another way to get to the build on Chromatic
2. You'll see a page similar to this one.  The button `Verify Changes` is the one you want.
   <img width="1149" alt="image" src="https://github.com/user-attachments/assets/d3c73f72-8405-4b53-8d45-7a0b9f90b23c">
3. You'll be shown the changes one at a time.   Here, for example is a change where the text `jpa03` in lowercase was changed to `JPA03` (uppercase).  Note that the left hand image is the old image, and the right hand image is the new image.  The right hand image has some "green highlighting" around the change that may look a little strange.  This is *not* part of the new look of the page; it's just there to highlight the differences.
   <img width="1231" alt="image" src="https://github.com/user-attachments/assets/9075932f-601f-49e4-a748-a547dfc3fd28">
   Click where it says `Accept` if this change is acceptable.  Or, if the changes is *not* what you want, click `Deny`.
4. Repeat this process for all of the changes.
5. Eventually you should see a green circle like this:
   <img width="1155" alt="image" src="https://github.com/user-attachments/assets/9a767bde-bb16-45ec-90b7-5103097b4e1b">
6. Then when you return to Github, the dreaded yellow circle should now be a green check, like this:
   <img width="634" alt="image" src="https://github.com/user-attachments/assets/18419b5b-32bc-4b50-8819-aa71b4714a5f">


