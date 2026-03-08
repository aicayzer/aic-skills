#!/bin/bash
# install.sh — symlink aic-skills into Claude Code command directories
#
# All skills are symlinked globally to ~/.claude/commands/ (single-file .md)
# or ~/.claude/skills/ (folder-based with SKILL.md).
#
# Vault skills are also symlinked to ~/aic-vault/.claude/commands/ for
# redundancy in vault sessions.
#
# Safe to run multiple times. Only manages symlinks for files from this repo.
# Does not touch existing files in the target directories.

set -euo pipefail

# Resolve the directory this script lives in
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GLOBAL_SRC="$SCRIPT_DIR/global"
VAULT_SRC="$SCRIPT_DIR/vault"
DEV_SRC="$SCRIPT_DIR/dev"

GLOBAL_DEST="$HOME/.claude/commands"
VAULT_DEST="$HOME/aic-vault/.claude/commands"
SKILLS_DEST="$HOME/.claude/skills"

# Create target directories if they don't exist
mkdir -p "$GLOBAL_DEST"
mkdir -p "$VAULT_DEST"
mkdir -p "$SKILLS_DEST"

echo "Installing skills from $SCRIPT_DIR"
echo ""

# Helper: symlink a single .md file to a destination directory
link_md() {
    local file="$1"
    local dest="$2"
    local name
    name="$(basename "$file")"
    ln -sf "$file" "$dest/$name"
    echo "  linked $name -> $dest/"
}

# Helper: symlink a folder-based skill to ~/.claude/skills/
link_folder_skill() {
    local dir="$1"
    local name
    name="$(basename "$dir")"
    ln -sfn "$dir" "$SKILLS_DEST/$name"
    echo "  linked $name/ -> $SKILLS_DEST/"
}

# Global skills — single-file .md, symlinked globally
echo "Global skills:"
for file in "$GLOBAL_SRC"/*.md; do
    [ -f "$file" ] || continue
    link_md "$file" "$GLOBAL_DEST"
done

echo ""

# Vault skills — single-file .md, symlinked globally AND to vault
echo "Vault skills:"
for file in "$VAULT_SRC"/*.md; do
    [ -f "$file" ] || continue
    link_md "$file" "$GLOBAL_DEST"
    link_md "$file" "$VAULT_DEST"
done

echo ""

# Dev skills — single-file .md go global, folder-based go to ~/.claude/skills/
echo "Dev skills:"
for item in "$DEV_SRC"/*; do
    [ -e "$item" ] || continue
    name="$(basename "$item")"

    if [ -d "$item" ] && [ -f "$item/SKILL.md" ]; then
        link_folder_skill "$item"
    elif [ -f "$item" ] && [[ "$name" == *.md ]]; then
        link_md "$item" "$GLOBAL_DEST"
    fi
done

echo ""
echo "Done. All skills installed."
