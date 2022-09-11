---
parent: React
grand_parent: Topics
layout: default
title: "React: UseSWR"
description:  "SWR, Stale While Revalidating, is a hooks based protocol for updating state in React apps"
category_prefix: "React: "
indent: true
---

UseSWR (Stale While Revalidating), is a hooks based protocol for updating state in React apps

As an example, consider this code:

```javascript
const { data: todoList, error, mutate: mutateTodos } = useSWR(
    ["/api/todos", getToken],
    fetchWithToken
  );
```

In this code, the array `["/api/todos", getToken]` is the list of parameters that will be passed to the function `fetchWithToken`.

TODO: Add more explanation and/or links to useful articles tutorials...
