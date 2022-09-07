---
parent: Topics
layout: default
title: "MongoDB: SSL certificate"
description:  "How to handle errors with the SSL certificate when connecting to MongoDB"
category_prefix	: "MongoDB: "
indent: true
---

As of November 2020 (F20) and continuing into February 2021 (W21), developers working with
Spring Boot and MongoDB on MacOS are running into this error when connecting to a MongoDB 
database:

```
2021-02-02 13:13:04.364  INFO 65733 --- [ngodb.net:27017] org.mongodb.driver.cluster               : 
Exception in monitor thread while connecting to server cluster0-shard-00-02.l6wrx.mongodb.net:27017

com.mongodb.MongoSocketWriteException: Exception sending message
	at com.mongodb.internal.connection.InternalStreamConnection.translateWriteException(InternalStreamConnection.java:551) ~[mongodb-driver-core-3.11.2.jar:na]
	... [ many stack frames omitted ]
  at java.base/java.lang.Thread.run(Thread.java:832) ~[na:na]
Caused by: javax.net.ssl.SSLHandshakeException: extension (5) should not be presented in certificate_request
	at java.base/sun.security.ssl.Alert.createSSLException(Alert.java:131) ~[na:na]
```

The following work around seems to fix this: 
* Add the flag `-Dspring-boot.run.jvmArguments="-Djdk.tls.client.protocols=TLSv1.2"` when running the `mvn spring-boot:run` command, like this:

  ```
  mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Djdk.tls.client.protocols=TLSv1.2"
  ```
  
