Run a convention audit across the vault and system.

Read ~/aic-vault/CLAUDE.md for the full list of conventions and common mistakes. That document and the standards it links to are the source of truth for what's correct.

## Input

$ARGUMENTS

Optional scope: `projects`, `wiki`, `naming`, `tags`, `inbox`, `structure`, or blank for a full audit.

## Instructions

1. **Determine scope.** If a scope is provided, focus on that area. If blank, run all checks below.

2. **Run checks by area:**

   **Projects** — scan `~/aic-vault/Projects/` for:
   - Every project folder has a project note (a `.md` file with `type: project` in frontmatter)
   - Every project note has `type: project` and a `status` value
   - Folder names use `slug-HASH` format (kebab-case slug, hyphen, 5-char uppercase alphanumeric hash)
   - Project note filenames match the pattern `Name HASH.md` where the hash matches the folder's hash
   - Subfolder numbering uses two-digit zero-padded prefixes (01-, 02-, 03-)

   **Wiki** — scan `~/aic-vault/Wiki/` for:
   - Every wiki page has `type: wiki` in frontmatter
   - Wiki pages do not have a `status` property
   - Pages are in the correct section (Standards/, Guides/) per ~/aic-vault/CLAUDE.md
   - No H1 headings (filename is the title)
   - Internal links use `[[Note Name]]` syntax, not raw paths

   **Naming** — check:
   - Vault note filenames use natural language with spaces (not kebab-case, except project folders)
   - No H1 headings duplicating the filename
   - Project folders are kebab-case with hash suffix

   **Tags** — check:
   - Tags in frontmatter are plain kebab-case (no prefixes, no underscores)
   - No status values appearing in the `tags` field
   - No `type` values appearing in the `tags` field

   **Inbox** — scan `~/aic-vault/Inbox/` for:
   - Items that clearly belong to an active project (should be in the project folder)
   - Items with no frontmatter
   - Items that have been sitting untriaged (check modification dates)

   **Structure** — verify the top-level vault structure:
   - Expected folders exist: Inbox, Projects, Library, Calendar, Wiki, Archive, Meta
   - No unexpected top-level folders
   - Meta has Templates/, Attachments/ subfolders

3. **Report findings.** Group by area. For each issue found:
   - State what's wrong
   - State what the convention says it should be
   - Give the file path

4. **Summarise.** At the end, give a count: how many issues found per area, and an overall health assessment.

## Rules

- UK English throughout
- No emojis
- Read-only — don't modify anything, just report findings
- Reference the specific convention document for each issue
- If everything passes in an area, say so explicitly — don't skip clean areas
- Be specific. "3 project folders missing project notes" is useful. "Some things might be wrong" is not.
