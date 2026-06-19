# Project 2 (Detailed) — Smart Ring Affiliate Blog: Build Log & Operating Data

**Live project:** [Smart Rings Reviews](https://www.smartringsreviews.com)
**Period covered:** ~mid-April 2026 → mid-June 2026 (about nine weeks)
**Status:** Experiment closed June 2026. Site archived (a "project status" banner now sits on every page); no longer actively updated.

This is the deep-dive companion to the Project 2 section in the main [README](../README.md). The top-level README tells the story; this file shows the receipts — how the affiliate accounts were set up, how the publishing sprints actually ran, how long it took, what broke, and what it cost versus what it returned.

---

## How this was compiled (and a note on privacy)

The numbers and dates below were reconstructed from my own Cowork session history for this project, cross-checked against the live site. A few honest caveats up front:

- **Account identifiers are redacted.** Affiliate publisher IDs, tracking/store IDs, deep-link tokens, API keys, and emails are deliberately omitted. Where a tracked link existed I refer to it generically (e.g., "an AWIN `tidd.ly` deep link" or "an Amazon `amzn.to` short link") rather than reproducing it.
- **Some fields aren't in the record.** The session transcripts don't expose wall-clock run times, and they don't contain dated AWIN/Amazon account-approval correspondence. Where I'm estimating, I say so. A "Data gaps" section at the end lists everything I *couldn't* substantiate.
- **Time figures are estimates** derived from sprint sizes and the dates work was initiated, not from logged durations. Treat them as order-of-magnitude.

---

## 1. The monetization setup

The site ran a hybrid affiliate model: **direct brand programs through AWIN**, plus **Amazon Associates** as the fallback for products without a direct program (or where Amazon converts better).

### 1.1 AWIN — application and acceptance

AWIN (Affiliate Window) was the backbone for direct-brand relationships. The mechanics that are actually documented:

**The publisher pitch.** AWIN advertisers want a short reason to approve you. I had Claude review the live site and draft a ≤255-character application pitch positioning the site as a niche, decision-stage buyer audience — independent reviews, 100% focused on smart rings, readers ready to purchase. That single paragraph was reused (lightly tailored) across program applications. No application fee appeared at any point in the process.

**Programs approved (4 confirmed):**

| Brand | Network | Status | Notes |
|---|---|---|---|
| Ultrahuman | AWIN | Approved | First direct program approved — a real milestone. Deep link generated via AWIN; product corrected to **Ultrahuman Ring PRO ($479)**. |
| BKWAT | AWIN | Approved | Approved the **same day** as Ultrahuman. Kept both the AWIN link and an existing Amazon link live for the brand. |
| Circular | AWIN | Pending → Approved | Initially "still pending," so the brand was mentioned editorially with an `[AFFILIATE LINK PENDING]` placeholder; later approved and the placeholder swapped for the live AWIN link across the affected posts. |
| Omni Health Ring | AWIN | Approved | Approved before the brand was covered anywhere on the site — the link was "banked" in the brand reference file with specs marked TBD. |

**The pattern worth recording:** approvals came in clusters ("two approvals in one day," then "two more"), and they didn't line up with content. Sometimes a program was approved before there was a post to put it in (Omni); sometimes a brand was written about before approval landed (Circular). That mismatch created link-maintenance work later (see the friction log).

**Link format:** AWIN approved-program links used AWIN's official `tidd.ly` shortener. They were dropped into posts verbatim — no third-party link-cloaking layer was relied on for these.

### 1.2 Amazon Associates — application and acceptance

Amazon Associates covered the brands without a direct AWIN program. What the record actually supports:

- **Active Amazon tracked links** (`amzn.to`) were live for at least **BKWAT, Samsung Galaxy Ring, Oura, and RingConn**. The Samsung Galaxy Ring Amazon link was added mid-project by hand.
- Amazon's well-known **qualification rule** is the relevant risk here for any new Associate: you must generate a small number of **qualifying sales within 180 days** of signup or the account is closed and you reapply. (Amazon's 2026 API changes — the old Product Advertising API being retired and a higher sales bar for API access — were researched separately during the project but apply to programmatic access, not basic link earnings.)
- The store/tracking ID itself is **redacted**.

**Honest gap:** the exact Amazon Associates signup date, store-ID creation date, current standing against the 180-day rule, and any influencer-program enrollment are **not documented** in the project history. What's certain is that Amazon links were created and in use across the catalog. Given total affiliate earnings of $4.08, the account did *not* clear a meaningful qualifying-sales threshold during the experiment.

---

## 2. The publishing sprints

