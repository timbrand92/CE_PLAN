# Card drafts 6 of 15: Inspector, CDCHECK and the saved record (Mon 2 Nov 2026, Melbourne)

Written by Sonnet (Team, read-only) at CE 00's request, for CE 05 to push. Nothing here is approved. Every card below is a DRAFT FOR TIM.

---

## FOR TIM

1. **Five cards follow**: the Inspector reading the saved drawing record, Inspector colours and units, CDCHECK, "CE's saved links and Undo", and the raingarden outlet wording. Each has all 19 fields.
2. **Where the work is.** Only one PR here (#1962, flatter-than-minimum pipe in red) is on the line you have installed (Civil 3.0.89, C-79a, as the build register records it). Seven PRs (#1880, #1951, #1953, #1955, #1958, #1892, #1952) are on the C-79b1 branch only; its Civil 3.0.90 build is made but not installed (slot Tue 3 Nov after 5:30 pm). #1920 (cover) is on the C-79b2 branch only. **#1588 (10 m pipe reads 10000 mm) and #1815 (raingarden outlet words) are on no C-79 branch at all**: they are still open drafts. None of the eleven is on `rel-20261102a`.
3. **Could not be pinned down**: whether the ribbon shows "Checks" as CDCHECK or the newer CDCHECKS depends on a Settings switch whose default I did not read. The layer the raingarden is drawn on, and whether the What's New list or Help page mention these changes, I did not read either. They are marked in the cards.
4. **Questions that need you** (field 18 of each card): does "[CE] Outlet not tracked" count as the fix for BUG-1107, or do you still want the outlet pit recorded (card 5, the main one); what amber should mean on a pipe that passes (card 2); is the new "skipped one damaged pit" line allowed to quote a drawing handle (card 4).
5. **Not proven, anywhere**: all of this is built and unit-tested by the authors and read by the reviewers. Nobody has run any of it in AutoCAD, and the Inspector's speed on a big job is unmeasured. No Codex PASS, no robot PASS, and no word from you yet.
6. **One disagreement to know about**: the finalizer classed C-79b1 as an area re-test; Opus said the Undo and record PRs (#1952, #1955) need the full re-test because they touch protected record files. The finalizer's reading is that nothing new is written to the drawing record. I did not settle it.
7. **What I read**: the Opus pre-reviews, both train PR lists, the register, the b1 finalizer report, the carpark entries (BUG-994, BUG-1107), and the code on `rel-20261112a` and `rel-20261102a`. **What I did NOT do**: open AutoCAD, run any test or build, read Tim's settings files, or read the installed DLL.

---

## Facts common to all five cards

1. **Which branch has which PR** (checked by asking git whether each PR's head commit is inside each branch):
   1. **`claude/rel-20261102a`** (C-78, Civil 3.0.88, head 3fbb9da5): none of the eleven PRs. BUG-1240, 1263 to 1266, 1141, 1070, 1094, 994 and 1107 are not in its REGRESSION_LOG.md.
   2. **`claude/rel-20261106a`** (C-79a, Civil 3.0.89): **#1962** only.
   3. **`claude/rel-20261108a`** (C-79b1, Civil 3.0.90 candidate): #1880, #1951, #1953, #1955, #1958, #1892, #1952 (and everything in C-79a).
   4. **`claude/rel-20261110a`** (C-79b2): adds **#1920**.
   5. **`claude/rel-20261112a`** (C-79c tip): holds all of the above.
   6. **#1588 and #1815**: in none of the five branches. Opus reviews of 1 Nov say both are open drafts on old bases (842 and 333 commits behind) and need a hand merge. On the tip, the compact Inspector still reads `$"{line.Length:0} mm"` (InspectorPaletteService.cs line 1041), so #1588 is confirmed not applied.
2. **Installed, as last recorded** (build register items 270 to 273, written Mon 2 Nov about 14:45): Civil 3.0.89 (C-79a). The b1 candidate (Civil 3.0.90, built from head bab2dbf8) is built; its install slot is Tue 3 Nov after 5:30 pm. I did not read the installed DLL, so confirm with the live check before relying on this.
3. **Structural line** (`rel-20261026s`): none of this group touches Structural.
4. **Ribbon (read from the files on the tip).** The tab is named **CE** (or **CE Civil** when classic tabs are on). Panels are in `CeCvlRibbonContributor.cs` and `CeCvlClassicRibbonLayout.cs`.
5. **Where each switch lives.** Every new switch ships ON. For #1880 the switch has no tick box on the Settings page (Opus: the page is at its height limit), so it changes only by editing the settings file. #1962, #1920 and #1815: not confirmed either way for #1962 and #1920; #1815 has no row.

---

# CARD 1. Inspector reads the saved drawing record when none is loaded

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** CE Inspector: open a saved job, click a pit, and the Inspector shows its real values straight away, without running CDSYNC first.
2. **Ribbon or trigger.** Tab **CE**, panel **Edit**, button **CE Inspector** (keytip CP); classic layout: tab **CE Civil**, button **Inspector**. Typed: `CDINSPECTOR`. Also the **Inspector** button in the CE Help window.
3. **Works today** (what Keep would protect). The Inspector follows your selection and shows Civil properties beside AutoCAD Properties. When CE has the list in memory it shows the pit number, type, size, cover level, invert levels and connections. "Open existing" and the Edit button (which hands over to CDEDIT) stay as they are.
4. **What the train or PR changes.**
   1. **#1880 (BUG-1240, B-059):** when CE holds no list for this drawing, the Inspector reads the list saved inside the drawing (read only). Switch `linking.inspectorReadsSavedRecordWhenNotLoaded`, ON. OFF = exactly today's Inspector.
   2. **#1951 (BUG-1265):** CDCHECK and the Inspector now ask one shared rule (`ProjectRecordReadRule`) for "use CE's list in memory or read the saved one". Nothing visible changes (Opus read the old and new logic line by line: identical).
   3. **#1953 (BUG-1263):** if CE is keeping a newer list for a drawing it could not save (you changed drawing A, switched to B, came back), the Inspector shows that newer list, not the older saved one. Switch `linking.inspectorShowsRecordWaitingToSave`, ON. Only used when it is the same drawing and the same file path.
   4. **#1958 (BUG-1266):** if the saved list cannot be read, the Inspector logs it once per drawing instead of on every pick. Switch `linking.inspectorUnreadableRecordLoggedOnce`, ON. Values still show Unknown.
   5. Where: all four are on C-79b1 (`rel-20261108a`) and later; not on `rel-20261102a`; not installed.
5. **Suggested class: Modify.** The working Inspector stays; one source of values is added behind a switch. Suggestion only.
6. **Prompts and windows.** No prompt. Wording the drafter sees:
   1. Before, on a freshly opened drawing: "This pit is not in CE's recorded project data yet. Values below are Unknown." (pipe: "This pipe is not in CE's recorded project data yet. Values below are Unknown.")
   2. After, saved list found: "Recorded values — block and label values may differ" (pipe: "Recorded values — drawing labels may differ").
   3. Nothing picked: "Drawing records are not loaded. Select an item to inspect its identity." becomes the Pits and Pipes counts.
   4. Saved list unreadable: values stay Unknown, and the CE log (not the command line) gets one line: "[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown."
7. **Selection.** It follows what you pick. Picking inside an Xref reads nothing from the Xref's record (only this drawing's own record). Copy-pasted or inserted pits from another drawing are not in this drawing's record and still say "not in CE's recorded project data yet" (Opus reading; what AutoCAD itself does with the source drawing's data was not verified).
8. **Preview.** None.
9. **Drawing output.** **Nothing is drawn and nothing is written to the drawing.** What is read: CE's record, stored as text inside the drawing's own named dictionary, opened ForRead and closed again (an "open-close" read). It does not bind, sync, save, or mark the drawing active; a source test forbids those calls in the Inspector's refresh path. One memory-only side effect: each successful read notes which drawing last had a record read from it (used later to decide Undo behaviour; see card 4). Layers, Xrefs, REFEDIT and read-only drawings: it only reads, so locked layers and Xrefs are untouched; no unlock, detach or explode.
10. **Cancel, Escape, Undo and Redo.** The Inspector is a palette, not a command, so there is nothing to cancel and no Undo step. The read is the same kind CE measured to keep REDO alive (BUG-192 v2); picks during the REDO window are still held back by the existing switch. **Not proven in AutoCAD for this path.**
11. **Save and reopen.** This is the point of the fix: reopen, or Save As, pick a pit, and the Inspector shows it. Two rare cases can show slightly old (not wrong-drawing) values: a change CE is holding for an unsaved drawing (now covered by #1953, if its path match works), and values changed by plain AutoCAD commands such as ATTEDIT since CE last saved (already warned by the "may differ" subtitle).
12. **Assets, data and Settings.** Reads the drawing's own CE record; no file in %APPDATA%. Settings keys above, all file-only (no Settings page row for #1880). A missing settings file or group reads ON.
13. **Performance.** Until a CE command loads the list, **each pick re-reads the saved list.** On a very big job this could be slow. **Not measured** (finalizer risk 1; Opus note). #1958 stops retrying an unreadable list.
14. **Discovery.** Ribbon button above; command `CDINSPECTOR`; Help page `https://help.creativeeng.com.au/ce-cvl-suite/commands/cdinspector` (from the command registry). I did not check whether What's New mentions this.
15. **Example drawing and expected result.** Open a saved job with pits P1 to P6 (pit 450 square, cover level 12.350, invert 11.200) that has not had any CE command run since opening. Pick P2 with the Inspector open. Expected: Number P2, the saved size, cover and invert levels, and connections, with the "Recorded values" subtitle. Before: "Unknown" and the "not in CE's recorded project data yet" line until you ran CDSYNC. (Figures are an illustrative example; the review names pit P2 but no levels.)
16. **Older family card.** None specific to the Inspector's saved-record read. `docs\workflows\C1_RULECHECK_GEOMETRY_2026-09-07.md` is about rule checks keeping observed pit positions and does not cover the Inspector at all. `docs\CARDS\QA-01_PROJECT_QA_SNAPSHOT.md` covers a held read-only Project QA snapshot and does not cover what the Inspector shows after a reopen. Neither says anything about reading the saved record when none is loaded, the "kept newer list" case, or the once-per-drawing log.
17. **Tim's AutoCAD checklist** (after the C-79b1 build is installed):
   1. Open a saved job that has CE pits and pipes. Do **not** run any CE command.
   2. Open the Inspector: ribbon tab **CE** > panel **Edit** > **CE Inspector**.
   3. With nothing picked, you should see the Pits and Pipes counts (before: "Drawing records are not loaded").
   4. Click a pit. You should see its real values and the subtitle "Recorded values — block and label values may differ".
   5. Click a pipe. Same, with "drawing labels may differ".
   6. Save As a new name, pick a pit again: values still show.
   7. Two drawings open: change a pit in A in a way CE can save, switch to B, back to A, pick the pit: you should see A's values, never B's.
   8. Ask CE to switch the new behaviour off only if told: edit the settings file key `linking.inspectorReadsSavedRecordWhenNotLoaded` to false and restart; you should get the old "Unknown" behaviour back. (Do this only on a copy or with the Settings backed up.)
   9. On your biggest real job, time one pick from a freshly opened drawing. Tell me if it feels slow.
18. **Questions only Tim can answer.**
   1. **Speed on a big job.** Context: each pick re-reads the saved list until a CE command runs. I understand it is unmeasured. Recommendation: test on your largest job before accepting, and treat a pause over about a second as a fail. If fine on a 500-pit job, nothing changes; if slow, CE would need to remember the list after the first read.
   2. **Waiting-to-save list shown with no hint.** Context: #1953 shows the newer kept list under the same "Recorded values" subtitle, so you cannot tell. Recommendation: accept for now; it is rare and the alternative is a new wording needing your approval. Either way the values are CE's newest, never another drawing's.
19. **NOT proven.** **Built:** yes, by the PR authors; assembled in `rel-20261108a` (finalizer GO at bab2dbf8, 1 Nov). **Tested:** unit tests by the authors (#1880: 444 of 444 focused; full Civil suite 21,542 of 21,576 with 2 failures the author did not compare against the base) and the finalizer's area re-test class; nobody has run it in AutoCAD; robot case N39_inspector_reopen is named by Opus for after the build, and I did not read whether it has run. **Installed:** no (b1 slot Tue 3 Nov after 5:30 pm). **Tim-accepted:** no, and no Codex PASS exists. Nobody has done the last three. BUG-1240, 1263, 1265, 1266 all stay OPEN in the carpark.

---

# CARD 2. Inspector colours and units

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** The Inspector's numbers and colours match CDRULES: a pipe flatter than the minimum is red, a 10 m pipe in a metre drawing reads 10000 mm, and pit cover is measured to the outside top of the pipe.
2. **Ribbon or trigger.** Same as card 1: tab **CE** > **Edit** > **CE Inspector** (typed `CDINSPECTOR`).
3. **Works today.** The Inspector shows Grade as "1:N" with a tick, a warning triangle or a cross; shows cover as "Cover depth: N mm (min N mm)"; and shows drawn length under Connections. The full-detail Inspector already converts length by the drawing's units (BUG-323).
4. **What the train or PR changes.**
   1. **#1962 (BUG-1094, B-131, C-79a, on `rel-20261106a`, so in the installed 3.0.89 as the register records it):** any pipe flatter than the minimum shows red. Switch `grade.inspectorFlatterThanMinimumShowsRed`, ON. OFF = the old amber band up to 1.2 times the minimum.
   2. **#1588 (BUG-994): on NO branch.** An open draft on `rel-20261022m`. It would make the compact Inspector convert drawn length by the drawing's units. No switch. Needs a hand merge: at line 1041 of InspectorPaletteService.cs the line must end `DrawnLengthText(line.Length, LinkService.InsunitsOf(line.Database))` (Opus R1).
   3. **#1920 (BUG-903, B-096, C-79b2, on `rel-20261110a`, stacked on #1897):** Inspector pit row, Civil Hub and the repair check measure cover to the outside top of the pipe (the CDRULES way), per pit's own surface. Switch `checks.screensMeasureCoverToPipeTop`, ON. OFF = the old "cover minus invert" figure and wording.
5. **Suggested class: Modify** for all three: a displayed number and colour change. #1588 additionally needs the rebuild of its merge. Suggestion only.
6. **Prompts and windows.** No prompt. On-screen wording:
   1. Grade row: "Grade: 1:N" with ✓, ⚠ or ✗ (the symbols come from `InspectorGradeStatusRule`). With the switch ON, flatter than the minimum is ✗ red; at or steeper than the minimum is ✓.
   2. Cover row, new: "Cover to [where measured] of pipe [mark]: N mm ✓/✗ (min N mm)", plus a sentence if the pipe wall is unknown. Old: "Cover depth: N mm ✓/✗ (min N mm)".
   3. Drawn length (once #1588 is merged): "10000 mm".
7. **Selection.** Pick a pipe (grade, length) or a pit (cover). Cover looks at every pipe end running into the pit and keeps the shallowest.
8. **Preview.** None.
9. **Drawing output.** **Nothing is drawn or written to the drawing.** Display only; it reads in the Inspector's existing read-only transaction. A source guard bans Transaction, Regen, system-variable changes and file writes in the new cover rule. Locked layers, Xrefs and REFEDIT are untouched.
10. **Cancel, Escape, Undo and Redo.** No command, no Undo step; read only, REDO-safe by Opus's reading. Not run in AutoCAD.
11. **Save and reopen.** Values are recomputed on each pick; nothing is stored.
12. **Assets, data and Settings.** Minimum pipe grade comes from Settings (Design Standards). Minimum cover comes from Settings per surface. Pipe wall comes from the Settings wall table. The grade and cover switches are in the settings file; I did not confirm whether they have Settings page rows.
13. **Performance.** #1920 measures pipe ends twice per shallow pit; Opus says fine at normal job sizes and did not time a 500-pit network.
14. **Discovery.** Same as card 1. I did not check What's New.
15. **Example drawing and expected result.**
   1. **Grade:** minimum 1 in 200. A pipe at 1 in 235 now shows ✗ red (before: ⚠ amber, because amber ran up to 1 in 240; only 1 in 241 and flatter was red). A pipe at 1 in 200 or steeper shows ✓.
   2. **Length:** metre drawing (INSUNITS 6), pipe 10.0 units long: Drawn length 10000 mm (before: 10 mm). Millimetre drawing, pipe 10000 units: 10000 mm.
   3. **Cover:** Road pit P1, cover level 10.000, invert 9.350 (old figure 650 mm); UPVC 225 pipe L1 at 9.355. Opus expects "400 mm" and "(min 600 mm)" (red cross); with the switch OFF, "Cover depth: 650 mm" with a tick. The 400 depends on the wall figure in Settings.
16. **Older family card.** None for these. `docs\workflows\C1_RULECHECK_GEOMETRY_2026-09-07.md` covers rule checks keeping observed pit positions; it says nothing about Inspector colours, units or cover measure, nor about how cover is measured to the pipe top.
17. **Tim's AutoCAD checklist** (grade after C-79a, which the register records as installed; cover after the C-79b2 build; length only after #1588 is built into a train):
   1. Draw or open a pipe at about 1 in 235 and a minimum grade of 1 in 200 in Settings.
   2. Pick it with the Inspector open. Grade should be 1:235 with a red cross.
   3. Pick a pipe at 1 in 150. Green tick.
   4. Edge case: a pipe at 1 in 200.3 will read "1:200" but be red. This is expected; see question 1.
   5. Open a Road surface pit (cover 10.000, invert 9.350) with UPVC 225 at 9.355. Pick the pit: look for "Cover to ... of pipe L1: about 400 mm ✗ (min 600 mm)". The wording must not be cut off in the palette.
   6. Metre drawing: pick a 10 m pipe, look at Connections > Drawn length. Expect 10000 mm (only once #1588 is in a build).
18. **Questions only Tim can answer.**
   1. **What should amber mean?** Context: with #1962 nothing is amber any more; the old amber band is gone when the switch is ON, and the carpark says what amber should mean on a passing pipe is your word. I understand there is no "near the limit" band now. Recommendation: leave amber unused until you decide; it avoids an invented rule. On a job: a 1 in 220 pipe against 1 in 200 passes (green), where today it may be amber.
   2. **1:200.3 shows "1:200" but red.** Recommendation: accept; it matches CDRULES's strict answer. On a job: a drafter might query why a "1:200" pipe is red.
   3. **Do you want #1588 in a train?** It is a tiny, safe fix, but it is not in any C-79 branch. I recommend raising it for C-80. (That is CE 00's scheduling call; asking only so you know a 10 m pipe in a metre drawing still reads 10 mm on the compact Inspector today.)
19. **NOT proven.** **Built:** #1962 and #1920 yes (in the branches above); #1588 built only on its own draft branch. **Tested:** authors' unit tests and Opus reading; the Inspector pit row for #1920 is proved only by a source-text check, not a behaviour test; no AutoCAD run for any. Robot cases named by Opus: N96_cover_pipe_top and N96c (switch OFF) for #1920; I did not read whether they have run. **Installed:** #1962 only, per the register's C-79a install; #1920 no; #1588 no. **Tim-accepted:** no, no Codex PASS. BUG-1094, 903 and 994 stay OPEN.

---

# CARD 3. CDCHECK (the drawing check)

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** CDCHECK lists every pit and pipe connection the drawing can prove (Connected, Possible, Unresolved, Not Connected, Unknown) and says plainly what it could not check. It never repairs.
2. **Ribbon or trigger.** Typed `CDCHECK`. Ribbon: tab **CE** > panel **Review**. The button reads **Checks** and runs CDCHECK, or CDCHECKS (the newer one-list door) when the "one Checks list" switch is on. I did not read that switch's default, so which one you see is unconfirmed (GUESS: the newer list, because the code says CDCHECK is "typed only" while it is on). With it on, CDCHECK is still available by typing.
3. **Works today** (what Keep would protect).
   1. First prompt: "CE check: show all connections, problems only, or save as CSV" with options All (default), Problems, Csv.
   2. A summary line: "[CE] CDCHECK: N objects, M connections: [summary]."
   3. Up to 60 numbered connection lines, then "... N more in the saved list."
   4. Extra lines for pipe-to-pit fit, FALL arrows pointing away from a pit, and open or high-branch pipe ends. Each is prefixed "[CE]".
   5. A saved text list next to the CE logs (and two CSV files with Csv).
   6. Where the saved list cannot be read: "[CE] The saved check record in this drawing could not be read (...). CDCHECK used the drawing as it is now." and, for the pit and pipe list: "The pit and pipe list saved in this drawing could not be read, so the pipe-to-pit fit check and the FALL arrow direction check did not run. Nothing was changed."
   7. Object names in words, not handles, while `checks.cdcheckLinesShowNoInternalIds` is on (BUG-372).
4. **What the train or PR changes.**
   1. **#1951 (BUG-1265):** the live-or-saved choice moves into one shared rule. CDCHECK's answers are the same. The earlier fix (BUG-1251, `checks.cdcheckReadsThisDrawingsRecord`, before this train) already makes CDCHECK read the saved list when CE's memory belongs to another or a closed drawing (the case that once gave 142 Connected / 44 Unresolved instead of 179 / 4). I did not find any change to `SpineCheckCommand.cs` or `ChecksResultReader.cs` between C-78 and the tip.
   2. **#1952 (BUG-1070, B-118, PROTECTED FILE `ProjectDataService.Persistence.cs`):** CE already refused to save over a record in the drawing that exists but cannot be read (BUG-971). The hold used to stay on after Undo even when Undo brought back a good record, so later CE changes were quietly not stored. Now Undo or Redo re-reads the record and the hold follows it: still unreadable = held; read fine or absent = released; uncertain read = unchanged. Switch `linking.undoRefreshesUnreadableRecordHold`, ON. Opus asked to read this again; the finalizer read it and called it KEEP.
   3. Branches: #1951 and #1952 are on C-79b1 and later; not installed.
5. **Suggested class: Keep** for CDCHECK itself (nothing a drafter sees changes); **Modify** for the Undo hold (#1952), which changes later CE saves. Suggestion only.
6. **Prompts and windows.** As in field 3. Nothing new prompts. The held-record sentence, shown once per kind of write at the next CE save (not by CDCHECK): "[CE] Not saved to the CE record (<what>): the CE record in this drawing could not be read, so CE does not save over it. The original record stays in the drawing; drafting carries on." After Undo lifts the hold, this line stops appearing.
7. **Selection.** None; it reads the whole drawing. Its follow-up "show where" actions use the normal picking.
8. **Preview.** None.
9. **Drawing output.** **CDCHECK itself writes nothing to the drawing record** (its own header says so; I did not read every line of the command). It writes a text file (and CSVs) next to the CE logs. About the protected file #1952: **nothing new is written to the drawing record.** It adds a memory-only note and an open-close re-read after U or REDO. What is written to the record, and when, is unchanged: only the commands that edit (draw, PIT, EDIT, CDSYNC and similar) write it, in their own transaction (one Undo). With a held drawing, every writer asks one gate, `RecordWriteHeldBecauseUnreadable`, and skips the write rather than overwriting. A held, unreadable record cannot be saved over. Locked layers, Xrefs and REFEDIT: read only; no new behaviour.
10. **Cancel, Escape, Undo and Redo.** Escape at the first prompt ends it. Nothing to undo for CDCHECK. For the hold: U back to a good record lifts the hold; Redo back to the damaged record puts it back (Opus reading of the tests: open damaged = held, U = released, Redo = held again, U = released). No command-line line from U or Redo. **Not run in AutoCAD.**
11. **Save and reopen.** The hold is remembered in memory only, per drawing; closing the drawing drops it. On reopen the record is read again and the hold is decided again.
12. **Assets, data and Settings.** Reads the drawing's CE record and the drawing. Settings: `checks.cdcheckReadsThisDrawingsRecord`, `checks.cdcheckLinesShowNoInternalIds`, `linking.keepUnreadableDrawingRecord` (BUG-971), `linking.undoRefreshesUnreadableRecordHold`. All ON by default; BUG-971's switch (`keepUnreadableDrawingRecord`) still wins over the Undo one.
13. **Performance.** Console list capped at 60 rows; the full list goes to the file. Unchanged by these PRs.
14. **Discovery.** Ribbon (Review panel), the typed command, and a What's New entry about CDCHECK exists ("Pipe-to-pit fit warns quietly"); I did not find one for these changes. Help page: command-registry entry at line 979 of `command-registry.json` (URL not read).
15. **Example drawing and expected result.** A job of 190 objects (about 183 connections). Open it, run CDCHECK on a freshly reopened drawing. Expected: "[CE] CDCHECK: 190 objects, 183 connections: 179 Connected, 4 Unresolved" (the BUG-1251 numbers quoted in the rule's comment; your drawing will differ). Undo case: damage the CE record in a copy (or use a drawing saved by a newer CE), run any CE edit (you see the "Not saved to the CE record" line once), U back to a good record, run the edit again: it saves and the line does not repeat.
16. **Older family card.** `docs\CARDS\QA-01_PROJECT_QA_SNAPSHOT.md` and `QA-01_READY_TO_ISSUE.md` (July 2026, the "Check Current Drawing" and Project QA gate). They say nothing about CDCHECK's live-or-saved record rule, the unreadable-record sentences, or the BUG-971 hold and its Undo lift. `docs\workflows\C1_RULECHECK_GEOMETRY_2026-09-07.md` is about the rule checks' pit positions, not CDCHECK's list. `docs\workflows\C4_NETWORK_REDESIGN_PROJECTDATA_FREEZE_2026-09-12.md` is about the held redesign preview and does not cover this.
17. **Tim's AutoCAD checklist** (after C-79b1 is installed; use a COPY of a job for the damaged-record steps):
   1. Close and reopen a job. Type `CDCHECK`, press Enter for All. You should get the summary line and the numbered list, the same as before.
   2. Try `Problems` and `Csv` once each: Problems lists only Unknown, Unresolved and Not Connected; Csv names two files.
   3. Damaged-record test on a copy: use a drawing whose CE record cannot be read (ask CE 05 for one; do not damage a live job). Run CDCHECK: expect the "could not be read" sentences and no change to the drawing.
   4. On the same copy, make a CE edit (for example change a pit size in PIT). Expect one "[CE] Not saved to the CE record" line.
   5. Press U to go back to a readable record. Make the same edit again. Expect it to save with no "Not saved" line.
   6. Press REDO. Edit again. Expect the "Not saved" line to return once.
18. **Questions only Tim can answer.**
   1. **Should CDCHECK itself say that CE is refusing to save over the drawing's record?** Context: today CDCHECK reads only; the hold's message appears only at the next CE save. I understand a drafter running CDCHECK on a damaged drawing sees the "could not be read" sentences but not that CE is also holding its saves. Recommendation: leave it as is for now (it changes wording on a working command and needs its own approval); revisit if the carpark gets a report. On a job: leaving it means a colleague learns about the hold only when they next edit.
   2. **Which "Checks" button should colleagues get on the ribbon: CDCHECK or the CDCHECKS list?** Context: which one shows depends on a switch I did not read. Recommendation: no answer needed from this card; the Checks list is a separate card.
19. **NOT proven.** **Built:** yes (#1951, #1952 on `rel-20261108a`; finalizer GO at bab2dbf8). **Tested:** authors' unit tests; `Bug1070UndoRefreshesHoldTests` (damaged, U, Redo, U gives held / released / held / released); `RedoSafeCallGraphTests` 25 of 25 per the finalizer; no AutoCAD run of U or Redo; robot proof W1952 (with a broken twin, in two sessions) is listed in the b1 smoke plan, and I did not read that it has run. **Installed:** no. **Tim-accepted:** no, and no Codex PASS. BUG-1070 and BUG-1265 stay OPEN (the carpark entry for BUG-1070 has no install note yet).

---

# CARD 4. CE's saved links and Undo

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** CE remembers which pipes join which pits when you open a drawing and after Undo. One damaged record no longer makes CE forget every pit, and Undo in drawing A no longer leaves CE's pit list wrong after you picked something in drawing B.
2. **Ribbon or trigger.** None. It runs on its own when a drawing opens, after Undo (`U`), and at drawing close. The only thing you see is a command-line line when a record is skipped.
3. **Works today.** On open and after U, CE reads every pit's and pipe's link record, so moving a pit drags its pipes and moving a pit keeps its pipes attached. A pipe record that is not valid text throws and (before the PR) left CE remembering no pit's links.
4. **What the train or PR changes.**
   1. **#1892 (BUG-1141, B-070, PROTECTED FILE `LinkService.Persistence.cs`):** one pit or pipe record that cannot be read is skipped and named once per drawing; every other pit still loads. The damaged record is left as it is. Switch `linking.unreadableLinkRecordSkippedOnOpen`, ON. OFF = the old throwing read.
   2. **#1955 (BUG-1264, B-127; touches `LinkService.cs`, `ProjectDataService.cs` and its Persistence file):** CE's note of "which drawing has the saved record" becomes one note per drawing, dropped at drawing close. Switch `linking.undoRemembersEachDrawingsRecord`, ON. OFF = the old single note.
   3. Branches: both on C-79b1 and later; not on `rel-20261102a`; not installed. #1892's own robot proof W1892 (and a broken twin) is in the b1 smoke plan.
5. **Suggested class: Modify.** Same behaviour in normal drawings; the failure cases change. Suggestion only.
6. **Prompts and windows.** No prompt. The new line (command line, once per drawing, not at every Undo): "[CE] The CE link record on one pit (drawing handle XXXX, at X,Y) could not be read, so CE skipped it and loaded the rest. That pit may not drag its pipes when it is moved; its record has been left as it is." For a pipe: "...on one pipe (drawing handle ...) ... That pipe may not follow its pits when they are moved; ...". The code names it by drawing handle and position, not by pit name, because a name read at open may belong to a different record.
7. **Selection.** None.
8. **Preview.** None.
9. **Drawing output.** **Nothing new is drawn or written to the drawing.** What is written to the CE record, and when: not changed by these PRs. Existing commands (the Edit Pipe level write, CDSYNC, PIT, PIPE and others) write in their own command's transaction, one Undo step. What the new code does: #1892 only **reads** (`ReadPitLinkDataForCache`, `ReadPipeLinkDataForCache`) and names a record on the command line (which writes nothing to the drawing). #1955 holds a per-drawing memory set (by AutoCAD's internal pointer, never read back) and forgets it at close. The finalizer read the merged diff of both protected files line by line and found no path that writes a CE record in a new way and no change to the saved-data format; it also found an unreadable link record cannot be overwritten or lost by this train. Locked layers, Xrefs and REFEDIT: no new behaviour, nothing unlocked or detached.
10. **Cancel, Escape, Undo and Redo.** Undo is the point. U runs the re-read as an open-close read (REDO-safe). #1955 case: after a pick in B, Undo in A back before A's first CE save now clears CE's pit list for A. REDO: nothing new runs between U and REDO except memory bookkeeping. `RedoSafeCallGraphTests`, 25 of 25, per the finalizer. **Not run in AutoCAD.**
11. **Save and reopen.** The damaged record stays in the saved drawing exactly as it was; the skip happens on every open (named once per drawing in a session). The per-drawing notes live in memory only and are dropped at close.
12. **Assets, data and Settings.** Reads the pit and pipe link records in the drawing. Switches above, all in the settings file.
13. **Performance.** #1892 swaps six reads in `LinkService.Cache.cs` for ones that skip damaged records. No timing was measured.
14. **Discovery.** None to discover; it is automatic. I did not check What's New.
15. **Example drawing and expected result.** A job with 40 pits where pit P7's link record is truncated (a copy made for the test). Open it. Expected: one line naming one pit, then MOVE pit P12: its pipes follow. Before: nothing said, and MOVE of P12 left its pipes behind. Two-drawing case: A and B open. In A, pick pit P1 (CE saves its first record). Switch to B, pick a pit. Back in A, U past A's first CE save, then pick in the Inspector. Expected: the Inspector no longer lists the pit that U removed. Before: the Inspector kept listing it.
16. **Older family card.** `docs\workflows\C7_PIPE_LINKAGE_MODEL_2026-09-16.md` (how a pipe holds its text, arrow and pits together, written for the one-object pipe change). It does not cover what happens when a link record is damaged, or Undo across two open drawings. `docs\workflows\C4_NETWORK_REDESIGN_PROJECTDATA_FREEZE_2026-09-12.md` is about the held redesign preview and does not cover this either.
17. **Tim's AutoCAD checklist** (after C-79b1 is installed; use copies):
   1. Damaged-link test (ask CE 05 for the prepared copy; do not damage a live job). Open it.
   2. Read the command line: one line about one pit or pipe, with a drawing handle. Count: only one line per damaged record.
   3. MOVE a different pit: its pipes should follow it.
   4. Two drawings: open drawings A and B (both with CE pits). In A, draw one pit. In B, pick a pit with the Inspector. Back in A, press U until the pit is gone, then click in the Inspector area: it should not list the pit that was undone.
   5. Close and reopen A: the damaged record is still there (not repaired) and the line appears again, once.
18. **Questions only Tim can answer.**
   1. **Is a drawing handle in that command-line line acceptable?** Context: BUG-372 (`checks.cdcheckLinesShowNoInternalIds`) makes CDCHECK name objects in words, not by handle. This new line shows a handle. I understand the code does so deliberately, since a damaged record has no trustworthy name. Recommendation: accept, because there is nothing else to quote and the line is rare. On a job: a colleague reading the handle can find the object with AutoCAD's handle search; without it they could not.
   2. **Should this wait for the full re-test class?** That is a process call for CE 00 (Opus said FULL for #1952 and #1955; the finalizer said AREA). I am only flagging it.
19. **NOT proven.** **Built:** yes (on `rel-20261108a`). **Tested:** authors' unit tests, source-shape pins (`Bug192LightReadTests`, `LinkServiceSpeedRound4Tests`; the finalizer found the first "stronger pin" was not stronger and added its own pin), and the REDO-safe scan; no AutoCAD run; robot W1892 and its broken twin are planned, I did not read a result. **Installed:** no. **Tim-accepted:** no, no Codex PASS. BUG-1141 and BUG-1264 stay OPEN.

---

# CARD 5. Raingarden outlet reads "[CE] Outlet not tracked" (CDRG and the Inspector)

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** CDRG draws a raingarden (boundary, hatch, optional GIO inlet). The Inspector, when you pick one, now says "[CE] Outlet not tracked" instead of a blank or "No outlet registered", so it is clear CE has not recorded an outlet pit. It does **not** record the outlet.
2. **Ribbon or trigger.** CDRG: tab **CE** > panel **Sources** > **More sources** (split button arrow) > **Raingarden**; typed `CDRG`. (Classic layout: a **Raingarden** button.) The Inspector: tab **CE** > panel **Edit** > **CE Inspector**.
3. **Works today.** CDRG asks for points one at a time ("Specify first raingarden point: "), with a rubber-band preview; Enter or right-click finishes the outline once you have three or more points (BUG-771); Esc cancels ("CDRG command cancelled."). Close/Undo keywords and the optional GIO prompts are on the family card. The accepted result is one closed model-space boundary, one hatch, an optional GIO block, and one saved raingarden row, committed together. On the line, picking one in the Inspector shows Area, "Outlet" and "GIO handle" rows. The outlet row is `garden.OutletPitId`, which is blank for CDRG gardens (only spoon-drain code fills it), so it reads Unknown or blank; the older panel says "No outlet registered" (InspectorPaletteService.cs line 2430 on the tip).
4. **What the train or PR changes.**
   1. **#1815 (BUG-1107):** a draft PR, **on no C-79 branch**. For a raingarden whose grated inlet carries a source tag (for example GIO1) where a recorded pipe has that tag as its From or To end (GIO1 to P3), the older panel and the Civil Properties item row say "[CE] Outlet not tracked". A raingarden with a saved outlet still shows it. No recorded pipe: the old words. Switch `linking.raingardenOutletRecorded`, ON.
   2. **Naming problem found by Opus:** that key says the opposite of what it does (nothing is recorded). Opus recommended a name like `raingardenSaysOutletNotTracked` before merge (not a blocker; permanent once shipped). A test named `RaingardenOutlet_Bug1107_InletPipeToPitP3_RecordsOutletP3` asserts that no outlet is saved.
   3. CDRG itself: unchanged by #1815.
5. **Suggested class: Keep** for CDRG; **Modify** for the Inspector wording (and it is only a partial answer to BUG-1107). Suggestion only.
6. **Prompts and windows.** CDRG: "Specify first raingarden point: " then further points, "CDRG command cancelled." on Esc. Optional GIO prompts and Close/Undo per the family card (exact wording not read). Inspector words as in field 4.
7. **Selection.** Pick the raingarden boundary to see it in the Inspector. The outlet lookup reads the inlet's tag and looks for a recorded pipe end with that name. It never takes a nearby pipe or pit as a connection.
8. **Preview.** CDRG shows a rubber-band outline while you pick points, and the optional GIO uses the existing source landing preview. Per the family card.
9. **Drawing output.** CDRG: a closed boundary polyline, an associative hatch (SOLID), an optional GIO compound, and one `ProjectData.Raingardens` row, in one commit; Cancel or Esc before Apply leaves no geometry, link or record. I did not read the layer names. The family card says locked layers, Xrefs, REFEDIT and non-model-space targets refuse, and that no nearest-object adoption, fake pit or automatic outlet is introduced. #1815: **display only**; it opens the inlet block ForRead inside the Inspector's existing transaction, catches errors and falls back to the old words; nothing written; no protected file. A guard test forbids adding a project initialisation.
10. **Cancel, Escape, Undo and Redo.** CDRG: Cancel or Escape at each prompt leaves nothing; one Undo removes the whole raingarden (per the family card; not re-read in code today). Inspector: no Undo step. Not run in AutoCAD.
11. **Save and reopen.** The raingarden row is saved in the drawing's CE record; the Inspector wording is recomputed on each pick.
12. **Assets, data and Settings.** Reads the raingarden record, the inlet block's source tag and the recorded pipes. Switch in the settings file; no Settings page row (the page would be 689 px against a 673 px limit).
13. **Performance.** The older panel reuses its one existing project read. No timing.
14. **Discovery.** Ribbon and typed command above. Not checked: Help page for CDRG, What's New.
15. **Example drawing and expected result.** Place a raingarden with CDRG (outline 6 m x 4 m, area 24 m²) and its GIO inlet tagged GIO1. Pipe GIO1 to P3 at 1 in 100. Pick the raingarden. After #1815: Outlet reads "[CE] Outlet not tracked". Before: blank or "No outlet registered" (or Unknown). **It will not read "P3"**: the carpark's own "Right looks like: outlet P3" is not met by this PR, and Opus says the carpark check must be rewritten before anyone counts it as fixed.
16. **Older family card.** `docs\workflows\C3_CDRG_ATOMIC_RAINGARDEN_2026-09-13.md` (atomic CDRG). It says the raingarden is a surface asset, the GIO is the exact source, and "no ... automatic outlet" is introduced. It does not say anything about what the Inspector shows for the outlet, nor that the outlet is not tracked. It says AutoCAD acceptance is pending.
17. **Tim's AutoCAD checklist** (only once #1815 is in a built train; today there is nothing to test):
   1. Type `CDRG`. Pick four corners of a 6 m x 4 m garden, press Enter to finish. Answer the GIO prompts to place a GIO inlet.
   2. Draw a pipe from the GIO (tag GIO1) to pit P3. Run CDSYNC if needed.
   3. Open the Inspector and pick the raingarden. Expect Outlet: "[CE] Outlet not tracked" with no "P3".
   4. Try a raingarden whose inlet has no pipe: expect the old words (blank or "No outlet registered").
   5. Esc test: start CDRG, pick two points, press Esc: "CDRG command cancelled." and nothing drawn.
18. **Questions only Tim can answer.**
   1. **Is "[CE] Outlet not tracked" what you want for BUG-1107, or do you still want CE to record the outlet pit?** Context: your carpark entry offers both ("fill the outlet ... or change the words to 'Outlet not tracked'"). I understand #1815 is the second, smaller option, and the entry's "Right looks like: outlet P3" is not met. Recommendation: accept the wording now (it is honest and safe) and keep the real outlet recording as a separate card, because recording needs a design decision (which pipe end counts as the outlet). On a job: with the wording, a colleague knows nothing is recorded and must check P3 by eye; with recording, the schedule and checks could use it.
   2. **Rename the switch before merge?** Context: `raingardenOutletRecorded` suggests ON records an outlet. Recommendation: yes, rename (for example `raingardenSaysOutletNotTracked`), because it is permanent once shipped. Cost: none.
   3. **Do you want this in the next train at all?** It is not on any C-79 branch. That scheduling is CE 00's call; flagging only.
19. **NOT proven.** **Built:** #1815 only on its own draft branch (head 57f93284, base `rel-20261026u`); not in any train branch. **Tested:** author's unit tests (red first for the P3 case, per Opus); an unrelated PDF test fails on the base and passes on others, so it flips by itself; nothing run in AutoCAD. **Installed:** no. **Tim-accepted:** no, no Codex PASS. BUG-1107 stays OPEN. CDRG itself: the family card says AutoCAD acceptance is pending; I did not find a record of it being accepted.

---

## What was read, and what was not

1. **Read:** `C:\TimOS\RULES.md`; AGENTS.md and the project instructions; the Opus pre-reviews Q (1880), RECHECK (1951, 1953, 1955, 1958, 1952, 1962), U (1920), BACKLOG_R1 (1588), BACKLOG_R6 (1815; the file is titled "group r4"), FILL_REC (the BUG-971 hold and its known gap); `TRAIN_C79A_PR_LIST` and `TRAIN_C79B_PR_LISTS`; the b1 finalizer report; the build register items 266 to 273; carpark entries BUG-994 and BUG-1107; the older family cards named above; the code on `origin/claude/rel-20261112a` and `rel-20261102a` (rules, Inspector, CDCHECK, ribbon contributor, registry) by `git show` and `git grep`.
2. **Not read or not done:** the Opus group file AC and the Z, T, Y group files in full (I used the RECHECK and finalizer summaries for #1892, #1952 and #1955 instead); the C-79c reports for any mention of #1588 or #1815 (none found by search); the installed DLL; whether any robot case has run; the layer names for CDRG; the "one Checks list" switch default; Help pages and What's New text. `gh` is not on this shell's path, so PR states (open, draft, merged) come from the reviews and git ancestry, not from GitHub.
3. **Nothing was built, tested, installed or opened in AutoCAD by this job.** The only file written is this one.
