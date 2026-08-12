# She Starts Over — Changelog
*Tracks every change to every file. Append new entries at the top.*

---

## Tools site v0.10 — August 12, 2026
**Repo:** `she-starts-over-tools` · **Session:** 9

### Fixed
- AI generating indicator always visible on page load (duplicate `display` property in inline style)
- Dashboard onboarding alerts panel showing "All members fully onboarded" incorrectly (filter excluded members with no join date or no step records)

### Added
- Inline note edit: pencil button on each note → textarea + Save/Cancel → `UPDATE member_notes` on Supabase
- Full rich-text toolbar on AI output cards: **B**, *I*, U, H2, ¶, bullet list, Copy, Delete
- `ai_outputs` Supabase table: all AI-generated content persisted, loaded on page open (SQL in session chat)

---

## Tools site v0.9 — August 12, 2026
**Repo:** `she-starts-over-tools` · **Session:** 8 (continued)

### Added
- Mobile bottom nav (fixed tab bar, burgundy) on all 6 pages — shows only at ≤768px
- Note delete (hard delete from `member_notes`, guarded by `window.confirm`)
- AI output history accordion: outputs saved to `ai_outputs` table, displayed newest-first below AI buttons, survive page reload
- Markdown rendering in AI output boxes: `**bold**` → `<strong>`, `*italic*` → `<em>`, `# headings`, `- bullets` — all parsed client-side with no dependency
- Favicon SVG added to all pages (burgundy circle, cream heart)

---

## Tools site v0.1–v0.8 — August 12, 2026
**Repo:** `she-starts-over-tools` · **Session:** 8
*Full build in one session — 8 phases. See build-journal Session 8 for detail.*

### Created (new repo, new files)
- `docs/schema.sql` (in main repo): 7 Supabase tables — members, member_notes, onboarding_steps, offboarding_steps, events, event_attendance, member_tags
- `assets/style.css`: complete She Starts Over design system (brand tokens, sidebar shell, all shared components)
- `assets/favicon.svg`: burgundy circle + cream heart
- `js/supabase.js`: async config fetch, Supabase client init, `requireAuth()` guard
- `js/utils.js`: formatting helpers, badge generators, Supabase write helpers, step/note utilities
- `api/config.js`: Vercel serverless — serves public Supabase credentials only
- `api/ai.js`: Vercel serverless Claude proxy — 6 AI features, model `claude-haiku-4-5-20251001`
- `login.html`: branded password gate, sessionStorage auth token
- `index.html`: dashboard — stat cards, alerts panels, founding countdown, activity feed
- `members.html`: member list — live search, filters, sortable table, AI introduction panel
- `member.html`: member profile — inline edit, tags, application answers, AI tools, checklists, notes
- `new-member.html`: add member — live avatar preview, founding-rate auto-calc, creates 16 onboarding/offboarding steps on save
- `health.html`: community health — Chart.js (approved CDN exception), MRR/status/funnel/attendance charts, revenue projection table

---

## v3.0d — July 19, 2026
**File:** `index.html` · **Session:** 7

### Changed
- All 5 orange heart emoji (🧡) replaced with white hearts (🤍): nav CTA, hero CTA, founding-offer CTA, how-it-works CTA, closing CTA, footer tagline
- Flip card 2 ("Your Inner Circle"): `overflow-y: hidden` added via `.flip-card:nth-child(2)` override — scrollbar removed (text already trimmed to fit in v3.0c)
- Founder story body fully rewritten a second time this session — same 2-col-grid → full-width-flow structure retained; grid still closes at "...everything depends on them."

### Note
- 3 em-dashes in the user's supplied draft converted to commas per the no-em-dash house rule (set Session 6) — applied silently, flagged in chat
- Bold emphasis kept on the same 3 lines as the prior founder-text version (reflective questions / core belief line / closing line) — new draft had no bold markers, judgment call to preserve established pattern, flagged in chat

---

## v3.0c — July 19, 2026
**File:** `index.html` · **Session:** 7

