---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: Pom.xml Order"
description:  "In what order should the elements of a pom.xml appear"
category_prefix: "Maven: "
indent: true
---

The `pom.xml` can have many elements inside.   The order likely doesn't matter, but for organization purposes, to be sure that you don't 
duplicate an element, it's helpful to have a *canonical order*.  Here *canonical order* just means a particular order that is agreed upon and always the same.  (If you insist on precision, a more rigorous definition can be found on the [Wikipedia article for Canonical form](https://en.wikipedia.org/wiki/Canonical_form).)

In the Maven documentation, the webpage [Maven Code Style And Code Conventions](https://maven.apache.org/developers/conventions/code.html) suggests the order below, so we'll adopt that order as *canonical* for Maven `pom.xml` files in CS56.    

In the code snippet below, you'll find each of the elements names, in the suggested order, formatted as an XML comment.

You can use this as a template to copy paste into your `pom.xml`, then move the sections
you have under the appropriate comment.   This can be particularly helpful when trying to merge together two different `pom.xml` files
from separate examples into one working product.
 
```xml
  <!-- (0) <modelVersion/> -->
  <!-- (1) <parent/> -->
  <!-- (2) <groupId/> -->
  <!-- (3) <artifactId/> -->
  <!-- (4) <version/> -->
  <!-- (5) <packaging/> -->
  <!-- (6) <name/> -->
  <!-- (7) <description/> -->
  <!-- (8) <url/> -->
  <!-- (9) <inceptionYear/> -->
  <!-- (10) <organization/> -->
  <!-- (11) <licenses/> -->
  <!-- (12) <developers/> -->
  <!-- (13) <contributors/> --> 
  <!-- (14) <mailingLists/> -->
  <!-- (15) <prerequisites/> -->
  <!-- (16) <modules/> -->
  <!-- (17) <scm/> -->
  <!-- (18) <issueManagement/> -->
  <!-- (19) <ciManagement/> -->
  <!-- (20) <distributionManagement/> -->
  <!-- (21) <properties/> -->
  <!-- (22) <dependencyManagement/> -->
  <!-- (23) <dependencies/> -->
  <!-- (24) <repositories/> -->
  <!-- (25) <pluginRepositories/> -->
  <!-- (26) <build/> -->
  <!-- (27) <reporting/> -->
  <!-- (28) <profiles/> -->
 ```

# A minimal `pom.xml`

A minimal `pom.xml` has one required top level element, `<project>`, and four
required nested elements, as in this example:

```xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1.0.0</version>
</project>
```	

We have marked the four required elements in the list below.

This example is taken from the [Apache Guide: Introduction to the Project Object Model (POM)](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html), which you might to be a helpful reference.


# Explanation of each section

Having this canonical order gives us an opportunity to write documentation explaining each section of the pom.xml.   

To make this easier to study from, we've divided it into two sections:

* In the first section, we list all elements, but omit details for sections
  that are not generally used in CMPSC 56.
* In the second section, we list only those sections that were omitted the
  first time around.

# All elements 

## (0) `modelVersion` (required)

The `modelVersion` refers to the version of the Project Object Model.  As of Winter Quarter 2020, the current version is `4.0.0`.  So this element should always be:

```xml
  <!-- (0) <modelVersion/> -->
  <modelVersion>4.0.0</modelVersion>
```

## (1) `parent` (optional)

If a large number of `pom.xml` project files share common elements, in
order to promote the principle of "Don't Repeat Yourself", it is
possible to factor our common elements into a *parent*.

It is very common in Spring Boot projects to find the following parent
specified:

```xml
  <!-- (1) <parent/> -->
  <parent>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-parent</artifactId>
      <version>2.1.6.RELEASE</version>
  </parent>
```

Parent projects might be located in a folder higher in the file system than the current project, or they may be downloaded from the web as a dependency.

For example, information about `spring-boot-starter-parent`, can be found
at the website <https://mvnrepository.com/> which lists modules that can be
downloaded by Maven automatically.   The record for `spring-boot-starter-parent` is here:

* <https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-parent>

That's where you might go to see if there is a newer version, for example.

The documentation for the Maven POM notes that just as in Java we have a concept of `java.lang.Object`, from all Java objects implicitly extend if they extend no other object, there is a concept of the *Super POM* which is the parent of all `pom.xml` files.

The Super POM is documented here: <https://maven.apache.org/pom.html#The_Super_POM>.

## (2) `groupId` (required)

Together, the `groupId` and `artifactId` (item (3)) give a unique name to the project you a building.   The `groupId` provides additional scope.  For example,
we might use `edu.ucsb.cs56.w20` as our groupId.   

Example: 

```xml
  <!-- (2) <groupId/> -->
  <groupId>edu.ucsb.cs56.w20</groupId>
```

According to the [Maven Naming Conventions](https://maven.apache.org/guides/mini/guide-naming-conventions.html), the group id is supposed to follow Java's [package naming rules](https://docs.oracle.com/javase/tutorial/java/package/namingpkgs.html), though that doesn't always happen.

Together, the `groupId`, `artifactId`, and `version` form what is called the `coordinates` of a particular project.   

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Maven_Coordinates>

## (3) `artifactId` (required)

The artifact id identifies what you are building.   For example, `lab02`

```xml
  <!-- (3) <artifactId/> -->
  <artifactId>lab02</artifactId>  
```

The `artifactId` is used to name the jar file, and as such should not
contain spaces.

According to the [Maven Naming Conventions](), the `artifactId`:

> "is the name of the jar without version. If you created it, then
> you can choose whatever name you want with lowercase letters and
> no strange symbols. If it's a third party jar, you have to take
> the name of the jar as it's distributed."

The `artifactId` is distinguished from the `name` element (item (6)) in that
the `name` element can be a human friendly name that may contain spaces
and special characters.

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Maven_Coordinates>

## (4) `version` (required)

The version specifies the version of the artifact you are building, for example
version `0.1.0`.   It is customary to use [Semantic Versioning](https://ucsb-cs56.github.io/topics/semantic_versioning/) as a scheme for choosing version numbers.

```xml
  <!-- (4) <version/> -->
  <version>0.1.0</version>
```

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Maven_Coordinates>

## (5) `packaging` (optional)

We can specify here how the artifact is to be built.   For example, this specifies that we want to build a `jar` file:

```xml
 <!-- (5) <packaging/> -->
 <packaging>jar</packaging>
```

The default when no `packaging` element is specified is `jar`.  Other valid values include `pom`, `maven-plugin`, `ejb`, `war`, `ear`, `rar`.

In CMPSC 56, since we will nearly always be using `jar` as our packaging, we could likely always omit this element and use the default value.

For the syntax, and more info, see: <https://maven.apache.org/pom.html#packaging>

## (6) `name` (optional)

`name` is a place we can specify an alternative name for the project, different from the `artifactId`, that doesn't have to adhere to the restrictions that
it be a reasonable filename for the `.jar` file.  For example, the `name` may contain spaces.

Example:

```
  <!-- (6) <name/> -->
  <name>UCSB CS56 W20 lab02</name>
```

The documentation indicates the following:

> Projects tend to have conversational names, beyond the artifactId.
> The Sun engineers did not refer to their project as "java-1.5",
> but rather just called it "Tiger". Here is where to set that value.

See also:
* <https://maven.apache.org/pom.html#More_Project_Information>
* <https://stackoverflow.com/questions/38594036/difference-of-artifactid-and-name-in-maven-pom>

Some `pom.xml` files for CMPSC 56 have the `name` element included, but it is likely not really needed.

As we update these `pom.xml` files, if the `name` element is simply a copy of the `artifactId`, it is likely a good idea to remove it.


## (7) `description` (optional, but recommended)

The description is a free form field that can be used for
any additional information about the project.  It is only for documentation
and therefore is optional.

Example:

```xml
<description>
Lab02 for CS56, W20
</description>
```
However, if you don't include it, the description that shows up on the 
web page generated by the `mvn site` command ends up having the description
inherited from the parent `pom.xml`.  

Therefore it is strongly encouraged to include it.

## (8) `url` (Not used in CMPSC 56)

## (9) `inceptionYear` (Not used in CMPSC 56)

## (10) `organization` (not used in CMPSC 56)

## (11) `licenses` (not used in CMPSC 56)

## (12) `developers` (not used in CMPSC 56)

## (13) `contributors` (not used in CMPSC 56)

## (14) `mailingLists` (not used in CMPSC 56)

## (15) `prerequisites` (not used in CMPSC 56)

## (16) `modules` (not used in CMPSC 56)

## (17) `scm` (Not used in CMPSC 56)

## (18) `issueManagement` (Not used in CMPSC 56)

## (19) `ciManagement` (not used in CMPSC 56)

## (20) `distributionManagement` (optional, but important)

This section is used in CMPSC 56 to specify that the website should be published to the `docs` folder. This allows us to use GitHub pages to publish our documentation.

Here is a sample `distributionManagement` element:

```xml
  <distributionManagement>
    <site>
        <id>website</id>
        <url>file://${project.basedir}/docs/</url>
    </site>
  </distributionManagement>
```

This element has other uses as well, but we are unlikely to see any of those in CMPSC 56.

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Distribution_Management>

## (21) `properties` (optional, but important)

The properties section allows us to define variables that can be used
in later sections of the file to factor out common values, and DRY up the
`pom.xml`.   Some properties are also predefined with default values;
we can override these defaults in the properties section.

This is where, for example, we define the Java Version that we want to use,
and files in the project should be treated as `UTF-8` encoding.

Examples:

Java 8:

```xml
<properties>
    <java.version>1.8</java.version>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```      

Java 11:

```xml
<properties>
    <java.version>11</java.version>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```      

For the syntax, and more info, see: <>

## (22) `dependencyManagement` (not used in CMPSC 56)


## (23) `dependencies` (optional, but important)

Although this is, strictly speaking, an "optional" section of the `pom.xml`, *it is arguably the most important part*.

Automatic dependency management is the most valuable feature of Maven, and the main reason that larger projects prefer it to Ant.   Even folks that use an alternative such as Gradle depend on the Maven infrastructure for dependency management.

So it is worth spending some time to understand this section of the `pom.xml`.  It is the one where you will most often need to add code as you work on Spring Boot projects in Maven.

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Dependencies>


## (24) `repositories` (optional)

The `repositorires` element is used to specify where Maven looks for dependencies.

Here, *repository* doesn't mean a GitHub repository, nor does it mean a Spring Boot data abstraction; it's yet another meaning of the word "repository". In this case, it's a collection of Maven *artifacts*, each with it's own *coordinates* (`groupId`, `artifactId`, and `version`).

The default repository to search is the one specified in the [Super POM](https://maven.apache.org/pom.html#The_Super_POM).  The `repositories` element in the Super POM  looks like this, and specifies that <https://repo.maven.apache.org/maven2/> is the default repository to search.

This element is only needed as/when it becomes necessary to specify additional places to look for dependencies other than the default repository.

The `repositories` element in the Super POM looks like this:

```xml
<repositories>
  <repository>
    <id>central</id>
    <name>Central Repository</name>
    <url>https://repo.maven.apache.org/maven2</url>
    <layout>default</layout>
    <snapshots>
       <enabled>false</enabled>
    </snapshots>
  </repository>
</repositories>
```						      

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Repositories>

## (25) `pluginRepositories` (optional)

This optional element can be used to specify an alternate repository to look specifically for plugins.  It is possible, but unlikely, that we will use this in CMPSC 56.

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Plugin_Repositories>

## (26) `build` (optional, but important)

Although optional, this is one of the most important parts of the `pom.xml`, second only in importance to the `dependencies` section.

This is where we control aspects of how the project is built.

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Build>

## (27) `reporting` (optional, but important)

This section is used to generate the `site`, i.e. the website directory that is created under the `target` directory.  In CMPSC 56 this is used to control two important things:

* `javadoc` generation
* `jacoco` reports (Test Code Coverage)

The following example ensures that there is an `index.html` file produced in the
`target/site` directory:

```xml
 <reporting>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-project-info-reports-plugin</artifactId>
                <version>2.9</version>
                <reportSets>
                    <reportSet>
                        <reports>
                            <report>index</report>
                        </reports>
                    </reportSet>
                </reportSets>
            </plugin>
            <!-- any further custom report here -->
        </plugins>
    </reporting>
```

If you combine this with a file under `src/site/site.xml` that contains the following, you'll get a nice website for your project with links to the javadoc
and the jacoco report.

```xml
<project>
  <body>
    <menu name="Documentation">
      <item name="Javadoc" href="apidocs" />
      <item name="Javadoc (test code)" href="testapidocs" />
      <item name="Jacoco (test coverage)" href="jacoco" />
    </menu>
  </body>
</project>
```

These maven commands are needed to populate the `docs` subdirectory with the
appropriate files:

```
mvn javadoc:javadoc
mvn javadoc:test-javadoc
mvn site
mvn site:deploy
```

Note that `mvn site:deploy` also requires the `distributionManagement` element (20).

For more details on the syntax, and more info, see: <https://maven.apache.org/pom.html#Reporting>

## (28) `profiles` (optional, but important)

Profiles are used in CMPSC 56 to allow us to vary the way we build the project for different targets.

In CMPSC 56, we use Profiles to allow us to build the project differently when we are targetting localhost, vs. when we are targetting Heroku.

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Profiles>

# Elements not used in CS56



## (8) `url` (Not used in CMPSC 56)

The [documentation for this field](https://maven.apache.org/pom.html#More_Project_Information) says:

> The URL, like the name, is not required. This is a nice gesture for projects users, however, so that they know where the project lives.

We will likely not use this field in CMPSC 56.

## (9) `inceptionYear` (Not used in CMPSC 56)

The [documentation for this field](https://maven.apache.org/pom.html#More_Project_Information) says:

> This is another good documentation point. It will at least help you remember where you have spent the last few years of your life

We will likely not use this field in CMPSC 56.

## (10) `organization` (not used in CMPSC 56)

The [documentation for this field](https://maven.apache.org/pom.html#Organization) says:

> Most projects are run by some sort of organization (business, private group, etc.). Here is where the most basic information is set.


## (11) `licenses` (not used in CMPSC 56)

See section "Elements not used in CMPSC 56" below.

This optional element may be used to specify a license for the project.  For the syntax and more info, see: <https://maven.apache.org/pom.html#Licenses>

In CMPSC 56, we use GitHub's feature for generating a license when
creating the repo, so there is likely no need to use this optional
`pom.xml` element.
Unless/until we start distributing our software via Maven Central, we will likely not use this field in CMPSC 56.

## (12) `developers` (not used in CMPSC 56)

This optional element may be used to describe who developed the project.  For the syntax and more info, see: <https://maven.apache.org/pom.html#Developers>

In CMPSC 56, we are tracking this through GitHub, so there is likely no need touse this optional pom.xml element.

## (13) `contributors` (not used in CMPSC 56)

This optional element may be used to describe, in more detail, the roles of individual contributors to the project. For the syntax and more info, see: <https://maven.apache.org/pom.html#Contributors>.

In CMPSC 56, we are tracking this through GitHub, so there is likely
no need to use this optional pom.xml element.


## (14) `mailingLists` (not used in CMPSC 56)

This optional element can be used to specify a mailing list for contributors to a project, or users of a library.

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Mailing_Lists>

In CMPSC 56, we are not setting up mailing lists for individual projects; instead we are using Slack for team communications. So there is likely no need for this optional element.

## (15) `prerequisites` (not used in CMPSC 56)

This field was used in Maven 2, but from Maven 3 going forward, the purpose of this field is replaced by a piece of software called the [Maven Enforcer Plugin's](https://maven.apache.org/enforcer/enforcer-rules/requireMavenVersion.html) `requireMavenVersion` rule.

Since we are using Maven 3, we will not need this field in CMPSC 56.


For the syntax, and more info, see: <https://maven.apache.org/pom.html#Prerequisites>

## (16) `modules` (not used in CMPSC 56)

This element is used in a more complex strategy for decomposing `pom.xml` files called *aggregation*.  It is unlikely that we will need to go into this in CMPSC 56.

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Aggregation>

## (17) `scm` (Not used in CMPSC 56)

SCM stands for "Software ConfiguratLion Mangement", and is another way to say "version Control System".

This would be used to specify which version control system is used for the
project, e.g. a git repo, an svn repo, etc.

Since we have standardized on GitHub for the course, there is likely no need
to use this element in CMPSC 56.

https://maven.apache.org/pom.html#SCM

## (18) `issueManagement` (Not used in CMPSC 56)

According to the documentation at <https://maven.apache.org/pom.html#Issue_Management>, this optional element:

> defines the defect tracking system (Bugzilla, TestTrack, ClearQuest,
> etc) used.  Although there is nothing stopping a plugin from using
> this information for something, its primarily used for generating
> project documentation.

In CMPSC 56 we are using GitHub issues for this purpose.  There is likely no particular benefit to specifying this in the `pom.xml` since the issues are already attached to the repo.

For the syntax, and more info, see: <>

## (19) `ciManagement` (not used in CMPSC 56)

This optional element allows the developer to specify what kind of [Continuous Integration](https://ucsb-cs56.github.io/topics/ci/) system such as [TravisCI](https://ucsb-cs56.github.io/topics/travis_ci/), etc. is being used for this project.

In an complex environment where many different projects used different CI systems, there might be some benefit to specifying this in the `pom.xml.  For our purposes in CS56, we tend to always use just one CI system for all projects in any given quarter (e.g. Travis-CI during F19 and W20).  Therefore there is likely no particular reason to specify this in the `pom.xml`.

For the syntax and more info, see: <https://maven.apache.org/pom.html#Continuous_Integration_Management>

## (22) `dependencyManagement` (Not used in CMPSC 56)

This element, likely not used in CMPSC 56, refers to how dependencies are resolved when inheritance and aggregation are used.  We will likely not need to go into this level of detail.

For the syntax, and more info, see: <https://maven.apache.org/pom.html#Dependency_Management>

