# ops-agent-skills

Generic, machine-independent agent skills, consumable with the
[skills CLI](https://skills.sh) from any machine — including Cursor Cloud
Agent VMs, which have no access to a home directory.

```bash
npx skills add wes-con/ops-agent-skills -g          # this machine
npx skills add wes-con/ops-agent-skills --copy -y   # a repo checkout / cloud VM
```

## Skills

| Skill | Purpose |
|-------|---------|
| `file-upload` | Upload/update/delete one file via the configured file host; local artifact fallback. |
| `html-communication` | Plans, specs, findings, mocks as one self-contained HTML file. |
| `html-artifact-read` | Fetch a hosted HTML artifact with curl, never a browser. |

## Ground rules

This repo is public. Nothing machine-, fleet- or client-specific belongs here:
no hostnames, no endpoints, no tokens, no internal paths beyond `~/.agents`
conventions. Skills read their configuration from environment variables
(documented as names only). Anything that would leak operational detail stays
in the private agents repo.
