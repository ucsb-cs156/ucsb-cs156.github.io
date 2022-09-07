---
parent: Topics
layout: default
title: "MongoDB: Spring Properties"
description:  "How to set properties for connecting to MongoDB when using Spring"
category_prefix	: "MongoDB: "
indent: true
---

The best way to set the connection to a MongoDB database when using Spring is to set the value of the property:

```
spring.data.mongodb.uri=
```

Sometimes you'll be provided with a connection URI such as this one:

```
mongodb+srv://<username>:<password>@cluster0.a1bcd.mongodb.net/<dbname>?retryWrites=true&w=majority
```

It is important to note that `<username>`, `<password>` and `<dbname>` need to be replaced with actual values that
you would be supplied with separately.

When you replace the values, do not include the `<>` characters.
