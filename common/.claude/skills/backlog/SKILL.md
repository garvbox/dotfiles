---
name: backlog
description: Manage a single global backlog across all sessions. With arguments, log a new item (tagged with current project) to BACKLOG.md. Without arguments, summarise the existing backlog.
argument-hint: "[description of item to log]"
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob, Grep, AskUserQuestion
model: sonnet
---

# Backlog

You manage a single global backlog file that collects deferred-work items across every project and session. The skill has two modes, chosen by whether arguments are provided.

**Global backlog path:** `/Users/garvin/projects/kv-workspace/BACKLOG.md`

This path is fixed. You always read/write here regardless of the current working directory. Entries are tagged with the cwd at the time they were logged.

## Step 1: Choose mode

**If the user provided arguments** (`$ARGUMENTS` is not empty) → **log mode**. Use the arguments as the starting topic and continue to Step 2.

**If no arguments were provided** → **summary mode**. Read `/Users/garvin/projects/kv-workspace/BACKLOG.md` and present a scannable overview, then stop. Do not offer to log anything, do not ask follow-up questions. Format:

- Open with a one-line count, e.g. "9 items on the backlog."
- If the current working directory matches a `from:` tag in any entry (or the cwd is `~/projects/kv-workspace`, which is the implicit default), list **"In this project"** first, then **"Elsewhere"** for everything else. Otherwise, list everything under a single heading.
- Within each group, one line per entry: `• <title> _(YYYY-MM-DD)_` — preserve the file's existing order (most recent first).
- Do not reproduce the prose body, done-subitem checkboxes, or the `from:` tag inline. Keep it terse — the user is scanning, not reading.
- If the file doesn't exist, say so in one line and stop.

Steps 2–4 below only apply to **log mode**.

## Step 2: Gather context and check for PLAN.md

Before writing, do these in parallel:

1. **Read the global `BACKLOG.md`** at `/Users/garvin/projects/kv-workspace/BACKLOG.md` to understand what's already there and avoid duplicates. If the file does not exist, you'll create it in Step 3.
2. **Check for a project `PLAN.md`** at the current working directory (cwd). Only relevant if the cwd is a project with an existing `PLAN.md` — in that case, read it.
3. **Elicit one round of clarification** — ask the user a single focused question to capture context they'd want when re-reading this entry later. Examples:
   - "What's the specific symptom / trigger?"
   - "Any files or components involved?"
   - "What approach were you leaning toward?"

   Keep it to ONE question. Don't over-interview.

4. **If a project `PLAN.md` was found** and the entry clearly fits as a planned work item for that specific project rather than an ad-hoc note, ask the user: "This sounds like it might belong in this project's PLAN.md — want me to add it there instead?" Respect their answer. **If the user chooses PLAN.md, skip Step 3 entirely and go to Step 4.**

## Step 3: Write the entry

This step applies only when writing to the global `BACKLOG.md`. If the user chose PLAN.md in Step 2, skip to Step 4.

Compose a short section:

```markdown
## <concise title>
_<YYYY-MM-DD>_ · _from: <cwd>_

<1 paragraph, max 2. Capture the what, why, and enough context to jog memory. Be specific — mention file names, component names, error messages, or behavioral details when relevant.>
```

**The `from:` tag:**
- Use the current working directory of this Claude session.
- Substitute `$HOME` with `~` for readability (e.g. `~/projects/myapp` rather than `/Users/garvin/projects/myapp`).
- If the cwd is the kv-workspace itself (`~/projects/kv-workspace`), you may omit the `· _from: …_` suffix entirely — it's the implicit default and adds noise.

**Placement rules:**
- Target file: `/Users/garvin/projects/kv-workspace/BACKLOG.md`.
- If the file doesn't exist, create it with a `# Backlog` header, then the section.
- If it exists, insert the new section **immediately after the `# Backlog` header line** (before any existing `##` sections), so most recent is first.
- Never remove or modify existing sections.

**Style rules:**
- Title should be imperative ("Fix X", "Add Y", "Investigate Z")
- Body is plain prose, no bullet lists or sub-headers
- Max 2 short paragraphs
- Include specific details (file paths, component names, error text) that make this actionable later

## Step 4: Write to PLAN.md (alternative)

This step applies only when the user chose to add the item to the current project's `PLAN.md` instead of the global `BACKLOG.md`.

1. Read the project `PLAN.md` (at cwd) and study its existing structure, formatting, and conventions (heading levels, bullet styles, section organization, etc.).
2. Add the new item **matching the format already used in PLAN.md**. Place it in the most logical existing section, or create a new section only if nothing fits.
3. Do NOT use the BACKLOG.md format (no date line, no `_from:_` tag, no `##` section with prose). Adapt entirely to however PLAN.md is structured.
