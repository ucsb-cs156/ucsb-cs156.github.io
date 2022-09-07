---
parent: Topics
layout: default
title: "Node: npm"
description:  "Node Package Manager"
indent: true
category_prefix: "Node: "
---

`npm` is the Node Package Manager.  It differs from `nvm` in the following ways:

* `nvm` is used to determine which version of `node` we are using
* Once we've settled on a version of `node`,  `npm` uses the information in our `package.json` to load the dependencies for our specific project. 

Once `npm` is installed, we can update our `npm` version by typing the following:

```
npm install -g npm
```

