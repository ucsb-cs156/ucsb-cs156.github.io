---
parent: Topics
layout: default
title: Port Numbers
description:  "Those numbers such as 8080, 12345 that show up when doing networking things"
---

When doing any kind of networking operation such as setting up or connecting to a server, the subject **Port Numbers* arises.

Here's what you should know about port numbers for working with web servers (or other network servers):

* Transport layer protocols are the rules that govern how two processes (running programs) on machines connected to a network 
  communicate with one another.

* The internet, as we have known it from the 1980s to today in the early 2020s, has been based primarily on two transport layer protocols: 
  TCP and UDP.  Both of these protocols use **Port Numbers** in their communication.
  
* For each network interface, there are up to 65535 channels numbered 1-65535, and these channels are called *Ports* or *Port Numbers*.  

* The upper bound  65535 is a hard limit, because the space for the port number in the TCP and UDP packet headers is a 16 bit field.

* Port 0 does not actually exist (it's an invalid port number) and port 1-1023 are typically reserved for privileged processes.
  (meaning that you need system administrator privileges to use them.).   It's generally a good idea to stay away from 1-1023 for
  casual testing and development.
  
* The default port for a web server is TCP port 80, which is a privileged port.  When setting up a test webserver, it's typical
  to use port 8080.  However, sometimes other ports are used, including 3000, 4000, 5000, 8000, or 8081.    You can use any port number
  as long as it isn't being used for another purpose.
  
# Error `Port already in use`  
  
On any given host, only one process can use a port at a time.  So if you already have a webserver running on 8080 in one window, and
you try to start up a second one, you'll get an error message such as `Port already in use`.  

Solutions:
* Shut down the other process before starting a new one using the same port
* Use a different port

# Ports and Spring Boot

When running a Spring Boot server, we typically define the port to be used in the file `src/main/resources/application.properties` with the following
line of code:

```
server.port=${PORT:8080}
```

This line of code signifies that the `server.port` property should be defined as the value of the environment variable `PORT` if it exists; otherwise
it should be the value 8080

Coding it without the environment variable fallback, as `server.port=8080` will work on `localhost`, but will fail on Heroku.  On Heroku, the 
cloud server will assign web servers (whether Spring Boot, Python Flask, Rails, or whatever) a port that they are expected to run on by
specifying the `PORT` environment variable.  If the server does *not* start up on the expected port within some reasonable timeout, say 15-20 seconds,
then the process will be killed an error will be logged.

Therefore when running Spring Boot on Heroku, the `server.port=${PORT:8080}` form should always be used.

