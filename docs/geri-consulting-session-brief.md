# Geri Pocs — AI Consulting Side Hustle · Strategy Session Brief
*Drop this entire document into a fresh Opus 5 Cowork chat to begin.*
*Version 1.0 — August 12, 2026*

---

## What This Session Is For

This is a strategy + planning session for building a freelance AI consulting side hustle. The goal of this session is to produce:

1. **Locked positioning** — who exactly this is for, what problem it solves, how it's framed
2. **Service offering list** — a concrete, honest list of what can and cannot be delivered
3. **Portfolio snapshot** — value-driven one-liners and 3–5 bullet summaries of 3 reference projects
4. **Site architecture** — how many pages, what sections, what the flow looks like
5. **Build plan** — a phased, numbered plan (like the tools-build-plan.md that worked perfectly for the She Starts Over admin tools project) ready for a separate Cowork build session
6. **Copy direction** — tone, headlines, key messages for the service page

This session is **strategy only** — no code, no HTML. The output should be a set of locked documents that a separate build session can execute from without asking strategic questions.

---

## Who Geri Is

**Full name:** Gergely Pocs (goes by Geri)
**Location:** Amsterdam (or nearby), European timezone
**Day job:** Principal Tech Recruitment Consultant — strong consulting skills, client-facing, business acumen, high attention to detail, pattern recognition, ability to zoom in and out of complex problems quickly
**Relevant personality traits:** ADHD as a superpower (sees the big picture instantly, solves complex problems fast), calm under pressure, energetic, fun, caring, great listener, very strong communicator
**AI/tech background:** Self-taught. Has built 3 substantial AI-powered products from scratch using Claude (Anthropic's API), Supabase, Vercel, plain HTML/CSS/JS, and various third-party integrations. Does NOT have a software engineering background — works with AI as a collaborator and builder tool, not as a coder.
**Approach:** Idea → plan → execute loop. Strong on architecture and planning, uses AI to fill the execution gaps. Gets things done fast.

---

## The Idea

Geri wants to launch a **freelance AI solutions consulting service** targeting small business owners in Western Europe — primarily solopreneurs and 1–5 person businesses who are overwhelmed by the operational complexity of running their business and have no time, willingness, or budget to hire a developer or tech team.

**The core value proposition:** Geri acts as a calm, capable technical partner who understands both the business problem and the AI/tech solution — and can deliver custom-built systems fast, without the jargon or the price tag of a traditional software agency.

**Initial distribution channel:** Geri's wife runs an agency connecting service providers with small business owners, primarily solopreneur moms in West EU. This is the warm launch network. Geri will then self-promote via outreach, LinkedIn, and the service site itself.

**This is a side hustle** — Geri can commit 2–4 hours/day (mornings + evenings). He's fast, getting faster, and wants to take 1–3 projects per quarter initially.

---

## What He's Built (Reference Projects)

These 3 projects are the portfolio. Each should be framed as a **client case study** in the strategy output — outcome-led, not tech-led. Note: Urte (Geri's wife) is the "client" for She Starts Over; Life OS is a self-client project.

### 1. Epistemic — AI Learning Platform
**Live at:** `epistemic.live`

**What it is:** A personal learning platform that turns passive podcast listening into a structured, searchable knowledge library. Users save concepts from episodes they've listened to; the product helps them understand, practise, and apply those ideas — not just collect them.

**The problem it solves:** Podcast listeners absorb enormous amounts of high-quality thinking but retain almost none of it. Epistemic closes that gap: every episode becomes a curated set of concept cards, every idea becomes something the user can practise writing about, search across, and connect to other ideas they've saved.

**Major modules built:**
- **Content pipeline** — Custom extract tool: paste a transcript → Claude extracts concepts in a structured schema → human review → auto-publish to live site in ~30 seconds. Zero backend infrastructure beyond Vercel serverless and GitHub as a JSON database.
- **Concept cards + library** — Flipable cards with hook / plain English / analogy / Socratic prompt. Category filtering, full-text search, note-taking, inline concept detail with related-concept hover previews.
- **Spark panel** — AI-powered contextual writing coach. Given saved concepts as grounding, generates Socratic prompts, story seeds, and situational corner-case challenges. Practice mode for applying ideas, not just reading them.
- **Lexi / Vocabulary** — Passive vocabulary harvesting as users read. Personal lexicon with Claude-graded writing exercises: write a sentence using the word → AI verdict + feedback.
- **Spatial canvas / Boards** — Infinite-pan, pinch-to-zoom canvas per folder. Draggable concept cards with SVG bezier connection arrows, freeform notes, YouTube clip embeds, shareable board URLs.
- **Home dashboard** — Personal knowledge dashboard: concept count, weekly goal strip, 7-day activity chart, category donut, 52-week GitHub-style heatmap.
- **AI voice architecture** — Three-layer system: House Voice (brand style enforcement), User Voice Profile (5 learnable dials), concept grounding (~1,200 tokens, RAG-lite without embeddings). Powers Compose (6 output formats), Chat, and Practice grading.

**Scale:** 625+ curated concepts across 14 categories, 60+ episodes processed.

**Tech stack:** Vanilla HTML/CSS/JS, Vercel, GitHub as JSON database, Claude API (Sonnet), Airtable + GitHub Actions for editorial pipeline.

**Portfolio bullets (value-framed):**
- Turned passive listening into active retention — listeners who previously forgot 95% of what they heard now have a searchable, personalised library of ideas they can revisit, practise, and connect.
- Built a full AI editorial pipeline from scratch — transcript → Claude extraction → human review → auto-publish to live site in under 60 seconds, with zero traditional backend infrastructure.
- Shipped a production AI writing coach — Spark and Lexi use concept-grounded Claude sessions to grade writing, provide structured feedback, and coach application of ideas.
- Designed a knowledge OS, not just a reading app — spatial canvas boards, shareable URLs, cross-concept connection arrows, and a 52-week habit heatmap give users a complete personal knowledge management system.
- Scaled to 625+ curated concepts with zero database — fully editorial-quality content served as static JSON, deployable globally in 30 seconds.

---

### 2. Life OS — Personal & Family Operating System
**Live at:** `pocs.family` (private, Cloudflare-gated)
**Client:** Geri & Urte Pocs (self-client)

**What it is:** A custom-built family operating system — a unified web app replacing scattered spreadsheets, habit trackers, and notebooks across every domain of daily life. Six interconnected modules built around the specific realities of two people: an ADHD-wired founder and a solopreneur navigating medical treatment while building a business.

**The problem it solves:** Most productivity tools are built for generic users. Geri and Urte needed something that understood their constraints — Urte's energy limits due to medical treatment, Geri's ADHD system-dependence, a dual-income household tracking debt payoff and savings goals, a side business CRM, and the mental weight of planning for parenthood. Nothing on the market fit. So they built it.

**Six modules:**
- **Finance OS** — Full household financial dashboard pulling live data from Google Sheets. Income KPIs, expense breakdown by 10+ categories, savings buckets (Baby / Wedding / Travel / Investments), debt payoff tracker, net worth panel, monthly snapshot history, one-click month rollover. AI-powered CFO-style narrative review every month-end: not a spreadsheet read, a story.
- **Geri OS** — Personal command center: daily ritual tracker, brain dump capture with AI intent-tagging (task / idea / note / blocker / question), AI Sort batching 10 dumps into structured tasks in one call, full-screen journal with Claude-powered weekly analysis, morning brief pulling live Google Calendar data. ADHD-aware throughout — optimistic UI, no data loss on network failure.
- **Urte OS** — Built around her energy first, business second. Daily wellness check-in (energy, sleep, mood, side effects). Full SSO sales CRM: lead pipeline with heat scoring, stage tracking, promo codes, revenue projection calculator. LinkedIn content system — idea bank, AI post generator trained on her exact voice (Claude Opus, 7-component brand guide, 30+ banned words anti-slop gate), rewrite pills, tone selectors, post history.
- **Kitchen OS** — Meal planning with its own visual identity. Full dish database with dietary metadata. State machine planning flow. AI meal generation respecting dietary rules, rotation constraints, weekly mood bias. Auto-populated shopping list with 10-category grocery structure. Save-as-image for the fridge.
- **Home OS** — Daily family touchpoint: finance strip, connection moment logger, Wins Jar, Baby Prep checklist, and a 152-card conversation deck in 8 categories.
- **Infrastructure** — 28-tab Google Sheets backend. GAS CRUD endpoint. 6am daily calendar sync pulling 4 calendars with 45-day lookahead. 11 Claude AI integrations across the system. Total AI cost: ~€0.20/month.

**Tech stack:** Vanilla HTML/CSS/JS, Vercel, Google Sheets as database (CSV reads, GAS writes), Claude API (Haiku / Sonnet / Opus), Cloudflare Access gate.

**Portfolio bullets (value-framed):**
- Replaced 11 separate tools with one system the couple actually opens daily — because it was designed around their real constraints, not a generic productivity user.
- Urte's LinkedIn content goes from blank page to scheduled post in under 20 minutes — an AI writing system trained on her exact voice, not a generic AI voice.
- Financial clarity in 30 seconds — income, spending, savings progress, debt runway, and net worth visible the moment you open the finance page, no manual data entry required.
- The system knows when to push and when to protect — Urte's AI check-in assesses energy before business output; Geri's weekly review runs an ADHD lens on avoidance patterns before suggesting next actions.
- Zero recurring SaaS cost for what a VC-backed startup would pay €500+/month to approximate — custom-built, privately hosted, owned entirely by the people who use it.

### 3. She Starts Over — Marketing Site + Admin CRM
**What it is:** Two separate builds for Urte's solopreneur community business:

**a) Marketing/landing page** (`shestartsover.co`) — full single-page marketing site with animated hero, flip cards, section reveals, event countdown timer, OG tags, Umami analytics, mobile-responsive. Built in plain HTML/CSS/JS. Multiple copy and design iterations.

**b) Admin tools site** (`tools.shestartsover.co`) — a private, password-gated CRM and community management tool built from scratch. Includes:
- Member list with live search, filters, sortable columns
- Individual member profiles with inline-editable fields, auto-save
- AI-powered tools: pre-1:1 brief, welcome email generator, post-1:1 follow-up draft, exit interview prep — all using Claude API, saved and editable
- Onboarding/offboarding checklists with optimistic UI
- Community health dashboard with Chart.js charts (MRR, churn, funnel, event attendance)
- Revenue projection table with founding rate expiry tracking
- Notes log with inline edit/delete
- Tags, application answer storage
- Supabase backend (7 tables), Vercel serverless functions for AI and config

