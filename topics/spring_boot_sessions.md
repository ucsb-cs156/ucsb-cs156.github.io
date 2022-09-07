---
parent: Topics
layout: default
title: "Spring Boot: Sessions"
description:  "How to make the stateless HTTP protocol stateful"
category_prefix: "Spring Boot: "
indent: true
---

# Sessions, in General 

The HTTP protocol is, by design, a *stateless* protocol.
* Recall that HTTP is the protocol by which web clients (e.g. browsers) communicate with web servers (e.g. a Spring Boot application).
* HTTP consists of requests and responses.
* To say that HTTP is *stateless*  means is that the HTTP protocol is designed so that every request, and response, in principle, is independent of every other request and response.  
* The server is not supposed to have to "keep track" of anything.

But in reality, many web applications actually *need* some state, typically in the form of a *User Session*
* That is, series of requests and responses that are all connected
* The session starts when the user starts interacting with the application (typically, though not always, by authenticating with a username/password)
* During the session, some *state* is associated with the session, typically in the form of key/value pairs
* When the session is complete, this state is discarded, and the session is done, either when:
   * The user logs out, or otherwise indicates that they session is over
   * The server determines that the session has been inactive and so it cancels it because it has "expired" or "timed out"
   
Most web frameworks have some way of maintaining user sessions, and Spring Boot is no exception.

# Sessions in Spring Boot

Sessions in Spring Boot can be "backed" by some kind of persistent storage.  Some options include:
* an SQL database
* a service such as Redis

# Why we prefer JDBC/SQL for Spring Sessions in CS56 

We don't want CS56 student to have to have a credit card to do their homework.

Accordingly, we restrict ourselves to the parts of Heroku that do not require entering a credit card.

That includes Heroku Postgres, but leaves our Heroku Redis.

So, while Redis may have some advantages over SQL databases for this purpose, for *our* purposes in CS56, we will use an SQL database.

## References

* <https://www.baeldung.com/spring-session-jdbc>
* <https://www.javainuse.com/spring/springboot_session>
* <https://docs.spring.io/spring-session/docs/current/reference/html5/guides/boot-redis.html>
