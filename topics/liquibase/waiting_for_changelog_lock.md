---
parent: Liquibase
grand_parent: Topics
layout: default
title: "liquibase: Waiting for changelog lock"
description:  "How to fix this problem"
indent: true
---

# {{page.title}}

If you run a `mvn` command and get stuck with this output over and over:

```
2023-11-23 13:18:31.018  INFO 1739 --- [           main] liquibase.lockservice                    : Waiting for changelog lock....
2023-11-23 13:18:41.025  INFO 1739 --- [           main] liquibase.lockservice                    : Waiting for changelog lock....
2023-11-23 13:18:51.032  INFO 1739 --- [           main] liquibase.lockservice                    : Waiting for changelog lock....
2023-11-23 13:19:01.037  INFO 1739 --- [           main] liquibase.lockservice                    : Waiting for changelog lock....
2023-11-23 13:19:11.045  INFO 1739 --- [           main] liquibase.lockservice                    : Waiting for changelog lock....
2023-11-23 13:19:21.051  INFO 1739 --- [           main] liquibase.lockservice                    : Waiting for changelog lock....
2023-11-23 13:19:31.054  INFO 1739 --- [           main] liquibase.lockservice                    : Waiting for changelog lock....
2023-11-23 13:19:41.056  INFO 1739 --- [           main] liquibase.lockservice                    : Waiting for changelog lock....
```

Here's the fix:

```
mvn liquibase:releaseLocks 
```

