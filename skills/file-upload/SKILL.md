---
name: file-upload
description: >-
  Use when the user asks to upload a file, or a local screenshot, recording,
  log, document, or build artifact is needed for a PR or preview.
---

# File upload

Publish one local file through the configured file host and return a URL the
human can open. Public links serve from the host's public base URL without
auth; the link for a key never changes.

## Requires

`FILE_HOST_URL` (the upload API endpoint) and `FILE_HOST_TOKEN`. The script
loads them from `~/.agents/.env` when that file exists; already-set environment
variables work too (on a cloud VM they come from the Cursor dashboard secrets).
If both sources are missing, do **not** invent a service and do **not** use
1Password. Fall back to a local artifact and say so.

## Steps

1. Confirm the file exists on this machine.
2. Run the script that sits next to this SKILL.md (invoke via `sh`, the exec
   bit may be missing on a fresh copy):

```bash
sh <path-to-this-skill>/scripts/upload.sh /path/to/file
```

3. Key choice: by default the key is derived from the filename and stays
   readable (generated collisions get `-2`, `-3`, …). Add `--slug NAME` for an
   exact key (fails with 409 if taken) or `--random` for a UUID key when the
   link should not be guessable.
4. Treat stdout as the public URL. If the script exits non-zero, stop and
   report stderr.
5. Never claim a public URL for a `file://` or `artifacts/` path.

## Replace or delete

KEY is the last segment of the public URL. An update swaps the content behind
the same link — no history. Delete is permanent and idempotent.

```bash
sh <path-to-this-skill>/scripts/upload.sh --update KEY /path/to/file
sh <path-to-this-skill>/scripts/upload.sh --delete KEY
```

## Using the URL

- PR or chat: paste the URL. For video, a short sentence plus the link is enough.
- Optional GIF preview with ffmpeg only when the user asked for a preview image.

## Local fallback

Without a host, the script copies to `~/.agents/artifacts/` (gitignored,
created if missing) and prints a `file://` path. On a Mac with a display you
may `open` that path if the user wants to see it. On a headless machine or
cloud VM, just return the path.
