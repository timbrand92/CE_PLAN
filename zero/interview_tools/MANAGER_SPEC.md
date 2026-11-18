# The Manager (MANAGER / MG): what it does, from Tim's answers

**Revision:** 3 (Wed 18 Nov 2026, afternoon, Melbourne time; revision 2 added statistics, MS-12; revision 3 settles the three open items, MS-13 to MS-15). IDs: MS-01 onwards, never reused. Builds on MG-01 to MG-06 in `design\TOOLS_AND_MANAGER_INTERVIEW.md`.
**Sources:** TA-011 to TA-013, TA-088 to TA-095 in `interview_tools\ANSWERS.md`. Earlier rulings: D-028 (one-click update and back), D-071 to D-074 (job link), D-180 (a drawing keeps its own values), D-204.
**Status:** planning only. Nothing is built. In the first release with the 18 shared tools (D-201).

## What it is

1. **MS-01 Opening it:** typed MANAGER or MG, or the button at the end of the CE Tools tab (TA-088). MG is free in AutoCAD's own short-name list and in Tim's. The full word is still to be typed once in AutoCAD to prove it is free.
2. **MS-02 What it never does:** no drawing tools. No drawing repair, survey intake or project QA pages (TA-012).

## Updates

1. **MS-03 Tim approves first.** A new version that passes the night tests reaches Tim only. He presses "approve for everyone" on his admin page, and only then are colleagues offered it (TA-089).
2. **MS-04 The offer:** when AutoCAD starts, a small window with "Install now" and "Later" (TA-090). One click installs it, with no administrator rights; going back is one click (D-028).
3. **MS-05 What changed:** the first time AutoCAD opens on the new version, up to three plain lines (for example "CN now flattens Xref files"), with a link to the full list (TA-091).

## Faults

1. **MS-06 Report a problem:** one button.
   - **What the person types:** a short box for what they were doing.
   - **What it sends:** the CE log, the version and the drawing (TA-092).
   - **Where it goes:** to the office IT folder, and Tim is told.
2. **Note for the build (planning chat's note, not Tim's words):** the drawing is client data. It may go only to the office's own IT folder, never to GitHub, the plan or any outside service (RULES 11). The log is scrubbed of private text as the old plug-in did; the drawing goes as it is.

## Office lists

1. **MS-07 Only Tim edits them:** standards, typed names, the block list (37 blocks), the hatch list by function, CLEAN's steps (MG-03).
2. **MS-08 How a change reaches colleagues:** at their next AutoCAD start (TA-093). A drawing designed with the old values keeps them; one line says what changed and offers to switch (D-180).

## Job link

1. **MS-09 Which job:** read from the drawing's folder or file name by the office naming pattern; it asks once if it cannot tell (TA-094). The old plug-in's naming-pattern code is worth reading again here (parts bin item 26).
2. **MS-10 What it hands the Job Manager program:**
   - the stage reached;
   - what was issued and when;
   - time on the drawing, counted by itself and checkable (D-072);
   - assumed values still open.

   Everyone sees job totals; only Tim sees who (D-073). The tracking itself lives in the Job Manager program, not here (D-071).

## Tim's admin page (only he sees it)

1. **MS-11 On it** (TA-013, TA-095):
   - each PC's version;
   - who is on an old version (flagged);
   - faults this week;
   - "approve for everyone";
   - "go back for everyone" (all PCs to the last good version);
   - a list of what Tim changed in the office lists, and when.
2. **MS-12 Statistics, IN the first release** (Tim: "CAN YOU ADD STATISTICS TO THIS RELEASE?", TA-096 to TA-098):
   - how many times each tool was used;
   - how long each tool takes, from typing it to OK;
   - which tools fail or are cancelled most;
   - drawing time per job (from the job link).

   Totals are shown to everyone; per person only on Tim's admin page (as D-073). The old plug-in's "one record per command run" idea is the starting point. Its gap must not come back: it only counted commands it wrapped (parts bin item 29).
3. **Later, not the first release:** fuller admin control (FI-02).

## Settled 18 Nov 2026 (were open in revision 2)

1. **MS-13 Who is the administrator:** a short admin list in the office IT folder names Tim's Windows sign-in; only he can change it (TA-099).
2. **MS-14 "Go back for everyone" while AutoCAD is open:** the small window shows at once ("Go back: Now / At next start"); nothing closes the colleague's drawing (TA-100).
3. **MS-15 Fault reports and their drawings:** kept 90 days, then deleted, with Tim told first (TA-101).

## Still open

Nothing.
