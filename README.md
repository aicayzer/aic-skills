# aic-skills

Claude Code slash commands that encode repeatable workflows for the aic-vault and broader aic-system. Skills make conventions executable — type `/log` and the right thing happens in the right place with the right format.

## Installation

```bash
cd ~/Services/aic-skills
chmod +x install.sh
./install.sh
```

The install script symlinks skills into `~/.claude/commands/` (global) and `~/aic-vault/.claude/commands/` (vault). It's idempotent and won't touch existing files that aren't managed by this repo.

## Skills

### Global (available everywhere)

- **`/log`** — create a timestamped log file in Calendar/Logs/
- **`/park`** — send something to Inbox with zero friction
- **`/capture`** — route content to the right destination based on context

### Vault (available in vault sessions)

- **`/project`** — scaffold a new numbered project in Projects/
- **`/status`** — update a project's status and log the change
- **`/system`** — orchestrate wiki updates with change tracking
- **`/review`** — surface items needing attention across the vault
- **`/audit`** — run a convention audit across the vault and system

## Adding a New Skill

1. Create a markdown file in `global/` or `vault/` depending on scope.
2. Use `$ARGUMENTS` as the placeholder for user input.
3. Reference wiki pages for conventions — don't restate them inline.
4. Keep the skill focused on one workflow.
5. Run `./install.sh` to symlink the new skill.
6. Test it manually in a real session before committing.

See `CLAUDE.md` in this repo for the full skill-writing rules.
