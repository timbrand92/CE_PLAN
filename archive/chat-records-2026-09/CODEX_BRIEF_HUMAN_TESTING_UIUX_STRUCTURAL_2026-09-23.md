# Codex brief — test like a drafter, review the whole plugin, audit Structural, draft a project (23 Sep 2026)

**Asked by Tim, 23 Sep 2026 (verbatim):** *"can you get codex to continue testing how it is but also make sure when it tests it
test with context of how a human would control and use and look at the program and how it feels from an end user
perspective then make updates to suit. the last sort of task on tuesday will be to get codex to draft a project from scratch
with an existing project from our project folder. codex also needs to review the entirety of the plugin as a whole and provide
recommendations on how it can be better for a ui ux persoective and from a usability standpoint then if it could also look in
to the current state of the stductural module as well and provide audits and updates for you to fix and improve"*

Driven by the deploy chat, one Codex run at a time, exactly as today. Every standing rule of
`CODEX_TEST_RUN_2026-09-23_RELEASE.md` still holds: never F2, **No** to every save prompt except on a test copy, never save a
setting, template or profile, never type a credential (report a sign-in or licence prompt and stop), work only on COPIES, and
name drawings by label only (DWG-A, PRJ-1), never by address or client (DATA-01).

**Who fixes what (ruling B):** a finding about what a command *does* goes to the release chat (Claude). A finding about how a
*window* looks or is laid out goes to Codex's window work. Tag every finding **Behaviour** or **Window**.

---

## PART H — every test step, also judged as a drafter would feel it (from the next install onwards)

Keep the four results (PASS, FAIL, BLOCKED, NOT TESTED) exactly as now. For every step you run, add one **Feel** line in plain
words, answering whichever of these applies:

1. **Could a drafter find it?** Ribbon button where they would look, name they would recognise, tooltip that says what it does.
2. **Did the prompts read like English?** Any software word (object, handle, role, attachment, spine, record) on screen.
3. **How many picks, clicks and Enters** from start to result. Anything asked twice, or asked that CE could have worked out.
4. **Waits:** anything over about 2 seconds with no sign of progress.
5. **Surprises:** something moved, disappeared, changed colour, or landed somewhere other than where you picked.
6. **Escape and Undo:** did Escape leave nothing behind; did one Undo remove the whole result.
7. **Windows:** everything visible on open without scrolling (Tim's rule), the one decision obvious, the next action obvious.

A step that passes but feels wrong is still **PASS**, with the Feel line saying what is wrong. The release chat turns Feel lines
into fixes.

## PART U — a review of the whole plugin, from a user's chair (read-only; any time AutoCAD is free)

Walk every CE ribbon tab (CE, CE Tools, CE STRUC), every panel and button, and every window it opens, on the test copies.
Reading the code is allowed where it explains what you see. **Change nothing.**

Write `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_UIUX_REVIEW.md`, grouped in Tim's order: **CDWT, CD, PIT**, then sources,
levels, calculations and CDCALC, CDDESIGN, review and checks, import, settings, Manager, Structural. For each recommendation:

1. **Where** (command or button, window, which field or prompt).
2. **What a drafter meets today**, in one or two sentences.
3. **The change**, specific enough to build.
4. **Why it matters** (time saved, mistake avoided, confusion removed).
5. **Behaviour or Window**, and **small / medium / large**.

Start with a **top ten**: the changes that would most improve a colleague's first week. No scores, no percentages.

## PART S — Structural audit (read-only; any time AutoCAD is free)

The shipping Structural is 1.0.74 (`60c41228`) plus today's fix for SBEAM on AutoCAD 2027 (`aad3fe02`, branch
`claude/struc-text-order-60c41228`). Audit it as it will ship:

1. **Start with the commands nobody has run on AutoCAD 2027** (the deploy chat's point: SBEAM was broken on every 2027 drawing and nobody had drawn a steel beam on the shipping build until 23 Sep). Then run every other command on the CE STRUC tab and the Structural panels, on `DWG-S.dwg` (blank). If Tim has named a structural job
   copy by then, use it too; **do not pick one yourself.**
2. For each command: does it work, what does it draw, Escape, Undo, the Feel line (Part H), and anything in the Structural log
   (`%APPDATA%\TIM_CE_CADTOOLS\logs\ce_struc_structured_*.log`) for that minute: copy the exception and stack lines.
3. Read the Structural code where a command fails or feels wrong, and say where the fault is (file and method).

Write `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_STRUCTURAL_AUDIT.md`: one row per command (**Works / Fails / Partly**), then the
findings, each tagged Behaviour or Window, with the file and method when known. The release chat fixes them.

## PART P — Tuesday, the last task: draft a project from scratch, with an existing project

**Tim names the project on Tuesday** (it is client data, so neither chat picks it). Then:

1. Copy **only the inputs** (architectural background, survey, any rating report) into
   `C:\Lisp Files\_TEST_COPIES_20260923\PRJ-1\`. **Never open, save or change anything in the project folder itself.** Call it
   PRJ-1 in every note.
2. In a new drawing from the office template, draft the drainage **with CE only**: CDDESIGN, sources, CD, PIT, CDWT, levels,
   CDCALC, schedules, as a drafter would.
3. Compare with the office's issued drainage drawing for that job, looking without changing it: what CE got right, what it got
   wrong, what it could not do, and how long each stage took.
4. Write `C:\Lisp Files\_TEST_COPIES_20260923\PRJ-1\PRJ-1_DRAFT_REPORT.md`, with the Feel line for every stage.

This is the closest test to a colleague's real day, and the one Tim will read first.

---

**Order:**

1. After the next install: Part Z re-runs, with Part H Feel lines.
2. Then the remaining pass-1 parts (A, V, K), with Part H.
3. In gaps, and overnight when useful: Parts U and S.
4. Tuesday, last: Part P, once Tim has named the project.

**Reports stay outside every repository.** The release chat copies only findings, never names, into CE_PLAN.
