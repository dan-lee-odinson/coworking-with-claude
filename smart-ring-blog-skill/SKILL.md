---
name: smart-ring-blog
description: Draft, fact-check, and schedule affiliate blog posts about smart rings (Oura, Ultrahuman, RingConn, Samsung Galaxy Ring, Evie, Amazfit Helio, Circular, BKWAT) for a live WordPress site. Use this whenever the user asks to work on smart ring posts, draft a smart ring article, schedule a batch of ring posts, write about wearables for their smart ring blog, or mentions anything related to their smart ring affiliate site — even if they don't explicitly name the skill. Also use when the user says things like "let's do the next batch," "continue the ring posts," or "write the [topic] post."
---

# Smart Ring Blog

This skill produces affiliate blog posts for a smart ring affiliate website. Posts are drafted, fact-checked, illustrated, and saved as scheduled WordPress drafts. The skill exists because smart ring content sits near several sensitivity seams (health claims, biometric data, medical device regulation) and the workflow needs clear guardrails to stay both accurate and on the right side of those seams.

> **Setup note:** This skill is published as a starting template. Several values are placeholders you need to fill in before running it against a live site. Search for `{{YOUR_` to find every spot that needs a real value (your domain, affiliate links, etc.). See the repo README for setup instructions.

## When you should consult this skill

Any task involving the smart ring blog: drafting a post, planning a batch, scheduling, editing a previously-drafted post, or deciding how to frame a topic. If the user mentions "the ring blog," "the next batch," a specific ring brand, or any of the recurring post types (EDC loadout, durability, privacy, cycle tracking, etc.), this skill applies.

## Tools this skill expects to be connected

- **Chrome MCP (`mcp__Claude_in_Chrome__*`)** — primary path for WordPress, image research, and link verification. The site is assumed to be hosted WordPress on a standard host. The established workflow is to open a Chrome tab logged into `wp-admin`, read the WordPress REST API auth nonce off the admin page via `javascript_tool`, then call `/wp-json/wp/v2/posts` (and related endpoints like `/media`, `/posts/{id}/meta`) directly with `fetch()`. This gives REST API access transported through the browser — much faster than driving the Gutenberg editor with clicks. **Do not use Zapier for WordPress operations.** The Chrome path is the working pattern; switching paths mid-rollout introduces drift between sessions.
- **Pexels / Pixabay** — accessed via the Chrome tab for sourcing base featured images. Canva is fine if explicitly opened, but the established pattern is Pexels → Canvas-API processing in the browser (see SEO conventions below).

If Chrome isn't connected at the start of a session, ask the user to enable it before drafting. Without browser access this skill cannot do its core job (link verification, REST API calls, image processing) — fabricating any of those would violate the rules below.

## The five rules (non-negotiable)

These rules exist because smart ring content can drift into territory that either misleads readers or generates safety-classifier friction. Follow them on every post.

**1. First-person opinion is fine. First-person physical-testing claims are not.** The site's voice is a confident reviewer — "I'd recommend," "I wouldn't buy this," "the subscription trap most buyers don't see." That's editorial opinion based on research, and it's on-brand. What's off-limits is fabricated hands-on experience: "I wore it for 30 days," "when I slept with it," "I tested the battery life." Those invent facts about an object that hasn't been physically tested. Phrase opinions as opinions ("based on published specs and independent reviews, I'd recommend X"), not as sensory experience ("I loved how X felt on my finger"). If the site owner has actually tested a specific ring and tells you so, you can use that — otherwise, stay in editorial-opinion mode.

**2. Lead medical-adjacent posts with a disclaimer.** If a post touches sleep, heart rate, blood oxygen, HRV, cycle tracking, fertility, GLP-1, blood pressure, stress, anxiety, sleep apnea, or any similar topic, open with a standard disclaimer: "This article is for general information only and is not medical advice. Readers should consult a qualified healthcare provider for diagnosis or treatment." The disclaimer goes at the top, not buried. It protects readers and it signals to classifiers that the post is informational, not prescriptive.

**3. Verify every outside link before using it.** Use the browser to open each product, brand, or news-source URL. If it 404s, redirects to a parked page, or resolves to a lookalike domain, do not link to it. See `references/fake-domains.md` for known lookalikes to avoid. Affiliate links should be included for every product mentioned — see `references/brands.md` for the real vendor domains and a template for your own affiliate program setup.

