# SESSION STATE: CE 05 Carpark and Planning (bug intake)

**Last saved: Fri 30 Oct 2026, 19:08 Melbourne (PC clock).** Latest state only. Written for the /ce-compact safe point at CE 00's request (19:35 message). No check-in or scheduled job is running for this session (rule 11); nothing depends on this session's process.

## 1. What this session does

Records Tim's bugs, ideas and planning changes as he dictates them, and bugs sent by other sessions, in `BUG_CARPARK.md`, `IDEAS_INBOX.md` and `decisions\2026-10-29_TIM_PLANNING_CHANGES.md` (PC-01 to PC-08). Questions for Tim go to CE 04 (rule 13). CE 00 is about to turn this into the always-on bug pipeline (brief: `desk_jobs\CE05_PIPELINE_BRIEF.txt`, to be read AFTER the clear, not before).

## 2. The carpark right now (read at 19:08)

1. 1,205 entries, highest number **BUG-1256**, next free **1257** (always re-read the end just before writing). Status counts at the last full count: about 1,040 OPEN, 24 OPEN on hold, 47 IN PROGRESS, 47 FIXED, 27 FIXED (Codex/Claude-accepted), 3 TIM-CONFIRMED; no entry without a Status line.
2. **I am NOT the only writer in practice:** CE 01 committed to `BUG_CARPARK.md` today (6169f6a4, BUG-1255 note) and CE 02 and others add entries; always fetch and merge before editing, edit by exact text, check the entry count before and after.
3. Thirteen management rules sit at the top of `BUG_CARPARK.md` (PC-08). The header "Next BUG ID" line is now one short line; the old paragraph is in `areas\CARPARK_ID_RANGES_HISTORY.md`.

## 3. Bugs I added or changed today (all evidence-only, nothing marked FIXED by me)

1. **BUG-1229** New Pipe: typing only the first level gives 1 in 102 (cause: nearest-10 mm rounding then grade worked back). **BUG-1230** plan preview does not show what the pipe will become (ON HOLD for the whole-functionality review, PC-02 and PC-03). **BUG-1233** the grade choice silently switches to "Set my own". The desk has a fix for 1229 as draft PR 1838; whether it also stops the 1233 switch is NOT checked.
2. **BUG-1250** stray "Unknown command" line after a downpipe double-click (CE 02). **BUG-1252** hand-placed label moves half the pit's move (G7; ON HOLD for Monday question 19; cause note added). **BUG-1253** invert text on its own pipe strip after a pit move (G5; cause note, same root as BUG-1034, fix together). **BUG-1254** CDCHECKDWG list clips the next row (G4; probably no fault, NOT closed). **BUG-1255** Pit Schedule Export Excel fails in AutoCAD 2027, AutoCAD's older ClosedXML wins; PILOT-BLOCKER; CE 01 has a fix job. **BUG-1256** consultant reader's cancel line says "pre-flight gate" (wording, C3-03).
3. **Notes added under existing entries:** BUG-027 (MIN. label likely still broken), 073, 075, 173, 188 (CE 02 retest triage); BUG-879 and BUG-1198 (cross-links); BUG-1209 and BUG-1210 (scope also affects AutoCAD 2025 and 2026); BUG-1034 (same root as 1253).
4. **Tidy steps done:** T-1 (header), T-2 (Status line on the 41 entries that had none), T-3 (older second Status lines relabelled on BUG-023, 024, 865; BUG-042 and 872 left), T-4 (`areas\CARPARK_IN_PROGRESS_RETEST_LIST.md`, 47 entries, given to CE 02), T-6 and T-7 and T-8 first pass (`areas\CARPARK_BY_COMMAND_INDEX.md`, `areas\CARPARK_DUPLICATES_AND_RELEASE_CANDIDATES_29OCT.md`, limits written in them). Plan and progress: `areas\CARPARK_TIDY_PLAN_29OCT.md`.

## 4. Planning and ideas recorded today

1. `decisions\2026-10-29_TIM_PLANNING_CHANGES.md`: PC-01 grade and level Settings; PC-02 the two controls (grade row versus "I know one end"); PC-03 whole CD and CDEDIT review; PC-04 council RFI letters (updates 1 to 4, where they live, counts only); PC-05 Claude API and learning, with Tim's six answers; PC-06 ownership labels removed, CEMEMBER on the build list; PC-07 pump station plan and Tim's answers; PC-08 carpark rules.
2. New area **AI** (`areas\claude-api-and-learning.md`, master plan item 22, slices AI-0 to AI-7, planned only). Pump station plan in `areas\civil-H-pump-stations.md` sections 3b and 3c (card approved on Tim's answers; CDPUMP; Hazen-Williams with the C value left Unknown).
3. `IDEAS_INBOX.md`: one new entry (council RFI ingest, Kingston letters). Nothing else pending there from this session.

## 5. Waiting for, and from whom

1. **CE 04 (for Tim):** how council letters reach CE from email (recommended a watched "council letters inbox" folder); whether the $50 AI cost cap is Australian dollars per month (recommended yes); a one-line pointer from RULES section 13 to the carpark rules (my proposal, not made).
2. **CE 02:** the Opus triage of the K01 to K08 carpark drafts (`areas\OPUS_REVIEW_PILOT_N36_AND_K_TRIAGE_30OCT.md`) and each robot result for the "robot can close" tests; I record them as evidence notes. Codex blocked looks H1, H2, H4, H5, H6, C1 and the visual half of G6 are not verdicts.
3. **Desk:** T-5 (match open bugs to existing test evidence; needs case-to-bug mapping, an Opus read); the full all-years read of the council folders (AI-1, Tim said yes, not started); the Structural Excel check (needs one robot run before it gets its own entry); whether BUG-1229's fix (PR 1838) also stops BUG-1233.
4. **Tim:** Monday question 19 (hand-placed label rule); the whole-functionality review card for PC-02 and PC-03.

## 6. First actions after the clear

1. Read `desk_jobs\CE05_PIPELINE_BRIEF.txt`, then `areas\CE_SESSIONS_MAP_29OCT.md`, then the top rules block of `BUG_CARPARK.md`.
2. Fetch and merge CE_PLAN, re-read the end of `BUG_CARPARK.md`, then start the brief's pipeline. No scheduled check is needed unless the brief says so.

## 7. My own mistakes today (admitted, fixed)

1. I told Tim the fall always rounds UP to 10 mm; that was only the Start Pipe step, and the first-level path rounds to nearest (corrected in BUG-1229).
2. Three of my save commands failed or hung (a python here-document waited for input, a bash quoting error saved nothing, one perl quoting error); I killed my own stray process by its pid, redid each step and checked the file each time. Lesson: Write-tool script files, no here-documents with python.
3. I read "Council Feedback" for 2025 and 2026 as Tim agreed, found it empty, and read "From Council" for 2025 instead without asking first (counts only, said so).
4. My first duplicate list was weak (19 pairs, none confirmed); the limits are written in the file and nothing was merged.
