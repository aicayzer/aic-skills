## Communication

- **UK English throughout.** Colour, organisation, behaviour. No exceptions.
- **No emojis.** Ever.
- **Be direct.** No preamble, no hedging, no padding. Get to the point.
- **Don't parrot.** Don't repeat back what was said. Acknowledge, build on it, move forward.
- **Push back when something is flawed.** Honest feedback over polite agreement. If an idea is over-engineered, say so.
- **No timelines.** Don't estimate how long things will take. Focus on what needs doing.
- **Bullet points for scannability.** Bold leads on bullets. Paragraphs for narrative. See the Writing standard in the vault wiki for full formatting conventions.


## File Paths

When creating or moving files, always include the full absolute path in your response so it's clickable. Format: `/Users/aicayzer/path/to/file.md`

If a path contains spaces, wrap it in backticks so the terminal treats it as a single clickable link: `` `/Users/aicayzer/aic-vault/Projects/10-example/Some Note.md` ``


## The System

The personal digital ecosystem is called **aic-system**. Key locations:

- **`~/aic-vault/`** — Obsidian vault. Notes, projects, wiki, logs. Agent instructions at `~/aic-vault/Wiki/CLAUDE.md`.
- **`~/aic-local/Dev/`** — development repos. Organised into subdirectories: Apps/, Extensions/, Infrastructure/, Scratch/, Archive/.
- **`~/Services/`** — infrastructure repos: `aic-shell` (shell config), `aic-skills` (Claude Code skills), MCPs, and others.
- **`~/aic-cloud/`** — active file system (iCloud). Areas, Resources, Stash, Archive.
- **`aic-atlas`** — Mac Mini M4, always-on server. Runs MCP services, obsidian-headless, media server.
- **`aic-mbp`** — MacBook Pro, daily driver.

Infrastructure names always in backticks: `aic-atlas`, `aic-cloud`, `aic-vault`, `aic-mbp`.

### Vault

When working in `~/aic-vault/`, read `~/aic-vault/Wiki/CLAUDE.md` for vault-specific conventions — note types, properties, wiki structure, naming, content ownership. That document is the authority for vault work.

Key vault structure:
- `Projects/` — numbered project folders (two-digit prefix, kebab-case). Each has `_project.md` as the project note. (`_project.md` is vault-only; Dev repos use `README.md`.)
- `Calendar/Logs/` — individual log files (`YYYY-MM-DD HHMM description.md`).
- `Library/` — standalone notes not tied to a project.
- `Inbox/` — unprocessed items.
- `Wiki/` — system documentation (Standards/, Workflows/, Guides/).
- `System/Templates/` — note templates.

### Development

- **TypeScript/Node.js** for web projects, Raycast extensions, service tooling.
- **Python (via uv)** for scripting, automation, data work.
- **Swift via Xcode** for iOS/macOS.
- **Git always.** Conventional Commits format. Main branch is `main`. See `~/aic-vault/Wiki/Standards/Development.md` for full conventions.
- **Prettier** for JS/TS formatting (single quotes). **Ruff** for Python. **ESLint** for linting.


## Working Preferences

- **Simplicity over engineering.** Don't add complexity. If a solution needs a new convention or abstraction, that's a red flag.
- **Don't invent conventions.** If the standards don't cover something, say so. Suggest what seems right, flag it as a suggestion.
- **Flag divergences.** If something doesn't match documented conventions, call it out. Don't silently work around it.
- **Claude Code sessions typically start in `~/aic-vault/`.** But may also start in dev repos. Use absolute paths for cross-directory work.
- **No git on `aic-mbp` for the vault.** `aic-atlas` handles vault backup via obsidian-headless and scheduled git. Obsidian Sync handles sync between devices.


## Skills

Skills are slash commands managed in `~/Services/aic-skills/` (also on GitHub at `aicayzer/aic-skills`), symlinked via `install.sh`. Three categories:

- **Global skills** (available everywhere): `/log`, `/park`, `/capture`
- **Vault skills** (vault sessions only): `/project`, `/status`, `/system`, `/review`, `/audit`, `/obsidian-cli`, `/obsidian-markdown`, `/obsidian-bases`, `/defuddle`, `/json-canvas`
- **Dev skills** (global, for extension development): `/obsidian-plugin-dev`, `/raycast-extension-dev`

**Always check available skills before performing vault workflows.** If a skill exists for the requested task, use it. Skills encode the conventions and produce consistent results. The wiki Workflows/ section ([[Projects]], [[Logs]]) documents the conceptual framework; skills are the procedural layer that implements it.


## Vault Conventions

- **Deletion** means moving to Obsidian's `.trash/` folder, not hard-deleting files.
- **`seen` property.** Set `seen: "false"` (string, not boolean) on every note, log, or document you create. Set `seen: "true"` when the user has clearly engaged with the content.
- **Project aliases use `Name (#NN)` format.** Always include the project number in the alias. Link as `[[MCP Cleanup (#05)]]`.
- **File linking.** Files inside the vault use `[[internal links]]`. Files outside the vault use markdown links with `file://` URLs: `[Display Name](file:///absolute/path)`. Web URLs use standard markdown links: `[Display Name](https://...)`. Never use backtick-wrapped paths as pseudo-links — backticks are for inline code, not navigation.
- **Don't over-preserve.** Once a working document's content has been captured in its permanent home, delete the working document. Don't keep to-do lists after the to-dos are done.
- **Don't backlink wiki pages from logs.** Logs link to things they're about (projects, tools, people), not to reference documentation.
