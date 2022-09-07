---
parent: Topics
layout: default
title: "Spring Boot: Heroku"
description:  "Tips for running with Spring Boot applications on Heroku"
category_prefix: "Spring Boot: "
indent: true
---

# Error: `failed to bind to $PORT within 90 seconds`

Symptom:

```
2019-11-21T00:07:44.777985+00:00 heroku[web.1]: Error R10 (Boot timeout) -> Web process failed to bind to $PORT within 90 seconds of launch
2019-11-21T00:07:44.778119+00:00 heroku[web.1]: Stopping process with SIGKILL
2019-11-21T00:07:44.954279+00:00 heroku[web.1]: State changed from starting to crashed
2019-11-21T00:07:44.939776+00:00 heroku[web.1]: Process exited with status 137
```

## Solution: 

In `src/main/resources/application.properties` you need:

```
server.port=${PORT:8080}
```

Reason: Heroku doesn't always run your webapp on port 8080.  It runs many webapps on the same server, on many different ports.
Your webapp must run on the port Heroku tells it to run on, which is specified in the `PORT` environment variable.  If it doesn't start up there, 
Heroku kills it off.
