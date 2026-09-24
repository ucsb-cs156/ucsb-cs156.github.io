---
parent: Staff
layout: default
title: "Autograders"
description:  "Information about Gradescope Autograders"
---

# {{page.title}} - {{page.description}}

The autograders for Gradescope assignments typically live in private repos in the ucsb-cs156 organization, where students are not members (only staff).

## Updating an assignment with Claude

When an assignment needs to be updated for a new Java version, a new Node.js
version, or another toolchain change, use Claude to audit the complete set of
repositories and instructions together. Make the changes in a consolidated
wave for one assignment, validate them, and merge the related pull requests
only after the whole assignment workflow is working.

For each assignment `xxx`, align these four surfaces:

1. The starter code in `ucsb-cs156-f26/STARTER_xxx`.
2. The autograder in `ucsb-cs156/autograder_xxx`.
3. The assignment-specific instructions in the term repository, such as
	`f26/lab/xxx.md` and the relevant setup page in `f26/info/`.
4. The shared installation instructions in this repository, especially
	`info/software.md` and the relevant platform pages under `topics/`.

Ask Claude to inspect the build files, version selectors, Maven or npm
wrappers, CI workflows, shell setup scripts, test fixture paths, and every
installation command. It should search for stale version literals and naming
variants, check the actual local or CI toolchain, run the narrow tests first,
and then build the documentation site. Keep the source of truth for shared
version values in the appropriate `_config.yml` and use the matching Liquid
variables in documentation. For example, use `jdk_distribution` with an
underscore, not `jdk-distribution`.

### JPA00 example

The JPA00 update moved the course setup to Java `25.0.4` with the SDKMAN
distribution `25.0.4-tem` and Maven `3.9.14` or newer. The work found and fixed
both environment drift and incorrect CI paths: the autograder was selecting
Java 21, its Maven wrappers were stale, and its meta-test command referenced
the wrong starter and autograder directories.

The four example pull requests are:

- [f26 course instructions](https://github.com/ucsb-cs156/f26/pull/2)
- [JPA00 starter code](https://github.com/ucsb-cs156-f26/STARTER-jpa00/pull/3)
- [JPA00 autograder](https://github.com/ucsb-cs156/jpa00-autograder/pull/3)
- [shared installation and WSL instructions](https://github.com/ucsb-cs156/ucsb-cs156.github.io/pull/11)

The f26 PR also contains the maintenance handoff file
[`course-maintenance/jpa00-java25-migration.md`](https://github.com/ucsb-cs156/f26/blob/fix/java25-docs/course-maintenance/jpa00-java25-migration.md).
Use it as an example of the context to preserve for Claude and future staff:
it records the repositories and files to inspect, configuration lessons,
validation steps, and the additional technology surfaces to consider as later
assignments add Spring Boot, Dokku, or frontend tooling.

Before starting the next assignment, read that handoff and adapt its checklist
to the assignment's technology. Keep the work assignment-focused: complete
and double-check JPA00 before beginning JPA01, then repeat the same four-way
alignment process for JPA02 and later assignments.

