---
parent: Topics
layout: default
title: "Legacy Code: Terminal Windows"
description:  "Six roles for terminal windows when working with Legacy Code"
category_prefix: "Legacy Code: "
indent: true 
---



While this may seem extreme, Prof. Conrad suggests having six terminal windows, each with specific roles to play.

| Num | Name | Directory | Purpose |
|-----|------|-----------|---------|
| 1 | Main | root of repo | Running git commands, and running `code .` to open VS Code |
| 2 | Backend | root of repo | Run backend with `mvn spring-boot:run` |
| 3 | Backend tests | root of repo | Run backend tests with `mvn test` <br /> or Test coverage with `mvn test jacoco:report` |
| 4 | Frontend | `javascript` | Run frontend with `npm start` |
| 5 | Frontend Tests | `javascript` | Run front end unit tests `npm test`<br /> jest coverage with `npm run coverage`, <br />Stryker coverage with `npx stryker run`, <br /> or eslint with `npx eslint --fix src` |
| 6 | Storybook | `javascript` | Run storybook with `npm run storybook` |
{:.table .table-sm .table-striped .table-bordered}

While there is nothing sacred about this *particular* way of organizing things, having *some* specific convention will help
you keep your work organized, and is especially helpful when communicating with others on your team or with staff about
what you are working on.


# MacOS Script

The following script can be used on MacOS to open up these 6 windows.  

```
#!/bin/bash
# See: https://stackoverflow.com/a/42340540
# See: https://apple.stackexchange.com/a/58151

osascript <<EOF

tell application "Terminal"
    activate
    
    my makeNewColor(65535,32768,65535)
    do script "git status" in front window

    my makeNewColor(65535,65535,32768)
    my makeTab()
    do script "mvn spring-boot:run" in front window
    
    my makeNewColor(32768,65535,65535)
    my makeTab()
    do script "mvn test jacoco:report" in front window
    
    my makeNewColor(32768,32768,65535)
    my makeTab()
    do script "cd javascript; npm start" in front window
    
    my makeNewColor(65535,32768,32768)
    my makeTab()
    do script "cd javascript; npm test" in front window
    
    my makeNewColor(32768,65535,32768)
    my makeTab()
    do script "cd javascript; npm run storybook" in front window
  
end tell

on makeTab()
    tell application "System Events" to keystroke "t" using {command down}
    delay 0.2
end makeTab


on makeNewColor(r,g,b)
    tell application "Terminal" 
     set the background color of window 1 to {r, g, b}
    end tell
    delay 0.1
end makeTab

EOF
```