### Changed
- Founder Circles card back-text trimmed to a single sentence (dropped the "Bring the challenge..." opening line)
- Your Inner Circle card back-text trimmed (dropped "The 3 AM thoughts. The small wins. The honest conversations.")
- "They change how it feels to build it." bolded in Solution section
- Solution section eyebrow label: "That's why She Starts Over exists" → "Our philosophy"

### Note
- The eyebrow label was the only text in the file matching the user's quoted line — treated as best-match, flagged in chat as an assumption

---

## v3.0b — July 19, 2026
**File:** `index.html` · **Session:** 7

### Added
- `.container-full` (1180px) — new wrapper class, used to widen the flip-card row beyond the 960px `.container-wide` used by the section heading above it
- `overflow-y: auto` on `.flip-card-front` / `.flip-card-back` — standing safety net against text overflow on any card
- `.founder-text-full` block (+ hairline divider) — holds the back half of the founder story, flows full-width below the photo+text grid

### Changed
- `.features-grid`: forced to `repeat(4, 1fr)` at ≥860px viewport (single row of 4, centered in `.container-full`); `auto-fit` fallback retained below that breakpoint
- Flip-card back-text: `0.87rem`/`1.72` line-height → `0.82rem`/`1.62` (fits comfortably at the narrower per-card width in a 4-across row)
- Founder section `h2`: line-break added before "She" so "She Starts Over exists" holds together on line 2
- Founder section split: photo+text grid now ends at "...everything depends on them."; remaining 3 paragraphs moved into `.founder-text-full`, full width
- Not-for-you list bullet marker: `—` → `✗`
- Founding-spots badge (`.offer-meta`): `12px` / regular weight / 55% opacity → `14px` / weight 600 / 82% opacity

### Note
- Divider line above the full-width founder text block was an unrequested addition — flagged in chat, easy one-line removal if unwanted

---

## v3.0a — July 19, 2026
**File:** `index.html` · **Session:** 7

