# smart-ring-blog (Claude Skill)

A Claude Cowork **Skill** that drafts, fact-checks, illustrates, and schedules affiliate blog posts about smart rings (Oura, Ultrahuman, RingConn, Samsung Galaxy Ring, Evie, Amazfit Helio, Circular, BKWAT) to a live WordPress site. Originally built and run against a real affiliate site — published here as a starting template anyone can fork and adapt.

## What this Skill does

When invoked in a Claude Cowork session, it autonomously:

1. Drafts a blog post in a defined editorial voice
2. Verifies every outside link in a real browser before using it
3. Generates a 1200×630 branded featured image in-browser via the Canvas API
4. Uploads the image to WordPress and attaches it as the featured media
5. Schedules the post as a future-dated draft (one per day at 14:00 UTC by default)
6. Reports back with titles, preview URLs, and scheduled publish dates

It also enforces five non-negotiable rules around health-claim language, medical disclaimers, hands-on-testing claims, link verification, and scheduled-draft (not immediate publish) behavior.

## Why publish it

Most public Claude skills focus on developer workflows. This one is built around a non-developer's project — a real affiliate blog — and might be useful as:

- A template for anyone running a niche affiliate site who wants to automate post production
- A worked example of what a non-trivial Cowork skill looks like (rules, references, voice guide, structural conventions)
- Reference reading for thinking about how to encode editorial guardrails into agent workflows

## Repo contents

```
smart-ring-blog-skill/
├── SKILL.md                  # The main skill file (instructions for Claude)
├── references/
│   ├── brands.md             # Per-brand vendor info and affiliate-link placeholders
│   └── fake-domains.md       # Known lookalike domains to avoid linking to
├── README.md                 # This file
└── LICENSE                   # MIT
```

## Setup if you want to use it on your own site

This skill is published with **placeholders** instead of live affiliate links and personal details. You'll need to fill those in before running it against your own WordPress site.

### 1. Find every placeholder

Search the repo for `{{YOUR_` to find every spot that needs a real value. The main ones:

- `{{YOUR_SITE_DOMAIN}}` — your blog's domain (used in the featured-image branding badge)
- `{{YOUR_OURA_AFFILIATE_LINK}}`, `{{YOUR_ULTRAHUMAN_AWIN_LINK}}`, etc. — your tracked affiliate URLs for each brand

### 2. Set up your affiliate accounts

You'll need accounts with whichever programs cover the brands you want to recommend:

- **Amazon Associates** — easiest to start with; covers most brands
- **Awin** — used by several smart ring brands directly (Ultrahuman, Circular, BKWAT)
- **ShareASale / Impact** — alternative networks used by some brands
- Brand-direct programs (Oura, Samsung) where available

Fill in each `{{YOUR_*_LINK}}` placeholder in `references/brands.md` with the real tracking URL once you have it. Leave a placeholder in place if a program is still pending — the skill will flag it during drafting.

### 3. Set up your WordPress site

The skill assumes:

- A WordPress site you own with the REST API enabled
- An admin user account you can log into in Chrome
- (Recommended) the **LuckyWP Table of Contents** plugin installed
- (Optional) the **Kadence** theme — the skill sets a Kadence-specific layout meta on each post; harmless if not using Kadence

### 4. Install the skill in Claude Cowork

Drop the entire folder (`smart-ring-blog-skill/`) into your Cowork skills directory. Claude will pick it up automatically when you mention smart ring posts.

### 5. Connect the Chrome MCP

The skill uses the Chrome MCP (`mcp__Claude_in_Chrome__*`) to drive WordPress, source images from Pexels/Pixabay, and verify outside links. Install the Chrome extension from the Cowork settings before running a batch.

## How to invoke it

Once installed and set up, just describe the work in natural language:

```
Use the smart-ring-blog skill to create and schedule the next 3 posts.
Topics: [topic 1], [topic 2], [topic 3]
```

Claude will draft, verify, illustrate, schedule, and report back. **Batch in groups of 3–4, not 10+** — running too many posts in parallel can overwhelm the local Cowork environment and crash the desktop app.

## What this Skill does *not* do

- It does NOT publish posts immediately — everything goes to scheduled-draft status by design (Rule 5).
- It does NOT fabricate hands-on testing claims, regardless of how natural the prose would feel (Rule 1).
- It does NOT generate featured images that "look professional" without the brand badge — visual consistency is non-negotiable.
- It is NOT a turnkey "give me a blog overnight" solution. It assumes you've done the affiliate-program setup and have an opinion about your editorial voice. The skill encodes one specific opinion; adapt it to yours.

## A note on Claude image generation

In the original project, Claude was tried for featured-image creation and the results were not usable (it produced images of *text about* the subject rather than relevant imagery). This skill works around that by sourcing base photos from Pexels/Pixabay and overlaying text on them via the Canvas API in the browser — not by asking Claude to generate the image. If you adapt this for a different niche, plan around the same limitation.

## License

[MIT](./LICENSE) — fork it, modify it, run it on your own site, ship a totally different version. Attribution appreciated but not required.

## Contributing

This was built as a personal-project artifact, not a community-maintained skill. Issues and PRs are welcome but response time is best-effort. If you fork it and build something interesting, I'd love to see it.
