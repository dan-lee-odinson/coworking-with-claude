# next-pass-skill

The Claude Cowork **Skill** I used to build and ship my first app — **Next Pass**, a Chrome extension that puts a glanceable countdown to the next visible ISS pass in your toolbar — and the anonymized project summary behind it.

This is the companion to **Project 3** in the main [coworking-with-claude](../) README. If the smart-ring-blog skill was about running an automated *content* pipeline, this one is about building and shipping *software* — from a one-sentence idea all the way to a published Chrome Web Store listing.

## What a "Skill" is (for anyone new to this)

A Skill is a reusable bundle of instructions and reference files that Claude loads at the start of a task, so it doesn't have to re-learn the project every session. Instead of re-explaining "here's how we build, test, and ship an app" in every chat, the rules live in one place and Claude picks them up automatically. Building a Skill once keeps each conversation short and consistent — Claude can even scaffold one for you, which is exactly how this was made.

## Why this skill exists

Shipping software has a lot of moving parts that have nothing to do with writing code: scoping the idea, building in testable steps, debugging by actually using the thing, packaging it, writing a privacy policy, getting through store review, and surviving a public launch. Working through an AI partner as a non-programmer, I needed guardrails so each of those parts stayed honest and happened in the right order. This skill encodes the method that worked, so the *next* app is faster.

The core principle it's built around: **Claude writes the code; I scope it, test it, and own what ships.**

## What's in this folder

| File | What it is |
|---|---|
| `SKILL.md` | The skill itself — the reusable workflow, the non-negotiable rules (scope, sprints, test-by-using, verify-your-claims, never-hardcode-secrets, anonymize), and pointers to the references. |
| `PROJECT-SUMMARY.md` | The worked example — a plain-language, step-by-step account of how Next Pass actually went from idea to published extension. Read this for the concrete story; read `SKILL.md` for the repeatable method. |
| `references/store-submission.md` | The full Chrome Web Store packaging + submission checklist, and the common rejection causes it heads off. |
| `references/placeholders.md` | What to anonymize before anything goes public, and the safe placeholder values to use. |

## How to use it

- **In Cowork:** drop this folder into your skills directory. It triggers when you ask to build an app or extension, scope an idea, test/debug an extension, package something for the Chrome Web Store, or work on Next Pass — even without naming it.
- **As a reference:** you don't have to install it. `PROJECT-SUMMARY.md` reads fine on its own as a "how I shipped an app with AI" walkthrough, and the references work as standalone checklists.
- **For your own app:** swap the Next Pass specifics (ISS, the satellite API, space communities) for your app's domain, but keep the structure and the rules — they're general.

## A note on anonymization

Like the smart-ring-blog skill, anything that could be a working credential or a spam magnet is scrubbed: support email, developer account, the published extension ID, repo owner, launch handle, and — most importantly — API keys, which never belong in a repo at all. `references/placeholders.md` lists exactly what gets replaced and with what. The material stays useful as a template; it just doesn't leak anything live.

## What I learned building it

The short version (the long version is Project 3 in the main README):

- **You set the scope; the AI fills it.** Deciding what *not* to build is the most important call.
- **Build in small, testable sprints.** One change at a time means a break is always traceable.
- **Test by using, not by reading.** Clicking through everything is how a non-programmer catches the bugs that matter.
- **Verify the agent's claims.** Confident wording isn't proof — check the live thing with your own eyes.
- **Shipping is its own skill.** Packaging, privacy policy, store assets, and review are the real last mile.
- **A public launch isn't a warm welcome.** Keep the useful feedback; let the noise go.
