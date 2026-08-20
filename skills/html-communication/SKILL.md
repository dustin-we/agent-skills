---
name: html-communication
description: >-
  Use when the user wants a plan, spec, write-up, findings, summary, report,
  comparison, or UI mocks as readable HTML, or mentions HTML with no additional
  context. Do not use for HTML that ships in a product.
---

# HTML communication

Present something a human should read *outside* the terminal as one HTML file.
This is not a landing page and not product UI.

## When

Plans, specs, findings, comparisons, UI mocks. The word "plan" is often absent.
If they just say "HTML", use this skill.

Do not use this for HTML that belongs in a repo.

## Write

- One self-contained HTML file. No external CSS/JS. Cap 512 KB.
- Write it like a spec: headings, short paragraphs, lists, tables. Dark
  background, white text, high contrast. No hero / marketing chrome.
- UI mocks: label them A, B, C. Lay them out for side-by-side comparison.
- Keep the same output path across iterations so a later upload can reuse a
  stable URL once a host exists.

Default path:

```text
~/.agents/artifacts/<short-kebab-name>.html
```

On a machine without `~/.agents` (e.g. a cloud VM), use
`.artifacts/<short-kebab-name>.html` in the workspace instead and keep it out
of git.

## Publish

1. Write the file.
2. If a public link is needed, use the `file-upload` skill. Never claim the
   document is hosted before that script succeeds.
3. If `FILE_HOST_URL` is unset, return the `file://` path and say it is local.
4. Do not open a browser unless the user asks. On a Mac with a display,
   `open` the local file only when they want to look at it here.
5. Do not use a browser or web-search tool to "verify" the upload.

## Mocks

When offering variants, stop after the HTML is ready. Wait for a choice like
"C plus D plus A" before changing product code.
