# Area AI — Claude API and learning inside the plugin (council RFIs first)

**Product:** CE_ACAD. **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`, area AI (item 22). **Opened 29 Oct 2026** by the carpark and planning intake chat from Tim's words (decisions\2026-10-29_TIM_PLANNING_CHANGES.md PC-04 and PC-05). **Status: PLANNED ONLY. Nothing built, nothing tested, nothing installed, nothing Tim-accepted.** Four separate facts, never a percentage.

## 1. The one-screen version (for Tim)

1. **Two kinds of "smart":** (a) learning from history is counting and matching, done on Tim's PC, no data leaves; (b) reading messy documents (council letters, marked-up PDFs) uses the Claude API.
2. **First product:** the council RFI family. A pre-submission checklist per council (so the RFI never comes), then an RFI reader that turns a letter into a to-do list, then a loop that learns what each council keeps asking.
3. **Claude never decides an engineering number.** It reads and proposes; CE's own rules calculate; an engineer approves every learned addition.
4. **Off by default, a Settings switch, a cost cap, Claude only, one letter at a time with names and addresses blanked.**

## 2. Tim's words that govern this area

1. 25 Sep 2026: "decision within the plugin should have a machine learning element" (UX-LEARN-01: habits, whole office, past CE projects, corrections; always shows why; never silently changes an engineering rule; an engineer promotes a learned default).
2. 25 Sep 2026: "we also need a council rfi ingest and reader" (UX-RFI-01..03: find the letter in the job folder, list every item as a to-do in a Council RFI tab in Project Review, check what it can: Met / Not met / Can't tell, Show where; learn what councils keep asking; no response-letter drafting).
3. 25 Sep 2026 (OFF_PC_CALLS audit): markup PDFs go one page at a time, to Claude only, with the title block blanked.
4. 29 Oct 2026: "need to be able to ingest and handle rfis from council", "we have lots of rfis and from other councils, the checklist sounds good, automation is key and also machine learning to know what to add for next time would be great", and, on this plan: "yes lets fully plan and add to the overall plan".
5. Standing: Settings-first (R-00), no hard blocks (R-27), Unknown stays Unknown, DATA-01 (client names and addresses never in a repo), keys only in `C:\Users\TimothyBrand\Keys\keys.txt`, the AI key never ships to colleagues (CE Cloud holds it).

## 3. What exists today (read, not tested)

1. **A Claude connection is already built:** `CE.AI.Core\AnthropicChatClient.cs` (streaming, retry, timeouts), reached through CE Cloud when `CE_CLOUD_URL` is set, otherwise direct with a key on the PC (OFF_PC_CALLS audit). CDASK and Analyse markups already use it.
2. **Known faults in the existing AI routes, to fix before any new one:** BUG-550 (markup / AI family goes to OpenAI, whole file, title block intact; the Enable MarkupAI switch is read by nothing), BUG-551 (Civil AI import sends up to 6 pages, Enter = Yes, no seat check), BUG-549 (Structural markup upload). These break the 25 Sep rule.
3. **Evidence:** three Kingston RFI letters (Tim's Downloads, local only) and about 125 jobs with council letters in `Civil\From Council` and `Civil\Council Feedback` (PC-04 updates 2 to 4). DATA-01 Gate 0 for the full corpus is recorded as FAILED in the plugin repo's docs: this area does not clear it.
4. **Where the learning lives:** UX-LEARN-01 is ruled but nothing built. The anonymised lessons go to this repository; client data stays in `C:\CE_DrawingIntelligence`.

## 4. The build order (slices; each needs a workflow card and Tim's approval before code, per the AGENTS.md review gate)

1. **AI-0 Governance and switches (no feature).** One Settings page for the AI: on/off (default OFF), approved provider (Claude only), monthly cost cap, what may be sent, a "Confidential project" tick that blocks sending, a log of every call (what, when, which job, size, cost; never the content). Verify Anthropic's current data-retention and no-training terms before any real letter is sent; do not proceed on assumption. Fix BUG-549, 550, 551 here.
2. **AI-1 Learning pool, no API.** A proper all-years read of the council folders (Tim named them 29 Oct; one pass by a builder, output anonymised: council, request type, wording; nothing client-identifying written). Output: a table of "council asks X on N jobs".
3. **AI-2 Pre-submission checklist, no API.** Per council: the standard notes list, the checks from CE's own numbers (permit discharge limit vs calculated flow, drawn vs calculated orifice, roof area per tank, charged pipe size under a dwelling, cover vs pipe class, invert-verification and permit notes present) and the details to draw. Kingston first (three letters in hand). Council values (phone numbers, minimum areas) come from the Settings / council rulebook, never from the code, each with a source and a "verify" flag. Ticks itself wherever it can (Tim: "automation is key").
4. **AI-3 RFI reader (first use of the API).** CE finds a new council PDF in the job's From Council folder (or Tim drops one in), works out the council and application number from the letter text (file names are just numbers), blanks the names and address, sends ONE letter's text to Claude, and gets back each request as a separate item with its type (note to add, check, detail to draw, human decision). Each item is matched to a checklist entry, ticked Met / Not met / Can't tell with Show where, and listed in the Council RFI tab in Project Review. Counts down the 90 days. No letter drafting (25 Sep ruling), subject to Tim's answer on a plain list of changes.
5. **AI-4 The learning loop.** After each RFI, requests that were not on the checklist become proposals: "Kingston asked for X on 3 jobs: add to the Kingston checklist?" Shows why and how often; the engineer promotes it to a company default (R-10 pattern); Manager shares the office list. Never silent.
6. **AI-5 Markup reader aligned to the 25 Sep rule** (CDASK and CEMARKUP: one page, Claude only, blanked title block), after BUG-550/551 are fixed.
7. **AI-6 Reviewer and plain-English help.** Reads a finished plan against the council rules and the checklist and lists gaps; answers "why did CE say this?" from the user's own settings and rules. A second pair of eyes, never the authority.
8. **AI-7 Habit learning (UX-LEARN-01 habits and corrections), local only,** after AI-4 proves the "shows why / engineer promotes" pattern.

## 5. Safety rules for every slice

1. Claude proposes, CE's rules calculate, the engineer approves. No engineering number is ever taken from a model reply (Unknown stays Unknown).
2. No hard blocks except the two in R-27; a failed or slow AI call warns and carries on, and CE works fully with the AI off.
3. Runs in the background; never while a command is running; a timeout line in plain words.
4. Each call is logged without its content; spend is metered against the cap; the key lives in CE Cloud, never on a colleague's PC.
5. Every window, command and wording follows the plain-English and no-jargon rules; every slice carries a Tim AutoCAD checklist and a Codex check.
6. Test with synthetic letters first (the three Kingston letters, anonymised, are the first fixtures; the originals never enter a repo).

## 6. Questions for Tim (one batch; none decided)

1. Are you happy for ONE letter's text, with the applicant, client name and address blanked, to go to Claude through CE Cloud? (Recommended: yes, switch off by default.)
2. Do the other councils' letters arrive by email before they are filed? (The 2026 jobs have none filed.)
3. Do you want the full all-years read of the council folders (AI-1)?
4. A monthly cost cap figure for AI use, or leave it to the desk to propose?
5. Which council after Kingston?
6. Does Tim want a plain list of changes made (for the covering letter), given the 25 Sep rule of no letter drafting?

## 7. Parked / related

`IDEAS_INBOX.md` (RFI idea, 29 Oct), PC-04 and PC-05, UX-RFI-01..03 and UX-LEARN-01 in `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, `areas\drawing-intelligence.md`, `areas\council-rulebook.md`, OFF_PC_CALLS audit `areas\release-v3-colleagues-OFF_PC_CALLS_2026-10-09.md`. BUG-538 (Kingston rules written into the code) feeds AI-2.
