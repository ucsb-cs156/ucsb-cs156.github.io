---
parent: Topics
layout: default
title: "REST"
description:  "RESTful APIs, etc (Representational State Transfer)"
---

# {{page.title}}

As a programmer, you typically encounter the notion of a RESTful API in one of two contexts:
* You need to use someone else's RESTful API that already exists
* You need to implement your own RESTful API for others to use.

# When would I need to use someone else's RESTful API?

As an example, suppose you want your web app to be able to share something to a social network feed.

You might use a RESTful API to do that.   For example, Facebook provides the [Graph API](https://developers.facebook.com/docs/graph-api), a RESTful API
which is described this way on [this overview page (retrieved 2016-06-30)](https://developers.facebook.com/docs/graph-api/overview/):

> The Graph API is the primary way to get data in and out of Facebook's platform. 
> It's a low-level HTTP-based API that you can use to query data, post new stories, 
> manage ads, upload photos and a variety of other tasks that an app might need to do.

(As a side note, the definition of what is, and is not, a RESTful API is sometimes a matter of debate.   At least 
according to [this StackOverflow post](http://stackoverflow.com/questions/4573963/is-facebook-graph-api-considered-a-restful-api) is considered a RESTful API.)

# When would I need to develop my own RESTful API?

You would develop your own RESTful API when you want to provide a way for other applications to access a service that you have built
over the internet.  You can think of a RESTful API as a way of providing *remote procedure call*:

* The idea of remote procedure call is that  inside the other person's application, they call a function or a method
* Magically though, as if there were a wormhole from their code into yours, when the function/method returns, they get back a result
  that comes from your app, instead of theirs.  Or, something changes inside of your app.
* The magic wormhole is an exchange of an HTTP request and response between their application and yours, over a RESTful API.

# Where did the notion of RESTful APIS come from?

[Roy Fielding](https://en.wikipedia.org/wiki/Roy_Fielding), who was a co-founder of the Apache HTTP Server project, 
proposed the idea of Representational State Transfer (REST) as part of his Ph.D. dissertation at UC Irvine (go Anteaters!).

It has since become a widely adopted model for building web services based on HTTP.

# Testing RESTful APIs Interactively

Two tools for testing RESTful APIs interactively (without writing additional code) are:
* `curl`, a command line tool
* [Postman](https://www.postman.com/downloads/), a GUI tool you can download and run on Windows/Mac/Linux

When testing APIs that use authentication, you may need to get an extension called the "JWT Debugger" and use it to copy the `Authorization: Bearer` token value.  (TODO: Fill in more detail about this process.)
``

# References on RESTful APIs

* Wikipedia article <https://en.wikipedia.org/wiki/Representational_state_transfer>
* <https://en.wikipedia.org/wiki/Representational_state_transfer#Relationship_between_URL_and_HTTP_methods>
* PUT vs. PATCH: <https://stackoverflow.com/questions/28459418/rest-api-put-vs-patch-with-real-life-examples/39338329#39338329>
   * Note that there is the notion of a "PATCH language" (or "PATCH protocol") some common agreed upon set of operations that both the client and server understand.  
