# She Starts Over — Tools Site Build Plan
# v1.0 — 2026-08-12 | COMPLETE — all pages built and live as of Session 8
# Keep this file as reference. Do not delete — used as context in future sessions.

---

## Context

Private admin CRM and tooling site for Urte (She Starts Over founder) and Geri (technical operator).
URL: `tools.shestartsover.co`
Repo: `she-starts-over-tools` (private, under pocsgeri1 GitHub)
Vercel: Geri's personal Vercel account
Security: simple sessionStorage login page for now, Cloudflare Access gate to be added later

**This site is completely separate from the public marketing site.**
- Public site: `she-starts-over` repo → `shestartsover.co` — do not touch
- Tools site: `she-starts-over-tools` repo → `tools.shestartsover.co` — this is what we're building

---

## Stack

- Plain HTML/CSS/JS — no framework, no build step, no npm, no bundler
- One shared `assets/style.css` imported by every page
- One shared `js/supabase.js` (Supabase client init) imported by every page
- One shared `js/utils.js` (helpers) imported by every page
- `js/ai.js` for Claude API calls
- Supabase: Postgres database + REST API (credentials in Vercel env vars)
- Claude API: AI features (called via Vercel serverless function `/api/ai.js` — never directly from the browser, to protect the API key)
- Vercel env vars already set: `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`, `CLAUDE_API_KEY`

---

## UI/UX Quality Standard — Non-Negotiable

This site must feel like a premium internal product. Not a scrappy admin page. Think Notion, Linear, Superhuman — clean, fast, considered.

Rules that apply to every page, every component:

- She Starts Over design tokens throughout: burgundy `#6B1E2E`, dusty rose `#B8788A`, cream `#FDF8F5`, ink `#1C1410`. Same tokens as the marketing site.
- DM Sans for all UI text. Playfair Display for page headings and section titles only.
- Every state transition is animated: sidebar open/close, modal appear/disappear, card expand, status badge change, checklist item complete. No instant jumps.
- Default easing: `cubic-bezier(0.4, 0, 0.2, 1)`. Duration: 0.2–0.35s for micro-interactions.
- `@media (prefers-reduced-motion: reduce)` overrides on every animation block — collapse to 0ms.
- All interactive elements have `:focus-visible` outlines (2px solid burgundy).
- All touch targets minimum 44×44px.
- Loading states on every async operation (data fetch, AI call, form submit) — never a blank wait.
- Empty states designed intentionally — "No members yet. Add your first founding member." with a CTA, not a blank table.
- Error states handled gracefully — inline, human-readable, never a raw JS error.
- Every form has inline validation before submit.
- Mobile-aware layout — this is primarily a desktop tool but must not break on iPad (768px minimum).
- No hardcoded hex values — all colors via CSS custom properties.
- No external libraries beyond Supabase JS client and the existing Google Fonts already loaded.

---

## File Structure

```
she-starts-over-tools/
├── index.html              ← dashboard
├── members.html            ← member list
├── member.html             ← individual member view
├── new-member.html         ← add member form
├── health.html             ← community health dashboard
├── login.html              ← password gate (sessionStorage)
├── assets/
│   └── style.css           ← all shared tokens, resets, components
├── js/
│   ├── supabase.js         ← Supabase client init + auth check
│   ├── ai.js               ← Claude API calls (via /api/ai.js serverless)
│   └── utils.js            ← shared helpers (date formatting, status badges, etc.)
└── api/
    └── ai.js               ← Vercel serverless function (protects Claude API key)
```

---

## Build Order

Build in this exact sequence. Do not skip ahead.

1. SQL schema (paste into Supabase SQL Editor)
2. `assets/style.css` + `js/supabase.js` + `js/utils.js` — shared foundation
3. `login.html` — sessionStorage auth gate
4. `index.html` — dashboard
5. `members.html` — member list
6. `member.html` — individual member view
7. `new-member.html` — add member form
8. `health.html` — community health dashboard
9. `api/ai.js` — Vercel serverless function
10. `js/ai.js` — AI feature calls wired into member.html and members.html

