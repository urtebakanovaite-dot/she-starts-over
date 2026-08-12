# She Starts Over — Build Journal
*What was built, how it performed, what to do differently. Append new entries at the top.*
*Strategy decisions go in master-doc. This doc is about execution and lessons.*

---

# She Starts Over — Build Journal
*What was built, how it performed, what to do differently. Append new entries at the top.*
*Strategy decisions go in master-doc. This doc is about execution and lessons.*

---

## Session 9 — August 12, 2026 · Tools Site UI Fixes + Feature Pass (v0.9 → v0.10)
*Repo: `she-starts-over-tools`*

### What was done
- **Mobile navigation**: fixed-position bottom tab bar (Dashboard / Members / Add / Health) added to all 6 HTML pages. Sidebar remains on desktop; bottom nav renders only on ≤768px screens.
- **Dashboard onboarding alert bug fixed**: the "all members fully onboarded" false positive was caused by a `THREE_DAYS` filter that silently excluded members with no join date or steps. Replaced with a direct incomplete-steps check — any active member with 0 of N steps completed now correctly triggers the alert.
- **Note inline edit**: pencil icon added to each note in the notes log. Clicking it replaces the note body with a prefilled textarea + Save/Cancel. Save calls `UPDATE member_notes SET note_text` on Supabase. No risk to existing data — cancel restores original text without a database call.
- **Note delete**: was already in v0.9. Confirmed working; hard delete from `member_notes` with `window.confirm` gate.
- **AI generating indicator bug fixed**: the indicator had `display:none` and `display:flex` both in the same inline style string — the latter won, so the spinner showed permanently. Removed the second declaration; JS now sets `display:flex` on click and clears it in `finally`.
- **AI output markdown rendering**: replaced `textContent` assignment with a lightweight markdown→HTML parser (`markdownToHtml`). Converts `# ` / `## ` / `### ` to `<h3>`, `**` to `<strong>`, `*` to `<em>`, `- ` bullet blocks to `<ul><li>`, remaining lines to `<p>`. No external dependency.
- **AI history accordion**: all generated outputs are now saved to a new `ai_outputs` Supabase table (member_id, feature, label, content, created_at, updated_at). They load on page open and display as a collapsible accordion below the AI buttons, newest first. Outputs persist across sessions, across tabs, and survive accidental clicks.
- **AI output editing**: each history item has a full rich-text editor bar (dark toolbar strip above the contenteditable): **B**, *I*, U, H2, ¶, bullet list, Copy, Delete. `document.execCommand` for formatting. Auto-saves to `ai_outputs.content` after 1.2s idle. A "Saved" flash confirms each write.
- **`ai_outputs` table**: run `CREATE TABLE ai_outputs (...)` in Supabase SQL Editor — SQL documented in session chat.

### Incidents
None. All changes targeted and tested locally before push.

### Lessons learned

**32. Two `display:` values in one inline style string — last one always wins**
CSS inline styles are parsed left-to-right; a duplicate property is not an error, the later value simply wins. Generated code that writes `style="display:none; ... display:flex"` will appear hidden while writing but always show on render. Standard fix: set only the initial state in HTML (`display:none`), let JS toggle the other via `.style.display = 'flex'` when needed — never duplicate the property in markup.

**33. Dashboard "all good" signals need to be falsifiable, not just true by default**
The onboarding alert was designed to only show members who had been around >3 days with incomplete steps. That's a reasonable idea, but the code also silently passed through members with no steps at all (because `!s` = undefined = return false). The safer design: any active member without 100% step completion should surface — Urte can always dismiss false positives. Alerts that fail silently are worse than alerts that fire too often.

**34. AI output boxes must save immediately on generate, not on close**
The original design displayed AI output in a single shared box that cleared when the user clicked away. First-time usage always risks accidental dismissal. Correct pattern: write to the database the moment a response is received, independent of UI state. The display layer is just a view — the source of truth is the database entry.

