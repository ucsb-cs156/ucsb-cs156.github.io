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

### JPA02, JPA03 and team01 examples

The same process was then applied to JPA02 (Spring Boot, JaCoCo and PIT
thresholds) and JPA03 (Spring Boot with a database, OAuth, Dokku Dockerfile
and actuator-based autograder checks). Each wave has its own handoff file in
`f26/course-maintenance/`, which records the versions chosen, the surprises
(for example, JaCoCo 0.8.12 silently mis-measuring Java 25 class files, PIT
1.23+ dropping built-in history, and JDK 23+ no longer running Lombok without
`-proc:full`), the validation performed, and the PR links:

- JPA02: [`course-maintenance/jpa02-java25-migration.md`](https://github.com/ucsb-cs156/f26/blob/main/course-maintenance/jpa02-java25-migration.md);
  PRs: [f26](https://github.com/ucsb-cs156/f26/pull/8),
  [starter](https://github.com/ucsb-cs156-f26/STARTER-jpa02/pull/3),
  [autograder](https://github.com/ucsb-cs156/jpa02-autograder/pull/5),
  [shared docs](https://github.com/ucsb-cs156/ucsb-cs156.github.io/pull/14)
- JPA03: [`course-maintenance/jpa03-java25-migration.md`](https://github.com/ucsb-cs156/f26/blob/main/course-maintenance/jpa03-java25-migration.md);
  PRs: [f26](https://github.com/ucsb-cs156/f26/pull/10),
  [starter](https://github.com/ucsb-cs156-f26/STARTER-jpa03/pull/2) (its description is the master list for the wave),
  [autograder](https://github.com/ucsb-cs156/jpa03-autograder/pull/9),
  [shared docs](https://github.com/ucsb-cs156/ucsb-cs156.github.io/pull/16)
- team01: [`course-maintenance/team01-java25-migration.md`](https://github.com/ucsb-cs156/f26/blob/main/course-maintenance/team01-java25-migration.md);
  PRs: [f26](https://github.com/ucsb-cs156/f26/pull/12),
  [starter](https://github.com/ucsb-cs156-f26/STARTER-team01/pull/4) (its description is the master list for the wave),
  [autograder](https://github.com/ucsb-cs156/team01-autograder/pull/11),
  [shared docs](https://github.com/ucsb-cs156/ucsb-cs156.github.io/pull/18)

team01 is a good example of a starter that had *already* been bumped to Java 25
in its `pom.xml` before the four-surface audit ran; the audit still found the
rest of the assignment out of step. Things that were different from JPA03:

- The team01 starter uses the shared reusable workflows in
  [`ucsb-cs156/workflows`](https://github.com/ucsb-cs156/workflows) (JaCoCo,
  Pitest, schema validation), which select Java with
  `actions/setup-java` and `java-version-file: ./.java-version`. `setup-java`
  cannot parse the SDKMAN form `25.0.4-tem`, so for these starters
  `.java-version` must stay `25`, and `.sdkmanrc` is the file that carries
  the full SDKMAN identifier. The starter's own workflows were also on
  `distribution: semeru` while the reusable ones default to `temurin`.
- The Dokku `Dockerfile` (`ubuntu:22.04` + apt `openjdk-25-jdk`) did build on
  amd64, but with apt's Maven 3.6 and a hard-coded
  `JAVA_HOME=/usr/lib/jvm/java-25-openjdk-amd64`, so `docker build` fails on
  Apple Silicon. The two-stage Temurin image from STARTER-jpa03 replaces it.
- The autograder compiles and runs Spring Boot tests against the student's
  code (it injects `jgrade2` and `reflections` into the student's `pom.xml`
  with pom-cli), so a JDK older than the starter's breaks every submission;
  it was still installing Java 21. Its roster and staff list are data files
  that staff must refresh by hand each quarter.
- PIT `1.30.0` together with `org.pitest:pitest-history-plugin:0.0.1` works
  with the incremental pitest workflow, which is the alternative to pinning
  PIT `1.22.1` as JPA03 did.

### Lombok stops compiling on Java 23 and later

This one is worth calling out because the symptom does not mention Lombok
at all. After moving a Spring Boot starter that uses Lombok (JPA03, team01,
team02 and every legacy project) to Java 25, `mvn test` fails at compile
time with dozens of errors like:

```
[ERROR] .../ExampleApplication.java:[30,7] cannot find symbol
  symbol:   variable log
  location: class edu.ucsb.cs156.example.ExampleApplication
[ERROR] .../SystemInfoServiceImpl.java:[39,31] cannot find symbol
  symbol:   method builder()
  location: class edu.ucsb.cs156.example.models.SystemInfo
```

Every missing symbol is something Lombok generates (`log` from `@Slf4j`,
`builder()` from `@Builder`, getters from `@Data`, and so on). The cause is
that starting with JDK 23, `javac` no longer runs annotation processors that
it merely finds on the classpath; they must be enabled explicitly, and Lombok
is an annotation processor. The fix is a `maven-compiler-plugin`
configuration in the `pom.xml`:

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <configuration>
        <!-- JDK 23+ no longer runs annotation processors (e.g. Lombok) found on the
             classpath by default; -proc:full restores that behavior. -->
        <compilerArgument>-proc:full</compilerArgument>
    </configuration>
</plugin>
```

No version is needed because the Spring Boot parent manages the plugin
version. JPA00, JPA01 and JPA02 do not use Lombok, so they compiled on
Java 25 without this; expect it on every assignment from JPA03 onward, and
check for it first whenever a Java upgrade produces a wall of
`cannot find symbol` errors. `proj-courses` and `STARTER-jpa03` both carry
this configuration and can be used as a reference.

### Files that carry staff and student information

A toolchain update is also the moment to refresh the per-quarter data the
autograders and instructions depend on. These files are not derivable from
the code, so Claude will leave them alone or flag them; a staff member has to
supply the values. Check each of these every quarter, for every assignment:

**In each autograder repo (`ucsb-cs156/jpaXX-autograder`, `team0X-autograder`):**

- `autograder/tools/roster.csv`: the student roster in the 13-column
  Frontiers export format
  (`COURSEID,EMAIL,FIRSTNAME,GITHUBID,GITHUBLOGIN,ID,LASTNAME,ORGSTATUS,ROSTERSTATUS,SECTION,STUDENTID,TEAMS,USERID`).
  `repo_matcher.py` uses `EMAIL` and `GITHUBLOGIN` to map the Gradescope
  submitter to their `jpaXX-githubid` repo; `verify_admin_emails.py` uses
  `TEAMS` to compute which teammates must appear in `ADMIN_EMAILS`. Add
  `*-staff` rows by hand if staff want to submit to Gradescope and pass the
  team-member check (the Frontiers export does not include staff).
- `autograder/tools/verify_admin_emails.py` (jpa03, team01, team02): the
  `staff_emails` list at the top of the file. Every email here must be in the
  student's `ADMIN_EMAILS`, so it must match the list students are told to
  use. Paste the list from the `#staff-resources` Slack channel.
- `autograder/run_autograder`: `GITHUB_ORG` (for example `ucsb-cs156-f26`),
  used to look up the student's repo, GitHub Pages site and workflow status.
- `.github/README.md`: the "Quarterly Updates" notes that describe the above.

**In the term repo (`ucsb-cs156/f26`):**

- `_config.yml`: `quarter`, `QXX`/`qxx`, `sample_team`, `ta_list_full`,
  `la_list_full`, `discussion_section_day` / `discussion_section_times`,
  the `aux_links` Canvas URL, and the Slack channel data used by
  `_includes/slack.html`.
- `lab/jpa03.md`, `lab/jpa04.md`, `lab/team01.md`: the `staff_emails` front
  matter, plus `course_org`, `course_org_name`, `starter_repo` and
  `example_running_app`. Keep `staff_emails` identical to the list in
  `verify_admin_emails.py`; the lab pages tell students to find the staff
  emails on the assignment's Slack help channel, so post the same list there.
- `_staffers/` and `office-hours.md`: the staff roster and office hours the
  lab pages link to.

**In the starter repos (`ucsb-cs156-f26/STARTER-*`):**

- `.env.SAMPLE` and the `app.admin.emails` default in
  `src/main/resources/application.properties`: the instructor's email is the
  fallback admin; students add their own and the staff list on top of it.
- `README.md` and `docs/*.md`: links to the course org, the example running
  app (`jpa03-staff.dokku-00.cs.ucsb.edu`) and `dokku git:sync` URLs that
  embed the org name.

In the JPA03 wave the roster and `GITHUB_ORG` were updated, but the
`staff_emails` list in `verify_admin_emails.py` and the `staff_emails` front
matter in `lab/jpa03.md` were left at the previous quarter's values because
the F26 staff list was not yet final; those two are recorded as follow-ups in
the JPA03 handoff.

Before starting the next assignment, read that handoff and adapt its checklist
to the assignment's technology. Keep the work assignment-focused: complete
and double-check JPA00 before beginning JPA01, then repeat the same four-way
alignment process for JPA02 and later assignments.

