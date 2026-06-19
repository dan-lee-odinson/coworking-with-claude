# coworking-with-claude
A running log of what I've learned working with Claude Cowork framed around the projects I've actually built.

# Coworking with Claude — Learning by Project Creation

A running log of what I've learned working with Claude Cowork, framed around the projects I've actually built. I'm not a programmer by background. I started with a small one-off task to see what the agent could do, then graduated to a full automated publishing pipeline. Each project taught me something I wish I'd known going in.

This README is meant for anyone in the same position — interested in AI agents, not a developer, learning by doing.

---

## TL;DR

Thirteen things I've learned so far:

1. **Pick a small, recoverable first project.** You will learn more from one mistake you can roll back than from a week of reading guides.
2. **Verify everything before you act on it** — especially links, file paths, and any system-level command. Confident phrasing is not evidence of correctness.
3. **Create a Windows System Restore point** (or equivalent backup) before letting Claude modify settings, registry keys, or services. It saved me from a full reinstall.
4. **Be specific in your prompts.** Break the goal into concrete sub-questions and Claude returns concrete artifacts.
5. **Build a Skill for any recurring project.** It pre-loads context, keeps your chat thread short, and stops Claude from re-learning the basics every session.
6. **Specify the tools to use and make sure Claude has permissions to use them.** Tell Claude to "Access Chrome" to use "REST API" rather than just "upload post to website" - it will try every tool in its toolbox and often choose the hardest unless told otherwise.
7. **Batch autonomous work.** Asking for "10 things at once" crashes the desktop app. Batches of 3–4 run reliably.
8. **Don't use Claude for image generation.** Use a dedicated image model and bring the result back in.
9.  **AI can help you build the machine, but it does not create demand.** Claude helped me research, draft, format, publish, and manage a working affiliate site, but traffic, trust, ranking, and conversions still had to be earned.
10. **“Passive income with AI” is a misleading frame.** This project was not passive. I spent significant time reviewing outputs, debugging issues, setting up accounts, managing WordPress, configuring hosting, checking links, and correcting mistakes.
11. **Product and niche selection matter more than content volume.** A smart ring affiliate site sounded narrow and monetizable, but choosing the right products, programs, buyer intent, commission structure, and competitive angle required far more research than the hype suggests.
12. **Revenue takes longer than the AI-content narrative implies.** My approximate spend was $300, while affiliate earnings were $4.08. That does not prove the model can never work, but it does show that profitability is not automatic, immediate, or guaranteed just because AI can produce the site.
13. **Treat AI side projects as experiments first, businesses second.** The most valuable result was not affiliate income; it was learning how to manage an agentic AI workflow, test automation claims against reality, and document what worked, what failed, and what still required human judgment.


The rest of this README walks through how I learned each of these by building two projects.

---

## Project 1 — Computer Optimization (My "One Small Step")

**Goal:** ask Claude to optimize my Windows machine's GPU performance for gaming and AI workloads.

**Why this was a good first project:** it had a clear, measurable outcome (frame rates, AI inference speed), it fit inside a single session, and it forced me to actually act on Claude's recommendations — which is where the real lessons live.

**What happened:** Claude returned a sensible-looking checklist. Most of it was solid:

- Update graphics drivers
- Enable GPU overclocking
- Set the Windows performance profile to Gaming
- A few registry and power-plan tweaks

Then it recommended disabling Hyper-V and the Windows Hypervisor entirely. I did a quick search, found articles confirming that hypervisor features can cost some GPU performance, and ran the elevated commands Claude provided.

Cowork stopped launching.

It turns out **Cowork itself runs in a virtualized environment**, so disabling the hypervisor broke the very tool that had given me the advice. I rolled back via a Windows System Restore point, reported the error to Claude, and got an "oops, I overlooked that" acknowledgement.

### Lessons from Project 1

**Verify system-level commands before running them.** Cross-check against an independent source, and create a Windows System Restore point first. Treat AI advice on system internals the way you'd treat advice from a stranger on a forum — sometimes great, sometimes catastrophic.

**LLMs hallucinate, including Claude.** Confident phrasing is not evidence. The hypervisor recommendation was delivered with the same tone as the (correct) driver-update advice. You cannot tell them apart from tone alone.

