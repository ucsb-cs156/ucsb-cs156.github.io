---
parent: Topics
layout: default
title: "React: Introduction"
description:  "Helpful tips for working with frontend code in CS156"
category_prefix: "React: "
indent: true
---

This page is not intended to be a full React tutorial, but a brief overview of some of the 
most important things you need to have at your finger tips when working with React code.


For a good React tutorial, visit: <https://beta.reactjs.org/learn>

# What is a React Component?

* A React Component is portion of a User Interface.
* By convention, it has a name that starts with a capital letter (e.g. `StudentList`, `CourseForm`, `AdminPage`).
* It can be an entire web page, or just a portion of a page.
* It is considered good practice to write *small* components, i.e. to break down a larger user interface, e.g. an entire web page,
  into smaller components that can be developed, tested, documented and maintained separately.

As an example, here is a animated screenshot of the Home Page of [proj-ucsb-courses-search](http://proj-ucsb-courses-search.herokuapp.com/).

![courses-page-components](proj-ucsb-courses-search-home-page-components.gif)

Here are just a few of the components on this page:

* The entire page is a component, [`main/pages/Home/Home.js`](https://github.com/ucsb-cs156-s21/proj-ucsb-courses-search/blob/main/javascript/src/main/pages/Home/Home.js)
* With the page, there are several components, shown with various colors of dotted outlines, including:
  -  The navigation bar: [`main/components/Nav/AppNavbar.js`](https://github.com/ucsb-cs156-s21/proj-ucsb-courses-search/blob/main/javascript/src/main/components/Nav/AppNavbar.js), which is included in `main/App.js`
  -  The authorization part of the navbar: [`main/components/Nav/AuthNav.js`](https://github.com/ucsb-cs156-s21/proj-ucsb-courses-search/blob/main/javascript/src/main/components/Nav/AuthNav.js), which is included in `AppNavbar.js`
  -  The form that is used to select courses:  [`main/components/BasicCourseSearch/BasicCourseSearchForm.js`](https://github.com/ucsb-cs156-s21/proj-ucsb-courses-search/blob/main/javascript/src/main/components/BasicCourseSearch/BasicCourseSearchForm.js), which is included in `main/pages/Home/Home.js`
  -   The table legend:  [`main/components/BasicCourseSearch/TableLegend.js`](https://github.com/ucsb-cs156-s21/proj-ucsb-courses-search/blob/main/javascript/src/main/components/BasicCourseSearch/TableLegend.js), which is included in `main/pages/Home/Home.js`
  -   The course filters:  [`main/components/BasicCourseSearch/CourseFilters.js`](https://github.com/ucsb-cs156-s21/proj-ucsb-courses-search/blob/main/javascript/src/main/components/BasicCourseSearch/CourseFilters.js), which is included in `main/pages/Home/Home.js`
  -  The table of course results:  [`main/components/BasicCourseSearch/BasicCourseTable.js`](https://github.com/ucsb-cs156-s21/proj-ucsb-courses-search/blob/main/javascript/src/main/components/BasicCourseSearch/BasicCourseTable.js), which is included in `main/pages/Home/Home.js`
  -  The footer for the page:  [`main/components/Footer/AppFooter.js`](https://github.com/ucsb-cs156-s21/proj-ucsb-courses-search/blob/main/javascript/src/main/components/Footer/AppFooter.js), which is included in `main/App.js`
 

# We use function based components, not class based

React Components can be written in two ways:
* Class based, with a structure where they inherit from `Component`, have constructors, and methods such as `componentDidMount`, and `componentDidUpdate`.  
  - *We generally do not use this form of React component in CMPSC 156*.
* Function based components, with a structure where the top level of the component is an *arrow function*.  
  - *This is the style of React component we generally use in CMPSC 156*.
  - This style of component uses *hooks*, which we'll explain more in detail at a later stage.

# New React Components go under `javascript/src/main/components` and  `javascript/src/main/pages`

New components should be placed in:
* `javascript/src/main/components` for all nearly all components (i.e. those that represent a portion of a page).
* `javascript/src/main/pages` only for components that represent a *full page* in the app

For page components, a recommended CMPSC 156 naming convention is to add `Page` to the end of the component name, as shown in this 
screen shot from the starter code for `team02` from S21, and keep them in a flat directory. Note that this convention may not always have been followed in the legacy code projects in the past, but it would be desirable to move in the direction of this convention over time.
     
![Page components from team02](team02-page-components-50pct.png)   
     
For the rest of the components, it may be useful to have a second level of directory to organize related components,
as shown in these examples:

| team02 | proj-ucsb-courses-search | proj-ucsb-cs-las | proj-mapache-search |
|-|-|-|-|
| ![team02-components](team02-components-50pct.png) | ![courses-components](courses-components-50pct.png)  | ![las-components](las-components-50pct.png)  | ![mapache-components](mapache-components-50pct.png) |
{:.table .table-sm .table-striped .table-bordered}


# Basic Outline of a Component

Here is a basic outline of a component that just displays a HTML `<h2>` heading element with text in it.

```jsx
import React from "react";

const Header = ({ text }) => {
  return (
    <h2> 
      {text}
    </h2>
  );
};

export default Header;
```

And here is a line-by-line explanation.

Line 1 is: `import React from "react";`

This indicates that we are writing a React component, and makes
`React` available in the file.  In more recent versions of React, you
technically no longer need this line, but you'll frequently see it.

The next few lines, if we strip out the parameters, and the body, have the form:

```jsx
const Header = () => {};
```

That is, we are declaring a new variable `Header`, and it happens to refer to an *arrow function*, which is
a type of value in Javascript.

By convention, React components take one exactly one parameter called `props`.  However, through something called
destructuring, it is possible to pass multiple parameters, by enclosing the params in `{}`.  So, here
we see that `Header` takes one parameter called `text`:

```
const Header = ({ text }) => {};
```

We now see that inside the `{}` we have a return statement that returns some HTML.  This is the end result
of all React components:

```
const Header = ({ text }) => {    // Overall, this is a function declaration, e.g. const Header = () => {};
  return (
    <h2> 
      {text}
    </h2>
  );
};
```

Each React component should return a single component, or HTML element.  It may have other HTML elements or components nested inside, but at the top
level, just there should be just one.  If you need to return multiple elements or components, you need to wrap them in what's called a *fragment* tag, as in this example
from the [React documentation](https://reactjs.org/blog/2017/11/28/react-v16.2.0-fragment-support.html).  Here the `<>` and `</>` are used at the top level to indicate that the three children should be returned as if they were one HTML element.


```jsx
render() {
  return (
    <>
      <ChildA />
      <ChildB />
      <ChildC />
    </>
  );
}
```
 
# New Components should have tests, and stories 
 
When adding a file for a new component such as `src/main/components/General/Header.js`, you should also add:
* A file with tests for that component, e.g. `src/test/components/General/Header.test.js`
* A file with stories for the storybook.  This may be in one of two formats:
  - `src/stories/components/General/Header.stories.js` (Javascript format)
  - `src/stories/components/General/Header.stories.mdx` (MDX format, which is a mix of Markdown and JSX)
  The MDX format is a lot more expressive, and is recommended for new components. Some older stories may have been
  written in the JS format.

# Writing a test 

Here's a very simple example test for our Header component.  You run the test in the `javascript` directory using `npm test`:

```js
import React from "react";
import { render } from "@testing-library/react";
import Header from "main/components/General/Header";

describe("Header tests", () => {
  test("The component should include the text", () => {
    const { getByText } = render(
      <Header 
         text={"Go Gauchos!"}
      />
    );
    expect(getByText("Go Gauchos!")).toBeInTheDocument();
  });
});
```

# Writing a story

Here's a simple example of a Story file written in JavaScript.  You check the storybook using `npm run storybook`.  

Note that while some errors may show up in the console where you ran `npm run storybook`.
most of the errors (if any) building the storybook  show up in the *console of the browser*, not the console
of the terminal session.  You'll need to right click in the browser window, select `Inspect Element`, and then
find the console in the developer panel that pops up.

```

import React from 'react';

import Header from "main/components/General/Header";

export default {
    title: 'components/General/Header',
    component: Header
};

const Template = (args) => {
    return (
        <Header {...args} />
    )
};


export const example1 = Template.bind({});
example1.args = { text: "Go Gauchos!" };

export const example2 = Template.bind({});
example2.args = { text: "Ole Ole Ole!" };
```

And here is a story for the same component written in .mdx

```mdx
import { Meta, Story, Canvas } from "@storybook/addon-docs/blocks";
import Header from "main/components/General/Header";

<Meta title="components/General/Header" component={Header} />

# Header

The `Header` component can be used to create an `<h2>` header.
It takes a single parameter, `text`, which should be a string
containing the header text.

Example:

`{% raw %}`{% endraw %}`jsx
    <Header text={Go Gauchos!} />
`{% raw %}`{% endraw %}`

export const Template = (args) => <Header {...args} />;

<Canvas>
  <Story
    name="Example 1"
    args={% raw %}{{{% endraw %}
      label: "Example 1",
      text: "Go Gauchos!",
    {% raw %}}}{% endraw %}
  >
    {Template.bind({})}
  </Story>
</Canvas>

A second example:

<Canvas>
  <Story
    name="Example 2"
    args={% raw %}{{{% endraw %}
      label: "Example 2",
      text: "Ole Ole Ole!",
   {% raw %}}}{% endraw %}
  >
    {Template.bind({})}
  </Story>
</Canvas>
```

# Next Steps

Read the [article on common React component pattern in our Code Base](https://ucsb-cs156.github.io/topics/react_patterns/).  It explains, among other things:
* Implementing a data entry form
* Implementing a data table
* etc.

We also have an article about [implementing a top level page](https://ucsb-cs156.github.io/topics/react_page_components/)
