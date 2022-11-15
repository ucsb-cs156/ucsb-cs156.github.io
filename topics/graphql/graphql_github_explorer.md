---
parent: GitHub
grand_parent: Topics
layout: default
title: "Graphql: GitHub Explorer"
description:  "An interactive web based interface for exploring the GitHub Graphql API"
indent: true
---


The GitHub Graphql Explorer can be found at this web page:

* <https://docs.github.com/en/graphql/overview/explorer>

Example Queries are often documented in a format such as the one shown below (from [this web page](https://docs.github.com/en/graphql/guides/forming-calls-with-graphql#working-with-variables)):

```json
query($number_of_repos:Int!) {
  viewer {
    name
     repositories(last: $number_of_repos) {
       nodes {
         name
       }
     }
   }
}
variables {
   "number_of_repos": 3
}
```

It is important to note that you need to copy the JSON after the word `variables` *into a separate pane* in the explorer, *without* the word `variables`, as shown in this screenshot:

<img width="444" alt="screenshot showing copying the variables part into a separate pane" src="https://user-images.githubusercontent.com/1119017/202026249-80798f98-9dc8-4ed6-b780-14602e50830d.png">


# Queries

This query will get all of the labels (for issues) associated with the repo `ucsb-cs156-f22/f22-5pm-courses`


```json
query {
  repository(owner:"ucsb-cs156-f22", name:"f22-5pm-courses") {
    labels(first:20) {
      edges {
        node {
                name
        }
      }
    }
  }
}
```

Sample output:

```json
{
  "data": {
    "repository": {
      "labels": {
        "edges": [
          {
            "node": {
              "name": "bug"
            }
          },
          {
            "node": {
              "name": "documentation"
            }
          },
          {
            "node": {
              "name": "duplicate"
            }
          },
          {
            "node": {
              "name": "enhancement"
            }
          },
          {
            "node": {
              "name": "good first issue"
            }
          },
          {
            "node": {
              "name": "help wanted"
            }
          },
          {
            "node": {
              "name": "invalid"
            }
          },
          {
            "node": {
              "name": "question"
            }
          },
          {
            "node": {
              "name": "wontfix"
            }
          }
        ]
      }
    }
  }
}
```


# Mutations

Adding new labels can be done with mutations.  
