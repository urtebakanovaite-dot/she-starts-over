# She Starts Over — Tech Stack & Site Launch Plan
*Version 1.0 | Created June 2026*
*For a non-technical user. Partner handles anything marked [PARTNER].*

---

## The Stack (Free, Matches Partner's Setup)

| Tool | What it does | Cost | Who sets it up |
|---|---|---|---|
| **GitHub** | Stores your site files | Free | [PARTNER] |
| **Vercel** | Puts your site on the internet, auto-updates when files change | Free | [PARTNER] |
| **Namecheap** or **Porkbun** | Buys your domain name | ~€10–12/year | You |
| **Calendly** | Booking page for founding member calls | Free (1 event type) | You (already have) |
| **Tally** | Application form + event interest forms | Free | You |
| **Brevo** | Email list + automated follow-up sequences | Free (up to 300 emails/day) | You |
| **Umami** | Website visitor analytics | Free | [PARTNER] |
| **Eventbrite** | Event ticketing (She Connects + brunch) | Free to list; ~3–5% per paid ticket | You |

**One-time cost: ~€10–12/year for the domain. Everything else is free.**

---

## Why This Stack

- Your partner already uses all of it — less learning curve, he can help when stuck
- Vercel + GitHub means the site auto-updates every time a file changes — no manual uploading
- Tally replaces Typeform (same quality, free, partner already uses it)
- Brevo is GDPR-compliant and built for European businesses — important for Amsterdam
- Umami is cookieless — no cookie banner needed, fully GDPR compliant
- Eventbrite takes the payment complexity off your plate entirely

---

## Before You Start: What You Need Ready

- [ ] The HTML file (`she-starts-over.html`) — ✅ exists
- [ ] Real Calendly link — check your Calendly account, copy the booking URL
- [ ] A domain name decision — see step 2 below
- [ ] Eventbrite account — free to create at eventbrite.com

---

## Step-by-Step Launch Plan

### STEP 1 — Partner sets up GitHub + Vercel [PARTNER, ~30 min]

What happens:
1. Partner creates a new GitHub repository (a folder for your site files)
2. Partner uploads `she-starts-over.html` to the repo
3. Partner connects the repo to Vercel
4. Vercel gives you a free URL like `she-starts-over.vercel.app` — this is your site, live

What you do: send the HTML file to your partner and say "can you get this on GitHub + Vercel?"

**Test before moving on:** visit the Vercel URL and confirm the site looks right.

---

### STEP 2 — Buy your domain (~15 min, you do this)

**Where to buy:**
- **Porkbun** (porkbun.com) — cheapest, ~€8–10/year, clean interface
- **Namecheap** (namecheap.com) — slightly more but very reliable, partner likely knows it

**Domain options to check (in order of preference):**
1. `shestarsover.com`
2. `shestarsover.co`
3. `she-starts-over.com`
4. `shestarsover.eu` (local option, Amsterdam-based)

**How to check:** go to porkbun.com, type the name in the search box, see what's available and what it costs.

**Buy the `.com` if available. If not, `.co` is fine. Avoid `.net` or unusual extensions — they look less professional.**

Do NOT buy from the hosting company (Vercel) — always buy domains separately. Keeps things simpler if you ever change anything.

---

### STEP 3 — Connect domain to Vercel [PARTNER, ~15 min + 24–48hrs wait]

What happens:
1. You log in to Porkbun/Namecheap and find the DNS settings
2. Partner gives you 2 values to paste in (an A record and a CNAME record)
3. You paste them in, save
4. Wait 24–48 hours — Vercel automatically picks up the domain

**You don't need to understand what DNS means** — it's like updating an address in a phone book. Your partner will tell you exactly what to paste where.

**During the wait:** your site is still live at the `.vercel.app` URL. You can share that URL internally for testing.

---

### STEP 4 — Add real Calendly link to the HTML [PARTNER or Claude, ~5 min]

In the HTML file, find this text (appears twice):
```
https://calendly.com
```
Replace both with your real Calendly URL, e.g.:
```
https://calendly.com/urte/founding-member-call
```

Then push the updated file to GitHub — Vercel auto-updates the live site within 1 minute.

**How to find your Calendly URL:** log in to Calendly → click the event you created for founding member calls → copy the link.

---

### STEP 5 — Create and publish She Connects on Eventbrite (~30 min, you do this)

1. Go to eventbrite.com → Create an event
2. Copy the event description from master doc Phase 4 — it's finalized and ready
3. Set: date (August 19), time (12PM CET), online (choose "Online Event"), price (€25), capacity (12)
4. Add the 10 tags from master doc Phase 4 (for discoverability)
5. Publish
6. Copy the Eventbrite link

