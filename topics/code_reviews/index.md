---
parent: Topics
layout: default
title: "Code Reviews"
description:  "An important part of professional software dev practice"
has_children: true
---

# Tips for Performing Code Reviews

Always try to be helpful, not harsh.  Be diplomatic and kind.

Realize that having your code reviewed by others, especially if you are new to that process, can be intimidating.  People can feel very vulnerable.

It can help to:
* ask questions rather than making statements
* invite folks to consider alternatives rather than telling them what to do

Examples: 

| This may come across as harsh |  Consider whether this might be better |
|-------------------------------|-----------------------------------------|
| This code is a mess; do you even know how to indent? | I wonder if this code would be easier to read if the indentation were more consistent. |
| This isn't how you are supposed to write JavaScript | I wonder if you are familiar with the reasons that `const` and `let` are preferred to  `var`? |
| Delete this  commented out code | Consider removing this commented out code  |

# Tips for Responding to Code Reviews

Try to **respond from a position of gratitude**.  

- The reviewer spent time looking at your code.  Try to be grateful for their time.
- Show your appreciation by addressing each comment.  "Addressing" doesn't mean you have to do what the reviewer says, or that you have to agree with them.  It does mean that you should at least acknowledge their input.
- If you agree, make the change and say "Thanks, fixed" or at a minimum "Done".   Better is "good call, fixed", or "thanks for catching that, fixed".  If you learned something new, acknowledge that "Wow I didn't realize, thanks for pointing that out. Fixed."
- **If you disagree, don't just dismiss the comment**.  
- At the very least say: "Hmm, I see it differently; let's discuss".  Or "I'm not sure I understand your perspective; can you explain further?" Or "I see where you are coming from, but i/we think it should be like this..."
  
# What to look for in a Code Review (non-exhaustive)

Non-exhaustive means that this list is incomplete; it's just a collection of examples, not the complete list of everything you should be looking for.

## In the PR itself

* Is the purpose of the PR well explained, not just the what, but also the why?
  - It is super important to explain the *why*, since the *what* can, if necessary, be determined by looking at the diff.
  - But the *why* is often unknowable unless it is explained
  - Where applicable, the *why* should be explained in terms of the impact on the user of the application: what will they experience differently?
  - If the *why* has no impact on the end user, then what is the purpose?  Is it to make the code more maintainable?  To improve performance?  Improve test coverage?  Make developers more productive? Something else?  Explain.
* Where applicable, are there before/after screenshots?
* Is the PR linked to an issue (or issues) on a Kanban board where appropriate?
* Have you moved the PR to the correct column on the Kanban board?
* Do both the PR and the Issue(s) have developers assigned?

## Testing / QA / Acceptance
* Does the PR pass all of the CI/CD tests?
* Have you deployed the code on either localhost and/or Heroku (preferably both) and tested the impacted functionality?
* If the issue(s) this PR addresses have acceptance criteria, are all of those met?  And if so, are they checked off?

## In the code

* Commented out code; typically this should be removed before merging into the default branch.

## In the PR file list

* Unnecessary files such as `.DS_Store` files from Mac users, `*~` files from emacs users.
* `package.json` and `package-lock.json` at the top level of the repo (they should only be in the `frontend` directory
  - This is typically the result of accidentally running `npm install` in the top level directory instead of the `frontend` directory

