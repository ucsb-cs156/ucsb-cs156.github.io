---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Pitest"
description:  "Mutation testing for Java"
---


# What is Mutation Testing?

If you want to check whether your code works, you can run your test cases.

But how do you know if your test cases are any good?

One way is to check code coverage.  But with code coverage, we can cheat: we can write a test suite that calls every single method&mdash;and perhaps even calls some of them
more than once with various parameters to ensure that we go through every path in the code.  That way all of our lines are "covered".  But if we then do no assertions
to make sure the code produced the correct result, the only thing we've shown is that our code doesn't compiles and doesn't crash.  We have *not* shown that the code
produces the correct result.

But, if we have code that we think is correct, and a test suite we think is pretty good, we can measure the quality of that test suite with mutation testing.

What mutation testing does is to create a large number of "mutant" version of our code: each one has one potential bug introduced.  Mutations do things 
like:
* replacing return values, or the right hand side of an assignment statement with null, empty string, 0, etc.
* changing `<` to `>` or `>=`, changing `==` to `!=` etc.
* deleting lines of code

We then see whether the test suite "kills the mutants"; mutants are "killed" if the test suite fails when we run the test suite.

If a mutant survives, it likely means that one of the following is true:
1. Usually: we have code that we need for which there is no test
2. Sometimes: We have code that we don't really need, that we should delete; it is not contributing to the correctness of the solution
3. Rarely: the mutation changed the code to code that is equivalent to the original (i.e. also correct)

That's what mutation testing does: in short, it *doesn't test our code; instead, it tests our tests*.

# Mutation Coverage with `pitest`

We can perform mutation testing on our Java test code using software called pitest.

The main pitest documentation is here: <https://pitest.org/>

To run pitest with maven, we first must have a "green" test suite, i.e. all of the tests must pass.  If even one fails, pitest won't even start doing mutation testing.

Once your test suite is green, you can run mutation testing with:

```
mvn pitest:mutationCoverage
```

If you want the command to fail when a goal (expressed as a percentage) is not met, you can add one or more of these flags:
```
mvn pitest:mutationCoverage -DmutationThreshold=100 -DcoverageThreshold=100
```

* `-DmutationThreshold=100` means we want 100% of the mutants to be killed, or else we'll fail the build
* `-DcoverageThreshold=100` means we want 100% of the lines of code to be covered by tests, or else we'll fail the build

Note that jacoco does line coverage only, and runs much faster, but we can also get line coverage from pitest.

# Pitest reports

The report from pitest can be found in `target/pit-reports/index.html`

Or, if you are running pitest through GitHub Actions, you can get the pitest report from the "artifacts", as long as the CI/CD script contains this block of code:

```
- name: Upload Pitest to Artifacts
      if: always() # always upload artifacts, even if tests fail
      uses: actions/upload-artifact@v2
      with:
        name: pitest-mutation-testing
        path: target/pit-reports/* 
```

The animation below shows how:


