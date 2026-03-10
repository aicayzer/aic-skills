---
description: "Email landscape reference — accounts, access rules, Superhuman concepts"
---

Reference skill for working with email across the system. Read this fully before performing any email-related operations.

## Email Accounts

Three email addresses are accessible via the Apple Mail MCP on `aic-atlas`:

### august@cayzer.me (Google account: "Google")
- **Purpose:** Primary personal email
- **Also used in:** Superhuman (desktop/mobile)
- **Access:** Read-only via Apple Mail MCP. Draft creation OK. Never send.
- **Superhuman concepts apply** — see below

### aicayzer@icloud.com (iCloud account: "iCloud")
- **Purpose:** Apple ID / iCloud email
- **Access:** Read-only via Apple Mail MCP. Draft creation OK. Never send.
- **Shares the iCloud account** with ops.cyzr.me addresses

### *@ops.cyzr.me (iCloud account: "iCloud")
- **Purpose:** Infrastructure operations — alerts, notifications, system emails
- **Catch-all:** Any address @ops.cyzr.me lands here (e.g. alerts@ops.cyzr.me)
- **Sending:** Only via msmtp on `aic-atlas` (not via Apple Mail MCP). From address: `ops.cyzr@icloud.com` (fallback) or `mail@ops.cyzr.me` (when propagation completes)
- **Access:** Read-only via Apple Mail MCP

### oblix.cyzr@gmail.com (NOT in Apple Mail)
- **Purpose:** Oblix's dedicated email channel
- **Access:** Gmail API only (not Apple Mail MCP). Managed entirely in NanoClaw's Gmail channel code
- **Not relevant to this skill** — covered by Oblix's own security model


## Apple Mail MCP Rules

The MCP runs in `--read-only` mode. The following tools are removed at startup:
- `compose_email`, `reply_to_email`, `forward_email`

Draft sending is blocked by a runtime guard. You can:
- Read emails from any accessible account
- Search across accounts
- Create drafts (saved to the account's Drafts folder)
- List, delete drafts
- Move emails between mailboxes
- Flag/unflag, mark read/unread
- Export emails
- View statistics and attachments

**Always pass the `account` parameter explicitly.** Never call tools without specifying the account — this prevents unintended iteration across all accounts.

Mail.app account names (what to pass as `account`):
- `"iCloud"` — for aicayzer@icloud.com and ops.cyzr.me
- `"Google"` — for august@cayzer.me


## Superhuman Concepts

august@cayzer.me is managed in Superhuman on mobile/desktop. Superhuman applies its own state model on top of Gmail. In Apple Mail, these manifest as:

- **Done** — email is archived (moved out of INBOX into `[Gmail]/All Mail`). It won't appear in INBOX searches but is still accessible in All Mail.
- **Snoozed** — email is temporarily hidden. Superhuman moves it to a snooze folder. It will reappear in the inbox at the scheduled time. In Mail.app, snoozed emails may appear in a `[Gmail]/Snoozed` or similar mailbox.
- **Remind me** — similar to snooze but for sent emails. Superhuman will surface the thread if no reply is received.
- **Labels** — Superhuman uses Gmail labels, which appear as mailboxes in Mail.app under `[Gmail]/` prefix.
- **Split inbox** — Superhuman categorises emails (Important, Other, etc.). These don't map to Mail.app mailboxes.

**Implication:** When reading august@cayzer.me via Apple Mail, the inbox may not match what the user sees in Superhuman. Archived/done emails are not in INBOX. Snoozed emails may be in unusual locations. If something seems missing, check `[Gmail]/All Mail`.


## Infrastructure Alerting

Infrastructure scripts send alerts to `alerts@ops.cyzr.me` via msmtp:

```bash
source ~/.config/aic-services/scripts/notify.sh
notify ERROR service-name "error description"
notify WARN service-name "warning description"
notify OK service-name "success confirmation"
```

Subject format: `[ERROR] service-name: description`

These arrive in the iCloud account and are readable via the Apple Mail MCP by searching for `[ERROR]`, `[WARN]`, or `[OK]` in subjects.