Then replace the placeholder Eventbrite link in the HTML:
```
https://eventbrite.com
```
→ with your real Eventbrite event URL.

---

### STEP 6 — Set up Tally application form (~45 min, you do this)

1. Go to tally.so → create free account
2. Build the form using the 10 questions from master doc Phase 6 (they're finalized)
3. Add the opening description (also in master doc Phase 6)
4. Add the closing screen (also in master doc Phase 6)
5. Publish the form — Tally gives you a link
6. Add the Tally link to the landing page

**Where to link it from:** the "Apply" or "Book a call" buttons can link to Tally instead of (or in addition to) Calendly — discuss with Claude where it fits best in the flow.

---

### STEP 7 — Set up Brevo email list (~30 min, you do this)

1. Go to brevo.com → create free account
2. Create a contact list called "She Starts Over"
3. Create a second list called "She Connects Attendees" (for post-event follow-ups)
4. Build the Day 1 post-event email using the template in master doc Phase 5 — save as a draft
5. Build the Day 7 follow-up email — save as a draft
6. (Optional) Add a simple email signup to the landing page — Claude can add this HTML element

**You don't need to build automations yet** — send emails manually for the first event. Automate once you've run the sequence once and know it works.

---

### STEP 8 — Add Umami analytics [PARTNER, ~10 min]

1. Partner sets up Umami (or uses their existing account)
2. Partner adds a one-line tracking code to the `<head>` section of the HTML
3. You can then see: how many people visit the site, what they click, where they drop off

**Why Umami over Google Analytics:** cookieless (no cookie banner needed), GDPR-compliant, simple dashboard, partner already uses it.

---

### STEP 9 — Privacy policy page [YOU, ~20 min]

**This is not optional if you're collecting emails or running events in the EU.**

What you need:
- A simple Privacy Policy page linked in the footer
- It needs to state: what data you collect, why, how it's stored, and that you use Brevo and Umami

**Cheapest way:** use a free generator like [Termly](https://termly.io) or [PrivacyPolicies.com](https://privacypolicies.com) — fill in the fields, copy the output, create a new HTML page for it.

**Partner can add a second page** (`privacy.html`) to the GitHub repo in 5 minutes. You just need to supply the text.

**Footer link already exists in the HTML** — just needs a real URL to point to.

---

### STEP 10 — Test everything before sharing publicly (~30 min)

Go through the site on your phone and desktop and test every single click:
- [ ] Calendly link opens and lets you book
- [ ] Eventbrite link opens and lets you buy a ticket
- [ ] Tally link opens the application form
- [ ] Footer links work (LinkedIn, Privacy Policy)
- [ ] Nav "Book a call" button works
- [ ] "Not sure yet?" link scrolls to She Connects section
- [ ] Email signup works (if added)
- [ ] Site looks right on mobile

**Don't share the URL publicly until all of the above pass.**

---

## Future Site Pages (not now — when needed)

| Page | When to build | What it is |
|---|---|---|
| `/she-connects` | Before Q4 She Connects event | Dedicated event page |
| `/brunch` | Before second brunch | Amsterdam brunch info + Eventbrite |
| `/apply` | When regular members open (October) | Full application page |
| `/members` (password protected) | When community grows past 20 | Member resources, session recordings |

**Build none of these now.** One page, live, functional, converting — that's the goal.

---

## Site Quality Standards (for Claude to follow on every edit)

- Mobile-first: test every change on mobile before desktop
- Load time: no heavy images, no external scripts beyond Google Fonts and Umami
- Accessibility: all buttons have descriptive text, sufficient colour contrast maintained
- Links: every external link opens in a new tab (`target="_blank"`)
- Forms: Tally embedded or linked — never a raw HTML form (breaks on most hosts)
- CSS: changes to one section must not break another — Claude tests adjacent sections after every edit
- Version: every edit increments the version number; changelog updated

---

## What Could Go Wrong (and the fix)

| Problem | Fix |
|---|---|
| Domain doesn't connect within 48 hrs | Check DNS records were saved correctly in Porkbun/Namecheap |
| Calendly shows wrong timezone | Set your Calendly default timezone to CET |
| Eventbrite takes a large % of ticket revenue | At €25 × 12 = €300, Eventbrite's ~3.5% fee = ~€10. Acceptable for now. Consider Stripe or direct bank transfer at higher volumes. |
| Tally form looks different from the site | Tally has a plain design — link to it rather than embedding it. Embedding can look off. |
| Site looks broken on mobile | Send Claude the specific section that's breaking — targeted fix only |
| GDPR complaint | Privacy policy page + Umami (cookieless) + Brevo (GDPR-compliant) is your baseline protection |
