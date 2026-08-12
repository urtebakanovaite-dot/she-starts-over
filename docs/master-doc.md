# She Starts Over — Master Project Document

*Last updated: August 12, 2026 (Session 8)*
*Purpose: single reference doc to bring into new chats. Compiles all strategic decisions, copy, and open threads from project development to date.*

---

## Session 8 — August 12, 2026

**Topic:** Community onboarding/offboarding workflow + Member CRM + Tools site architecture

**Decisions:**
- Build a private admin tools site at `tools.shestartsover.co` — same GitHub + Vercel pattern as Geri's epistemic-tools
- Stack: plain HTML/CSS/JS (no framework, no build step), Supabase (Postgres database + API), Claude API (AI features), Vercel (hosting)
- Security: simple login page (sessionStorage) for now, Cloudflare Access gate to be added later
- Database: Supabase (not Excel/Sheets) — required for AI recommendation features to work properly
- Repo: `she-starts-over-tools` — private repo under Geri's personal GitHub (`pocsgeri1`), connected to Geri's personal Vercel account
- Subdomain: `tools.shestartsover.co` — CNAME added in Porkbun pointing to Geri's Vercel. Completely separate from Urte's Vercel account which hosts the public site
- Supabase account: created under Geri's `pocsgeri1` GitHub. Geri is sole admin. Same Supabase account to be reused for Epistemic and other future projects
- Circle: do NOT set up yet. Start free trial ~1 week before community launch (14-day trial is sufficient for setup). Geri will assist in a dedicated session
- Brevo onboarding automation: trigger when new paying member is added to CRM. Email sequence to be written in a dedicated session (flagged in Up Next)
- Offboarding flow: built in from day one, not added later

**Tools site — confirmed feature set:**

Multi-page app with these pages:
1. `index.html` — dashboard: MRR, member counts, onboarding alerts, at-risk flags, founding rate conversion countdown
2. `members.html` — full member list with search/filter
3. `member.html` — individual member: profile, onboarding checklist, offboarding checklist, notes log, AI buttons
4. `new-member.html` — add new member form
5. `health.html` — community health dashboard: MRR chart, churn, onboarding funnel, event attendance, revenue projection

AI features (all confirmed, build in from start):
- Introduction matcher — suggests 2–3 member pairings with draft intro email line
- Pre-1:1 brief — one-click summary + suggested questions before each monthly 1:1
- Post-1:1 email draft — Urte pastes raw notes, AI formats the follow-up email in her voice
- At-risk weekly digest — surfaces inactive members, upcoming rate conversions, members who haven't attended any event
- Onboarding email personalizer — drafts personalized Day 1 welcome using application answers
- Offboarding exit interview prep — tailored exit questions based on member history

Database tables: `members`, `member_notes` (append-only), `onboarding_steps`, `offboarding_steps`, `events`, `event_attendance`

**Infrastructure completed this session:**
- Supabase project created, credentials saved in 1Password
- GitHub repo `she-starts-over-tools` created (private, under pocsgeri1)
- Vercel project created, env vars added: `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`, `CLAUDE_API_KEY`
- Porkbun CNAME added: `tools` → `cname.vercel-dns.com`
- `tools.shestartsover.co` is live (pending DNS propagation)

**Open items:**
- Cloudflare Access gate for `tools.shestartsover.co` — deferred, add once community is live
- Write Brevo onboarding email sequence (Day 0 / Day 3 / Week 3 / Month 5) — dedicated session
- Circle setup — dedicated session, ~1 week before launch
- Terms & Conditions + Community Guidelines — still outstanding

**Next session task:** Build the tools site. Start with SQL schema → paste into Supabase SQL Editor, then build pages in order: index → members → member → new-member → health. AI features wired in last.

---

## Session 7 — July 19, 2026

