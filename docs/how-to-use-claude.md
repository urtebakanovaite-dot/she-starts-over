# How to Use Claude — She Starts Over Project Guide
*Version 1.0 | Created June 2026*
*Plain-language guide for a beginner AI user.*

---

## The one thing to understand first

Claude has no memory between conversations. Every time you start a new chat, Claude starts completely blank — it has no idea who you are, what She Starts Over is, or what decisions you've already made.

**The fix:** you paste your context documents in at the start of every chat. That's the whole system. The documents you maintain are your "Claude memory."

---

## 1. How to set up this project

### The project feature (you're already using it)
Claude's "Projects" feature lets you store files that Claude can always see — without you pasting them in every time. You're already using this. The files in your project right now are:
- `she-starts-over.html` (the landing page)
- `she-starts-over-master-doc.md` (the full decision log)

**Add new files to your project as you create them.** Every document from the document system guide (changelog, roadmap, business overview, etc.) should live here once built.

### What goes in Project Instructions
Project instructions are a short block of text that tells Claude how to behave in every conversation in this project. Think of it as your standing rules. Write them once; they apply to every chat.

**Recommended project instructions for She Starts Over:**

```
You are a strategic and technical collaborator for She Starts Over, 
a curated community business run by Urte. 

Always read the project files before doing anything. State which files 
you read at the start of each response.

Rules:
- No full file rewrites. Targeted edits only.
- No preamble. Start with the answer.
- Bullets and numbered phases only. No prose paragraphs in plans.
- One idea per bullet.
- Action plan first — I approve before you execute.
- Flag HIGH risk changes and wait for approval before proceeding.
- Match existing branding exactly.
- Plain language. Non-technical explanations.
- Tell me what could go wrong and what I might be missing.
- Give a commit title + version number at the end of every build.
```

**How to add project instructions:**
- In your project, look for a "Project instructions" or "Custom instructions" section
- Paste the block above directly in

---

## 2. How to start a chat correctly

### The opening line matters more than anything else

Bad opening:
> "I want to update the landing page"

Good opening:
> "New session. Read all project files before doing anything. State which files you read and the current version. One line. Then [your actual task]."

Why: without the instruction to read files first, Claude may answer from general knowledge rather than your specific project context.

### The structure that works (you've already discovered this)
```
New session. Read all relevant project files. State which files you read. 
[What you want to accomplish this session.]
[Any specific constraints or decisions already made.]
Action plan first — I approve before you execute.
```

---

## 3. How to use Claude for different task types

### For strategy decisions
- Paste in the relevant section of the master doc
- Ask Claude to list options with trade-offs — don't ask "what should I do"
- Ask "what am I missing?" after every plan
- Approve a direction, then ask Claude to update the master doc with the decision + reasoning

### For writing copy
- Always give Claude: the audience, the tone, the goal, and examples of copy you like
- Ask for 2–3 options — not one version
- Tell Claude which you prefer and why — this trains the session
- Ask Claude to write to match the voice already in the landing page or master doc

### For editing files (HTML, documents)
- Always use the format you established: "action plan first → I approve → then execute"
- Claude reads the live file, makes targeted edits, outputs the finished file
- Never say "rewrite this" — say "change X to Y in section Z"

### For building new documents
- Tell Claude exactly what the document is for, who reads it, and what it needs to contain
- Give Claude the raw material (from master doc, your notes, decisions made in chat)
- Claude structures it — you review and approve

### For research and thinking
- Ask Claude to "think through" a problem before giving an answer
- Ask for pros/cons lists, not recommendations (you make the call)
- Ask "what's the cheapest/simplest way to do this?" to avoid over-engineering

---

## 4. How to update your documents

### The golden rule: decisions get written down immediately
Every time you make a decision in a Claude conversation — a pricing change, a strategy shift, a copy update — that decision needs to land in a document before the chat ends. If it doesn't, it disappears when you close the tab.

**At the end of every session, ask:**
> "Update the master doc with all decisions made this session. Add a new section at the top titled 'Session [date]'. List every decision, the reasoning, and any open items flagged."

Then copy Claude's output into your actual master doc file.

### Versioning your files
- Every time the HTML file is edited, the version number goes up (v1.0 → v1.1 → v1.2)
- The changelog records what changed and why
- This means you can always go back to a previous version if something breaks

### When to update which document

| Something changes | Update this document |
|---|---|
| Strategic decision | master-doc.md |
| Price changes | pricing-and-offers.md |
| Landing page edit | changelog.md + she-starts-over.html |
| New event confirmed | roadmap.md |
| New outreach contact | outreach-tracker |
| After an event runs | build-journal.md |

---

## 5. What Claude is good at vs. what it isn't

### Use Claude for:
- Writing, editing, and improving copy
- Structuring documents and plans
- Building and editing the HTML file
- Thinking through strategy options with you
- Spotting gaps in your plan ("what are you missing?")
- Generating templates (emails, DM scripts, forms)
- Summarizing long documents into short ones
- Formatting messy notes into clean structured docs

### Don't rely on Claude for:
- Memory between sessions (it has none — use documents)
- Real-time information (prices, competitor status, current events — it may be out of date)
- Making final decisions (it offers options; you decide)
- Knowing what happened after you closed the chat (it can't see your inbox or your Calendly)
- Emotional validation — it will tell you what's true, not what feels good

---

## 6. Common mistakes and how to avoid them

| Mistake | What happens | Fix |
|---|---|---|
| Starting a chat without pasting context | Claude gives generic advice that doesn't fit your project | Always open with "read all project files" |
| Asking Claude to "rewrite this" | You lose all the decisions baked into the original | Say "change X to Y, leave everything else" |
| Not writing decisions down before closing the chat | Decisions disappear | End every session with "update the master doc with today's decisions" |
| Asking Claude what you should do | You get a confident answer, not necessarily the right one | Ask for options + trade-offs; you make the call |
| Over-engineering early | You spend sessions building documents you don't need yet | Build only what the document system guide says is "Build Now" |
| Changing strategy mid-session without updating docs | Contradictions build up across documents | Pause and update the relevant doc before continuing |

---

## 7. A sample session flow (end to end)

**Opening:**
```
New session. Read all project files before doing anything. 
State which files you read and current versions. One line.
Today I want to: [task].
Context: [any relevant decisions or constraints].
Action plan first — I approve before you execute.
```

**During:**
- Approve the action plan
- Give feedback on drafts ("option 2, but softer tone")
- Flag anything Claude missed or got wrong
- Ask "what am I missing?" before signing off on any plan

**Closing:**
```
Before we close: update the master doc with all decisions 
made this session. New section at the top: Session [date]. 
Decisions / reasoning / open items.
```
- Copy Claude's update into your master doc file
- Update the changelog if any file was edited
- Note the next session's starting point somewhere

---

## 8. The short version (pin this)

1. **Project files = Claude's memory.** Keep them updated.
2. **Start every chat with "read all project files."**
3. **Action plan first, always. Approve before Claude executes.**
4. **End every session by asking Claude to update the master doc.**
5. **Never ask Claude to rewrite. Say "change X to Y."**
6. **You make decisions. Claude gives options and builds.**
