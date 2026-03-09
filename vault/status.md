Update a project's status and log the change.

Read ~/aic-vault/Wiki/Workflows/Projects.md for project conventions and ~/aic-vault/Wiki/Workflows/Logs.md for log conventions.

## Input

$ARGUMENTS

Format: `project-slug new-status [optional reason]`

Examples:
- `mcp-cleanup done`
- `stream-app later Parking this until the vault setup is solid`

## Instructions

1. **Find the project.** Look in `~/aic-vault/Projects/` for a folder matching the slug (the part after the numeric prefix, e.g. `05-mcp-cleanup` matches `mcp-cleanup`). If no match is found, list available projects and ask the user to clarify.

2. **Validate the status.** Must be one of: `active`, `later`, `backlog`, `done`, `cancelled`, `archive`. If the input contains an invalid status, reject it and list the valid options.

3. **Update `_project.md`.** Change the `status` property in the frontmatter to the new value. Do not modify anything else.

4. **Create a log file.** In `~/aic-vault/Calendar/Logs/`, create a log recording the status change:
   - Filename: `YYYY-MM-DD HHMM project-name status changed to new-status.md`
   - Frontmatter: `type: log`, `source: claude-chat`, `project: "[[Project Name]]"`, relevant tags, and `seen: "no"`
   - Body: brief note of the change, the reason if provided, and an internal link to the project

5. **Confirm** what was changed — the project path, old status, new status, and the log file created.

## Rules

- UK English throughout
- No emojis
- Valid statuses: active, later, backlog, done, cancelled, archive
- Always create a log when changing status — status changes are significant events
