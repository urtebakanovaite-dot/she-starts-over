# She Starts Over — Engineering & Design Standards
# v1.0 — 2026-08-12
# Read at the start of every session alongside cowork-default-instructions.md

These rules apply to every session, every feature, every file touched. Not optional.

---

## Single-File Architecture

The entire site lives in one file: `index.html`. All CSS is in a `<style>` block in `<head>`. All JS is in a `<script>` block before `</body>`. There are no separate stylesheets, no JS files, no build step, no bundler.

Rules that follow from this:
- Never introduce a new `<link rel="stylesheet">` or `<script src="...">` tag without explicit approval.
- Never introduce new external libraries or CDN links (no jQuery, no GSAP, no Alpine, nothing). The only permitted external resources are Google Fonts (already loaded) and Umami analytics (already loaded).
- All new component logic — CSS and JS — goes inline in the same file, inside the existing `<style>` and `<script>` blocks.
- When extracting JS for `node --check`, pipe just the JS content (between `<script>` tags) to `/tmp/k.js` — not the whole file.

---

## Design & CSS

- Follow best CSS/HTML/UI/UX practices. When in doubt, reference MDN + WCAG 2.1 AA.
- All colors, spacing, radii, and type sizes reference `:root` custom properties only — never hardcode hex, px, or rem inside component CSS blocks.
- **Defined tokens** (do not add new colors without explicit approval):
  - `--burgundy: #6B1E2E` — primary brand color, main buttons, headings on light backgrounds
  - `--burgundy-deep: #4A1020` — button hover states, deep accents
  - `--terracotta: #B8788A` — accent, image borders, offset shadow-panels, scroll progress bar
  - `--blush: #F2DDD5` — subtle backgrounds, card accents
  - `--blush-light: #FAF3F0` — lighter blush backgrounds
  - `--cream: #FDF8F5` — page background
  - `--ink: #1C1410` — body text
  - `--ink-mid: #4A3728` — secondary text
  - `--ink-light: #8C6D5E` — captions, labels, quiet text
  - `--white: #FFFFFF`
  - `--divider: #E8D5CC` — horizontal rules, card borders
- No dark mode. This is a single-mode site. Never add `[data-mode=dark]` or `@media (prefers-color-scheme: dark)` variants.
- Before introducing a new visual pattern, check if an existing class covers it. Do not invent variants.
- New interactive components must include `:focus-visible` outlines (already set globally to `2px solid var(--burgundy)`) and correct `aria-*` attributes. Keyboard navigation must work without a mouse.
- All touch targets: minimum 44×44px. This includes icon buttons, chevrons, pill buttons.

---

## Typography

- **Body font:** DM Sans (`'DM Sans', sans-serif`) — weights 300, 400, 500, 600; italic variants available
- **Display font:** Playfair Display (`'Playfair Display', serif`) — weight 700 upright; weight 500 + 700 italic. Used for headings, pull quotes, the hero italic phrase.
- Base font size: `17px`. Line height: `1.65`.
- Use `clamp()` for fluid type scaling instead of stacked media query overrides where possible.
- House style: no em-dashes in on-page prose. Replace with a colon (before a list) or comma (joining a clause). No exclamation marks unless already present on the page. No curly/smart quotes in JS string literals.

---

## Brand Voice (apply to any copy written or edited)

Always:
- Warm, editorial, intimate — like a good independent bookshop
- Speak to one woman directly ("you"), not to a group
- Acknowledge the hard stuff before the solution
- Use: genuine, real, honest, friendship, connection, solo, curated

Never:
- hustle, scale, tribe, exceptional, 10x, girl boss, empower, unlock, crushing it
- Corporate or clinical language
- Bullet-point copy in on-page prose — prose only in HTML sections
- Exclamation marks (unless already present on the page)
- Em-dashes

---

## Animations

- All state transitions get smooth, matching animations: expand/collapse, flip, open/close, appear/disappear.
- Default easing: `cubic-bezier(0.4, 0, 0.2, 1)`. Duration: 0.35–0.6s for micro-interactions, 0.6–1s for panel/section transitions.
- No GPU-intensive effects: no `box-shadow` transitions on large surfaces, no `filter: blur()` in animation, no animating `width` or `height` directly — use `max-height`, `transform: scaleY()`, or `clip-path` instead.
- `will-change: transform` only on elements actively animating. Currently used: cursor glow, `.flip-card-inner`. Never set permanently on static elements.
- Add `@media (prefers-reduced-motion: reduce)` overrides for every animation block — collapse duration to `0ms`. Do this in the same commit as the animation, not later.
- Animations must match the emotional register of the component — warm and deliberate, not bouncy or mechanical.

---

## Established Component Patterns (reuse these, don't reinvent)

