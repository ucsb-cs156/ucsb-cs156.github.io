---
parent: graphql
grand_parent: Topics
layout: default
title: "Graphql: IDE Support"
description:  "Support in VSCode and Intellij for editing Graphql"
---

# {{page.title}} - {{page.description}}

Working with GraphQL typically occurs in the Java backend of our Spring Boot apps when you need to interact with an API such as:
* Github API
* Canvas API
* etc.

You may have bits of GraphQL in your code, like this:

```java
String query =
        """
        query GetGroupSets($courseId: ID!) {
          course(id: $courseId) {
            groupSets {
              _id
              name
              id
            }
          }
        }
        """;
```

If you want your IDE (e.g. VSCode, Intellij) to help you with the syntax, there are a couple of things you can do.

1. Get the schema for the GraphQL API you are working with, download it, and add it to your repo under a directory called, for example, `graphql-schemas`.   You can see an example in [this PR](https://github.com/ucsb-cs156/proj-frontiers/pull/595/changes)
2. Add a `graphql.config.yml` in the root of your project to specify the location of the schema files.    You can see an example in [this PR](https://github.com/ucsb-cs156/proj-frontiers/pull/595/changes)
2. Look up the extensions for GraphQL for your IDE.  There are some specfic links for VSCode and Intellij below.

## VSCode

You will probably want to start by enabling these extensions:
* Language Feature Support: <https://marketplace.visualstudio.com/items?itemName=GraphQL.vscode-graphql>
* Syntax Highlighting: <https://marketplace.visualstudio.com/items?itemName=GraphQL.vscode-graphql-syntax>

Instead of `// language=GraphQL`, the GraphQL extensions for VS Code uses `/* GraphQL */` 
as a block comment before the template literal or `#graphql` for line comments in supported files. 

## Intellij

When using Intellij support for GraphQL, you will want to precede each Java GraphQL string with this comment:

```java
    // language=GraphQL
```

For more information, see: 
* <https://plugins.jetbrains.com/plugin/8097-graphql>
* <https://www.jetbrains.com/help/idea/using-language-injections.html#language-injections>
