---
parent: Stryker
grand_parent: Topics
layout: default
title: "Stryker: html attribute surviving mutants"
description:  "Hints on resolving these"
---

Here is an example of a mutation report showing that a mutation eliminating an HTML attribute that survived:

<img width="605" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/e4a3eeb7-4afc-4545-b7a4-b2ccbd1f0763">


This is showing that the code:
```
        <Button style={{ float: "right" }} as={Link} to="/hotels/create">

``` 

Was mutated to the following (removing `float: "right"`), without any tests failing (i.e. "the mutant survived").
```
        <Button style={{  }} as={Link} to="/hotels/create">
``` 

To fix this, you can add this to your test, where `thisButton` is a handle to the button in question:

```
        expect(thisButton).toHaveAttribute("style", "float: right;");
```

For example, here's what that looks like in context.

With `screen` included in the import from `@testing-library/react`:
```
import { fireEvent, render, waitFor, screen } from "@testing-library/react";
```

We can write:

```
    const createHotelButton = screen.getByText("Create Hotel");
    expect(createHotelButton).toBeInTheDocument();
    expect(createHotelButton).toHaveAttribute("style", "float: right;");
```
