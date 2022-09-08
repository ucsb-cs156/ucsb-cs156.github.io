---
parent: CSIL
grand_parent: Topics
layout: default
title: "CSIL: browser from command line"
description:  "How to open a browser from the command line"
indent: true
---

# Open URL from command line on CSIL

These may launch a browser if you have access to X11 from your terminal.

* `google-chrome http://example.org`
* `firefox http://example.org`

# Other commands to open URL from command line on Linux

These may launch a browser if you have access to X11 from your terminal.

Your mileage may vary: these may or may not work on any given Linux system

* `sensible-browser http://example.org`
* `xdg-open http://example.org`
* `x-www-browser http://example.org`

Based on <https://askubuntu.com/questions/8252/how-to-launch-default-web-browser-from-the-terminal>

# Get contents of URL (no graphical browser)

This is particularly useful for just testing whether a site is up, and/or for RESTFul APIs.

* `curl http://example.org`
