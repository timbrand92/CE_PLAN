# PENDING TESTS — what is built and waiting for Tim in AutoCAD

### BUG-1456 fourth door, a copy of another drawing's record is never written by a tool's own step — 13 November 2026 (Built and unit-tested only; NOT installed; no switch; robot and Codex to run on COPIES)

PR 2089 (DRAFT, never merged by the run), branch `claude/bug-1456c-snapshot-write-door`, on the change door (PR 2083). The refusal is in CE's log only: `[BUG-1456] CE did not write its record into this drawing: the record CE is holding belongs to another drawing. Nothing was written here.` Read CE's log after every case.

1. **Core console first:** `CEPROOFCROSSCOPY` (BUG-1456-CROSS-03), with `CEPROOFCROSSCHANGE` and `CEPROOFCROSSDRAWING` on the same head. Right = PASS for all three, each detail line showing its faulty version was noticed.
2. **The case that matters, ordinary work in ONE drawing, each tool that changes several things in one step:** CDEDIT with several pits and with several pipes (the batch edit), a Dashboard proposal applied, CDRUNSOLVE with its proposals applied, one source tool placed, CDSLAB, an AGI line, a strip drain, a water tank, CDREPAIR on a drawing with something to repair. Then U after each, save, reopen. Right = everything is recorded as on the installed build, and the refusal line NEVER appears in CE's log.
3. **Two jobs worked in turn:** the batch edit in A, switch to B, the batch edit in B, back to A. Right = each drawing's record holds its own pits and pipes only; the refusal line does not appear (these tools attach the record first).
4. **The CE Assistant panel's apply and a CDRULES approved fix** (the two routes the reviewer did not open), in one drawing and then with a second job opened first: Right = as case 2; if the refusal line appears, say which tool, and check that drawing's stored record was left exactly as it was.
5. **If any ordinary step logs the refusal line:** FAIL, and say which tool: that is a right write refused.

### BUG-1456 change door, a change to CE's record is refused when the record is another drawing's — 13 November 2026 (Built and unit-tested only; NOT installed; no switch; robot and Codex to run on COPIES)

PR 2083 (DRAFT, never merged by the run), branch `claude/bug-1456b-record-change-door`, on the BUG-1456 cure (PR 2073). The refusal is said in CE's log only: `[BUG-1456] CE did not change its record: the record CE is holding belongs to another drawing, not the one this tool is working in. Nothing was changed.` Read CE's log after every case.

1. **Core console first:** `CEPROOFCROSSCHANGE` (BUG-1456-CROSS-02) and `CEPROOFCROSSDRAWING` (CROSS-01). Right = PASS for both, each detail line showing its faulty version was noticed.
2. **The most important case, ordinary work in ONE drawing:** PIT, CD, Edit Pit, Edit Pipe, a source tool, CDSYNC, the Pit Schedule window (edit a row), erase a pit, U, save, reopen. Right = everything is recorded as on the installed build and the refusal line NEVER appears in CE's log.
3. **Two jobs, each worked in turn:** PIT in A, switch to B, PIT in B, switch back to A, Edit Pit in A. Right = each drawing's record holds its own pits only; the refusal line does not appear (these tools attach the record first).
4. **X-Civil import** into a job copy, source drawing not open beforehand (CE opens it to read it). Right = the import's pits and pipes are all recorded; the refusal line does not appear.
5. **X-Civil import with the source drawing already open in another tab.** Right = as case 4.
6. **A CE panel left open while another job is brought to the front** (corrected 13 Nov after the review of PR 2083: the Pit Schedule window cannot be used for this, it must be closed before another drawing can be brought forward). With the Inspector panel open on a pit in job A, bring job B to the front and change a pit's number in the panel; then the same with the "What CE Found" panel. Right = the edit lands in the record of the drawing in front (the panel follows it) or is refused with the log line; it must never change the other job's record. If neither panel can be made to hold job A's pit with job B in front, record the case as not reachable.
7. **If any ordinary step in cases 2 to 5 logs the refusal line:** FAIL, and say which tool: that is a right change refused.
8. **Core console, first run 13 Nov 07:55 at head `522e5502`:** `CEPROOFCROSSDRAWING` PASS; `CEPROOFCROSSCHANGE` FAIL through a fault in the check itself (it counted a stale list at its own tidy-up; the three changes WERE refused). The corrected check was pushed at `8a6decef` (08:52) and run again by the evidence lane about 09:10: `CEPROOFCROSSCHANGE` PASS and `CEPROOFCROSSDRAWING` PASS.
9. **Added 13 Nov with PR 2090 (branch `claude/bug-1456d-refusal-said-on-screen`, on PR 2089; DRAFT wording for Tim): a refusal is also said on the command line.** Whenever a case above logs the refusal line, the command line must show, once: "CE: this change was not recorded. CE is holding another drawing's pits and pipes, not this drawing's. Nothing in CE's data was changed. Please report which tool you were using." A tool refused many times in a row says it once (at most one line every 5 seconds).
10. **The line must NEVER appear in ordinary work:** rows 2 to 5 above, and rows 2 and 3 of the BUG-1456 fourth door section, with the command line read after each tool. If it appears, FAIL and say which tool.

### BUG-1456 follow-up, the opening line says when a drawing already holds another drawing's CE data — 13 November 2026 (Built and unit-tested only; NOT installed; read only; robot and Codex to run on COPIES)

PR 2078 (DRAFT, never merged by the run), branch `claude/trust-01b-other-drawings-data`, on the opening line (PR 2041). Settings: `trust.sayWhenDataLooksLikeAnotherDrawings` (ON) and `trust.anotherDrawingsDataMissingPercent` (50). The line: "CE: this drawing holds CE data that looks like it belongs to another drawing. Nothing has been changed. Do not run CDSYNC; ask before fixing." Every case reads the drawing's changed flag and stored CE record before and after: both must be unchanged.