---

## Phase 1 — SQL Schema

Paste this entire block into Supabase → SQL Editor → Run.

```sql
-- Members
create table members (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text unique not null,
  linkedin_url text,
  photo_url text,
  business_name text,
  business_description text,
  what_they_do text,
  who_they_help text,
  location text,
  timezone text,
  joined_date date,
  cohort text check (cohort in ('founding', 'regular')),
  status text check (status in ('active', 'alumni', 'churned', 'pending')) default 'pending',
  founding_rate_expires date,
  current_challenge text,
  what_they_offer text,
  what_they_seek text,
  application_answers jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Member notes (append-only log — never edit, only insert)
create table member_notes (
  id uuid primary key default gen_random_uuid(),
  member_id uuid references members(id) on delete cascade,
  note_text text not null,
  note_type text check (note_type in ('general', '1on1', 'observation', 'introduction', 'testimonial', 'risk')),
  created_at timestamptz default now()
);

-- Onboarding checklist steps
create table onboarding_steps (
  id uuid primary key default gen_random_uuid(),
  member_id uuid references members(id) on delete cascade,
  step_name text not null,
  step_order int not null,
  completed boolean default false,
  completed_at timestamptz,
  created_at timestamptz default now()
);

-- Offboarding checklist steps
create table offboarding_steps (
  id uuid primary key default gen_random_uuid(),
  member_id uuid references members(id) on delete cascade,
  step_name text not null,
  step_order int not null,
  completed boolean default false,
  completed_at timestamptz,
  created_at timestamptz default now()
);

-- Events
create table events (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  type text check (type in ('she_connects', 'brunch', 'weekly_session', 'other')),
  event_date date,
  capacity int,
  ticket_price numeric(10,2),
  notes text,
  created_at timestamptz default now()
);

-- Event attendance
create table event_attendance (
  id uuid primary key default gen_random_uuid(),
  member_id uuid references members(id) on delete cascade,
  event_id uuid references events(id) on delete cascade,
  attended boolean default false,
  notes text,
  created_at timestamptz default now(),
  unique(member_id, event_id)
);

-- Member tags
create table member_tags (
  id uuid primary key default gen_random_uuid(),
  member_id uuid references members(id) on delete cascade,
  tag text not null,
  created_at timestamptz default now()
);
```

---

## Phase 2 — Shared CSS & JS Foundation

### `assets/style.css`

Define all CSS custom properties matching She Starts Over brand tokens. Then build:
- Reset + base typography (DM Sans body, Playfair Display headings)
- Layout: sidebar nav (240px fixed left) + main content area
- Component library: status badges, cards, buttons (primary/secondary/ghost), form inputs, checkboxes, modals, tooltips, loading skeletons, empty states, inline alerts

Sidebar nav items:
- Dashboard (home icon)
- Members (people icon)
- Add Member (plus icon)
- Health (chart icon)
- Divider
- Settings (gear icon — placeholder for now)

### `js/supabase.js`

- Initialize Supabase client using `SUPABASE_URL` and `SUPABASE_ANON_KEY` from env vars (Vercel injects these at build time via a tiny inline script tag — see note below)
- Export `supabase` client for use across all pages
- Include auth check function: if sessionStorage token missing, redirect to login.html

**Note on env vars in plain HTML:** Vercel doesn't automatically inject env vars into static HTML files. The approach: a Vercel serverless function at `/api/config.js` returns the public vars as JSON. Pages fetch this on load. The service_role key and Claude API key never touch the browser — they only live in serverless functions.

### `login.html`

- She Starts Over branded page (cream background, burgundy logo wordmark)
- Single password field + submit button
- On correct password: set `sessionStorage.setItem('sso_auth', 'true')`, redirect to index.html
- On wrong password: inline shake animation + "Incorrect password" message
- Password hardcoded in the JS for now (replace with Cloudflare Access later)

---

## Phase 3 — Dashboard (`index.html`)

**Layout:** sidebar nav (left) + main content (right)

