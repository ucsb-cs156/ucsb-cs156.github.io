---
parent: Topics
layout: default
title: "CSIL: ssh port forwarding"
description:  "How to access webapps running on CSIL from your local machine"
indent: true
---


When you want to access a `localhost:8080` web app running on CSIL from a non-CSIL computer, e.g. your laptop:

At a command prompt (terminal prompt on MacOS, Linux, WSL, Windows 10, or git bash shell on Windows), you can type this:

```
ssh -L 1234:localhost:8080 username@csil.cs.ucsb.edu
```

That will set up port 1234 on your local machine as a tunnel to "localhost:8080" on the CSIL machine.    Then, if you put `localhost:1234` in your browser, you should be getting access to `localhost:8080` on the CSIL machine you are ssh'ing into.

# If using Auth0

If you are using Auth0,  running on a specific csil machine (e.g. `csil-04`), already have `localhost:8080` set up in the `Allowed Callback URLs`,  `Allowed Logout URLs` and `Allowed Web Origins`, then you shoudl use a command like this one:

```
ssh -L 8080:localhost:8080 username@csil-04.cs.ucsb.edu
```

where:
* `username` is your actual CSIL username
* `csil-04` is the specific CSIL machine on which you are running.
* The first `8080` is always `8080` if that's what's in your Auth0 `Allowed Callback URLs`,  `Allowed Logout URLs` and `Allowed Web Origins`.
* The second `8080` might change to, say,  `8081` if you are running on a different port than 8080 on the CSIL machine.

This is a preferred alternative to connecting directly to, say, `http://csil-04.cs.ucsb.edu:8080`, which may work for web apps that do *not* use Auth0, but may results in a blank page when Auth0 is used.   In that case, the underlying cause of the blank page may be this one: <https://github.com/auth0/auth0-spa-js/blob/master/FAQ.md#why-do-i-get-auth0-spa-js-must-run-on-a-secure-origin> 

