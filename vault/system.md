Orchestrate a wiki update following the system's change tracking conventions.

Read ~/aic-vault/Wiki/CLAUDE.md for content ownership rules, updating principles, and the one-fact-one-home model. Follow them exactly.

## Input

$ARGUMENTS

## Instructions

1. **Understand what changed.** Parse the input to identify what was changed, which wiki page(s) are affected, and whether this relates to a project.

2. **Read the relevant wiki page(s).** Before making any edits, read the current state of each affected page. Check ~/aic-vault/Wiki/CLAUDE.md's content ownership table to confirm you're updating the canonical owner.

3. **Make the updates.** Edit the wiki page(s) following these principles:
   - **One fact, one home.** Update the canonical location. Other pages that reference this information should link, not duplicate.
   - **Durable, not current.** Write conventions and patterns, not snapshots. Avoid "currently" or counts that go stale.
   - **Wiki documents conventions; repos document operations.** Keep operational detail in repos, not the wiki.
   - Follow the formatting conventions in ~/aic-vault/Wiki/Standards/Writing.md.

4. **Create a log.** In `~/aic-vault/Calendar/Logs/`, record what was changed:
   - Filename: `YYYY-MM-DD HHMM description of wiki change.md`
   - Frontmatter: `type: log`, `source: claude-chat`, relevant `tags`, and `project` if applicable
   - Body: what changed, which pages were updated, and why. Internal links to the wiki pages and project if relevant.

5. **Update the project note** if this change is part of an active project. Add a brief mention in the project note's current state or key decisions section, linking to the log.

6. **Confirm** what was updated — wiki pages modified, log created, and project note updated (if applicable).

## Rules

- UK English throughout
- No emojis
- Never restate information that belongs to another document — link to it
- Check content ownership before updating — don't put information in the wrong canonical home
- Always create a log for wiki changes
