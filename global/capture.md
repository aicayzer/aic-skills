Route content to the right destination in ~/aic-vault/ based on context.

This skill replaces the former /park skill. When routing is unclear, Inbox is always the safe choice — zero friction, no judgement calls.

## Input

$ARGUMENTS

## Instructions

1. **Decide what this is and where it belongs.** Apply these rules in order:
   - **A thought, event, decision, or moment** — most things are logs. Create a log in `~/aic-vault/Calendar/Logs/` using the `/log` conventions (timestamped filename, `type: log`). If the input expresses intent to do something, include `- [/]` action items in the body.
   - **Project working material** — if the input relates to an active project (mentioned by name, or the current working context is a project), file it into that project's folder under `~/aic-vault/Projects/<project-folder>/`. Check existing project folders to find the right one.
   - **Something that sounds like a new project** — if the input describes a body of work with a defined outcome, suggest using `/project` to scaffold it. Don't create the project yourself — flag it and let the user decide.
   - **Freestanding reference material** — if it's polished, authored reference material not tied to a project or a moment, file it in `~/aic-vault/Library/`. This is rare.
   - **Unclear** — if you genuinely can't determine where it belongs, file it in `~/aic-vault/Inbox/`. This is the zero-friction default.

2. **Derive a filename.** Natural language with spaces, descriptive. The filename is the title — no H1 heading.

3. **Build frontmatter.** Determine the type:
   - `type: artifact` — working material for a project (Claude outputs, analysis docs, saved prompts). The default for project-context captures.
   - `type: note` — polished, authored content that's freestanding and worth keeping long-term. The default for Library captures.
   Include:
   - `aliases` with a randomly generated 5-character uppercase alphanumeric hash (e.g. `aliases: [A1B2C]`)
   - `status: draft` if the content is unfinished; omit status for inbox items awaiting triage
   - `tags` if relevant topics are apparent
   - `project` property (as an internal link, e.g. `"[[Acme App R7K2M]]"`) if filing into a project folder

4. **Write the body.** Clean up the input into well-structured content. Add internal links where appropriate.

5. **Create the file** at the determined location.

6. **Confirm and explain.** State what was created, where it was filed, and — importantly — *why* that destination was chosen. Walk through the reasoning: which routing rule matched, what made it a log vs an artifact vs a note, and why it didn't go somewhere else. This helps the user learn the system's conventions through use.

## Rules

- UK English throughout
- No emojis
- No H1 heading
- If filing into a project folder, the content goes directly there — not into Inbox first
- When in doubt, Inbox is always safe
