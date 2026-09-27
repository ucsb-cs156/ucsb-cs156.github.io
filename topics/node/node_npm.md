---
parent: Node
grand_parent: Topics
layout: default
title: "Node: npm"
description:  "Node Package Manager"
---

# {{page.title}} - {{page.description}}

`npm` is the Node Package Manager.  It differs from `nvm` in the following ways:

* `nvm` is used to determine which version of `node` we are using
* Once we've settled on a version of `node`,  `npm` uses the information in our `package.json` to load the dependencies for our specific project. 

Once `npm` is installed, we can update our `npm` version by typing the following:

```
npm install -g npm
```

## Approving install scripts

`npm 11` added a security feature: **dependency install scripts** (preinstall/install/postinstall) are blocked by default now. This closes off a real supply-chain attack vector — a compromised or malicious package used to be able to run arbitrary code the moment `npm install` touched it, with no prompt at all. `npm` now silently skips those scripts and, instead, lists at the end of the run which packages got skipped.

It's tracked via an `allowScripts` field in `package.json`, managed with the new `npm install-scripts` subcommand (`approve`, `deny`, `ls`, `prune`).

If you see `npm warn install-scripts ...` not yet covered by `allowScripts`, this is `npm` (`v11+`) protecting you from a package silently running code on your machine during install. 

* Run `npm install-scripts ls` in the affected directory to see which packages are asking to run install scripts, and take a moment to check they're what you'd expect (build tools like `esbuild/@swc/core`, or a dev-server tool like `msw`) rather than something unfamiliar.
* If they look right, run `npm install-scripts approve --all` and include the resulting `package.json` change in your commit.
* If a package you don't recognize shows up here, stop and ask before approving it — that's exactly the scenario this feature exists to catch.

Here's an example of that warning:

```
npm warn install-scripts 4 packages have install scripts not yet covered by allowScripts:
npm warn install-scripts   @swc/core@1.16.2 (postinstall: node postinstall.js)
npm warn install-scripts   esbuild@0.28.2 (postinstall: node install.js)
npm warn install-scripts   fsevents@2.3.3 (install: (install scripts present))
npm warn install-scripts   msw@2.15.0 (postinstall: node -e "import('./config/scripts/postinstall.js').catch(() => void 0)")
npm warn install-scripts
npm warn install-scripts Run `npm install-scripts ls` to review, or `npm install-scripts approve <pkg>` to allow.
```

The clean fix is this:

```
cd frontend
npm install-scripts approve --all   # pins each to the exact version just reviewed
git diff package.json               # review the new allowScripts block before committing
```

