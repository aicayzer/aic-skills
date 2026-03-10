Surface vault items that need attention.

## Input

$ARGUMENTS

Optional filter: `inbox`, `later`, `projects`, `actions`, or blank for all.

## Instructions

1. **Determine scope.** If a filter is provided, focus on that category. If no filter, cover all categories below.

2. **Gather items by category:**

   **Inbox items** — scan `~/aic-vault/Inbox/` for files. Read their frontmatter to get type, status, and tags. These are untriaged items waiting for a routing decision.

   **Later items** — search across `~/aic-vault/Projects/` for project notes (files with `type: project` in frontmatter) where `status: later`. These are deferred projects worth reconsidering.

   **Active projects** — search `~/aic-vault/Projects/` for project notes (files with `type: project` in frontmatter) where `status: active`. Show their current state briefly.

   **Open actions** — grep across `~/aic-vault/` for `- [/]` (action items). Show each action's text, the source file, and how old the file is. Group by: project-affiliated (source file has a `project` property) vs freestanding. Flag any actions older than 30 days as stale.

3. **Present the triage list.** For each category with items, show:
   - The note title (filename)
   - The file path
   - A one-line summary from the content or frontmatter
   - How long it's been there (based on file creation or modification date)

4. **Suggest actions** where obvious — e.g. an inbox item that clearly belongs to an active project, or a "later" project that's been deferred for a long time.

## Rules

- UK English throughout
- No emojis
- Read-only — don't modify anything, just surface information
- Keep summaries concise — one line per item
- Sort by age within each category (oldest first)
