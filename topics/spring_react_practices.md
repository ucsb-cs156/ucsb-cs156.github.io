---
parent: Topics
layout: default
title: "Spring/React: Practices"
description:  "Practices that we encourage in our code bases"
category_prefix: "Spring React: "
indent: true
---

Over time, as our community of practice has learned more about Spring, React, and the other various frameworks we are using, we
have adopted certain practices to keep the code base clean.

You will notice that these practice are not uniformly observed throughout the code base.  This is because new practices are discovered
on an ongoing basis, and it is not always feasible to go back and revise all of the code each time a new practice is adopted.

The list below contains certain practices that should be used going forward, and incorporated into the older code as time permits.

# Use `lombok.Data` to generate setters/getters/toString/equals/hashCode

On classes that are primarily records that store data (e.g. most `@Entity` classes, most `model` type classes), rather than
writing setters and getters from scratch, along with `toString`, `equals` and `hashCode`, you can simply annotate the class
with `@Data`, and add:

```
import lombok.Data
```

For more information, see: <https://projectlombok.org/features/Data>

# Use `@Slf4j` instead of creating logger from scratch

In the Java code, you will sometimes see these imports:

```
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
```

And a declaration near the top of the file:

```
  private Logger logger = LoggerFactory.getLogger(Auth0MembershipService.class);
```

These can be replaced with this import:

```
import lombok.extern.slf4j.Slf4j;

```

And this annotation at the start of the class:

```
@Slf4j
```

You can then change all instance of `logger` to `log` (the variable that is automatically declared by the `@Slf4j` annotation.
