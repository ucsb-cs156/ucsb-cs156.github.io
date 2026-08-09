---
parent: "Agentic AI"
grand_parent: Topics
layout: default
title: "Agentic AI: Claude"
description:  "Using Claude for Agentic AI"
---


## How can you give Claude standing instructions

Short answer: **`CLAUDE.md` at your repo root**, committed to the repo. Claude Code reads it at the start of every session — from the VS Code extension, the CLI, and the GitHub Action alike.

But "instructions for every issue it works on" actually splits into two things, and putting both in CLAUDE.md is the common mistake.

## Standing rules → `CLAUDE.md`

CLAUDE.md files are markdown files that give Claude persistent instructions for a project, your personal workflow, or your entire organization. You write these files in plain text; Claude reads them at the start of every session. This is the right home for facts that should hold no matter what you're doing: build and test commands, naming conventions, "always run `npm test` before committing," where things live.

The locations, broadest to most specific — all of them load, concatenated into context rather than overriding each other:

| Location | Scope | Committed? |
|---|---|---|
| `~/.claude/CLAUDE.md` | You, every project | No |
| `./CLAUDE.md` or `./.claude/CLAUDE.md` | The repo, everyone | Yes |
| `./CLAUDE.local.md` | You, this repo only | No — gitignore it |

Run `/init` to generate a starting file from your codebase, then hand-edit. Target under 200 lines — longer files consume more context and reduce adherence.

## The per-issue workflow → a skill

If your instructions are a *procedure* — read the issue, reproduce it, write a failing test, fix, run the suite, open a PR referencing the issue — that doesn't belong in CLAUDE.md. The docs are explicit: if an entry is a multi-step procedure or only matters for one part of the codebase, move it to a skill or a path-scoped rule instead.

Create `.claude/skills/work-issue/SKILL.md`:

```markdown
---
description: Work a GitHub issue end to end
argument-hint: [issue-number]
---

Work issue #$1:

1. `gh issue view $1` — read it fully before touching code.
2. Reproduce the bug, or confirm the feature is genuinely absent.
3. Write a failing test first.
4. Implement the smallest fix that passes.
5. Run the full suite.
6. Commit with `Fixes #$1` in the message.
7. Open a PR against `main`; do not push to `main` directly.
```

Then `/work-issue 412` runs the whole thing. The advantage over CLAUDE.md is that this only loads when you invoke it, so it costs no context on unrelated sessions.

(`.claude/commands/work-issue.md` does the same thing — the docs now label the single-file `.claude/commands/` form legacy and prefer `.claude/skills/`, but existing command files keep working.)

## Scoped rules → `.claude/rules/`

If some instructions only matter for certain files, `.claude/rules/*.md` with `paths:` frontmatter loads them only when Claude touches matching files:

```markdown
---
paths:
  - "src/api/**/*.ts"
---
- All endpoints validate input at the boundary
- Use the standard error response shape
```

## Two things worth knowing

**Verify it's actually loading.** Run `/context` in a session and check the **Memory files** list. Most "Claude ignored my instructions" reports are really "the file never loaded."

**It's context, not enforcement.** Claude treats these as context, not enforced configuration. To block an action regardless of what Claude decides, use a PreToolUse hook instead. So "never push to main" in CLAUDE.md is a strong suggestion; a hook is a guarantee.

One practical note on the committed-vs-personal split: a root `CLAUDE.md` becomes part of the repo, so if collaborators work in it, they inherit your instructions. That's usually what you want for conventions, but for things that are just your habits — your preferred scratch branch naming, your local test shortcuts — `CLAUDE.local.md` keeps them yours.
