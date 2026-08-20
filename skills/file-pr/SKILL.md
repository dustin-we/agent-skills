---
name: file-pr
description: >-
  Use when the user asks to file, open, or create a PR (pull request), or says
  "file and babysit".
---

# File a PR

File one concise, reviewable pull request with `gh`. The reader is Dustin (or
a future second developer) skimming dozens of these — optimize for them.

## Before filing

1. Check whether a PR for this branch already exists: `gh pr list --head <branch>`.
   If yes, update that one instead of opening a second.
2. Review the diff against `origin/main` and confirm it matches the user's
   original goal — nothing more.
3. Branch names follow the repo convention: `feature/…` or `fix/…`.

## Title

PR titles usually become commit messages. One short line that explains why the
change matters, in plain language.

- Bad: `fix server parse CLI version in update pre-flight`
- Good: `fix: version drift warning showed on every start`

## Description

Open with the problem in the user's words, then briefly the solution. Do not
lead with an implementation inventory.

- Bad: "Removed implicit workspace carryover from every new thread entry
  point. New threads inherit only the project from context…"
- Good: "My new-worktree default was ignored when starting new threads.
  Super unintuitive. Now the preference always applies."

End with one line naming the model and harness that made the change, e.g.
`— claude-fable-5 via T3 Code`. If the harness does not expose the model slug,
say so instead of guessing.

## Rules

- Open a **real** PR, not a draft — drafts skip review bots where they exist.
- Never include secrets, `.env` contents, or customer paths in title or body.
- Screenshots or recordings: upload via the `file-upload` skill and embed the
  URL. Never commit media into the repo for this.
- If the user also said "babysit", continue with the `babysit-pr` skill after
  filing.

## Not for this repo?

If the repository has no remote or the user normally commits straight to
`main`, say so and offer a plain commit instead of inventing a PR flow.
