---
description: "Quick reference for the system and available skills"
---

The user wants a quick reference for the system. Read this file fully, then respond with the content below -- formatted for the terminal, not as a code block. Adjust phrasing naturally but preserve all substance.


## How This System Works

You don't need to memorise commands. Just talk naturally -- describe what you want to do, and Claude will handle the routing. Skills are shortcuts, not gatekeepers.

- **"I had an idea about X"** -- Claude will figure out whether it's a log, a project note, or something to park in Inbox.
- **"Can we work on project Y"** -- Claude will open the project context and pick up where you left off.
- **"I need to capture this"** -- Claude will route it to the right place.

If in doubt, just say what's on your mind. That always works.


## Skills

### Capture and Record

- **/log** -- Create a timestamped log entry in Calendar/Logs/. For things that happened, thoughts you had, decisions made.
- **/park** -- Drop something into Inbox/ with zero friction. Use when you don't know where it belongs yet.
- **/capture** -- Route content to the right place: project folder, Library, or Inbox.

### Projects

- **/project** -- Scaffold a new numbered project folder with `_project.md`.
- **/status** -- Change a project's status (active, later, backlog, done, cancelled, archive).
- **/review** -- Surface items needing attention: stale projects, unseen notes, things to tidy.
- **/audit** -- Check vault conventions -- naming, properties, structure. Finds divergences.

### Wiki and System

- **/system** -- Orchestrate wiki updates. Use when a standard, workflow, or guide needs changing.

### Reference

These load context for specific work. You rarely invoke them directly -- Claude pulls them in when needed.

- **/obsidian-cli** -- Obsidian CLI tool reference
- **/obsidian-markdown** -- Obsidian-flavoured markdown conventions
- **/obsidian-bases** -- Obsidian Bases (database views) reference
- **/defuddle** -- Web content extraction reference
- **/json-canvas** -- JSON Canvas format reference

### Development

- **/obsidian-plugin-dev** -- Obsidian plugin development conventions and patterns
- **/raycast-extension-dev** -- Raycast extension development conventions and patterns


## What Do I Do When...

- **I had a thought worth recording** -- Just say it. Claude will create a log. Or use `/log` directly.
- **I want to capture something but don't know where it goes** -- `/park` puts it in Inbox. No decisions needed.
- **I want to start a new body of work** -- Say so, or use `/project`. Claude will ask for the details.
- **I want to work on an existing project** -- Just say "let's work on [project name]".
- **I want to change a project's status** -- `/status` or just say "mark project X as done".
- **I want to update a wiki page or standard** -- `/system` or describe what needs changing.
- **I want to check if the vault is tidy** -- `/audit` for convention issues, `/review` for things needing attention.
- **I'm building an Obsidian plugin or Raycast extension** -- Start in the repo. Dev skills load when relevant.
- **I don't know what skill to use** -- Don't worry about it. Just describe what you want.


## Content Types at a Glance

| Type | What it is | Where it lives |
|---|---|---|
| **log** | Timestamped record -- thought, event, decision | Calendar/Logs/ |
| **quick-note** | Freestanding reference thought (rare) | Library/ |
| **note** | Substantive, authoritative document | Library/ or project folder |
| **artifact** | Working document -- proposal, analysis, draft | Project folder |
| **project** | The `_project.md` hub for a body of work | Projects/NN-name/ |
| **wiki** | Source-of-truth documentation | Wiki/ |
| **prompt** | Agent instructions | Project folder |


## Where Does Content Go?

- **Working on a project?** Content goes in the project folder.
- **Had a thought?** It's a log. Most things are logs.
- **Something freestanding and reference-worthy?** Library quick-note -- but this is rare.
- **Don't know?** Inbox. `/park` it.
- **Starting new work?** `/project` or just say so.
