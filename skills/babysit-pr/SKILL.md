---
name: babysit-pr
description: >-
  Use when the user asks to monitor, watch, shepherd, or babysit a PR until it
  is green and approved.
---

# Babysit a PR

Keep one PR merge-ready until it is green and approved, without letting it
grow. Requires an existing PR (`file-pr` creates it).

## Loop

Poll with `gh pr view`, `gh pr checks`, and the review threads. Act only on
checks and comments **newer than the latest push** — do not re-litigate old
threads.

1. CI red? Distinguish a real repo failure from an infrastructure flake.
   Fix real failures; for flakes, re-run and say why.
2. New review comment (human or bot)? **Verify the finding against the source
   before changing code.** Bots are often wrong.
   - Real issue → fix it.
   - Not worth addressing → reply with a short written reason and resolve the
     thread. Never ignore silently.
3. `main` moved? Rebase or merge main so the PR stays current.
4. Repeat until: checks green, reviews resolved, approvals in.

## Comment etiquette

Comments left on Dustin's behalf are marked as such:

```
`<model slug>` responding on behalf of Dustin:
<reply>
```

## Hard rules

- **The most important line:** do not let review feedback expand the PR beyond
  the user's original goal. Address real shortcomings, avoid scope creep. If a
  reviewer asks for more, note it as a follow-up instead of building it.
- If an overlapping PR makes this one obsolete: stop, report, and ask before
  closing — unless closing was explicitly authorized.
- Never force-push over someone else's commits on the branch.
- No reviewers, no bots, no CI configured? Say that the babysit loop has
  nothing to watch and stop, instead of polling forever.

## Reporting

When done (or blocked), report in one short block: final check status, what
was fixed, which comments were dismissed and why.
