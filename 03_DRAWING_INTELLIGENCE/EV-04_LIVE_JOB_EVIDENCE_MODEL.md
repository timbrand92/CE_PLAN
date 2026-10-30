# EV-04 — Live job evidence model: a structural job from inputs to issue

**Planning:** DRAFT, for Tim's approval. Not approved.
**Implementation:** not started. **Tested:** no. **Installed:** no. **Tim-accepted:** no. (Four separate facts.)
**Opened:** Thu 29 Oct 2026, about 17:30 Melbourne, chat "CE_ACAD_Plugin - Evidence Model" (Claude).
**Tim's words:** `decisions\2026-10-29_TIM_EV-04_LIVE_JOB_EVIDENCE.md`.
**Timing (Tim, 29 Oct):** plan only. Nothing is built until after the colleague pilot (Mon 16 Nov 2026) and Tim approves this card.
**Sister card:** `EV-03_EVIDENCE_MODEL.md` (approved plan). Every EV-03 rule applies here unchanged.

---

## 1. The one-screen version (for Tim)

1. **EV-03 looks backwards** at finished jobs, to learn from them. **EV-04 follows a live job** from the day the architect's drawings arrive to the day you issue, and through every revision after.
2. **Three parts, one record per job:**
   1. **The job record**: every footing, member, note value and sheet on the job.
   2. **The source of every item**: *"F3 = 1200 x 600, from the footing list, row 3"*. No source means **Unknown**, never a guess.
   3. **Proof each stage was checked**: what was checked, against what, by whom, when.
3. **What you would see:** before an issue, CE lists what has no source or no check. Example: *"2 items have no source: beam B7 size; bearing value in the geotech note. 1 sheet uses an old background: S02 still shows architectural Rev C, Rev D arrived 3 Nov."* It warns. It never stops you (R-27).
4. **Claude's part:** your Claude skills (footing schedule, member schedule, geotech note, numbered notes) and the plugin both write into the same record. A skill that reads a screenshot says exactly what it read, and marks what it could not read as **Unknown**.
5. **Where it lives (Tim, 29 Oct):** `C:\CE_DrawingIntelligence`, private, never in a repository, never synced. **The skills' source notes (Tim, 30 Oct):** beside each drawing file in the job's Markups folder, read from there by the job record.

## 2. The stages of a structural job

These are the stages Tim chose (inputs, design/calcs, drafting, check/issue/revisions), split into the steps the drawing atlas (Evidence Job 2) found on real house sets. Each stage lists **what it records** and an **example**.

1. **Stage 1: inputs arrive.**
   1. Records: each document received, its revision or date, the day it arrived, and what it **supersedes**.
   2. Inputs: architectural set, geotechnical report, survey, client or builder brief, council or permit conditions, the previous issue (alterations jobs).
   3. Example: *"Architectural Rev D received 3 Nov; supersedes Rev C."*
2. **Stage 2: design and calcs.**
   1. Records: every engineering value with its **authority** (EV3-11): calculation, footing list, member list, computation sheet, the engineer's markup, the geotechnical report, or a CE office rule.
   2. Example: *"Allowable bearing 100 kPa, geotech report dated 12 Oct, page 4."* *"B7 = 200UB25, member list row 7."*
3. **Stage 3: background preparation.**
   1. Records: which architectural revision each Xref background was made from, and which sheets use it (the one-overlay-per-level recipe in Evidence Job 2).
   2. Example: *"S02 first floor framing uses background from architectural Rev C."*
4. **Stage 4: drafting.**
   1. Records: each drawn item that carries an engineering value (footing schedule rows, member schedule rows, member marks, notes with numbers, details), **which tool drew it** (CE command or Claude skill), and which stage-2 value it shows.
   2. Details: whether it is a library detail (Evidence Job 1 index), an edited library detail, or a custom detail.
   3. Example: *"Footing schedule on S03 drawn by the footing schedule skill from a screenshot of the footing list; 9 rows read; row F4 unreadable, Unknown."*