**Content sections:**

**Header row — 4 stat cards:**
- Total active members (founding + regular)
- Current MRR (founding members × €30 + regular × €60)
- Onboarding completion rate (% of members with all steps done)
- Members at risk (inactive 14+ days)

**Onboarding alerts panel:**
- List of members with incomplete onboarding steps older than 3 days
- Each row: member name + photo + which steps are missing + "View member" link
- Empty state: "All members are fully onboarded 🤍"

**At-risk members panel:**
- Members with no activity in 14+ days OR never attended an event
- Members whose founding rate (€30) expires within 30 days — flagged for proactive outreach
- Each row: member name + last activity + reason for flag + "View member" link

**Recent activity feed:**
- Last 10 notes added across all members (chronological)
- Shows: member name + note type badge + first 80 chars of note + timestamp

---

## Phase 4 — Members List (`members.html`)

**Layout:** sidebar nav + full-width table

**Controls row:**
- Search input (filters by name, business, email in real time)
- Filter dropdown: All / Active / Alumni / Churned / Founding / Regular
- Filter dropdown: Tags
- Button: "Add member" → links to new-member.html

**Table columns:**
- Photo (avatar, 36px circle)
- Name + business name (stacked)
- Status badge (colour-coded: active=burgundy, alumni=dusty rose, churned=grey, pending=amber)
- Cohort badge (founding / regular)
- Join date
- Onboarding progress (5-dot indicator or "100%" text)
- Last note date
- Events attended count
- Actions: "View" button

**Row click:** navigates to `member.html?id=[uuid]`

**AI button** (top right of page):
- "Suggest introductions" → calls AI introduction matcher across all active members → results shown in a slide-in panel

---

## Phase 5 — Individual Member (`member.html`)

Loaded with `?id=[uuid]` query param. Fetches full member record + all related data on load.

**Layout:** sidebar nav + two-column content (left: profile + AI tools, right: checklists + notes)

**Left column:**

Profile card:
- Photo, name, status badge, cohort badge
- Business name + description
- LinkedIn link (opens new tab)
- Location + timezone
- Join date + founding rate expiry (if applicable)
- Edit button → opens inline edit mode for all fields

What she does / who she helps / current challenge / what she offers / what she seeks:
- Displayed as labelled fields
- All editable inline on click

Tags:
- Pill tags displayed, click × to remove
- "Add tag" input

Application answers:
- Collapsible section
- Displays raw answers from Tally/onboarding form (stored as JSON)

AI Tools panel:
- "Prepare for 1:1" button → generates pre-1:1 brief (see AI features)
- "Draft follow-up email" button → opens text input for raw notes → generates post-1:1 email
- "Draft welcome email" button → generates personalized onboarding email
- "Prep exit interview" button → visible only when status = churned/alumni
- All AI outputs display in an expanding panel below the button with copy-to-clipboard

**Right column:**

Onboarding checklist:
- 7 steps with checkbox + timestamp when completed
- Steps: Joined Circle / Payment method added / Circle profile completed / Introduced herself in member network / Attended Welcome Ceremony / Attended first event / Connected with another member
- Progress bar at top (e.g. 5/7)
- Checking a box auto-saves to Supabase + records timestamp

Offboarding checklist (hidden unless status = churned/pending-churn):
- 9 steps: Cancellation received / Confirmation email sent / End date calculated / Exit 1:1 invited / Exit 1:1 completed / Feedback recorded / Circle access removed / Alumni offer made / Database updated
- Same checkbox + timestamp pattern

Events attended:
- List of events with attended toggle
- "Add event attendance" dropdown

Notes log:
- Chronological, newest first
- Each note: timestamp + type badge + note text
- Append-only — no edit or delete
- Add note form at top: type selector (dropdown) + text area + "Add note" button
- On submit: inserts to `member_notes`, refreshes list, clears form

---

## Phase 6 — Add Member (`new-member.html`)

