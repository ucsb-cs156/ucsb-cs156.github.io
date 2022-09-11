---
parent: React
grand_parent: Topics
layout: default
title: "React: Page Components"
description:  "Writing components for a top level page"
category_prefix: "React: "
indent: true
---

A page component is a React component that represents a full page in the app.

# Basic outline for page component

A simple Page Component looks like this:

```jsx
import React from "react";
import { Jumbotron } from "react-bootstrap";

const HomePage = () => {
  return (
    <Jumbotron>
      <div className="text-left">
        <h5>Welcome to the (Changeme To App Name) App!</h5>
        <p>This is where your home page content goes</p>
      </div>
    </Jumbotron>
  );
};

export default HomePage;
```

The first line, `import React from "react";` is no longer strictly necessary in later versions of React, but you'll often see it.

The second line, `import { Jumbotron } from "react-bootstrap";` imports a `Jumbotron` component that we are using to display text.
You can find other components that may be useful at the documentation for React Bootstrap here: <https://react-bootstrap.github.io/>

Then, we see a variable declaration, one that declares the variable `HomePage` to be a JavaScript arrow function:

```
const HomePage = () => { ... }
```

That indicates that this React component is a functional component (i.e. the "Hooks" style of React programming), as opposed to a class-based React component.   

That information may be useful if you are trying to understand React articles and documentation.  The other style, which we are generally *not* using in this course, looks like this:

```
// DON'T WRITE COMPONENTS THIS WAY IN CMPSC 156 UNLESS YOU HAVE A REALLY GOOD REASON

import React, { Component } from "react";
import { Jumbotron } from "react-bootstrap";

class HomePage extends Component { // We don't do it this way in CMPSC 156
  render() {
    return (
     <Jumbotron>
        <div className="text-left">
          <h5>Welcome to the (Changeme To App Name) App!</h5>
          <p>This is where your home page content goes</p>
        </div>
     </Jumbotron>
    );
  }
}
```

# Where to put a page component

New page  should be placed in `javascript/src/main/pages`.

This directory is only for components that represent a *full page* in the app

For page components, a recommended CMPSC 156 naming convention is to add `Page` to the end of the component name, as shown in this 
screen shot from the starter code for `team02` from S21, and keep them in a flat directory. Note that this convention may not always have been followed in the legacy code projects in the past, but it would be desirable to move in the direction of this convention over time.
     
![Page components from team02](team02-page-components-50pct.png)   
   

# Registering page with React Router in `src/main/App.js` 

TODO: finish this discussion
