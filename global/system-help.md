---
description: "Quick reference for the system and available skills"
---

The user wants a quick reference for the system and available skills. Read this file fully, then respond with the content below — formatted for the terminal, not as a code block. Adjust phrasing naturally but preserve all substance.


## How This System Works

You don't need to memorise commands. Just talk naturally — describe what you want to do, and Claude will handle the routing. Skills are shortcuts, not gatekeepers.

- **"I had an idea about X"** — Claude will figure out whether it's a log, a project note, or something to capture.
- **"Can we work on project Y"** — Claude will open the project context and pick up where you left off.
- **"I need to capture this"** — Claude will route it to the right place.

If in doubt, just say what's on your mind. That always works.


## Skills

### Capture and Record

- **/log** — Create a timestamped log entry in Calendar/Logs/. For things that happened, thoughts you had, decisions made.
- **/capture** — Route content to the right place: project folder, Library, or Inbox. When routing is unclear, Inbox is the zero-friction default.

### Projects

- **/project** — Scaffold a new project folder with a hashed project note.
- **/status** — Change a project's status (draft, active, later, done, void).
- **/review** — Surface items needing attention: stale projects, inbox items, things to tidy.
- **/audit** — Check vault conventions — naming, properties, structure. Finds divergences.

### Wiki and System

- **/system-updates** — Orchestrate wiki updates. Use when a standard, workflow, or guide needs changing.

### Reference

These load context for specific work. You rarely invoke them directly — Claude pulls them in when needed.

- **/obsidian-cli** — Obsidian CLI tool reference
- **/obsidian-markdown** — Obsidian-flavoured markdown conventions
- **/obsidian-bases** — Obsidian Bases (database views) reference
- **/defuddle** — Web content extraction reference
- **/json-canvas** — JSON Canvas format reference

### Development

- **/obsidian-plugin-dev** — Obsidian plugin development conventions and patterns
- **/raycast-extension-dev** — Raycast extension development conventions and patterns


## What Do I Do When...

- **I had a thought worth recording** — Just say it. Claude will create a log. Or use `/log` directly.
- **I want to capture something but don't know where it goes** — `/capture` puts it in Inbox by default. No decisions needed.
- **I want to start a new body of work** — Say so, or use `/project`. Claude will ask for the details.
- **I want to work on an existing project** — Just say "let's work on [project name]".
- **I want to change a project's status** — `/status` or just say "mark project X as done".
- **I want to update a wiki page or standard** — `/system-updates` or describe what needs changing.
- **I want to check if the vault is tidy** — `/audit` for convention issues, `/review` for things needing attention.
- **I'm building an Obsidian plugin or Raycast extension** — Start in the repo. Dev skills load when relevant.
- **I have something but don't know what to do with it** — `/capture`. It figures out where things belong and tells you why.
- **I don't know what skill to use** — Don't worry about it. Just describe what you want.


## Content Types at a Glance

| Type | What it is | Where it lives |
|---|---|---|
| **log** | Timestamped record — thought, event, decision | Calendar/Logs/ |
| **artifact** | Working material for a project — Claude outputs, analysis, prompts | Project folders |
| **note** | Precious, authored content that survives cleanup | Library/ or project folders |
| **project** | The project note hub for a body of work | Projects/slug-HASH/ |
| **wiki** | Source-of-truth documentation | Wiki/ |

Note is earned, not default. Most things are logs or artifacts.


## Where Does Content Go?

- **Working on a project?** Working material goes in the project folder as an artifact.
- **Had a thought?** It's a log. Most things are logs.
- **Something polished, authored, and worth keeping long-term?** A note in Library/.
- **Don't know?** Inbox. `/capture` it.
- **Starting new work?** `/project` or just say so.