**Decisions:**
- Full landing page copy pass across Hero, Nav, Identity, Solution, Founder, Included (flip cards), For You, Closing sections — new copy supplied by Urte, implemented in `index.html` v3.0 through v3.0d
- Section reorder: Founder section moved to directly after Solution (was after How-it-Works); Photo Break B (workspace image) moved between Included and For You; How-it-Works/Three Steps moved to directly before Closing. New page order: Hero → Identity → Solution → Founder → Included → Photo Break B → For You → Testimonials (hidden) → Photo Break C → Founding Offer → She Connects → How It Works → Closing → Footer
- Flip cards: "Weekly Sessions" renamed **Founder Circles**, "Member Lounge" renamed **Your Inner Circle**, new 4th card added — **Monthly Reset**. All 4 now display full-width, single row, 4-across on desktop (new `.container-full` wrapper, wider than the section's usual 960px container)
- Founder section restructured: 2-column photo+text grid now covers only the first half of the story (ends "...everything depends on them."); the rest flows full-width below it in a new block
- Founder story copy: rewritten twice this session; final version (v3.0d) is Urte's latest draft, with bold retained on 3 emphasis lines (reflective questions / core belief statement / closing line) matching the pattern from the first rewrite
- Solution section eyebrow label changed: "That's why She Starts Over exists" → **"Our philosophy"**
- Closing headline changed: *"One meaningful conversation can change the trajectory of your business."* → **"Build a business that supports your life."**
- Sitewide emoji change: all orange hearts (🧡) replaced with white hearts (🤍) — 5 instances (all CTA buttons + footer)
- Not-for-you list bullet marker changed from `—` to `✗`
- Founding-spots badge ("Accepting applications · Only 10 founding spots") given more visual weight — larger, bolder, more opaque
- House style rule (no em-dashes, set Session 6) applied to 2 new copy drafts this session — converted silently, consistent with standing instruction

**Open items:**
- Monthly Reset card icon (🌙) was Claude's pick, not confirmed by Urte — revisit if a different icon is preferred
- Heart emoji colour (🤍 white, changed from 🧡 orange) is not yet codified anywhere as a brand rule — worth adding to a future `brand-style-guide.md` once that document is built, so it doesn't silently drift back
- **File hygiene flag:** two master-doc files currently sit in project files — the outdated `she-starts-over-master-doc.md` (last updated Session 4, June 30) and this file, `master-doc.md` (current, updated through Session 7). Per the same file-hygiene rule already established for `index.html` (Session 4 incident), recommend deleting `she-starts-over-master-doc.md` from project files now that this doc supersedes it — avoids the exact stale-file ambiguity risk documented in Session 4
- No infrastructure work this session (Calendly, Eventbrite, Tally, Brevo, domain-linking all unchanged) — this was a pure design/copy session, all on `index.html`

---

**Decisions:**
- Community launch decoupled from a fixed date. New trigger: launch happens once 
  10 paying founding members have joined — actual date unknown, could be October 
  2026 or January 2027.
- Founding member rate reconfirmed: €30/month for the first 6 months from each 
  member's individual join date, then €60/month. General ("doors open") 
  membership only opens once the 10-founder threshold is met — not on a calendar 
  date.
- Event revenue (She Connects, Brunch, and any future paid events) is now tracked 
  as an independent revenue stream, separate from membership MRR — not gated on 
  when the community itself launches.
- Two illustrative scenarios modeled against the above (Scenario A: 10 founders 
  by Oct 2026; Scenario B: 10 founders by Jan 2027). Under both, the original 
  €2,000/month by December 2026 target no longer holds.

**Open items:**
- New target date/revenue milestone not yet set. Options: keep Dec 2026 as 
  aspirational only, or set a new target once the founding cohort actually fills.
- Additional paid events beyond She Connects and the Brunch were mentioned as a 
  plan but are not yet scheduled or priced.

---

## Session 6 — July 2–3, 2026

**Decisions:**
- Domain confirmed live: `shestartsover.co` (the `.com` was unavailable; `.co` was already flagged as an acceptable fallback in the tech-stack doc, so no new decision needed there — just confirming which one went live)
- Umami analytics fully wired: base tracking script (v2.6) plus 8 custom events covering every "Become a member" CTA (tagged by page location: nav/hero/how-it-works/founding-offer/closing), the She Connects Eventbrite button, the LinkedIn connect card, the footer LinkedIn link, all 3 flip cards (tagged by card name), and 2 scroll-depth milestones (reached founding offer, reached She Connects)
- Umami dashboard approach decided: one custom Board (not multiple), built from 5 components — Metrics Bar, Metrics Table set to "Event," Metrics Table set to "Channel," World Map, Visitors Chart. Per-button/per-card breakdowns (e.g. which CTA location converts best) live separately under Events → Properties tab, checked manually, not pinned to the board.
- Umami's "Links" feature (short trackable URLs) decided to be used only in off-site placements going forward (LinkedIn DMs, Brevo email templates) — never for on-site buttons, since those already have direct event tracking and a redirect would add unnecessary latency
- Open Graph + Twitter Card tags added to fix broken LinkedIn share preview. Title copy: *"Building alone? You don't have to."* — reused verbatim from the existing closing-section line rather than new copy. Description reused/trimmed from the existing meta description. Image: `assets/group-photo-wide.jpg`, chosen over the founder portrait specifically because portrait-orientation photos crop badly in the landscape preview box most platforms use.
- New house style rule: no em-dashes in on-page prose. Replace with a colon when introducing a list of examples, or a comma when joining a qualifying clause. Applied retroactively to 5 existing instances in the identity section and for-you list.
- Nav CTA text shortened from "Become a member" to "I'm in," specifically to guarantee it never wraps to 2 lines regardless of screen width (paired with a CSS fix, not just a text change)
- Brand-voice override, flagged not silently applied: Urte's suggested nav text included an exclamation mark ("I'm in!"). Dropped per her own existing rule (no exclamation marks unless already used on the page — the page currently has none). Reversible on request.

**Incident (see build-journal.md Session 6 for full detail):** A mobile bug reported as three separate symptoms (page feeling "zoomed in," nav button wrapping to 2 lines, founder-section text overflowing right edge) traced back to one root cause: the founder photo's fixed 420px width (set in Session 5) wasn't shrinking properly inside its CSS grid column on narrow phone screens, forcing the whole page wider than the viewport. Fixed with `min-width: 0` plus an explicit smaller size on mobile only; desktop untouched.

**Open items:**
- Confirm `shestartsover.co` is set as Primary Domain in Vercel settings (Urte to do)
- Confirm Umami's website settings show the real domain, not the old `.vercel.app` address
- Force LinkedIn to re-scan the link via linkedin.com/post-inspector once the latest file is deployed, since LinkedIn cached the earlier broken preview
- A list of further mobile UX audit points was proposed but deliberately not actioned this session (nav tagline wrap risk, flip-card hint text size, countdown timer wrap risk, photo-break section overflow check, touch-target sizing, real-device Android testing) — revisit in a dedicated mobile-polish session
- Note: the project's "Current Stage" summary (in Project Instructions) still describes the landing page as "not yet live" and Eventbrite as "not yet published" — this is now out of date versus this doc and the roadmap. Not corrected here since Project Instructions wasn't part of this update request — worth Urte updating that text herself next time she edits project settings, so future sessions don't start from a stale premise.

---

## Session 5 — July 1, 2026

**Decisions:**
- Real photos (identity portrait, founder portrait, detail-workspace shot, group photo) wired into `index.html` via a new `assets/` folder in the GitHub repo. Filenames locked: `urte-portrait-identity.jpg`, `urte-portrait-founder.jpg`, `detail-workspace.jpg`, `group-photo-wide.jpg`.
- Image compression guidance given (source files ~15MB each): use Squoosh (squoosh.app) to resize + compress before upload, target under 300–500KB per image. No change to filenames or paths needed regardless of compression tool used.
- Design treatment chosen for photos: terracotta hairline border + offset shadow-panel applied to identity portrait, founder portrait, and the detail-workspace shot. Soft rounded corners (not full circles — would distort non-square aspect ratios) applied to the two portraits only. The full-bleed group photo deliberately excluded from all three treatments to preserve its intentional edge-to-edge, immersive look.
- Founder photo resized to exactly match the identity photo (420px wide, 3:4 ratio) for visual consistency between the two portraits.
- Founder section container widened (720px → 960px) to comfortably fit the larger photo alongside the text column.
- "She.Starts.Over" (with periods) corrected to "She Starts Over" everywhere it appeared (nav logo, founder heading) — no strategic meaning attached to the periods, treated as a formatting slip.
- Testimonials section reappeared in the live project file after being removed in Session 4 — re-disabled this time via `display:none` rather than deletion, specifically so the disable state can't be silently lost again by a stale file re-upload. See build-journal Session 5, Lesson 15.

**Open items:** none new. Testimonials re-addition still pending workshop or member quotes, same as Session 4. Founder photo and design updates are built in `index.html` v2.5a but not yet pushed to the live GitHub repo / Vercel — next session should confirm this has been done before further edits.

---

## Session 4 — June 30, 2026

**Decisions:**
- Testimonials section removed from `index.html` (v2.2) until real testimonials (workshop or community-member) are available. Exact original markup preserved for verbatim re-insertion on request — not rebuilt from scratch when ready.
- Confirmed file hygiene rule: only ONE HTML file (`index.html`) should exist in project files going forward. The older `she-starts-over.html` draft is fully superseded and should be deleted from project files to avoid future ambiguity.

**Incident (see build-journal.md Session 4 for full detail):** An outdated `index.html` was present in project files at the start of this session (predating LinkedIn connect card, photo break slots, accepting badge). The testimonials removal was first done correctly in isolation but against this stale file. Urte caught it via live-site comparison and re-uploaded the correct, current `index.html`. The edit was redone and diff-verified against the correct file — confirmed only the testimonials block changed, nothing else.

**Open items:** none new. Testimonials re-addition is pending workshop or member quotes — no action needed until Urte has them.

---

## 🔼 UP NEXT — Action List

**Immediate (this week):**
- [x] Buy domain — `shestartsover.co` (live, confirmed Session 6)
- [ ] Set up business email inbox — Google Workspace or Zoho before using `urte@shestartsover.com` in any outreach
- [ ] Insert real Calendly link into `index.html` (replace `https://calendly.com`)
- [ ] Publish She Connects Eventbrite — copy ready in Phase 4. Insert real link into HTML
- [ ] Publish brunch Eventbrite — copy ready in Phase 4B. Insert real link into HTML
- [ ] Start LinkedIn outreach — 3 DMs/day using templates in Phase 9. Track in outreach spreadsheet
- [ ] Double-check: Aug 19 = Wednesday ✓ and Sept 16 = Wednesday (verify before sending date-specific messages)

**Next 2 weeks:**
- [ ] Publish Tally application form — questions in Phase 6
- [ ] Set up Brevo — create list, build Day 1 + Day 7 email templates (copy in Phase 5)
- [ ] Founder photo: get live on site as soon as shoot at Moxy Hotel is done
- [ ] Request 2–3 testimonials — template in Phase 7
- [ ] Privacy policy page — generate free via Termly, [PARTNER] adds as second HTML file
- [ ] Confirm Zoku brunch booking in writing — 2-hour window, Sept 16
- [ ] Decide bag contents for brunch — recommendation: handwritten note + one small local treat (see Phase 4B)
- [ ] Brief friend on event-day support role — see Phase 9

**Event week (Aug 19 — She Connects):**
- [ ] Send reminder email to registrants 1–2 days before
- [ ] Prep Zoom breakout rooms
- [ ] Pre-select 2 Founder Circle topics from submitted challenges (don't choose live)
- [ ] Run She Connects
- [ ] Send Day 0 + Day 1 follow-up sequence (templates in Phase 5)

**September (brunch at Zoku):**
- [ ] Send Day 3 + Day 7 follow-ups to She Connects leads
- [ ] Confirm 12 brunch attendees
- [ ] Print place cards (name + one-line business description)
- [ ] Print 4–6 conversation cards for icebreaker (shortlist in Phase 4B)
- [ ] Run brunch
- [ ] Run founding member calls from both events

**Tools site (next session):**
- [ ] Build SQL schema → paste into Supabase SQL Editor
- [ ] Build `index.html` dashboard + shared `style.css` + `supabase.js`
- [ ] Build `members.html`, `member.html`, `new-member.html`, `health.html`
- [ ] Wire in AI features (Claude API via Vercel serverless `/api/ai.js`)
- [ ] Add simple login page (sessionStorage auth)
- [ ] Add Cloudflare Access gate (deferred — after community launches)

**Brevo (dedicated session):**
- [ ] Write onboarding email sequence: Day 0 / Day 3 / Week 3 / Month 5 week 3
- [ ] Set up Brevo automation triggered when new member added to CRM

**Circle (dedicated session, ~1 week before launch):**
- [ ] Spaces setup, member profile fields, payment linking, onboarding flow

**Still outstanding:**
- [ ] Terms & Conditions
- [ ] Community Guidelines
- [ ] Content for 3–4 upcoming weeks
- [ ] Lead generation + LinkedIn messaging (ongoing)

**Unresolved (not urgent, doesn't block launch):**
- Final community/product name — "She Connects Circle" and "She Connects Lounge" are live contenders, availability not yet confirmed (see Phase 8)
- Whether to separate "She Starts Over" personal brand from community product name
- Legacy free community — calls paused; bigger pivot announcement deliberately held until She Connects + brunch generate real momentum (see Phase 10)

---

## How to use this document

Each phase below covers one topic area from the project's development. When starting a new chat, paste this whole document in as context. The "Up Next" list above is the actionable summary; the phases below are the reasoning and detail behind each decision, useful if anything needs revisiting.

**Suggested companion documents to build separately** (flagged throughout, not yet created):
- **Brand/style guide** — colour palette, fonts, logo usage, voice & tone rules, do's/don'ts. Right now this lives only in the landing page HTML and scattered chat decisions. Worth consolidating once the name is finalized, since the colours and name will both feed into it.
- **Build journal / changelog** — a running log of what's been built, tested, and the outcome (e.g. "Aug 19 event: X attendees, Y converted to calls, Z joined as founding members"). Useful once events start running, to track what's actually working vs. assumed.
- **Pricing & offer architecture doc** — a single source of truth for current pricing across all offers (She Connects ticket, brunch ticket, founding member rate, regular member rate, future coaching/products). Most prices are now confirmed as of Session 2 (see Key Numbers table at the bottom) — early drafts referenced €20/€29 for She Connects and €45/€60 for the brunch before settling on €25 and €35 respectively. Worth a dedicated doc once more products exist, but the table at the bottom of this doc is sufficient for now.
- **Event runbook** — step-by-step operational checklist for running She Connects and the brunch (tech setup, timing, scripts, who does what). Phase 4 and Phase 9 contain the raw material; this would be the polished, printable version for event day.
- **Outreach/CRM tracker** — simple spreadsheet to track who's been contacted, what stage they're at (cold outreach → warm conversation → event attendee → founding member call → joined), so nothing falls through the cracks as volume increases.

None of these are needed immediately — the master doc below is sufficient to keep moving. Build the above only when the relevant activity becomes frequent enough to need a dedicated system.

---

## PHASE 1 — Brand Repositioning & Strategic Pivot

**Original positioning:** She Starts Over was created for women who felt stuck, burned out, disconnected, or navigating major life transitions. Focus was on clarity, purpose, confidence, personal growth, starting over.

**Why it changed:** The community model was tested and engagement was poor. Diagnosis: wrong women in the room — some still job-hunting, some with side hustles they weren't actively working on, inconsistent participation. The free model also meant zero commitment. The one genuinely engaged member (Kristina) was emotionally invested but still business-stage "figuring it out" — which clarified that this profile is not who the new community should be built for. She needs a business mentor, not a peer community — a useful distinction: the community solves *connection*, not *strategy or results*.

**New positioning:** A curated community for established female solopreneurs/founders who don't want to build alone. Focus shifted from "starting over" to: founder/peer connection, meaningful relationships, support systems, belonging, sustainable growth.

**Core belief carried through:** Most founders don't need another course, PDF, or expert. They need people in their corner, honest conversations, perspective, trusted relationships. *"One meaningful conversation can change the trajectory of a business."*

**Key tension identified and resolved:** Urte's own founder journey (burnout → reconnecting with herself → rebuilding → now monetizing) mirrors the "starting over → building" arc of her ideal member. This isn't a contradiction — it's the brand story. She Starts Over began as a community for women rebuilding; as Urte grew, so did the audience. The personal narrative is evidence the model works, not just backstory.

---

## PHASE 2 — Target Audience Definition

**Final sharpened ideal member profile:**

Women in their late 20s and 30s running independent, service-based businesses (coaching, marketing, sales funnels, PR, branding) built around their personal brand, often via LinkedIn. They've deliberately chosen flexibility and independence over venture-scale growth or fundraising — their goal is an aligned, financially free lifestyle, not "building the next big thing." They crave real connection and collaboration with peers who understand solo entrepreneurship — not hustle-culture energy or "10x your revenue" pressure. Based in or generally available during European time zones. Some are near Amsterdam and may want occasional in-person meetups (brunches, dinners, coworking).

**Explicitly NOT the target:**
- Founders raising VC funding or scaling tech products
- Digital nomads without a geographic/timezone anchor
- People seeking high-intensity "exceptional girls, scale faster" energy
- Women still figuring out what business to start
- Women looking for coaching or done-for-you support
- Women who join communities and disappear

**Language shift:** "Founder" was dropped from community-facing copy in favour of "solopreneur" — founder is overused, sounds startup-coded, and doesn't quite match the personal-brand/service-business reality of the audience. ("Founding member" was kept — that refers to early-adopter status, a different concept entirely.)

---

## PHASE 3 — Differentiation Strategy ("Not Networking")

**The core risk identified:** "We're not networking, we're about real connection" is a claim every community makes. It's not a real differentiator on its own.

**What actually differentiates She Starts Over, established through discussion:**
1. **Pre-selection/curation** — every member or attendee is personally reviewed. The room itself is intentional, not self-selected.
2. **Values-based filtering, not just demographic** — filtering for a specific relationship with ambition: "feminine success" defined concretely as allowing rest, prioritizing the journey over vanity metrics, building for the long term, trusting timing over over-optimizing. Important nuance surfaced: this must read as *ambitious-but-non-anxious*, not low-ambition — the audience is still serious about building, just without white-knuckle hustle energy.
3. **Real depth of conversation in the Founder Circle/Idea Circle portion** — this is where actual connection forms, more than icebreakers or formats.

**Practical filtering mechanism:** Applications (for both the community and She Connects) ask questions designed to surface this values-fit explicitly — e.g. "What does success look like for you in this phase of life?" and "What do you believe makes a community truly valuable, and how do you personally contribute to that?" These were intentionally retained even when trimming the form, because they filter for hustle-culture mismatch specifically.

---

## PHASE 4 — She Connects (Online Event) — Full Spec

**Event:** She Connects — August 19th, 12PM CET, online, €25 (price point revised down from an initial €20 draft and a later €35 suggestion — €25 was the final call, balancing accessibility with a "this isn't free/casual" signal for a first-time event).

**Final schedule (90 min):**
| Section | Time | Duration |
|---|---|---|
| Welcome & intro + agenda | 12:00 | 5 min |
| Connection Bingo — breakout rounds | 12:05 | 15–20 min |
| Bingo debrief — share learnings | 12:25 | 5 min |
| Founder Circle — topic 1 | 12:30 | 15 min |
| Founder Circle — topic 2 | 12:45 | 15 min |
| Founder Circle wrap | 13:00 | 5 min |
| She Starts Over introduction | 13:05 | 5 min |
| Reflection + LinkedIn exchange | 13:10 | 10 min |
| Close | 13:20 | — |

**Format decisions:**
- Urte assigns breakout rooms herself (not self-selected) to avoid cliques and ensure everyone meets someone new.
- Founder Circle topics should be pre-selected from submitted challenges *before* the event, not chosen live — reduces facilitation pressure.
- Closing line drafted: *"You showed up today. That already says something about the kind of founder you are. Go nurture at least one connection you made here — and remember, you don't have to do this alone."*

**In-event community mention script** (used at the 13:05 mark, ~60 seconds, before Reflection):
> "Before we move into our final reflection — I want to share something briefly. One of the reasons I created She Connects is because I kept seeing the same thing. Founders having a genuinely meaningful conversation, feeling that energy, and then going back to building alone. I don't want that to be the end of the story. That's why I'm launching She Starts Over — a small, curated community for founders who want this kind of connection ongoing... I'm opening it to a small founding group first — 10 to 15 women at a founding rate. If that resonates, there's a link in the chat and I'm happy to chat after. Okay — let's go into our final reflection."

**Bingo card — 24 prompts (built specifically for established-founder/solopreneur audience, replacing original "started over"-themed prompts which no longer fit the repositioned audience):**
1. Has pivoted their business or offer at least once
2. Has worked with a VA or contractor
3. Has turned down a client that wasn't the right fit
4. Is building an online business
5. Has had a launch that didn't go as planned
6. Has experienced founder loneliness
7. Is an expat or has lived in more than one country
8. Has changed their pricing in the last year
9. Has a morning routine they swear by
10. Has collaborated with another founder
11. Is currently working on a new offer or product
12. Has taken a proper break without feeling guilty — eventually
13. Believes rest is part of the strategy
14. Has built their business primarily through word of mouth
15. Has invested in a coach or mentor
16. Has said "I'll figure it out" and actually did
17. Is building a purpose-led business
18. Has celebrated a win alone and wished someone was there to share it
19. Has gone back and forth on their niche
20. Has a business idea they haven't acted on yet
21. Prefers deep conversations over small talk
22. Has had a €5k+ month
23. Has shown up and done the work even when motivation was low
24. Believes success and rest can coexist

**Final Eventbrite description (live copy):**
**Updated description (this session — "solopreneurs" replacing "founders" per Phase 2 language shift, "curated experience" wording confirmed as the preferred tagline phrase):**
> Welcome to She Connects!
>
> Building a business can be incredibly rewarding. It can also feel isolating and lonely.
>
> She Connects is a curated experience for female solopreneurs who are done with surface-level networking and ready for something that actually feels meaningful.
>
> No pitching or boring panels. Just honest conversations with women who genuinely understand what you're building.
>
> **What to expect:**
> Connection Bingo - a fun and interactive way to meet fellow founders, discover common ground, and break the ice naturally.
> Founder Circle - a facilitated group conversation where founders share real challenges and opportunities. Real experiences and raw ideas that lead to momentum.
> Reflection & Connection - share key insights, exchange LinkedIn profiles, and leave with connections worth continuing.
>
> **This event is for you if:**
> - You have a business and paying clients
> - You're tired of feeling like the only one navigating this
> - You value deep conversations over small talk
> - You believe success feels better when it's shared
>
> Spots are limited to keep the conversation intimate. 🧡
>
> Entrepreneurship was never meant to be a solo journey, even if you are a solopreneur! And sometimes one conversation changes everything.

**Note:** even in this updated pass, "Founder Circle" and "fellow founders" remain inside the What To Expect section — not yet fully scrubbed to "solopreneur" language. Flagged but left as-is since Urte approved this exact copy live; revisit only if full consistency matters more than shipping speed.

**One-line event description (for use in tags/meta/short-form placements), finalized this session:**
> "A curated experience for female solopreneurs craving genuine connection and meaningful conversation."

**Eventbrite tags (10), finalized this session:**
female entrepreneurs · solopreneurs · women in business · networking for women · female founders · business community · online networking event · women entrepreneurs Amsterdam · personal brand business · female solo business owners

*(Note: "networking" intentionally included in 2 tags despite not matching the brand's own voice — kept purely for Eventbrite search discoverability, since people search using that word even though the event explicitly isn't positioned that way in its own copy.)*

---

## PHASE 4B — Founders Brunch (In-Person, Amsterdam) — Full Spec (NEW this session)

**Event:** Founders brunch — Zoku Amsterdam, intended date September 16th (day of week NOT yet verified — confirm before sending date-specific outreach), 12:00–14:00 (2-hour window, to be reconfirmed directly with the venue).

**Pricing — confirmed:** €35 per person, includes buffet brunch. Venue cost is €27pp. Margin: €8pp × 12 guests = €96 total, which must also cover Urte's own seat at the table (effectively 13 covers needed against 12 ticket-payers) plus any bag contents — net surplus is thin (~€69 after Urte's own meal), and this is a deliberate trade-off: the stated priority for this first brunch is testing the format and getting the right people in the room, not revenue. Price can be raised for future brunches once there's signal on price sensitivity (e.g., did anyone hesitate or push back at €35).

**Bag contents — decided direction:** Skip physical merchandise/swag given the thin margin. Instead: a handwritten personal note from Urte in each bag, plus one small low-cost local treat (e.g. Dutch chocolate or mini stroopwafel). Prioritizes relationship/personal touch over branded-but-generic swag.

**Format — deliberately different from the online She Connects event, NOT a copy-paste:**

No Connection Bingo (doesn't translate to a seated meal). Replaced with a custom icebreaker mechanic, see below. Founder Circle (open-floor challenge discussion) is retained, same spirit as the online version.

**Icebreaker mechanic — "card game":**
Printed prompt cards placed face-down on the table (shortlist of 4–6 cards, not the full 24 used for online bingo — see list below). Mechanic:
1. One woman picks up a card and reads the prompt aloud.
2. She guesses which woman at the table she thinks it applies to.
3. That woman confirms or denies, and shares a short story about it if she did it.
4. If the guess is wrong: ask the table "okay, who was it?" — whoever it actually applies to (could be more than one person) shares briefly.
5. If it applies to nobody at the table: laugh it off, move to the next card.
6. Repeat with a new card, new woman picking each time.

Soft time cap: ~2–3 minutes per card including the story, to protect time for the Founder Circle later. Host (Urte) gently moves things along if a card is running long.

**Shortlisted 6 prompts for the brunch card game** (pulled from the original 24-card online bingo list, chosen specifically because they're broad enough that someone at almost any table of 12 is likely to fit, and because they prompt a story rather than a yes/no):
1. Has pivoted their offer or business at least once
2. Has worked with a VA, contractor, or freelancer in their business
3. Has had a launch or offer that didn't go as planned
4. Has turned down a client that wasn't the right fit
5. Has taken a proper break without feeling guilty — eventually
6. Has had a €5k+ month

*(6 backup/alternate prompts were offered but not yet selected — revisit the full 24-card list in Phase 4 if more are needed on the day.)*

**Full event flow / runsheet (2 hours, assuming 12:00 start):**

| Time | Segment | Notes |
|---|---|---|
| 12:00 | Arrival & seating | Guests arrive, find their seat, settle in |
| 12:10 | Lightning intro round | Name + what you do, one sentence each. Urte goes last — uses that moment to introduce the community, the why, and the structure for the brunch |
| 12:25 | Buffet — serve yourselves | Everyone gets food, resettles at the table |
| 12:40 | Card game, while eating | Read card aloud, guess, confirm/deny + story. 4–6 cards, ~3 min each |
| 13:10 | Buffer — finish eating | Food winds down, energy settles before the deeper conversation |
| 13:25 | Founder Circle | Open floor for a real challenge. Urte seeds it herself if nobody volunteers first |
| 13:55 | Close & branded bags | Wrap, hand out bags. Optional: move to the lounge for coffee for anyone wanting to stay on (not part of the paid time block) |

~5 minutes of natural slack is built into this flow. If anything runs long, protect the 13:25 Founder Circle start time first — it's the part most aligned with the core promise of the brunch, so it shouldn't get squeezed by an overrunning icebreaker.

**Why the lightning round comes first (solves a structural problem):** with only 4–6 cards in the game, not all 12 women would get a personal introduction moment through the card game alone. The lightning round at the very start guarantees baseline visibility for everyone before the more random card mechanic begins — the card game then becomes a bonus layer of depth and story, not the only chance to be seen. Backed up further by:

**Place cards (backup visual intro):** Simple name + one-line business description cards visible at each seat for the whole brunch, so even people the card game never reaches aren't a mystery to the table.

**Brunch Eventbrite description (finalized this session):**
> Welcome to She Connects!
>
> Building a business can be incredibly rewarding. It can also feel isolating and lonely.
>
> She Connects is a curated brunch for female solopreneurs who are done with surface-level networking and ready for something that actually feels meaningful.
>
> No pitching, no agenda. Just good food and honest conversations with women who genuinely understand what you're building.
>
> **What to expect:**
> Conversation Starters — a relaxed way to get to know the table, surface common ground, and break the ice over good food.
> Founder Circle — a facilitated group conversation where founders share real challenges and opportunities. Real experiences and raw ideas that lead to momentum.
> Reflection & Connection — share key insights, exchange LinkedIn profiles, and leave with connections worth continuing.
>
> **This event is for you if:**
> - You have a business and paying clients
> - You're tired of feeling like the only one navigating this
> - You value deep conversations over small talk
> - You believe success feels better when it's shared
>
> Spots are limited to 12 women to keep the conversation intimate. 🧡
>
> Entrepreneurship was never meant to be a solo journey, even if you are a solopreneur! And sometimes one conversation changes everything.

**Personal invite message for Amsterdam-based outreach (used to fill this event — see also Phase 9):**
> "I'm testing a new format for my community — an intimate, invite-only brunch for female solopreneurs on September 16th. Small group, real conversation, brunch included — €35 to join. I think you'd be a great fit. Would you like to hear more?"

**Confirmation message once she says yes (finalized, price now included):**
> "So glad you're interested! Here's what to expect: an intimate, cozy brunch at Zoku on Wednesday, September 16th, 12–2PM, with a small group of up to 12 women solopreneurs who crave genuine connection — personally invited to join. Real conversation, no pitching, no agenda. It's €35 to join, which covers a delicious buffet brunch. You can grab your spot here: [Eventbrite link] — spots are limited, so I'd love for you to secure yours soon. Let me know if you have any questions!"

**Equivalent confirmation message for She Connects (online), for comparison/consistency:**
> "So glad you're interested! Here's what to expect: an intimate, online founder experience on Wednesday, August 19th, 12–1:30PM CET, for a small group of up to 12 women solopreneurs who crave genuine connection — personally invited to join. Real conversation, no pitching, no agenda. It's €25 to join. You can grab your spot here: [Eventbrite link] — spots are limited, so I'd love for you to secure yours soon. Let me know if you have any questions!"

---

## PHASE 5 — Post-Event Follow-Up Sequence (She Connects)

**Day 0 (within 2 hrs) — LinkedIn DM to every attendee:**
> "[Name] — it was so lovely to have you at She Connects today. I really enjoyed the energy in the room and the conversations that came out of it. I'll be sending a short follow-up email tomorrow with a few things from today. Speak soon! 🧡 Urte"

**Day 1 — Follow-up email to all attendees** (Subject: *Thank you for being there 🧡*):
> Hi [Name], Thank you for showing up to She Connects yesterday. I hope you left with at least one conversation that felt worth continuing... I also want to share something with you. One of the reasons I created She Connects is because I kept seeing the same thing — founders having a genuinely meaningful conversation, feeling that energy, and then going back to building alone. I don't want that to be the end of the story. That's why I'm launching She Starts Over... I'm opening founding member spots in September — just 10 to 15 women at a founding rate... If you left yesterday thinking "I want more of this" — I'd love to have a founding member conversation with you. It's just 20 minutes... You can book a time that works for you here: [Calendly link]. And if the timing isn't right, that's completely fine too. Speak soon, Urte 🧡

**Day 3 — Personal LinkedIn message to the 3–5 warmest leads:**
> "[Name] — I've been thinking about what you shared yesterday about [specific detail]. I'm opening founding member spots for She Starts Over next month and honestly, you came to mind. I'd love to have a quick founding member conversation — just 20 minutes... Would you be up for that? [Calendly link]. No pressure at all — genuinely just want to connect properly. 🧡"

**Day 7 — Gentle nudge to anyone interested but not yet booked:**
> "Hi [Name] — I wanted to follow up in case my last message got buried. I still have a few founding member spots open... [Calendly link]. And if the timing isn't right, completely understood — I'd still love to stay connected. 🧡"

**Founding member call structure (20 min):**
- 5 min — ask about their business, what's working/not
- 5 min — share what She Starts Over is, who it's for, how it works
- 5 min — answer questions honestly, including who it's *not* for
- 5 min — if it feels right, invite them to join as a founding member

**Mindset note carried through:** the call should feel like mutual fit-finding, not persuasion — that energy comes through and matters more than any script.

---

## PHASE 6 — Community Structure, Pricing & Application Form

**Community structure (finalized):**
- **Weekly session**, alternating format: Week 1 = Founder/Idea Circle (real challenge, group solves it together); Week 2 = Feedback Round (honest input on offer/content/next move). Combined into one weekly touchpoint rather than two separate biweekly sessions — simpler to schedule, lighter cognitive load for busy members.
- **Member Lounge** — ongoing async space. Rhythm: Monday = share weekly intentions, Friday = share wins & learnings. This creates a structural reason to post without needing constant prompting from Urte.
- **She Connects** — quarterly, wider circle, also functions as a funnel/intro event.
- **Brunch & Meetups** — Amsterdam-based, in-person, intimate (max ~12).

**Early-engagement risk flagged:** small async communities (10–15 members) can go quiet fast if 2–3 people stop posting. Mitigations discussed: Urte models the behaviour by posting first every Monday/Friday without fail; consider rotating accountability pairs; make the weekly rhythm an explicit onboarding expectation, not just a suggestion.

**Pricing (current decision):**
- Founding members: **€30/month**, locked in for first 6 months, then moves to **€60/month** (the standard ongoing rate) — NOT a permanent discount, to avoid a lasting two-tier resentment dynamic.
- Decision: do **not** display this price publicly on the landing page yet. Reveal it during the founding member call instead, where value can be built first. Flagged that this only works at small/founding scale — once regular members are being acquired, pricing must become visible on the page for trust reasons.

**Revenue modelling (see interactive calculator built in-chat):** To reach a €2,000/month target (the threshold at which quitting the 4-day-a-week job becomes viable), a realistic mixed scenario is roughly 10 founding + 15 regular members (€1,500) plus 2 brunches/month × 12 attendees × €45 (€1,080) ≈ €2,280/month combined. Community-only growth alone (e.g. 15 founding + 20 regular ≈ €1,650) falls short without event revenue. Six-month roadmap targets this combined model by December 2026, with founding members converting to full price at the 6-month mark.

**Six-month roadmap (July–Dec 2026), high level:**
- July: landing page + outreach + application form live (build phase)
- August: She Connects Aug 19 → first 3–5 founding members
- September: first Amsterdam brunch → conversion + community rhythm begins
- October: open to regular members at €60/mo, second brunch, Q4 She Connects
- November: referral push, third brunch, review what's working
- December: founding members convert to €60/mo, target ~20 members + 2 brunches/mo ≈ €1,920–2,280/mo

**Application form — final structure (Typeform):**

Description:
> She Starts Over is a curated community for female founders who are done building alone. I review every application personally — the quality of the room is everything, and I want to protect the energy and vibe we're creating together. If that sounds like you, I'd love to read your application. 🧡

Questions, in order:
1. Contact details (name + email)
2. LinkedIn profile link
3. Tell me about your business — what do you do and who do you help?
4. How long have you been running your business? (under 6mo / 6mo–1yr / 1–2yr / 2–5yr / 5yr+)
5. Which best describes where you are right now? (still working toward first client / consistently signing clients / growing & scaling / building a small team / established business owner)
6. What does success look like for you in this phase of life — and how are you actively moving towards it? *(deliberately open — filters out hustle-culture mismatch)*
7. What do you believe makes a community truly valuable — and how do you personally show up in one? *(filters giver vs. taker mindset)*
8. What's your biggest challenge right now as a founder?
9. What made you want to join a founder community at this point in your journey?
10. What are you looking for most here? (multi-select: founder friendships, honest conversations, accountability, support during hard periods, collaboration, celebrating wins)

Closing screen:
> Thank you for applying. 🧡 I read every application personally and will be in touch within a few days. If it feels like a good fit, I'll reach out to arrange a short conversation before you join. — Urte

**Note:** this form copy predates the Phase 2 "founder → solopreneur" language shift. Worth revisiting wording like "founder community" / "as a founder" if full consistency with the sharpened audience language is wanted — not urgent, but flagged for the brand/style guide companion doc.

---

## PHASE 7 — Landing Page (Built Asset)

**Status:** A complete, functioning HTML landing page has been built and saved as a project file (`she-starts-over.html`). It is NOT on Carrd — it's a standalone HTML file that can be hosted via Netlify Drop, GitHub Pages, or used as a structural/copy reference if rebuilt in Carrd.

**Design system:**
- Colours: deep burgundy (`#6B1E2E`) as primary, dusty rose/mauve (`#B8788A`) as accent (changed from an initial terracotta/orange accent, which clashed) — full palette defined in the file's CSS `:root` variables.
- Fonts: DM Sans (body, clean/modern sans-serif) + Playfair Display (headings, serif with personality) — loaded via Google Fonts.
- Tone: warm, editorial, intimate — burgundy full-bleed section used as a deliberate bold visual break.

**Section structure (in order):** Hero → Identity ("this space is made for you if...") → Solution → What's Included (4 features) → Who It's For / Not For → How It Works (3 steps) → Founder Story (Urte's bio, photo placeholder) → Testimonials (placeholders) → Founding Member Offer (price hidden, CTA to book a call) → She Connects (soft secondary CTA) → Closing → Footer.

**Copy reflects the Phase 2 sharpened audience** (solopreneur language, personal-brand/service-business specifics, explicit "not for you if raising VC funding / digital nomad without timezone / scale-faster energy" filtering) — this was a full pass applied after the initial draft.

**Outstanding items to finalize before publishing:**
- [ ] Replace placeholder Calendly link with real one (Urte confirmed she already has Calendly set up — just needs inserting into the HTML)
- [ ] Replace placeholder Eventbrite link with real She Connects event link
- [ ] Add 2–3 real testimonials (workshop testimonials can be used now; community-member testimonials to be requested — template message for this was drafted, see below)
- [ ] Replace founder photo placeholder once brand shoot is complete (shoot is booked at Moxy Hotel Amsterdam; outfit and styling discussed — warm neutrals recommended over on-trend brand colours, since colours may still evolve)

**Testimonial request template (for existing community members):**
> "Hi [name] — I'm launching a landing page for She Starts Over and would love to include a short testimonial from you. Would you be comfortable sharing 2-3 sentences about your experience — specifically what the community or our conversations have meant to you as a founder? Completely fine if not! 🧡"

---

## PHASE 8 — Naming Exploration (OPEN / UNRESOLVED)

**Status: not finalized. Does not block any current launch activity.**

**Key decision already made:** "She Starts Over" will remain the main personal/umbrella brand (carries Urte's story, LinkedIn equity at ~5.5k followers, founder journey narrative). A *separate* name was being explored for the community itself as a product — with room for additional products (e.g. coaching) to sit under the She Starts Over umbrella later.

**Reasoning for why a new name was even being considered:** "She Starts Over" describes a starting-over narrative that the *new*, more established target audience may not see themselves in. But Urte decided NOT to rename the umbrella brand itself, partly because her own journey now spans starting-over → building, so the name still holds true to her arc — it just may not need to be the *product* name for the community specifically.

**Directions explored and rejected, with reasons (avoid re-treading these):**
- "Your Corner" — strong, warm, but has a double meaning risk ("hiding in a corner" vs. "championing your corner" vs. "your corner of the internet" — the last reframe redeemed it somewhat but it remained unresolved)
- "Her Corner" / "Her Circle" — Her Circle already exists as a brand; Her Corner inherits the same ambiguity as Your Corner
- "She's in Your Corner" — too long for a name, reads as a tagline; also centres the brand on Urte personally in a way that may limit future peer-to-peer brand expansion
- "Founders Table" — already exists as a brand in Amsterdam
- "Dare" / "Your Corner to Dare" / "Her Project" — tested against the four core desired feelings (warm, welcoming, safe, inspiring) and found to lean too heavily into boldness/risk-taking at the expense of warmth and safety
- "Bloom," "Elevate," "Belonging," "Becoming," "Gathering," "Homeroom," "The Living Room," "Common Room" — all explored as single words or short phrases; none reached a clear "yes," though **Belonging** and **Homeroom** generated the most positive reaction before the conversation moved to execution priorities

**The four non-negotiable feelings established for the name to evoke:** warm, welcoming, safe, inspiring. (Earlier, a longer list included expansive, supported, seen, validated, genuine friendship — these remain true to the brand but were narrowed to the four above as the actual naming brief.)

**Last stated preference before pausing:** Urte said she wants the name to emphasize *space* and *connection* rather than a verb/feeling-based abstraction — this reopens the "room/space" word family (Living Room, Common Room, etc.) as the more promising direction versus the verb-based direction (Belonging, Becoming, Gathering).

**Recommended process for resuming this (a methodical naming framework was researched and provided):**
1. Lock non-negotiable criteria (already done: warm, welcoming, safe, inspiring + space/connection emphasis)
2. Shortlist to 5–7 real contenders only
3. Run a "telephone test" — say each name out loud in a real sentence ("Welcome to ___") and notice if it needs explaining
4. Check domain + Instagram handle + basic trademark/conflict search for every finalist BEFORE getting attached
5. Test the shortlist with 3–5 real people matching the target audience, with zero context first, then with the tagline
6. Sit with the final choice for 48 hours, written out everywhere it would actually appear (hero section, Instagram bio, email signature) before locking it in

**Recommendation given in-chat:** resolve this only once there's spare bandwidth — it does not block She Connects, the brunch, the application form, or the landing page launch, all of which work fine under "She Starts Over" as currently published.

**Session 2 update — new direction explored: using "She Connects" itself as the community/product name**, since it already exists as the event name and carries some recognition. Caveat raised: a possibly-dormant business already uses "She Connects" — worth verifying it's genuinely defunct (checking for an active trademark registration, not just an inactive website/socials) before building on it, since those are different things.

**Variations tested on "She Connects + [word]," with availability findings:**
- **She Connects Hub** — more structural/functional feeling, less warm than Club or Collective
- **She Connects Club** — warm, immediately legible as paid membership, slight retro elegance — but **already exists, taken**
- **She Connects Collective** — peer-powered, communal, current — but **already exists, taken**. Also flagged: "collective" is trending toward overused in women's business/wellness spaces, similar to how "tribe" became saturated
- **She Connects Circle** — not yet confirmed as taken; reinforces equality/no-hierarchy (fits the peer-support model better than Club's host-led connotation or Collective's trend-saturation risk) — **worth checking availability next**
- **She Connects Lounge** — also not yet confirmed as taken; ties back to the "space and connection" preference (Phase 8 original) by adding a literal sense of place
- Other wordplay considered and set aside as weaker: "She, Connecting," "The She Connection," "She Gathers/Belongs/Links/Meets/Bonds/Unites," "The Connect," "Connect, By She," "In Connection," "She, Connected"

**Status: still unresolved.** "She Connects Circle" and "She Connects Lounge" are the two live contenders not yet confirmed as taken — next step is the same domain/Instagram/trademark check recommended in the original naming framework above, before getting attached to either.

---

## PHASE 9 — Outreach, Referrals & Operational Support

**LinkedIn outreach — cold/new connections (warm-up approach, no event ask in first message):**
> "Hi [Name] 👋 I came across your profile and loved [something specific]. It's clear you're building something real. I'm always curious how other solopreneurs are finding the journey — the wins are great, but I think people don't talk enough about how isolating it can feel sometimes... How are you finding it lately? Do you have a solid circle of people around you who get it, or does it ever feel like you're navigating it mostly on your own? Urte 🧡"

Follow-up (only sent after they reply, used to naturally introduce She Connects):
> "...I'm actually hosting a small online event called She Connects on August 19th — built exactly around this, female solopreneurs having real conversations instead of typical networking. Would you be curious to join? Happy to send details either way."

**Amsterdam-based outreach for the September brunch (warmer, more direct — people Urte has some existing connection to):**
> "I'm testing a new format for my community — an intimate, invite-only brunch for female solopreneurs on September 16th. Small group, real conversation, brunch included — €[price] to join. I think you'd be a great fit. Would you like to hear more?"

*(Note: price was added into this message after the gap was identified — originally the message didn't mention payment at all, which risked feeling like a bait-and-switch once an Eventbrite paywall appeared later. Price must be stated upfront in any future iteration of this message, even briefly.)*

**Confirmation message once she says yes:**
> "So glad you're interested! Here's what to expect: Saturday, September 16th, brunch somewhere cosy in Amsterdam, max 12 women, real conversation, no pitching. It's €[price] to join, which covers brunch. You can grab your spot here: [Eventbrite link] — spots are limited so I'd love for you to secure yours soon. Once you're in, I'll send the exact location closer to the date."

*(Open item: exact brunch ticket price not yet finalized — €45 was modelled in the revenue calculator, but this needs confirming before the message above goes out. Also unconfirmed: whether September 16th actually falls on a Saturday — flagged to double check.)*

**Friend network referral ask (for sourcing Amsterdam-based brunch attendees):**
> "I'm building a small community for female solopreneurs in Amsterdam and is hosting an intimate founders brunch in September. I thought of you! Would you be interested? Happy to connect you if so." *(forwardable version, designed so friends can pass it on with minimal effort — removing friction increases follow-through)*

**Event-day support (physical brunch only):** A trusted friend (skilled at organization/curation) has agreed to help for free. Role: backup support for no-show calls, answering phone/email if someone can't find the venue, helping moderate conversation, handing out branded bags at the end. Recommendations made: give her a simple one-page brief per event (who's expected, timing, her specific responsibilities, edge-case scripts), be explicit about what "curating the conversation" means in practice (joining in vs. actually co-facilitating), and offer a meaningful non-monetary thank you (free founding membership, dinner, or genuine public credit) even though she's not charging — free help from a friend still has relationship costs worth tending to.

**Online event (She Connects) does not require this kind of support** — Urte plans to run it solo.

---

## PHASE 10 — Winding Down the Current (Free) Community (NEW this session)

**Context:** Separate from the new paid community being built, Urte still has an existing free community group with low/zero engagement and a standing bi-weekly connection call. Three women were messaged individually about the upcoming call: one is job hunting and stepping back (not focusing on the group right now), one is going through a breakup and a hard personal period, one still wants the call and is happy to do it 1:1. Five other women in the group were also messaged individually; some did not reply at all.

**Key distinctions made, useful if this situation recurs:**
- These three women are in genuinely different situations, not one uniform "disengagement" problem — treating them identically (e.g. one group blast) would serve the still-interested woman poorly and feel tone-deaf next to someone navigating a breakup.
- "Cancelling a 1:1 call" and "winding down/ending the whole community" are two separate decisions that got conflated initially — worth keeping them distinct going forward.
- Since this is specifically a **recurring bi-weekly group call** (not ad hoc 1:1s), a brief group message about pausing *the calls* is appropriate — but this is not the same as a full "I'm pivoting" announcement, which was deliberately deferred.

**Decision made: pause (not end) the bi-weekly calls, via a short, low-key group message — not a full pivot announcement.** Rationale: with most of the group going quiet or in personal crisis, a "here's my big pivot" message right now would land tone-deaf. The bigger "here's what I'm building next" story is being deliberately saved for after She Connects and the brunch generate real momentum and a clearer narrative to tell — rather than announcing a still-unvalidated pivot.

**Group message sent/drafted for pausing the calls:**
> "Hi all 🧡 Given where everyone's at right now, I'm going to pause our bi-weekly connection calls for the time being rather than have them feel like one more thing on the calendar. If that changes for any of you, just let me know — happy to do something 1:1 instead. Thinking of you all 🧡"

**Separate, personal (non-community-related) outreach recommended for the woman going through a breakup:** not a community message at all — just a human check-in, e.g. "saw your message, sending you so much warmth, no pressure to engage with anything right now, just want you to know I'm thinking of you." This is a relationship moment, not a community-management moment.

**For the woman stepping back to job-hunt:** simple, warm, no guilt — "totally understand, sounds like the right focus for you right now, the door's always open" — and let the call go without chasing further.

**For the one woman who still wants to talk:** keep the call. She's the one live, real signal in this group — don't let the others' silence cause doubt about her genuine interest.

---

## PHASE 11 — Site Infrastructure & v2.0 Build (Session 3)

**GitHub + Vercel setup:**
- Repo created, `index.html` uploaded, Vercel connected — site live on `.vercel.app` URL
- Critical: file must be named `index.html`, not `she-starts-over.html` — Vercel serves `index.html` at root. Any other name = 404.
- Domain not yet purchased (deferred). Site works on `.vercel.app` in the meantime.

**Email decision:**
- Use **Gmail** for infra tools (GitHub, Vercel, domain registrar, Umami) — invisible to members, reliable for recovery
- Use **`urte@shestartsover.com`** for all member-facing tools (Calendly, Brevo, Eventbrite, Tally)
- Owning the domain ≠ having a working inbox. Business email needs separate hosting (Google Workspace ~€6/mo or Zoho free) before it can be used anywhere

**v2.0 HTML build — what changed:**
Full detail in `changelog.md`. Summary:
- Hero: full typographic redesign — poster-style layout, "an inner circle" as dominant visual element in massive Playfair italic
- Hero: three ambient floating blobs (CSS-only), 8-element stagger load animation (pure CSS)
- Features: CSS 3D flip cards with Web Audio API paper SFX on each flip
- Steps: filled circle numbers + connector line draws on scroll
- Buttons: full pill, gradient, shine sweep on hover (site-wide)
- Nav: two-line logo (wordmark + italic tagline), scroll-triggered shadow, pill CTA
- Added: scroll progress bar, back-to-top, cursor glow, heartbeat 🧡 animations, countdown timer
- Added: word-by-word reveal on closing headline, section stagger reveals throughout
- Fixed: copyright year 2025 → 2026, `rel="noopener noreferrer"` on all external links, favicon, meta description

**Documentation created this session:**
- `changelog.md` — file version history
- `build-journal.md` — session log + lessons learned
- `roadmap.md` — phase-by-phase status tracker with revenue targets

---

## Reference: Key Numbers At A Glance

| Item | Value |
|---|---|
| She Connects ticket price | €25 |
| She Connects date/time | August 19 (day of week to verify), 12PM CET, online |
| She Connects capacity | 12 attendees |
| Brunch venue | Zoku, Amsterdam |
| Brunch date | September 16th (day of week to confirm — message drafts assume Wednesday) |
| Brunch time window | 12:00–14:00 (2 hrs, to be reconfirmed with venue) |
| Brunch capacity | Max 12 |
| Brunch ticket price | **€35pp, confirmed** (includes buffet) |
| Brunch venue cost | €27pp |
| Brunch margin | ~€8pp × 12 = €96 total, must also cover Urte's own seat + bag contents (~€69 net surplus) |
| Founding member rate | €30/month for first 6 months |
| Regular member rate (post-founding) | €60/month |
| Founding member cohort size | 10–15 women |
| Revenue target (to consider quitting 9-5) | €2,000/month net |
| Current LinkedIn following | ~5.5k |
| Current work schedule | 4 days/week at 9-5, ~8-12 hrs/week available for She Starts Over |

