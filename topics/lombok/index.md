---
parent: Topics
layout: default
title: "Lombok: "
description:  "Automatic generation of getters/setters, etc."
category_prefix: "Lombok: "
has_children: true
---

Lombok is a package that allows the automatic generation of boilerplate code such as getters, setters, toString, hashCode, etc.

Documentation is at <https://projectlombok.org/>

The Maven dependency can be found at: <https://mvnrepository.com/artifact/org.projectlombok/lombok>.

The most basic use case is to add the following import:

```
import lombok.Data;
```

Then, simply make a class with all private attributes, prefixed by the annotation `@Data`:

```
import lombok.Data;

@Data
public class Foo {
  private int x;
  private double y
  private String name;
  private Bar bar;
}
```

Lombok will automatically generate appropriate getters, settters, a `toString`, a `hashCode` and `equals` method, etc.


