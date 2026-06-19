# Chrome Web Store — Packaging & Submission Checklist

Everything needed to take a finished extension from "works on my machine" to "live in the store." Work top to bottom; the early items are content you prepare, the later ones are the dashboard flow.

## 1. Package the extension

- Produce a single `.zip` containing the extension files: `manifest.json`, all HTML/CSS/JS, and the icon set (16/48/128 px).
- The manifest's `version` must increase on every upload. Keep it consistent with whatever you name the zip so you always upload the right one.
- Do **not** include secrets, local notes, or unused files in the zip.

## 2. Listing copy

Prepare, in plain text, ready to paste:

- **Item name** (≤ 45 chars)
- **Short description** (≤ 132 chars)
- **Detailed description** (≤ 16,000 chars) — what it shows, how it works, privacy posture, and a short "what's coming" if there's a roadmap
- **Category** (e.g. Productivity)
- **Single-purpose statement** — one sentence on the app's one job
- **Permission justifications** — one plain sentence per permission (storage, geolocation, alarms, notifications, each host permission). The store asks why each is needed; vague answers get rejected.

## 3. Images

- **Store icon** 128×128 (usually already in the zip).
- **Small promo tile** 440×280.
- **1–5 screenshots** at 1280×800 (or 640×400). Capture them by actually using the app so they show the real UI — placeholder/demo states (`--:--:--`) look unfinished and can draw a rejection. On Windows: `Win+Shift+S`, then crop/resize.
- Optional: 920×680 marquee tile, and a ≤30s demo video hosted on YouTube.

## 4. Privacy policy (required if the app handles any user data)

- Write a public page covering: what's stored and where, what leaves the device and to whom, that there's no account/tracking, and how the user deletes their data.
- Host it at a public URL. GitHub Pages is the established choice. **The page served at the repo root is `index.html`** — if you keep a second copy (e.g. `PRIVACY.html`), edits must go into the file actually being served, or the live page won't change.
- Put a real contact email on it (anonymize to a placeholder only in repo copies meant to be public templates).
- Paste the live URL into the listing.

## 5. Developer registration

- Go to `chrome.google.com/webstore/devconsole` and sign in with the account that should own the listing.
- Pay the **one-time $5 developer fee** (covers all future extensions, not per-app).
- Verify the contact email when prompted.

## 6. Create the item and submit

- "New item" → upload the `.zip` → wait for processing.
- Fill every listing field, upload icon + promo tile + screenshots, paste the privacy URL, add the single-purpose statement and permission justifications.
- Save draft; the dashboard shows a checklist of anything missing.
- When the checklist is clear, **Submit for review**. Google typically responds in **2–7 days**.

## Common rejection causes (all preventable here)

- Missing or unreachable privacy policy URL.
- Vague permission justifications.
- Screenshots that don't show the actual extension UI (or show demo/placeholder data).
- Requesting a permission the app doesn't visibly use.

## After approval

- You get an email and a public store URL.
- Share the URL where the app's real users are; always include the install link in the launch post.
