Scaffold a new project in ~/aic-vault/Projects/.

## Input

$ARGUMENTS

Format: `slug Human Readable Name and optional description`

The first word (kebab-case) is the folder slug. Everything after it is the human-readable name and optional description.

## Instructions

1. **Check for existing projects.** List the folders in `~/aic-vault/Projects/` and check whether an existing project already covers this work — including as a new phase, subfolder, or sub-project of something that already exists. If so, suggest filing into it instead and stop — don't create a duplicate or a sibling project for what's really the next step in an existing one.

2. **Generate a hash.** Create a random 5-character uppercase alphanumeric string (characters A-Z and 0-9). This hash uniquely identifies the project and is used in both the folder name and the project note filename.

3. **Create the project folder.** Format: `~/aic-vault/Projects/slug-HASH/` where slug is kebab-case and HASH is the generated hash (e.g. `acme-app-R7K2M/`).

4. **Create the project note** named `Name HASH.md` (e.g. `Acme App R7K2M.md`) with this structure:

   ```yaml
   ---
   type: project
   status: active
   aliases: [HASH]
   ---
   ```

   Replace `HASH` with the generated hash (e.g. `aliases: [R7K2M]`).

   Follow with an `## Overview` section containing the description from the input. Add any relevant internal links. If the project has a repo or external URL, link it using `file://` markdown links (e.g. `[my-app](file:///Users/aicayzer/aic-local/Dev/Apps/my-app/)`) or standard URL links (e.g. `[GitHub](https://...)`). Never use backtick-wrapped paths — backticks are for inline code, not navigation.

5. **Confirm what was created** — full path to the folder and project note, the hash, and the status.

## Rules

- UK English throughout
- No emojis
- No H1 heading — filename is the title
- Project folders use kebab-case with a hash suffix
- Subfolders within projects use two-digit zero-padded numbering (`01-`, `02-`, `03-`)
- Don't create subfolders unless the user specifies them — start with just the project note
- Hashes are never reused — always generate a fresh one
