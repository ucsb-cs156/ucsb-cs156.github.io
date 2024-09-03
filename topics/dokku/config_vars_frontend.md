---
parent: Dokku
grand_parent: Topics
layout: default
title: "Config Vars Frontend"
description:  "How to pass config vars to the frontend"
---

# {{page.title}} - {{page.description}}

Suppose you have a variable that you want to configure via `dokku config:set ...` and you want to access this value in the backend.

It's a bit of a puzzle to figure out all of the pieces needed to make that work.

The frontend is built by the `com.github.eirslett.frontend-maven-plugin` which is configured in the `pom.xml`.  On dokku, this happens during the build phase.

Normally, config vars are not available during the build phase, but you can override this by doing this:


* First, make sure the variable is prefixed with `REACT_APP_`
  * For example, not `START_QTR`, but `REACT_APP_START_QTR`
* One time setup:
  ```
  dokku docker-options:add courses-qa build '--build-arg REACT_APP_START_QTR'
  ```
* Add the variable to the `Dockerfile` as an `ARG`
  ```
  ARG REACT_APP_START_QTR   
  ```
* Then, set up a script to get all of the variables that start with `REACT_APP` and put them in a `.env` file in the frontend directory during the build phase:
  ```
  RUN (cd /home/app/frontend; ./scripts/create_dotenv_dokku.sh; pwd; ls -al; cat ./scripts/create_dotenv_dokku.sh; cat ./.env; cd ..)
  ```

The script `./scripts/create_dotenv_dokku.sh` looks like this:

```
#!/usr/bin/env sh
# Copy REACT_APP_ variables to a local .env

rm -rf .env
touch .env
env | grep '^REACT_APP_' | while read -r line ; do
  echo "${line} " >> .env
done
```

Then, in `package.json` prefix `npm run build` or `npm run start` with `env-cmd` like this:

```
 "build": "env-cmd react-scripts build",
```

In the React code, you can then access the variables like this:

```
process.env.REACT_APP_START_QTR
```


Relevant documentation:
* The main documentation is here: <https://dokku.com/docs/configuration/environment-variables/>
* This is also relevant: <https://dokku.com/docs/deployment/builders/dockerfiles/#build-time-configuration-variables>
* This issue also has important details: <https://github.com/dokku/dokku/issues/1860>
