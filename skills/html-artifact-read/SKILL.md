---
name: html-artifact-read
description: >-
  Use when the user supplies a postplan, artifact, or hosted HTML URL, or asks
  to read / fetch uploaded HTML. Fetch with the shell, never a browser.
---

# HTML artifact read

Fetch HTML the user already pointed at. Do not render it in a browser tool.

Theo's version targeted `postplan.dev`. You do not have PostPlan. This skill
is the same trigger for any artifact URL you paste.

## Fetch

1. If the path is local (`file://`, an `artifacts/` directory, or a repo
   path), read the file. Do not curl it.
2. If it is `http://` or `https://`:

```bash
# strip a trailing slash, then try /raw if the first body is a viewer shell
url=${1%/}
curl -fsSL "$url"
```

If the body is clearly a host wrapper rather than the document, retry
`"$url/raw"` once. If that 404s, stop and report both status codes.

3. Do not use web search or a browser to retrieve it.
4. After reading, answer from the document. Do not rewrite it unless asked.