Posts were produced and scheduled in batches — never all at once, because asking for ten-plus in a single parallel run reliably overwhelmed the desktop app. Early batches were written by injecting PHP (`wp_insert_post()`) through the WordPress Theme File Editor, because JavaScript `fetch`/REST calls from injected scripts hung indefinitely. Later batches moved to `wp.apiFetch`/REST once that path was working. Featured images were built from Pexels base photos and composited to 1200×630.

### Sprint-by-sprint

| Sprint (as labeled) | Initiated | Posts | Scheduled to publish | Cadence | Highlights / topics |
|---|---|---|---|---|---|
| **Batch 1** | ~3rd week April 2026 | ~12 | Apr 23 – May 4 | First 3 at 14:00 UTC; rest at 09:00 | Foundational catalog. Built via a 71 KB PHP payload base64-injected in ~34 sub-chunks. Spanned 2+ sessions. Medical disclaimers added on GLP-1, sleep-apnea, and FDA/contraception posts. 5 categories created. |
| **Batch 2** | late April | 3 | Apr 29 – May 1 | 09:00 | "How Smart Rings Have Evolved"; "Smart Ring vs. Smartwatch vs. Patch"; "Smart Ring as EDC." ~1,400–1,600 words each. Clean run with full verification. |
| **Batch 3** | early May | 2 | May 2 – May 3 | 09:00 UTC | "Where Does Your Smart Ring Data Go?"; "Smart Rings for Personal Safety." Samsung Amazon link added by hand afterward. |
| **Batch 8** (run in the session titled "batch 4") | ~May 25–26 | 10 | May 26 – Jun 4 | 09:00 UTC | Run as four micro-batches (8a–8d). Comparison/how-to mix: Oura 4 vs RingConn; vs Whoop; shift workers; step/calorie accuracy; cleaning; saunas/hot tubs; colors & finishes; gift guide; myths; first week. Milestone note: "35 consecutive days now queued." |
| **June replacement batch** | ~mid-June | 4 | Jun 13 – Jun 16 | daily | First-week setup; ring myths; rings as gifts; colors & finishes — deliberate rewrites that replaced four older Batch-8 posts and introduced Oura Ring 5 / RingConn Gen 3 with new Amazon links. Triggered the duplicate-content cleanup. |

Plus non-sprint work: a **featured-image audit across all ~44 posts** (with four replacement images staged as drafts), and a **deduplication pass** that caught accidentally re-created posts.

### The catalog, in numbers
- **~31 posts** came from clearly dated sprints above.
- At the Batch 8 milestone the project self-reported a **catalog of ~44–45 posts** (≈9 published from an April baseline + ~35–36 scheduled May 1 – Jun 4), growing further with the June batch.
- **Cadence** standardized to **one post per day at 09:00 UTC** from Batch 2 onward. Batch 1's first three went out at 14:00 UTC — an inconsistency that got flagged (below).

---

## 3. Time spent (estimated)

There are no logged run-time figures in the history, so this is reconstructed from sprint sizes and the dates work was initiated. **Methodology:** assume ~12–18 minutes of agent execution per finished post (research → draft → image → schedule → verify), then add setup, fixes, and oversight separately.

| Work | Volume | Estimated agent runtime | Notes |
|---|---|---|---|
| Content production | ~44 posts in catalog | ~9–13 hrs | The bulk of execution time. |
| Featured-image audit + rebuilds | ~44 audited, 4 rebuilt | ~2–4 hrs | Canvas compositing + uploads. |
| Affiliate-link updates, dedup, redirects, TOC/cache config | several sessions | ~3–5 hrs | Lots of small, fiddly edits. |
| **Estimated agent execution total** | — | **~15–20 hrs** | Spread across 8+ dedicated sessions. |
| **Estimated human direction/oversight** | — | **~25–35 hrs** | Reviewing outputs, approvals, account setup (WordPress, hosting, AWIN/Amazon apps), debugging, decisions. |

**Calendar span:** ~9 weeks (mid-April to mid-June 2026). The takeaway the raw hours understate: this was **not passive**. The agent compressed production time, but the human hours — setup, verification, and cleanup — were substantial and unavoidable.

---

## 4. Operational friction (the rework log)

The part most "AI passive income" write-ups leave out. Each of these cost real time:

