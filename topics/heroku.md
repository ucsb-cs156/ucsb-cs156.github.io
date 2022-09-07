---
parent: Topics
layout: default
title: "Heroku"
description:  "A cloud computing platform"
category_prefix: "Heroku:"
---

[Heroku](https://heroku.com) is a "platform as a service" (PAAS) cloud-computing platform.

At least as of this writing (August 2018), Heroku has a free tier that we can use without needing a credit card
to try out Java applications (including web applications) in the cloud.  This allows us to run Java web applications and make them 
available 24x7 on the public internet.

# Quickstart with Heroku

To get a Java webapp running on Heroku (e.g. a SparkJava web app), here's the minimum you need to do:

1.  You need a file called `Procfile` in the root of the github repo.  It must be called `Procfile`, exactly.  Not `procfile`, not `procfile.txt`, but `Procfile`.

2. In the Procfile, you need the following:

   ```
   web: java $JAVA_OPTS -jar location-of-the-jar-file
   ```
   
   That `location-of-the-jar-file` will need to be replaced with the exact location of Jar file that has everything
   in it needed for your application.  Next, we need to describe how to create a suitable jar file with Maven.
   
   The jar file produced by the sparkjava-01 example is: <br> `target/sparkjava-demo-01-1.0-jar-with-dependencies.jar`
   
   So the Procfile should look like this:
   
   ```
   web: java $JAVA_OPTS -jar target/sparkjava-demo-01-1.0-jar-with-dependencies.jar 
   ```
   
   The name of the jar that is produced by this, when you run `mvn package` might be different depending on other things that are in your `pom.xml`.  Instead of `target/sparkjava-demo-01-1.0-jar-with-dependencies.jar`, it may be something else.  And it's possibly, you won't have a suitable .jar at all. Do the next step first, then do `mvn package` then look in the `target` subdirectory for the jar.  (Oh, and make sure that `target` is in your `.gitignore`.)

   
3.  In your pom.xml, you need this.  You will need to modify the part that says `mainClass` to be the exact package and class
   name of the file that has the main for your web app.   What this does is to create an executable jar that has all the dependencies in it.  For more details, see: <https://www.baeldung.com/executable-jar-with-maven>
   
    
   ```
      <!-- Make executable jar WITH dependencies -->
      <!-- See: https://www.baeldung.com/executable-jar-with-maven -->
      
      <plugin>
	      <groupId>org.apache.maven.plugins</groupId>
	      <artifactId>maven-assembly-plugin</artifactId>
	      <executions>
          <execution>
            <phase>package</phase>
            <goals>
              <goal>single</goal>
            </goals>
            <configuration>
              <archive>
                <manifest>
		                <mainClass>edu.ucsb.cs56.pconrad.SparkDemo01</mainClass>
                </manifest>
              </archive>
              <descriptorRefs>
                <descriptorRef>jar-with-dependencies</descriptorRef>
              </descriptorRefs>
            </configuration>
          </execution>
	       </executions>
      </plugin>
   ```

4.  You may also need to modify the main of whatever example you are working with to be sure that it picks up the port number from Heroku correctly.    The `sparkjava-01` example code does this.  BUT, any particular example Sparkjava app that you happen to find on the web on a tutorial website might or might not have that code.  

   As an example, the tutorial from this repo <http://sparkjava.com/tutorials/application-structure>
   has a hard coded port:
   
   ```
         port(4567);
   ```
   
   That's no good.  Instead, you need this:
   ```     
   port(getHerokuAssignedPort());
   
   ```
   
   That relies on you implementing a static method called `getHerokuAssignedPort` yourself.
   
   Here's the code:

   ```
     static int getHerokuAssignedPort() {
        ProcessBuilder processBuilder = new ProcessBuilder();
        if (processBuilder.environment().get("PORT") != null) {
            return Integer.parseInt(processBuilder.environment().get("PORT"));
        }
        return 4567; //return default port if heroku-port isn't set (i.e. on localhost)
    }
   ```
 
5.  To get this working on Heroku, go to the Dashboard on Heroku and create a new Heroku app.
   Then, go to the Deploy tab, and link that app to your github repo.  Finally, scroll down to where it says:
   Deploy Branch, and click to deploy from the Master Branch.
   
   You should see a running log of the webapp starting up, and at the end, it should give you a button to open your web app.
   Or else, you'll see an error message indicating what went wrong.
   
   Good luck.
   

# The Heroku Toolbelt (aka Heroku CLI)

The "Heroku Toolbelt" is a command-line interface to Heroku that you can install on Windows, Mac or Linux.

As of this writing (08/27/2018), the Heroku toolbelt is also available on the CSIL machines and the machines in Phelps 3525 (CSTL).

* Use `heroku login` to login to your heroku account for your current CSIL shell session
* Use the command `heroku` to list the available commands
* Use `heroku logout` if you want to logout and login to a different heroku account.

# Deploying Java apps to Heroku with Maven

There is a `plugin` for Maven to deploy Heroku apps.   

One note: it appears that you *need to be logged into a Heroku account* using the Heroku CLI on the machine where you are running Maven, or else this plugin will not work.

Here's an example of the plugin configuration in the pom.xml to get this to work.  It is adapated from [this tutorial about using SparkJava with Heroku](https://sparktutorials.github.io/2015/08/24/spark-heroku.html)

```xml
     <plugin>
	<groupId>com.heroku.sdk</groupId>
	<artifactId>heroku-maven-plugin</artifactId>
	<version>0.4.4</version>
	<configuration>
          <jdkVersion>1.8</jdkVersion>
          <!-- Use your own application name, the one from Heroku Dashboard -->
	  <!-- Or use heroku create app-name, e.g. heroku create cs56-m18-lab03-phill -->
          <appName>cs56-m18-lab03-phill</appName> 
          <processTypes>
            <!-- Tell Heroku how to launch your application -->
            <!-- You might have to remove the ./ in front   -->
            <web>java -jar ./target/sparkjava-demo-1.0-jar-with-dependencies.jar</web>
          </processTypes>
	</configuration>
      </plugin>
```