1. **Start from the one real mixed-up drawing the evidence lane saved** (corrected 13 Nov 07:58 by that lane: `CLDTP_SAVED_CONTAM2.dwg` in its TRUST_VERIFY scratch folder is the only genuine one; `CLDTP_SAVED_CONTAM.dwg` was deleted because it turned out not to be mixed up). It is the second job (2 pits, 46 pipes drawn) carrying the standard drawing's record (11 pits, 49 pipes; the stored name is the standard drawing's). Its untouched twin is `CLDTP_LARGE.dwg` beside it. Work on COPIES of both; never open the originals. On the installed build CDCHECKCURRENT says 82 items in the mixed-up copy and 48 in the untouched one. Only if the copy is gone, make a new one with the INSTALLED build: CDDIAG in job A, open a copy of a different job B, CDHELP, check B's stored record really holds A's pits, save B under a new name and close (6 of 11 tries).
2. **Open each affected drawing on this build, touch nothing:** Right = the line above, once; no "save changes?" question on close.
3. **CDCHECKCURRENT in the affected drawing:** Right = the first item is "CE data here looks like it belongs to another drawing", it names job A's file name (not its folder) and the count not drawn here, and its next step says not to run CDSYNC. Nothing changed.
4. **A revision made by Save As:** open job A, Save As a new name, close, open the new file. Right = the usual line ("CE: N pits, N pipes, all linked." or its usual "needs checking"), NOT the line above.
5. **A job folder copied to another place** and opened there. Right = the usual line.
6. **Job A itself with its pits and pipes erased by plain ERASE, saved, reopened.** Right = the usual "needs checking" line, NOT the line above.
7. **The known limit, to be seen:** in an affected drawing run CDDIAG (it attaches the record), save, close, reopen. Expected = the line above is no longer said (the stored name is now this drawing's); the usual "needs checking, N pits with no object" line is said. Record what was seen.
8. **Switch off** (`trust.sayWhenDataLooksLikeAnotherDrawings` false): case 2 gives the usual lines only.
9. **A Structural drawing hit the same way** (job A's record written into it): Right = the line above is said (it now holds pits and pipes, so CE does not stay quiet).
10. **Added 13 Nov after the review of PR 2078. The same untouched job opened from a different folder path** (copy its folder elsewhere, open it there): Right = the usual line.
11. **The untouched job renamed in Explorer, then opened:** Right = the usual line.
12. **A new drawing started from each office template:** Right = the usual line or nothing; never the line above.
13. **CDCHECKCURRENT in a mixed-up copy shows ONE count:** the first item says "N of its M recorded pits and pipes are not drawn here (no block, or no pipe line, with that object number)", and no "X is not linked to a visible drawing object" items are listed under it. In the untouched twin the list is as on the installed build.
14. **The known limit is permanent, to be seen once:** case 7 above (after any CE tool that attaches the record saves in the mixed-up drawing, the line is not said again).

### Trust plan step 0, the reader: CETRUSTREAD, stored LPDs, and the three evidence misses — 13 November 2026 (Built and unit-tested only; NOT installed; the command's switch ships OFF; robot only, on COPIES)

PR 2040 (DRAFT, never merged by the run), branch `claude/trust-reader` at `ebf7a21a`, cut from the installed Civil commit `cf059dcf`. Setting: `diag.trustReaderCommand` (OFF; set it to true in `CD_Settings.json` for these cases and put it back after). Command: CETRUSTREAD (typed; hidden; on no ribbon). It replaces the evidence lane's throwaway probe `CEPROOFREADER`. Every case on a COPY; never the live bundle until Tim says so.

1. **Switch off:** CETRUSTREAD. Right = "CETRUSTREAD is switched off (diag.trustReaderCommand). Nothing was read or changed."; drawing not marked changed.
2. **Switch on, the six drawings of EVIDENCE_READER.md:** type a plain name (T01 or MADEUP_...). Right = the reading on the command line AND in `%TEMP%\CE_TrustReader\<NAME>_<date>_<time>.txt`; nothing beside the drawing; DBMOD the same before and after; no new Undo step; CE's stored record text identical before and after (read directly, not through a CE tool); two runs word for word the same.
3. **MADEUP_oldpit_levels_01:** cover levels 12.30, 12.10, 11.95, 11.60 on pits 1, 2, 3, 5 and inverts 11.20, 11.05 on pits 1 and 2, each Proposed with "COVER LEVEL block ... with its value text ... is 1860 mm from pit ..."; pit 4 cover level Unknown; NEW LEVEL 11.95 not a cover level.
4. **MADEUP_oldlisp_01:** pipe A-B inverts 1.10 and 0.90, pipe B-C 0.88 and 0.75 ("lies beside the pipe, 2200 mm along from its end"); pits P1 and P2 no longer take an invert.
5. **MADEUP_oldpipeblocks_01:** the loose pipe's size Unknown with "text found, wording not recognised: "150 DIA. PIPE"".
6. **A copy with an LPD set (CDLPD, and one with the newer set from CDDESIGN):** each LPD a Proposed row "a stored LPD is read as a proposal for the start point"; a copy holding both forms: one Unknown LPD and the note "CE's stored LPD could not be read: both LPD forms are stored ...".
7. **Not covered:** real AutoCAD (core console only is fine for this command), AutoCAD 2022 to 2024, a real old job.

### BUG-1456, CE's record is never written into a drawing it does not belong to — 13 November 2026 (Built and unit-tested only; NOT installed; no switch; robot and Codex to run on COPIES)

PR 2073 (DRAFT, never merged by the run), branch `claude/bug-1456-record-own-drawing`, cut straight from the installed Civil commit `cf059dcf`. No setting to turn on: the protection is always there. What was seen on the installed build is in `areas\trust-run\EVIDENCE_CROSS_DRAWING.md`. Every case uses two DIFFERENT jobs (a copy of the same job can hide the fault) and reads the second drawing's stored CE record (pits, pipes, stored path) before and after.

1. **Core console first:** `CEPROOFCROSSDRAWING` (BUG-1456-CROSS-01). Right = PASS, and its detail line shows the faulty version (the installed writer called with no check) wrote the other record and was noticed.
2. **The seen sequences, real AutoCAD:** (a) CDDIAG in job A, open job B, CDHELP and close; (b) CDDIAG in A, open a blank drawing, CDS and close; (c) CDDIAG in A, open B, CDS alone; (d) the other order: CDDIAG in B, make A current, CDHELP. Right each time = the second drawing's record is exactly as it was; the blank drawing still has no CE record and does not ask to be saved.
3. **The log line:** when a write is refused, CE's log holds one line "CE did not write its record into this drawing: the record CE is holding belongs to another drawing. Nothing was written here." Help and CD Settings no longer write at their end at all, so after case 2 the line may not appear; that is right too. Record which was seen.
4. **The comparison run on the installed build (3.0.90):** the same four; expect the fault (6 of 11 there).
5. **The controls must still pass:** (a) in B, a circle then U, then CDS: B keeps its own record; (b) the same with CDHELP; (c) a cancelled PIT and a cancelled CD in A, then B and a blank drawing with CDHELP and CDS: nothing changed in B or the blank drawing.
6. **A real change is not lost:** Edit Pit in A with a changed cover level, OK; switch to B; CDHELP. Right = A's stored record holds the new level (now, or after A's next command), and B is untouched.
7. **A real change whose drawing has closed:** Edit Pit in A, OK, close A without saving, then CDHELP in B. Right = nothing of A's is written into B.
8. **One drawing, ordinary work:** PIT, CD, Edit Pit, save, reopen. Right = everything is stored as on the installed build (the check never stops a drawing's own record being written).
9. **Not covered by this change:** a drawing that already holds another job's record from before is not repaired.

### Trust plan queue item 7, a cancelled command writes nothing — 13 November 2026 (Built and unit-tested only; NOT installed; the switch ships OFF; robot and Codex to run on COPIES)

PR 2064 (DRAFT, never merged by the run), branch `claude/trust-09-cancel-writes-nothing`, on step 6 plus the headless checks. Setting: `trust.cancelledCommandWritesNothing` (OFF; set it to true in `CD_Settings.json` for these cases and put it back after). Every case starts from a FRESHLY OPENED copy and compares the whole stored CE record text, the drawing's object count and the Undo list. Use a copy whose record is in an older format as well as a current one.

1. **Core console first:** `CEPROOFTRUSTCANCEL` (TRUST-CANCEL-01). Right = PASS, and its detail line shows the faulty version (switch off) was noticed.
2. **Switch off:** every case below behaves as the installed build (a cancelled PIT rewrites the record). This is the comparison run.
3. **Esc at the first question, switch on, one tool per fresh copy:** PIT, CD (Esc at the first point, and Cancel in the New Pipe window), CDFW, CDAGI, CDSTRIP, CDRUNSOLVE, DP, IO, OF, FO, GIO, CDTG, CDSL, CDWT, Edit Pit (Cancel), Edit Pipe (Cancel). Right = stored record identical, character for character; no new Undo step named after the tool; closing the drawing asks nothing.
4. **Help and CD Settings in a second drawing:** copy A open, run any CE tool in it; open copy B (a blank drawing, then a different job); type CDHELP and close it; type CDS and close it. Right = B's CE store is exactly as it was (a blank drawing still has none; another job still has its own pits). Switch off on the installed build: record what B holds afterwards (the review expects A's record in B).
5. **A real change is still written, and still one U:** PIT placed properly; Edit Pit with a changed cover level, OK; CD drawing a pipe. Right = the record changes, one U puts the record and the drawing back together.
6. **A brand new drawing:** PIT, Esc at the first question. Right = the drawing holds no CE store at all afterwards. PIT placed properly: the drawing is marked Civil and the record holds the pit; reopen: the opening line counts it.
7. **A drawing with a stray line on the pipe layer (the record really is behind):** PIT, Cancel. Right (said plainly, NOT fixed by this item) = the record may still change, and step 5's "CE updated its record" line says what changed.
8. **Old job, record in an older format:** open, run CDFW, Esc. Right = the stored record keeps its older format and no identities are added. Then place one floor waste: the record is written in today's format with the identities.
9. **Two drawings, work waiting in the first:** change a pit in A (Edit Pit, OK), switch to B, run a CE tool. Right = A's change is in A's record (never lost, never in B).
10. **Added 13 Nov after the review of PR 2064 (head `9d44a9c0`; BUG-1456 is now its own section above, PR 2073, and is merged into this branch). Core console:** `CEPROOFTRUSTESC` (TRUST-CANCEL-02) as well as `CEPROOFTRUSTCANCEL`. Right = PASS for both, each detail line showing its faulty version was noticed.
11. **Esc in a brand new drawing (no "Civil" mark yet), switch on:** PIT, Esc at the first question; then draw a LINE. Right = CE's record and the "Civil" mark are NOT written with the LINE; one U takes back the line only; closing asks only about the line.
12. **The same with the tool closed by its window's X or Cancel, and with a tool that fails** (for example PIT with its layer locked). Right = as case 11.
13. **An update that really changed something, then Esc, switch on:** in a job copy, erase one pipe line with plain ERASE; PIT (its hidden update drops the pipe), Esc. Right = the changed record is written inside the PIT command (step 5's line says what changed); the next command (a LINE) has only the line in its Undo step.
14. **A tool that asks for the mark only after placing (CDTG, CDSL, CDWT on the safety lane's branch, when merged):** in a new drawing place one. Right = the "Civil" mark is written with it, in the same Undo step.
15. **The list is 14 names now:** Help and CD Settings never write CE's record at their end, switch on or off.
16. **Added 13 Nov after the re-review of PR 2064 (head `dde7825e`). A ZOOM or PAN in the middle of a CE tool, switch on, in a brand new drawing:** start a spot level tool (it puts nothing in CE's record), type 'ZOOM (with the apostrophe) or pick Pan on the navigation bar at its first pick, finish the zoom, then place the spot level. Right = the drawing is marked "Civil" with it, in the same Undo step. Then the same with PIT.
17. **The same, but Esc out of the tool after the zoom:** Right = nothing is written (no mark, no record), and a LINE drawn next has only the line in its Undo step.
18. **A CE tool that runs other commands itself (Copy and Rotate) in a new drawing, switch on:** Right = the mark is written with what it places; nothing is lost.
19. **Note on rows 2 and 4 (from the re-review):** on this branch the BUG-1456 mix-up no longer shows with the switch OFF either (PR 2073 is merged in); only the INSTALLED build still shows it. Row 14's CDTG, CDSL and CDWT apply once PR 2055 is merged with this.

### Trust plan step 7, the LPD as the one stored start point (TRUST-07, DRAFT card) — 13 November 2026 (Built and unit-tested only; NOT installed; the switch ships ON; robot and Codex to run on COPIES)

PR 2058 (DRAFT, never merged by the run), branch `claude/trust-07-lpd-start-point`, stacked on step 6. Setting: `trust.toolsStartFromConfirmedLpd` (ON). Full case set: `areas\trust-run\cases\TRUST-07.md`. Existing robot scripts for CDRENUMBER and CDRUNSOLVE meet ONE NEW QUESTION on a drawing with an LPD; answer it or switch the setting off.

1. **Asked once (H1, H5):** a copy with an LPD drawn by CDLPD. Run CDRENUMBER. Right = "CE found the LPD on the pipe leaving P1. Is this the start point?"; type Y; "CE: LPD confirmed on the pipe leaving P1."; answer No to the renumber. Run CDRENUMBER and CDRUNSOLVE again: no second question. Save, close, reopen: still no question.
2. **Enter does not confirm:** at the question press Enter. Right = the question is asked again; nothing stored.
3. **Escape (H8):** fresh copy; Escape at the question. Right = "CE: LPD not confirmed, order may differ.", the tool carries on as the installed build does, and the drawing's LPD group holds nothing new.
4. **Opening line (H19):** confirmed copy, reopen. Right = "..., all linked, LPD confirmed." Erase the LPD's pipe, save, reopen. Right = "needs checking" with "the LPD's pipe is no longer in the drawing"; CDCHECKCURRENT lists "The LPD needs checking"; CDRENUMBER says the same and picks no other LPD.
5. **CDRENUMBER with two pipes leaving the network:** not confirmed = it asks which pit is the main outlet (as today). Confirmed = it does not ask, and counts up from the pit at the LPD.
6. **CDRENUMBER with no pipe leaving the network (BUG-1237, H28):** confirmed LPD = it renumbers from the pit at the LPD instead of stopping.
7. **The solver and the pit named LPD-3 (H7):** LPD drawn at P1, pit P3 renamed LPD-3. Confirmed = the run from upstream of P3 goes on to the LPD. Not confirmed = "LPD found by pit name at 'LPD-3', not confirmed".
8. **CDLPD cannot write (H14):** a drawing whose outlets were set in the Design window. Type CDLPD. Right = one plain line starting "[CE] CDLPD cannot change the LPD here:" before any window, ending "Nothing has been changed."; never "see CE log". Same for CDLPDRESET.
9. **Move the LPD (H20):** confirmed copy; CDLPD onto another pipe end. Right = the next tool asks the question again. One U after the move: RECORD what comes back.
10. **CDLPDRESET:** confirmed copy; reset. Right = the opening line no longer says LPD confirmed and says nothing about a left-over confirmation.
11. **Save As (H17):** confirmed copy saved under a new name: still "LPD confirmed", no question. Then erase the network and draw a new one: "needs checking", and a new LPD is asked about.
12. **Read-only (H27):** open a confirmed-less copy read-only, run CDRENUMBER, type Y. Right = "CE: this drawing is read-only, so the LPD confirmation is used for this session only and is not stored."; file time and size unchanged.
13. **Installed build afterwards (H7 of the card's list, H15):** open a confirmed copy in the INSTALLED build. Right = CDLPD, CDLPDRESET and the Pit Schedule work as before and the LPD does not read as damaged.
14. **Switch off (H22):** CDRENUMBER and CDRUNSOLVE ask nothing and behave as the installed build; the stored confirmation is still in the drawing.
15. **Undo (H9), RECORD only:** confirm, press U once, read the LPD group. No line may promise what U does.
16. **Not built, do not test as built:** the long section (CDPROFILE), placing the LPD from inside a tool, two LPDs choosing by which pits drain where, an LPD inside an attached drawing, the Pit Schedule's order.
17. **Added 13 Nov after the review of PR 2058. Stale on any change:** confirm; then (a) stretch one end of the LPD's pipe, (b) on a fresh confirmed copy re-join the pipe to another pit, (c) on a fresh confirmed copy reverse the pipe. Right each time = the opening line says "needs checking" with "the LPD was changed since it was confirmed", and the next CDRENUMBER asks the question again.
18. **Renumbering does not undo the yes:** confirm, run CDRENUMBER and accept, run CDRENUMBER again. Right = not asked again; the opening line still says LPD confirmed.
19. **Moving the LPD's note or callout:** confirm, MOVE the callout 3 m. Right = still confirmed (the note is not part of what was confirmed). RECORD.
20. **More than one LPD (replaces case 3 of the card, which is NOT BUILT):** a job with two outlets set in the Design window. CDRENUMBER and CDRUNSOLVE. Right = no start-point question; one line "CE: more than one LPD in this drawing. CE does not yet know which pits drain to each, so the order is worked out as before."; the solver never prints "not confirmed".
21. **Long section:** LPD stored, not confirmed: CDPROFILE. Right = one line "CE: LPD not confirmed. The long section still stops at the LPD stored in this drawing." and no question; the routes stop at the LPD as on the installed build. Confirmed: no line.
22. **Save As and AutoCAD's drawing fingerprint (settles a point the review raised):** on a copy read FINGERPRINTGUID, Save As to a new name, read it again. RECORD both. Then on a confirmed copy: Save As, reopen the new file. Right (by reading) = same fingerprint, still "LPD confirmed", no question.
23. **LPD set again on the same pipe end with another pit:** confirm; CDLPD picking a different pit that resolves to the same pipe end. Right = asked again.

### Trust plan step 8 slice A, the read-only Check this drawing list (TRUST-08, DRAFT card) — 13 November 2026 (Built and unit-tested only; NOT installed; the switch ships OFF; robot and Codex to run on COPIES)

PR 2051 (DRAFT, never merged by the run), branch `claude/trust-08a-check-list`, stacked on step 6 with the reader (PR 2040) merged underneath. Setting: `trust.checkThisDrawingList` (OFF; set it to true in `CD_Settings.json` for these cases and put it back after). Command: CDCHECKDRAWING (typed; on no ribbon).

1. **Switch off:** type CDCHECKDRAWING. Right = one line saying it is not switched on yet; nothing else happens.
2. **Current job copy, switch on:** Right = `Sure (N): ...` with the job's pits and pipes, `Proposed (0).`, `Unknown (0).` or the single line `CE: all linked. Nothing to check.` Close without editing: no "save changes?" question.
3. **Same copy with one extra polyline on the stormwater pipe layer:** Right = that line is in Proposed or Unknown with a reason, never in Sure, and the state line says needs checking.
4. **A pit block with no label:** Right = in Unknown as `Pit: ... Number Unknown (...)`.
5. **Old drawing with no CE record:** Right = nothing is Sure; every pit and pipe is Proposed or Unknown, each with a reason.
6. **A drawing that is not Civil:** Right = `Sure (0).`, nothing proposed, or the nothing-to-check line; the drawing is not changed and not marked Civil.
6a. **Changed 13 Nov after the review of PR 2051. Every case starts from a FRESHLY OPENED drawing** and compares CE's stored record before and after; AutoCAD's DBMOD is not proof (it is already set in a drawing with unsaved work).
6b. **A drawing that is not Civil, or whose drainage is all inside an attached drawing:** Right = `CE found no pits or pipes in this drawing's model space.` and, with an Xref attached, the note that drainage inside attached drawings is not checked. NEVER `CE: all linked. Nothing to check.` (This replaces the expectation in case 6.)
6c. **Copy a numbered pit within the job (or paste one in from another job) so two pits show the same number:** Right = neither is counted in Sure; both are listed under Unknown as `Number P3 is on 2 pits in this drawing`.
6d. **A pit whose number is in CE's record but has no label on the plan (erase its label):** Right = under Proposed as `Proposed: number P8 (the number is in CE's record but no label on the plan shows it)`, and P8 is not in the "found" part of the row.
6e. **Old job with no record, pits with a label nearby but no levels:** Right = each such pit is under Unknown with its Unknown levels AND `proposed number P3: label is ... from pit ..., the only pit in reach`.
6f. **By eye on every list:** no row shows an object code (short strings of digits and the letters A to F such as 2A4F); no row says "card", "record format" or "attribute".
7. **A read-only drawing:** the list still shows (it writes nothing).
8. **Run it twice on fresh copies of the same file:** Right = the same lines, row for row.
9. **Read the stored record before and after (straight from the drawing):** identical.
10. **Broken twin (already proven without AutoCAD):** a copy of the list that writes to the drawing is caught by the compiled-plugin scan.
11. **Not provable by the robot alone:** whether each proposal's reason is one a drafter agrees with (Tim, on jobs he knows); the wording of the rows (one Codex look).

### Trust plan step 6, Unknown instead of made-up values (TRUST-06, DRAFT card) — 12 November 2026 (Built and unit-tested only; NOT installed; the Unknown switch ships OFF; robot and Codex to run on COPIES)

PR 2049 (DRAFT, never merged by the run), branch `claude/trust-06-guesses-removed`, stacked on step 5. Settings: `trust.showUnknownInsteadOfGuess` (OFF), `trust.reachesFollowDrawingUnits` (ON), `reaches.pitLabelSearchPastPitMm` (2000), `reaches.pitLevelTextSearchPastPitMm` (2500), `reaches.restoreByPositionMm` (200), `reaches.orphanPitMatchMm` (50). Each fill-in is an engineering default: the robot and Codex can prove the behaviour, only Tim's word settles what each should be.

1. **Unknown switch OFF, millimetre job (the shipped state):** run PIT, CD, CDEDIT, CDSYNC, CDUPGRADE and the Pit Schedule on a copy. Right = nothing differs from the installed build.
2. **Unknown switch ON, a line on the pipe layer with no size:** run CDSYNC. Right = the pipe's size and material are blank in the record; the Pit Schedule shows "?"; nothing reads 100 or UPVC; step 5's line has no "Guessed" sentence.
3. **Unknown switch ON, a pit symbol with no label:** Right = no P number is made up; the pit holds CE's code for its symbol; no number label is drawn. (Windows do not show "?" for it yet.)
4. **The same job in a millimetre copy and a metre copy (units switch ON):** Right = identical readings, item for item, including a 225 pipe drawn 0.225 wide in the metre copy.
5. **Metre drawing, a pit with a label 1.5 m away and another label 30 m away:** Right = only the first is matched.
6. **Save, close, reopen with Unknowns:** Right = the same Unknowns.
7. **Broken twin (already proven without AutoCAD):** a version that still fills "100" fails the same check as case 2.
8. **Units switch OFF:** the metre copy behaves as on the installed build (the far label is matched too).
9. **Not covered by this build (see the regression entry, item 6):** Edit Pit's lid offer, CDPROPAGATE's 225, the pipe flow calculator, the detention pipe volume, copies and pipe split, plan label wording, the Pit Schedule's "0 x 0" and write-back, flow direction, two pits in reach of one label, a no-units drawing that is really in metres.
10. **Not provable by the robot alone:** how Unknown looks in the schedule window, Edit Pipe and Edit Pit (Codex look); whether the Unknowns are the ones Tim would expect on jobs he knows (Tim).
11. **Added after the review of PR 2049 (13 Nov). Unknown switch ON, the relink step:** draw a plain line (no width) on the stormwater pipe layer between two pits, run CDLINKDANGLINGPIPES, then CDSYNC. Right = the new pipe's size is blank in the record, not 100 and not "0"; step 5's line has no "Guessed" sentence for it. Same with the switch OFF: 100, and step 5's line says it was guessed.
12. **Unknown switch ON, a pit symbol with no label, then the Pit Schedule:** place the schedule table. Right = that pit is NOT a row in the placed table (no row showing CE's code for the symbol, no "0 x 0"), and CDCHECKCURRENT lists it as "Pit left out of the Pit Schedule: its number is not known". Give the pit a number and a size: it joins the schedule by itself. Switch OFF: the schedule lists pits exactly as the installed build does.
13. **Unknown switch ON, CDUPGRADE keeps a recorded size:** a pipe whose record holds 150 and whose line has no drawn width. Run CDUPGRADE. Right = the record still says 150. (Switch OFF: it becomes 100, as on the installed build.)
14. **The pit seen in AutoCAD on the installed build (`areas\TRUST_PROBES_13NOV.md` section 4):** an unlabelled PIT BLOCK 3. Switch OFF = P8, 350 x 350, Class A Grated Lid, plastic, not scheduled (as seen). Switch ON = no made-up number or lid.

### TRUST-04 core safety fixes (session trust-safety-fixes) — 12 November 2026 (Built and unit-tested only; NOT installed; Codex or robot to run on COPIES)

Each fix is its own draft pull request cut from the build Tim has installed (Civil 3.0.90 = cf059dcf, Structural 1.0.126 = 8de95c34). None is merged or installed. Card: `04_REFERENCE/ux-plan/cards/TRUST-04_CORE_SAFETY_FIXES_CARD_DRAFT_2026-11-12.md`. Findings: side-session note `trust-safety-fixes_findings_12nov.md`.

1. **BUG-650, cancel CDFW keeps pit inverts (ALREADY INSTALLED since Civil 3.0.70, commit da006db6; no new PR).** On a copy with pits P1 (invert 20.000) and P2 (19.800) whose labels show CL only: open Edit Pit on P1 and P2 and write both inverts down FIRST. Type CDFW, press Esc at "Specify floor waste insertion point". Open Edit Pit on P1 and P2 again. Right: 20.000 and 19.800, unchanged. Repeat with CDSOURCE (Esc at the source type question). Then CDFW and place a floor waste on the pipe run: FW1 appears, the inverts are still 20.000 and 19.800, one U removes FW1. Broken twin: none needed in AutoCAD (unit twin done 12 Nov: 3 of 8 tests fail with the fix taken out).
2. **BUG-1274, Pit Schedule says which pits it leaves out (PR #2039).** Needs the PR installed. Copy with 2 concrete pits and 3 plastic pits never set to "Number and schedule this one anyway" (P3, P4, P5). PITSCHEDULE. Right: the line at the top reads "3 plastic pits are not in this schedule: P3 to P5. Open PIT on each and press Number and schedule this one anyway to add it." and the table shows the 2 concrete pits only. Open PIT on P4, press Number and schedule this one anyway, OK; PITSCHEDULE again: P4 is in the table and the line names 2 pits, P3, P5. Everyday case: place two plastic pits with PIT today (they get no number) beside P3 and P5: the line reads "...P3, P5 and 2 without a number..." and never shows a code such as 2A3F; with only unnumbered plastic pits it says none of them has a number. There is no off switch (removed 13 Nov). Nothing in the drawing changes (no save prompt from the window alone).
3. **BUG-1276 Civil, not-saved reminder and timed copies (PR #2042).** Needs the PR installed. On a copy: Settings Backups `unsavedReminderMinutes` 2, `unsavedCopyMinutes` 2; AutoCAD SAVETIME 1. Draw a line, do not save, wait 3 minutes with no command running. Right: the CE status-bar text starts "Not saved for 2 min", the command line says "CE: not saved for 2 min. CE never saves; type QSAVE to save.", and a file `<name>_UNSAVED_<date>.dwg` appears in `%APPDATA%\TIM_CE_CADTOOLS\AutoSaveBackups\UnsavedWork\<drawing folder>`. The drawing file's own date does not change. QSAVE: the status text goes back to normal and no further reminder comes. Twin: set `unsavedReminderEnabled` false: no status text, no line.
4. **BUG-1255, Pit Schedule Export Excel on AutoCAD 2027 (ALREADY INSTALLED since Civil 3.0.88; no new PR).** Codex K1-01 and K1-03 PASSED on 1 Nov on 3.0.88. Still owed: K1-04, the switch-off twin (`excel.useAutoCadLoadedClosedXml` false before AutoCAD starts: no file, the line "Excel export could not start on this AutoCAD. Use Export CSV, it saves the same rows.", no "rendering error"), and one repeat of K1-01 on 3.0.90. CDCALC XLSX is BUG-1268, separate.
5. **BUG-1276 Structural, not-saved reminder and timed copies (PR #2048).** Needs the PR installed. Same steps as row 3 on a Structural copy, with the Structural Settings boxes (Backups: reminder minutes, copy minutes). Right: the Structural status text reads the not-saved minutes, the same command-line line as row 3, and an `_UNSAVED_` copy in `%APPDATA%\TIM_CE_CADTOOLS\AutoSaveBackups\UnsavedWork\<drawing folder>`. Also with an Xref attached and open in a second tab: the copy is skipped for the Xref tab only (one CE log line saying why). Save a drawing from the Standard Details folder or a drawing template: no "backup copy not made" line at all. Save a recovery copy (A$C...): the line says it is a temporary or recovery copy, never "CE could not read the drawing file".
6. **BUG-497, STRSCHEDCREATE one row short (PR #2044).** Needs the PR installed. Copy: draw one AB brace, one bored pier, one tie-down. STRSCHEDCREATE. Right: three tables, each with a title row, a heading row and the one item listed; no AutoCAD error. Then four AB braces: the bracing table lists four.
7. **BUG-498, STRSCHEDREFRESH leaves erased braces listed (PR #2046).** Needs the PR installed (and row 6). Copy: four AB braces, STRSCHEDCREATE, erase one brace, STRSCHEDREFRESH, pick the bracing schedule. Right: three braces listed, the old fourth row blank. Same with bored piers. A schedule on a locked layer: CE refuses as AutoCAD does today (unchanged).
8. **BUG-499, roof trusses out of wall bracing totals (PR #2047; ENGINEERING: Tim to confirm the rule).** Needs the PR installed. Copy: CSBRACINGREQUIRED North-South 5000; one 2700 AB brace running north-south; one 4000 truss with BT1 running north-south; CSBRACINGPANEL. Right: North-South "2700 provided / 5000 required" and a cross (short). Wrong (today): 6700 provided. Only roof trusses are removed; how type A and type B combine is unchanged and still Tim's call.
9. **BUG-1275, SBEAM crash: NOT BUILT.** Cause not proven (crash inside AutoCAD's own drawing code while CE reads the current space). Nothing to test from this run.
10. **BUG-1042, a blank cover level no longer blocks New Pit and Edit Pit (PR #2052).** Needs the PR installed. Copy drawing: PIT, choose a type and size, leave Cover level empty. Right: the bottom line reads "No cover level yet: the pit will be saved with the cover level blank (Unknown, never 0.000). Depth checks at this pit will say not known.", the cover box is highlighted, and Continue placement works; the pit's cover text has no CL line; PITSCHEDULE shows its cover cell blank, never 0.000. Then double-click the pit, change the width, Save with the cover still blank: it saves. Type 10.250, Save: the CL line appears. Broken twin: a width that is not a number still greys the button. Added 13 Nov: PIT with "add cover text" on and nothing to write (cover empty, no invert shown, no notes, not plastic): no corner question, and the line "No cover text placed: there is nothing to write in it yet..." shows. Edit Pit on a pit whose cover text is only "CL 20.000": clear the cover level, Save: the cover text is removed (LIST at that corner finds no empty text).
11. **Also from the 13 Nov review fixes (needs the PRs installed):** (a) row 2, PR #2039: a plastic pit placed with PIT today (no number) is counted, never shown by an internal code such as 2A3F; with P3 and P4 numbered plus two unnumbered the line reads "P3, P4 and 2 without a number". (b) rows 3 and 5: with AutoCAD's automatic save switched off (OPTIONS, Open and Save, untick Automatic save), draw a line and wait past the copy minutes: one line "CE cannot keep copies of unsaved work: AutoCAD's automatic save is off ..." appears once; with both new reminder switches off, no "backup copy not made" line ever appears.
12. **Queue item 6, Esc at the first question of CDTG, CDSL or CDWT leaves CE's record as it was (PR #2055).** Needs the PR installed. Copy drawing: edit one pit's CL text on the plan by hand so it differs from CE's stored cover level; note the stored level in Edit Pit. Type CDTG, Esc at the start point: Edit Pit still shows the old stored level. Same for CDSL (Esc at the insertion point, and Esc at the level question) and CDWT (Cancel in the tank window). Then run CDTG and CDWT to the end: they place as before. CDSL placed to the end: the stored pit level is STILL the old one (CDSL never updates CE's record now). On a freshly opened copy with no edits, Esc at the first question of each: the drawing is not marked changed (no save prompt on close). The robot should compare the whole stored record text before and after, not one level.
13. **Queue item 7, Edit Pipe Save refuses a locked layer or Xref (PR #2056).** Needs the PR installed. Copy drawing: lock the layer of one pipe's size text. CDEDIT the pipe, change the diameter, Save. Right: "[CE] A label of this pipe is on locked layer <name> (unlock it, or leave it out, then run the edit again). Save was not applied."; the pipe, its labels and its stored values unchanged; the layer still locked. Unlock, Save again: it saves. Repeat with the pipe's own layer locked. A pipe in a layout still saves. Added 13 Nov: an older-style pipe with a double-line border on a locked layer, and a detention pipe with twin barrels on a locked layer: each refused in plain words, never AutoCAD's own locked-layer error.
14. **Queue item 5, CD Cancel guard (PR #2076 on trust-foundations' #2064, tests only; PR #2053 is the older version, superseded, left open for Tim).** Robot case: freshly opened copy, no edits; read CE's stored record text; (a) CD, Esc at the first point; (b) CD again, Cancel in the New Pipe window; (c) window-first CD (window first, then points), Esc at the first point; read the record text and the object count again after each. With #2064's switch `trust.cancelledCommandWritesNothing` OFF (today) the text may be restamped and the drawing shows as changed; with it ON: identical text, no change.
15. **Queue item 8, Esc cancels in CDWT and at CDAGI's level questions (PR #2057).** Needs the PR installed. CDWT: pick a tank, Esc at the detention volume: "CDWT cancelled", nothing placed. Again, Esc at the callout point (and separately at the riser and dropper points): nothing placed. Again with Enter at all three: the tank is placed without them, as before. Repeat through the tank window. CDAGI: draw the run, pick the outlet, Esc at "Start invert level": "CDAGI cancelled - nothing was drawn."; Enter at both levels: drawn with no grade line, as before.
16. **Queue item 9, CD's breakline answer and missing parts (PR #2059).** Needs the PR installed. CD with the breakline toggle on, draw the pipe, answer No in "Continues to another plan?": "[CE] No breakline placed: this pipe ends on this plan.", no breakline symbol, the level text at that end IS on the plan, and CDEDIT shows that end's level as shown (not hidden). Again with Yes: breakline and the "run CD again" line, no level text at that end, CDEDIT shows it hidden. Missing parts: make the arrow layer locked, draw a pipe: one line "The pipe was drawn, but CE did not place its flow arrow (a question was cancelled, or CE could not; the CE log says which)..." (not proven that a locked layer is what stops it).
17. **Queue item 10, CDMA and CDANNOTATIONEDIT protection (PR #2060).** Needs the PR installed. CDMA: pick an Xref: "That is part of an external reference (Xref)... nothing changed."; pick an ordinary block (a north point): "not a CE flow arrow"; pick a CE arrow and move it: "Flow arrow moved."; pick a pipe, Esc at "Enter first invert level": nothing placed, "Move arrow - nothing changed."; Esc at "Reverse arrow direction?": nothing placed. CDANNOTATIONEDIT: pick text inside an Xref: the Xref line, no Move/Rotate question.
18. **Queue item 11, CDLPD in a metre drawing (PR #2061).** Needs the PR installed. A metre-unit copy with two pipe ends about 3 m apart. CDLPD, pick a point 0.1 m from one end: the LPD goes on that end. Pick a point 5 m from any end: "No pipe end found" (before: the nearest end however far).
19. **Queue item 12, start-up checks (PR #2062).** Needs the PR installed. Make a copy read-only (file Properties). Run CDREVERSEFLOW, CDTEXTSEG, CDMA, CDTIDYLABELS, MR, CR, CDDEST, CDSYSTEM: each says the drawing is read-only and asks nothing. On a layout tab outside a viewport, CDREVERSEFLOW: the Paper Space line; MR there runs as before (no refusal). During REFEDIT, CR: the REFEDIT line. Added 13 Nov (review fix 620fe976, Tim's 7 Nov ruling): MR and CR on a Structural drawing and on an untagged drawing (a survey or consultant's plan) ask NO drawing-type question, write no tag, and move or copy as before. Check on 2027 and on one of 2022 to 2026 (MR and CR have two code paths).
20. **Queue item 13, BUG-1313, CDRG and CDAGI close distance in a metre drawing (PR #2063).** Needs the PR installed. A metre-unit copy. CDRG: pick four corners about 5 m apart, and for the fourth pick click 0.5 m from the first corner. Right: the outline does NOT close (before: it closed early, anything within 1 m counted). Same with CDAGI's outline. CDAGI on a run whose two ends are at clearly different distances from the outlet (both under 1 m): it picks the nearer end.
21. **Queue item 13, BUG-1356, CDRUNSOLVE preview words (PR #2065).** Needs the PR installed. Copy with a run of three pipes. CDRUNSOLVE. Right: the preview title says "(invert levels only)" and each line reads "Whole-run solve: invert levels only. Suggested DN... at 1:... (... m/s); size and grade are not changed - set them in Edit Pipe if you agree." Apply. CDEDIT each pipe: only the two inverts changed; size and grade as before.
22. **Queue item 13, BUG-1339, CDCHECKCURRENT flags a blank link (PR #2066).** Needs the PR installed. A copy whose record holds a pit with no drawing object recorded (for example a test job where a pit block was erased and the record kept). CDCHECKCURRENT. Right: the list names that pit as "not linked to a visible drawing object" with "The saved item list has no drawing object recorded for this item." Nothing in the drawing or the record changes. Added 13 Nov (review fix d846f1ed): with two such pits that have no number, Ignore one of them: the other is still listed. Known limit: an item with neither a drawing object nor a CE identity is named by its place in the list, so after items are added or removed an Ignore can shift onto another such item.
23. **Queue item 13, BUG-1300, moving the LPD takes 'LPD' off the earlier pipe (PR #2067).** Needs the PR installed. Copy with two pipes A and B whose downstream ends are blank. CDLPD on A's downstream end: CDEDIT A, its To reads LPD. CDLPD on B's downstream end: the command line says "LPD moved: pipe <A> no longer ends at the LPD."; CDEDIT A: its To is blank; CDEDIT B: its To reads LPD. Run CDLPD again on B's same end: nothing changes on A or B. PITSCHEDULE and CDCHECK show one discharge end, not two.
24. **BUG-1052, CDAGI and CDPERIMETER grade check in a metre drawing (PR #2075, stacked on #2057).** Needs both PRs installed. BUG-1052's own steps: empty metre drawing (INSUNITS 6), Settings AG minimum grade 1 in 100; CDAGI, Enter for None, pick 0,0 then 10,0, Enter, skip the outlet, start invert 10.001, end invert 10.000: the preview reads "1:10000" and "below the office minimum" (before: 1:10 "meets"). Repeat with CDPERIMETER. A 0.5 m run must still ask for the levels. Also: a metre-unit copy, CDAGI, a 12 m run, start invert 10.000, end invert 9.900. Right: "1:120 - below the office minimum 1:100. Increase the fall or shorten the run." (before: about 1:0.1 and "meets"). The same run in a millimetre copy gives the same words.
25. **BUG-1334, MR and CR on AutoCAD 2027 (PR #2081).** Needs the PR installed, AutoCAD 2027. Copy with a pipe drawn on 2027 plus two lines. MR, pick all three: one plain line naming the pipe and its layer, "Nothing was changed. Move the pipe and what it connects to with AutoCAD's MOVE and ROTATE instead.", nothing moves, no "eNotApplicable". MR, pick only the two lines: "Select objects" asked ONCE, they move and rotate, and afterwards nothing is left gripped. Grip the two lines first, then MR: no selection question. CR on two lines: after the copy the originals are not gripped (press Delete: nothing is erased). Also: a line on a locked layer, a hatch, a block in an Xref: each named in plain words.
26. **BUG-1316, CDWT by its window keeps the library tank (PR #2082; ENGINEERING FIGURE for Tim).** Needs the PR installed. (a) CDWT, choose a library tank in the window, place it; read the stored CE record: make, library name, size and trafficable lid are there (no window shows them; the lid is recorded only). (b) Settings "add make and size to the tank callout" ON on the copy (default OFF), place again: the callout shows make and size; put the switch back. (c) On a detained branch with a base level, CDTWL before and after placing a window tank: the tank is now COUNTED in the storage (Tim to confirm this figure change). (d) Typed 4000 L: litres only.
27. **BUG-1318, CDSOURCE never reuses a number (PR #2084).** Needs the PR installed. CDSOURCE ROOF DRAIN three times (1, 2, 3); erase ROOF DRAIN 3; CDSOURCE ROOF DRAIN: ROOF DRAIN 4. Known limit: a name with a digit or a sign in it does not get this fix.
28. **BUG-1320, CDTAG retag with No (PR #2085, review fix BUILDS AFTER 2:00pm).** Needs the PR installed. DP1 with its label; CDTAG to DP7, answer No: the retag is reported done and the label reads as DP7 does under the drawing's numbering. Again with Yes. With the label's layer locked and No: "the tag label for this source is on locked layer ... Nothing was changed." A source with no label and No: still no label. One U after each puts it back.
29. **BUG-1321, CDTAG retag keeps a source's connection point (PR #2086; CDFIXTAGS sister fix stacked on it).** Needs the PR installed. There is NO grip for this point (corrected after review). (a) On a test copy holding a source whose stored connection point is away from its insertion point (tagged by an older CE that asked for the point, a copy of one, or set up on the copy by the evidence lane): read the stored point, CDTAG it to a new tag, read it again: unchanged, and the pipe end still belongs to the source. (b) The same with CDFIXTAGS on two sources sharing a tag. (c) A source placed by today's CE: the point stays on the insertion point, as before.
30. **BUG-1358, CDRULES keeps only its newest runs (PR #2087).** Needs the PR installed. Run CDRULES seven times on a copy, then its saved-findings view: five recorded checks, newest first. Settings `checks.rulesRunsKept` 2, run once more: two kept.
31. **BUG-1346, CDFEEDBACK keeps a typed report (PR #2088).** Needs the PR installed, any copy. Make the feedback folder unwritable, CDFEEDBACK, type a title and text, Send report: the window stays open, the text is still there, the line reads "Not saved: CE could not write the file. Your report is still here; try Send report again." Put the folder right, Send report: the window closes and the command line says where it went.

### Trust plan step 5, the record update made visible (TRUST-05, DRAFT card) — 12 November 2026 (Built and unit-tested only; NOT installed; robot and Codex to run on COPIES)

PR 2045 (DRAFT, never merged by the run), branch `claude/trust-05-sync-visible`, stacked on step 1 (PR 2041). Settings: `trust.readOnlyToolsNeverUpdateRecord` (ON), `trust.sayWhatRecordUpdateChanged` (ON). The robot must read the stored record directly from a copy (not through any CE tool), or its own reading would run the update.

1. **Each read-only tool changes nothing:** on a Civil copy, read the stored record, run CDGRAPH, read it again. Right = identical, and no "save changes?" question on close. Repeat for CDDIAG, its window's Refresh, and CDDASHBOARD. (CEHEALTH is Manager's command and never touched Civil's record; nothing to test there.)
2. **Record behind the drawing:** add one polyline on the stormwater pipe layer, run CDGRAPH. Right = `CE: needs checking. 1 line on a pipe layer not in the CE record. Type CDCHECKCURRENT to see them.` and the record is still unchanged.
2a. **Added 13 Nov after the AutoCAD evidence run (fix `d0cf644c`): CDGRAPH counts the stored pipes.** Same copy as case 2 (one stray polyline on the stormwater pipe layer; record holds N pipes). Run CDGRAPH. Right = the summary line says N pipes (not N+1), and the next line says `[CDGRAPH] CE's record holds ... and N pipes. 1 line on a pipe layer is not in the record, so it is left out of this trace. Type CDCHECKCURRENT to see it.` Switch OFF: as the installed build (the line is added to the record, N+1, no extra line).
3. **Edit Pit on that copy:** Right = one line starting `CE updated its record (` with the command that was typed in the brackets, then `1 pipe added. Guessed, not read from the drawing: 1 pipe size (100), 1 pipe material.` and the record really gained exactly one pipe.
4. **Nothing to update:** run PIT's edit window twice in a row. Right = no "CE updated its record" line the second time.
5. **Erase a pit (leave its pipes drawn), then run PIT:** Right = the line counts `1 pit removed` and, for each pipe that ran to it, either `pipe end no longer joined` or the pipe `removed` and `added` again. Which of the two the update does is not settled from reading the code: the robot compares the line with the real difference in the stored record, number for number.
6. **Edit a pit's cover level text on the plan, then run a tool:** Right = `1 cover level changed from the drawing` (a level that was blank before reads `read from the drawing`; a CL line deleted from the text reads `cleared`).
6a. **Erase a pit by mistake and press U, then run a tool:** Right = no "Guessed" sentence when CE put the pipes' own sizes and materials back.
6b. **Pit Schedule, Relink:** Right = one line for the whole relink, including pipe ends it re-joined.
6c. **Take every "before" reading after one ordinary CE command** has run in the drawing, so a save CE already owed the drawing does not fail a case for a reason outside the tool.
7. **CDPROPAGATE, then Cancel:** Right = no "CE updated its record" line. Accept instead: the line appears once.
8. **CDRECOVERINVERTS on a copy with a pipe of no size:** Right = the pipe is not given 100 before the tool looks at its size.
9. **Both switches off:** every tool behaves exactly as on the installed build, and no line appears.
10. **Not provable by the robot alone:** the wording of the lines (one Codex look); whether any read-only tool now shows older information than before (Tim, on jobs he knows); what one U does after an update (probe P2).

### Trust plan step 1, the opening line (UX-OPEN-01) — 12 November 2026 (Built and unit-tested only; NOT installed; robot and Codex to run on COPIES)

PR 2041 (DRAFT, never merged by the run), branch `claude/trust-01-open-line`, cut from the installed Civil commit `cf059dcf`. Settings: `trust.sayDrawingStateOnOpen` (ON), `trust.openCheckMaxObjects` (50000, a DRAFT figure until probe P1 times the check).

1. **Civil job, all linked (copy):** open it. Right = one line `CE: N pits, N pipes, all linked.` and the numbers match the job. Close without editing: no "save changes?" question.
2. **Same job with one extra polyline on the stormwater pipe layer:** open it. Right = `CE: needs checking. 1 line on a pipe layer not in the CE record. Type CDCHECKCURRENT to see them.` and CDCHECKCURRENT lists the same one line ("Line on a pipe layer is not in the CE record").
3. **Old drawing with pit symbols and no CE record:** Right = `CE: N pit blocks found, no CE record. Nothing has been changed by this check. ...`
4. **Structural drawing, consultant drawing, blank drawing:** Right = no CE line at all.
5. **Read-only file:** the line still shows; nothing is written.
6. **A drawing whose pit blocks get updated on opening (older PIT BLOCK 2):** Right = a second line `CE: pit blocks were updated when this drawing opened.`
7. **U, then open another drawing, then back:** Redo still works in the first drawing.
8. **Size limit:** set `trust.openCheckMaxObjects` to 10 in `CD_Settings.json`, open a Civil job: `CE: large drawing, not checked on opening. Type CDCHECKCURRENT to check it.` Put it back after.
9. **Switch off:** `trust.sayDrawingStateOnOpen` = false: no line on any drawing and CDCHECKCURRENT is exactly as before.
10. **Broken twin (already proven without AutoCAD):** a deliberately broken copy of the check that writes is caught twice, by the changed-counter guard and by the compiled-plugin scan. In AutoCAD the equivalent check is case 1's "no save question" (DBMOD unchanged).
11. **Start AutoCAD by double-clicking a Civil test copy (review of PR 2041, finding 1):** Right = that first drawing gets its line too.
12. **A current job with an outlet pipe ending at the LPD, a pipe starting at a downpipe and one at a connection point (review finding 2):** Right = `all linked`; none of those ends is counted as not linked.
13. **Run cases 1 to 4 once with the Inspector showing and once with it hidden:** with it showing, opening may also print step 5's "CE updated its record" line.
14. **Not provable by the robot alone:** the look of the line (one Codex look, also on a large drawing); the counts on real old jobs (Tim, five jobs he knows and one messy one).

## TRUST step 0, the read-only reader and scorer (DRAFT, nothing calls it), draft PR 2040 — 12 Nov 2026

Built and unit-tested only (82 of 82 on net10 and net48). Branch `claude/trust-reader`, https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/2040. **Nothing to test in AutoCAD yet:** no command, window or button uses it. It becomes testable when the read-only copy of a real drawing is built (next item) and probe P3 runs it on the test-set copies. Then: read each copy twice, the readings must be identical and the copy unchanged; score against the answer sheet.

**Update 13 Nov 01:11 (second run):** the eight review fixes (3eb415c9), the read-only copy-filler (ab4fc1f7) and the old palette blocks (222a303e) are built; 155 of 155 unit tests on net10 and net48. The copy-filler now exists, so the AutoCAD check becomes possible (robot, lane trust-acad-evidence, on copies, without installing): (1) load the branch build in accoreconsole, open a made-up or labelled test copy read-only, call `TrustSnapshotFiller.Fill`, read twice; the two readings must be identical; (2) the drawing's DBMOD stays 0 and CE's stored record text is byte-identical before and after; (3) one old-palette copy with a "Stormwater Pit" must list it as a Proposed pit, not as unrecognised.

## Structural fixes BUG-1361, BUG-1435, BUG-1439/1442/1447 (DRAFT, built and unit-tested only), draft PRs 2071, 2072, 2074 — 13 Nov 2026

None of these faults has been seen in AutoCAD; test on a COPY (a made-up Structural drawing), AutoCAD 2027, a build that contains the branch (2072 is stacked on 2071, so test it with 2071).

1. **BUG-1361 (PR 2071), bracing table sync:** draw a flat brace (Enter at the angle) and ROTATE it 30 degrees; place a second brace. STRSCHEDCREATE, note each brace's length and angle with LIST, run STRSCHEDSYNC without editing. Right looks like: both braces identical to before. Then type a new length in one cell and sync: only that brace's length changes.
2. **BUG-1435 (PR 2072), B over A:** with an A brace in the table, type B over its row and run STRSCHEDSYNC. Right looks like: a plain line saying the type cannot be changed from the table and to use ABS; the brace still on layer A and plotting as A.
3. **BUG-1439 (PR 2074), locked layer:** lock a layer that holds text, run CLEAN. Right looks like: the text step completes and says how many objects on locked layers were left alone; nothing unlocked; no AutoCAD error word.
4. **BUG-1442 (PR 2074):** run CLEAN on a read-only copy and inside REFEDIT. Right looks like: one plain stop line and nothing purged or saved. Note: CLEAN does NOT stop on a layout tab (dropped 13 Nov after review; it still cleans and saves there). Test: on a layout tab CLEAN runs and saves as before. Question for Tim: should it be refused there?
5. **BUG-1447 (PR 2074):** save, then run CLEAN. Right looks like: after "saved", a line saying CE kept no copy from before, and what .bak file is or is not beside the drawing (named with its time, called AutoCAD's own).
6. **Not covered:** AutoCAD 2022 to 2026; a real pre-clean copy (not made, Tim's decision).

## Structural fixes BUG-1362, BUG-1363, BUG-1365 (DRAFT, built and unit-tested only), draft PRs 2068, 2070, 2069 — 13 Nov 2026

Each on its own branch from the installed Structural commit 8de95c34. None of the three faults has been seen in AutoCAD; test on a COPY (a made-up Structural drawing), AutoCAD 2027, a build that contains the branch, on a TEST Windows login for the one switch.

1. **BUG-1362 (PR 2068), the A-B bracing switch:** on the copy, make the BRACING block unavailable (rename it in the Block Editor; locking the layer does not show it). Place an older-named brace ("A - BRACING LEFT"), run ABS and pick it. Right looks like: the old brace is still there, unchanged, and the line says it was left as it was. Wrong: the brace has gone. Then with the BRACING block present: ABS converts it, and one U puts the older one back.
2. **BUG-1365 (PR 2069), beam layers:** lock the BEAM layer in the Layer command, run 1 and pick a beam. Right looks like: "Beam not placed: layer BEAM is locked. Nothing was drawn and nothing was changed ..." Wrong: "CE hit an internal problem". Repeat with BEAM frozen, BEAM LOWER switched off, BEAM's colour changed to 1, and for tools 2, 4 and 5. Nothing may be unlocked or changed by CE.
3. **BUG-1363 (PR 2070), support size:** add a member schedule row for DS1 with a timber pack ("2 No 90 x 45 F17 KDHW"). Switch OFF (default): run DS1, place a support. Right looks like: a line saying the block was drawn at 90 x 90 instead, and the block shows 90 x 90 in Properties, Visibility. Switch ON (`"stopWhenScheduleSizeCannotBeShown": true` under `Supports` in the TEST login's Structural settings file): run DS1 and pick a point. Right looks like: the stop line naming the size and the choices, and nothing placed. A size the block does have: no change either way.
4. **Not covered:** the same mark on two floors (BUG-501) and the rest of card TRUST-S3; AutoCAD 2022 to 2026.

## TRUST-S1 Structural core tab (DRAFT, switch OFF), draft PR 2054 — 13 Nov 2026

Built and unit-tested only. Branch `claude/trust-struc-s1-e13111`, https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/2054. Test on a COPY (a made-up Structural drawing), AutoCAD 2027, a build that contains this branch.

1. **Switch off (default):** start AutoCAD. Right looks like: the Structural tab "CE STRUC" with its seven panels, exactly as today.
2. **Switch on:** on a TEST Windows login (or with the Structural settings-folder override), never Tim's own login: close AutoCAD. In that login's Structural settings file add `"structuralCoreTab": true` under the `CommandHub` group. Start AutoCAD, wait a minute. Right looks like: one tab "CE Structural" with panels Roof, Floors, Bracing, Tools, in that order. 28 buttons: Roof has Rafter Marks and Purlin Marks; Floors has one Beam button (click its arrow: Beam, Lower beam, Special beam, Offset), then the beam, stud and column tools; Bracing has A bracing, B bracing, Switch A and B; Tools has Clean and save, Help, Settings, CE Blocks. The bracing truss, bracing panel and schedule buttons are NOT on the tab (held off on purpose).
3. **Press each button once** on the copy: each starts its own command. Right looks like: nothing says "Unknown command".
4. **Hidden commands:** type SDS, ABS, FASTSAVE, STRSCHEDCREATE, BT1. Right looks like: each still runs.
5. **Tooltips:** hover Rafter Marker, Column Marker, Clean and CE Settings. Right looks like: each ends with "Known fault: ..." in plain drafting words, and every button's name is the same as on today's tab (only the four beam types have words of their own).
6. **Way back:** remove the `structuralCoreTab` line (or set false) and restart. Right looks like: today's "CE STRUC" tab, complete.
7. **Look:** screenshot the tab at normal and narrow window width. Right looks like: no cut-off labels, every button has a picture, no software words.
8. **Not covered:** the shared-ribbon Structural tab, the pull-down menu on every AutoCAD year (not changed), AutoCAD 2022 to 2026.
9. **DRAFT defaults for Tim to confirm:** at the top of `Services/CeStrucCoreRibbonList.cs`.

## TRUST-03 office setup (DRAFT, switch OFF), draft PR 2043 — 12 Nov 2026

Built and unit-tested only. Branch `claude/trust-core-settings-e13111`, https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/2043. Behaviour only: the window, "Make this the office setup" and the first-start offer are not built, so most of this cannot be driven in AutoCAD yet. Settings file: the `options` group of `CD_Settings.json`, on a TEST Windows login, never Tim's own.

1. **Switch off (default):** start AutoCAD. Right looks like: nothing new in the CE log (no line starting "Office setup").
2. **Switch on, no values shipped:** add `"followOfficeSetup": true` under `options`, restart. Right looks like: one CE log line "Office setup: not known (this release carries no office values yet)". Settings file unchanged.
3. **Switch on, a test office file:** put a copy of `office-setup.json` with a few `values` (for example `{"pit":{"xWidth":450}}`) in the bundle's Assets\Config on the TEST login, restart. Right looks like: log line "Office setup: no, 1 value differs".
4. **Tim's PC:** with `"thisPcIsOfficeSource": true` the line reads "Office setup: this PC makes it" and nothing is ever changed.
5. **Settings are not frozen:** with the switch off, save the Settings window once on the TEST login. Right looks like: `followOfficeSetup` and `thisPcIsOfficeSource` do NOT appear in `CD_Settings.json`.
6. **Not covered:** applying, putting back, and the window need the built window; today the robot tests prove them on temporary files only, including that an ordinary settings save after Apply keeps the office values.

## TRUST-02 core ribbon (DRAFT, switch OFF), draft PR 2038 — 12 Nov 2026 (updated after the independent review)

Built and unit-tested only. Branch `claude/trust-core-ribbon-e13111`, draft pull request https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/2038. Test on a COPY, AutoCAD 2027, a build that contains this branch.

1. **Switch off (default):** start AutoCAD. Right looks like: one tab "CE" with nine panels, exactly as today, with today's tooltip words. No "CE Drainage" or "CE Design" tab.
2. **Switch on:** close AutoCAD. In the settings file (`CD_Settings.json`, the `options` group) add `"showCoreCivilTabs": true`. Start AutoCAD, wait about a minute. Right looks like: tab "CE Drainage" with panels New Job, Pits, Downpipes and tanks, Pipes, Check this drawing, Schedules, Help, in that order, then tab "CE Design" with Design, Network, Rules. 45 buttons in all. Floor Waste and Pit Schedule are NOT on the tabs (held off on purpose). Open a blank drawing and a Structural drawing: both tabs still show.
3. **Press each button once** in a Civil copy: each starts its own command. Right looks like: nothing says "Unknown command".
4. **Tooltips:** hover Pipe, Pit, Edit, Help, Tidy labels. Right looks like: the same plain words as today's CE tab; Front Overflow, Move + Rotate and Copy + Rotate end with "Known fault: ...".
5. **Pop-up tabs:** pick a pipe, a pit, a downpipe. Right looks like: the Pipe, Pit and Source tabs still appear.
6. **Hidden commands:** type CDRULES, CDCHECK, CDSURVEY, PITSCHEDULE, CDFW. Right looks like: each still runs.
7. **Way back:** set `"showCoreCivilTabs": false` (or remove the line) and restart. Right looks like: today's single "CE" tab, button for button, and no CE Drainage or CE Design. (`showClassicCeTabs` is a different, older three-tab layout kept for one release; leave it alone.)
8. **Look:** screenshot both tabs at normal and narrow window width. Right looks like: no cut-off labels, every button has a picture (Pipe System has none yet, Top Water Level, Downpipe Destinations, New Job and Renumber Pits show the generic wrench), no software words.
9. **AutoCAD 2025 and 2026 (if a PC is available):** right looks like: the same tabs without New Job (that command is 2027 only).
10. **Not covered:** AutoCAD 2022 to 2024 (menu file not changed), Manager's later rebuild keeping both tabs (check the tabs are still two after about a minute and after CEMANAGERREFRESH).
11. **DRAFT defaults for Tim to confirm:** listed in the draft PR and at the top of `Services/CeCvlCoreRibbonList.cs`.

## Curved paving, refusal and cancellation —15October2026

1. **Six checks: four PASS, two FAIL.** Native AutoCAD measures the rounded paving outline as22.283m²; CE reports16m²,28.197%low (newHIGHBUG643). The hatch follows the curve correctly. Correct-looking shading is not acceptance of the calculated area.
2. **Safe guards:** an open polyline is refused and reasked; cancelling leaves all54 original ordinary records and nine staged controls unchanged. After selectingP1, physicalEscape adds nothing; the message incorrectly says no pit was picked (existingBUG360). Outline selection used nativeAutoLISPentity arguments, P1/Enter/Escape actualUI.
3. **Safety/remainder:** originalninecontrols restored/readback, source/preferences unchanged, failure specimen saved locally and normally closed; exact ownlease released/other595session untouched. No curvedplacementUndoRedo/save-reopen/otherunits/overload/protection/plot/olderruntime proof. SetupHelp/invalidinput/deselect recovery excluded from producttests. UX-SURF-03 remains partialFAIL. BUG642 blue-text symptom cross-referenced to prior209; its additional overlap/base occlusion remains open.


## Native grated-pit catchment overlay — 15 October2026

1. **Tenchecks:8PASS/2FAIL:** actualtypedCDCATCHMENTNew,84m2rectangle/twoClassCpits→42m2each. OneUndo/delayed29.389secondRedo/HideShowpass. New641: onewholehatchdoesnotidentifyeachpitregion;new642:blueonblue/overlappingP1labelandwashed-outbaseinformation.
2. **Savedoutput:** all3overlayrecords/nineoriginalcontrols/layerpersistafterSave/normalclose/reopen. Layernonplot290=0readback;noactualplot. Whole56recordequalityfailsbecauseunrelatedoriginaldynamicblock7F3nameU13→U12;other55records equal,definitionequivalenceunproved,noproductfaultassigned. All53baselineordinaryrecords unchangedafterplacement.
3. **Context/remaining:** realAutoCAD2027/Civil3.0.49,mm/modelspace/WorldUCS. Newselectionviaactualcanvas;HideShowviaAutoLISPnativekeywordarguments. Originalninecontrols restored/sourceunchanged/ownwindowempty/exactlease released/old595untouched. Preferencefilebaseline notcaptured. Clear/deletionnotexecuted. Overload/capacitySettings/Cancel/irregulargeometry/otherunits/protection/plot/olderruntime remain;UX-SURF-03partialFAIL,whole50%UNKNOWN.


## Native revision-cloud regression — 15 October 2026

1. **Eight checks PASS:** actualRC at1:100/defaultNo and1:20/KeepOSNAPYes creates closed nativeCLOUD polylines. ImmediateoneUndo removes each cloud; untouched67.757/31.329secondRedo restores it. Original BUG215 now scoped Codex-accepted for Structural1.0.116/AutoCAD2027.
2. **Drawing/settings:** all155 original ordinary entity/Xdata printed records unchanged;12stagedcontrols equal after each completion. Original12restored; explicitSave/normalclose/reopen retains all157records/controls after onlysessionaddressnormalisation. Source/preferences intact, ownwindowempty/exactlease released, older595session untouched. Screens1324–1337/localrevcloudledger; printed precision, no fullUndo-record equality claim.
3. **V3 limits:** ST09 historicalcandidate does not specify manualRC; no wholecard acceptance. UX-REG-03 CE-proposed clouds/triangles remains unproven. Cancel/repeat/protection/otherunits/scales/UCS/paper/plot/olderruntime remain. No code/deploy.


## Codex native dimension editing follow-through,15 October2026

1. **Narrow Codex-accepted:**reopened native arc/circle dimensions follow a500mm source-only MOVE;oneUndo/delayedRedo works visually. DiameterlateEscape preserves objects; Lengthwholecircle refusal is clear and state-preserving. Fivechecks4PASS1FAIL.
2. **Retest after repair:**621DiameterlateEscape must restore previousstyle plusallothercontrols; existing640geometry-first andotherannotationbugs stayOPEN. Working native associativity must be retained. No repair installed.
3. **Remaining:**radius/angle/grip/rotation edits, moved-state persistence, broken/protectedgeometry, otherunits/scales/UCS/paper/plot/olderruntime. NextprimaryLevelMark/RC andremainingbuiltworkflows; no wholefamilyacceptance. Source/prefs unchanged, controlsrestored, trialdiscarded/lease released.634checks,whole50%UNKNOWN.

## Codex RD Length/Diameter follow-through,15October2026

1. **Narrow Codex-accepted:**installed Structural1.0.116/f180,actualRD Length1571mm/Diameter2000mm previews/output, LengthlaterEscape preserves entities, eachoneUndo/delayedRedo,andactualsave/close/reopen readback. Ninechecks7PASS2FAIL; no wholeST03acceptance.
2. **Retest after repair:**621lateEscape must restore Standard andallpriorcontrols;640mustselectgeometry beforeofferingtype, as approvedST3-5. Keep working native output/rememberedtype; repeat recovery/persistence. No repair installed.
3. **Continue autonomously:**DiameterlaterEscape, unsupported/broken geometry, source editing/association/grips, protectedcontent, units/scales/UCS/paper/plots/olderruntime remain. Originalcontrols/prefs/source preserved; ownedcopyclosed/exactlease released.629totalchecks/51ledgers,whole50%UNKNOWN.

## Codex existing-level fall/review follow-up,14October2026

1. **Narrow Codex-accepted:** Civil3.0.49+48662ddd,SpotLevelribbonicon,automaticP21.500read,Move/Accept/levelEscape,defaultEnter/tworepeat,oneUndo/delayedRedoandallsavedgeometryretained. WarmCDCHECKflagswrongnorth1:80whilecorrectsouthsuggestionsunflagged. Receipts213-218/screens523-545.
2. **Retest after repair:**588actualsavedlistmustincludevisibleP2awaywarning;589CDCHECKfirstafterreopenmustdetectitwithoutanotherCEcommand. Rawhandles/IDsremain360. Claude-ownedconcretesource/guardpacketsinbugregister;nochatdispatch/install. Remainingprotection/equal-missingcovers/nopits/metres/UCS/rotation/plot/2024.
3. **Safety/coverage:**18narrowassertions16PASS2FAIL;settingsunchanged/controlsrestored/copyclosed/ownlease released,weekly35%. No whole-IDcredit;50%targetactive.

## Codex suggested-fall follow-up,14October2026

1. **Narrow Codex-accepted:** Civil3.0.49+48662ddd, explicitlevel missing/belowcover skips, clickedSkip/Move/Accept, move recalculatesP1/1:9.2 toP2/1:5.3, Enterfinish, oneUndo/delayedRedo and save/reopen. Receipts207-212/screens504-522.
2. **Remaining:** existingCDSLprefixedlevelautomaticread, awayarrowflag, MoveEscape/levelCancel, multipleacceptsoneUndo, equal/missingcovers/nogratedpit, protectedlayers/Xref/REFEDIT, metres/UCS/edit/plot/2024. UX-SURF-02partial; no whole-ID coveragecredit. No newbug/code/install.
3. **Cleanup:** copyclosed, controlsrestored/all3settingsunchanged/ownlease released;14narrowassertions14PASS,weekly34%. Overall50%targetunfinished.

## Codex spot-level/manual-fall follow-up,14October2026

1. **NarrowCodex-accepted:** Civil3.0.49+48662ddd, CDSL explicitP18.600/blankplaceholder, early/lateEscape/repeat/oneUndo/delayedRedo; CDFALL threeEscape stages/blank-zero reask/east1:80/oneUndo-delayedRedo. Save/close/reopen retains bothspot symbols andfall. Receipts201-206/screens480-503.
2. **Remaining:** SpotLevelribbon route inconclusive; repeat actualicon/button. Linked-survey existing-level display and remaining suggested-fall variants, other bearings/UCS/units/protectedlayers/REFEDIT, words/negative/decimalratios, spotinvalidinput/edit/grips/plot/2024 remain. No wholeUX-SURV-03/UX-SURF-02 acceptance or50%credit.
3. **Safety:** ownedcopyclosed,controlsrestored/all3settings unchanged/ownlease released.18narrowassertions17PASS/1UNPROVEN;weekly34%. No newbug/code/deploy/provider/reset.

## Codex existing Pit Schedule follow-up,14October2026

0. **Regression draft only:**1256/commitb56b2250 onexactCivil48662ddd,9checks6PASS/3FAIL. DeliberatelyRED/doNOTmergealone; no runtimefix/install. PendingFilters881/641/618 andData1192 need coordinatedrepair. Candidate stillneeds actualtyped-note/Stop/Update/recovery/diskreplay afterrepair,plus586regressiongreen. Receipts199-200.

1. **NarrowCodex-accepted:** installedCivil3.0.49+48662ddd, complete single custom-note paste/Stop overriding/Update writes note in the existingtwo-row table and retains it aftersavedrawing/reopen. Receipts193-198/screens457-479. Ordinary typing and finishedlayout are not accepted.
2. **OPENfailures/retest:**586normaltypinglosesnote,587drawnremarks crossrowborders,573stale/precisiondifferences,256delayedRedoNothingtoredo. Firstrepeat exactnativecharactersequence and savedtwo-rowlayout afterrepairs; preserveengineeringwarnings. Windows586ownershipaudit next; Claudeoutput/recovery packetsrecorded, nochatdispatch.
3. **Remaining:** newplacement/pointCancel, multi-inlet/longnotes, protectedobjects, plotPDF, metres,2024 andfullUXmapping. Controlsrestored/all3settingsunchanged/owncopyclosed/lease released. Weekly33%;50%targetunfinished.

## Codex plan-level / framing entry follow-up,14October2026,12:46Melbourne

1. **NarrowCodex-accepted:** installedStructural1.0.116+f180b349, CSPLANLEVELinitialUnknown/Enterkeep, numberedGround,customLoft1,oneUndoactualrecordreadback,controlleddelayedRedoGround,explicitUnknownclear,numericcustomname9,Escapekeep,and9savedrawing/reopen/Enterkeep. Receipts179-183/screens410-431;no wholeUX-LEVEL-01acceptance.
2. **Outstanding:** BUG360falsenever-setwordingafterclear. CEpanelleveldisplay/title/scheduleconsumers,template/SaveAscopyconfirmation,read-only/REFEDIT,otherunits/olderversionsremain. CSFRAMINGLEGEND/CSLEVELCARRYhonestlydiscloseOFF; actualoutput/update/protectionstillBLOCKED,nomachinefeatureflagchanged.
3. **Cleanup/coverage:** ownedfixtureclosed,controlsrestored,all3settingsunchanged,owncontrollease released.16narrowcases13PASS/1FAIL/2BLOCKED,includingoffdisclosure/cleanup;weekly31%. Overallunique-IDrecount/50%targetstillunfinished.


## Codex connected schedule end-write follow-up,14October2026,12:15 Melbourne

1. **Narrow Codex-accepted:** installedCivil3.0.49+48662ddd; PITSCHEDULE P2 inlet19.800->19.750/Enter/Stop overriding changes actual downstream only, preserves upstream20.00 and survives savedrawing/reopen inplan andschedule. ApprovedINT046/BUG351b route, receipts172-175/screens390-409. No wholeBUG351 acceptance.
2. **Recovery failure remains:** one nativeUndo restores19.80, controlled delayedRedo reportsNothingtoredo withautosave0 andnointerveningdrawingaction. Added to existingBUG256; re-test schedule write, diameter edit andflatplacementafterrepair.
3. **Remainder:** typedC2rename, unconnectedend oldrecord, ARRAY, window-internalUndo, protectedobjects, placed-schedule update/plot andallother schedulevariants remain. Redgrade-warning text crossespipe: readability observation, noengineeringrulechange. Ownedcopyclosed,controllease released, controls/restored andall3settingsunchanged. Weekly30%; overall50%recount unfinished.

## Codex V3 / UX verification, 13 October 2026 — narrow passes and remaining work

1. **Evidence:** areas/release-v3-colleagues-CODEX_V3UX_VERIFICATION_2026-10-13.md records exact source, test totals, failures and local screenshot receipts. This batch does not supersede the older checklists or accept untested workflows.
2. **Codex-accepted on installed Civil 3.0.49:** New Pit -> Inspect Drawing -> Escape cancels without reopening; Inspector -> Open Edit Pit -> Inspect Drawing -> Escape does the same. Pit Schedule dark 1080p fits with footer visible; searching P8 honestly shows 2 listed / 30 output rows. 14 Oct follow-up: new linked schedule placement, in-place update, placement Escape return, Excel all-row export, connected pipe/pit Undo/Redo and pipe save/reopen were exercised as recorded below. Enter-return from Inspect Drawing and PP remain untested; no wholesale schedule acceptance. BUG-360 raw Handle wording was still visible.
3. **Test-tool drafts:** #1253 restores installer test discovery with an optional explicit Git executable; #1254 repairs exact Structural version/output proof inputs, constructor-forwarding guards and test screenshot isolation. Neither merged or installed. Independent review remains, including required Opus review of the constructor guard. No new AutoCAD test is needed solely for these test-tool changes; the production behaviours they assess remain separately pending.
4. **Candidate UI, not accepted:** no-blue #1043 has 21 targeted checks passing and a freshly inspected compiled light calculation view; stacked Settings #1252 has 221 checks passing but no visual candidate inspection. After an authorised coordinated install, open CDS and visit every page in Light and Dark; confirm labels, units, bounds, keyboard/Cancel and staged values, then read saved values from an isolated test profile. Open Calculations -> Print -> Sections and export, verify grey/black styling, preview and inspect actual output. Do not save over Tim's live settings for this acceptance batch.
5. **Open blockers:** BUG-307 drainage historical calculation mismatch; BUG-478 installer contracts (36 failures); BUG-568 structural proof-harness stall. The aborted Structural run is not a pass. Remaining AutoCAD workflows, drawing output and older releases stay unproven; consolidate them by related workflow cards rather than sending Tim the historical backlog.


## Codex real AutoCAD follow-up, 14 October 2026, 05:06 onward

1. **Narrow accepted routes, installed Civil 3.0.49:** CDS cover search and Cancel of two staged values; detached grated-pit placement/one U/REDO; new connected P1/P2 pipe creation with typed levels and calculated-grade warning, one U/REDO, editor Cancel and pipe save/reopen; two-row schedule readback, placement Escape retry, actual linked placement and in-place update. Genuine pit cover edit updates plan and schedule immediately, with one U/REDO. Exact evidence in the verification/report files, entries63-79. These do not accept all cases within each named workflow.
2. **Confirmed outstanding:** BUG570 stale/clipped pit preview; BUG571 native Excel output defects; BUG572 Inspector type and first-selection loading; BUG573 equivalent precision shown as a change; BUG574 derived pit bottom readback. Existing BUG213 older unlinked schedule has no replacement action. BUG207 partial pass on cover-only live update; movement/open-end routes remain.
3. **Still to exercise:** other pipe types, batch editing, protected layers/foreign content, drawing-switch recovery, schedule row overrides/source/system selection, layouts/plotting, Manager and Structural groups, engineering-intent cases. Account weekly usage17% at05:49; preserve10% reserve. Overall latest-verdict case mapping and 50% tally still incomplete.
## Codex Structural real AutoCAD follow-up, 14 October 2026, 07:24 Melbourne

1. **Exercised narrowly, installed1.0.116+f180b349:** Settings23-page layout and timer Escape discard; C1 placement/mark/one U/REDO/rotation Escape; DS fallback/recovery, DS1 label, TS1 label-side Escape; SC2 conversion/recovery, SC1 locked-body refusal; support save/reopen; mm Regular beam preview/Accept/recovery; Lower duplicate-support refusal/preview Cancel; FST staging Cancel and library Save/readback; FPFC outline/recovery; FEDIT Cancel/Apply and immediate actual-schedule update. Receipts81-99 and local screenshots65-153. No full-workflow or engineering approval.
2. **Outstanding confirmed:** BUG575 installed-version display; BUG576 ninth-choice wording; BUG577 unitless beam refusal wording; BUG578 accepted full-mark library key unused by placement; BUG579 entered pad depth omitted immediately, isolated with PF2 before Undo. Existing BUG454 tiny pad label and BUG517 blue styling remain. PF1 depth re-entry via FEDIT works as a workaround, not a fix.
3. **Remainder:** Structural grips/linking/bracing/roof/floor/wind, TS1 completion, Lower acceptance, footing deletion/strip/system/protection/persistence, all themes/Save/bounds and output publishing; Civil batch/move/copy/free-end/protected-object/import/calculation/plot routes; Manager. Weekly account20% at07:24; overall50% recount and unique-case mapping remain incomplete. Opening23 pages never becomes23 whole cases.
## Codex Manager, footing and transform follow-up, 14 October 2026, 08:12 Melbourne

1. **Codex-accepted narrowly:** straight FSF draw/Undo/Redo; FDELETE default No and explicit whole-system Yes/recovery; Structural geometry/library/three-mark schedule disk persistence; Manager module-version agreement/search/no-results/clear; General preview/Discard and unsaved Close/Stay/Discard with three settings files unchanged; plain-object MR move/rotation/Undo/Redo/late Escape and locked-layer refusal. Receipts100-114 and local screenshots154-216. Existing BUG219 passes module versions only; BUG221 Status layout still fails.
2. **Failures:** new BUG580 Light header contrast and BUG581 Help Start tool; existing BUG221/222/360 reconfirmed. BUG579 missing initial pad/strip depth, BUG578 unused full-mark library key, BUG454 tiny labels and BUG517 styling remain. Saved known/Unknown schedule states match; persistence does not fix missing initial values.
3. **Remaining:** CE-object and mixed transforms, Xref/REFEDIT, grips/linking, other footing systems/buckets, curved strips, individual deletion, Manager theme Apply/restart, updates/blocks/transfer/offline, all Help routes, Civil and engineering cases listed above. Prior 07:24 strip/deletion/persistence/Manager remainder is superseded only by these narrow routes. Overall unique-case mapping and50% target remain incomplete.
4. **Cleanup verified:** autosave5, snaps5375, owned layer locks0; only empty AutoCAD remains and shared control released08:10. Three settings files unchanged. Weekly account22%; preserve10% reserve. Continue documentation/coverage work without controlling AutoCAD during protected hours.
## M-SET-01 Move My Settings (Manager) - BUILT as draft PRs #424 (tool) and #425 (button + packaging), Opus fixes in progress, NOT merged, NOT installed (30 Sep 2026 11:55): TIM'S AUTOCAD CHECKLIST (or a special Codex brief: AutoCAD must close itself and a second PC is needed)

The steps are in `C:\CE_PLAN\CHAT_PROMPT_MANAGER_SETTINGS_TRANSFER_01.md` ("Test steps for Tim or Codex in AutoCAD", six steps): Save my settings with an unsaved drawing (asked to save first; close message; AutoCAD closes; the tool waits, saves a package to the OneDrive CE folder, Start AutoCAD reopens on the same profile); Cancel at the save question and at the close message (nothing happens); Load my settings on a second PC (newest package preselected, backup line, VERIFICATION PASSED, no false MenuFile warning, autosave folder created if missing, ribbon/TOOLPALETTES/PLOT present); Undo last settings move; the same on 2022-2024 and 2025-2026; double-clicking the exe alone opens as today. "Assumed, Tim to confirm": the OneDrive folder name for packages; whether staff see the button or only admins. Not for Codex to accept: only Tim accepts.

## CODEX RESULTS 30 Sep 2026 - pass 18 and sweep C1, on the INSTALLED build (Civil 3.0.15+a6e0cc87, Manager 1.1.15, Structural 1.0.86+532f9550)

*Filed 30 Sep 2026 by the triage step. Word check (RULES 4): these were **built and installed**, and **tested by Codex in AutoCAD on Tim's PC, on copies**. A PASS below is **Codex-accepted** only for the exact scope written; nothing here is Tim-accepted, and engineering values still need Tim's word.*

1. **Pass 18 (00:02 to 05:57, 30 Sep).** 103 checks: **PASS 47 / FAIL 18 / BLOCKED 21 / NOT TESTED 17.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md`; results `P18_results.json`; screenshots `P18_screenshots\`; logs `P18_logs_start\` and `P18_logs_end\` (same folder). No DWG saved, no settings edits, copies only. Weekly meter 56% at start.
2. **Sweep C1 FINAL (started 06:01, stopped ~08:00-08:12 for crash recovery; report complete 08:10).** **In scope 631, tested 22, not tested 609. PASS 11 / FAIL 11 / BLOCKED 5 / NOT TESTED 604.** (The 631 is a discovered minimum, not the full unknown total; the 604 NOT TESTED are not passes, reason TIME almost throughout; the 5 BLOCKED are counted inside the 609.) **AutoCAD CRASHED at ~07:55** closing a saved drawing copy (BUG-224, blocker, not reproduced). Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md`; evidence and 207 screenshots in `SWEEPC1\` and `SWEEPC1\screens\`. UX verdict: "Not ready for a colleague: the save/close crash and unreliable recovery need resolving; this sweep remains incomplete."
   1. **Sweep C2 (`CODEX_SWEEPC2_2026-09-30.md`): 0 tested.** AutoCAD was never launched (the run began at 08:12, three minutes before the 08:15 stop, and the inventory step was not finished). Known typed commands in scope 43: PASS 0 / FAIL 0 / BLOCKED 0 / NOT TESTED 43 (reason TIME); grand total Unknown; no UX finding, no log copies, CPROFILE and OSMODE not read (Unknown). Four DWG copies were prepared in `SWEEPC2\` and left unopened; resume at STEP 0 per `SWEEPC2\NEXT_START.txt`. It tested nothing, so it clears nothing.
3. **Where every FAIL and BLOCKED went** (bug file = `C:\CE_PLAN\BUG_CARPARK.md`; UX reading list = `areas\release-v3-colleagues-UX_FINDINGS_2026-09-30.md`).
   1. **Pass 18 FAIL (18):** PROFILE_CHECK_END OSMODE 0 = BUG-206 (new). Q2(a) COPY replacement unlinked = BUG-210 (new). Q2(c), BUG-192 PIT, BUG-192 grip, P3 five U/two REDO, #384 CD/U/REDO = BUG-192 (known, still failing). Q3 place schedule on legacy pit = BUG-212 (new). Q3 fresh schedule automatic update = BUG-207 (new, needs Tim on UX-LIVE-01). P12 erase linked column = BUG-211 (new). R5 Enter to finish = BUG-216 (new). R5 CDCATCHMENT area = BUG-209 (new). R6 visible PD tag = BUG-217 (new). R8 CSBRACINGPANEL = BUG-218 (new). RC one U = BUG-215 (new, related BUG-169). #384 diameter-only = BUG-198 (known, still failing on 3.0.15). #384 upstream-only open ends = BUG-199 (known, partly). #384 direction = BUG-205 (new).
   2. **Pass 18 BLOCKED (21):** Q2(b) and Q6 part 1 = BUG-208 (new, the pipe-end record guard). Q3 five existing-schedule edits = BUG-213 (new). B3/BUG-176 = BUG-176 line (known). BUG-098, BUG-099, B4/BUG-158 = lines on those bugs (fixtures not reachable). Q1 examined/written counters = line on BUG-189 (log lines absent). **Fixture or brief only, no bug filed:** P2 full quick-edit (PITEDIT picks rejected on overlapping objects, see UX file 25; old schedule blocked), P8 DDEDIT (brief should say TEXTEDIT), P12 Job Time (test copy has Unknown job, timer 0m00s), P13 x2 (installed Structural removed timed saves, UX-STD-03: rewrite the check), R4 spoon-drain outlet (Inspector says not a CE object), R5 CDCHECK FALL classification (no FALL entry in report), R7 lid Surface/Use (automation could not drive the nested list), R9 actual footing (no footing in the copy), R10 actual soil report (no job-folder report), R10 wind suggestion (region table empty, see UX file 57), B1 moving/rotating preview (tool cannot hover), N2 council values (no council set).
   3. **Sweep C1 FAIL (11, final):** Cold start 1 (launcher opened unasked, DBMOD 1 after open) = BUG-220 and BUG-214. CEFIND = BUG-214. CDDISCIPLINE Redo lost = BUG-192 (known; evidence line added: the same U-then-REDO fault on an empty drawing, with the CE write-after-U named in the log). Manager three-version agreement = BUG-219. CEMANAGER Status overlap = BUG-221. CEMANAGER Settings/Civil scroll = BUG-222. Civil switch tooltip wrong = BUG-226 (new). Settings tooltip wrong = BUG-227 (new). Diagnostics tooltip / CDDIAG placeholder = BUG-228 (new). Pit tab Close button = BUG-225 (new). Save-and-close COPY / AutoCAD crash = **BUG-224 (new, blocker)**. Also filed from the observations: BUG-229 CDMANAGER duplicate Draw Order rows (not a Codex FAIL).
   4. **Sweep C1 BLOCKED (5, final):** Structural startup BUG-203 = line on BUG-203 (wrong fixture, copy is Civil). CEASK, CDASK, CEASK six questions = AI disconnected and no Send allowed by the brief (no bug; UX file 40). PROFILE_CHECK_END = the original session ended in the crash before the final read (part of BUG-224; a separate fresh session read Tim / 21759).
4. **Codex-accepted, pass18 30 Sep** (exact steps in the report's journal AND a screenshot in `P18_screenshots\`, scope as stated):
   1. **BUG-193 Pit Schedule SIZE, ordinary pit 450 x 450 to 1200 x 900:** cell kept, drawn pit resized, Edit Pit agrees (`N384_size_record.png`). Not the P6 900 x 900 case. Carpark status left for the controller to move.
   2. **#383 (PR #383) CD remembers 225 UPVC Stormwater; a detention pipe is not remembered:** `N383_remember225.png`, `N383_after_detention225.png`.
   3. **#384 typed levels 18 and 17.8 both "Staff entered"; connected-pit route calculated 19.47 "Calculated from grade":** `N384_typed_staff_entered.png`, `Q3_pipe_fixture_calculated.png`. The open-ends route still fails (BUG-199).
   4. **B2 custom "1 in 100" survives Detention, Existing, Stormwater:** `B2_return_stormwater.png`.
   5. **Speed (BUG-189 evidence):** first-command 20-point spline 26.7 ms, zero pipe updates (`Q1_spline.png`); network pit grip 644 ms with six pipes following (`Q1_P3_moved.png`); final spline and pan responsive (`P14_spline20.png`, `P2_spline20.png`). Not a promise of sub-50 ms; several moves are 250-650 ms.
   6. **Pit editing and legacy pipes:** P5 legacy MLINE draw order (`P5_legacy_after.png`), P7 double-click from outline, label and both invert labels plus STRETCH (`P7_STRETCH.png`), P10 two drawings keep their own edits (`P10_A_retained.png`).
   7. **Schedule:** fresh pit and fresh linked schedule place (`Q3_fresh_schedule_placed.png`); new pit at a pipe end updates the schedule FROM (`Q3_FROM_P2_updated.png`); manual "Update existing schedule" updates the drawn rows (`Q3_manual_update_drawn.png`). Automatic update fails (BUG-207).
   8. **Civil surface drainage / paving (likely #304, #305, #312):** CDRENUMBER preview and default No (`R1_preview.png`); CDPAVE placement and Escape (`R3_concrete_placed.png`, `R3_cancel.png`); CDKERB and CDSPOONDRAIN Escape (`R4_kerb_cancel.png`, `R4_spoon_cancel.png`); CDFALLSUGGEST placement only (`R5_fall_suggestion.png`); CDCHECK completes (`R5_CDCHECK_complete.png`); CDCATCHMENT Hide, Show, Clear (`R5_catchment_Hide.png`, `R5_catchment_Show.png`, `R5_catchment_Clear.png`); CDPERIMETER grade and preview (`R6_grade_preview.png`) and exclusion from the ordinary schedule (`R6_PD1_not_in_schedule.png`); CEBLOCKS Civil PIT LABEL placed and editable (`B1_attribute_T18.png`). The catchment area and PD tag do not pass (BUG-209, BUG-217).
   9. **Structural:** CSTIEDOWN placement incl. rotated UCS (`R8_rotated_UCS_placed.png`); tie-down type list does not double (`R8_types_after_settings.png`, command list only); CSLOADPATH no-footing guard (`R9_no_footings.png`); CSSOILREPORT missing-report guard (`R10_no_soil_report.png`); CSWINDCLASS topography wording (`R10_topography.png`); column COPY/MOVE, ROTATE, SCALE with beam and label following and one U (`R11_copy_move_300.png`, `R11_rotate45.png`, `R11_scale2.png`).
   10. **RC (BUG-169), all except one U:** `RC_100_arc450.png`, `RC_20_cloud.png`, `RC_paper_arc4p5.png`, `RC_viewport_arc90.png`, `RC_layer_colour12.png`, `RC_Enter_repeat.png`, `RC_OSMODE_restored.png`, `RC_cancel.png`.
   11. **Installed-version gate:** DLL product versions read before launch (a file read, no screenshot): Civil 3.0.15, Manager 1.1.15, Structural 1.0.86.
5. **NOT TESTED (no evidence) in pass 18:** P1, P4, P6, P9, Q4, Q5, B5, N1 (already passed in pass 17, not repeated); P11, R2, Q6 part 2, Q7 (skipped by request); R12/BUG-180 (Home and Annotate tabs absent); R1 apply/Undo and already-in-order; R3 existing Xref outline; RC older-drawing comparison. **BUG-195, BUG-196, BUG-197, BUG-200, BUG-203, BUG-204** were not tested in pass 18 (BUG-200 only hinted, see its carpark line).
6. **Sweep C1 Codex-accepted, final (11 PASS, scope tiny; each has steps in the report AND a screenshot):** no-drawing start reaches an empty workspace (`cold2-no-drawing.png`); Explorer double-click open (`cold1-dwg-s-civil-ribbon.png`); File > Open (`cold2-civil-ribbon.png`); blank-copy startup usable, 0 objects, DBMOD 0 (`blank-copy-zero-model-objects.png`); CPROFILE Tim / OSMODE 21759 at the start (`profile-start-cprofile.png`); CDS Cancel discards staged Light and -1 mm cover with the settings file hash unchanged (`cds-cover-negative-unsaved.png`, `cds-cover-reverted.png`); Alias editor Cancel after empty / clashing / 200-character names, hash unchanged (`aliases-native-clash.png`, `aliases-200-name-validation.png`); Start Here to Help Centre in two clicks (`start-here-minimum-reading.png`, `help-centre-home.png`); Help task guide picture enlarge/Escape (`help-task-enlarged-picture.png`); one CE pipe selected shows the Pipe tab and Escape clears it, 1,280 objects unchanged (`context-pipe-selected.png`, `context-pipe-escape.png`); typed CDCLOSETAB clears the selected Pipe tab (`context-cdclosetab.png`). Everything else in the sweep is **NOT TESTED**. Engineering values read in CDS / CDPARTS / CDRULEBOOK are reported, never accepted (they need Tim's word).
7. **Suggested fix queue, most important first (lane in brackets):** **BUG-224 the save/close crash (lane unknown: someone with a debugger opens the dump first, then repeat the sequence with Civil and Structural unloaded)**; BUG-192 U/REDO (Civil); BUG-205 uphill direction choice (Civil); BUG-206 OSMODE 0 (cause unknown: Structural RC first suspect, Civil second); BUG-207 stale drawn schedule (Civil, Tim to decide against UX-LIVE-01 first); BUG-198 and BUG-199 re-open (Civil); BUG-208 pipe-end record guard (Civil). Then BUG-209, 210, 211 (Structural), 212, 213, 214 to 222, then 225 to 229.
8. **Things Codex touched that Tim should know (as reported, all on copies):** OSMODE ended 0 and Codex typed 21759 back into Tim's AutoCAD (pass 18, BUG-206); DIMSCALE set 1 to 100 to 20 and the test drawing's UCS set to Z45 then World in the DWG-S_P18 copy, not saved. **Sweep C1 (final, as reported):** CPROFILE Tim / OSMODE 21759 at the start and again in a fresh recovery session at 07:58 / 07:59 (the original session's end values are Unknown, it crashed); FILEDIA was already 0 ("no setting changed"); `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` SHA256 FD5DE8D6679CB224CFC161DB4339FD6958A613F3AB01D4FDF7E2A484C5B02247 and `parts_catalogue.json` SHA256 3DA3A8DE859CFA25F4D68A13A7D1D91DDFD5611B1F3B12604FC7F3BE6F1D7ED0 (file last written 15 Sep) both match their values from before the Cancel tests; "No code, bundle, template, settings file or alias file edited"; no Settings Save/Apply/OK, no Send, no debug mode, no install. Codex staged edits in CDS, CDPARTS, Label Styles and Aliases and cancelled every one. It **copied the office Civil A1 template** to `SWEEPC1\Blank_SWEEPC1.dwg` (the template itself untouched), made synthetic copies (Blank, CleanBlank, Heavy 5,100 lines, Discipline_SWEEPC1, DWG-A/B/C/S), and copied privacy-filtered CE log files into `SWEEPC1\logs_start` and `logs_end` (identifying lines suppressed; not byte-for-byte). Two PASTECLIP prompts were cancelled (DBMOD 0 afterwards) and one misdirected viewport command was refused in Model. After the crash, other open test copies lost their unsaved test changes (copies only). The AutoCAD crash dialog: Send Report NOT clicked. AutoCAD keeps its own recent/recovery state, which Codex says it did not touch. **Not opened by me:** the crash dump `C:\Users\TimothyBrand\AppData\Local\CrashDumps\acad.exe.4120.dmp` (90.8 MB, 07:55, holds AutoCAD memory; keep it out of any repo).

## UX-PIPE-06c / batch pipe grade "Carry downstream", plus a length-mismatch fix (26 September 2026, code review ready)

1. **Candidate:** [PR #244](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/244), branch `claude/ux-grade-several` (tip `c1f46306`). Fixed a real preview-vs-Apply disagreement on any curved pipe (the preview now uses the same straight-vertex length Apply always used), added the pit name to the preview line, cached `ImpactLines` (was reopening one AutoCAD transaction per pipe per read), and built Tim's UX-PIPE-06c ruling. 51/51 focused; full Civil suite 11,157/6/19 (6 known baseline, unchanged); 3 lanes 0 errors. **Not installed, not opened in AutoCAD.**
2. **After an authorised install:** select 3-4 same-type gravity pipes in a run with at least one pit that splits into two downstream pipes. Run CDEDIT, tick **Design grade**, type a value, choose **Carry downstream**. **Expected:** the impact band lists the direct pipe(s), then the cascade's own lines, then a line naming the splitting pit and both its downstream pipes where it stops — nothing past that point moves. Repeat on a straight run with no splits: every pipe down to the end should re-grade, preview, and write together under one `U`.
3. **Also check:** any pipe with a curved (bulge) segment — the previewed invert must exactly match what Apply actually writes (this is the bug that was fixed).

## UX-REP-01 / CDSYNC and CDREBUILD warn honestly, without claiming to save the drawing (26 September 2026, code review ready)

1. **Candidate:** [PR #240](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/240), branch `claude/ux-repair` (tip `803424a3`). CDREBUILD's opening and closing lines used to say "save" — it never saves the drawing, only writes CE's own record into the drawing's Named Object Dictionary (UX-STD-03, "Never, you save"). Both lines reworded; "One U undoes it" kept, checked against this repo's own T4-UNDO-PROOF headless evidence, not assumed. Focused 7/7; 3 lanes 0 errors. **Not installed, not opened in AutoCAD.**
2. **After an authorised install:** type `CDREBUILD` in a Civil drawing. **Expected:** the first line says CE will rebuild its stored pit/pipe data and write it inside the drawing, and says plainly it does **not** save the drawing — never "save it immediately". The closing line should likewise say the drawing itself was not saved. Confirm one `U` after CDREBUILD restores everything it changed together.

## UX-WORD-03 / Feedback: never create the office folder itself; one honest result line (26 September 2026, code review ready)

1. **Candidate:** [PR #239](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/239), branch `claude/ux-words` (tip `2f020d38`). `FeedbackService` used to silently create "Creative Engineering - IT Admin" itself on a PC without the office share, then report success. Fixed: only writes into that folder when the office's own sync already put it there. CDFEEDBACK's command line no longer prints "Email this file... or Tim will collect it remotely" unconditionally — only when the file genuinely stayed local. 30/30 focused; 3 lanes 0 errors. **Not installed, not opened in AutoCAD.**
2. **After an authorised install, on a PC WITHOUT the office OneDrive share (most colleague machines):** run CDFEEDBACK, submit one. **Expected:** "Saved on this PC only: the office folder wasn't reachable. Email this file to tim@creativeeng.com.au so Tim gets it." and no "Creative Engineering - IT Admin" folder appears anywhere on that PC afterwards. **On a PC that DOES have the share:** the message should say only "Sent to the office feedback folder." with no email instruction, and the file should land in `...\Creative Engineering - IT Admin\CE Diagnostics\feedback\`.

## CR-D1b/c / council profile source sweep (26 September 2026, code review ready)

1. **Candidate:** [PR #259](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/259), ready for review on codex/cr-d1-council-sweep at 8d1538ce. All 284 unsourced values stay in use, marked **Assumed - no council source** and warned on use; the 24 source-backed value corrections and Whitehorse exception stay. All 22 profiles were compared with origin/master on the same inputs: zero other profile-value differences. Three Civil Release builds: 0 errors. Focused checks: 65 passed. Full Civil suite: 11,135 passed, six known baseline failures, 19 skipped. **No AutoCAD opened; nothing installed or Tim-accepted.**
2. **After a separately authorised install, in AutoCAD 2027 and then 2024/net48:** open CE Settings and select Banyule. Its detention rule should require **all storage below ground**, and its minimum orifice should read **40 mm**. Select Maribyrnong: storage should use the **10-year storm**, not the 20-year overflow storm, and the minimum orifice should be **40 mm**.
3. **One uncertainty check in each lane:** select Whitehorse. Its **90 mm** minimum must be visibly marked **Assumed - source not found**. Select Knox: its retained detention-method value must be marked **Assumed - no council source** and warn when used. A minimum grade with no entered value may remain Unknown; it must never say council-verified. If an assumed value appears as verified, stop acceptance and report that screen.

## UX-HELP-02/03 / Start Here first-run tour, What's New gate (26 September 2026, code review ready)

1. **Candidate:** plugin draft [PR #255](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/255), branch
   `claude/ux-first-run` (tip updated 26 Sep, review fix) against `master`. From Tim's 25 Sep 2026 23:57
   "Help and first run" ruling. **Review fix, 26 Sep:** UX-HELP-05's "Engineer or Draftsperson?" question
   was dropped — Tim's same-day UX-MODE-01 ruling replaced that person role with a per-job job mode, so it
   never reached this checklist as a real feature; `CEROLE`/"My Role" are removed, not just hidden. The
   Start Here highlight also no longer reuses Manager's generic amber health dot — it is now CE's own
   accent colour (gold on dark, CE blue #1E5AA8 on light), and the tour window was shortened to remove an
   empty gap the dropped question left behind. Civil and Manager Release net48/net8/net10: 0 errors. Full
   Civil suite (net10, single NUnit worker, from before the review fix — nothing engineering-relevant
   changed since): 11,160 passed / 19 skipped / 6 known baseline failures, unchanged by name — none touch a
   file this branch changed. Focused retest after the review fix: 37 passed / 1 failed (the 1 is the same
   pre-existing BUG-177, unrelated). Dark/light pictures of the corrected tour window inspected:
   `docs/image/V3_WINDOWS/starthere-{dark,light}.png`. **Not installed, not opened in AutoCAD, not
   Tim-accepted.** UX-HELP-04 (F1 context help) and UX-HELP-08 (first-three-uses tips) were not reached —
   see the branch's `REGRESSION_LOG.md` top entry for what remains.
2. **After an authorised install, AutoCAD 2027 first, then 2024.** Open the CE tab.
   1. The **Start Here** button (CE panel, leftmost) should carry a small dot — gold on dark, CE blue on
      light — with a tooltip explaining why — never just a colour with no words.
   2. Click it (or type `CESTARTHERE`). The tour opens: five cards with real ribbon pictures (Pipe, Pit,
      Edit, Checks, Help). Close with **Got It**. (No role question any more.)
   3. Look at the CE tab again, same session: Start Here should no longer carry the dot. Close and reopen
      AutoCAD — still no dot (this is what stops it ever coming back).
   4. Type `CEROLE`: it should report "Unknown command" — there should be no "My Role" button on the CE
      panel either. If either still appears, the old build is still installed.
   5. Delete `%APPDATA%\TIM_CE_CADTOOLS\last_version.txt`, restart AutoCAD: What's New should open once,
      within a few seconds. Restart again without touching the file: it should **not** reappear. This is
      the exact case Codex found missing — please confirm it specifically.
   6. From the tour, choose **Help Centre** instead of Got It: the CE Help Centre should open and the tour
      should close.
   7. If a spare machine or fresh Windows profile is available: with no `CD_Settings.json` at all, Start
      Here should be lit from the very first CE tab shown, with no pop-up of any kind on its own.

## STRUC-D2-SLICE1 / beams follow their column on MOVE; each label stays with its beam (26 September 2026, code review ready)

1. **Candidate:** plugin draft [PR #250](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/250), branch `claude/d2-slice1`
   (tip `cce3b237`) against the shipping Structural line `claude/struc-d1-prep`. From the D1 card Tim approved 25 Sep
   (choice 7 "Beams follow"; the label half of choices 3 and 4). Shipped Structural lanes net48/net8/net10: 0 warnings,
   0 errors. Machine tests and a headless AutoCAD 2027 core-console proof passed (13/13 plus save/reopen; one U put
   everything back each time). **Not installed, not opened in full AutoCAD, not Tim-accepted.**
2. **After an authorised install, AutoCAD 2027 first, then 2024.** New drawing: two stud walls 6.0 m apart, a DS1 on
   each, a C1 halfway. Command **1**: B1 from the left DS1 to C1, then B1 from C1 to the right DS1.
   1. **MOVE**, pick only C1, Enter, `@300,0`. Right: both beam ends land on C1 in its new place, each label keeps its
      place on its beam (centred stays centred), and the command line says *"CE moved 2 beam ends with the support, and
      2 beam labels with their beams. One U undoes both."*
   2. **U** once. Right: C1, both beams and both labels are exactly back.
   3. MOVE C1 `@0,300`. Right: both beams tilt to meet C1; each label keeps its side and turns with its beam. U: all back.
   4. Click C1, drag its own grip and click. Right: the same as step 1 (no preview yet: the CE grips are slice 2).
      U: all back.
   5. MOVE the left beam line alone `@0,500`. Right: its label comes with it; C1 and the right beam stay. U: all back.
   6. Start MOVE on C1, press Escape before the second point. Right: nothing moves.
   7. Lock the beam layer, MOVE C1 `@300,0`. Right: only C1 moves; the command line names B1 and says to unlock the
      layer. U: C1 back. Unlock the layer.
   8. MOVE C1 `@300,0`, save, close, reopen, MOVE C1 `@-300,0`. Right: the beams follow again.
   9. AutoCAD 2024: repeat steps 1 and 2.

## UX-RIBBON-01 / jump to the contextual Pipe, Pit, Source tab (25 September 2026, code review ready)

1. **Candidate:** branch `claude/ux-ribbon-jump` (from `origin/release/civil-train-0925`, `cef5215c`), draft PR
   against `master`. Three Civil Release lanes and three Manager Release lanes: 0 errors. Full net10 suite:
   Manager 265/265, Civil 11,130 passed / 6 known baseline failures (unchanged) / 19 skipped. No AutoCAD,
   install or Tim acceptance. Also pending Tim's review of the UX-RIBBON-01 card itself (settings-first
   default, recorded in `areas\windows-and-ribbon.md`).
2. **After a separately authorised release, AutoCAD 2027 and 2024/net48:** open a job with a drawn pipe, pit
   and source (downpipe or overflow). Click the pipe — the Pipe tab must appear and be the active tab at once,
   the way selecting a hatch opens Hatch Editor in front. Press Escape (or the tab's Close button) — the tab
   must disappear and the CE tab must be back in front, not any other AutoCAD tab. Repeat for the pit and the
   source. Click the pipe, then Ctrl-click the pit so the selection mixes families — no contextual tab may
   claim it. Click the pipe and run Reverse Flow from the now-active Pipe tab — its existing confirm step and
   single Undo must be unchanged.

## CDSETUP / Design source draft and LPD outlet — V3 39.8 (25 September 2026, code review ready)

1. **Candidate:** Slice 1 PR #210 (`a650644a`) and Slice 2 ready-for-review
   PR #212 (`0cee02af`), stacked on #210. Three Civil Release builds: 0 errors.
   Full net10 suite: 11,078 passed / 19 skipped / 6 known failures. Dark/light
   Design pictures checked. No AutoCAD, install, merge or Tim acceptance yet.
2. **After a separately authorised release, AutoCAD 2027 and 2024/net48:**
   in a disposable synthetic drawing, open Design, enter a job reference and
   survey revision, then Escape. Reopen and check nothing was saved or drawn.
   Enter them again, Save Draft, reopen and check both remain; one `U` must
   reverse that Save Draft. Pick an approved outlet and note location, review
   the ghost and CE standard note in dark and light, then Cancel: nothing is
   placed. Pick again, enter an evidence reference and known invert with datum,
   Confirm LPD, and check the CDLPD-style marker and note. Reopen, verify the
   same outlet values, then one `U` must remove marker, note and record. Repeat,
   save/reopen and check persistence. Add a second outlet and confirm each is
   selected separately. Set one invert to Unknown and check Work out design is
   blocked. On a disposable drawing with an older CDLPD record, Design must
   ask for review and leave it untouched. Check locked layers, Xrefs and
   REFEDIT retain AutoCAD's normal protection. Only native appearance,
   interaction, Undo and save/reopen remain to prove; automated checks cover
   the model and window layout.

## CDTAG empty selection — UC 39.2 (25 September 2026, code review ready)

1. **Candidate:** [PR #209](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/209), `codex/uc392-cdtag` at `60d11634`, ready for review. Three Civil Release builds have 0 errors; full net10 suite 11,072 passed / 6 known failures / 19 skipped. Code only: no AutoCAD, installation or Tim acceptance.
2. **AutoCAD 2027 and 2024/net48, after a separately authorised release:** with nothing selected, type `CDTAG`. Expect one line: `Select one source, then run CDTAG again. Nothing was changed.` No block-pick or tag question and no drawing change. Select one downpipe, run `CDTAG` again and check its normal tag workflow still opens; Escape without changing it.

## Edit Pipe one-page New Pipe look — BUG-173 pipe (24 September 2026, awaiting release)

1. **Candidate:** [draft PR #180](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/180), `codex/onepage-editpipe` tip `7e74c93d`. Every pipe-edit entry opens the one-page New Pipe layout titled Edit Pipe with Save, independent of the remembered workshop switch. Three Civil Release lanes built with zero errors; 345 focused checks passed. Four compiled dark/light New/Edit pictures were inspected at `docs/image/V3_WINDOWS/editpipe-onepage-*.png`. Full Civil suite awaits the release chat after 17:30. No AutoCAD, installation or Tim acceptance.
2. **After the combined release, AutoCAD 2027 and 2024/net48:** double-click a 375 mm pipe. The same window as New Pipe opens, titled Edit Pipe, showing 375 mm. Change it to 450 mm, open Review changes and see 375 → 450, Save, then enter one `U`: the pipe returns to 375 mm. Reopen it and check the displayed size and label. Repeat once by typing CDEDIT and once with the workshop preference off; both must show the same page. Check the actual drawing fills PLAN PREVIEW, both ends and Unknown levels stay honest, More contains the less-used controls, and no fixed layout area scrolls or overlaps at 1920 × 1080 at 100% and 125%. Inspect Drawing and return must keep the pending 375 → 450 comparison. Cancel/Escape must leave the drawing untouched. This final native preview, write, Undo and save/reopen evidence cannot be proved off-screen.

## New Pit and Edit Pit CD look — BUG-173 pit (24 September 2026, awaiting release)

1. **Candidate:** `codex/onepage-pit` at `a760d7d4`, ready-for-review [PR #184](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/184), supersedes tabbed PR #176. The one-page Engineering / Drafting / full-width plan / fixed-footer window fits 1080p and 1440p at 100/125/150% in code checks. Rotation, lid class and detention lid layout are in More. Three Civil Release lanes built with zero errors; 304 requested/pit checks and 599 wider fit checks passed. Full Civil: 10,935 passed, 6 existing non-Pit failures, 19 skipped. Thirty-two dark/light 150% New/Edit pictures were inspected under `docs/image/V3_WINDOWS/`. No AutoCAD, installation or Tim acceptance. The command owner still needs to supply New Pit's plan anchor and Edit Pit's pending dry-run preview.
2. **After the combined release, AutoCAD 2027 and 2024/net48 — New Pit:** open PIT at 1920 × 1080 and 2560 × 1440 at 100%, 125% and 150%. Check the same one-page layout and fixed header/footer as New Pipe, readable Cover/Bottom units, Unknown where evidence is absent, and the real drawing plan showing the proposed pit and connected pipes. Check type, ladder size selection and typed size, cover and bottom, Sump pit own bottom IL, label, text above/below and cover text. In More, check lid class, rotation, detention lid layout, Connected pipes, suggested bottom/Use it and Presets. Change size and cover, inspect the drawing, return and check the typed values and Review changes; Cancel/Escape must place nothing. Continue placement, place a pit, and reopen to check drawing output.
3. **Edit Pit:** open an existing pit and check the same one-page layout and the proposed drawing preview as fields change. Change size, cover and bottom, use Review changes and Inspect Drawing, then Save. One Undo should reverse the edit; reopen to check the drawing and fields agree. Tim still needs to judge native preview, prompts, placement, Cancel/Escape, drawing output and save/reopen; off-screen pictures cannot prove these.

## CE Blocks palette — CE-BLOCKS-20260924 (24 September 2026, awaiting release)

1. **Candidate:** `codex/ce-blocks` tip `a64199bb`, draft [PR #174](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/174), builds CEBLOCKS in Manager, the Civil CE and CE Tools buttons, and Manager settings for the palette folder and office block drawing. Twelve exported groups / 307 block tools and both dark/light off-screen pictures passed their focused checks. Manager 16/16, Civil 18/18; all six Manager/Civil Release builds have zero errors. Full Civil suite awaits the release chat after 17:30. Structural ribbon button remains its separate later branch. Nothing installed or checked in AutoCAD; not Tim-accepted.
2. **After a separately authorised combined release, AutoCAD 2027:** run `CEBLOCKS`. Check the twelve groups and their order match the office tool palettes, and that “Block Civil 2” has that name. In Steel place WELD VERT; it must land on WELDING at the old-palette size. In Ground place SCREW PILE with the 45° default. Press Escape during another placement: nothing is added. Place one block, type `U` once and check it disappears. Lock, then freeze, a target layer and check each attempt names the layer on the command line and draws nothing. Save and reopen the test drawing and check the inserted block is still right.
3. **AutoCAD 2024/net48:** repeat opening the palette and placing WELD VERT, checking its layer and size. Temporarily remove local access to the office block drawing and reopen CE Blocks; it must stay open with one clear OneDrive line. Restore access through normal sync. Check the Manager settings paths can be read and saved. Native placement, Xref behaviour, docking, Undo and saved drawing output remain unproven by automated checks.

## What's New readability and content — BUG-170 (24 September 2026, awaiting release)

1. **Candidate:** `codex/whatsnew-readable` at `4465e22d`, draft [PR #173](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/173). The window is 760 × 640, resizable, with a fixed header/footer and a scrolling reading list. Its 15 Version 3.0.1 claims name visible Civil actions; the false single-tab and Civil status-dot text has gone. Three Civil Release lanes have zero errors; 11 What's New and 29 related ribbon/registry checks pass. Eight real dark/light pictures at 100% and 125% were inspected. Full Civil suite waits for the release chat after 17:30 Melbourne. No AutoCAD, install or acceptance by this session.
2. **After a separately authorised combined release, AutoCAD 2027 and 2024/net48:** when the window opens after the next version change, read the full subtitle in dark and light at 1920 × 1080. Scroll to "Less work after a pipe move"; the header and How To Guide/Got It buttons must stay in place, with all text readable. Check that Design setup, Rainfall, Legal point of discharge and Import → X-Civil/LandXML/Survey are on the Civil ribbon, and that the page does not claim one CE tab or a Civil status dot. Press Escape: the drawing stays unchanged. This is a visual/content check; no new drawing action was added.

## Tabbed Pit review and plan text targets — PIT-REVIEW-02 (24 September 2026, awaiting release)

1. **Candidate:** `codex/pit-review-changes` at `bad3c979`, draft [PR #166](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/166) against master, dependent on the 24 Sep Civil train. New Pit and Edit Pit have a fixed-footer Review changes button and the one-page plan text choices. Edit Pit retains its opening Was → Now values after Inspect Drawing. Three Civil Release lanes build with zero errors; 27 focused Pit window checks pass; dark/light review and tab pictures inspected. Full Civil suite remains with the release chat after 17:30. No AutoCAD, installation or acceptance.
2. **After a separately authorised combined release, AutoCAD 2027 and 2024/net48:** open New Pit, note the starting plan length, change it, and click Review changes. Check the opening and pending lengths are both shown under Plan length. The fixed footer must show Pit label and Cover, invert and notes under Text on plan. Cancel without placing.
3. **Edit Pit:** edit a 600 mm pit, change its plan length to 1200 mm and clear its cover level. Review changes must show Was 600 mm → Now 1200 mm and Now Unknown for Cover level. Choose Cover, invert and notes; the corner marker must name that text. Click Inspect Drawing, pan/zoom, press Enter to return: the gold edge, Was/Now tip and review list must still use the original 600 mm value. Cancel; the drawing pit remains 600 mm.

## Civil performance fixes — PERF-1B (24 September 2026, awaiting release)

1. **Candidate:** `codex/perf-audit`, draft [PR #156](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/156). Four existing paths changed: moved-pipe label tidy-up, automatic Project QA timing, command usage/failure writing and CE pipe grip filtering. Three Civil Release lanes built with zero errors; 68 focused net10 tests passed. Synthetic figures are in `docs/perf/PERF_AUDIT_2026-09-24.md`; the full Civil suite awaits the release chat after 17:30 Melbourne. No AutoCAD, install or acceptance by this session.
2. **After a separately authorised release, AutoCAD 2027 and 2024/net48:** on a disposable synthetic drawing with two adjacent CE pipes and nearby pit/invert text, MOVE one pipe and grip-move an end. Its labels must clear the same nearby clashes; labels on the neighbouring pipe must remain correct. Cancel a move; then Undo a completed move and check geometry, labels and pipe links return together. Save/reopen and confirm the label positions persist. Select and grip an ordinary rectangle/polyline: its normal midpoint stretch grips and hover menu must remain; select a CE pipe and check its grip and plan-only move.
3. **Settling check:** make several quick drawing edits, stop for three seconds, then open Project Review and check its drawing findings become current without repeated flicker. Complete a CE command and check its ordinary usage record is still written. Tim's representative native check is needed because synthetic operation counts do not prove wall-time speed or drawing output.

## Command-line keyword choices — BUG-168 (24 September 2026, awaiting release)

1. **Candidate:** `codex/keyword-shortcuts` tip `825c12ac`, draft [PR #155](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/155). Seven static prompt clashes and CDWT's generated lists corrected; global keyword names remain stable. Focused net10 checks 16/16, three Drainage Release lanes 0 errors. No AutoCAD opened, installation or acceptance.
2. **After separately authorised installation, AutoCAD 2027 and separately 2024/net48:** type `CDGRIPDIAG`, click `OFF` in F12 and check the command line reports OFF. Run it again, click `ON`, and check ON. Run `CDDEBUG`, click `OFF`, and check OFF is reported. For `CDDISCIPLINE`, choose Clear and check the explicit tag is cleared; repeat with Cancel and check there is no change. Check CDWT's plan and office tank lists display separate A–I choices when several names begin with the same letter. Escape from each prompt must leave its setting unchanged. No drawing edits are expected from these shortcut checks.

## Civil import windows — UI-IMPORT-20260924 (24 September 2026, awaiting command wiring)

1. **Candidate:** `codex/ui-import` tip `65e54830`, [PR #153](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/153), ready for review, contains the source, schedule and results window code and 14 dark/light pictures. Three Civil Release lanes build with zero errors; seven focused window checks pass; the full Civil suite has 10,829 passed / 11 exact baseline failures / 19 skipped. The CE ribbon does not open these windows yet: X-Civil, LandXML and survey command/service wiring is reserved for Claude. No AutoCAD opened, installation or acceptance.
2. **After command wiring and a separately authorised combined release, AutoCAD 2027 and 2024/net48:** open CE Import and X-Civil/LandXML in both themes at 1920 × 1080 scale 1. Choose a DWG, then a consultant package folder; check the pit/pipe schedule identifies P1 and P1 to P2 before accepting. The result must identify the same drawing labels, with any unproven levels shown as Unknown. Cancel at source and schedule review must draw nothing. Repeat an import and use the existing Abort option; the prior drawing items must remain untouched.
3. **One drawing-output check:** import a LandXML network and confirm its pits and pipes match the existing command's result; link a survey and review/approve it through Manager Survey Intake. After an accepted change, use one Undo, then save/reopen. Check locked layers and Xrefs retain AutoCAD's normal protections. Automated pictures prove layout only; real file picking, drawing output, Undo and persistence remain untested.

## Edit Pipe — UI-EDITPIPE-20260924 (historical #144 candidate, superseded by BUG-173 pipe)

1. **History only:** [PR #144](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/144) built the three-tab Edit Pipe candidate and its tests; it was never installed or Tim-accepted. Tim's 24 Sep correction makes New Pipe's one-page window the reference. The three-tab source is retained pending Tim's retirement decision, but the old three-tab AutoCAD checklist is superseded. Use the consolidated BUG-173 pipe check above.

## Civil Hub — CIVIL-HUB-UI-20260924 (24 September 2026, awaiting release)

1. **Candidate:** [PR #142](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/142), codex/ui-print tip 49020240, tested code 9c226efc; ready for review. Print in review item 15 is CDCALC, already rebuilt by PR #139; this is the next eligible scrolling window, item 20 Civil Hub (CDHUB). Three Release lanes 0 errors. Full Civil: 10,668 passed / 11 exact baseline failures / 19 skipped / 10,698 reported. All 52 Hub checks pass; 40 dark/light real-window pictures inspected and unchanged after the full suite. Not installed or Tim-accepted.
2. **After release-owner installation, AutoCAD 2027 and 2024/net48:** open CDHUB on a synthetic network in both themes at 1920 x 1080 scale 1. Select and scroll to the last finding, refresh, then Show on plan / Edit selected item; confirm it acts on that object. Show all, Pit Schedule and Long profile keep their existing hand-offs. Open a design-impact proposal and visit Affected items / Network sketch. Header and actions stay fixed while long lists scroll.
3. **Redesign / native remainder:** complete Network and controls / Outlets and branches / Flows and preview, including branch assignments. Build preview, visit every full pit/pipe and final-schedule column view, approve then Check again (approval clears). Review, approve/apply and use one Undo. Cancel/Close/Escape leave the drawing unchanged; save/reopen confirms existing persistence. Drawing picks, navigation, output, Undo and native focus remain the representative acceptance work. Automated evidence covers all task pages at opening/minimum sizes, last finding, long cell wrapping, approval and refresh guards, unknown wording, both-theme contrast and Escape. Existing Plan vs schedule / Xref availability remains service/command-owner work.

## CE Inspector - UI-INSPECTOR-01 (24 September 2026, awaiting release)

1. **Candidate:** [PR #141](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/141), `codex/ui-inspector` tip `aca43279`, tested code `2351b7cb`, ready for review. Three Release lanes 0 errors; full Civil 10,673 passed / 11 exact known failures / 19 skipped / 10,703 reported. All 167 Inspector/C2 checks pass in the full suite. All 36 compiled-palette dark/light pictures inspected and unchanged after the suite, under `docs/image/V3_WINDOWS/inspector-*`. Not installed or Tim-accepted; no AutoCAD opened.
2. **After release-owner installation, AutoCAD 2027 and 2024/net48:** open CDINSPECTOR beside a synthetic drawing in both themes at 1920 x 1080 scale 1. Select a pit, pipe and source, visit Item / Connections / On plan and read them at opening/minimum sizes. Clear selection, then select an unrecorded pit/pipe: the plain Unknown sentence remains. A long connection list scrolls while the header and actions stay fixed. Change theme with the palette open.
3. **Full Inspector / native remainder:** open Full Inspector, visit Selected object / Drawing health / Schedules; counts remain Not checked until Refresh. Refresh, select a network finding, Show in drawing and use the existing editor route; open Pit Schedule. Switch drawings and reopen to confirm selection/refresh, native docking/focus and save/reopen. Escape and Undo keep their usual AutoCAD behaviour. Compact Edit remains disabled as before; use the displayed CDEDIT instruction. Enabling that hand-off is routed to Claude's behaviour work. Automated evidence already covers tab layout, command bindings, Unknown wording, fixed actions, long lists and live theme changes.
## Project Review, What CE Found and Pit Schedule — REVIEW-SCHEDULE-02 (24 September 2026, awaiting release)

1. **Candidate:** [PR #140](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/140), codex/ui-review tip 00fbda40, implementation af7dd32c; ready for review. Three Release lanes 0 errors each. Civil: 10,692 passed / 11 exact baseline failures / 19 skipped / 10,722 total. All 65 targeted checks passed in the full suite. All 34 dark/light compiled-window pictures inspected and unchanged after the suite. Not installed or Tim-accepted; no AutoCAD opened by this session.
2. **After release-owner installation, AutoCAD 2027 and 2024/net48:** on a synthetic drawing open CDDASHBOARD. Visit all seven tabs, filter and Clear all, scroll to the final finding, select it and Show in drawing; confirm the label and highlighted object agree. Check again, CSV and Escape. Open CDCHECKCURRENT; select an item, switch to Attached, select an attached drawing and Show in drawing. Summary and Surfaces must not highlight a hidden prior selection. Read the full explanation and last surface note. Header/footer stay fixed in both themes.
3. **Pit Schedule native remainder:** open PITSCHEDULE; scroll to the final pit/inlet and switch the three column views. Edit/restore one cell, reorder a group, apply/clear a search and confirm the stated output scope is unchanged. Review changes, choose set/system, place/update once and cancel once; check Undo, Close/Escape and drawing save/reopen. Drawing selection/output, persistence and keyboard feel remain the native acceptance work. Automated evidence already covers layout, tab clipping, final-row access, selected-row contrast, labels, filter/output separation and command bindings. This supersedes earlier finding/schedule page-button checks.


## New Pit and Edit Pit levels — UI-NEWPIT-02 (24 September 2026, awaiting release)

1. **Candidate:** [PR #127](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/127), `codex/ui-newpit` tip `1a780add`, tested code `fe48b037`. Code gate met for review; no installation or AutoCAD acceptance. Three Release lanes 0 errors each; full Civil 10,686 reported / 10,656 passed / 11 exact known failures / 19 skipped; all 260 Pit checks pass. Fourteen dark/light actual-window pictures inspected and unchanged after the final suite, committed under `docs/image/V3_WINDOWS/newpit-*` and `editpit-*-levels.png`.
2. **After a separately authorised combined installation, AutoCAD 2027 and 2024/net48:** open PIT in dark/light at 1920 x 1080 scale 1. Clear cover, width, invert or rotation; confirm one matching next action and highlighted input. Complete the input and confirm Continue placement enables. Visit all five tabs, including detention/building alignment; use a preset, survey RL, Recall and Inspect/return with long remarks. Header/footer stay fixed. Cancel/Escape leave no pit; complete one placement and Undo.
3. **Edit Pit / native remainder:** edit a pit with a missing connected invert and confirm the warning sits beside Bottom. Check the retained connection evidence in Levels & Pipes, Save/Cancel and save/reopen. Automated checks prove shared bindings, focus routes, command enablement, warning clearing and both-theme layouts at minimum/opening sizes. Native preview, drawing output and keyboard feel remain Tim's representative acceptance checks; these renders deliberately show the no-preview state outside AutoCAD.

## Help Centre Version 3 guide and scrolling - code ready for review, 24 September 2026

1. **Candidate:** [PR #125](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/125), codex/ui-help tip a651680b, code 54801c50. Ready for review; not installed or Tim-accepted. Three Release lanes 0 errors each; full Civil 10,595 passed / 11 exact baseline failures / 19 skipped. Shared Help 45/45, browser 3/3, real Civil renders 2/2. All 64 current pictures inspected, unchanged after full suite.
2. **Current guide candidate:** [draft PR #172](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/172), `codex/help-v3-content` tip `4f51457a`, based on the Civil train. All 69 current Civil ribbon commands are covered; none uncovered. Three Release lanes 0 errors; focused Help tests 5/5; dark/light Introduction plus three reading-page pictures inspected. Full Civil suite awaits the release chat after 17:30 Melbourne. This supersedes the older guide-content and Version 2.1 warning check in #125; #125's bounded scrolling remains.
3. **After release-owner installation, AutoCAD 2027 and 2024/net48:** open CE → Help Centre and confirm the badge says `v3.0 guide`. Search "change pipe size", open Edit, and check the Pipe, Levels & Flow and Connections directions. Open Import: Survey tells you to pick the survey reference; X-Civil names the pit and pipe schedule review; Consultant DWG says it prints a text report. Wheel and Page Down/Page Up through the full reading page; header, search, left list and footer stay fixed. Reach the selected-item entries, then Home and Escape. The drawing stays unchanged.
4. **Shared reader:** open Move and rotate, scroll to More detail, return Home and Continue reading, then close/reopen. The reading position returns; the existing guarded Start tool and minimise/restore paths still need native host acceptance. No new drawing operation is introduced.
5. **Pictures:** current Civil guide evidence is `help-window-{dark,light}-{intro,start-draw,design-review,import-settings}.png`; earlier section pictures remain historical evidence for #125. This supersedes previous Help Previous/Next-page acceptance steps and -page-/-tasks- pictures. No AutoCAD check has been run for #172.


## CDCALC whole window - UI-CDCALC-02 (24 September 2026, awaiting release)

1. **Candidate:** `codex/ui-cdcalc`, tip `88d0e99d`, [PR #139](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/139), ready for review. Final master integration `59e03b0e` includes master `53b5a8c4`. All three Release lanes 0 errors; Civil 10,654 total / 10,624 passed / 11 known failures / 19 skipped, exact baseline names; all nine CDCALC window tests pass. Thirty-two dark/light compiled-window pictures inspected and unchanged after the final suite. No AutoCAD opened, installation or acceptance by this session.
2. **One representative session after a separately authorised combined installation, AutoCAD 2027 and 2024/net48:** open CDCALC in a synthetic drawing; visit every calculation tab in both themes at 1920 x 1080 scale 1. Header, task tabs and footer stay fixed; long lists scroll in their own area. Detention: scroll beyond the first rows, Find/add/remove/refresh, add extra storage and edit litres. Check blank required volume, typed zero, shortfall and surplus; each reads honestly with superscript units. This supersedes the older five-row paging checks.
3. **Native remainder:** pick a longitudinal route, preview/place/update; preview/export a computation sheet; insert the detention criteria block, Undo, Close/Escape and save/reopen. Confirm drawing picks, output and saved values remain correct. Automated checks already cover every page at minimum/opening sizes, rendered selection, row addition, required/attention states and unit text. Existing automatic recalculation remains; no separate Calculate command or per-pollutant WSUD flags have been added to protected models.

## Drawing Standards — UI-STANDARDS-03 (24 September 2026, awaiting release)

1. **Candidate:** `codex/ui-standards`, tip `63015551`, [PR #126](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/126). All three Release lanes 0 errors; own window tests 13/13; full Civil 10,588 total / 10,558 passed / 11 known failures / 19 skipped, exact baseline names. Fourteen dark/light real-window pictures inspected and committed. No installation or AutoCAD acceptance; the build/test gate is met for review.
2. **One representative session after a separately authorised combined installation, AutoCAD 2027 and 2024/net48:** open Drawing Standards, Label Styles and Parts Catalogue; visit all seven tabs in dark/light at 1920 x 1080, scale 1. Header, actions and footer stay in place; only long lists or label text scroll. Add/duplicate/delete beyond the visible list, save/reopen, and confirm the final row remains available. Enter an invalid pipe diameter: Save keeps the draft and explains the problem. Reset then Cancel preserves saved catalogue entries; Escape retains the established cancel/close behaviour.
3. **Label and drawing remainder:** in a synthetic drawing, insert Pit number/Cover level into existing wording, replace selected wording with a named field, add a line, inspect the live example and save/reopen. Apply Draw Order to Model and All Layouts and check one Undo; apply labels and check one Undo. Save/reopen the drawing. Native DIMSTYLE opens through Labels & Dimensions. The automated checks already prove draft persistence, cell validation, named-field round trips, caret insertion, selection reveal and both-theme layout; Tim's remainder is native drawing output and interaction.

## Feedback window — FEEDBACK-UI-01 (24 September 2026, awaiting release)

1. **Branch:** `codex/ui-feedback`, tip `546bb4a5`, **PR #136 draft**. Feedback 25/25; all three Release lanes 0 errors; full Civil 10,544 passed / 12 failed / 19 skipped (11 known + the newly merged Settings reset expectation mismatch, routed to its builder). Code only: no installation or AutoCAD acceptance. All four compiled-window pictures checked in dark/light at 1080p scale 1 and committed.
2. **One representative session after Claude installs, AutoCAD 2027 and 2024/net48:** open CDFEEDBACK. Details opens first; title, description and Save/Cancel fit without a scrollbar in dark and light themes. Choose Idea, write a synthetic title and multiline description, visit Included information and return: the draft and type stay. Save enables only with both fields filled, and Enter in the description adds a line.
3. **Save/cancel remainder:** save that synthetic report and check the file named in AutoCAD's command line; it contains the chosen type, title and description. Repeat with Cancel, Escape and the title-bar close: no new feedback file. Reopen on Details. A draft over 2,000 characters warns that the file is shortened; editing below the limit clears that warning. Check normal and 150% display scaling.
4. **Routed to Claude-owned behaviour:** automatic screenshot attachment, shared delivery/receipt and an in-window save-failure retry require FeedbackCommand/FeedbackService work. The window accurately describes the existing local-file route; it does not claim those design-pack capabilities are implemented.

**This is the one living list, across every chat.** A chat ending must never take the test list with it.

## Rules for every chat

- **When you build something**, add it here with its branch, commit and the exact steps Tim should follow.
- **When Tim confirms a pass**, move it to "Accepted" at the bottom with the date and the build he tested.
- **When Tim reports a failure**, say so here — do not delete the row.
- **Never tick anything yourself.** A green build, a passing test run and an AutoCAD result are three different
  facts. Only Tim's word moves a row to Accepted.
- Steps must be **specific**: *"open a 375 pipe and check the Edit Pipe window shows 375"*, never *"test pipe
  editing"*. Include the failure paths — Cancel, Escape, a refused save, one accepted edit = one Undo.
- Say which **lane**: AutoCAD 2027, and separately 2024/net48 — Tim ruled 2022–2024 users are in scope.

---

## CDWT-LAYOUT-03 — bounded lists built; review gate blocked — 24 Sep 2026

1. **Candidate:** draft [PR #135](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/135), `codex/ui-cdwt` at `d12fd5b7`. All three Release lanes: 0 errors. Focused Water Tank: 192 passed, 0 failed. Full Civil: 10,579 total, 10,548 passed, 12 failed, 19 skipped. The 11 baseline failures remain; extra Settings Reset test expects old 3.0 m/s instead of 6.0 m/s. Its builder's fix `5d533ab9` arrived on master after the starting merge; protected files untouched here. PR stays draft under Tim's 11-failure gate. Not installed or accepted.
2. **Already automated:** both themes, complete bounded lists, minimum/opening sizes, fixed footer, captions, scrolling/selection, matched-first plans, one gold/blue next action, typed capacity, empty states and scrollbar/blank-space double-click safety. Twenty real-window off-screen pictures inspected and committed; hashes unchanged after full suite. No AutoCAD launch.
3. **Remaining after separately authorised combined installation — AutoCAD 2027:** open CDWT, choose a tank and check its matching plan is first; scroll to the last capacity and plan, choose a plan, switch tabs and confirm capacity/selection and footer stay fixed. Check dark/light once, typed litres and detention/reuse. Double-click the scrollbar: no placement. Complete representative Place/plan-double-click and Tag existing flows; Cancel/Escape draw nothing; one Undo and save/reopen retain the established behaviour.
4. **AutoCAD 2024/net48:** confirm the existing CDWT entry still works; this WPF window change compiles only in the 2027 lane. Tim's native acceptance remains pending. See `areas/civil-G-water-tanks-cdwt.md` section 11.

---
## COLLEAGUE RELEASE, Tuesday 29 Sep — Codex runs the AutoCAD testing (Tim, 23 Sep)

**The one run list:** `archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md`. Pass 1 covers the installed
`aeb03763` (installed 12:18 by the release chat), including the 18 Sep list, V1 to V18 below and the deploy chat's
`CODEX_TEST_RUN_2026-09-23.md` folded in as Part B. All of it is **installed now**, even where headings still say NOT INSTALLED. Area: `areas\release-v3-colleagues.md`.

---

## LIVE since 23 Sep 2026 11:26 — `3.0.0+b02f3ec7` built from **master**

Tim: **"AUTOCAD IS CLOSED, DEPLOY"**. **The first release built from `master`**, now that PR #87 has made the
main line equal what is installed.

**Read back by hand from all three lane DLLs, not from the installer's output — all three identical:**

1. **Legacy** (net48, AutoCAD 2022–2024) — `3.0.0+b02f3ec7988e9666199aab5bbd16dee482acd09b`
2. **Net8** (AutoCAD 2025–2026) — same
3. **Modern** (net10, AutoCAD 2027) — same

Lane SHA256: Legacy `B1666539…5826A1` · Net8 `54337DB6…D4D517` · Modern `BAB029FC…6800FA8`.
Native modules staged in Modern: grip `.arx` 82 KB, objects `.dbx` 108 KB, transform `.arx` 74 KB.

**Tim's one-action undo** — the deploy script does not back up, so both were taken by hand first:

1. `CE_CVL_SUITE_PRE_d90659cf_20260923-110557.backup` — 133 MB, 806 files
2. `CE_SUITE_MANAGER_PRE_CESHARED_20260923-110557.backup` — 75 files

**CE_SHARED** — the script does not sync it. All three Manager lanes differed and were copied from Civil,
each hash-verified after the copy: Legacy `B35FEE12…`, Net8 `F98CE4C0…`, Modern `41DD9367…`.
Independently re-read afterwards and confirmed identical lane for lane.
**STRUCTURAL IS NOT REDEPLOYED** — still `1.0.74+5d723d41`.

### What this carries beyond `d90659cf`

1. **CDWT-LINK-01** — a tank finds its own plan drawing, matched on the litres in the plan caption.
2. **CD-RECENT-01** — the CD window's "Recent:" strip trimmed (four diameter buttons, not ten).
3. **DEPLOY-01** — the release script's reference paths, and a preflight over eleven inputs.
4. Two client addresses out of the saved code; the command-count guard corrected for `SML`/`CHECKML`.

### Testing

**`CODEX_TEST_RUN_2026-09-23.md`** (55 steps, mine) is folded into the release chat's single list as **Part B**.
That list is the one Tim uses. **Part X needs an AutoCAD 2024 machine** and is carried to Monday's colleague check.

### The first attempt was refused, and it is worth recording

At 11:07 the installer stopped: `ERROR: AutoCAD is running (PID 8616)` — AutoCAD had been opened between the
two checks. **Nothing was copied or removed.** On the retry the first check caught AutoCAD **still shutting
down** (a process at 64 K), so **four** checks were made before installing. `accoreconsole.exe` was also
running; its loaded modules were inspected and it was not holding the bundle. **The deploy script checks only
`acad.exe`, never `accoreconsole`.**

---

## LIVE since 28 Sep 2026 11:19 on Tim's PC — Civil `3.0.10+6558776d`, Manager `1.1.10+6558776d`, Structural `1.0.81+ad288199`

1. **Installed by the release chat, Tim: "AUTOCAD IS CLOSED, DEPLOY"** (fourth install today). AutoCAD closed checked twice (11:19:27, 11:19:37); 2,903 files hash-checked, 0 mismatches; CE_SHARED identical Civil/Manager per lane; Structural all 3 lanes, native ARX present, 0 stray CE_SHARED files.
2. **Backups:** `CE_CVL_SUITE_PRE_3d3b359d_20260928-111927.backup`, `CE_SUITE_MANAGER_PRE_3d3b359d_20260928-111927.backup`, `CE_STRUC_SUITE_PRE_0fb866ee_20260928-111927.backup` in `%APPDATA%\Autodesk\ApplicationPlugins`.
3. **Undo:** close AutoCAD; delete the three new `CE_*.bundle` folders; rename each `..._PRE_*_20260928-111927.backup` back to its `.bundle` name.
4. **Carries, on top of the 01:57 install:** BUG-188 (CEBLOCKS text-tag fix, #333), CEBLOCKS smart redesign (#337 - real tabs, search, recent row, stamp mode), BUG-172 (3 missing ribbon icons, #340), #330/#331 (real templates folder + pump pit in Pit Schedule), #334 (Civil job timer - first time installed, one minor known issue: a ~0.5s file-write every 10 min, no off-switch yet), #276 (admin setup fail-closed, Tim's own admin-setup click confirmed done first). Structural: #332 (New Sheet templates pointed at the real folder, AutoCAD-side still unproven).
5. **Not yet tested in AutoCAD by Codex.** Live lag investigation ongoing (Tim running CEPERFDIAG) - a proactive audit found nothing new tonight causes constant lag; the job timer is the one new always-on feature to suspect first if lag changes after this install.

## LIVE since 28 Sep 2026 01:57 on Tim's PC — Civil `3.0.9+3d3b359d`, Manager `1.1.9+3d3b359d`, Structural `1.0.80+0fb866ee`

1. **Installed by the release chat under Tim's standing override** (same rule as the two earlier installs tonight). AutoCAD closed checked twice (01:57:36, 01:57:46); 2,900 files hash-checked, 0 mismatches; CE_SHARED identical Civil/Manager per lane; Structural all 3 lanes, native ARX present, 0 stray CE_SHARED files.
2. **Backups:** `CE_CVL_SUITE_PRE_82b9d315_20260928-015736.backup`, `CE_SUITE_MANAGER_PRE_82b9d315_20260928-015736.backup`, `CE_STRUC_SUITE_PRE_d7d2cb09_20260928-015736.backup` in `%APPDATA%\Autodesk\ApplicationPlugins`.
3. **Undo:** close AutoCAD; delete the three new `CE_*.bundle` folders; rename each `..._PRE_*_20260928-015736.backup` back to its `.bundle` name.
4. **Carries, on top of the 00:03 install:** Civil #317 (job record + CDNEWDWG) #320 (CDXREFCOMPARE/CDXREFREPAIR). Structural #316 (timber subfloor CSSUBFLOORGRID/CSTAGBEARERS) #318 (basements CSBSMTWALL/CSPUMPPIT/CSPUMPPITSCHEDULE). NOT carried: #319 (New Sheet layout - held, placeholder template paths, needs Tim's real template + an AutoCAD check first).
5. **Not yet tested in AutoCAD by Codex.** Three installs tonight (18:57, 00:03, 01:57), none Codex-tested yet - Codex's daily share won't free up until roughly Tim's own AutoCAD hours start (~9:05am), so the next pass needs Tim to pick a window (before 8:30, or his 2-3pm gap, or after 5:30pm) rather than fitting overnight.

## LIVE since 28 Sep 2026 00:03 on Tim's PC — Civil `3.0.8+82b9d315`, Manager `1.1.8+82b9d315`, Structural `1.0.79+d7d2cb09`

1. **Installed by the release chat under Tim's standing override** ("from now until tuesday we build, test and deploy whenever we need"; Tim, 27 Sep night: "keep going...knocking things off the plan"). AutoCAD closed checked twice (00:02:45, 00:02:55); 2,900 files hash-checked after install, 0 mismatches; CE_SHARED identical Civil/Manager per lane; Structural all 3 lanes, native ARX present, 0 stray CE_SHARED files, 0 AdminSasUrl files.
2. **Backups:** `CE_CVL_SUITE_PRE_efd4a838_20260928-000245.backup`, `CE_SUITE_MANAGER_PRE_efd4a838_20260928-000245.backup`, `CE_STRUC_SUITE_PRE_9edc9bc2_20260928-000245.backup` in `%APPDATA%\Autodesk\ApplicationPlugins`.
3. **Undo:** close AutoCAD; delete the three new `CE_*.bundle` folders; rename each `..._PRE_*_20260928-000245.backup` back to its `.bundle` name.
4. **Carries, on top of the 18:57 install:** Civil #302 (DP/lid-class) #304 (surface drainage) #305 (paving/kerb/spoon) #307 (wave-4 fixes) #312 (fall arrows + catchment overlay). Structural #301 (column labels, merged with #269/BUG-184) #303 (bracing panel + tie-downs) #309 (roof geometry, not wired to a command) #310 (CSSOILREPORT/CSWINDCLASS) #311 (CSLOADPATH). Not carried: #276 (admin), #278 (rainfall), #252/#256 (held, superseded by #301) - all held for Tim.
5. **Build note for the record:** the first three payload-build attempts raced against leftover unfinished builds in the same worktree and produced a stale 3.0.7-stamped DLL; cleared all stale bin/obj/payload_build output and rebuilt watched, one step at a time, before trusting the version read-back. Payload staged at `C:\CEPay\payload` (short path - the usual scratchpad path is too deep for some Copy-Item calls, same class of issue as [[native-build-long-path]]).
6. **Not yet tested in AutoCAD.** Codex pass 15 queued next.

## LIVE since 27 Sep 2026 18:57 on Tim's PC — Civil `3.0.7+efd4a838`, Manager `1.1.7+efd4a838`, Structural `1.0.78+9edc9bc2`

1. **Installed by the release chat** (Tim: "AutoCAD is closed, deploy"). AutoCAD closed checked twice (18:57:46, 18:57:56), before the swap and at the end; 2,001 files hash-checked after install, 0 mismatches; CE_SHARED identical Civil/Manager per lane; Structural all 3 lanes (Legacy/Net8/Modern), native ARX present, no stray CE_SHARED files, Manager has 0 AdminSasUrl files.
2. **Backups:** `CE_CVL_SUITE_PRE_a7c46308_20260927-185746.backup`, `CE_SUITE_MANAGER_PRE_a7c46308_20260927-185746.backup`, `CE_STRUC_SUITE_PRE_f23e5e77_20260927-185746.backup` in `%APPDATA%\Autodesk\ApplicationPlugins`.
3. **Undo:** close AutoCAD; delete the three new `CE_*.bundle` folders; rename each `..._PRE_*_20260927-185746.backup` back to its `.bundle` name.
4. **Carries:** Civil train 7 (#277 #283 #286 #287 #284) + train 8 (#291 housekeeping/pit-catch, #294 CDRENUMBER + schedule, #292 Settings search/history/aliases, #293 F1/tips, #297 BUG-186/187, #296+#298 contextual-tab BUG-180). Structural train 7 (#280 command 5, #285 mark engine, #295 BUG-185 + item 268/265 test fixes). Not carried: #276 (admin), #278 (rainfall) - held for Tim; #252/#256 (column labels) - held, clashes with #269/BUG-184.
5. **Not yet tested in AutoCAD.** Codex pass 14 planned ~04:05 Mon 28 Sep.

## LIVE since 27 Sep 2026 02:10 on Tim's PC — Civil `3.0.6+a7c46308`, Manager `1.1.6+a7c46308`, Structural `1.0.77+f23e5e77`

1. **Installed by the release chat** (Tim: "keep working until monday 10am"). AutoCAD closed checked twice (02:09:41, 02:09:52), before the swap and at the end; 2,900 files hash-checked after install, 0 mismatches; CE_SHARED identical Civil/Manager per lane; Structural all lanes, native ARX listed.
2. **Sources:** Civil + Manager = train 6 `release/civil-train-0927` @ a7c46308 (#268 #272 #274; merged to master by #281). Structural = `release/struc-train-0927` @ f23e5e77 (#271 #269 #270 #273 #275 #279; merged to claude/struc-d1-prep by #282).
3. **Checks before install:** Opus reviews (train 6 fix PRs; #273 separately) with every fix applied; Civil full suite 6 failed = baseline; Manager 265/265; DesignCore base; Structural suite base + 7 receipt drift (re-pinned #279); 383 tests did not run overnight - their guard groups run directly: 394/395 pass (the 1 is a build-freshness check).
4. **Carries (fixes for pass 12 faults):** BUG-178 Esc then ONE U removes the last placed pit/pipe/source; BUG-179 downpipe no longer rolled back by an unrelated pipe; BUG-181 STRUCDEBUG registered; BUG-182 beam command 4 places again + plain refusal lines; BUG-183 column MOVE then ONE U restores; BUG-184 command 1/2 beams link each column to the end on it (a right-to-left beam's column MOVE moves the right end) and support-to-point beams work heading left/down; old swapped beams stay put with one plain line.
5. **Backups (undo):** `CE_CVL_SUITE_PRE_e4c97de1_20260927-020941.backup`, `CE_SUITE_MANAGER_PRE_e4c97de1_20260927-020941.backup`, `CE_STRUC_SUITE_PRE_ad9c0742_20260927-020941.backup`.
6. **Codex pass 13** at 09:05 (brief codex\pass13.txt; report `_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS13_2026-09-27.md`). A PASS is now **Codex-accepted** (RULES 4.5, Tim 27 Sep).

## LIVE since 26 Sep 2026 16:58 on Tim's PC — Civil `3.0.5+e4c97de1`, Manager `1.1.5+e4c97de1`, Structural `1.0.76+ad9c0742`

1. **Installed by the release chat** under Tim's standing word ("test here until Monday morning"; AutoCAD free, Tim away). AutoCAD closed, checked twice (16:57:19, 16:57:29), before the swap and at the end. REL-09 rename and copy; 2,900 payload files hash-checked after install, 0 mismatches. CE_SHARED identical Civil/Manager in all three lanes; Structural has none; Structural is now the ALL-LANES package (Legacy, Net8, Modern; the same package colleagues get, UX-STRUC-12), 591 ribbon pictures per lane, native ARX in Modern and listed to load at start-up.
2. **Sources:** Civil + Manager = release train 5 `release/civil-train-0926` @ e4c97de1 (master bde0c9a9 + #224 #229 #228 #226 #259 #232 #233 #241 #257 #243 #247 #248 #251 #249 #260 #238 #242 #244 #240 #239 #235 #237 #255 #261 + #263). Structural = `release/struc-train-0926` @ ad9c0742 (claude/struc-d1-prep + #231 #236 #227 #253 #254 #250 #262). **Held out:** #252 + #256 (D2 slices 2-3: a copied column's move also moved the original's label), #230, #208.
3. **Checks before install:** both Opus final reviews, every finding fixed or recorded; Civil full suite 11,427 run / 6 failed = the known baseline; Manager 265/265; DesignCore 1,441 / 6 = base; Structural.Tests 2,084 run / 30 failed = the base's 21 + 9 new, all one cause: the 2027-lane Sbeam reader fingerprint shifted because new DesignCore files joined (reader, CE_SHARED byte-identical; same pattern as STRUC-TRAIN2-GUARDS 25 Sep) - re-pin follows as a PR, tests are not in the package. New native pipe object (CE_CVL_OBJECTS_2027.dbx, the U3/U4 Undo fix) rebuilt and packaged (06913A7E...).
4. **Carries (Civil 3.0.5):** one U after an Edit Pit resize and after a PIT split brings the whole pipe outline back (#247); Edit 2 Pipes on split halves (#248); downpipe no longer rolls back (#249, headless PASS on a DWG-B copy); placing commands carry on, Esc stops (#238); Hide grade per pipe type (#242); batch grade Carry downstream with the Settings pit drop (#244); Project Review / Inspector wording (#235, #237); CDSYNC/CDREBUILD warn first (#240); CDFEEDBACK one line (#239); Start Here tour (#255); tank/AGI/TG lid types (#241, #257); contextual tabs (#243); council rules CR-A1..A5 and the CR-D1 sweep (#224 #226 #228 #229 #259, Boroondara/Maribyrnong Tc kept 5 Assumed); PROXYGRAPHICS on + one-piece pipe upgrade held on colleagues' PCs, NOT on Tim's (#260). **Structural 1.0.76:** STRUCDEBUG (#231), no CE save anywhere + CLEAN says it does not save + publish warning OK/Cancel (#236), beam refusal reasons (#227), CEARCHREVIEW gated below 2027 (#253), package pictures + native reader (#254), D2 slice 1 beam ends follow a moved column (#250).
5. **Backups (undo):** `CE_CVL_SUITE_PRE_cef5215c_20260926-165719.backup`, `CE_SUITE_MANAGER_PRE_cef5215c_20260926-165719.backup`, `CE_STRUC_SUITE_PRE_838f95ee_20260926-165719.backup`. Undo: close AutoCAD, delete the three new bundles, rename these back.
6. **For Tim (from the review of #260):** ONE-PIECE PIPES stays Automatic on your PC (upgrades); never set it On in a colleague-defaults sweep. Any shared job you open on your PC is upgraded, so before Tuesday work on copies, or set Off on your PC for live shared jobs, so a colleague on AutoCAD 2022-2024 can still edit those pipes with CE.
7. **INVALIDATES:** earlier results for Undo after pit resize / PIT split, Edit 2 Pipes, downpipe placement, CD/PIT carry-on, batch grade, council values (Darebin 30 mm minimum orifice), every Structural beam result, CLEAN, CE Sheets publish.
8. **Codex pass 12** (Tim's PC, started 16:58): brief `codex\pass12.txt` in the old release scratchpad; report `_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS12_2026-09-26.md`.
9. **Pass 12 result (19:02):** 20 PASS / 8 FAIL / 3 BLOCKED / 2 NOT TESTED. Fixed in this build and seen working: one U after an Edit Pit resize (U3), Edit 2 Pipes on split halves (U5), CE never saves (U6), Structural ribbon pictures (B1), native hover menus (B6). STILL WRONG in this build (fixes in progress, see release-v3 item 255): PIT/CD carry-on - after Esc the first U undoes an empty step (press U twice for now); a downpipe can roll back after split/undo edits (eUnknownHandle); contextual Pipe/Pit tab does not come to the front; STRUCDEBUG is Unknown command (fixed for the next install); beam command 4 point mode refuses with the generic line; MOVE of a column that carries a beam then one U does not restore (ROTATE is fine).

## LIVE since 25 Sep 2026 18:19 on Tim's PC — Civil `3.0.4+cef5215c`, Manager `1.1.4+cef5215c`, Structural `1.0.75+838f95ee`

1. **Installed by the release chat** under Tim's word of 24 Sep about 17:15 ("TEST HERE UNTIL MONDAY MORNING, I HAVE LEFT AUTOCAD IS CLOSED"). AutoCAD closed, checked twice (18:18:56, 18:19:06), before the swap and at the end. REL-09 rename and copy; 1,563 payload files hash-checked after install, 0 mismatches. CE_SHARED identical Civil/Manager in all three lanes; Structural has none; native ARX present; no AdminSasUrl.
2. **Sources:** Civil + Manager = release train 4 `release/civil-train-0925` @ cef5215c (master bf57f739 + #223 #217 #234 #216 #207 #220 #225 #204 #205 #206 #211 #214 #203 #210 #212 #222). Structural = `release/struc-train-0925` @ 838f95ee (#221 guard re-pins incl. train 0924b: weld mark #202, CE Blocks button #193, version 1.0.75; + #219 Newtonsoft crash fix).
3. **Checks before install:** Civil full suite 11,134 run / 6 failed = the known baseline; Manager 265/265; Structural.Tests 2,036 run / 21 failed = the base's 21, 0 new; DesignCore 1,302 / 6 = base.
4. **Carries:** one U after an Edit Pit resize diagnostics (X3, CDDEBUG [X3] lines); CE never saves the drawing and a save writes no draw order (#225); PIT split one U and Edit 2 Pipes after a split (#216); downpipe / pipe-end identity kept (#220, #207 CDRG); pipe type kept after a label edit (#204); each split half its own length (#205); CE Blocks docked (#206); CDCALC WSUD gold, Manningham R-30 (#203) and Edit Pipe warning (#211); C2 diagnostics (#214); C4 tidy-up pit check (#217); CDSETUP Start page + LPD confirm (#210, #212). Structural: SBEAMEDIT registered, weld mark, Pen & Linetypes, commands return to your layer (RC), CE STRUC CE Blocks button, colleague defaults, MarkupAI/SBEAM/Connected Design Newtonsoft crash fix.
5. **Backups (undo):** `CE_CVL_SUITE_PRE_b22095c5_20260925-181856.backup`, `CE_SUITE_MANAGER_PRE_b22095c5_20260925-181856.backup`, `CE_STRUC_SUITE_PRE_8c077569_20260925-181856.backup`. Undo: close AutoCAD, delete the three new bundles, rename these back.
6. **What changes for Tim:** CE no longer saves the drawing every 10 minutes (only AutoCAD's own automatic save protects unsaved work). One U straight after Ctrl+S undoes AutoCAD's own save step first (proven in the core console with no CE code; pass 11 U0 checks full AutoCAD).
7. **INVALIDATES:** earlier results for Undo after save / pit resize / PIT split, CDRG, CE Blocks docking, Edit Pipe warnings, CDCALC WSUD colour, pipe type after label edits, and every Structural beam result.
8. **Codex pass 11** (Tim's PC, tonight): brief `codex\pass11.txt` in the old release scratchpad; report `_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS11_2026-09-25.md`.

## LIVE since 24 Sep 2026 22:04 on Tim's PC — Civil `3.0.3+b22095c5`, Manager `1.1.3+b22095c5`, Structural `1.0.74+8c077569` (unchanged)

1. **Installed** under Tim's 24 Sep 17:15 word (test here until Monday). AutoCAD (left open by Codex pass 9 since 18:08, no drawing open) was closed gracefully at 22:03 with no save prompt; then checked closed twice. REL-09 swap; 899 files hash-verified (0 mismatches); CE_SHARED identical in all lanes; no AdminSasUrl. `b22095c5` is in master (release train 3, PR #201; master `bf57f739`).
2. **Carries, beyond 18:04:** one-page Pit window with real preview and 125/150% fit (#184, #186), CDPROFILE (#187), council rule R-30 (#189), CDEDIT same-type batch for everyone (#192), Newtonsoft fragile calls (#194), CE Blocks layer/dock/icon (#195), BUG-171 round 2 (#196), Undo after save and pit Undo (#197), C7 split + bent-pipe grip (#198), pass 9 wording (#199), versions (#200).
3. **Checks:** full Civil suite on `b22095c5`: 6 failed, all within the saved baseline (0 new); Manager 265/265.
4. **Backups (undo):** `CE_CVL_SUITE_PRE_f0aca3f9_20260924-220345.backup`, `CE_SUITE_MANAGER_PRE_f0aca3f9_20260924-220345.backup`.
5. **INVALIDATES:** every pass 9 result for the items above; PIT / Edit Pit window results (now the one-page layout).
6. **Headless proofs not run:** another process (AutoCAD Benchmark `cebench`) keeps a core console open, and the proof runner refuses to start alongside one. **Codex pass 10** queued (brief `codex\pass10.txt`, report `_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS10_2026-09-24.md`).

## LIVE since 24 Sep 2026 18:04 on Tim's PC — Civil `3.0.2+f0aca3f9`, Manager `1.1.2+f0aca3f9`, Structural `1.0.74+8c077569` (unchanged)

1. **Installed by the release chat** under Tim's word of 24 Sep about 17:15 ("TEST HERE UNTIL MONDAY MORNING, I HAVE LEFT AUTOCAD IS CLOSED"); AutoCAD closed, checked twice (18:03:40, 18:03:50) and at the end. REL-09 rename and copy; every installed file hash-checked against the payload afterwards: 899 files (Civil 821, Manager 78), 0 missing, 0 mismatches (the script's own count showed 0 because its first hash list had shifted paths; re-written and re-checked by hand). CE_SHARED identical Civil/Manager in all lanes; no AdminSasUrl. `f0aca3f9` is in master (release train 2, PR #190; master `1eb8f4ec` after #191).
2. **Carries, beyond 14:46:** BUG-171 read-back (#175), BUG-175 Edit Pipe type order (#179), BUG-174 no [CE] in questions (#177), What's New readable and true (#173), CE Blocks palette (#174), Undo after save / COPY (#167), Help v3 guide (#172), CEPERFDIAG (#178), Edit Pipe = the one-page window (#180), fresh-install defaults = Tim (#183), guards (#188), versions (#182). NOT in: one-page Pit (#184/#186, fit fix running).
3. **Checks before install:** full Civil suite on `f0aca3f9`: 11,015 run, 11 failed = exactly the baseline; Manager 262/262 (same list before #188). The Manager release check stopped at 72-vs-78 files: the six extra are the CE Blocks icons (#174), verified; check updated (#191).
4. **Backups (undo):** `CE_CVL_SUITE_PRE_7d85c40f_20260924-180340.backup`, `CE_SUITE_MANAGER_PRE_7d85c40f_20260924-180340.backup`. Undo: close AutoCAD, delete the two new bundles, rename these back.
5. **INVALIDATES:** earlier results for What's New, Edit Pipe routes and window, CDDESIGN question choices, Undo after save/COPY, Help content, and any CD start-up order observation (draw-first is unchanged on Tim's PC).
6. **Codex pass 9** (Tim's PC, tonight): brief `codex\pass9.txt` in the old release scratchpad; report `_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS9_2026-09-24.md`.

## LIVE since 24 Sep 2026 14:46 on Tim's PC — Civil `3.0.1+7d85c40f`, Manager `1.1.1+7d85c40f`, Structural `1.0.74+8c077569` (unchanged)

1. **Installed by the release chat** on Tim's word ("AUTOCAD IS CLOSED, DO WHAT YOU NEED TO", about 14:15); AutoCAD closed, checked twice before the swap and again after. REL-09 rename and copy of the pre-built payload (`CE_TEST_STATION\payloads\0924-civil-7d85c40f-struc-488f6250\`); 884 files hash-checked after copying, 0 mismatches; CE_SHARED identical in Civil and Manager in all three lanes; no AdminSasUrl in any Manager blob-config. `7d85c40f` is in master (release train PR #170, master `1ee79791`).
2. **Carries, beyond 07:39:** #143 C7 regressions; #146/#149 CDDESIGN, CDRAINFALL, CDLPD windows (connected); #150 SEC-001; #154 BUG-159 grip filter; #151 one U = one edit, tabbed PIT / Edit Pit, Edit Pipe polish; #157 window wording; #155 F12 keyword shortcuts (BUG-168); #156 speed fixes; #162 import windows (X-Civil, LandXML, survey); #160 fit check (quiet on older drawings); #164 version numbers.
3. **Checks before install:** full Civil suite on `7d85c40f`: 15 failed = 11 known + 4 source guards, all four protections confirmed present (PR #169). Manager 257/257. Structural 1.0.75 **not installed**: its suite comparison was still running at 14:45.
4. **Backups (undo):** `CE_CVL_SUITE_PRE_c78a350d_20260924-144523.backup`, `CE_SUITE_MANAGER_PRE_c78a350d_20260924-144523.backup`. Undo: close AutoCAD, delete the two new bundles, rename these two back to `CE_CVL_SUITE.bundle` and `CE_SUITE_MANAGER.bundle`.
5. **INVALIDATES:** pass 8 Z2-Z11 window results (PIT / Edit Pit windows, wording, Edit Pipe clipping changed); R-A-4 / Z4 / X3 Undo results (U1 in); CDGRIPDIAG / BUG-159 grip results; every earlier keyword-choice observation.
6. **Tim's quick look this afternoon (2027):**
   1. The CE status bar reads **3.0.1**; `CEMANAGER` shows Civil 3.0.1 and Manager 1.1.1.
   2. BUG-159: type `CDGRIPDIAG`, click **On** (undoing this morning's workaround). A plain rectangle keeps AutoCAD's own square midpoint grips and hover menu; a CE pipe keeps CE's grips.
   3. BUG-168: `CDGRIPDIAG` again, click **Off** in the list: the command line says OFF. Then set it back On.
   4. One U: edit a pipe's diameter in Edit Pipe, Save, press U once: only that change goes.
   5. `PIT`: the tabbed Pit window opens (Pit & size / Levels & text / Connected pipes / Drawing options / Rotation / Presets).
   6. `CDDESIGN`, `CDRAINFALL`, `CDLPD` each open a window; Cancel closes with nothing drawn.
7. **Codex / Test Station:** R-002 on the VM tests the same Civil and Manager bytes plus Structural 1.0.75.
8. **Tim's results, 24 Sep about 15:10 (2027):** step 1 version "YEP WORKS"; step 2 grips "WORKS NOW" (BUG-159 fixed); step 3 Off/On "WORKS" (BUG-168, CDGRIPDIAG); step 4 one U "WORKS"; step 6 design windows "WORKS". **Tim-accepted:** those five. Step 5 PIT: the tabbed window opens but "DOESNT LOOK GREAT IN COMPARISON TO HOW THE CD WINDOW LOOKS" (BUG-173). New: BUG-171 (upgraded old pipe opens as Detention), BUG-172 (Civil ribbon pictures), BUG-173 (Edit Pipe should look like New Pipe).

## LIVE since 24 Sep 2026 07:39 on Tim's PC — Civil `3.0.0+c78a350d`, Manager `1.1.0+c78a350d`, Structural `1.0.74+8c077569`

1. **Installed by the release chat,** AutoCAD closed (checked twice at each step). CE_SHARED is identical in Civil and
   Manager in all three lanes (E856BE14 / 10A43BA5 / 6B7D6B87). Structural carries none and its native ARX is present.
   BUG-167 hit again (zip still empty after 180 s). The script stopped the build and installed from `payload_build`,
   having checked that all three lanes read `c78a350d`.
2. **Carries, beyond 02:24:** the overnight windows.
   - Civil: #125 Help Centre, #126 Drawing Standards, #127 New Pit and Edit Pit levels, #135 CDWT, #139 CDCALC,
     #140 Project Review / What CE Found / Pit Schedule, #141 CE Inspector, #142 Civil Hub, #144 Edit Pipe.
   - Structural `8c077569`: #145 windows in the Civil look and #147 ribbon pictograms and plain names, on top of #138.
3. **Backups:** `CE_CVL_SUITE_PRE_d1d7022c_20260924-072908.backup`, `CE_SUITE_MANAGER_PRE_d1d7022c_20260924-072908.backup`,
   `CE_STRUC_SUITE_PRE_a93e2614_20260924-073928.backup`.
4. **Codex pass 7 results** (on `d1d7022c` / `a93e2614`): 6 PASS, 6 FAIL, 3 BLOCKED. Report
   `_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS7_2026-09-24.md`.
5. **INVALIDATES:**
   - Pass 7's window results: Y11 Settings and Y12 Feedback still stand; CDWT, CDCALC, Help, New Pit, Edit Pit, Edit Pipe,
     Inspector, Pit Schedule and Review are new and untested.
   - Pass 7's Structural ribbon results: the pictures and names changed; the handler did not.
6. **Pass 8, when AutoCAD is free:**
   - Every new Civil window once: open it, check no scrollbar on the layout, Escape/Cancel.
   - The Structural windows and ribbon.
   - The C7 fixes once PR `claude/c7-regressions-01` lands.

## LIVE since 24 Sep 2026 02:24 on Tim's PC — Civil `3.0.0+d1d7022c`, Manager `1.1.0+d1d7022c`, Structural `1.0.74+a93e2614`

1. **Installed by the release chat,** AutoCAD closed (checked twice at each step). CE_SHARED is identical in Civil and
   Manager in all three lanes (90617F46 / 170510A4 / DEE9627C). Structural has no CE_SHARED; its native ARX is present.
   `build_installer.ps1` zipped normally this time, so BUG-167 comes and goes. The install script now stops the build if
   the zip is still empty 180 s after it starts.
2. **Carries, beyond 23:45:**
   - #121 SPLIT-LEVEL-02
   - #129 UC behaviour (New Pipe readiness, CDCALC wording, drafting words, CDFALL/CDSL Escape)
   - #130 Settings window (six tabs; Reset now gives 6.0 m/s and 450 mm)
   - #131 SAME-DRAWING-01 (CDRG, CDREPAIR Apply)
   - #132 PIT-OUTLINE-02
   - #133 and #137 test follow-ups
   - #134 UC behaviour 02: CDEDIT accepts the CE pipe object (pass 6 X5); tidy-up no longer aborts on one unreadable pit
     (X2); "CE Inspector" wording (X6); CDTAG with nothing selected; downpipe failure wording; New Pit and Edit Pit
     signals for Codex's windows
   - #136 Feedback window
   - Structural `a93e2614`: the ribbon fix (#138: the handler dropped the clicked button) plus plain-English labels
3. **Backups:** `CE_CVL_SUITE_PRE_6eec48af_20260924-021323.backup`, `CE_SUITE_MANAGER_PRE_6eec48af_20260924-021323.backup`,
   `CE_STRUC_SUITE_PRE_bf264cbb_20260924-022426.backup`.
4. **Codex pass 7** (launched 02:25): items Y1-Y15; report `_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS7_2026-09-24.md`.
5. **INVALIDATES:** pass 6 X2, X5 and X6 (that code changed), and every Structural result from 5ca35054.
6. **Still known FAIL, not fixed:** X3 (one U after a PITEDIT resize). Investigated in #134, with candidate fixes named.
7. **Merged after this build, NOT installed:** #126 Drawing Standards windows.

## 24 Sep 2026 01:12 — Structural ROLLED BACK to `1.0.74+bf264cbb`; Codex pass 6 results

1. **Rollback:** Codex pass 6 (X8) found that no button on the organised Structural ribbon (`5ca35054`) opens
   anything, including Beam, RC Beam, Column, Footing, Rebar, Level/Section Mark, schedules and CE Settings. The release
   chat put the previous build back at 01:12, with AutoCAD closed twice. The failed build is kept as
   `CE_STRUC_SUITE_5ca35054_RIBBON_FAIL_20260924-011234.backup`. Civil and Manager are unchanged (`6eec48af`). Codex is
   diagnosing on `codex/struc-ribbon-fix` (from `claude/struc-d1-prep`).
2. **Pass 6 results:** gate PASS; safety readbacks matched at start and end. Report:
   `_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS6_2026-09-24.md`.
   - X1 CDWT-CONTRAST-01: **PASS**.
   - X2 C7-DRAW-01: **FAIL**. LIST shows CE_CVL_PIPE_OBJECT but Properties says Polyline, and the label tidy-up was
     skipped ("outline of object ... could not be read", a detention pit). New Pipe also said ready while Start Pipe was
     disabled; that is fixed by #129, which is not installed.
   - X3 PIT-OUTLINE-01: **FAIL**. One U after a PITEDIT resize left the enlarged pit and moved pipe end.
   - X4 SPLIT-HALVES-01: **BLOCKED**. No verified split was produced.
   - X5 LAYER-CASE-01: **FAIL, and more serious than the layer case.** CDEDIT refuses to select a CE pipe object, before
     and after the rename.
   - X6 RIBBON-02: **FAIL**. Water Tank is on the Draw panel and the tab reads CE Inspector, but the palette still says
     "Civil Properties" and "Existing Inspector".
   - X7 HELP-V3-01: **BLOCKED**. The v3.0 badge shows; the older-pages notice could not be reached by automation.
   - X8 Structural ribbon: **FAIL** (see 1).
3. **Routed:** X5, X2 tidy-up, X3 and X6 to the overnight Claude builder (`claude/uc-behaviour-02`, PR #134); X8 to Codex.

## LIVE since 23 Sep 2026 23:45 on Tim's PC — Civil `3.0.0+6eec48af`, Manager `1.1.0+6eec48af`, Structural `1.0.74+5ca35054`

1. **Installed by the release chat.** Civil + Manager 23:42-23:44 from master `6eec48af`; Structural 23:45 from candidate
   `5ca35054` (`claude/struc-ribbon-organised`, Modern SHA256 `F608578A...92783CB7E`). CE_SHARED is identical in Civil and
   Manager in all three lanes (D7E6BFC5 / 4DEA942A / 01ACC18C); Structural carries none. Modern natives: grip ARX,
   transform ARX, object DBX.
2. **Civil was deployed from `Installer\payload_build` without the release zip**, because `build_installer.ps1` hung
   twice at `Compress-Archive` (BUG-167). Every lane was built and checked before the hang, and all three read `6eec48af`
   before the copy.
3. **Carries, beyond 19:10:**
   - #117 HEADLESS-PROOF-01
   - #118 LAYER-CASE-01
   - #119 SPLIT-HALVES-01
   - #120 PIT-OUTLINE-01
   - #122 HELP-V3-01
   - #123 RIBBON-02
   - #124 CDWT-CONTRAST-01
   - #128 C7-DRAW-01
   - Structural's organised ribbon
4. **Backups:** `CE_CVL_SUITE_PRE_19c77126_20260923-234112.backup`, `CE_SUITE_MANAGER_PRE_19c77126_20260923-234112.backup`,
   `CE_STRUC_SUITE_PRE_bf264cbb_20260923-234521.backup` (all in `%APPDATA%\Autodesk\ApplicationPlugins`). Two earlier
   Civil backups from the hung attempts (`..._20260923-214427`, `..._20260923-231539`) are identical copies of 19c77126.
5. **Codex pass 6** (launched 23:50 by the release chat): re-runs X1-X8 for the items above; report
   `_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS6_2026-09-24.md`.
6. **INVALIDATES:** pass 5 results for CDWT's status line, the ribbon, Help and the Structural ribbon (their code
   changed). Pass 5's R-B (Manager) and R-C (criteria labels) stand: that code did not change. R-A-4 is still a
   known FAIL.
7. **Merged after this build, NOT installed:** #121 SPLIT-LEVEL-02, #129 UC behaviour (New Pipe readiness, CDCALC Unknown
   wording, drafting words, CDFALL/Spot Level Escape).

## LIVE since 23 Sep 2026 19:10 on Tim's PC — Civil `3.0.0+19c77126`, Manager `1.1.0+19c77126`, Structural `1.0.74+bf264cbb`

Adds, on top of 17:11 (none Tim-accepted; Tim's new rule: Codex-proven first, then his short final check). Installed at 18:01 and Codex PASS in pass 4: new pit labels and batch resize (Z8d), SBEAM (Z8a), older-pipe wording (Z8e). New at 19:10:

1. **CDEDIT-LEGACY-01** (PR #115): on a copy of an older drawing, double-click a pipe's level text. CE highlights the pipe's label and asks whether it is this pipe's label; Yes records it and opens Edit Pipe; next time it opens straight away; No changes nothing.
2. **MGR-STATUS-01** (PR #113): CEMANAGER shows Structural once, installed and running; Manager's own "Installed next start"; the footer "3 of 3 installed CE plugins running".
3. **CRITERIA-LABELS-01** (PR #114): CDCALC, Detention, Insert Criteria Block: the labels sit down the left beside their values; nothing at 0,0.
4. **P06-MESSAGES-01** (PR #116): the detention length prompt says "drawn length"; Enter keeps the drawn length.
5. **MODELSPACE-CASE-01 + IDENT-02** (PR #112): PIT twice: both number labels; both pits resize together; one Undo.

Pilot **candidate 4** at `_RELEASE_V3_PILOT\candidate-4-civil-19c77126`, 0 files differing from the live set.

---

## LIVE since 23 Sep 2026 17:11 on Tim's PC — Civil `3.0.0+9df46d7b`, Manager `1.1.0+9df46d7b`, Structural `1.0.74+4cb3c938`

Adds, on top of the 16:01 set (none Tim-accepted; Codex pass 3 re-runs them first):

1. **SBEAM-DBID-01** (Structural `4cb3c938`, branch `claude/struc-sbeam-fingerprint`): SBEAM places a steel beam on 2027. Steps: SBEAM on a copy of a structural drawing, any section, Place, one point. The section, hatch and label appear. One Undo removes the whole beam. Escape at the point leaves nothing.
2. **MGR-RUN-01** (PR #109): CEMANAGER, then Drawing Repair, then Project QA. Both pages open and show their counts and status line; AutoCAD stays open.
3. **CDWT-MATCH-02** (PR #110): CDWT, Underground, pick 3000 L Round after choosing a plan for it once. That plan comes first and the other 3000 L plans follow it. Then type 2510 in "or type litres": the 2510 L underdeck plan is selected and the gold line says one plan matches.
4. **D-01** (PR #108): CDDEST on a copy of an older drawing with DP labels. It says how many DP labels and downpipe blocks it can see and points to CDTAG. Nothing changes.

Read back by hand: CE_SHARED identical in Civil and Manager in all three lanes. Pilot **candidate 3** is at `_RELEASE_V3_PILOT\candidate-3-civil-9df46d7b`, 0 files differing from the live set.

---

## LIVE since 23 Sep 2026 16:01 on Tim's PC — Civil `3.0.0+a2f56f43`, Manager `1.1.0+a2f56f43`, Structural `1.0.74+aad3fe02`

Everything in the BUILT list below is now **installed**, plus **BUG-166** (double-click a level label) and **STRUC-TEXT-ORDER-01** (SBEAM places steel beams on 2027; the 25R/25L text from the same builder). Read back by hand: CE_SHARED identical in Civil and Manager in all three lanes; the Civil 2027 natives are present; Structural has its native module and no CE_SHARED. Backups: `CE_CVL_SUITE_PRE_aeb03763_20260923-155243.backup`, `CE_SUITE_MANAGER_PRE_aeb03763_20260923-155243.backup`, `CE_STRUC_SUITE_PRE_60c41228_20260923-160046.backup`. Pilot candidate 2: `C:\Lisp Files\_RELEASE_V3_PILOT\candidate-2-civil-a2f56f43` (0 files differ from the live set). Codex pass 2 runs Z8 first (SBEAM first).

---

## BUILT 23 Sep 2026 — on `master`, NOT installed yet (goes in at the next install, after Codex's current run)

1. **BUG-165** (PR #92): Manager never treats the old `2026.0420` build number as newer than 3.0. Nothing to click; Manager's trace log stops showing *"staging CE_CVL_SUITE → 2026.0420.1549"*.
2. **BUG-162** (PR #93): test only.
3. **G-02 / G-04** (PR #94, `db5c8517`): CDDESIGN looks through every folder in the job for the rating report, and offers the council from the job folder's suburb. Steps: `REGRESSION_LOG.md` G-02/G-04 and Codex list Part G.
4. **RIBBON-01** (PR #95, `45bec4be`): CE tab, Review panel, **Rainfall Curve** runs CDRAINFALL.
5. ~~CD-ESC-01~~ **WITHDRAWN, do not test** (PR #100). CD keeps its 10 Sep rule: Escape at point 3 cancels the pipe.
7. **MGR-OPEN-01** (PR #99, `26285f0f`): `CEMANAGER` opens the Manager window. Drawing Repair and Project QA open, with grey buttons like the rest.
6. **C7-LOG-01** (PR #98, `e3b95b50`): nothing to click. After a drawing says pipes were left as drawn, the CE log lists each one with its reason.
8. **G-04b** (PR #101, `8e17ab6e`): CDDESIGN finds the council in a council letter or permit in the job when the folder's suburb does not settle it. AutoCAD 2027 only. Steps: Codex list Part G, G3, G5 and G6.
9. **R-02** (PR #102, `40a1e509`): on AutoCAD 2022-2024, the CE CVL toolbar's Rules and Rulebook buttons show the ribbon's pictures. Tim's VM check, Part M6b.
10. **PIT-BATCH-01 + PIPE-EDIT-WHY-01** (PR #103, `659b6540`): select two pits, Edit Pit, and the batch editor opens (B-P5 again). Edit Pipe on a pipe with doubled labels says why in plain words (B-L3 again).
11. **LPD-NOWRITE-01** (PR #105, `e7a0af71`): `CDLPD`, type `CouncilP`: the message, and nothing on the drawing. Escape at the connection question: nothing on the drawing.
12. **CRITERIA-ANCHOR-01** (PR #106, `2a22c381`): CDCALC, Insert Criteria Block, pick a clear point: the table's top-left corner is at the pick.
13. **BUG-166** (PR #107, `a2f56f43`): double-click a pipe's IL label: Edit Pipe opens on that pipe. Ordinary text still opens AutoCAD's editor.

---

## LIVE since 23 Sep 2026 12:18 — `3.0.0+aeb037639f628e64a98e1cde4d86d2df38c45fcc` (master, PRs #89 + #90)

Installed by the release chat under Tim's standing override (*"from now until tuesday we build, test and deploy whenever we need"*), AutoCAD checked closed at 12:12:29 and 12:12:40 (Tim: *"AutoCAD is closed"*) and again by the script before build and before install.

**Read back by hand from all three lanes:** Legacy `DF49FD6C…`, Net8 `13A4C69E…`, Modern `9572839E…`, each `3.0.0+aeb03763…`. CE_SHARED copied into Manager lane for lane and hash-verified (Legacy `98ECCF14…`, Net8 `C3A92910…`, Modern `B746E17A…`). Natives in Modern: `CE_CVL_NATIVE_GRIP_2027.arx`, `CE_TRANSFORM_2027.arx`, `CE_CVL_OBJECTS_2027.dbx`. Manager `1.1.0+96e7d76a` and Structural `1.0.74+5d723d41` unchanged.

**Undo:** close AutoCAD; delete `CE_CVL_SUITE.bundle` and rename `CE_CVL_SUITE_PRE_b02f3ec7_20260923-121346.backup` back to it; do the same for Manager with `CE_SUITE_MANAGER_PRE_CESHARED_20260923-121346.backup` (both in `%APPDATA%\Autodesk\ApplicationPlugins`).

**What it adds over `b02f3ec7`:** BUG-164 (AutoCAD no longer crashes on close) and REL-BUILD-01 (build-file only). **Test:** Codex list Part C; Tim's steps in `REGRESSION_LOG.md` BUG-164.

**Note:** the existing `Deploy-Local-AsAdmin.ps1` also sets SECURELOAD=1 in the user registry for AutoCAD 2025-2027, as on every earlier install.

**12:32 — the shipping Manager and Structural installed too** (release chat's call: test what ships, from the start). By the REL-09 hand steps: old bundle renamed to a `.backup` name, new bundle copied in.

1. **Manager `1.1.0+aeb03763`**, all three lanes, 72 files (its own verified release candidate). Replaces `1.1.0+96e7d76a` (7 Sep). Backup `CE_SUITE_MANAGER_PRE_96e7d76a_20260923-123202.backup`.
2. **Structural `1.0.74+60c41228`** (Tim's 1.0.74 plus Codex's four window fixes), AutoCAD 2027 only, **built by the 2027 trial route so it keeps `CE_STRUC_NATIVE_2027.arx`** (the three-lane route leaves it out). Replaces `1.0.74+5d723d41`. Backup `CE_STRUC_SUITE_PRE_5d723d41_20260923-123202.backup`.
3. **CE_SHARED 1.1.0.0, byte-identical in Civil and Manager in all three lanes**; Structural carries none. The ProgramData Manager copy has no live manifest.

**Tests:** Codex list Part R (versions), Part Z steps Z9-Z21 (Manager and Structural) now run in pass 1.

---

## LIVE since 23 Sep 2026 09:36 — `3.0.0+d90659cf` on `claude/civil-merge-2026-09-23`

Tim: **"AUTOCAD IS CLOSED, DEPLOY"** (23 Sep, 09:34). AutoCAD checked twice, eight seconds apart, before
anything was touched: not running either time.

**Read back from all three lane DLLs by hand, not from the script's own output:**

1. **Legacy** (net48, AutoCAD 2022–2024) — `3.0.0+d90659cf25cee1bac8e9e106deb4a006f4e9fe7d`
2. **Net8** (AutoCAD 2025–2026) — same
3. **Modern** (net10, AutoCAD 2027) — same

Native modules staged in Modern: `CE_CVL_NATIVE_GRIP_2027.arx` (82 KB), `CE_TRANSFORM_2027.arx` (74 KB),
`CE_CVL_OBJECTS_2027.dbx` (108 KB).

### Tim's one-action undo — the backups

The deploy script does **not** back up. Both were taken by hand first:

1. **Civil:** `CE_CVL_SUITE_PRE_d0ffe1a2_20260923-093445.backup` — 133 MB, 806 files
2. **Manager:** `CE_SUITE_MANAGER_PRE_CESHARED_20260923-093445.backup` — 75 files

Both sit beside the live bundles in `%APPDATA%\Autodesk\ApplicationPlugins\`.

### CE_SHARED brought into step

The deploy script does **not** sync it, and every CE plugin shares one assembly identity — the first copy
AutoCAD loads wins for all of them. All three Manager lanes differed from Civil's and were copied across,
each hash-verified after the copy.

**STRUCTURAL IS NOT REDEPLOYED.** Its bundle still carries whatever CE_SHARED it was built with.

### What this build carries, beyond the previous live `d0ffe1a2`

1. All four September Civil chats — tanks, pipe text, levels, `CDFIXTAGS`, splits, CDTWL, the detention
   zero, the Council keyword.
2. The eight overnight fixes of 19 Sep, and the audit that corrected them.
3. The trunk's documents and the DATA-01 privacy clean-up (PRs #79/#80/#81).
4. **CD-RECENT-01** — the "Recent:" strip trimmed.
5. **DEPLOY-01** — the release script's reference paths, and a preflight that checks eleven inputs.

### What is NOT in it, said plainly

1. **The CD window layout fixes** — pipe preview still scrolls away, invert boxes and labels unchanged.
   That window was rebuilt since the branch they came from, so they are a redesign, not a patch.
2. **The pit-on-pipe preview programme** — 35,700 product lines and 108,990 test lines, never opened in
   AutoCAD. Deliberately not taken.
3. **The CDWT crash (W4)** — cause still not established.

### Still open on this register

`build_installer.ps1` does **not** build `CE_TRANSFORM_2027.arx`. It was built by hand before this release,
as every release has needed. The new preflight checks the project exists, which is not the same as building
it. Unchanged gap.

---

## BUILT 23 Sep 2026 — **CDMOVETEST** (E-HOLD-01 probe), branch `claude/e-hold-01-move-test` @ `42766dd9`, PR #88 — NOT installed, NOT tested

**Install decision (release chat, 23 Sep):** PR #88 stays off `master` until the colleague package is cut
(Thursday 24 Sep, 5:30pm), so this test tool never reaches a colleague. It goes onto Tim's PC after Codex's
second pass on the colleague package finishes, so it does not change the build under test. Area:
`areas\release-v3-colleagues.md`, Holds.

**What it is:** a test command, not a feature. It answers two questions before the hold-grade / hold-levels
work is built: (1) can CE's preview window open by itself right after a MOVE, STRETCH or grip drag, and
(2) can Cancel take the move back in one step, and what does one U take back after Apply. Built and
unit-tested (33/33 on net10); both lanes compile. **Use a TEST drawing — the test uses Undo.**

**Who installs it:** the release chat only (Tim, 23 Sep 2026: *"CE_ACAD / release-v3-colleagues / plan / 01 this chat controls deployment"*). **Tim's PC only — a test tool, never in the colleague build.** Release chat: note here when it goes in.

**Steps (AutoCAD 2027):**
1. **Setup:** a test drawing with two CE pits joined by one CE pipe.
2. **Run A — MOVE a pit, Cancel.** Type `CDMOVETEST`, Enter. Then `MOVE`, pick one pit, move it about 2 m.
   **Right looks like:** a window opens by itself, headed "MOVE TEST - nothing in this window is written"
   (ignore "IL 0.00"). Click **Cancel**: the pit and its pipe end jump back, and the command line says
   `Result 2 ... YES`.
3. **Run B — drag a pipe-end grip, Apply, then U.** `CDMOVETEST`, Enter. Click the pipe, drag one end grip
   about 2 m. The window opens; click **Apply**. Type `U`, Enter, once. Read `Result 3`. If it asks, `U` once
   more and read `Result 4`.
4. **Run C — STRETCH, Cancel.** `CDMOVETEST`, Enter. `STRETCH` with a crossing window over one pit and its
   pipe end, move 2 m. Window opens; **Cancel**. Read `Result 2`.
5. **Send Claude every line starting `[CE move test]`** (F2 shows them). A NO is a useful answer, not a failure.

**Steps (AutoCAD 2024):** Run A only, then send the lines.

---

## BUILT overnight 18→19 Sep — `claude/civil-overnight-2026-09-19` @ `07325a2b` — NOT INSTALLED, NOT TESTED

**Eight items, on top of the frozen combined payload `0a84eb07`.** Tim: *"overnight sequence for all fixes,
improvements and completion of all tasks from all 4 chats"*, then **"Go — all 8 items"** and **"No — just
build"**.

**`claude/civil-combine-2026-09-18` @ `0a84eb07` is UNMOVED and still deployable on its own** if any of the
overnight work proves wrong.

| ID | What Tim would see | Lane |
|---|---|---|
| **V1** | **Settings page: the standard LPD note now reads the full sentence**, not `LPD - {connection}, IL {invert} m AHD`. That stale setting is why every note came out short no matter what the code said | both |
| **V2** | `CDLPD` → type `Council` → the note reads **CONNECT TO COUNCIL PIPE AT APPROX IL…m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM…** — a sentence, not one short line | both |
| **V3** | **Type your OWN wording** into the Settings note box, save, close AutoCAD, reopen. **Your wording is still there.** CE must never overwrite it | both |
| **V4** | **Lock the layer the IL texts sit on**, run the invert propagation. It **names the pipes it could not update**, and `PITSCHEDULE` must **NOT** show the new levels for them — schedule and drawing must agree | both |
| **V5** | Unlock, run again: drawing and schedule move together. A pipe with **no** IL text still updates normally | both |
| **V6** | Make a write fail outright (lock the pipe's own layer): the refusal **names the pipe** it stopped on | 2027 |
| **V7** | Draft an orifice standard detail. **It must look exactly as always, with no new message.** If a message ever appears saying CE used the closest orifice detail it could find, tell me — the master was resaved | 2027 |
| **V8** | Convert a job's pipes (`CDC7UPGRADE`), set a converted pipe's level to **17.35**, Save. `PITSCHEDULE` shows **17.35**, **not a blank cell**. Reopen the drawing: still 17.35 | 2027 |
| **V9** | Same on an **ordinary** pipe: nothing about it has changed | 2027 |
| **V10** | **MOVE** a pipe that has `FALL` / `LEVEL` tags. The tag box **and its text** travel together. Then **grip** one. Then try a **turned** (diagonal) pipe | both |
| **V11** | Open Edit Pipe, change something, **Cancel**. The tag text goes back with its box, not left where the edit put it | 2027 |
| **V12** | **Then say whether O3 / O4 / O10 / O17 still happen.** If they do, this was not their cause and I will say so | 2027 |
| **V13** | Three pits in a line, `CD` one pipe through all three, **Yes** to the split. **BOTH lengths carry their own pipe text**, each mid-way along its own length, same side as before | both |
| **V14** | Same the other way: draw the pipe, then **drop a pit onto it**. Same result — that is the route Tim asked about, and it shares this code | both |
| **V15** | A **bent** pipe (3+ points), split it: the copied text sits **on** the pipe, not out in space | 2027 |
| **V16** | A pipe drawn with **simple pipe only** (no text): split it. **Neither half gains a text** | 2027 |
| **V17** | **One Undo** after a split removes the whole thing, copied text included | 2027 |
| **V18** | Check a copied text reads the right size and material. **If a half shows the wrong GRADE, say so** — that is the known limit of copying rather than re-rendering | 2027 |

### Ghost preview — NOTHING to test yet

`GHOST-01` built the **rule** only (Tim's ruling A, 18 Sep). **The picture panel is Codex's under ruling B and
is NOT built**, so Tim will see no change in AutoCAD. Contract:
`04_REFERENCE/contracts/CONTRACT_GHOST_PREVIEW_2026-09-18.md`.

---

## COMBINED 18 September 2026 — `claude/civil-combine-2026-09-18` @ `0a84eb07` — BUILT, NOT INSTALLED, NOT TESTED

**All FOUR Civil branches merged into one payload by the COMBINE chat. Nothing here is in AutoCAD.**
Morning pack: `archive/chat-records-2026-09/MORNING_PACK_COMBINE_2026-09-19.md`. Codex test list (76 steps):
`archive/chat-records-2026-09/CODEX_TEST_RUN_2026-09-18.md`.
Installed is still `3.0.0+d0ffe1a2`, read back from the DLL.

| Input | Tip merged | Note |
|---|---|---|
| windows / deploy `claude/civil-combined-2026-09-17` | `c9dac1bc` | base of the merge |
| other Civil areas `claude/civil-other-areas-handoff-d747af` | `24d9230f` | **forked beside the installed build at `e0cfe172`** — had to be merged, never built alone |
| K / L `claude/civil-k-l-2026-09-16` | **`dc937001`** | **NOT the handed-over `457bf032`** — that tip had already moved; `dc937001` adds the K4 Council-keyword fix Tim asked for on 18 Sep |
| fixes `claude/civil-fixes-2026-09-18` | **`c0ef58a6`** | merged 18 Sep after Tim said that chat had finished; its claims were verified from the diff, not from a handover (it never wrote a Section 4) |

**Proof held (§6 of the combine brief):**

- `git merge-base --is-ancestor` — `c9dac1bc`, `24d9230f`, `dc937001` **and the installed `d0ffe1a2`** are all
  ancestors of `ed5c7077`.
- Builds: **net48, net8.0-windows, net10.0-windows — 0 errors** each.
- Full net10 suite (final, all four merged): **10,052 run · 10,013 passed · 22 failed · 17 skipped.** Failing
  **names** set-compared against the 20 recorded distinct names: **identical — no new failures, none silently
  fixed.** All eight of the fixes chat's new guard tests ran and passed.
- `PreviewPackage_AllSections_RetainsStatusAndUsesAdvisoryWsudAuthority` — reported as a 23rd failure by BOTH
  the other-areas and K/L chats, both predicting it would clear once merged with BUG-158 (`308ea803`).
  **Confirmed by evidence: it RAN and PASSED on the combined line.** Prediction upheld.
- `MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` (the known flaky one)
  also **ran and passed**.

**Conflict resolution, stated so nobody has to re-derive it:**

- `Modules/Drainage/Commands/PipeEditCommand.cs` **auto-merged with no conflict** — the two chats edited
  different regions. Verified by hand, not trusted: the `vm.DryRunPreview =` assignment is **gone** from both
  `PipeEditCommand.cs` and `PitEditCommand.cs`; the separate `IsDryRunPreview` flag **survives**; the
  other-areas chat's `LevelBoxesAreAuthoritative` is **present**. Both behaviours kept.
- `REGRESSION_LOG.md` and `FLEET_STATUS.md` conflicted only because all three chats prepend entries to a shared
  tail. **Both sides kept in full**, newest first. No entry from any chat was dropped.

**Build gap worth recording (issue #78):** a fresh worktree fails the net10 lane with `MSB3030` until
`Modules/Shared.Transform.Native2027/CE_TRANSFORM_TRIAL_2027.vcxproj` is built with
`/p:ProductionIntegration=true`. It must be run through **PowerShell** — Git Bash rewrites the `/t:` and `/p:`
switches into paths and MSBuild fails with `MSB1008`.

**What Tim must test if this is installed:** the **76-step Codex list** at
`archive/chat-records-2026-09/CODEX_TEST_RUN_2026-09-18.md` (Tim, 18 Sep: *"all 40 for codex so make sure it knows what to
do"*). Parts S (start-up) · N (CDWT, 11) · P (pit number, 7) · O (pipe text, levels, CDFIXTAGS, splits, 25) ·
T (CDTWL, detention, PSD, CDLPD, 21) · X (2024 lane) · Z (regression sweep).

⚠️ **The CDWT crash (W4) is NOT fixed** — the fixes chat states its cause is not established and no fix was
attempted. Step **N9** is a probe, and a crash there is expected, not a regression.

---

## TESTED 16 September 2026 — MOSTLY FAILED. Read `decisions/2026-09-16_TEST_DAY_RESULTS.md` FIRST

`c1af9781` is live and Tim has tested it. **The deploy worked; most of what it carried does not.** Do not use
the 77-step list as a to-do — use the failure register in
**`decisions/2026-09-16_TEST_DAY_RESULTS.md`**, which is the authoritative record of what he found.

**Tim's instruction, 16 Sep:** ONE AREA AT A TIME. Priorities **`CDWT`, `CD`, `PIT`**, then test sections
**H, I, J, K, L**, then **M**. He has withdrawn trust in large batches.

### Original deploy note (kept for the record)

**Live bundle is `c1af9781`.** Deployed after Tim said "AutoCAD is closed, deploy". All three lane SHA256s
matched the staged payload and the lineage check printed nothing. **Nothing below has been tested in AutoCAD
by anyone** — that is the whole point of the list.

Use `archive/chat-records-2026-09/DEPLOY_AND_TEST_2026-09-16.md` section 3: **77 steps, A to O**, covering the whole
69-commit payload. Restart AutoCAD first.

### BUILT 18 Sep — **P12 / P14 / BUG-151 pit label**, branch `claude/civil-fixes-2026-09-18` @ `29d0598d` — NOT installed, NOT tested

Fixes register **P12** and **P14**, and almost certainly the long-running **BUG-151 / P-08** *"the label
won't step out"*. Builds net48 / net8 / net10 **0 errors**; full net10 suite **9,929 run · 9,890 passed ·
22 failed · 17 skipped — the same 22 names as the recorded baseline, compared by name. No regressions.**
Full entry: plugin `REGRESSION_LOG.md` **P12 / P14 / BUG-151**.

**What it actually was:** the pit label is a block holding the **circle**, with the **number** stored as an
attribute that has its own position. CE moved the block and never moved the number. The label *did* step
out — the circle went, the number stayed.

| # | What | Steps | Lane |
|---|---|---|---|
| P12 | **Resize: number goes with the circle** | Open DWG-B. `CDEDIT` on **P10**, change **450 × 450 → 1200 × 1200**, Save. The circle **and** the number move together; the number stays centred in the circle. | 2027 **and 2024** |
| P14 | **Corner change: same, with no resize** | `CDEDIT` **P10**, change only the **label corner Top right → Bottom right**, Save. The number goes with the circle. | 2027 **and 2024** |
| P12b | **The other label block** | Same test on **P1** or **C1** (they use `PIT LABEL`, not `PIT LABEL 2`). | 2027 |
| P12c | **Two pits at once** | Resize two pits in one go. **Both** numbers travelled. | 2027 |
| P12d | **One change = one Undo** | After an accepted resize, one `U` puts it back. | 2027 |

**NEW, NOT FIXED — worth knowing:** a second probe on the same drawing found **240 of 387** other blocks
also carry their text as attributes — the **FALL / grade** label, the **LEVEL** texts, **DP** and **WT**
tags. Two pipe paths move those blocks the same way the pit label was moved. That is a **strong candidate**
for register items **O3 / O4 / O10 / O17** ("MOVE and grip break label alignment") — but it is a hypothesis,
nobody has reproduced those items against it, and it needs a full rotate-and-move rather than the simple
fix used here. **Not touched.**

### BUILT 18 Sep — **W-09 / W-10 CDWT tank plans**, branch `claude/civil-fixes-2026-09-18` @ `d95e7342` — NOT installed, NOT tested

Fixes register **W2** (blank tile pictures, short list) and the **no-ghost** half of **W4**. Cut from
`claude/civil-combined-2026-09-17` @ `c9dac1bc`. Builds net48 / net8 / net10 **0 errors**; 149 WaterTank
tests pass. Full entry: plugin `REGRESSION_LOG.md` **W-09 / W-10**.

Measured against Tim's own `CE Civil WATER TANKS PLAN.dxf`: **39 plans read · 29 offered before · 39 now ·
39 with a picture · 39 with a real size · 0 using the caption as a block name.**

| # | What | Steps | Lane |
|---|---|---|---|
| W-09a | **Every tile has a picture** | `CDWT`. No tile is blank. | 2027 |
| W-09b | **Nothing is missing from the list** | `CDWT`. Count the tiles: **39**, not 29. Look for **GRAF CARAT**, **AQUARIUS**, **WT1** and **PLAN VIEW** — all four were being dropped. | 2027 |
| W-10 | **Three PLAN VIEW tanks — Tim's eye needed** | Three tiles read "PLAN VIEW  (7560 x 4800 mm)", "… 2" and "… 3". They are three different plans in your master. **Say if you want them named properly** — that means moving titles in the master, not changing CE. | 2027 |
| W-09c | **The ghost comes back** | Pick **2510L UNDERDECK WATER TANK**, set a detention share, **Place tank**, pick an insertion point. **A ghost of the real tank follows the cursor.** That is the exact tile that failed on 16 Sep. | 2027 |
| W-09d | **The right block lands** | Finish the placement. The block on the drawing is the one in the picture. | 2027 |
| **W4-PROBE** | **The crash — NOT fixed, this is a 30-second probe** | Place a tank, and press **Enter** at the callout prompt instead of picking a point. **Does it still crash?** If it completes, the callout pick is the suspect; if it crashes anyway, it is elsewhere. Either answer tells me where to look. | 2027 |

**Not claimed fixed:** the `AutoCAD cannot continue` crash in W4. It is an unmanaged fault — CE's own error
handling cannot see it and there is no CE log line for it — so its cause is **not established** and no fix
has been attempted. The probe above is how we settle it.

### BUILT overnight 17 Sep - branch `claude/civil-combined-2026-09-17` @ `28464fbd` - NOT installed

Windows chat. Three CDWT faults found by opening the real master and the rendered window. Full detail in the
plugin `REGRESSION_LOG.md` (**W-06**, **W-07**, **W-08**) and
`archive/chat-records-2026-09/MORNING_PACK_WINDOWS_2026-09-18.md`. Builds 0 errors on all three lanes; full net10 suite
**9,918 run · 9,879 passed · 22 failed · 17 skipped** - the same 22 names as the baseline, compared by name.

| # | What | Steps | Lane |
|---|---|---|---|
| N1 | **Tank tile names are right (W-06)** | `CDWT`: no two tiles carry the same tank name at different sizes; exactly **one** "KINGSPAN 6000 L SLIMLINE METAL TANK"; no tile starts with a code like `xsm1;` | 2027 |
| N2 | **Untitled tiles are honest (W-06)** | Two tiles read **"Untitled tank plan"** with a size and a picture - those plans have no title in the master. **Tim: say if you want them named** | 2027 |
| N3 | **The MELRO pair - Tim's eye needed (W-06)** | 4500 and 5500 MELRO now attach to different blocks (4500 -> 5600x1760, 5500 -> 4622x1760). Check against the master; if wrong, the master's titles need moving, not CE | 2027 |
| N4 | **Empty Standard Details folder (W-08)** | Settings -> point the folder at an empty one -> `CDWT`: reads "No tank plans found", names the drawing, offers both ways out. **No empty black panel.** "Tag a block already in the drawing" still asks for the block. Put the folder back: tiles return | 2027 |
| N5 | **Nothing else about CDWT moved** | Place a tank normally: tank, detention share, plan, Place tank, insertion point, callout/riser/dropper, Base RL - as before | 2027 |
| N6 | **The tank detail warning (W-07)** | Nothing to do in normal use. If the master is ever resaved, `CDWT` prints *"The usual water tank detail was not in ... CE used the biggest tank detail it could find instead"* rather than quietly drafting a different detail | 2027 |

**Not fixed, contract written:** double-clicking a pipe **label** opens the OLD editor, not the one-page
window (needs 823 px against an 820 cap - three pixels). `CdDialog.xaml` is Codex's file under ruling B, so
the measurement and the contract are in the plugin at
`docs/workflows/CD_LABEL_TAB_FIT_CONTRACT_2026-09-17.md`. Building it clears **five** of the 22 red tests.

### SUPERSEDED 20 minutes later by `d0ffe1a2` — see below. `081c82b6` was live 22:31–22:57 only.

### LIVE since 16 Sep 22:57 — `d0ffe1a2` on `claude/civil-combined-2026-09-17`

`081c82b6` **did not contain two commits Tim had already been answered on.** The K/L branch had moved to
`26432227` after the tip that was handed over, carrying `L-01b/L-02b` (**both** Council Pit wordings offered,
note moved to `25TEXT`) and `L-02c`. Those are now in, plus **F1-06** (Tim, 17 Sep: the rainfall warning
appears *"once"*).

All three lanes read `3.0.0+d0ffe1a281808c1837375785351581610dcc9c51`. Manager's `CE_SHARED` re-synced.
Backup is still `CE_CVL_SUITE_PRE_6505fb5a_20260916_222407.backup`.

Builds: net48 / net8 / net10 **0 errors**. Full net10 suite: **9,904 run · 9,864 passed · 23 failed ·
17 skipped**. The 23rd is `MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`
— *"The PDF renderer produced only blank page(s)"*. **It passes 15/15 when its fixture is run on its own**,
and this payload changes no PDF or markup code. Recorded as **flaky under full-suite load, not a regression**
— not as "pre-existing", because it did not fail in the 22:31 run of the same suite.

**Tim's four answers of 17 Sep:**

| | Tim | State |
|---|---|---|
| `COUNCIL PIT` vs `EXISTING COUNCIL PIT` | *"both are necessary"* (and *"both are options"*, 16 Sep) | **Both offered** — `CouncilPit` and `ExistingCouncilPit`, in `d0ffe1a2` |
| Sump tick wording | *"yes"* | Already built (PIT-TWEAKS-01) — no change |
| Two tanks on one system | *"i have confirmed two tanks on one detention system"* | Already built (item 66) — no change |
| Rainfall warning twice | *"once"* | **Built in `d0ffe1a2`** (F1-06) |

**Still open and NOT decided:** the note's wrap width — Tim asked to *"show me the different variations"*,
five widths were drawn for him on 17 Sep and **he has not picked one**.

**Installed, NOT tested.** The ONE list: `archive/chat-records-2026-09/CODEX_TEST_RUN_2026-09-17.md`; drawings named in
`C:\Users\TimothyBrand\CE_TEST_DRAWINGS_2026-09-17.md` (outside every repo, DATA-01).

### LIVE since 16 Sep 22:31 — `081c82b6` on `claude/civil-combined-2026-09-17` (ALL THREE overnight chats, one payload)

Tim: *"AUTOCAD IS CLOSED, DEPLOY"*. Merge of `claude/ce-civil-handoff-sept-16-5623ca` @ `17847985` (windows),
`claude/civil-other-areas-2026-09-16-1c1ae6` @ `e0cfe172` (C7 / labels) and `claude/civil-k-l-2026-09-16` @
`0ed39495` (K/L). All three lanes read `3.0.0+081c82b6315c43213f1a699c3d1421fd8c795790`.
Backup: `CE_CVL_SUITE_PRE_6505fb5a_20260916_222407.backup`. Manager's `CE_SHARED` brought into step
(backup `CE_SUITE_MANAGER_PRE_CESHARED_20260916_223259.backup`); **Structural is NOT redeployed**, so the
Structural half of PERF-003 is not live.

Builds: net48 / net8 / net10 **0 errors**. Full net10 suite: **9,899 run · 9,860 passed · 22 failed ·
17 skipped** — the 22 known names, all in test files this payload never touched (list below).

**Installed, NOT tested.** The ONE list for this build is
**`archive/chat-records-2026-09/CODEX_TEST_RUN_2026-09-17.md`** — 90 steps in parts S/W/C/P/O/K/L/F/R/M, being run by
Codex driving AutoCAD. It supersedes rows L8–L18, O1–O15 and K1–L11 below as the thing to work from;
those rows stay for the record.

<details><summary>The 22 known failures, by name (recorded 17 Sep — this baseline did not exist before)</summary>

AddSystemCommand_Execute_AddsAnotherSystem · AddSystemCommand_Execute_NameIsSystem2 ·
AddSystemCommand_Execute_SelectsNewSystem · BackTest_GlenEira24115_Computed_WithinTolerance ·
BoydsDetentionRequired_Changed_PropagatesBoydsSuggestedVolumeToAllSystems ·
CdEnterAfterTwoPickedPoints_FinishesTheRouteInsteadOfCancellingIt ·
CompiledDefaultSourceCallersNeverOptIntoPitPlanPlacement ·
Copy_GivesTheCloneItsOwnIdentityDuringReconciliation ·
EveryTabFitsOrUsesExplicitFallbackAtOfficeScaling (×3 cases) ·
ExistingEngineeringAndInteractionRulesRemainInTheProductionCommands ·
FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision ·
GetPanels_KeepsEveryVisibleCivilCommandReachable ·
IMP014_OnDocumentToBeDestroyed_GatesUnhookOnIsDatabaseAlive ·
InternalCivilCommands_RebuildOnlyAfterAnAcceptedPipeChange ·
NativeQueue_StoresIdentityContractAndRechecksItBeforePreviewAndWrite ·
PendingValuesKeepThePriorDisplayEnvelopeAndEveryComparisonFits ·
RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure ·
Registration_ProjectsOnlyAfterCanonicalPipeAndOwnerRecordsAreWritten ·
SelectedLabelStillFitsThePrevious1080p125PercentEnvelope ·
SpineReader_WiresListedVisibleReciprocalMTextIntoTheBoundedResolver

</details>

### LIVE since 16 Sep 16:06 — `6505fb5a` on `claude/ce-civil-handoff-sept-16-5623ca` (LAYOUT-01 · PIT-PREVIEW-01/02 · CD-PREVIEW-01 · BUG-159 CDGRIPDIAG)

Tim: *"AUTOCAD IS CLOSED, DEPLOY"*. All three lanes read `3.0.0+6505fb5a`. Backup: `CE_CVL_SUITE_PRE_0737efa3_20260916_160353.backup`.
**Installed, NOT tested.** Rows L1–L7 below are the list, plus the BUG-159 rectangle test in the plugin repo `docs/workflows/BUG159_DEPLOY_HANDOVER.md`.

Full entries: plugin `REGRESSION_LOG.md` LAYOUT-01, PIT-PREVIEW-01, PIT-PREVIEW-02, CD-PREVIEW-01.

| # | What | Steps | Lane |
|---|---|---|---|
| L1 | **CD window uses the whole window** | Double-click a stormwater pipe. Engineering left, Drafting right, PLAN PREVIEW reaching from just under the fields to just above the buttons. No empty black band. All five buttons visible, no scrolling. | 2027 |
| L2 | **Nothing pushed off on the busy cases** | Same on a detention pipe with twin pipes on, and on a pipe with a linked IL label. Type a value → More… → Back: value still there. | 2027 |
| L3 | **PIT centre preview is the wide column** | Double-click a pit. Centre PLAN PREVIEW clearly wider than either side column. Both "Bottom right" position lists on the right fully readable, not cut off. | 2027 (and 150% scaling if you can) |
| L4 | **Fit guard** | If the command line prints "The tabbed editor does not fit this AutoCAD work area", report which window and your monitor/scaling. | 2027 |
| L5 | **PIT preview shows every connected pipe (PIT-PREVIEW-01, `d5f41362`+)** | Double-click a pit with 2+ pipes: each pipe is a grey stub on the wall it enters, square to the wall, with "size · Entering/Leaving · IL" at its end. Pick another pipe in the list: its stub goes gold. A pipe with no IL reads "IL Unknown". A pipe CE cannot place is listed top-left as "Not placed: … – reason" with no stub. Change the pit size: stubs stay on the walls. | 2027 only |
| L6 | **PIT preview is the real plan around the pit (PIT-PREVIEW-02)** | Double-click a pit on a real drawing: the centre picture is the actual plan, north up, pit centred, ~3 pit-widths across, sharp. Tags (no stub lines) at each placed pipe's wall point with "size · Entering/Leaving · IL"; picked pipe goes gold. Change pit size: redraws. Opening must not feel slower; say by how much if it does. Try a drawing with an xref underneath and report whether it shows. A NEW unplaced pit shows the block + stubs instead. | 2027 only |
| L7 | **CD preview is the real plan along the pipe (CD-PREVIEW-01)** | Double-click a pipe between two pits: the PLAN PREVIEW band is the actual plan along it, north up, both pits in view, sharp. Gold ring + caption "pit · IL" at each end; type a new invert and the caption changes at once. A pipe ending at an IO/DP/LPD shows the real symbol. A 3+ vertex pipe shows the whole run. A NEW pipe still shows the old schematic. Opening must not feel slower. NOT yet shown: where pipe text / invert text / arrow will land (next item). | 2027 only |
| L8 | **PIT-CONN-01 - pit lists its pipes again** (built, NOT installed) | Edit Pit P10 on the same drawing: Connected pipes shows the P10→P9 pipe with size and IL, and its tag sits on the picture at the wall. Edit Pit P9: same pipe, Entering. A pit with no pipes still says so. | 2027 |
| L9 | **CD-PREVIEW-01a - New Pipe shows the real plan** (built, NOT installed) | CD, pick the route: the window opens with the plan along the picked points and End 1 / End 2 captions. | 2027 |
| L10 | **POLISH-01 - CD/PIT windows tidied** (built, NOT installed) | Edit Pipe: level row on one line ("Set Upstream 19.45 m AHD"), header chip one line, plain wording under the levels. Edit Pit: label row + one status line under it, two readout lines under the picture, no duplicate "no pipes". Say what still looks wrong. | 2027 |
| L11 | **PIT-TYPE-01 - stormwater pipe no longer called CHARGED in the pit list** (built, NOT installed) | Edit Pit P10: list reads "P10 → P9 · Entering/Leaving · IL 19.450" and the pit IL suggestion strip appears. Save the pipe unchanged, reopen the pit: still not charged. A real Charged pipe still reads CHARGED. | 2027 |
| L12 | **CLICK-01 - click the picture to select** (built, NOT installed) | Edit Pit with 2+ pipes: click a pipe tag on the picture, the list changes and the tag goes gold. Edit Pipe: click the downstream ring, the cursor lands in the downstream level box with its value selected. | 2027 |
| L13 | **DRAG-01 - drag the corner badge** (built, NOT installed) | Edit Pit: drag the gold badge to the top-left of the picture and release: badge sits top-left, the Pit label corner list reads Top left, cover-text list unchanged. Pick "Cover text" in the footer list, drag to top-right: only the cover-text corner changes. Cancel: nothing moved on the drawing. | 2027 |
| L14 | **DRYRUN-01 - the picture shows what Save would do** (built, NOT installed) | Edit Pit: 450→1200, wait 1 s: bigger pit + stepped-out label in the picture; change label corner: label moves. **Cancel, then `U` once: only your previous real edit undoes - anything else, stop and report.** Edit Pipe: change diameter + text side, wait: text reads the new size on the new side, arrow where Save puts it; type a new IL: it changes. Type fast: no per-keystroke flicker. Blank the pit size: falls back to the plan as-is, no error. | 2027 |
| L15 | **PIT-TWEAKS-01 - tick, size drop-down, sump tick** (built, NOT installed) | Edit Pit: Plan size is a drop-down of your ladder (450/600/900/1200/1500); pick 900 → picture redraws; type 700 → accepted. Bottom row tick reads "Sump pit · own bottom IL": unticked = grey box; ticked = box opens. Save, reopen: kept. **Confirm "Sump pit" is what you meant.** | 2027 |
| L16 | **CDWT-W01 - tank window first, and it opens** (built, NOT installed) | `CDWT`: the window appears IMMEDIATELY (no "Adopt or Insert" at the command line first). Above ground ticked; list smallest first with dimensions; tick Underground → list changes. Pick tank, detention, plan → Place tank → insertion point with ghost → callout/riser/dropper → Base RL. "Tag a block already in the drawing" closes the window and asks for the block. Cancel: nothing placed. If the command line asks Adopt/Insert first, paste the [CE] line. | 2027 |
| L17 | **BUG-158 / F1 - the computations sheet is a CE sheet** (built, NOT installed) | `CDCALC` → Export PDF → print to PDF → **open the PDF**. Page 1 = CE letterhead sheet: logo top-left, CREATIVE ENGINEERING / DRAINAGE COMPUTATIONS top-right, job strip, then BASIS OF DESIGN → ON SITE DETENTION → STORAGE PROVIDED → VOLUME tables → ORIFICE → WHERE THESE FIGURES CAME FROM. No "Note:", no blank cover, no repeated detention page. Export XLSX: "Computations" tab reads the same. | 2027 |
| L18 | **CD-TICKS-01 - level Set buttons are ticks** (built, NOT installed) | Edit Pipe: level row reads "☐ Upstream 19.45 m AHD"; untick → box greys; tick → opens. Save, reopen: as left. | 2027 |

### Branch `claude/ce-civil-handoff-75-percent-671a19` — IFD-01 · D2 · F1/F2 · BUG-156 (built overnight 15–16 Sep 2026)

Owner: the Civil behaviour chat. **Use `archive/chat-records-2026-09/DEPLOY_AND_TEST_2026-09-16.md` section 3 — it is the
ONE consolidated list for the whole 69-commit payload, including everything in the folded-in table above.
The rows below are a summary of this chat's own part only.**

| # | What | Steps | Lane |
|---|---|---|---|
| R1 | **`CDRAINFALL` — a job carries its own rainfall** | New command. Run it on a job with no curve: it must SAY it is using the office Melbourne curve and warn that it reads 7–9% high. Load `SAMPLE_2_lighter_place.txt`, answer No (nothing changes), then Yes. Reopen the drawing — the curve is still there. | Both |
| R2 | **A bad block is refused, nothing stored** | `SAMPLE_4_BROKEN_only_three_rows.txt` → "needs 7 rows… 3 rows found. Nothing has been stored." `SAMPLE_5_BROKEN_wrong_order.txt` → refused for being out of order. The previously stored curve must be untouched. | Both |
| R3 | **The rainfall actually changes the design** | `CDDESIGN` with no curve, note the storage required. Set the 18%-lighter curve, run again — **storage required must go DOWN**. Set the same-as-office curve — it must return to the original figure. | 2027 |
| R4 | **CDCALC produces the computations sheet** | `CDCALC` → Export PDF / XLSX. The export now LEADS with a CREATIVE ENGINEERING / DRAINAGE COMPUTATIONS sheet (XLSX tab "Computations"): header, basis of design naming the rainfall curve, PSD and storage required with the council in brackets, the storage split, VOLUME OF PIPE and VOLUME OF PIT tables, an ORIFICE block, and WHERE THESE FIGURES CAME FROM. | 2027 |
| R5 | **The sheet warns, never blocks** | Leave the council unset and export: the sheet still comes out, PSD reads **"not known"** and never `0`, and the last block names it as not established. Make the storage short on purpose — it must say **by how much**. | 2027 |
| R6 | **Plate height says "not known"** | On the ORIFICE block, plate height is deliberately "not known" — CDCALC holds the head, not the plate height, and CE will not work one backwards. Confirm the head, diameter, Co and flow are all present. | 2027 |
| R7 | **BUG-156 — a redesign stops forgetting** | Record a downpipe destination (`CDDEST`), answer the split question, set a rainfall curve. Run a network redesign and apply it. All three must survive. Before this fix all three were lost. | 2027 |
| R8 | **Nothing that already worked has moved** | A job you know well with NO rainfall curve set must produce **exactly the same** detention numbers as before. Any movement at all is a fault. | Both |
| R9 | **The 2024 lane** | R1 and R8 on AutoCAD 2024 — 2022–2024 users are in scope. | **2024** |


### FOLDED IN — `claude/c7-one-object` @ `9058a405` is inside the batch below

> **Do not test from this table.** Every row of it is now part of
> `archive/chat-records-2026-09/DEPLOY_AND_TEST_2026-09-16.md` section 3, which is ONE list covering the whole payload
> (Tim's ruling, 14 Sep). `9058a405` is an ancestor of `d6aa4dbf`, so deploying that batch installs all of
> this too. The rows are kept below only so nothing is lost; the steps in the deploy document are the
> current ones.
>
> **Row 14's hold is lifted.** `CDTWL` was held because it asserted a top water level instead of offering
> candidates. It now offers them (commit `a5dce440`), so it is testable — see section E of the deploy
> document.

#### Original rows, superseded by that document

Owner: the Civil behaviour chat. **Requires the API-v3 enabler to be rebuilt and shipped with it.**

| # | What | Steps | Lane |
|---|---|---|---|
| 1 | **BUG-154 — CDFW/CDSOURCE place again** | In the job that failed: `CDFW` at a free point, then on a pipe run, then on a free pipe end. Each must place. | Both |
| 2 | **The repeated-name offer** | After each placement the command line names the repeated source name, says **nothing was stopped by it**, and offers `CDFIXTAGS`. | Both |
| 3 | **`CDFIXTAGS`** | It lists the repeated names and their blocks, proposes renames, changes nothing on **No**. Run again, answer **Yes**, check the renamed blocks show their new labels. | Both |
| 4 | **Split on draw** | Three pits in a line; draw ONE pipe through all three. It asks once — answer Yes. You get four pipes, four schedule rows, and the middle pits have a pipe in and out. | Both |
| 5 | Split on draw — memory | Draw another across pits: **it must not ask again**. In a NEW drawing answer **No** first time; it stays one pipe and does not ask again. | Both |
| 6 | Split on draw — edge cases | A pipe that starts and ends on pits but crosses nothing: says nothing, splits nothing. **Escape** at the question: nothing split, pipe intact. | Both |
| 7 | **Converted pipe split (C7 3d)** | `CDC7UPGRADE` a pipe, then `CDFW` on it. Both halves must be CE pipe objects. **Move the top half aside and check there is no stray pipe underneath** — that is the whole point. | 2027 |
| 8 | Converted split — annotations | Labels and invert texts end on the correct halves; the new invert appears both sides of the floor waste. A **twin barrel** still draws as twins after the split. | 2027 |
| 9 | Ordinary pipe unchanged | Do the same on an unconverted pipe and confirm nothing about it changed. | Both |
| 10 | **Pit label on resize** | PITEDIT a 450 pit to 1200. The label circle steps out and **keeps its distance from the pit**, like the cover text. Check the CE log line `ShiftAnnotation [pit label]`. | Both |
| 11 | **`CDDESIGN`** | Asks only for what is missing; makes you confirm the legal point of discharge; refuses a roof area larger than the site **without shrinking your number**; finishes saying nothing was drawn. **Confirm the drawing is untouched.** | Both |
| 12 | **LPD note** | `CDLPD`, pick the street pipe end. The list now offers **CouncilStub, ExistingStub, Easement** as well as Kerb/CouncilPipe/SideEntry. Choose CouncilStub — the callout must read `CONNECT TO COUNCIL STUB AT APPROX IL<level>m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM ALL LEVELS PRIOR TO THE COMMENCEMENT OF WORK.` with the level to **two decimals**. | Both |
| 13 | LPD — unknown level | Run it on a pipe end whose invert is **not set**. The note still appears and simply leaves the level clause out — no `IL m`, no zero. | Both |
| 14 | **`CDTWL`** | ⚠️ **Hold** — the TWL rule was reopened 15 Sep (a trench grate can sit above the highest pipe obvert). Do not test until the command offers the candidates rather than asserting one. | — |

### Codex window candidates — not installed

| # | What | Status |
|---|---|---|
| 15 | PIT input pages / no-scroll | **Measured failure open**: detention at 900 × 600 overflows by ~5.4 layout units. Not committed, not deployed. |
| 16 | UI connection recovery (`af0cd66a`) | 19 of 25 wanted corrections recovered. **Not a Structural replacement** — it deletes the installed SBEAM runners. |
| 17 | Structural preservation (`60c41228`) | Built and checked, **not installed**. Preserves SBEAM commands. |

---

## ALREADY LIVE AND STILL UNTESTED — `10ac480d`, installed 15 Sep 14:46

| # | What | Steps | Lane |
|---|---|---|---|
| 18 | PIT block preview, taller pane (`63bc7207`) | Open PIT. **Check nothing scrolls** and everything is visible on open. Tim has reported a scrollbar is present — Codex owns this. | 2027 |
| 19 | PIT preview in 2024 | Old schematic/text remains usable; no renderer error. | **2024 — never tested** |

---

## ACCEPTED — keep the record, do not re-test without a reason

| What | Build tested | Date |
|---|---|---|
| CDPARTS Save and Reset to Defaults (BUG-152/153) | `10ac480d` | 15 Sep 2026 — recorded on #78 |
| PIT block preview, original rendering — **7 of 8 checks** | `6a6d6bc7` | 15 Sep 2026 — #75. The 2024 check stays open |
| C0 managed Slide/Offset/Flip grips and twin/MLINE selection, bounded Test Day 2 | `9050f497` | recorded on #26 |

### BUILT 16→17 Sep overnight — branch `claude/civil-other-areas-2026-09-16-1c1ae6` @ `3bc94c78` (other Civil areas chat) — NOT installed, NOT tested

Steps written for a stranger are in the plugin `REGRESSION_LOG.md` entries **C7-POLY, IDENT-01, PLACE-01, C7-2024**. Summary rows:

| # | What | Test (2027 unless said) | Lane |
|---|---|---|---|
| O1 | Pipes become CE pipe objects on open | Open a COPY of a job: one line `[CE] N pipe(s) upgraded to CE pipe objects ... Backup: ...`; `_PRE_C7_` file beside it; reopen → no second line, no second backup | 2027 |
| O2 | The object is ONE polyline-like thing | Click a pipe: band + magenta walls, vertex grips only, LIST says `CE pipe P3: 3 points, 225 mm wide` | 2027 |
| O3 | Text follows the object | MOVE a pipe 2 m: pipe text, both IL texts, arrow move with it; grip an end: same at command end | 2027 |
| O4 | CDFW on a converted pipe | Split happens, two objects, no stray polyline under either half (move one half aside) | 2027 |
| O5 | CD draws the object | `CD` a pipe: one object at once; one U removes pipe + labels | 2027 |
| O6 | Twin | After open a twin is ONE object drawing two barrels; grip-move it; no stray barrels | 2027 |
| O7 | CDEDIT width | 100 → 150: walls widen, no MLINE appears | 2027 |
| O8 | Migration | The 16 Sep test copy (51 morning-objects): open → "migrated" in the line; pipes still work | 2027 |
| O9 | IDENT-01 | `CD` a pipe, grip-drag its end straight away: labels follow; no "identity" line in the log | 2027 |
| O10 | PLACE-01 draw | `CD` a pipe whose start lands 100 mm from a big pit's edge: the start IL text sits one step further in (log `route=draw ... in from the pipe end (1)`) | 2027 |
| O11 | PLACE-01 pit | `PITEDIT` 450 → 1200 on a pipe: IL text slides in; past 500 mm it flips (`route=pit-boundary`) | 2027 |
| O12 | PLACE-01 pipe | MOVE a pipe so its label crosses another pipe: label slides clear; report names `pipe P9` | 2027 |
| O13 | PLACE-01 callout | MOVE a pipe so its callout text lands on IL text: text moves, leader still starts on the pipe | 2027 |
| O14 | PLACE-01 settings | CDSETTINGS → LABEL PLACEMENT: 900 refused; 300 → IL text flips instead of a second slide | 2027 |
| O15 | 2024 enabler | Needs an AutoCAD 2024: ARXLOAD `CE_CVL_OBJECTS_2024.dbx`, open a 2027-saved drawing with pipe objects: pipes draw, one object, no proxy warning | 2024 |

### BUILT 16→17 Sep overnight — branch `claude/civil-k-l-2026-09-16` @ `0ed39495` (sections K and L chat) — NOT installed, NOT tested

Steps written for a stranger are in the plugin `REGRESSION_LOG.md` entries **L-01, L-02/L-03, P-08/item 64,
item 66, item 67, AUDIT-K-L**, and collected in `archive/chat-records-2026-09/MORNING_PACK_K_L_2026-09-17.md`. Summary rows:

| # | What | Test (2027 first; 2024 builds clean but is unrun) | Lane |
|---|---|---|---|
| K1 | `CDLPD` offers **Council Pit** | `CDLPD` on a street pipe end: `CouncilPit` is in the list; note reads `CONNECT TO COUNCIL PIT AT APPROX IL<lvl>m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM…` | both |
| K2 | The old `Council` word still works | `CDLPD`, type `Council` → still gives COUNCIL PIPE | both |
| K3 | An unknown word writes nothing | `CDLPD`, type `Banana` → "not recognised", **nothing written**. Must NOT quietly write a kerb note | both |
| K4 | The note is an **MLeader**, wrapped | Note sits where you picked, **wrapped ~5 lines**, leader + arrow back to the **pipe end**, same look as a CD pipe callout. Not one long line; leader must not shoot to the drawing origin | both |
| K5 | **No invert set → no level clause** | `CDLPD` on an end with no invert: `CONNECT TO COUNCIL STUB TO COUNCIL SATISFACTION. BUILDER TO…` — no `IL`, no `0.00`, no gap | both |
| K6 | COUNCIL PIPE does not break mid-sentence | `CDLPD` → `CouncilPipe`: `CONNECT TO COUNCIL PIPE AT APPROX …` runs on. Must NOT break the line after PIPE | both |
| K7 | One note, not two | Run `CDLPD` twice on the same end → one note. `U` once removes note + leader | both |
| L1 | **Pit resize re-snaps the pipe ends** (was broken) | 450 pit with ≥2 pipes in → `PITEDIT` → 1200 × 1200 (**both** boxes) → every pipe stops at the **new** outline; none stranded inside, none poking through | both |
| L2 | Label and cover keep their distance | Same resize: label circle and cover text step out, same clear gap from the pit edge | both |
| L3 | Undo, and shrink | `U` once → size, label, cover, pipe ends all go back. Then 1200 → 450: label + cover come **in**, pipe ends come in with them | both |
| L4 | If L2 still looks wrong, the log now answers it | `%APPDATA%\CE_CVL_SUITE\logs\`: `PITEDIT Resize:` names size **from** and **to**; each `ShiftAnnotation` line prints `gapBefore=` / `gapAfter=`. Same numbers = the ruling held | both |
| L5 | **Every tank counted** | `CDTWL` on a job with 2+ tanks on one system: total goes **up**; report says *"This system has 2 tanks (WT1, WT2). All of them are counted in the storage."* Must NOT say *"Only WT1 is counted"* | both |
| L6 | A one-tank job is unchanged | `CDTWL` on a single-tank system: total the same as before | both |
| L7 | A tank on another branch is not counted | A re-use tank on a different system must not appear in this branch's total | both |
| L8 | **Propagation: drawing and record agree** | Type an invert by hand, save, `CDPROPAGATE` from the downstream pit: it says which levels you set by hand and asks; after Apply the drawing level and the schedule level are the **same number** (open 2–3 pipes) | both |
| L9 | One Undo takes the schedule with it | `U` once after L8 → pipes, pits **and** the schedule all go back. Reopen a pipe and check | both |
| L10 | **Nothing is skipped in silence** | On a `CDC7UPGRADE`d drawing, `CDPROPAGATE`: any pipe that could not be updated is **named** in a line at the top. Must not quietly report success. **Send Tim's line back** — evidence for the unfinished piece | 2027 |
| L11 | A refused cascade leaves the schedule alone | If a cascade is refused for any reason, the schedule still shows the **old** levels | both |

**Not finished, needs the other Civil chat:** writing a *converted* pipe's own stored record goes through
`LinkService.Persistence.cs` (their file) and, reading the code, does not reach the real object. Unproven in
AutoCAD, their file untouched. Written up in `FLEET_STATUS.md` on the K/L branch.

**Open for Tim (5):** the `COUNCIL PIT` vs `EXISTING COUNCIL PIT` wording · the note's layer (`25DIMS` vs
`25TEXT`) · the note's wrap width (18.7 text heights) · whether two tanks on one system should be added ·
whether the 16 Sep `PITEDIT` tests changed one size box or both.

---

### BUILT 17 Sep — branch `claude/civil-other-areas-handoff-d747af` @ `0b3f17bd` (other Civil areas chat) — NOT installed, NOT tested

> **Branch note for the window chat:** this branch **is** the old `claude/civil-other-areas-2026-09-16-1c1ae6`
> (same tip, `e0cfe172`) plus this one commit. The chat's worktree could not write to the old branch's copy, so it
> was continued under a new name cut from that branch's tip — **not from master**. Merge THIS one; the old branch
> is contained in it.

**IDENT-02 (P-07, second half)** — *"double-clicking the invert again will not let him edit it"*. Full steps and
the evidence are in the plugin `REGRESSION_LOG.md` entry **IDENT-02**. Summary rows:

| # | What | Test | Lane |
|---|---|---|---|
| O16 | **Double-click a pipe's IL text opens the Edit Pipe window** | Open a COPY of a job with pipes. **Edit nothing first** — that is the point. Double-click an `IL 19.40` text: the Edit Pipe window opens on that pipe with 19.40 in the level box. Before, you got AutoCAD's plain text editor. | 2027 **and 2024** |
| O17 | It works the **second** time too | Escape out, double-click the same IL text again: the window opens again, not a refusal | 2027 |
| O18 | Pipe text does the same | Double-click `225 DIA. UPVC PIPE AT 1 IN 100`: Edit Pipe window opens | 2027 |
| O19 | **Pits are unchanged** | Double-click a pit's `CL 19.65` cover text: the Edit Pit window opens exactly as before | 2027 **and 2024** |
| O20 | **Ordinary text is still AutoCAD's** | Double-click a note in the title block that CE did not draw: AutoCAD's own text editor opens. If the Edit Pipe window opens on it, **stop and report** | 2027 **and 2024** |
| O21 | The pipe itself is unchanged | Double-click the pipe: Edit Pipe window as before | 2027 |
| O22 | A drawing with no CE pipes | Double-click any text: AutoCAD's editor; opening the drawing must not feel slower | 2027 |
| O23 | **The evidence run for "changing an invert does nothing"** | Open a pipe, change a level, press OK. **Whatever happens, say what the command line said and send the log.** Two new lines now record Cancel/Escape and "OK but nothing changed", with both levels as held and as read in. This is how that half gets settled — it is **not** claimed fixed | 2027 |

**ANSWERED and BUILT — this is no longer open.** The question was: blanking a level in the Edit Pipe window did
**not** clear it from the pipe's stored record, so the schedule could keep showing a level you deleted.
**Tim, 17 September 2026: *"yes a blank box should clear it, go ahead"***. Built as **BLANK-01** (`d63a29f3`) —
it turned out the old level came back from **two** places, the pipe's own record **and** the schedule row, and
both were fixed as an opt-in so the other four level-writers are untouched. **Test rows O24–O29.**

### ADDED 17 Sep — CDTWL faults, same branch `claude/civil-k-l-2026-09-16` @ `b8d827b8` — NOT installed, NOT tested

Steps in the plugin `REGRESSION_LOG.md` entry **TWL-04 / TWL-06**. Summary rows:

| # | What | Test (2027 first, then 2024) | Lane |
|---|---|---|---|
| T1 | **CDTWL takes your own level** | `CDTWL` → outlet → volume → at *"Which level is the top water level?"* type **`18.54`**. Accepted. It must NOT say *"1 or 2 only"*. The report says *"your own level, not one CE measured off the drawing"* | both |
| T2 | Picking by number still works | Run again, type `1` — exactly as before | both |
| T3 | It warns without blocking | Type a level above the lowest lid → accepted, plus *"Careful: that is ABOVE the lowest lid in this system (…), so water would come up out of it."* | both |
| T4 | Nonsense is refused cleanly | Type `banana` → *"neither one of the numbers above nor a level. Nothing was worked out."* | both |
| T5 | **The storage total — the important one** | On the same real job as Test Day, run `CDTWL`. Far fewer pits left out; the ones taken say *"…so its floor was taken from the pipes that meet it (19.200)"*; storage total **higher** than the 17,948 L he saw. **Send back the new number and how many pits and pipes are still left out** | both |

**Not fixed, and said so:** the **18 dropped pipes** (`PipeData` records no length or geometry, so the pure
collector can only measure a pipe from its two pits' positions — fixing it changes the shape and was not
guessed at); **TWL-03** (CDCALC's own TWL box is already offered, so its record did not hold 18.54 and why
cannot be established without the drawing — T1 removes the harm); **TWL-05** (the `"0.0"` volume is written on
the CDCALC side, which is the unclaimed computations work); **TWL-07** (*"will this whole command be in a
window at some point?"* — still Tim's question).

### BUILT 17 Sep — **BLANK-01**, branch `claude/civil-other-areas-handoff-d747af` @ `d63a29f3` — NOT installed, NOT tested

**Tim, 17 Sep:** *"yes a blank box should clear it, go ahead"*. Emptying a level box now deletes the level. It was
coming back from **two** places — the pipe's own record **and** the schedule row — so both were fixed. Everything
else that writes levels is untouched (opt-in). Full entry: plugin `REGRESSION_LOG.md` **BLANK-01**.

| # | What | Test | Lane |
|---|---|---|---|
| O24 | **A deleted level stays deleted** | Pick a pipe with both levels; note them in `PITSCHEDULE`. Double-click it, **empty the downstream box**, OK. The IL text leaves the plan **and** `PITSCHEDULE` shows that level **blank** — not the old number. Re-open the pipe: the box is still **empty** | 2027 **and 2024** |
| O25 | One Undo brings it back | `U` once after O24: the level returns on the plan **and** in the schedule | 2027 |
| O26 | Both levels deleted | Empty **both** boxes, OK: both gone from plan and schedule; the pipe still runs between the same two pits and its pipe text still reads size and material | 2027 |
| O27 | **A typo must never delete anything** | Type `19.4O` (**letter O**) in a level box, OK. **Nothing is deleted** — the stored levels stay as they were. Say what the command line said | 2027 |
| O28 | **"Just draw the pipe" must never delete a level** | On a pipe with both levels, tick **simple pipe only**, OK. The texts come off the plan but `PITSCHEDULE` **still shows both levels**. Untick: still there | 2027 **and 2024** |
| O29 | Nothing else changed | Run `CDLPD`, a pit move, and `CDREPAIR` on a pipe that has only ONE level: the other level must **not** be wiped | 2027 |

### ADDED 17 Sep — TWL-05, branch `claude/civil-k-l-2026-09-16` @ `b8e234f9`

| # | What | Test | Lane |
|---|---|---|---|
| T6 | A fresh system has **no** volume | `CDCALC` → Detention → add a system. Volume required box is **empty**, not `0.0`; status reads *"Enter required volume to compare."* | both |
| T7 | A real volume is offered | Type `25.06`, save, run `CDTWL`. *"CDCALC records the volume required for this system as 25.06 m3. Press Enter to use it…"* — and **Enter accepts it** | both |
| T8 | An empty one is explained | `CDTWL` on a system with no volume: *"CDCALC has no volume recorded for this system yet…"*. Must NOT say *"not a plain number"* | both |
| T9 | No matching system says so | Pick an outlet no CDCALC system names: *"CDCALC has no detention system recorded against this outlet…"*. Must not go quiet | both |
| T10 | **The drawing block** | Insert ON SITE DETENTION CRITERIA for a system with no volume: `VOLUME REQUIRED   NOT SET`. Must NOT read `0.00 m3`. **Tim to say whether `NOT SET` is the right words** | both |
| T11 | An existing job is untouched | Open a job already filled in — its volume still reads what he typed | both |

**Question for Tim (new):** the same view model hard-codes `_psd = "5.24"` — a permitted site discharge, an
engineering value, in code. R-00 puts those on the Settings page. **Not changed**, because a different default
PSD changes designs. Should it be a Settings value, or start empty like the volume now does?

### BUILT 17 Sep — **T-01 `CDFIXTAGS`**, branch `claude/civil-other-areas-handoff-d747af` @ `acfb38f6` — NOT installed, NOT tested

It contradicted itself because the summary asked "describe the renames that worked" with an empty list, and that
helper answers *"Nothing to repair"*. It also **stopped at the first block it could not rename**, so the rest were
never tried, and the failure reason never reached the command line. Full entry: plugin `REGRESSION_LOG.md` **T-01**.

| # | What | Test | Lane |
|---|---|---|---|
| O30 | **The contradiction is gone** | Same drawing as 16 Sep. `CDFIXTAGS` → **Yes**. The words *"Nothing to repair"* must **not** appear anywhere after a Yes | 2027 **and 2024** |
| O31 | **It says what it did, once** | One summary: either *"N blocks were renamed: …"* or *"No block was renamed."*, then *"N was/were not renamed:"* and one line per block with the block number and a plain-English reason ending in what to do (`CDTAG` or `CDREPAIR`) | 2027 |
| O32 | **More should change than last time** | One awkward block used to stop the rest. **Count how many of the three get renamed now and tell me the number** | 2027 |
| O33 | Follow the reason, run it again | Do what the reason says (usually `CDTAG` the other block), run `CDFIXTAGS` again — it should rename the rest | 2027 |
| O34 | A tidy drawing is still called tidy | `CDFIXTAGS` on a drawing with no repeated names: *"Every source name in this drawing already names one block. Nothing to repair."* — that sentence is correct **there** and must stay | 2027 |
| O35 | Answering No | *"Nothing was renamed."* and nothing changes | 2027 |
| O36 | **Send the log** | A new `[SourceClaims] refused:` line names which piece of text is claimed twice and by which blocks. **That is what decides whether the refusal is right or whether it is the next bug** | 2027 |

**Not fixed, and said plainly:** the underlying refusal. Erasing a label that another source also claims would take
the wrong text off the drawing, so that guard was **not** bypassed. Whether the shared claim is real on this
drawing or the duplicate tag itself confuses the scan **is not established** — row O36's log line settles it.

### BUILT 17 Sep — **P-02 split levels**, branch `claude/civil-other-areas-handoff-d747af` @ `24d9230f` — NOT installed, NOT tested

The split level was correct but **one of the two copies was drawn at the far end of the pipe** instead of at the
pit it was split at. Proven from Tim's own 16 Sep coordinates. Full entry: plugin `REGRESSION_LOG.md` **P-02**.

| # | What | Test | Lane |
|---|---|---|---|
| O37 | **Split levels sit at the middle pit** | Three pits in a line, left to right. `CD` ONE pipe through all three (19.45 → 19.25). Answer **Yes** to the split. **Both `IL 19.35` texts must be beside the MIDDLE pit** — one just above the pipe, one just below — **not** one back at the first pit | 2027 **and 2024** |
| O38 | Drawn right-to-left | Same run drawn the other way, split it: levels still at the middle pit | 2027 |
| O39 | Drawn vertically | A north-south run through three pits, split it: levels at the middle pit | 2027 |
| O40 | They do not overlap | The two split levels are on opposite sides of the pipe | 2027 |

**DECIDED — P-01, Tim, 18 September 2026: *"ask inside the CD window as a tick"***

The command-line question is **moved, not retired**: the same choice, asked before the pipe is drawn instead of
at the command line after the window closes. The splitting itself still runs after the pipe exists, because the
halves cannot link to their pits until the pipe is in the drawing. Contract for Codex to build the tick from:
`04_REFERENCE/contracts/CONTRACT_SPLIT_ON_DRAW_TICK_2026-09-18.md`. Ruling recorded at `TEST_DAY_RESULTS_2026-09-16.md`
§6s. **Not built yet** — acceptance replaces steps 52–56 and is listed in §9 of the contract.

**Both follow-ups settled the same day.** Tim, 18 September 2026: ***"wording is fine, and yes retire the escape
step"***. The tick reads **`Split where it crosses pits`**. The old **Escape at the split question** route is
**RETIRED with his explicit approval**, and **acceptance step 56 of the 16 September list is retired with it** —
leaving the tick unticked is the same answer, and Cancel on the CD window still means no pipe at all.
**The contract is complete and waiting on nobody; Codex can build the tick.**

**One thing the behaviour side must prove before it ships:** that one `U` after a ticked draw removes the pipe,
its halves and their labels **together**. Not verified today, not claimed.

**Still open in this area:** P-04 (a pipe with more than one bend) and P-05 (each half needs its own pipe text)
— both in progress in the same chat.

### ADDED 17 Sep — PSD-01, branch `claude/civil-k-l-2026-09-16` @ `457bf032`

| # | What | Test | Lane |
|---|---|---|---|
| T12 | A new system has **no** PSD | `CDCALC` → Detention → add a system. PSD box **empty**. Must NOT say `5.24` | both |
| T13 | CE does not fill it in for you | Fill the Boyd's tab so it works out a PSD → the Detention PSD box is **still empty** (the one-click button is Codex's to add) | both |
| T14 | A typed PSD survives | Type your own PSD, then change the Boyd's figure → yours stays | both |
| T15 | It round-trips | Save, reopen: an empty PSD is still empty, a typed one still reads what you typed | both |

**Worth a look on old jobs:** every system created before today started at `5.24 l/s`. CE does not rewrite
saved records, so check any job you have not looked at since.

### ADDED 18 Sep — K4 Council keyword, branch `claude/civil-k-l-2026-09-16` @ `dc937001`

| # | What | Test | Lane |
|---|---|---|---|
| T16 | **`Council` gives COUNCIL PIPE** *(the bug)* | `CDLPD` → pipe end → label point → type **`Council`**. Note says **COUNCIL PIPE**. Must NOT say COUNCIL STUB | both |
| T17 | Each full word still works | `CouncilStub`, `CouncilPit`, `CouncilPipe` each give their own wording | both |
| T18 | An ambiguous shortening is refused, not guessed | Type **`CouncilP`** → *"CouncilP could mean CouncilPit or CouncilPipe. Nothing was written…"* and **nothing is placed** | both |
| T19 | Shortenings still work | Type **`K`** → KERB & CHANNEL | both |
| T20 | Enter still takes the default | Press Enter → KERB & CHANNEL | both |
| T21 | `Other` still takes your own words | Type `Other`, then your wording → it goes on the note | both |

**Changed for Tim, say if you mind:** this one question no longer offers AutoCAD's right-click keyword menu —
CE reads what you type and matches it itself, which is why it can now be proven. The choices are still printed
in the question and shortenings still work.

**Not fixed by this:** the note **wording** is still wrong on Tim's machine because his settings hold the old
short template. K4 fixes which connection **type** is chosen. Both are needed.

## BUILT overnight 20→21 Sep — `claude/lisp-tools-port`, merged to master 23 Sep (PR #83, `38f1d98a`) — NOT INSTALLED, NOT TESTED

Two commands ported from the retired root LISP file CLOSED MLINE.lsp (Tim, 20 Sep: "can those lisp files be updated and added to the plugin"). CML already ran natively. Built on net10, three source-guard tests pass. Nothing installed; needs a build into a bundle and a deploy on Tim's phrase before these rows can be ticked.

| ID | What Tim would see | Lane |
|---|---|---|
| **L1** | Type `SML`, then draw two points. **A plain STANDARD multiline appears** (no end caps). Type `CML`, draw again: **closed ends** as before. | both |
| **L2** | Type `CHECKML` after `SML`. The command line prints **three lines: MLINE style STANDARD, the scale number, the justification word** (Top / Zero (centre) / Bottom). After `CML` it says CLOSED-ENDS. | both |
| **L3** | In a fresh drawing with no STANDARD style renamed, `SML` never errors. If STANDARD was deleted from the drawing, `SML` says **"STANDARD MLINE style not found in this drawing"** and draws nothing. | 2027 |

## DESIGN-WINDOWS-20260924 — wiring candidate, native acceptance still pending

1. **Previous window-only candidate (superseded by wiring PR #149, 24 September):** PR https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/146, codex/ui-design-windows tip cfa8d59b, tested code ac52577f. Three Release lanes 0 errors; own checks 26/26. Full Civil 10,790 passed / 12 failed / 19 skipped / 10,821 total. All 11 baseline failures plus one new-to-this-run light-theme Help rendering timeout. Eighteen real-window dark/light pictures inspected and committed; hashes unchanged after the full run. Not installed or Tim-accepted.
2. **Previous precondition (wiring superseded by PR #149, 24 September):** wire the three windows through the protected CDDESIGN/CDRAINFALL/CDLPD command files and named Design ribbon entries using the explicit PR hand-offs. Preserve STORM/council consent, active drawing context, existing drawing authority and Undo. Resolve the extra Help rendering failure and restore the full-suite 11-failure gate. Until then the typed commands still open their original prompts; do not ask Tim to find the new windows there.
3. **Later representative acceptance, AutoCAD 2027 and 2024/net48, after a separately authorised release:** open each window by ribbon and command in dark/light, visit each fixed tab, then Escape. Design: missing council/areas/discharge, all prerequisites, refused result, input change and recalculation; confirm nothing is drawn. Rainfall: file and clipboard, invalid/failed input after a reviewed curve, preview/decline, approve/save/reopen, office-fallback review/decline and confirm. LPD: object and point, each normal/Other connection including blank Other, Escape at each drawing prompt, label placement, one Undo, save/reopen.
4. **What the automated evidence cannot prove:** command discovery and native integration, actual drawing persistence/selection/label output/Undo, operating-system picker/clipboard interaction and final engineering acceptance. This is one consolidated workflow check, not a backlog of separate historical tests. Import is deferred.

5. **Wiring candidate, 24 September:** Tim approved "yes to windows" at 07:55 Melbourne. PR https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/149, codex/ui-design-wiring code a39719eb connects all three commands and named/icon Design routes on both ribbons and legacy menu. Final tip d80aaf13; PR ready for review. Three Release lanes 0 errors; full Civil 10,805 passed / 11 exact known failures / 19 skipped / 10,835 total; expanded focused 114 passed / 1 known CDPIPEOBJ failure. All 40 window/hand-off/Design-route checks pass and 18 inspected image hashes are unchanged. The earlier extra Help rendering timeout did not recur in this complete run. Nothing installed or Tim-accepted. Use the same consolidated checklist above after release-owner installation; also check locked-layer/Xref refusal and rainfall false-save messaging.

## NOTE 9 Oct 2026 - REDO after switching drawings (BUG-558, not reproduced)

Claude driver run 2 saw 'Nothing to redo' 3 of 3 on a Civil copy (CLD10_B1, four missing xrefs) after U, switch to another drawing, switch back, REDO; run 3 could not reproduce it (5 of 5 PASS on fresh copies); run 4 repeats run 2's exact order. If it recurs, note whether UNDO 2 or an autosave ('Automatic save to ...' in the history) came first. Codex brief W49 item W49-07b repeats the switch check on a Civil drawing without missing xrefs. Autosave between U and REDO is AutoCAD's own rule, not a CE fault.

## Codex free-ended pipe follow-up,14 October2026

1. **Narrow Codex-accepted, installed Civil3.0.49:** draw-first free-ended225UPVC with firstIL19.50 and calculated second19.40; actual grade1in100/right arrow, repeatEscape, oneU/delayedREDO, editor readback and actual QSAVE/CLOSE/disk reopen. Diameter-only edit225->300 retains levels/grade/direction; Undo restores225. Verification receipts121-126, local screens217-246.
2. **Outstanding:** BUG582 NewPipe calculated-end preview/status falsely Unknown; BUG572 first Inspector selection after reopen cannot read saved records until editor opened; BUG256 controlled diameter-edit delayedRedo fails with autosave0 and no intervening action. No whole pipe-edit acceptance. Other types, multiple edit, protected objects and units remain pending.
3. **Coverage and usage:** source-traceable inventory508 UX IDs; historical509 mismatch and whole-case latest-verdict evidence still being reconciled. No50% claim. Account weekly24%; holiday hours override allows testing whenever needed until29October, no new installation authority implied.
4. **Additional narrow pipe-field check:** upstreamHidden Save removesonlytext, storeslevel19.50, leavesotheroutputunchanged; oneUrestorestext. Verification127/screens247-249. FullfielddiskpersistenceandRedo remainuntested. Ownedfixtureclosed/CEsettingsunchanged/controlleasereleased, receipt128. NoTimmanualrepeatneededfortheserecordednarrowpasses.
## Codex wind and bracing follow-up, 14 October 2026

1. **Narrow Codex-accepted, Structural 1.0.116:** CSBRACINGPANEL visible with Command Hub closed, empty/unset totals, Refresh and X close; AB horizontal 2700 mm default placement, A mark, one Undo and delayed Redo; panel provided total matches 2700 mm. Wind Region Escape, invalid terrain reask, synthetic N2 record recall/default No and same-PC drawing reopen. Exact source/screens in verification receipts130–134.
2. **Confirmed existing fault:** BUG504 blank Wind class Enter claims set/confirmed but saved class is empty and IsConfirmed false. No duplicate new bug. Known-region suggestion, arbitrary-value warning, every Escape boundary, wind/job sharing and engineering suitability remain untested. Required-bracing editing saves live Settings and needs an isolated profile before testing; no live Settings Save made here.
3. **Remaining bracing:** B type, vertical/diagonal direction totals, metre units, rotated plans, manual/automatic flip, protected objects and disk persistence of new brace. Do not infer whole UX-FRM14 or BUG503 accepted. No manual repeat requested from Tim for narrow recorded passes.
## Codex brace protection, switching and persistence update,14 October2026

1. **Narrow Codex-accepted:** installedStructural1.0.116+f180b349. SavedA reopen; verticalB2700mm/manualflip/liveNS/EWtotal/recovery; AB/BB/STRUCAB/STRUCBB locked-output refusal; lateFlipEscape; normalABSswitch/Undo/delayedRedo; final A/Bpair diskreopen. Verification136-142/screens280-310. Earlier pending B/vertical/manualflip/lateCancel/disk cases above are superseded by these results only.
2. **Confirmed fault:** BUG583 ABS on selected locked B opens unhandled eOnLockedLayer. No silentunlock/change in single-object case. Mixedselection rollback, lockedtarget and aliases remain pending. Repair in behaviour lane; no installedfix or acceptance.
3. **Still to test:** diagonal/metre/rotated/Xref/REFEDIT, automaticflip/requirements under isolatedsettings, remaining variants and wind branches. WholeUX-FRM14/BUG503 not accepted. No Timrepeatrequested for narrow recordedpasses; engineering adequacy remains Tim's decision. Settings/controls restored, ownedfixture closed, lease released. Weekly26%; overall50% remains unverified.

## BUG580 Manager header contrast candidate,14October2026

1. **Built, not installed:** draftPR1255 https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1255, commit8789a8ed on codex/manager-header-contrast-20261014, exact installedManager48662ddd base. Modern/net48 builds0errors/0warnings; existingthemechecks3/3PASS; source-derivedstaticpictures inspected. Whitewordmark now follows liveheaderforeground; no settingswrites or behaviourchanges.
2. **Real acceptance after combined authorisedinstallation:** CEMANAGER -> SettingsGeneral -> Light: read CEwordmark and subtitle; Discard restoresDark and savedsettingsunchanged. RepeatFollowAutoCAD and150%scaling. Check renderharness limitations in verification144-145; never count this candidate as realAutoCADcoverage. BUG580 remainsOPEN. No Timtesting requested before installation.

## Floor/roof and bracing-truss runtime update,14October2026

1. **Narrow Codex-accepted, Structural1.0.116+f180b349:** BT1 number0/10refused,9accepted, default2700mm/0degreeBT9/body, oneUndo/delayedRedo, liveprovidedNS0/EW2700, actualsave/reopen samebody/mark/total. R1 PointmodeEscape restorescontrols; RJSET correctpage/CancelbuttoncloseswithoutSave. Verification146-151/screens311-332.
2. **Blocked output stays pending:** CSROOFSETOUT/CSFLOORSETOUT installedcommands disclose offdefault and Settingspage stilltobebuilt; onlythatdisclosuretested. R1/FJ1/P1 successsavesliveSettings; needsverifiedisolatedprofilebeforeplacement. No wholeUX-FRM05/11/14accepted, and no Timmanualrepeatrequested for narrowpasses.
3. **Drafting observation:** BT9textcrossesitscircle atreadablezoom; proposalinIDEAS_INBOX. Approvedexpectedbubblelayout/actualplotcheck neededbeforeanysymbolchange. Noassertednewengineeringbugorblockrewrite. Controls/settingsrestored, ownedfixtureclosed, lease released. Accountweekly27%, 50%unverified.

## R1 exact span and saved readback,14October2026

1. **Narrow Codex-accepted:** R1 unchangedstoredRT1tag placement, completeoneUndo/delayedRedo withautosave0, diskbody/mark retention and unchangedglobalsettings. Receipts152-158/screens333-350. EarlierblanketR1/FJ1/P1 profileblock is superseded for unchangeddefaulttag route only.
2. **Confirmed failure:** BUG584 exact8000x4000mm four-pointbay yieldsinternal2400/outer2600/arrow4000; wrongwidthvalues persistafterdiskreopen. No fixinstalled; correctspangeometry notaccepted. RelatedFJ1/P1, alternatewidth/depth/object/rotated/protected routes remainpending; require behaviourreview before repair.
3. **Engineering boundary:** BT9panel2700 numericalreadback does not approve rooftrussescontributing towallprovidedtotal. ExistingBUG499 nowhasobservedevidence, expectedaggregationstillTimengineeringcall. No Timrepeatrequested for recordednarrowpasses. Settings/controlsrestored andlease released;weekly28%,50%unverified.

## Floorjoist sizing and purlin lateCancel,14October2026

1. **Narrowpasses:** FJ1 storedDJ1 output/oneUndo/delayedRedo; P1 outputrecovery; unchangedglobalsettings/draftingcontrols. Receipts159-164/screens351-371. Noengineeringcapacityacceptance.
2. **Failed:** BUG584FJ1 exact6000x6000mm bayretains2400/2600width, arrow6000correct; persistsafterreopen. BUG585P1 EscapeatApplylap stillplacesbody/tag. BothOPEN, Claude behaviourrepairlane, nofixinstalled.
3. **Remaining:** normalP1Yes/No/exactsize/object/rotated/protected/metre andpurlindiskreadback. No Timrepeatneededforrecordednarrowpasses. Account28%, overall50%unverified.

## Evidence scope corrections, 14 October 2026

1. **Schedule write remains pending:** W63-08 staged inlet/number display is not a BUG351 drawing-write or save/reopen acceptance. Apply the approved typed-end route, read that actual pipe end, compare the other end and label, then Undo and reopen. Prior window display evidence remains valid narrowly.
2. **Flat pipe output remains pending:** W61-04 proves a single informational warning and recovery; its overlapping existing pipes do not prove the new label correctly represents equal inverts. Use an empty owned bay, type equal levels, inspect that new pipe alone, read its editor/record/label and save/reopen. BUG427 stays OPEN.
3. **Coverage:** refreshed535 headed bugs/52 FIXED-text candidates/8 no explicit status; 508 traceable UX IDs. Historical statuses and old results still need item-by-item evidence mapping. No new 50% claim. Verification165-167; local source hashes preserved.

## Flat-pipe isolated result,14October2026

1. **Specific route now Codex-accepted:** Civil3.0.49, new100UPVC/Standard/freeends, both18.500. ActualFLATlabel/editor/preview/numericalreadback/save-reopen pass. Screens375-378/381-387, receipts168-170. Prior generic flat-label pending note is superseded for thisroute only.
2. **Still failing:** BUG256 oneUndo succeeds but controlleddelayedRedo saysNothingtoredo; BUG572 InspectorTypeUnknown despite correct100/UPVC/18.500/18.500. Nowholebugclosed.
3. **Remaining:** held/custom-grade variants, repair command, protection/units andBUG427Structural subcase. NewPipe absent-preview observation awaits contract/source review. Settings/controls restored, ownedcopyclosed,lease released. Account29%;50%stillunverified.

### Codex real P1 normal-lap evidence, 14 October2026
1. **Partial only:** explicitNo/Yes lap0/1200 and both oneUndo/delayedRedo/diskreadback exercised on installedStructural1.0.116+f180b349. BUG584 wrongbasewidth persists; BUG585 Escape stillOPEN. Do notacceptwholeframingworkflow orwholebugfromrecovery/lapPASS.
2. **Nextguard:** fourabsolutePointcoordinates with actual intermediatepoint proof, compare placementposition/span, then object/protected-layer/Xref/REFEDIT/rotation/units/olderrelease cases. Report and exactownedcopy provenance in verification188-192.
## Codex job rainfall evidence, 14 October2026

1. **Specific route Codex-accepted:** installedCivil3.0.49+48662ddd, synthetic ownedcopy: fallbackwarning, inputrefusals, validseven-rowpreview, approval/editinvalidates, Escape, nativefileimport/source, Save and realDWGsave-close-reopen. Exactreceipts219-222/screens546-561,15narrowPASS. No engineering-site acceptance or wholeUX-CALC04 acceptance.
2. **Remaining representative checks:** singleUndo/delayedRedo of savedcurve; confirmedoffice replacement and diskreadback; clipboard/filecancel/readfailure/parservariants; realdownstreamcalculationusingcurve;2024/otherDPI/themes/multipleDWGs. Avoid askingTim torepeat recorded narrowpasses. Hoverbuttoncontrast/current-versus-proposed wording observations retained in report for bounded UI repair review.
3. **Safety and coverage:** controls/restored, threepreferences unchanged, ownedcopyclosed, ownlease released;36%accountweeklyusage. No installation/provider/reset. Overall50%target remains unverified.
## Codex calculation draft and package guards,14October2026

1. **Narrow realpasses:** installedCivil3.0.49, newblankdraft/noexamplearea; committedsyntheticinputs; explicitUseBoyds transfer; preview-before-export and change-invalidates-export; Draft/unknownbasisdisclosure. Verification223-226/screens562-576.
2. **Unresolved:** existing249fixedrainfalllist/source;507missinginputlooks0;515lastrowwarningnotvisible. Sourcewarningsbuiltbutnotshown: Codexwindowrepairpacketneedsownershipcheck; engineeringformula/stormlist remainsbehaviourowner. Noactualfix/engineeringacceptanceorwholeBUGclosure.
3. **Next:** reopenowned CODEX_CALCULATIONS_20261014.dwg andcheckdraft restoration, then actualPDF/XLSXandrenderedpages,rainfallchange/downstreamconsumer,othercalculatorbranches/2024. Do notaskTimtorepeatrecordednarrowpasses. Savedfixture/localcases12=9PASS3FAIL;controls/settingsunchanged/copyclosed/lease released;weekly36%,50%stillunverified.
## Calculation warning window candidate1257,14October2026

1. **Built/tested only:**4ede9332/draftPR1257 https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1257,existingwarningdisplay.24focusedPASS/net48build0errors;light/darkrenderpicturesinspected. Nothinginstalled,norealAutoCADcandidateacceptance.
2. **Aftercombinedrelease:** CDCALCfreshsyntheticdraft/Boydsblankinputsinstructionvisible;700/500/200m2/PSD2leavefield ->9.42m3/30minplusexistinglongerstormwarningbesideinputs. Repeatlight/dark/150%/saved-draftreopen. Keep1216warningwording/switchand22colourhunks;507zeros/249rainfallstillOPEN.
3. **Remainder:** completeitemcoveragecrosswalk/currentpercentage, actualdraftdiskrestore/exportedPDF/XLSXandremainingcalculatorbranches. Goalactive;weekly37%,noreset/provider/installation. Verification227-229.
## Coverage index and untested remainder,14October2026

1. **Evidence attached:**reportcompanionCODEX_COVERAGE_INDEX_2026-10-14.json contains508UXIDs/539bugheadings/sourcehashes/12partialscopeaudits.14caseledgers172assertions(144PASS/22FAIL/4BLOCKED/2UNPROVEN)notwhole-itemcoverage.265evidencefilesverifiedpresent/hashmatches.
2. **Stillpending:** fullcase-to-UX/bugmapping,historical/currentversionscreenshotreview,eligibility/statusreconciliationandtruthfuloverallpercentage. Old7%notcurrent;994/497arithmeticprovisional. Noitemacceptedfromopenedwindow,buildorpartialcase.
3. **Nextrealchecks:** savedcalculationdraftreopen,actualPDF/XLSXandrenderedoutputs,rainfall-changeconsumption. Preserve1257combinedreleaseacceptancecheckand507zero/249rainfallremainders. Goalactive;noTimrepeatrequestedforrecordednarrowpasses.
## Codex actual calculation exports —14October2026

1. **Recorded:** installedCivil3.0.49+48662ddd, receipts234-239:14narrowassertions9PASS4FAIL1UNPROVEN. Saved draft/cancellation pass;3actualPDFpageslegible and nativeExcelopens3tabs. No completeUX-CALC04or50%acceptance.
2. **Repair/retest:** BUG590eachpage/tabactualdraft/approvedstateandidentity; BUG591typednumericvalues/Unknown distinction;249acceptedBoydsrowprovenance/sharedrainfall;515warning1257candidateawaitscombinedinstallation. Criticaldurationtransferreviewopen;noautomaticPSDtransferassumed. No faultfixinstalled.
3. **Remaining:** selectedsections/overflow/WSUD/approvalinvalidation/readfailures/2024; calculatorconsumers/drawingApply. Ownedcopyclosed/preferencesunchanged; do notaskTimtorepeatcompletedbatch. Continueownership-awareauthorisedrepairs.

## BUG590/591 regression package —14October2026

1. **Banked:** draftPR1258 https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1258 /36043dbe. Tests-onlyRED:7executed1PASS6FAIL0skip,net48build0errors46warnings. DoNOTmergealone;fixbothproductionfaultsandruntheseguards.
2. **Actualretestaftercombinedrepair:** everyPDFpageincludingoverflowandeveryXLSXtabretainsdraft/issuedstateandjobidentity; numericcellsworkwithoutconversion,Unknownandzeroareseparate. Preservefrozenapprovalandpending403/1043. InstalledfaultsstillOPEN;theseunitchecksarenotnewAutoCADcoverage.

## Pipe flow/Catchments real checks — 14 October2026

1. **Recorded:** receipts243-248;17narrowchecks12PASS5FAIL on installedCivil3.0.49. Native selection, valid recovery, ARI/manual source and draft persistence exercised. No completeUX-CALC04.
2. **Repair next:**592 unavailable pipe results distinct from zero in tab/export;593 invalidate stale row flow/tick on invalid rainfall, including draft restore and prepared package. Existing360 readable pipe identity. Reuse owned invalid fixture; do not ask Tim to repeat completed cases.
3. **Remaining:** row add/remove/edit/report intake; invalid/range/nonfinite inputs; other calculator tabs; actual repairedPDF/XLSX; approval/Apply/units/UCS/protection/2024. No repair installed.

## 15 October2026 — BUG593 catchment window/draft candidate (Codex)

1. **Candidate:** draftPR1259 https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1259 , branchcodex/catchment-result-state-20261015, dbb1dac1 frominstalled48662ddd. Modern53focused+36surroundingPASS;net48build0errors;net48runtimezerodiscoveryNOTPASS. Notinstalled/accepted;bugOPEN.
2. **Combined-release dependency:** Claude CalculationExportPackage.CaptureCatchments must consume HasFlow/HasTotalFlow for Unknown in preview/PDF/XLSX, with approval-consumer guards. Numeric compatibility members clearedto0 so stalevaluesgone, but rawexportstill0. Bankwithintegrationbeforeclaimingend-to-endrepair; no independent install authority.
3. **Representative real2027check, Codex to perform after combined authorised release:** ownsyntheticcalculator-consumersfixture; two500m2/C0.9rows/manual110 ->13.75each/27.50total. Set0/blank/text/negative ->Unknownallrows/total/warnings; saveclose/reopen sameUnknown/typedinput. Return110 restoresvalidfigures. Invalidonearea/C retainsotherrowflowbuttotalUnknown. PrepareandopenPDF/XLSX, proveUnknown/provenance andoldpreviewinvalidation. Cancel/no drawingchange. Older2024/net48 lane andsourcewindowrenderstillpending; noextraengineeringruleapprovalclaimed.

### BUG593 candidate appearance update,15October2026

1. **PR1259 head07160dee:**4actualWPFgrid/totalrenderchecksPASS;invalidDark/LightPNGspersonallyinspected. This provescandidatewindowbindings/display,notinstalledAutoCAD or exportintegration. Originalcombined-releasecheckstillpending;bugOPEN.
2. **New real row evidence:** savedsyntheticcatchment-rows/CODEX_CATCHMENT_ROWS_20261015.dwgcontainsC1area500/C0.9,C2area1000/C0.9,jobcurveARI10/Tc15/manualOFF,row8.08/16.16,total24.24. NextCodexreopenmustprovepersistedrows/source/total;thisbatchsavedbutdidnotreopen. AddandEnter-committedareaeditPASS,no-jobreportguidancePASS,actualreportintakeBLOCKED;receipts254-257.

### 15October2026 row disk-readback completed by Codex

1. **Prior row-reopen remainder now proven narrowly:** realinstalledCivil3.0.49+48662ddd,629showsC1area500/C0.9/Q8.08,C2area1000/C0.9/Q16.16,total24.24,Typedinsources/recordedjobcurve;630preparedpackageconsumesrowsandtotal. SavedfixturehashunchangedaftercloseNo. Screens628-632/receipts261-263. This isexistinginstalledrowbehaviour,notPR1259candidateacceptance.
2. **Stillpending:** PR1259combinedexportintegration/install/retest,actualrating-reportintake,otherrowedits/previewinvalidation/protections/olderruntime/Apply/approval/outputprovenance. NoextraTimmanualrequest.

## 15October2026 — BUG594/595 report intake and native recovery

1. **BUG594:** PR1258nowa711f3d3,tests-onlyreader3executed1PASS2FAIL;realAutoCADBlueFactor-onlyreadfailsandolderSTORMisofferedinstead. ClaudeownsTryReportsroutingrepairtoexistingParseAnyRatingReport;bankredguardswithrepair,nofixinstalled.
2. **Representative retest:** ownreport-intakejobhascurrentBlueFactor170m2roof/tank,50bypass,12Unknown;olderSTORM110. Correctcurrentreport/3rowsoffered;Cancel/Escapenomutation,confirmone/source/destination/disk/exportprovenance;repeatformat/scanned/empty/missingfolderandlegacy2024disclosure.
3. **BUG595 recoveryfirst:** AutoCADstillopenwithonlyownsyntheticfixture;normalcommandentry/Closedidnotcompleteaftertargetchange. Ownlease1791986256retained;source/helper/sessioncauseunproven. Recoverproperdialog/prompt/commandlinevisibilitybeforenextnativebatch;noforcekill/deployorblanketacceptance. Receipts264-268.

## Codex15October follow-through — pipe availability and native recovery

1. **BUG592 guards,PR1258/ecd48404:**21modernchecks2PASS19FAIL0skipped,tests-only. Pending627/642 overlap production model; coordinate repair ownership. After combined repair/installation, CDCALC Pipe Flows225mm/n0.010/grade50 must read82.55L/s,2.08m/s; blank/zero grade must readUnknown with warning inwindow,preparedsheet,actualPDF/XLSXand saved/reopened draft. Valid recovery works; advisory-only velocity warning retains numbers. Repeat invalid diameter/roughness/nonfinite/overflow/olderAutoCAD. Notinstalled/accepted.
2. **BUG595 recovery still first for native input:** observed system-menuClose did not close app; screenshot640. OnlyownsyntheticreportDWGopen, on-diskhashunchanged, lease1791986256held. Do not count this as Cancel or stationfree. Recover proper command/dialogstate then test actual pick Cancel/confirm/source/destination/disk/export, preserving fullscope. Independent tests/window work continues.

## Codex15October report follow-through — fresh native session usable

1. **Real legacy intake narrowlyPASS:** observedCancelunchanged,explicitone-rowconfirm,duplicateguard,anddiskpersisted110m2/Ratingreport/Tank/Q1.78,total26.02. CurrentBlueFactor/Unknowndestination stillblocked594; keyboardEsc/actualPDF/XLSXprovenance/older2024/engineeringnotaccepted. Verification273-276/screens641-654; savedownCODEX_REPORT_FRESH fixture154253bytes/SHA89D41EDD48376AFA84D3A25AB6AAB4F5C8209CE136AFF65A7552FD8DC57902D5.
2. **Nativeworkaround:** newmain778113170usableandnowempty; old87364294sessionunresolved595. Ownleaseheldwithaccuratenote,all3CEpreferencesunchanged. Reusefreshinstance; donotlaunchmoreorclaimoldrecovery. Nextactualmanualoverride/source/exportandremainingcharged/pump/WSUD/profiles;wholegoalactive/50%unverified.

## Codex15October — charged-loss unit candidate and stale results

1. **BUG596windowcandidate:**1259/2dca5f15,6focusedmodernWPFPASS,net48build0errors286warnings. Combinependingwindowrepairsbeforeinstall. ChargedSystem48.5/97m mustlabelwholefriction0.1438/0.2876m,retainedtotal0.2165/0.3603m;Dark/Light/older2024. CandidateNOTinstalled/accepted.
2. **BUG597:** savedownedCODEX_CALC_REMAINING_20261015.dwg154217bytes/SHA76BE6236806FADA06A5B687B1D9F23DD8E779DE9A6266B1477BEB516131681BE containsblankchargedarea/length97. Reopenreadbackstillpending;repairmustshowUnavailable/Unknownthroughall5resultsandsaveddraftwithoutstalequantities. Testvalidrecoveryandinputedgecases. Pump/WSUDremainintentionallyread-only;donotbypassthemoraccepttheirengineeringrules. Oldnativefault595unresolved;reusefresh778113170empty,leaseheld.

## Codex — 15 October charged restore follow-through

1. **Observed failure:** saved blank area and97m length reopen with starting48.5m results; restore390m2 and the97m figures recover. Explicithead0 is a real calculatedzero capacity with warning. Screens665-671; originalinvalidfixture preserved.
2. **Repair integration:** PR1258/927d0f7b has21charged regression checks,4PASS17FAIL0skipped. Pending1159 owns overlappingmodel work; combine availability changes with it and Codex display integration. Preserve independently known results and explicit zeros; unavailable results are nullable. Finalnet48build0errors46warnings, no runtimepass. RED tests do not merge alone.
3. **Representative native retest:** install the combined reviewed candidate through the authorised release lane; reopen saved invalidfixture and see Unknown for dependentquantities, restorearea390/97m then clear/save/reopen again. Check explicithead0capacity, other missingfields, all outputconsumers, themes and olderAutoCAD. No engineeringrule approval claimed. Oldsession595unresolved; fresh778113170usable/empty, lease retained.


## Codex 15 October — report-area provenance BUG598

1. **Actual failure:** committed typed120 m² still says Rating report after imported110 m²; screens673/674, verification285-286. No repair installed.
2. **Follow-through:** preserve original area/source, honest manual badge and notifications, repeated/same-value/invalid edits, Cancel, preview invalidation, duplicate intake, draft save/reopen and actual PDF/XLSX. Existing PR1259 Codex window/viewmodel slice; Claude output integration.


3. **BUG598 candidate banked:** PR1259 latest4a2f90f8, manual slice2f6bfa13;65modernPASS/zero skipped,net48compile0errors. Source detail retains original110/report source and badge becomes Typed in on edits. This is window/draft only, not installed. Actual save/reopen reproduces installed failure678. After combined installation retest in AutoCAD; full side-by-side review, preview invalidation, duplicate intake and actual exports remain open.


## Codex15October — linked profile native follow-through

1. **Exercised:** explicit start/route, blankdatumgate, insertionEscape, readyknownrows, scaleinvalidation, safe missingDASHDOT2refusal, explicitstandardmetriclinetypeload, realplacement, oneUndo and delayedRedo. Screens681-703/verification291-295. BUG599 late dependency disclosure OPEN.
2. **Next fixture:** local V3UX_20261014/profiles/CODEX_PROFILE_20261015.dwg saved158219bytes/SHA2F66797A610C6EE1D2D80FB582500D3A5205CD594280D39BDCCD8AF7C3A553D9. Freshsession778113170empty; old87364294stillunresolved595; ownlease1791986256 retained. Diskreadback/update, fullreadable row/plot, branches/curves/Unknown/realzero, stalegeometry/target and lockedlayer/Xref/REFEDIT/olderruntime remain unproven.
3. **Repair and improvements:** Claude profileadapter/writer should disclose dependency599 at preparation while preserving refusal. Codex review improvements: readable plain route identity rather than pipehandle2C3 (existing wording360), practical insertioncoordinate display with exact detail, and a larger/centred review chart retaining correctscale ratio; no independentaxisstretch or hidden engineeringchange. These are review notes, not built upgrades or accepted layout.


### Codex native profile follow-through — 15 October2026

1. **Installed:** Civil3.0.49+48662ddd. Real saved-sectionrows/updateCancel/exacttarget/scaleinvalidation andupdateddiskreadbackrecorded296-301; no wholeUX-LSEC01/02acceptance.
2. **Open repairs:** BUG599 lateDASHDOT2disclosure;600multilinetitlecollision;601existingsectiondoesnotvisiblyrefreshuntilREGEN. Claudeownsonewriter/command, Codexreviewwindow. Preserveatomicprotections.
3. **Representative retest:** P1/P2route9.55m,datum18,H100/V10; changeH200/repreviewexistingtarget/Apply immediatelyshows1:200; Undoimmediately1:100/Redo1:200,save/reopen; alltitle/scalelinesseparated. Repeatlockedlayer/Xref/REFEDIT,missingassets,long/branchedrouteandolderruntime. Fullplot/engineeringclearancestillpending. CodexcancontinuecopieswithoutTimdrivingeachcase.
4. **Progress:**270narrowchecksare214PASS44FAIL6BLOCKED6UNPROVEN,not50%wholecoverage. Bugs599-601remainOPEN;repaircandidates1259areuninstalled. Savedupdatedfixturestayslocalonly.


### Codex LandXML failure review — 15 October2026

1. **Real installed observation:** Civil3.0.49 Sourceblank/Readdisabled andpickerCancelpass; empty-networkReadreports0pits0pipes/aborted. BUG602OPEN:failurewindowdisappears,no visiblechoose-another-file/resultreview.
2. **Repair/retest:** ClaudecommandhandoffpassesabortedreceipttoexistingCodeximportreviewwindow. Empty/malformed/missinginputskeepplainfailure/retry; validtwo-pitcontrolshowsproposedunits/levels/assetsbeforeApply. ThenoneUndo/Redo,save/reopen,reimport/overridesandprotectedtargets;2027and2024/net48separate. No runtimefixbuiltorinstalledthisbatch.
3. **Evidence:** verification302-305/localLandXMLcases/report/screens;fourpassesandonefailure are narrowcases. Full50%unverified. KeepallV3/UXscopeandinstalledcatalogue inventorydistinct.


### Codex LandXML positive import faults — 15 October2026

1. **603/604:** Readsourcewritesbeforeapprovedpreview/Applyandresultsusefalseschedulesourcewords. Claudeintake/writercontract,Codexexistingreviewpresentation. Detachedpreview/transform/source-awarefieldsbeforeanywrite.
2. **605:** explicit49.000/48.850ILmissingafterUndoRedo,whilecovers/sizesretained;freshbeforeUndoanddiskreadbackmustisolatecause. Samefixturepositive/Unknown/sump-onlycontrolsandoneUndo/Redo,geometry/schedule/Inspectoragreement. No productionfixinstalled.
3. **Evidence:** verification306-310/native733-746/localLandXMLreport/debug/XML;savedpostRedoDWG9B4DCBE4,localonly. FullCV07/engineering/olderruntimeacceptancepending.

### Codex LandXML initial-import isolation — 15 October2026

1. **Supersedes cause uncertainty above:** BUG605failsBEFOREUndo/Redo inindependentfreshimport752; savedpostRedoreadback748alsofails. RepairinitialprovidedILmapping/recordsandthenprovebothinitialandUndoRedo/diskreadback. No requirementforTimtoisolatecausehimself.
2. **Same-source control:** secondidenticalXMLstillfourpit-schedulerows756; stableidentity/fullgeometryduplication/overridesNOTyetaccepted. Bothcopiesclosednormally,initialcontrolsavedlocalonly.
3. **Representative acceptance still pending:** correct49.000/48.850inplan/schedule/Inspector,before/afterUndoRedo/reopen;missingInvertstaysUnknown;previewbeforeApply,sourceawarewords,stableidentityandchangedrevisionoverrides/protections,2027and2024separate. Bugs602-605OPEN. No code/deploychangehere.

### Codex consultant drawing check — 15 October2026

1. **606OPEN:** nativeCDCHECKDWGresultwindow/summaryworks,butreportwritesbesidesourceDWG. Claudeownsreportdestination;useexistingapprovedCEreportlocation. NativecontrolsEscape/missingfilepass,sourceDWGhashunchanged.
2. **Representative retest:** currentandexternalDWG,sourcehash/foldermanifestunchangedbychecker,actualreportatapprovedlocation,visibleon-disk/unsavedlimitation;missing/read-only/corruptsourcesplain,2027and2024separate. Exactin-memorynonmutationandengineeringQAtruthremainunproved.
3. **Evidence:** verification315-317/local761-768/drawing-checkactualreport;freshsessionempty,preferencesunchanged,no productionfixinstalled. CodexcontinuesauthorisedcopieswithoutTimdrivingeachtest.

### Codex LandXML regression guard ready —15October2026

1. **PR1258 d82d2dc4:**tests-only10modern5PASS5FAIL,zero skipped. Existingmapperknown/UnknowncontrolsPASS;duplicateevidenceandmissingsharedmapperwiringFAIL. net48build0errors286warnings28.49sec,no runtimePASS. RED,dontmergealone.
2. **Claudeintegration:** useonecanonicalprovidedlevelassignmentinLandXMLentry;deduplicatenamespaceenumeration,retainUnknown/multiple-endsemantics. Thenactual49.000/48.850plan/schedule/Inspectorbefore/afterUndoRedo/reopen. CV07preview/source/identity/protectionsandolderruntimeacceptedseparately. No productionfixinstalled.

### Codex reference comparison score —15October2026

1. **607OPEN:** added-networkreferencecorrectlylists2missingpits/1missingpipeyetOVERALLSCORE100%. Claudecomparisonformatterrepair;sharedfieldsubscoreandassetcompletenessmustbedisclosedhonestly,no competingengine.
2. **Representativeacceptance:** identical2pit/2pipecontrolmatches;addedP91/P92/300pipecontrolshowsexactMISSINGcountswithoutoverall100%;reverseEXTRAandchangedlevel/sizecasesseparate. KeepownershipUnknown/stored-cachecaveatvisible,verifyfiles/sourcefolderandlivegeometryunchanged. OlderAutoCADseparate.
3. **Evidence:** native769-781/localcomparisonledger/reporttext;cleanrunafterdiscardingoperatorF2/CLEANchanges. Currentcopyclosed,all3DWGhash/bytes/mtimeand3preferencesunchanged. Fullin-memorynonmutationunproved. No repairinstalled.

### Codex607regressionready—15October2026

1. **PR1258/0f2022b5:**ninechecks5PASS4FAIL/zero skipped;fourmissing/extraassetsoverall100%failures,matching/changedcover/nonmutation/existingcontrolsPASS. net48build0errors286warnings31.33sec,no runtimePASS. Tests-onlyRED/combinematchingClaudeformatterrepair.
2. **Nativeacceptanceremains:** identicalandaddednetworkcontrols,nofalseoverall100%,reverseEXTRA/changedvalues,ownershipUnknown/cachecaveat,exactin-memory/filesourcenonmutation,olderruntime. No newproductionfixinstalled.

### Codex Structural checklist—15October2026

1. **608/609OPEN:** realStructural1.0.116NAfirstitem0/3withoutreason/persistsreopen;closed-DWGpalettekeepsstalestatesandcontrols. Codexprompt/contextdisplayplusClaudecanonicalrecord/targetcontract. No productionrepairinstalled.
2. **Representativeacceptance:** Xref4templateCancelleavesnone;Apply0/4,N/Ablank/Cancelkeeps0/4,validsyntheticreason0/3withtraceablereason/user/timeafterreopen/report. UndoNArestores0/4. CloseAclears/disables;Bwithoutchecklistshowsnone;returnAloadsitsownrecord. AutomaticFail/Unknowncannotbemanuallypassed. NativeUndoRedo/protection/olderruntimeindependent.
3. **Evidence:** verification325-327/local782-802/checklistledger. Syntheticmanualtickcontrolsarenotengineeringacceptance;missedclick784/unexpectedHelp800excluded. SavedNAfaultB39551DBpreserved,copyclosed,threeCEpreferencesunchanged,paletteopened/resizedintentionally.


### Codex Structural checklist context/Undo —15October2026

1. **Narrow native PASS:** ordinaryA/B context isolation, itemnoteCancel/reopenblank and Escape.609 remains stale at finaldocumentclose;608 still reasonlessN/A.
2. **610OPEN representative check:** fresh saved four-itemA (firstN/A), UndoN/A0/4, immediate nativeUndo0/3/Redo0/4 BEFORE switching, retain same four identities; thenA/B switching and actualsave/reopen agree. Currentdiagnostic insteadshowedNoChecklistafterUndo/reactivation; record-losscauseunproved,after-switchNothingtoredonotattributedtoCE. Claude storage/Undo plus Codex context display, no productionrepairinstalled.
3. **Evidence:** verification328-331/local803-818; savedA/B and threepreferencesunchanged; no client drawings or engineering approvals.2027 and2024 acceptance separate.


### Codex610single-editisolation completed—15October2026

1. **Supersedes cause-isolation remainder:** native819-824 proves NoChecklistafterUndo/QSAVE/reopenwithoutdrawing-switchornotes.610HIGH/OPEN; actualinternal deletionversusunreadablerecordunproved. IndependentimmediateRedo825-831beforeanyswitchrecoversfouritems0/4andsurvivesreopen.
2. **Remainingrepairacceptance:** oneUndoofN/Aeditrestoresreadablefour-itemchecklistand0/3;Redo0/4;actualrecordandpaletteagree,thenA/Bswitch/save/reopen. PreservecanonicalQAauthority/identity;Claude storage/Undo andCodexrefresh. ImmediateRedoPASSdoesnotclose610.2024/protectedtargets/otheredittypesstillpending.


### Codex609lifecycle regressionready—15October2026

1. **PR1260/6e01714a:**tests-onlychild1254;3modern2PASS1FAIL/zero skipped104ms. Compiledclose/no-currentrefreshroutefails,activationandlistenercleanupcontrolsPASS. net48build0errors10warnings25.67s,noruntimePASS. REDdontmergealone; no productionrepairinstalled.
2. **Combineandnativeacceptance:** lastdrawingcloseclearschecklist/showsNo drawing open/disablesdrawingactions;Bwithoutchecklistnone,returnAownrecord. Timing/rapid-switch/protections/2024separate. Exact610Undo/readbackfailureseparate;immediateRedoPASSdoesnotcloseit.


### Codex Structural sections native window —15October2026

1. **NarrowPASS:** installedSBEAMPFCsearch/no-matchgating/recovery,sideflangeTowardAway/frontpreview,Timberblank/90x240SectionpreviewandCancel. Noactualsectionplaced.611LOWOPENfalseTimbersteel-searchstatus;Codexexistingwindowstatusrepairmustpreservevalid/invalidsteelbehaviour.
2. **Representative remaining:** onePFCsectionandoneelevationplacedatknownpoint/scale,Inspector/SBEAMEDITsameviewandidentity,oneUndoRedo/save-reopen,correcthiddenlines/hollowinnerwalls/nativeplot,protectedtargets;oneRCbeam/column,linkedcalculationstaleness and2024separate. Noengineeringvalueapprovalfrompreview. Local836-850/sectionledger,baseline161895ADBC0B48intact.


### Codex Structural section placement/edit —15October2026

1. **Supersedes noactualplacement:**200PFCnativeplaced/finished,UndoRedo commandroundtripandactualsavedreopenedvisiblegeometry observed. FullmanagedrecordUndoRedoacceptanceunproved.
2. **612OPEN:**SBEAMEDIToutlinecannotreadrecordafterRedoandafterQSAVE/close/reopen. FreshnoUndo controlpending. Repairacceptance:place200,editreadoutline+label,Cancelunchanged;200to250preview,oneUndo200/Redo250,save/reopenedit250. Claude nativecanonicalrecord;Codexwindowacceptance. Scale/hollows/elevations/protection/plot/RC/2024remainseparate.


### Codex612freshcontrolresolved—15October2026

1. **Freshplacementalsofails:**200PFCimmediateSBEAMEDITwithoutUndoRedofailsfromoutlineandlabel865-869;UndoRedoisnotnecessarytrigger.Bothspecimenssavedlocallyandclosed870-871. No repairinstalled.
2. **Nextrepairguard:**actualwriter-to-readerroundtripbeforeUndo,theneditedsize/UndoRedo/save-reopen;canonicalnativeownerClaude. Source-onlytestsnotnativeacceptance.CodexcontinueRC/remainingsectionspluswholeworkflowcoverageandowner-safe611statusrepair.


### Codex RCBEAM native batch —15October2026

1. **NarrowPASS:**Plainbeamvisualpicker/livepreview,zero-widthvalidation,top-barcountpreview,actualfivebar/coggedlig/labels/dimensionoutput,oneUndovisiblecleanup,savedreopenedoutput.OnlyPlaingeometryexecuted,notallType1-8orcolumns.
2. **613OPEN:**outline-onlynativeMOVEstrandsreinforcement/annotation.ST8-9/10repairacceptanceallcomponentsMOVE/ROTATE/ERASEtogether,COPYnewmeaning/identity,UndoRedo/save-reopen/protectionand2024.Claude nativewriter;Codexexactpreviewwindow.Previewcurrentlyomitsactualcog/twowindowsnotapprovedsinglevisualworkflow.
3. **Remainder:**RedoafterautosaveNothingtoredoUNPROVENcausation;nativeProperties375area/80lengthwith300x500UI/note1:1needsdrawing/detailscalecontractbeforegeometryacceptance.WholeST08/engineering/plot/otherRCformsremainunproved.Local872-896/structural-rc/cases.json;freshmainempty,sourceandprefsunchanged.


### Codex column-review evidence —15October2026

1. **Already exercised in installed2027:** ST08 RCRECTCOL opening/600x400mm live-preview/Cancel; RCCIRCCOL opening/zero-diameter warning/Cancel. Six boundedPASSchecks including unchanged specimen/settings cleanup; verificationarea356-357/localRC13-18. No fullroworengineeringacceptance.
2. **Representative remainder:** place one rectangular or circular column with explicitly reviewed dimensions/reinforcement; compare preview and drawn bars/cover/dimensions, move complete detail, singleUndo/Redo, save/reopen, plot and2024. ExistingST08card governs; no extra individual manual backlog or install requested.


### Codex column-output evidence —15October2026

1. **Already exercised in installed2027:** rectangular400x400/fourbarandcircular450mm/eightbarvisibleoutput,oneUndo/delayedRedo,bothsavedreadback. Area358-361/localRC19-28. ExistingBUG613nowalsofailsrectangularcolumnMOVE;preserveitOPEN. No wholeST08orengineeringacceptance.
2. **Remaining representative acceptance:** repairedoutlineMOVEcarriesbars/tie/hatch/label/dimensions;verifyexactdimensions/cover/scaleandplot,thenprotectedcontent,COPY/ROTATE/ERASE,linksand2024. KeepthisinexistingST08batchratherthanindividualmanualbacklog.

### BUG-576 — column picker instruction candidate (15 October, PR1261)

1. **After the combined authorised release:** C2 and SC2 show nine choices and Press 1–9; key9 then Enter selects 250x90 PFC. Cancel/Escape leaves the owned support unchanged; inspect dark/light appearances. Candidate b2e56d16 has modern/legacy builds only, no installed acceptance. Existing successful key9 evidence105–106 is the control. BUG remains OPEN.

### ST-05 hatch follow-through — BUG-614 (15 October)

1. **Recorded:** CEHATCH search/no-match/Materials/20-scale preview/Cancel pass narrowly;50/500 concrete preview and Place refuse. No placed hatch accepted by this batch.
2. **Remaining grouped check:** approved scale policy20/50/100 and actual plot density, native associative output from owned Objects/Points boundaries, islands/origin/angle, HATCHEDIT, Cancel/Escape, Undo/Redo, save/reopen and protected/Xref content. Reuse the synthetic hatch specimen and existing ST-05 card; Claude owns the command repair. No guessed engineering formula.


### Codex15October — ST05hatch output follow-through

1. **Observed now:** CH1:20 Objects/Points nativeassociation, HATCHEDIT, outerboundaryandislandMOVE, cancellation, singleUndo/delayedRedo andsave/reopen onownedcopy.13narrowchecks12PASS1FAIL; notwholeST05acceptance.
2. **Remaining grouped acceptance:** BUG614normal1:50 andBUG615actualdrawingpreview/Apply; remainingpresets/1:100/plotdensity/draworder/nestedislands/protectedlayers/Xrefs/REFEDIT/grips/H2Arollback/olderversions. Retain acceptedCHnativeoutput while addingreviewstage. Nativepropertiesmustremaineditable/associative.
3. **Usage instruction:** Tim supersedes10%reserve15October: useallowanceto0%,thenTimresets. Do notstopat90%; saveeachcoherentbatch.

4. **Alias evidence follow-through15October:** EH/CH/WH/LBH/LBUH/BLH1:100 preselection/nativeproperties/save-reopen now observed narrowly; WHorigin Propertiesedit/persistence and BLHUndoRedo pass.12newcases11PASS1FAIL; same615livepreview/Applygap acrossaliases remainsOPEN. No allpreset/plot/protection/H2A/oldversion acceptance inferred.


### Codex native Xref follow-through —15October2026

1. **Installed narrowresults:** XRLINFO/normalXRLtransfer/nonlayerpropertypreservation/oneUndoRedo/mixedlockedprotection/sourcefilehash/save-reopen exercised inAutoCAD2027 onownedcopies.9checks7PASS2FAIL; no2024/fullworkflowacceptance.
2. **Open616/617:** Addapprovedhighlightedpreview/counts/Apply withEscapenochange. Preflightlockedreferences inplainEnglish; failedrunmustnotcreateemptytargetlayer. Preserveexistingnativeprotectionandallreference/sourceproperties. Claude serviceowner; nofixcandidateinstalled.
3. **Grouped remainingacceptance:** Same two-referencefixture, thenoverlay/paperspace/targetlocked/nested/unloaded/missingpaths/Xclip/REFEDITandlargecancel. OneUndo/Redo/save-reopen; compare sourcehashes. Do nothandTim individualhistoricaltestbacklog.


### Codex Xref settings/copy —15October2026

1. **Observed:** XRLCONFIGtab/values, editCancel/fileunchanged/reopen, cleanEscape, CXREFEscapeandPXREFemptyclipboardrefusalpassnarrowlyin2027. Savevalidation/invalidvalues/otherresolutions/2024notaccepted.
2. **Open618:** RepairCXREFloaded-referenceeInvalidKey beforefullST5-12pasteacceptance. UseownedCODEX_XRLfixture; firstreferenceunlocked. Aftercopyworks, verifytype/path/insertion/scale/rotation/Xclip/layeroverrides, original/pickpreview/unitcheck, missingpaths/Cancel/Undo/save-reopen. Claude serviceowner; nofixinstalled.


### Codex existing-hatch Audit/Change —15October2026

1. **Open619:** Report-onlyCEHATCHAUDITandCEHATCHCHANGEApplyfail eInvalidKey in2027synthetic24-hatchfixture. All24originalnativehatchespreservedexactly; modeEscapepasses. No servicefixinstalled.
2. **Grouped acceptance:** Reportmustfinishcounts/findingsread-only; changingoneBLHtoConcreteSlabmustretainboundary/islands/background/nativeediting, thenUndo/Redo/save-reopen. Includecustom/protected/unsupportedhatchesand2024. Traceactualerrorbeforechoosingrepair; donotinferitfrom618sameerrorwording.


### Codex batch hatching and gap cancellation — 15 October 2026

1. **Observed:** two independent associative native hatches, grouped Undo/Redo and gap-tolerance Escape pass narrowly in 2027. Saved in a separate synthetic batch drawing; original audit specimen unchanged.
2. **Still open:** BUG-615 also applies to batch placement: library thumbnail then immediate commit, without the approved drawing preview and adjustment stage. Actual gap bridging, batch reopen, protected objects, plotting and 2024 remain untested.

**Codex ST-05 update,15October — gap assistance:** measured2mm opening bridges at5mm tolerance;20mm opening safely refuses; both outlines remain open with unchanged geometry and prior hatch survives refusal. Negative input and control restoration pass narrowly. HG-01–06:5PASS1FAIL, BUG615 preview/Apply stillOPEN. Next grouped acceptance: gap Undo/Redo, move/grip open boundary, save/reopen, islands/scale/units/UCS/protection/plot; no wholeworkflow acceptance. Evidence in existing Codex V3UX verification/report/index.

**ST-05 follow-through,15October:** gap hatch save/close/reopen now passes;500mm whole-boundary MOVE follows,oneUndo and delayed34.7sRedo pass with exactnativepostRedorecords. Four additionalPASS,HGR-01–04. This supersedes the earlier gap-reopen/whole-boundary-MOVE remainder only. Original CE gap-placement Undo/Redo,grip/stretch/rotation,islands,protectedcontent,scales/units/UCS/plots/older releases remain. BUG615 staysOPEN.

**ST-05 save-only gate —BUG620:** source for installed Structural version still purges unused definitions and changes Xref layers before FASTSAVE. Native reproduction pending; source finding only. After command-owner repair, verify dirty disposable fixture saves without changing any drawing/symbol/reference data, then reopen; include save-failure refusal. Full15ST5decision review is now in existing coverage index, with67nativecases linked narrowly.


### Codex ST-03 dimensions follow-through —15October2026

1. **Recorded native sample:** AD5000mm andLD4000mm placement/nativepreviews; ADoneUndo/delayedRedo/source-lineassociation; bothdimensionssave/close/reopen.12boundedchecks10PASS2FAIL, no wholeST03acceptance.
2. **BUG621 repair acceptance:** beforeAD/LD chooseStandard/currentgreen3/Continuous/0.25mm; cancel first/late and complete placements. All prior styles/layers/snaps/appearance mustrestore; existing style definitions unchanged. Retain native geometry/association/recovery/reopen passes. Claudecommand/serviceowner; no installedrepair.
3. **Remaining grouped coverage:** Q/QD/RD/MLL/MLR, linkedlevelmarks/update and sections/breaklines/dimensionrepair; LDplacementUndo/Redo; grip/stretch/rotation; protected layers/Xref/REFEDIT; scale/units/UCS/paper/plot;2022–2024native lane. Engineering intent still needs Tim where relevant. Evidence remains local in existing V3UX_20261014 store; no individual backlog handed to Tim.


### Codex ST-03 radius follow-through —15October2026

1. **Native sample:** RD Radius on1000mmcircle previews/places nativeR1000; oneUndo/22.309secondRedo pass. CompletedcommandleavesTIMLEADERinsteadStandard, extendsBUG621. Lengthmodearc-selectionEscapeaddsnone.6checks5PASS1FAIL; radius trial notsaved/reopened.
2. **Remaining:** actualDiameter/Lengthoutputs, unsupported/broken/protected geometry, association afterradiusedit, grips, scales/UCS/paper/plots/olderAutoCAD. Approved ST3-5geometry-first differs installedtype-first: retain workflowgap; no silent redesign. Q/QD/MLL/MLR andlinkedlevel/section familiespending. CE_ARCDIMregistryentryassociated throughdeclaredRDalias; primarytypednameunverified.
3. **Cleanup:** controls/Lengthdefaultrestored, unsavedtrialdiscarded/savedbaselineunchanged. Settingssave normalised an installation timestamp to equivalentUTC; exactsemanticdiffcheckedbefore originalbytesrestored. No unrelated preference overwritten.


### Codex ST-03 left/right note leaders — 15 October 2026

1. **Recorded:** MLL/MLR native objects and paragraph text; readable MLR preview/output at1:100 with2.5mm text/3mm arrows; clean immediate Undo/delayed Redo for MLR; both objects persist after actual save/close/reopen.10 checks:7PASS2FAIL1UNPROVEN.
2. **BUG622 acceptance:** preserve arrow point and note; F flips left/right during placement, F again flips back. Actual preview/output must agree; Escape adds none. Verify native editable object, oneUndo/Redo and reopen at supported scales/UCS/paper space/protected layers. Claude command/service repair card recorded; no installed fix.
3. **Remaining:** clean MLL recovery (earlier input-cancel history contaminated grouping), complete cancellation paths, native editing/grips, placement precision, plots, legacy runtime and fullstyle portability/nonmutation. Q/QD remain untested by this batch. Original controls/preferences restored and all owned drawings closed.


## Codex Q/QD native follow-through —15 October2026

1. **Narrow Codex-accepted:** native arrow/dot preview/output and linked LEADER/MTEXT25DIMS at1:100; first-point Escape adds nothing; each immediate oneUndo/delayedRedo; both full records survive save/close/reopen.12checks9PASS3FAIL, quick-leaders-case-ledger.json/screens1137–1162, receipts416–418.
2. **Fault retests:** BUG621 Q/QD cancellation must restore prior Standard style and all drawing controls. BUG623 Q note must remain readable inside native editor; first isolate ordinary native MText/same Standard style and clean-template/known-font controls. Existing fixture has empty Standard font fields; do not assume CE caused them or rewrite global definitions. Confirm actual edit/Undo/Redo/reopen after repair.
3. **Still untested:** Q/QD later-stage Escape, multiline/width/multiple vertices/native grips/stretch/text movement, definitions portability/nonmutation, other scales/UCS/paper/units/protections/plots/older versions. CleanMLL grouping remains separate. No wholeST03/50% acceptance. Capturedcontrols/settings restored, saved copy/source drawings preserved, owneddrawingsclosed/lease released.


**BUG623 diagnostic remainder —15 October:** native Standard control and repeat Q editor became readable after reopen plus temporary font/control creation; existing Standard definition unchanged. Initial blank editor is not consistently reproduced. Repeat immediately after clean reopen before controls, then isolate native controls separately; retain both outcomes. Temporary controls discarded, no new plugin check counted, no repair installed or accepted. Evidence1163–1168,receipt419.


## Codex clean MLL follow-through —15October2026

1. **Narrow Codex-accepted:** arrow/note/preview Escape leave122objects and12capturedcontrols unchanged; nativeparagraphMLeaderoutput; immediateoneUndo/52.337secondquietRedo; fullnativeobjectsave/close/reopen.9checks8PASS1FAIL, receipts420–423. EarliercontaminatedML03remainsUNPROVEN asitsownsample.
2. **BUG624repairretest:** MLL arrow→two-line note→clickclearlyleft; previewandfinalnote/leader mustmatchselectedlocation/side. RepeatMLRright,long/shortnotes,snapson/off,scales,UCS,paper/protection,UndoRedo/reopen. Rootcauseunproved; command/serviceowner,noinstalledrepair. Ftoggle622remainsseparate.
3. **Remaining:** nativeedits/grips,paragraphstyles/portabledefinitions,fullnonmutation,levels/sections/breaklines,otherannotationpaths/plots/legacyruntime andwholeST03/V3coverage. Source/preferencesintact,all12originalcontrolsrestored,owncopyclosed/lease released.


## ST-03 next missing workflow families — 15 October 2026

1. **Level marks:** FFL/RL/SSL/NGL must offer trusted source or Manual/Unknown, complete following preview and F flip. Check each prompt’s Escape, native object set, state restoration and save/reopen. Inspect any preference changes before restoring only owned test changes.
2. **Safe update:** on a synthetic ordinary note beside a genuine level mark, LMU must refuse the ordinary note and only propose changes to recognised marks/references. Source accepts TEXT/MTEXT broadly; this is a source risk pending native reproduction, not an additional executed test.
3. **Sections, breaklines and repairs:** full section preview with identifier/sheet/both bubbles; compound MOVE/COPY/EDIT; BL model/paper/scales/UCS; dimension repair scope/preview/Apply with no forced save. Approved card ST03 and its 15-decision audit remain the authority. No full-card acceptance.


## Native level safety failures — 15 October 2026

1. **BUG625:** LMU must refuse ordinary TEXT/MTEXT, preserve unrelated nearby notes, and propose only recognised CE mark/reference changes before Apply. Native overwrite now reproduced; source-risk-only status is superseded. Test real recognised mark/source propagation, every cancellation stage, one Undo/Redo and reopening.
2. **BUG626:** complete FFL/RL/SSL/NGL trusted-source or Manual/Unknown flow, full following preview, F flip and final click. Current FFL entered-value/output recovery passes narrowly; do not rebuild those working parts unnecessarily.
3. **BUG627:** normal MOVE from any recognised mark component must carry symbol/tail/value/source together. Check COPY fresh identity, edit, safe erase, recovery and reopen across protection/scale/UCS/paper/legacy contexts.
4. **Recorded:** levels-case-ledger.json10checks7PASS3FAIL, screenshots1190–1217 and8metadata; receipts426–430. Captured13controls and rememberedSSL restored; source/saved files preserved, own drawing closed/lease released. No repair installed or engineering acceptance.


## BUG611 Timber section status candidate — 15 October 2026

1. **Candidate:** draft[PR1262](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1262),30e0cffe, isolated installed-sourcef180 base. Window status/contrast only;16modern guards pass and both standalone builds0errors0warnings. Candidate not installed; bugOPEN.
2. **Native replay after coordinated install:** SBEAM→PFC→search200→200ZZZ. Genuine no-match must be readable, clear stale geometry and disable Place. Clear search; recover choices. Timber with blank dimensions must show timber guidance and no steel warning;90x240mm must show correct preview/enablePlace. Return to steel and repeat no-match/clear. Run Dark/Light, keyboard/Cancel; catalogue-load failures must stay visible.
3. **Separate:** no wholeST08, placement/compound/member-edit/plot/protection/legacy native acceptance. Render guards exercised compiled windows outside AutoCAD, never accepted a placement or wrote live preferences. Native count582 unchanged. Revert candidate commits to undo; no deployment performed.


## Native BL scale and current-space failures — 15 October 2026

1. **BUG628:** compare BL20/50/100 and another supported scale; native zigzag must have consistent paper dimensions.20/100 output passes narrowly;50 currently40% size. Verify actual plot/PDF after repair.
2. **BUG629:** BL from Layout1 paper space must remain on Layout1; test actual clicked points, model/active viewport, scale/UCS/protection and saved readback. Current native output incorrectly belongs to Model.
3. **Evidence/remainder:** seven checks5PASS2FAIL,13screens1218–1230/ninemetadata. First/second Escape and full native-record persistence pass; full cursor preview, rotated UCS, native editing, isolated UndoRedo/protections/older runtime remain. No repair installed.


## Section mark native failures — 15 October 2026

1. **BUG630:** identifier/sheet first, complete following line/bubbles/fill/labels preview and final placement confirmation. Current SM asks geometry first and draws immediately after sheet entry. Check later Escape and all directions/F.
2. **BUG631:** normal MOVE from line/bubble/text must carry whole recognised section; COPY fresh identity and duplicate-reference confirmation, safe edit/erase, one UndoRedo and reopen. Current cut-line click selects1and strands remainder; UndoMOVE restores exact11records.
3. **BUG632:** complete identifier must stay readable against half-fill at both ends, in dark/light drawing and plot/PDF, for all directions/sizes/labels. Native A/S02 data and persistence pass narrowly; visual identifier currently partly hidden.
4. **Evidence:** sectionmarks-case-ledger7checks4PASS3FAIL;16screens1231–1246/sixmetadata. Source/settings preserved, owned window empty/lease released; no repair installed. Original placement UndoRedo, protections/units/scales/UCS/paper/performance/older release remain.


## Dimension repair native failures — 15 October 2026

1. **BUG633:** DSET must select ordinary native dimensions through line/text and preselection. DSET1 is the positive control for the actual specimen. Do not accept arbitrary non-dimension objects.
2. **BUG634:** unrecognised styles remain unchanged/reported; supported selections show existing/proposed scope/style before Preview/Apply. Check every cancellation, mixed leaders/objects, protection and one UndoRedo.
3. **BUG635:** approved factor must agree with visible native measurement immediately, after REGEN/reopen and rendered plot. Current5000mm specimen stores0.2 yet displays5000. Saved wrong-state retention is not acceptance.
4. **Recorded/remainder:** six checks3PASS3FAIL,13screens1247–1259/sixmetadata. DSET1 no forced save in this sample; DUP remains unexecuted and needs its own scope/no-forced-save test. Ninecontrols/source/preferences preserved, owned drawing closed/lease released. No original UndoRedo, plot, supported-style or whole-family acceptance.


## DUP scope and unrelated-note failures — 15 October 2026

1. **BUG636:** replace implicit whole-drawing conversion with approved selectedscope/existing-proposedPreview/Apply; preserve/report unknown styles. NativeDUPat20nowchanges8dimensionswithoutselection; at1refusesunchanged.
2. **BUG637:** unrelated schedule remarks must remain exact during dimensioncommands/REGEN/recovery. TwoMTEXTnotes change wording/paragraph/capitalisation duringDUP; rootcauseunproved. Preserve legitimate explicit scheduleupdates separately.
3. **Positive controls:** firstDSETEscape/selectedDSET1Escape exactrecords/controls unchanged;DUPno-forcedSave sample;secondUndo restoresallcapturedrecords/controls. DelayedRedoacknowledged,butfullpostRedorecordequalityunproven. OriginalDSET1recovery,protectedmixedobjects/spaceUCSunitsplots/olderruntime remain.
4. **Evidence:** dimcancel-case-ledger9checks6PASS2FAIL1UNPROVEN;19screens1260–1278/ninemetadata. Originalcontrols/source/preferencespreserved;testclosedNo/exactleasereleased. HistoricalDUP-unexecuted statements are superseded by thisboundedbatch only. No codefix/install.


## Recognised-style dimension and locked-layer follow-through — 15 October 2026

1. **BUG638:** DSET1lockedtargetmustrefuseplainlywithoutUnhandledException;preserveentireprotectedrecord/layerlockandrollbackanyeligiblechangesinamixedbatch. Nativeerrorandunchanged-statepositivecontrolnowrecorded. Xref/REFEDITandmixedlockedbatchremain.
2. **BUG635:** knownTIM LEADERnowreproduces0.2stored/5000displayedafterRedo/REGEN/savecloseopen;unknownstyleisnotrequired. Confirmnativegraphicsandrenderedplotagreewithapprovedfactorafterrepair.
3. **Narrowpasses:** selectedscopeonly110Bchanged,0.5dimension1118skippedexact,allotherobjects/control/layerpreserved;postRedonativeexpectedstateafter51.691secondquietdelay. FirstUndofullrecordcapturestillmissing. All3savedrecords/gfx/lock/originalcontrolsretainexactafterreopen. NoforcedsavebeforeexplicitQSAVE.
4. **Evidence/remainder:** dimprotection-case-ledger9checks7PASS2FAIL,18screens1279–1296/sevenmetadata;source/preferencespreserved,owncopyclosed/exactlease released. Fullnativegrips/otherdimensiontypes/spaces/UCS/units/scales/plots/olderruntimeandwholecardacceptance remain. No sourcefix/install.


## Requirement coverage and unexercised annotation routes — 15 October 2026

1. **Actualcommandroutes:** CE_LEVELMARK/LMprimarytriggerseparatefromtestedFFL;RCRevisionCloudagainstST09;RDLength/DiameteralongsideexistingRadiussample. Checkcurrentapprovedbehaviourbeforecodechanges,actualnativeavailability,preview/cancel/output/edit/Undo/reopen.
2. **Hiddenentries:** CSGENNOTES/CSLEADERNOTE/CSBOXNOTES/CSSLABSTEPneedavailability/featuregatedisclosurechecksfirst;registryentryaloneisnotbuiltfeatureacceptance. Notes/stepsneedtheirownlaterUXrulingsandapprovedworkflowreview.
3. **Cross-cuttingUX:** existingcasekeysnowlinkedtoSTD03/FAIL01/SEL01/LYR01;completecommandmatrixstillrequired. No-forcedSaveisboundedpositiveevidence;valid-object/wrong-targetfiltersandfailurehandlinghaveknownfaults;Settings-derivedlayercreationunproved. No whole-IDorpercentagecredit.
4. **Authority639:** resolve11brokenhistoricalcardindexlinksagainstexactprovenance/currentpointerswithoutrewritingverbatimapprovaltextorsubstitutingsupersededarchives. CurrentmasterV3gatesincludingstandaloneCivilandcolleaguepilotremaininthecoverageaudit. No newnativecasesinthisreconciliation.


## Structural BUG-1364, BUG-1400/1401/1403, BUG-1369/1370 (DRAFT, built and unit-tested only), draft PRs 2077, 2079, 2080 — 13 Nov 2026

Built and unit-tested only. Test on a COPY (a made-up Structural drawing), AutoCAD 2027, a build that contains the branch. Nothing here is installed or accepted. Each branch is based on the installed Structural 1.0.126 commit 8de95c34.

1. **BUG-1364 (PR 2077), BDL in a metre drawing:** on the copy set INSUNITS to metres and run BDL. Right looks like: one plain line (the same one AB says) and nothing drawn. Wrong: BDL asks for points and draws a lower line 100 m away. A millimetre copy behaves as today.
2. **BUG-1400, BUG-1401, BUG-1403 (PR 2079), inside points:** save three points with BSET, then run BSETRESET. Right looks like: it asks "Clear them? [Yes/No] <No>" and names 3; Enter clears nothing; Yes clears them. On a drawing with none it says there is nothing to clear. On a layout tab and on a read-only copy, BSET and BSETRESET print a stop line first. The failure lines (could not save, read or clear) cannot be reached on a copy by a read-only drawing, because the new first stop comes first: record "not reachable on a copy" unless a damaged inside-point record can be made.
3. **BUG-1369, BUG-1370 (PR 2080), bracing panel:** on the copy place one A - BRACING LEFT block and two BRACING blocks on a frozen layer. Run CSBRACINGPANEL. Right looks like: the command line and a red note on the panel say "1 older-named brace ... is not in the bracing total or the schedule" and "2 braces on frozen or switched-off layers are counted in the bracing total"; the two totals are the same as before the change. Thaw the layer and press Refresh: the second line goes. Only current visible braces: no note. Also run STRSCHEDCREATE on the same copy: it now prints the same lines (once the second-review change is pushed); and check the panel in the dark theme and that it stays where it is placed when it grows.
