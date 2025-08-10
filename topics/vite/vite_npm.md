---
parent: Agile
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

Here's a conversation with Gemini that explains the fix:

> I'm builiding a vite project on mac os, but then trying to deploy it on CI/CD systems and docker containers that use linux.
>
> I'm getting this:
>
> Error: Cannot find module @rollup/rollup-linux-x64-gnu. npm has a bug related to optional dependencies (https://github.com/npm/cli/issues/4828). Please try `npm i` again after removing both package-lock.json and node_modules directory.
>
> I suspect that it may be because I need to do something special when I build my package-lock.json to ensure that versions of dependencies for linux-x64-gnu are included along with version for MacOS. Am I on the right track? Can you help me figure out what needs to go in package.json or my workflow to fix this?

That's a frustrating error! You're on the right track. The issue is that **`npm` or `yarn` by default will only install platform-specific optional dependencies for the operating system they are run on**. When you build your project on macOS, your `package-lock.json` file is created with the macOS dependencies, but it doesn't include the dependencies required for Linux. The build then fails on the CI/CD system or Docker container because it can't find the necessary Linux packages.

### The Fix:

The solution is to tell `npm` to install all optional dependencies, regardless of the platform. You can do this by using the `npm i --include=optional` command, but a more direct approach is to **set the `npm_config_platform` and `npm_config_arch` environment variables** to a value that will install all optional dependencies.

Here’s what you need to do:

1.  **Remove existing lock files and `node_modules`:**
    ```bash
    rm -rf package-lock.json node_modules yarn.lock
    ```
2.  **Install dependencies with all optional dependencies:**
    You need to set the environment variables to tell `npm` to install dependencies for **all platforms**, not just the current one. The recommended way to do this is to set `npm_config_platform` to a value that doesn't match a real platform, which forces `npm` to download all optional dependencies. A common practice is to use a placeholder like `npm_config_platform=all`.

    For example, with `npm`:
    ```bash
    npm_config_platform=all npm install
    ```

    Or, with `yarn`:
    ```bash
    yarn install --ignore-optional
    ```
    And then install them separately:
    ```bash
    yarn install --ignore-scripts --frozen-lockfile
    ```

---

### Workflow Integration:

You should add this command to your CI/CD workflow before the build step. For example, if you're using a `.yml` file for your workflow, it might look something like this:

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