**Backups are not optional.** A System Restore point takes 30 seconds and saved me an entire reinstall. Do this before any task where Claude will modify settings, registry keys, or system services.

**A small, contained "first project" is worth doing on purpose.** I learned more about how to work with Claude from breaking my own machine than I would have from reading any guide. Pick something where the blast radius is recoverable.

---

## Project 2 — Smart Ring Affiliate Blog (My "[Skateboard](https://medium.com/@byrnereese/the-skateboard-mindset-in-product-development-ddf3409d5e98) Project") 

**Live Project:** [Smart Rings Reviews](https://www.smartringsreviews.com)

**Goal:** an automated affiliate marketing blog covering smart rings (Oura, Ultrahuman, RingConn, Samsung Galaxy Ring, Evie, Amazfit Helio, Circular, BKWAT). Posts are researched, drafted, SEO-optimized, and scheduled to a live WordPress site without me writing each one by hand.

**Why this was the right second project:** it stretched into territory the first one didn't — multi-step workflows, recurring tasks, autonomous execution, integration with a live external system (WordPress). It forced me to learn how to give Claude *durable* context, not just a one-off prompt. I also want to explore the potential for passive income generation using Claude as an agent.

> 📊 **Detailed build log & data:** This section is the story; the receipts live in the [**Project 2 Detailed Summary**](./smart-ring-blog-skill/PROJECT-SUMMARY.md) inside the [`smart-ring-blog-skill`](./smart-ring-blog-skill) folder. It documents the AWIN and Amazon affiliate **application and acceptance** process, the post-by-post **publishing sprints** with time-spent estimates, a full **operational friction log** (errors, usage limits, context resets, duplicate posts and the redirects that fixed them), and the complete **cost-vs-ROI** breakdown. Account identifiers are anonymized.

### The Stack

- **Claude Cowork** — orchestrates research, writing, and scheduling
- **Custom skill** (`smart-ring-blog`) — pre-loaded prompt, workflow, and reference material for end-to-end post creation
- **WordPress** — live site where posts are scheduled and published via the REST API
- **Web search + product research** — for keyword targeting, spec verification, and affiliate links

### What works today

The skill drafts a research-backed post, formats it for WordPress, applies basic SEO, and schedules it for publication — end to end, hands-off — as long as I batch the work properly.

### Lessons from Project 2

#### Be specific in your prompts

Vague prompts produce vague results. Break the objective into concrete sub-questions before sending it to Claude.

❌ **Don't:**

```
I want to see if I can sell widgets. Show me the best way to sell widgets.
```

✅ **Do:**

```
Research trending searches for widgets to determine if there is demand for the product.

Identify the most popular platforms and methods for selling widgets online.

Produce a list of steps for setting up a widget-selling business.

Estimate startup cost and a realistic ROI timeline for my investment.
```

The second version forces Claude to give you research, options, and a plan — three different artifacts you can act on.

#### Verify generated links

When I asked Claude to write a post and include product links without specifying which URLs to use, it produced confident-looking links that 404'd on the brand sites or pointed to unrelated pages. Fix: always supply the canonical product URLs yourself, or have Claude verify each link with a web fetch before publishing. (This is the same hallucination pattern as Project 1 — just with URLs instead of system commands.)

#### Use a Skill to pre-load context for ongoing projects

By default, every Cowork task starts fresh. You can grant access to past logs, but re-reading them costs context and slows responses.

A **Skill** is a reusable bundle of instructions, steps, and reference files that Claude loads at the start of a task. For a recurring project like a blog with a defined voice, structure, and publishing workflow, building a Skill once means Claude doesn't re-learn the basics every session. Claude can help you author one — just ask.

The `smart-ring-blog` skill in this project handles research, drafting, scheduling, and SEO in a single invocation.

**Why this matters:** keeping all your project's instructions in one growing chat thread means each new prompt re-sends the entire conversation history to the model. Responses get slower and you eventually hit the context window limit. A Skill keeps the working context tight.

#### Batch autonomous work — don't ask for everything at once

When I tell Claude to "create and post 10 scheduled blog posts," it tries to do all 10 in parallel. The desktop app spawns concurrent browser sessions, file writes, and WordPress API calls — and on my machine that reliably overwhelms the local environment and crashes Cowork.

Splitting the same job into batches of 3–4 works every time. Claude completes one batch fully (research → draft → schedule → SEO), then moves to the next.

**Pattern that works:**

```
Use the smart-ring-blog skill to create and schedule the next 3 posts.
When that batch is complete, continue with the next 3.
```

The same logic applies to any multi-step process. Telling Claude to do everything simultaneously can cause later steps to undo the work of earlier ones.

#### Claude is not the right tool for image generation

I enabled the design skill, brand skill, and every image-related skill I could find. When I asked Claude to create a featured image for a blog post, the first attempt produced an image of *text about* the subject. The second attempt, after detailed art direction, produced a flat, generic image that didn't fit the blog. For now I generate featured images in a dedicated image model and bring them in manually. If you're building a similar pipeline, plan around that gap.

---

## How the Two Projects Connect

The Project 1 lessons are about **trust** — verify before you act, back up before you change anything, don't confuse confidence with correctness.

The Project 2 lessons are about **scale** — once you trust the agent, how do you give it durable context, how do you keep it from overwhelming itself, and where does it still fall short?

You really do need the first set before the second set is useful.

---

## A Note on How "Memory" Actually Works

A clarification for anyone newer to LLMs than I was: Claude's model doesn't run on your computer's GPU. Inference happens on Anthropic's servers. Two things really are happening locally:

1. **Context window growth** — every prompt re-sends the whole conversation, so longer threads = slower responses and eventually hard limits. This is what Skills help with.
2. **Local tool execution** — when Cowork runs browsers, writes files, or hits APIs, that load is on your machine. Parallel runs of those tools is what crashed my app, not "the AI" itself.

Knowing the difference makes it easier to know which lever to pull when something feels slow or unstable.

---

## Recommended Setup if You Want to Try Something Similar

- Claude Cowork installed on a machine with headroom for parallel browser automation (16GB RAM is the minimum I'd recommend, I upgraded to 64GB)
- A Windows System Restore point taken **before** running any system-level commands Claude suggests
- For a publishing pipeline: a WordPress site with the REST API enabled and an application password configured
- A custom Skill (Claude can scaffold one for you) that encodes your project's voice, structure, and rules
- A separate image generation tool if your project needs visuals

### Final Results — June 2026 Closeout

This project began as a practical test of the claim that AI agents can create meaningful “passive income” through affiliate marketing with minimal human effort.

The site was successfully built and published. Claude Cowork helped create a repeatable workflow for research, drafting, SEO formatting, WordPress publishing, and post scheduling. The technical experiment worked: an AI-assisted publishing pipeline can be created by a non-programmer with enough prompting, verification, and manual oversight.

The business experiment did not validate the passive-income claim.

Approximate results:

- Spend: ~$300
- Affiliate earnings: $4.08
- Net result: -$295.92
- Revenue recovered: ~1.36% of spend
- Break-even gap: earnings would have needed to be roughly 73.5x higher just to recover costs

The biggest lesson: AI reduced some production friction, but it did not remove the hard parts of affiliate marketing. Product selection, niche research, trust-building, SEO authority, affiliate program quality, account setup, compliance, debugging, hosting, analytics, and human review still required substantial time.

Conclusion: Agentic AI is useful as a workflow accelerator, but “AI passive income” is a misleading frame. This was not passive income; it was an AI-assisted small publishing business experiment.

> 📄 **Want the granular version?** Every number behind this closeout — affiliate approvals (AWIN: Ultrahuman, BKWAT, Circular, Omni Health Ring; plus Amazon Associates), the sprint-by-sprint schedule, estimated time spent, and the full log of errors, usage limits, and restarts — is documented in the [**Project 2 Detailed Summary**](./smart-ring-blog-skill/PROJECT-SUMMARY.md).

---

## Next Project Ideas

Things I'm considering as the next progression:

- A scheduled daily-briefing skill that pulls news in topics I follow (space launches, robotics, sci-fi releases) and summarizes them
- Designing and building a small app from scratch with Claude — taking it through the full cycle of prototype, test, package, and deploy — to learn what "shipping software" actually involves
- Building a small custom MCP server so Cowork can talk to a tool I write myself

Each of these is one step further out — more autonomy, more integration, more places where Project 1's "verify everything" lesson keeps mattering.
