---
parent: Vite
grand_parent: Topics
layout: default
title: "Vite: npm for multiple platforms"
description:  "How to resolve the problem 'Cannot find module @rollup/rollup-linux-x64-gnu' "
---

# {{page.title}} - {{page.description}}

The `vite` platform has some dependencies that are binaries that are specific to architecture and platform: they are different on Mac, Windows, Linux, and for x86 vs arm.

However, by default, `npm` only installs the dependencies for the platform on which you build the `package-lock.json` file when you run `npm`.

This can result in the following error, or similar ones:

```
Error: Cannot find module @rollup/rollup-linux-x64-gnu. npm has a bug related to optional dependencies
(https://github.com/npm/cli/issues/4828). Please try `npm i` again after removing both package-lock.json
and node_modules directory.
```

## A conversation with Gemini 

> I'm builiding a vite project on mac os, but then trying to deploy it on CI/CD systems and docker containers that use linux.
>
> I'm getting this:
>
> Error: Cannot find module @rollup/rollup-linux-x64-gnu. npm has a bug related to optional dependencies (https://github.com/npm/cli/issues/4828). Please try `npm i` again after removing both package-lock.json and node_modules directory.
>
> I suspect that it may be because I need to do something special when I build my package-lock.json to ensure that versions of dependencies for linux-x64-gnu are included along with version for MacOS. Am I on the right track? Can you help me figure out what needs to go in package.json or my workflow to fix this?

You're on the right track. The error occurs because **`npm` on macOS only installs optional dependencies for the Mac operating system.** When you then try to build the project on a Linux-based CI/CD system or Docker container, it can't find the necessary Linux packages, causing the build to fail.

### The Fix

The solution is to tell `npm` to install **all optional dependencies**, regardless of the platform. You do this by setting the `npm_config_platform` environment variable before running `npm install`.

Here's a step-by-step guide:

1.  **Remove existing lock files and `node_modules`:**
    ```bash
    rm -rf package-lock.json node_modules
    ```

2.  **Install dependencies for all platforms:**
    The best way to do this with `npm` is to set `npm_config_platform` to a value that doesn't match a real platform (like `all`). This forces `npm` to download all optional dependencies.
    ```bash
    npm_config_platform=all npm install
    ```

---

### Workflow Integration

You should add this command to your CI/CD workflow **before** the build step. For a typical `.yml` workflow, it might look something like this:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '16'
      - name: Install dependencies for all platforms
        run: npm_config_platform=all npm install
      - name: Build project
        run: npm run build
```
