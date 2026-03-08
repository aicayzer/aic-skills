# Common Raycast Extension Pitfalls

Issues that cause store rejection or runtime bugs. Ordered by frequency.

## Store Rejections

### 1. Manual Preferences interface
**Wrong:** Defining `interface Preferences { ... }` in your code.
**Right:** Raycast auto-generates this from package.json into `raycast-env.d.ts`. Just use `getPreferenceValues<Preferences>()`.

### 2. defaultValue vs default
**Wrong:** `"defaultValue": "detail"` in package.json preferences.
**Right:** `"default": "detail"`.

### 3. Missing EmptyView
**Wrong:** A List or Grid that shows nothing when empty.
**Right:** Always include `<List.EmptyView title="..." description="..." />` with a helpful message and optionally a create action.

### 4. Using dotenv
**Wrong:** `import 'dotenv/config'` or `.env` files.
**Right:** Use `getPreferenceValues()` for all configuration. Preferences are defined in package.json and managed through Raycast's UI.

### 5. console.log for errors
**Wrong:** `console.log(error)` or `console.error(error)`.
**Right:** `showFailureToast(error)` from `@raycast/utils`, or `showToast({ style: Toast.Style.Failure, title: "...", message: String(error) })`.

### 6. Navigation title on root command
**Wrong:** Setting `navigationTitle` dynamically on the root command's List/Grid.
**Right:** Use a static `navigationTitle` string on root, or omit it entirely. Only set dynamic titles on pushed (nested) screens.

### 7. Missing screenshots
The `metadata/` folder must contain at least 1 screenshot at 2000x1250 PNG. Reviewers check this early — missing screenshots delay the review.

## Runtime Bugs

### 8. Empty view flicker
**Cause:** Data hasn't loaded yet, but `isLoading` is false, so the empty view briefly shows.
**Fix:** Pass `isLoading={true}` while the initial fetch is in progress. Use `useCachedPromise` which handles this automatically with `keepPreviousData: true`.

### 9. OAuth token in component body
**Wrong:** `const { token } = getAccessToken()` at the top level of a component.
**Right:** Call `getAccessToken()` inside callbacks, hook functions, or event handlers. Use `withAccessToken(provider)(Component)` to wrap command exports.

### 10. Stale etag on update
**Cause:** Using a cached contact's etag for an update after the contact has been modified elsewhere. Google API returns 400.
**Fix:** Always fetch the latest contact (`getContact`) immediately before pushing to an edit form or performing an update.
