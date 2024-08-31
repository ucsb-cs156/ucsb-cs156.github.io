---
parent: Code Style
grand_parent: Topics
layout: default
title: "Code Style: astyle"
description:  "Code format checking via mvn commands"
indent: true
---

# {{page.title}}

If the  plugin `git-code-format-maven-plugin` is in the `<build><plugins>` section of your `pom.xml`, you can do code format/style checking automatically via mvn, and then
automate that in your CI/CD pipeline.

Documentation for this plugin can be found here:
* <https://github.com/Cosium/git-code-format-maven-plugin>

An example of what you need in your `pom.xml` to enable this appears below.


## Checking and fixing the formatting

The formatting will be checked anytime you run `mvn verify` (unless you specify `-Dgcf.skip` as in `mvn verify -Dgcf.skip`)
However, that will also run all of the other checks that are part of the `mvn verify` cycle.

To check the formatting and nothing else, use:

```
mvn git-code-format:validate-code-format
```

To fix the formatting, use:

```
mvn git-code-format:format-code
```

Afterwards, do a `git status` to see which files were changed, or `git diff` to see the changes.

## Example plugin code

Here is an example of what goes in your `pom.xml`, in the section `<build><plugins> ... </plugins></build>`:


```xml
              <plugin>
                <groupId>com.cosium.code</groupId>
                <artifactId>git-code-format-maven-plugin</artifactId>
                <version>5.1</version>
                <executions>
                    <execution>
                        <id>validate-code-format</id>
                        <goals>
                            <goal>validate-code-format</goal>
                        </goals>
                    </execution>
                </executions>
                <dependencies>
                    <!-- Enable https://github.com/google/google-java-format -->
                    <dependency>
                        <groupId>com.cosium.code</groupId>
                        <artifactId>google-java-format</artifactId>
                        <version>5.1</version>
                    </dependency>
                </dependencies>
            </plugin>
```

# Adjusting workflows

After you add this to your pom.xml, 
you may experience the unintended consequence that other workflows that use the `verify` phase of Maven's lifecycle--such as the `jacoco:check` step which checks whether
code coverage percentages are within the tolerances specified in the `pom.xml`--may start to fail if the code is improperly formatted.  This may be undesirable; it's more informative
when CI/CD workflows that are checking independent aspects of the code report those independently.

To prevent a `mvn verify` step from checking code formatting, just add `-Dgcf.skip` as in this example:

Instead of using this in a workflow for jacoco:
```
mvn test jacoco:report verify
```

Use this:

```
mvn test -Dgcf.skip jacoco:report verify
```
