---
parent: "Github Actions"
grand_parent: Topics
layout: default
title: "Github Actions: Workflow 02"
description:  "Rebuild content of gh-pages branch (part 1)"
---

# {{page.title}} - {{page.description}}

Workflow `02-gh-pages-rebuild-part-1.yml` consists of three parts:

* Preliminaries
* Six jobs that rebuild the gh-pages site for the main branch, and run in parallel
* A matrix of six jobs that rebuild the gh-pages site for each PR, and also run in parallel

## Uploading Artifacts

The workflow [`actions/upload-artifact`](https://github.com/actions/upload-artifact) is used in various places to upload artifacts that are then downloaded and deployed to the
gh-pages branch in the workflow `04-gh-pages-rebuild-part-2.yml`.

Here's an example:

```yml
    - name: Upload to artifacts
      uses: actions/upload-artifact@v4
      with:
          name: javadoc
          path: ${{ env.destination }}
          overwrite: true
```

Here:
* `name` is a key used for the key/value store used by Github Actions for artifacts
* `path` is the location that the artifact should be retrieved from.  When it is described by a variable `${{ env.destination }}` it is because a *previous* step used that as the destination to store something (e.g. the generated javadoc, coverage report, etc.).
* `overwrite: true` is needed because the `actions/upload-artifact`, by default, will not overwrite a previously uploaded artifact.

The names currently used in the script are:

|                job    | Artifact Name                    | Explanation                                                              |
|-----------------------|----------------------------------|--------------------------------------------------------------------------|
| `a - Javadoc (main)`  |  `javadoc`                       | Javadoc, HTML documentation                                     |
| `b - Chromatic (main)`| `chromatic`                      | Storybook and Chromatic Build, HTML redirect to Chromatic.com   |
| `c - Jacoco (main)`   | `jacoco`                         | Test Coverage (java, backend), HTML report                               |
| `d - Pitest (main)`   | `pitest`                         | Mutation testing (java, backend), HTML report                            |
| `e - Coverage (main)` | `coverage`                       | Test Coverage (javascript, frontend), HTML report                        |
| `f - Stryker (main)`  | `stryker-incremental-main.json` | Mutation Test Coverage (javascript, frontend); data for incremental runs |
| `f - Stryker (main)`  | `stryker`                       | Mutation Test Coverage (javascript, frontend); HTML report               |
| `a - Javadoc (PR, branch)`  |  <tt>prs-<i>num</i>-javadoc</tt>                       | Javadoc, HTML documentation                                     |
| `b - Chromatic (PR, branch)`| <tt>prs-<i>num</i>-chromatic</tt>                      | Storybook and Chromatic Build, HTML redirect to Chromatic.com   |
| `c - Jacoco (PR, branch)`   | <tt>prs-<i>num</i>-jacoco</tt>                         | Test Coverage (java, backend), HTML report                               |
| `d - Pitest (PR, branch)`   | <tt>prs-<i>num</i>-pitest</tt>                         | Mutation testing (java, backend), HTML report                            |
| `e - Coverage (PR, branch)` | <tt>prs-<i>num</i>-coverage</tt>                       | Test Coverage (javascript, frontend), HTML report                        |
| `f - Stryker (PR, branch)`  | <tt>prs-<i>num</i>-stryker-incremental-main.json</tt>  | Mutation Test Coverage (javascript, frontend); data for incremental runs |
| `f - Stryker (PR, branch)`  | <tt>prs-<i>num</i>-stryker</tt>                        | Mutation Test Coverage (javascript, frontend); HTML report               |

