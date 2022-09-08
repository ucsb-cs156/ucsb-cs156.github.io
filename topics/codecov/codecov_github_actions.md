---
parent: Codecov
grand_parent: Topics
layout: default
title: "Codecov: GitHub Actions"
description:  "Using Codecov with GitHub Actions, including adding CODECOV_TOKEN secret"
---

To use CodeCov.io with GitHub Actions, you need two things:


* You need to set a *Secret* on the settings for your repo; this is like a password that allows
  your GitHub Actions workflow (i.e. a script) to access your codecov.io account and upload the 
  code coverage report.
* You need the appropriate lines in the script for your GitHub Workflow (e.g. in `.github/workflows/maven.yml`)
  that invoke the codecov upload after generating the Jacoco report.
  
# Obtaining the Upload Token

To obtain the upload token, first be sure that you are logged in at <https://codecov.io> with you GitHub account.

Then, navigate to <https://codecov.io/gh/ORG-NAME-HERE/REPO-NAME-HERE>, for example
* <https://codecov.io/gh/ucsb-cs156-f20/jpa02-cgaucho>

You should see a screen with an upload token.   

On that page, there should be a so-called upload-token value, a series of letters and numbers like a 
very long password. You'll need to copy/paste that value, so keep that window open.

If you can't find the upload token there,  try this URL instead:
* <https://codecov.io/gh/ucsb-cs156-f20/jpa02-cgaucho/settings>

If neither of those, works, try the "troubleshooting page" linked to below.

# Setting the Secret

* Visit your repo, go to the Settings tab for the repo (not the Settings tab for your GitHub account)
  and then find `Secrets` in the left navigation, and click on it.

  Or, equivalently, visit the URL <https://github.com/ucsb-cs156-f20/YOUR-REPO-NAME-HERE/settings/secrets>

* You should see a `New Secret` button at the upper right.  Click on this, and add a new secret
  called `CODECOV_TOKEN` (must be all uppercase, with underscore).   The value of the secret
  will be the one you found on the `codecov.io` page.

  Adding this token gives your GitHub Action the permission it needs to upload
  code coverage results to <https://codecov.io>.

  If your repo is private, the code coverage results will be also; note that if your
  repo is part of the class organization, then the course staff will also have access
  to your code coverage results, but fellow class members won't (at least not by default.)
  
* To see your code coverage results on <https://codecov.io>, you need to trigger GitHub
  actions to run, either with a push to a branch, or a Pull Request.  Then, by visiting
  the URL <https://codecov.io/gh/ucsb-cs156-f20/REPO-NAME-HERE> you should be able to
  see your code coverage results.

# Adding codecov.io to your GitHub Actions workflow

For Java repos, here is an example of a `maven.yml` that uploads codecov information from
a Jacoco report to codecov.

```yml
name: Java CI

on:
  pull_request:
  push:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Set up JDK 11
        uses: actions/setup-java@v1
        with:
          java-version: 11.0.x
      - name: Build with Maven
        run: mvn test jacoco:report
      - name: Upload to Codecov
        env:
          CODECOV_TOKEN: ${{ secrets.CODECOV_TOKEN }}
        run: bash <(curl -s https://codecov.io/bash)
      - name: Pitest
        run: mvn test org.pitest:pitest-maven:mutationCoverage
      - name: Upload Pitest to Artifacts
        uses: actions/upload-artifact@v2
        with:
          name: pitest-mutation-testing
          path: target/pit-reports/**/*  
```

The following lines are the one that generate a jacoco report (which is something we can upload to codecov). Different lines would be needed instead (or in addition) to also generate reports from JavaScript code (e.g. `jest`).

```yaml
      - name: Set up JDK 11
        uses: actions/setup-java@v1
        with:
          java-version: 11.0.x
      - name: Build with Maven
        run: mvn test jacoco:report
```

These are the lines that upload the report to codecov.  The `env` part is what gets the secret from 
GitHub and then loads it into an environment variable used by the script.   
The line `run: bash <(curl -s https://codecov.io/bash)` automatically gets an appropriate script from
the url `https://codecov.io/bash` and then executes it.

```yaml
     - name: Upload to Codecov
        env:
          CODECOV_TOKEN: ${{ secrets.CODECOV_TOKEN }}
        run: bash <(curl -s https://codecov.io/bash)
```
