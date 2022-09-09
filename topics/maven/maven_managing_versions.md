---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: Managing Versions"
description:  "How do you get the right version for dependencies, plugins, etc."
indent: true
category_prefix: "Maven: "
---

In a Maven `pom.xml`, the author specifies dependencies such as:

```
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
      <scope>test</scope>
    </dependency>
```

And plugins such as:

```
 <plugin>
	 <groupId>org.apache.maven.plugins</groupId>
	 <artifactId>maven-javadoc-plugin</artifactId>
	 <version>3.0.0-M1</version>
	 <configuration>
	  <reportOutputDirectory>docs</reportOutputDirectory>
	 </configuration>
 </plugin>
```

These typically have version numbers specified.  How do you know which version to use?

Here are two ways:

# Getting Versions from Maven Central

At this site, you can search for dependencies and plugins and find the various versions, along with the Maven xml element to copy past and
put into your `pom.xml`:

* <https://mvnrepository.com/repos/central>

# A plugin to help manage dependency versions

This plugin helps manage dependency versions:

* <https://www.mojohaus.org/versions-maven-plugin/usage.html>

This Stack Overflow answer offers one example of how to use it:

* <https://stackoverflow.com/a/19324681>

# Using the `org.codehaus.mojo.versions-maven-plugin`

(These instructions are from <https://stackoverflow.com/a/19324681>)

Add this plugin under the `<build>` section

```
<project>
  ...
  <build>
    ...
    <plugins>
      ...
      <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>versions-maven-plugin</artifactId>
        <version>2.1</version>
      </plugin>
      ...
    </plugins>
    ...
  </build>
  ...
</project>
```

This command will create a backup of the `pom.xml` called `pom.xml.versionsBackup`

```
mvn versions:set -DnewVersion=9.9.9
```

Then run this, which updates the `pom.xml`

```
mvn versions:use-latest-versions
```

You can then run:

```
diff pom.xml pom.xml.versionsBackup
```

Test with the new versions.  You may want to then set the version in the `pom.xml` back to what it was before.
