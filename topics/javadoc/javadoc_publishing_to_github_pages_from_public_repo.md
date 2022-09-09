---
parent: Javadoc
grand_parent: Topics
layout: default
title: "javadoc: publishing to github pages from a public repo"
description:  "step-by-step instructions"
indent: true
---

This workflow is used when you want to publish JavaDoc from a public repository. This will be the case when you are working on your legacy code projects, but it is NOT the case when working on your labs because those repositories are PRIVATE.

If you have already been through the steps of [publishing to github pages from a private repo](https://ucsb-cs56-pconrad.github.io/topics/javadoc_publishing_to_github_pages_from_private_repo/), these instructions should seem familiar and, hopefully, simpler. If not, don't worry! You aren't missing anything.

# Before Beginning

Move to the top directory of your repository (we will run ALL commands in this tutorial from this directory), and make sure you are on the correct branch. This is likely `master`, but if you are working on a legacy project, you may have your own development branch. In any case, you should NOT be on the `gh-pages` branch. To check which branch you are currently working on, you can run

```
git branch
```

This will pop up a list of branches, with the one you are currently on highlighted. To switch branches, run

```
git checkout <branch name>
```

# Step 1: Modify or Create the Ant JavaDoc Target

Open the `build.xml` file in your favorite text editor. Then find the javadoc target, which should start with something like:

```
<target name="javadoc"  depends="compile"
```

If there is no javadoc target, you will be creating it now! If there is, we need to make sure that it is ONLY compiling the javadoc into a the `javadoc` folder and not trying to copy it somewhere else (as in [publishing to github pages from a private repo](https://ucsb-cs56-pconrad.github.io/topics/javadoc_publishing_to_github_pages_from_private_repo/)).

Since we no longer want to copy the javadoc files to another directory, we can remove all references to creating and copying the javadoc directory, including the XML property `public_javadoc_absolute_path`. However, we want to keep the property called `javadoc_absolute_path`. Once you are finished, the javadoc target should look like this:

```xml
<property name="javadoc_absolute_path" location="javadoc"/>

<target name="javadoc" depends="compile" description="generate javadoc">
  <delete>
    <fileset dir="javadoc" />
  </delete>
  <javadoc destdir="javadoc">
    <fileset dir="src" >
      <include name="*.java"/>
    </fileset>
    <classpath refid="project.class.path" />
    <link href="https://docs.oracle.com/javase/8/docs/api/" />          
  </javadoc>
  <echo>
    javadoc written to file://${javadoc_absolute_path}/index.html
  </echo> 
</target>
```

To test your changes, run `ant javadoc`. This should generate a `javadoc` directory containing a bunch of HTML files.

# Step 2: Modify .gitignore to Ignore the JavaDoc Directory

Now that we are placing our documentation in the `javadoc` directory of the current repository, we want to prevent these files from being committed to the master branch (or your working branch; see above). One of the principles of source control systems (like Git) is that machine-generated files should not be placed in source control. Since your JavaDoc files are generated automatically by `ant javadoc`, this principle applies to them. To prevent yourself from accidentally adding and committing this folder, open the file `.gitignore.` and add this on a new line at the end of the file:

```
javadoc/
```

Now, whenever you run `git add *` or `git add .`, the `javadoc` directory will not be included in the files added to Git. However, it is possible that you or someone else already added the `javadoc` files to this repository (particularly if it is a legacy code repository). To make sure this is not the case, run the following command:

```
git rm -rf javadoc
```

This may produce an error message if the `javadoc` directory was not present or may not produce any output if you successfully removed the directory. Either way, you can now be certain that your JavaDoc files are not in the repository. To finish up this step, add, commit, and push all of your changes to GitHub:

```
git add .
git commit -m "<message>"
git push origin <branch, probably master>
```

# Step 3: Create the gh-pages Branch

Previously, you may have made your JavaDoc available on GitHub Pages by creating a separate public repository with a `gh-pages` branch. Now, we are going to use a `gh-pages` branch in the SAME REPOSITORY, removing the complication of copying the `javadoc` directory around. The reason we can do this now but not before is that your legacy code repositories are PUBLIC while you lab repositories are PRIVATE, and we can only use GitHub Pages from a public repository. If you are not familiar with GitHub Pages, read the introduction of [publishing to github pages from a private repo](https://ucsb-cs56-pconrad.github.io/topics/javadoc_publishing_to_github_pages_from_private_repo/) to get up to speed. Since we do not need to create a new repository in this case, we can do everything from the command line. To create a gh-pages branch, run:

```
git checkout -b gh-pages
```

If you get an error message complaining that "a branch named gh-pages already exists," there is already a gh-pages branch, and you can just run

```
git checkout gh-pages
git pull origin master
```

Now that we have a `gh-pages` branch locally, we need to make sure this branch is reflected in GitHub, which we do by pushing to the `gh-pages` branch:

```
git push origin gh-pages
```

# Step 4: Make the JavaDoc Available on gh-pages

So we have a gh-pages branch and, as a result, a GitHub Pages site. However, because we removed the `javadoc` directory there is nothing on that site. Darn it! Well, now that we're on the `gh-pages` branch, we can just put the JavaDoc back, right?

Yes! That's exactly what we're going to do.

Reopen the `.gitignore` file and remove the line `javadoc/` that you added towards the beginning of this tutorial. Now your `javadoc` directory will be visible to git. Run `ant javadoc` to generate all of the JavaDoc, then:

```
git add .
git commit -m "Added javadoc to gh-pages"
git push origin gh-pages
```

Now your javadoc should be available at

```
https://<organization or user name>.github.io/<repository>/javadoc/index.html
```

Copy the link, and substitute the appropriate names. It may take a minute or so for the GitHub Pages site to show up.
