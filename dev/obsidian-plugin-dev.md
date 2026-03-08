---
name: obsidian-plugin-dev
description: Guide for developing Obsidian plugins that pass community review. ONLY trigger when the user explicitly asks to create, build, develop, or work on an Obsidian plugin — e.g. "create a new Obsidian plugin", "work on my Obsidian plugin", "fix my plugin for the review bot", "submit my plugin to community plugins". Also trigger when the user explicitly mentions eslint-plugin-obsidianmd, the Obsidian review bot, or community plugin submission. Do NOT trigger for general Obsidian vault work, writing notes, CSS snippets, themes, Dataview queries, Templater templates, or managing/syncing vaults.
---

# Obsidian Plugin Development

<!-- Rule documentation adapted from gapmiss/obsidian-plugin-skill (MIT License).
     Patterns refined through hands-on plugin development. -->

Obsidian plugins are TypeScript projects bundled with esbuild into a single `main.js`. Every plugin extends the `Plugin` class and ships three files: `main.js`, `manifest.json`, and optionally `styles.css`. Community plugins are reviewed by an automated bot that enforces naming, code quality, and accessibility standards.

Plugins are always built for public release — code should be well-structured, clearly commented, and ready for others to read. This skill covers the full lifecycle: scaffolding, coding, testing, and submitting.

## 1. Scaffolding a New Plugin