1. **Usage-policy / safety-classifier refusals mid-batch.** During Batch 1 and the affiliate-research session, requests intermittently returned a "unable to respond… appears to violate our Usage Policy" error and stalled progress. The affiliate-research session was effectively blocked and had to be restarted; reframing the request was the only reliable fix.
2. **Usage / session limits reached.** At least one content session ended mid-task with a hard "you've hit your session limit · resets [time]" message, cutting off a blog-list review and forcing a fresh session to continue.
3. **Context exhaustion → session restarts.** The Batch 1 PHP injection ran out of context partway (≈56% through the payload) and had to be resumed from a summary in a new session.
4. **REST/AJAX hangs forced a workaround.** Injected `fetch`/XHR calls hung indefinitely, so early posts had to be written via the Theme File Editor + `wp_insert_post()` instead of the REST API.
5. **Large-string injection errors.** A ~25,000-character base64 chunk threw a `SyntaxError` (the tool truncated the string); fix was to split into ~34 chunks of ~3,000 chars. A separate base64 paste error mid-Batch-3 required re-encoding an image.
6. **`javascript_tool` silent failures.** Calls failed quietly because of wrong parameters (and "top-level await isn't supported"), so some uploads/creations didn't actually happen until reworked into an async pattern.
7. **Stale media IDs → missing featured images.** Some posts published with `featured_media = 0` because outdated media IDs were used; images had to be re-attached.
8. **Duplicate posts created — twice.** One session created three posts that duplicated existing ones; the June batch also duplicated four Batch-8 posts. Resolved by setting the duplicates back to draft and adding **four 301 redirects** (Redirection plugin) from the old slugs to the replacements.
9. **Cadence / timezone drift.** Batch 1's first three were scheduled at 14:00 UTC, everything after at 09:00, with the timezone initially unstated — a real "posts publish at different local times" risk that had to be flagged and standardized. (Note: no post is confirmed to have *auto-published instead of scheduling* — all batches verified as `status=future` — but the drift was a live hazard.)
10. **Stale skill/reference drift.** The brand reference file repeatedly fell out of sync with reality: a wrong product/price (Ring Air → Ring PRO, $479), and a "Dan does NOT use Pretty Links" rule that was later contradicted by the actual plugin list. The skill folder was also mounted read-only in several sessions, blocking direct edits and forcing workaround copies.
11. **Billing watch-items.** A social-automation tool (dlvr.it) defaulted to a paid 14-day Pro trial rather than the intended free tier — caught and flagged for manual downgrade.

The through-line: most rework came from **overconfidence** (confident-but-wrong links, IDs, prices) and from **environment limits** (context windows, session/usage caps, parallelism crashing the app). Verification wasn't optional overhead — it was the job.

---

## 5. Cost vs. return

| Metric | Result |
|---|---|
| Approx. project spend | ~$300 |
| Affiliate earnings | $4.08 |
| Net result | −$295.92 |
| Revenue recovered | ~1.36% of spend |
| Break-even gap | ~73.5× more revenue needed just to recover costs |

Spend covered hosting, domain, and tooling across the ~9-week run. Earnings came from the AWIN + Amazon links across the catalog. The gap isn't a "ramp" problem you grow out of next month — it's the difference between *building the machine* (which AI did well) and *creating demand* (which it can't).

---

## 6. What the data shows

- **The pipeline is real.** A non-programmer can stand up an AI-assisted research → draft → image → schedule → publish loop against a live WordPress site. That part worked repeatedly, across ~44 posts.
- **Affiliate approval is gateable and clustered.** AWIN approvals (Ultrahuman, BKWAT, Circular, Omni) came in bursts and rarely matched content readiness, creating ongoing link-maintenance work. Amazon links were trivial to add but never cleared a meaningful sales threshold.
- **Throughput was never the bottleneck.** Volume scaled fine in batches of 3–4; what didn't scale was authority, trust, and ranking — none of which the agent can manufacture.
- **Friction is the hidden cost.** Usage limits, context resets, classifier refusals, duplicate posts, and stale references each cost human time. Budget for rework, not just generation.
- **"Passive income" is the wrong frame.** Net −$295.92 over nine weeks, with real human hours throughout. The return on the experiment was the learning, not the money.

---

## 7. Data gaps & caveats

For completeness, things I could **not** substantiate from the record and chose not to invent:

- No AWIN account-creation, application-submission, or approval **dates**; no application fee; no decline outcomes (approvals are evidenced by "I was accepted" notes, not dated correspondence).
- No Amazon Associates signup date, store-ID creation date, current 180-day-rule standing, or influencer-program enrollment (only that `amzn.to` links are in active use).
- No precise per-session or total **run times** — all time figures here are estimates from sprint sizes and initiation dates.
- No confirmed instance of a post auto-publishing due to a timezone bug; the documented timezone issue is cadence drift only.

*All figures current as of June 2026. Account identifiers intentionally redacted.*
