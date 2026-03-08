Create a log file in ~/aic-vault/Calendar/Logs/.

Read ~/aic-vault/Wiki/Workflows/Logs.md for the full log conventions — naming, properties, body format, and linking expectations. Follow them exactly.

## Input

$ARGUMENTS

## Instructions

1. **Determine the timestamp.** Use the current date and time in `YYYY-MM-DD HHMM` format.

2. **Derive the filename.** Format: `YYYY-MM-DD HHMM description.md` where description is brief, lowercase, natural language — enough to identify the log at a glance. If a file already exists at that minute, append `-2` to the time (e.g. `1430-2`).

3. **Build frontmatter.** Always include `type: log` and `seen: "false"`. Only include other properties when they have values:
   - `tags` — topic tags relevant to the content
   - `source` — if this is a Claude Code session, set `source: claude-chat`
   - `project` — if the log relates to a project, set as an internal link (e.g. `"[[Project Name]]"`)
   - `location` — if a location is mentioned or contextually obvious
   - `session` — if running in a Claude Code session and the session path is available
   - `seen` — always `false` (the user hasn't read it yet)

4. **Write the body.** Use the input to write concise log content. Link to things the log is about — projects, tools, people, concepts. Do not backlink wiki pages. Internal links use `[[Note Name]]` syntax.

5. **Create the file** at `~/aic-vault/Calendar/Logs/YYYY-MM-DD HHMM description.md`.

6. **Confirm** what was created, including the full file path.

## Rules

- UK English throughout
- No H1 heading — the filename is the title
- No emojis
- If the input mentions a project, always set the `project` property AND link to it in the body
- A log can be substantive — length and analytical depth don't disqualify it. It only stops being a log when the content is a freestanding idea no longer anchored to a moment
- Link to things the log is **about** (projects, tools, people, concepts) — not to wiki pages or other reference documentation
