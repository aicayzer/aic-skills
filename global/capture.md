Route content to the right destination in ~/aic-vault/ based on context.

Read ~/aic-vault/Wiki/Workflows/Projects.md and ~/aic-vault/Wiki/CLAUDE.md to understand the vault structure and filing conventions.

## Input

$ARGUMENTS

## Instructions

1. **Decide where this belongs.** Apply these rules in order:
   - **Project context** — if the input relates to an active project (mentioned by name, or the current working context is a project), file it into that project's folder under `~/aic-vault/Projects/<project-folder>/`. Check existing project folders to find the right one.
   - **Freestanding reference material** — if it's reference material not tied to a project or a moment (e.g. "How email forwarding works", "Container runtime comparison"), file it in `~/aic-vault/Library/`. This is rare — most thoughts are logs.
   - **Unclear** — if you genuinely can't determine where it belongs, file it in `~/aic-vault/Inbox/` with `status: inbox`.

2. **Derive a filename.** Natural language with spaces, descriptive. The filename is the title — no H1 heading.

3. **Build frontmatter.** Set `type` appropriately:
   - `note` for substantive, authoritative content (analysis, research, records)
   - `quick-note` for freestanding reference material not anchored to a moment (rare — most thoughts are logs)
   - `artifact` for working documents within a project
   - Always include `seen: "no"`
   - Include `status: inbox` only if filing to Inbox
   - Include `tags` if relevant topics are apparent
   - Include `project` property (as an internal link) if filing into a project folder

4. **Write the body.** Clean up the input into well-structured content. Add internal links where appropriate.

5. **Create the file** at the determined location.

6. **Confirm** what was created, where it was filed, and why that destination was chosen.

## Rules

- UK English throughout
- No emojis
- No H1 heading
- The difference from /park: capture makes a routing decision, park always goes to Inbox
- If filing into a project folder, the content goes directly there — not into Inbox first
- When in doubt, Inbox is always safe