Clone the official template (don't fork — you want a clean history):

```bash
npx degit obsidianmd/obsidian-sample-plugin my-plugin-name
cd my-plugin-name
npm install
```

Then customise:
1. Rename all sample classes — `MyPlugin`, `SampleSettingTab`, `SampleModal` must go
2. Edit `manifest.json` — see naming rules in section 2
3. Update `LICENSE` — change "Dynalist Inc." to your name, set the current year
4. Rewrite `README.md` — the template README describes the template, not your plugin
5. Add a deploy script for local testing (copy built files to your vault's plugin folder)

### What the template provides

| Included | Must be added |
|----------|---------------|
| esbuild config (dev + prod) | Real plugin logic |
| ESLint v9 flat config with obsidianmd plugin | Release CI workflow (GitHub Actions) |
| TypeScript strict config | Real styles in `styles.css` |
| version-bump.mjs + .npmrc (no `v` prefix) | Tests (if desired) |
| Settings pattern (load/save/tab) | Hot-reload `.hotreload` file (optional) |
| 3 example commands (callback types) | |

### Required files for submission

| File | Purpose |
|------|---------|
| `manifest.json` | Plugin metadata — ID, name, version, minAppVersion |
| `main.js` | Compiled plugin (gitignored, built at release time) |
| `styles.css` | Styling (Obsidian auto-loads this) |
| `package.json` | Dependencies and scripts |
| `tsconfig.json` | TypeScript config |
| `esbuild.config.mjs` | Bundle config |
| `versions.json` | Maps plugin versions → minimum Obsidian versions |
| `LICENSE` | MIT recommended — **current year, your name** |
| `README.md` | Description, screenshots, usage |

## 2. Naming & Manifest Rules

The review bot enforces strict naming. Violations cause automatic rejection.

### Plugin ID (`manifest.json` → `id`)
- Lowercase letters, dashes, underscores only
- **Must not** contain "obsidian"
- **Must not** end with "plugin"

Bad: `obsidian-my-tool`, `my-tool-plugin`
Good: `my-tool`, `file-metadata`

### Plugin name (`manifest.json` → `name`)
- **Must not** contain "Obsidian" or fragments ("Obsi", "dian")
- **Must not** end with "Plugin"

Bad: `Obsidian File Viewer`, `My Tool Plugin`
Good: `File Viewer`, `My Tool`

### Description (`manifest.json` → `description`)
- **Must not** start with "This plugin" / "A plugin that" / "This is a plugin"
- **Must not** contain "Obsidian"
- **Must** end with punctuation (`.`, `!`, `?`, `)`)
- Keep under 250 characters

Bad: `This plugin allows you to view file metadata in Obsidian`
Good: `Shows file metadata, text statistics, and document outline in the sidebar.`

### LICENSE
- **Must** use current year
- **Must not** list "Dynalist Inc." as copyright holder (leftover from old template)

## 3. Code Quality & UI Rules

### Remove sample code
Rules: `obsidianmd/no-sample-code`, `obsidianmd/sample-names`

Remove all boilerplate before publishing. Rename `MyPlugin`, `SampleSettingTab`, `SampleModal` to meaningful names for your plugin.

### Sentence case for all UI text
Rule: `obsidianmd/ui/sentence-case` (auto-fixable)

All user-facing text uses sentence case — first word capitalised, rest lowercase (except proper nouns). This applies to `.setName()`, `.setDesc()`, `.setText()`, `.setButtonText()`, `new Notice()`, `addCommand()` names, and ARIA labels.

Bad: `this.addCommand({ name: 'Open File Viewer' })`
Good: `this.addCommand({ name: 'Open file viewer' })`

For localised plugins, also enable `obsidianmd/ui/sentence-case-json` and `obsidianmd/ui/sentence-case-locale-module` via the `recommendedWithLocalesEn` config.

### Command naming
Rules: `obsidianmd/commands/no-command-in-command-id`, `no-command-in-command-name`, `no-plugin-id-in-command-id`, `no-plugin-name-in-command-name`

Don't include "command" or your plugin's ID/name in command IDs or names. Obsidian automatically namespaces commands with the plugin ID.

Bad: `{ id: 'file-metadata-show-panel', name: 'File Metadata: Show panel' }`
Good: `{ id: 'show-panel', name: 'Show panel' }`

### No default hotkeys
Rule: `obsidianmd/commands/no-default-hotkeys`

Let users configure their own shortcuts. Never assign hotkeys in `addCommand()`.

### Use correct command callback type

- `callback` — always available
- `checkCallback` — conditionally available (return `true` to show, execute when `checking` is false)
- `editorCallback` — only available when an editor is active

### Settings headings
Rules: `obsidianmd/settings-tab/no-manual-html-headings`, `no-problematic-settings-headings`

Use `.setHeading()` for section headers. Don't use `createEl('h3')`. Avoid "settings", "options", "General", or the plugin name in heading text — the user already knows where they are.

Bad: `containerEl.createEl('h3', { text: 'General settings' })`
Good: `new Setting(containerEl).setName('Appearance').setHeading()`

### Don't mutate defaults
Rule: `obsidianmd/object-assign`

Bad: `Object.assign(DEFAULT_SETTINGS, loadedData)` — mutates defaults!
Good: `{ ...DEFAULT_SETTINGS, ...loadedData }`

### Validate manifest and license
Rules: `obsidianmd/validate-manifest`, `obsidianmd/validate-license`

The linter checks that `manifest.json` is valid and complete, and that LICENSE has a current year and isn't the template's Dynalist copyright.

## 4. API Patterns

### File access

```typescript
// Active file — use the Editor API (preserves cursor)
const view = this.app.workspace.getActiveViewOfType(MarkdownView);
if (view) {
  const editor = view.editor;
  editor.replaceRange(text, from, to);
}

// Background file edits — atomic, prevents race conditions
await this.app.vault.process(file, (content) => {
  return content.replace('old', 'new');
});

// Frontmatter manipulation
await this.app.fileManager.processFrontMatter(file, (fm) => {
  fm.tags = fm.tags || [];
  fm.tags.push('new-tag');
});

// File deletion (handles backlink cleanup)
await this.app.fileManager.trashFile(file);

// Direct lookup instead of iterating all files
const file = this.app.vault.getAbstractFileByPath(normalizedPath);
```

Rules: `obsidianmd/no-vault-editor`, `obsidianmd/use-vault-process`, `obsidianmd/prefer-file-manager-trash-file`, `obsidianmd/vault/iterate`

### Type-safe file handling
Rule: `obsidianmd/no-tfile-tfolder-cast`

Use `instanceof` for type narrowing, never `as TFile` or `as any` casts:

Bad: `const file = abstractFile as TFile;`
Bad: `(this.app as any).someInternalThing`
Good: `if (abstractFile instanceof TFile) { /* safe */ }`

### Path handling
Rules: `obsidianmd/hardcoded-config-path`

```typescript
// Always normalise user-supplied paths
import { normalizePath } from 'obsidian';
const path = normalizePath(userInput);

// Never hardcode .obsidian — users can customise this
const configDir = this.app.vault.configDir;
```

### Network requests

```typescript
// Obsidian's requestUrl bypasses CORS and works on mobile
import { requestUrl } from 'obsidian';
const response = await requestUrl({ url: 'https://api.example.com/data' });
```

### Platform detection
Rule: `obsidianmd/platform`

```typescript
import { Platform } from 'obsidian';
if (Platform.isMobile) { /* adjust UI */ }
if (Platform.isDesktopApp) { /* desktop-only feature */ }
```

Never use `navigator.platform` or `navigator.userAgent`.

### Global app
Rule: `obsidianmd/no-global-app`

Always use `this.app` from your plugin instance — never the global `app` variable.

### Input suggestions
Rule: `obsidianmd/prefer-abstract-input-suggest`

Use Obsidian's built-in `AbstractInputSuggest`, not copied community implementations.

### DOM creation

```typescript
// Use Obsidian's helpers — never innerHTML (XSS risk)
const container = parentEl.createDiv({ cls: 'my-plugin-container' });
const label = container.createSpan({ text: 'Hello' });
const button = container.createEl('button', {
  text: 'Click',
  attr: { 'aria-label': 'Action' }
});
```

### Fire-and-forget promises

```typescript
// Use void for promises you intentionally don't await
void this.saveData(this.settings);
```

### Timer types

```typescript
// Use window.setTimeout (returns number), not NodeJS.Timeout
const timer: number = window.setTimeout(() => { /* ... */ }, 1000);
```

### Imports

Always use ES module `import` statements, never `require()`. The esbuild config handles module resolution:

Bad: `const { setIcon } = require('obsidian');`
Good: `import { setIcon } from 'obsidian';`

### Console logging

Minimise console output. Don't log in `onload`/`onunload` in production. Use conditional debug logging:
```typescript
if (this.settings.debugMode) {
  console.log('Debug:', data);
}
```

## 5. Memory Management

Obsidian plugins must clean up after themselves. The `Plugin` base class provides auto-cleanup methods:

| Method | Cleans up |
|--------|-----------|
| `this.registerEvent(events.on(...))` | Workspace/vault event listeners |
| `this.addCommand({...})` | Registered commands |
| `this.registerDomEvent(el, 'click', fn)` | DOM listeners on **persistent** elements |
| `this.registerInterval(window.setInterval(fn, ms))` | Intervals |

All are automatically cleaned up on plugin unload.

For **ephemeral DOM** (elements destroyed and recreated each render), plain `addEventListener` is fine — the DOM destruction handles cleanup. `registerDomEvent` on ephemeral elements would accumulate stale references.

### Don't store view references
Rule: `obsidianmd/no-view-references-in-plugin`

Views are destroyed and recreated by Obsidian. Query dynamically:
```typescript
const leaves = this.app.workspace.getLeavesOfType('my-view');
```

### Don't pass plugin as component
Rule: `obsidianmd/no-plugin-as-component`

Never pass `this` (the plugin) to `MarkdownRenderer.render()`. The plugin lifecycle outlives individual renders, causing memory leaks. Create a separate `Component` instance instead.

### Don't detach leaves in onunload
Rule: `obsidianmd/detach-leaves` (auto-fixable)

Obsidian handles leaf cleanup automatically — `detachLeavesOfType()` in `onunload()` is unnecessary and can cause issues.

## 6. CSS & Styling

### Use Obsidian CSS variables

Common variables:
- **Text**: `--text-normal`, `--text-muted`, `--text-faint`, `--text-accent`
- **Backgrounds**: `--background-primary`, `--background-secondary`, `--background-modifier-border`
- **Interactive**: `--interactive-accent`, `--interactive-hover`
- **Sizing**: `--font-ui-small`, `--font-ui-medium`, `--radius-s`, `--radius-m`
- **Spacing**: `--size-4-1` through `--size-4-8` (4px grid)
- **Navigation**: `--nav-heading-weight`, `--nav-heading-size`

### Scope everything
Rule: `obsidianmd/scoped-styles`

For `ItemView` subclasses, Obsidian adds a `.view-type-{viewType}` class to the container automatically. Use this as the root selector to prevent styles leaking into other views:
```css
/* viewType is whatever getViewType() returns */
.view-type-my-plugin-view .row { /* scoped to your view */ }
```

For non-view elements, prefix all classes with your plugin ID (e.g., `my-plugin-row`, `my-plugin-header`).

### No inline styles
Rule: `obsidianmd/no-static-styles-assignment`

All CSS goes in `styles.css`. Never use `element.style.color = '...'` or create `<style>`/`<link>` elements.

### Style Settings integration

Add a `/* @settings */` YAML block at the top of `styles.css` to expose variables to the [Style Settings](https://github.com/mgmeyers/obsidian-style-settings) plugin:

```css
/* @settings
name: My Plugin
id: my-plugin
settings:
  - id: my-plugin-accent
    title: Accent colour
    type: variable-themed-color
    format: hex
    default-light: '#383a42'
    default-dark: '#abb2bf'
*/
```

Reference with fallbacks: `color: var(--my-plugin-accent, var(--text-normal));`

Without Style Settings, fallbacks apply. With it, users get colour pickers and sliders.

### Theme compatibility

Test in both light and dark themes. CSS variables handle theme switching automatically — no need for manual `.theme-dark` selectors.

## 7. Accessibility (MANDATORY)

Accessibility is not optional. The review bot checks for it and plugins are rejected without it.

### Keyboard navigation
Rule: `obsidianmd/no-missing-keyboard-handler`

Every clickable element must also respond to Enter and Space. Extract the action into a named function to avoid duplication:

```typescript
const action = (): void => { /* do something */ };

el.setAttribute('tabindex', '0');
el.setAttribute('role', 'button');
el.addEventListener('click', action);
el.addEventListener('keydown', (e: KeyboardEvent) => {
  if (e.key === 'Enter' || e.key === ' ') {
    e.preventDefault();
    action();
  }
});
```

For navigation links, use `role="link"` instead of `role="button"`.

### ARIA attributes

- **Icon-only buttons**: must have `aria-label`
- **Collapsible sections**: must have `aria-expanded` (toggled on click)
- **Tooltips**: use `data-tooltip-position` attribute

```typescript
button.setAttribute('aria-label', 'Open settings');
header.setAttribute('aria-expanded', String(!isCollapsed));
```

### Focus indicators

```css
.my-plugin .is-clickable:focus-visible {
  outline: 2px solid var(--interactive-accent);
  outline-offset: -2px;
  border-radius: var(--radius-s);
}
```

### Touch targets

All interactive elements must be at least **44×44px** for mobile usability.

### Screen reader support

Use `aria-live` regions for dynamic content updates that should be announced to assistive technology.

### Verification checklist

Before release, verify:
- [ ] All interactive elements respond to keyboard (Tab + Enter/Space)
- [ ] Tab order is logical
- [ ] Focus indicators are visible
- [ ] Icon buttons have `aria-label`
- [ ] Collapsible sections have `aria-expanded`
- [ ] Touch targets ≥ 44×44px

## 8. Testing

There's no standard automated testing framework for Obsidian plugins. Testing is primarily manual, with lint as the first automated gate.

### Automated checks

```bash
npm run lint    # Catches all ESLint rules — run this first
npm run build   # TypeScript type-checking + esbuild bundle
```

### Manual testing checklist

Before every release:
- [ ] **Light theme** — all UI elements visible and readable
- [ ] **Dark theme** — same check
- [ ] **Mobile** (if not desktop-only) — touch targets, responsive layout
- [ ] **Keyboard navigation** — Tab through everything, Enter/Space to activate
- [ ] **ARIA** — labels on icon buttons, expanded/collapsed states
- [ ] **Plugin reload** — disable/enable doesn't leave stale state
- [ ] **Multiple files** — switch between files, verify state updates
- [ ] **Empty state** — no file open, empty files handled gracefully
- [ ] **Large files** — performance doesn't degrade on long documents
- [ ] **Settings** — all toggles and inputs persist after restart

### Cross-platform gotchas

- **No regex lookbehind** (`obsidianmd/regex-lookbehind`) — crashes iOS < 16.4
- **Use `Platform.isMobile`** — not `navigator.userAgent`
- **Use `requestUrl()`** — not `fetch()` (CORS on desktop app)
- **Use `normalizePath()`** — path separators differ across platforms
- **Use `window.setTimeout`** — not `NodeJS.Timeout` type

### Using obsidian-cli for testing

If you have the obsidian-cli tool:
```bash
obsidian reload my-plugin    # Hot-reload after build
obsidian screenshot          # Capture current state
obsidian eval code="..."     # Run JS in Obsidian console
obsidian errors              # Check for runtime errors
```

## 9. Build, Release & Submission

### Build workflow

```bash
npm run lint          # Check code quality first
npm run build         # TypeScript check + esbuild bundle
# Deploy to vault for testing:
cp main.js styles.css manifest.json /path/to/vault/.obsidian/plugins/your-plugin/
```

### Version bumping

Update three files for every release:
1. `manifest.json` → `version`
2. `package.json` → `version`
3. `versions.json` → add `"X.Y.Z": "minAppVersion"`

The template's `.npmrc` strips the `v` prefix so `npm version patch` creates tags like `1.0.1` (not `v1.0.1`), which is what Obsidian expects.

### GitHub Actions release workflow

The template doesn't include a release workflow — add one:

```yaml
name: Release
on:
  push:
    tags: ["*"]
permissions:
  contents: write
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: "20.x", cache: "npm" }
      - run: npm ci
      - run: npm run build
      - uses: softprops/action-gh-release@v2
        with:
          files: |
            main.js
            manifest.json
            styles.css
```

### Release strategy

Obsidian plugins use **tag-based releases**. The GitHub Actions workflow above triggers when a tag is pushed — it builds the plugin and creates a GitHub Release with the artefacts. This is the standard approach used by the official sample plugin and most community plugins.

**Do not auto-release on merge to main.** Not every merge warrants a release (README fixes, refactors, batched changes). The version bump is a deliberate step — you're making a compatibility promise via `manifest.json` and `versions.json`.

To release, from the `main` branch after merging any PRs:

```bash
npm version patch   # or minor/major — bumps package.json, manifest.json, versions.json, creates tag
git push && git push --tags   # pushes commit + tag, triggers the release workflow
```

The `.npmrc` in the template strips the `v` prefix so tags are `1.0.1` not `v1.0.1`, which is what Obsidian expects.

### Community submission

1. Create a GitHub release with `main.js`, `manifest.json`, `styles.css` as assets
2. Fork [obsidianmd/obsidian-releases](https://github.com/obsidianmd/obsidian-releases)
3. Add your plugin to `community-plugins.json`:
   ```json
   {
     "id": "your-plugin-id",
     "name": "Your Plugin Name",
     "author": "your-github-username",
     "description": "Description ending with punctuation.",
     "repo": "username/obsidian-your-plugin"
   }
   ```
4. Open a PR — the review bot scans your repo automatically
5. Fix any issues — the bot rescans within ~6 hours of each push (no new PR needed)

### Common rejection reasons

- Plugin name/ID contains "Obsidian" or ends with "Plugin"
- Description starts with "This plugin" or lacks terminal punctuation
- Missing keyboard handlers on interactive elements
- Using `as TFile` casts instead of `instanceof`
- Hardcoded CSS colours instead of variables
- Sample class names left from template (`MyPlugin`, `SampleModal`)
- LICENSE still says "Dynalist Inc." or has wrong year
