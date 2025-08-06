---
parent: Topics
layout: default
title: Coding With AI
description: Hints on using AI agents to assist with coding tasks
has_children: true
---

# {{page.title}} - {{page.description}}

The purpose of this page and its sub-articles is to gather information about
effective uses of AI agents (e.g. GitHub Copilot, Google Gemini, ChatGPT, Jetbrains Junie, etc.)
to assist with coding tasks in the context of CMPSC 156.

## Constructing prompts

When constructing prompts, it is important to provide the AI agent with as much context as possible.

Here's an example:

```
I need help with writing a test to cover a line of code.   Context: React, vite, vitest.


Here is the unit under test:

(Paste full contents of .js or .jsx file here)


Here is the test file:

(Paste full contents of .js or .jsx file here)


The line I need to cover is:

(Paste the line that is not covered.)

```

If the test provided by the agent doesn't work, follow up with the error message.

Note that it is not unusual to have to go through several rounds with the agent
before you get an correct solution.  When asking the AI to generate tests, it helps
to:
* Focus on one test at a time
* Read any information the agent gives you about the test, and try to understand the code and the test.  
  The agents are pretty good at getting to a solution *eventually*, but they often need human guidance
  in the form of your *human intelligence*.  
* Focus on using the agent as a way to learn more about writing good tests, and how testing works, 
  as opposed to using it to *avoid* learning those things.

## Example Followup

Here's an example of a followup prompt:

```
Unfortunately, the test you gave me doesn't pass. Here's the result:

 FAIL  src/tests/utils/useLogout.test.jsx > useLogout tests > should log out the user, reset queries, and navigate to home
AssertionError: expected "spy" to be called with arguments: [ '/' ]
Number of calls: 0 
```

The result I got back from this started like this:

> Thanks for the feedback. You're right, the test failed because of a subtle but critical mismatch in the mocking setup.
> 
> The hook you're testing imports useNavigate from "react-router", but the test file was mocking "react-router-dom". Because of this, the vi.mock was not applied to the correct module, and the real useNavigate was used instead of your MapsSpy, which is why the spy was never called.
> 
> To fix this, simply change the module name in your vi.mock call from 'react-router-dom' to 'react-router'.

The answer continued with the full test, refactored with this additional information, and on the second try, the AI got it right.

