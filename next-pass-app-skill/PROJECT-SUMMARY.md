# Project Summary — How Next Pass Was Built & Shipped

*The worked example behind this skill: a plain-language, step-by-step account of how a non-programmer built and published a Chrome extension with Claude as the coding partner. Account identifiers are anonymized. No prior coding knowledge assumed — each step explains both **what** to do and **why**.*

---

## What it produced

A working Chrome extension — **Next Pass**, a glanceable countdown to the next visible ISS pass — published on the Chrome Web Store, built without the author writing the code by hand, by directing, testing, and shipping it with AI support.

**The journey breaks into seven phases:**

1. Decide what the app is about
2. Set up the project and tools
3. Build it in small daily sprints
4. Test it (where the human does the real work)
5. Package it for the store
6. Register and submit to the Chrome Web Store
7. Launch and handle feedback

---

## Phase 1 — Decide what the app will be about

The hardest part isn't the code; it's choosing a good first idea. A good first app is **small, useful to you personally, and clearly scoped**.

**1.1 — Pick something you actually want.** Next Pass came from a real itch: "when can I see the ISS from my backyard?" Building something you'd use yourself keeps motivation up and makes you a sharper tester — you immediately notice when it feels wrong.

**1.2 — Write the idea as one sentence.** Ours: *"A glanceable countdown to the next visible ISS pass, living in the Chrome toolbar."* If you can't say it in a sentence, it's too big for a first project.

**1.3 — Confirm it's possible before committing.** Ask Claude: *"Is there a free data source for this? What would an app like this need?"* For Next Pass this surfaced a free satellite-tracking API (personal key, entered in settings) — confirming the idea was buildable before writing anything.

**1.4 — Cut it down to a version 1.** List every feature you can dream up, then circle the smallest still-useful set. Everything else becomes a "roadmap." Our v1 = countdown + pass details + a couple of conveniences; multi-satellite tracking, radio frequencies, and telescope control all went to "coming soon."

> **Why this matters:** AI will build whatever you ask. That's exactly why *you* set the boundary. Scope is the human's job.

---

## Phase 2 — Set up the project and tools

**2.1 — Give the project a home folder.** One folder for the whole app — code, images, notes. Claude reads and writes files there.

**2.2 — Tell Claude exactly which tools to use.** Say "build me an app" and the agent picks its own path, often the hardest one. Be specific: "create the files in this folder," "use [this] API for data." Naming the tool saves hours.

**2.3 — Consider a Skill for a long project.** A Skill is a reusable instruction bundle Claude loads at the start of each session so it doesn't re-learn the project each time — it keeps responses fast and consistent over a multi-day build. Claude can write one for you.

---

## Phase 3 — Build it in small daily sprints

Don't build the whole app in one prompt. Break it into **small daily steps, each testable on its own.** The exact arc we used:

**3.1 — Day 1: get *anything* to load.** A bare extension that installs and shows "Hello, ISS." Tiny, but it proves the foundation works.

**3.2 — Day 2: core feature with fake data.** The toolbar popup with a live countdown, using *placeholder* data, so the look could be designed before wiring anything real. **Design first with fake data; wire in real data later.**

**3.3 — Day 3: tidy up and add settings.** Refactored so the popup and a full-screen view share one engine instead of two copies that drift; added a Settings page. Less glamorous "make it maintainable" work that prevents future bugs.

**3.4 — ~Day 5: connect real data.** Wired in the live satellite API so the countdown reflects actual passes, added a cache (so it isn't constantly re-fetching), and a fallback to demo data when there's no key or network. **Always plan for "what if the data isn't there?"**

**3.5 — Later sprints: the "real app" extras.** Desktop notifications before bright passes; one-click calendar export. The touches that make it feel finished.

> **Why sprints work:** each day ends with something you can see and test. If a step breaks, you know exactly which change caused it.

---

## Phase 4 — Test the app (with AI support)

Where a non-programmer adds the most value. **You don't need to read code to test well — you need to use the app and notice what's wrong.**

**4.1 — After every sprint, actually run it.** Load it in Chrome (`chrome://extensions/` → enable Developer mode → "Load unpacked" → pick the project folder), then *use* it.

**4.2 — Test like a user, not a coder.** Click the buttons. Does the calendar button really add an event? Does the notification fire? Does it still work with the internet off? Bugs hide in the click-through, not the code review.

**4.3 — Describe problems plainly.** No technical words needed. *"The countdown shows dashes instead of a time"* is enough; Claude traces the cause from the symptom.

**4.4 — Verify the agent's claims yourself.** Claude sounds equally confident whether right or wrong. When it says "fixed," reload and check. Real example: the privacy policy *looked* done, but the live page still showed a placeholder email — because two near-identical files existed and the edit went into the one that wasn't being served. Only loading the live page revealed it.

**4.5 — Loop until it's boring.** Test → report → fix → re-test. When you can't find anything new wrong, you're ready to ship.

> **The mindset shift:** you move from "director" (hand off tasks) to **co-creator and tester** — running every build, finding the bugs, deciding what's good enough. The AI writes the code; you own the quality.

---

## Phase 5 — Package the app for the store

Shipping is its own skill, separate from building.

**5.1 — Zip the extension** (code + icons) into a single file. **5.2 — Write the listing text** (name, short + long description, category) — Claude drafts, you edit. **5.3 — Create the images** (icon, 440×280 promo tile, 1–5 screenshots at 1280×800 taken from the real app). **5.4 — Write and host a privacy policy** at a public URL (GitHub Pages is free) listing what you store, what you send out, and how users delete it. **5.5 — Prepare permission justifications** — one plain sentence per permission.

*(Full detail in `references/store-submission.md`.)*

---

## Phase 6 — Register and submit to the Chrome Web Store

**6.1 — Open the Developer Dashboard** at `chrome.google.com/webstore/devconsole` and sign in with the account that should own the listing. **6.2 — Pay the one-time $5 developer fee** (covers all future extensions). **6.3 — Create a new item and upload your zip.** **6.4 — Fill in the listing** (text, images, privacy URL, single-purpose statement, permission justifications). **6.5 — Submit for review** — Google typically replies in 2–7 days. **6.6 — Go live** on approval; you get a public store URL to share.

---

## Phase 7 — Launch and handle feedback

**7.1 — Post where your users are.** For Next Pass that meant space/satellite communities. Share the *install link* — and double-check it's actually in the post (it got left out the first time and a moderator had to ask).

**7.2 — Be honest about how it was made.** Disclosing AI involvement is the right call for trust — but expect some hostility ("AI slop" comments are common now).

**7.3 — Separate signal from noise.** Some feedback is gold: a hobbyist pointed out that certain roadmap satellites were decommissioned and suggested better, still-operational ones — the roadmap was updated on the spot. Some feedback is just dismissal. Keep the specific, technical notes; let the rest go.

**7.4 — Iterate.** Fold the good feedback into the roadmap and ship updates. The first release is a starting point, not the finish line.

---

## The big-picture lessons

- **You set the scope; the AI fills it.** Deciding *what not to build* is the most important job.
- **Build in small, testable steps.** One change at a time means you always know what broke.
- **Test by using, not by reading.** A non-programmer who clicks through everything catches the bugs that matter.
- **Verify the agent's claims.** Confident wording isn't proof.
- **Shipping is a separate skill from building.** Packaging, privacy, store assets, and review are the real "last mile."
- **A public launch isn't a warm welcome.** Mine the useful feedback; ignore the noise.

*From "wouldn't it be cool if…" to a live, public app — done as a non-programmer, with AI as the coding partner and the human as director, tester, and owner.*
