# She Starts Over — Cowork Session Protocol
# v1.0 — 2026-08-12

---

## Roles

- **Urte** — project owner. She makes all decisions about copy, strategy, design direction, and brand.
- **Geri** — technical operator. He runs all Claude sessions, makes all code edits, handles GitHub/Vercel.
- Claude works for both: strategic and technical collaborator.

---

## How Claude works in every session

Rules:
- Work in background: read file → targeted edits → present finished result
- No full-file rewrites. Touch only what's changing.
- No preamble. Answer starts with the answer.
- All responses in bullets and numbered phases. No prose paragraphs.
- One idea per bullet. Nested bullets for depth.
- If a change has more than one valid approach, pick the most conservative and flag it — don't ask first.
- HIGH risk phases: flag and wait for explicit approval before executing.
- Flag design/architecture risks before touching anything.
- Match existing design tokens exactly — no inventing colors, fonts, or spacing.
- Give a detailed commit title + body with version number at the end of every build.

Token rules:
- No restating what was said. No summaries that weren't asked for.
- Tell us what could go wrong and what might be missing, unprompted.
- Plain language. Urte is non-technical.
- Mark anything needing Geri's action: **[GERI]**
- Mark anything needing Urte's action: **[URTE]**

Structure of every response during a build:
- Phase / step heading [RISK: LOW / MEDIUM / HIGH]
  - Key point
  - Key point

---

## Start every session

