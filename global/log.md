Create a log file in ~/aic-vault/Calendar/Logs/.

## Input

$ARGUMENTS

## Instructions

1. **Determine the timestamp.** Use the current date and time in `YYYY-MM-DD HHMM` format.

2. **Derive the filename.** Format: `YYYY-MM-DD HHMM description.md` where description is brief, lowercase, natural language — enough to identify the log at a glance. If a file already exists at that minute with the same description, append `-2` to the time (e.g. `1430-2`).

3. **Build frontmatter.** Always include `type: log` and `aliases` with a randomly generated 5-character uppercase alphanumeric hash (A-Z and 0-9). Only include other properties when they have values:
   - `tags` — topic tags relevant to the content
   - `source` — free text describing the origin (e.g. `claude-chat`, `meeting`, `reading`, `voice-note`)
   - `project` — if the log relates to a project, set as an internal link (e.g. `"[[Acme App R7K2M]]"`)
   - `location` — if a location is mentioned or contextually obvious

4. **Write the body.** Use the input to write concise log content. Link to things the log is about — projects, tools, people, concepts. Do not backlink wiki pages. Internal links use `[[Note Name]]` syntax.

5. **Detect action items.** If the input expresses intent to do something ("I want to", "need to", "should", "plan to", "going to", or similar), include `- [/]` action items in the body. These are genuine commitments — greppable across the vault and surfaced by `/review`. Only add `- [/]` for things the user intends to act on, not for ideas or observations. Multiple action items per log are fine.

6. **Check for related logs.** Search `~/aic-vault/Calendar/Logs/` for recent logs on the same topic or project. If relevant recent logs exist, add internal links to them in the body (e.g. "Continues from [[2026-03-08 1322 previous log A1B2C]]"). This builds a chronological thread without requiring the reader to search.

7. **Create the file** at `~/aic-vault/Calendar/Logs/YYYY-MM-DD HHMM description.md`.

8. **Confirm** what was created, including the full file path.

## Rules

- UK English throughout
- No H1 heading — the filename is the title
- No emojis
- If the input mentions a project, always set the `project` property AND link to it in the body
- A log can be substantive — length and analytical depth don't disqualify it. It only stops being a log when the content is a freestanding idea no longer anchored to a moment
- Link to things the log is **about** (projects, tools, people, concepts) — not to wiki pages or other reference documentation
