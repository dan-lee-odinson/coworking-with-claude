---
name: next-pass
description: Build, test, and ship a small browser extension (or similar self-contained app) with Claude as the coding partner — from idea through Chrome Web Store publication. Use this whenever Dan wants to work on Next Pass or build a new app/extension from scratch, scope an app idea, set up daily build sprints, test or debug an extension, package an app for the Chrome Web Store, write a privacy policy or store listing, or plan a launch. Also use when Dan says things like "let's build an app," "make a Chrome extension," "ship this to the store," "what's next on the app," or names a specific app feature/roadmap item — even if he doesn't explicitly name this skill.
---

# Next Pass — Building & Shipping a Browser-Extension App with Claude

This skill captures the workflow Dan used to build and publish his first app — **Next Pass**, a glanceable Chrome extension that shows a countdown to the next visible ISS pass — and generalizes it so the same method works for the next app. It exists because shipping software has a lot of moving parts (manifest, data source, testing, packaging, privacy policy, store review, launch) and a non-programmer working through an AI partner needs clear guardrails to keep each part honest and in order.

The guiding idea: **Claude writes the code; Dan scopes it, tests it, and owns what ships.** This skill is built around that division of labor.

## When you should consult this skill

Any task involving Next Pass or a new app/extension build: scoping an idea, setting up sprints, writing extension code, testing/debugging in the browser, packaging for the Chrome Web Store, drafting a privacy policy or listing copy, or planning a launch. If Dan mentions "the app," "the extension," "the store," a Next Pass roadmap feature (multi-satellite tracking, ARISS radio frequencies, telescope pointing), or building something new "like Next Pass," this skill applies.

## Tools this skill expects

- **File tools (Read/Write/Edit)** — the app's source lives in a single project folder on Dan's machine. Create and edit files there directly. Keep everything for one app in one folder.
- **Chrome MCP (`mcp__Claude_in_Chrome__*`)** — for loading/inspecting the extension behavior, reading live pages (e.g. verifying a published privacy policy), and checking the store listing. Note the gallery itself (`chromewebstore.google.com`) blocks scripting and screenshots — you can see the tab exists but cannot read its contents; rely on Dan for what the dashboard shows.
- **A static host for the privacy policy** — GitHub Pages is the established choice (free, public URL). The privacy page is a separate repo from the app code.

If Chrome isn't connected when behavior needs checking, ask Dan to enable it rather than guessing at what the running extension does.

## The non-negotiable rules

These exist because the failure modes on this kind of project are predictable, and each rule heads one off.

**1. Dan sets scope; you fill it.** An AI will happily build any feature asked of it — which is exactly why the human draws the boundary. Before building, agree on a *version 1* (the smallest genuinely useful set) and push everything else to a written "roadmap." Don't quietly expand scope mid-build.

**2. Build in small, testable sprints — never one giant prompt.** Each step should end in something Dan can see and run. The Next Pass arc: Day 1 get *anything* to load → Day 2 core feature with mock data → Day 3 refactor + settings → ~Day 5 wire in live data + caching + fallback → later sprints for notifications, exports, packaging. One change at a time means a break is traceable to the change that caused it.

**3. Test by using, not by reading.** The bugs that matter surface only when the app is actually clicked through. After every sprint, load it (`chrome://extensions/` → Developer mode → Load unpacked), then exercise every screen, button, and setting. Confirm real-vs-demo data states, that exports actually fire, that notifications actually appear, and that it degrades gracefully with no network/key.

**4. Verify your own claims before reporting "done."** Claude sounds equally confident whether right or wrong. When you say something is fixed or live, check it with your own eyes (reload the page, re-read the file). The canonical Next Pass example: the privacy policy *looked* finished, but the live URL still showed a placeholder email — because two near-identical files existed (`index.html` vs `PRIVACY.html`) and the edit went into the one that wasn't served. Only loading the live page revealed it. Always confirm the thing being served, not just the file you edited.

**5. Never hardcode or expose secrets, and never fabricate data.** API keys live in the app's settings/storage, entered by the user — never in source, never in the repo, never in the listing. If a data source isn't reachable (no key, no location, no network), fall back to clearly-labeled demo data; don't invent values and present them as real.

**6. Anonymize personal/account details in anything public.** Before code, a summary, or a listing goes into a public repo or post, scrub real credentials and account identifiers — support email, developer account, extension ID, repo owner, launch handle, API keys. See `references/placeholders.md` for the list and the safe placeholders to use.

## The build method (sprints)

Default to short, self-contained sprints. A good sprint has a single visible goal and ends with Dan running the result.

1. **Foundation sprint.** Get the extension to install and render *anything* (a manifest, an icon, one page). Proves the base works before any feature.
2. **Core-feature sprint, mock data.** Build the main thing (for Next Pass: the toolbar popup + countdown) using placeholder data, so the look is settled before real data is wired in.
3. **Structure sprint.** Refactor shared logic into one place so multiple views (popup + full-screen) don't drift; add a settings/options page persisted via the browser's storage.
4. **Live-data sprint.** Connect the real API. Add a cache so you don't hammer it, and a fallback path for when data is unavailable. Plan for "what if it's not there?" every time.
5. **Polish sprints.** The "real app" layer — notifications, calendar/export conveniences, empty/edge states.
6. **Packaging sprint.** Zip, listing, images, privacy policy, permission justifications, submission. See `references/store-submission.md`.

> Why sprints: each one is independently testable, so quality stays high and regressions are obvious. It also keeps each chat's context small — the same reason the smart-ring project batched its work.

## Testing & debugging with an AI partner

This is where Dan adds the most value, and where his role shifts from *director* (Project 2) to *co-creator and tester* (Project 3).

- After each sprint, Dan runs the extension and reports symptoms in plain language ("the countdown shows dashes," "the Settings button does nothing"). You trace the cause from the symptom — Dan doesn't need to read code to test well.
- Reproduce → isolate → fix → **re-test**. Don't mark something done until it's been re-run.
- When a fix touches something served publicly (a hosted page, the store listing), verify the *live* artifact, per Rule 4.
- Keep a short running list of what's been tested so nothing silently regresses between sprints.

## Packaging, submission, and launch

When v1 is solid, move to shipping. The full checklist lives in `references/store-submission.md`; the shape is: zip the extension → draft listing copy → make icon + promo tile + real screenshots → write and host a privacy policy → write one-sentence permission justifications → register on the Web Store ($5 one-time fee) → upload, fill the listing, submit → expect a 2–7 day review.

For launch: post where the app's actual users are (for Next Pass, space/satellite communities), and **include the install link** (it's the one thing easy to forget). Be honest that it was built with AI — that's the right call for trust, and expect some "AI slop" hostility alongside genuinely useful domain feedback. Keep the specific, technical feedback; fold it into the roadmap; let the noise go.

## Reference files

Read these when the task reaches them:

- `references/store-submission.md` — the full Chrome Web Store packaging and submission checklist, plus common rejection causes.
- `references/placeholders.md` — what to anonymize and the safe placeholder values to use in any public artifact.

## Project history

`PROJECT-SUMMARY.md` (in this folder) is the anonymized, step-by-step account of how Next Pass was actually built and shipped — the worked example behind this skill. Read it for the concrete walkthrough; read this SKILL.md for the reusable method.