Clean form page. On submit:
1. Creates member record in Supabase
2. Auto-generates 7 onboarding steps (all uncompleted) for that member
3. Auto-generates 9 offboarding steps (all uncompleted) for that member
4. Redirects to `member.html?id=[new-uuid]`

Fields:
- Name (required)
- Email (required)
- LinkedIn URL
- Photo URL (paste a URL for now — file upload later if needed)
- Business name
- Business description
- What she does / who she helps
- Location / timezone
- Joined date (date picker, defaults to today)
- Cohort (founding / regular — dropdown)
- Founding rate expiry (auto-calculated as joined date + 6 months if founding, editable)
- Current challenge
- What she offers
- What she seeks
- Application answers (large text area — paste raw Tally answers, stored as text in JSON field)

---

## Phase 7 — Health Dashboard (`health.html`)

**Stat cards row:**
- Total members ever (including churned)
- Current active members
- Current MRR
- Churn rate (churned / total ever, %)
- Average onboarding completion time (days from join to all steps done)

**Charts (use Chart.js from CDN — exception to the no-external-library rule, approved):**
- MRR over time (line chart, monthly)
- Member status breakdown (donut chart: active/alumni/churned)
- Onboarding funnel (horizontal bar: how many completed each step)
- Event attendance per member (bar chart, top 10 most engaged members)
- Churn reasons (pie chart, pulled from offboarding notes tagged as 'risk')

**Revenue projection table:**
- Lists founding members with their expiry date
- Shows: current rate (€30) → new rate (€60) → date of change → MRR impact
- Running total: projected MRR after all conversions

---

## Phase 8 — AI Features (`api/ai.js` + `js/ai.js`)

### Vercel serverless function (`api/ai.js`)

Single function that accepts a `{ feature, data }` POST request and routes to the right Claude prompt. The Claude API key lives only here — never in the browser.

Features routed through this function:
- `introduction_matcher`
- `pre_1on1_brief`
- `post_1on1_draft`
- `at_risk_digest`
- `welcome_email`
- `exit_interview_prep`

### Feature prompts

**Introduction matcher**
Input: array of all active member objects (name, business, challenge, offering, seeking, location)
Output: 3 pairing suggestions. Each includes: member A name, member B name, 2-sentence "why these two" explanation, one draft opening line for the intro email.

**Pre-1:1 brief**
Input: full member object + all notes + events attended
Output: 1-paragraph "who she is and why she joined", bullet list of what's happened since joining, 4–5 tailored suggested questions for the call.

**Post-1:1 email draft**
Input: member name + raw notes Urte types in
Output: warm, personal follow-up email in Urte's voice. Structure: opening line / what I took away / any introductions promised / relevant upcoming events / soft close. Tone: editorial, intimate, no corporate language. Sign off: "Urte 🤍"

**At-risk weekly digest**
Input: all active members + their last note date + events attended + founding rate expiry
Output: plain-English summary. "X members need attention this week:" followed by name + specific reason for each flag.

**Welcome email personalizer**
Input: member name + business + application answers
Output: personalized Day 0 welcome email. References something specific from her application. Not generic. Tone: warm, like a letter from a friend who's been expecting you.

**Exit interview prep**
Input: full member object + notes + events attended + offboarding reason (if recorded)
Output: 6–8 tailored exit interview questions. Not generic — based on her actual history with the community.

---

## Phase 9 — Brevo Integration (separate session — do not build yet)

When a new member is added to the CRM, a webhook triggers Brevo automation:
- Day 0: Welcome email (personalized)
- Day 3: Introduction to another member (reminder to Urte to send manually)
- Week 3: 1:1 invitation email
- Month 5 week 3: Founding rate conversion notice (€30 → €60 next month)

Email sequence copy to be written in a dedicated session before this is built.

---

## Commit standard for this repo

```
feat: [vX.X] Description

- What was built
- Any decisions made
- Files touched
```

Version format: v0.1 (login + shared CSS), v0.2 (dashboard), v0.3 (members list), v0.4 (member view), v0.5 (add member), v0.6 (health dashboard), v0.7 (AI features), v1.0 (all pages complete + tested)
