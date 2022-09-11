---
parent: Topics
layout: default
title: Javadoc
description:  "Documentation generator for java"
has_children: true
---

# {{page.title}}

# References

* [Oracle's reference for javadoc (in JDK SE 8)](http://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html)

# Javadoc: FAQ

## There's no javadoc for one of my classes!

Check to make sure that your class starts with:

```
public class Foo
```

and not just

```
class Foo
```

If you have a class that doesn't explicily say `public` in front of it, javadoc will not be generated.  
Classes that don't say either `public` or `private` are treated as *package private* which means they are only
accessible within the package where they appear.

If you are writing code without packages at all, then *all* of your code is in the so-called 
"unnamed package", which means that your "package private" classes "seem" to be public.  But, they really aren't.

# Javadoc on github-pages

* http://dephraser.net/blog/2012/04/16/ant-javadox-and-github/
* http://xlson.com/2010/11/09/getting-started-with-github-pages.html
* https://help.github.com/articles/user-organization-and-project-pages
* http://assylias.wordpress.com/2013/01/06/upload-javadoc-to-github/
* http://benlimmer.com/2013/12/26/automatically-publish-javadoc-to-gh-pages-with-travis-ci/


