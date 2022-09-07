---
parent: Topics
layout: default
title: "Java: HttpURLConnection"
description:  "And HttpsURLConnection; a Java object for retrieving content from a URL"
indent: true
---

If you are trying to retrieve content via 
[`HttpURLConnection`](https://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html) or 
[`HttpsURLConnection`](https://docs.oracle.com/javase/8/docs/api/java/net/HttpsURLConnection.html), there is
one problem you can run into that will cause you no end of trouble, unless you know the secret trick.

Some APIs, e.g. Reddit, DuckDuckGo, and others, may allow you to retreive from a URL in a regular browser, or
using `curl` or `postman` or just about anything EXCEPT raw access through a 
Java [`HttpURLConnection`](https://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html).

Note that the same problem can afflict Python code that uses the `requests` library.

You can get a 500 error, or really any number of other errors, when it seems that every other way of accessing
the URL works fine--and that your code can access other URLs with no trouble.

The issue might be the `User-Agent` header.


# When accessing a URL in code doesn't work, what do you do?

If you having trouble accessing web content, you may occassionally run into problem with access, where
you get "Forbidden", or "Access Denied" or "Too many requests" errors.

These are especially frustrating when you find that issuing the EXACT SAME REQUEST in a web browser results in no problem at all.

It really makes you wonder: why does my web browser work, but my code doesn't?  Especially when the
requests are coming from the exact same computer?

So, it isn't *always* the case, but it is *often* the case that the problem is something called the 'User-Agent'.

The 'User-Agent' is the identifier for a particular kind of "browser-like-thing".     
Each web browser, e.g. Firefox, Chrome, IE, Safari, etc.
has its own particular signature that it sends along with requests in a header called the 'User-Agent'.

And, when you send a request from your Java code (or for that matter, your Python or JavaScript code), 
if you don't set a `User-Agent`, then you might appear to
be some kind of badly behaved bot.   This often triggers code on the server that will keep you out!

There are a couple of ways to address this.

One is to set a User-Agent that describes who you are and what you are doing.  
It is best, in this case, to add something
to your `User-Agent` string that differentiates your request from others, 
especially if you are on a shared machine such as
an CSIL machine.  For example:

Instead of:

```java
        HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Content-Type", "application/json");
        System.out.println(connection.getResponseMessage());
```

Use this.  Note the call to `.setRequestProperty` which sets the `"User-Agent"`

```java
        HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestProperty("User-Agent", "UCSB/1.0");
        System.out.println(connection.getResponseMessage());
```

If that still doesn't work, you can get really devious, and try to mimic the User-agent string of an actual browser
that is known to be working.  You can use various developer tools inside browsers such as Chrome and Firefox to peek
at the HTTP headers that are being sent along with successful requests, and then try to spoof those headers.  This is
a bit "dirty", and it should not be abused.    It is important to respect the terms of service and limitations of data
providers.

# As an aside, here's the same issue in Python

Incidentally, in Python this would be:

Instead of:
```python
>>> result = requests.get("http://www.reddit.com/r/ucsd.json")
>>>
```

Use this:
```python
>>> result = requests.get("http://www.reddit.com/r/ucsantabarbara.json", headers = {'User-agent': 'UCSB/1.0'})
>>>
```

