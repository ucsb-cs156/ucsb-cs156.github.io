---
parent: Topics
layout: default
title: "Enviroment Variables"
description:  "Reading them from Java code"
---

# {{page.title}}

One way to allow the configuration of an application to vary depending on the environment in which
it is running is to have the application look at *environment variables*.

In Unix, these can be defined at the command line, like this:

```
export DB_USER=testuser
export DB_PASSWORD=sfa8wefKH67f
```

Those values can be read from inside Java code in one of several ways.

Here are some examples:

# Example 1: Using `System`

```java
String DB_USER = System.getenv("DB_USER");
```

# Example 2: Using `ProcessBuilder`

```java
 static int getHerokuAssignedPort() {
        ProcessBuilder processBuilder = new ProcessBuilder();
        if (processBuilder.environment().get("PORT") != null) {
            return Integer.parseInt(processBuilder.environment().get("PORT"));
        }
        return 4567; //return default port if heroku-port isn't set (i.e. on localhost)
    }
```

# Example 3: Multiple Environment Variables

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