**35. `document.execCommand` is "deprecated" but still the correct tool for basic rich text in plain HTML**
The MDN deprecation notice for `execCommand` leads developers toward a full custom editor implementation, which is overkill for a private admin tool. `execCommand('bold')`, `execCommand('italic')`, `execCommand('formatBlock')`, `execCommand('insertUnorderedList')` all work reliably in Chromium and Safari (the only browsers Urte will use). Use it for small admin tools; reach for Tiptap or Quill only when the editor is user-facing or needs fine-grained undo history.

---

## Session 8 — August 12, 2026 · Tools Site Build — Phase 1–8 Complete (v0.1 → v0.8)
*Repo: `she-starts-over-tools`*

### What was done
Full build of the private admin tools site from scratch, in one session. 8 phases completed:

**Phase 1 — SQL schema** (`docs/schema.sql` in main repo): 7 tables (members, member_notes, onboarding_steps, offboarding_steps, events, event_attendance, member_tags), indexes, auto `updated_at` trigger, RLS intentionally disabled (private tool).

**Phase 2 — Shared foundation**: `assets/style.css` (complete design system — brand tokens, sidebar shell, all UI components), `js/supabase.js` (async config fetch + client init + `requireAuth`), `js/utils.js` (formatting helpers, badge generators, Supabase helpers), `api/config.js` (Vercel serverless — returns public Supabase creds only, never exposes service role or Claude key).

**Phase 3 — `login.html`**: branded password gate with shake animation. `sessionStorage` token. Password stored in 1Password. Favicon added.

**Phase 4 — `index.html` (Dashboard)**: 4 stat cards (active members, MRR, onboarding rate, at-risk count), onboarding alerts panel, at-risk panel, founding rate countdown (only shown within 90 days), recent activity feed. All data loaded in parallel on page open.

**Phase 5 — `members.html`**: live debounced search (200ms), status + cohort filters, sortable table, onboarding progress bars, last-note date (red if none), events attended count. Suggest introductions → slide-in panel → `api/ai.js` → pairings rendered as cards.

**Phase 6 — `member.html`**: two-column layout. Left: avatar, inline-editable fields (auto-save 800ms), tags, application answers (collapsible), 4 AI tool buttons. Right: onboarding checklist (optimistic UI), offboarding (hidden unless churned/alumni), events attended, notes log.

**Phase 7 — `health.html`**: 4 stat cards, Chart.js (CDN — only approved exception), MRR line chart, status donut, onboarding funnel bar, event attendance bar (top 10), revenue projection table with founding-rate expiry countdowns.

**Phase 8 — `api/ai.js`**: Vercel serverless Claude proxy. 6 features: `introduction_matcher`, `pre_1on1_brief`, `post_1on1_draft`, `at_risk_digest`, `welcome_email`, `exit_interview_prep`. Model: `claude-haiku-4-5-20251001`. Claude API key server-side only. Introduction matcher attempts JSON parse, falls back to plain text.

**Doc updates**: `docs/schema.sql` added to main repo. `tools-build-plan.md` marked COMPLETE. `master-doc.md` updated with full session decision log.

