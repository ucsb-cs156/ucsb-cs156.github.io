---
parent: Topics
layout: default
title: "Maven: Skip Tests"
description:  "how to run commands while skipping tests"
indent: true
category_prefix: "Maven: "
---

To skip tests when running Maven commands that would normally invoke them, such as `mvn package` you can use:

* `-Dmaven.skip.tests` or `-DskipTests`

Example:

```
mvn package -Dmaven.skip.tests
```

For more info, see: <https://maven.apache.org/plugins-archives/maven-surefire-plugin-2.12.4/examples/skipping-test.html>