**Tech used:** Supabase, Vercel, plain HTML/CSS/JS, Claude API (haiku-4-5-20251001), Chart.js
**For the portfolio:** Frame this as "custom CRM + AI-powered admin surface" — the clearest example of what Geri can build for a real client with a real business need

---

## What He Can Confidently Build (Service Offering Raw List)

The session should help turn this into a structured, named service list. These are the raw capabilities:

- Custom admin dashboards and internal tools (like the SSO tools site)
- CRM-style member/client management systems
- AI-powered content and email generation tools (using Claude/OpenAI APIs via serverless)
- Finance and expense trackers with dashboards
- Onboarding/offboarding workflow tools
- Marketing and landing pages (with animations, reveals, copy)
- Form → email → CRM automation flows (Tally + Brevo + Supabase)
- Recipe/content/idea generators powered by AI
- Community management tools
- Scheduling and reminder systems
- Health and habit tracking dashboards
- Client reporting dashboards
- Agentic AI pipelines for content processing (podcast → cards, text → structured data)
- Automated weekly digests and AI summaries
- Social media content generators

---

## What He Cannot or Should Not Build (Honest Limitations)

The session should acknowledge these and help position around them honestly:

- RAG systems at production scale (demo-level fine, not production-grade)
- Real-time collaborative editing (Google Docs-style live sync)
- Complex payment/billing logic with SCA compliance
- Native mobile apps (iOS/Android)
- High-traffic systems (not architected for thousands of concurrent users)
- Security-critical data systems (medical, financial under PSD2)
- Legacy enterprise integrations (SAP, Oracle, ERP middleware)
- Model fine-tuning or training
- Multi-tenant SaaS at scale