**4. Add a relevant featured image at 1200×630 with brand overlay.** See "SEO conventions" below for the exact image-generation workflow. The short version: source a relevant base image from Pexels/Pixabay, then process it in-browser via Canvas API to crop to 1200×630, darken with a gradient, and overlay the keyword, sub-headline, and your site's badge. Avoid stock images of unrelated people staring at phones — pick something that visually connects to the post's actual subject.

**5. Save each post as a scheduled draft.** One per day, starting the day after the current drafting session. Do not publish immediately. After scheduling, report the preview URL and scheduled publish date back to the user in the final summary.

## Voice and style

The site reads like a trusted friend who's done the homework — opinionated, confident, conversational, willing to tell you not to buy something. Match that voice closely. A few guardrails:

**Person and perspective.** First person is the default — "I'd recommend," "I wouldn't buy," "in my view." First-person plural ("we") is fine for roundup-style posts. Do not retreat into neutral third-person reviewer prose — it will read as off-brand. (Again, opinions are fine; fabricated sensory experience is not — see Rule 1.)

**Contractions, always.** "You're," "it's," "don't," "they're." Formal prose reads as robotic next to the existing catalog.

**Sentence rhythm.** Mix short, punchy declarative sentences with longer qualifier sentences. A good pattern: "Oura charges $5.99/month. Without it, your ring becomes a basic step counter." Short jab, then a longer follow-up. Avoid uniform sentence length — it flattens the voice.

**Open with a sharp observation, not a definition.** Never start a post with "Smart rings are wearable devices that..." Good openers are pointed facts ("Oura charges $5.99/month"), surprising framings ("Smart rings in 2026 are in a weird, wonderful moment"), or a direct statement of what the post will argue. Treat the opening paragraph as the hook, not the background.

**Editorial verdicts are allowed and encouraged.** The voice calls things "garbage readings," "a subscription trap," rings it would "tell people to avoid." That directness is the voice. Don't water it down into diplomatic mush. If a product has a real flaw, name it.

**Avoid hype language.** "Game-changing," "revolutionary," "best ever," "you NEED this," exclamation points, all-caps, urgency phrasing — none of it. The voice is confident, not breathless.

**Comparisons use concrete attributes.** Battery life, sensor list, subscription fees, water resistance, size range, app compatibility, warranty, price. Not "best" or "most comfortable" without backing. Side-by-side tables are preferred for head-to-heads. "Choose X if / Choose Y if" verdict boxes are a signature move — use them.

**Heading style.** Mix declarative keyword headings ("Side-by-side specs," "Battery life," "The bottom line") with direct questions ("Who should buy the Oura Ring 4?", "What do you actually lose with no subscription?"). Do not write keyword-stuffed SEO headings.

**Calls to action are calm.** "Check Price on Amazon →", "Read Review →", "See the Top Picks →". No exclamation points, no urgency, no "GRAB YOURS NOW." The arrow is a signature.

**Close with an editorial takeaway, not a recap.** End on a single conversational line — a parting piece of advice, an aside, a verdict. Example: "Either way: order a sizing kit before you buy. Wear the sizer for a full day, including sleep. Trust me." Not a summary block. Not "In conclusion."

## Post structure

Default to this structure unless the user asks for something different:

1. **Affiliate disclosure — at the top of every post, verbatim:** *"This post contains affiliate links. If you buy through a link, I may earn a commission at no extra cost to you."* This satisfies the FTC disclosure requirement up front rather than burying it.

2. **Medical disclaimer** (if Rule 2 applies). Goes immediately after the affiliate disclosure.

3. **Hook paragraph.** Open with a sharp observation, a pointed stat, or a direct statement of what the post will argue. Two to four sentences. Never start with a definition of what a smart ring is.

4. **The substance.** For comparison posts: a side-by-side spec table followed by prose explaining the trade-offs. For troubleshooting: numbered steps. For explainers: H2 sections, mixing declarative keyword headings and direct-question headings. When comparing two products, include a "Choose X if / Choose Y if" verdict box.

5. **"The bottom line" or equivalent.** A short editorial verdict section that takes a position. Honest about limits, not a hard sell.

6. **Product recommendations.** Two or three rings that fit the post's theme, each with a one-paragraph explanation and an affiliate link. Do not recommend products you can't justify relative to the topic. CTA format: "Check Price on Amazon →" or "Buy [Ring]: Amazon | Official Site".