### Infrastructure set up this session
| Component | Status | Notes |
|---|---|---|
| `she-starts-over-tools` GitHub repo | ✅ | Private, under pocsgeri1 |
| Vercel (tools site) | ✅ | Geri's personal Vercel, separate from public site |
| Supabase project | ✅ | Schema deployed, RLS off, 7 tables live |
| `tools.shestartsover.co` subdomain | ✅ | CNAME in Porkbun → Geri's Vercel |
| Vercel env vars | ⬜ | `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `CLAUDE_API_KEY` to be set before first test |
| `ai_outputs` table | ⬜ | SQL added Session 9 — needs to be run in Supabase |

### Incidents
- **`she-starts-over-tools` repo not on disk at session start**: Claude tried to write to it before it existed locally. User cloned via GitHub Desktop, then mounted it as a Cowork folder. No data lost.
- **Supabase RLS warning on schema run**: Supabase flagged that tables were created without RLS. Correct response: "Run without enabling RLS" — this is intentional for a private password-gated admin tool.

### Lessons learned

**32 (see Session 9 entry above for 32–35)**

**Pre-32. Env vars in plain HTML require a serverless shim**
There's no secure way to put secret keys directly in client-side JS. The solution: a Vercel serverless function (`api/config.js`) that serves only the *public* Supabase credentials (anon key + project URL) to the browser. The service role key and Claude API key never leave the server. This pattern scales to any plain HTML site that needs secrets.

**Pre-33. RLS-off is correct for a private admin tool**
Supabase enables RLS (Row Level Security) by default and warns when you don't. For a tool that sits behind a password gate and is never user-facing, RLS adds complexity with no security benefit — the auth layer is the login page. The right call was to disable RLS explicitly and document why, so future Geri/Urte doesn't undo it thinking it was an oversight.

**Pre-34. Optimistic UI for checklists requires a revert path**
Checklist toggles update the UI instantly before the Supabase call resolves. The revert path (toggle back + toast on failure) has to be written before the try block, not as an afterthought — otherwise a failed network call leaves the UI in a permanently wrong state.

---

## Session 7 — July 19, 2026 · Full Copy Pass + Section Reorder + Flip Card Redesign (v3.0 → v3.0d)

### What was done
- Full copy rewrite: nav subtext, hero subtext, identity body, solution heading + body, founder story (rewritten twice), for-you/not-for-you lists, closing headline + subtext, solution eyebrow label, 2 flip cards renamed with new copy, 1 new flip card added
- Structural reorder: Founder section, Photo Break B, and How-it-Works section all relocated to new positions in the page flow
- Flip card row widened to a full 4-across single row via a new `.container-full` wrapper, decoupled from the section's normal `.container-wide` heading width
- Founder section split into a photo+text 2-column grid (shorter, ends mid-story) and a full-width flow block underneath (rest of the story)
- Sitewide emoji swap: 🧡 → 🤍 (5 instances)
- Per-card scrollbar override (card 2 only) via `:nth-child()`
- Founding-spots badge given more visual weight (size + font-weight + opacity)
- ✗ replaced — as the not-for-you bullet marker

### No incidents this session
Five sub-versions (v3.0 → v3.0d) shipped as fast, iterative rounds. Every edit was diff-verified via section/div/`<strong>` tag-balance checks before presenting — no stale-file or lost-content issues, unlike Sessions 4–5.

### Lessons learned

**26. A nested "breakout" container is the reusable pattern for widening one element inside an otherwise-narrower section**
Splitting a section into two inner wrappers, e.g. `.container-wide` for the heading and a separate wider `.container-full` for the flip-card row, lets one element (the card row) go wider than the rest of the section without touching the section's own width or the elements around it. Reuse this pattern any time a single component (a grid, a gallery, a stat bar) needs to break out of the section's normal reading width.

**27. `overflow-y: auto` should be a standing default on any fixed-height text container, not a reactive fix**
Added to both faces of every flip card this session as a blanket safety net against future copy-length changes. Costs nothing visually when unused, and removes an entire category of "will this text fit" risk on every future copy edit to these cards. Apply this by default to any new fixed-height card/box going forward, don't wait for an overflow complaint.

**28. `:nth-child()` is the lightweight way to override one instance in a shared-class set**
Card 2 needed `overflow-y: hidden` instead of the sitewide `auto` default. Rather than adding a new class to the HTML, `.flip-card:nth-child(2) .flip-card-back` targeted it directly from CSS alone. Useful whenever a fix is specific to one instance of a repeated component, not the whole pattern — avoids an HTML edit for a CSS-only concern.

**29. When a user's quoted line doesn't match anything verbatim, search the whole file for the closest match before asking**
"That's why She Starts Over exists" (v3.0c request) matched no heading exactly — it turned out to be a paraphrase of a short eyebrow label. Proceeded on the best match and flagged the interpretation in the same response rather than stopping to ask, since the edit was small, reversible, and low-stakes. Save clarifying questions for changes that are ambiguous *and* costly to get wrong.

**30. When a user re-pastes previously-edited copy without repeating earlier formatting instructions, preserve the established pattern rather than dropping it**
The founder story was rewritten twice this session. The second draft (v3.0d) had no `**bold**` markers, unlike the first. Defaulted to keeping bold on the same 3 lines as the prior approved version rather than treating the absence of markers as "remove all bold" — flagged the judgment call explicitly so it's a one-line reversal if wrong.

**31. The no-em-dash house rule (Session 6) needs a proactive check on every new pasted paragraph, not just on request**
Em-dashes appeared in two separate user drafts this session (founder story twice) and were caught and converted both times. This should be a standing pre-flight check on any new copy block going forward, the same way tag-balance checks now run after every structural edit — not something that only gets applied when explicitly asked to "rewrite."

---

### What was done
- Umami analytics script added and verified (v2.6)
- Click and scroll-depth event tracking added across 8 custom events covering every CTA, the LinkedIn card, flip cards, and two scroll-depth milestones (v2.7)
- Open Graph + Twitter Card meta tags added to fix a broken LinkedIn link preview that was pulling random on-page text and an arbitrary image (v2.8)
- Domain finalized as live: `shestartsover.co` (not `.com` — availability meant the `.co` fallback already flagged as acceptable in the tech-stack doc was used)
- Diagnosed and fixed a mobile-only CSS grid bug causing horizontal page overflow (v2.9)
- Removed 5 em-dashes from visible body copy, established a no-em-dash house rule
- Shortened nav CTA text, fixed permanent nav button wrapping bug

### Incident: mobile "pinch to zoom" bug traced to one root cause, not three
What happened: Urte reported three separate-seeming mobile problems — the page feeling zoomed in until pinched out, the nav "Become a member" button breaking into 2 lines, and founder-section text overflowing off the right edge. Investigation found a single root cause: `.founder-photo` (enlarged to a fixed 420px in Session 5) sat inside a CSS grid column that, on narrow phone screens, doesn't reliably shrink a fixed-width grid item below its own size — even with `max-width: 100%` already set. This forced the whole page wider than the viewport, which explains all three symptoms as one bug.

### Lessons learned

**19. A fixed pixel width inside a CSS grid column needs `min-width: 0` as standard practice, not an afterthought**
`max-width: 100%` alone does not guarantee a grid item shrinks below its own declared `width` on narrow viewports — CSS grid's default `min-width: auto` on grid items can override it. Going forward: any time a fixed-width element (photo, card, block) sits inside a grid or flex column, add `min-width: 0` by default, don't wait for a bug report. This should have been added in Session 5 when the founder photo was resized 260px → 420px.

**20. One user-reported bug description can hide multiple symptoms of a single cause**
Urte's report bundled three visually distinct problems (zoom feel, button wrap, text overflow) that read like three separate bugs. Tracing the actual CSS mechanism first, before fixing anything, revealed they were one cause. Fixing each symptom individually (e.g. just shortening the nav text, just resizing the photo) would have patched the visible effects without removing the underlying overflow — worth always asking "could these separate-sounding reports share one cause?" before starting on fixes.

**21. `white-space: nowrap` + `flex-shrink: 0` is the durable fix for "this button might wrap" bugs**
Shortening button text reduces the *chance* of wrapping but doesn't guarantee it won't happen again at some other screen width. Adding `white-space: nowrap` and `flex-shrink: 0` makes wrapping structurally impossible for that element, independent of how much text it holds. Apply this as standard practice to any pill/CTA button going forward, not just when a wrap bug is reported.

**22. LinkedIn (and most platforms) cache link previews per URL — a meta-tag fix alone isn't enough**
Adding Open Graph tags after a bad preview has already been shared once won't automatically update what's shown — the platform cached the first scrape. Any future og:title/description/image fix needs a paired instruction to force a re-scan (LinkedIn: linkedin.com/post-inspector) or the fix will appear "broken" even though the code is correct.

**23. Portrait-orientation photos don't work as share-preview images**
Most platforms force link-preview images into a ~1.91:1 landscape box (1200×630). A 3:4 portrait photo (like the founder photo) gets awkwardly cropped top-to-bottom in that box. When choosing a share-preview image from an existing photo set, always pick the landscape one, even if a portrait photo is the "nicer" or more personal shot.

**24. House style rule adopted: no em-dashes in on-page prose**
Replace with a colon when the dash introduces a list of examples, or a comma when it joins a qualifying clause. Never substitute a bare hyphen mid-sentence — reads grammatically odd in flowing prose. Apply this rule to all future copy on the site, not just this cleanup pass.

**25. A user's suggested copy can conflict with an already-established house rule — flag it, don't silently override or silently comply**
Urte suggested nav button text "I'm in!" Her own brand voice rule (no exclamation marks unless already used on the page) said otherwise, and the page currently has zero exclamation marks. Resolved by using "I'm in" without the mark, and explicitly telling her the override happened and why — rather than either silently adding the "!" (breaking her own stated rule) or silently dropping it without mention (which could look like the instruction was ignored).

---

## Session 5 — July 1, 2026 · Real Photos Wired + Design Polish (v2.3 → v2.5a)

### What was done
- All 4 photo slots wired to real images via new `assets/` GitHub folder: identity portrait, founder portrait, detail-workspace shot, full-bleed group photo
- Advised on image compression before upload (source files were ~15MB each): recommended Squoosh (squoosh.app) for combined resize + compress, target under 300–500KB per image, with specific dimension/quality guidance per slot
- Founder photo repositioned to align with "A little bit about why" heading, then later enlarged to exactly match the identity photo's dimensions (420px, 3:4 ratio)
- Group photo crop position (`object-position`) adjusted twice — first guess (68%) was the wrong direction, corrected to 32% once Urte reported the result
- Applied a coordinated design treatment across 3 of the 4 images: terracotta hairline border + offset shadow-panel (all three) + soft rounded corners (portraits only) — full-bleed group photo deliberately excluded to preserve its immersive edge-to-edge look
- Testimonials section — found reappeared in the live project file despite being removed in v2.2; re-disabled via `display:none` this time instead of physical removal
- Removed leftover periods from "She.Starts.Over" in nav logo and founder heading (2 occurrences)
- Widened founder section container 720px → 960px to match Included section width

### Incident: testimonials section reappeared after prior removal
What happened: v2.2 (Session 4) removed the testimonials section from the HTML entirely. At the start of this session, the project's `index.html` had the full testimonials section back in the DOM, undoing that decision. Cause not fully known — likely a re-upload of a pre-v2.2 file version, consistent with the file-hygiene risk already flagged in Session 4 (Lesson 11/12). This time, resolved with `display:none` rather than deleting the markup — see Lesson 15.

### Lessons learned

**15. Prefer `display:none` over physical deletion for "temporarily disabled" sections**
Session 4 physically deleted the testimonials markup from the HTML; it still came back (see Incident above), likely via a stale file re-upload. A `display:none` toggle on the wrapping `<section>` is more resilient: even if an out-of-sync file gets re-introduced, the disable state travels with the markup itself rather than depending on the markup being absent. Trade-off: slightly more code sits unused in the file, which is an acceptable cost for the durability gained.

**16. Don't guess `object-position` direction — confirm with the person after the first try**
The first attempt at fixing the group photo crop (v2.4, `68%`) moved the crop the wrong way. `object-position` direction is genuinely easy to get backwards without seeing the actual image. Going forward: ship a reasonable first guess, but flag it explicitly as a guess and expect one correction round — don't over-invest in getting it right blind.

**17. When mixing multiple design treatments across several images, exclude full-bleed/immersive ones explicitly**
Applying the same border+offset-panel treatment uniformly across all 4 images would have undermined the one image (group photo) intentionally designed to be edge-to-edge. When a "mix these ideas" request spans images with different structural roles (contained vs. full-bleed), flag the mismatch and propose excluding the structurally different one — don't apply uniformly by default.

**18. Enlarging a fixed-width grid column needs a matching breakpoint check**
Enlarging the founder photo from 260px to 420px (fixed width, in a 2-column grid) would have crushed the text column on tablet-width screens before the existing 640px mobile breakpoint kicked in. Added a defensive 860px breakpoint (matching the pattern already used for the identity section) without being asked. General rule going forward: any time a fixed-width column grows, re-check the breakpoint math, not just desktop and phone.

---

## Session 4 — June 30, 2026 · Testimonials Section Removed (v2.2)

### What was done
- Removed the Testimonials section from `index.html` (no real or workshop testimonials available yet)
- Exact removed markup saved in chat for verbatim restoration once testimonials are ready — just ask to "add the testimonials section back"
- CSS left in place (unused, harmless) so re-adding is a pure HTML paste, no rebuild needed

### Incident: edited the wrong file (v2.1 → corrected as v2.2)
What happened: the project contained two HTML files — `she-starts-over.html` (an older, superseded draft, 56K) and `index.html` (the true live file, 64K). The version of `index.html` present in project files at the start of the session was itself stale — an older copy that predated the real live site (missing the LinkedIn connect card, photo break slots, accepting badge, etc.). The edit was made correctly in isolation (verified by diff — only the testimonials block changed, nothing else), but against the wrong source file. Urte caught this by checking the live output and re-uploaded the correct, current `index.html`. The edit was then redone against the correct file and diff-verified again.

### Lessons learned

**11. Two similarly-named/purposed files in project = silent ambiguity risk**
Having both `she-starts-over.html` and `index.html` in project files at once, with no flag for which is "live," means Claude has no way to know which is authoritative — it can only read whichever file is sitting there. **Action: keep exactly one HTML file in project files at all times.** Delete `she-starts-over.html` from project files now that `index.html` supersedes it.

**12. Stale uploads are invisible until tested**
A file can be technically present and readable in the project without being current. There's no built-in "last verified live" signal. **Mitigation: after any manual change made outside a Claude chat (e.g. directly in GitHub), always re-upload the current `index.html` to project files before starting the next session** — otherwise Claude may silently work from an outdated copy.

**13. Diff-checking after every edit is the real safety net**
Running a diff between the pre-edit and post-edit file (or the source-of-truth and the edited copy) is what caught and proved the scope of the actual change was correct, even though the underlying source was wrong. This should be standard practice for every HTML edit going forward, not just when something looks broken.

**14. "Something looks wrong" feedback should trigger a diff first, not a rebuild**
When Urte flagged that other sections looked changed, the right first move was diffing the delivered file against the original — which proved the edit itself was clean and isolated the real problem (wrong source file) in one step, rather than guessing or redoing work blind.

---

## Session 3 — June 21, 2026 · Site Launch + v2.0 Build

### What was done
- GitHub repo created, Vercel connected — site live on `.vercel.app` URL
- 404 error: file named `she-starts-over.html` caused Vercel to return NOT_FOUND — fixed by renaming to `index.html`
- Full v2.0 visual overhaul built and delivered (see `changelog.md` for detail)
- Documentation system started: `changelog.md`, `build-journal.md`, `roadmap.md`

### Infrastructure set up
| Tool | Status | Notes |
|---|---|---|
| GitHub | ✅ Live | Repo created, `index.html` uploaded |
| Vercel | ✅ Live | Auto-deploys on every GitHub push |
| Domain | ⬜ Not bought | Deferred — use `.vercel.app` URL for now |
| Business email | ⬜ Not set up | Needs Google Workspace or Zoho before outreach |
| Calendly | ⬜ Placeholder | Real link not yet inserted in HTML |
| Eventbrite (She Connects) | ⬜ Not published | |
| Eventbrite (Brunch) | ⬜ Not published | |
| Tally form | ⬜ Not built | |
| Brevo | ⬜ Not set up | |
| Umami analytics | ⬜ Not added | |

### Lessons learned

**1. Vercel requires `index.html` as the filename**
Any other name → 404. Always name the main page `index.html` before uploading. Applies to any static host (Netlify, GitHub Pages, etc.).

**2. Domain and hosting are independent — buy in parallel**
GitHub + Vercel can go live immediately on `.vercel.app`. Domain takes 24–48hrs to propagate once purchased. Don't wait on one before starting the other.

**3. Owning a domain ≠ having a working inbox**
`urte@shestartsover.com` does not exist until email hosting is set up separately (Google Workspace ~€6/mo or Zoho free tier). Do not use it in outreach or on Eventbrite until the inbox actually works.

**4. Gmail for infrastructure, business email for member-facing**
- Gmail → GitHub, Vercel, domain registrar (Porkbun/Namecheap), Umami
- `urte@shestartsover.com` → Calendly, Brevo, Eventbrite, Tally, LinkedIn outreach
- Reasoning: infra tools are invisible to members; business email builds trust in everything members see

**5. `will-change` is a GPU promise — use it sparingly**
Only assign to elements that are *actively* mid-animation (cursor glow, flip-card-inner). Applying broadly consumes GPU memory without benefit. Over-applying is worse than not applying.

**6. One scroll listener for all scroll-based UI**
Scroll progress bar, nav shadow, back-to-top visibility — all in a single passive listener. Multiple listeners for scroll events compounds jank. Pattern: one listener, switch on the thing that changed.

**7. Web Audio API needs lazy `AudioContext` init**
Browsers block audio until a user gesture. Create `AudioContext` on first flip click, not on page load. Catch any errors silently — audio SFX is an enhancement, not a dependency.

**8. `IntersectionObserver` > scroll events for reveals**
All scroll-triggered reveals (section entries, stagger animations) use `IntersectionObserver` with `unobserve()` after firing. This is zero-cost after the element is in view. Scroll listeners fire continuously — avoid for static reveal logic.

**9. Hero animation can be pure CSS**
Hero stagger doesn't need JS. `animation: heroIn 0.65s forwards; animation-delay: var(--d)` on each element works perfectly and degrades gracefully (no JS = elements stay visible at opacity: 0 without fix needed, since hero loads immediately). Kept as pure CSS.

**10. Flip card SFX: bandpass filtered white noise**
Best "paper card" sound: white noise buffer → exponential decay → bandpass filter at ~3800Hz. Keep gain below 0.6. Duration: 0.11s. Any longer sounds heavy.

---

## Session 2 — June 18, 2026 · Strategy + v1.0 Build

### What was done
- Audience repositioned: burnout/starting-over → established solopreneurs
- All event copy finalised: She Connects (online, €25, Aug 19) + Brunch (Zoku, €35, Sept 16)
- Community structure, pricing, application form finalised
- Post-event follow-up sequence written
- Landing page v1.0 built (HTML file)
- Free community bi-weekly calls paused

### Lessons learned
- "Founder" alienates the target audience — use "solopreneur" throughout
- Price testing: She Connects €25 (not €20 = too casual, not €35 = too high for first event without track record)
- The community solves *connection*, not *strategy* — this keeps the value prop clean and avoids competing with coaches/courses
