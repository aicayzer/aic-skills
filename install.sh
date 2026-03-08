#!/bin/bash
# install.sh — symlink aic-skills into Claude Code command directories
#
# Safe to run multiple times. Only manages symlinks for files from this repo.
# Does not touch existing files in the target directories.

set -euo pipefail

# Resolve the directory this script lives in
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GLOBAL_SRC="$SCRIPT_DIR/global"
VAULT_SRC="$SCRIPT_DIR/vault"

GLOBAL_DEST="$HOME/.claude/commands"
VAULT_DEST="$HOME/aic-vault/.claude/commands"

# Create target directories if they don't exist
mkdir -p "$GLOBAL_DEST"
mkdir -p "$VAULT_DEST"

echo "Installing skills from $SCRIPT_DIR"
echo ""

# Link global skills
echo "Global skills -> $GLOBAL_DEST"
for file in "$GLOBAL_SRC"/*.md; do
    name="$(basename "$file")"
    ln -sf "$file" "$GLOBAL_DEST/$name"
    echo "  linked $name"
done

echo ""

# Link vault skills
echo "Vault skills -> $VAULT_DEST"
for file in "$VAULT_SRC"/*.md; do
    name="$(basename "$file")"
    ln -sf "$file" "$VAULT_DEST/$name"
    echo "  linked $name"
done

echo ""
echo "Done. All skills installed."
