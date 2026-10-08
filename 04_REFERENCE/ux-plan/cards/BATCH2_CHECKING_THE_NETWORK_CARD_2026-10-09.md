**Code read on rel-20261009c 446162c2** (installed Civil 3.0.39; re-checked by design run 6, Fri 9 Oct 2026 about 05:40 PC clock).

# Batch 2 card: checking the network (Day 1 steps 12 and 13), 9 Oct 2026

## Re-check on the release commit (run 6, 9 Oct 2026)

This card was already written against 446162c2. Run 6 re-read every file:line in "Code references" on that commit:
1. **CONFIRMED (all):** the Ends/Fit/Items one-prompt switch (`Commands/SpineCheckCommand.cs:176-180`); the "A pipe end left pit P4: it is
   now Not connected yet. CDCHECK lists it until you connect it." line (`Rules/NativeEditEndpointOwnerRule.cs:146-162`, called from
   `Services/LinkService.Reactors.cs:1326-1333`); the pit-erase line (`Services/PitEraseFreeEndsMessagePolicy.cs:42-43`); the only
   "What CE Found" palette (`Services/DrawingCheckPaletteService.cs:65`); the commands CDCHECKCURRENT, CDDASHBOARD, CDINSPECTOR, CDRULES,
   CEPERFDIAG at the lines given; every "Select ..." prompt quoted in card 2.4 at the lines given; no `ProgressMeter` anywhere in
   Modules or Shared; the progress bar in `Controls/CeEditorShell.xaml` still used by no window; no "ignore a finding" store or Ignored list.
2. **CONFIRMED, the four files the card read on master:** automatic Project QA still waits 3 seconds
   (`Services/CivilProjectQaAutomaticService.cs:52`); since master it also skips Structural-only drawings and waits while REDO is still
   possible (BUG-256). `Services/Spine/SpineDecisionLedger.cs` gained "a source sits on this main" records (CD-BRANCH-01), still no
   ignore. `Rules/RulebookEngine.cs` gained two warning-only rules since master: R-31 speed in the pipe leaving a pit and R-32
   detention pipe 225 and up no flatter than 1 in 200 (INT-068 items 2 and 3, Tim 8 Oct). **CHANGED for card 2.2 only in this
   sense:** the Rules tab of the Checks palette must show these two warnings too.
3. **Wording fix:** "installed Civil 3.0.38" below ~~is~~ *(superseded 9 Oct 2026, run 6)*: 446162c2 is installed Civil **3.0.39**.
   The W35/W36 Codex observations quoted below were on 3.0.38 and still match the 3.0.39 code.

**Status: DRAFT. Not approved. No code may start until Tim answers `TIM_BATCH_QUESTIONS_2_3_2026-10-09.md` (questions 1 to 7) and
approves this card.**
Written by design lane run 5 (headless, Opus), Fri 9 Oct 2026 about 05:20 Melbourne (PC clock). Read-only on plugin code: "today"
below is read from the Civil release commit `446162c2` (train C-25, 9 Oct 03:02, branch `claude/rel-20261009c`; NOT `master`,
which stopped at `650c0c19` on 28 Sep and is weeks behind every installed build) and from the Codex reports in
`C:\Lisp Files\_TEST_COPIES_20260923` (named per line). Code lines are not proof of what installed Civil 3.0.38 does. File
references are at the end of this card.

**Items (6):** UX-DI-01, UX-DI-03, UX-DI-04, UX-SEL-01, UX-PERF-01, UX-PERF-02. (UX-DI-02, AutoCAD's own TRIM / EXTEND / BREAK / JOIN
on CE pipes, waits on the one-piece pipe and is not in this batch.)
**Commands touched:** CDCHECK, CDRULES, CDCHECKCURRENT ("What CE Found" palette), CDDASHBOARD (Project Review), CDINSPECTOR, every
command that asks the drafter to pick a pipe or pit (CDEDIT, PIPEEDIT, PITEDIT, CDANNOTATIONEDIT, CDTAG, CDCONFIRM and others), CEPERFDIAG,
and one new thing: a **Checks palette** (UX-WIN-04 names it as a palette that stays open).
**Why now:** Day 1 steps 12 (`CDCHECK`) and 13 (`CDRULES`) are what a new colleague runs to see whether the network is right. Today
both answer only on the command line, and the counts they give do not match the other two check windows (Codex UI/UX review item 17:
"a colleague needs a next action, not three unexplained competing counts").