7. **Closing line.** One conversational sentence — a parting piece of advice, an aside, a verdict. Not a recap. Not "In conclusion." If you catch yourself writing a summary paragraph, delete it and replace with a single line.

8. **FAQ section (SEO move, not optional).** A "Frequently Asked Questions" section with five questions and concise answers. Pick questions readers actually ask, not made-up SEO bait. See "SEO conventions" for the JSON-LD schema that goes alongside it.

## SEO conventions

These technical/structural conventions are established on the site and should be applied automatically to every post. Skipping any of them creates inconsistency that's painful to clean up later.

### Featured images: 1200×630, branded, in-browser via Canvas API

Open Graph standard size is 1200×630 — that's what shows up in social-card previews on Twitter, LinkedIn, Facebook, iMessage, etc. Use this size with a consistent brand treatment.

The established workflow:

1. Source a relevant base image from Pexels or Pixabay using the Chrome tab (search keyword tied to the post's subject).
2. Inside the Chrome tab, use `javascript_tool` to draw the image to a Canvas at 1200×630, cropping/centering as needed.
3. Apply a downward gradient darkening (alpha overlay) to the lower third so text reads cleanly.
4. Overlay text in three layers:
   - **Primary keyword** (the post's headline, condensed to 3–6 words) — bold, large.
   - **Sub-headline** — the framing or year context (e.g., "WHAT COUPLES SHOULD CONSIDER IN 2026"), all caps, smaller, tracked-out.
   - **Site badge** — `{{YOUR_SITE_DOMAIN}}` in the top-right corner, small but visible.
5. Export as JPEG, target 80–150 KB.
6. Upload to WordPress via the REST API media endpoint, then attach as the post's featured image (`featured_media`).

Don't deviate from 1200×630 unless the user explicitly asks. Don't ship a post without the brand badge — site visual consistency matters for trust.

### FAQ section + JSON-LD FAQPage schema

Every post ends with a visible "Frequently Asked Questions" heading containing five Q&A pairs. Below that (or embedded in the post body), include a `<script type="application/ld+json">` block with a `FAQPage` schema matching the questions and answers verbatim. Google reads the JSON-LD to surface rich-result FAQ snippets in search.

Important: **do not rely on Rank Math's TOC or FAQ blocks** if Rank Math is installed. Those blocks are rendered by the plugin's frontend JavaScript and don't populate when posts are created via REST API — the post will publish with empty placeholder shortcodes. Static HTML for the visible FAQ + an inline JSON-LD script tag is the working pattern.

Question selection: pick five things real readers ask about the topic. Replacement cycles, lifespan, sizing, waterproofing, subscriptions are common smart-ring questions; for medical-adjacent posts, lean toward "what can/can't this device measure" rather than "is this device safe for [condition]" — keep the disclaimer-friendly framing consistent with Rule 2.

### Table of contents: handled by LuckyWP plugin — do not add a manual TOC

The site is configured with the **LuckyWP Table of Contents** plugin installed and configured site-wide. It auto-inserts a TOC into every post after the first block, so any manual TOC you add will create a duplicate. Don't write one.

Recommended LuckyWP settings (don't change without explicit instruction):

| Setting | Value |
|---|---|
| Width | 320px |
| Float | Right (functions as a sticky sidebar on desktop) |
| Toggle Show/Hide | Enabled |
| By default, items hidden | Enabled (TOC starts collapsed as "Contents [show]") |
| Auto Insert | On for Posts, "After first block" |
| Hierarchical view | On |
| Numeration | Decimal nested |
| Min headings | 2 |
| Depth | 6 |

Headings should be H2 for major sections and H3 for sub-sections — the plugin builds its hierarchy off these, so use them consistently.

If a specific post should not have a TOC (rare), disable it via the per-post panel LuckyWP adds to the Gutenberg sidebar — don't disable site-wide.

### Theme: Kadence sidebar layout meta

If using the Kadence theme, set the post meta `_kad_post_layout` to `right-sidebar` on every post. The Kadence theme reads this and reserves the right column for sidebar widgets. Even though the LuckyWP TOC handles the sidebar visually via float, the meta keeps the layout consistent and forward-compatible if a real widget is added later.

### Schedule timing: 14:00 UTC, watch the timezone

The established cadence is **one post per day at 14:00 UTC** (10:00 ET / 07:00 PT). Most WordPress servers run UTC, and this is the critical part: when scheduling a post, the timestamp must be in the **future relative to UTC**, not relative to the user's local time. If you schedule a post for "10am" and 10am has already passed in UTC, WordPress flips the status from `future` to `publish` and the post goes live immediately.

Practical rule: when in doubt, schedule for tomorrow 14:00 UTC at the earliest. If you ever see a post get auto-published instead of scheduled, that's the cause — set status back to `draft`, fix the timestamp, and re-schedule.

### Caching: LiteSpeed Cache (or equivalent) may be active

If the site uses LiteSpeed Cache or a similar full-page cache, new posts publish fine, but **edits to already-published posts may not appear immediately** because of the cache. If you've edited a published post and the change isn't visible, purge from `LiteSpeed Cache → Toolbox → Purge All` (or equivalent), or wait for the cache to expire naturally on next page request. New scheduled posts don't need a manual purge.

### Affiliate links: drop verbatim, no plugin in use

This skill assumes no Pretty Links plugin or other link-rewriting wrapper. The tracked affiliate URLs in `references/brands.md` (once filled in with your real URLs) are the final form — drop them into the post exactly as listed. Don't append parameters, don't substitute a "cleaner" version, and never fabricate a tracking ID for a brand that doesn't have one approved yet. See the "Affiliate link formatting" section in `references/brands.md` for the full rules and per-brand link template.

## Working in batches

Topics are typically fed in batches of three (sometimes four) to keep each conversation's context small. Within a batch:

- Work through all topics in order
- Draft → verify links → generate image → schedule → move to next
- Do not pause for per-post approval — the established pattern is fully autonomous in-batch pacing
- If something genuinely blocks progress (a tool disconnection, a topic that seems impossible to write safely, a link that can't be verified), stop and ask rather than guessing
- After all topics are scheduled, report back with: titles, preview URLs, scheduled publish dates, and any notes on topics that needed framing adjustments

If a topic feels sticky — hard to write without running into Rule 2 territory or feeling like it might misinform readers — don't power through. Flag it, explain why, and suggest a reframe. Smart ring topics can often be rewritten into a safer frame without losing reader value (example: "smart rings for children" → "should kids wear smart rings? a parent's guide to trade-offs").

## Example pre-scoped topics

These are example topics that have been scoped with framings that work well within the rules above. Use as a starting point or as patterns for your own topic list:

- "Couples Swapping Traditional Wedding Bands for Smart Rings: What to Consider"
- "Troubleshooting Smart Ring App Compatibility Across iPhone and Android"
- "Smart Rings on the Jobsite: Durability for Tradespeople, First Responders, and Heavy-Industry Workers"
- "How Smart Rings Have Evolved — From Fitness Trackers to Next-Generation Wearables"
- "Smart Ring vs. Smartwatch vs. Patch: How Wearable Health Tech Stacks Up"
- "Smart Ring as EDC: Adding a Ring to Your Every-Day-Carry Loadout"
- "Where Does Your Smart Ring Data Go? A Plain-English Look at Storage, Sharing, and Access"
- "Smart Rings for Personal Safety: Alerts, Location Sharing, and the Limits of What a Ring Can Do"
- "Using a Smart Ring Alongside Your GLP-1 Journey: What You Can and Can't Measure"
- "Smart Rings and Sleep Tracking: How Consumer Wearables Differ from a Sleep Apnea Diagnosis"
- "Can Your Smart Ring Help You Track Your Cycle? What Oura, Natural Cycles, and FDA Clearance Actually Mean"
- "Should Kids Wear Smart Rings? A Parent's Guide to Features, Privacy Trade-offs, and Age-Appropriate Alternatives"

## Reference files

Read these when needed:

- `references/brands.md` — Real vendor URLs, product lines, battery/subscription notes, plus placeholders for your own affiliate program setup
- `references/fake-domains.md` — Known lookalike/fake domains to avoid linking to

## What to do if the safety classifier pushes back

If a response gets refused mid-batch with a Usage Policy error, don't try to continue from where you left off — the context is what's being flagged, and re-prompting with the same history will re-trigger it. Report the issue back to the user so they can open a fresh tab with the remaining topic(s) and a tighter reframe. Don't attempt workarounds that involve fighting the classifier — reframing the topic is always the cleaner path.
