---
parent: Topics
layout: default
title: "Sockets"
description:  "An abstraction used in networking"
---

# {{page.title}}

The term *socket* is overloaded, in the sense that there are multiple meanings of the word.

It can mean:

* In TCP/IP based networking, a pair consisting of an IP address and a port number (sometimes written `<IP-address,port>`
`<128.111.27.13, 80>`.

* An abstraction that originated in the Unix Operating System (and was widely copied into other OS designs) that 
   is an endpoint for network communication; i.e. the data structure through which an application initiates connections 
   and/or responds to connection requests, and sends and receives data.
   
Often these two "sockets" are in a one-to-one relationship, but not always.    There are times when one <IP-address,port> pair may correspond
to multiple "sockets" in the OS abstraction sense (this happens more often with server side sockets than client side sockets.)

In the Java programming language there is a class [`Socket`](https://docs.oracle.com/javase/8/docs/api/java/net/Socket.html) 
that depending on the context, may correspond to either of these meanings, but it is close to the second sense of the word
socket.

# Some Socket Code Examples from Chapter 15 of HFJ

* <https://github.com/UCSB-CS56-pconrad/hfj-chap15>

# BindException

A question that sometimes gets asked on Homework and/or Exams is this one:

* You are creating a socket and you get a `BindException`. What does this mean, and what should you do to try to fix this? 

Some versions of this question were more specific and said that the socket was being created with the line of code:

```java
Socket s = new Socket("127.0.0.1",20000);
```

Unfortunately, that's not really a good example to use.  Better to use this, taken from the `VerySimpleChatServer.java` program of Chapter 15:

* (full source code available here: [VerySimpleChatServer.java](https://github.com/UCSB-CS56-pconrad/hfj-chap15/blob/master/src/VerySimpleChatServer.java)


```java
ServerSocket serverSock = new ServerSocket(5000);
```

And the best way to see the error actually occur is to run that program on the same system, in two different shell windows:

In one window:

```
169-231-163-224:hfj-chap15 pconrad$ java -cp build chap15/VerySimpleChatServer
...
```

In the other:

```
169-231-163-224:hfj-chap15 pconrad$ java -cp build chap15/VerySimpleChatServer
java.net.BindException: Address already in use
	at java.net.PlainSocketImpl.socketBind(Native Method)
	at java.net.AbstractPlainSocketImpl.bind(AbstractPlainSocketImpl.java:382)
	at java.net.ServerSocket.bind(ServerSocket.java:375)
	at java.net.ServerSocket.<init>(ServerSocket.java:237)
	at java.net.ServerSocket.<init>(ServerSocket.java:128)
	at chap15.VerySimpleChatServer.go(Unknown Source)
	at chap15.VerySimpleChatServer.main(Unknown Source)
169-231-163-224:hfj-chap15 pconrad$ 
```

The problem is that on a given system, you can only have one server listening on a given port at a time.

One way to fix the error is to allow the user to:
* give a more helpful error message, one that includes at least the port number that we are trying to bind
* allow the user to override the default port number (500) by specifying a command line argument.  That way the user 
   trying to run the second server can enter 5001, or 5002, etc. until they find an unused port.
   
