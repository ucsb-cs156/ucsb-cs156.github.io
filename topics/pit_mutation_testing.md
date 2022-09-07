---
parent: Topics
layout: default
title: "PIT Mutation Testing"
description:  "Testing your test suite by mutating your solution, pitest.org"
---

# Quick reference

The maven command to run pitest is:
* `mvn clean test org.pitest:pitest-maven:mutationCoverage`

# Introduction

How do we know whether a test suite for a piece of software is any good?

One way is with code coverage testing, but this is of limited use.  
* Test coverage can definitely show you  what you are *not* testing.  
* It isn't very effective at showing  whether you are testing *well* the things that you *are* testing.

For that, we have *mutation testing*.   Mutation testing involves:
* making many copies of the solution (which is assumed to be correct)
* turning these copies into mutants (copies of the solution with bugs in them)
* checking to see whether those bugs are caught (are the mutants killed?)

One tool for mutation testing in Java is PIT Test, which is explained at <https://pitest.org>

# See also

* Discussion of Mutation testing in <https://ucsb-cs156.github.io/tutorials/student_ex08/>
* Baeldung Article: <https://www.baeldung.com/java-mutation-testing-with-pitest>