**Flip cards (`.flip-card` / `.flip-card-inner` / `.flip-card-front` / `.flip-card-back`):**
- CSS 3D `rotateY` flip, 0.25s `ease-in-out`
- Front: burgundy icon + title + "↻ tap to explore" hint
- Back: burgundy background + description text
- `overflow-y: auto` on both faces as a standing default against copy overflow
- Web Audio API paper SFX on flip (lazy `AudioContext` init — only on first user click)
- Stagger-reveal on scroll via `IntersectionObserver`, 115ms apart

**Photo treatments (portraits and detail shots only — not the full-bleed group photo):**
- `1.5px solid var(--terracotta)` border
- Offset terracotta shadow-panel behind (translate 12px/10px)
- Soft rounded corners on portraits (44px/40px); sharp 6px on detail shot
- Hover lift: `scale(1.01)` + shadow, desktop-only
- Full-bleed group photo (`group-photo-wide.jpg`): deliberately excluded from all treatments to preserve its edge-to-edge, immersive design

**Fixed-width elements inside CSS grid columns:**
- Always add `min-width: 0` — CSS grid's `min-width: auto` default can override `max-width: 100%` on narrow screens and cause horizontal page overflow. This is the root cause of the Session 6 mobile bug. Apply by default, not as a reactive fix.

**Buttons — three variants:**
- `.btn-primary` — pill (`border-radius: 100px`), gradient `var(--burgundy) → var(--burgundy-deep)`, shine sweep `::after` on hover, 2px lift + shadow
- `.btn-secondary` — animated underline slides in from left on hover
- `.btn-outline` — matching pill, fills on hover

**Breakout containers (when one element needs to be wider than its section):**
- `.container` — 720px max-width
- `.container-wide` — 960px max-width (standard for most sections)
- `.container-full` — 1180px max-width (for elements like the flip-card row that break out of their section's reading width)
- Use the nested breakout pattern: section heading uses `.container-wide`, the wider element gets its own `.container-full` wrapper inside the same section.

---

## JS Quality

- `node --check` before every commit — mandatory, no exceptions.
- Null-check every `document.getElementById` / `querySelector` result before use. Assume DOM elements may not exist.
- No `innerHTML` with user-supplied strings — use `textContent` or build DOM nodes programmatically.
- Debounce any function attached to `resize` or `scroll` events (minimum 16ms).
- No curly/smart quotes inside JS string literals. `grep -c '\u2018\|\u2019\|\u201c\|\u201d' index.html` must return 0 before commit.
- One passive scroll listener for all scroll-based UI (progress bar, nav shadow, back-to-top) — already in place in `index.html`. Add to it, don't add a second listener.
- All scroll-triggered reveals use `IntersectionObserver` with `unobserve()` after firing. Never use scroll events for static reveal logic.
- `AudioContext` lazy init — created on first user click, not on page load. Catch errors silently. Audio SFX is an enhancement, not a dependency.

---

## Mobile — Think Mobile and Web Simultaneously

Every change is designed and implemented for both desktop and mobile at the same time. There is no "I'll fix mobile later."

- Design the mobile layout in your head before writing a single line of CSS. If a layout can't work on 390px, reconsider the desktop layout too.
- After every meaningful CSS change: mentally simulate at 390px (iPhone 15 Pro), 768px (iPad), and 1280px (desktop). If any breakpoint breaks, fix it in the same commit.
- Use `clamp()` for fluid type and spacing instead of stacked media query overrides where possible.
- Prefer `gap`, `flex-wrap`, and `min-width` over fixed widths that collapse on small screens.
- All touch targets: minimum 44×44px.
- Test scroll behavior: panels that expand should never cause horizontal overflow.
- For any panel with a text area or input, test virtual keyboard behavior: the input must remain visible when the keyboard slides up.
- Never place critical UI in the bottom 84px of the screen on mobile without `padding-bottom: env(safe-area-inset-bottom)` — iPhone home indicator territory.
- Key breakpoints currently in use: `640px` (single-column stacks), `860px` (defensive for fixed-width grid columns like the founder photo), `768px` (general tablet). Check these against your edit before committing.

---

## Commit Hygiene

- One feature = one commit. Don't bundle unrelated changes. If you touched something unrelated to fix a side effect, call it out explicitly in the commit body.
- Version every build. Format: `vX.X` (major = significant redesign/reorder, minor = component or copy change, letter suffix = rapid iterative pass, e.g. v3.0a → v3.0b).
- Pre-commit checklist (all must pass before `git commit`):
  1. `node --check /tmp/k.js` → pass
  2. `grep -c '\\\!' index.html` → 0
  3. No curly quotes in JS blocks
  4. Mobile layout verified at 390px (mental or DevTools)
  5. No new hardcoded hex values (all colors via CSS custom properties)
  6. No new external dependencies introduced
  7. Diff-check: confirm only the intended section changed, nothing adjacent was broken