5. **Stage 5: check.**
   1. Records: each check, what it compared, against which source, **who** did it (engineer, drafter, CE automatic, Claude proposal), when, and the result (**Met / Not met / Can't tell**, the same words as area AI).
   2. Engineer markups become correction events (EV3-10): *before, markup instruction, final result*.
   3. Example: *"Footing schedule on S03 matches the footing list: Met (CE automatic, 4 Nov)."* *"Markup: B7 label move above beam; done on Rev B."*
6. **Stage 6: issue.**
   1. Records: issue purpose (preliminary, council, tender, construction, matching the stamp layers), sheets and revisions issued, the evidence check result at the moment of issue, and who issued it.
   2. Links to the approved register and issue card (`04_REFERENCE\structural\cards\STRUC-REGISTER-ISSUE_CARD_2026-09-26.md`); EV-04 does not replace it.
7. **Stage 7: revisions.**
   1. Records: when an input changes, which values, drawn items and sheets depend on it, so they show as **needs review**. What changed between two issues, and why (the source of each change).
   2. Example: *"Geotech report revised; 6 footing rows and the geotech note depend on it; S01, S03 need review."*

## 3. What every item in the record carries

1. **What it is**: footing, member, note value, detail, sheet, input document.
2. **Its value** (or **Unknown**).
3. **Its state**, kept distinct as the Master Plan section 5 requires: Sourced, **Unknown**, **Assumed**, **Manual / Pinned**, **Display Override**.
4. **Its class** (EV3-8): Fixed, Engineering, Drafting, Exception, Unknown.
5. **Its source**: which document, which revision, where in it (page, row), or which CE rule.
6. **Who or what put it there**: CE command, Claude skill, engineer, drafter; and when.
7. **Its checks**: zero or more stage-5 records.
8. **What depends on it**: drawn items and sheets that show it (used by stage 7).

## 4. Rules (all carried from EV-03 and the Master Plan; nothing new is invented)

1. **No source means Unknown**, even when the value looks right or appears on every past job (EV3-11).
2. **Proximity is not ownership.** A note near B4 is not B4's note without proof (EV3-6).
3. **Claude proposes; it never decides an engineering number** (area AI section 5). A value Claude read from a report stays "read by Claude, not checked" until a person checks it.
4. **Claude can never mark a check as done by the engineer.** Only a person's action records an engineer check.
5. **Warn, never block** (R-27). The pre-issue evidence check lists gaps; the user can issue anyway, and the record says so.
6. **Keep history.** A changed value keeps the old one, its source and the date; nothing is overwritten silently (EV3-14).
7. **Privacy (DATA-01).** The record names the client, the address and the architect's documents, so it stays in `C:\CE_DrawingIntelligence` only. Anonymised lessons may come back to this repository; the record never does.
8. **Settings-first (R-00).** Which checks are expected per job type (deck, house, townhouses, basement, commercial) is a Settings list, not code.

## 5. How Claude ties in

1. **The four Claude skills** (footing schedule, member schedule, geotech note, numbered notes) today make a DXF from a screenshot and keep **no record of what they read**. Under EV-04 each would also write a small source note for the job record: the input it read, the date, the rows or values it read, and the rows it could **not** read (Unknown).
2. **Reading inputs** (geotech reports, architectural revisions): Claude may propose values with a page reference, under the area AI governance (AI-0: off by default, Claude only, one document at a time, names and address blanked, cost cap). Those values stay "proposed, not checked" until a person checks them.
3. **Asking Claude about the job:** "what changed since Rev A?", "which numbers have no source?". Answered from the record, never from a guess.
4. **Feeding EV-03:** a finished EV-04 job is already the complete, labelled evidence package EV-03 has to rebuild by hand for old jobs (EV3-1, EV3-2: which issue is the real final).

## 5b. The current Claude skills, one by one (read 29 Oct 2026 from Tim's account; nothing changed)

**Tim, 29 Oct 17:12:** "the skills are good but they are just really simple starting points". So EV-04 does not design around how the skills work today. It sets **one source-note format** that any tool must write: today's skills, bigger skills later, or the plugin commands that may replace them. The gaps below are examples of what the format has to catch, not a fix list for these four.

**Found while reading:** all four skills are written for **Silvia**, run on **her PC**, and save into the job's `Engineering\Markups\<dated folder>` in the Projects folder. They work from **screenshots**, and their only record of what they guessed is a short message in the chat, which is lost when the chat closes. This affects where the record can live (section 7, question 1).

1. **Footing schedule skill (`footing-schedule-autocad`).**
   1. **Reads:** a screenshot of the footing list (PDF). **Draws:** the A3 Footing Schedule (mark, name, width, depth, reinforcement, F'c in the title).
   2. **Engineering values it carries:** every width, depth and bar callout, and F'c.
   3. **What it already flags in chat:** corrected marks (`1b1` to IB1), guessed names (TB, "confirm with Silvia"), an F'c not given, 3-line cells, reworded text.
   4. **Gap:** when the screenshot gives no F'c it writes **25MPa** anyway. Under EV-04 that value must be recorded as **Assumed (office default)**, not Sourced.
   5. **Should record:** which footing list and revision, the date read, one line per footing (value, row on the list), each correction and guess, each Assumed value, unreadable cells as Unknown.
   6. **Checks it already does:** the DXF opens with 0 errors and the preview has one column per footing. Those are **drafting** checks; they do not prove the numbers match the footing list.
2. **Member schedule skill (`member-schedule-autocad`).**
   1. **Reads:** screenshots of the Excel member list. **Draws:** the member schedule in Silvia's dynamic block (1 to 3 columns).
   2. **Engineering values it carries:** every mark and member size, spacing, backspan and cantilever.
   3. **What it already flags in chat:** rows cut off at the screenshot edge, text that looks struck through, odd marks ("FB17 r"), typos fixed, rows spanning two lines.
   4. **Gap:** it **re-orders** groups and rows (supports first, tie beams under floor beams). That is presentation only; the record must keep the link from each schedule row back to its Excel row so the re-order cannot hide a missing member.
   5. **Should record:** which member list (file, sheet, date), each mark with its Excel row, rows cut off or unreadable as Unknown, every typo fix and every guessed mark.
3. **Geotechnical note skill (`geotech-note-autocad`).**
   1. **Reads:** a screenshot of the geotech report details. **Draws:** the GEOTECHNICAL NOTE (site class, report number, company, date, founding depth, soil, bearing capacity per footing type).
   2. **Engineering values it carries:** site class, founding depths, bearing capacities. **These are the values the footings are designed on.**
   3. **What it already flags in chat:** ambiguous wording, and the SOLE RELIANCE line when it was added from the template.
   4. **Gap:** the note cites the report, but nothing links the bearing value back to the **page** of the report, and nothing tells the footing schedule which report revision it depends on (stage 7).
   5. **Should record:** report number, company, date, the page the screenshot came from, each value as Sourced with that page, anything rewritten into template wording, anything added from the template.
4. **Numbered notes skill (`numbered-notes-autocad`).**
   1. **Reads:** a screenshot of handwritten or typed markup notes. **Draws:** NOTE 1:, NOTE 2: … text.
   2. **Engineering values it carries:** lengths, bolt counts and member marks written by the engineer on a markup.
   3. **What it already flags in chat:** guessed member marks (DS1 / DSI / DSJ), corrected handwriting slips. It already refuses to add engineering content that is not in the screenshot.
   4. **Gap:** a guessed mark ("DS1, most likely") goes onto the drawing looking exactly as certain as a clear one.
   5. **Should record:** which markup (date, sheet, page), each note as written and as transcribed, every guessed reading as **Assumed, needs check**. This is also the EV3-10 correction event: *markup instruction, final note*.

**What the four skills have in common, and the one change EV-04 asks of them (plan only):** each would save a small **source note** beside the DXF it already makes, with the same name and the ending `- SOURCE.json` (for example `FOOTING SCHEDULE - SOURCE.json`). It holds what was read, from which document and revision, the date, every value with its place in the source, and every guess, correction, Assumed value and Unknown. The chat reply stays as it is. Nothing about the drawing output changes.

**Stages with no skill today:** stage 1 (logging inputs as they arrive), stage 5 (checking a drawn schedule against its list), stage 6 (issue) and stage 7 (what a new revision affects). Candidate new skills, parked until this card is approved: a **job inputs log** skill, a **schedule check** skill (reads the DXF and the source note, and says Met / Not met / Can't tell per row), and a **what-changed** skill between two issues.

## 6. Build order (slices; each needs its own workflow card and Tim's approval; nothing starts before the pilot)

1. **EV4-0: this card approved** by Tim, with his answers to section 7.
2. **EV4-1: the record itself, no plugin change.** Folder layout under `C:\CE_DrawingIntelligence` (proposed `12_Live_Job_Evidence\<job>\`), the record format, a hand-made example job. Test: Tim reads the example and says whether it describes the job.
3. **EV4-2: the four Claude skills write their source notes** (section 5b). Outside the plugin. One skill at a time, footing schedule first. Tests: (a) a footing list screenshot with one blurred row: the source note lists that row as Unknown; (b) a screenshot with no F'c: the note lists 25MPa as Assumed; (c) a markup with "DSI": the notes skill records DS1 as a guess, needs check.
4. **EV4-3: the plugin writes the record** when it places schedules, member marks and notes (CEMEMBER, schedule importers, CENOTES).
5. **EV4-4: checks and the pre-issue evidence check** (stage 5 and 6). Test: issue a set with one unsourced beam; CE warns, names B7 and Show where, and the issue still goes ahead.
6. **EV4-5: revisions** (stage 7). Test: register architectural Rev D; the sheets with a Rev C background show "needs review".
7. **EV4-6: hand finished jobs to EV-03.**

## 7. Open questions for Tim (not decisions)

1. **Colleagues and the skills.** With the record in `C:\CE_DrawingIntelligence` it exists on Tim's PC only. But the four skills run for **Silvia, on her PC**, and save into the job's Markups folder (section 5b). Their source notes cannot reach Tim's `C:\CE_DrawingIntelligence`. Options: (a) source notes sit beside the DXF in the job's Markups folder, and the job record on Tim's PC reads them from there; (b) keep everything on Tim's PC and the skills record nothing until sharing is decided; (c) move the whole record into the job folder. Recommendation: (a). **ANSWERED (Tim, Fri 30 Oct 2026, 11:57): "yep sounds good" = option (a).** Each skill's source note sits beside its drawing file in the job's `Engineering\Markups\<dated folder>`; the job record in `C:\CE_DrawingIntelligence` on Tim's PC reads them from there. The job record itself stays in `C:\CE_DrawingIntelligence` (29 Oct choice, unchanged).
2. **Job identity.** Name each job's record folder by the office job number? (The number stays local; it never goes into a repository.)
3. **Who counts as a checker.** Engineer only, or engineer and drafter with different weight?
4. **Which issues run the evidence check.** Every issue, or construction issue only?
5. **Expected checks per job type.** For example, does a deck need a geotech check?
6. **Who owns `C:\CE_DrawingIntelligence` now.** Its README (Aug 2026) names Codex as implementation authority; PC-06 (29 Oct) removed the Claude/Codex ownership labels. Which applies to this folder?

## 8. What EV-04 does not do

1. It does not design anything or choose any engineering value.
2. It does not change EV-03, the register/issue card, or any shipped command.
3. It does not send client documents anywhere except under area AI's rules.
4. It does not stop an issue.
