Create a note in ~/aic-vault/Inbox/ with minimal friction.

## Input

$ARGUMENTS

## Instructions

1. **Derive a filename.** Natural language with spaces, descriptive enough to identify the note later. No date prefix — just a clear title. The filename is the title; no H1 heading in the body.

2. **Build frontmatter:**
   ```yaml
   type: note
   status: inbox
   tags:
     - tag-one
     - tag-two
   ```
   - Always set `type: note`, `status: inbox`, and `seen: false`
   - Extract tags from any hashtags in the input (e.g. `#ai` becomes `ai`). If no hashtags, infer a few relevant topic tags. Zero tags is also fine.

3. **Write the body.** Use the input as-is or lightly clean it up. Add internal links (`[[Note Name]]`) where entities are mentioned that might have vault notes.

4. **Create the file** at `~/aic-vault/Inbox/<filename>.md`.

5. **Confirm** what was created with the full path.

## Rules

- Always goes to Inbox — no routing decisions, no judgement calls
- UK English throughout
- No emojis
- No H1 heading
- Keep it simple — this is zero-friction capture
