---
parent: React
grand_parent: Topics
layout: default
title: "React: Patterns"
description:  "Common patterns in our code base"
category_prefix: "React: "
indent: true
---

<style>


summary { 
   border: 4px solid green;
   padding: 1em;
   background-color: #ffe;
   margin-bottom: 1em;
}

details { 
  margin-top: 1em;
  margin-bottom: 1em;
  margin-left: auto;
  margin-right: auto;
  width: 80%;
  border: 4px solid blue;
  padding: 1em;
}


</style>

There are many *patterns* for writing components in React.   Here we present a few that you will find in our
code base:

We explains, among other things:
* Implementing a data entry form
* Implementing a data table
* Implementing a look ahead selector
* Implementing a drop down selector
* Simple component to just factor out some HTML

We have a separate article for implementing a top level page

# First a bit about the word *pattern*

We are abusing the term *pattern* a bit here.  Our usage doesn't exactly correspond to the usage of *pattern*
as it is used in the phrase *design patterns* in discussions of software engineering.

* If you are interested in exploring that, click the box below to open a longer discussion.  
* If you just want to get to the solution to your problem, you can skip over this for now.

<details>
<summary>
Open this box for a discussion of how the word *pattern* is used on this page, 
and how that differs from the canonical use in Software Engineering.
</summary>

According to Wikipedia, in Software Engineering, a *pattern* is:

> ...a general, reusable solution to a commonly occurring problem within a given context in software design. 
> It is not a finished design that can be transformed directly into source or machine code. 
> Rather, it is a description or template for how to solve a problem that can be used 
> in many different situations. Design patterns are formalized best practices that the programmer
>  can use to solve common problems when designing an application or system.

Examples of *design patterns* in Software Engineering include:
* Visitor Pattern
* Model-View-Controller Pattern
* Decorator Pattern
* Facade Pattern
* etc.

What we describe here doesn't correspond precisely to this formal definition of software design *pattern*, though it
does share some things in common:
* We do describe "commonly occuring problems" that occur in a given context (namely our Spring/React architecture)
* We do present examples of how to approach those problems, including sample code.

What this does *not* have in common with the usual accepted definition of pattern:
* Traditionally, patterns are usually described at a very high level of abstraction.  That's not what we do here.
* Instead, we provide specific examples of code to solve an instance of the problem, along with general advice of
  how to adapt the solution to your specific needs.
* Typically by the time something gets the name *design pattern*, it has been:
  - observed "in the wild" in many projects
  - has been implemented in multiple programming languages
  - is understood to be a "good practice", i.e. it has particular known advantages (and possibly pitfalls as well.)

</details>

# Implementing a data entry form

* TODO: Point to react-hook-form examples in STARTER-team02

## Implement a Boolean in Data Entry Form

<img width="579" height="278" alt="Screenshot 2025-10-30 at 6 03 28 PM" src="https://github.com/user-attachments/assets/3979464e-a09d-4b3c-83ef-164ff23b1b32" />


# Implementing a data table

* TODO: Point to react-bootstrap-table-next examples in STARTER-team02

# Implementing a look ahead selector

* TODO: Point to examples in STARTER-team02

# Implementing a drop down selector

* TODO: Point to example in proj-ucsb-courses-search

# Implementing a multiple-stage selector

* TODO: Point to example in proj-ucsb-cs-las

# Simple component to just factor out some HTML

* TODO: Point to examples in proj-ucsb-courses-search


