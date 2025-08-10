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

## Some more information from Copilot

### Cleaning and Installing Node Modules with frontend-maven-plugin

If you are using the [frontend-maven-plugin](https://github.com/eirslett/frontend-maven-plugin) (e.g., `com.github.eirslett:frontend-maven-plugin`), you don’t have direct shell access to run commands like `rm -rf node_modules package-lock.json` in your CI workflow. Instead, you can leverage npm scripts and the plugin’s configuration to ensure a clean install.

### Why Is This Needed?

Sometimes, npm (especially with packages like `rollup` and its native bindings) can run into issues with optional dependencies or incorrect package-lock states. To work around this, it can help to remove both `node_modules` and `package-lock.json` before installing dependencies.

### Step-by-Step Instructions

#### 1. Add a Clean Script in `package.json`

Add a script in your `frontend/package.json` to remove `node_modules` and `package-lock.json`:

```json
"scripts": {
  "clean-lock": "rm -rf node_modules package-lock.json"
}
```
**Note:**  
- On Windows runners, use [rimraf](https://www.npmjs.com/package/rimraf) for cross-platform compatibility:
  ```json
  "clean-lock": "rimraf node_modules package-lock.json"
  ```
  and add rimraf as a dev dependency:  
  `npm install --save-dev rimraf`

#### 2. Update `pom.xml` to Call the Clean Script

Add an execution phase to your `frontend-maven-plugin` block to run the clean script before install:

```xml
<execution>
  <id>npm clean-lock</id>
  <goals>
    <goal>npm</goal>
  </goals>
  <configuration>
    <arguments>run clean-lock</arguments>
  </configuration>
</execution>
```

#### 3. Use `npm install` with the Correct Environment Variable

Update your install step to use `install` (instead of `ci`), and set the `npm_config_platform` variable:

```xml
<execution>
  <id>npm install</id>
  <goals>
    <goal>npm</goal>
  </goals>
  <configuration>
    <arguments>install</arguments>
    <environmentVariables>
      <npm_config_platform>all</npm_config_platform>
    </environmentVariables>
  </configuration>
</execution>
```

#### 4. Full Example Plugin Block

Here is how your full `frontend-maven-plugin` configuration might look:

```xml
<plugin>
  <groupId>com.github.eirslett</groupId>
  <artifactId>frontend-maven-plugin</artifactId>
  <version>1.12.1</version>
  <configuration>
    <workingDirectory>frontend</workingDirectory>
    <installDirectory>${project.build.directory}</installDirectory>
    <skip>${frontend.skip}</skip>
  </configuration>
  <executions>
    <execution>
      <id>install node and npm</id>
      <goals>
        <goal>install-node-and-npm</goal>
      </goals>
      <configuration>
        <nodeVersion>v22.18.0</nodeVersion>
      </configuration>
    </execution>
    <execution>
      <id>npm clean-lock</id>
      <goals>
        <goal>npm</goal>
      </goals>
      <configuration>
        <arguments>run clean-lock</arguments>
      </configuration>
    </execution>
    <execution>
      <id>npm install</id>
      <goals>
        <goal>npm</goal>
      </goals>
      <configuration>
        <arguments>install</arguments>
        <environmentVariables>
          <npm_config_platform>all</npm_config_platform>
        </environmentVariables>
      </configuration>
    </execution>
    <execution>
      <id>npm run build</id>
      <goals>
        <goal>npm</goal>
      </goals>
      <configuration>
        <arguments>run build</arguments>
      </configuration>
    </execution>
  </executions>
</plugin>
```

### Additional Notes

- Always verify that your clean script runs successfully in your CI logs.
- Make sure your CI pipeline is not caching old `node_modules` or `package-lock.json` between runs.
- If you are on Windows, scripts using `rm -rf` will fail. Use a cross-platform solution like `rimraf`.

### Summary

To reliably resolve optional dependency and lockfile issues with npm in Maven-based projects, use an npm clean script plus a fresh install via the `frontend-maven-plugin`. This approach ensures that your dependencies are always re-installed from scratch, minimizing platform-specific issues.