---

## Pricing Direction (Rough)

- **No public fixed prices** on the site — discovery call first
- **Hourly rate indication** desired: affordable/accessible, not €60–100/hr agency rates (something like €35–55/hr would position well for the target market)
- **Project range:** €500–€2,500 per project depending on scope
- **Engagement types:** mix of fixed-scope projects, short retainers, and one-off discovery engagements
- **No free tools or lead magnets** — demos (screenshots/screen recordings) and case studies only

---

## Brand and Domain Context

**Brand name candidates being considered** (session should help lock one):
1. Digital Eden — evocative, memorable, "eden = where everything works"
2. Calm Systems — positioning baked into the name, speaks directly to the overwhelmed client
3. SoloStack — clear ICP signal
4. Nucleus — the core of your business operations
5. Forma Studio — European, elegant, "to shape"
6. Lucid Build — clarity + building
7. The Build Room — warm, workshop feel
8. Flow Studio — flow state + creative
9. Quiet Stack — invisible tech that runs in the background
10. Pocs Studio — simple personal brand

**Domain preference:** Geri does not want to buy a new domain. He has `pocs.family` and `epistemic.live`. The brand name can live as a subdomain (e.g. `eden.pocs.family` or `studio.pocs.family`). The session should confirm whether this is a smart long-term decision or whether one cheap domain is worth it.