**Authority:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` lines 1052-1066 (UX-DI-01..04, 26 Sep 00:49), lines 1190-1196
(UX-PERF-01, 02, 26 Sep 01:11), line 1814 (UX-SEL-01), lines 1839-1840 (UX-WIN-04: Checks is a palette that stays open);
`V3_UX_PLAN.md` section 1 rules 8 (quiet when OK), 12 (speed) and 17 (nothing selected), section 2 item 5.

**Related open bugs (do not fix twice):** BUG-389 (CDCHECK command-line list prints a raw arrow code for old pipe names), BUG-359
(CDCHECK ran 4+ minutes in the headless test driver; verdict: the driver, not CE) and the "hang" note under BUG-358, BUG-239 (CDRULES
and Project Review quote raw internal source paths instead of document and page). Codex Explore 1 item 10 (29 Sep): Enter at "Jump to
item number" led to a SECOND number prompt for pipe end warnings, so the next typed command was refused. FIXED in the release code:
one number prompt that switches list by keyword ("Jump to item number (1-60) or [Fit/Ends], or Enter to finish"); W35/W36 on 3.0.38
saw "Jump to item number (1-60) or [Ends]:" and one Enter ended it.

---

## Card 2.1 — UX-DI-01: after an ordinary AutoCAD edit, CE re-checks quietly

1. **Tim ruled (26 Sep):** "Straight after, quietly." CE re-checks only the edited items and their neighbours; ends that no longer
   touch turn amber "Not connected yet"; no pop-up; shown in Checks; never reconnects on its own.
2. **Today:**
   - After MOVE, STRETCH, a grip edit or ERASE, CE's link watcher makes pipes follow a moved pit and labels follow their pipe, and
     tidies label clashes, at the end of the AutoCAD command. It prints a line only when it refuses or fails (for example "CE attachment
     ownership is conflicting. The AutoCAD move remains visible, but CE link data was not changed. Run Drawing Repair before relying on it.").
   - **When a grip, STRETCH or MOVE pulls a pipe end off its pit, one plain line is printed (BUG-208, Tim 29 Sep "Allow, flag it"):**
     "A pipe end left pit P4: it is now Not connected yet. CDCHECK lists it until you connect it." ERASE of a pit prints "1 pipe now has
     an end that is Not connected yet" (UX-EDIT-01). Neither reconnects anything.
   - A separate background check (automatic Project QA) re-reads profiles and schedules 3 seconds after editing stops.
   - **There is no amber mark on the end and no list that stays open:** the line scrolls away, and the end is found again only by
     running CDCHECK. The line covers only an end that LEFT a pit; a pipe dragged ONTO a pit it is not linked to says nothing (not
     read in full: question 1 asks what Tim wants).
3. **What works:** pipes follow pits; labels follow pipes; the "Not connected yet" line with its wording; CE never reconnects anything by
   itself (keep that).
4. **Wrong or missing:** the amber "Not connected yet" mark on the end; the entry in Checks; a check of an end that now TOUCHES a pit it
   is not connected to.
5. **Classification: MODIFY** (the watcher and the line exist; the mark and the Checks entry are missing).
6. **Proposed:**
   - At the end of each AutoCAD edit command, CE re-checks the connections of the pipes and pits that were edited and their direct
     neighbours (never the whole drawing).
   - An end that no longer touches its pit gets a small amber ring at the end (on screen only, never plotted, never saved as drawing
     objects) and a line in the Checks palette: "P3-P4: downstream end not connected yet (moved 0.42 m away from P4). Show where / Connect / Keep as a free end".
   - Today's command-line line stays, with "See Checks" added; no pop-up (question 1 asks whether a status-bar note is wanted too).
   - CE never reconnects it. The drafter uses Connect in Checks, CDCONFIRM, or moves it back.
7. **Undo:** the re-check writes nothing to the drawing, so U of the edit simply removes the cause and the amber ring goes at the next re-check.
8. **Speed:** only edited items and neighbours; a timing line in the CE log; over a second shows progress (card 2.5).
9. **Example:** STRETCH moves P4 0.4 m east; the P3-P4 pipe follows (it is linked) and nothing is flagged. MOVE the pipe alone 0.4 m:
   both ends turn amber, Checks lists two lines, the command line keeps today's "Pipe ends left pits P3, P4: they are now Not connected yet." plus "See Checks."

## Card 2.2 — the Checks palette (one place for CDCHECK, CDRULES and What CE Found)

UX-WIN-04 says "Civil Properties, Checks and Proposals are palettes that stay open". There is no Checks palette today. This card is
the home that UX-DI-01, 03 and 04 all need.

1. **Today, three places and three counts:**
   - `CDCHECK` (ribbon label "Checks"): command line only. Prompt "CE check: show all connections, problems only, or save as CSV
     [All/Problems/Csv] <All>:", then a summary such as "[CE] CDCHECK: 217 objects, 190 connections: 185 Connected, 1 Possible,
     4 Unresolved, 0 Not Connected, 0 Unknown." (SEEN, Codex W35), up to 60 numbered rows, then "Nothing in the drawing was changed."
     Full list always saved as a text file under `%APPDATA%\CE_CVL_SUITE\logs`.
   - `CDRULES`: command line only. Prompt "CE rules: show all findings, problems only, the values in use, or explain each problem
     [All/Problems/Values/Explain/pReview/Source] <Problems>:", summary "[CE] CDRULES: 408 finding(s) across 12 rules; 29 warnings,
     312 unknown, 67 pass; ..." and "Drawing geometry unchanged; results recorded in the project." (SEEN, W35). The run is stored in the
     drawing. No Show where.
   - `CDCHECKCURRENT` opens the "What CE Found" palette (stays open; Show in drawing, Check again, Clear highlight, Close) with its own
     count. Project Review (`CDDASHBOARD`) is a window that blocks AutoCAD, with Show in drawing and Propose a fix. Codex (UI/UX review
     item 17) saw "89 issues", "27 items" and a long CDCHECK list side by side.
2. **What works:** the CDCHECK and CDRULES engines and their honest "Unknown is not a pass" wording; "Nothing in the drawing was
   changed"; the CSV option; What CE Found's one-at-a-time list and Show in drawing; Project Review's safe fixes.
3. **Wrong or missing:** one list that stays open while drafting; Show where for rule findings; a plain next action per finding; counts
   that agree.
4. **Classification: MISSING** (the palette) / **KEEP** (CDCHECK and CDRULES as typed commands and their engines).
5. **Proposed:**
   - The "What CE Found" palette is renamed and grown into the **Checks** palette (question 2), stays open while drafting, and has three
     tabs: Connections (CDCHECK), Rules (CDRULES), Ignored (card 2.3).
   - Header: "Checks: 4 to look at · 185 connected · 312 not known (CE could not check)". When all pass, one green line (UX-STD-08):
     "Network OK: 24 pipes, 11 pits checked".
   - Each row: the plain words, the pit or pipe name (never a handle), a symbol and colour (tick, triangle, cross: UX-ACC-02), and its
     buttons: **Show where**, the fix CE knows (Connect, Edit pipe, Reverse flow), **Ignore...**.
   - Ribbon "Checks" opens the palette and runs the check. Typed `CDCHECK` and `CDRULES` keep their command-line answers exactly as Day 1
     steps 12 and 13 describe, and end with one extra line "See them all in the Checks palette (CDCHECKS)." (question 3).
   - Project Review stays the window for a full review before issue; its counts are the same numbers as the palette's.
6. **Prompts:** none new. **Discovery:** ribbon Review > Checks; the "See Checks" line in card 2.1.
7. **Undo:** looking writes nothing. A fix button is its own command and one U.

## Card 2.3 — UX-DI-03: an ignored finding stays ignored until something changes

1. **Tim ruled (26 Sep):** "Until something changes." Ignored for the job with its reason; asked again only if the item or its rule
   changes; an "Ignored" list shows them all.
2. **Today:** no way to ignore a finding. The nearest is CDCHECK's per-item action Connect / Disconnect (or CDCONFIRM), which records a
   connection decision for one pipe end in the drawing with person and time, and says "It will not be asked again. Save the drawing to
   keep it." Its reason is filled in automatically ("Marked not connected by the engineer"). Nothing re-asks when the pipe changes.
   CDRULES only marks an older run STALE when its inputs change.
3. **Classification: MISSING.**
4. **Proposed:**
   - **Ignore...** on any Checks row asks for a reason with the UX-STD-04 quick picks (Survey, Council requirement, Engineer's judgement,
     Other) plus an optional note.
   - Stored with the drawing and the job (question 4), with who and when.
   - The finding comes back, marked "Asked again: P3-P4 changed since you ignored this on 9 Oct", when the pipe or pit it is about changes
     (size, level, position, connection) or the rule's value changes (for example the council minimum cover).
   - The Ignored tab lists every ignored finding with reason, who, when, and **Un-ignore**.
   - A pipe end marked "Free end" (deliberately not connected) is the same thing for connections: it stays quiet until that end moves.
5. **Undo:** Ignore and Un-ignore are each one U.
6. **Example:** CDRULES says P7 cover is 250 mm, under the 300 mm office minimum. The engineer has a concrete-encased note on the plan.
   Ignore, reason "Engineer's judgement", note "encased, see detail 4". It disappears from Rules. Next week P7's cover level is lowered:
   the finding comes back, marked "Asked again".

## Card 2.4 — UX-DI-04: Show where zooms and glows; the list stays open; Esc clears

1. **Tim ruled (26 Sep):** "Zoom + glow, window stays." Show where zooms and highlights in the attention colour; the list stays open;
   Escape clears the highlight.
2. **Today:**
   - CDCHECK's "Jump to item number" zooms to the object and SELECTS it (AutoCAD's own selection look), prints "[CE] Item 3: ..." (the
     handle was taken out, BUG-372) and then asks "Action for this item [Connect/Disconnect/Flow/Main/Edit/Next] <Next>:". No CE colour.
   - The shared zoom-and-highlight used by the Pit Schedule, Project Review, the Inspector and CEFIND uses AutoCAD's highlight plus
     selection; a row click fades after 2 seconds; one level of "Back" to the previous view.
   - What CE Found's "Show in drawing" selects and zooms; "Clear highlight" empties the selection; closing it puts back the drafter's
     own selection. Esc does not clear the highlight anywhere.
   - No attention-colour glow anywhere (on-screen overlays are used today only for surface and slab-flow shading).
3. **What works:** the zoom with margin; Back; giving back the drafter's selection on close (UX-STD-06).
4. **Wrong or missing:** the attention-colour glow; Esc clears it; Show where must not replace the drafter's selection.
5. **Classification: MODIFY.**
6. **Proposed:** one Show where for every CE list (Checks, Pit Schedule, Project Review, Inspector, CEFIND, CDCHECK's Jump):
   - Zoom so the object and its neighbours fill about a third of the screen (question 5), with Back to the previous view.
   - The object glows in the office attention colour (on-screen only, not plotted, not saved, not an undo step).
   - The drafter's selection is not changed.
   - The glow stays until Esc, the next Show where, or the row being closed. The list stays open.
7. **Undo:** zoom and glow are not undo steps (they change nothing); U still undoes the last real edit.

## Card 2.5 — UX-SEL-01: nothing selected, so the command asks to pick, filtered

1. **Tim ruled (26 Sep):** "Ask to pick." The command line asks for the right object ("Select a pipe:"), filtered to that kind; Esc
   cancels cleanly.
2. **Today (read in code, mostly already right):**
   - CDEDIT: uses anything already selected, else "Select a pit, pipe, source or CE text to edit:", refusing other objects with "Select a
     CE pit, drainage pipe, tagged source or CE label text." then "[CE] CDEDIT only works on CE pits, drainage pipes and tagged sources."
   - PIPEEDIT: "Select pipe to edit:", "That is not a pipe. Click the pipe line or its outline." and a live hint under the cursor.
   - PITEDIT: "Select pit block to edit:", "Selected entity is not a pit block."
   - CDANNOTATIONEDIT: "Select annotation to edit (invert text, pipe text, arrow):" (does not use a pre-selection).
   - CDTAG: "Pick the source to label:", "Select a block reference."
   - CDCONFIRM, run solve, profile, pit delete, LPD, AGI: each asks for its own object.
   - Esc at every one of these ends the command and changes nothing.
   - The only "select first" refusal found: the right-click label action, "Select one linked Civil pipe label, invert or arrow first."
3. **What is wrong:** wording is uneven ("pit block", "entity", "block reference" are computer words, not drafting words); some refuse
   the wrong kind only AFTER the pick; one right-click action refuses instead of asking.
4. **Classification: MODIFY (wording and one refusal).**
5. **Proposed wording, one pattern:** "Select a pipe:", "Select a pit:", "Select a pit, pipe or CE label:". Wrong kind: "That is a
   {what it is}, not a pipe. Select a pipe:" and ask again. Esc: "[CE] Nothing was changed." once. The right-click label action asks
   "Select a CE pipe label, invert or flow arrow:" instead of refusing. Every pick prompt uses what is already selected when it fits.
6. **Test:** a guard that lists every pick prompt in Civil and fails on "entity", "block reference" or "block" (as in "pit block").

## Card 2.6 — UX-PERF-01: anything over about a second shows progress with Cancel

1. **Tim ruled (26 Sep):** "Status-bar progress + Cancel." Nothing freezes silently.
2. **Today:** no AutoCAD progress bar anywhere in Civil, Manager or the shared code. A progress bar with Cancel is built into the shared
   editor window frame but no window uses it yet. The CE log times every command. Codex measured CDCHECK's pipe end review at 4.7 ms on
   DWG-B (Pass 18), so CDCHECK is normally quick; the 4-minute CDCHECK of 3 Oct was the test driver (BUG-359).
3. **Classification: MISSING.**
4. **Proposed:** any CE command or palette refresh still busy after about 1 second shows AutoCAD's own status-bar progress line with
   its words ("CE: checking connections 140 of 217...") and Esc cancels. On Cancel: nothing written ("CE check cancelled. Nothing was
   changed.") or, for a command that writes, the whole command undone. First users: CDCHECK, CDRULES, Tidy labels (Batch 1), Pit
   Schedule update, X-Civil import, CDCALC, Project Review, sheet sync.

## Card 2.7 — UX-PERF-02: a slow CE feature offers to pause itself for that drawing

1. **Tim ruled (26 Sep):** "Tell you + offer to pause it." One quiet line offers to pause it for that drawing; remembered per drawing;
   shown on Manager's status page.
2. **Today:** `CEPERFDIAG` (a diagnostic typed command) can switch off eight background watchers, including link tracking and the
   automatic Project QA, but for the whole AutoCAD session only; nothing is saved; all are back on at the next start. No per-drawing switch.
   Commands are timed in the log.
3. **Classification: MODIFY** (the switches exist; per drawing, the offer and Manager's line are missing).
4. **Proposed:**
   - CE watches how long its own background work takes after each AutoCAD command. If one feature (for example the automatic label tidy)
     adds more than about 2 seconds three times running in one drawing (question 6), one status-bar line: "CE: automatic label tidy is
     slowing this drawing (about 3 s each edit). Pause it for this drawing? [Pause] [Not now]".
   - Pause is saved in the drawing. A paused feature shows on the CE panel ("Paused here: label tidy. Resume") and on Manager's status page.
   - Never pauses connection safety or anything that keeps the network right without asking. Only conveniences (label tidy, automatic
     QA refresh, the Inspector's live refresh) can be paused (question 7).
   - "Not now" is remembered for that drawing for the session.

---

## Tests (automated, before Tim)

1. MOVE a pipe off its pit in a test drawing: the re-check lists 2 ends "not connected yet"; nothing is reconnected; the drawing has no new objects; U removes the cause.
2. STRETCH a pit with linked pipes: no finding.
3. Checks palette counts equal CDCHECK's and CDRULES's summary lines on DWG-B.
4. Ignore a rule finding with a reason; save, reopen: still ignored; change the pipe's level: it comes back marked "Asked again".
5. Show where: the drafter's selection is unchanged; Esc clears the glow; nothing goes in the undo list.
6. Pick-prompt wording guard (no "entity", "block reference"); wrong kind asks again; Esc says "Nothing was changed." once.
7. A forced-slow check shows progress after 1 s; Esc cancels and writes nothing.
8. A feature slowed on purpose 3 times: the pause offer appears once; Pause is saved in the drawing; Manager's status page lists it.
9. CDCHECK: Enter at the first number prompt returns straight to "Command:" (the Explore 1 item 10 double prompt); BUG-389 arrow text is a real arrow.

## Example drawings

1. `C:\Lisp Files\_TEST_COPIES_20260923\DWG-B.dwg` and `DWG-B1_VC7.dwg` (Codex's W35/W36 copy: 217 objects, 4 Unresolved, 408 rule findings), copied to a new name per run.
2. A large job copy for the speed cards (job W26-26 copy already used by Codex; job number only).

## Tim's AutoCAD checklist (about 10 minutes, on a copy)

1. **Quiet re-check:** MOVE one pipe 0.5 m away from its pits. **Should see:** amber rings on both ends, today's "Not connected yet" line ending "See Checks", no pop-up. The Checks palette lists both ends. `U`: rings gone.
2. **Checks palette:** ribbon Review > Checks. **Should see:** Connections, Rules and Ignored tabs, names not handles, counts matching `CDCHECK` and `CDRULES` typed.
3. **Show where:** click Show where on a row. **Should see:** zoom, a coloured glow, the palette still open, your selection unchanged. Esc: the glow goes.
4. **Ignore:** Ignore a cover finding with "Engineer's judgement". It moves to Ignored. Change that pit's cover level: it comes back "Asked again".
5. **Nothing selected:** type `PIPEEDIT` with nothing selected and click a pit. **Should see:** "That is a pit, not a pipe. Select a pipe:". Esc: "Nothing was changed."
6. **Progress:** run `CDRULES` on the big job copy. If it takes over a second, a status-bar progress line; Esc stops it and nothing changes.
7. **Typed commands unchanged:** Day 1 steps 12 and 13 read exactly as before, plus the last line pointing to the Checks palette.

## Code references (read on Civil release commit 446162c2, C-25, 9 Oct; spot-checked by git grep, line numbers where checked)

Under `Modules\Drainage\`: `Commands/SpineCheckCommand.cs:50-56, 130-168, 176-205 (Items/Fit/Ends), 249-293, 336-345, 397`;
`Commands/RulesCommand.cs:34, 42`; `Rules/NativeEditEndpointOwnerRule.cs:146-162` (the "Not connected yet" line);
`Services/LinkService.Reactors.cs:1326-1333`; `Services/PitEraseFreeEndsMessagePolicy.cs:42-43`; `Services/DrawingCheckPaletteService.cs:65`
(the only Civil PaletteSet besides the Inspector); `Commands/CheckCurrentDrawingCommand.cs:19`; `Commands/DashboardCommands.cs:19`;
`Commands/InspectorCommand.cs:13`; `Services/CeZoomHighlightService.cs`; `Commands/HubCommands.cs:101`; `Commands/PipeEditCommand.cs:80`;
`Commands/PitEditCommand.cs:92`; `Commands/AnnotationEditCommand.cs:37`; `Commands/SourceTagCommand.cs:149`;
`Services/PipeAttachmentContextMenuService.cs:156`; `Controls/CeEditorShell.xaml` (progress bar with Cancel, not used by any window);
`Commands/PerfDiagCommand.cs:116`. Not found anywhere in Modules or Shared on that commit: `ProgressMeter`, any "ignore a finding" store,
an "Ignored" list. Also read (same files, local master 650c0c19, for detail only): `Services/Spine/SpineDecisionLedger.cs`,
`Services/CivilProjectQaAutomaticService.cs`, `Rules/RulebookEngine.cs`, `Services/ProjectDataService.RulebookDrawing.cs`.
Codex: `CODEX_VERIFYW35_2026-10-08.md` items 21-24; `CODEX_VERIFYW36_2026-10-08.md` item 15; `CODEX_EXPLORE1_REPORT_2026-09-29.md`
item 10; `CODEX_CIVIL_UIUX_REVIEW.md` item 17; `CODEX_TEST_REPORT_PASS18_2026-09-28.md` item 58.
