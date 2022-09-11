---
parent: JavaScript
grand_parent: Topics
layout: default
title: "JavaScript: Destructuring"
description:  "Assigning multiple variables at once using ECMAScript 6 destructuring"
category_prefix: "JavaScript: "
---

# {{page.title}}

In modern JavaScript (e.g. ECMAScript 6), there is a feature called destructuring.

Here's an example fron some real code:

```
  const { user, getAccessTokenSilently: getToken } = useAuth0();
  const { data: todoList, error, mutate: mutateTodos } = useSWR(
    ["/api/todos", getToken],
    fetchWithToken
  );
```

To make sense of this, here's a toy example:

```
  function foo() {
    return {a:3, b:5, c:7}
  }
  const {a, b, c} = foo();
```

The result of `const {a, b, c} = foo();` is that three variables are created in the local scope, `a`, `b`, and `c`, with `a=3; b=5; c=7;`

Suppose instead, we did:
```
  const {a, b:x, c} = foo();
```

Then the result would be three variables are created in the local scope, `a`, `x`, and `c`, with `a=3; x=5; c=7;`

