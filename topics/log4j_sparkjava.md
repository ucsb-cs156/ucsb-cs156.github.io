---
parent: Topics
layout: default
title: "Log4J: SparkJava"
description:  "Using Log4J with SparkJava"
category_prefix: "Log4J: "
indent: true
---

Log4J is short for  [Apache Logging For Java](https://logging.apache.org/log4j)

If you get this message when starting up a [Sparkjava](/topics/spark_java/) web application, the reason is that
are missing the dependency on Log4J:

```
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
```

To fix this, include this in your `pom.xml`:

```xml
 <dependency>
       <groupId>org.slf4j</groupId>
       <artifactId>slf4j-api</artifactId>
       <version>1.7.5</version>
   </dependency>
   <dependency>
       <groupId>org.slf4j</groupId>
       <artifactId>slf4j-log4j12</artifactId>
       <version>1.7.5</version>
  </dependency>       
```

That is only the start.  You'll then get this error message instead:

```
log4j:WARN No appenders could be found for logger (spark.route.Routes).
log4j:WARN Please initialize the log4j system properly.
log4j:WARN See http://logging.apache.org/log4j/1.2/faq.html#noconfig for more info.
```

To fix this, create a file called `log4j.properties` in the file `src/main/resources`.  The contents should be as shown below.)

(Source: <https://www.mkyong.com/logging/log4j-hello-world-example/>)

```
# Root logger option
log4j.rootLogger=DEBUG, stdout

# Redirect log messages to console
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.Target=System.out
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n

```

Once you do this, you'll start seeing a lot more information in the output stream of your Sparkjava webapps.
For example:

```
2018-09-04 17:08:19 DEBUG Routes:187 - Adds route: post, /posts, spark.RouteImpl$1@4a7a2694
2018-09-04 17:08:19 DEBUG Routes:187 - Adds route: get, /posts, spark.RouteImpl$1@59a47725
2018-09-04 17:08:19 DEBUG log:176 - Logging to org.slf4j.impl.Log4jLoggerAdapter(org.eclipse.jetty.util.log) via org.eclipse.jetty.util.log.Slf4jLog
2018-09-04 17:08:19 INFO  log:186 - Logging initialized @1734ms
```

Too little log output can be frustrating, since you don't know what's going on.  But too much can be overwhelming, so it's possible to tailor the level of output using the settings in the `log4j.properties` file.


For more information, see:

* <https://www.tutorialspoint.com/log4j/>
* <https://www.mkyong.com/logging/log4j-hello-world-example/>
* <https://www.tutorialspoint.com/log4j/log4j_logging_levels.htm>
