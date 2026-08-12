# She Starts Over — Document System
*Version 1.0 | Created June 2026*
*What to build, why, and in what order.*

---

## How to read this

Each document has a **priority** (build now / build soon / build later) and a **trigger** — the moment when it becomes useful enough to justify creating it. Don't build everything at once. Build it when you need it.

---

## Tier 1 — Build Now (you need these to operate)

### 1. `business-overview.md` ✅ EXISTS
- **What it is:** Single-page summary of the entire business — why, what, how, who, model, numbers
- **Why you need it:** Drop into any new Claude chat to give instant full context. Also useful for onboarding a collaborator, VA, or future team member.
- **Keep it updated:** after any major strategic decision (pricing change, new product, pivot)
- **Owner:** Urte

### 2. `master-doc.md` ✅ EXISTS
- **What it is:** Running log of every decision made, with full reasoning and copy
- **Why you need it:** The "why we decided this" document — prevents re-litigating old decisions
- **Keep it updated:** after every working session with Claude (add a new session block at the top)
- **Owner:** Urte

### 3. `landing-page.html` ✅ EXISTS
- **What it is:** The live website file
- **Why you need it:** It is the product's public face
- **Keep it updated:** via targeted edits only — never full rewrites
- **Owner:** Claude executes, Urte approves

---

## Tier 2 — Build Soon (within 4 weeks)

### 4. `changelog.md`
- **What it is:** A numbered log of every change made to any file, with date and what changed
- **Why you need it:** Lets you roll back a decision, track what version you're on, and give Claude a quick "here's where we are" reference without reading the whole master doc
- **Format:**
  ```
  v1.1 — June 20, 2026
  - Updated landing page hero headline
  - Added She Connects Eventbrite link
  ```
- **Trigger:** Start it now, before v1.1 of the site goes live
- **Owner:** Claude generates, Urte approves

### 5. `roadmap.md`
- **What it is:** Month-by-month plan from now through December 2026, with clear milestones
- **Why you need it:** Gives Claude (and you) a shared view of what matters now vs. later — stops low-priority work creeping in
- **Format:** Month / milestone / status (not started / in progress / done)
- **Trigger:** Build before September — by August your calendar will get complex
- **Owner:** Urte writes, Claude formats

### 6. `outreach-tracker.md` or spreadsheet
- **What it is:** Simple list of every person contacted, what stage they're at, and next action
- **Columns:** Name / Platform / Date contacted / Stage (cold → warm → event attendee → call booked → joined) / Notes / Next step
- **Why you need it:** Once you're managing 20+ conversations across LinkedIn and email, things fall through the cracks without a tracker
- **Trigger:** Start it the moment you begin She Connects outreach — i.e. this week
- **Owner:** Urte maintains; Claude can help build the template

### 7. `pricing-and-offers.md`
- **What it is:** Single source of truth for every price, every offer, every discount
- **Why you need it:** Prices have already changed multiple times in development (She Connects went from €20 → €35 → €25; brunch went from €45 → €35). A single doc prevents confusion when copy is being written or when Claude is building anything that references a price.
- **Contents:** Current live prices, legacy prices (for reference), what's included at each level, what's hidden/public
- **Trigger:** Before the Eventbrite listings go live — you need this locked before anything is published
- **Owner:** Urte writes, Claude formats

---

## Tier 3 — Build Later (when the activity becomes frequent enough)

### 8. `event-runbook.md`
- **What it is:** Step-by-step operational checklist for running She Connects and the brunch — who does what, when, with scripts for edge cases
- **Why you need it:** When you're running events monthly, you can't reconstruct the plan from scratch each time
- **Contents:** Pre-event checklist / day-of checklist / post-event checklist / scripts / edge cases (no-show, tech failure, awkward moment)
- **Trigger:** After She Connects August 19 — build it from what actually happened, not what you planned
- **Owner:** Claude builds from your debrief notes

### 9. `build-journal.md`
- **What it is:** A running log of what's been built, tested, and the outcome
- **Format:**
  ```
  August 19, 2026 — She Connects
  Attendees: 8 / 12 spots filled
  Converted to calls: 3
  Joined as founding members: 2
  What worked: Founder Circle topic was pre-selected — no awkward silence
  What to change: Bingo rounds felt rushed at 15 min — extend to 20 next time
  ```
- **Why you need it:** Separates "what we assumed" from "what actually worked" — the only way to improve over time
- **Trigger:** After the first event runs
- **Owner:** Urte writes debrief; Claude can structure it

### 10. `brand-style-guide.md`
- **What it is:** Colours, fonts, logo rules, voice, tone, do's and don'ts in one place
- **Why you need it:** Right now brand decisions live scattered across the master doc and the HTML file. Once you have a VA, a collaborator, or you're producing content at volume, you need a single reference.
- **Contents:** Colour palette with hex codes / fonts / logo usage / voice rules / banned words / approved phrases / example headlines (good vs. bad)
- **Trigger:** Once the community product name is finalized — the name feeds into the brand guide
- **Owner:** Claude generates from existing decisions; Urte approves

### 11. `site-architecture.md`
- **What it is:** A map of the website — what pages exist, what each one does, what links where, what tools are embedded (Calendly, Eventbrite, Typeform)
- **Why you need it:** As the site grows (She Connects page, brunch page, member area, blog), you need a map so nothing breaks and Claude knows where everything lives before touching any file
- **Trigger:** When the site has more than 2 pages
- **Owner:** Claude generates, Urte approves

### 12. `member-onboarding.md`
- **What it is:** The exact sequence a new member goes through from "call completed → paid → first session"
- **Contents:** Welcome email / what to do first / lounge intro format / what to expect in week 1
- **Trigger:** When the first founding member joins
- **Owner:** Claude drafts, Urte personalizes

---

## Summary: What to Build and When

| Document | Build when | Priority |
|---|---|---|
| business-overview.md | ✅ Done | — |
| master-doc.md | ✅ Done | — |
| landing-page.html | ✅ Done | — |
| changelog.md | Now, before v1.1 | HIGH |
| outreach-tracker | This week, before outreach starts | HIGH |
| pricing-and-offers.md | Before Eventbrite listings go live | HIGH |
| roadmap.md | Before August | MEDIUM |
| event-runbook.md | After first event | MEDIUM |
| build-journal.md | After first event | MEDIUM |
| brand-style-guide.md | After product name is finalized | LOW |
| site-architecture.md | When site has 2+ pages | LOW |
| member-onboarding.md | When first member joins | LOW |
