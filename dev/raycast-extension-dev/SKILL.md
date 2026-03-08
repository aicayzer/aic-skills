---
name: raycast-extension-dev
description: |
  Raycast extension development — conventions, store requirements, AI tools, UI patterns, and submission workflow.
  Use this skill whenever working on a Raycast extension: building a new one, updating an existing one, fixing bugs,
  adding features, preparing for store submission, or reviewing Raycast extension code. Also use when the user
  mentions Raycast commands, Raycast AI tools, or the raycast/extensions repository. Trigger when a project has
  @raycast/api in package.json, when working in a raycast/extensions fork, or when the user asks about Raycast
  extension patterns, store requirements, or the Raycast API.
---

# Raycast Extension Development

## Core Stack

- TypeScript + React (TSX), Node.js, npm (not yarn/pnpm)
- `package-lock.json` must be committed — Raycast's build system expects it
- Build: `npx ray build` — Lint: `npx ray lint --fix`
- Auto-generated types: `Preferences`, `Arguments.*` live in `raycast-env.d.ts` — defining these manually causes conflicts and is a common rejection reason

## Extension Structure

```
extension-name/
├── assets/           # Icons (512x512 PNG, custom — not the default)
├── metadata/         # Screenshots (2000x1250 PNG, 16:10, min 1, ideal 3-6)
├── media/            # README images
├── src/              # TypeScript source
├── package.json      # Raycast manifest
├── CHANGELOG.md      # Required for store
└── README.md
```

## package.json Conventions

- `license` must be `"MIT"` — Raycast store requires it for all extensions
- `categories` must have at least one entry
- Preferences use `"default"` not `"defaultValue"` — a frequent source of silent bugs
- Command titles: `<verb> <noun>` format, Apple Style Guide title case
- Extension title: nouns preferred ("Emoji Search" not "Search Emoji")
- Tool descriptions guide the AI model — make them specific and instructive, because the description is the primary way the AI decides whether and how to use the tool

## AI Tools

Tools are the extension's AI interface. The quality of JSDoc comments directly determines how well the AI uses the tool — JSDoc isn't just documentation, it's the instruction set for the model.

### Input Schema

- Use descriptive JSDoc on every parameter — these are instructions to the AI model
- Include format hints: "in ISO 8601 format", "e.g. people/c12345"
- Explain how to obtain required values: "Use the search operation first to find the resourceName"
- For array fields (phone, email), clarify append vs replace semantics — the AI model cannot infer intent without explicit guidance

### Confirmation Functions

- Export `confirmation` for create, update, and delete operations — this keeps the user in the loop for mutations
- Return `undefined` for read-only operations (search, get) to avoid unnecessary prompts
- Use `Action.Style.Destructive` for delete confirmations
- Resolve IDs to human-readable names before showing to the user — a resource name like "people/c12345" means nothing to a human

### Tool Design

- A single tool with an `operation` discriminator is fine for small extensions (under ~8 operations)
- For larger extensions, split into separate tool files per operation (Linear pattern: `create-issue.ts`, `update-issue.ts`, `add-label.ts`) — this gives the AI clearer tool boundaries
- Search results should include full entity details to avoid unnecessary follow-up `get` calls — a round-trip saved is latency halved

## UI Patterns

### Lists and Grids

- Always use `List.EmptyView` / `Grid.EmptyView` — an unexplained blank screen makes the extension feel broken
- Show loading indicator (`isLoading`) before data arrives to prevent the empty view from flickering briefly before content loads
- `searchBarAccessory` supports one dropdown only — choose the most useful filter (view mode, category, etc.)

### Action Panel

- Title Case for all action titles
- Consistent icon usage — don't mix icon styles within a section
- Group actions into `ActionPanel.Section` blocks with titles
- Destructive actions go last with `Action.Style.Destructive`

### Navigation

- Use the Navigation API (`useNavigation`, `Action.Push`) for screen transitions — don't swap content in place
- Do not modify the root command navigation title — only set it in nested/pushed screens
- Fetch fresh data before pushing to an edit form, because stale etags cause API errors on save

### Toasts

- Use `showFailureToast` from `@raycast/utils` for errors, not `console.log` — console output is invisible to the user
- Animated → Success/Failure pattern for async operations
- Include the error message in failure toasts: `message: String(error)`

## Data Fetching

- `useCachedPromise` — primary hook, stale-while-revalidate pattern with `keepPreviousData` to avoid UI flicker
- `getAccessToken()` — call inside hook callbacks, not at component level (it needs the OAuth context to be ready)
- `withAccessToken(provider)(Component)` — wrap command exports for OAuth
- For external APIs, wrap `fetch` with a helper that handles auth headers, 401 re-auth, and error extraction

## Workflow

### Before Pushing to Public Repos

Public repos (especially `raycast/extensions`) are reviewed by maintainers and used by thousands. Pushing broken or unreviewed code wastes reviewer time and delays the PR queue.

1. Run `npx ray build` — must compile clean
2. Run `npx ray lint --fix` — must pass with no errors
3. **Launch a sub-agent to review all changed files** — check for type errors, logic bugs, API correctness, missing props, unused imports, and edge cases
4. Only push after the review agent confirms the code is clean

### Sub-Agent Usage

Sub-agents catch mistakes that are easy to miss in a single pass. Use them throughout development:

- **Research agent** before starting — check existing patterns in the raycast/extensions repo, read API docs, see how similar extensions solve the same problem
- **Review agent** before pushing — full code review of all changes, with fresh eyes
- **Explore agent** for codebase questions — find patterns, check how other extensions handle similar features

### Store Submission Checklist

Before opening a PR to `raycast/extensions`, verify (see `references/store-checklist.md` for the full list):

- [ ] MIT license
- [ ] Custom icon (512x512 PNG)
- [ ] At least 1 screenshot in `metadata/`
- [ ] `categories` populated in package.json
- [ ] `ray build` and `ray lint` pass
- [ ] US English throughout
- [ ] No `dotenv` — use `getPreferenceValues()`
- [ ] No manual `Preferences` interface
- [ ] CHANGELOG.md with `## [Title] - {PR_MERGE_DATE}` format
- [ ] README covers: what it does, setup, usage

### CHANGELOG Format

```markdown
## [Initial Version] - {PR_MERGE_DATE}

- Initial release
```

For updates:

```markdown
## [Feature Name] - {PR_MERGE_DATE}

- Added starred contacts support
- Fixed phone number append vs replace bug
```

## Common Pitfalls

See `references/common-pitfalls.md` for the full list with wrong/right examples. The most frequent store rejection causes:

1. Using `"defaultValue"` instead of `"default"` in preferences
2. Manually defining `Preferences` type (auto-generated by Raycast)
3. Missing `List.EmptyView` causing blank screens
4. Using `dotenv` instead of Raycast's preference API
5. Missing screenshots in `metadata/`
6. Navigation title set on root command (only for nested screens)