### Added
- New 4th flip card: "Monthly Reset" (🌙 icon — Claude's pick, not user-specified, flagged in chat)

### Changed
- Flip card 1: "Weekly Sessions" → "Founder Circles", full copy rewrite
- Flip card 2: "Member Lounge" → "Your Inner Circle", full copy rewrite
- Flip card 4: "In-Person Gatherings" copy rewritten
- "This is for you if" / "This isn't for you if" — both 5-item lists fully replaced
- Closing headline: *"One meaningful conversation can change the trajectory of your business."* → *"Build a business that supports your life."* (word-reveal spans re-indexed 1–7, italic moved from "your" to "life.")
- Closing subtext: "You don't have to do it alone." → "You don't have to carry it all alone."
- Founder story: first full rewrite this session — 7 paragraphs, `<strong>` on the 3 lines the user marked with `**`, 3 em-dashes converted to colon/comma per house style

---

## v3.0 — July 19, 2026
**File:** `index.html` · **Session:** 7

### Changed (copy)
- Nav subtext, hero subtext, identity section body (4 paragraphs), solution heading (*"Because the right people..."* → *"What we believe"*) + body — all replaced with new copy per Urte's drafts

### Changed (structure)
- Founder section moved: was after How-it-Works → now right after Solution, before Included
- Photo Break B (workspace detail image) moved: was before Included → now between Included and For You
- How-it-Works / Three Steps section moved: was after For You → now right before Closing
- New section order: Hero → Identity → Solution → Founder → Included → Photo Break B → For You → Testimonials (hidden) → Photo Break C → Founding Offer → She Connects → How It Works → Closing → Footer

### Note
- All 5 sub-versions this session (v3.0 → v3.0d) diff-verified after every edit via section/div/`<strong>` tag-balance checks — no content lost or duplicated across the full rewrite pass

---

## v2.9 — July 3, 2026
**File:** `index.html` · **Session:** 6

### Fixed (root cause, mobile only)
- `.founder-photo` had a fixed `width: 420px` sitting inside a CSS grid column. On phones, grid items don't reliably shrink below their own fixed width even with `max-width: 100%` set — a known CSS grid quirk. This forced the whole founder section, and therefore the whole page, wider than the phone screen.
- This single bug was the cause of three symptoms reported at once: the "pinch to zoom out" feeling, the nav button wrapping to 2 lines, and founder-section text bleeding off the right edge on mobile
- Added `min-width: 0;` to `.founder-photo` — safe at every screen size, only matters when there isn't enough room
- Added `html, body { overflow-x: hidden; }` sitewide as a safety net against any horizontal scrollbar

### Changed
- `.founder-photo` on mobile only (≤640px breakpoint): explicit size cap added, `max-width: 260px` (down from 420px, ~38% smaller) — desktop and tablet untouched
- Nav CTA: text shortened "Become a member" → "I'm in"; added `white-space: nowrap` + `flex-shrink: 0` so it can never wrap again regardless of screen width; padding reduced (`0.58rem 1.4rem` → `0.5rem 1.1rem`) for a more compact, auto-sized pill
- Replaced 3 placeholder URLs (`YOUR-LIVE-URL-HERE`) with the real live domain `https://www.shestartsover.co/` — in `og:image`, `og:url`, `twitter:image`
- Removed 5 em-dashes from visible body copy (identity section ×3, for-you list ×2) — replaced with a colon where the dash introduced a list of examples, or a comma where it joined a qualifying clause. New house rule: no em-dashes in on-page prose going forward.

### Not changed
- Desktop layout, spacing, design — fully intact, verified via diff
- OG title/description/image content — set correctly in v2.8, no further edit needed here

### Note
- Brand-voice override: user suggested nav text "I'm in!" — dropped the exclamation mark per the existing house rule ("no exclamation marks unless already used on page"); landing page currently has zero exclamation marks anywhere. Flagged to Urte, not reversed unless she asks.

---

## v2.8 — July 3, 2026
**File:** `index.html` · **Session:** 6

### Added
- Open Graph tags: `og:type`, `og:title`, `og:description`, `og:image` (+ width/height), `og:url`
- Twitter Card tags: `twitter:card`, `twitter:title`, `twitter:description`, `twitter:image`
- Title copy: *"Building alone? You don't have to."* — reused verbatim from the existing closing-section line, not new copy
- Description copy: reused/trimmed from the existing `<meta name="description">` tag
- Image: `assets/group-photo-wide.jpg` (landscape group photo — chosen over the founder portrait, which is 3:4 vertical and would crop awkwardly in the 1200×630 preview box most platforms use)

### Fixed
- Root cause of a bad LinkedIn share preview: the file had zero Open Graph tags, so LinkedIn's crawler guessed a title from random on-page text (it picked up the "In-Person Gatherings" flip-card label) and an arbitrary image. Explicit tags now control this everywhere the link is shared (LinkedIn, WhatsApp, Slack, iMessage, X).

### Note
- Shipped with a placeholder URL (`YOUR-LIVE-URL-HERE`) since the live domain wasn't confirmed yet at build time — corrected in v2.9 once Urte confirmed `shestartsover.co`
- LinkedIn caches link previews per URL — after deploying, Urte needs to force a re-scan via linkedin.com/post-inspector, or the old broken preview may persist for days

---

## v2.7 — July 2, 2026
**File:** `index.html` · **Session:** 6

### Added
- `data-umami-event` attributes on 8 link/button elements:
  - `become-member-click` (×5 instances, tagged by `data-umami-event-location`: nav / hero / how-it-works / founding-offer / closing)
  - `not-sure-yet-click`, `linkedin-connect-card-click`, `eventbrite-reserve-click`, `footer-linkedin-click`
- JS: `flip-card-opened` event added to the existing flip-card click handler, tagged by card name (Weekly Sessions / Member Lounge / In-Person Gatherings)
- JS: `reached-founding-offer` event added to the existing `#offer` section IntersectionObserver
- JS: new `reached-she-connects` IntersectionObserver + event, mirrors the existing observer pattern (0.15 threshold)

### Changed
- Nothing else — no visual or behavioral change for visitors, purely tracking additions

---

## v2.6 — July 2, 2026
**File:** `index.html` · **Session:** 6

### Added
- Umami analytics tracking script in `<head>`, website ID `6157776d-fcdc-4c40-8c04-9516b5189a83`
- Cookieless, GDPR-compliant — no cookie banner required

### Changed
- Nothing else — single-line addition, diff-verified

---

## v2.5a — July 1, 2026
**File:** `index.html` · **Session:** 5

### Fixed
- Group photo crop direction reversed: `object-position` 68% → 32% (v2.5's fix moved the visible crop the wrong way)
- Removed periods from "She.Starts.Over" → "She Starts Over" — nav logo + founder section heading (only 2 occurrences existed, none elsewhere)

### Changed
- Founder photo enlarged to exactly match identity photo: 260px/5:6 ratio → 420px/3:4 ratio (identity photo itself untouched)
- Founder section outer container widened: `.container` (720px) → `.container-wide` (960px), matching Included section and photo-break width
- Founder-inner grid single-column breakpoint widened 640px → 860px — defensive addition (not explicitly requested) to stop the text column being crushed on tablet widths now that the photo column is a fixed 420px; mirrors the existing identity-inner pattern

---

## v2.5 — July 1, 2026
**File:** `index.html` · **Session:** 5

### Added
- Identity + Founder portraits: soft rounded corners (44px / 40px), 1.5px terracotta border, offset terracotta shadow-panel behind (translate 12px/10px), hover lift (scale + shadow, desktop-only effect, harmless on touch)
- Detail-workspace photo: same border + offset panel treatment; corners stay sharp (unchanged 6px radius)

### Note
- Full-bleed group photo deliberately excluded from border/panel treatment to preserve its immersive edge-to-edge design — flagged before building, not applied silently
- True circular crop (`border-radius: 50%`) rejected for portraits since their aspect ratios (3:4, 5:6) would distort into ovals — used soft rounded-rectangle instead

---

## v2.4 — July 1, 2026
**File:** `index.html` · **Session:** 5

### Changed
- Founder photo resized 200×240 → 260px / 5:6 ratio; `margin-top: 2.1rem` added so the image top aligns with "A little bit about why" heading instead of the "Hi, I'm Urte" eyebrow above it
- Group photo `object-position` set to `center 68%` to reduce head-cropping (later found to be the wrong direction — corrected in v2.5a)

### Removed
- Testimonials section hidden via `display:none` on `<section class="testimonials">` — markup fully preserved for reinstatement once real testimonials exist. The section had reappeared in the live project file despite being removed in v2.2 — see build-journal Session 5, Lesson 15.

---

## v2.3 — July 1, 2026
**File:** `index.html` · **Session:** 5

### Added
- Real images wired into all 4 photo slots via a new `assets/` folder in the GitHub repo:
  - `assets/urte-portrait-identity.jpg` → Identity section
  - `assets/detail-workspace.jpg` → Photo Break B
  - `assets/urte-portrait-founder.jpg` → Founder section
  - `assets/group-photo-wide.jpg` → Photo Break C (full-bleed)
- Removed "Photo coming soon" placeholder labels and the founder monogram placeholder markup
- Added `has-photo` modifier CSS per slot (removes dashed border/background, applies `object-fit: cover`)

### Note
- Old placeholder CSS (`.photo-placeholder-monogram` etc.) left in place, unused — harmless, avoids a rebuild if ever needed again

---

## v2.2 — June 30, 2026
**File:** `index.html` · **Session:** 4

### Removed
- Testimonials section removed entirely (HTML only) — no real testimonials or workshop quotes available yet. Will be re-added verbatim once quotes are supplied.
- CSS for `.testimonials`, `.testi-grid`, `.testi`, `.testi-quote`, `.testi-author` left in place in `<style>`, unused — avoids rebuilding from scratch on re-add.
- JS testimonial stagger-reveal block (`testiGrid` observer) now no-ops safely since `#testi-grid` no longer exists in the DOM — no error, no edit needed.

### Note
- v2.1 (same change) was built against a stale/incorrect `index.html` that existed in project files before the true live file was uploaded. v2.1 is superseded — v2.2 is the correct version, built and diff-verified against the actual live file.

---

## v2.0 — June 21, 2026
**File:** `index.html` · **Session:** 3

### Hero
- Full typographic redesign: quiet opener line → "You deserve" → massive italic *an inner circle* in burgundy → quiet closer line
- Three ambient floating blobs (pure CSS @keyframes, `transform` only, no JS)
- 8-element stagger load animation — pure CSS `animation`, no JS dependency
- Decorative 2px terracotta marker line above headline
- Eyebrow tagline moved from hero to nav logo

### Nav
- Two-line logo: wordmark + italic tagline beneath
- Scroll-triggered `box-shadow` replaces static border on scroll
- Nav CTA: full pill (`border-radius: 100px`), gradient, shine sweep `::after` on hover

### Buttons (site-wide)
- `.btn-primary` → pill, gradient `#6B1E2E → #8B2E42`, shine sweep on hover, 2px lift + shadow
- `.btn-secondary` → animated underline slides in from left on hover
- `.btn-outline` → matching pill, fills on hover
- Offer section button keeps terracotta gradient override

### Features
- Flat grid → CSS 3D flip cards (`rotateY`, 0.25s `ease-in-out`)
- Front: icon + title + "↻ tap to explore" hint
- Back: burgundy background + description
- Web Audio API SFX on flip (generative white noise, bandpass filtered, no external file)
- Cards stagger-reveal on scroll (115ms apart) via `IntersectionObserver`

### Steps
- Numbers redesigned: large faded text → filled burgundy circles (44px)
- Vertical connector line draws on scroll (`scaleY 0→1`, 1.4s transition)
- Rows stagger in on scroll (145ms apart)

### Sections — reveals & animation
- All sections: `IntersectionObserver` reveal (opacity + translateY, fires once, unobserves)
- Identity: atmospheric large quote mark (`::after`, 30rem Playfair, 3% opacity)
- Identity closer: animated underline draws on scroll
- Testimonials: enlarged quote mark (4.5rem Playfair), hover lift + shadow, stagger-reveal
- Founding offer: pulsing spot badge with animated terracotta dot
- She Connects: pulsing live dot on event label + countdown timer to Aug 19 (auto-updates 1s)
- Closing headline: word-by-word reveal (10 words, 45ms stagger via `--wi` CSS var)

### Performance
- Single passive scroll listener handles: progress bar + nav shadow + back-to-top
- All reveals via `IntersectionObserver` (no scroll event listeners)
- Cursor glow: RAF loop, `transform` only, desktop + `prefers-reduced-motion: no-preference` only
- `will-change` on cursor glow and `.flip-card-inner` only
- `AudioContext` lazy init (created on first user interaction)
- No new external dependencies

### Global additions
- Scroll progress bar (2px burgundy, top of page)
- Back-to-top button (appears at 55% scroll)
- Warm cursor glow (desktop only, RAF-driven)
- Heartbeat `🧡` animations, offset so they never sync
- SVG favicon (data URI — "S" on burgundy, no request)
- `<meta name="description">` + `theme-color`
- `rel="noopener noreferrer"` on all external links
- Font `preconnect` tags added
- Focus-visible ring in brand colour
- `prefers-reduced-motion` kills all animations/transitions

### Fixes
- Copyright year: 2025 → **2026**
- `will-change` scope corrected (was over-applied)
- `border-radius: 2px` → `100px` on all buttons
- Cards use real `gap` instead of border-colour grid trick

---

## v1.0 — June 18, 2026
**File:** `she-starts-over.html` → renamed `index.html` (required for Vercel)
**Session:** 2

- Initial landing page built, all sections: Hero, Identity, Solution, Included, For You, How It Works, Founder, Testimonials, Founding Offer, She Connects, Closing, Footer
- Design system established: burgundy `#6B1E2E`, cream `#FDF8F5`, DM Sans + Playfair Display
- Placeholder links throughout: Calendly, Eventbrite, LinkedIn
- Placeholder content: founder photo, 3 testimonials
- GitHub repo created, Vercel connected — site live on `.vercel.app` URL
