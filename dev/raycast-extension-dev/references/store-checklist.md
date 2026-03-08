# Raycast Store Submission Checklist

Complete before opening a PR to `raycast/extensions`.

## Required

- [ ] **License:** MIT (in package.json and LICENSE file)
- [ ] **Icon:** Custom 512x512 PNG in `assets/extension-icon.png` — not the default Raycast icon
- [ ] **Screenshots:** At least 1 in `metadata/` (2000x1250 PNG, 16:10 aspect ratio). 3-6 recommended.
- [ ] **Categories:** At least 1 in `package.json` `categories` array
- [ ] **Build passes:** `npx ray build` with no errors
- [ ] **Lint passes:** `npx ray lint` with no errors
- [ ] **US English:** All user-facing text
- [ ] **CHANGELOG.md:** Present with `## [Title] - {PR_MERGE_DATE}` header format
- [ ] **README.md:** Covers what the extension does, setup instructions, usage
- [ ] **package-lock.json:** Committed (npm only, no yarn.lock or pnpm-lock.yaml)

## Common Rejection Causes

- [ ] **No dotenv:** Use `getPreferenceValues()` for configuration, never `dotenv` or `.env` files
- [ ] **No manual Preferences type:** Raycast auto-generates this in `raycast-env.d.ts` from package.json
- [ ] **No console.log for errors:** Use `showFailureToast` from `@raycast/utils`
- [ ] **Empty views:** Every List/Grid must have an `EmptyView` component
- [ ] **Loading states:** Show `isLoading={true}` before data arrives to prevent empty view flicker
- [ ] **Navigation titles:** Do not set `navigationTitle` on root commands, only on pushed screens
- [ ] **Preference syntax:** Use `"default"` not `"defaultValue"` in package.json preferences
- [ ] **No external analytics:** No tracking, telemetry, or analytics services
- [ ] **No keychain access:** Do not access the system keychain
- [ ] **No opaque binaries:** All dependencies must be traceable npm packages

## Naming Conventions

- [ ] **Extension title:** Apple Style Guide title case, nouns preferred
- [ ] **Command titles:** `<verb> <noun>` format, title case
- [ ] **Action titles:** Title Case, consistent icons
- [ ] **Subtitles:** Extension name as command subtitle

## Before Pushing

- [ ] **Sub-agent review:** Launch a review agent to check all changed files for type errors, logic bugs, API correctness, and edge cases
- [ ] **Squash merge ready:** Commits are clean and follow conventional commits format
