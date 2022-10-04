---
parent: Webapps
grand_parent: Topics
layout: default
title: "Webapps: Webapps vs. Websites (Static Web Sites/Pages)"
description:  "What's the difference between a web app and a web site/page"
category_prefix: "webapps: "
indent: true
---

# {{page.title}}

This page explains the difference between:

-   a static web page/site
-   a web app

The short version is that a static web page is simply a "file" on the server containing HTML code. 
* Each time a request comes to a server for that file, it will return the contents of that file as the response. 
* The web page looks the same each time you see it
* It is straightforward and simple.
* Static web pages are typically retrieved with http `GET` requests.  (We'll discuss what a GET request is later in this article.)

A web app, by contrast, is some custom code that:
* runs on the server or the client, or both
* that <em>computes</em> the web page that you see.

This is sometimes called a dynamic web page, since it can change each time you look it.

Client Side vs. Server Side code
--------------------------------

Dynamic web pages&mdash;ones that show pages that can be different each time you see them&mdash;can do computations in one of two places: the server side, or the client side.

Let's try to understand how this works, and what the difference is.

First, let's understand this point:
* Server side code runs on the remote web server in response to a *request* for a page.   It runs on the server once per request, to compute what is sent back to your browser.  By the time the page arrives at your browser, the computation is over.
* Client side code runs directly in your browser, in a JavaScript interpreter that is tightly integrated into whatever browser you are using.   At least for now (as of 2016), client-side code is JavaScript, and *only* JavaScript.   This code can be running at *any time* while you are looking at the page.

Most of the rest of this article will focus on server side code for dynamic web apps.   We'll deal with client side code for dynamic web apps in another article later one.

HTTP Requests
-------------

When you bring up a web page in a browser, your browser sends a message to a web server with a *request* for the URL that you put
in the address bar, or the URL that was in the link that you clicked.

The server looks at the URL and then determines whether it is a request&mdash;from the server's perspective&mdash;for static content, or dynamic content.

HTTP Requests for Static Content
--------------------------------

It if is static content:
* The server simple sends back the file requested.  That file is typically an HTML file.
* That HTML file *might* contain references to other needed files, including embedded images (gifs, jpegs, pngs), CSS files (which control the look of the page: fonts, colors, layout, spacing, etc.).  So far, we are still only talking about static content.
* That HTML file *might* also contain Javascript code directly inside it, or it might contain references to external JavaScript
  files.   If so, those JavaScript files will be executed on the client side, possibly resulting in what appears to the user
  as a dynamic web page.   
* Whether or not there are JavaScript files, though, from the server's perspective though, this scenario is considered "static", since the server provides the same answer to the same request, every single time, and does *no* computation other than locating the file on the server's disk space that is to be transmitted back to the requester (whether that file is HTML, CSS, an image, or some JavaScript.)

HTTP GET requests
-----------------

The request to a web app may also be of several different types, with GET and POST being the most common types of requests.

These various types of requests are called "HTTP methods".  

-   Technically, GET and POST are just two of a long list of requests types called <b>HTTP Methods</b>
-   The full list of them is defined in [Section 9 of the HTTP 1.1 standard, RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html), and includes in addition to GET and POST, these types: OPTIONS, HEAD, DELETE, PUT, TRACE, CONNECT
-   The ones other than GET and POST, though, are rarely used by folks that are just getting started with web app programming.
-   GET and POST requests for dynamic content often have *parameters* that are used to compute a result.   More on that later.

That's why many of the books, web sites, and other resources you read will only mention GET and POST, and emphasize when to use one vs. the other. We'll do the same—do keep in mind though, that as your understanding of web applications progresses and you move into the topic of [RESTful APIs](/topics/rest), you'll need to move beyond just GET and POST.   (If you just can't wait to learn more, here is an article on [what is beyond GET and POST](/topics/http_beyond_get_and_post).)

A request for static content typically uses the GET method.  We'll discuss the POST method later in this article.

A note about this word "method":
* If you are studying Object-Oriented Programming, you may know a specfic meaning of the term *method*, but don't be confused.
* The word *method* here is being used with its ordinary English meaning, and then being defined as a specific technical term in the context of HTTP.    
* HTTP methods are not methods in an OOP sense; rather they are  different ways (different "methods") of making an HTTP request.


