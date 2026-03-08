This is `aic-skills` — a repo of Claude Code slash commands (skills) that encode repeatable vault and system workflows.

## How Skills Work

A skill is a markdown file in `.claude/commands/`. When a user types `/skill-name`, Claude Code reads the file and uses it as a prompt. The `$ARGUMENTS` placeholder captures whatever the user types after the command.

All skills are symlinked globally to `~/.claude/commands/` so they are available in every Claude Code session regardless of working directory. Vault skills are also symlinked to `~/aic-vault/.claude/commands/` for redundancy in vault sessions.

The repo uses `global/`, `vault/`, and `dev/` folders for organisational purposes only — the folder a skill lives in has no effect on availability.

Single-file skills (`.md`) are symlinked to `~/.claude/commands/`. Folder-based skills (containing `SKILL.md` plus supporting files) are symlinked to `~/.claude/skills/`.

Run `./install.sh` to create the symlinks.

## File Structure

```
global/          # General-purpose skills
vault/           # Vault and Obsidian workflow skills
dev/             # Development-context skills
install.sh       # Symlinks all skills globally
```

## Rules for Writing Skills

- **Reference the wiki, don't restate.** Skills point to `~/aic-vault/Wiki/` pages for conventions. If the convention changes, the wiki changes and the skill inherits it.
- **One workflow per skill.** Each skill does one thing. If it needs more than three conditional branches, it's doing too much.
- **Self-contained.** Skills don't call other skills.
- **UK English throughout.** No emojis. See `~/aic-vault/Wiki/Standards/Writing.md`.
- **Use `$ARGUMENTS`** as the placeholder for user input.
- **Absolute paths.** Use `~/aic-vault/...` so skills work regardless of working directory.
- **Test manually.** Use each skill in real work before considering it done.
