Update a project's status and log the change.

## Input

$ARGUMENTS

Format: `project-slug new-status [optional reason]`

Examples:

- `acme-app done`
- `stream-app later Parking this until the vault setup is solid`

## Instructions

1. **Find the project.** Look in `~/aic-vault/Projects/` for a folder matching the slug (the part before the hash suffix, e.g. `acme-app-R7K2M` matches `acme-app`). If no match is found, list available projects and ask the user to clarify.

2. **Validate the status.** Must be one of: `draft`, `active`, `later`, `done`, `void`. If the input contains an invalid status, reject it and list the valid options.

3. **Update the project note.** Find the project note in the folder (the `.md` file with `type: project` in its frontmatter). Change the `status` property to the new value. Do not modify anything else.

4. **Create a log file.** In `~/aic-vault/Calendar/Logs/`, create a log recording the status change:
   - Filename: `YYYY-MM-DD HHMM project-name status changed to new-status.md`
   - Frontmatter: `type: log`, `source: claude-chat`, `project: "[[Project Name HASH]]"`, relevant tags
   - Body: brief note of the change, the reason if provided, and an internal link to the project

5. **Confirm** what was changed — the project path, old status, new status, and the log file created.

## Rules

- UK English throughout
- No emojis
- Valid statuses: draft, active, later, done, void
- Always create a log when changing status — status changes are significant events