**Note on Epistemic:** Epistemic.live is a product brand (a learning platform), NOT a consulting service. Do NOT position the consulting service as part of Epistemic — they are separate things.

---

## Positioning Inputs (for the session to develop)

**His differentiators vs. generic AI freelancers:**
- Recruitment background = he understands business needs, not just tech specs
- Calm, caring, excellent listener — not a typical "developer" personality
- ADHD superpower = fast at seeing the big picture, fast at solving
- Builds quickly (2–4 hours/day side hustle, gets full products live)
- Uses AI as a collaborator — so the cost of build is lower, delivery is faster
- Genuinely interested in the client's business outcome, not just the deliverable

**Target client profile (raw):**
- Solopreneur or 1–5 person business in West EU
- Overwhelmed by operational complexity
- Has no time or appetite to learn tech themselves
- Wants a calm, capable partner who "just sorts it out"
- Probably paying for multiple SaaS subscriptions that don't talk to each other
- Would benefit enormously from a custom-built, integrated system

**Initial warm network:** West EU solopreneur mothers via Urte's agency connections. Site must appeal to this group without being limited to it.

---

## Site Architecture (starting assumptions — session should challenge and refine)

The session should produce a recommendation on:
- Single page vs. multi-page
- What sections are essential
- What makes small business owners in 2026 say "wow" (design, animations, interactivity)
- Whether to include a blog/content section or keep it pure service
- What the consultation request flow looks like (CTA → form → calendar booking)
- Mobile-first considerations (primary audience likely on phone)

**Must-haves:**
- Clear above-the-fold value proposition
- Case studies / portfolio (the 3 projects, value-led)
- Service offering with use cases
- Consultation request form or Calendly link
- About Geri (human, warm, credible)
- Screen recordings or demo previews of the builds

**Known inspiration:** The She Starts Over landing page build process worked well — strong design system, animations, section reveals, mobile-responsive. Same quality bar applies here, adapted for a B2B consulting service.

---

## Deliverables Expected from This Session

By the end of the strategy session, the following should be locked:

1. **Brand name** — one name chosen, domain decision made
2. **Tagline** — 1 line, speaks directly to the client's pain
3. **ICP (Ideal Client Profile)** — 1 paragraph, specific enough to use in outreach
4. **Service list** — 4–6 named, packaged services with a one-sentence description each
5. **Portfolio summaries** — one-liner + 3–5 bullets for each of the 3 reference projects, value-framed
6. **Pain points + solutions list** — 8–12 common small business pain points Geri can confidently solve, formatted for use on the site
7. **Site architecture** — recommended page structure with section list
8. **Design brief** — visual direction (tone, references, animation style, what makes it stand out in 2026)
9. **Build plan** — numbered, phased plan (like tools-build-plan.md) with risk ratings, ready for a Cowork build session
10. **Copy starters** — headline options, hero subtext, about section direction

---

## Process Notes (What Worked Before)

The most successful build loop so far: **strategy session → tools-build-plan.md → execution session with the plan pasted in.** The plan had numbered phases, clear deliverables per phase, risk ratings, and architecture decisions locked before a single line of code was written. Replicate this exactly.

The session should produce a `consulting-site-build-plan.md` equivalent at the end, ready to paste into a build Cowork session. No build work in this session — only planning and decisions.

**Model note:** This session was started on Opus 5 deliberately. The positioning and brand decisions are high-leverage and benefit from deep reasoning. The build session should use Sonnet (faster, cheaper for execution work).

---

## Start Instructions for Claude

Read this entire document first. Then:

1. Start by **proposing a locked brand name** from the list above — pick the one you think is strongest given the positioning, and make a case for it. Give Geri a chance to confirm or push back before moving on.
2. Once the name is confirmed, develop the **tagline** and **ICP** together.
3. Build the **service list** — challenge Geri on scope if anything sounds too broad or too risky.
4. Produce the **portfolio summaries** — value-led, not tech-led. A client should understand what it means for *them*, not how it was built.
5. Produce the **pain points + solutions list**.
6. Recommend a **site architecture** — make a strong recommendation, don't just list options.
7. Write a **design brief** — be specific about what "wow" looks like in 2026 for a West EU B2B service site.
8. Produce the **build plan** in the tools-build-plan.md format.
9. Produce **copy starters** for the key sections.

Work through these in order. Don't rush to the build plan before the strategy decisions are locked — that's what causes misaligned builds.