A simple static Web Page
------------------------

A **static web page** is what you get when you make a .html file, and put it in your public\_html directory on CSIL. As an example, you might:

-   put the HTML code below into `sample.html`
-   store it under the directory /cs/student/yourname/public\_html
-   Do these chmod commands so that the Apache webserver process on CSIL has access to it:
    -   `chmod` `711` `$HOME`
    -   `chmod` `-R` `755` `$HOME/public_html`
-   Access the page at <http://www.cs.ucsb.edu/~yourname/sample.html>

```html
    <!DOCTYPE html>
    <html>
     <head>
       <title>Sample web page</title>
     </head>
     <body>
       <title>Hello, World!</title>
     </body>
    </html>
```

# What happens when you do a GET request for a static page

When you put the URL <http://www.cs.ucsb.edu/~yourname/sample.html> into your browser and hit enter, the browser sends an HTTP message to the server called a"GET" request, and the server responds with the contents of the requested file. It's up to your browser to make sense of the HTML that is returned, and display it properly.

More specifically:

-   Your browser divides the URL into two parts: <http://www.cs.ucsb.edu> (the host) and ~yourname/sample.html (the requested resource on that host).
-   The browser opens an HTTP Connection to the host, www.cs.ucsb.edu, which is running the Apache webserver.
-   The Apache webserver on www.cs.ucsb.edu is configured so that when it gets a request for a resource formatted like ~yourname/sample.html, it looks under the home directory of user yourname for a directory called public\_html, then for a file named sample.html, and returns the contents of that file in the HTTP <em>response</em> message.

In summary, we have:

-   URL in browser get divided into HOST and RESOURCE
-   Browser opens HTTP connection to HOST and sends "GET" requestfor RESOURCE
-   Server finds the file that corresponds to RESOURCE, and responds with HTTP response, containing file contents.

# GET requests made to a web app

By contrast, a <b>web app</b> is some code that the web server runs in response to a GET request to <em>calculate</em> the response that will be sent back.

Perhaps the most familiar and commonly used "web app" is Google Search. Consider this URL:

```
    https://www.google.com/search?q=pupplies
```

# GET parameters

Let's break this URL [`https://www.google.com/search?q=pupplies`](https://www.google.com/search?q=pupplies) down into its pieces:

-   The HOST in this URL is www.google.com, and the RESOURCE is `search?q=puppies`
-   The part that comes after the question mark (`?`) contains <em>parameter values</em>. In general, its a list of key/value pairs.
-   In this particular URL, there is only one key/value pair. The key is `q` and the value is `puppies`

In response the Google web server runs a computation that:

-   does a search on the term `puppies`
-   collects results in some data structure
-   converts that data structure into the HTML for a formatted web page of those results
-   sends back that computed web page

### Where do GET parameters come from?

Typically, though, a user doesn't interact with Google by typing in a query such as that one. It would be more typical to go to <http://google.com>, or a Google Search bar, or app on their phone, then type `puppies` into the search box and press return.

In the case of the Google.com home page at <http://google.com>, the HTML for that page is coded so that whatever you type into the search box produces a URL that has `q=puppies` in it. In general, any web page or app that interacts with a web app via GET requests will have code to

-   gather input from the user (through text boxes, check boxes, radio buttons, etc.)
-   put that input into the appropriate parameters to the GET request
-   send that along with the GET request to the server.

### To review: What does a web app do?

A web app:

-   receives a HTTP GET request message or any of several other kinds of request that we'll discuss in a moment), along with its parameters,
-   <em>computes</em> the response that goes back (in HTML, or whatever other format may be needed) based on the requested resource and its parameters
-   sends that response back to the requester in an HTTP response message


### Other kinds of requests made to a web app `POST`, `PATCH`, `DELETE`, etc.

A `GET` request is only one kind of request that can be made to a webapp.  There are a variety of others, the most important one being
`POST`.    A complete list can be found in the specification for the HTTP protocol, here: 

We'll cover those other kinds of requests, and the difference between `GET` and `POST` in another article.

* For now, if you want to learn more, see: "Get vs. Post" <http://blog.teamtreehouse.com/the-definitive-guide-to-get-vs-post> 
* Also see the article about [REST](https://ucsb-cs156.github.io/topics/rest.html)

