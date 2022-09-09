---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: Adding custom jar dependency"
description:  "Including a jar file that isn't available as a standard Maven dependency"
indent: true
---

One of the main advantages of Maven is not having to deal with jar files directly.  

If you depend on JUnit, you just add it as a dependency in your `pom.xml`,  you just add the magic words to specify
`JUnit` as a dependency in your `pom.xml`, and the jar gets automatically downloaded and added to your classpath.

Same with all the parts of Spring Framework, Apache Commons, or whatever.   Pretty much anything that is a standard 3rd party java library.

But what is the thing you need is NOT standard?  Maybe its too new to have been put into Maven Central?

Examples:

* The Virginia Tech Corgis library
* One CS56 legacy code project using code from another

This is the best solution I've found:

* https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html


# Other resources

* <https://devcenter.heroku.com/articles/local-maven-dependencies>
* <http://blog.valdaris.com/post/custom-jar/>
* <http://stackoverflow.com/questions/5692256/maven-best-way-of-linking-custom-external-jar-to-my-project>
* <https://www.mkyong.com/maven/how-to-include-library-manully-into-maven-local-repository/>
* <https://softwarecave.org/2014/06/14/adding-external-jars-into-maven-project/>
* <https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html>
* <https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html>
