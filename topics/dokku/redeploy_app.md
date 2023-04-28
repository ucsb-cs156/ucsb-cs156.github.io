---
parent: Dokku
grand_parent: Topics
layout: default
title: "Redeploy App"
description:  "How to redeploy an app"
---

If you are trying to deploy an app by pushing to the `dokku` remote like this, and get a message that `Everything up-to-date`, you may find this frustrating, and be tempted to make 
a "fake change" to force a redeploy.  

```
[pconrad@csilvm-01 STARTER-team02]$ git push dokku main
Everything up-to-date
```

But there's an better way that doesn't involved making fake changes to the code: an empty commit.  Here's how:

```
[pconrad@csilvm-01 STARTER-team02]$ git commit --allow-empty -m "pc - empty commit to push to dokku"
[main 8253cbd] pc - empty commit to push to dokku
[pconrad@csilvm-01 STARTER-team02]$ git push dokku main
... Dokku starts deploying
```

# An even better way, if it works

If you have a terminal open to the shell prompt on `dokku-xx.cs.ucsb.edu`, you can also try these commands:

* `dokku ps:restart app-name`
* `dokku ps:rebuild app-name`

