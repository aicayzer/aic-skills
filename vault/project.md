Scaffold a new project in ~/aic-vault/Projects/.

Read ~/aic-vault/Wiki/Workflows/Projects.md for the full project conventions — numbering, folder structure, `_index.md` format, and naming rules. Follow them exactly.

## Input

$ARGUMENTS

Format: `slug Human Readable Name and optional description`

The first word (kebab-case) is the folder slug. Everything after it is the human-readable name and optional description.

## Instructions

1. **Check for existing projects.** List the folders in `~/aic-vault/Projects/` and check whether an existing project already covers this work. If one does, suggest filing into it instead and stop — don't create a duplicate.

2. **Detect the next available number.** Scan existing project folders for two-digit prefixes (`01-`, `02-`, etc.) and pick the next sequential number. Gaps are normal — use the next number after the highest existing one.

3. **Create the project folder.** Format: `~/aic-vault/Projects/NN-slug/` where NN is the zero-padded two-digit number and slug is kebab-case.

4. **Create `_index.md`** with this structure:
   ```yaml
   ---
   type: project
   status: active
   tags: []
   aliases:
     - Human Readable Name
   seen: false
   ---
   ```
   Follow with an `## Overview` section containing the description from the input. Add any relevant internal links.

5. **Confirm what was created** — full path to the folder and `_index.md`, the project number, the alias, and the status.

## Rules

- UK English throughout
- No emojis
- No H1 heading — filename is the title (and `_index.md` uses the alias as its display name)
- Project folders use kebab-case — the only place in the vault where kebab-case is used
- Two-digit zero-padded prefix for the project number
- Subfolders within projects use two-digit zero-padded numbering (`01-`, `02-`, `03-`)
- Don't create subfolders unless the user specifies them — start with just `_index.md`
- Numbers never get reused or reshuffled
