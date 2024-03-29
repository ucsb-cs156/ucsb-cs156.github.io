---
parent: Javadoc
grand_parent: Topics
layout: default
title: "Javadoc: Legacy Code Projects"
description:  "step-by-step instructions for javadoc for UCSB-CS56-Projects"
indent: true
---

# Before we begin

This tutorial is for those who have completed javadoc tutorial refered in [rational_04](http://ucsb-cs56-pconrad.github.io/tutorials/rational_ex04/). We will be using the javadoc folder generated by the build.xml to make the Github pages. Also make sure that you are in your top directory such that we can do commands in the top directory.

# Step 1: Generate your `javadoc/` folder

Now because your `javadoc/` folder shouldn't/won't be in your pull request, we need to add it to your `.gitignore`. So that's pretty simple, add the following line into your `.gitignore`:

  `javadoc/`
  
I know, mindblowing. 

Next, in your terminal, you can generate your `javadoc/` folder by simply entering `ant javadoc` if your build.xml is configured correctly. However, if you do not have a javadoc target in your build.xml you can also refer to [step 1 from javadoc: publishing to github pages from a public repo](http://ucsb-cs56-pconrad.github.io/topics/javadoc_publishing_to_github_pages_from_public_repo/) or for the lazy, you can copy the following snippet of xml code into your build.xml:

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

# Step 2: Fork javadoc repo for your project

Your mentor should have created a javadoc repo for your legacy project in the [UCSB-CS56-Projects-Javadoc](https://github.com/UCSB-CS56-Projects-Javadoc) Github organization. To make sure, you can click on the link and find the repo that matches your legacy project. E.g. if you are working on `cs56-games-minesweeper`, the repo name should be `cs56-games-minesweeper`. It's an simple as that. If it doesn't exist, ask your mentor to create the repo for you. 

Once it is created, make sure there is a file for the `LICENSE` and `README.md` and the default branch is the `gh-pages` branch. Again, if this is not the case, talk to your mentor. Now you should fork the page as you have when you forked your legacy code project. After forking is done, go to the settings of the forked repo to set the default branch as `gh-pages`. This will allow you to test the Github javadoc page yourself before you push. 

# Step 3: Clone your repos

Assuming that you already generated the `javadoc/` folder in Step 1, your should already have a clone of your legacy project's fork. We will need to have a clone of the javadoc version of your legacy project as well. So go to your legacy project's javadoc repo's fork (I know that's long and confusing but you got this) and clone it into the folder above your clone of your legacy project.

### BUT WAIT, the legacy project repo has the same name as your javadoc repo.
There is an easy fix. When you clone, add the desired folder name at the end of the command. e.g:

    git clone <Github HTTPS URL> <legacy project>-javadoc

    OR //real life example

    git clone https://github.com/UCSB-CS56-Projects-Javadoc/cs56-games-minesweeper.git cs56-games-minesweeper-javadoc

Now you should have a folder that holds your main legacy project called `<legacy project>` and a folder that will contain your javadoc called `<legacy project>-javadoc` that you just cloned.


# Step 4: Move your `javadoc/` folder into the javadoc repo

Now that you have:

  1. Generated your `javadoc/` folder in your legacy project folder AND placed the javadoc into your gitignore.
  2. Forked your javadoc repo from [UCSB-CS56-Projects-Javadoc](https://github.com/UCSB-CS56-Projects-Javadoc).
  3. Cloned your forked javadoc repo AND set the default branch to `gh-pages`.

Wecan move the `javadoc/` folder into your javadoc repo. If you feel confident, try doing this without help.  Remember that Unix commands are directory specific so you will need to be a a directory above the directory you wish to move folders into OR refer to the directory directly through ~/.

<details> 
  <summary>If you _really_ need help then click the triangle on the left. </summary>
  
    mv [legacy project repo]/javadoc [legacy project javadoc repo]
    
    OR //real life example
    
    mv ./cs56-games-minesweeper/javadoc ./cs56-games-minesweeper-javadoc
</details>


Continue with your normal Github workflow by going into the javadoc repo typing the following commands:
```
git status
git add javadoc/
git status
git commit -m "updated javadoc repo"
git push origin gh-pages
```
If you get an error saying that your gh-pages does not exist, you should check again that the default branch of the repo is gh-pages AND that you have it as a remote.

# Step 5 submit a pull request

The forked javadoc repo should now be able to show you the javadoc. To make sure of this, go to the Github page of the forked javadoc repo that you just pushed to. You can look in the settings for the link that Github published to. The format is usually as follows:

`https://<organization or github id>.github.io/<project name>/javadoc/index.html`

E.g. For minesweeper:

`https://ucsb-cs56-projects-javadoc.github.io/cs56-games-minesweeper/javadoc/index.html`

Please make sure that your own javadoc link works before submitting a pull request. Here is a complete checklist/tl;dr for you to follow in case you want to double check the steps:

  1. Generated your `javadoc/` folder in your legacy project folder AND placed the javadoc into your `.gitignore`.
  2. Forked your javadoc repo from [UCSB-CS56-Projects-Javadoc](https://github.com/UCSB-CS56-Projects-Javadoc).
  3. Cloned your forked javadoc repo AND set the default branch to `gh-pages`.
  4. Move the `javadoc/` folder from your main legacy code cloned repo to the cloned javadoc repo and push it to the `gh-pages` branch.
  5. Test the link in your forked repo before finally submitting a pull request to the main javadoc repo.

You're done! Go get some recognition from your friends and tell your family.
