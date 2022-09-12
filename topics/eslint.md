---
parent: Topics
layout: default
title: "Eslint"
description:  "Linting (checking for style and frequent errors) in ECMAScript (i.e. JavaScript)"
---

# {{page.title}}

# NOTE: `eslint` currently disabled.

Eslint is currently disabled in the W22 example repo `demo-spring-react-example-v2`.  
* [This issue explains why](https://github.com/ucsb-cs156-w22/demo-spring-react-example-v2/issues/76), and proposes that someone fix the problem.

# About `eslint`

The utility `eslint` is used in many of our projects to do *linting* of our JavaScript/ECMAScript code.


When working on the frontend code, there is a GitHub actions script that will run a program called `eslint` against your JavaScript/ECMAScript code (the `es` in `eslint` stands for
ECMAScript.)

This is what it looks like when it fails:


<img alt="ESlint fails" src="https://user-images.githubusercontent.com/1119017/153115905-5a6b0360-95fb-429b-8e28-6f31229621aa.png" width="800" />

What `eslint` does is to check your code for certain style issues, including:
* Indentation
* Variables that are declared by never used

You can check what the eslint problems are by running `npx eslint .` inside the `frontend` directory.  Here's a sample run:

```text
pconrad@Phillips-MacBook-Pro frontend % npx eslint .

/Users/pconrad/github/ucsb-cs156-w22/demo-spring-react-example-v2/frontend/src/tests/components/OurTable.test.js
  1:38  error  'within' is defined but never used. Allowed unused vars must match /^_/u  no-unused-vars

/Users/pconrad/github/ucsb-cs156-w22/demo-spring-react-example-v2/frontend/src/tests/components/Users/UsersTable.test.js
  1:18  error  'waitFor' is defined but never used. Allowed unused vars must match /^_/u                  no-unused-vars
  4:10  error  'getFirstSmallestLargest' is defined but never used. Allowed unused vars must match /^_/u  no-unused-vars
  5:8   error  'userEvent' is defined but never used. Allowed unused vars must match /^_/u                no-unused-vars

✖ 4 problems (4 errors, 0 warnings)

pconrad@Phillips-MacBook-Pro frontend % 
```

In this case, all of the errors are about variables that are defined by never used.  The typical way to resolve this is to simply delete the definitions of those variables.

In rare cases, there may be a legitimate reason that you are keeping the variable around.  In this case, you may change the name of the variable to one that starts
with an underscore, e.g. change `foo` to `_foo`.  This is a convention for unused variables.

Once you've addressed all of the problems, the `eslint` CI/CD script should give you a green check.

If you run `npx eslint .` and get back no output, that means you are good to go:

```text
pconrad@Phillips-MacBook-Pro frontend % npx eslint .                              
pconrad@Phillips-MacBook-Pro frontend % 
```


# Configuring Exceptions

Sometimes there are individual style rules that `eslint` enforces that you might have a specific reason to
want to ignore.

As an example, in Storybook code, there is a convention that results in this warning from `eslint`:

```
/Users/pconrad/github/HappyCows/dsrk/frontend/src/stories/components/Profile/RoleBadge.stories.js
  6:1  warning  Assign object to a variable before exporting as module default  import/no-anonymous-default-export

/Users/pconrad/github/HappyCows/dsrk/frontend/src/stories/layouts/BasicLayout/BasicLayout.stories.js
  6:1  warning  Assign object to a variable before exporting as module default  import/no-anonymous-default-export

```

The string `import/no-anonymous-default-export` is a label that identifies this particular issue.  What we want to do
is suppress these warnings, but only under the directory tree `src/stories`.

To do this, we can modify the file `.eslintrc.json` in the `javascript` directory as follows:

```
{
    "extends": ["react-app"],
    "overrides": [
      {
        "files": ["src/stories/**"],
        "rules": {
          "import/no-anonymous-default-export": "off"
        }
      }
    ]
}
```


The process is documented here: <https://eslint.org/docs/user-guide/configuring/>

Note that because we are using Create-React-App, there are some subtle issues that arise,
as explained here: <https://create-react-app.dev/docs/setting-up-your-editor/#extending-or-replacing-the-default-eslint-config>.  What it boils down to is that you need this line in your configuration so that your customizations extend the ones already being done under the hood
for `react-app`, rather than replacing them, resulting in strange issues.

```
  "extends": ["react-app"],
```