0. **Find this file first.** Always try `docs/cowork-default-instructions.md` (relative to repo root). If not found — search the repo for `*cowork-default-instructions*` using Glob before anything else. If still not found — stop and inform Geri. Never proceed without reading this file.
1. Confirm `~/Documents/GitHub/she-starts-over` folder is connected. If not — stop.
2. Tell Geri: quit GitHub Desktop. Close any editor with the repo open.
3. `git pull origin main` via bash before touching anything.
4. Read in parallel:
   - `docs/master-doc.md` — decisions, copy, open threads, UP NEXT list
   - `docs/changelog.md` — last 2–3 versions (know what's currently in the file)
   - `docs/roadmap.md` — phase status + red flags
   - `docs/build-journal.md` — ALL ⚠️ standing rules, then latest session entry
   - `docs/engineering-standards.md` — ALL CSS/JS/animation/mobile rules — apply every session
5. State in one line: current version + what we're building this session.
6. **Scope**: one area per session. Finish + commit + docs before switching areas.

Path mapping — both required, neither works for the other:
- Read/Write/Edit tools → `/Users/gergelypocs/Documents/GitHub/she-starts-over/...`
- bash → `/sessions/[id]/mnt/she-starts-over/...` (get exact id from the active session)

---

## The business — read this before every session

**She Starts Over** is a curated paid membership community for established female solopreneurs running independent, service-based businesses (coaching, marketing, branding, PR, sales funnels). Founded by Urte after her own burnout and rebuild. Core belief: women building solo businesses don't need more courses — they need real friendships with people who understand the journey.

**Three products:**
1. **Community membership** — €30/month founding rate (first 6 months per member), then €60/month regular. Target: 10 founding members before community launches (date is trigger-based, not calendar-based).
2. **She Connects** — quarterly online event, €25/ticket, 12 spots, 90 minutes. Next: August 19, 12PM CET.
3. **Amsterdam Brunch** — intimate in-person event, €35/ticket, max 12 women, Zoku Amsterdam. Next: September 16.

**Current site:** `https://www.shestartsover.co` — live, `index.html` v3.0d. Single-page HTML site hosted on Vercel via GitHub.

**Primary acquisition channel:** LinkedIn (~5,500 followers). All outreach is personal and 1:1. No ads.

**Ideal member:** Woman, late 20s–30s, running a personal-brand service business in European time zones. Chose flexibility over scale. Craves peer friendships, not hustle culture. Often Amsterdam-based.

**NOT for:** VC-backed founders, digital nomads without a timezone, "scale faster / exceptional girls" energy, women still figuring out what business to start.

**Decisions that are locked — do not re-litigate:**
- Brand name: She Starts Over (umbrella). Community product name: still TBD — does not block current work.
- Language: "solopreneur" not "founder" in audience-facing copy. "Founding member" is kept — it refers to early-adopter status, a different concept.
- Pricing: not displayed publicly on the site — revealed on the founding member call.
- She Connects ticket: €25. Brunch ticket: €35. Confirmed. Do not suggest changing.
- House style: no em-dashes in on-page prose. No exclamation marks unless already used on page.
- Heart emoji: 🤍 (white). Was 🧡 — changed in v3.0d. Do not revert.

---

## Three rules that break everything if skipped

**A — Edit tool only. Never Python for file content.**
If Edit can't match a string, widen `old_string` until it's unique — never fall back to Python replace. Python only for: `node --check`, reading line numbers.

**B — `node --check` before every commit.**
Extract JS with a temp file → `node --check /tmp/k.js`. Fail = fix and recheck before committing. One check prevents three fix-commits.

**C — Docs before next task (not end of session).**
Any commit starting with a version bump triggers doc updates immediately — not "next time."

---

## Commit workflow

Pre-commit checks (all must pass):
1. `node --check /tmp/k.js` passes
2. `grep -c '\\\!' index.html` returns 0
3. No curly quotes inside JS blocks
4. Mobile layout mentally verified at 390px

Commit command (Geri runs via bash):
```bash
cd /sessions/[SESSION_ID]/mnt/she-starts-over && git add [files] && git commit -m "vX.X — short description

- bullet: what changed and why
- bullet: root cause for any bug fixed
- bullet: files touched"
```

Push — Geri runs from Mac Terminal:
```bash
rm -f ~/Documents/GitHub/she-starts-over/.git/index.lock
rm -f ~/Documents/GitHub/she-starts-over/.git/HEAD.lock
cd ~/Documents/GitHub/she-starts-over && git push origin main
```
Vercel auto-deploys ~30–60s → check `https://www.shestartsover.co`.

After any `git restore` / `git checkout`: run `git log --oneline -3` and report what HEAD is.

---

## ⚠️ DOC UPDATES — MANDATORY after every feature commit. No exceptions.

This is a blocking rule. Do not move to the next task without completing this.

### Which docs to update and when

| Doc | Update when |
|-----|-------------|
| `changelog.md` | Every commit — new entry at top |
| `roadmap.md` | Any phase item resolved or new blocker added |
| `master-doc.md` | Any strategic decision made this session — new session block at top |
| `build-journal.md` | Any new recurring trap found → add numbered lesson at top |

### Commit format (mandatory)

Features/fixes:
```
feat/fix: [vX.XX] Title of change

- Bullet detail of what changed
- Root cause for every bug, not just "fixed X"
- What file / function was changed and why
```

Docs-only commit:
```
docs: [vX.XX] changelog + roadmap
```

### Changelog entry format (copy exactly)

```markdown
## vX.X — YYYY-MM-DD
**File:** `index.html` · **Session:** N

### Added / Changed / Fixed / Removed
- **Feature/Fix name:** what changed and why
- **Root cause (bugs):** what was wrong, not just what was fixed
```

### Rules
- Docs commit happens in the SAME session as the feature — never "I'll do it next time"
- If a new trap was found that caused a bug: add numbered lesson to `build-journal.md` so future sessions don't repeat it
- `changelog.md` entry must include root cause for every bug fix, not just "fixed X"

---

## Architecture (quick ref)

**Site:** Single HTML file — `index.html` at repo root. All CSS and JS are inline inside the file. No separate stylesheets, no JS files, no build step.

**Repo:** `she-starts-over` on GitHub → auto-deploys to Vercel on every push.

**Live URL:** `https://www.shestartsover.co`

**Domain:** registered via Porkbun, DNS pointed to Vercel. Primary domain set in Vercel project settings.

**External dependencies (only these, no others):**
- Google Fonts: DM Sans + Playfair Display (loaded via `<link>` in `<head>`)
- Umami analytics: `https://cloud.umami.is/script.js` (cookieless, GDPR-compliant, website ID `6157776d-fcdc-4c40-8c04-9516b5189a83`)

**External tools (not in the HTML):**
- Calendly — booking link for founding member calls (placeholder still in HTML — real link TBD)
- Eventbrite — ticketing for She Connects + brunch
- Tally — application form (not yet built)
- Brevo — email list + follow-up sequences (not yet set up)

**Assets:** `assets/` folder in repo root. Four images:
- `urte-portrait-identity.jpg` — Identity section
- `urte-portrait-founder.jpg` — Founder section
- `detail-workspace.jpg` — Photo Break B
- `group-photo-wide.jpg` — Photo Break C (full-bleed) + OG share image

**Page structure (current section order, v3.0d):**
Hero → Identity → Solution → Founder → Included (flip cards) → Photo Break B → For You / Not For You → Testimonials (hidden, `display:none`) → Photo Break C → Founding Offer → She Connects → How It Works → Closing → Footer

**Design tokens (all defined in `:root` in `<style>`):**
- `--burgundy: #6B1E2E` (primary)
- `--burgundy-deep: #4A1020`
- `--terracotta: #B8788A` (accent, borders, image treatments)
- `--blush: #F2DDD5`
- `--blush-light: #FAF3F0`
- `--cream: #FDF8F5` (page background)
- `--ink: #1C1410` (body text)
- `--ink-mid: #4A3728`
- `--ink-light: #8C6D5E`
- `--white: #FFFFFF`
- `--divider: #E8D5CC`

**No dark mode.** This is a single-mode site. Do not add dark mode tokens.

Live repo always beats any knowledge file when they disagree. When in doubt — read `index.html` first.

---

## Engineering & Design Standards

→ Fully documented in `docs/engineering-standards.md` — read it every session alongside this file.

Summary of what's in there: CSS token discipline · animation rules · single-file HTML architecture · photo treatment patterns · JS quality gates · mobile-first rules · commit pre-flight checklist.
