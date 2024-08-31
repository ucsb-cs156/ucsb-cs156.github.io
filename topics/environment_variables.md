---
parent: Topics
layout: default
title: "Enviroment Variables"
description:  "Reading them from Java code"
---

# {{page.title}}

One way to allow the configuration of an application to vary depending on the environment in which
it is running is to have the application look at *environment variables*.

In Unix, environment variables are typically defined at the command line, like this:

```
export DB_USER=testuser
export DB_PASSWORD=sfa8wefKH67f
```

There are other ways of defining these as we explain below.

Then, inside the code of a Java app (or for that matter, an app in pretty much any programming language), there is a way for the code to access these value.

The idea is to be able to change these values without having to recompile the program; the program discovers the values at run time.  Instead of recompiling the code, the person in charge of deploying the app can just change the environment variable.  This also allows different values for development, testing and production deployments of the app.

## How to set environment variables

At the Unix command line:

```
export DB_USER=testuser
export DB_PASSWORD=sfa8wefKH67f
```

In a Spring Boot app, these can be defined in a file called `.env` and then set via the properties files (as explained further below).  The .env file typically looks like this:

```
GOOGLE_CLIENT_ID=89340234710-thisisafakevalue.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=GOCSPX-thisisafakevalue
ADMIN_EMAILS=phtcon@ucsb.edu
START_QTR=20204
END_QTR=20231
UCSB_API_KEY=ABCD1234THISISFAKEABCD
```

Various deployment platforms such as Dokku, Heroku, plain Docker, etc. have ways of setting environment variables also, for instance in dokku, it is does with the command:

```
dokku config:set appname VARIABLE_NAME=VALUE
```

Those values can be read from inside Java code in one of several ways, as shown below.

## Reading Env Vars in a Spring Boot application

Environment variables are typically read into a Spring Boot application indirectly through the properties file values.

As an example, the value of `START_QTR` in the `proj-courses` app is defined in a value in the `.env` file on localhost, or via a `dokku config:set ...` command on dokku.

Then, in the file `src/main/resources/application.properties` we have this line:

```
app.startQtrYYYYQ=${START_QTR:${env.START_QTR:20221}}
```

This defines the spring boot property value `app.startQtrYYYYQ` as the value of `START_QTR` if one exists as an internal variable; otherwise the value of `START_QTR` from the environment, otherwise the default value `20221`.

Then this value can be accessed in code like this inside the Spring Boot application (this example is from `src/main/java/edu/ucsb/cs156/courses/services/SystemInfoServiceImpl.java`).  Again, this says to take the value from the property `app.startQtrYYYYQ` if it is defined,
otherwise use the default value of `20221`		

```
  @Value("${app.startQtrYYYYQ:20221}")
  private String startQtrYYYYQ;
```

## Reading Env Vars in Plain Java

### Example 1: Using `System`

```java
String DB_USER = System.getenv("DB_USER");
```

### Example 2: Using `ProcessBuilder`

```java
 static int getHerokuAssignedPort() {
        ProcessBuilder processBuilder = new ProcessBuilder();
        if (processBuilder.environment().get("PORT") != null) {
            return Integer.parseInt(processBuilder.environment().get("PORT"));
        }
        return 4567; //return default port if heroku-port isn't set (i.e. on localhost)
    }
```

### Example 3: Multiple Environment Variables

```java

 public static void main(String[] args) {
 
   HashMap<String,String> envVars =
	    getNeededEnvVars(new String []{ "FACEBOOK_CLIENT_ID",
					    "FACEBOOK_CLIENT_SECRET",
					    "FACEBOOK_CALLBACK_URL",
					    "APPLICATION_SALT"});
  }
```

```java
/**
       return a HashMap with values of all the environment variables
       listed; print error message for each missing one, and exit if any
       of them is not defined.
    */
    
 public static HashMap<String,String> getNeededEnvVars(String [] neededEnvVars) {
	HashMap<String,String> envVars = new HashMap<String,String>();
	
	
	for (String k:neededEnvVars) {
	    String v = System.getenv(k);
	    envVars.put(k,v);
	}
	
	boolean error=false;
	for (String k:neededEnvVars) {
	    if (envVars.get(k)==null) {
		    error = true;
		    System.err.println("Error: Must define env variable " + k);
	    }
	}
	if (error) { System.exit(1); }
	
	return envVars;
  }

```
