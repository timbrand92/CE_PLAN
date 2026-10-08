# Bug Carpark

> **FOR CLAUDE — READ THIS FIRST, EVERY SESSION**
>
> This file is the single source of truth for known bugs that are being deliberately deferred
> rather than fixed immediately. Follow these rules in every session, every chat:
>
> **At session start:**
> - Read this file before doing anything else.
> - If any bug is marked `IN PROGRESS`, tell Tim: *"We have [BUG-XXX] in progress from a previous session — do you want to continue that first?"*
>
> **When Tim reports a new bug mid-session:**
> - If it is not being fixed right now, add it here immediately using the template below.
> - Tell Tim: *"I've added that to the carpark as BUG-XXX — we'll come back to it."*
> - Do NOT start fixing it inline unless Tim explicitly says to fix it now.
>
> **When a carpark bug is being fixed:**
> - Change its status to `IN PROGRESS` before starting work.
> - Change it to `FIXED — YYYY-MM-DD` once Tim has confirmed it works in AutoCAD.
> - *27 Sep 2026 (Tim: "if codex can test then my rule of me driving it is no longer necessary and it can be the measure of that"):* a Codex PASS in real AutoCAD on Tim's PC also counts - write `FIXED — YYYY-MM-DD (Codex-accepted, pass N)`. Engineering-judgement items still need Tim.
> - Never mark FIXED until Tim has confirmed the test in AutoCAD — not assumed, confirmed.
>
> **Adding a new bug — use this exact template:**
> ```
> ## BUG-XXX
>
> **Command / Area:** (the AutoCAD command, alias, or LSP file affected)
>
> **Symptom:** (what Tim sees — described in AutoCAD terms, not code terms)
>
> **Expected behaviour:** (what should happen instead)
>
> **Reference:** (related .lsp file, command alias, or plugin area — if known)
>
> **Status:** OPEN
> ```
>
> **Status values:** `OPEN` · `IN PROGRESS` · `FIXED — YYYY-MM-DD` · `WONT FIX — reason`
>
> **Next BUG ID to use:** BUG-488 (BUG-476..487 = Manager and installer bug hunt HUNT-M-01..15 (no administrator list: first colleague to click Admin Dashboard becomes THE administrator and Tim is locked out; update messages name an installer nobody can run; Roll Back still offered; an old April Structural approval reads as newer; "CE is current" when the office folder is unreachable; Manager turns the menu bar on at every start; CESUPPORT zip lands in OneDrive; old install scripts and builds in the office folder; CEHEALTH misses Manager; Refresh with no error catch; long staging paths on 2022 to 2024; four LOWs; all from reading code and the drive, none seen in AutoCAD); BUG-466..475 = Structural bug hunt findings HUNT-S-01..15 (FPFC takes the typed mark's size, rotated UCS, roof-down with linking off, FEDIT Esc still saves, FSF picking an outline, metre drawings, layout/REFEDIT, locked layers, FEDIT rename overwrites a size, LOWs); BUG-458..464 = Civil bug hunt findings HUNT-C-01..07 (REFEDIT not checked, locked label layers, "Nothing was changed" sentences, fixed 10 percent, 2-decimal rounding, schedule read-only), BUG-465 = HUNT-C-08..15 (eight LOWs); all from reading code only, none seen in AutoCAD; BUG-457 = second independent Opus review of the Civil redo-safety paths: nothing writes between U and REDO on 3.0.40 or C-27 (code reading only), 3 MEDIUMs about the guard test blind spots, 9 routes Codex has never walked; BUG-456 = C-27 finalizer: GO at 319ba688, one MEDIUM fixed (false "other end open" line for a downpipe branch), 10 LOWs; BUG-455 = Codex W45 on Civil 3.0.40 / Manager 1.1.40: CEHEALTH and CESUPPORT zip PASS, the three start-up lines remain, Edit Pipe window still shows the 1 in 100 grade selector on a flat pipe (the #819 preview line was not seen); BUG-454 = Codex W44 on Structural 1.0.110: FSF Enter at the centreline question ends the command (seen twice), FPFC pad shows no label, R1 needs a third (top) object; CSREOBAR and FEDIT PASS; BUG-453 = Codex W43 on Structural 1.0.110: new C1 wording works, 13 settings keys added and nothing changed, off sentences still say the Settings page is "still to be built"; BUG-452 = C-26 finalizer: GO at 2162e2f5, the #811 login leak fixed, 10 LOWs incl. menu lines may remain on PCs that already have them; BUG-451 = Codex W41 on Structural 1.0.109: DAY1 steps 14/18/19/20 all BLOCKED by brief and operator faults, observations only; BUG-450 = S-27 finalizer: GO at 52bdb4b5, one wording commit, 7 LOWs; BUG-449 = Codex W39 on Structural 1.0.109: C1/TS1 label fix PASS, Esc PASS, beam PASS, Enter at the support text prompt starts the normal text command and prints "Text placed" before the label is placed (wording, S-27); BUG-448 = S-26 finalizer: #815 misread BUG-438, finalizer fix 1fd75ab6, Esc at the number question needs Tim; BUG-447 = C-25 finalizer: the P8 zero-length pipe is a real 1.68 m pipe whose ends were pulled together, wording fixed, end-matching cure is a Team item; BUG-446 = Codex W37: marker layer seen, stale marker stays after Edit Pipe Save, Civil log shrinking; BUG-445 = Codex W35: rebuilt #805 marker works, U/REDO passes, REGEN between U and REDO is native; BUG-444 = C-24 finalizer: rebuilt #805 proven redo-safe, 9 LOWs, W33 test; BUG-443 = S-25 finalizer findings (doubled default fixed, 8 LOWs, legend second-copy item); BUG-442 = Codex W32: FLAT label passes, Edit Pipe window still shows 1 in 100, CESUPPORT zip holds one file; BUG-441 = C-23 finalizer: #805 reverted (REDO risk), Roll Back and Kingston Stale notes, 7 LOWs; BUG-440 = Codex W29: BUG-061 not reproduced, zero-length P8 pipe, import single U passes, profile template points to a test copy; BUG-439 = S-24 finalizer findings (two MEDIUMs fixed, 8 LOWs); BUG-438 = Codex W28: C1 support text CR1 "DefaultValue is not set", column not CE-linked until a beam is linked; BUG-437 = Codex W26: C1/TS1 reject Enter at the support text prompt, old menu names fail at AutoCAD start-up; BUG-436 = Codex W25: BUG-061 re-import 53 vs 45 pipes + P8 to P8 self-pipe, no pipe list to count; BUG-435 = Codex W24: start-up lines "Menu item failed to load" + "; error: syntax error", C1 prompts; BUG-434 = Codex W21: C1/TS1 leave CLAYER changed when cancelled, _Dot message on C1/TS1; BUG-433 = S-23 finalizer LOWs (SF Xref scan, repeated line, Sheets Sync no warnings); BUG-432 = C-22 finalizer findings (CDTG grate cover 0.000 vs blank, MEDIUM advice only); BUG-431 = Kingston K02 label/edition flag + BUG-251 Team item; BUG-430 = Codex W20: pit label double-click opens the Enhanced Attribute Editor, override tick after Stop overriding; BUG-429 = Structural 1.0.105 writes 20 new default keys into the user CS_Settings.json at first start (LOW design question); BUG-428 = S-22 finalizer LOWs (BB brace no warning, limit compared in drawing units); BUG-427 = Codex W18 observations (flat typed pipe keeps a 1 in 100 label; footing region after STRETCH U/REDO); BUG-426 = C-21 finalizer findings (Pit Schedule window p1 case MEDIUM, wording LOWs); BUG-425 = second source audit Structural + Manager, 2 HIGH in the Manager update channel (Roll Back Release does nothing; Civil updates without Manager); BUG-424 = S-21 finalizer LOW findings; BUG-423 = C-20 finalizer findings (CDFIXFLATPIPES steep wording, three places real names remain); BUG-422 = unknown ground level skips the cover check in the Edit Pipe strip; BUG-420 = Pit Schedule window accepts a bare duplicate number (W14), BUG-421 = stray text typed into AutoCAD (voice?); BUG-417 = X-Civil import unlocks locked layers (HIGH), BUG-418 = strip footing commands re-layer the whole drawing (HIGH), BUG-419 = source audit MEDIUM/LOW findings; BUG-414 = Edit Pit rename onto an existing number can delete the other record (older), BUG-415 = pit-number wording gaps, BUG-416 = C-19 small items; BUG-413 = W11c Structural 1.0.102 observations incl. Civil machine-report name with real login; BUG-412 = W10c observations (record-not-saved line, CDRULES prompt); BUG-411 = F2 runs CLEAN; BUG-409 = Codex changed Tim's ABFLIPAUTO setting (restore), BUG-410 = W11 observations on 1.0.102; BUG-408 = Stop overriding status sentence not seen (#681); BUG-405 = report privacy gaps (#662 SourceRoot/StatusSummary, Civil file name), BUG-406 = four old-metre readers left, BUG-407 = #678 fails #686 guards; BUG-404 = C: drive space swings and build stops (Windows Search indexer, installer scratch, Codex snapshots); BUG-403 = quiet paste catcher prints nothing when Civil is already awake and the destination has no record; BUG-402 = StrucPlus LISP not found at start-up; BUG-401 = New Pit cover blank after restart; BUG-399 = FEDIT gap pick misses (observation), BUG-400 = Duplicate definition of block _Dot message; BUG-398 = issue preview vs issue disagree (#692); BUG-397 = Manager CE.Host load list (#684 LOW 2); BUG-396 = C-17 and S-18 finalizer findings; BUG-395 = Codex verifyW8 results; BUG-394 = CSREOBAR doubled defaults + driver run 26; BUG-393 = four places still read old metre records 1000x short; BUG-392 = Codex verifyW7 results: FST Delete on a locked layer PASS but U does not restore the footing in CE record; BUG-391 = driver run 24 results + 7 findings (BEXTEND/FEDIT doubled defaults, INSUNITS, undo step after FST cancel, FADOPT arc/ellipse, CEMANAGER no window, MOVE message); BUG-390 = Codex verifyW6 results: BUG-385 fixed in real AutoCAD; BUG-389 = CDCHECK command-line list prints a raw arrow escape; BUG-388 = FDELETE question prints [Yes/No] twice; BUG-387 = CLAYER nil after a Pit Schedule Revert/U sequence; BUG-385 = Pit Schedule Revert Row Override makes the row disappear; BUG-386 = Revert keeps the typed cover (question); BUG-384 = locked pipe layer batch refusal does not mention the lock (wording); BUG-383 = a fresh open already shows DBMOD 1 before any CE command; BUG-381 = Foundations manager open+close marks the drawing modified; BUG-382 = FST status line log tail; BUG-380 = Codex verifyW3 results (FEDIT edge pick, OSMODE 1151, ribbon menus, Edit Pipe has no layer box); BUG-376 = Pit Schedule blank IL; BUG-377 = raw U+2192 in a warning; BUG-378 = first open skips the old-pipe upgrade; BUG-375 = C-11 finalizer side findings; BUG-374 = Codex verifyW2b results (templates all INSUNITS 4 mm; Edit Pipe Cancel DBMOD; scaled Edit Pit label unclear); BUG-373 = driver session 15: Edit Pipe Cancel marks the drawing modified (DBMOD 17 to 21), CDDESIGN drop-downs read class names; BUG-372 = raw handle and block name in the invert text no-clear-spot line (LOW); BUG-371 items closed by driver runs 12-13 (Civil 3.0.25 all pass); BUG-371 = C-10 finalizer leftovers (2024 names test, BUG-364 cause unsettled, LISP STRETCH undo); BUG-370 = driver session 11 on Structural 1.0.94: undo counts, layer probes, names all PASS; Kind column code words LOW; BUG-369 = S-10 finalizer leftovers (frozen layer draws a hidden bar, LOW); BUG-368 = Structural: extra empty undo step after CSREOBAR and CSBARSCHEDULE (BUG-358 pattern); BUG-367 confirmed in real AutoCAD (frozen layer thawed and recoloured, STR unlocks a locked layer outside the undo); BUG-367 = S-9 finalizer: CE silently resets and UNLOCKS existing layers (RBL, RBC, STR: MED, in 1.0.92 too); BUG-366 = driver session 8: CSREOBAR typed fails (investigating), paste into a no-drainage drawing prints no line (BUG-342 part 1 open); BUG-365 = UI mapping session 7: more unnamed controls and jargon names, Settings Enter saves the window, sheets scan whole folder, crash-inference records after driver kills, Structural telemetry not anonymised; BUG-364 = driver session 6 results: first-use locked-layer line prints raw handles (LOW); LISP PostCommand also spins (still not CE); BUG-363 = C-9 finalizer leftovers (old pit copy MOVE rewords original pit pipe labels LOW-MED); BUG-362 = S-8 finalizer leftovers (LOW); BUG-361 = typed PIT prompt burns 1.5-1.9 cores, hot thread in CE DrawingService.GetPoint (reopens BUG-359); BUG-360 = UI accessibility names and jargon; BUG-359 = AutoCAD wedges caused by the driver leaving a prompt open (CDCHECK first question, bare LINE), not CE; BUG-358 = driver run 2: S-05 extra silent undo step (MED), second AutoCAD wedge (investigating), locked-layer wording; BUG-357 = modern pipe fixture findings (silent grade change when a pit is moved with the pipe layer locked, MED to confirm); BUG-356 = Whats New window modal at first start after an install blocks automation; BUG-355 = first driver run findings (FEDIT outline pick, legacy pipe fixture); BUG-354 = CE_StrucPlus LISP not found at every start (old ce_suite_startup.lsp, not in repo; LOW); BUG-353 = C-8 Opus review leftovers (unconnected-end record 18.10 MED, label grade after schedule edit, ARRAY erase wording); BUG-352 = S-7 finalizer leftovers (raft beams in cm/inch mm-evidence MED, LOWs); BUG-351 = C-8 builder leftovers + two questions for Tim; BUG-350 = headless probe findings on installed 3.0.22 (HIGH pit rename, batch Apply refused, modal box, ARRAY); BUG-349 = installed 1.0.90 Opus review findings (OPEN/NEW counter, FSTEXPORT note, CSLOADPATH, FEDIT five-vertex); BUG-348 = #542 Opus review leftovers (cm-drawn-in-mm detection MED, LOWs, tests append to Tim live Structural log); BUG-347 = Codex verifyC7 observations (palette click, legacy-pipe prompt, ARRAY erase line, fixtures); BUG-346 = C-7 finalizer leftovers (MED copy-label follow, LOWs); BUG-345 = C-7 builder leftovers (LOW); BUG-344 = Structural footings in non-mm drawings: convert automatically per INT-026, S-7; BUG-343 = grade lock: breakline pair halves, held grade on pipes set flat, downToUp, Repair Center cut-off buttons, damaged labels with no repair) (BUG-342 = C-6 adversarial review 2: paste into a drawing with no drainage ignored, pit move drags unowned items, associative ARRAY untested, council swap on one Enter) (BUG-341 = S-5 adversarial review: corner grip makes a kite and the record stays old, memory-only out-of-date note, CMDNAMES nested check unmeasured) (BUG-340 = C-6 adversarial review 3: batch editor confluence level, clash warnings, Simple Pipe + Design grade, double write, broken-pair halves, carry ignores typed levels/locked layers; native locked-layer code sound) (BUG-339 = batch editor Apply fails "affected schedule cell cannot be resolved from the accepted project snapshot", Codex C6-06) (BUG-338 = C-6 adversarial review 1 units: drafter-started writers in UNITS-Metres/mm-drawn drawings, reverse mix undetected, split pipe grade lock half length, metre drawings drawn at mm size) (BUG-337 = Codex C6-04: CD arrow P1 -> P2 but Edit Pipe flow P2 -> P1 with crossed levels in a metre drawing with a scaled pit, unresolved) (BUG-336 = S-5 leftovers) (BUG-335 = S-4 adversarial review 3: native footing edits never recorded, FADOPT doubles, FST delete eWasErased, retyped label reverted) (BUG-334 = S-4 adversarial review 1: HIGH footing redraw is its own Undo step, HIGH schedule out-of-date note never works on 2027, HIGH background-thread drawing work, link migration written at open) (BUG-333 = S-4 adversarial review 2: HIGH failed footing redraw forgets the old outline, settings busy-at-start Save, CSLOADPATH OK in non-mm drawings, units question every command) (BUG-332 = Structural S-4 finalizer leftovers) (BUG-331 = PR #508 builder leftovers: CD refuses pipes 1 m or shorter in a metre drawing (R-27), detention length check, long section, imported-level review, dead code) (BUG-330 = PR #507 builder leftovers: more mm-in-metre places, OOPS end-owner choice, Pipe tab mm vs m) (BUG-328 = HIGH: grade-locked pipe inverts worked out from a length 1000x too short in metre drawings; BUG-329 = #503 review leftovers) (BUG-327 left free) (BUG-323..326 = Codex VERIFYC5 findings: Edit Pipe route length 30 mm in metre drawing, batch editor refuses whole selection for one legacy pipe, OOPS pit+pipe prints no CE line, AutoCAD fatal error AcSmNav.arx during layer lock) (BUG-322 = pipe label offsets in mm after a schedule edit, redesign approvals not cloned, repeated locked-layer line) (BUG-321 = annotation offsets around scaled pits still mm) (BUG-320 = paste/settings follow-ups from PR #501, BUG-306 design is two PRs) (BUG-319 = CDDESIGN area from CDCALC wins, window should say so at typing time) (BUG-314..316 = Structural Team-lane leftovers: footing memory at close, schedule text/legend questions, settings and units follow-ups) (BUG-317/318 = scaled-pit record size and other PR #497 builder leftovers; test hygiene) (BUG-314..316 left free) (BUG-309..313 = C-5 finalizer leftovers: metre-drawing grade label, OOPS shared-key edge, palette change undone on cancel, held-back labels forgotten on close, native C++ locked-layer opens) (BUG-308 = Codex C4C fails: 80 mm end not linked in a metre drawing, 17-degree landing at centre, CDDESIGN setup not remembered, footer buttons only on Start) (BUG-307 = Glen Eira back-test 34.6% off) (BUG-305 = foreign paste prints no CDREPAIR line and labels stay behind, BUG-306 = New Pit writes CD_Settings.json) (BUG-302..304 = #482 wording, S2 default-on findings, footing follow on 2024) (BUG-300 = Structural footing OOPS and #480 redraw design) (BUG-299 = Structural settings save follow-ups) (BUG-295..298 from the C-4 sign-off: redo-window LOWs, #478 raw distances, 100 mm insertion match, CDFIXPIPEENDS half-change) (BUG-294 = four Structural tests read and rewrite Tim's real CS_Settings.json) (BUG-293 = Edit Pipe grade suggestion in metre drawings still /1000) (BUG-292 record-order level fill, BUG-291 Design grade holds the first drawn end, BUG-290 refresh-before-preview commands) (BUG-285..289 = pipe OOPS has no pipe half, CD to a locked pit one-sided, Metres drawing with mm-sized pits 1000x tighter reach, #450 dropped open-end rescan, CDFIXPIPEENDS no schedule refresh) (BUG-284 = ~15 more locked-layer write paths, BUG-283 = CDIMPORTXCIVIL unlocks ~20 layers, BUG-282 = four cover strips still 600, BUG-281 = saved downpipe radius raw 150) (BUG-280 = two copies of the redo-window rules, Civil and Structural, converge before the V3 single-plugin cutover) (BUG-279 = other Structural places compare AutoCAD Database objects by reference, which never matches in 2027; found by team lane 01 while fixing BUG-275, 1 Oct) (BUG-278 = Edit Pipe + Save can undo the CDFIXPIPEENDS repair (PR #460)) (BUG-277 = Structural bar grip-stretch live length (PR #440), BUG-276 = Structural level set before first save carries into a SAVEAS copy (PR #430)) (BUG-275 = Structural MainPalette compares Database by reference, from PR #459 builder) (BUG-274 = after U of any footing edit the footing monitor redraws the outline again outside a command, so REDO is lost and the drawing is marked changed; from the Opus review of PR #449, 1 Oct) (BUG-273 = a failed Structural job-file save shows raw code text or nothing, from the Opus review of PR #455, 1 Oct) (BUG-272 = Structural job data save fails in AutoCAD 2027 with a Newtonsoft "Method not found", Codex VERIFYS1 log, 1 Oct) (BUG-271 = remaining fixed reach literals + unitless drawings) *(BUG-270 = pipe-end and pit search reaches are fixed 100 mm values not converted for metre drawings (the relink reach in `LinkService.RepairAudit.Relink.cs` / `LinkService.Geometry.cs:1257-1260`, `LinkService.PitOutline.cs:394-405`): same family as BUG-230; BUG-269 = `-ARRAY` of 299 pipes spends 48.8 s in the clean-up (each copied pipe's band, labels and arrow redrawn one at a time, about 163 ms each: `CloneRegeneration.cs:22-60`): do it in one batch with a progress line; both from the Opus review of PR #450, 1 Oct)* (older note follows) BUG-269 *(BUG-268 = a copied pipe already saved wrong by 3.0.16 (From/To names or levels crossed after a pit COPY) is NOT repaired by PR #444 and Edit Pipe + Save re-breaks it: needs a repair command (CDSYNC/CDUPGRADE style, in a command, one Undo, a per-pipe log line, names AND keys moved together); BUG-267 = the OOPS gap for PIT labels is probably the same as the perimeter-drain PD text (#443 fixed the drain only); both from the Opus builders of PRs #443/#444, 1 Oct)* (older note follows) BUG-267 *(BUG-256..266 = Codex verification of the 30 Sep install, 1 Oct 2026 (VERIFYC1: 50 scope items PASS 24 / FAIL 14 / BLOCKED 12; VERIFYS1: 27 items PASS 9 / FAIL 17 / BLOCKED 1): 256 REDO lost after U everywhere (Civil and Structural; the BUG-192 family, the top blocker), 257 tab X Cancel then U names CLOSE, 258 OOPS loses the PD text (BUG-236 fix did not work), 259 CDDESIGN Confirm setup loses the outlet / agreed design, 260 Edit Pipe header/arrow/schedule disagree on direction, 261 false uphill warning on a two-free-end size-only save, 262 locked/skipped messages name handles not items, 263 XCLMTXT invisible review issue, 264 Structural Annotate flyouts cut off, 265 CEADMIN restart request with hotspots 0 + debug lines, 266 far pit COPY takes 5 s in a 304-pipe drawing)* (older note follows) BUG-256 *(BUG-255 = Edit Pipe's own pipe-size suggestion strip still uses a fixed 600 mm minimum cover instead of the rulebook value (council, project, office) while the new Project Review size proposals use the rulebook value: two rules for one behaviour; from the Opus builder of PR #437 fixes F3, 30 Sep)* *(BUG-254 = writing a CE record onto a pit or pipe can silently UNLOCK the item's layer, write, then lock it again: `GetOrCreateLinkDictionary` (`LinkService.Persistence.cs` ~:853-857, 923-937) does this and swallows AutoCAD errors, which conflicts with the native-protection rule (never silently unlock); found by the Opus confirm of train fix A2, 30 Sep; NOT verified by a builder yet)* (older note follows) BUG-254 *(BUG-253 = the pipe batch write protection checks exist twice: `RevalidateSizeTargets` (the pipe size writer, PR #437) and the lambda inside `ApplyPipeBatch` (CDEDIT batch): same helper calls in the same order, only the wording differs: fold them into ONE preflight (design rule 1); from the Opus review of PR #437, 30 Sep)* (older note follows) BUG-253 *(BUG-252 = a silent default pipe roughness of 0.013 remains in the grade-only pipe path (`DesignValidationService.cs` ~:162-163 via `PipeSizingSolver.cs` ~:369) and the Inspector (`InspectorPaletteService.cs` ~:3109), and the roughness word "PE" (`DesignValidationService.cs` ~:31) also matches "EXISTING PIPE" and reads it as PVC; from the Opus confirm of PR #434, 30 Sep)* (older note follows) BUG-252 *(BUG-251 = a Kingston COMMERCIAL job (once the Land use field exists) still uses the RESIDENTIAL PSD storm, pre-development C and time of concentration: K02 gives commercial figures (PSD storm 1 in 10, Tc 7 min, pre-development C the lower of existing C or 0.7); fix = `psdAriBySiteCase` / `tcMinutesBySiteCase` with the same `siteCaseByLandUse` mapping; commercial pre-development C needs the site's existing C so it stays Unknown and needs a Tim card; from the Opus review of PR #433, 30 Sep)* (older note follows) BUG-251 *(BUG-250 = with the older beam-linking ("command 8" linking) switched ON, OOPS after erasing a Structural column still does not relink its beams and prints nothing; the #428 relink sits only in the linking-off branch (`BeamLinkService.Reactors.cs` ~:357-377); the default of `LinkingEnabled` was not read; from the Opus review of PR #428, 30 Sep)* (older note follows) BUG-250 *(BUG-249 = the CDCALC Boyds intensity rows (`BoydsCalcViewModel.cs` ~:87-92: 113 mm/h at 5 min) are fixed numbers not linked to any council or return period; the office curve at 5 minutes gives 105 for 10 years and 88.8 for 5 years; found by the Opus review of PR #427, 30 Sep)* (older note follows) BUG-249 *(BUG-248 = OOPS after erasing a perimeter drain brings the drain back with its record but WITHOUT its PD text, and prints nothing; the same class as BUG-237 (columns); from the Opus review of PR #426, 30 Sep)* (older note follows) BUG-248 *(BUG-247 = two Installer.Tests for the Manager release payload already FAIL on the release line: `ManagerPublishing_RunsOnlyAfterOuterBuildAndValidatesCompleteThreeLanePackage` and `ManagerReleasePayload_HasTrackedManifestAndThreeLaneLocalAssets`; found by the Opus review of PR #425, 30 Sep)* (older note follows) BUG-247 *(BUG-246 = a Pit Schedule cell skipped because its layer is locked / in an Xref / in a reference edit is NOT recorded as out of date: the window's OUT OF DATE badge tracks source changes only; from the Opus review of PR #423, 30 Sep)* (older note follows) BUG-246 *(BUG-244 = after a grip drag / move, an IL-text edit or a relink-all the automatic re-link writes the DRAWN-order levels back, so a pipe between two same-named ends can run uphill again and the arrow is left alone; BUG-245 = a pipe from a pit to an open end still follows drawn order; both from the Opus review of PR #422, 30 Sep)* (older note follows) BUG-244 *(BUG-242 = a raingarden or pavement saved in a metre drawing by the OLD code shows a wrong tiny area (0.0006 m2, shown as "0.0 m2") in the Inspector with nothing saying it is stale; BUG-243 = surface overlay labels are a fixed 250 drawing units tall so unreadable in a metre drawing; both from the Opus review of PR #421, 30 Sep; BUG-241 is left free for the CE_AcadSettings chat)* (older note follows) BUG-241 *(BUG-240 = Tim's real 2027 profile: CE bundle folder 15 times in TRUSTEDPATHS, log folder = the plugin code folder, CE_AcadSettings chat 30 Sep)* *(BUG-239 = council rule findings and the CDAUTO proposal report print internal file paths / GitHub links as the source, from the Opus confirm of PR #420, 30 Sep)* (older note follows) BUG-239 *(BUG-238 = WONT FIX: was read from the Claude app's private registry copy, not Tim's real profile - see its entry; this header said BUG-232 while 232-237 were already used)* (older note follows) BUG-232 *(BUG-230 = other commands assume millimetres (PAVE, raingarden, site-area readers), BUG-231 = PluginInitialization.Terminate still saves at shutdown: both from the Opus reviews of #411/#412, 30 Sep)* (older note follows) BUG-230 *(BUG-224..229 = Codex sweep C1 FINAL report, 30 Sep 2026, installed Civil 3.0.15 / Manager 1.1.15 / Structural 1.0.86: 224 AutoCAD CRASHED closing a saved drawing copy (blocker); 225 Pit contextual tab Close button does nothing; 226 Civil ribbon tooltip says Civil on an Unknown drawing and offers Both; 227 CDS tooltip promises tiers and pages that are not installed; 228 Data Diagnostics tooltip promises a report, CDDIAG prints counts and "coming in v2.1 (PL-032)"; 229 CDMANAGER Draw Order list shows duplicate rows)* *(BUG-223 = CDEDIT / not-drawn-first CD with two same-named ends can still save an uphill pipe, from the #404 Opus review, 30 Sep)* (older note follows) BUG-223 *(BUG-205..222 = Codex pass 18 and sweep C1, 30 Sep 2026, on installed Civil 3.0.15 / Manager 1.1.15 / Structural 1.0.86: 205 CD level-direction choice makes an uphill pipe; 206 OSMODE ended 0; 207 drawn Pit Schedule stale after a pit edit; 208 pipe end grip refused by CE record guard; 209 CDCATCHMENT area 28 million m2; 210 COPY replacement pit unlinked; 211 erase column leaves beam silently; 212 Place schedule fails on a legacy pit; 213 older schedule cannot be re-placed; 214 CEFIND then Esc marks drawing changed; 215 RC needs two U; 216 CDFALLSUGGEST Enter rejected; 217 PD drain shows AG; 218 CSBRACINGPANEL invisible; 219 status bar says v1.1.10; 220 Structural launcher opens unasked; 221 Manager Status cards overlap; 222 Manager Civil settings scroll)* *(BUG-203 and BUG-204 are used, see below; this header said BUG-203 was next until 30 Sep 2026)* *(BUG-202 = constant lag in a Structural drawing on everything - select, hover, draw/edit, move/copy, pan/zoom - Tim suspects polylines, 29 Sep 2026)* *(BUG-195..201 = Codex exploratory run X1 on Civil 3.0.14 / Structural 1.0.85, 29 Sep 2026: XCLMTXT invents floors, Structural schedule text tiny, branch labels overlap, diameter-only CDEDIT changes grade, calculated level labelled staff-entered, CDCHECK Enter does not finish, pit placement jargon)* *(BUG-194 = selecting a plain rectangle in a Structural drawing opens the CE Pipe ribbon tab, Tim live 29 Sep 2026)* *(BUG-192 = REDO says "Nothing to redo" after U in a CE drawing; BUG-193 = typing a size in the Pit Schedule does not resize the drawn pit; both Codex pass 17, 29 Sep 2026)* *(BUG-191 = Inspector "Use plan label" takes a document lock outside a command, suspected unnamed Undo step (U1 family), found by the BUG-190 builder 28 Sep 2026)* *(BUG-190 = CE project data may not reach the DWG on Ctrl+S/close after a palette edit with no command, found by the BUG-189 re-review, 28 Sep 2026)* *(BUG-189 = AutoCAD goes through slow phases after a lot of CE interaction, native SPLINE stays fast, reported by Tim 28 Sep 2026)* *(BUG-188 = CEBLOCKS drops attribute text tags entirely and has no live placement/rotation preview, found by Tim live in AutoCAD, 28 Sep 2026)* *(BUG-186/187 = Codex pass 13 N4 carry-downstream Apply refused, N3 CD preview missing after Existing, 27 Sep 2026)* *(BUG-185 = 45-degree beam against a non-square column refused in metre drawings, train 6 review probe, 26 Sep 2026)* *(BUG-184 = suspected swapped support ends on command 1/2 beams picked right to left, train 6 review, 26 Sep 2026)* *(BUG-178..183 = Codex pass 12 faults on 3.0.5 / 1.0.76, 26 Sep 2026: carry-on Undo, downpipe rollback, contextual tab, STRUCDEBUG unknown, beam command 4, column MOVE Undo)* *(BUG-177 = CDPIPEOBJ is a visible registry command with no ribbon button, found by the release chat's builder while adding Start Here/My Role, 26 Sep 2026)* *(BUG-176 = CDRG places no grated inlet on an ordinary CD-drawn pipe, found by Codex pass 11, 25 Sep 2026)* *(BUG-175 = Edit Pipe decides rising-main destination and reverse arrow from a crude layer-name guess, found in code 24 Sep 2026)* *(BUG-174 = "[CE]" inside command-line questions is offered as a choice, 24 Sep 2026)* *(BUG-173 = Edit Pipe window should match New Pipe; BUG-172 = Civil ribbon pictures misaligned and wrong; BUG-171 = an upgraded old pipe opens as Detention instead of Stormwater; all 24 Sep 2026)* *(BUG-170 = What's New window small, hard to read and partly untrue, 24 Sep 2026)* *(BUG-169 = Structural RC revision cloud "a bit glitchy", symptoms not yet recorded, 24 Sep 2026)* *(BUG-168 = F12 keyword choices can select the wrong action, 24 Sep 2026)* *(BUG-167 = the release zip step (Compress-Archive) hangs intermittently, 23-24 Sep 2026)* *(BUG-166 = double-clicking an IL label starts TEXTEDIT and Edit Pipe never opens; diagnosed, experiment queued, 23 Sep 2026)* *(BUG-165 = Manager would treat the old 2026.0420 build number as newer than 3.0.0, 23 Sep 2026)* *(BUG-164 = AutoCAD crashed on close - CE's palette shutdown; fix installed 23 Sep 12:18, Codex saw three clean closes, awaiting Tim)* *(BUG-163 = CDWT: AutoCAD cannot continue at the callout point, first seen 16 Sep, logged 23 Sep 2026)* *(BUG-162 = stale Pipe Edit source-text check failing on master since 13 Sep, 23 Sep 2026)* *(BUG-161 = the trunk did not contain what is installed in AutoCAD, 23 Sep 2026; FIXED, PR #87 merged)* *(BUG-160 = grade-held pipe rewrites a hand-typed bottom level on the plan but not in the schedule, 23 Sep 2026)* *(BUG-159 = ordinary rectangle midpoint grips square + no hover menu, 16 Sep 2026)* *(BUG-158 = CDCALC computations sheet silently dropped from export, 16 Sep 2026)* *(2026-09-16: BUG-148 to BUG-157 were already used in REGRESSION_LOG.md by other chats - CDPARTS save/reset, PITEDIT label shift, Pipe/Pit Update truthfulness, save-return signal - so this header was stale and IDs resume above them.)* *(BUG-144 to BUG-147 = R4 batch, 15 Sep 2026)* *(BUG-139 to BUG-143 = R3 batch, 15 Sep 2026)* *(2026-09-15: BUG-127 to BUG-138 are the R2 batch F1–F12; BUG-107 to BUG-126 were used as loose references in older rows and are skipped to avoid a clash.)* *(2026-09-07: BUG-094 to BUG-097 record the CDEDIT repair and lunch verification findings.)*
>
> **BUG-082 status correction (2026-07-27):** FIXED in code. Focused tests and controlled Civil/Structural/Manager net48+net10 builds passed with zero new persistent workers. Historical orphan workers remain a separate one-time cleanup.

> **Monday test target:** 2026-05-12 — 16 items total (12 plugin, 3 LSP, 1 verify-only). See BUG-007 checklist.

> **Round 6 (2026-05-22):** 14-item corrective sweep over R5/R5b output Tim rejected — `IN PROGRESS`, awaiting AutoCAD verification.  See "Round 6 (2026-05-22)" section below.

> **Round 7 (2026-05-22):** 2-item disciplined batch — (R7.1) Breakline rebuilt as a procedural Z-polyline (no more block-rotation surprises); (R7.2) Pit dialog layout tightened.  Coded, units green on both TFMs, awaiting AutoCAD verification.  See REGRESSION_LOG.md "Round 7 (2026-05-22)" section for full detail.

> **Round 11 (2026-05-25):** 3-item Cross-plan break polish — (R11.1) non-rising-main grade calc now uses combined length for all GradeModes (was inverts-only); (R11.2) breakline-end invert stays hidden across refreshes by persisting `SecondInvertHiddenFromPlan` at draw time; (R11.3) CDEDIT respects breakline suppression on unpaired basement halves too (was paired-only).  Both TFMs compile clean, +2 new unit tests in `GradeAutoCalcTests` pass.  Awaiting AutoCAD verification.  See REGRESSION_LOG.md "Round 11 (2026-05-25)" section for full detail.

> **Round 12 (2026-05-25):** 3-item batch — (R12.1 BUG-XAML) CD command crashed at dialog load with `Cannot find resource named 'BaseWindowStyle'` — `ContinueRisingMainDialog.xaml` + `GradeMismatchDialog.xaml` switched from `StaticResource` to `DynamicResource` for theme-level brushes/styles; (R12.2 BUG-CDGR) Cross-plan break paired halves displayed wildly different grades (1 IN 21 vs 1 IN 3 for the same logical pipe) — `LinkService.UpdatePipeGradeFromInverts` now uses the REAL endpoint inverts (basement.FirstInvert + continuation.SecondInvert) and writes the shared label to BOTH halves; (R12.3 BUG-CDIL) Continuation toggle didn't pre-populate the breakline-end IL on the continuation's First Invert field — new `LinkService.TryGetBreaklinePipeBasicsAndInverts` plus a `vm.FirstInvert = basementSecondInvert` set in `TryAttachContinuationAnchor`.  Both TFMs compile clean.  +1 new unit test `BuildGradeValue_CrossPlanPair_UsesRealEndpointInverts_SharedAcrossHalves` in `GradeAutoCalcTests` (23/23 GradeAutoCalcTests pass on both TFMs).  Awaiting AutoCAD verification.  See REGRESSION_LOG.md "Round 12 (2026-05-25)" section for full detail.

## BUG-279

**Command / Area:** Structural, several readers and writers (the AutoCAD 2027 Database identity lesson, queue 3G: every read of `doc.Database`, `ObjectId.Database` or `WorkingDatabase` returns a NEW managed object, so `ReferenceEquals` on two of them never matches; Equals, == and the Document object work).

**Symptom (read in code by team lane 01 while fixing BUG-275, 1 Oct; NOT measured in AutoCAD; the 2027 behaviour is observed in probe DB-IDENTITY-01, AutoCAD 2027 core console, PR #443):** these still compare by reference. Fixed in PR #464: `MainPalette.xaml.cs` only (BUG-275). Still open, highest risk first:
0. **`FoundationService.FindDocumentForDatabase`: re-enable ONLY with guards (Opus review of #464, finding 1).** It never matches in 2027, so a footing stretched or moved with AutoCAD's own grips is not redrawn and an erased footing is not set aside. Switching it to `Equals` alone turns on an idle-time redraw with no U/UNDO/REDO/MREDO skip, no `LockDocument` and no plain failure line: U, REDO and one-U would break. Needed together: (a) the Undo/REDO skip (draft #468, BUG-274, adds it in `FoundationMonitor.QueueCandidate`); (b) `doc.LockDocument()` around the monitor's `RegenerateSystem`; (c) one plain command-line line when a monitor redraw fails ("CE could not redraw footing X after your edit: run FREGEN"); (d) Codex runs stretch, U, REDO and ERASE, U in 2027. Left as a reference compare on purpose, marked in the code and pinned by a guard test in #464.
0b. **Database-keyed `ConditionalWeakTable`s (Opus review of #464, finding 3):** `Services/DrawingDisciplineGate.cs:36` (callers `DrawingDisciplineDb.cs:52-53, :80-89, :108-111, :195`): in 2027 `CSWAKE` may not stick (it says switched on, the next check finds no entry) and the one-second cache never hits, so the PERF-DISCIPLINE-01 gate does nothing. `Services/DrawingIntelligence/ArchitecturalChangeReviewReceiptInbox.cs:24`: `TakeCurrent(database)` (`ArchitecturalChangeReviewCommandRunner.cs:151`) may never find its receipt. Key them by Document, or by `UnmanagedObject` with a close hook.
1. `Services/DrawingIntelligence/ArchitecturalOccurrenceAutoCadReader.cs:653` and `Services/Checklist/CeLegacyChecklistAutoCadReader.cs:169`: `ReferenceEquals(id.Database, _database)`: every id may read as "not this drawing", so these read-only features may find nothing in 2027.
2. `Services/ConnectedDesign/Commit/AutoCadBeamCommitEvidenceReader.cs:317, :338` (`ReferenceEquals(current, _database)`) and `AutoCadBeamExtensionAtomicWriter.cs:144` (`ReferenceEquals(_capture.Context?.Database, _database)`): safe only if both sides are the very same captured object; otherwise lintel boundary evidence and beam extension commits are refused.
3. `TransactionManager` / `TopTransaction` compared by reference (`SbeamAtomicEditWriter.cs:262-263`, `SbeamCompoundStore.cs:103-104`, the two readers above, `StructuralIntelligenceGate2ReadOnlyHarness.cs:147-148`): whether AutoCAD 2027 also hands out new TransactionManager wrappers is NOT known (Autodesk internals): measure first.
4. `CeSheetsPdfPublisher.cs:156`, `ExportService.cs:551`: "WorkingDatabase switched" is always true in 2027; probably harmless (the same drawing is put back), not proven.

**Expected behaviour:** compare the Document, or the Database with Equals; never ReferenceEquals on a Database or its wrappers.

**Test that catches it:** the source guard from PR #464 (`Bug275DatabaseIdentityGuardTests`) widened to all of Structural once these are fixed; plus a core-console probe for item 3.

**Steps to confirm (Codex, AutoCAD 2027, a copy):** for item 0, once its guards are built: stretch a footing line with AutoCAD's own grip: its outline follows; U puts both back; REDO brings the stretch back; ERASE a footing line then ONE U brings line and outline back. For item 0b: CSWAKE on a Civil drawing, then a Structural command: it stays awake. For item 2: place a lintel between two walls and extend a beam with the CE grip: both commit. For item 1: run the checklist and the architectural review on a drawing with content: they find it.

**Status:** OPEN (filed 1 Oct about 12:10 by the PC clock; an earlier stamp here read 18:40 by mistake). Updated 1 Oct 12:50 after the Opus review of #464: only the palette is fixed there; the footing lookup is item 0 above.

---

## BUG-360

**Command / Area:** UI accessibility names and jargon in Civil/Structural windows (desk UI mapping session 5, 3 Oct; `UI_MAP_2026-10-03.md`, raw files in `C:\Lisp Files\_ACAD_DRIVER\ui_map\`).

**Mapped:** Edit Pit, Edit Pipe, four Pit Schedule tabs, CE Inspector palette, CE STRUC Footings toolbar, contextual Pit/Pipe ribbon tabs. NOT mapped yet: New Pit, CDDESIGN, CESHEETS, CEPALETTE, FST, CE ribbon tab panels (next session).

**Symptom:** 30 controls have no accessible name; grid/Inspector rows are named `CE_CVL_SUITE.ViewModels.PitScheduleRow` / `CivilPropertyRow`; group headers show raw handles like `P:109601`; two Footings-toolbar buttons are named wrongly, one 'Do you want to save your changes?'. Against the plain-English UI rule (no jargon anywhere users read) and automation (Codex/driver need real names). Fix: AutomationProperties.Name on every control, plain row/group names (pit number, pipe name, not handles or class names). Sonnet job (small, Civil + Structural toolbar).

**Status:** OPEN (LOW-MED). Not fixed until Tim confirms.

---

## BUG-367

**Command / Area:** Structural train S-9 Opus finalizer (af428d0674b61956d, branch claude/rel-20261013s fb7cd0bb GO, no fixes; report `S9_OPUS_FINALIZER_2026-10-03.md`). Checked by reading: #566 layers created before any object gets them (existing LOCKED 35CONT: plain line 'Layer 35CONT is locked, so CE drew no reo bar...', nothing unlocked, no crash; one U also removes a 35CONT CE just made: wanted), #562 strip-or-pad test matches the outline builder type for type, #563 reo bars use the footing schedule's unit rule (2 ft bar reads 'x 610 LG'; mm unchanged); no merge slips; 11092 -> 11117 test lines.

**Open:** (1) **MED, already in 1.0.92, not caused by S-9:** CE silently RESETS an existing layer to its standard settings: a drafter who froze or recoloured 35CONT or 25TEXT gets it thawed and recoloured with no message; in RBL, RBC and STR a LOCKED 35CONT or 25TEXT is also UNLOCKED, which breaks the native protection rule 'never silently unlock'. About 30 places use this: too wide for the gate: for the Team build worker (one shared EnsureLayer helper that never changes an existing layer's lock/freeze/colour; a locked layer = a plain line; tests per command). (2) LOW: an inch drawing (from acad.dwt) really drawn in mm turns a 5500 bar into 'x 139700 LG' (shown in the preview line before Yes: the drafter can say No). (3) LOW: bars placed in inch/foot drawings under 1.0.92 get new wording and size at their next refresh (tool hidden: none exist yet). (4) LOW: if drawing the bar fails, the line says 'Nothing was changed' but an empty 35CONT may be left behind (one U removes it). (5) NOTE: CSREOBAR may have the same extra empty Undo step as BUG-358: driver check 5 (LINE, CSREOBAR, U, U: the second U must remove the LINE).

**Driver/Codex checks (S-9):** CSREOBAR plain chain on DRV2_S1 with NO 35CONT made first (Preview, BM1 line, 3 objects, 35CONT now exists, no units line); one U (bar and layer gone), REDO brings both; answer No (nothing, no layer); a LOCKED 35CONT (plain line, still locked; also a FROZEN 35CONT: thawed?); undo count; FEDIT on a strip near a pad (names SF1; Escape nothing; shared corner 'That is a CE outline...'); foot drawing INSUNITS 2 (a 2-unit bar 'feet, converted', 'x 610 LG'; INSUNITS 0 'not set' line; 4 no line); CSBARSCHEDULE after (BM1 5500, one U removes only the table).

**Status:** OPEN. Not fixed until Tim confirms in AutoCAD.


**UPDATE 3 Oct 10:55 PC (driver session 10 on the INSTALLED Structural 1.0.93, `DRIVER_RUN10_2026-10-03.md`; both CS_Settings.json identical before/after every chain): BUG-367 CONFIRMED in real AutoCAD.** (1) CSREOBAR thaws AND recolours a FROZEN 35CONT silently (frozen colour 7 came out thawed colour 2; one U restores frozen, colour 7). (2) Typed STR UNLOCKS a locked 25TEXT or 35CONT silently (35CONT also recoloured 7 to 2), and the U after STR removes the stirrup but leaves the layer UNLOCKED and the NEW 35CONT in place: the layer change is OUTSIDE the undo group (worse than first suspected). Fix: shared EnsureLayer for STR / RBL / RBC and CSREOBAR (never change an existing layer's lock/freeze/colour; a locked layer = plain line) AND put layer creation inside the undo (Team build worker job 46 items 16a/16b; extends #568).

**PASS on 1.0.93:** CSREOBAR plain chain with NO 35CONT: 'BM1: 3-N16-100 CTS x 5500 LG, TOP & BOTTOM.', 3 objects, 35CONT created, NO units line; one U removes bar and layer, U then REDO both back; answering No draws nothing and creates no layer; LOCKED 35CONT: plain line 'Layer 35CONT is locked, so CE drew no reo bar' and the layer STAYS locked; foot drawing INSUNITS 2: 2-foot bar 'feet, converted', 'x 610 LG'; CSBARSCHEDULE after a bar: BM1|N16|STRAIGHT|5500|6*|52.1*, one U removes only the table.

---

## BUG-371

**Command / Area:** Civil/Manager train C-10 Opus finalizer (a86db87183cf640b8, branch claude/rel-20261014b 55a5da59 GO; headless probes on a copy of FIX_MODERN_PIPE.dwg; report `C10_OPUS_FINALIZER_2026-10-03.md`). None HIGH.

**Fixed by the finalizer (BUG-364 wording):** with the pipe layer locked the first pit MOVE after opening a drawing printed 'the pipes pipe 11C807 and pipe 11C83E': when CE has no pipe name yet it fell back to the drawing handle: now the line counts those pipes ('the 2 pipes' / 'P8 -> P11 and 1 more'); when names are known the line is unchanged; tests + REGRESSION_LOG.

**Measured (copy):** CHPROP a pipe to another layer: label stays 1 IN 100 (3.0.24 changed it to 1 IN 101); old pit copy MOVEd alone: the original pit's pipe labels stay 1 IN 100 (pipe layer locked or unlocked), one U; STRETCH the pipe's far end: label changes to 1 IN 101, one U restores pipe, label and both invert texts, the same STRETCH again re-words again (the U/fingerprint fix works); pit moved alone and pit+pipe moved together re-word as in 3.0.24; pipe layer locked + pit MOVE: one [CE] line, both labels stay, one U.

**Open:** (1) LOW (test only, the AutoCAD 2022-2024 build): one #560/#565 names test fails (the CDDESIGN check that the source-register boxes are named): a screen reader or the driver's ui scan in AutoCAD 2024 may not see those 18 boxes by name; the assembler/builder never ran these tests on the 2024 build. (2) LOW-MED: BUG-364's cause is not settled: on the first command after opening, CE could not find those pipes in its records although they are there: only the wording was fixed: driver check that the Pit Schedule is right after that first MOVE. (3) NOTE (headless only, same on 3.0.23): a STRETCH run from inside ONE LISP line is not undone by U (a typed STRETCH undoes fine): one check in real AutoCAD settles it. (4) NOTE: a pipe CE itself snapped to a pit re-words once on its next CHPROP (old behaviour, safe).

**Driver checks (9 in the report):** CHPROP 11C807 to ZOTHER (label stays, one U); old pit copy MOVE 0,-500 (original's labels stay); ZOOM W -200,-80600 1200,-79400 then STRETCH C 300,-80100 600,-79900 Enter 0,0 0,300 (label becomes 1 IN 101, one U restores all, again re-words); the same STRETCH inside one LISP line then U; pit P11 moved alone / pit+pipe together (as 3.0.24); grip-drag a pipe end onto another pit (label re-words); fresh open + lock STORMWATER PIPE + MOVE P11 0,500 as the FIRST command (names 'P8 -> P11 and P11 -> P12' or 'the 2 pipes', never 11C807; then the Pit Schedule shows P11 right); CDDESIGN grey Confirm LPD hover reason on Setup / Areas and route / Results / During (ui read); names ui scan (Pit Schedule, Edit Pit, Inspector, New Pit, five CDDESIGN tabs: 0 jargon 0 unnamed; During reads 'During'; CDREPAIR 17 ids: press only Close; in AutoCAD 2024 also scan CDDESIGN Start).

**Status:** OPEN (LOW). Not fixed until Tim confirms in AutoCAD.


**UPDATE 3 Oct 14:40 PC (driver sessions 12 and 13 on the INSTALLED Civil 3.0.25, `DRIVER_RUN12/13_2026-10-03.md`): ALL PASS.** CHPROP of pipe 11C807 to a new layer: label stays '225 DIA. UPVC PIPE AT 1 IN 100', other label and all 4 invert texts unchanged, no CE line, ONE U restores; first move after a fresh start with the pipe layer locked prints the P names (no raw handle) = BUG-364 FIXED; typed STRETCH (two line breaks after the crossing corners): label 1 IN 100 to 1 IN 101, ONE U restores pipe, label and both invert texts exactly, the same STRETCH again re-words again; **item (3) of the finalizer notes (a STRETCH inside ONE LISP line is not undone by U) was a CONSOLE ARTEFACT: in REAL AutoCAD one U brings it back (echo '(Lisp Expression) GROUP'): closed**; P11 moved alone and P11 + pipe 11C807 together: both labels 1 IN 101, one U restores each; CDDESIGN opens with no question first, During tab reads 'During', the grey Confirm LPD exposes its reason on all five tabs ('The existing LPD record needs review before Design can change it.': read-only help text, not a real hover); ui scan on Pit Schedule, Edit Pit, CE Inspector, New Pit, five CDDESIGN tabs and Repair Center: 0 jargon, 0 unnamed, 17 Repair Center button ids; the only flag: 8 'error codes' on the Pit Schedule Source tab = job numbers in drawing names. Old pit copy MOVE (OLDCOPY_C10.dwg, handles in C:\ce_rc_drv\OLDCOPY_C10_note.txt): session 14.

---

## BUG-394

**Command / Area:** CSREOBAR questions "Number of bars <8> <8>" and "Spacing (mm) <200> <200>" still print the default TWICE (desk driver run 26, 4 Oct ~10:40; `DRIVER_RUN26_2026-10-04.md`, installed Structural 1.0.100; BUG-388 / BUG-391 family: the keyword/default is printed by CE and again by AutoCAD). LOW wording. To Team build/02 (run 65 has it). **Driver run 26 (the last driver AGENT session for these lists; wedged early by the agent's own Enter-repeat test that left SFC at "Enter SF number:"; a quit -Kill test kill, one unclean-exit entry about 10:07 expected): 4 PASS, 0 FAIL, 3 BLOCKED, 15 NOT TESTED.** PASS roof-down: wind class (lists/defaults once, saved Hill top / Escarpment or ridge, Enter keeps saved), BEXTEND (list once, "at its end/start", plain refusal), CSREOBAR bar size / face lists once, SFC (MLINE on STRIP FOOTINGS scale 300, CLAYER back to 0). Not run: every footing-units case and all of C-16 (moved to Codex W8). **Status:** OPEN.

---

## BUG-417

**Command / Area:** NATIVE-PROTECTION BYPASS (HIGH), source audit 7 Oct (04_REFERENCE/release/SOURCE_AUDIT_2026-10-07.md, finding checked by me in the code): **CDIMPORTXCIVIL (X-Civil import, on the Civil ribbon) UNLOCKS locked layers**: `XcivilImportService.cs:1474-1501` `TemporarilyUnlockImportTargetLayers` sets `IsLocked = false` on about 13 named layers plus every pipe layer, writes, then relocks; `XcivilImportReportService.cs:602` erases earlier imported pits, pipes and labels. Only a debug line records the unlock. Breaks the rule 'never silently unlock'. **Fix needs a reviewed workflow (card): skip locked objects and say so, or ask once with a visible preview and explicit approval.** **Status:** OPEN (HIGH; Team; needs Tim's ruling on the import: ask/skip).

## BUG-418

**Command / Area:** NATIVE-PROTECTION BYPASS (HIGH), source audit 7 Oct: **strip footing commands re-layer objects across the WHOLE drawing**: `CeTextService.cs:4301-4380`, run when SF, BSF or STRIPLAYERSMERGE starts, moves objects in EVERY block definition and erases old layers; failures are swallowed, so locked objects are skipped without telling the drafter. **Fix:** touch only the objects the command made, skip locked layers/Xrefs and say so. **Status:** RULED 7 Oct (INT-065, Tim: "some things are worth running in the background a layer tify up is one of those things if done properly"): the tidy-up STAYS in SF/BSF/STRIPLAYERSMERGE and runs quietly IF done properly: never touches locked-layer objects, Xref content or anything while REFEDIT is open; erases an old layer only when empty, unlocked and unused; speaks only when it skips (one plain line each); never swallows a failure. Draft #764 (build/02) does that: Opus review next, then S-22. BUG-417 (X-Civil import) is NOT decided by this: #765 stays DRAFT.

## BUG-419

**Command / Area:** Settings-first and Unknown-as-zero findings of the 7 Oct source audit (MEDIUM, file:line in SOURCE_AUDIT_2026-10-07.md): (1) built-in velocity, cover, grade and time-of-concentration numbers behind the Edit Pipe strip and Civil Design (`MaterialVelocityLimits.cs`, `PipeSizingModels.cs:55-122`, `RationalFlowService.cs:57-60`: a rulebook with no cover quietly gets 600 mm; Project Review reads Settings, so two screens can disagree on one pipe); (2) Unknown ground level, cover level or council minimum orifice becomes 0 (`PipeFlowSizingAdvisorService.cs:176-177`, `NetworkDesignService.cs:517-518`, `DetentionSystemViewModel.cs:966,997`); (3) council and pump rules written into the code (Bayside 1-in-20, Manningham/Kingston/Casey reuse credits, Casey orifice formula, `PumpSizingService.cs`, `ReuseCreditService.cs`); (4) Structural's central error handlers print the raw error for every Structural command (`CeStrucCommandBase.cs:136`, `BaseStructuralCommand.cs:35`, `CommandSafetyService.cs:64`); the 2700 mm brace clamp is next in line. 49 findings in all: 2 HIGH (BUG-417/418), 28 MEDIUM, 19 LOW. **Status:** OPEN (Team triage; several are R-00 items that need Tim's numbers: Settings rows, not new constants).

---

## BUG-420

**Command / Area:** Pit Schedule window, bare pit number over an existing one (Codex W14-02, 7 Oct 22:20, installed Civil 3.0.33 with #723): `PITSCHEDULE` Rows, P1 selected, typed bare `2` (P2 exists), Enter: **the cell and the 'Selected pit' box showed `2`, the group header stayed P1, P2 stayed, and NO line appeared**: the C-19 finalizer expected '[CE] Pit number 2 is the same pit number as P2 (another pit), so this pit keeps P1...' and the row kept P1. Typing `p1` over P1 showed lower-case `p1` in the cell (expected: stays P1). Typing 77 did not change the cell at all in one attempt. **Possible causes:** the window's cell edit commits on another event than Enter (e.g. on leaving the cell or Close), or this unlinked-schedule fixture uses a path without the #723 check: needs a read of PitScheduleViewModel pit-number edit commit and a retest by Codex with Tab / click-away. **Status:** OPEN (FAIL, Team to read the code first).

## BUG-421

**Command / Area:** STRAY TEXT TYPED INTO AUTOCAD DURING CODEX PASSES (observed 4 times: 14:34 4 Oct 'Esc cancelled /plan'; 17:51 4 Oct '/' and 'plan'; 19:27 7 Oct 'and', 'follow', 'it.'; 21:28 7 Oct 'follow UCSFOLLOW', 'it.'): short words arrive at the AutoCAD command line that no tool of ours typed; the 7 Oct ones read like speech but are NOT speech: the words "and follow it" are the last words of Codex's own LAUNCHER text (verifyWnn.txt: "...then follow it EXACTLY and in full as if it were this message"), so the Codex agent's screen-control tool typed a fragment of its own instructions into AutoCAD (a mis-targeted type action), and the first two (4 Oct "/plan") may be the same kind. **Not CE, not Tim.** Harm so far: none (Esc twice cleared each), but it breaks a mouse pass. **Fix idea:** rewrite the launcher so it contains no short everyday words that AutoCAD can accept as a command or system variable (UCSFOLLOW appeared because "follow" was typed), and tell Codex to click the command line and screenshot before every type. **Status:** OPEN (Codex-tool glitch, low harm: Esc twice clears it).

---
- **Update 8 Oct 02:06 (W17):** a fifth episode, AFTER the launchers were reworded to "carry out every step of that file exactly". While Codex typed `(setvar "SAVETIME" 0)` the command line showed untyped text `follow UCSFOLLOW`, `Enter new value for UCSFOLLOW <0>:` and `it.`: the same word "follow" and "it." again, so the fragment probably comes from the brief text itself (the brief says "follow ..." in its rules), not only from the launcher. Esc twice, no value submitted to UCSFOLLOW, no harm. Next step: find every sentence in the brief files that contains the word "follow" and reword it ("carry out", "keep to").


## BUG-422

**Command / Area:** Civil Edit Pipe strip / pipe sizing (Settings rows plan, 8 Oct, `PipeSizingSolver.cs:365`): the solver treats a ground level of 0 or less as 'cover not assessed' and SKIPS the cover check, so an UNKNOWN ground level (stored/read as RL 0) lets the Edit Pipe strip say a pipe size 'works' with no cover check (a real ground level of exactly RL 0 is treated as unknown too). Related: unset cover treated as 600 mm, missing cover treated as 0 (cluster CL2 in SETTINGS_ROWS_PLAN_2026-10-08.md). **Fix:** Unknown stays Unknown and the strip says 'cover not checked' in plain words; keys for cover already exist. Also note from the plan: new Settings keys must NOT change the fingerprint of an unchanged job (the CDRULES 'Stale' marker fingerprints the whole DesignStandards object). **Status:** OPEN (MEDIUM, wrong 'works' answer; Team cluster CL2).

---

## BUG-423

**Command / Area:** Opus finalizer of C-20 (8 Oct, TRAIN_C20_FINALIZER_REPORT.md), none block the install: **MEDIUM (release note, #722):** CDFIXFLATPIPES is NOT unchanged: with the new default 'no limit', a flattened pipe held at 1 in 5 is now offered with a 'steep ... check it' line where 3.0.33 said 'Check by hand' (the desk's reading of Tim's steep-pipe ruling, which was about the levels proposal): Tim should see it once. **MEDIUM (question for Tim, #745):** real names remain in three places: (1) old report files carrying the real login/computer name are KEPT (the log blames 'a Tim rule: never delete existing files' that the finalizer could not find; Structural deletes its own old real-named file: two rules for one thing); (2) the Manager report still has the real login and PC name INSIDE it; (3) support-bundle FILE NAMES still carry the real PC name. **LOW:** #740's window has no Undo button (its Undo fix is only reachable by one U after closing the window: takes back the whole Pit Schedule visit); the screen reader hears 'Last action' instead of the sentence; the steep and downpipe values are not on the Settings window yet messages tell users to look there; Edit Pit's refusal says 'press Update' but the button reads 'Save'; BUG-415 is NOT fixed by C-20 though the bug file says it would be; Civil and Manager must be installed together. **Status:** OPEN (Tim: release note + the three real-name places).

---

## BUG-424

**Command / Area:** S-21 Opus finalizer findings (8 Oct, TRAIN_S21_FINALIZER_REPORT.md; none blocks the install): (1) BTX with nothing picked: pressing Enter right away probably returns the same answer as an empty window, so it prints 'There is no TEXT or MTEXT in that window.' (the line quoted by earlier checklists says 'in that selection' and is effectively unreachable); it prints after Enter, following AutoCAD's '0 found'; (2) #759: the two footing-resize lines round differently (an inch-drawing 24-inch pad reads '609.6 x 609.6 mm' then '610 x 610 mm'); (3) STS1 on a support block on a locked layer prints raw '[CE_STRUC_SUITE] TS1 switch failed: eOnLockedLayer' (older than the train; nothing is unlocked or changed); (4) BT1: if the BRACING block fails to load the reason only shows with bracing debug on and goes nowhere in the CE log; (5) a login glued to letters/digits ('TimothyBrand2.dwg') is not hidden (Civil uses the same rule); (6) Tim's current Structural machine report says version '1.0.1.0' although 1.0.103 is installed (older, not investigated); (7) the real AutoCAD report folder is %APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox\machines ('admin-telemetry' is only a test-run folder): Codex briefs corrected. Civil's machine report on Tim's PC is still named with his real login and PC name until #745 (C-20) is installed. **Status:** OPEN (LOW; Team).

---

## BUG-425

**Command / Area:** SECOND SOURCE AUDIT of Structural + Manager (8 Oct, `04_REFERENCE/release/SOURCE_AUDIT_2_2026-10-08.md`, Opus, read-only, code at Structural 1.0.104 and Manager 1.1.34): 25 findings, 2 HIGH, 12 MEDIUM, 11 LOW, none a proven crash. Both HIGH are in Manager's office update channel (the pilot does not use that channel yet: colleagues get installs by script). **S2-001 HIGH:** Roll Back Release changes the approval record only; Manager only accepts a NEWER build, so no PC goes back and its status dot turns green ('CE is current'). **S2-002 HIGH:** the update channel can update Civil but never Manager (Manager leaves itself out of the plugin list), so approving a new Civil would split the Civil/Manager pair that must move together. MEDIUM: S2-003/004 Manager re-checks signatures and re-fingerprints whole plugin folders every 60 s in the background and on AutoCAD's own thread when CEMANAGER opens (may be part of Tim's lag, BUG-202/BUG-404 family); S2-006 approvals and the administrator list are written straight over the old file (a half-written file hides later approvals or stops CEMANAGER opening for everyone); S2-007 the 'Starts with AutoCAD' switch rewrites the installed plugin's own setup file in place; S2-008 CESUPPORT zips the whole CE_CADTOOLS folder (logs carry drawing paths = client addresses) and uploads it by itself; S2-009 Manager's failure/usage/diagnostic reports carry real logins, computer names and raw errors (goes further than the known machine-report item, BUG-405/413); S2-010 sheet sync saves over a closed drawing and only checks locks on this PC (a colleague's open drawing gets a OneDrive conflict copy or lost work); S2-011 the sheet list file has no safe write (a damaged copy reads as 'no sheet list' and the rescan loses typed titles/revisions); S2-012 after editing then MOVE of a single-line text, Structural quietly fixes its position outside any command, so the first U undoes only that fix (BUG-256 family); S2-013 CLEAN and FASTSAVE still add an extra empty Undo step (BUG-368 pattern); S2-015 a footing or raft beam with no known width is drawn 300 mm wide and a screw pile with no size 150 mm (Settings-first rule R-00). Not audited: the installer that installs an update, ~40 Structural files that write without their own lock check, native C++. Needs Codex tests on a COPY before anyone relies on the symptom: S2-006, S2-012, S2-013, S2-022.

**Tim decisions needed (via desk):** (1) S2-001 what Roll Back Release must do (auditor recommends: PCs go back at the next AutoCAD start, with an 'are you sure'); (2) S2-002 approving Civil also approves Manager with the same stamp, warn (not block) if one goes without the other; (3) S2-008 what a support bundle may contain and whether it uploads by itself; (4) S2-009 hide logins/computer names like Civil, or show real names in the admin dashboard on purpose; (5) S2-010 skip any sheet a colleague has open and list the skipped ones; (6) S2-015 unknown footing width stays unknown and is asked for, or becomes a Settings value.

**Status:** OPEN. Filed 8 Oct 02:59 by the controller from the audit. Not fixed until Tim confirms in AutoCAD.

---

## BUG-426

**Command / Area:** C-21 Opus finalizer findings (8 Oct, TRAIN_C21_FINALIZER_REPORT.md; GO at 49034734, none blocks the install). **MEDIUM (#766):** in the Pit Schedule window type 9 in P1's pit-number cell, then type p1 (lower case of the same number): the cell goes back to **9**, but the footer says '...so it stays P1.' Tim ruled 'p1 over P1 puts P1 back' (INT-059), so the window gets this case wrong. Nothing is written: the plan, record and pipes keep P1 until the drafter chooses Stop overriding, Review or Update. Cause: `PitScheduleViewModel.Data.cs:1061-1063` puts back the LAST ACCEPTED number in this case as well as on a refusal; the fix touches how override rows are saved to the drawing record and needs its own test run (Team). **LOW (wording):** an exact duplicate reads like a riddle: 'P2 is the same pit number as P2 (another pit)' (window and placed table; Edit Pit says 'already used by another pit (P2)'); the new window footer lines start with '[CE]' which the window strips from its other footer lines; the older Edit Pipe window still has the heading 'BEFORE UPDATE' above 'choose Save'; the 'looks like C2' sentence is now written out by hand in three places (can drift). **LOW (window edge cases):** on a pit's second row (pit-number cell blank) a refused number fills the cell with P1; the window recognises its own pit differently from Edit Pit and the plan label (a stale second record of the same pit could be named 'another pit'). **LOW (test steps in REGRESSION_LOG that would mislead a tester):** #763: the command-line 'looks like' line only appears at Stop overriding, Review or Update, not on Enter; #762: double-clicking a CE pit label opens Edit Pit, so the new label sentence needs the Properties palette; #774: the step says 'PIT ... type a diameter' but the commands are PITEDIT and PIPEEDIT. **INFO:** #747: the Manager diagnostic report is still saved to the shared IT folder under the real login and computer name (BUG-425 S2-009 / BUG-413 family). **Codex coverage:** none of W10-W17 tests C-21 code; the Codex checks for AutoCAD are section 4 of the finalizer report (type 'C 2' in P5's cell beside C2; the p1 case above; Edit Pit refusal vs window refusal wording together).

**Status:** OPEN (MEDIUM). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-427

**Command / Area:** CODEX W18 observations on installed Civil 3.0.34 / Structural 1.0.104 (8 Oct 03:53, CODEX_VERIFYW18_2026-10-08.md). **(1) MEDIUM to confirm (New Pipe, flat levels):** CD from P10 to P9 with the SAME test invert 18.500 at both ends in the New Pipe window: the window warns 'Pipe is essentially flat - no measurable fall' (informational; 'the pipe has been saved'), the plan shows both inverts 18.500, BUT the pipe label still reads '100 DIA. UPVC PIPE AT 1 IN 100'. CDFIXFLATPIPES then calls it 'held at 1 in 100: now 18.500 / 18.500 (flat)' and puts it in 'to check by hand (never changed by CE)'. So a pipe typed flat keeps a held grade of 1 in 100 that its levels do not show; the label tells the drafter a fall that is not there. Question for the Team: should the label read 'FLAT' or the real grade, or should the held grade be dropped when both ends are typed the same? (A pipe typed flat is never fixable by CDFIXFLATPIPES, so the steep wording and the Yes/No question can only be tested on a pipe flattened the old way.) **(2) LOW observation (Structural, STRETCH on a footing region):** in DWG-S1_VC7.dwg a click on the 'PF1 outline' selected a REGION on layer STRIP FOOTINGS (handle 47b, 600 x 600, area 360000); the typed STRETCH ('2 found') printed no CE line; after U then REDO the footing region had a new handle (537) and bounds -300..303.2 (area 360738.7): a 3.2 mm bulge nobody asked for. May be an artefact of STRETCH on a REGION (AutoCAD cannot stretch a region), but a footing monitor redrawing the outline after U/REDO from a changed record is the BUG-274 family: check before shipping a footing-resize path. **(3) Not defects (brief faults, recorded so they are not re-reported):** U after a PITSCHEDULE visit, a TEXTSCR or a LIST undoes that visit, not the earlier edit (each CE window visit and each LIST/TEXTSCR leaves its own undo step); the #759 'now says ... mm' sentence is produced by a footing resized by a grip/stretch of its outline polyline, not by FEDIT, and has still not been seen.

**Status:** OPEN (MEDIUM to confirm). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

**Team build/04 run 36 investigation (8 Oct, read-only, nothing changed; engineering call for Tim):**
1. **Why the label says 1 IN 100.** Two causes. (a) In Custom grade mode New Pipe writes the typed grade verbatim whatever the levels are (CdCommand.Grade.cs:186) and the +/-10% mismatch question is skipped when the fall is nil (line 234), so a flat pipe gets no question. (b) In Default mode with both levels typed the same, ComputeActualGradeLabel returns the fixed text 100 when the fall is zero (CdCommand.Grade.cs:318, same call in CDEDIT PipeEditCommand.GradeText.cs:263); it is not even the Settings default grade. The label is written once, at save; relink skips a flat pipe (ScheduleLinkService.PlanLabelGradeText returns blank for no fall), so nothing ever refreshes it. The 'essentially flat' line (DesignValidationService.cs:329) only informs.
2. **Why CDFIXFLATPIPES leaves it.** By design: it only repairs the old metre-drawing fault. In a millimetre drawing it says the pipe was set flat some other way (for example both levels typed the same) and lists it 'to check by hand' (FlatPipeRepairPolicy.cs:206); it also never writes a typed bottom level. This is correct under Tim's rules (INT-059 item 23 a typed level is never moved; 23 Sep hold-grade ruling: nothing typed is silently kept or overwritten).
3. **Rules that bear on it.** Engineering rulebook: the label shows the ACHIEVED grade, exact (locked); a flat pipe has no achieved grade, so the fixed 100 breaks that rule. R-27 / Unknown stays Unknown: the label must not invent a fall. No Tim ruling yet says what a flat label reads.
4. **Option A (recommended): the label reads FLAT (no grade figure) and no grade is held when both ends are typed the same.** The typed levels stay; the drafter sees the truth on the plan; CDFIXFLATPIPES keeps leaving it alone but its reason line says plainly 'both levels were typed the same: CE leaves them'. Small change, no new question.
5. **Option B: ask at save.** 'Both levels are 18.500, so the pipe is flat. Keep it flat, or let CE work the second level from 1 in 100?' Keep flat gives the same label as A; the other writes a fall (a level CE works out, shown in the preview as Tim ruled). More faithful to a drafter who forgot the second level, but adds a question to every flat save, including deliberate flat pipes.
6. **Footing region after STRETCH then U/REDO (item 2):** noted only. Not investigated here (Structural, build/02 lane).


---

## BUG-428

**Command / Area:** S-22 Opus finalizer findings (8 Oct, TRAIN_S22_FINALIZER_REPORT.md; GO at c2df7548; no HIGH, no MEDIUM; seven LOW/NIT/NOTE items, none blocking; read the report for all seven): the BB brace command still draws a long brace WITHOUT a warning while AB warns (INT-066: both should warn); the 2700 mm brace limit is compared in DRAWING UNITS, so a metre or centimetre drawing never warns (the old cut had the same blind spot; the limit should be converted or the drawing units asked first); CSPOINTLOAD (#737) is reachable only by typing (AutoCAD autocomplete after 'CSP' offers it): hidden and OFF as approved (INT-062); #770 head shipped is 9a789418 (the head Opus run 117 marked MERGE), an old bracing block with no stored length is left as it is with one line. Release-note wording: 'a brace over 2700 mm keeps its drawn length and warns; Markup AI refuses a brace when the default length is blank (same as the brace command)'. Not run by the finalizer: net8 Structural tests, DesignCore net48/net8, Drainage, Manager, Installer tests, the multi-hour SBEAM evidence fixture. #736 was merged by the finalizer (its one allowed commit c2df7548) after proving head e4db65cb = reviewed MERGE head and keeping both Settings lines.

**Status:** OPEN (LOW). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-429

**Command / Area:** Structural 1.0.105 rewrites Tim's `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` at the FIRST start after the install (found by Codex W19, 8 Oct 04:26, reported as a settings FAIL): 24,377 -> 25,791 bytes, SHA256 DA5B5B44... -> 2FBE34BB...; the controller diffed the pre-install copy (C:\ce_rc_scratch\settings_pre_1036) against the live file (keys only): 20 keys ADDED, 0 removed, 0 changed: BraceLength.MaxLengthMm 2700 / DefaultLengthMm 2700, MarkupAI.QaEnabled false / QaSameItemDistanceMm null, CeSheets.IssueJobWidePdfEnabled / IssueDwgSnapshotEnabled / IssuePreviewEnabled all false + IssueDwgSnapshotFolderName 'DWG snapshot', RoofPointLoads.* (CarryDown, MarkerEnabled false, layer 'CE ROOF POINT LOAD', radius 150, text height 100, DrawingsShareOrigin false), MemberSchedule.* (Enabled false, groups, titles, levels Ground/First/Second). So the new version writes its new default Settings rows into the user's file when it first loads: harmless (all engines OFF, no existing value touched) but it means (1) the file hash changes on every upgrade that adds Settings rows, so every Codex hash baseline must be re-taken after an install (new Structural hash 2FBE34BB...), (2) a colleague's file changes on upgrade, (3) the write has no 'Settings saved successfully' log line (the check found none). Question for the Team: should an upgrade write only when the user changes a value (read-only defaults), so a settings file never changes by itself? Not a defect for the pilot.

**Status:** OPEN (LOW, design question). Filed 8 Oct by the controller. Tim's file was NOT restored (no word from the desk or Tim).

---

## BUG-430

**Command / Area:** CODEX W20 on installed Civil 3.0.35 / Manager 1.1.35 (8 Oct 05:20, CODEX_VERIFYW20_2026-10-08.md; usage 27 -> 28%). **(1) Double-click on a CE pit label opens AutoCAD's own 'Enhanced Attribute Editor' (block PIT LABEL, tag PIT_LABEL, value P 2: command _eattedit), NOT Edit Pit** (the C-21 finalizer expected Edit Pit; BUG-166 family: double-click on an IL label starts TEXTEDIT). A drafter who edits the label text there bypasses the Edit Pit rules; whether #762's bare-number check then catches it was NOT tested (Ctrl+1 in the brief toggled an already-open Properties palette shut: brief fault). **(2) Override tick still checked after Stop overriding:** in the Pit Schedule window, after typing 'P 2' in P1's PIT No. cell (accepted, footer '[CE] P 2 looks like P2 (another pit). Check the numbering.'), then right-click > Stop overriding (footer 'Stopped overriding this row. The values you typed stay.', cell and group heading read P 2), the row's Link/inspector later showed SOURCE OVERRIDE, STATE OK, OVERRIDE tick CHECKED, PIT No. P 2, and the tick stayed through later rejected/cancelled edits. Cause unconfirmed (it may mean 'the typed value is now the source'), but the cover case in W16 lost its mark: check whether the pit-number cell behaves differently. **(3) Real words seen (PASS, for the record, 3.0.35):** bare 2 / p2 / P2 over P1 refused with '[CE] Pit number 2 is the same pit number as P2 (another pit), so this pit keeps P1. Type a number no other pit uses.' (and the same with p2 / P2 in front: the riddle wording of BUG-426); p1 and 'P 1' give '[CE] Pit number p1 is this pit's own number in other capitals or spaces, so it stays P1.'; 'P 2' accepted with '[CE] P 2 looks like P2 (another pit). Check the numbering.' (command line shows it on the visit history); U echo PITSCHEDULE then REDO 'Everything has been redone'; Edit Pit with 2 typed: 'Pit number 2 is the same pit number as P2 (another pit), so this pit keeps P 2. Type a number no other pit uses. Nothing was changed. Your entries have been kept — correct them and press Save again.' and the button reads Save (#774). **(4) Not reached:** BUG-426 'type a free number then p1' (9 was occupied by P9: choose a free number such as 77 next time), per-step override ticks, plan-label Contents edit.

**Status:** OPEN (LOW-MED). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-431

**Command / Area:** Council rulebook workstream, Kingston (desk, design run 3, 8 Oct; `04_REFERENCE/release/KINGSTON_K02_READ_2026-10-08.md`): **LOUD FLAG:** `COUNCIL_KINGSTON_ISSUE5_2025.md` (02_COUNCIL_RULES) says 'Issue 5, 2025' and quotes AS/NZS 3500.3:2021, but the K02 document on disk is **Version 5 of September 2018 citing AS/NZS 3500.3:2015**: either the label or the 2021 quote is unverified. Tim's two Kingston rulings (Tc 7 min under 1000 m2; pre-development C = the lower of existing and 0.7) and the 1 in 10 PSD/storage storm all match K02 page 14. Do NOT take 'commercial 1 in 20, C 0.9' from K02 page 17 (the council's own asset table, not the stormwater design rule). **Team item (BUG-251, assigned by the desk, queued for build/04 after run 39):** blank council fields psdAriBySiteCase / tcMinutesBySiteCase; commercial 1 in 10, 7 min; pre-development C Unknown until typed.

**Status:** OPEN (council rulebook: verify the 2018/2025 label and the 3500.3 edition against the source before any Kingston figure is Confirmed). Filed 8 Oct by the controller.

---

## BUG-432

**Command / Area:** C-22 Opus finalizer findings (8 Oct, TRAIN_C22_FINALIZER_REPORT.md; GO at 596ba72b; no HIGH). **MEDIUM (#769, cover check; advice only, writes nothing):** a trench grate placed with CDTG with Enter at the cover-level prompt stores its cover level as 0.000 instead of blank (`SourceBlockInsertCommands.cs:226-227, 375, 734-758`); #769 now treats RL 0.000 as a real ground level, so a pipe running from that grate can say 'Insufficient upstream cover -45300mm' and offer no size (the pipe size review shows the same sentence where it said the cover level was missing). Whether Edit Pipe links that pipe end to the grate is not proven (Codex step B2 in the report). Fix (Team): a skipped cover level stores blank; existing 0.000 grates read as 'not known'. **LOW:** downpipe and grate tag labels still go onto a locked GUIDELINES layer (AutoCAD allows new objects on a locked layer; nothing unlocked; the report does not mention it); Reverse Flow (#771) with both levels blank keeps the level already stored on the pipe; built-in numbers still in code: a 600 mm cover and a 6.0 m/s default for auto-design, the marked-up change plan and network redesign when no standards are passed in, and Casey's orifice K of 21.9 (Settings-first rule); a #786 test step says to edit the pit label's text in Properties but the label is a block attribute (W20-03: double-click opens the Enhanced Attribute Editor, BUG-430); typing a pit's own number into its blank second row in the Pit Schedule now shows the number there (nothing saved). **Facts for the record:** CD_Settings.json is NOT written at first start by this train (start-up never saves); the new markup and detention groups and six survey keys appear only on the next save from the Settings window; Tim's own values equal the built-in ones so #772 changes no pipe-size answer on his PC; #786's login-hiding rule can only hide too much (e.g. this PC's computer name is ADMINISTRATOR so a drawing called 'Administrators' becomes '<code>s' in the machine report), never reveal a name; #788 deletes only this PC's own exact old CE_CVL_SUITE__<login>__<PC>.json.

**Status:** OPEN (MEDIUM, advice only). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-433

**Command / Area:** S-23 Opus finalizer findings (8 Oct, TRAIN_S23_FINALIZER_REPORT.md; GO at e3fd1420; no HIGH; the one MEDIUM (doubled '<450>' default in CSROOFSETOUT's rafter spacing question) was FIXED in the finalizer's one commit e3fd1420: the assembler's one-liner was not enough, a later line that set AutoCAD's own default had to go too). **LOW (8, none blocks):** (1) #764: each SF start reads every object inside every attached Xref only to count objects it will never touch (`CeTextService.cs:4414`): may slow SF on a very large architectural Xref (not measured); (2) #764: an old strip-footing layer that is locked or still in use gets its one line on EVERY SF run (repeats); (3) Sheets palette Sync button never shows warnings (`SheetsPanel.xaml.cs:195`): a drawing skipped because a colleague has it open (#798) shows only as a lower drawing count (CE Properties and the Sheets windows do show the skip line); (4) ENTER default brace in a metre drawing draws a 2700 m brace (`BracingCommands.cs:566`, old behaviour, now at least warns after #787); (5) colleague's login (#798) appears only in on-screen messages, traced: never reaches a log; plus three smaller items in the report. **Not in the train on purpose:** #792 newer head 543d9ac5 and #798 newer head 5d19c35f (small LOW fixes pushed after assembly, both Opus MERGE): ride S-24. **Codex list:** in the finalizer report (roof first, footings LAST).

**Status:** OPEN (LOW). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-434

**Command / Area:** CODEX W21 on installed Structural 1.0.105 (8 Oct 07:01, CODEX_VERIFYW21_2026-10-08.md; usage 29 -> 30%; PASS 1 / BLOCKED 2 by a brief fault, no product failure). **(1) MEDIUM to confirm (C1 / TS1 leave the current layer changed when cancelled):** the current layer was "0"; after C1 was started and cancelled at its rotation question the layer toolbar showed SUPPORT COLUMN, and after TS1 was started and cancelled the current layer ended as SUPPORT (the final reading was (5375 "SUPPORT" 21)); OSMODE stayed 5375. The command changes CLAYER to its own layer and Esc does not put it back (the BUG-387 / BUG-206 family: a command that is cancelled must leave CLAYER as it found it). **(2) LOW:** C1 and TS1 still print 'Duplicate definition of block _Dot ignored.' at their first placement (the same message BUG-400 removed from BT1 and PIT in 1.0.103 / 3.0.33). **(3) Real prompts for the record (installed 1.0.105):** C1: 'Specify insertion point for C1:' then AutoCAD's own ROTATE: 'Current positive angle in UCS: ANGDIR=counterclockwise ANGBASE=0' / 'Select objects: 1 found' / 'Specify base point: _non' / 'Specify rotation angle or [Copy/Reference] <0>:' (Enter = 0); TS1: 'Specify insertion point for TS1:' then the same ROTATE lines. **(4) Not reached:** the column-grip Undo/Redo case (D2 'click a CE grip on a column'): the brief did not know the rotation question; retest queued as W24 (Enter at the rotation question, keyboard only: a click on the command strip hit 'Reference').

**Status:** OPEN (MEDIUM to confirm). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-435

**Command / Area:** CODEX W24 on installed Civil 3.0.36 / Manager 1.1.36 / Structural 1.0.106 (8 Oct 07:28, CODEX_VERIFYW24_2026-10-08.md; usage 31 -> 32%; PASS 1 / BLOCKED 2 by a brief fault). **(1) MEDIUM to confirm (start-up messages in the AutoCAD command line, first time anyone read them):** opening DWG-S1_VC7_b.dwg printed 'Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL', 'Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager' and '; error: syntax error', then 'CE CVL loaded: CE CVL SUITE v3.0.36.0 [Modern]', 'Start with CD, PIT, PITSCHEDULE, or CDEDIT.', 'Use CDHELP for workflow guidance and CDREPAIR for recovery.'. The CE ribbon tabs were present and every command ran, so the menu failure may only affect the classic pull-down menus (Civil / Manager): check whether the CE CVL / CE Manager menus exist in AutoCAD 2027, whether older passes printed the same lines (W16-W23 did not report them; nobody read the start-up text), and where the 'syntax error' comes from (a LISP/menu macro in Tim's profile or in the CE menu files; BUG-402 was the StrucPlus LISP line). **(2) Real prompts for the record (Structural 1.0.106):** C1: 'Specify insertion point for C1:' > ROTATE ('Current positive angle in UCS: ANGDIR=counterclockwise ANGBASE=0' / 'Select objects: 1 found' / 'Specify base point: _non' / 'Specify rotation angle or [Copy/Reference] <0>:') > 'Pick desired support text location (auto left/right/top/bottom):'; TS1 the same; no column-type or size prompt. **(3) Confirmed again:** cancelling C1 left the current layer SUPPORT COLUMN and TS1 left SUPPORT (start '0', end SUPPORT): BUG-434 item 1 stands; 'Duplicate definition of block _Dot ignored.' still printed by C1. **(4) Not reached:** column-grip Undo/Redo (retest queued as W26: unlisted prompts answered with Enter, not cancelled).

**Status:** OPEN (MEDIUM to confirm). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-436

**Command / Area:** CODEX W25 = BUG-061 re-import check on installed Civil 3.0.36 (8 Oct 07:54, CODEX_VERIFYW25_2026-10-08.md; usage 32 -> 33%; job W26-26 copy, job number only): **the import now makes 53 pipes (April: 63) against 45 on the consultant's schedule (+8), and still makes ONE pipe from a pit to itself (P8 to P8, 600 mm)**; the BUG-059 doubling is gone (April 63 -> 53; raw pipe geometry 328 -> 122 after wall-pair consolidation), but the extra pipes and the self-pipe remain, so BUG-061 is NOT gone and NOT closed. Pre-flight lines (direct from the screen): schedule source 'DWG text (DEGRADED - no PDF/DWG block schedule found)', pit candidates found/confirmed 11 -> 8, pipes confirmed for import 53, pits to insert 8; imported: 8 CE pit blocks, 53 CE pipe polylines, 46 pipe texts, 48 invert texts, 51 tagged source blocks, 4 AGI drain lines, 119 supplemental XCivil lines, 203 spot levels, 77 fall arrows, source-tag pits registered 45; end line '[CE] Post-import QA: 15 warnings, 191 data sanity findings - see report'. Window: 'Creative Engineering | X-Civil import' (tabs Source / Pit and pipe schedule / Results and review; buttons Choose DWG..., Choose package folder..., Read source, Import to drawing, Close; pages 'Choose the source', 'Check the schedule first', 'What happened in this drawing' = 'Import complete. Some items still need checking - see the report.'); the schedule page lists P1-P8 plus two rows 'Unknown to Unknown' / '0 mm UPVC CHARGED pipe from the schedule' marked Check; P1 cover 0.50 m and depth -16.43 displayed. **Open measurement gap (the real blocker for BUG-061):** the Pit Schedule has NO pipe list (21 pit/inlet rows, no Pipes tab, no full From/To list), so Codex could not count straight same-size pipes meeting end to end without a pit, bend joins, or exact duplicates: a CE command or report that lists every pipe with From, To, size and length is needed (the import's own report file was not opened). **Undo:** the prescribed U echoed PITSCHEDULE (the visit was the last undo step), so one-U for the whole import is unproven: do it with no PITSCHEDULE visit before the U. **Also seen:** the default template contains a drawing border and notes, so label tidy-up lines such as 'no clear spot among its usual positions, left where it is (on the block Drawing Border)' appear (test artefact); AutoCAD truncated the import output in the command line ('... output truncated in command line ...').

**Update 8 Oct 08:35 (CODEX W27, CDAUDITDETAIL right after the import, W26-26 copy, Civil 3.0.36):** 57 distinct stored pipe handles against 45 on the consultant schedule (+12; the import window counted 53 pipe polylines + 4 AGI drain lines); 52 pits retained (8 CE pit blocks + 44 source-tag pits IO/OF/DP/WT); 33 'Unknown: unresolved stored pipe' lines (branch pipes between source tags, e.g. DP4 -> DP8, OF5 -> IO5, 100 and 150 mm: they join no CE pit, 'outside schedule=44'); ONE 'STORED BOTH ENDS' pipe H=10366B P8 -> P8 DIA 100, IL Unknown (the self pipe); two matching FROM/TO/DIA groups (5 handles): Unknown -> P2 DIA 150 (H=103355 and 10345E) and Unknown -> P8 DIA 100 (H=103643, 103672, 10369A): matching Unknown ends do not prove they are physical duplicates. P8 has 6 stored connections (three 100 mm pipes arriving from Unknown at IL 16.82 / 16.82 / 18.20, one leaving to Unknown 16.82). 'Stored rows retained: 52 pit(s), 57 pipe(s)' stayed the same after U x2 / REDO x2. **Undo finding (new):** U echoed 'GRAPHSCR', the next U echoed 'TEXTSCR': the native display commands TEXTSCR/GRAPHSCR (and earlier LIST) leave their own undo step in a CE session, so one U after reading output undoes nothing visible (AutoCAD does not record them in plain use; BUG-358/368 extra-undo-step pattern, now for native display commands): Team question; the whole-import single-U check needs NOTHING typed after the import (W29 does that). Next: W29 (import, immediate U/wait/REDO, then LIST of the six suspect handles for length, ends and overlap).

**Status:** OPEN. Filed 8 Oct by the controller. BUG-061 NOT closed.

---

## BUG-437

**Command / Area:** CODEX W26 on installed Civil 3.0.36 / Manager 1.1.36 / Structural 1.0.106 (8 Oct 08:08, CODEX_VERIFYW26_2026-10-08.md; usage 33 -> 34%; PASS 1 / FAIL 1 / BLOCKED 2). **(1) MEDIUM (C1 and TS1, Structural support placement):** after 'Specify insertion point for C1:' and the ROTATE question the command asks 'Pick desired support text location (auto left/right/top/bottom):' and REJECTS Enter with 'Invalid point.' (five times, then Esc leaves *Cancel* and the just-placed column DISAPPEARS): the prompt wording invites 'auto' but there is no way to take it with Enter; a drafter who presses Enter loops. Either Enter must mean auto, or the prompt must say 'Pick a point for the text, or type A for auto' (and the choice must be a keyword the prompt really accepts). Also confirmed again: a cancelled C1/TS1 leaves the CURRENT LAYER changed ('0' -> 'SUPPORT COLUMN' -> 'SUPPORT') and prints 'Duplicate definition of block _Dot ignored.' (BUG-434; #810 fixes both and is in the next train). **(2) LOW / MEDIUM to confirm (start-up lines, W26-00):** the three lines are still there, and now with their place in the AutoCAD start-up: 'Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL' / 'Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager' come BEFORE 'Opening an AutoCAD 2018 format file', then '; error: syntax error' comes before 'AutoCAD menu utilities loaded.'; so they belong to AutoCAD's start-up/profile menu loading, not to the drawing. The menu bar DOES have the CE menus (MENUBAR was already 1): 'CE CVL - Layout / Sources / Review / Edit / Settings / Import/Export / Admin' and 'CE Manager - Control'; 'CE CVL - Layout' lists 8 items (Pipe Layout (CD); Pit Layout (PIT); Edit Pit or Pipe; Spot Level; Strip Drain (CDSTRIP); Structural Root Zone (CDSRZ); Tree Protection Zone (CDTPZ); Inspector) and 'CE Manager - Control' lists 6 (Manager; Refresh; Updates; Diagnostics; Logs; Admin). So what fails is probably an OLD menu group name ('CE CVL' / 'CE Manager') still listed in Tim's profile or loaded by a stale menu entry, while the new generated menus work: harmless to drafting but noisy on every start. Team read-first investigation is queued (desk).

**Status:** OPEN (MEDIUM). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-438

**Command / Area:** CODEX W28 on installed Structural 1.0.106 (8 Oct 08:57, CODEX_VERIFYW28_2026-10-08_0837.md; usage 36 -> 37%; PASS 1 / FAIL 1 / BLOCKED 1). **(1) MEDIUM (C1, Structural column + support text):** with the support-text point typed (19600,300) C1 printed 'Text placed at the top right (CR1).' and then 'Enter a number to append to 'C' (or press Enter to exit):'; Enter at that question gave '[CR1] DefaultValue is not set.' / 'Type CESUPPORT to generate a diagnostic bundle for support.' / '[CE_STRUC_SUITE] Support text command failed: CE text command 'CR1' failed.' / '[CE] No beam found nearby, so the support is not linked. Place the beam first, or run BEAMLINKMIGRATE.' on BOTH columns; the column blocks are placed (block 'SUPPORT BLOCK NEW', layer SUPPORT COLUMN, '89 SHS') but have NO support label: 'DefaultValue is not set' is the AutoCAD error for a question that tells AutoCAD to use a default it was never given (the BUG-174 / CeQuestion.OwnDefault family: a question that shows <default> but AutoCAD has none): the Team should check the 'append a number' question of the CR1 text command (pressing Enter to exit must work). **(2) LOW/MEDIUM:** the placed support is 'Not a CE object / ownership not linked' in the Inspector until a beam is linked, so its grips are AutoCAD's own (clicking the middle grip gave 'Specify point location or [Base point/Undo/eXit]:', not 'Edit together / Edit this only / Disconnect'); the D2 'CE grip on a column' case therefore needs a column that is LINKED to a beam: the order is probably beam first or BEAMLINKMIGRATE after (the CE line says so): the desk should say the drafter's real order. **(3) Confirmed again:** C1 leaves CLAYER at SUPPORT COLUMN after the command (0 -> SUPPORT COLUMN, DBMOD 1 -> 21) and prints 'Duplicate definition of block _Dot ignored.' (BUG-434, #810 in the next train). **(4) Beam command 1 works with clicked supports:** 'Select the first support (a support block or a line), or press Enter to pick points:' > 'Select the end support (a support block or a line), or press Enter to pick a point:' > 'Enter text <bdl>:' > 'Beam preview [Accept/Cancel] <Accept>:' > 'Beam placed. One UNDO removes the complete beam.' **(5) Not reached:** the column-grip Undo/Redo case (BUG-256 Structural).

**Update 8 Oct 10:34 (CODEX W31 on installed Structural 1.0.107, second start):** the 'append a number' error is NOT about a bare Enter: typing the NUMBER 1 gives exactly the same lines ('Text placed at the top right (CR1).' / 'Enter a number to append to 'C' (or press Enter to exit): 1' / '[CR1] DefaultValue is not set.' / 'Support text command failed: CE text command 'CR1' failed.' / 'No beam found nearby, so the support is not linked...'), and a bare Enter fails the same way: so the CR1 support-text command fails at its number step whatever is answered, on this fixture, and the column gets no 'C1' label (the column block itself is placed). **#810 PASSES on 1.0.107:** C1 cancelled at the text-location question leaves CLAYER '0' (start '0'), the half-placed column disappears, no 'Duplicate definition of block _Dot ignored.'; a FINISHED C1 also leaves CLAYER '0'; U echo 'C1 GROUP', REDO echo 'GROUP C1' / 'Everything has been redone', column back. **Hidden commands on 1.0.107 print TWO sentences, not one (fine, plain English):** CSLINTELPROPOSE 'The lintel and support proposals are switched off in Settings (Lintel and support proposals), so nothing was drawn. The Settings page for it is still to be built.'; CSROOFSETOUT 'The roof area setout is switched off in Settings (Roof area setout), so nothing was drawn. The Settings page for it is still to be built.'; CSPOINTLOAD 'Roof point loads are switched off in Settings (Roof point loads), so nothing was placed. The Settings page for it is still to be built.'

**Status:** OPEN (MEDIUM). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-439

**Command / Area:** S-24 Opus finalizer findings (8 Oct, TRAIN_S24_FINALIZER_REPORT.md; GO at 37a99f27; no HIGH). **Two MEDIUMs, both FIXED in the finalizer's one commit 37a99f27:** (1) #793 FADOPT 'Width in mm <300>:' showed '<300>' twice (the assembler's one-liner was not enough, a later line that turned AutoCAD's own default back on also had to go; Enter still takes the Settings width 300 mm strip / 300 beam; screw pile 150 mm only for an older screw pile with no recorded size; Esc leaves nothing recorded); (2) #808 + #798: the Sheets palette Sync wrote each warning word for word to the CE log ('open in another AutoCAD session (jsmith)'): a colleague's Windows login went into `ce_struc_suite.log`, which the CE Support zip collects (breaks #798's own fix and INT-069 item 7); each line now goes through #798's login-hiding step; on-screen box unchanged; a new test fails on the old source. **LOW (8, none blocks):** #810: the current layer now comes back after a FINISHED C1/TS1/DS too (before, a finished C1 left SUPPORT COLUMN current) inside the command's one Undo (tell Tim); #808: the 'say this layer line once per drawing' memory is never emptied when a drawing closes (log says it resets on reopen: code does not; at worst one info line missed); #799: a start-up that adds rows AND corrects a value writes only the 'Start-up changed N ...' line; #806 (command OFF): the grey stud preview ignores the Settings stud size, a tolerance set to 0 does not switch that rule off, some drafting constants are in code (tag offsets, preview colour; none an engineering value); #793: the unlabelled-beam question says 'EB line with no label' (code wording, not plain English); #808: BracingCommands.cs lost its byte-order mark. **Tim to confirm:** the lintel two-faces tolerance 350 mm (a Settings value). **New rows 1.0.107 writes at first start, all neutral/off:** FootingWidth 300/300/150, RoofSetout.NewLayerColourIndex 200, LintelProposal.Enabled false. **Not run:** DesignCore, net8 Structural, CommandTruth, Drainage, Manager, Installer, ReleaseTests; one net10 test (shared-library public-interface check) needs git history the private copy lacked. **S-25 candidates:** #804 and #802 (add-next-to-add conflicts with #793/#806 in registry, UserSettings.cs, SettingsService.cs).

**Status:** OPEN (LOW). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-440

**Command / Area:** CODEX W29 on installed Civil 3.0.36 / Manager 1.1.36 / Structural 1.0.107 (8 Oct 10:10, CODEX_VERIFYW29_2026-10-08.md; usage 38 -> 39%; PASS 3 / FAIL 1 by the brief's settings rule). **BUG-061 (W26-26 copy) RESULT: (1) the import's single U works: U echoed CDIMPORTXCIVIL, 12 s untouched, REDO 'Everything has been redone', the drainage came back (nothing typed between the import and the U): the 'one U takes back the whole import' check PASSES. (2) The suspect pipes are NOT duplicates and NOT one run split in pieces:** the six handles match W27; the BOTH-ENDS pipe H=10366B (P8 -> P8) is a ZERO-LENGTH object: LWPOLYLINE, width 100, two vertices, start = end = (107692.423, 24198.519): a degenerate pipe the import should not create (the one real defect); the three 'Unknown -> P8' 100 mm pipes (H=103643 4.095 m, 103672 3.812 m, 10369A 3.824 m) have different starts, ends and lengths; the two 'Unknown -> P2' 150 mm pipes (H=103355 25.600 m, 10345E 19.239 m) are different long pieces; all are CE_CVL_PIPE_OBJECT on layer STORMWATER PIPE (the Unknown end is a source-tag point that is not a CE pit). So the +12 over the schedule is branch pipes to source tags plus one zero-length pipe; no evidence of a run imported as several straight pieces: **BUG-061 is, on this job, NOT reproduced (close as 'gone' only when Tim confirms; keep the zero-length pipe as a Team item: the import must skip a pipe whose two ends coincide).** **START-UP (W29-00):** the first AutoCAD start on 1.0.107 wrote Tim's Structural CS_Settings.json (26,103 -> 26,901 bytes, SHA256 48FDC295... -> C34946A4..., 09:48:32.899) and the #799 line IS in the CE log, not in the command line: `ce_struc_structured_20261008.log` 09:48:32.918 [INF] 'Settings file updated with new default rows (CS_Settings.json). No value you set was changed.' (Codex looked only in the command-line history: expected). Controller key diff against the pre-install copy: 24 keys ADDED, 0 removed, 0 changed: RoofSetout.NewLayerColourIndex 200; FootingWidth.StripWidthMm 300 / BeamWidthMm 300 / ScrewPileDiameterMm 150; LintelProposal.* (Enabled false, MinOpeningMm 600, MaxOpeningMm null, OffsetToleranceMm 150, OneOpeningFacesMm 350, AngleToleranceDeg 2, BeamEndToWallMm 150, ExistingSupportMm 300, TripleStudAtOrAboveKn null, prefixes L/DS/TS, layers LOADBEARING WALL / BEAM / LINTEL / SUPPORT DS / SUPPORT COLUMN, TextHeightMm 250, SupportSizeMm 100, NewLayerColourIndex 200). NEW BASELINE: Structural CS_Settings.json C34946A4..., 26,901 bytes. **Menus (BUG-435 update):** THREE 'Menu item failed to load' lines at AutoCAD start now: CE_CVL_SUITE_MENU:CE CVL, CE_STRUC_SUITE_MENU:CE STRUC, CE_SUITE_MANAGER_MENU:CE Manager, then '; error: syntax error', 'AutoCAD menu utilities loaded.'. **Profile contamination (tell the desk / Tim):** the File > New prompt reads 'Enter template file name or [. (for none)] <C:\Lisp Files\_TEST_COPIES_20260923\BISECT_STRUCT_ONLY\office_template_copy.dwt>:' - Tim's AutoCAD profile DEFAULT TEMPLATE points to a TEST COPY left by an earlier bisect experiment (the template has missing-xref lines at open: 'Resolve Xref ... missing file', '[CE] background not found ... suggests CDXREFREPAIR'); every Codex File > New used it. Not CE code; a profile setting that belongs to Tim's AutoCAD (QNEWTEMPLATE / Options > Files > Template Settings). Restore only with Tim's or the desk's word.

**Update 9 Oct 03:46 (CODEX W38, Civil 3.0.39, usage 54 -> 55%): BUG-440 FIX SEEN.** Re-import of the W26-26 copy (new blank drawing, Model tab, CDDISCIPLINE Civil, window: Choose DWG > Read source > Import to drawing): '[CE] Post-import QA: 22 warnings, 191 data sanity findings' (was 15 warnings on 3.0.36: 7 more warnings, not yet explained: probably the new 'was not imported' line(s)); CDAUDITDETAIL first command: **ZERO 'STORED BOTH ENDS' lines, 'Stored rows retained: 52 pit(s), 56 pipe(s)'** (was 57), no pipe with FROM=TO; P8 now has 5 stored connections (P1 > P8 600 mm; P8 > Unknown 100 mm IL 17.98; Unknown > P8 100 mm at IL 16.82, 18.00 and 18.20). Handle 10366B now denotes an 'Unknown > P8' row (handles do not prove identity across imports). **One U (echo CDIMPORTXCIVIL), 12 s untouched, REDO 'CDIMPORTXCIVIL' / 'Everything has been redone': the drainage came back.** Not seen: the new 'was not imported: both its ends were matched to the same point' report line naming source object B365D (the import report file was not read); the ~1.7 m real pipe near P8 in the consultant drawing (not looked at). Start-up: the three 'Menu item failed to load' lines and '; error: syntax error' persist; the 'What's New' window at start shows the heading 'CE Civil - Version 3.0.1' although 3.0.39 is installed (stale heading: LOW, Team).

**Status:** OPEN (zero-length pipe = Team item MEDIUM; BUG-061 closes only when Tim confirms). Filed 8 Oct by the controller.

---

## BUG-441

**Command / Area:** C-23 Opus finalizer findings (8 Oct, TRAIN_C23_FINALIZER_REPORT.md; GO at 09a0e66b = nine PRs, #805 REVERTED OUT by the finalizer's one commit; no HIGH left). **#805 (grade-check marker on the plan, switch grade.showGradeCheckMarkerOnPlan) is OUT:** after each command it erased an out-of-date CHECK marker; the U/UNDO/REDO command end never runs that erase, but the same pass also runs at the end of REGEN/REDRAW with no redo check and #805's own comment says Undo is one of the things that sets the erase off: the finalizer could not PROVE it never lands between a U and the following REDO, so per Tim's rule (REDO after U is the top priority, BUG-256) it was reverted and NO baseline line was added; the Team (build/04 run 44) rebuilds it to skip the erase/refresh while an UNDO/REDO is in flight; the exact AutoCAD test for the rebuilt #805: type a level so the marker shows, U once, wait 12 s, REDO; also REGEN or a pick between U and REDO, and the Pit Schedule window left open. **Release-note items (MEDIUM, no fix needed):** (1) Manager Roll Back (#794/#795): do NOT offer it to colleagues until one PC proves the installer accepts an older version: pressed today it changes nothing: the office record has no earlier build stored, Manager answers 'No trusted rollback target has been recorded yet.'; no approval is in 'Rolled Back', so installing Manager 1.1.37 starts no go-back on any PC; (2) Kingston (#803): every saved Kingston CDRULES run shows Stale once after the install (re-run CDRULES). **Fixed at the reviewed heads (confirmed):** #796 HIGHs, #789 HIGH (a Custom-grade flat pipe saved in Edit Pipe stays FLAT), #790 MEDIUM (speed 0 or less falls back to 1.5 / 2.0 m/s and says so), #797 (deletes only this PC's own old report by exact name, never throws). **LOW (7):** one Manager test reaches the real shared OneDrive folder for one delete (only this PC's own old report, which Manager does at start-up anyway); a comment in UserSettings.cs:1652 says 0 switches the speed check off but the code falls back to 1.5 / 2.0; #803 has no field for the existing-site C (harmless for Kingston, its permitted discharge comes from the council); four more in the report. **Facts:** #803's Kingston change in council-profiles.json matches K02 page 14 (BUG-431 K02 edition flag still open); CE_SHARED unchanged (built CE_SHARED.dll byte-identical Civil vs Manager in all three builds); new Settings keys only pipeSpeed.pitOutletRecommendedMs 1.5 and pitOutletLimitMs 2.0 (no Settings-page row yet); REGRESSION_LOG CRLF, no markers, no duplicate headings; Civil net10 16,316 of 16,336 pass, 19 skipped, 1 red (Glen Eira); Manager 635/635; CommandTruth 64/64; TestHarness 101/101. **Still out of C-23:** #791 (Team rebase onto 850967b2 running, build/03 run 58), #800 (rebase, build/04 run 44), #809, #781, #768; newer heads of #801/#803 await re-review.

**Status:** OPEN (release notes + Team items). Filed 8 Oct by the controller.

---

## BUG-442

**Command / Area:** CODEX W32 on installed Civil 3.0.37 / Manager 1.1.37 / Structural 1.0.107 (8 Oct 11:16, CODEX_VERIFYW32_2026-10-08.md; usage 41 -> 43%; PASS 2 / FAIL 1 by my expected wording). **#789 FLAT label PASSES:** New Pipe P10 -> P9 with 18.500 at both ends (test inputs): the warning 'This pipe has design warnings ... Pipe is essentially flat - no measurable fall ... Warnings are informational - the pipe has been saved.'; the label reads **'100 DIA. UPVC PIPE FLAT'** (no grade figure; 3.0.36 said '... AT 1 IN 100'); both invert texts 'IL 18.500'; **U echoed 'CD' (the pipe disappeared), 12 s untouched, REDO 'CD' / 'Everything has been redone' (pipe and FLAT label back)**; Edit Pipe (PIPEEDIT: 'Select pipe to edit:') with NOTHING changed and Save: '[CE] Warning: Pipe is essentially flat - no measurable fall' / 'Pipe updated.', label STAYS 'FLAT' (no '1 IN 100'); U echoed 'PIPEEDIT' and the label stayed FLAT. **OBSERVATION (LOW/MEDIUM): the Edit Pipe WINDOW still DISPLAYS the grade '1 in 100' while both invert boxes read 18.500** (window grade field vs the flat levels: the label is fixed, the window is not; a drafter reads 1 in 100 beside two equal inverts). **CESUPPORT (#796):** zip made on this PC in the folder 'CE Support' under the user's Desktop (OneDrive); file name CE_SUPPORT_sOkhYs-36_stPtHp_20261008_001123.zip (coded: NO real login or computer name in the name: PASS); exact output: '[CESUPPORT] Creating support bundle...' / '[CESUPPORT] Support file saved on this PC: C:\Users\<login>\...\CE Support\<zip>. It has not been sent anywhere. If support asks for it, send it yourself (email, or the job's support folder). Drawing paths inside it are cut to job numbers and your login and computer name are coded.' / 'The zip lists what it holds in WHAT_IS_IN_THIS_ZIP.txt (1 files, 0 left out).' (my brief expected the ending 'Nothing is sent anywhere.'; the real wording is 'It has not been sent anywhere.': fine). **MEDIUM to confirm: the support zip is only 856 bytes and holds ONE file (WHAT_IS_IN_THIS_ZIP.txt): no log, no report, no diagnostic: a support bundle that contains nothing useful** (logs excluded by the privacy scrub, not found, or an empty list): Team to check what CESUPPORT should put in (the CE logs with drawing paths cut to job numbers) and why the count is 1. **Also:** the printed local path contains the real Windows login (on the drafter's own screen only). Settings hashes unchanged (Structural C34946A4, 26,901 bytes). The CD transcript above the strip and the START bad-settings snapshot were not captured (recorded by Codex, not a failure).

**Status:** OPEN (MEDIUM to confirm). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.

---

## BUG-443

**Command / Area:** S-25 Opus finalizer findings (8 Oct, TRAIN_S25_FINALIZER_REPORT.md; GO at e65bf1e4; no HIGH). **MEDIUM FIXED in the finalizer's one commit e65bf1e4:** #802 CSFLOORSETOUT 'Spacing in mm <450>:' showed '<450>' twice (same pattern as the roof setout; the question now writes its default once and Enter takes the Settings value 450 joist / 1800 bearer / 450 subfloor joist; new test red-then-green). **LOW (8, none blocks), two need Tim's word:** the floor arrow asks 'Joists/Bearers/Subfloor' which is not quite roof-down order; the legend wording 'DENOTES POST UNDER' is not Tim's own words yet. **Worth a Team item:** if a drafter erases only the legend TITLE, the next CSFRAMINGLEGEND run draws a SECOND legend and leaves the old rows behind (command OFF + hidden: no drafter can hit it yet). **Proved by reading:** CSROOFSETOUT is unchanged on this build (#802's new draw routine is a plain split; the roof still passes the same layer, text height, arrow head, colour and messages as 1.0.107). **First start on a copy of Tim's real CS_Settings.json (temp folder; his file untouched):** only FramingLegend (five office rows) and FloorSetout added, Enabled false, exactly one line 'Settings file updated with new default rows (CS_Settings.json). No value you set was changed.', a second start writes nothing. Registry 369 unique commands, all nine built copies identical. Revert recipe if S-25 must ship without #802: `git revert --no-edit e65bf1e4` then `git revert --no-edit -m 1 c70619dd` (dry run clean, 368-command registry). Tests at the new head: Structural net10 4419 of 4419; net48 36 reds (same known); builds 0 errors x6; not run: DesignCore (no DesignCore file changed), net8 Structural, Drainage, Manager, Installer.

**Status:** OPEN (LOW). Filed 8 Oct by the controller.

---

## BUG-444

**Command / Area:** C-24 Opus finalizer findings (8 Oct, TRAIN_C24_FINALIZER_REPORT.md; GO at 996fd85d, NO commit, nothing HIGH or MEDIUM, nine LOWs). **THE REBUILT #805 STAYS IN: the finalizer shows no drawing write lands between a U and the following REDO, by two independent reasons:** (1) the automatic marker erase has ONE caller, the full Pit Schedule cell refresh (`ScheduleLinkService.cs:486`, erase at `:510`), which always opens a drawing transaction first: opening a transaction already loses REDO, so any path reaching the erase would already have lost REDO in the installed 3.0.37 (Codex proved no such path runs in the gap); (2) the erase asks the redo guard first (`GradeNoteMarker.cs:138`) and does nothing until the next command starts. The 'U or REDO just finished' state is SET when U, REDO, MREDO or an UNDO that really changed the drawing ends (`RedoWindowGuard.cs:192-215`) and CLEARED when the next command of ANY kind starts (Tim's 'Wait after Undo' = 0 = until the next command, so the 12 s wait is fully covered); at the end of the U/REDO command CE only reloads its memory (`LinkService.Reactors.cs:860-911`, change-watching is off while U runs, nothing queued); a REGEN between U and REDO acts only if work is waiting (after a U nothing is). The redo-safety guard test passes with NO baseline line (`EveryHookBetweenCommands_IsRedoSafe_OrReviewed`, `TheBoundariesAreHonest`; baseline byte-identical to base). **Codex test to run after the install (W33):** Pit Schedule: type 19.85 at P2, close the window, U once (level + marker go back), 12 s untouched, REDO (PASS 'Everything has been redone', level + marker back); repeat with a REGEN between U and REDO, then with a pick, then with the Pit Schedule left open; also locked marker layer, and a plot preview showing no marker. **Per PR:** #791: the orifice figure is a per-council value, blank by default; blank = CDAUTODESIGN sizes as before, no built-in 12 anywhere; the removed office row detention.orificeRequiredAboveLps (12.0) had no reader and an old CD_Settings.json that still has the key loads fine (unknown keys ignored); #809 (LOW): the Long Section, detention top-water-level screens, the CDRULES fix planner and the hover/Inspector text STILL read an old 0.000 trench grate as a real level (same as installed: not a regression); #803/#801 a test attribute and one message line. **Settings:** one new key grade.showGradeCheckMarkerOnPlan = true with NO Settings-window row (Settings-first LOW); council profile gains optional orificeRequiredAboveLps (blank); one office key removed. **Facts:** Shared/ unchanged (CE_SHARED.dll byte-identical Civil/Manager); command-registry.json and council-profiles.json unchanged; the marker never unlocks a layer, never touches anything inside an Xref, stops while a reference edit is open; every new catch writes a log line. **Tests (re-run by the finalizer):** whole solution 0 errors; Civil net10 16,389 run / 16,369 pass / 19 skipped / 1 red (Glen Eira); Manager 636/636; focused net48 144 run / 143 pass / 1 red (the known stale PitBlockPreviewControl.OnTick baseline line).

**Status:** OPEN (LOW + Codex test W33). Filed 8 Oct by the controller.

---

## BUG-445

**Command / Area:** CODEX W35 on installed Civil 3.0.38 / Manager 1.1.38 (8 Oct 13:37, CODEX_VERIFYW35_2026-10-08.md; usage 45 -> 47%): **the rebuilt #805 marker WORKS and its single U/12 s/REDO PASSES.** Route (from build/04's W35_ROUTE_BUG805.md): new pipe P10 -> P9 with 'Set my own' 1 in 100, start invert 20.000, end 19.91; Pit Schedule P9 row, IL (Inlet) 19.91, typed 19.85 + Enter = 'Override enabled for linked row.' (plan unchanged, by design); right-click > Stop overriding = 'Stopped overriding this row. The values you typed stay.', inlet 19.85 (depth -0.40), plan IL 19.85, red marker ending 'LEVELS GIVE ABOUT 1 IN 61' and the command line '[CE] Pipe P10-P9: the label grade is 1 IN 100 but its levels now give about 1 IN 61. Only the end at P9 changed; the far end was not moved. Check the grade, or set it in Edit Pipe (CDEDIT).' (the marker's layer CE GRADE CHECK and its full text were outside the zoomed view: not inspected). **(a) U / 12 s / REDO: U echo 'PITSCHEDULE' (one U took back the whole visit), 12 s untouched, REDO 'PITSCHEDULE' / 'Everything has been redone', IL 19.85 and marker back.** (b) U, 6 s, REGEN, 6 s, REDO gave 'Nothing to redo': **this is AutoCAD's own rule (REDO works only immediately after U; any typed command in between, REGEN included, ends it) and my brief's fault, NOT a CE fault** (the Team's finalizer note said REGEN must not break it: that note is wrong for a typed command; a mouse PICK is not a command and is still to be tested: W36 queued); the CE log lines for (b): 13:25:15.373 '[REDO] write after U finished, before the next command: object changed (DrawOrderTable) ... no CE code on the stack (... AutoCAD itself ...)' and 13:25:59.856 '[REDO] 1 write(s) reached the drawing between the end of U and the start of REGEN; AutoCAD discards its Redo list after a write, so Redo was not available in that gap': the one write after U is a native DrawOrderTable change with no CE code on the stack (it appears after the passing REDO too at 13:23:15.858). Cleanup U echoes were 'REGEN' then 'INTELLIZOOM' (REGEN and a mouse-wheel zoom each leave their own undo step in this session). **W35-03 readings:** CDCHECK prompt 'CE check: show all connections, problems only, or save as CSV [All/Problems/Csv] <All>:'; '[CE] CDCHECK: 217 objects, 190 connections: 185 Connected, 1 Possible, 4 Unresolved, 0 Not Connected, 0 Unknown.'; '[CE] FALL arrow direction: 5 arrow(s) point away from their nearest grated pit.' (P4 168, P3 173, P2 173, P2 172, P1 172 degrees: 'Check the fall direction or move the arrow.'); prompt 'Jump to item number (1-60) or [Ends]:'; NO 'cover level not known' line (this fixture has no old 0.000 grate); CDRULES prompt '[All/Problems/Values/Explain/pReview/Source] <Problems>:': '[CE] Previous rule results (2026-09-05 00:26) were STALE ... Re-checking now.' / 'CDRULES: 408 finding(s) across 12 rules; 29 warnings, 312 unknown, 67 pass; no council profile set (CDRULEBOOK > Council).' / 'Problems only: 341 of 408.'; orifice rules R-05, R-15..18, R-20..23 are 'not evaluated here (needs the CDCALC orifice result / pump/tank calculation / engineer-reviewed calculation)'. Settings unchanged (Structural 4AB7CC9F, 28,361 bytes). **Open for the Team (build/04):** the status 'Override enabled for linked row.' could say how to write the level ('Typed level is waiting. Right-click the row and choose Stop overriding to write it to the drawing.'); for Tim: a typed level + Enter changes nothing on the plan until Stop overriding (design question: write on Enter?).

**Update 8 Oct 14:01 (CODEX W36, Civil 3.0.38, usage 47 -> 49%): THE REBUILT #805 IS PROVEN IN AUTOCAD FOR U/WAIT/REDO AND FOR A PICK DURING THE WAIT.** (a) held-grade pipe, typed 19.85, Stop overriding: marker + IL 19.85 on the plan; ONE U (echo 'PITSCHEDULE') REMOVED THE MARKER AND RESTORED 19.91 TOGETHER (level and marker share one Undo step); 12 s untouched; REDO 'PITSCHEDULE' / 'Everything has been redone': marker and 19.85 back. (b) the same with ONE mouse pick in the wait (U, 6 s, pick on empty drawing (it starts 'Specify opposite corner or [Fence/WPolygon/CPolygon]:'), Esc twice, REDO): 'Everything has been redone', marker and 19.85 back; no autosave between U and REDO. So the two realistic cases of Tim's REDO rule pass with #805 installed; a typed command (REGEN) between U and REDO ends REDO natively. NOT yet seen: the marker's layer CE GRADE CHECK / non-plotting flag (not read), Edit Pipe Save removing the marker (the pipe pick answered 'That is not a pipe. Click the pipe line or its outline.' at (405,699): pick the pipe line itself next time), the first ten CDRULES console lines. CDRULES report file (first lines): 'CDRULES ... 408 finding(s): 28 warnings, 312 unknown, 68 pass; VALUES IN USE (council > project > office values) Council: none; R-01 scour caps: CAST 4.0 m/s, CONC 6.0, CONCRETE 6.0, DI 4.0, HDPE 3.0, PE 3.0, PVC 3.0, RCP 6.0, RRJ 6.0, STEEL 4.0, UPVC 3.0; unknown material 6 m/s (office); R-02 minimum velocity 0.6 m/s (office); R-03 minimum grade ladder DN90 1:100, DN100 1:100, DN150 1:100, DN225 1:200, DN300 1:250, DN375 1:300, DN450 1:200 ... DN750 1:200; drafting warning 200 (1:N) (office); R-04 minimum cover 300 mm (office)'; 'R-05/R-18 orifice: Co not set in the rulebook, council minimum not set in the rulebook'. Settings unchanged.

**Status:** OPEN (#805 REDO proven in AutoCAD; marker layer, Edit Pipe removal still unseen). Filed 8 Oct by the controller.

---

## BUG-446

**Command / Area:** CODEX W37 on installed Civil 3.0.38 / Manager 1.1.38 (9 Oct 02:16, CODEX_VERIFYW37_2026-10-09.md; usage 51 -> 53%; PASS 3 / FAIL 1). **Marker facts SEEN (PASS):** after Stop overriding the red marker is an MTEXT on layer **CE GRADE CHECK**, colour 1 (red), contents 'CHECK: LABEL GRADE 1 IN 100, LEVELS GIVE ABOUT 1 IN 61'; the Layer Properties Manager shows the printer crossed out (**non-plotting**), padlock open (unlocked), sun (thawed); same route and wording as W35/W36. **FAIL (MEDIUM, Team): a STALE red marker stays after the level is fixed in Edit Pipe:** PIPEEDIT (click the pipe LINE beside P9: opens Edit Pipe, Flow P10 -> P9), downstream invert 19.85 -> 19.91, Save; an extra window 'CE - Recalculate downstream inverts? / The downstream invert on pipe 11C55A changed from 19.85 to 19.91. / Recalculate downstream pipe inverts at each pipe's current grade? / You will see a preview of every affected pipe before anything is applied.' [Yes/No] (Enter = Yes); '[CDEDIT-CASCADE] No downstream pipes from this pipe - nothing to cascade.' / 'Pipe updated.'; the plan IL becomes 19.91 and the pipe label changes from '... AT 1 IN 100' to **'100 DIA. UPVC PIPE AT 1 IN 102'** (Edit Pipe re-works the label from the new levels), BUT the red marker STILL reads 'LEVELS GIVE ABOUT 1 IN 61' (no longer true; the pipe now falls 1 in 102). The #805 PR text says the stale marker is removed 'when the pipe's levels changed (next Pit Schedule refresh)': so it goes only at the next Pit Schedule refresh (not tried: open the Pit Schedule after the Edit Pipe Save and see if it goes), and build/04's route file said Edit Pipe 'only removes' it; the drafter sees a warning that is no longer true until the Pit Schedule is opened. Team: remove or refresh the marker when Edit Pipe Save changes the pipe's levels (inside the same command so one U takes both). **REDO with Edit Pipe: PASS:** U echo 'PIPEEDIT', 12 s untouched, REDO 'PIPEEDIT' / 'Everything has been redone' (level back to 19.91); final U 'PIPEEDIT' (level 19.85, label 1 IN 100); the marker never moved. **Other readings:** start-up CE line on opening DWG-B1: '[CE] 49 pipe(s) upgraded to CE pipe objects, 49 given their CE identity. (a PRE_C7 backup already exists beside the drawing.)'; Civil log: the privacy-filtered 'Settings saved successfully' line count fell 351 (W29-W30) -> 307 (W31-W36) -> 228 (W37): 79 historical lines are absent from the current Civil log (cause unknown: log trimming/rotation, or a test run touching Tim's real log: check; the memory note says a test once truncated his live Structural log) - no CE setting was written.

**Status:** OPEN (MEDIUM). Filed 9 Oct by the controller.

---

## BUG-447

**Command / Area:** C-25 Opus finalizer findings (9 Oct, TRAIN_C25_FINALIZER_REPORT.md; GO at 446162c2 = a1b14032 + the finalizer's wording commit; nothing HIGH, one MEDIUM FIXED, eight LOWs). **The P8 -> P8 pipe of the W26-26 job (BUG-440) is a REAL pipe:** Codex's own import log shows it comes from a 1.68 m, 100 mm pipe in the consultant drawing (source object B365D on layer CI-STRM-DRAN-INVT-N, two different invert levels 18.00 and 17.98), but the import PULLED BOTH ENDS onto the same spot on P8's wall so it came out as a zero-length dot. #814 rightly stops drawing the dot; the MEDIUM was its report line ('its two ends are at the same point, so it has no length' reads as 'the consultant drew rubbish here' and a drafter would ignore it and lose a real branch). **FIXED by the finalizer (commit 446162c2, wording only):** the line now says '... was not imported: both its ends were matched to the same point, so CE could not draw it. The consultant drawing may show a short real pipe here: check it, and draw it with CD if it is needed.' **What #814 can skip:** never a pipe between two different pits or tags; it can drop a short straight branch (under about 3.2 m) whose far end is not near any pit or tag, because both ends get pulled onto one pit (before this train that branch came out as a useless dot). The real cure is to fix the END-MATCHING step (it needs its own reviewed change: Team item). **#820:** old trench grates stored as cover 0.000 now read 'not known' in the CDRULES fix planner, the detention top-water-level checks and the Inspector ('-' / 'Missing cover level'); STILL RL 0.000: the Long Section and the hover tooltip over a pit (no worse than installed). **Codex check after the install:** re-import the W26-26 copy, CDAUDITDETAIL: expect no BOTH ENDS pipe and 56 or fewer pipes (52 likely); look for the new line naming source object B365D; look at the consultant drawing near P8 (about 107,800, 24,350) for a ~1.7 m pipe running into P8; U once = the whole import back, 12 s, REDO = all back. **Process note:** one 6-test check ran after a single AutoCAD-closed check instead of three (nothing affected).

**Status:** OPEN (end-matching cure = Team item). Filed 9 Oct by the controller.

---

## BUG-448

**Command / Area:** S-26 Opus finalizer findings (9 Oct, TRAIN_S26_FINALIZER_REPORT.md): **the train as assembled (35f4e152) was NO-GO: PR #815 misread the cause of BUG-438 and would NOT have fixed the column label; the finalizer's commit 1fd75ab6 makes it GO.** What the finalizer OBSERVED IN THE LIBRARY (read from AutoCAD 2027's own `accoremgd.dll`: a HYPOTHESIS about AutoCAD internals, not documented fact; CODEX W39 is the proof): switching a question's default off never fails; READING the default when none is stored fails with 'DefaultValue is not set.'; the 8 Oct errors in Tim's Structural command log come from reading the default in the text step's own debug line after the drafter had answered. #815 made the shared helper READ the default to test it (so the first C1 of a session would have shown the error before 'Enter a number to append to 'C'' even appeared). **Fix 1fd75ab6:** the helper is back to its original one line and the debug line no longer reads the default (#815 had also changed the beam text questions e.g. 'Enter BEAM text' with nothing remembered: now exactly as 1.0.108). **MEDIUM fixed:** a label could land BESIDE THE PREVIOUS COLUMN (Enter at 'Enter a number' on one column; on the next C1 press Enter at the text-location question (#812 auto right): the new label went to the old column's spot and was recorded as the new column's label): that one-shot 'put the next label here' is now cleared after every support text run. 5 new tests failed on the train and pass with the fix; Structural net10 4436 of 4436; net48 the same 36 old reds; builds 0 errors x6; command list 369, no new Settings. **Not proven (headless AutoCAD cannot start an isolated profile on this PC: "Can't find 'TempDirectory' registry value"):** how C1 and the beam questions look on screen: CODEX W39 checks. **Open (none blocking):** Esc at 'Enter a number' keeps the column and prints 'Support text command failed: Command cancelled.' (unchanged from 1.0.108; the code's intent suggests Esc should remove the column: NEEDS TIM'S WORD); 'Text placed at the right (CR1).' is printed before anything is placed; Enter to exit the number question ends with no sentence; two minor items in the switched-off framing legend. The two newer PR heads held back for S-27 (#812 b7aaa225, #818 f89af2ca) merge onto 1fd75ab6 with only the usual REGRESSION_LOG conflict.

**Status:** W39 (9 Oct 04:13) SEEN IN AUTOCAD on 1.0.109: C1 with a typed point and number 1 draws the column and the C1 label, no "DefaultValue is not set", no _Dot line; TS1 with number 2 draws TS2; Esc at the text prompt removes the half-placed column; one U / REDO takes the column and label together. Awaiting Tim's confirmation. Esc at the number question still needs Tim. Updated 9 Oct by the controller.

---

























## BUG-414

**Command / Area:** Civil, Opus finalizer of C-19 (7 Oct, report TRAIN_C19_FINALIZER_REPORT.md), **OLDER THAN 3.0.32**: **Edit Pit has no pit-number clash check**: renaming pit P5 to P8 while a P8 exists can DELETE the other P8's record (`ProjectDataService.Mutations.cs:374-380`, `PitEditCommand.cs:1724`; read in the code, not run in AutoCAD). The drawing keeps two pits labelled P8 and one record. **Fix (Team build/03 run 40):** Edit Pit refuses a rename onto an existing number with a plain sentence naming the other pit (like New Pit #734), test red first; joins C-20. **Status:** OPEN (MEDIUM).

## BUG-415

**Command / Area:** Civil pit-number wording gaps (C-19 finalizer, LOW, none block C-19): (1) double-clicking a plan label and typing a bare '8' or '12' is refused with a general sentence that does not name P8 (the label keeps showing what was typed and a later MOVE of that label renames the pit to '12' with no message: reported, not yet reproduced); (2) the Pit Schedule window accepts 'C 2' beside C2 WITHOUT the warning Tim ruled (INT-059 item 18). Fix with BUG-414 (build/03 run 40, C-20). **Status:** OPEN (LOW).

## BUG-416

**Command / Area:** Civil, small items from the C-19 finalizer (LOW): (1) right-click 'Select this run' straight after U, in a drawing whose CE record is not loaded yet, may lose REDO (rare; not reproduced); (2) the #731 test step in REGRESSION_LOG names 'CDSETTINGS' which does not exist: the Settings window command is CDS (controller fixes it in the C-19 Codex checklist); (3) the #705 test step is superseded by #731; (4) #667 open AutoCAD-only question: the save for drawing A runs while drawing B's command starts with no document lock on A (a lock clash is caught and retried at idle): Codex two-drawing test (edit a pit label in A, then at once in B) in block W14. **Status:** OPEN (LOW; W14).

---

## BUG-413

**Command / Area:** W11c (Structural 1.0.102 installed, Codex 5 Oct 18:59) results: PASS 1 (FEDIT: editing PF1, 'Pad footing', five questions each once, PF1 unchanged, LIST confirms 600 x 600), FAIL 2, BLOCKED 4; most 'FAIL/BLOCKED' are brief mismatches (not defects): **the beam commands are named `1`, `2`, `4`, `5` (and BDL), there is NO command called BEAM** (BeamPlacementCommands.cs: [CommandMethod("1")]...; 'BEAM' is only a label); BTX after selecting text asks 'Choose suffix [NONE/CANT/CONT/BOTH/LOWER/PORTAL/PF/OTHER] <NONE>:'; CSREOBAR asks bar size <N12> (last used), number <8>, then 'Spacing (mm) <200>:'; FPFC duplicate label Increment gives the next FREE number (PF5), not PF10; FSF 'Enter depth <0 to skip>:' has no trailing <0>. **REAL ITEMS:** (1) **Civil's machine-report file name contains the real Windows login and computer name** (`CE_CVL_SUITE__<login>__<computer>.json` in %APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox\machines) while Structural's is hashed (`CE_STRUC_SUITE__<16>__<16>.json`: #662 works): this CONFIRMS BUG-405 (2) in the field; check whether the outbox is synced to the office IT folder. (2) BT1 prints `Duplicate definition of block _Dot ignored.` (Structural bracing loader). (3) BTX with a window that finds 0 TEXT exits silently (no 'There is no TEXT or MTEXT in that selection...' line) after 'Select beam TEXT/MTEXT to convert:'. (4) ABFLIPAUTO shows <On> (Tim's value; the finalizer's text said <Off>). Settings files unchanged (hash DA5B5B44 held). **Status:** OPEN (Team; Tim's call on the machine-report name).

---

## BUG-412

**Command / Area:** Civil, installed 3.0.32, Codex W10c (5 Oct 18:07): (1) after a New Pit placement, Esc, then TEXTSCR, the command line showed 'CE could not save its pipe and pit record with this command. It will be saved with your next command.' (once; the next commands then ran). Check whether the pit placement can leave the record unsaved when the next command is a view/system command (U afterwards removed the pit body, label and cover text, 3 U: the typed query commands NOMUTT and TEXTSCR each took one U step). (2) The pit placement printed NO 'Duplicate definition of block _Dot ignored.' (#671 observed in the transcribed lines; not fully certified). (3) 'Stop overriding' still shows NO explanatory sentence (BUG-408; group heading changed to 'CL 18.82'). (4) CDRULES asks 'CE rules: show all findings, problems only, the values in use, or explain each problem [All/Problems/Values/Explain/pReview/Source] <Problems>:' (not a Design Check window): the METRE-A grade check (#666) is still unproven; METRE-A opened the wrong drawing (NEWTGT) first again when the Explorer list moved. **Status:** OPEN (observation; W10d with the CDRULES 'Values' option and METRE-A opened by File > Open dialog).

---

## BUG-411

**Command / Area:** F2 key runs the CE command CLEAN (Codex W10b, 5 Oct 17:34-17:36, installed Civil 3.0.32 etc.): pressing F2 in the AutoCAD drawing window (normally the text-window toggle) runs `[CLEAN]`: Purge, Xref Layer Isolation, Text Style Standardization, ByLayer Normalization (dims/leaders/mleaders), RegenAll, then 'Save the drawing to keep these changes.' Three presses, three runs; no CLEAN was typed. So in Tim's profile (and possibly every colleague's) F2 REWRITES the open drawing (in memory; saved only if the drafter saves). **Why it matters:** a drafter who presses F2 to read the command history gets a purge/restyle of the drawing; Undo may not cover all of it. **To find:** who binds F2 (CE CUIX/accelerator in CE_CADTOOLS, acad.lsp, or the Structural/Civil bundle's CUIX); decide: keep with a visible name and a confirmation, or move off F2. The Codex briefs already carried 'Never F2' (an older lesson); my W10b/W11b briefs wrongly told Codex to press F2 (fixed: TEXTSCR/GRAPHSCR). **Status:** OPEN (Tim's decision needed on the binding; Team to locate it).

---

## BUG-409

**Command / Area:** TEST INCIDENT on Tim's live Structural settings (Codex W11-03, 5 Oct 10:19): my W11 brief told Codex to answer ABFLIPAUTO 'ON' then 'OFF' assuming the setting started Off. The prompt showed `[ON/OFF] <On>` (Tim's own saved value is ON), so the pass ended with the setting OFF and the command itself saved `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` (24,377 -> 24,378 bytes, SHA256 DA5B5B44B1F17C96... -> 7E9EF4FFF4720B8C...). The ORIGINAL file is copied aside by install 30: `C:\ce_rc_scratch\settings_pre_1030\CE_STRUC_SUITE_CS_Settings.json` (SHA256 starts da5b5b44b1f17c96 = the original hash). **Fix:** put the setting back to ON (run ABFLIPAUTO and answer ON, or copy the saved original over the live file with AutoCAD closed: needs the desk's/Tim's word because it is Tim's settings file). My brief error; future briefs must read the current value first and restore exactly that. **Status:** RESTORED 5 Oct ~10:50 by the desk (answer a): live file copied back from the saved original, 24,377 bytes, SHA256 DA5B5B44 = original; the changed copy kept as settings_pre_1030CE_STRUC_SUITE_CS_Settings.AFTER_W11_BUG409.json; only line that differed: SkipFlipPromptWhenAutoDetermined true -> false. Rule added to _CODEX_RUNNERbuilder_rules.txt (SETTINGS-WRITING COMMANDS RULE). Tim to be told by the desk.

## BUG-410

**Command / Area:** W11 findings on installed Structural 1.0.102 (Codex, 5 Oct 10:44; most 'FAIL/BLOCKED' were prompts the finalizer's checklist quoted from code but AutoCAD prints differently, i.e. brief mismatches; real or possibly real items): (1) BTX with a window that finds 0 objects exits silently (`0 found`, Enter returns), no 'There is no TEXT or MTEXT in that selection. Nothing changed.' (the #630 message may only fire when objects were selected but none is text; check); BTX on the typed TEST text window found 0 so conversion unproven. (2) BT1 prints `Duplicate definition of block _Dot ignored.` (the Structural bracing loader re-defines _Dot: same family as BUG-400). (3) Typing BEAM in AutoCAD ran BEAMLINKDEBUG (AutoCAD type-ahead picked the longer name); is plain BEAM a registered command? (grep finds no CommandMethod "BEAM" in Modules/Structural; may be LISP). (4) CSREOBAR's bar-size default is N12 (last used), not N16 (not a defect). (5) R1 asks 'Pick LEFT beam or wall [Object/Point] <Object>:' (the roof tag text question I quoted does not exist in R1: not a defect). (6) FSF asks 'Enter width for SF 1 <300>:' (brief wrong wording). (7) The machine-report folder `%APPDATA%\TIM_CE_CADTOOLS\CE_Admin\admin-telemetry\outbox\machines` does not exist yet, so #662's 'no login in file names' is unproven. PASS on 1.0.102: CSFDNPROPOSE = Unknown command; FPFC on a decimetre drawing prints the exact warning and draws nothing; FEDIT says 'Pad footing'; FST Delete PF2 then one U restores PF2 on drawing and in the list. **Status:** OPEN (observations; W11b with a corrected brief).

---

## BUG-408

**Command / Area:** Pit Schedule 'Stop overriding' status sentence (#681, installed in Civil 3.0.32), Codex W10-03, 5 Oct 09:30: the menu item 'Stop overriding' is there and works (cover stays 18.82, row kept), the current layer is put back (CLAYER stayed BLOCKS after Close, U and reopening: #683 PASS part), but NO status sentence ('Stop treating this row as an override. The values you typed stay.') appeared anywhere in the captured window; the hover text could not be tested by Codex's tools. Either the sentence is only in the hover/status strip that Codex missed, or the status line is replaced by the header text. **To check:** a short driver or Tim's eyes; read the status line code in PitScheduleViewModel for the 'Stop overriding' command. Other W10 notes: W10-01 CEHEALTH printed a blank capture (IT-folder sentence not read); W10-02 placement log not fully captured (a second New Pit P13 window opened after the cover click) but no _Dot message and NOMUTT 0 throughout; W10-05 opened the wrong drawing (METRE-A grades unproven); the fixture's Pit Schedule is UNLINKED so #658's CURRENT/OUT OF DATE badge is unproven. **Status:** OPEN (observation; retest as W10b).

---

## BUG-405

**Command / Area:** report privacy (S-19 Opus finalizer, 5 Oct 09:55). (1) PR #662 (Structural reports hash the user and computer names like Civil) leaves two fields of the machine report unscrubbed: `SourceRoot` and `StatusSummary` (AdminTelemetryService.cs:182, Structural): a colleague whose CE assets folder sits under OneDrive would have their Windows login in that field. (2) Civil is worse and is OLD code outside every train: its machine report's FILE NAME still carries the real login and computer name (Modules/Drainage AdminTelemetryService.cs:263). **Fix:** scrub or hash both fields in Structural and the Civil file name the same way. **Status:** OPEN (LOW-MEDIUM privacy; Team).

## BUG-406

**Command / Area:** old METRE drawings (C-18 Opus finalizer, 5 Oct 09:30). #666 fixed two of the six readers of an older metre record; four are STILL on the old reading (length 1000 times too short): `MarkupToChangePlanService.cs:229`, `:281`, `:373` and `GetProjectNetworkTool.cs:177` (the #659 review's other readers `RulebookEngine.cs:72` and `RuleFixPlanner.cs:42` are the two #666 fixed). The four are the markup-to-change plan and the AI project-network tool: not reachable by a drafter's normal commands today (markup/AI lanes), but they will give wrong grades on an old metre job. **Fix:** read each pipe length through the same unit-aware helper, test with a metre-saved record (0.020 for a 20 m pipe). **Status:** OPEN (MEDIUM; Team or Codex).

## BUG-407

**Command / Area:** Structural CSFDNPROPOSE (PR #678, hidden OFF command), found by S-19 assembly 5 Oct 08:55: on top of #686 it fails three guards: `EveryClassWithACommandMethod_IsListedAsACommandClass` (FootingProposalCommands not registered with [assembly: CommandClass] in Plugin.cs, so AutoCAD would say Unknown command), and `EveryFoundationsKeywordQuestion_ShowsItsChoiceListOnce` + `NoOtherStructuralFile_SwitchesAutoCadsCopyOffItself` (FoundationService.Proposal.cs:142/:144: its 'accept which proposals' question switches AutoCAD's copy of the list off by hand instead of CeQuestion.OwnList). #678 was DROPPED from train S-19 (revert 6becb2a4). **Fix round for the Team:** register the class, use CeQuestion.OwnList, rerun after #686 is in. **Status:** OPEN (Team).

---

## BUG-404

**Command / Area:** the PC's C: drive during builds and tests (not an AutoCAD command): free space swings between 2 and 27 GB and builds, Codex runs and installs stop at the 12 GB gate (4-5 Oct 2026).

**Symptom:** C: dropped to 2.1 GB free several times with nothing of ours running. Causes found (read only, 4-5 Oct): (1) Windows Search Indexer (searchindexer.exe) writing 120 to 330 MB/s (Enhanced search mode indexing the work folders, temp folder and Codex history), which takes several GB of temporary space while it merges its index; (2) installer-style scratch folders in %TEMP% (random names such as o3wb5cfc 3.8 GB and lestw1e0 1.3 GB, Visual Studio / .NET setup files) that every build wave recreates; (3) Codex made a 3 GB copy of Tim's live settings folders at the start of each run (n3np-live-before, ce-settings-enter-1, ce-review-fixes2-live-before); (4) old background-task output from finished sessions (13.7 GB in one folder).

**Expected behaviour:** C: stays above 15 GB through a build wave. Done so far: the old task output and the installer scratch were deleted (Tim 4 Oct 23:20: "clean c drive as you need and dont remove important stugg"); two of the three Codex snapshots deleted after the desk compared counts, sizes and hashes with the live files (5 Oct 03:55); Codex's builder rules now say hash receipts instead of a full copy (controller, 5 Oct). STILL TO DO BY TIM at the PC: Settings > Privacy & security > Searching Windows > Find my files > Classic (or exclude C:\Lisp Files, C:\ce_rc_vc7, C:\ce_rc_drv, C:\Users\TimothyBrand\.codex and .claude); a Windows system setting, so no chat changes it. Later: Codex history (7.2 GB sqlite, a 3.7 GB rollout) is Tim's data: archive only if he says so; delete C:\Temp\n3np-live-before after the first Codex AutoCAD check on the Monday install passes.

**Reference:** decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md (INT-058, INT-060); queue items 190-195; TIM_DESK.md.

**Status:** OPEN

## BUG-403

**Command / Area:** Civil quiet paste catcher, #567 (INT-048), found by the desk's driver probe DRIVER_RUN27 (4 Oct ~21:07) on the INSTALLED Civil 3.0.31 (#567 is in the installed line: merge 0eff93d4 is an ancestor of 88bf32d8). COPYCLIP of 15 CE pits and pipes in a drainage drawing, PASTECLIP into a Structural drawing with no drainage in the SAME AutoCAD session: the paste landed (15 -> 1049 objects) but NO CE line and no 'run CDREPAIR' line was printed. The CE log says it counted 9 pasted pits needing CDREPAIR, then 'this drawing's record is not loaded; the not-in-schedule line was not printed'. **Cause (reading the code, LinkService.ForeignClones.cs:~750 and CloneOriginRule.cs:~232):** the line is held back unless the destination's schedule record is loaded OR 'Civil was woken by this very paste' (ScheduleRowsKnown). In the driver case Civil was already awake from the source drawing, so the paste did not wake it, and the Structural destination has no loaded record, so the rule treats 'no schedule rows' as unknown. That is exactly Tim's normal case (copy from a drainage drawing, paste into a drawing with none, in one session). **Approved card (INT-048):** one plain line 'run CDREPAIR' for CE pits/pipes pasted into a drawing with no drainage. **For the Team:** decide whether 'destination has no Civil record at all' counts as 'no rows known' (print the line) and add the test for 'Civil already awake, destination has no record'. Codex W9-06 (blank new drawing, Civil asleep) is still unproven because PASTECLIP did not land under mouse control. Plain paste of a circle and U after it: PASS (driver). **Status:** OPEN (HIGH-ish: the approved line does not appear in the normal case).

---

## BUG-402

**Command / Area:** AutoCAD start-up message (Codex W9d, 4 Oct 19:31): the command line prints '[CE_StrucPlus] LISP not found: C:\ProgramData\Autodesk\ApplicationPlugins\CE_STRUCPLUS.bundle\Contents\CE_StrucPlus.lsp' although no CE_STRUCPLUS bundle is installed (leftover loader reference). Noise for every drafter at start-up. Codex build bj6 item N-2 (4 Oct 19:40) looks for the printer; if it lives outside the repo (old autoload) it is reported. Also seen: four '[CE] Background not found: <xref> Type CDXREFREPAIR' lines when returning to the Civil fixture (xref paths in the fixture, expected). **Status:** AWAITING TIM CONFIRM (5 Oct 01:40: desk commented out line 76 of ce_suite_startup.lsp with Tim's yes, backup .bak-20261005-before-strucplus-removal beside it; check the next AutoCAD start is clean). UPDATE 4 Oct 19:40 (Codex bj6): the printer is OUTSIDE the repo: Tim's own support file ce_suite_startup.lsp in his AppData Roaming Autodesk AutoCAD 2027 R26.0 enu Support folder (acad.lsp loads it; line 76 calls the retired StrucPlus loader). Editing it needs Tim's separate authorisation (desk to ask), or the installer should own that file.

---

## BUG-401

**Command / Area:** Civil New Pit: cover level after a restart (Codex W9d W9-08, 4 Oct 19:31, installed Civil 3.0.31). Two pits placed (cover 21.00, then 12.340); CD_Settings.json stayed byte-identical (SHA256 ACD64E79..., 15,270 B, 08:22:30: **#638 PASS on that part**). `CD_RecentValues.json` (4,071 -> 4,072 B) holds `"coverLevel": "12.340"`, `"addCoverText": true`, `"coverTextPosition": "BR"` (I read the file). But after closing AutoCAD and reopening FIX_MODERN_PIPE_W1.dwg, PIT at 18000,-90000 opened New Pit P13 with the **cover box EMPTY**, warning 'Enter the cover level.' and 'Unknown. Cover text is on, but every text field is blank.' It did not propose 12.340. **Question for Tim (via desk):** should New Pit propose the last cover level, or is a blank cover (drafter must type it) the intended rule because a cover level belongs to one pit? If proposing is wanted: the value is saved but not read back into the window. **Status:** DECIDED 5 Oct (Tim, INT-059/060): New Pit cover after restart stays BLANK (default); #705/#715 keep the choice; no code change needed for the default. Other W9d results: W9-04 typed C2 reached the window (fields showed C2 and 21.00) but the brief's Esc-twice zoom cancelled the label prompts, plan label not verified; W9-06/W9-07 PASTECLIP showed no insertion-point prompt (test-driving problem, retest needed with typed point on the command strip).

---

## BUG-399

**Command / Area:** FEDIT outline click (Structural), Codex W9c W9-01B, 4 Oct 18:51. At close zoom (gap between PF1 and strip SF1 = 50 mm filling a third of the screen), clicks at the middle of the gap, 2 mm from PF1's edge and 2 mm from SF1's edge all answered 'Nothing Selected.' / 'Select a footing to edit:'. Clicks directly ON the outlines (W9b, wide zoom) named the right footing. So the pick box may be missing outlines at small offsets, or Codex's pixel mapping was off (the fixture edges were at pixel y615 and y805 for 50 mm). **Not a confirmed defect:** needs a driver or accoreconsole probe at a known pick point, then decide the pick tolerance (Settings value, R-00). **Status:** OPEN (observation).

## BUG-400

**Command / Area:** Civil PIT 'Continue placement' (Codex W9c W9-08, 4 Oct): the command line shows 'Duplicate definition of block _Dot ignored.' each time a pit is placed. Harmless AutoCAD message from inserting a second definition of the _Dot block, but noise for the drafter; find the inserter that re-defines _Dot from a file and make it insert the existing definition. **Status:** OPEN (LOW, observation). UPDATE 4 Oct 19:40 (Codex bj6): already covered by PR #671 (branch claude/pit-place-dot-noise, in the Monday Civil list); check in AutoCAD after #671 is installed: place two pits, no duplicate message.

---

## BUG-398

**Command / Area:** Structural issue-revision preview engine (PR #692, STRUC-REGISTER-ISSUE slice 2), found by Codex builder bj4 W-1 on 4 Oct 16:41. The preview and the real issue disagree for sheets that are NOT ticked: the preview shows one revision and date, the issue itself gives another. Codex stopped the preview window (branch codex/w1-issue-preview-window @ 3e55d788, no PR, nothing built) because a window must show what the issue will really do. **Fix needed in the engine first:** one code path for 'what revision and date does an unticked sheet carry', used by both the preview and the issue. Then the window (W-1) is rebuilt on top. **Status:** OPEN. Do NOT merge #692 into a Structural train until fixed. Also noted: full-suite red `DuplicateCommandScan_CommandCounts_MatchStudyEvidence` in the W-2 worktree (check whether it is on the train base or only in the window PR #698).

---

## BUG-397

**Command / Area:** Manager CE.Host load list (reviewer run 87, REVIEWLANE_LOG 584-586, 4 Oct 15:54): **#684 LOW 2** and #677 each carry a DIFFERENT wrong list of what the Manager loads (CE.Host's load list); Team build/03 run 19 is making ONE correct list (Manager list fix #684/#677). Filed so the item cannot be lost. To verify at the Monday C-18 train: the Manager status page's 'N of M installed CE tools running' and its load line must match what is really loaded in AutoCAD (Civil, Manager, Structural, AutoCADLink, Transform); Installer.Tests to be run once after both PRs (reviewer note). **Status:** OPEN (Team build/03 r19).

**Also for the Monday trains (reviewer run 87):** #687 DO-NOT-MERGE (double-click label edits never reach that reader; typed c2 still becomes C2; overlaps #670: fold the real fix into #670); #691 stays OFF (can write a 0.000 invert on a pipe end with no level; inherits #679's council-pipe gap); #689 needs Tim's ruling or a softer message (older placed tables refuse the first typed rename per cell; Codex K-4 builder decision: use 'Update existing schedule' first); #652 already in 1015y (close). Codex builds: bj2 ended 14:43 (J-items already in PRs), bj3 built K-1 #681, K-3 #685, K-4 #689; bj4_windows started 16:00.

---

## BUG-396

**Command / Area:** findings of the C-17 Opus finalizer (4 Oct ~11:55, `TRAIN_C17_FINALIZER_REPORT.md` item 5; train claude/rel-20261015h e027a288, built and unit-tested only). None blocks. Filed as numbered items:

1. **MED (CHECK FIRST IN AUTOCAD): a double-click edit of a PLACED Pit Schedule table cell may not reach CE at all.** The finalizer found no route by which a table-cell edit reaches the pit rename: CE pauses its watcher during TEXTEDIT (`LinkService.Reactors.cs:1683-1690`) and the end of a text edit handles only CE's own labels. If typing C2 into P5's cell does nothing in AutoCAD, 3.0.30 behaves the same (not a regression) but #660's feature does nothing there. Codex check, first.
2. **Six metre-length readers (#659):** six places read an older metre job 1000x short; BUG-393 lists only the four #659 fixed: reconcile the lists (the reviewer's six vs the four in BUG-393).
3. **Stale table cell can rename a pit back** (`ScheduleLinkService.cs:234`): a placed cell left showing an old number (its layer was locked at refresh) can rename a pit back when unlocked and moved, with only a log line; true in 3.0.30 for P-numbers, now for any number.
4. **#645 hand-typed level mark lost:** after a particular MOVE of a flat pipe with one hand-typed level, that level can lose its 'typed by hand' mark, so a later grade recalculation could overwrite it (`RelinkedPipeRecordWriter.cs:146-149`).
5. **Plan pit label:** moving a label still reads P-numbers only; editing the label text uppercases the number (c2 becomes C2).
6. **Wording:** the 'Undo takes it back' promise on Stop overriding is not backed by code that puts the plan label back; the diagnostics service says 'DLL missing' (`CeDiagnosticsService.cs:186`) and 'missing bundle files' (`:345`) (jargon).
7. **Questions for Tim (not faults):** a typed 8 beside P8 and 'C 2' beside C2 are accepted as separate pits (OK?); a charged pipe that rises on purpose with an open end now flips on a grip drag (#654): intended?

**Also the S-18 finalizer (c651e623, GO, #652 stays in): LOW 1 Re-link accepts any object (circle, Xref insert) and redraws the footing from it (pre-existing); LOW 2 an Undo mark AutoCAD refuses fails silently (`LegacyToolCommon.cs:451`): add a log line; FIRST CHECKS AFTER INSTALL: delete PF2, U, REDO; LINE, FST, Cancel, U; locked-copy + #653 footer; DBMOD after FST + Cancel then Zoom and U; Re-link, Escape, U; ERASE a pad and U twice. If one fails: stop using FST Delete on real jobs; revert the #652 merge 9bc9f247 in the next Structural train.**

**Status:** OPEN (items 2-6 to the Team; 1 and the S-18 first checks to Codex W9).

---

## BUG-395

**Command / Area:** Codex verifyW8 results (4 Oct 10:12-11:09 PC clock, usage 22% -> 25% = the stop line; `CODEX_VERIFYW8_2026-10-04.md`, evidence `VERIFYW8\`, `NEXT_START.txt`) on installed Structural 1.0.100 + Civil 3.0.30 / Manager 1.1.30: **2 PASS, 1 FAIL (wording), 6 BLOCKED (mostly MY brief's faults), 1 NOT TESTED (time).** Not Tim-accepted.

1. **W8-03 PASS: mixed-units hold:** with INSUNITS 6 on a drawing whose CE footings are drawn at millimetre size, FPFC refuses at once: "This drawing's units are metres, but its CE footings are drawn at millimetre size (one is 600 metres across), so CE has not run this command. Check what the drawing is really drawn in (LIST one footing) before changing anything." Nothing drawn (4 polylines before and after). INSUNITS restored to 4.
2. **W8-08 PASS: CEMANAGER with the Manager window MINIMISED (#650): typing CEMANAGER brings the window back in front.** (So BUG-391 finding 6 is fixed.)
3. **W8-04 FAIL (LOW wording): decimetre hold:** FPFC with INSUNITS 14 says "This drawing's units are decimetres. CE cannot size the schedule table in decimetres yet, so CE has not run this command. Check what the drawing is really drawn in (LIST one footing) before changing anything." The card case 8 line ('CE converts mm, cm, m, in, ft only') is absent: the actual line is plain and true, so judge if the card wording or the code wording stands (desk).
4. **W8-05 (BLOCKED, but evidence): metre blank drawing:** FPFC in a new drawing with INSUNITS 6 prints ONCE "This drawing's units are metres, so CE has converted the footing sizes between millimetres and metres.", accepts X 600, Y 600, depth default, then "[FOUNDATION] Redrew footing system 'Footing Network': 1 footing. Nothing needs attention." The 0.6 size, label height and FEDIT 900 were not measured (the AREA read failed: "unknown name: AREA"; no readable label for the FEDIT click).
5. **W8-09 PARTIAL PASS (#638, BUG-306): ONE pit placement left `CD_Settings.json` BYTE-IDENTICAL (SHA256 ACD64E79..., 15,270 bytes, LastWriteTime 08:22:30 unchanged) and `CD_RecentValues.json` was created.** New Pit window (P13, 450 x 450), cover 21.00, Continue placement; extra prompts after it ("Specify pit label insertion point:" then "Click to place cover text (Enter = <BR>):") were cancelled; message seen on placement: "Duplicate definition of block _Dot ignored." (LOW noise line: an AutoCAD message when CE inserts its block; check if it can be avoided). The second pit, 12.340 and the restart (W8-10) were not reached.
6. **BLOCKED by the brief:** W8-01 (FSF asks "Enter text <SF1>:" first: Esc cancelled it; the strip was never made; FEDIT outline click at the 50 mm gap NOT TESTED), W8-02 (FPFC prompts are: Enter text <PF1>, "Label 'PF1' already exists... [Yes/No/Increment]" -> auto-incremented to PF5, X, Y, depth, insertion point (centre), rotation; no 600 x 600 'size prompt' as my brief assumed; a pad at 12000,0 redrew the system with 5 footings, U echoed FPFC), W8-06 and W8-07 (the standard 'Esc twice before every command' protocol clears the selection before COPYCLIP, so the paste checks were not reached: the next brief must select and type COPYCLIP in ONE step WITHOUT Esc between).
7. **W8-10 NOT TESTED: TIME** (25% reached).

**Status:** result record. Re-run as W9 (separate budget day) with the brief fixed (FSF prompts, FPFC prompts, selection-preserving COPYCLIP).

---

## BUG-393

**Command / Area:** four places still read a METRE-drawing record saved before BUG-331 as 1000 times too short (found by the C-16 Opus finalizer, 4 Oct 09:28, `TRAIN_C16_FINALIZER_REPORT.md` item 5; not listed anywhere else in the carpark): `ProposalApplyService.PlanBuilders.cs:560` (CDRUNSOLVE's own solve), `PipeSizeNetworkReviewService.cs:608`, `NetworkRedesignDrawingProjector.cs:381`, `PitRenumberNetworkBuilder.cs:119`. Same family as BUG-330 / the dashboard "Fix all" invert fix (ProposalApplyService.cs:777). After train C-16 the invert write uses the true length, so CDRUNSOLVE on such a job now labels its near-flat levels honestly ("1 IN 100000") where 3.0.29 showed a misleading "1 IN 100" (the levels written are the same either way). **Fix:** read the pipe length through the same unit-aware helper the new code uses; tests first (a metre record, an old saved record); Team build/03 or build/04, read-first. **Status:** OPEN (MED, pre-existing, metre jobs only).

---

## BUG-392

**Command / Area:** Codex verifyW7 results (4 Oct 07:52-08:29 PC clock, usage 19% -> 21%; `CODEX_VERIFYW7_2026-10-04.md`, evidence `VERIFYW7\`), installed Structural 1.0.99 + Civil 3.0.29 / Manager 1.1.29: **2 PASS, 0 FAIL, 3 BLOCKED.** Not Tim-accepted.

1. **W7-01 PASS (Structural, roof-down brief; the one footing item last): FST Delete of PF2 on DWG-S1_LOCKED (STRIP FOOTINGS locked), answering YES:** the warning box "Foundation (Warning)" reads "Took footing 'PF2' out of footing system 'Footing Network'. Its line is on locked layer STRIP FOOTINGS, so it was left in the drawing (nothing was unlocked). Unlock the layer, erase it, then type FREGEN." (layer named ONCE, true, no "nothing was changed" claim, no "Its the" typo); the layer flag stays 4 (locked); the PF2 polyline is still in the drawing; PF2 is gone from the FST list (3 elements). Same text repeated on the command line with [FOUNDATION]. OSMODE 5375, CLAYER "0" (that fixture's), DBMOD 17.
   - **FINDING A (MED, U): ONE U after this delete echoed "FST" but did NOT bring PF2 back** (reopened FST still lists PF1, PF3, PF4): the footing's removal from CE's record is not undone by U when the drawing itself changed nothing. Decide: should FST Delete be one undoable step including the record (as BUG-358/368 for other commands)? To build/02, read-first.
   - **FINDING B (LOW wording): the FST footer after the delete still reads "Layer STRIP FOOTINGS is locked, so CE did not redraw footing system 'Footing Network' (nothing was unlocked or changed). Unlock it and type FREGEN."** The "(nothing was unlocked or changed)" wording is the disputed one (true of the redraw, misleading after a real delete); same fix family as #606.
2. **W7-03 PASS: BUG-385 recheck on the C-15 build: Revert Row Override on P11 (cover 20.900 -> 20.910): rows 30 before and after; P8, P11, P12 intact (450 x 450, ILs 19.80 / 19.71 / 19.70 / 19.61 unchanged); the typed cover stays 20.91 (BUG-386: the rename to "Stop overriding" is queued); plan label P11, CL 20.91; no CE warning.**
3. **W7-02 BLOCKED (one sub-line):** Pit Schedule reset assertions PASS: first open 30 rows, Type All, Group All, "All sets" header, empty Search; a P11 search shows 2 of 30; reopened: Search empty, Type All, Group All, 30 rows, view "Rows / Pit and pipes" kept (#618 works). The Type-box change timed out ("computer-use request timed out: click"); the Set box is not on the Rows page. So "every filter cleared after CHANGING each filter" is proven for the search box only.
4. **W7-04 BLOCKED (plan IL comparison):** DWG-B1_VC7 opens with "[CE] 49 pipe(s) upgraded to CE pipe objects, 49 given their CE identity. (a PRE_C7 backup already exists beside the drawing.)"; P3 cover 18.88 -> 18.89 then Revert Row Override: 27 rows before and after, P3 name unchanged, cover kept 18.89, depth 1.63 -> 1.64, every IL cell unchanged (FROM P4 450 / 17.30, outlet 17.25, WT10/WT9 150 / 18.10, WT4/WT3 150 / 18.24), NO "was not written" / "Set it in Edit Pipe" line; the plan IL AFTER readable (18.10 at the lower connections, 17.30, 17.25, 18.24 x2) but IL BEFORE unreadable (clipped by the zoom), so equality not established.
5. **W7-05 BLOCKED:** CEMANAGER typed ONCE opened the window (so finding 6 of BUG-391, 'typed twice opened none', is probably the second call while the window is open: build/04 run 7 reads it); on Status / Updates NO clearly greyed button was visible: "Send a fault report" and "Send waiting reports", "Admin Dashboard", "Refresh" all looked enabled (nothing to prepare for all three modules), so the 'greyed button has a reason' check could not be exercised (nothing pressed).
6. **Other:** CD_Settings.json rewritten four times by CE on Pit Schedule Close (15,273 -> 15,270 bytes, hash 63AF5316 -> ACD64E79; BUG-306 family); OSMODE unchanged at every reading; clean exit by File > Exit (a drawing-free AutoCAD has no command line).

**Status:** result record; FINDING A to build/02 (read-first), FINDING B LOW wording to build/02.

---

## BUG-391

**Command / Area:** Desk driver run 24, the ONE combined session (4 Oct ~08:40; `DRIVER_RUN24_2026-10-04.md`) on installed **Structural 1.0.99 + Civil 3.0.29 / Manager 1.1.29**: **15 PASS, 0 FAIL, 5 BLOCKED, 6 NOT TESTED**, one launch, clean quit, OSMODE 5375 throughout. Not Tim-accepted. PASS (roof down): BEXTEND "Beam extended to the boundary at its end/start" (never "End end"); FDELETE, units question, FEDIT, repeated-label and adopt-mode questions show [Yes/No] or the list ONCE and Enter takes the default; FREGEN, one-U of FADOPT; Civil: Pit Schedule resets to All/All/empty on reopen (#618); two drawings: CE log "kept" then "written to its own drawing", no leak; CDSYSTEM in the second drawing left the first identical; CDDIAG new line.

**STILL WRONG (7 findings, filed as BUG-391 items 1-7):**
1. **BEXTEND's two questions show their default TWICE** (`<Nearest> [Nearest/Start/End] <Nearest>`): the BUG-388 family (Structural keyword question prints the default twice). LOW. To build/02.
2. **FEDIT size and depth questions show the default twice** (`<600> <600>`): same family. LOW. To build/02.
3. **The units question still says INSUNITS** (jargon in a user-read line). LOW wording. To build/02 (plain: "drawing units").
4. **Open + Cancel of the Foundations manager leaves an UNDO STEP** (the first U undoes FST only): a read-only window should leave nothing for U. MED (U-count). To build/02, headless repro first (BUG-381 family).
5. **FADOPT Footing mode adopted an ARC as a strip footing and silently ignored an ELLIPSE** (Raft mode untested). MED: adopt only the shapes CE can honestly use as a strip; say plainly what was skipped; never a silent ignore. To build/02, read-first.
6. **CEMANAGER typed twice opened NO window and printed NO error (maybe a driver effect; a fault until proven otherwise).** HIGH-MED. Reproduce headless/code-read first (the Manager window open path, ShowModeless, the 'already open' guard, a stale window handle after the first call); Codex W7 W7-05 types it once and reports. To build/03 or build/04.
7. A plain MOVE on a B1 pipe printed "does not match a single pipe in the project record" (maybe fixture noise: BUG-355 item 2 family). LOW; read-first.

**BLOCKED:** pier diameter / stump shape (Esc needed), FST "Remove unlinked" box, Manning's n (no concrete-pipe fixture; Edit Pipe shows no velocity: a fixture is wanted), Manager greyed buttons (Codex W7 W7-05). **NOT TESTED:** "Stop overriding" (not built yet), record copy with pavement areas (no fixture), ribbon hover words, overlay label height, renumber question.

**Status:** OPEN (items 1-7 to the Team; fixture wishes: a concrete-pipe job for Manning's n, a record with pavement areas).

---

## BUG-390

**Command / Area:** Codex verifyW6 results (4 Oct 05:02-05:39 PC clock, usage 17% -> 19%; installed Civil 3.0.28 / Manager 1.1.28 / Structural 1.0.98; `CODEX_VERIFYW6_2026-10-04.md`, evidence `VERIFYW6\`): **1 PASS, 0 FAIL, 2 BLOCKED.** Not Tim-accepted. Filed as a result record plus observations:

1. **W6-02 PASS: BUG-385 IS FIXED IN REAL AUTOCAD (3.0.28).** FIX_MODERN_PIPE_W1: total rows 30 before the cover edit, 30 after, 30 after Revert Row Override on P11; P8, P11 and P12 all still listed (searches: P11 = 2 rows, P8 = 2, P12 = 1); P11 typed 20.91 stays 20.91 (plan label P11, CL 20.91); inlets/outlets unchanged; no CE warning; OSMODE 5375 / CLAYER BLOCKS / DBMOD 17 unchanged. (3.0.27 lost three rows, 30 -> 27.)
2. **W6-01 BLOCKED (plan comparison):** the prescribed object zoom clipped the IL texts above the viewport, so IL BEFORE could not be read; everything else read: 27 rows before / after / reopened; P3 cover 18.88 -> 18.89 typed exactly; Revert Row Override clicked once; all five inlets (17.30, 18.10, 18.10, 18.24, 18.24) and outlet 17.25 unchanged in the schedule; plan P3 CL 18.89 with ILs 17.30 / 17.25 / 18.10 x2 / 18.24 x2 unchanged; NO "level was not written" / "Set it in Edit Pipe" line; no U/REDO. So the finalizer fix (Revert must not push plan-text levels) looks right but the P2 end was not in view. OBSERVATIONS: after the Revert the schedule shows no OVERRIDE badge on the row (the edited cell is italic); **Revert Row Override also restored the PREVIOUS search text (P12) in the box** (0 of 27 rows): the #618 clear-on-open (in train C-15) should be checked in this window; the cover stays 18.89 after Revert (BUG-386 question still open).
3. **W6-03 BLOCKED (my brief error):** DWG-S1_LOCKED.dwg (STRIP FOOTINGS locked, flag 4 before and after): FST "Foundation systems" shows Footing Network, 4 elements, PF1-PF4 (Pad footing, Linked object); select PF2, "Delete Selected Element": the question is "Delete footing 'PF2' (Pad footing)?" with Yes / No (title "Delete Footing"). My brief told Codex to click No if asked, so the locked-layer box after a Yes was NOT reached. Redo with YES (the copy is never saved) in the next pass. FST has no Close button (Cancel / Save Size Library at the foot): "[FST] Cancelled." The window's buttons: Refresh, Rename System, Delete System, Regenerate Selected System, Regenerate All, Zoom Selected Element, Delete Selected Element; header View Log.
4. **Other:** a drawing-free AutoCAD has no command strip, so the final typed QUIT is unavailable (use the window Close button); CD_Settings.json rewritten three times by CE during PITSCHEDULE work (content hash unchanged); OSMODE end = start.

**Status:** result record; W6-03 to redo as W7 (Yes at the delete question) after the next installs.

---

## BUG-389

**Command / Area:** CDCHECK list on the COMMAND LINE still prints a raw `AGI\U+2192C1` for old pipe names (desk driver run 22, installed Civil 3.0.28, 4 Oct ~04:55; `DRIVER_RUN22_2026-10-04.md`, item C7): the saved list FILE has the real arrow, the command-line copy shows the escape text (BUG-377 family: an escaped arrow in a user-read line). Print "to" / ASCII "->" on the command line. LOW wording. **Status:** OPEN (to build/03 or build/04).

**Driver run 22 result (Civil 3.0.28 / Manager 1.1.28, C-13 list): 6 PASS, 0 FAIL, 1 BLOCKED; nothing wedged; OSMODE 5375 and CLAYER BLOCKS after every step: CLAYER NEVER READ NIL (BUG-387 not reproduced: PITSCHEDULE, edit, close, U, reopen; the Revert click itself untried: Codex W6).** PASS: C1 BUG-385: with two drawings open, W1 kept its own 30 rows with P8/P11/P12 listed after PITSCHEDULE in the second drawing (27 rows), fingerprint of W1's pits/pipes/texts identical before/after; C4 BUG-378: the old-pipes copy upgraded 49 pipes on open with another drawing open, others unchanged; C5 locked pipe layer named, CE says it will not unlock it, layer stayed locked; C6 CDRULES "(CDRULEBOOK > Council)", CDRUNSOLVE "P4 -> P3 -> P2 -> P1", no raw \U+2192; C7 CDCHECK list file landed in the logs folder (All option); C8 CDSETUP/CDFIXTAGS/CDXREFREPAIR as before. NOT TESTED: C3 (no fixture with two pipes leaving one pit), Revert Row Override (Codex W6).

---

## BUG-388

**Command / Area:** FDELETE question prints `[Yes/No]` TWICE on one line (desk driver run 21, installed Structural 1.0.98, 4 Oct ~04:35; `DRIVER_RUN21_2026-10-04.md`): `Delete footing system 'Footing Network' and its 4 footings? [Yes/No] <No>` shows the keyword hint twice. LOW wording (to build/02, one-line fix: AutoCAD adds the [Yes/No] hint itself, so the CE prompt text must not). **Status:** OPEN.

**Driver run 21 result (Structural 1.0.98, S-14 list): 2 PASS, 0 FAIL, 3 BLOCKED, 3 NOT TESTED.** PASS: S1 FDELETE prompt "Select a footing line or outline of the footing system to delete:" then "Delete footing system 'Footing Network' and its 4 footings?" (No deletes nothing); S2 FREGEN prompt plain, a plain LINE pick says "That is not a CE footing line or outline. Nothing changed."; U/REDO fine; OSMODE 5375 at every reading. FEDIT pick landed on the pad OUTLINE: "That is a CE outline, not a footing. Pick the pad (or its label) instead." = the BUG-380 behaviour again (Tim's ruling needed: edit the pad when its edge is clicked?). The agent's FEDIT chain was one Enter short and wedged AutoCAD at "Select a footing to edit:" (driver-made; hang capture, quit -Kill; expect one unclean-exit entry about 04:12 in the CE Admin outbox). BLOCKED: the locked-layer FST Delete box (the driver never presses a button named Delete; this fixture has no S-FOOTING layer: pads are on STRIP FOOTINGS) and S3 remainder: need a Codex mouse pass (W6) or Tim; NOT TESTED: S6-S8 (BEXTEND message etc.).

---

## BUG-387

**Command / Area:** CLAYER reads nil after a Pit Schedule Revert / U sequence (Codex verifyW5 W5-02, 4 Oct 03:1x, installed Civil 3.0.27; `CODEX_VERIFYW5_2026-10-04.md`, evidence `VERIFYW5\screenshots\W4-02-end-clayer-nil.png`). The OSMODE/CLAYER/DBMOD line was (5375 "BLOCKS" 17) at the start and after the edit; at the END of the item, after PITSCHEDULE -> cover edit -> Revert Row Override -> U (echo "PITSCHEDULE") -> PITSCHEDULE again, it read **(5375 nil 21)**: CLAYER nil. No layer was locked or set by the tester. Not isolated (which of Revert, U or the second PITSCHEDULE). The final U/reopen restored the row count to 30. A `(getvar "CLAYER")` returning nil is unusual; it may be a read made while AutoCAD was in a state where the variable could not be read (a document/transaction that ended with an error), or a real loss of the current layer. Needs a headless reproduction with the fixture (FIX_MODERN_PIPE_W1.dwg): same sequence, CLAYER before/after each step. **Status:** OPEN, to Team (read-first); the #604 fix (record bound to the drawing) may already change it.

**Codex verifyW5 result (4 Oct 02:51-04:19 after the daylight-saving jump = 01:51-03:19 on the old clock; usage 15% -> 16%): W5-02 FAIL (BUG-385 reproduced on the INSTALLED Civil 3.0.27: total rows 30 -> 27 after Revert Row Override on pit P11; P8, P11 and P12 each missing (search 0 rows); one U ("Command: U" then "PITSCHEDULE") restored the total to 30). W5-01 BLOCKED again (plan IL figures too small to compare at the prescribed view): row count stayed 27 throughout this time (the drawing started at 27 after the earlier switch), Revert on P3 printed no "was not written" line in the visible history, plan P3 CL 18.89 and ILs 17.30 / 17.25 / 18.10 x2 / 18.24 x2 unchanged, but completeness of the command-line history was not shown.** Also: the Pit Schedule remembers the last search filter (P11 stayed in the search box between sessions and after Revert). CD_Settings.json written four times by CE (hash 67270C52 -> 63AF5316; BUG-306 family). END readings = START (5375).

---

## BUG-385

**Command / Area:** Pit Schedule "Revert Row Override" makes the pit's row DISAPPEAR (Codex verifyW4 W4-03, 4 Oct 01:15 PC clock, installed Civil 3.0.27 / Manager 1.1.27; `CODEX_VERIFYW4_2026-10-04.md`, evidence `VERIFYW4\screenshots\W4-03-*`). **Severity MED-HIGH (a schedule row vanishes).**

**Symptom:** on FIX_MODERN_PIPE_W1.dwg (modern pipes, pits P8/P11/P12 drawn without a recorded project record, the schedule says "This pit is not in CE's recorded project data yet. Values below are Unknown."): row P11 cover 20.900, inlet 19.71, outlet 19.70; the drafter typed cover 20.91 (accepted visibly), right-click Revert Row Override: the schedule total went from 30 to 27 rows, a search for P11 shows "0 rows listed", the row is gone. The plan itself is unchanged (P8/P11/P12, P11 CL 20.900, pipe ILs 19.80/19.71 and 19.70/19.61); no "was not written" line, no other CE message; only "Command: PITSCHEDULE". No U/REDO was tried. OSMODE/CLAYER/DBMOD unchanged (5375 "BLOCKS" 17).

**Likely cause to check:** Revert Row Override re-derives the row set after dropping the override and a drawing-only pit (no recorded project data) has no row to fall back to, so P11 (and two more rows: 30 -> 27, probably P8/P12) drop out. Not known whether this is new in C-12 (#589 + the finalizer fix 59aeb250 changed the Revert path) or older. Read first: the Revert path in the Pit Schedule view-model; reproduce headless on a copy of the fixture; failing test first; a Revert must never remove a row.

**Status:** OPEN, to Team (read-first, next round). Not accepted; not fixed.

---

## BUG-386

**UPDATE 4 Oct 06:22:** BUG-386 Revert Row Override: Tim INT-043, 4 Oct 06:30, verbatim 'revert row override i think stop overriding' (desk reading: rename the menu item to 'Stop overriding'; behaviour unchanged: the typed value stays, one U undoes it; NOT 'put the original back'). DECIDED. To Team: rename the menu item (and any hover/help text); small, test first.

**Command / Area:** Pit Schedule Revert Row Override on pit C1 keeps the TYPED cover (Codex verifyW4 W4-02, repeat of the 3 Oct W3-04 reading): C1 cover 18.74 typed 18.80, Revert Row Override: row AND plan label stay at 18.80 (CL 18.80), pit stays C1 (no PC1), inlet 16.87 / outlet 16.82 unchanged, no prompt; one U ("Command: U" then "PITSCHEDULE") brings the plan back to CL 18.74. So "Revert" clears the override flag but leaves the value the drafter typed in the drawing. **Question for Tim/the desk (not a defect until answered):** should Revert Row Override bring the cover back to the drawing's/record's value (18.74) or only stop tracking the override? A plain-English name that says what it does ("Stop overriding this row" vs "Put the original value back") may be the fix. **Status:** OPEN (question).

**Codex verifyW4 result (4 Oct 00:54-01:26 PC clock, 13% -> 15%): W4-01 BLOCKED (input fault: keys went to the AutoCAD parent window and Esc closed the schedule; Revert fix on P3 still NOT proven), W4-02 PASS as a reading (BUG-386), W4-03 FAIL (BUG-385), W4-04 PASS in substance (the brief wrongly expected both pipes' labels to change: only the selected pipe P8 -> P11 became "300 DIA. UPVC PIPE AT 1 IN 100", P11 -> P12 stayed 225, as designed; "Pipe updated."; CLAYER/OSMODE/DBMOD unchanged; one U restores 225; no Design Warnings window appeared).** END OSMODE 5375 = START, SAVETIME unchanged. CD_Settings.json written 7 times by CE during the pass (BUG-306 family; hash changed ACD64E79 -> 67270C52, 15,270 -> 15,273 bytes); Structural settings unchanged.

---

## BUG-384

**Command / Area:** Edit Pipe / batch write with the pipe layer LOCKED (desk driver run 20, installed Civil 3.0.27, 4 Oct ~00:50, `DRIVER_RUN20_2026-10-04.md`, item C6): the batch is refused with "label records do not match" and NO mention of the lock. Expected (BUG-364 style): a plain line saying the pipe layer is locked and nothing was changed ("Unlock it to edit, CE will not unlock it for you"). Wording only; no behaviour change (the refusal and the untouched drawing are correct, native locked-layer rule kept). **Status:** OPEN, LOW wording (to a Team sweep).

**Driver run 20 result (Civil 3.0.27 / Manager 1.1.27): 6 PASS, 0 FAIL, 4 BLOCKED.** OSMODE 5375 and CLAYER BLOCKS unchanged after EVERY item (five Apply actions): the #585 leak fix holds. PASS: C1 Pit Schedule P3 IL shows the plan figures; C4 conflict cell blank with "the plan text shows 17.13 but CE's record holds 17.01"; C6 Edit 2 Pipes, one U back; C7 plain arrow; C9 CDFIXTAGS plain, no handles (names "AGI 1/2/3" with a space: wording only); C10 ARRAY line + one U. BLOCKED: C2, C3 and the Revert half of C4 (Revert Row Override is a right-click menu item only: the driver cannot right-click; so the #589/finalizer Revert fix is NOT proven in AutoCAD: Codex W4 items W4-01 to W4-03); C5 (the pipe-size write is switched off in Tim's settings; a Project Review level fix was applied instead: 17.65 -> 17.58, OSMODE/CLAYER stayed, one U undid it); C8 (no downpipe-on-a-run fixture).

---

## BUG-383

**Command / Area:** a fresh open of a drawing marks it modified (Structural 1.0.96 loaded). Desk driver run 19 (4 Oct ~00:05, `DRIVER_RUN19_2026-10-03.md`): DBMOD already reads 1 shortly after every fresh open, BEFORE FST or any CE command is typed; so something writes at open (an object-level write: a CE/AutoCAD reactor, xdata, a layer or settings record). Not the Foundations manager: the BUG-381 proof holds on installed Structural 1.0.96 (open+close of the Foundations manager, Cancel, FREGEN, FREGENALL, FPFC, FDELETE, ERASE, Regenerate All never took DBMOD to 4 or 5; it reached 5 only after the agent's own -LAYER setup lines). Find which object or system variable changes at open (headless probe on a copy, with only Structural loaded, then Civil+Manager loaded). **Status:** OPEN, LOW. Not Tim-facing yet. (BUG-381 proof: PASS in driver run 19; still not Tim-accepted.)

**Driver run 19 result (Structural 1.0.96): 6 PASS, 0 FAIL, 1 BLOCKED (T3 cancelled SFC: the driver cannot send Esc), 1 NOT TESTED (no raft fixture).** SFC/BSFC leave the current layer alone; FREGEN/FST/FREGENALL lines plain; U/REDO every time; OSMODE 5375 throughout. LOW: one pad reads "1 footing, 4 outlines" (Team #593 fixes it). The agent had one wedge of its own making (an ERASE chain one Enter short) and used quit -Kill once: an unclean-exit line in the CE Admin outbox about 23:52 on 3 Oct is expected, not a defect.

---

## BUG-381

**Command / Area:** Structural Foundations manager (FST / Foundations Manager): opening and closing it marks the drawing modified. Desk driver run 18 on installed Structural 1.0.95 (3 Oct, `DRIVER_RUN18_2026-10-03.md`): DBMOD goes 1 -> 5 across open + close, nothing edited. Same family as the Edit Pipe Cancel DBMOD finding (BUG-373, fixed by #581); a read-only window should leave the drawing unmodified. **Status:** OPEN (to Team after run 52; failing test first). Not Tim-facing yet.

---

## BUG-382

**Command / Area:** FST status line (Structural 1.0.95): the plain line still ends with a log tail `elements=4 orphans=0 generated=4 issues=0 reason=PFC:PF4` (driver run 18). Plain-English rule: no log words in user-read lines. **Status:** OPEN, LOW wording.

**Driver run 18 result (desk, installed Structural 1.0.95):** 7 PASS, 0 FAIL, 2 BLOCKED (S7 CESETTINGS window title "CE Settings", driver fix; S10 Save refused by the driver), 1 NOT TESTED (S9 OSMODE watch, superseded by Team's static find #585). PASS: CSREOBAR frozen 35CONT, BWT off 25TEXT, STR both layers one line, CSBARSCHEDULE frozen: plain lines print, layers stay as they were, one U + REDO works every time; FST Kind column "Footing network" / "Pad footing" read-only, no jargon; all three ribbons load. AutoCAD ended by quit -Kill at the CESETTINGS alarm (a TEST kill: one "did not close cleanly" entry about 21:28 in the CE Admin outbox is expected, not a defect).

---

## BUG-380

**UPDATE 4 Oct 06:31:** Confirm LPD (#543) grey vs hide: Tim INT-050, 4 Oct ~07:00, verbatim 'CONFIRM LPD BUTTON - WHATEVER YOU RECOMMEND' (desk reading: GREY with a plain hover reason on the four non-Start tabs, the default as built; no change). #547 (footing drawing conversion): card shown to Tim in chat (INT-049), still HELD until he says approve.

**UPDATE 4 Oct 06:22:** BUG-380 W3-05 FEDIT edge pick: DECIDED by Tim, INT-042 (see BUG-355 item 1 and the card FEDIT-OUTLINE-PICK_CARD_2026-10-04.md). The BLOCKED W3-02 / W3-06 notes stay open. #544 CLOSED unmerged 4 Oct (INT-044, pipe lands on the pit WALL, supersedes INT-030).

**Command / Area:** Codex verifyW3 (3 Oct 19:42-20:49 PC clock, usage 9% -> 12%; `CODEX_VERIFYW3_2026-10-03.md`, evidence `VERIFYW3\`) on installed Civil 3.0.26 / Manager 1.1.26 / Structural 1.0.94: **3 PASS, 1 FAIL, 2 BLOCKED.** Not Tim-accepted.

**PASS:** W3-01 CEMANAGER window with Civil loaded: footer "3 of 3 installed CE tools running · 490 commands ready · AutoCAD 26.0.0.0"; Drawing Repair and Project QA pages do NOT say "CE Civil is not running"; buttons "Send a fault report" and "Send waiting reports" present (not pressed). W3-03 batch Edit 2 Pipes (design grade 100) with real Apply on DWG-B1: IL at the P3 end of 109ED4 18.10 -> 18.19 (the window's preview said IO8 -> P3 downstream 18.10 -> 18.19), 109E23 P3 17.25 held, P2 17.13 -> 17.01; AFTER U 18.10/17.25/17.13 (= BEFORE); AFTER REDO 18.19/17.25/17.01; message "[CE] 2 pipes updated. One Ctrl+Z undoes all of it." plus the pit-schedule cells brought up to date; ONE U undid the whole edit (U echo "CDEDIT"); no Yes/No box. W3-04 Pit Schedule: C1 cover typed 18.80 (F2, Ctrl+A, type, Enter works: the W2-10 typing fault is solved), Revert Row Override: pit stays C1 (not PC1) in the row, on the plan and in the reopened schedule.

**FAIL (W3-05, FEDIT on a strip 50 mm from a pad, mouse):** DIST confirmed the gap 50.0 mm (strip SF1 300 wide). A click on SF1's near outline gave "[FEDIT] That is a CE outline, not a footing. Pick the pad (or its label) instead. Nothing changed." (expected: names SF1); a click on PF1's free left edge gave the same refusal (expected: names PF1); the corner click gave that refusal as expected. DBMOD unchanged (21). **This is BUG-355 item 1 again:** a click on a pad or strip edge always hits CE's generated outline, so the engineer cannot pick the footing by its edge. Tim's rule needed (his words, not mine): should FEDIT resolve a picked outline to its pad/strip (my recommendation: yes, never refuse when the driver is known), or keep the refusal? Gate: FEDIT is a reviewed command: needs the plain question on the desk return page before any code.

**BLOCKED (W3-02, Edit Pipe layer change + Save):** the Edit Pipe window has NO layer box (main page, More... -> Drawing: Drawing preset, IL text, Label layout, Show grade in pipe text, Save as Line only/Line + arrow, Mask behind invert text, Drawing breaks) and the bottom-right button reads "Save" (not "Save pipe and close"). So the C2b "layer change" path of the finalizer list does not exist in this window; what #581 protects is the CLAYER/OSMODE the Save clean-up puts back after a normal Save. Redo as: change the diameter, Save, read CLAYER/OSMODE/DBMOD before and after, one U. (BEFORE was CLAYER "BLOCKS", OSMODE 5375, DBMOD 17, pipe layer "STORMWATER PIPE".)

**BLOCKED (W3-06, CE STRUC ribbon):** read to the end: Beams, Beam Drafting, Beam Sections, Joists & Roof, Footing Schedules, Footings & Piers, Foundation Management, Raft Foundations, Bracing, Annotation Tools, Dimensions & Leaders, Markup, Xrefs, Schedules, Export, Admin Tools, Diagnostics, System, Workspace: none shows STR, BWT or CSREOBAR. NOT readable to the end (menu taller than the 1920x1080 screen and it does not scroll by Down Arrow): Annotate -> Beam & Support Tags, Hatching, Legacy Drafting (Legacy Drafting does show "Reinforcing Bar (two entries)"); two Columns & Footings flyouts did not open. Typed STR works ("Bar size [r10/n10/n12/?] <R10>"). Next: a static read of the Structural ribbon definition lists every button text (no AutoCAD needed), and long Annotate menus that cannot be scrolled are a usability defect worth a plain look (AutoCAD normally shows scroll arrows).

**OBSERVATIONS / NEW:** (1) **OSMODE ended 1151 vs START 5375** (Codex restored it): a CE or test command in the W3 sequence left Tim's running snaps changed (same family as the 30 Sep OSMODE finding); not isolated; next Codex pass reads OSMODE after every item; suspects: FSF/FEDIT/DIST in the Structural group, PITSCHEDULE, Edit Pipe Cancel. (2) After Revert Row Override the row and plan read cover 18.80 (not the drawing's 18.74): and one U (echo "PITSCHEDULE") left the plan label at CL 18.80: unclear whether Revert should bring 18.74 back or only keeps the typed value as the new record; ask the desk. (3) Edit Pipe on 11C807 opened with "Recognised from the drawing's own links. No old-style pipe tag is needed." (fine) and an automatic-save message appears after Cancel (plain AutoCAD). (4) CD_Settings.json LastWriteTime moved at 20:08/20:09 with 'Settings saved successfully' during the two PITSCHEDULE Close actions (content hash unchanged: BUG-306 family, report only).

**Status:** OPEN. Not accepted until Tim confirms.

---

## BUG-376

**Command / Area:** PITSCHEDULE (Pit Schedule): IL (Inlet) and IL (Outlet) blank where the plan shows a level. Driver run 17 (3 Oct ~19:50, `DRIVER_RUN17_2026-10-03.md`, item C9), installed Civil 3.0.26; the Opus #580 review had warned of it (REVIEWLANE_LOG 392).

**Symptom:** on DRV17_B1, Pit Schedule row P3 reads pit P3, 900 x 900, from WT10, DIA (Inlet) 150, **IL (Inlet): blank**, DIA (Outlet) 450, **IL (Outlet): blank**, cover 18.88; the next row "Pit P2, pipe from P3" has dia 450 and IL blank; the plan shows `IL 18.10` at the P3 end of the IO8 to P3 pipe. So the schedule is blank where the plan has a value. Cause per the #580 review: the schedule takes IL from the pipe's stored levels, so older pipes (and pipes whose level is only drawn as text) show blank.

**Wanted:** the schedule falls back to the level the plan shows at that pipe end (the same figure the pipe's own invert text uses) when no stored level exists; never invent a level; if neither exists the cell stays blank with its plain-English reason. Settings-first, no hard block. **Status:** OPEN. Fix to Team build/02 (read first). Not fixed until Tim confirms.

---

## BUG-377

**Command / Area:** a raw `\U+2192` text shows in one warning line (driver run 17, Civil 3.0.26). An escaped arrow code instead of the arrow (or 'to') in a user-read line: find the string, print the plain word. **Status:** OPEN, LOW. Wording; no behaviour change. Not Tim-facing until located.

---

## BUG-378

**Command / Area:** open of a drawing holding old pipes: the FIRST open of the FIX copy and of DRV17_B1 did not upgrade the old pipe polylines ("2 pipe objects"), a later fresh open of the same copy printed "49 pipe(s) upgraded to CE pipe objects" with a backup beside it (51 objects after). C4 was repeated on the upgraded state with the same result. Driver run 17. Cause unknown (the upgrade runs on open/draw/demand: maybe a timing race with the first drawing activation, or the driver's open route). **Status:** OPEN, LOW until reproduced. Next driver session: open once, check the pipe object count at once, then wait 10 s and check again.

---

## BUG-375

**Command / Area:** C-11 finalizer side findings (3 Oct, `TRAIN_C11_FINALIZER_REPORT.md`; train claude/rel-20261015c b73f5ab4, built and unit-tested only, not in AutoCAD).

1. **CE.CommandTruth.Tests has 3 OLD failures (not caused by the train):** the central command register expects 131 rows but the registry has 113; seven Civil commands are not in the registry (CDFIXTAGS, CDGRIPDIAG, CDSETUP, CDUSEPLANLABEL, CDXREFCOMPARE, CDXREFREPAIR, CEBLOCKS); CDNEWDWG is registered on net10 only (by design since 28 Sep). Never run in C-10, so no baseline until now. Needs a small Team item: decide whether the seven belong in the registry and bring register and registry to one list.
2. **`C:\Lisp Files\_CODEX_RUNNER\sweepMG2.txt` is out of date:** it still uses the old Manager button names ("Send Diagnostics", "View Superseded" and others); a sweep run from it will report them missing. Fix the brief before any Manager sweep.
3. **Rule to keep:** no script may start AutoCAD or accoreconsole with `CE_LOG_DIR_OVERRIDE` set; with #573 that would run CE on default Settings with all Manager switches off. Not set anywhere today.
4. **One AutoCAD check for the install:** with Civil loaded, the Manager's Drawing Repair and Project QA pages must not say "CE Civil is not running".
5. **Net48 test-only:** the #577 grade test cannot run without AutoCAD 2024 behind it (125/127 on net48 train classes; the other failure is the known C-10 one). Nothing shows in AutoCAD.

**Status:** OPEN (items 1 and 2 are tidy-ups; not Tim-facing).

---

## BUG-374

**Command / Area:** Codex verifyW2b (restart of the mouse pass, 16:13-17:06 PC, Codex 4% -> 8%; installed Civil 3.0.25 / Manager 1.1.25 / Structural 1.0.94; report `CODEX_VERIFYW2B_2026-10-03.md`, evidence `VERIFYW2B\`): 4 PASS, 2 FAIL, 5 BLOCKED, 0 NOT TESTED. Not Tim-accepted.

**PASS:** W2-04 grip-drag of a PAD corner: ONE kite message ('PF1 is no longer a rectangle in the drawing (a corner moved on its own, a vertex added, a side turned into an arc, or the outline no longer closed), so CE's footing record keeps 600 x 600 ... or type FEDIT to square it at its drawn centre.'), one U echoes 'Grip Edit' and restores pad and outline, REDO brings the dragged shape back, final U restores the square; W2-11 CDDESIGN: the head box is on 'Areas and route' (not Setup); Save Draft closes the window with '[CE] Design draft saved in this drawing.'; reopened field keeps the value; W2-12 New Pit: proposes P8 (450 x 450), 'Enter the cover level.' with Continue placement disabled; 21.00 enables it ('Ready to place the pit.', footer 'CL 21.00'); placed; Esc 'Stopped. Everything placed stays; U takes back the last one.'; ONE U echoes PIT and removes pit, label and cover text together; W2-07 template readings (below).

**W2-07 TEMPLATE UNITS (INT-031, Tim's question: which office templates are UNITS = Metres with mm pits):** all four copies read INSUNITS 4 (millimetres), MEASUREMENT 1, UNITMODE 0: TPL1_C01_VERTICAL.dwg and TPL2_BAYSIDE.dwg contain a pit (block name, scale and width not read: UNCLEAR: LIST asked for objects again), TPL3_TYPICAL.dwg and TPL4_S01_HORIZ.dwg contain NO pit block. So NONE of these four office templates is a Metres template: Tim's 'Yes, some are' (INT-025) is not seen in them; the units mismatch comes from other drawings (his real job drawings: INSUNITS of five real jobs is still to be read: BUG-352-era step 11 of the S-8 checklist). Tell the desk for the return page.

**FAIL (confirmed again): W2-14 Edit Pipe Cancel marks the drawing MODIFIED: DBMOD 17 -> 21** across open, diameter 300, Cancel; both plan labels unchanged ('225 DIA. UPVC PIPE AT 1 IN 100'); Save works: 'Pipe updated.' and '300 DIA. UPVC PIPE AT 1 IN 100' on the selected pipe only; one U echoes CDEDIT and restores 225; an 'Automatic save' message followed the U so no clean autosave-free claim. No Design Warnings dialog. (BUG-373 item: Team build/02 run 49 has it.)

**FAIL/unclear: W2-13 Edit Pit on the 0.001-scaled pit:** the editor reads 600 x 600 mm (the old 0 x 0 fault is gone); width 900 -> 'Pit updated.' and the pit enlarges, but NO P1 label or CL 21.00 appeared near it in the view (distance not measured: label/CL may be outside the zoom); one U echoes CDEDIT and the reopen reads 600 x 600. Needs a look at where the label and cover text are after a scaled-pit Edit.

**BLOCKED:** W2-02 (FSF default width 300 and the LINE gave a 200 mm gap, over the 100 mm limit: fixture needs SF1 about 50 mm from PF1); W2-06 (CE STRUC panels visible; no literal STR / BWT / CSREOBAR label seen in the inspected entries, but three long Annotate menus extend below the screen so absence cannot be certified; typed STR starts 'Bar size [r10/n10/n12/?] <R10>'); W2-08 (batch Apply worked: 'Edit 2 Pipes' preview P3 -> P2 downstream 17.13 -> 17.01 and IO8 -> P3 downstream 18.10 -> 18.19, warning 'P2: P2 -> P1 starts 90 mm above the new pit outlet — it would need lowering.'; Apply: '[CE] 2 pipes updated. One Ctrl+Z undoes all of it.', then 'The pit schedule also had out-of-date cells, now brought up to date from the record'; no Yes/No box; but the plan IL figures were too small to compare visually); W2-09 (no IO8 row; P3 FROM lines IO, WT9, P4, WT4, WT3; the inlet from IO reads 18.19 = the batch's IO8 -> P3 downstream 18.19: consistent); W2-10 (the grid cell would not take typing: input fault: C1 stays cover 18.74; Revert not tested).

**Other:** Civil settings (CD_Settings.json) changed through CE during the run (BUG-306: New Pit writes it); Structural settings files unchanged; OSMODE restored 5375; typed QUIT was unavailable after the command strip disappeared, closed with the Close button; usage 4% -> 8% (over the 3-point guess).

**Status:** OPEN. Not accepted until Tim confirms.

---

## BUG-373

**Command / Area:** driver session 15 (desk, read-only walk of the CE windows on the INSTALLED builds; `DRIVER_RUN15_2026-10-03.md`).

**Passed by reading:** W1-05 (Save Draft on all five Design tabs; Confirm LPD grey on all five with its reason text), W1-07 ('Quiet start after an update' tick exists and is OFF), W1-13 (CETOOLS opens the palette 'CE_STRUC_SUITE' with tabs Home, Sheets, Notes, Checklist, Commands), W1-14 (Foundations manager lists only PF1-PF4). Partly read, rest needs a real Apply/Save by mouse (now in verifyW2 W2-08..W2-14): batch window 'Edit 2 Pipes' (both pipes in it; the Design grade tick box has NO accessible name: click by position), Pit Schedule (no row for the IO8 pipe under P3 visible; IL cells blank to accessibility), C1 cover 18.74 override/Revert, CDDESIGN reopen memory, New Pit (proposes P2; typing 21.00 enables Continue placement), Edit Pit on the scaled pit reads 600 x 600.

**FAIL (LOW-MED): W1-08 Edit Pipe on the modern pipe:** Cancel seems to mark the drawing MODIFIED: DBMOD went 17 to 21 across open, type 300, CANCEL (the pipe and both labels read back unchanged): a Cancel must write nothing and leave DBMOD alone. Check what the window touches on open/Cancel (a transaction commit, a reload, a system variable). Team job (Opus read: undo/save path). Also: no '1 in 100' button on.

**Surprise:** the older-pipe question quoted '150 DIA. UPVC SEWER CLASS PIPE AT 1 IN 70' for the second pipe of the batch (copy only; the chain had already answered Yes).

**Accessibility leaks (BUG-365 leftovers, Team job desk_jobs/build02_job_latest.txt item 11):** the CDDESIGN Design drop-downs read 'CE_CVL_SUITE.ViewModels.DesignLpdChoice' (Approved outlet / Connection type / Job mode could not be read), the 'Design grade' tick has no name, IL cells blank.

**Driver/Codex:** the 'Command search' palette pop-up could not be closed by ui close (3 tries, AutoCAD idle 0.01 cores): Esc closes it (added to verifyW2).

**Status:** OPEN. Not fixed until Tim confirms in AutoCAD.

---

## BUG-372

**Command / Area:** wording, Civil 3.0.25 (driver session 13, same family as BUG-364).

**Symptom:** after a STRETCH or MOVE the command line says 'pipe 11C807 start invert text: no clear spot ... (on "the block PIT BLOCK 3")': a RAW HANDLE and a block name shown to the drafter. Fix: name the pit/pipe ('P8 -> P11', 'pit P11') through the same helper as the BUG-364 line (counts if the names are not known yet); never a handle or a block name.

**Status:** OPEN (LOW). Team build worker (Civil, with other wording items). Not fixed until Tim confirms.

---

## BUG-370

**Command / Area:** driver session 11 on the INSTALLED Structural 1.0.94 (desk, `DRIVER_RUN11_2026-10-03.md`).

**ALL PASS:** UNDO COUNTS: LINE, CSREOBAR, U, U: U1 echoes 'CSREOBAR' (no GROUP; objects 19 to 16, 35CONT gone), U2 echoes the LINE group (16 to 15); bar then CSBARSCHEDULE: U1 'CSBARSCHEDULE' removes only the table, U2 'CSREOBAR'; STR with no 35CONT: ONE U echoes 'STR' and removes stirrup AND the new 35CONT, REDO both back; ERASE a pad + FREGENALL: U1 'FREGENALL', U2 'ERASE' pad back (BUG-368 and BUG-358 FIXED). BUG-367 LAYER PROBES: FROZEN 35CONT before 70=1 62=7, after 70=1 62=7 (bar drawn but hidden, one U removes it; no CE warning); LOCKED 35CONT and LOCKED 25TEXT with STR, RBL, RBC: 'Layer X is locked, so CE drew no stirrup / rebar line / rebar circle. Unlock it and try again.', layer stays 70=4 62=7, nothing added, no 35CONT created (6 of 6); RECOLOURED 35CONT colour 5 stays 70=0 62=5 after CSREOBAR, STR, RBL, RBC (4 of 4). MOVE, U, REDO fine; with the footing layer renamed ('STRIP FOOTINGS' to 'STRIP FOOTINGS OLD') a new MOVE recreated STRIP FOOTINGS with the outlines on it and ONE U removed the move and that layer together. Foundations manager read-only ui scan: 0 jargon, 0 raw handles, 0 unnamed on all four views; rows 'Linked object', no blank row. Both CS_Settings.json unchanged.

**Open:** (1) LOW: the Foundations manager 'Kind' column still shows code words 'FootingNetwork' and 'PadFooting' (plain-English fix). (2) LOW: a FROZEN 35CONT/25TEXT gets a hidden bar with no CE line (suggest 'Layer 35CONT is frozen, so the bar is drawn but hidden.') (= BUG-369 item 1). (3) BLOCKED: the CE palette opens titled 'Command search' with a box named 'Search commands' but the driver could not drive it (title not on its allow-list: desk adds it); grip-stretch of a pad corner needs the mouse (Codex W1). ('Unlinked object' and 'None' not exercised: all four pads linked.)

**Status:** Structural 1.0.94 proofs done; LOW items open. Not accepted until Tim confirms.

---

## BUG-369

**Command / Area:** Structural train S-10 Opus finalizer leftovers (finalizer a07afc661329c1093, branch claude/rel-20261014t d30dc353 GO; report `S10_OPUS_FINALIZER_2026-10-03.md`). None HIGH.

**Decision on the red REDO guard:** SAFE, baseline updated (4 stale lines out, 6 in): #568 moved the footing layer creation into the shared helper; the two footing hooks reach the same create-only write under the helper's name; they refuse U/UNDO/REDO/MREDO/save (StructuralIdleWorkPlanner.cs:48-56, FoundationMonitor.cs:197, 403-406, 260-278, 321-330, 444-467); a layer is written only when the footing layer is missing, inside the same Undo step. **Finalizer fix (test + REGRESSION_LOG):** the shared layer helper looked for the office layer template (a drawing file on OneDrive) BEFORE checking the layer exists: since #568 that ran at the end of every footing MOVE or STRETCH; now an existing layer is answered from the drawing first.

**Open:** (1) LOW: CSREOBAR, RBL, RBC, STR, BWT now leave a FROZEN or OFF 35CONT/25TEXT frozen, as asked: the bar is drawn onto the hidden layer: the drafter sees 'Created ...' and nothing on screen (one U removes it): suggest a plain line 'Layer 35CONT is frozen, so the bar is drawn but hidden.' (2) LOW: about 11 places still create layers with their own code instead of the shared helper (all create-only). (3) NOTE: Foundations manager Override tick box can be ticked but is never saved (before #564 too). (4) NOTE: an edit made inside LISP or a nested command is redrawn at a quiet moment when its drawing is back in front: its own U step; can recreate a missing footing layer (since S-5/S-6). (5) NOTE: a footing layer CE creates now takes the office template's settings, like every other CE layer.

**Driver checks (S-10, 12 steps in the report):** LINE, CSREOBAR, U, U (U1 echo CSREOBAR no GROUP, U2 removes the LINE); bar, CSBARSCHEDULE, U, U; STR with no 35CONT then U (stirrup and layer both go, REDO both back); ERASE + FREGENALL still two U; frozen 35CONT with CSREOBAR (stays frozen colour 7, bar hidden, one U); LOCKED 35CONT then 25TEXT with STR/RBL/RBC ('Layer X is locked, so CE drew no stirrup/rebar line/rebar circle. Unlock it and try again.'); recoloured 35CONT (colour 5) stays; grip-stretch a pad corner then one U; frozen BATTER/LBW probe; MOVE a pad, U, REDO then rename the footing outline layer and MOVE (layer returns, one U removes move and layer); Foundations manager ui scan (0 jargon, 0 unnamed; 'Linked object / Unlinked object / None'; no blank row); CEPALETTE 'Command search'.

**Status:** OPEN (LOW). Not fixed until Tim confirms in AutoCAD.

---

## BUG-368

**Command / Area:** Structural 1.0.93 undo marks (driver session 10).

**Symptom:** LINE, CSREOBAR, U, U: the SECOND U does nothing (the LINE stays; a THIRD U removes it); CSBARSCHEDULE has the same empty extra step = the BUG-358 pattern is still present for these commands (only ERASE + FREGENALL was fixed by #558). Find the shared cause (an extra empty undo mark/group in the command wrapper or the reo bar / schedule path) and add an undo-mark count test per Structural command.

**Not tested:** FEDIT strip-near-pad (#562): the driver cannot give FEDIT a real pick (every pick says 'That is a CE outline...' even on a free pad edge): needs a REAL mouse pick: verifyW1 item W1-19. RBL mark not run (no typed form; the switch is in Tim's Settings). INSUNITS 0 skipped on purpose (it opens a 'Lighting - Insert Units' dialog that blocks the driver for minutes).

**Status:** OPEN (MED). Team build worker job 46 items 16a/16b. Not fixed until Tim confirms in AutoCAD.

---

## BUG-366

**UPDATE 4 Oct 06:31:** Settings Enter question: Tim INT-047, 4 Oct ~07:00, verbatim 'SETTINGS WINDOW - YES' to the desk's wording 'should Enter save the whole window?'. AMBIGUOUS against the older wording: NO change queued; the desk confirms with Tim. (Item stays: keep Enter as built.)

**Command / Area:** desk driver session 8 (typed forms) on the INSTALLED Structural 1.0.92 / Civil 3.0.24 (report `DRIVER_RUN8_2026-10-03.md`, 18 min, clean run).

**PASS:** STR typed: `[CE_STIRRUP] Created R10-200.`, +2 objects (15 to 17), one U takes it back (echo 'STR GROUP'); CSBARSCHEDULE on an empty drawing: 'Bar schedule placed with 0 bar mark(s)... No bars with a bar mark are drawn yet, so the bar schedule is empty.', new 4x6 table, one U 'CSBARSCHEDULE GROUP' removes it; NEITHER CS_Settings.json changed in any chain (same SHA256 and write time).

**FAIL 1: CSREOBAR typed (HIGH to investigate, tool hidden by #440):** the chain (N16 / 3 / 100 / tAndB / 0,8000 / @5500,0 / Yes) failed 4 times (read-only and writable copy): every prompt took its answer, then CE printed 'CE could not draw the reo bar. Nothing was changed.' (no preview line, no bar; the trailing 'Yes' landed at Command: as an Unknown command, i.e. the command ended one answer early); U names CSREOBAR but nothing changes. Either the chain does not match the real prompt order or a real fault in Structural 1.0.92 (a hidden command that no longer works typed). Sonnet a9485eb2920837c54 reads the source (CSREOBAR_FAILURE_READ_2026-10-03.md); a by-hand run is verifyW1 item W1-18.

**FAIL 2: PASTE #550 prints NO line (BUG-342 part 1 still OPEN):** COPYCLIP of 46 CE objects from a Civil drawing and PASTECLIP into a BLANK copy: selection matched (143 -> 189 objects), but CE printed NO line and the Civil log has no [PasteCheck] line: the log says Civil treated the target (no Civil content) as having none and SKIPPED all 1881 handler calls for that paste: pasting pits/pipes into a drawing with NO drainage is silently ignored (the original BUG-342 symptom); the C-9 finalizer's headless INSERT of the same objects DID print the line (different event path). Undo is fine (U, REDO, U: 143, 189, 143). A decision is needed: Civil must stay quiet in Structural drawings (#393), but pasted CE pits/pipes could wake Civil for that one paste and print the CDREPAIR line once. Sonnet adb9cb57682cb9168 reads the gate and options (PASTE_NO_DRAINAGE_READ_2026-10-03.md).

**Other:** the agent re-sent CSREOBAR 4 times after the first failure (against the brief: retry only on a stop-rule trip): harmless.

**Status:** OPEN. Not fixed until Tim confirms in AutoCAD.


**UPDATE 3 Oct 09:30 (Sonnet source read, `CSREOBAR_FAILURE_READ_2026-10-03.md`): CSREOBAR failure = a REAL CODE FAULT in 1.0.92 (the typed chain was RIGHT; a driver/fixture problem is ruled out).** 'CE could not draw the reo bar' is the catch-all at ReoBarService.cs:200; the preview builds its objects (line 145) and sets their layers (743, 762, 767) BEFORE the code that creates the layers runs (157-158): if the drawing has no 35CONT or no 25TEXT layer (the DRV2_S1 test copy probably has neither) the new object is refused, the throw sits before the 'Preview:' line (786) and the trailing Yes lands at Command: (CSBARSCHEDULE creates its layer first, line 241, so it works). Not yet proven (the DWG is compressed): next step (about 5 minutes, driver, copy): read (tblsearch "LAYER" "35CONT") and (tblsearch "LAYER" "25TEXT"); turn on CEADMIN / DEBUG / CETEXT / ON then rerun the chain to read the real exception line '[FOUNDATION-DIAG ...] ReoBar.Place: CSREOBAR failed ::' (NOT CEDEBUG: it rewrites Tim's CS_Settings.json); create only the missing layer(s) with -LAYER N and rerun: the Preview and BM1 lines should then appear. Hidden command (#440), office drawings with both layers probably do not hit it; no test runs the real path (pure rules + source-text only). Fix for the next Structural train (create the layers before building the objects; add a test that places a bar in a drawing WITHOUT the layers): Team build worker. 'worked on 1.0.91' in the driver report is wrong: ReoBarService.cs is new in 1.0.92.

**UPDATE 3 Oct 09:50 (Sonnet source read, `PASTE_NO_DRAINAGE_READ_2026-10-03.md`): PASTE into a no-drainage drawing, THE GATE.** Decided at drawing open, LinkService.cs:1599-1608: DrawingDisciplinePolicy.ShouldCivilBeActive (line 153) leaves Civil off unless the drawing is tagged Civil or its stored CE record has at least one item (IsCeOwned=false = quiet). Five handlers in LinkService.Reactors.cs check CivilQuietMode.IsQuiet and skip (lines 40, 92, 485, 572, 1625): those are the 1881 skipped calls. The ONLY paste wake is IncomingMappingHasCivilObject (Utilities.cs:1122-1144, called from OnBeginDeepCloneTranslation line 1198): it wakes Civil only if a pasted object is a CE_CVL_PIPE_OBJECT or comes from a drawing CE already tracks: a PIT BLOCK CAN NEVER WAKE IT, nor an ordinary polyline pipe. Why the headless INSERT woke and the real PASTECLIP did not: the C-7 fixture's pipes were CE pipe objects; the driver opened DRV1_B1 READ-ONLY and the open-time pipe upgrade skips read-only drawings (PipeObjectUpgradeOnOpenService.cs:99), so its pipes were almost certainly ordinary polylines (inference: one line settles it: (cdr (assoc 0 (entget (handent "109E23")))) before COPYCLIP); on colleagues' PCs the pipe upgrade is HELD, so this paste is silent EVERY time. RECOMMENDED OPTION A, a 'quiet paste catcher': while the drawing is quiet and a paste/insert runs, remember the block references and polylines it adds (memory only); at that command's end run the existing PastedNotInScheduleLine classifier: if it finds real CE pits or pipes wake Civil and print the CDREPAIR line once, else stay quiet. Files: LinkService.Reactors.cs, LinkService.State.cs, LinkService.ForeignClones.cs, LinkService.Utilities.cs, a new pure wake rule in CloneOriginRule.cs, tests; plus one diagnostic log line in the quiet clone callback (settles in one real paste whether the clone event fires). Risk: a Structural drawing receiving real CE pits/pipes is told once and Civil stays awake in it that session; plain geometry or a lone legend block stays quiet (#393 holds); no new undo step; a lone pit with no CE notes and no pipes stays silent under every option if notes do not travel in a real PASTECLIP. BUG-342 part 1 STILL OPEN for pits and ordinary pipes on 3.0.24.

**UPDATE 3 Oct 10:15 (driver session 9, `DRIVER_RUN9_2026-10-03.md`): CSREOBAR FAULT PROVEN.** DRV2_S1 has NO layer 35CONT (nil), 25TEXT exists; with CEADMIN DEBUG CETEXT ON (then OFF; neither CS_Settings.json changed, same SHA256/write time) the exact line was '[FOUNDATION-DIAG Warning] ReoBar.Place: CSREOBAR failed :: Autodesk.AutoCAD.Runtime.Exception: eKeyNotFound' thrown from Entity.set_Layer inside BuildBarEntities, called from ConfirmWithPreview. After creating ONLY 35CONT the same chain printed 'Preview: BM1  3-N16-100 CTS x 5500 LG, TOP & BOTTOM' then 'BM1: 3-N16-100 CTS x 5500 LG, TOP & BOTTOM.' (+3 objects, 15 to 18); one U removed note and mark; U then REDO brought both back; CSBARSCHEDULE with the bar: 'Bar schedule placed with 1 bar mark(s)...', table 5x6, first row BM1|N16|STRAIGHT|5500|6*|52.1*, one U removed the table and left the bar. FIX LINE: create 35CONT/25TEXT before BuildBarEntities (Team build worker job 43 item 12). Verification once installed: the plain chain on DRV2_S1 with NO layer pre-created. Paste #550 still unproven in a real PASTECLIP into a drawing with no drainage until the quiet-paste-catcher build (a typed PASTECLIP is the same command as Ctrl+V: no new information from a key press).
---

## BUG-365

**Command / Area:** desk UI mapping session 7 (3 Oct; `C:\Lisp Files\_ACAD_DRIVER\UI_MAP_SESSION7_2026-10-03.md`): New Pit, CDDESIGN (5 tabs), Settings (6 tabs), Repair Center, Foundations manager (2 tabs + 3 inner), Drawing sheets (first tab), the CE palette (empty state).

**Good:** the PIT chain `PIT\n10000,-90000` opened New Pit with NO spin (session 5's spin was the bare PIT prompt: BUG-361 stays 'driver'); ui click/type worked on real WPF.

**Extends BUG-360 (accessibility / jargon):** unnamed controls: CDDESIGN 37, New Pit 2, Foundations manager 10 check boxes plus unnamed grids/tabs, Drawing sheets 8 input boxes plus tab/grid/group, the CE palette search box, Repair Center's 17 buttons have no ids. JARGON in names: 'System.Windows.Controls.TabItem Header: Content:' (CDDESIGN During tab), 'CE_STRUC_SUITE.Models.FstSizeEntry / FoundationSystemSummary / FoundationElementSummary' (Foundations manager), 'CE_STRUC_SUITE.Models.CeSheetEntry' (Drawing sheets rows), 'Item: {NewItemPlaceholder}, Column Display Index: N' (empty grid cells), bare drawing handles like 43F in the 'Drawing reference' column (Foundations manager). (PR #560 covers Edit Pit, Edit Pipe, Pit Schedule, Inspector only.)

**Other findings:** (a) Settings window: Enter inside a number box SAVES THE WHOLE WINDOW (from source, untested): UX risk: review against the Settings card. (b) Drawing sheets scans the WHOLE FOLDER of the open drawing as it opens (performance on a big job folder). (c) Real window titles: 'Foundations manager', 'Drawing sheets' (not 'FST...' / 'CE Sheets'), the palette has NO title; CDREPAIR opens its window with no question; CDDESIGN asks up to four questions first in a real job folder (chain untested). (d) CE wrote usage records and two FAILURE records into Tim's real TIM_CE_CADTOOLS\CE_Admin\outbox during the session: READ by the controller (read only): both are 'The previous CE CVL / CE STRUC session did not close cleanly' (Category crash, IsCrashInference true, CommandName empty) written at the next start after the driver's kills of AutoCAD: expected noise from the driver, not a plugin crash; but the CE Admin outbox will REPORT these as crashes: tell Tim/desk so the admin view is not misread; and the Civil record carries an ANONYMISED UserName/MachineName (random strings) while the Structural record carries the real UserName 'TimothyBrand' and MachineName 'ADMINISTRATOR': an inconsistency between the two products' telemetry (LOW; privacy rule says Civil's anonymising is the intended one: check Structural).

**Status:** OPEN. Candidates: Team build worker (Structural/Civil names), Settings Enter-saves question for Tim via the desk. Not fixed until Tim confirms.

---

## BUG-364

**Command / Area:** driver session 6 on the INSTALLED builds (Civil 3.0.24 / Manager 1.1.24 / Structural 1.0.92; desk report `DRIVER_RUN6_2026-10-03.md`).

**PASS:** S-05 now TWO U (U1 echoes FREGENALL, U2 ERASE, pad back); S-01 runs 1-3; BUG-357: with the pipe layer locked, a pit MOVE prints exactly the #557 line and both labels STAY "1 IN 100" (the unlocked control still re-words to 1 IN 101: BUG-363 fix in PR #561), one U, REDO works; the half-lock case names only the locked pipe; What's New: first launch only, MODELESS (typing worked with it open); FEDIT on a pad EDGE (typed coordinates, right/left/top): "[FEDIT] That is a CE outline, not a footing. Pick the pad (or its label) instead. Nothing changed." (the 'say plainly' option of #555); a label pick works (U echoes FEDIT); a real mouse pick on the edge is for Codex W1.

**CPU (BUG-361):** idle 0.03 cores; a bare LINE via the LISP vla-PostCommand route = 1.57 cores and cancel REFUSED: the route does NOT avoid the spin (same mechanism: AutoCAD runs the command inside the COM call); no CE frame (second dump read and deleted). Still NOT CE. No driver route can leave a prompt waiting: complete one-line chains only. A human at a PIT prompt is measured by Codex (verifyW1 item W1-17).

**ODD (LOW):** the FIRST locked-layer move after the Civil copy was freshly opened printed "the pipes pipe 11C807 and pipe 11C83E" (raw handles and a doubled word); later opens printed the P names: wording/jargon bug on first use (the handles are not yet resolved to pit/pipe names when the line is built): fix: resolve names first or say 'the pipes' without handles.

**CORRECTION to the C-9 / S-8 finalizer notes:** 'REDO twice' cannot work with plain REDO: after U, U, REDO the second REDO says "REDO must immediately follow the U or UNDO command" (native): the correct form is U, REDO.

**NOT RUN:** typed STR/BWT/CSREOBAR (safe forms being written: `TYPED_FORMS_S8_C9.md`), the ribbon (the driver refuses the main window: registry says hidden:true for STR, BWT, CSREOBAR, CSBARSCHEDULE: ribbon look = Codex W1), the paste line (typed chain being written).

**Status:** OPEN (LOW wording bug). Not fixed until Tim confirms.

---

## BUG-363

**Command / Area:** Civil train C-9 Opus finalizer leftovers (finalizer aabed73056ac8535f, branch claude/rel-20261010a 3cfe9224 GO, no fixes; headless probes on copies; report `C9_OPUS_FINALIZER_2026-10-03.md`, probe runs in C:\ce_rc_probe5). None HIGH.

**Verified:** locked pipe layer: pit P11 MOVEd alone 500 north: pit, label, cover text move, both pipes stay, both labels still "1 IN 100", ONE [CE] line, one U restores, REDO redoes; one pipe locked: the free pipe follows and the line names only the locked pipe; nothing locked = identical to 3.0.23. Batch Apply on DWG-B (grades 54, 75, 100, 200): "2 pipes updated", plan IL = CE's record (IO8 -> P3 18.01, 18.12, 18.19, 18.29), one U each. Paste into an empty drawing: "3 pits and 2 pipes ... run CDREPAIR", no draw-order error. What's New opens without locking AutoCAD, Quiet start switch off by default, old settings load, redirect paths unchanged when the variable is unset; 13,200 -> 13,278 test names, none lost; Drainage 15,268 run 5 known failures; Manager 415/415; train tests on net48 146/146.

**Open:** (1) LOW-MED (already in 3.0.23, same measure): moving an OLD pit COPY (made before CE re-mapped copies, not repaired) rewords the ORIGINAL pit's two pipe labels "1 IN 100" -> "1 IN 101"; those pipes do not move; nothing prints. Fix for the next train: leave EVERY pipe the MOVE did not carry alone, not just pipes on a locked layer. (2) LOW (3.0.23): CHPROP of a pipe to another layer rewords its label 1 IN 100 -> 1 IN 101 with no message. (3) LOW: when the MOVE repair adds a pipe whose own record names the pit, a pipe on a locked layer gets added to the pit's list and the log says it "moved with it" though it stayed. (4) NOTE (C-8): the back-fall warning's arrow printed garbled in the core console: check how it reads in full AutoCAD.

**Status:** OPEN. 10 driver/Codex checks in the report. Not fixed until Tim confirms in AutoCAD.


**UPDATE 3 Oct 15:00 PC (driver session 14, `DRIVER_RUN14_2026-10-03.md`): BUG-363 item 1 FIXED in REAL AutoCAD (Civil 3.0.25, installed C-10).** MOVE of the OLD COPY pit 11C88F alone (0,-500) on OLDCOPY_C10.dwg: the copy went (10000,-83000) to (10000,-83500), the original pit 11C657 stayed at (10000,-80000), both pipes and all nine texts stayed put; BOTH pipe labels (11C80D, 11C844) read '225 DIA. UPVC PIPE AT 1 IN 100' before and after; no CE line; one U echoes MOVE and restores exactly; U then REDO re-does it, labels still 1 IN 100; settings unchanged. Not tested: the same MOVE with the pipe layer locked on this copy + a Pit Schedule read (optional); grip-drag (Codex W1). Nothing accepted by Tim.
---

## BUG-362

**Command / Area:** Structural train S-8 Opus finalizer leftovers (finalizer af12410edd1ae9c48, branch claude/rel-20261011s 3733f3a0 GO, no fixes; report `S8_OPUS_FINALIZER_2026-10-03.md`). None HIGH, none MED.

**Open (LOW):** (1) FEDIT: picking a STRIP footing's edge close to a pad edits the pad (the strip is measured from its centre line, the pad from its edge); the command line names the wrong mark; Escape changes nothing. (2) reo bar units: unset, inch and foot drawings are read as millimetres while the footing schedule converts feet (a bar 2 ft long in a foot drawing reads "x 2 LG"); always shows a warning line and the tool is hidden: settle before CSREOBAR is un-hidden. (3) #553: a raft-only drawing really drawn in centimetres with beam widths typed in millimetres would be read as mm (rare). NOTES: footing commands are now ONE U each so FEDIT's U echo no longer says GROUP; a transparent 'ZOOM in the middle of PEDIT on a bar refreshes its note mid-command; the reo watcher unhooks from a closing drawing through a different handle (harmless); the settings start-up code has no ReoBars line (the reader is null-safe).

**By reading (to drive):** ERASE + FREGENALL is two U now (U1 echoes FREGENALL, U2 ERASE); other commands keep their Undo; STR/STIRRUP/BWT/BARWEIGHT typed unchanged and gone from ribbon, menus, toolbars; CSREOBAR/CSBARSCHEDULE hidden but typed they run; 12 Codex/driver checks in the finalizer report.

**Status:** OPEN (LOW). Not fixed until Tim confirms in AutoCAD.

---

## BUG-361

**Command / Area:** typed `PIT` prompt at 1.5-1.9 cores (desk driver session 5, 3 Oct about 06:03; full dump `C:\ce_rc_dumps\hang_20261003_060341`, 2.93 GB, holds drawing data: never commit/upload, delete after analysis).

**Symptom:** AutoCAD waited at the PIT insertion-point prompt and ran at 1.5-1.9 cores, COM and Esc refused; the driver agent read the hot MAIN THREAD inside CE code: `PitCommand.AskPitInsertionPoint` then `DrawingService.GetPoint`. This CONTRADICTS the 'driver only, no CE busy loop' verdict of BUG-359: if Civil's own GetPoint wrapper spins while waiting for a pick it burns a core at every pick prompt (user-visible lag; possibly Tim's lag). Opus investigator a0340235a761c5841 reopened (cdb on the dump, code of DrawingService.GetPoint and every Editor.Prompt*/Idle subscription; controlled measurement proposal: CPU over 20 s at a bare LINE prompt vs the CE PIT prompt vs CD). Small fix expected.

**Verdict (Opus a0340235a761c5841, 3 Oct about 06:30, dump read in place with cdb + SOS): NOT a CE busy loop; same mechanism as BUG-359.** The busy thread IS the AutoCAD main thread (88.6% of a core; 7 min 47 s user plus 3 min 33 s kernel time). Its stack from the bottom: an incoming COM call (`combase!ReentrantSTAInvokeInApartment`, `OLEAUT32!IDispatch_Invoke_Stub`) = the driver's SendCommand, then `accore!do_cmd`, `CCmdThroat::Run`, `PitCommand.PlacePit`, `PlacePitWithDialogPreset`, `AskPitInsertionPoint`, `DrawingService.GetPoint`, `Editor.GetPoint`, `accore!acedGetPoint` and AutoCAD's own input loop (`AcApAppImp::run`, `SendMessageW`, `NtUserGetProp2`). There is NO CE frame above `DrawingService.GetPoint` in any of the 3 snapshots. Second hot thread: an AutoCAD graphics worker (`acaddm18`, 72%). The code is one `Editor.GetPoint`, no loop, no keywords; there is no DoEvents/Sleep(0)/PushFrame anywhere in Civil, Manager or CE_SHARED. The 4 CE Idle handlers hooked at the time return at once while a command runs; the contextual-tab watchdog was off. Core console (keyboard-input prompts, same fixture copy): Command prompt, LINE and PIT insertion point each 0.01 cores (the console has no window loop or COM, so this does not prove a person's prompt in real AutoCAD). No CE fix, no branch. Confound: session 5's UI-automation scans add window messages to the main thread. **Measurement next (desk, real AutoCAD, 20 s each, no ui calls):** idle baseline; LINE / PIT / CD each started with `(vla-PostCommand (vla-get-ActiveDocument (vlax-get-acad-object)) "<cmd> ")` (not inside COM), then try cancel; last a bare `LINE -Force` via SendCommand with HANG_CAPTURE -NoDump and a 10 s dotnet-trace. Details: report section "Reopened 3 Oct 06:20".

**Status:** investigated: driver mechanism (see BUG-359). Stays OPEN only for the interactive-prompt measurement above. Not fixed until Tim confirms.


**UPDATE 3 Oct 16:35 PC (Codex verifyW2 first run, `CODEX_VERIFYW2_2026-10-03.md`; the strongest lag lead so far):** with Codex's computer-control client attached, AutoCAD idle measured **1.026 cores over 20 s, 1.053 at the PIT insertion prompt, 1.041 at a bare LINE prompt: the SAME ~1 core in every state**; the desk's COM driver at idle (no UI-automation client attached) measured **0.03**. So the ~1 to 1.9 cores seen in the 'wedges' (and probably Tim's lag whenever a screen-control or UI-automation client is attached) is most likely the cost of that CLIENT (accessibility polling/screenshots of AutoCAD's WPF windows and palettes: CE Inspector, ribbon, CE palettes), not a CE loop and not the prompt. TEST TO RUN after verifyW2b (clean attach/detach, desk driver): idle AutoCAD with nothing attached (CPU 20 s), then attach `ui windows` / `ui tree` polling (CPU 20 s), then detach (20 s), then close CE Inspector / hide CE palettes and repeat; if the cost drops with the palettes hidden, the fix is in what the palettes expose to accessibility (AutomationPeers) or poll. Not CE busy loop until that test says otherwise. The 'Command search' palette could not be closed by ui close (Esc closes it).

**UPDATE 3 Oct 17:20 PC (desk driver run 16, `DRIVER_RUN16_CPU_2026-10-03.md`, clean attach/detach test on DRV1_B1):** idle AutoCAD with the driver lock held is about 0.05 cores; one `ui windows` call does not raise it and nothing stays raised after it returns; a looped `ui scan "CE Inspector"` every 13 s raised it to about 1.1 cores while each scan ran (readings 0.4 to 0.7). So a polling screen-reader costs about 1 core while it reads and nothing when it stops. Together with the Codex reading (1.03 cores idle while computer-control was attached) the lag lead is: a screen-reading client that polls, not CE. Codex's own computer-control was not attached in this test (untested separately). Tim's PC: if he ever runs a screen-reader or computer-control client beside AutoCAD, detach it when not in use.

---

## BUG-359

**Command / Area:** the two AutoCAD wedges of 2-3 Oct (Opus investigator a0340235a761c5841, report `HANG_INVESTIGATION_2026-10-03.md`; capture checklist `C:\Lisp Files\_ACAD_DRIVER\HANG_CAPTURE.md`).

**Verdict: caused by the test DRIVER, not a CE busy loop. 3 Oct 06:30 update: CONFIRMED by the BUG-361 dump.** The 1.4 to 1.9 cores is AutoCAD's own point and keyword input loop running nested inside the driver's COM SendCommand call (main thread), plus AutoCAD's graphics workers; CE code sits only as the command that asked the question. Earlier wording "the 1.4 to 1.5 cores while AutoCAD waits is unexplained" is superseded (3 Oct 06:30). Wedge 1 (01:43-01:58, Civil 3.0.22): a bare LINE typed through COM SendCommand waited for a point; last Civil log line 01:43:14; Structural's one-second timer still ran at 01:53:27 (main thread alive). Wedge 2 (03:51-03:56, 3.0.23): AutoCAD's command log shows only "Command: CDCHECK"; CDCHECK's FIRST step is a question ("show all connections, problems only, or save as CSV [All/Problems/Csv]") so it was waiting for an answer; the scan (no [PERF] CDCHECK.PipeEndReview line) never started; COM refused every call; quit later logged CommandCancelled trigger=CDCHECK. Ruled out: CDCHECK slow (250 ms, then 109 ms on 225 objects in the core console). Weak: graphics/Windows.

**Fix list (the desk owns the driver):** take CDCHECK and CDHELP off the 'finishes by itself' list; treat a 'pending' type result as the alarm (no cancel: it is always refused; run HANG_CAPTURE.md, then quit -Kill); consider AcadDocument.PostCommand instead of SendCommand (exists in the 2027 interop; untested). Experiments: E1 (bare LINE with -Force on C:\ce_rc_drv\DRV2_S1.dwg, wait 60 s, HANG_CAPTURE steps, quit -Kill: settles what burns 1.5 cores), E2 (the same with PostCommand: expect an immediate return, near-zero CPU, cancel works).

**Side findings (carpark):** (1) CDCHECK saves its full list into the REAL %APPDATA%\CE_CVL_SUITE\logs even in a headless test setup (the investigator's console run put one file there; moved aside): a Civil log/report path not under the CE_LOG_DIR_OVERRIDE redirect (LOW; C-8 redirected the ledger and CDRULES/CDCHECK report folders: this may be a different path: check). (2) The driver's quit cleanup deleted AutoCAD's own command log of wedge 2 (capture script now copies logs first). (3) HANG_CAPTURE.md: cdb from the installed WinDbg writes a full dump in about a minute; the comsvcs MiniDump route was NOT tested on purpose (Defender flags that command line as credential-theft technique).

**Status:** closed as 'driver' (confirmed 3 Oct 06:30 by the BUG-361 dump), open LOW items above. Driver fix: send commands with PostCommand, not SendCommand (measurement in BUG-361 first).

---

## BUG-358

**Command / Area:** desk driver run 2 on installed Structural 1.0.91 / Civil 3.0.23 (3 Oct, report `DRIVER_RUN2_2026-10-03.md`).

**PASS:** S-06 (locked schedule layer: FREGENALL "The footing schedule is on a locked layer, so it was not updated."; FSTEXPORT "The footing schedule is on a locked layer (25TEXT), so CE left it as it was..."; layer stays locked; unlock + update drops the column); S-07 (a)(b) (FREGENALL ok=1 for the Structural copy, ok=0 for the Civil copy after close/reopen/switching: footings do not carry over); C-03 and C-04 on the MODERN fixture (pit layer stays locked, one U puts everything back, unlocked control fine).

**FAIL S-05 (Structural, MED):** ERASE pad PF4 then FREGENALL: the schedule updates (table 5 to 4 columns, one U puts the table back) BUT TWO U do not bring the pad back: the second U prints NOTHING and the pad and outline stay erased; a THIRD U echoes ERASE and restores everything (the design says two U): an extra silent undo step in the ERASE + FREGENALL ladder.

**Other findings:** (1) locked-layer wording differs between real AutoCAD and the console: real AutoCAD pit+pipe MOVE with the pit layer locked printed 'a downpipe or other CE block ... a MOVE of that block will NOT carry the pipe'; a pipe-alone MOVE printed 'pit P8's own record' and 'a pit MOVE still carries the pipe'. (2) pit+pipe MOVE with the pit layer locked leaves the pipe MOVED 500 and DETACHED from both pits (quoted in the report): check whether the pipe-follows-pit protection should refuse the pipe move too (native locked-layer protection applies only to the locked pit). (3) S-07(c) blocked (a blank drawing is not a test copy for the driver); C-02 blocked (ARRAYRECT chain). (4) BUG-357 (silent grade change, pipe layer locked, pit MOVEd alone): NOT RUN, see below.

**THE HANG (second wedge, HIGH to investigate):** a baseline CDCHECK on the freshly reopened modern fixture FIX_MODERN_PIPE.dwg ran 4+ minutes at about 1.5 cores, COM refused cancel, the Civil log went silent right after CDCHECK started; the agent killed AutoCAD. First wedge (2 Oct night, 3.0.22): after a bare LINE at a prompt, about 15 min at about 1.4 cores, a Civil drawing with CE Inspector docked. SAME SIGNATURE (about 1.4-1.5 cores, UI and COM unresponsive, Civil log silent): possibly a real Civil busy-loop (Inspector refresh, Idle handler, reactor) and possibly Tim's lag. Opus investigator a0340235a761c5841 running (report `HANG_INVESTIGATION_2026-10-03.md`, plus `HANG_CAPTURE.md` for the next wedge).

**Status:** OPEN. Not fixed until Tim confirms in AutoCAD.

---

**UPDATE 3 Oct 04:25 (driver run 3, REAL AutoCAD, DRIVER_RUN3_2026-10-03.md): BUG-357 REPRODUCES.** Modern fixture, pipe layer STORMWATER PIPE LOCKED, pit 11C657 MOVEd alone 500 mm north: pit and cover text move, BOTH pipes stay behind (correct, native protection), the command line prints ONLY the MOVE prompts (no CE line), and BOTH pipe labels silently change from "1 IN 100" to "1 IN 101" (positions, all four inverts and cover levels unchanged; Civil log "pipes relinked", no grade line); one U restores everything including the 1 IN 100 labels; REDO brings back exactly the moved state. Nothing protected is written; the label re-words with NO message. Fix per R-27 (one plain CE line, no block, no Tim question): Sonnet a75c9f31ca51a3cf6, branch claude/c9-pit-move-locked-pipes-line.

**UPDATE BUG-358 S-05 U ladder (exact):** U1 echoes "FREGENALL GROUP" (table back to 5 columns, pad still erased); U2 echoes NOTHING, UNDOMARKS stays 0, nothing visible changes (Civil log: only a project reload, no object writes); U3 echoes "ERASE" (pad, outline, table all back): three U with one empty step in the middle: needs a CODE READ of CE's undo handling around FREGENALL (the empty U2 is probably a begin/end undo-mark pair or a reload that opens its own undo group). Candidate for the Team build worker (Structural, base origin/claude/rel-20261008u 3d83cde1; NO Opus-free: Undo path: Opus review required). Also: no wedge in 3 sessions of about 40 commands without CDCHECK or a bare LINE.

---

## BUG-357

**Command / Area:** modern-pipe fixture job (Sonnet a43d8cd6fb3475128, headless on copies, 3 Oct; report `FIXTURE_MODERN_PIPE_2026-10-03.md`), installed Civil 3.0.23.

**Fixture:** `C:\ce_rc_fix\FIX_MODERN_PIPE.dwg` (+ `_b`): copy of DWG-B1 with pits P8 (11C555), P11 (11C657), P12 (11C758) placed by CE's own PIT placement and pipes 11C807 (P8 -> P11) and 11C83E (P11 -> P12) drawn by CD's pipe service; layers STORMWATER PIT / STORMWATER PIPE; a fresh console read-back matches each pipe exactly once in the project record.

**Findings:** (1) the 109E23 refusal ("does not match a single pipe in the project record") is the legacy-pipe case: the pipe carries an identity key in the drawing but its project-record row has none; ALL 49 pipe rows in DWG-B1 and DWG-B have no key, so no existing test copy can reach the locked-layer line (the fixture above does). (2) On the modern pipe a MOVE on a LOCKED pit layer prints the right line (`[CE] Layer "STORMWATER PIT" is locked, so CE left pit P8's own record as it was ... CE never unlocks a layer. Do not draw the pipe again: once the layer is unlocked, a MOVE of the pit still carries the pipe and puts it on the pit's list.`), the locked pit and its label and cover text do not move, the layer stays locked (flag 4), U and REDO work; LOW: the line names pit P8 (the pipe's far end), not the pit that was moved. (3) SUSPECTED BUG, MED, to measure in real AutoCAD: pipe layer LOCKED and a pit MOVEd alone: the pit moves and the pipes stay behind; nothing is printed on the command line, yet CE's log says the pipes were relinked and their grade changed (a silent grade change on a locked pipe layer; native protection kept the pipe geometry still, but CE changed the record).

**Status:** OPEN (3 = MED to confirm). Driver plan updated with the exact one-line commands. Not fixed until Tim confirms.

---

## BUG-355

**UPDATE 4 Oct 06:22:** BUG-355 item 1 (FEDIT edge pick): Tim INT-042, 4 Oct 06:30, verbatim 'fedit yep click outlien edit': a click on a pad/strip OUTLINE edits that pad/strip. DECIDED. Command card written: 04_REFERENCE/ux-plan/cards/FEDIT-OUTLINE-PICK_CARD_2026-10-04.md; Team builds from it (BUG-380 is the same item).

**Command / Area:** findings of the first driver run on the INSTALLED Structural 1.0.91 / Civil 3.0.23 (desk's Sonnet driver, 3 Oct 02:30 to 03:03, report `DRIVER_RUN1_C8_S7_2026-10-03.md`; 4 PASS, 3 FAIL on one expectation each, 5 BLOCKED).

**PASS:** S-01, S-02, S-03 (Structural 1.0.91: pad MOVE / STRETCH then U and REDO bring back pad AND outline together) and C-01 (Civil 3.0.23: pit MOVE, U, REDO; pipe end and cover text follow).

**Findings:** (1) MED/LOW (Structural UX): FEDIT, picking the pad's right EDGE, says "Selected entity is not linked to a foundation system": the pick hits CE's generated OUTLINE REGION on the edge, not the pad; picking the label text worked, drawing unchanged. FEDIT should resolve a picked generated outline to its driver (or say "that is a CE outline: pick the pad"). (2) C-03 / C-04 (locked STORMWATER PIT layer): pit stayed put, layer stayed locked, U restored all; but CE did NOT print the expected locked-layer line: it printed "Pipe 109E23 in the drawing does not match a single pipe in the project record" for a plain pipe-only MOVE, locked or not (the unlocked control printed the same): probably the test copy's 109E23 is the legacy-version pipe with no project-record entry: needs a modern pipe fixture before it is called a bug. (3) S-05/S-06 partial variants printed the right lines: "PF4 was erased; type FSTEXPORT to update the footing schedule." and with 25TEXT locked "Layer 25TEXT is locked, so CE did not redraw footing system Footing Network (nothing was unlocked or changed). Unlock it and type FREGEN." (good). (4) BLOCKED: S-07 and the rest because the driver refuses bare ERASE / FREGENALL / FSTEXPORT (allow-list being added); C-02 ARRAYRECT chain.

**Status:** OPEN (observations). Re-run S-05, S-06, S-07, C-03, C-04 after a modern pipe fixture. Not fixed until Tim confirms.

---

## BUG-356

**Command / Area:** Manager "Creative Engineering | What's New" window after an update.

**Symptom:** at the FIRST AutoCAD start after each install the What's New window opens MODAL and disables AutoCAD until it is closed by hand: COM and any automation (the desk's driver, Codex) are blocked (the driver `launch` reported FAILED after 4 min until the agent closed the window). A drafter sees it too once per update. Fix idea: show it non-modal (or as a palette), and add a Settings switch for quiet first run for test/automation runs (Settings-first R-00; cockpit rule: quiet unless one decision).

**Status:** OPEN (LOW-MED). Candidate for the Team build worker (Manager). Not fixed until Tim confirms.

---

## BUG-354

**Command / Area:** AutoCAD start-up history line `[CE_StrucPlus] LISP not found: C:\ProgramData\Autodesk\ApplicationPlugins\CE_STRUCPLUS.bundle\Contents\CE_StrucPlus.lsp` printed at EVERY AutoCAD start (found by the desk's driver session 3 Oct; source traced by Sonnet a90e2f6d61813b1f8).

**Root cause:** NOT in this repo. The line comes from `C:\Users\TimothyBrand\AppData\Roaming\Autodesk\AutoCAD 2027\R26.0\enu\Support\ce_suite_startup.lsp` (dated 22 Jul), loaded by `acad.lsp` in the same folder; `s::startup` runs `ce:load-strucplus-lisp`, which looks for the retired CE_STRUCPLUS bundle. It was written by an old `Install-CESuiteAutoload.ps1` that is not in this repo; no installed bundle ships the text; a copy also sits under `...\AutoIsolate\AutoIsolate3\Roaming\Support\`.

**Symptom:** a harmless start-up line (LOW). Cleanest fix: delete the `(ce:load-strucplus-lisp)` call in `s::startup` (the comment there says legacy startup routes are retired); or remove the file and the `(load "ce_suite_startup.lsp")` line in `acad.lsp`. Tim's PC profile file: the desk decides; colleagues' PCs may carry the same file: check at rollout.

**Status:** OPEN (LOW), nothing changed. Not fixed until Tim confirms.

---

## BUG-353

**Command / Area:** C-8 Opus review leftovers (Opus a34208ea7350930ed, PR #548 claude/c8-probe-fixes d2b393f7, verdict GO, 3 Oct; report `C8_OPUS_REVIEW_2026-10-03.md`). None HIGH.

**Open:** (1) MEDIUM (already in 3.0.22, now hit more often because batch Apply works): Edit 2+ pipes on IO8 -> P3, whose end sits 549 mm from P3 so CE cannot tie it to the pit: the plan level becomes about 18.29 but CE's record and the Pit Schedule keep 18.10 (= BUG-351 item 1). Fix first in the next Civil train. (2) LOW-MED (same on 3.0.22): a level typed in the Pit Schedule leaves the pipe label's grade old: P3 -> P2 still reads 1 IN 193 while its levels give about 1 in 136; Tim's question (b) (BUG-351) covers EVERY pipe, not only fixed-grade pipes. (3) LOW: after an associative ARRAY, erasing the array leaves C1's label, CL text, band and schedule row with no pit under them; the ARRAY line should say "Press U, or EXPLODE the array and run CDREPAIR". (4) LOW (code reading, not measured): an ARRAY of a perimeter drain still erases its PD text. (5) LOW (code reading): typing the Settings standard grade can still be refused on a long pipe whose levels already give within 0.5 of that grade (batch rolls back, nothing damaged). (6) LOW: Revert override no longer refreshes a plan label whose diameter differs from an unchanged record diameter. (7) The two SourceAtomicCoordinatorDependencyTests 'known failures' the builder reported are NOT real (24/24 pass in Release): take them off the known-failures list; Drainage known failures stay the 5 accepted.

**Verified by the reviewer (headless, copies):** grades 54, 68, 75, 100, 193, 200 all Apply with one U; no Yes/No box in 7 batch Applies (single Edit Pipe still asks); back-fall warning after Apply (280/190/160/90 mm at 1 in 54/68/75/100); ARRAY of pit C1 + pipe keeps label, CL text, band, schedule row, one U/REDO each; real ERASE afterwards still cleans up; Pit Schedule outlet 17.30 lands on plan and record (3.0.22 left the record at 17.25).

**Status:** OPEN. Codex checks: the six in the PR body + read P3's inlet after batch Apply on IO8 -> P3 (18.10 or 18.29?); ERASE the array: labels left with no pit?; row P3 outlet 17.30: label still 1 IN 193? Not fixed until Tim confirms in AutoCAD.

---

## BUG-352

**Command / Area:** Structural train S-7 Opus finalizer leftovers (finalizer ae5b3fe43e220490a, branch claude/rel-20261008t 76403ba2 GO; report `S7_OPUS_FINALIZER_2026-10-03.md`). None HIGH.

**Fixed in the train:** closing a drawing now always forgets its footings (PR #511 changed 2 of 3 forget sites; the S-5 close site could forget nothing if AutoCAD had already taken the drawing off its open list, so the next drawing opened could be handed the closed drawing's footings).

**Open:** (1) MED: raft-slab-only drawing whose UNITS say centimetres or inches but drawn in millimetres: a 300 beam shows as 3000 (cm) or 7620 (inch) in the footing and R.C. beam schedules; an automatic update (FREGEN, FDELETE) rewrites a placed schedule that way with no units line (1.0.90 kept 300). Cause: the "every footing is 1.5 m or more across" check counts pads and strips only. Fix to decide: count raft beams too (the reason to leave rafts out went away once the check was limited to cm/inch drawings). Small Sonnet fix for the next train. (2) LOW (speed, not measured): after a big MOVE, CE checks AutoCAD's list of open drawings twice per moved line before redrawing; MOVE ALL in a large job may be slower. (3) LOW: a schedule column the drafter widened is remembered by position; when a mark leaves the table another mark gets the wide column. (4) LOW (speed): FADOPT now checks every text on other layers: slower in drawings with a lot of text. (5) NOTE: a drawing started from AutoCAD's default template (UNITS inches) but drawn in millimetres now refuses every footing DRAWING command with advice to set UNITS (1.0.90 asked Yes/No instead).

**Status:** OPEN. Codex checks (35 steps) are in section 5 of the report and feed verifyC8. Not fixed until Tim confirms in AutoCAD.

---

## BUG-351

**UPDATE 4 Oct 06:31:** BUG-351 (b) typed Pit Schedule level on a fixed-grade pipe: Tim INT-046, 4 Oct ~07:00, verbatim 'BUG 351B - ONLY CHANGE THAT END' (desk reading: the typed level changes ONLY THAT END of the pipe, as it works today; no behaviour change). DECIDED. Optional if cheap: the pipe label (keeps 1 IN 100 while the levels give about 1 in 67) shows the achieved grade or a plain note: warn, do not block. (a) was decided earlier (INT-045: pit numbers stay as typed).

**UPDATE 4 Oct 06:22:** BUG-351 (a): Tim INT-045, 4 Oct 06:30, verbatim 'pit numbers , yes' (desk reading: pit numbers stay exactly as typed; typing C2 keeps C2, not PC2). DECIDED. To Team: stop the PC prefix on a typed new pit number; small, test first. Item (b) still unanswered.

**Command / Area:** C-8 builder leftovers and questions for Tim (Opus builder ab3dca0d34ffd4f33, PR #548 claude/c8-probe-fixes d2b393f7, 3 Oct).

**Open (not fixed):** (1) record keeps the old level on an UNCONNECTED pipe end: IO8 -> P3 ends 549 mm from pit P3; when saved, the plan and the pipe get the new downstream level but the record keeps 18.10 (already in 3.0.22). (2) non-associative ARRAY says CE "could not give 2 copied pit(s)/pipe(s) their own number". (3) the ledger folder of CE_CVL_SUITE was not covered by the test log redirect (a full Drainage test run wrote 255 lines, 53 KB, into Tim's live suggestions.jsonl; cut back to its previous content; the ledger and CDRULES/CDCHECK report folders are now in the redirect in #548). (4) BUG-350 items 7-11 stay carpark (Team worker has 7 and 9).

**QUESTIONS FOR TIM (plain):** (a) typing a NEW pit number such as C2 in the Pit Schedule still renames the pit to PC2 (the old "P" rule); recommend: keep the number exactly as typed. (b) a level typed in the Pit Schedule on a pipe with a FIXED grade changes only that end: the label keeps "1 IN 100" while the levels now give about 1 in 67 (how schedule edits have always worked); the alternative is to move the far end to keep the grade as Edit Pipe does. Which does Tim want?

**Status:** OPEN. Opus review of #548 running (a34208ea7350930ed). Not fixed until Tim confirms in AutoCAD.

---

## BUG-350

**Command / Area:** headless probe of the INSTALLED Civil 3.0.22 / Manager 1.1.22 and Structural 1.0.90 (Opus probe aad6fbb1490a9442b, 2 to 3 Oct, accoreconsole on copies; report `PROBE_C7_S6_2026-10-03.md`).

**Symptom:** (1) HIGH (fixed on origin/claude/probe-fixes-c7, not installed): Pit Schedule edit then Revert override silently renames a pit whose number does not start with P: pit C1 became PC1 on the label, the record and both pipes' From/To, no message. (2) MEDIUM, the C-7 batch fix still fails on the real route: Edit 2+ pipes Apply is refused ("did not retain the accepted Design grade", rolled back, nothing damaged) for almost every grade (on pipes 109E23/109ED4 only 1 in 54, 68, 75 passes: 3 of 351 between 1 in 50 and 1 in 400); a typed grade equal to Settings' standard (100) also fails; the label shows the ACTUAL grade from 2-decimal levels, the readback (PipeEditCommand.Batch.cs 1368-1369) demands the typed number. (3) MEDIUM: a "Recalculate downstream inverts?" Yes/No box pops up INSIDE batch Apply (once with Only these pipes, three times with Carry downstream); without an answer the console waits forever (PipeEditCommand.Update.cs 1849-1856, no batchOwnsOuterBoundary check). (4) MEDIUM: no back-fall warning in "Only these pipes": grade 75 leaves the pipe from P3 arriving 140 mm below where the pipe leaving P2 starts, silently (the warning exists only in the carry plan). (5) MEDIUM (= BUG-347, confirmed): an ARRAY of a pit plus its pipe is handled as ERASE: "The pit was erased and the schedule is updated. 4 pipes now have ends that are Not connected yet", the pit label, CL text and pipe band are deleted and the pit leaves the schedule; U and REDO put all back. (6) LIKELY HIGH, needs Codex on a real CD pipe: schedule invert edit + Revert override on a grade-held pipe: drawn level text 20.05, record 20.00; in a metre copy the hold line says the label was left alone though the text changed. (7) LOW: batch Apply refreshes unrelated linked cells (lid "Class A Grated Lid" gets "\PWith Step Irons", row P3 inlet From WT10 -> IO) without a line; one U puts them back. (8) PIT always draws at scale 1 (mm size) whatever UNITS says (PitCommand.cs 343-348), so every UNITS-Metres drawing using PIT is "mixed units" to CE; in a true metre drawing CE's own pipe service puts level texts hundreds of metres off and on the wrong ends and Edit Pipe reads the levels swapped (MEDIUM, Codex to confirm). (9) LOW: paste into a drawing with no drainage: the "run CDREPAIR" line counts pipes only, not pits; eNotInBlock in the draw-order step after a paste. (10) 11 of 13 DWG-B pipes are "older pipes": CDEDIT and the batch refuse until each label is confirmed one by one; Carry downstream stops at the first. (11) HeadlessProof U5 checks pass 2 arguments to TryCollectPipeData which now has 3 (LOW tooling).

**Passed:** CDFIXFLATPIPES (mm lists nothing; metre copy list, Enter nothing, Yes fixes, ONE U; wrong-way pipe "check by hand"); Structural S-6 footings (outline follows the line, one U, kite once, SCALE once, note survives save/reopen); mixed-units hold line with no "1 IN 100000"; batch ONE undo step when Apply succeeds; Carry downstream preview takes the lowest arrival and lists unselected arriving pipes.

**Status:** OPEN. Items 1-6 and PR #543 are in Opus builder ab3dca0d34ffd4f33's train C-8 (branch claude/c8-probe-fixes, base rel-20261006d). Items 7-11 carpark. Not fixed until Tim confirms in AutoCAD.

---

## BUG-349

**Command / Area:** Structural 1.0.90 (installed; S-5 finalizer + six S-6 commits): independent Opus review, 3 Oct (a62943906b10cf1da, `S5S6_OPUS_REVIEW_2026-10-03.md`). Verdict FINDINGS, none HIGH; no fix branch from the review.

**Symptom:** (1) MED, not measured: type OPEN or NEW in drawing A, go back to A: the first footing MOVE of a pad needs TWO U and the first U puts back only the outline (the per-drawing command counter stays stuck at 1; FoundationMonitor.cs 286-290, 188, 412-414). (2) MED-LOW: ERASE PF3, FSTEXPORT refused (schedule on a locked layer or several schedule copies), unlock, PFC + Escape: the schedule still lists PF3 and nothing says so (the note is thrown away: FoundationScheduleService.cs 256, 265-269, 291-295, 182). (3) LOW-MED: CSLOADPATH records a resize without updating the schedule or setting the note (FoundationService.LoadPath.cs 74). (4) LOW-MED: FEDIT on a pad whose line got an extra vertex squares it at the average of five corners and moves a 600 pad 60 mm sideways; wording says "corner grip" for any non-rectangle (FootingGripPlanner.cs 176-181). (5) LOW-MED, side effect of the S-6 design: a script or LISP that does MOVE of a pad then QSAVE then CLOSE may save the line moved with the OLD outline and record; the next footing command repairs it, a PUBLISH before that plots the old outline. (6) LOW: FEDIT changes the line before the redraw refuses a locked label/outline layer (half done until unlock + FREGEN); a LISP error may leave the LISP count stuck; most S-6 tests check wording not behaviour; the 2022-2024 lane skips all 104 footing fixtures (compile-only proof). Also: tests are still writing into Tim's live TIM_CE_CADTOOLS\logs\ce_struc_structured_20261003.log (see BUG-348 hygiene; builder job B adds the env-var redirect).

**Sound (checked):** the command count cannot go negative; nothing written after U/UNDO/REDO; the note stays inside the drawing's own record (copies and COPYCLIP do not carry it); nothing unlocks a layer; Escape at FEDIT writes nothing; mm unchanged.

**Status:** OPEN. Items 1-4 are being fixed on claude/s7-s5s6-review-fixes (Opus builder a0c2f39c9169b2911, draft PR, base rel-20261005s) for the S-7 train; item 5 is a design note only. Not fixed until Tim confirms in AutoCAD.

---

## BUG-348

**Command / Area:** S-7 PR #542 Opus review (head a688403a; fixes on claude/s7-opus-fixes b9cedb2f + e2c011a6; report `S7_OPUS_REVIEW_542_2026-10-03.md`). Verdict MERGE-WITH-FIXES. Tim's INT-026 ("Convert units automatically") is met for the three SCHEDULE commands only; every footing DRAWING command holds with one line (nothing drawn).

**Fixed on the Opus branch:** hold lines no longer tell the drafter to "set units to Millimetres" as the only way (UNITS does not rescale what is drawn: a metre-drawn 600 pad would draw 600 m wide); now "If the drawing is really drawn in millimetres, set its units to Millimetres (UNITS) and run it again"; unknown-INSUNITS wording; CE log line wording; stale comments; Enter-means-No tests restored.

**Open (not fixed):** (1) MED: a drawing set to centimetres but drawn in millimetres with footings under 1 m is not detected (600 reads as 6 m, under the 10 m threshold): CSFOOTINGSCHEDULE lists "6000 x 6000" with the "converted" line; an automatic schedule update after FDELETE/FREGEN/MARKSRENUMBER/FST (no units check) rewrites a correct "600 x 600" to "6000". Suggested follow-up: also treat "every CE footing is 1.5 m or more across" as millimetre evidence. (2) LOW: true metre drawing, a strip/raft beam adopted on 1.0.90 took its width from the label in mm, trips the 10 m check, schedules hold (safe); an automatic update shows pads as "1 x 1" as before. (3) LOW: the schedule command's record check can redraw a footing restored by OOPS; a missing label is then made at mm height/offset in a metre drawing. (4) LOW: the 10 m check reads the stored footing list before the drawing is re-checked: an AutoCAD-ERASEd footing can still count (errs towards holding). (5) Codex wording: "UNDO has nothing to undo" is wrong; U names the held command and changes nothing. (6) Test hygiene: the review's test runs appended about 13 KB to Tim's live Structural log ce_struc_structured_20261002_004.log (earlier content intact; today's logs copied to S7_OPUS_REVIEW_542_LOGS): same class as the memory note tests-can-touch-tims-real-files; the Structural test suite writes to the live log folder.

**Status:** OPEN. Not fixed until Tim confirms in AutoCAD. PR head has since moved to 2d4a330f: the stage-2 assembler must merge the head and then claude/s7-opus-fixes and an Opus confirm follows.

---

## BUG-347

**Command / Area:** Codex combined pass verifyC7 on installed Civil 3.0.22 / Manager 1.1.22 / Structural 1.0.90 (2 Oct 15:35 to 17:22; report `CODEX_VERIFYC7_2026-10-02.md`; Codex 80% to 87%). Result: PASS 1 (VC7-22 strip footing: locked 25TEXT STRETCH gives ONE line and no unlock; unlock + FREGEN gives one outline; TRIM with 'Z completes, outline follows), FAIL 0, BLOCKED 20, NOT TESTED 1. No product fault proven; every block was fixture or input.

**Observations to follow up:** (1) the Structural palette did not open from a click on the CE STRUC ribbon tab (App Manager ribbon stayed visible); that blocked VC7-01..07: next Codex brief must open the palette by a TYPED command, not a ribbon click, and the controller should name that command. (2) DWG-B1 pipe 109E23 asks "This pipe was drawn with an older version of CE. Is the highlighted text ... this pipe's label? [Yes/No] <Yes>" on CDEDIT: fixture needs the legacy-upgrade question answered once (Yes) before the batch retest; check the question is the intended one on a pipe the 3.0.22 build already upgraded ("49 pipe(s) upgraded to CE pipe objects" was printed at open). (3) VC7-16 associative ARRAY of a pit + pipe: "[CE Civil] The pit was erased and the schedule is updated. 5 pipes now have ends that are Not connected yet. U restores everything." printed after the array (a pit was not erased by an ARRAY; check whether ARRAY replaces the originals with associative copies and CE reads that as an erase); CDCHECK after it: 206 objects, 173 connections, 4 Unresolved. Same family as BUG-342 item on ARRAY. (4) PIT and the New Pit window need a cover level: the fixtures METRE-A/METRE-C need supplied cover levels. (5) VC7-10: DWG-B1 and DWG-A have no repairable open-end pipe (fixtures wanted). (6) CE_STRUC_SUITE\CS_Settings.json had its write time changed at 17:14 (shutdown) with identical contents: a same-content rewrite on AutoCAD close, cause unconfirmed, harmless so far.

**Status:** OPEN (observations). Codex waits for the Wed 7 Oct 20:52 reset (87%). Not fixed until Tim confirms in AutoCAD.

---

## BUG-346

**Command / Area:** C-7 Opus finalizer leftovers (Opus finalizer a89d383716bb6676e, train claude/rel-20261006c bb8e9800, 2 Oct; report `C7_OPUS_FINALIZER_2026-10-02.md`). None HIGH.

**Symptom:** (1) MED: in older drawings where a pit was COPY'd before CE re-mapped copies, the copy's number label and cover text can stop following it on MOVE after a relink or CDREPAIR. Nothing erased. Read from code, not reproduced. (2) LOW: a wrong recorded level (e.g. 0.00) on an unselected pipe arriving at a pit pushes Carry downstream far too deep; the preview names that pipe before Apply and one U undoes it. (3) LOW: a mm drawing with pit symbols scaled to 0.2 or smaller now holds automatic grade/length updates, with a message (deliberate). (4) LOW: at a pit with two pipes leaving, the second one's inlet cell is named "left as drawn" on every edit; rebuilding the schedule does not clear it. (5) LOW: no reminder survives closing the drawing that a batch left Pit Schedule rows as drawn (= BUG-345 item 1).

**Fixed in the train (not carpark):** a pipe drawn low-pit-to-high-pit before its levels were set (or relinked by CDREPAIR) was called out of date by the new cell rule on every edit; the levels now decide (5 mm test, as the schedule). 

**Status:** OPEN, carpark. Not fixed until Tim confirms in AutoCAD.

---

## BUG-345

**Command / Area:** C-7 builder leftovers (Opus builder a36ec5d339421ed8c, branch claude/rel-20261006b head 3bcfa859, 2 Oct).

**Symptom:** (1) LOW: no reminder on reopen / PITSCHEDULE for schedule rows a batch Apply left as drawn (BUG-340 item 7): needs a persisted list of left-out rows first. (2) LOW: `CalculationsWindowViewModelTests` (34 tests) fail as a class when run after `CalculationsV2ViewModelTests` in one chunk (DocumentManager InvalidProgramException); each passes alone: test-order problem, not a plugin fault. (3) LOW: in non-carry mode the warning for pipes outside the batch arriving at a pit shows in the preview only, not again after Apply. (4) LOW: Edit Pipe still marks a typed level on one half of a split pipe only; the grade lock now reads both halves. (5) LOW: a split detention pipe with no project record is not checked for mixed units. (6) Not proven: paste clean-up inside RegisterPitAttachment during clone regeneration is overwritten by RemapClonePit straight after (traced in code, not run).

**Status:** OPEN, carpark. Not fixed until Tim confirms in AutoCAD.

---

## BUG-344

**Command / Area:** Structural footing commands in a cm / metre / inch / feet drawing (S-7). Tim's ruling INT-026 (2 Oct 14:20): "Convert units automatically", NOT refuse and NOT ask.

**Symptom:** today (Structural 1.0.90, S2 review 3 build) any footing command in a non-mm drawing asks one Yes/No question, default No, and stops with nothing written on No (`FootingDrawingUnitsAllowed`, FoundationService.cs ~4260; commands listed in `MillimetreFootingCommands`: THC, PFC, SF, REB, RIB, FADOPT, FEDIT, BP, SCREWPILE, STUMPFOOTING, FSTEXPORT, CSFOOTINGSCHEDULE, CSRCBEAMSCHEDULE). Tim wants the drawing read in its own units, one plain line saying so (R-27 warn + record), mm and unset drawings unchanged.

**Plan (S-7, queued, one Opus builder per product per train; none before Sat 3 Oct 12:00 desk throttle):** replace the question with the conversion. The one conversion already exists (`DrawingUnitRule.MillimetresInDrawingUnits` / `SizingDrawingUnitsPerMm`) and is already used by the load path, rebar spacing, schedule sizing and the FADOPT label reach. Per command the builder decides CONVERT or HOLD (plain line saying why): CONVERT where every size read or written goes through the helper (FADOPT, FSTEXPORT, CSFOOTINGSCHEDULE, CSRCBEAMSCHEDULE, REB, RIB, THC, load path); HOLD with a plain line until audited the drawing commands with hard-coded millimetre geometry (PFC, SF, BP, SCREWPILE, STUMPFOOTING, FEDIT grips/kite/outline/offsets/text heights) if the audit finds any constant not routed through the helper. Mixed-units drawings (INSUNITS says metres but footings drawn in mm) need the same evidence-based hold as Civil BUG-338/#540. Tests: pure rule tests per unit (cm, m, in, ft), source guard that no footing command reads a typed size without the helper, accoreconsole probe of one pad in a metre drawing.

**Status:** OPEN, queued for S-7. Decision recorded (decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md INT-026). Not fixed until Tim confirms in AutoCAD.

---

## BUG-343

**Command / Area:** the GRADE LOCK and flat-pipe leftovers (from the Opus review of PR #513, 2 Oct 11:25; builder a62c2d3d1bfe37084 fixing the PR itself; review `B328R_OPUS_REVIEW_2026-10-02.md`).

**Symptom:** (1) HIGH: the grade lock itself works a breakline-pair half from its own drawn length while both halves store the whole run's levels (Tim's rule: both halves hold the same levels, grade worked over the combined length) (same family as BUG-338 item 3). (2) MED: pipes set flat through the Pit Schedule, Inspector, IL label or CD with the Minimum grade left on keep a HELD grade (so they are looked at as flat-by-accident by any repair). (3) MED: the grade lock keeps the HIGH end even when the drafter fixed the downstream level ("downToUp"), so that level moves on a pit move. (4) MED: the Repair Center window already cut off Focus Windows, Toggle Debug and Run Triage before #513 (no scroll bar, UI rule: regroup). (5) LOW: labels damaged by the old metre fault ("1 IN 1", "0.01m") on pipes that never went flat are found by NO repair command.

**Status:** OPEN (2 Oct 11:25).

---

## BUG-342

**UPDATE 4 Oct 06:31:** BUG-342 part 1 (paste/INSERT into a drawing with NO drainage): Tim INT-048, 4 Oct ~07:00, verbatim 'PASTE - YEP' (desk reading: YES, a paste of CE pits/pipes into a drawing with no drainage wakes Civil for that paste with one plain line (run CDREPAIR), only for CE pits/pipes). DECIDED. #567 (quiet paste catcher, card CARD_PASTE_QUIET_CATCHER_2026-10-03) may ship once its review fixes pass: needs the card, an Opus verdict and a Team builder for the fixes; no longer on HOLD for the question.

**Command / Area:** Civil C-6 adversarial review 2 (CDDESIGN setup, paste, OOPS/ERASE/COPY/ARRAY; Opus a3bd56e68fb7e4091, 2 Oct 11:15; report `C6_OPUS_ADV_2_DESIGN_PASTE_OOPS_2026-10-02.md`; installed 3.0.21). Sound: all CDDESIGN saves happen inside the command (one U, nothing after U), changing the council keeps every other rulebook value, no layer unlocked, no new hard block, no exception escapes a handler.

**Symptom:** (1) HIGH-MED: paste or INSERT into a drawing with NO drainage yet (new or Structural drawing) is ignored completely: no "run CDREPAIR" line, the pasted pits keep the other job's links (`LinkService.Reactors.cs:1619-1623`, `:40-44`; Civil switches on halfway through the paste, `LinkService.Utilities.cs:1155`); a later pit MOVE can drag objects that share those old handle numbers. (2) MED: moving a pit moves every item on its label and pipe lists WITHOUT checking ownership (`PipeMoveHelpers.cs:230-290`, `PitMoves.cs:104-160`, `Registration.cs:446-448`; `HasReciprocalChildOwnership` exists but only highlighting uses it); CDREPAIR leaves a pasted pit's label list as pasted. (3) MED-HIGH, NEEDS CODEX: the normal associative ARRAY (ARRAYASSOCIATIVITY 1) of CE pits and pipes was never driven: by the code the original counts as erased (loses its schedule row, labels erased), the copies sit inside the array block and their clean-up is refused (`CloneOriginRule.cs:422`, only MIRROR may erase originals); one U puts it back: Codex: ARRAY on a pit and on a pipe, CDCHECK, U, REDO, timing 299 pipes. (4) MED, NEEDS CODEX: dragging objects between two open drawings (probably DROPGEOM) is on neither the copy nor the paste list: Codex reads the real command name. (5) LOW-MED: a job council this PC does not know: CDDESIGN offers the job-folder council with Yes as the default without naming the existing one; one Enter + Save Draft rewrites the job's council (`CivilDesignCommand.cs:95`, `:653`). (6) LOW: Save Draft with nothing typed freezes CDCALC's areas into the Design draft ("Design's saved site area is 800" on every later open; a cleared CDCALC area comes back as "Set"); Save Draft on 3.0.20 or older silently drops the saved head and detention answer (install note); the OOPS line after 299 pipes is one 3,190-character line and a downpipe is called "pit 2A1F"; a plain INSERT of an ordinary pit-named block (legend/detail symbol) now prints "run CDREPAIR" and CDREPAIR would register legend symbols as real pits.

**Status:** OPEN (2 Oct 11:15). Items 1, 2, 5 and the LOWs to Opus builder (claude/c7-paste-ownership); ARRAY and drag-and-drop are Codex observations first.

---

## BUG-341

**Command / Area:** Structural S-5 adversarial review (command-end redraw, native edit record-follow, #515; Opus a1869b334251c7350, 2 Oct 11:30; report `S5_OPUS_ADV_1_COMMAND_END_2026-10-02.md`; installed Structural 1.0.89 = claude/rel-20261004v ce94628e). Held up: nothing writes after U/UNDO/REDO/MREDO or at save/close/plot; no exception can escape into AutoCAD; nothing is unlocked; #515 is right; the settings Save refusal covers the older folder; a drawing with no old CE links writes nothing.

**Symptom:** (1) HIGH: AutoCAD's CORNER grip moves one corner (the pad becomes a kite): the outline follows, the schedule stays 600 x 600, CSLOADPATH checks the old square, FEDIT squares the pad back at its old place, silently; the Codex steps at `REGRESSION_LOG.md:9` (d) and `:20` (a) ask for exactly that grip and expect "resized ... 900 x 900": cannot pass as written (rewrite as STRETCH with a crossing window over one side; print one line when a pad is no longer a rectangle; FEDIT writes every vertex). Same family MED: a pad drawn by clicking back onto its start point has a fifth vertex: FADOPT accepts it (`FoundationService.cs:3840`) but the new follow rejects it (`FoundationService.Grips.cs:237`): it never follows MOVE; FEDIT moves four of five vertices (`:1518`) and leaves a spike. (2) MED: the "schedule out of date" note is memory only (`FoundationRegistryMemory.cs:16`): SCALE or ERASE a scheduled pad, QSAVE, close, reopen, PFC Escape: schedule still old/lists the erased pad: keep the flag in the footing record in the same Undo step. (3) MED: the "not inside 'ZOOM during TRIM" check relies on CMDNAMES at the moment the nested command ends (`FoundationMonitor.cs:235-241`), never measured by the 2027 probe: count command depth per drawing instead; LOW: inside a LISP routine each inner MOVE redraws the whole footing system (50 pads = 50 redraws): wait while CMDACTIVE shows LISP/script. (4) MED-LOW: FEDIT cannot put back a hand-retyped label (retype PF1 to PF7, then FEDIT type PF1: CE keeps PF7; "Current" line shows the stale mark). (5) LOW (3 proven by probe): an adopted pad slightly out of square is called "resized" with nothing edited; any edit to a label's text becomes the footing mark ("PF1 TYP.", "pf1"); the command-end filter costs about 0.5 s per 100,000 moved objects with no time limit inside the command (MOVE ALL is the case to time); FADOPT takes labels in drawing order (a pad can take its neighbour's label; drafter MText labels still get a second CE label); FEDIT redraws twice; a resize found during a redraw that fails for a reason other than a locked layer is never reported.

**Status:** OPEN (2 Oct 11:30). Items 1-4 (+5 if cheap) to Opus builder af1089cfa4ac7b0fd on `claude/rel-20261005s`.

---

## BUG-340

**Command / Area:** Civil C-6 adversarial review 3 (batch editor + native locked-layer opens + held-back labels; Opus aa6ee9466df95f905, 2 Oct 11:15; report `C6_OPUS_ADV_3_BATCH_NATIVE_2026-10-02.md`; installed 3.0.21). The NATIVE locked-layer code is SOUND (lock check before every write-open, never unlocks, no leaks on refusal, errors caught at every native entry point, same 2024/2027 source); nothing C-6 touched can let an exception escape a LAYER lock (agrees with BUG-326). Nothing loses a drawing; the batch findings need particular selections.

**Symptom:** (1) HIGH `PipeEditCommand.Batch.cs:175-199`: two pipes into one pit with Carry downstream: P3->P4 takes its level from whichever incoming pipe was picked first (P1 arrives 9.00, P2 arrives 8.80: P3->P4 starts 8.98, P2's water climbs 180 mm); preview lists both answers, Apply writes one, no warning; fix: lowest arriving level, show only what Apply writes. (2) MED `Batch.Cascade.cs:172`: "Only these pipes" with two pipes in a run: P1 arrives 220 mm below where P2 starts (back-fall), clash warning skipped for two batch pipes (conflicts with Tim's ruling: downstream clashes are warnings). (3) MED `Update.cs:352-422`: Simple Pipe preset + Design grade ticked: preview shows new levels, Apply keeps the old ones while recording "custom 1 in 100"; the next pit MOVE re-levels the pipe unseen. (4) MED `Batch.cs:880-891`: a pipe with no levels yet + another field + Carry downstream is written twice; whole batch refused "did not retain the accepted Diameter". (5) MED `Batch.cs:833-849`, `Update.cs:847-855`: both halves of a broken pipe in one batch: the second write restores the old break level, batch commits. (6) MED `Batch.Cascade.cs:337-351`: Carry downstream ignores hand-typed levels (replaced; old value never shown; the new level keeps the "typed by hand" mark) and locked layers (a downstream pipe on a locked layer rolls the whole batch back at Apply; the line names no layer). (7) MED: held-back Pit Schedule labels give no reminder after reopening: a plotted plan can show an old level while the schedule shows the new one: one line on open or when PITSCHEDULE opens. (8) LOW: batch preview stays cached across the "Inspect drawing" loop (`CeBatchEditViewModel.cs:208-233`). (9) LOW: batch locked-layer refusal names no layer, only at Apply. (10) LOW-MED older: the twin pipe's centreline is rewritten before the pipe-object upgrade can refuse (`PipeObjectUpgrade.cs:147-164`). (11) LOW-MED older: the native split shortens the pipe before the second half exists: a later failure leaves a half-length pipe while CE says nothing changed (`CeCvlObjectsApi.cpp:430-462`). (12) Forward: when #516's mixed-units hold on Edit Pipe Save lands the batch preview must use the same hold. Codex should try first (fresh mm copy): two pipes joining at P3 both selected + Design grade 100 + Carry downstream (compare both P3->P4 preview lines with the level written); a run of two pipes "Only these pipes" (any clash warning at the shared pit?); Simple Pipe + Design grade together, Apply, open the Pit Schedule.

**Status:** OPEN (2 Oct 11:15). Items 1-6 (+9) to builder aadd93ce379348e02 on top of the BUG-339 fix.

---

## BUG-339

**Command / Area:** Civil batch editor (Edit 2+ pipes) APPLY fails: "An affected schedule cell cannot be resolved from the accepted project snapshot" (Codex VERIFYC6 run 6 item C6-06 FAIL, 2 Oct 11:02, installed Civil 3.0.21; the same error stopped C5-02/03/04 on 3.0.20).

**Symptom:** pipe 109E23 (P3 18.50 / P2 19.00, header "Flow: P2 -> P3") selected with an older pipe 109ED4 (IO8 to P3): #507 works (the older pipe is left out with a plain line naming it and the way out: CDEDIT it once and answer Yes when CE highlights its label); the preview is right ("P2 -> P3: upstream IL 19.00 -> 19.00 (held) · downstream IL 18.50 -> 18.76 (worked out) · pit P3's schedule invert/depth follows this new level"); then APPLY (No to the downstream recalculation question) FAILS: nothing written, levels stay 18.50/19.00, plan label "AT 1 IN 46"; log 11:01:41.251: `CDEDIT atomic pipe batch failed: InvalidOperationException: An affected schedule cell cannot be resolved from the accepted project snapshot.` So the #492 batch Apply (BUG-289/291/292 family) is STILL not usable on this fixture; OOPS line wording PASS in the same run: "[CE] OOPS brought back pit P2 with its label, and pipe P2-P3 (109E23) with its 4 other items, and re-linked them." (C6-07 (a)(c) PASS; (b) far-end/main label view not inspected).

**Status:** OPEN (2 Oct 11:15). Opus builder started (claude/c7-batch-apply-cell).

---

## BUG-338

**Command / Area:** Civil train C-6 adversarial review 1 (pit / metre-units conversion; Opus a436397e83dff8b13, 2 Oct 11:00; report `C6_OPUS_ADV_1_UNITS_2026-10-02.md`; installed 3.0.21 = branch claude/rel-20261005b 42b53473). Every conversion converts ONCE; the hold for mixed drawings cannot leak on anything CE does automatically; nothing is wrong in millimetre drawings (every office drawing Codex has seen).

**Symptom:** (1) HIGH, ONLY IF an office template has UNITS = Metres while drawn in mm: every drafter-started writer writes numbers 1000x out (3.0.20 wrote most right): 10 m pipe at 1 in 100 from 20.00: CD with draw-first OFF and "work it out from the grade" writes downstream -80.00 instead of 19.90 UNSEEN (draw-first is on by default: the window shows -80.00 before OK); labels "1 IN 100000"; batch editor Design grade and Carry downstream drop each pipe 100 m (shown in the preview); CDPROPAGATE with a typed grade; Pit Schedule edits; approved repair proposal grade text; split detention labels. PR #516 holds CD and Edit Pipe Save only. Fix: hold the other five behind the same decision (builder adf210578c640d63e widening the C6-17 PR). (2) MED: the REVERSE mix is never detected: UNITS Millimetres (or none) but drawn in METRES with pits scaled 0.001: one pit MOVE flattens a grade-locked pipe (19.90 -> 20.00), CD labels new pipes "1 IN 1", pit catch reach becomes 100 m (CD can move a picked end up to 100 m onto a pit wall): make the check work both ways (5x larger or 5x smaller). (3) MED, ANY units: a SPLIT pipe's grade lock measures only the moved half: 6 m + 4 m at 1 in 100 drops 0.06 not 0.10 (bottom 19.94, label "1 IN 167"); a same-plan break typed as 25 m real but drawn 2 m + 2 m drops 0.02 instead of 0.25 (read from code, not proven in AutoCAD): use the whole pipe's length and write both halves. (4) MED, RULING FOR TIM: CE still draws at millimetre size in a true metre drawing: a DN300 pipe is drawn as a band 300 m wide, text/blocks mm-sized; CDREPAIR takes diameter from the line width (a 0.375-wide pipe recorded as DN100): only mm drawings get both right numbers and right linework. (5) LOW-MED: CDFALLSUGGEST in a metre drawing takes a spot level up to 50 m away as "here" and writes "1:0.1" instead of "1:100" on the fall arrow. (6) LOW: CDSPOONDRAIN in a metre drawing prints "1:0" and stores the run length 1000x short. (7) LOW: metre drawings: branch messages say "at 0.01 m" for 10 m, CDREFRESHLINKS leaves labels up to 1 m out, XCL import wall snap and detention length assume mm. (8) LOW: a pit scaled other than 0.001 in a metre drawing (0.002) is stored at its drawn size and read back 1000x small. (9) LOW/unknown: when a scaled pit's linework cannot be read CE assumes AutoCAD reports drawn sizes (true in 2027): untested on 2024-2026 (a version that reports block-unit sizes would read a 0.001 pit 1000x too big).

**Status:** OPEN (2 Oct 11:00). Whether the office has UNITS-Metres or metre-drawn UNITS-mm drawings is still Tim's BUG-287 question.

---

## BUG-337

**Command / Area:** Civil CD level/direction in a metre drawing with a scaled pit (Codex VERIFYC6 run 6, item C6-04, 2 Oct 10:50, installed 3.0.21; ATTRIBUTION UNRESOLVED, Codex marked it REPORT).

**Symptom:** fixture: metre drawing (INSUNITS 6), pit P1 scaled 0.001, pit P2 copied to 102010.6,0, CD pipe 100672 (LIST length 10.000, vertices 102000.300 and 102010.300). New Pipe showed known upstream 20.00 / calculated 19.90, grade 100. Edit Pipe then showed `Flow P2 -> P1`, `P1 19.90 / P2 20.00` with the warning "Pipe text exists nearby but is not linked. Stored values may be stale until the text is relinked.", preview label AT 1 IN 100; while the CD command line said "Inserted flow arrow. Flow: P1 -> P2" (and "Pipe end moved to the inside wall of P1 (was 300 mm inside the pit)"). The two directions DISAGREE and the levels put the high end at P2 although CD's flow arrow points P1 -> P2: either the drawn-order level fill (known upstream 20.00 given to the FIRST drawn end) was stored on the wrong end after the end-to-pit linking, or Edit Pipe reads the ends in the other order (BUG-260/BUG-244/#492 family). After a MOVE of P2 by +5 m (grade-locked): Edit Pipe showed P1 19.85 / P2 20.00, grade 100, "not flat" (the #508 fix works for the lock; the schedule later showed P1 outlet 20.00 and P2 inlet 19.85). The U / schedule-cell steps were not established (Codex input problems). Plain-English check needed: which end is upstream in the CE record vs the arrow.

**Status:** OPEN (2 Oct 10:50). Passed to the C-6 adversarial reviewers (a436397e83dff8b13) and the next Codex run.

---

## BUG-336

**Command / Area:** Structural train S-5 (`claude/rel-20261004u`, Opus finalizer GO at 6934c7eb, 2 Oct 07:30) leftovers.

**Symptom:** (1) edits ended with Escape (TRIM, PEDIT, EXTEND after changes) still take two U: hooking a cancelled command needs its own probe first. (2) FDELETE and FST "Delete system" leave outline pieces on a locked outline layer without naming the layer. (3) the first redraw after updating to S-5 still overwrites a hand-retyped footing label; typed schedule values stay with the old mark after a hand rename. (4) a settings file that can never be opened refuses every Save: the message should say how to get out. (5) drawings with no old CE links are now scanned (read only) at every open: extra open time on large drawings. (6) the compiled-proof fixture `SbeamEditAutoCadEvidenceReaderTests` still stalls past 600 s (BUG-332 item 1). (7) 2024/2025/2026 not measured: the one-U probe and the command-end redraw are AutoCAD 2027 only. (8) `S5AdversarialHighFixTests` (41) cannot run on net48 (setup needs AutoCAD): proven on net10 only. (9) Team lane duplicates #514, #517, #518 are NOT merged (S-5 kept its own versions: #514 pointer key kept with the footing memory; #517 still locks at open, S-5 only reads; #518 same rule); #515 (background-thread drawing work) IS in. Opus fixes on top of the builder: redraw only when the outermost command ends (not inside 'ZOOM during TRIM), record restored only if the drawing really went back, separate coordinate and size tolerances for pads on survey (MGA) coordinates.

**Status:** OPEN (2 Oct 07:30).

---

## BUG-335

**Command / Area:** Structural S-4 adversarial review 3 (drafter's footing and schedule workflows; Opus af887afe421542554, 2 Oct 06:05; report `S4_OPUS_ADV_3_WORKFLOWS_2026-10-02.md`; train c84a3629).

**Symptom:** (1) HIGH (= BUG-334 item 2, proven by a probe): the #485 "schedule out of date" note never matches on 2027 (stored against the Database object): ERASE PF2, then PFC and Escape: schedule still lists PF2; Codex check 8(a) fails; fix: key by native pointer, forget at close, widen the guard test to fail on such memory lists anywhere in Structural. (2) HIGH, older code now hidden on 2027 by #480: CE never records a native MOVE/STRETCH/ROTATE/SCALE/grip edit of a pad, thickening, pier or stump footing: grip a pad 600 -> 900: outline follows, schedule keeps 600 x 600, CSLOADPATH checks columns against the old place, FEDIT snaps the pad back to its old place/size/angle, a moved stump/screw pile is redrawn at its old spot; fix: refresh the stored centre/size/angle from the actual line before each redraw and at each command's start-of-command drawing check; FEDIT offers the live size. (3) HIGH (= BUG-333 item 1): locked 25TEXT makes a failed redraw save an emptied outline list; outlines double (`FoundationService.cs:1776`, `:2446`, `:1949-1955`; raw text "eOnLockedLayer"). (4) MED: a hand-retyped footing label (PF1 -> PF7) is silently put back at the next redraw (`:2091`). (5) MED: FADOPT of a copied pad, as #488's own message advises, doubles label and outline ("PF6" printed over "PF1"). (6) MED: FST "Remove orphan", "Delete element", "Delete system" and FDELETE fail with "eWasErased" for a footing erased earlier in the session; FDELETE half-deletes (`:2528`). (7) MED (BUG-300): on 2027 one native footing edit needs 2 or more U presses and the first U puts the outline back while the line stays erased. (8) LOW: a schedule copy is never named at footing commands; deleting a system's last footing in FST leaves its outline; an OOPSed old label doubles; a 1.0.88 schedule locks in whatever DIMSCALE is current at its first rewrite; column widths reset on every update; stretching the raft slab edge is not followed. HELD UP: copies refused by FEDIT/FREGEN/FDELETE; cut-and-pasted/CHSPACEd/OOPSed schedule found again; 1:1 on layouts; footing memory per drawing (BUG-314); OOPS picked up at the next footing command; the finalizer's note-order fix; cancelled-save handling (#481); the hidden palette restore (#465); reo bar units (#499). #440 is not in S-4: no bar schedule or mark to test.

**Status:** OPEN (2 Oct 06:00). Items 1-3 to the S-5 builder (a40464c119283a752), 4-6 if time.

---

## BUG-334

**Command / Area:** Structural S-4 adversarial review 1 (Undo/Redo and idle paths; Opus a18a09596b7fc83d0, 2 Oct 05:50; report `S4_OPUS_ADV_1_UNDO_IDLE_2026-10-02.md`; train `claude/rel-20261004s` c84a3629).

**Symptom:** (1) HIGH: one U takes back CE's footing REDRAW, not the drafter's edit (new on 2027 in S-4 via #480): MOVE a pad's line, then U: the outline jumps back but the line stays moved; ERASE a pad's line then U: the line stays erased; U, U, REDO leaves the outline at the old place until FREGEN. Cause: the redraw runs after the command with the drawing locked (`FoundationService.cs:505`), its own Undo step. The REGRESSION_LOG checklist contradicts itself: `:329` (7b) and `:331` (7d) expect one U, `:311` (6b) expects two (Codex will fail 7b and 7d). Fix: redraw inside the editing command's own end like the beam follow (`BeamLinkService.ConnectedFollow.cs`), prove with Codex that one U works; until then change 7b/7d to "two U". Correction: BUG-304 and BUG-314 item 4 say the redraw "never takes LockDocument"; on S-4 it does, what is left is the extra Undo step. (2) HIGH: the #485 "schedule out of date" note NEVER works on 2027: stored against the drawing object (`FoundationScheduleService.cs:114-127`) and 2027 hands out a new object on every read (probe confirmed the lookup misses): ERASE a scheduled pad, then PFC and Escape: the pad is still in the schedule; Codex steps at `REGRESSION_LOG.md:12`, `:272`, `:298` fail. Fix: store by the drawing's native pointer, forget at close. (3) HIGH, older: STRSCHEDREFRESH writes a table and STRUCEXPORTCSV reads the drawing on a BACKGROUND thread (`AsyncCommandService.cs:61-66`): can crash AutoCAD: do the drawing work in the command, only Excel file writing in the background. (4) MED, older: `LinkMigrationService` writes `CE_LINKS_MIGRATED_V2` into EVERY drawing at open (Civil, consultants' backgrounds, new drawings): likely cause of "Save changes?" on drawings only opened (BUG-214, not proven): write only when old CE links exist. (5) MED: Structural has no IL baseline / reactor-timer REDO guard (the Civil `RedoSafeReviewedHooks.baseline.txt` 830 lines and `RedoHistoryCommandEndRule` scan only the Civil assembly; BUG-280); duplicate inventory key at `RedoWindowGuardTests.cs:842`/`:847`. (6) LOW: CE Sheets rescan opens other DWG files on a background thread; the footing Idle drain redraws when its own check fails (`FoundationMonitor.cs:254`); `StructuralFrameGripOverrule.OnDocumentToBeDestroyed` has no catch (`:115`); a dimension command's restore can run at the end of U and lose REDO (`DimensionCommands.cs:916`); U run from LISP may not clear the footing memory. Sound: nothing CE runs on its own after U does a full read or write on a default setup (only the footing grips switch, off by default, needs #505); schedule never refreshed twice in one command; BUG-314 items 1 and 2 fixed.

**Status:** OPEN (2 Oct 05:50). Items 1-3 go to an Opus builder (S-5 batch with BUG-333 item 1).

---

## BUG-333

**Command / Area:** Structural S-4 adversarial review 2 (units / locked layers / settings round trips; Opus a9ac625d880c4e40f, 2 Oct 05:50; report `S4_OPUS_ADV_2_UNITS_LOCKED_SETTINGS_2026-10-02.md`; train `claude/rel-20261004s` c84a3629).

**Symptom:** (1) HIGH: a footing REDRAW that fails part way loses track of the old outline: lock 25TEXT (or LAYISO lock-and-fade), STRETCH a strip footing: "could not redraw ... type FREGEN", FREGEN fails the same way with a raw AutoCAD error word and no layer named; after unlocking, the next redraw puts a SECOND outline on top of the old one and nothing ever removes the old one; FADOPT with locked footing lines/labels says "Adopt Footing complete. adopted=N" with nothing drawn. Cause: `EraseGeneratedOutlines` clears the outline list in memory (`FoundationService.cs:2446`) and skips locked outlines silently (`:2440`); driver and label opened for write outside any check (`:1821`, `:1904`, `:2039`); the catch saves the record with the outline list cleared (`:1949-1955`). Fix: in the catch call Invalidate instead of Save; check layers first and print one line naming the locked one; keep a locked outline on record (as `EraseOutlinePiecesBroughtBack` does). (2) MED: a colleague whose only settings are in the older TIM_CE_CADTOOLS folder, file busy at AutoCAD start, CESETTINGS Save pressed while still busy: standard values plus the one edit are written to the new CE_STRUC_SUITE file and the older settings are never read again, nothing said (`SettingsService.LoadRecovery.cs:599`; reproduced in probe P7): refuse whenever the file that failed to open still exists, whichever folder. (3) MED: CSLOADPATH in a metre drawing after a Yes: adopted strip lines keep mm widths (300/450) treated as 150 m half-widths so it prints "[LOADPATH OK] ... all supported"; the reason line reads "within 0mm" (`LoadPathEngine.cs:112`): never print LOADPATH OK in a non-mm drawing (Tim decides: measure nothing, or convert stored widths); #496 MED 2 leftover. (4) MED: the units question is asked on EVERY footing command, the "units not set" note repeats, and a script feeds its next line to the question (S-3 adversarial 1 findings 1, 3, 7): Codex meets it first in a metre drawing. (5) LOW settings (BUG-299 family): values a newer build adds inside list rows are lost at the first start-up save; a bad value in one span-table row is saved as a row at 0 mm; a cut-off file is replaced by standard values at start (41 values reset on a copy of Tim's file; older S-3 behaviour); the carry-over reads the file before taking the save lock; the lock wait has no time limit and now runs at every start (`SettingsService.cs:610`); routine saves rewrite the file even when nothing changed. (6) LOW: each redraw moves the drafter's footing label back to 25TEXT; with DIMSCALE 0 labels are always 250 units tall. HELD UP: Tim's real CS_Settings.json (copy) loads clean (bearer span table 471 rows back to 3, all copies of the starter rows), the second start does not rewrite it; no raw 1000/25.4/304.8 added in the train; nothing in Structural unlocks a layer.

**Status:** OPEN (2 Oct 05:50). Item 1 goes to an Opus builder with the other S-4 adversarial HIGHs (S-5).

---

## BUG-332

**Command / Area:** Structural train S-4 leftovers (Opus finalizer, 2 Oct 04:00; train `claude/rel-20261004s` GO at c84a3629 incl. #488).

**Symptom:** (1) `SbeamEditAutoCadEvidenceReaderTests` (compiled proof) is still unproven on S-4: the test host stalls past 600 s. (2) #505 (BUG-314 (3): reading the footing record after U) is NOT in S-4: it must ship BEFORE the footing-grips switch goes on. #506 (stacked on #485) and #486 (needs #440) go to S-5. (3) when the start-up save is skipped, old `.CS_Settings.json.save-*.tmp` leftovers survive, and if the drafter deletes `CS_Settings.json` on purpose before the next real save the old save is put back at the next start (#494 x #493, LOW). (4) CSLOADPATH's own drawing check runs outside #485's schedule refresh, so a pad brought back by OOPS there updates the schedule only at the next footing command (LOW). (5) schedules size decimetre/yard/km drawings as millimetres while the load path measures them truly (by design, #485 vs #496). (6) `LoadPathEngine.cs` has a doubled `<summary>` comment (cosmetic). Merge slip found and FIXED by the finalizer: `FoundationMonitor.cs` merged without conflict but said the erased-footing note before collecting the erased footings (ERASE of a scheduled pad printed nothing and the schedule was not marked out of date).

**Status:** OPEN (2 Oct 04:00).

---

## BUG-331

**Command / Area:** Civil metre-drawing leftovers (from the PR #508 builder, 2 Oct): (1) CD REFUSES any pipe 1 m or shorter in a metre drawing (`ValidatePointGeometry` `<= 1.0`, "< 1mm"): a hard block against R-27 (pre-existing). (2) CD's detention length check compares a required length in millimetres with a drawn length in drawing units. (3) the legacy same-plan break's 100 mm minimum gap is measured in drawing units. (4) the long section reads lengths as millimetres and its evidence has its own `Math.Floor` grade copy (`ProfileRouteEvidenceCaptureService.cs:713`). (5) `ImportedLevelReviewService.TryWallToWallMm` mixes pit centre distances in drawing units with pit sizes in millimetres. (6) dead code still uses raw lengths: `GetCombinedBreaklineLengthMm`, `LabelStyleService.GetPipeLabelText`.

**Status:** OPEN (2 Oct 03:15). C-6 FINALIZER (2 Oct 06:40, GO at b4e075d8) adds: (1) a Pit Schedule edit in a "UNITS Metres, drawn in mm" drawing writes the plan label grade 1000 times too big (e.g. 1 IN 100000) after #508 (3.0.20 was right there by accident): the closed list says no hold pass is open there but one is; the writer just doesn't ask it (decision: user-started, agreed scope; PR #516 holds Edit Pipe Save and CD in mixed drawings but not this one); (2) CD's optional same-plan break end margin is 1 drawing unit (`CdCommand.SamePlanBreak.cs:85`, pre-existing); (3) the Pit Schedule pipe sync re-places the main label with mm offsets every time (pre-existing); (4) the `Services.P` tests (2,042) pass but the test host never exits when run as one chunk (also on base 266959ec): split it; (5) installer test `ManagerReleasePayload_HasTrackedManifestAndThreeLaneLocalAssets` fails with "no PrepareReleaseCandidateRoot target" (pre-existing). REAL OFFICE DRAWINGS ARE MILLIMETRE (Codex C5 saw INSUNITS 4 on DWG-B with 600 mm pit blocks): the mixed case matters only for templates Tim answers on. Opus CONFIRM rounds 2 and 3 of #508 (2 Oct 05:10): round 2 found `UpdateLinkedPipeGrades` unheld (fixed in c33ec47b); round 3 found the NATIVE STRAIGHT-PIPE EDIT route (STRETCH/LENGTHEN/TRIM/EXTEND/grip stretch/plain MOVE of a pipe: `NativeEdits.cs:368`) still rewriting length and grade text from the 1000x length in Metres-UNITS drawings drawn in mm (builder fixing, last round); LOW: a split triggered by placing or landing a source rewrites detention label lengths without the hold; one pass's decision comes from the first pipe's pits (mixed metre-scaled and mm pits). Earlier: Opus CONFIRM of #508 (2 Oct 04:15, MERGE-WITH-FIXES at e78efbc2, one fix with the builder: hold the label too): (MED) a Metres-UNITS drawing drawn in mm with NO sized CE pit block gives the guard no evidence (the 1000x reading goes ahead); (MED) in such drawings CD drawing and Edit Pipe Save still write "1 IN 100000" and "10000.00m"; (LOW) `LinkService.PitRelinks.cs:237` fixed 1.0 drawing-unit tolerance (1 m in a metre drawing); (LOW) the approved repair proposal's grade gained CD's rounding nudge in mm drawings. Opus review of #508 first round (2 Oct 03:40, MERGE-WITH-FIXES) adds: (HIGH) existing METRE jobs may already hold pipes the OLD grade lock FLATTENED (bottom reset to top on a pit move): nothing finds or repairs them (needs a repair command: in a command, one Undo, one line per pipe); (HIGH) a Metres-UNITS drawing drawn in mm gets 1000x lengths in every BUG-328 writer (builder adds a hold-and-warn guard); (HIGH) `TryApplyDetentionLengthConstraint` MovePit moves the end pit about 1000x too far in a metre drawing; (MED) Unitless drawings drawn in metres still flatten grade-locked pipes on a pit move; (MED) `DetentionCalcViewModel.GetEntityLength` 1000x too small in metre drawings; (MED) `SplitHalfRule.cs:187-199` rewrites "NN.NNm DETENTION" and `DetentionRequiredLength` from raw drawing units; (LOW) five more unfolded grade-rule copies (`InvertPropagation:1080`, `LevelsProposalEngine:813`, `UpstreamDownstreamSuggest:117`, `ProfileRouteEvidence:713`, `CdCommand:536`).

---

## BUG-330

**Command / Area:** Civil metre-drawing leftovers and OOPS (from the PR #507 builder, 2 Oct).

**Symptom:** (1) these still read drawing units as millimetres in a metre drawing: CD's detention required-length trim, the Pit Schedule charged-main length, the imported-level review, the repair-audit length checks, the detention system window and the label style service. (2) erasing a pit clears the end-owner choice its surviving pipes had for it (set by hand, a split pipe or a downpipe change) and OOPS does not put it back (pipes touching the pit re-join by position). (3) the Pipe tab shows the route in mm ("30000 mm") while the main Edit Pipe window shows metres. (4) a pipe that reads but then fails the second label check still stops the whole batch (kept so "carry downstream" can never write it).

**Status:** OPEN (2 Oct 03:00). Opus review of #507 (2 Oct 03:20, MERGE-WITH-FIXES) adds: CDCALC prefill and Design Review read pit-to-pit distance as millimetres (`PipeGeometryHelper.TryComputePipeLengthM`): 1000 times short in metre drawings; tidy-up lines in metre drawings say "moved 1175 mm" (unit of that figure not checked); the CDPIPEOBJ message and the detention window / Pit Schedule charged main / imported-level review still unconverted. KEY FINDING already routed to the builder: CE pipe OBJECTS (every pipe CD draws on Tim's PC) have no MLINE band, so a units lookup through `MlineId.Database` falls back to mm.

---

## BUG-329

**Command / Area:** Civil, minor items from the Opus review of PR #503 (2 Oct).

**Symptom:** (1) CD's grade rule exists in three places plus a separate round-down copy at `PipeEditCommand.GradeText.cs:80`: fold into one. (2) every Pit Schedule sync re-places the pipe label at its default spot (`relabelPlace` is true whenever the record has a diameter), undoing hand moves (corrects BUG-322 item 1). (3) `NetworkRedesignProjectDataFreezeService.CloneForApply` also drops `PavementAreas` and `SpoonDrains`, not only `ProjectReviewApprovals`; no test checks that every `ProjectData` property is copied. (4) held-back label list: no size cap; an error part-way forgets an item without writing it; the long-section route-review fingerprint changes when only the list changes. (5) legacy migration: outline and twin handles are not pre-checked, yet `FixRecordsAfterUpgrade` still erases them. (6) the native locked-layer check (#503) has never run: needs an accoreconsole probe on a drawing with a locked layer.

**Status:** OPEN (2 Oct 02:36).

---

## BUG-328

**Command / Area:** Civil, METRE drawings: ApplyGradeLockToInverts (found by the Opus review of PR #503, 2 Oct; pre-existing, HIGH).

**Symptom:** in a metre drawing a grade-locked pipe gets its invert levels worked out from a length 1000 times too short: `ApplyGradeLockToInverts` (`LinkService.Utilities.cs:~1825`) treats drawing units as millimetres. CD draw (`CdCommand.cs:~414`), Edit Pipe, `UpdatePipeGradeFromInverts`, the native edit text and the length text all do the same: a 10 m pipe at 1 in 100 reads "1 IN 1" in CD and after a pit move; wrong ENGINEERING LEVELS, not only a wrong label. Same family as BUG-323, BUG-293, BUG-270, BUG-287.

**Status:** OPEN (2 Oct 02:36). Builder assigned (metre-unit sweep).

---

## BUG-326

**Command / Area:** AutoCAD FATAL ERROR during Codex VERIFYC5 item C5-12 setup (2 Oct 02:07, installed Civil 3.0.20 / Structural 1.0.88).

**Symptom:** after typing `(command "_.-LAYER" "_LOCK" "25TEXT" "")` the AutoCAD main window disappeared; exception window titled `Exception in AcSmNav.arx ARX Command`, then `FATAL ERROR: Unhandled e0434352h Exception at 905F41CAh` (a managed .NET exception that escaped). Codex did not attribute it to CE; `AcSmNav.arx` is Autodesk's own (Sheet Set / navigation). Cause UNKNOWN: investigation running (Opus a1d3bb4852ccf8d97, report `CRASH_C5_INVESTIGATION_2026-10-02.md`). After the crash the Codex S3 pass could not start AutoCAD normally ("No Profile name exists: Tim", "Customization file load failed ... acad", WebView data-directory error, then "Security - Unsigned Executable File" for CE_STRUC_SUITE.dll: every CE DLL is NotSigned, old and new, so the prompt is not new with 1.0.88; Tim's R26.0 Tim profile has empty TRUSTEDPATHS in the registry view that was read).

**Status:** OPEN (2 Oct 02:20). UPDATE 2 Oct 02:55, Opus investigation `CRASH_C5_INVESTIGATION_2026-10-02.md`: NOT CE code (about 80% sure; trigger about 60%). The 02:06 error is a .NET out-of-memory (0x8007000E, 29 GB free so not real) on a background AutoCAD/WebView2 thread, after AutoCAD's own Sheet Set Manager (AcSmNav.arx) failed at about 02:03:40, 6 s after an autosave of DWG-B3; no CE code in the crash record, CE logged normal work until 02:03:37, C-5 locked-layer code never reached. No CE change proposed. Next time: Codex screenshots the FIRST error dialog, ProcDump on acad.exe needs Tim's OK to download, optional CE log breadcrumb of recent errors at exit (needs a card); then re-run C5-12..14 on a fresh DWG-B copy. PROBLEM 2 (S3 would not start): CAUSE = start method: Codex started AutoCAD from a PowerShell `Start-Process`, which sees a PRIVATE registry copy (BUG-238) where a blank profile "Tim" was created at 02:12; Tim's REAL profile and acad.CUIX are INTACT and unchanged (checked through a WMI-started process; nothing written to the real profile since 30 Sep 16:43; CUIX last written 00:34:10 by the normal CE/AutoCAD start). The desk's 02:25 profile backup is the SANDBOX copy: marked DO NOT IMPORT; the REAL read-only export is C:\ce_rc_scratch\acad_profile_backup_REAL_20261002 (local only, contains job names). Rule added to the Codex briefs: start AutoCAD only through launch_app or the Start-menu shortcut, never Start-Process, never /p, plus a START CHECK and a first-dialog screenshot rule.

---

## BUG-325

**Command / Area:** OOPS after ERASE of a pit, its number label and its pipe together (#490), Codex VERIFYC5 C5-07 (installed 3.0.20).

**Symptom:** pit, number and cover text and pipe all come back and one U removes them together (PASS), but there is NO CE line on OOPS (the log has the BUG-267/BUG-285 lines "4 item(s) back, 1 pit list(s) rejoined" but nothing reaches the command line), and the pipe's main label was only partly visible and its far IL text and arrow were not visually verified (Unknown). The erase line says "5 pipes now have ends that are Not connected yet" with no mention of OOPS bringing them back.

**Status:** OPEN (2 Oct 02:20).

---

## BUG-324

**Command / Area:** Edit Pipe batch editor with two pipes selected (Codex VERIFYC5 C5-02/03/04, installed 3.0.20).

**Symptom:** pipes 109E23 and 109ED4 selected: "[CE] 2 pipes selected — opening the batch editor." then "[CE] The pipe batch was refused because every selected pipe could not be read exactly." The log says 109ED4's pipe-text-layer child has no exact supported text role (unclassified, recorded before CE stored text roles). One older pipe makes the whole selection refuse, so the batch Design grade preview and Apply of #492 could not be tested (C5-02 FAIL, C5-03/04 BLOCKED). Expected: name the unreadable pipe, offer to leave it out or repair it (CDREPAIR / upgrade, in a command, one Undo), and open the editor for the others (R-27: no new hard block; plain English). Single-pipe edit of 109E23 worked: header "Flow: P2 -> P3" correct after Save.

**Status:** OPEN (2 Oct 02:20).

---

## BUG-323

**Command / Area:** Edit Pipe > More > Levels & Flow in a METRE drawing (Codex VERIFYC5 C5-11, installed 3.0.20 = C-5 with #491).

**Symptom:** METRE2 (INSUNITS 6), CD pipe 30 drawing units long, DN100, levels 9.30/9.00; CDEDIT shows `Measured route: 30 mm`, `Fall: 0.300m over 0.0m (1 in 0)`, `Available Fall: 300 mm`, and "No suggestion: Neither the upstream nor the downstream pit has a known invert level". The route length is read as 30 mm, not 30 m (BUG-293 family: #491 fixed the suggestion strip but not the length display), so the fall reads "1 in 0". Flow entry could not be tested.

**Status:** OPEN (2 Oct 02:20).

---

## BUG-322

**Command / Area:** Civil label placement and redesign (from the PR #503 builder, 2 Oct).

**Symptom:** (1) after a Pit Schedule diameter edit the pipe label is re-placed with fixed millimetre offsets (`QuickModeService.CalculatePipeTextPosition`): in a metre drawing that puts it about 237 m off the pipe; all CE pipe text placement works this way (same family as BUG-243 and BUG-321). (2) `NetworkRedesignProjectDataFreezeService.CloneForApply` does not copy `ProjectReviewApprovals`, so a redesign apply may lose the drawing's approval history (the BUG-156 rule); not checked further. (3) a drawing whose locked layers keep pipes from upgrading prints the locked-layer line again on every open (#503). (4) the native lock check of #503 has never run in a real drawing (needs the enabler in AutoCAD 2027 or accoreconsole).

**Status:** OPEN (2 Oct 02:20).

---

## BUG-321

**Command / Area:** CE annotation around scaled pits in a metre drawing (from the PR #502 builder, 2 Oct).

**Symptom:** CE's label offsets, text heights and hover radius are still millimetre numbers in a metre drawing, so labels and cover text around scaled pits are placed by mm-sized offsets; the Edit Pit plan preview for a scaled pit was not looked at; running the whole Rules test namespace in one go crashes the test runner (run letter by letter); a full test run rewrites committed screenshots and creates evidence DWGs under `docs/` (BUG-318).

**Status:** OPEN (2 Oct 01:50).

---

## BUG-320

**Command / Area:** Civil paste and settings follow-ups (from the PR #501 builder, 2 Oct).

**Symptom:** (1) pasted pits were skipped silently after a paste from another drawing: the cause (pit arrived without its CE notes, or its block name not readable as a pit at paste end) is not proven; new `[PasteCheck]` log lines will settle it on the next Codex run. (2) CDREPAIR registers a pasted pit but its label still reads the old number and its labels are not linked. (3) the locked-layer sentence after a paste also counts items that failed for other reasons, so its wording can be wrong (predates #501). (4) BUG-306 is bigger than moving the recent lists: New Pit's Place saves its whole "remember last pit" block (23 fields) to `CD_Settings.json` on every placement, CD about 35 fields, more than 30 places outside the Settings window save that file. Design (two PRs): first one writer for a new `CD_RecentValues.json` (pit, pipe and recent-list values, one-time copy from the old file, guard test that placing a pit leaves `CD_Settings.json` byte-identical); second sorts the other background writers into screen memory or real settings. Nothing in Manager or the installer ships `CD_Settings.json`, so no distribution change.

**Status:** OPEN (2 Oct 01:20). Opus review of #501 (2 Oct 02:00, MERGE-WITH-FIXES, builder fixing four items) adds for BUG-306 PR 1: `Options.RememberPitSettings` is the New Pit tick box (a switch) and MUST stay in `CD_Settings.json` so "colleagues get Tim's switches" keeps working; `CD_RecentValues.json` must use the same test isolation as the settings file; the byte-identical guard must drive the real Place path; rolling back an install loses the remembered values; undecided whether the test station copies the new file. Also: CDREPAIR registers a pasted pit but its label still shows the other job's number (B2f: P32 reads P1).

---

## BUG-319

**Command / Area:** CDDESIGN areas (from the Opus confirm of PR #497, 2 Oct).

**Symptom:** (1) an area typed in Design over a CDCALC figure is agreed by Confirm setup, but on reopen Design shows CDCALC's figure and During at once reports a change ("Site area was 1000 m2, now 800 m2"): the window should say at typing time that CDCALC's figure wins. (2) Near block scale 0.8 to 0.9 a pit whose sizes were read in its own units would be judged "scaled" and come out 1/scale too big (hypothetical: real pits sit at scale 1 or 0.001). (3) If CDCALC ever stores an area with a thousands comma ("1,200") Design reads it as Unknown (not checked whether CDCALC can store one).

**Status:** OPEN (2 Oct 01:05).

---

## BUG-318

**Command / Area:** test hygiene (from the PR #497 builder, 2 Oct): (1) four `CalculationsWindowViewModelTests` fail only in some run orders and are not on the known-failure list; (2) test runs rewrite and add `docs/image/V3_WINDOWS/*.png` files in the working tree (the Opus finalizer had to restore 135 and delete 12 by hand); (3) `ManagerReleasePayload_HasTrackedManifestAndThreeLaneLocalAssets` was already red on the train for a missing target, which is why the Manager 1.1.10 status-bar drift (BUG-219) was never caught.

**Status:** OPEN (2 Oct 00:40).

---

## BUG-316

**Command / Area:** Structural settings and units follow-ups (Team lane build 02, run 5, 2 Oct).

**Symptom:** (1) SBEAM favourites and BeamCommandSettingsSnapshotReader use the strict settings reader: one bad value fails them if the start-up load failed. (2) SBEAM Place with only a locked legacy-folder file creates a standard current file. (3) RBL/RBC bar circle treats mm as drawing units in a metre drawing with no question; FREGEN, CSINFILL and CSFOOTINGLEGEND are not in the units guard. (4) ScaleFactor for an unset imperial drawing changed from 25.4 to 1 (the code comment says "same"). Merge note: #495 and #496 add at the same place in `DrawingUnitRule.cs` (trivial conflict, keep both).

**Status:** OPEN (2 Oct 00:30).

---

## BUG-315

**Command / Area:** Structural schedules (#431/#436/#485), Team lane build 02.

**Symptom:** (1) QUESTION FOR TIM: with DIMSCALE 0 and CANNOSCALE "1:1" should the schedule text stay 2.5 drawing units (today) or fall back to a 1:100 sheet height? (2) legend and infill note have the same scale/placement issues as the schedule (#436). (3) a true cut-and-paste loses an edit typed after the last footing command (the drafter is told).

**Status:** OPEN (2 Oct 00:30).

---

## BUG-314

**Command / Area:** Structural footing memory and REDO (#481 x #459 read, Team lane 2 Oct).

**Symptom:** (1) footing memory is not cleared at drawing close if FoundationMonitor never attached; pointer reuse could hand a new drawing the old register (fix: Invalidate in `RedoWindowGuard.OnDocumentToBeDestroyed`). (2) every command reads the Database before the undo-family test. (3) #481 LOW 4: `LoadCore` normal-transaction read (`FoundationRegistryService.cs:228`); the drawing-switch inventory test checks file names only; `Database.BeginSave` proof still a follow-up. (4) BUG-304 stays: the Idle redraw has never taken LockDocument (`FoundationService.cs:1593`); needs a 2024 test. **Correction (2 Oct, S-5 builder):** (4) is stale: on S-4 the Idle redraw DOES take LockDocument (#480, `FoundationService.cs:505`); what was left was its extra Undo step, moved into the editing command's own end on `claude/rel-20261004u` (BUG-334 item 1; see BUG-304). (S-5 also makes close forget the schedule out-of-date note with the footing memory: `FoundationRegistryService.ForgetDrawing`.)

**Status:** OPEN (2 Oct 00:30).

---

## BUG-317

**Command / Area:** scaled pits (from the PR #497 builder).

**Symptom:** the pit RECORD of a pit inserted at scale 0.001 still stores the scaled size (0.6 "mm"): the cause of the 0x0 mm tooltip, wrong Pit Schedule / CDCHECK sizes and a wrong detention length; Edit Pit and Resize writing sizes to scaled pits share it. #497 fixes only the reach/outline reads. Also: scaled-pit linework reads are not cached (cost on a big metre job not measured); CDDESIGN During tab does not compare the orifice head or the detention answer; MOVE logged pipe levels 9.30/9.30 after 9.30/9.00 was entered (Codex C4C, not looked at).

**Status:** OPEN (2 Oct 00:40). Opus CONFIRM of #502 (2 Oct 03:10, MERGE at 84ff3116) leaves two traps: (a) typing a size in Edit Pit on a scaled pit that is NOT a units change (unitless drawing at 0.001, metre drawing at 0.002) still writes the number as drawing units (900 gives a 900 m pit): today's behaviour kept on purpose; (b) CDREBUILD's "not changed" line gives the wrong "block's own size" for pits scaled up 1.0 to 1.78 times (from #497's linework check including the wall). Added 2 Oct 01:00 from the Opus review of #497: (4) an offered council accepted from the job folder or letters, then Close, is silently not kept (no "not saved" line); (5) areas taken from the STORM report are saved by Save Draft as if typed, so where they came from is lost on reopen; (6) the Manager version guard (`ManagerReleasePayload_HasTrackedManifestAndThreeLaneLocalAssets`) has been red since the missing `PrepareReleaseCandidateRoot` target; (7) two IL-shape tests (FinalLandingProducer..., RefusedNativeCallback...) fail on the base tip in a Debug build and are not on the known-failure list.

---

## BUG-313

**Command / Area:** Civil native C++ (`CeCvlObjectsApi.cpp` lines 66, 96, 217, 243), from the Opus finalizer of train C-5 (1 Oct).

**Symptom:** the native code still opens items for write on locked layers (not audited by #489's locked-layer sweep, which covered the C# paths). Needs the same locked-layer rule: skip, never unlock, one plain line.

**Status:** OPEN (1 Oct 23:55).

---

## BUG-312

**Command / Area:** Pit Schedule refresh, from #489 (disclosed by its builder).

**Symptom:** labels held back because their layer was locked are remembered only in memory; after the drawing is closed and reopened, Refresh cannot bring them up to date.

**Status:** OPEN (1 Oct 23:55).

---

## BUG-311

**Command / Area:** CDRUNSOLVE / CDPROPAGATE cancel (#492, disclosed by its builder).

**Symptom:** while either command waits at a prompt, a change made in a CE palette is rolled back too if the command is cancelled (the record cannot tell a palette write from a refresh write). Needs Tim's decision: accept, or make palette edits wait.

**Status:** OPEN (1 Oct 23:55).

---

## BUG-310

**Command / Area:** OOPS after erasing a copied pipe (#490), from the Opus finalizer of train C-5.

**Symptom (edge, not confirmed possible):** if two objects ever share one identity key, OOPS can bring a pipe's labels back against the other object's schedule row.

**Status:** OPEN (1 Oct 23:55).

---

## BUG-309

**Command / Area:** plan label grade after a Pit Schedule edit in a METRE drawing (pre-existing, found by the Opus finalizer of train C-5).

**Symptom:** the label update after a Pit Schedule edit works out the grade as if the drawing were in millimetres, so a metre drawing gets a wrong grade on the pipe label.

**Status:** OPEN (1 Oct 23:55).

---

## BUG-308

**Command / Area:** Civil CD pipe end linking, CDDESIGN setup persistence and footer (Codex VERIFYC4C on installed Civil 3.0.18, 1 Oct 2026, report `CODEX_VERIFYC4C_2026-10-01.md`; 37 in scope, 14 tested: 7 PASS, 4 FAIL, 3 engineering REPORTED; 23 not tested).

**Symptom:** (a) CD first point 80 mm outside a 600 mm pit wall (pit scaled 0.001, INSUNITS 6, metre drawing): pipe stays an open end, review says "Unresolved" (same family as BUG-270/287, reach in metre drawings). (b) CD pipe arriving at 17 degrees: the end links to the pit but the last vertex lands about 1 mm from the pit centre, not on the wall (check whether centre landing is the intended rule). (c) CDDESIGN: council, site area and head are not remembered on reopen after Confirm setup or Save Draft; During says "Nothing has changed since the design was agreed" (BUG-259 family, not fixed in 3.0.18). (d) Save Draft / Confirm LPD / Confirm setup are on the Start tab only; the other four tabs show Next missing input / Work out design / Close (may be an intended layout; needs Tim's ruling). Also seen: Manager status bar still reads v1.1.10 (BUG-219); pit tooltips show 0x0 mm after true-size scaling; MOVE logs linked pipe inverts 9.30/9.30 after an initial 9.30/9.00.

**Status:** OPEN (1 Oct 23:25). Route (a)(b) with BUG-270/287, (c) to a CDDESIGN persistence builder, (d) ask Tim.

---

## BUG-307

**Command / Area:** Civil AutoDesign back-test `BackTest_GlenEira24115` (pre-existing, found 1 Oct by the PR #491 builder and confirmed on base 3.0.19 by the Opus review).

**Symptom:** stored volume (SSR) 1.69 m3 against the sheet's 2.58 m3 (34.6% off the 30% allowance); discharge (PSD) 6.54 against 5.87 L/s. AutoDesign is the Boyd's storage engine and does not use pipe cover. Probable cause (not verified): job 24-115 in the test does not fix the after-development soft-ground figure at 0.35 as job 23-129 does, so it runs on the newer 0.30 default. Whether the TEST or the ENGINE is wrong is an engineering question (report both figures to Tim).

**Status:** OPEN (1 Oct 23:15)

---

## BUG-306

**Command / Area:** Civil New Pit (and other commands): automatic write of `CD_Settings.json` (Codex VERIFYC4B X1, 1 Oct 21:10).

**Symptom:** continuing New Pit placement in DWG-A wrote `%APPDATA%/TIM_CE_CADTOOLS/CD_Settings.json` (14283 bytes): log 'Settings saved successfully' with no Settings window opened (the recent-values save). Not a defect by design (recent diameters/materials/inverts are remembered), but it violates test passes that must not change settings; and it is the same path the PR #477 builder hardened. Decide: keep (documented) or move recent values to a separate file so CD_Settings.json only changes when the user saves Settings.

**Status:** OPEN (1 Oct 22:55)

---

## BUG-305

**Command / Area:** Civil paste from another drawing (PR #474), Codex VERIFYC4B B2b/B2c/B2d (1 Oct, installed 3.0.18).

**Symptom:** pasted pits/pipes from DWG-A into DWG-B get their own CE keys and no schedule record (good) but NO command-line line pointing to CDREPAIR (expected one line per paste), CDREPAIR then registers them (B2f PASS: P30..P32, label still reads P1); pasted pit labels stay behind when the pasted body is moved with native MOVE (pit body moved, both labels stayed). Also B2a: Ctrl+C in DWG-B failed with 'Copy to clipboard failed' even for a plain LINE (native/clipboard environment, cause Unknown).

**Status:** OPEN (1 Oct 22:55)

---

## BUG-304

**Command / Area:** Structural S-3 sign-off (1 Oct): footing follow on AutoCAD 2024.

**Symptom:** the queue-47 check 2 (does ONE U take back both a footing MOVE and its redraw) cannot be settled on 2027: the footing follow never runs there (BUG-279 item 0, PR #480 held out of S-3). On AutoCAD 2024 the follow now runs at Idle with no lock, so it may stop following a MOVE after #481/#459. Untested (no 2024 on this PC).

**Correction (2 Oct, S-5 builder, BUG-334 item 1):** stale since S-4: #480 runs the follow on 2027 and takes `LockDocument` at Idle (`FoundationService.cs:505` on c84a3629), which is its own Undo step. Branch `claude/rel-20261004u` (S-5) moves the redraw into the editing command's own end (`FoundationMonitor.OnCommandEnded`); the AutoCAD 2027 core console measured one U taking back MOVE or ERASE plus a write made in its CommandEnded under the lock (receipts `C:\Autodesk\CERef\Colleague-20260913\verification\claude-s5-bug334-undo-probe\`). Still open here: AutoCAD 2024/2025/2026 not measured; full AutoCAD window and grip edits need Codex.

**Status:** OPEN (1 Oct 21:25)

---

## BUG-303

**Command / Area:** Structural, S2 Opus adversarial reviews, default-on findings not filed before: ADV2 M2 (the footing and R.C beam schedules stay stale after FST delete or ERASE), ADV2 M4 (inserting one row by hand files the depth under REINFORCEMENT silently), ADV4 H1 (a copied footing still acts as the original), ADV5 H1 (CSLOADPATH checks the wrong point); lower: ADV2 L6/L7, ADV3 L4, ADV4 M3, ADV5 M2/M3/M10/L12 (files in C:\Lisp Files\_TEST_COPIES_20260923\S2_OPUS_ADV_*.md).

**Status:** OPEN (1 Oct 21:25)

---

## BUG-302

**Command / Area:** Structural PR #482 wording: the code cites 'Tim's ruling for #457' (unset units: measure nothing) but that ruling is not in decisions/; after a Yes in a metre drawing the FADOPT label search reaches 1000x too far (as in 1.0.87).

**Status:** OPEN (1 Oct 21:25)

---

## BUG-300

**Command / Area:** Structural footings: OOPS after ERASE of a footing line (PR #480 review, 1 Oct).

**Symptom:** Opus review of #480: OOPS brings the line back, but the footing stays 'set aside' and the outline is not redrawn: nothing clears the set-aside flag and the redraw skips set-aside footings (`FoundationService.cs:1651`). After ERASE then one U: the outline and footing record come back but the LINE stays erased (the PR's own step (d) fails as written). #480 itself is held out of train S-3: its Idle redraw runs once per changed line under its own document lock (each an extra undo step: STRETCH across 5 strip lines = 5 redraws, 6 U to undo); the lasting fix is to redraw inside the drafter's own command or group per system/per drawing.

**Status:** OPEN (1 Oct 20:20)

---

## BUG-299

**Command / Area:** Structural settings save (PR #483), follow-ups from the Opus confirm (1 Oct).

**Symptom:** (1) after a failed swap there is no settings file: the next start loads standard values with no warning (the kept temp file is never read back); (2) the save dialog's 'may have changed' wording contradicts 'Not saved'; (3) the CESETTINGS banner adds the message again on every refused save.

**Status:** OPEN (1 Oct 19:55)

---

## BUG-298

**Command / Area:** Civil: CDFIXPIPEENDS can half-change a pipe record if it throws (`LinkService.PipeEndRepair.cs:161-166`); the 'Pipe X was not changed' line can be false.

**Symptom:** Opus ADV 2 LOW 8 (C-3 review, 1 Oct); the dropped-tracking path in #484 only logs (finalizer LOW).

**Status:** OPEN (1 Oct 19:00)

---

## BUG-297

**Command / Area:** Civil Edit Pipe: pits are still found by 'within 100 mm of the insertion point' (`PipeTruthResolverService.cs:651`).

**Symptom:** Opus ADV 4 MED 6: since the 29 Sep wall snap, new pipe ends no longer sit near the insertion point so that match never succeeds for new pipes.

**Status:** OPEN (1 Oct 19:00)

---

## BUG-296

**Command / Area:** Civil #478 (units): the lower-impact raw millimetre distances it did not convert (list in the PR #478 body; includes `CheckHitboxOverlap`, `SourcePlacementService`, Xcivil import, the recovery 200 mm matches).

**Symptom:** the C-4 sign-off (1 Oct): open, not filed before.

**Status:** OPEN (1 Oct 19:00)

---

## BUG-295

**Command / Area:** Civil Undo/Redo, C-3 Opus ADV 1 LOW 5, 6, 8: the redo window may release early on Properties/Help/similar commands; held work restarts at the next command's START not END (a typed MREDO waiting for its count could see Inspector-page work run in that gap); U then QSAVE: held writes run after the save so CLOSE asks 'Save changes?' (nothing lost); also the RedoSafe guard test does not see inside async methods (two command starts missed: `PitCoverTextFlipGripOverrule.cs:178`, `PipeAttachmentActionRequestQueue.cs:248`) and the N-names in the frozen baseline can hide a new lambda.

**Symptom:** all need measuring in AutoCAD first (Codex REDO matrix).

**Status:** OPEN (1 Oct 19:00)

---

## BUG-294

**Command / Area:** Structural tests that read and REWRITE Tim's real `CS_Settings.json` (`%APPDATA%\CE_STRUC_SUITE`).

**Symptom:** found by the PR #483 builder (1 Oct): `UnitCopyReviewTests`, `UnitDefaultOffReviewTests`, `UnitRoundTwoReviewTests` and `StrucDebugTests` read `SettingsService.Current` with no temp override (`CE_STRUC_SUITE_APPDATA_ROOT`), so a test run on Tim's PC loads (and, via the recent-value saves, rewrites) his REAL settings file. Same family as the 28 Sep memory 'tests can touch Tim's real files' (a test run truncated his live Structural log).

**Expected behaviour:** every test uses the temp-folder override through one shared fixture; a guard test fails if a test touches the real %APPDATA%.

**Status:** OPEN (1 Oct 19:10). 2 Oct 00:30: fix (shared fixture CeStrucTmpRootSetUp, PR #483) is in the installed Structural 1.0.88 train S-3; not closed until a test run on Tim's PC is seen to leave CS_Settings.json untouched.

---

## BUG-293

**Command / Area:** Civil Edit Pipe grade suggestion in METRE drawings (`PipeEditCommand.GradeSuggestion.cs:77`): still divides drawing units by 1000.

**Symptom:** Opus review of PR #478 (1 Oct): it now disagrees with Project Review for the same pipe in a metre drawing (the size writer length is converted in #478; this strip is not). Related to BUG-287: in a drawing whose UNITS are Metres but whose CE pits are millimetre-sized, #478's converted size-writer length reads a 30 m pipe as 30 km and the slab outlet check falsely reports ponding.

**Expected behaviour:** one unit conversion for every strip and the size writer; BUG-287's detection warns before any of them runs on a mixed-units drawing.

**Status:** OPEN (1 Oct 17:20)

---

## BUG-292

**Command / Area:** Civil Edit Pipe: when a pipe has no stored drawn-end levels the boxes are filled in RECORD order (`PipeEditCommand.DataCollection.cs:98-104`).

**Symptom:** Opus ADV 4 (MED 6) and the PR #473 builder (1 Oct): a downstream-first pipe could be reversed by a plain Save; the fix touches the #437 sizing reader, which relies on the record order, so it is its own change.

**Status:** OPEN (1 Oct 16:05)

---

## BUG-291

**Command / Area:** Civil CDEDIT batch 'Design grade' and the single editor's 'work it out from the grade': both hold the FIRST DRAWN END's level as upstream.

**Symptom:** PR #473 builder (1 Oct): a pipe drawn from its downstream end can turn round when Design grade is used, as in 3.0.17; holding the recorded upstream end needs the grade auto-calc, the batch preview and the carry-downstream step to be direction-aware.

**Status:** OPEN (1 Oct 16:05)

---

## BUG-290

**Command / Area:** Civil: several commands run a full refresh of the pipe records from the drawing BEFORE their own preview or question: CDRUNSOLVE, CDAGI, CDSTRIP, CDPROPAGATE, CDUPGRADE (CDFIXPIPEENDS and CDCHECK are fixed/read-only in PR #473).

**Symptom:** the refresh (`ProjectDataService.RefreshPipeMetadataFromDrawing`, :1038-1041 and :1052) overwrites pipe levels without checking the hand-typed override flags and saves immediately; 'No' or Escape cannot roll it back. Found by Codex review c3rev1 (1 Oct, HIGH on CDFIXPIPEENDS) and the #473 builder.

**Expected behaviour:** the refresh respects the typed-override flags and does not write before the command's own question; each preview-first command reads read-only first.

**Status:** OPEN (1 Oct 16:05)

---

## BUG-289

**Command / Area:** Civil CDFIXPIPEENDS (PR #460): it does not refresh the drawn Pit Schedule or turn the flow arrows after a repair.

**Symptom:** Opus adversarial review of C-3 (ADV 4, 1 Oct, LOW): after the repair the schedule and arrows stay as drawn until the next refresh; also the pipe-end join (PipeEndJoin.cs) has its own separate unit conversion (one pattern wanted).

**Status:** OPEN (1 Oct 15:10)

---

## BUG-288

**Command / Area:** Civil far-COPY relink (PR #450): the "open end anywhere" rescan was dropped.

**Symptom:** Opus ADV 4 (1 Oct, MED): a downpipe copied onto an existing OPEN pipe end, together with a pit, is no longer relinked after #450's scope change.

**Status:** OPEN (1 Oct 15:10)

---

## BUG-287

**Command / Area:** Civil, drawings whose UNITS are Metres but whose CE pits are millimetre-sized (PIT inserts at scale 1: `PitCommand.cs:343-347`).

**Symptom:** Opus ADV 4 (1 Oct, HIGH design question): after #453 every reach is 0.1 m, i.e. 1000 times tighter than 3.0.17 in such a drawing: a pipe end 50 mm outside a pit, a branch 20 mm off a main, linked in 3.0.17 and no longer link; nothing warns. The Unitless note (`DrawingAreaUnits.cs:130-133`) can also fire for a millimetre drawing at MGA coordinates and send the user to UNITS, which leads into this.

**Expected behaviour:** detect a pit block size that disagrees with the drawing units and warn once in plain English before linking differently; Tim's ruling on what the office does with such drawings.

**Status:** OPEN (1 Oct 15:10)

---

## BUG-286

**Command / Area:** Civil CD to a pit on a LOCKED layer (BUG-254 family, PR #469).

**Symptom:** Opus ADV 2 (1 Oct, MED): the pit's pipe list is skipped, so the link is one-sided: a later pit MOVE leaves the pipe behind, and "run the command again" would draw a second pipe.

**Status:** OPEN (1 Oct 15:10)

---

## BUG-285

**Command / Area:** Civil pipe OOPS (the pipe half of #443/#460).

**Symptom:** Opus ADV 2 (1 Oct, MED): erase a pipe and OOPS: it comes back bare (no band, labels, arrow or record) and its pits no longer list it, so it stays behind on a later pit MOVE; erase it with its pit and OOPS puts the pipe record back (#460) but not the labels.

**Status:** OPEN (1 Oct 15:10)

---

## BUG-284

**Command / Area:** Civil: other places that open an item on a LOCKED layer for write without unlocking it (about 15; from the PR #469 builder, 1 Oct).

**Symptom:** the PR #469 work removed the unlock-write-relock bypass (BUG-254) but found about 15 more places that open locked-layer items for write directly; some may throw or silently skip, none is audited. Each needs its own look: the native protection rule says respect locked layers, say plainly what was skipped, never crash.

**Expected behaviour:** every write to a locked-layer item is skipped with one plain line (layer named) or refused cleanly, never an exception.

**Status:** OPEN (1 Oct 13:00)

---

## BUG-283

**Command / Area:** Civil CDIMPORTXCIVIL: unlocks about 20 layers for the whole import and relocks them afterwards (`XcivilImportService.cs:1500/1545`).

**Symptom:** found by the PR #469 builder and Opus review (1 Oct): the only layer unlock left in Civil; recorded only in the debug log. The native protection rule says never silently unlock; simply not unlocking would make the import fail part-way.

**Expected behaviour:** a reviewed workflow: either skip-and-warn per locked layer, or an explicit Yes/No in the import window naming the layers (Tim's command review first).

**Status:** OPEN (1 Oct 13:00)

---

## BUG-282

**Command / Area:** Civil cover-depth strips: Smartify, RunSolve, AutoDesign and NetworkRedesign still use a fixed 600 mm cover.

**Symptom:** found in the PR #470 review (1 Oct): Edit Pipe and Project Review now use the rulebook cover (Settings 'Minimum cover depth', office default 300 mm: Tim 24 Sep "300 mm, like mine"); these four paths still hard-code 600. (The New Pipe/CD strip is fixed inside #470.)

**Expected behaviour:** one helper, one cover value from the rulebook (council, then project, then office) everywhere.

**Status:** OPEN (1 Oct 13:00)

---

## BUG-281

**Command / Area:** Civil downpipe sources: the saved source connection radius (150) is written raw into each downpipe's saved record (`SourceTagService.cs:617-618`).

**Symptom:** found in the PR #470 review (1 Oct): in a metre drawing the downpipe split check and the pipe-end-on-downpipe match still use 150 m (`Split.cs:385`, `Geometry.cs:1350-1354`); not a regression (was 220 m).

**Expected behaviour:** the radius is stored in millimetres with a unit tag (or converted when read) so metre and imperial drawings use the right reach; a saved-record format change: needs the persistence rules (optional field, old builds ignore).

**Status:** OPEN (1 Oct 13:00)

---

## BUG-280

**Command / Area:** Civil and Structural: the "redo window" rules (hold background work after U/REDO until the next command) exist as TWO copies.

**Symptom:** found by the review lane (PR #459, 11:29, rule #1 one code path per behaviour): Structural `RedoWindowRegistry.cs` / `RedoWindowGuard.cs` (PR #459) and Civil `Modules/Drainage/Services/RedoWindowGuard.cs` (PR #452) hold the same rules; they have already drifted (Structural has the LISP-end re-arm, Civil does not).

**Controller decision (1 Oct 12:25, controller 06):** two copies are ACCEPTED for the colleagues' release because Civil and Structural ship as separate bundles from separate branch chains and a shared source file would have to live in CE_SHARED (Civil + Manager one assembly identity; Structural's own CE_SHARED copy is unrelated). CONVERGE DATE: before the unified single-plugin host (V3 cutover): one AutoCAD-free source file linked into both, and the LISP-end re-arm added to Civil. Until then any change to one copy is mirrored into the other in the same train, and a parity test pins the shared rule table (UNDO sub-options that do not open the window: BEGIN, END, MARK, CONTROL, GROUP, AUTO).

**Status:** OPEN (1 Oct 12:25)

---

## BUG-278

**Command / Area:** Civil Edit Pipe + Save after the CDFIXPIPEENDS repair (PR #460): Save can break a repaired pipe again.

**Symptom:** found by the PR #460 builder (1 Oct): `LinkPipeEndpointsToPits` (`LinkService.RepairAudit.Linking.cs:333`) writes From/To in the pipe's DRAWN order, so an Edit Pipe + Save on a pipe the repair just fixed (From/To against the drawn direction) can put it back to the drawn order. Same family as the one-upstream rule (BUG-260/261/268).

**Expected behaviour:** Edit Pipe + Save keeps the recorded flow direction (From/To) and never rewrites it from the drawn order.

**Reference:** PR #460 body; `LinkService.RepairAudit.Linking.cs:333`.

**Status:** OPEN (1 Oct 12:15)

---

## BUG-277

**Command / Area:** Structural reinforcement bars (PR #440): grip-stretch of a bar does not update the live length.

**Symptom:** reported by worker 1 (log, 1 Oct): "#440's grip-stretch live length" has no queue or carpark line. Details are in the worker log (release-v3-colleagues-TEAMLANE_LOG.md, lines 38-44) and the #440 PR comments.

**Expected behaviour:** dragging a bar's grip shows the live length and the label follows.

**Status:** OPEN (1 Oct 11:50)

---

## BUG-276

**Command / Area:** Structural plan level record (PR #430, slice 0): a level set before the first save carries into a SAVEAS copy.

**Symptom:** found by the review lane at 15:27 (worker 1 log line 44): a confirmed level set before the drawing is first saved is carried into a SAVEAS copy, so the copy shows a confirmed level it never had. Related to the F05 fix (copy of the same file name in another folder keeps a confirmed level).

**Expected behaviour:** a copy made by SAVEAS or copy-to-another-folder shows the level as an unconfirmed suggestion until the drafter confirms it (canonical source path compared).

**Status:** OPEN (1 Oct 11:50) - fix built on PR #430 head 841c35ec by team lane 01 (13:34): once the drawing has a name, a level set before the first save is a suggestion until confirmed once; NOT AutoCAD-tested; Opus review required.

---

## BUG-274

**Command / Area:** Structural footings (FoundationMonitor): U after any command that changes a footing driver (PFC, SF, REB, RIB, THC, FEDIT, the CE footing grip CSFOOTINGGRIPEDIT, AutoCAD's own grips or MOVE on a footing line).

**Symptom (read in code by the Opus review of PR #449, 1 Oct; not yet seen in AutoCAD):** `FoundationMonitor.cs:143-147, 164-190` listens to ObjectModified and ObjectErased with no check for UNDO in progress. After U, the restored driver is queued, and at the next idle `RegenerateSystem` erases and redraws the footing outlines outside any command. That new change makes REDO say "Nothing to redo" and marks the drawing changed. Probably part of the BUG-256 REDO family for Structural.

**Expected behaviour:** U puts the footing back exactly as it was and REDO works; the monitor does nothing while AutoCAD is undoing or redoing.

**Test that catches it:** a monitor test: a driver change seen while UNDO or REDO is the active command is not queued.

**Steps to confirm the fix (Codex, AutoCAD 2027, a copy):** `PFC` a pad, press U, then REDO. Right: REDO brings the pad back; the drawing is not marked changed after U.

**Status:** OPEN (1 Oct 12:40).

---

## BUG-273

**Command / Area:** Structural commands that save the job file beside the drawing: CSUNITTOOLS / CSUNITCOPY, CSSOILREPORT, the wind class command, CSBSMTWALL.

**Symptom (read in code by the Opus review of PR #455, 1 Oct; not seen in AutoCAD):** when the job-file save fails (BUG-272 in 2027, or a real file problem such as a OneDrive lock or a read-only folder): the unit commands write the warning only to the log (`UnitCopyCommands.cs:69-70`, `:307-308`, `SoilAndWindCommands.cs:286-287`), so nothing shows on the command line; CSSOILREPORT and the wind class command (`SoilAndWindCommands.cs:119`, `:216`) do not catch it, so the drafter reads `[CE_STRUC] CSSOILREPORT error: Method not found ...` (raw code text, `CeStrucCommandBase.cs:122`) and "Confirmed and saved" never prints; CSBSMTWALL saves after drawing (`BasementWallService.cs:61`, `:67`), so the walls ARE drawn but the drafter reads "Basement wall layout not completed: ...".

**Expected behaviour:** one plain line, the command finishes normally: "[CE] The drawing is updated, but the job file beside it could not be saved (<reason>). Nothing on the drawing is lost."

**Test that catches it:** a seam test that makes the job-file save throw and checks each command prints that line and reports success for the drawing part.

**Steps to confirm the fix (Codex, AutoCAD 2027, a copy):** make the job file beside the drawing read-only, run CSSOILREPORT and confirm a value. Right: the plain line above, no "error:" text, and the drawing keeps the soil report.

**Status:** OPEN (1 Oct 12:00). Not a regression: with BUG-272 fixed (#455) it fires only on a real file problem.

---

## BUG-272

**Command / Area:** Structural job data (the sidecar job file next to the drawing) in AutoCAD 2027: every save of the job data. Seen during CSUNITTOOLS / CSUNITCOPY (Codex VERIFYS1 W5/W7, 1 Oct).

**What happened:** eight warnings in the Structural log: "The drawing keeps the unit choice; the old job cache could not be refreshed." followed by `System.MissingMethodException: Method not found: 'System.String Newtonsoft.Json.Linq.JToken.ToString(Newtonsoft.Json.Formatting)'` in `ProjectDataService.SerializeForFile` / `ProjectDataService.Save` (log `ce_struc_structured_20261001.log`). The drawing kept the choice; the job file was NOT written.

**Expected behaviour:** the job file saves without an error in every AutoCAD version.

**Cause (read in code, team lane 01):** `ProjectDataService.cs:160` calls `json.ToString(Formatting.Indented)`. AutoCAD 2027 loads its own older Newtonsoft.Json first and that copy has no such method (the same trap fixed in MARKUPAI-NEWTONSOFT and ConnectedStructuralRecordCodec). Unit tests do not see it because the test runner loads CE's newer copy.

**Test that catches it:** a source guard: no Structural code calls `JToken.ToString(Formatting)`; plus the existing SerializeForFile tests still pass with the replacement call.

**Steps to confirm the fix (Codex or Tim, AutoCAD 2027, a copy):** CSUNITTOOLS ON, CSUNITCOPY one unit, then read the Structural log for today: right = no "Method not found" line and no "old job cache could not be refreshed" warning; the job file beside the drawing has today's time.

**Status:** OPEN (1 Oct 10:25), being built by team lane 01.

---

## BUG-275

**Command / Area:** Structural drawing-health palette (MainPalette): compares the drawing's Database object by reference.

**Symptom:** found by the PR #459 builder (1 Oct): `MainPalette.AttachEntityDeltaTracking` compares `doc.Database` by reference; on AutoCAD 2027 every read of `doc.Database` is a new managed object, so the comparison always fails and the event handlers are attached again on every health scan (handler build-up, wasted work).

**Expected behaviour:** compare by Equals / the Document object (stable), attach once per drawing.

**Reference:** `Modules/Structural` MainPalette.AttachEntityDeltaTracking; the 2027 Database identity facts in queue section 3G.

**Status:** OPEN (1 Oct 11:55)

---

## BUG-271

**Command / Area:** Civil pit/pipe search in non-millimetre drawings: the remaining fixed distances (same family as BUG-230 and BUG-270).

**Symptom:** found by the PR #453 builder (1 Oct): these literals are still plain drawing units, so a metre or imperial drawing reads them wrongly: `PipeTruthResolverService.PitLookupTolerance` (100), the report-only 500 mm snap check in the repair audit, `SourceOwnerHitPadding` (40) and `SourceOwnerFallbackRadius` (220) for downpipe sources, `PitOutline.WallSnapToleranceMm` (5). Also: a UNITLESS drawing (INSUNITS 0) still reads reaches as millimetres (deliberate: a search must never refuse to link; a follow-up may warn when the coordinates are plainly metres).

**Expected behaviour:** every reach comes from Settings in millimetres and is converted to the drawing's units; unitless drawings get a plain-English note instead of a silent wrong search.

**Reference:** PR #453 body and the Opus review of it. Opus review of #453 also lists: branch-junction tolerance `CivilSpineProjector.JunctionToleranceMm` (NewPipeEnds.cs:28, EndpointPreview.cs:288, BranchJunctionDisplay.cs:44, TextClashTidyUp.cs:710, SpineCheckCommand.cs:77), pit-record lookup PipeTruthResolverService.cs:17/648, SlabCommand.cs:1140 (500), BreaklineAnchorMath.cs:285-291 (50), Registration/Split ConnectionHitboxRadius, a pit with a missing block falls back to its mm sizes (PitOutline.cs:90, 600 m wide in a metre drawing), unitless drawing with 6-digit eastings should warn.

**Status:** OPEN (1 Oct 09:50)

---

## BUG-270

**Command / Area:** Civil pit relink and pit/pipe-end search in METRE drawings.

**Symptom:** the search reaches are fixed at 100 mm around a pit and are not converted for the drawing's units, so in a metre drawing they read 100 m or 0.1 mm depending on the path (same family as BUG-230). Found by the Opus review of PR #450 (1 Oct); not a regression.

**Expected behaviour:** reaches come from Settings in millimetres and are converted to drawing units.

**Reference:** `LinkService.RepairAudit.Relink.cs` (~:623, :906), `LinkService.Geometry.cs:1257-1260`, `LinkService.PitOutline.cs:394-405`.

**Status:** IN PROGRESS (1 Oct 09:50): draft PR #453 (head 777845f3) built and unit-tested only, Opus review running, not yet in AutoCAD

---

## BUG-269

**Command / Area:** `-ARRAY` (or COPY of many CE pipes) in Civil: clean-up time.

**Symptom:** arraying 299 pipes spends 48.8 s in CE's clean-up: each copied pipe's band, labels and arrow are redrawn one at a time (about 163 ms each; `CloneRegeneration.cs:22-60`). Found in the Codex logs (VERIFYC1 V10) and confirmed by the PR #450 review.

**Expected behaviour:** one batch, one transaction where possible, with a quiet progress line.

**Status:** OPEN (1 Oct 09:40)

---

## BUG-268

**Command / Area:** Civil pipes copied with a pit COPY in 3.0.16 (BUG-260 / V2.01): already saved wrong.

**Symptom:** a pipe whose record was written wrong by the copy-time level read-back (From level on the first drawn end: `from=18.50 to=19.00`, then `from=P5 to=`) stays wrong: PR #444 fixes NEW copies only; Edit Pipe + Save does NOT repair it (Save writes the names, `RegisterPipe` -> `LinkPipeEndpointsToPits` puts the old From back, and the old pit keys are copied from the old row).

**Expected behaviour:** a repair command (CDSYNC / CDUPGRADE style) in a command, one Undo, a per-pipe log line ('Pipe 114438: From P5 -> P1 because its levels ...'), names AND keys moved together, never touching a correct pipe.

**Reference:** PR #444 (Opus round 2, 1 Oct); `PipeEditCommand.Update.cs:539,1547,1565`; `LinkService.RepairAudit.Linking.cs:288-335`.

**Status:** OPEN (1 Oct 05:00)

---

## BUG-267

**Command / Area:** OOPS after erasing a PIT (Civil): its labels / linked text.

**Symptom:** hypothesis only: the same gap as the perimeter drain PD text (BUG-258): CE erases linked text at the end of ERASE, OOPS restores only what ERASE picked. PR #443 fixes the perimeter drain only (an ERASE of a pit then OOPS was checked to touch no text); not measured in AutoCAD for pits.

**Expected behaviour:** OOPS returns the pit with its labels and links.

**Status:** OPEN (1 Oct 05:00) - measure first (Codex), then mirror the #443 approach.

---

## BUG-266

**Command / Area:** COPY of a pit in a large Civil drawing (304 pipes): speed.

**Symptom:** a COPY of one pit placed FAR from every pipe took 5.3 s to relink (two COPY Multiple + Escape 4.8 s); regenerating 299 copied pipes spans 48.8 s in the log. Suspected cause: after the train fixes every pipe with a blank end is rescanned as a candidate on any pit copy (Codex verification VERIFYC1, 1 Oct, V10). May be new in 3.0.16 (train fix A2).

**Expected behaviour:** a far COPY touches only pipes near the new pit; bulk work shows a quiet progress line.

**Reference:** `LinkService.RepairAudit.Relink.cs` candidate-3 pipes (A2 round 3), `LinkService.PitRelinks.cs`; evidence `C:\Lisp Files\_TEST_COPIES_20260923\VERIFYC1\` ([PERF] lines).

**Status:** OPEN (1 Oct 04:20) - measure against the previous install (3.0.15) first.

---

## BUG-265

**Command / Area:** Structural drawings with both suites loaded: activation of a Civil drawing prints `[CEADMIN] Runtime health RESTART RECOMMENDED (document). Restart AutoCAD now (recent hotspots 0)`.

**Symptom:** a restart request with "recent hotspots 0" gives no actionable reason; the activation is not quiet (Codex VERIFYS1 W10.02, 1 Oct). Structural placement also prints `[SUPPORT-DEBUG]`, `[CE-TEXT-DEBUG]`, `[BEAM-DEBUG]` lines during routine work with no debug switch on (W1).

**Expected behaviour:** activating a drawing is quiet; a restart request only with a specific current cause; diagnostic detail goes to the log.

**Status:** OPEN (1 Oct 04:20)

---

## BUG-264

**Command / Area:** CE STRUC ribbon > Annotate: the text, hatch and symbol flyouts run below the screen edge and cannot be scrolled; repeated labels do not distinguish commands (Codex VERIFYS1 W6.01, 1 Oct).

**Expected behaviour:** bounded, scrollable task lists with one visible entry per action.

**Status:** OPEN (1 Oct 04:20) - Codex window/ribbon item.

---

## BUG-263

**Command / Area:** XCLMTXT review window (Structural 1.0.87): "1 issue / 1 active" with a blank Issues area (Codex VERIFYS1 W4.02, 1 Oct).

**Symptom:** the one active review item has no visible row (accessibility sees "Low-confidence floor guess / Member C1 has no floor in the source / Accept suggested floor: First Floor / 68%"), so the drafter cannot review it; Re-analyze gives the same. The banner also says two rows were fixed from past jobs while the header says past-job evidence is not built yet.

**Expected behaviour:** a visible, selectable issue; corrections show their real source.

**Reference:** unit tools OFF; parity with 1.0.86 not established (no baseline run).

**Status:** OPEN (1 Oct 04:20)

---

## BUG-262

**Command / Area:** Civil messages for locked or skipped items (Codex VERIFYC1 V4.01, V5.04, V6.02, V8.07, 1 Oct).

**Symptom:** the command line names a handle or a count, not the item: "114438 (a pit or source it joins is locked)" does not name the pit or its layer; "1 pit schedule cell is on a locked layer" does not name the cell, pit or layer; editing a COPIED schedule cell says only "Pit updated." and the foreign cells are not named; a locked invert-text layer leaves the stretched geometry with old labels detached and says "Run CE Repair/Audit".

**Expected behaviour:** plain names (pit/pipe number, layer, schedule column) and one clear recovery action; a foreign copied cell is named when skipped.

**Reference:** train fixes A2 / B messages; `ScheduleLinkService.cs` (B round 2), `LinkService.RepairAudit.Relink.cs`.

**Status:** OPEN (1 Oct 04:20)

---

## BUG-261

**Command / Area:** Edit Pipe two-free-end pipe, size-only save (Civil 3.0.16): false uphill warning (Codex VERIFYC1 V8.11, 1 Oct).

**Symptom:** draw a pipe with two free ends (levels 10.00 left, 11.00 right), Use level direction (arrow flows 11 -> 10, 1 in 12): change only the diameter 100 -> 150 and Save: "[CE] Warning: Pipe flows uphill — upstream IL 10.000 is 1000mm lower than downstream IL 11.000", though the window and arrow show it flowing downhill.

**Expected behaviour:** no contradictory warning (the BUG-198 / #404 / #407 two-open-ends case).

**Status:** OPEN (1 Oct 04:20)

---

## BUG-260

**Command / Area:** Civil Edit Pipe header / end fields / drawn arrow / Pit Schedule disagree about which pit gets which level (Codex VERIFYC1 V1.01, V2.01, V5.01, 1 Oct).

**Symptom:** right after CD with Use level direction, Edit Pipe says "Flow: P1 → P1", upstream 18.50 and downstream 19.00 with the warning "upstream invert is lower than downstream", while the drawn arrow and labels (18.50 left, 19.00 right) are correct; after copies the Pit Schedule lists OUTLET 100 / 19.00 against the physical end; after reversing a pipe with a typed 17.50 the header says P3→P9 while the arrow points from 17.50 towards 18.50. Whether the stored From/To is wrong or only the display is Unknown.

**Expected behaviour:** one consistent physical-end and direction result in every view.

**Reference:** A1 resolver changes, #410, #422; evidence VERIFYC1 screenshots V1_baseline_EditPipe.png, V5_reverse_record_17_50.png.

**Status:** OPEN (1 Oct 04:20) - diagnose from the installed build; Opus.

---

## BUG-259

**Command / Area:** CDDESIGN Confirm setup (Civil 3.0.16, #432): after "Confirm setup" the window reopens on Start without the picked outlet and During shows no agreed design (Codex VERIFYC1 V9.01, 1 Oct).

**Symptom:** confirmation says setup is complete but the outlet is lost and no agreed design is recorded. Job mode used by Codex not recorded: #432 only records an agreed design for From-markup jobs ("Design-from-scratch never gets an agreed design yet") so this may be the known limit, but the lost outlet is not.

**Expected behaviour:** retained outlet; During opens after a successful confirmation, or a clear statement of what is missing.

**Status:** OPEN (1 Oct 04:20) - check the job mode first.

---

## BUG-258

**Command / Area:** OOPS after erasing a perimeter drain (BUG-236 / BUG-248): the PD text is still not restored in the installed 3.0.16 (Codex VERIFYC1 V8.08, 1 Oct).

**Symptom:** CDPERIMETER PD1, ERASE the line, OOPS: the line returns, the PD1 text does not (#426 is in the train).

**Expected behaviour:** both return.

**Status:** OPEN (1 Oct 04:20) - the train fix did not work in AutoCAD; diagnose (Opus).

---

## BUG-257

**Command / Area:** drawing tab X then Cancel at the save prompt, then U (Civil 3.0.16) (Codex VERIFYC1 V3.01, 1 Oct).

**Symptom:** MOVE a pit, click the tab X, choose Cancel, then U: the command line prints "CLOSE" and the pit STAYS moved; REDO says "Nothing to redo". The close-time CE write is still a separate Undo step (the train fix B kept it as a safety net and A2/B only moved the native-command flush).

**Re-read 1 Oct 04:40 (Opus builder of PR #442, from the unredacted Civil log):** CE wrote NOTHING at that close (the MOVE wrote its record inside itself at 22:33:04; nothing was waiting at 22:33:36). The 'CLOSE' that U printed is AutoCAD's OWN undo entry for the cancelled CLOSE (a second U undoes the MOVE, like the first U after Ctrl+S printing 'QSAVE'); the lost REDO is BUG-256. PR #442 removes a real remaining write-at-close (a waiting record was locked and written before the save question) and keeps the only-unsaved-change case safe.

**Expected behaviour:** one U restores the MOVE and its records; REDO works; CE takes no lock and writes nothing at close when nothing is waiting.

**Reference:** `LinkService.cs` `OnBeginDocumentClose` (`doc.LockDocument()` + `FlushPendingSave`, ~:1235); `Drainage.HeadlessProof/UndoChecks.cs` WRITELOCK control (a lock outside a command is its own undo step).

**Status:** OPEN (1 Oct 04:20)

---

## BUG-256

**Command / Area:** REDO after U in Civil AND Structural drawings (the BUG-192 family) in the installed Civil 3.0.16 / Structural 1.0.87: "Nothing to redo" after U in EVERY case tested.

**Symptom (Codex verification 1 Oct 02:05 and 04:03, AutoCAD 2027, reports CODEX_VERIFYC1 and CODEX_VERIFYS1):** Civil: COPY a pit onto a free end (V1.05), a pit copied far from every pipe (V1.03), COPY Multiple + Escape (V2.03), grip stretch with Automatic (V5.03), tab X + Cancel (V3.01): one U works, REDO says "Nothing to redo". Structural: ERASE a column (W1.03), RC (W2.01), copied column (W7.02), ten Structural commands and five-step U/REDO (W9: Rebar Line, Level Mark, schedule "REDO must immediately follow the U"). U itself works and restores everything. Civil log lines after the U show CE writing to the block/viewport/layer table records before the next command (Codex reading, cause not established).

**Expected behaviour:** U then REDO restores the undone step.

**Reference:** BUG-192 (entry above); fix candidate PR #414 (BUG-192 v2) is NOT in the install; headless proof run 1 Oct 04:05 (result in the queue).

**Status:** OPEN - the top blocker (1 Oct 04:20). UPDATE 2 Oct 00:20: Codex control D (plain AutoCAD 2027, ALL CE bundles off, `CODEX_VERIFYC4D_2026-10-01.md`): plain AutoCAD keeps REDO only in the plain baseline (LINE, U, REDO) and LOSES it after U + wheel zoom + typed -PAN (with or without an automatic save), U + switch drawing tab and back, U + 136 s idle with an automatic save, U + hatch pick (native Hatch Editor ribbon), U + QSAVE. Those sequences (Codex A1c, A2 open g, A3, A4) are NATIVE AutoCAD behaviour, NOT a CE fault: drop them from CE re-tests. What is left for CE: the pick / copy / edit cases proven working in 3.0.18 stay as the pass list. Final closing waits for Tim's confirmation in AutoCAD.

---

## BUG-255

**Command / Area:** Edit Pipe (Civil): the pipe-size suggestion strip (`PipeFlowSizingAdvisorService` via `MaterialVelocityLimits.BuildStandards`) versus the Project Review pipe size proposals (PR #437).

**Symptom:** the size suggestion in Edit Pipe checks the pipe cover against a fixed 600 mm; the Project Review proposals use the minimum cover in the rulebook (council, then project, then office Settings). With an office minimum of 900 mm the two can disagree about the same pipe.

**Expected behaviour:** one rule: both use the resolved rulebook value (settings-first, one code path per behaviour).

**Reference:** `MaterialVelocityLimits.cs` BuildStandards (constant `DefaultMinCoverMm`), `RulebookValues.cs` (resolver), PR #437 builder fix F3 comment; the same constants also hold minimum speed, scour limits and the grade ladder.

**Status:** OPEN (30 Sep ~19:50) - after #437 merges; Opus review required (engineering result).

---

## BUG-254

**Command / Area:** any CE write to a pit or pipe record on a locked layer (Civil): `LinkService.Persistence.cs` `GetOrCreateLinkDictionary` (~:853-857, 923-937).

**Symptom:** hypothesis from the code (not yet verified by a builder or in AutoCAD): the code UNLOCKS the layer of a locked pit or pipe, writes its CE link dictionary, then locks the layer again, swallowing AutoCAD errors. A locked layer is therefore not respected for CE records.

**Expected behaviour:** nothing on a locked layer is changed, and skipped items are named (native-protection rule: never silently unlock, detach, explode or clone around protected content); any exception needs its own reviewed workflow with a preview and the user's approval.

**Reference:** found by the Opus confirm of train fix A2 (claude/t1-fix-a2 fdaf8a5e), 30 Sep; also conflicts with A1 F7 (a grip onto a locked pit is refused). Not changed by the A2 fix.

**Test that catches it:** a pit on a locked layer: COPY / relink / Edit Pit must leave its record untouched and name it; a source guard that no layer unlock exists in the record-write path.

**Status:** OPEN (30 Sep ~19:50) - verify first (Opus), then fix; Opus review required (native protection).

---

## BUG-253

**Command / Area:** the pipe batch write protection checks (Civil): `RevalidateSizeTargets` (`PipeSizeWriteService.cs`, PR #437) and the lambda inside `ApplyPipeBatch` (`PipeBatchWriteService.cs` / `PipeEditCommand.Batch.cs`). Found by the Opus review of PR #437 (C4 B4b size writer), 30 Sep 2026; NOT fixed. It is code duplication, not a wrong result today.

**What happens (hypothesis from the code):** the protection checks before a pipe batch write (locked layer, Xref, outside model space, REFEDIT, pipe not found) exist twice: once for the CDEDIT batch and once for the proposal size writer. The reviewer compared them: same helper calls in the same order, only the refusal wording differs. Design rule 1 (one code path per behaviour): a future change to one (a new protection rule) could miss the other.

**Test that catches it:** one preflight class used by both callers; a source guard that no second copy exists; every existing refusal message still reads plainly.

**Steps for Tim/Codex:** none in AutoCAD (behaviour unchanged): the batch and the size writer refuse the same cases by name.

**Status:** OPEN (30 Sep ~16:05) - lane F after #437 merges; small.

---

## BUG-252

**Command / Area:** pipe roughness defaults (Civil): `Modules/Drainage/Services/DesignValidationService.cs` ~lines 31 and 162-163, `PipeSizingSolver.cs` ~369, `InspectorPaletteService.cs` ~3109. Found by the Opus confirm of PR #434 (C4 B3), 30 Sep 2026; read from the code, NOT seen in AutoCAD, NOT fixed. Engineering value: needs Tim's roughness values on the Settings page.

**What happens (hypothesis from the code):** #434 makes the CDEDIT size suggestion say Unknown when the material is blank or has no roughness. But the grade-only path (the grade suggestion, via `PipeSizingSolver`) and the Inspector still fall back silently to a roughness of 0.013 for a material with no value; and the word "PE" matches inside "EXISTING PIPE", so an existing pipe is read as PVC.

**Test that catches it:** a pipe with an unknown material (STORMPRO, CMP, EXISTING, blank) never gets a roughness number silently in any path: the grade-only path and the Inspector say Unknown or use a value from Settings; "EXISTING PIPE" is not matched as PE/PVC.

**Steps for Tim/Codex:** CDEDIT and the Inspector on a STORMPRO / CMP / existing pipe: no silent roughness.

**Status:** OPEN (30 Sep ~15:50) - lane F after #434; needs Tim's roughness values (Stormpro, CMP) on the Settings page (R-00).

---

## BUG-251

**Command / Area:** Kingston commercial jobs: PSD storm, pre-development C and time of concentration (Civil; follow-up to PR #433 Land use, PR #427 Kingston 5 years). Found by the builder of #433 and confirmed by the Opus review of #433, 30 Sep 2026; NOT fixed. Engineering values: Tim card needed for the C part.

**What happens (hypothesis from the code):** after #433, a Kingston job whose Land use is COMMERCIAL gets the storage storm 1 in 10 (K02 page 14), but the other Kingston figures stay the RESIDENTIAL ones: the PSD storm 1 in 5 (the proposal report still prints "Q minor (1-in-5 yr)"), the pre-development C and the time of concentration. K02 gives commercial values: PSD storm 1 in 10, Tc 7 minutes, pre-development C = the lower of the existing C or 0.7 (profile provenance notes and `COUNCIL_KINGSTON_ISSUE5_2025.md` lines 25-35; the PDF was not opened by the reviewer). #433 makes the commercial note say the other figures are the residential ones and to check them against K02 page 14.

**Test that catches it:** a Kingston commercial job resolves PSD storm 1 in 10 and Tc 7 minutes from the profile (data-driven, the same `siteCaseByLandUse` mapping); the commercial pre-development C stays Unknown until the site's existing C is known (never invented); a residential job and every other council are unchanged (the 22-council sweep).

**Steps for Tim/Codex:** a Kingston commercial job (Land use set to commercial once the CDSETUP window field exists): CDCALC/CDDESIGN show the commercial PSD storm and Tc with page 14, and the pre-development C as Unknown with the reason.

**Status:** OPEN (30 Sep ~14:50) - lane F after #433; add `psdAriBySiteCase` and `tcMinutesBySiteCase` to the profile model; needs a Tim card for the pre-development C rule.

---

## BUG-250

**Command / Area:** Structural OOPS after erasing a column, when the older "command 8" beam linking is switched ON (`Modules/Structural/Services/BeamLinkService.Reactors.cs` ~:357-377). Found by the Opus review of PR #428 (BUG-237), 30 Sep 2026; read from the code, NOT seen in AutoCAD, NOT fixed.

**What happens (hypothesis from the code):** #428 relinks a beam to its column after OOPS, but only in the branch used when the older linking is OFF. With that linking ON, OOPS prints nothing and the beam stays unlinked (the same symptom BUG-237 fixed for the other branch). The default of `LinkingEnabled` was not read: this may be a dead path.

**Test that catches it:** with linking ON, erase a column that supports a beam, OOPS, MOVE the column: the beam follows, or one plain line says why not.

**Steps for Tim/Codex:** as above with the setting on.

**Status:** OPEN (30 Sep ~12:50) - lane F after #428; first read whether the linking-on branch is reachable at all.

**Update (team lane 01, Thu 1 Oct 13:55):** reachable (the linking tick box is in CE Settings, default OFF). Fix built in draft PR #466, NOT AutoCAD-tested. **For Tim to rule (Opus review of #466, finding 3):** when the drafter answers **Yes** (erase the beam and the other column too) and then types OOPS, AutoCAD brings back only the column. #466 does NOT bring the beam back; it prints one line saying how (U, U). Civil #443 (perimeter drain text) does the opposite: CE puts back what it erased, at the end of OOPS. Recommendation: match Civil (CE brings the beam, its label and its other column back at OOPS's end, one U) as a follow-up, so OOPS means the same thing in both suites. Until Tim answers, #466 keeps the warning only.

---

## BUG-249

**Command / Area:** CDCALC Boyds calculation, intensity rows (`Modules/Drainage/ViewModels/BoydsCalcViewModel.cs` ~lines 87-92). Found by the Opus review of PR #427 (Kingston 5 years), 30 Sep 2026; read from the code, NOT seen in AutoCAD, NOT fixed. Engineering value: changing it needs a command card and Tim's approval (never alone).

**What happens (hypothesis from the code):** the Boyds calculation uses fixed rainfall-intensity rows (for example 113 mm/h at 5 minutes) that are not linked to any council or return period. The office curve at 5 minutes gives 105 mm/h for 10 years and 88.8 mm/h for 5 years, so 113 matches neither. When a council's storage return period changes (Kingston residential 10 to 5 years, Tim 30 Sep) the Boyds intensities do not follow, and the sheet must not imply they were drawn at the stated return period.

**Test that catches it:** the Boyds intensities come from the same curve and return period as the design (or the sheet says "not known" for the Boyds intensity source).

**Steps for Tim/Codex:** CDCALC on a Kingston residential job: the Boyds intensity source is stated (or "not known") and agrees with the 5-year design.

**Status:** OPEN (30 Sep ~12:45) - needs a command card and Tim's approval before any change to the rows; #427 makes the sheet say "not known" wherever it implies a return period the rows were not drawn at.

---

## BUG-248

**Command / Area:** OOPS after erasing a perimeter drain (Civil; PR #426, BUG-236). Found by the Opus review of PR #426, 30 Sep 2026; NOT fixed.

**What Tim would see (hypothesis from the code):** after #426, ERASE of a perimeter drain takes its PD text with it, and U puts both back. OOPS (which restores the last erased object) brings the drain back with its record but NOT its PD text, and nothing is printed, so Tim cannot tell the label is missing. #426 prints one plain line; the real fix is to redraw the text at the end of OOPS (Opus suggests `AppendCopiedDrainTag` with the record's number). Same class as BUG-237 (OOPS after erasing a Structural column does not restore its beam link).

**Test that catches it:** draw a perimeter drain, ERASE, OOPS: the drain and its PD1 text are both back (or one plain line says the text needs redrawing, and it can be redrawn).

**Steps for Tim/Codex:** as above.

**Status:** OPEN (30 Sep ~12:20) - lane F, after #426; do it together with BUG-237 (both are "OOPS restores the object, not its link/label"): reactor-adjacent, Opus review.

---

## BUG-247

**Command / Area:** the Manager release-payload tests in Installer.Tests (release safety lane RS-01C1; release line `claude/rel-20260929c`). Found by the Opus review of PR #425 (M-SET-01), 30 Sep 2026; verified BY NAME against the base; NOT fixed.

**What happens:** two tests already fail on the release line before #425: `ManagerPublishing_RunsOnlyAfterOuterBuildAndValidatesCompleteThreeLanePackage` and `ManagerReleasePayload_HasTrackedManifestAndThreeLaneLocalAssets`. The base code has `->Count()`, no `ReleaseCandidateRoot`, and CEBLOCKS where the tests expect CESURVEYREVIEW: the tests expect a different design from the one on the branch. The owner is the RS-01C1 release-safety lane (last edited e6e07c45). #425 adds CESETTINGSMOVE (one more reason for the second test to fail) and its new 85-file guard assumes the OPPOSITE design.

**Test that catches it:** the two tests pass on the release line, and the package-file-count guard and the payload manifest test agree with each other.

**Steps for Tim/Codex:** none in AutoCAD: `dotnet test` of Installer.Tests (net10, SkipDevBundle) shows the two tests green.

**Status:** OPEN (30 Sep ~11:55) - before any release package is built from a train (the release safety lane owns it; controller to reconcile with #425 when that lane fixes its tests). Old failing guards are not proof: read the RS-01C1 card before "restoring" either side (memory: old-failing-guard-not-proof).

---

## BUG-246

**Command / Area:** Pit Schedule status after a protected cell is skipped (Civil 3.0.15). Found by the Opus review of PR #423 (BUG-232), 30 Sep 2026; read from the code, NOT seen in AutoCAD, NOT fixed.

**What Tim would see (hypothesis from the code):** after #423, a cell on a locked layer (or in an Xref or reference edit) is left as drawn and named on the command line. Nothing then records that the drawn cell is stale: the window's OUT OF DATE badge (`PitScheduleStatusService.cs:181-187`) tracks changes to the source record, not the drawn cells, so once the message scrolls away the schedule looks up to date when it is not. The cell is only brought up to date when that pit is edited again or the full refresh runs.

**Test that catches it:** lock the schedule layer, move a pit, unlock: the window shows the schedule (or that pit's row) as out of date until it is refreshed.

**Steps for Tim/Codex:** as above; the badge names the pit(s) whose drawn cells were skipped.

**Status:** OPEN (30 Sep ~11:25) - lane F, after #423 merges. Needs a small record of skipped cells (persistence: Opus review).

---

## BUG-244

**Command / Area:** the automatic pipe re-link after a grip drag, MOVE, an IL-text edit or "relink all" (Civil 3.0.15; `LinkService.Geometry.cs:237` and `:273`). Found by the Opus review of PR #422 (BUG-223), 30 Sep 2026; read from the code, NOT seen in AutoCAD, NOT fixed. It is the state before #422 (not a regression), but it silently undoes #422's fix.

**What Tim would see (hypothesis from the code):** a pipe between two same-named ends (two "Open end"s) is saved correctly (higher level = From) by #404/#422. Then he drags a grip, moves the pipe, edits an IL text or runs relink-all: the re-link calls the old `Resolve` and writes the DRAWN-order levels back, so the row runs uphill again and the flow arrow is left alone, with no warning.

**Test that catches it:** a pipe with two open ends and levels 18.00/17.80 saved correctly; grip-drag one end: the row keeps From 18.00 / To 17.80 (or a plain warning), never uphill; the same after MOVE, an IL-text edit and relink-all.

**Steps for Tim/Codex:** CDEDIT a two-open-end pipe with the levels the "wrong" way round, then grip-drag an end and reopen CDEDIT: the direction is still the level direction.

**Likely fix:** `RelinkedPipeRecordWriter.Write` calls `ResolveWithLevels` (the level-aware reading #404/#422 share). #410 rewrites that hunk: fix after #410 (same reactor lane).

**Status:** OPEN (30 Sep ~11:10) - lane F, after #422 and #410.

---

## BUG-245

**Command / Area:** a pipe from a pit to an open end (Civil 3.0.15). Found by the Opus review of PR #422 (BUG-223) and its builder, 30 Sep 2026; NOT fixed.

**What happens (hypothesis from the code):** the two ends have different names, so the flow direction still follows the DRAWN order, not the levels; if the open end is higher than the pit the pipe can be saved with the fall the wrong way round (with the existing warning at most). Left alone by #404/#422 because different-named ends were outside their brief (a pit end has a defined role).

**Test that catches it:** draw a pipe from a pit at 17.80 to an open end at 18.00, save: the direction follows the levels or a plain warning says the pipe rises to the open end.

**Steps for Tim/Codex:** as above in CD and CDEDIT.

**Status:** OPEN (30 Sep ~11:10) - lane F, needs a ruling on what should win when the drawn order and the levels disagree for a pit-to-open-end pipe (a pit is usually the downstream end): Tim's question for his return page if not answered by the plan.

---

## BUG-242

**Command / Area:** Inspector palette, raingarden and pavement area (Civil 3.0.15). Found by the Opus review of PR #421 (BUG-230), 30 Sep 2026; read from the code, NOT seen in AutoCAD, NOT fixed.

**What Tim would see (hypothesis from the code):** a raingarden (or pavement) saved in a METRE drawing by the old code stored a wrong, tiny area (for example 0.0006). After #421 is installed the Inspector still shows that saved number as "0.0 m2" (`InspectorPaletteService.cs:771, 2028`) and nothing says it is out of date. Nothing calculates from these two fields, so no design number is wrong; the displayed area is.

**Test that catches it:** open an old drawing with such a record: the Inspector shows "saved X, drawing measures Y" (or "not re-measured") instead of a plain wrong number.

**Steps for Tim/Codex:** open a drawing saved by the installed 3.0.15 with a raingarden in a metre drawing; select it: the area is shown with a plain note that it can be re-measured.

**Status:** OPEN (30 Sep ~10:55) - lane F, after #421 merges.

---

## BUG-243

**Command / Area:** surface overlay labels (`SurfaceOverlayTransientService.cs:24`). Found by the Opus review of PR #421, 30 Sep 2026; read from the code, NOT seen in AutoCAD, NOT fixed.

**What Tim would see (hypothesis from the code):** overlay labels are a fixed 250 drawing units tall, which is 250 mm in a millimetre drawing but 250 m in a metre drawing (unreadably large) and 0.25 mm in a kilometre drawing.

**Test that catches it:** the label height is scaled from the drawing units (and the annotation scale), the same as other CE text.

**Steps for Tim/Codex:** in a metre drawing show the surface overlay: labels are a readable size.

**Status:** OPEN (30 Sep ~10:55) - lane F.

---

## BUG-239

**Command / Area:** CDRULES findings, the review windows, Manager project QA and the CDAUTO proposal report (Civil 3.0.15 / Manager 1.1.15). Found by the Opus confirm of PR #420 (BUG-233), 30 Sep 2026; read from the code, NOT seen in AutoCAD, NOT fixed. #420 fixes only the computations sheet, PDF, XLSX and CDCALC.

**What Tim would see (hypothesis from the code):** where a council rule value is quoted, the source shown is the raw internal locator (a docs path and a GitHub link), not the document name and page. The raw locator is added at `CouncilRuleValues.cs:42` and reaches users through rule findings (`RulebookEngine.cs:64-65` then CDRULES `RulesCommand.cs:227`, review windows `ReviewReading.cs:39`, Manager QA `CivilProjectQaContributor.cs:248`) and the CDAUTO proposal report (`AutoDesignService.cs:554`, `DesignProposalReport.cs:247`).

**Test that catches it:** the same plain-words guard #420 uses on the sheet (no path separator, ".md", "github", "](#", "Tim R-"), run over the CDRULES findings text, the QA text and the CDAUTO proposal report for every shipped council; use the shared resolver `CouncilSourceWords` from #420.

**Steps for Tim/Codex:** run CDRULES and CDAUTO on a job with council rules: every source reads as a document name and page, or "source: not recorded".

**Status:** OPEN (30 Sep ~10:35) - lane F, after #420 merges (stacked on its resolver). Calculation-adjacent wording: Opus review required.

---

## BUG-202

**Command / Area:** Whole AutoCAD session, Structural drawing (Civil 3.0.14 / Structural 1.0.85 installed).

**What Tim saw (29 Sep 2026 ~16:45, live):** "THERES SOMETHING POLYLINE RELATED THAT IS MAKING IT LAG OUT LIKE THERES NO END" / "OR AT LEAST I THINK". Clickable answers: lag on selecting/hovering, drawing/editing, moving/copying AND pan/zoom; in a Structural drawing; "all day" (not only since the 14:13 Structural 1.0.85 install).

**Evidence so far:** every CE handler with a timing line is fast (Civil ApplyPendingLinkUpdates 0-4 ms per call; Structural BeamLink/FoundationMonitor/AutoSave under 1 ms per call). Civil's automatic QA ran 1,095 times today (~4 s total) - so Civil may still be active in his drawing. Not timed: CE draw/grip/osnap overrules (Civil pipe overrules are XData-filtered; Structural beam grip overrule on every Polyline/Line with an extension-dictionary filter; Structural support grip on every block), the native C7 pipe object / grip ARX, and AutoCAD itself. Lag on pan/zoom points at drawing/display, not command-end work (hypothesis).

**Tim's CEPERFDIAG A/B (29 Sep ~16:55): "NO CHANGE THE EXACT SAME" with each of the 8 Civil watchers off - the Civil watchers are ruled out.** Next: one session with CE Structural moved aside (then Civil), same drawing, to prove CE vs the drawing itself.

**Earlier plan:** Tim's 2-minute A/B with CEPERFDIAG (turn off one CE watcher at a time); if not CE-Civil, the same test with Structural unloaded (NETLOAD-free session) to prove CE vs the drawing itself.

**29 Sep ~19:00 update (structural/fix/01, Fable, measured read-only on Tim's live AutoCAD; controller 06 read the report, not yet re-measured):** the lag is mostly NOT CE code. (1) AutoCAD's own main thread was at 50-77% of one core, in AutoCAD native code every sample, no CE frame. (2) CE's timed work is milliseconds. (3) The PC was loaded by builds and test suites (9.4 of 12 cores busy at 18:41) while he drafted; AutoCAD's CPU share fell to 12-28% between test runs. (4) A stray `python3 -` from a bash call spun a core for 40+ min (gone by 18:52). (5) GTX 1050 Ti 4 GB asked for 4.56 GB video memory; 43 GPU-timeout reports and a blue screen at 18:16; driver from Feb 2025; NVIDIA overlay running; unclean shutdown 05:01. **Controller action (done 29 Sep 19:00): builder/test processes run at Below Normal priority (builder_rules.txt), and while acad.exe runs at most 2 builders run at once.** For Tim, through the desk: NVIDIA app > Settings > Features > In-game overlay OFF; update the NVIDIA driver; close Firefox/Revu/ChatGPT while drafting; A/B with AutoCAD GRAPHICSCONFIG hardware acceleration OFF for one session. Real CE defects found: BUG-203, BUG-204 below.

**Status:** OPEN - investigating (mostly environment; CE defects split out as BUG-203/204).

---

## BUG-224

**SEVERITY: BLOCKER. A crash is a blocker (a colleague loses unsaved work).**

**Command / Area:** AutoCAD itself closing a drawing right after "Save As", on the installed build (Civil 3.0.15+a6e0cc87, Manager 1.1.15+a6e0cc87, Structural 1.0.86+532f9550 all loaded). Found by Codex sweep C1, 30 Sep 2026 07:53-07:55 Melbourne, on a COPY. Whether CE is involved is NOT established.

**What Codex did (exact sequence, from the C1 report items 92 and 622):** on CleanBlank_SWEEPC1.dwg (0 model objects, DBMOD 0, no CE project dictionary): (1) ran the CDDISCIPLINE Undo/Redo test: typed CDDISCIPLINE, Civil / Structural / Civil / Structural / Civil (five changes), then five U (each named CDDISCIPLINE) and five REDO (each "Nothing to redo", that is BUG-192); (2) set the discipline to Civil; (3) Save As a new copy `SWEEPC1\Discipline_SWEEPC1.dwg`, which succeeded (115,019 bytes, written 07:53:51); (4) closed that drawing through the AutoCAD COM automation call `Document.Close(false)` (not a user Ctrl+S / CLOSE / X). The call stalled, then AutoCAD exited on its own. Codex's Python got "remote procedure call failed" from Close; the planned reopen step never ran.

**Expected:** the drawing closes; AutoCAD stays up; the saved copy reopens with Civil set.

**What happened:** AutoCAD closed unexpectedly (07:55). The Autodesk Error Report window appeared ("A software problem has caused AutoCAD to close unexpectedly"); Codex did NOT click Send Report and closed the window. Other open test copies lost their unsaved test changes (copies only; nothing of Tim's). Codex started a fresh AutoCAD: the saved Discipline_SWEEPC1 copy opened fine (model 0, DBMOD 0, discipline Civil set explicitly), so the save itself was good.

**Reproduced?** NO repeat is recorded: it happened once, on the first attempt of this sequence, and Codex stopped for evidence and recovery. Whether a normal user close (Ctrl+S then the X, or CLOSE) does the same is UNKNOWN: the COM close route may itself be the trigger.

**Crash evidence (as read, 30 Sep):**
1. **Windows crash event (Codex-recorded):** faulting application acad.exe 32.0.60.0 (time stamp 0x698193d5); faulting module **coreclr.dll 10.0.1226.42308** (the .NET runtime that hosts the CE plugins; module time stamp 0x6a89b724); exception 0xc0000005 (access violation); fault offset 0x3596cf. Lane: AutoCAD 2027 (CDFEEDBACK reported "AutoCAD 26.0.0.0"; the Civil log says "AutoCAD 2027 native module"); the .NET 10 runtime is the crashed module, so it is the net10 lane. `SWEEPC1\crash-event-summary.txt`.
2. **A crash dump exists (listed, NOT opened):** `C:\Users\TimothyBrand\AppData\Local\CrashDumps\acad.exe.4120.dmp`, 90.8 MB, written 07:55 30 Sep, plus Autodesk `...\AppData\Local\Autodesk\CER\senddmp.log` (07:55). It holds AutoCAD memory and can hold drawing content: read it where it is, never copy it into a repo. No debugger is installed on this PC (BUG-164 note), so nobody has read the stack yet. **Is CE code on the stack? Insufficient information: the dump has not been read.**
3. **CE log tail around it (privacy-filtered copies, `SWEEPC1\logs_end\`):** Civil, last lines of the crashed session: `07:52:32.057 [REDO] write after U finished, before the next command: object changed (Xrecord); CE code: LinkService.OnObjectModified`, then `07:52:35.102 Project data reloaded after Undo/Redo: pits=0, pipes=0`, then `07:52:38.091 [PERF-SUMMARY] CivilProjectQaAutomaticService.Advance: 7 call(s)`. Nothing from Civil after 07:52:38 (no line at the 07:53:51 Save As, none at the close, and none of the "unregistered / shut down" lines a normal exit writes; the recovery session's normal exit at 08:00:18 does write them). Structural, last lines: `07:53:51.168 [PERF-SUMMARY] BeamLink.ObjectErased: 2 call(s)`, `07:55:00.592 [PERF-SUMMARY] BeamLink.ObjectModified: 132 call(s), 0.3 ms in last ~70s`, then the next line is the recovery session's start at 07:56:48. I cannot tell from these whether the 132 Structural events or the missing Civil lines relate to the crash.
4. **Screenshot of the Autodesk report window:** `SWEEPC1\screens\autocad-error-report-after-copy-close.png` (read: it shows only the standard crash dialog).
5. **Related, relation Unknown:** BUG-164 (crash on AutoCAD QUIT in CE's palette shutdown, same 0xc0000005 class) has its fix installed since 23 Sep and three clean quits were seen (pass 17 too); this crash is on closing one drawing, not quitting, so it is not shown to be BUG-164 coming back. The same session's CDDISCIPLINE Undo/Redo had shown the CE write-after-U pattern (BUG-192).

**Test that catches it:** repeat the exact sequence on a copy, three times, by BOTH routes (the COM `Document.Close(false)` and the user's Ctrl+S then X / CLOSE): no crash and no new `acad.exe.*.dmp` in `C:\Users\TimothyBrand\AppData\Local\CrashDumps\`. Then the same sequence with Civil unloaded, and with Structural unloaded, to find whether CE is involved. Someone with a debugger (WinDbg / dotnet-dump) opens `acad.exe.4120.dmp` in place and reads the faulting stack.

**Steps to confirm the fix (Codex or Tim):** on a copy of a blank Civil drawing: CDDISCIPLINE Civil then Structural then Civil, Save As a new name, close the drawing (X), reopen the saved copy: AutoCAD stays up, the discipline reads Civil, and no new crash report file appears.

**Also blocked by it:** sweep C1 PROFILE_CHECK_END (original session never reached the final read; a fresh-session read gave Tim / 21759, labelled separately) and the "reopen after SaveAs" step of the discipline persistence test.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 622 "Save and close discipline COPY / AutoCAD crash", FAIL item 1, Method items 21-23); `SWEEPC1\crash-event-summary.txt`, `SWEEPC1\FINAL_STATE.txt`, `SWEEPC1\Discipline_SWEEPC1.dwg`; screenshots `SWEEPC1\screens\autocad-error-report-after-copy-close.png` and `cddiscipline-copy-reopened.png`.

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1; cause Unknown; not reproduced; CE involvement Unknown).

---

## BUG-225

**Command / Area:** Pit contextual ribbon tab, Close button (Civil 3.0.15 / Manager 1.1.15). The Pipe tab's typed route works; this is the Pit tab button.

**What Codex did (sweep C1, 30 Sep 2026, DWG-S_SWEEPC1 copy):** clicked a pit border (2 model objects): the Pit tab appeared (Edit Pit, Flip Cover Text, Focus, Close). Clicked **Close** once. Repeated a second time. Also pressed Escape while the ribbon held focus.

**Expected:** Close clears the selection and closes the tab, as its tooltip says.

**What happened:** the command line ran CDCLOSETAB and CMDACTIVE went back to 0, but the pit stayed selected (1) and the Pit tab stayed open, twice. Escape sent while the ribbon had focus did not visibly clear it either. Typing CDCLOSETAB (through the command API) closed the tab and cleared the selection. Objects stayed 2. No matching log error; root cause Unknown.

**Test that catches it:** Codex: select a pit, click Close from the ribbon: selection 0 and no Pit tab. Unit: the Close button runs the same clear-selection path as the typed command.

**Steps to confirm the fix (Codex or Tim):** click a pit, click Close on the Pit tab: the tab goes and the pit is no longer selected.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 617, FAIL item 11, UX finding 10); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\context-pit-close-settled.png`, `context-pit-close-repeat.png`, `context-pit-typed-close.png`; data `cdclosetab-pit-after.json`, `cdclosetab-pit-repeat.json`. Codex suggestion: make Close clear the selection reliably from ribbon focus. Related: BUG-194 (contextual tab), BUG-180.

**Likely area (hypothesis only):** the ribbon button's command runs while the ribbon has focus, so the selection clear is not applied (same command works typed).

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1).

---

## BUG-226

**Command / Area:** Civil ribbon tooltip for the discipline switch (CDDISCIPLINE), Civil 3.0.15.

**What Codex did (sweep C1, 30 Sep 2026, CleanBlank copy):** typed CDDISCIPLINE (prompt: "Unknown (not set)", choices Civil / Structural / Clear / Cancel), then hovered the ribbon button.

**Expected:** the tooltip describes the drawing's real state and the real choices.

**What happened:** the tooltip says "This drawing is Civil" on a drawing that reports Unknown, and says to choose Civil, Structural or Both; the prompt has no Both.

**Test that catches it:** Codex: hover the button on an Unknown, a Civil and a Structural drawing: the words match the prompt. Unit: tooltip text built from the current discipline and the prompt's real keyword list.

**Steps to confirm the fix (Codex or Tim):** hover the discipline button on a fresh drawing: it says the drawing is not set and lists Civil, Structural, Clear.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 604, FAIL item 8, UX finding 11); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\ribbon-tooltip-civil.png`, `cddiscipline-cleanblank.png`.

**Likely area (hypothesis only):** static tooltip text in the Civil ribbon definition.

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1).

---

## BUG-227

**Command / Area:** Civil ribbon tooltip for Settings (CDS), Civil 3.0.15. Only the installed guidance is the fault; the missing future features are simply not installed.

**What Codex did (sweep C1, 30 Sep 2026):** hovered the Settings button, then opened CDS, CDMANAGER, CDLABELSTYLE, CDPARTS.

**Expected:** the tooltip describes what is installed.

**What happened:** the tooltip promises Personal / Project / Firm tiers and says CDMANAGER, CDLABELSTYLE and CDPARTS open as a page of this window. The installed CDS has six tabs (Drafting, Pipes & Pits, Design, Survey, Display, Advanced) and those three commands open separate windows.

**Test that catches it:** Codex reads the tooltip against the installed window. A wording guard listing the six tabs.

**Steps to confirm the fix (Codex or Tim):** hover Settings: the words match the six tabs and the separate editors.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 605, FAIL item 9, UX finding 12); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\ribbon-tooltip-settings.png`, `cds-default.png`. Codex suggestion: describe the installed six-tab window and the separate editors accurately.

**Likely area (hypothesis only):** ribbon tooltip text written for the planned settings tiers (UX-SET work) ahead of the installed window.

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1).

---

## BUG-228

**Command / Area:** Data Diagnostics ribbon tooltip and CDDIAG result text, Civil 3.0.15.

**What Codex did (sweep C1, 30 Sep 2026, Heavy copy, 5,100 lines):** hovered Data Diagnostics, then typed CDDIAG.

**Expected:** the tooltip and the result agree, with no internal ID or future-release promise shown to a colleague.

**What happened:** the tooltip promises to inspect and export a support report. CDDIAG printed counts only ("0 pits, 3 pipes in the data model", from the office template, not from the 5,100 lines), a line "Full diagnostic dialog coming in v2.1 (PL-032)", and a pointer to CDREPAIR > Audit. No export was offered. Object count stayed 5,100.

**Test that catches it:** wording guard: the CDDIAG output contains no "PL-0" internal ID or version promise; the tooltip lists only what the command does.

**Steps to confirm the fix (Codex or Tim):** hover the button and run CDDIAG: the words match; no "PL-032".

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 606 and 90, FAIL item 10, UX findings 7 and 13); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\ribbon-tooltip-settings-4.png`, `cddiag-heavy-output.png`. Codex suggestion: remove the stale release promise and internal ID and offer a direct Audit action; describe only the counts until the report window is installed.

**Likely area (hypothesis only):** the CDDIAG stub message and the ribbon tooltip written for the planned window.

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1).

---

## BUG-229

**Command / Area:** CDMANAGER > Layers > Draw Order list (Civil 3.0.15). An observation, not a Codex FAIL; cause Unknown.

**What Codex did (sweep C1, 30 Sep 2026, Heavy copy):** opened CDMANAGER, read all three tabs and scrolled the entire list. No Add / Reset / Apply / Save used.

**Expected:** each layer appears once in the Draw Order rules.

**What happened:** duplicate rows are visible (for example 20TEXT, 25DIMS, 25TEXT, AGI DRAIN). Codex records the cause as Unknown and gave no suggestion; it may be the saved rule list, the load, or the office template.

**Test that catches it:** Codex/unit: open CDMANAGER on a fresh drawing: no repeated layer name in Draw Order. (Compare BUG-204, where the Structural rule lists gained about 24 duplicates per start.)

**Steps to confirm the fix (Codex or Tim):** open CDMANAGER > Draw Order: every layer name appears once.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 84 "CDMANAGER", UX finding 44 in the UX file); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\cdmanager-layers-default.png`, `cdmanager-layer-colours.png`; `cdmanager-draw-order-controls.txt`.

**Likely area (hypothesis only):** the same append-on-load pattern found for the Structural lists in BUG-204; not checked.

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1; look before anyone edits the list).

---

## BUG-240

**Command / Area:** Tim's REAL AutoCAD 2027 profile `Tim` (read from his own settings export `AutoCAD_2027_ADMINISTRATOR_20260930.ceacad`, made by the settings tool from his desktop, 30 Sep 2026 ~10:42; not the Claude app's private copy - see BUG-238). Found by the CE_AcadSettings chat while checking Tim's 2027 -> 2026 import log.

**What happens:** (1) Trusted Locations (TRUSTEDPATHS) holds the CE Civil bundle folder `%AppData%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern` 15 times over: something adds it on every load without checking it is already there, so the list keeps growing. Source not found yet (the test harness saves and restores TRUSTEDPATHS, it does not add). Searched 30 Sep ~12:20: no .cs/.lsp/.ps1/.xml in the plugin's main checkout (worktrees and the test harness excluded) sets TRUSTEDPATHS, so the adder is outside that code (installer script, bundle loading or AutoCAD itself are possibilities, not checked). (2) Log File Location (LOGFILEPATH) = `C:\lisp files\ce_acad_plugin\`, the plugin's code folder: if AutoCAD's log is ever switched on, logs holding drawing names and job paths land inside a git working copy.

**Expected:** each trusted folder listed once; the log folder is a normal AppData folder, never a code folder.

**Test that catches it:** load the plugin 3 times (restart AutoCAD between): TRUSTEDPATHS contains the bundle folder exactly once. Read LOGFILEPATH after a Codex/Claude test run: unchanged.

**Steps for Tim:** none needed now. Nothing on his PC was changed. Fix and clean-up only on his word (the clean-up edits his live profile).

**Seen on disk 30 Sep ~11:45:** 285 AutoCAD log files (named after real jobs, several with street addresses) in the root of the plugin's main checkout `C:\Lisp Files\CE_ACAD_PLUGIN`, oldest 23 Sep, newest 10:50 today, so AutoCAD is writing them now. Checked: ignored by git (`.gitignore` `*.log`), **none tracked, none ever committed on any branch**. Not in OneDrive. Clean-up = set the log folder back, then move the files out (listing them for Tim's yes first; never bulk-delete).

**Clean-up, Tim 30 Sep ~11:55: \"yes clean up the log files\".** Done ~12:00 (via a WMI-started process, i.e. the real disk): 290 logs MOVED (not deleted) from the plugin checkout root to `%LocalAppData%\Autodesk\AutoCAD 2027\R26.0\enu\Logs moved from plugin folder 2026-09-30` (290 counted there from outside the app). 1 left: the log AutoCAD had open (acad.exe was running; a copy is also in the new folder). Tim's AutoCAD settings NOT touched (AutoCAD open) - Tim to set OPTIONS > Files > Log File Location himself; after that, one final sweep of new logs.

**~12:10:** Tim: "done" (changed Log File Location in OPTIONS). Real registry still showed the old value at 12:10 while AutoCAD stayed open, and AutoCAD kept its open log in the old folder (1 file; copy taken). Not known when AutoCAD writes the setting (Autodesk internals). Check after AutoCAD's next restart: registry value = the AppData folder, new logs land there, plugin folder has no new logs; then move the last one. Log names are AutoCAD's own (drawing name + code), so moving kept them: 290 logs from 44 drawings, job numbers in the names where the drawing name has one.

**Status:** OPEN - (2) log files moved; log folder setting changed by Tim, confirm after AutoCAD restart; (1) TRUSTEDPATHS duplicates for a plugin chat, do not edit Tim's profile without his yes.

---

## BUG-238

**Command / Area:** Tim's own AutoCAD 2027 profile on the work PC (`<<Unnamed Profile>>`), Options > Files. Not CE plugin code as far as known. Found read-only by the CE_AcadSettings chat (CE_ACAD / general / fix / 01), 30 Sep 2026 ~10:30.

**What happens:** three profile locations point at places that do not exist on disk (checked 30 Sep): (1) Printer Configuration, Plot Style and Printer Description (PMP) search paths = `C:\Program Files\Autodesk\AutoCAD 2027\plotters...` (the folder is not there; the real PC3/CTB files are in `%AppData%\Autodesk\AutoCAD 2027\R26.0\enu\Plotters`); (2) Log File Location = a deleted Claude worktree under `C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\`; (3) Custom Dictionary = a missing `Program Files\...\Support\sample.cus`. Already present in Tim's 17 Jul settings export, so it predates the September release work. **Update 30 Sep ~11:00:** the Log File Location CHANGES: the 17 Jul export named worktree `confident-boyd-beb394`, the live profile at 11:00 names `agent-a524b98f03f190b3e` (also gone). So something keeps setting AutoCAD's log folder to a Claude working folder (hypothesis: a test/agent run sets LOGFILEPATH); read-only finding, nothing changed. Cause unknown (a profile reset, or a test run that set LOGFILEPATH, is a guess only).

**Expected:** the profile points at folders that exist: plotters at the Roaming Plotters folder, log file at a normal folder.

**Test that catches it:** read the three values in `HKCU\Software\Autodesk\AutoCAD\R26.0\ACAD-A101:409\Profiles\<<Unnamed Profile>>\General` and `Editor Configuration`; every folder exists.

**Steps for Tim:** in AutoCAD, OPTIONS > Files > Printer Support File Path: check the three entries; PLOT > Printer list shows your PC3s and the Plot Style list shows the CE CTBs. Nothing changed on his PC; any fix is his call (the settings tool's BUG-004 fix repoints these automatically only when a profile is IMPORTED).

**Status:** WONT FIX — not a bug in Tim's AutoCAD (30 Sep 2026 ~11:05). **Correction, own mistake:** everything above was read by a Claude chat whose commands see a PRIVATE copy of the registry (the Claude app's own), not Tim's real one. Read-only check through a process started by WMI (outside the app) showed Tim's REAL AutoCAD 2027: current profile = `Tim`, PrinterConfigDir = `%UserProfile%\...\AutoCAD 2027\R26.0\enu\plotters` (correct), Unnamed Profile LogFilePath = a normal AppData folder. **The real finding for every CE chat:** registry reads/writes from Claude tool commands (and, by hypothesis, AutoCAD started from them) go to that private copy: it holds a default-looking `<<Unnamed Profile>>` whose log folder names an agent worktree. So anything a chat 'reads from Tim's AutoCAD profile' through its own shell may not be Tim's real profile; to read the real one, start `reg query` via WMI (`Invoke-CimMethod Win32_Process Create`) and read its output file.

---

## BUG-235

**Command / Area:** COPY of a pit (relink by proximity) - from the Opus review of PR #417, 30 Sep 2026 ~10:20, read from the code, NOT seen in AutoCAD.

**What happens:** pipes drawn by CD keep their creation-time pit IDs; OTHER pipes go to the nearest touching pit, so a copy placed slightly nearer than the original can take a pipe end from the original; a copy exactly on top of the original: the older pit wins by drawing order, with no warning (the plan: stable identity outranks proximity). Also (undone-ness): the copy's link writes are separate steps and one-Undo of them is unchecked.

**Test that catches it:** copy a pit so its outline touches a pipe end owned by another pit: no end changes owner; copy exactly on top: a plain warning.

**Status:** OPEN (30 Sep ~10:20) - carparked (not new; not a #417 blocker).

---

## BUG-236

**Command / Area:** perimeter drain PD1 tag text (`AgiCommand.Apply.cs` `AppendTagLabel`): from the Opus review of PR #417.

**What happens:** the PD1 text is not linked to its drain: erase, move, copy (the copy shows a second PD1) or renumber leaves it wrong; its height 250 is the shared hard-coded pipe text constant (breaks R-00: text heights belong in Settings).

**Test that catches it:** erase / move / copy a perimeter drain: its PD1 text follows or goes; the height reads from Settings.

**Status:** OPEN (30 Sep ~10:20) - carparked.

---

## BUG-237

**Command / Area:** Structural OOPS after erasing a column (PR #415, Opus review): OOPS brings the column back but NOT its link to the beams.

**Test that catches it:** erase a CE column that supports a beam, OOPS: the beam is linked to it again (or the beam end is flagged Unresolved until relinked).

**Status:** OPEN (30 Sep ~10:20) - carparked.

---

## BUG-234

**Command / Area:** pipe FROM/TO records after a MOVE or a grip drag (flat or missing levels). Found by the Opus confirm 3 of PR #410 (BUG-208), 30 Sep 2026 ~10:10, read from the code, NOT seen in AutoCAD; older than #410.

**What happens (hypothesis):** with flat or missing levels, a pipe that keeps BOTH names still records its OLD pits when it is MOVEd straight onto two other pits, or when one end is gripped directly from pit P2 onto P3 (the stored direction is read as still valid). Suggested fix: `Helpers/ConnectedPipeFlowResolver.cs`: add `&& !storedNamesLeftTheEnds` to the `if (hasStoredDirection)` check for connected ends with flat levels. Keep this case OUT of Tim's MOVE acceptance steps for #410.

**Test that catches it:** move a flat-levelled pipe with both names straight onto two other pits (and grip one end from P2 onto P3): the FROM/TO and pit records name the NEW pits on the correct sides.

**Status:** OPEN (30 Sep ~10:10) - lane F after #410 merges.

---

## BUG-233

**Command / Area:** the computations sheet (CDCALC), the orifice discharge-coefficient line. Found by the Opus builder of PR #413 while rendering the sheet, 30 Sep 2026 ~09:10; NOT fixed.

**What Tim would see:** the orifice discharge-coefficient line prints an INTERNAL FILE PATH and a GitHub link as its source (for example a docs/evidence path and a link code) instead of the document and page.

**Test that catches it:** render the computations sheet and assert no source line contains a path separator, ".md", "github" or "](#" (the same guard #413 added for the storm-frequency line, applied to every source line).

**Steps for Tim/Codex:** run CDCALC on a detention job with an orifice, open the sheet PDF: every source reads as a document name and page.

**Status:** OPEN (30 Sep ~09:10) - lane F (calculation output: Opus review required).

---

## BUG-232

**Command / Area:** the scoped Pit Schedule refresh after each command (`ScheduleLinkService.Index.cs` lines ~105 and ~278): it writes drawn schedule cells WITHOUT the locked-layer / Xref / reference-edit check. Found by the Opus confirm of PR #409 (BUG-207), 30 Sep 2026 ~09:00, read from the code, NOT seen in AutoCAD; it was like this before #409 and is outside its diff.

**What happens (hypothesis):** after an ordinary command CE refreshes the affected schedule cells without checking whether the cell's layer is locked, in an Xref or in a reference edit; PR #409 added that check only to the full refresh used by PITEDIT and the window. Native protection rule: CE must never write into locked/foreign content.

**Test that catches it:** lock the schedule layer, move a pit, run the command: the cell is skipped and named on the command line; nothing is written; Xref-owned and REFEDIT cells the same.

**Status:** OPEN (30 Sep ~09:00) - lane F after #409 merges.

---

## BUG-230

**Command / Area:** PAVE, raingarden placement and the site-area readers (`SurfaceEvidenceMapService`, `XrefSiteGeometryService`): drawing units. Found by the Opus review of PR #411 (BUG-209), 30 Sep 2026 ~08:50, read from the code, NOT seen in AutoCAD.

**What happens (hypothesis from the code):** these commands never check the drawing's INSUNITS: they assume millimetres. In a metre drawing they give areas a million times too small, and that site area feeds the design and detention sizing. Also: on a Unitless drawing CDCATCHMENT now shows Unknown (PR #411, Tim's "no automatic unit inference approved") while PAVE shows a number: the commands disagree.

**Test that catches it:** a 20 m x 30 m outline in a mm drawing and in a m drawing through each command: 600 m2 in both; a Unitless drawing: Unknown with the reason, in every command.

**Steps for Tim/Codex:** in a metre drawing and a millimetre drawing draw the same pavement and read the area in PAVE, the raingarden tool and the site-area figure in the design window: they agree; check what INSUNITS Tim's office templates use (if Unitless, CDCATCHMENT will say Unknown on every job: needs Tim's ruling).

**Status:** OPEN (30 Sep ~08:50) - after #411 merges (lane F, Opus builder: calculation path).

---

## BUG-231

**Command / Area:** AutoCAD shutdown: `PluginInitialization.Terminate` (when AutoCAD shuts the plugin down on exit) still saves CE's project record even when nothing is waiting. Found by the Opus review of PR #412 (BUG-224), 30 Sep 2026 ~08:50, read from the code.

**What happens (hypothesis):** the same kind of close-time write that crashed AutoCAD closing a drawing (BUG-224), at plugin shutdown. Not seen to crash; the risk is the same.

**Test that catches it:** a source guard that Terminate performs no database write/lock; Codex: QUIT with a save left waiting: no crash, no new dump, no .NET 1026 event.

**Status:** OPEN (30 Sep ~08:50) - carparked; fix together with the BUG-224 Codex probe result.

---

## BUG-223

**Command / Area:** CDEDIT (Edit Pipe) and the not-drawn-first CD path: flow direction of a pipe whose two ends have the SAME name (two "Open end"s). Found by the Opus review of PR #404 (BUG-205 fix), 30 Sep 2026 ~08:05, read from the code, NOT seen in AutoCAD.

**What happens (hypothesis from the code):** `ConnectedPipeFlowResolver.Resolve` never reads the levels when both ends carry the same name. PR #404 fixed only the draw-first path (`CdDrawFirstFlowService`); two other callers still use the old helper: `PipeEditCommand.Update.cs:1476` (CDEDIT) and `CdViewModel.Inverts.cs` `ResolveCurrentConnectedFlow` (the not-drawn-first path). CDEDIT re-levelling a pipe with two open ends could keep the stored direction and save an UPHILL pipe (with a warning). Minor: when no question is asked the "Flow:" line still reads "Open end -> Open end".

**Test that catches it:** the BUG-205 test through `PipeEditCommand` and `ResolveCurrentConnectedFlow`: two open ends, levels 18.00 / 17.80, CDEDIT, change the levels: the direction follows the levels (positive fall) or warns plainly; never silently uphill.

**Steps for Tim/Codex to confirm the fix:** draw a pipe between two open ends, CDEDIT it, type the upstream and downstream levels the other way round: the pipe does not end up uphill without a plain warning.

**Status:** OPEN (30 Sep ~08:05) - filed from the Opus review of #404; fix after #404 merges (lane F, next).

---

## BUG-203

**Command / Area:** Civil waking up inside Structural drawings (Civil 3.0.15 / Structural 1.0.86).

**What Tim did / saw:** drafting in a Structural (_STR_) drawing; laggy session (BUG-202). Found by structural/fix/01, verified in code at a6e0cc87 (not re-verified by the controller).

**What happened:** the Structural drawing carries an EMPTY Civil project record. `ProjectDataService.IsDrawingActive` returns true because the CE_CVL_SUITE_PROJECT dictionary merely exists, so `DrawingDisciplinePolicy.ShouldCivilBeActive(Structural, hasCivilContent=true)` wakes Civil (LinkService.cs ~1320). Result: Civil tidy-up at every command end (250 times in 81 min), a 7-phase check at idle (1,068 calls in a day), a full cache rebuild after every U, Civil writes after U (this is probably the BUG-192 REDO killer, now also in Structural drawings), job-folder search, "CloneReconcile ... CE adoption refused" 16 times. "[PERF] CivilQuiet" appeared 0 times all day.

**Expected:** "has Civil content" means real content (pits > 0, or pipes > 0, or manual rows > 0, or a CE pipe/pit object), not "the dictionary exists"; an empty record is never written or migrated into a quiet drawing. Civil stays quiet in a Structural drawing (Tim's ruling 29 Sep: Structural wakes by itself; Civil-only drawings unaffected).

**Test that catches it:** (1) unit: ShouldCivilBeActive / HasCivilContent with an empty record in a _STR_ name = quiet; with 1 pit = active. (2) Codex: open a copy of a Structural drawing with an empty Civil record, run 5 QLEADERs, read the Civil log: "[PERF] CivilQuiet: skipped" and zero "[TidyUp]" lines; then U, REDO in that drawing.

**Steps for Tim to confirm the fix:** open a Structural drawing, draft normally: it feels no different, but a U followed by REDO now works there.

**Status:** OPEN (29 Sep 20:30) - built, draft PR #393 (`claude/bug203-quiet`, base rel-20260929c; one helper `ProjectDataService.HasCivilContent` used at open registration, `ReevaluateCivilActivity` and `IsCeOwnedDrawing`; empty record no longer written into a quiet drawing; focused 87 pass; full Civil net10 7 failures = the known 7; PR files verified). Opus review REQUIRED (LinkService, ProjectDataService). One existing test line changed (`CivilQuietModeTests` source-text guard: the string names `HasCivilContent(db)` instead of `IsDrawingActive(db)`; same rule, controller checked; Opus to confirm). Not tested in AutoCAD. Known gap: a CE pipe/pit object with NO project record at all is not detected at open (no model-space scan allowed); it wakes Civil at the next Civil command.

**Codex 30 Sep sweep C1: BLOCKED (wrong fixture).** The test copy DWG-S_SWEEPC1 is a Civil drawing (CDDISCIPLINE: "Civil (set explicitly in this drawing)"; 2 model objects), so Civil silence in a Structural drawing could not be judged. Needs a genuine _STR_ drawing with an empty Civil record. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 7); screenshot `SWEEPC1\screens\dwg-s-discipline-is-civil.png`.

---

## BUG-204

**Command / Area:** Structural settings file (Structural 1.0.86).

**Found by:** structural/fix/01 (29 Sep): `CS_Settings.json` is 2.4 MB: Excel.FloorRules 15,622 entries, MarkPrefixRules 13,748, ActiveScheduleFloors 3,750 (normal is about 30). 58 code paths call SettingsService.SaveSettings, each writing the whole file. Growth path: ExcelMText / XclmTxt rule normalisation (ExcelMTextService.cs ~1757-1814, XclmTxtService.cs ~2055-2084) with no de-duplication. Not the lag; a real bloat defect (slow saves, slow start).

**Expected:** duplicate rules are removed on load and save (NormalizeFloorRules returns distinct rules), lists capped, settings file stays small.

**Test that catches it:** load a settings file with 15,000 duplicate rules = normalised to the unique set; a size guard (< 200 KB) on the saved output.

**Steps for Tim:** none needed beyond a Codex check that Structural Settings still opens and keeps his real rules; his current file must be BACKED UP, then cleaned by the fix, never by hand (his rules are his).

**Status:** OPEN (29 Sep 23:10) - built, draft PR #399 (`claude/bug204-dedupe`, base rel-20260929c-struc). Root cause: the three rule lists start seeded with defaults and every load APPENDED the saved file onto them (about 24 per start); commit 34d8a295 had only fixed tie-down types. Fix: replace on load; remove exact duplicates on every load/save; nothing distinct is ever dropped; no cap. Sonnet review enough. Overlaps #392 in UserSettings.cs (same train). Back up Tim's CS_Settings.json before installing. Not tested in AutoCAD.

---

## BUG-205

**Command / Area:** CD (New Pipe window, Start Pipe direction question), Civil 3.0.15 installed.

**What Codex did (pass 18, 30 Sep 2026 05:02, DWG-B_P18 copy):** CD, picked two points, Enter, 225 UPVC Stormwater Standard, typed first IL 18 and second IL 17.8 (both showed "Staff entered"). New Pipe warned "The levels run the other way to how the pipe was drawn. Start Pipe will ask which direction to keep." Start Pipe then asked "Pipe was drawn Open end -> Open end, but the entered levels indicate Open end -> Open end. Is this correct?" (both ends called "Open end", so the two choices look identical). Codex clicked the clickable choice **UseLevelDirection**.

**Expected:** the pipe is made to flow from the 18.00 end to the 17.80 end (downhill), no uphill warning, and the choice shows the actual levels (18.000 -> 17.800) so a drafter can tell the two options apart.

**What happened:** Design Warnings said "Pipe flows uphill - upstream IL 17.800 is 200mm lower than downstream IL 18.000"; the flow arrow pointed left; the pipe was saved anyway (11C76C) with the footer "Warnings are informational - the pipe has been saved."

**Test that catches it:** unit test of the direction resolver: two open ends, entered levels 18.0 and 17.8, choice UseLevelDirection = upstream 18.0, downstream 17.8, no uphill finding; plus a wording test that the question names the levels. Codex repeat of the steps above.

**Steps to confirm the fix (Codex or Tim):** CD two points, type 18 then 17.8, Start Pipe, choose the level direction: the flow arrow runs 18.00 to 17.80 and there is no "flows uphill" warning; the question itself shows the two levels.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 100 "direction prompt consistency", section "05:03 Melbourne - #384 typed level provenance and direction"); screenshot `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\N384_direction_uphill_FAIL.png`. Civil log 05:02:16-05:02:17 (pipe 11C76C; "CD: uphill check").

**Likely area (hypothesis, not checked):** the CD direction question / level-direction handling added with the #384 batch (PR #384, installed in 3.0.15); the prompt builds its text from the pipe's end labels, which are both "Open end".

**Status:** OPEN (30 Sep 2026, found by Codex pass 18; not triaged for a fix).

---

## BUG-206

**Command / Area:** AutoCAD system variable OSMODE (Tim's running object snaps), across a whole Codex pass on Civil 3.0.15 / Structural 1.0.86.

**What Codex did (pass 18, 30 Sep 2026):** read CPROFILE and OSMODE at the start (after the first spline): CPROFILE Tim, OSMODE 21759. Read OSMODE again after the RC checks (21759, RC_OSMODE_restored.png). Ran many more commands in three drawing copies (Structural R9/R10/R11, Civil Q3, CDRG, CEBLOCKS, CD, tie-downs, UCS change). At 05:57 before shutdown: CPROFILE Tim, but the OSMODE prompt said <0>.

**Expected:** OSMODE finishes exactly as it started (21759). No CE command leaves Tim's snaps changed, on completion, on Escape or on error.

**What happened:** OSMODE was 0 at the end. Codex typed 21759 and read it back (21759) before closing AutoCAD, so Tim's profile value was put back by Codex, not by CE. Codex did not isolate which command did it and blames none.

**Test that catches it:** Codex: read OSMODE before and after each of RC (Yes, No, Escape at the question, Escape mid-cloud), CDRG (Place, Escape), CEBLOCKS, CDPAVE, CDKERB, CDSPOONDRAIN, CDPERIMETER, CDFALLSUGGEST, CDCATCHMENT, CSTIEDOWN and CD; the one that changes it is the culprit. The sweep C1 run started on 21759 (after Codex's restore), so it does not clear this.

**Steps to confirm the fix (Codex or Tim):** run the list above one command at a time on a copy, reading OSMODE between each: every read is 21759.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 3 PROFILE_CHECK_END, section "Shutdown and P13 resolution"); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\PROFILE_CHECK_END_OSMODE_FAIL.png` and `PROFILE_CHECK_END_OSMODE_RESTORED.png`.
**Likely area (hypothesis only, nothing verified):** any command that switches snaps off for its own preview and restores later: Structural RC ("Keep OSNAP ON?" question and its queued repeat), the CE snap presets ("Use Drawing now"), CDRG / CEBLOCKS placement. The last read known good was after RC; the failing read came after several later commands.

**Status:** OPEN (30 Sep 2026, found by Codex pass 18; cause Unknown).

**Codex 30 Sep sweep C1: does NOT clear this bug.** Sweep C1 read CPROFILE Tim / OSMODE 21759 at the start (`SWEEPC1\screens\profile-start-cprofile.png`) but ran almost no CE drawing commands, and AutoCAD crashed (BUG-224) before the end-of-run read, so the original session's final OSMODE is Unknown. A separate fresh recovery session read Tim / 21759 at 07:58 and 07:59 (`SWEEPC1\PROFILE_CHECK_END.json`, `PROFILE_CHECK_RECOVERY.json`, labelled as a different session). Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (items 9 and 10).

---

## BUG-207

**Command / Area:** Pit Schedule (PITSCHEDULE) drawn table versus Edit Pit / pit grip edits, Civil 3.0.15.

**What Codex did (pass 18, DWG-S_P18 copy, 30 Sep 05:20-05:36):** placed a fresh pit P1 (450 x 450, cover 20.00) and a fresh one-row linked schedule (cover 20.00, works). Double-clicked P1, changed Cover 20.00 to 20.1, Save ("Pit updated."). Then grip-moved P1.

**Expected:** the drawn schedule shows 20.10 straight after the edit finishes. Tim's ruling UX-LIVE-01 (25 Sep 2026, "Straight after each edit"): live labels, schedule and OSD block update as each edit finishes.

**What happened:** the plan text changed to CL 20.1 but the drawn schedule stayed 20.00, also after the grip move. PITSCHEDULE > Placement then said "Civil data changed in Current drawing (DWG-S_P18.dwg). Review the differences; the placed schedule has not changed." Only the manual button "Update existing schedule" brought the drawn table to 20.10 (P1 FROM P2, cover 20.10, P2 cover 20.20). Two cover levels disagreed on the sheet with no warning.

**Test that catches it:** unit/integration: place a linked schedule, edit a pit cover in Edit Pit, run the command-end pass: the drawn cell equals the new cover; or, if the design keeps a manual step, a visible "schedule out of date" mark appears on the drawn schedule at the moment of the edit. Codex repeat of the steps above.

**Steps to confirm the fix (Codex or Tim):** place a pit and a schedule, edit the pit's cover level in Edit Pit and Save, look at the drawn schedule without pressing anything: the new level is there (or the schedule is clearly marked out of date).

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 25 "Q3 fresh linked schedule automatic update", sections "Q3 fresh fixture follow-up" and "Q3 open-end connection / schedule refresh detail"); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\Q3_fresh_schedule_stale_FAIL.png`, `Q3_fresh_move_still_stale.png`, `Q3_manual_update_required.png`, `Q3_manual_update_drawn.png`.

**Design check needed:** the placement text "Review the differences; the placed schedule has not changed" suggests the current build deliberately makes update a manual review step. That conflicts with UX-LIVE-01 as recorded in `C:\CE_PLAN\decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`. Tim to say which he wants; Codex judged it a FAIL against the brief.

**Likely area (hypothesis only):** ScheduleLinkService.RefreshLinkedCells (log at 05:25 showed 1 call, 0.0 ms, i.e. it ran but changed nothing) and the schedule difference/review service (PitScheduleDifferenceService).

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-208

**Command / Area:** Pipe end grip / STRETCH on a CD-drawn pipe: "CE did not change its linked records" (Civil 3.0.15). Covers pass 18 Q2(b) and Q6 part 1 (both BLOCKED by this).

**What Codex did (pass 18, 30 Sep 05:38, fresh pipe 899 linked P2 -> P1 in DWG-S_P18 copy, created minutes earlier):** selected the pipe outline, activated the upstream end grip, typed `@-800,0` (STRETCH). Earlier the same happened on the older pipe 109E23 in DWG-B_P18 (after an ERASE/COPY of a pit, see BUG-210).

**Expected:** a normal end-grip edit on a fresh CD pipe moves the pipe end and CE's record together (or refuses both), and the message tells the drafter one exact action to take.

**What happened:** the pipe geometry shortened by 800 mm but CE refused the linked records: "[CE Civil] The AutoCAD geometry remains as edited, but CE did not change its linked records. The native edit has incomplete or invalid admission evidence. Run CE Repair/Audit before the next linked edit." The drawing and CE's data now disagree. The older pipe gave a different wording ("missing, damaged or protected linked drawing objects"). Because of this Codex could not build the "move a nearby pit onto the end" test (Q2b) or the 300 -> 375 then 5 m stretch (Q6 part 1). A later CDRG in the same drawing was refused with "The drawing and project do not describe the same complete pipe set" (see BUG-176 line).

**Test that catches it:** Codex: draw a fresh CD pipe between two pits, grip-stretch one end by 800 mm: the record follows (or both are refused); then Edit Pipe and the schedule agree with the drawn pipe. Unit: NativeEditPlan classification of a fresh CE pipe object as admissible.

**Steps to confirm the fix (Codex or Tim):** CD a pipe pit to pit, drag its end grip 800 mm, then open Edit Pipe: it shows the new length and end; no "admission evidence" message.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (checks 20 and 103, section "Q2(b) fresh-fixture retry - 05:38 Melbourne"); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\Q2b_fresh_pipe_guard.png`, `Q2b_setup_guard.png`. Civil log 05:38:05.751 [WARN] [NetworkEdit] GRIP_STRETCH.

**Likely area (hypothesis only):** `Modules/Drainage/Services/NativeEditPlan.cs` (the "incomplete or invalid admission evidence" refusal) and `NativeEditApplyPlan.cs` ("straight-pipe admission evidence is incomplete"), through `LinkService.NativeEdits.cs`.

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-209

**Command / Area:** CDCATCHMENT > New (Civil 3.0.15): area shown and capacity warning.

**What Codex did (pass 18, DWG-B_P18 copy, 30 Sep 03:45):** drew a small closed rectangle beside grated pit P66 (about the size of the 33.3 m2 CDPAVE rectangle), CDCATCHMENT > New, picked its top edge, picked P66, Enter.

**Expected:** a plausible area in square metres (about 28.45 m2 by comparison with the adjacent pavement) and no overload warning.

**What happened:** "[CE] P66's catchment is 28447480.8 m2, over the assumed Class A capacity of 40 m2. Check the grate can take this area, or split the catchment to another pit." A false capacity warning that would send a drafter to split a catchment. Codex's inference (not a code diagnosis): the area is not converted from drawing units (mm2) to m2 before display and comparison. The blue label on the blue fill is also barely readable.

**Test that catches it:** unit: a 5,334 mm x 5,334 mm closed polyline in a millimetre drawing reports about 28.45 m2; capacity comparison uses m2. Codex repeat.

**Steps to confirm the fix (Codex or Tim):** draw a 5.3 m x 5.3 m rectangle, CDCATCHMENT > New, pick its edge and a pit: the message says about 28 m2.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 60, section "R5 catchment continuation"); screenshot `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\R5_catchment_area_FAIL.png`. No exception in the Civil log.

**Likely area (hypothesis only):** the catchment overlay command added with the fall-arrow/catchment batch (#312): area measured from the picked polyline before unit scaling.

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-210

**Command / Area:** ERASE a pit then COPY another pit onto the junction (Civil 3.0.15): the replacement pit is not linked.

**What Codex did (pass 18, DWG-B_P18 copy, 30 Sep 00:21-00:23):** erased P3 (six pipes attached; message "The pit was erased and the schedule is updated. 6 pipes now have ends that are Not connected yet. U restores everything."). COPY of P2 onto the exposed junction: "1 pit copied and numbered as new" and it took the mark P3.

**Expected:** the replacement pit links to the six pipe ends straight away (or clearly says it did not), and Edit Pipe, Edit Pit and the Pit Schedule all agree.

**What happened:** Edit Pipe named P4 -> P3, but Edit Pit said for every nearby pipe "The pit has no recorded connection to this pipe", and the Pit Schedule showed P3 with blank FROM / inlet / outlet and P2 with "Unknown" for its former P3 inlet. A later, unrelated PIT command (00:50) then linked the six old pipes to the copied P3, so the repair was delayed, not immediate. After this the same drawing refused pipe end edits (BUG-208).

**Test that catches it:** Codex: erase a pit with connected pipes, COPY another pit onto the junction, open Edit Pit and the schedule at once: connections listed. Unit: CloneReconcile after COPY re-links pipe ends within the pit's catch margin.

**Steps to confirm the fix (Codex or Tim):** erase a mid-run pit, copy a neighbouring pit onto the gap, open the Pit Schedule and Edit Pit: both show the pipe connections.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 19, section "Q2(a)"); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\Q2a_schedule_missing_links.png`, `Q2a_pit_no_connections.png`, `Q2a_after_P4_P3new.png`. Log 00:23:00.554 `[CloneReconcile] command=COPY placements=1 repaired-pits=1 repaired-pipes=0 ... regenerated-pipes=0`.

**Likely area (hypothesis only):** the CloneReconcile pass after COPY (repaired-pipes=0), and the pit relink pass (ApplyPendingPitRelinks) not being run for a copied pit. See also the desk's COPY versus CSUNITCOPY design note.

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-211

**Command / Area:** ERASE a Structural column that has a beam attached (Structural 1.0.86, C1 toolbar column + Beam ribbon command `1`).

**What Codex did (pass 18, DWG-S_P18 copy, 30 Sep 02:48):** placed 89 SHS column C1, placed a beam starting on C1 (command `1`: picked C1 first, Enter, picked the free end, accepted default label and preview). Selected C1 and pressed Delete.

**Expected:** a question about the attached beam (delete it too, keep it, detach), as Tim's workflow expects, before the erase completes.

**What happened:** the column vanished silently; the beam and the C1 label stayed. Command history only "_.erase 1 found". Later rotate/scale of a column proved the beam does follow the column, so the link exists; U restored the erase. Codex did not inspect the link record itself.

**Test that catches it:** Codex: place column and beam, erase the column: prompt or clear message about the beam; U puts everything back. Unit: erase of a linked support with a beam raises the question.

**Steps to confirm the fix (Codex or Tim):** place a column and a beam from it, delete the column: CE asks what to do with the beam.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 39, section "P12 - 30 Sep 02:50"); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\P12_support_erased_no_prompt.png`, `P12_erase_exact_text.png`. Structural log 02:48:31.780 BeamLink.ObjectErased 1 call, no prompt.

**Design check needed:** whether the "ask per linked beam" behaviour was ever specified (STRUC-D2 beam-follow work); the brief expected a prompt. Codex records it as a FAIL of the observed workflow.

**Likely area (hypothesis only):** Structural BeamLink.ObjectErased / CommandEnded.ProcessPendingWork (both ran, 0.0 ms, no prompt).

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-212

**Command / Area:** Pit Schedule > Place schedule on a pit from an older drawing (Civil 3.0.15).

**What Codex did (pass 18, DWG-S_P18 copy, 30 Sep 04:51-04:53):** the drawing had no linked schedule ("No linked pit schedule was found"). Grip-moved recognised pit P1 (450 x 450, cover 20.00). Reopened PITSCHEDULE > Continue to Place / update > Place schedule > picked an insertion point.

**Expected:** one new linked schedule.

**What happened:** an error window: "The schedule cells and source record could not be stored together. Nothing was placed; please try again." Nothing was drawn (that part is honest and safe). Log: "Pit schedule placement transaction failed: InvalidOperationException: A schedule row has no permanent identity." Retrying cannot help. A fresh pit placed in the same copy did place a schedule (Q3 fresh pit, PASS), so the fault is a legacy pit with no permanent identity.

**Test that catches it:** Codex: place a schedule for a pit that predates the identity system: either identity is given first, or the message names the pit and the repair. Unit: PitScheduleViewModel placement with a row lacking identity.

**Steps to confirm the fix (Codex or Tim):** open an older drawing, PITSCHEDULE, Place schedule: it places, or names the pit and offers the repair in one click.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 23, section "Q3 fresh schedule case - 04:55"); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\Q3_new_schedule_FAIL.png`, `Q3_S_no_schedule.png`, `Q3_S_move_before.png`. Civil log 04:53:13.163 [ERROR].

**Likely area (hypothesis only):** `Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs` (~line 775, the "Nothing was placed; please try again." text) and `PitScheduleDifferenceService.cs` (row "has no permanent identity").

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-213

**Command / Area:** Pit Schedule > Placement for an older schedule (Civil 3.0.15).

**What Codex did (pass 18, DWG-B_P18 and DWG-A copies, 30 Sep 00:30-01:10):** opened PITSCHEDULE > Placement in drawings whose schedule was placed by an older build.

**Expected:** a way to re-place the older schedule (a "Replace older schedule..." action with a preview and one U), because the window itself says to do so.

**What happened:** the window says "UNLINKED SCHEDULE. An older pit schedule exists without a linked source record. It is preserved; deliberately re-place it before linked status can be shown." but the only button is "Update existing schedule", disabled. No re-place control anywhere. So five live cell-update checks (Q3) could not be run against any old schedule, and P2's schedule updates stayed blocked.

**Test that catches it:** Codex: open an older drawing with an old schedule: a visible, enabled Replace/Re-place action exists and one U undoes it.

**Steps to confirm the fix (Codex or Tim):** open a drawing with an old schedule, PITSCHEDULE > Placement: a Replace older schedule button is there and works.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 22, section "Q1 network and Q2(c) evidence" item Q3 existing schedule); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\Q3_unlinked_schedule.png`, `Q3_disabled_update.png`.

**Likely area (hypothesis only):** the Placement page of the Pit Schedule window (button enable rule for a schedule with no source record).

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-214

**Command / Area:** CEFIND (Civil), and a drawing marked "changed" with no edit (Civil 3.0.15 / Manager 1.1.15, sweep C1).

**What Codex did (sweep C1, 30 Sep 2026, copies):** on a clean fixture (CleanBlank: 0 objects, DBMOD 0, no CE project dictionary) typed CEFIND, then pressed Esc at "Type a pit, tag or pipe to find (e.g. P7, WT1, P3-P4):". Also reproduced on a 5,100-line drawing and on a reopened Blank copy.

**Expected:** Find is read-only. Cancelling leaves a clean drawing clean; closing it gives no "Save changes?" prompt.

**What happened:** the drawing became modified (DBMOD 0 -> 1) before any input; Esc left it modified. U printed "CEFIND" but the flag stayed 1; REDO said "Nothing to redo" (on CleanBlank: "Everything has been redone"). Closing showed a save prompt (answered No). The 27 query cases (words, typos, symbols, 0/negative/999999, 200/300 characters) changed no objects. Second, weaker observation: on a Structural-named copy (cold start 1) merely opening the drawing left DBMOD 1 and a save prompt on close; the log shows the automatic pit-block migration ran, so that one may be by design; Codex records the attribution as Unknown. Also: P2 was visible as a drawn label on DWG-A but CEFIND said not in drawing (ownership Unknown).

**Test that catches it:** Codex: open a clean drawing, CEFIND, Esc, read DBMOD: 0. Unit: CEFIND start-up writes nothing (no dictionary creation, no marker write).

**Steps to confirm the fix (Codex or Tim):** open a drawing you have not touched, type CEFIND, press Esc, close it: no "Save changes?" question.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 78 "CEFIND", item 1 "Cold start 1", Method items 9, 12, 17); evidence `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\cefind-cancel-undo-redo-dirty.png`, `cefind-cleanblank-prompt.png`, `cefind-empty-prompt-dirty.png`, `cefind-unexpected-save-prompt.png`, `cefind-five-undo-redo.png`, `dwg-s-save-prompt-on-close.png`; data `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\cefind-cleanblank-recovery.json`.

**Likely area (hypothesis only):** the CEFIND command's start (a write into the drawing, e.g. the CE_LINKS_MIGRATED_V2 marker, which was the only CE entry on CleanBlank) and the open-time pit-block migration.

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1; root cause Unknown).

**Codex 30 Sep sweep C1 (final report): unchanged, FAIL confirmed, reproduced on three drawings** (item 78, FAIL item 3, UX finding 2): the clean CleanBlank (0 objects, DBMOD 0, no CE project dictionary; only the CE_LINKS_MIGRATED_V2 marker), the reopened Blank copy and the 5,100-line Heavy copy. CEFIND then Esc: DBMOD 1, 0 objects. One U prints CEFIND but DBMOD stays 1; REDO says "Nothing to redo" (CleanBlank: "Everything has been redone"); five U / five REDO the same. Native CLOSE then showed the Save prompt (answered No). No unique error log line; root cause Unknown. Evidence `SWEEPC1\cefind-cleanblank-recovery.json`, `cefind-empty-undo-redo.json`, screenshots `SWEEPC1\screens\cefind-cleanblank-prompt.png`, `cefind-five-undo-redo.png`. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md`.

---

## BUG-215

**Command / Area:** RC (Structural rectangular revision cloud), Structural 1.0.86. Related to BUG-169.

**What Codex did (pass 18, DWG-S_P18 copy, 30 Sep 04:24):** DIMSCALE 20, RC, Yes to Keep OSNAP ON, two corners: cloud drawn (arcs 90). Then U as the very next command.

**Expected:** one U removes the cloud (one Undo step for the cloud and its temporary layer/snap changes).

**What happened:** the first U named "RC" but the cloud stayed; a second U named "REVCLOUD" and removed it. A drafter would think U did nothing.

**Test that catches it:** Codex: RC, then U once: the cloud is gone. Unit/contract: RC creates one Undo step.

**Steps to confirm the fix (Codex or Tim):** draw a cloud with RC, type U once: it disappears.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 92, section "RC BUG-169 - model-space results" item 5); screenshot `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\RC_immediate_U_FAIL.png`. Structural log 04:26:02 shows only BeamLink.ObjectErased, no cloud error.

**Likely area (hypothesis only):** the RC restore (PR #386): RC queues one silent "RC" after REVCLOUD so Enter repeats RC; that extra command may be the first U step.

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-216

**Command / Area:** CDFALLSUGGEST (Civil 3.0.15): "Enter to finish".

**What Codex did (pass 18, DWG-B_P18 copy, 03:33):** CDFALLSUGGEST near grated P66, entered level 19.23 m, accepted the suggested FALL toward P66 at 1:27.1 (works). At "Next level (1 placed, 0 skipped), or Enter to finish:" pressed Enter.

**Expected:** Enter finishes and prints the placed/skipped count.

**What happened:** "Invalid point." twice and the same prompt. Esc finished ("CDFALLSUGGEST finished. 1 placed, 0 skipped.") and kept the arrow. Same family as BUG-200 (CDCHECK Enter).

**Test that catches it:** Codex: place one suggested fall, press Enter at the next prompt: it finishes. Unit: the prompt accepts an empty result.

**Steps to confirm the fix (Codex or Tim):** CDFALLSUGGEST, place one arrow, press Enter at "Next level": the command ends and reports the count.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 57, section "R5 fall suggestion and check" item 2); screenshot `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\R5_Enter_finish_FAIL.png`.

**Likely area (hypothesis only):** `Modules/Drainage/Commands/FallSuggestCommand.cs` (~lines 65-66, the prompt text; the point prompt probably lacks AllowNone).

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-217

**Command / Area:** CDPERIMETER (perimeter drain, Civil 3.0.15): the drawn tag.

**What Codex did (pass 18, DWG-B_P18 copy, 04:00):** CDPERIMETER, two vertices, Enter, skip outlet, IL 18 to 17.9, Enter at Accept. Command reported "Perimeter drain PD1 placed ... Grade 1:72.3 - meets the office minimum 1:100" (that part passed).

**Expected:** the drain on the plan carries its own PD tag (PD1), matching the command line and the record.

**What happened:** the line on the plan repeats "AG" text and no PD tag is visible. Prompts also say "AGI vertex" and "Place this AGI drain?" while the preview says perimeter drain. Codex could not tell an intended linetype from a missing tag.

**Test that catches it:** Codex: place a perimeter drain and read the visible text: PD1. Unit: the drawn text for a PD drain is its PD mark.

**Steps to confirm the fix (Codex or Tim):** CDPERIMETER two points, accept: the drain is labelled PD1 on the plan.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 65, section "R6 perimeter drain"); screenshot `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\R6_PD1_placed.png`. Log 03:58:08.685 "[PD] Registered surface drain PD1 handle=11C769".

**Likely area (hypothesis only):** CDPERIMETER re-uses the AGI drain drawing code (AgiCommand.cs prompts "AGI vertex"), so the drawn text is the AGI tag.

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-218

**Command / Area:** CSBRACINGPANEL (Structural 1.0.86).

**What Codex did (pass 18, DWG-S_P18 copy, 04:08):** typed CSBRACINGPANEL.

**Expected:** the bracing-length panel appears (in front, focused).

**What happened:** command line said "Bracing panel shown. Set required lengths with CSBRACINGREQUIRED." No panel was visible after a refresh; only the existing Structural Time palette showed; the window inventory listed no new panel. Codex records the visible failure, not the cause. No CSBRACINGPANEL error in the Structural log.

**Test that catches it:** Codex: run CSBRACINGPANEL with the Command Hub docked and closed: the panel is on screen. Unit: the panel show call brings the palette forward.

**Steps to confirm the fix (Codex or Tim):** type CSBRACINGPANEL: the bracing panel is visible.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 68, section "R8 partial results"); screenshot `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\R8_bracing_not_visible.png`.

**Likely area (hypothesis only):** the palette host (auto-hidden or docked behind another tab, as CEBLOCKS and CEASK also show).

**Status:** OPEN (30 Sep 2026, found by Codex pass 18).

---

## BUG-219

**Command / Area:** the AutoCAD status-bar text for Manager, and any place where the version is not read from the running assembly (Manager 1.1.15 installed). Earlier sighting: X1 finding 12 (29 Sep), and pass 18 UX 27.

**What Codex did (sweep C1, 30 Sep 2026):** opened CEMANAGER > Module pages for Civil, Manager and Structural (versions and hashes match the installed DLLs: Civil 3.0.15, Manager 1.1.15, Structural 1.0.86), then read the AutoCAD status bar.

**Expected:** every place that shows a version shows the running one.

**What happened:** the status bar says "CE MANAGER v1.1.10" while the Manager module page says 1.1.15. Pass 18 saw the same strip ("still says 1.1.10"). Colleagues would think they are on an old build.

**Test that catches it:** unit: the status-bar version string equals the Manager assembly's product version; Codex: read the status bar and the Module page on the same run.

**Steps to confirm the fix (Codex or Tim):** after an install, the status bar version equals the CEMANAGER Module page version.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 388 "Manager three-version agreement", UX finding 1); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\cemanager-module.png`, `cddiag-heavy-output.png`; pass 18 `P18_screenshots\Q3_manual_update_drawn.png`.

**Likely area (hypothesis only):** a fixed version string in Manager (1.1.10 was the version live on 28 Sep 11:19); `Modules/Manager/Services/CeDiagnosticsService.cs` reads `Plugin.Version`, so check what the status bar reads.

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1).

**Codex 30 Sep sweep C1 (final report): unchanged, FAIL confirmed** (item 388, FAIL item 5, UX finding 4): the module pages match the installed DLLs (Civil 3.0.15, Manager 1.1.15, Structural 1.0.86, exact hashes) while the status bar reads CE MANAGER v1.1.10. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md`.

---

## BUG-220

**Command / Area:** AutoCAD start-up, Structural tools launcher window (Structural 1.0.86).

**What Codex did (sweep C1, 30 Sep 2026 06:13, cold start 1):** double-clicked a drawing in Explorer with AutoCAD closed.

**Expected:** a quiet start: the drawing opens and the CE tab appears; no window opens unless the drafter asks for it.

**What happened:** a Structural tools launcher window appeared by itself and had to be closed with X. It appeared on two starts (not on the "no drawing" start). The drawing was ready at 40.8 s and the CE tab at 59.3 s (both include Codex's inspection delay, not a product timing). The drawing was a Civil-discipline copy (CDDISCIPLINE says Civil, set explicitly).

**Test that catches it:** Codex: cold start with a Civil drawing and with a Structural drawing: no window opens unrequested.

**Steps to confirm the fix (Codex or Tim):** close AutoCAD, double-click a drawing: no launcher window appears.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 1 "Cold start 1", UX finding 3); screenshot `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\cold1-structural-launcher.png`.

**Likely area (hypothesis only):** the Structural start-up / palette launcher (Command Hub) opening on load; not searched in code.

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1).

**Codex 30 Sep sweep C1 (final report): unchanged, FAIL confirmed** (item 1 Cold start 1, FAIL item 2, UX finding 5). Final report also says the launcher was NOT seen on the second (no-drawing) start, so it depends on the start; Structural startup silence (BUG-203) was BLOCKED because the fixture is a Civil drawing. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md`.

---

## BUG-221

**Command / Area:** CEMANAGER > Status tab layout (Manager 1.1.15).

**What Codex did (sweep C1, 30 Sep 2026):** opened CEMANAGER at its default size 1311 x 1073 and at maximised 1920 x 1080.

**Expected:** each card shows its running version, build hash and "Installed next start" value separately and readable.

**What happened:** in all three cards (Civil, Manager, Structural) the running build/hash text overlaps the "Installed next start" values, at default and maximised size.

**Test that catches it:** Codex: read the Status tab at 1311 x 1073 and 1920 x 1080 at 100% and 150% scale: no overlap. A render test of the card layout with a 40-character hash.

**Steps to confirm the fix (Codex or Tim):** open CEMANAGER > Status: every value is legible and separate.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 517, UX finding 8); screenshot `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\cemanager-status-default.png`. Codex suggestion: short version prominent, full hash in a copyable detail line.

**Likely area (hypothesis only):** the Status card XAML in Manager (version + hash in one row).

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1).

**Codex 30 Sep sweep C1 (final report): unchanged, FAIL confirmed** (item 517, FAIL item 6, UX finding 9), at default 1311 x 1073 and maximised 1920 x 1080. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md`.

---

## BUG-222

**Command / Area:** CEMANAGER > Settings > Civil form (Manager 1.1.15). Breaks Tim's rule: high-use windows never scroll their layout (tabs or regroup; long lists and help pages may scroll).

**What Codex did (sweep C1, 30 Sep 2026):** opened CEMANAGER > Settings > Civil at 1311 x 1073.

**Expected:** the settings sit in task tabs (as CDS does), all visible without a long vertical scroll.

**What happened:** the whole Civil settings form needs a long vertical scroll to reach the bottom (first field to the last: Reset Civil). Codex ranks it ANNOYING; it is a standing-rule breach.

**Test that catches it:** Codex: open the page at 1311 x 1073: every field reachable without the main scrollbar; or a render test that the form height fits a 1073-high window.

**Steps to confirm the fix (Codex or Tim):** open CEMANAGER > Settings > Civil: fields are grouped in tabs and none needs scrolling.

**Reference:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 518, UX finding 7); screenshots `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\cemanager-settings-civil.png`, `cemanager-settings-civil-middle.png`, `cemanager-settings-civil-lower.png`, `cemanager-settings-civil-bottom.png`. Codex suggestion: host the same task tabs CDS uses.

**Likely area (hypothesis only):** `CivilSettingsView` in Manager (single long form).

**Status:** OPEN (30 Sep 2026, found by Codex sweep C1).

**Codex 30 Sep sweep C1 (final report): unchanged, FAIL confirmed** (item 518, FAIL item 7, UX finding 8); the sweep's own note: the Civil settings form is a settings layout, not an allowed reading/list scroll. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md`.

---

## BUG-195 .. BUG-201 (Codex exploratory run X1, 29 Sep 2026 14:14-14:51, Civil 3.0.14 / Structural 1.0.85, test copies)

Full steps, screenshots and logs: `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_EXPLORE1_REPORT_2026-09-29.md` (finding numbers in brackets). No crash; 0 confirmed slow spots.
1. **BUG-195 (Structural, X1 #2):** XCLMTXT import of a two-row CSV with no floor column assigned the rows to "First Floor" and "Second Floor" and the review said nothing needed attention. Expected: missing floor asked or left unassigned (Unknown stays Unknown). OPEN. **29 Sep 19:00 (controller 06): fix already on the Structural live line - commit ccd31d62 "Fix BUG-195 and BUG-196", in 1.0.86 installed 17:05 (ancestry checked). Not FIXED: Codex re-test on 1.0.86 first.**
2. **BUG-196 (Structural, X1 #3):** STRSCHEDCREATE table outlines are drawing-size but the cell text is tiny marks - unreadable. OPEN. **29 Sep 19:00 (controller 06): fix already on the Structural live line - ccd31d62 plus 4a0bc721 (scale and cell margins), in 1.0.86; tests `TableMetrics_*`. Residual: tables already drawn keep old text; the XCLMTXT "MEMBER SCHEDULE" block keeps its fixed sizes 300/200 - **CLOSED by Tim's ruling 29 Sep ~22:50: "No, keep 300 and 200" (decisions/2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md)**; do not size it by the other schedules' rule. Not FIXED: Codex re-test STRSCHEDCREATE on 1.0.86 first.**
3. **BUG-197 (Civil, X1 #5):** a new branch's invert labels overlap each other and its flow arrow clashes with the main's label. OPEN. **29 Sep 19:20 (controller 06): built, draft PR #388 (`claude/bug197`, base rel-20260929c; CD draw now tidies the host main's labels first; 6 new tests, focused 27/27, full Civil net10 7 failures = the known 7; PR files verified). Opus review REQUIRED (LinkService.TextClashTidyUp.cs). Watch for review: a hand-dragged main label under a new branch also moves (Reset Position undoes it). Not tested in AutoCAD.**
4. **BUG-198 (Civil, X1 #6):** CDEDIT changing ONLY the diameter (100 -> 150) changed the displayed grade (was 1 IN 100). OPEN. **29 Sep 18:45 (controller 06): fix already on the live line - commit 89ad7fc2, in Civil 3.0.15 installed 17:05, tests `Bug198_*` in X1CdLevelsFixesTests (code read by the controller). Not FIXED: Codex re-test in Part Z on 3.0.15 first.** **Codex 30 Sep pass18: STILL FAILING on installed Civil 3.0.15 (which contains fix 89ad7fc2).** Fresh 225 UPVC pipe at 1 IN 100 (invert labels 18.00 / 17.90); double-click the label, Edit Pipe, change only Diameter to 300, Save: the label became "300 DIA. UPVC PIPE AT 1 IN 99", invert labels unchanged, no warning, command line "Pipe updated." Route differs from X1 (Edit Pipe window Save, not the CDEDIT sequence); not checked whether the `Bug198_*` tests cover it. Screenshot `P18_screenshots\N384_diameter_grade_FAIL.png` (`N384_edit_before.png` before); report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 96).
5. **BUG-199 (Civil, X1 #7):** CD with only the upstream invert typed: the calculated downstream level (18.41) is labelled "Staff entered" like the typed one. OPEN. **29 Sep 18:45 (controller 06): fix already on the live line - commit 89ad7fc2 (label now "Calculated from grade"), in Civil 3.0.15; tests `Bug199_*`. Not FIXED: Codex re-test in Part Z on 3.0.15 first.** **Codex 30 Sep pass18: PARTLY PASSED on installed Civil 3.0.15.** PASS (Codex-accepted): route to an existing pit with only the upstream 19.5 typed: upstream "Staff entered", downstream 19.47 "Calculated from grade" (`P18_screenshots\Q3_pipe_fixture_calculated.png`); typed 18 and 17.8 both "Staff entered" (`N384_typed_staff_entered.png`). STILL FAILING for a route with two open ends: with the route picked and only IL 18 typed, the downstream field says "Calculated after pipe length is known" and the preview caption says "Unknown" until Start Pipe, although the plan then shows 17.93 / 17.90 (`N384_provenance_unknown.png`). Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (checks 97-99).
6. **BUG-200 (Civil, X1 #10, UX):** CDCHECK "Enter to finish" goes to a second prompt instead of finishing; a typed next command is swallowed. OPEN. **29 Sep 19:05 (controller 06): built, draft PR #387 (`claude/bug200-201`, BUG-200 + BUG-201; 11 new tests; full Civil net10 5 failures = known). Opus review REQUIRED (SpineCheckCommand.cs). Not tested in AutoCAD.** **Codex 30 Sep pass18: not specifically tested.** Only a hint: CDCHECK (All) completed on the DWG-B_P18 copy (212 objects, 184 connections, 22 findings, no crash) and Enter exited each follow-up prompt (`P18_screenshots\R5_CDCHECK_complete.png`). The BUG-200 fix (PR #387) is not in the installed 3.0.15, so this is not acceptance. The same Enter problem was found in CDFALLSUGGEST: BUG-216.
7. **BUG-201 (Civil, X1 #9, UX):** ordinary pit placement prints internal diagnostic jargon on the command line. OPEN. **Codex 30 Sep pass18: STILL PRESENT on installed Civil 3.0.15.** PIT placement still prints "Auto inline split skipped: No inline pipe segment found at owner point. considered=50, geometryRejected=36, hitboxRejected=14, nearestPipe=11C584, nearestDistance=1060.128." (and, at a pipe end, the same text followed by hundreds of digits) before "Pit placed successfully." Screenshots `P18_screenshots\BUG192_PIT_placed.png`, `Q3_P2_open_end_placed.png`; report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (journal items under BUG-192 PIT and "Q3 open-end connection"). The fix (PR #387) is not installed.
Also from X1: **BUG-192 REPRODUCED (X1 #1)** - CD a branch onto a main, U (view), U (CD), then REDO straight away: "Nothing to redo". **BUG-193 still failing on 3.0.14 (X1 #4)** - typing "1200 x 900" in the Pit Schedule SIZE cell shows blank outside the editor. UX (ideas): CD preview omits the pending route and completing loses the view (X1 #8); two "CE Settings" menu entries open different windows (X1 #11); status bar vs Structural Settings show different installed versions (X1 #12).

---

## BUG-194

**Command / Area:** CE contextual ribbon tab (Pipe tab), Civil 3.0.13 / Structural 1.0.82, on a Structural drawing.

**What Tim did / saw (29 Sep 2026, live, screenshot):** in a Structural drawing (_STR_ file) he selected a plain closed rectangle (a polyline on layer HATCHOUTLINE, part of a wall/footing section detail). The ribbon switched to the CE **Pipe** tab (Edit Pipe, Adjust Positions, Reverse Flow, Focus, Close). Tim: "rectangle opens ce pipe in ribbon when im in a structural drawing".

**Expected:** the Pipe tab appears only when a real CE pipe is selected. A plain polyline (any layer, any drawing) never brings it up. The CE Inspector already got it right: "Not a CE object - Polyline - ownership not linked".

**Likely cause (hypothesis, not verified):** since C7 the CE pipe object is built on a Polyline, so the contextual-tab rule probably checks the object TYPE (polyline) instead of CE ownership (the pipe's CE record / XData), the check the Inspector uses.

**Test that catches it:** the contextual-tab decision for a plain polyline, a closed rectangle, a CE pipe (C7 object) and a legacy CE pipe: only the two CE pipes show the tab.

**Steps for Tim to confirm the fix:** open a Structural drawing, click any plain rectangle or polyline: the ribbon stays where it was. Then in a Civil drawing click a CE pipe: the Pipe tab appears.

**Status:** IN PROGRESS (29 Sep ~13:30) - fixed, draft PR #380: `CivilSelectionClassifier.ClassifyEntity` decided the tab by object type (any polyline = pipe; any non-pit block = source). Now it uses CE ownership like the Inspector (C7 pipe object / CE pipe record or data; twin barrels only with a real CE owner; a block is a Source only with CE's source tag). Pits still recognised by block name. CE_SHARED untouched. Watch: older downpipe blocks without CE's source tag will no longer bring up the Source tab. Banked for 3.0.14.

---

## BUG-193

**Command / Area:** Pit Schedule (PITSCHEDULE), typed SIZE cell (Civil 3.0.12).

**What Codex did (pass 17, 29 Sep 2026, DWG-B copy):** filtered to P6 (ordinary pit, 900 x 900), double-clicked its SIZE cell, typed 1200 x 1200, Tab, Close.

**Expected:** the drawn pit itself resizes to 1200 x 1200 (block, label, cover text), as the feature promised.

**What happened:** the cell went blank and PITEDIT still showed 900 x 900. Screenshots P17_screenshots 172-185 (`C:\Lisp Files\_TEST_COPIES_20260923\`).

**Test that catches it:** the size-parse + apply path with "1200 x 1200" (spaces, lowercase x) and "1200x1200".

**Steps for Tim to confirm the fix:** open the Pit Schedule, type 1200 x 1200 into an ordinary pit's SIZE, close: the pit on the plan is now 1200 x 1200 and PITEDIT agrees.

**Status:** IN PROGRESS (29 Sep ~05:30) - built, draft PR #362: the schedule treated a typed SIZE as a pending 'override' before the resize check ran, so the resize never fired and the cell blanked. SIZE now always goes straight to the same resize route PITEDIT uses. PitSchedule tests 531/531 both lanes. Note: builder's full-suite count (12,132 total, 5 failures) differs from the usual 12,231 / 7 - the next install gate re-checks by name. Banked for the next install.

**Codex 30 Sep pass18: PASSED on installed Civil 3.0.15 (Codex-accepted for this scope only: ordinary pit P1 450 x 450, not the P6 900 x 900 case).** Pit Schedule > Rows, double-click SIZE, typed `1200 x 900`, Enter, Close: the cell kept its text, the drawn pit became 1200 x 900, Edit Pit showed plan size 1200 / 900; log `[PitFit] pit P1 resized 450x450 -> 1200x900`. Screenshots `P18_screenshots\N384_size_before.png`, `N384_size_typed.png`, `N384_size_record.png`. Status left as it is: marking FIXED (Codex-accepted, pass 18) is the controller's call. Small leftover: the row group heading still showed 450 after the edit (POLISH). Report: `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 101).

---

## BUG-192

**Command / Area:** Undo/Redo in a CE drawing (Civil 3.0.12).

**What Codex did (pass 17):** five U (PASTECLIP, GROUP, MOVE, INTELLIZOOM, PITEDIT), then REDO twice.

**Expected:** REDO puts back the last undone step.

**What happened:** "Nothing to redo" both times. Hypothesis: CE writes something to the drawing after a U (for example its project-data save or a cache write), which clears AutoCAD's redo. Also possible: the sequence itself (AutoCAD's REDO only follows a U directly). Not proven.

**Test that catches it:** Codex - PIT, U, REDO straight away: the pit comes back; repeat with a pit move.

**Steps for Tim to confirm the fix:** move a pit, U, REDO: the pit goes back to where you moved it.

**Status:** OPEN (reproduce cleanly first).

**Codex 30 Sep pass18: STILL FAILING on installed Civil 3.0.15, reproduced five times with no command between U and REDO:** (1) PIT, U, REDO = "Nothing to redo" (`P18_screenshots\BUG192_PIT_REDO_FAIL.png`); (2) fresh pit grip-moved 767 mm, U, REDO (`BUG192_A_grip_REDO_FAIL.png`); (3) CD pipe, U, REDO (`N384_clean_CD_REDO_FAIL.png`); (4) network pit grip move, U, REDO (`Q2c_REDO_failure.png`); (5) five U then two REDO (`P3_REDO2_FAIL.png`). New evidence: the [REDO] diagnostic named a CE writer in (4) and (5): `object changed (DrawOrderTable); CE code: LinkService.OnObjectModified < ProjectDataService.TryLoadFromDrawing < ProjectDataService.ReloadAfterDrawingHistoryChange < LinkService.OnCommandEnded` (Civil log 00:17:06.297 and 02:18:58.047), and one line "96 write(s) reached the drawing between the end of REDO and the start of GRIP_STRETCH; AutoCAD discards its Redo list after a write". In (1)-(3) the clean interval had no [REDO] line. Likely area: ProjectDataService.ReloadAfterDrawingHistoryChange (draw order re-applied after U); BUG-203 (Civil awake in Structural drawings, PR #393, not installed) may add more writes. Report: `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (checks 21, 29, 30, 33, 102; section "Complete REDO diagnostic lines").

**Codex 30 Sep sweep C1 (final report): STILL FAILING on installed Civil 3.0.15, now on a drawing with NO pits or pipes (CleanBlank, 0 objects).** CDDISCIPLINE Unknown -> Civil, then one U returned "CDDISCIPLINE" and restored Unknown, and the very next REDO said "Nothing to redo"; repeated with five alternating Civil/Structural changes, five U (each named CDDISCIPLINE), five REDO (each "Nothing to redo"), final discipline Unknown, objects 0 throughout. Same pattern with CEFIND (five U, five REDO, "Nothing to redo"). **New evidence, this time with the writer named on an empty drawing:** the Civil log at 07:52:32-33 has `[REDO] write after U finished, before the next command: object changed (Xrecord) / (DBDictionary) / object erased (Xrecord) / (DBDictionary); CE code: LinkService.OnObjectModified` and `...OnObjectErased`, each followed by "Project data reloaded after Undo/Redo: pits=0, pipes=0". Codex records this as correlation only (causality not established). It shows the CE write-after-U happens even with no pits, so BUG-203's hypothesis (an empty Civil record in a Structural drawing) is not the only route. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (item 92, FAIL item 4, UX finding 3); evidence `SWEEPC1\redo-log-extract.txt`, `cddiscipline-five-undo-redo.json`, `cddiscipline-all-undo-commandline.txt`; screenshots `SWEEPC1\screens\cddiscipline-undo-redo-commandline.png`, `cddiscipline-five-redo-commandline.png`, `cddiscipline-redo-lost.png`. The same session then crashed (BUG-224).

---

## BUG-191

**Command / Area:** Inspector palette, "Use plan label" button (`InspectorPaletteService.UsePlanLabel`, Civil).

**What happens (found in code by the BUG-190 builder, 28 Sep 2026; not seen in AutoCAD):** the button renames the pit record from its plan label and saves straight away under its own document lock, with no command running. Taking a lock outside a command is the pattern that made the U1 bug: AutoCAD records an unnamed Undo step, so U can show a bare "Command: U" and undo the wrong thing.

**Expected:** "Use plan label" behaves like a normal CE edit: one named Undo step that undoes exactly the rename.

**Test that catches it:** Codex - press "Use plan label" on a pit whose label and record differ, then U once: the record goes back and the command line names the step.

**Steps for Tim to confirm the fix:** select a pit whose plan label differs from its ID, open the Inspector, press "Use plan label", then type U: only the rename is undone.

**Status:** IN PROGRESS (28 Sep ~23:00) - built, draft PR #359: the button now runs a hidden command CDUSEPLANLABEL (one named Undo, no lock outside a command); guard test that no Inspector button takes a lock; Inspector tests 188/188, full Civil net10 no new failures. Banked for the next install (not in 3.0.12). Needs a light review first.

---

## BUG-190

**Command / Area:** Civil project data saving (Modules/Drainage `LinkService.Reactors.cs` ~771-786, `LinkService.cs` ~1142, `ProjectDataService.Persistence.cs`).

**What happens (found in code by the independent review of the BUG-189 fix, 28 Sep 2026; same on master, NOT caused by BUG-189):** after an edit made in a CE palette or window with no command running, CE's project data waits for the next command end to be written into the drawing. Ctrl+S (QSAVE/SAVE) ends without that write, and nothing writes it when the drawing is about to be saved or closed (only when it is already being destroyed, too late to reach the file).

**Expected:** Ctrl+S or closing a drawing always saves CE's latest project data with it.

**Real-world risk:** edit a pit's data in the Inspector palette, press Ctrl+S, close, reopen: the latest pit data may be missing. Not yet observed on a real job; hypothesis from code until Codex reproduces it.

**Test that catches it:** Codex scenario - palette edit with no command, Ctrl+S, close, reopen, compare the pit record; plus a guard that a save-start/close-start flush exists.

**Steps for Tim to confirm the fix:** open a job, change a pit's surface level in the Inspector, press Ctrl+S, close, reopen: the new level is still there.

**Codex pass 17 Q4 PASS (29 Sep, 3.0.12): Ctrl+S then close/reopen kept 525; drawing-tab X prompted, Yes, reopen kept 600; CLOSEALL gave exactly one prompt per drawing. Codex-accepted.**

**Status:** IN PROGRESS (28 Sep ~22:00) - PR #357 (`5c845164`) review fixes done: close now locks the drawing (Undo irrelevant at close) and marks it modified so the save prompt appears; autosave (.sv$ / unlocked) skipped; warning logged if a flush fails; net10 OutsideCommandUndoPolicy 43/43. Being combined into Civil 3.0.12 tonight; Codex pass 17 Part Q4 tests it.

---

## BUG-189

**Command / Area:** Whole plugin (Civil + Manager + Structural loaded together), AutoCAD 2027 on Tim's PC.

**What Tim did / saw (28 Sep 2026, verbatim):** "AUTOCAD GOES THROUGH PAHSES OF FAST AND SLOW WHEN DRAWING A SPLINE IT WORKS REALLY FAST AND QUICKLY BUT TOO MUCH INTERACTION WITH CE ACAD PLUGIN ITEMS REALLY CLOGS IT UP AND SLOWS IT DOWN, THIS IS THE FIRST AREA OF CONCERN FOR NOW".

**Expected:** AutoCAD feels the same speed after an hour of placing and editing CE pits/pipes/labels as it does on a fresh start; CE work never makes ordinary drawing (SPLINE, LINE, pan/zoom) sluggish.

**First evidence (release chat 04, 28 Sep, read from the drive):**
1. Structural's idle detector writes one log line about every 2.5 seconds all day (8,757 of 8,947 lines in today's `ce_struc_structured_20260928_001.log`, 1.1 MB since 11:20). Small cost on its own; not proven to be the cause.
2. Civil hooks about 40 AutoCAD events (object changed/added/erased, command ended, selection changed, idle) across LinkService, the Inspector palette, overrules, QA, job time, backup and Xref watchers. A read-only code audit of these for per-edit whole-drawing work and for things that pile up during a session is running.
3. Civil `debugLogging` is off in `CD_Settings.json`.

**What ends a slow phase (Tim, 28 Sep, clickable answer):** "Waiting a while". It is not saving, not switching drawings and not a restart. That points to a backlog of CE work, queued while he edits and worked off while AutoCAD sits idle (hypothesis). **Not yet known:** which CE action starts a slow phase.

**MEASURED ON 3.0.12 (Codex pass 17, 28-29 Sep): round 3 works for pit moves - ApplyPendingLinkUpdates now 180-420 ms touching 3-6 pipes (was 3,681 ms / 49 pipes). NEW FINDING: the FIRST command after opening the drawing (here a plain SPLINE) took 3,249 ms, PipeUpdates count=49 with no pit or source moves - CE flushes a queue of all 49 pipes built at drawing open (open-time upgrade or cache load) at the first command end, so the first thing Tim does after opening a job freezes ~3 s. Also: each pipe update still costs ~60 ms (graphics rebuild) - worth halving. Next round (4): skip the open-time pipe updates when nothing changed, and profile the per-pipe cost.** Hypothesis only until measured.

**Code audit (release chat 04, 28 Sep, read-only; each item is what the code does, the effect on AutoCAD is still a hypothesis, nothing measured yet):**
1. After almost every CE edit command, at the next idle moment, CE throws away and rebuilds all its link memory by reading every object in model space three times (`LinkService.Reactors.cs` 674-696 and 1701-1749, `LinkService.Cache.cs` 727-749). Sometimes twice in a row. The same full rebuild runs after every U/UNDO/REDO, a native MOVE of a pipe, and moving a pit. Top suspect.
2. At the end of any command that touched a CE object: schedule cells refresh (walks model space) and the draw order is re-applied to every entity on matched layers (`ScheduleLinkService.cs` 353-398, `LayerService.cs` 837-960).
3. At the start of each CE edit command (PIT, CDEDIT, PITEDIT...), a full project-data sync with several whole-drawing passes, skipped only if nothing changed (`ProjectDataService.cs` 528-597).
4. The whole project file is re-saved as JSON on each change (350 ms throttle); a save attempted at idle has no lock, fails and retries every 2 s without limit until the next command; automatic QA then runs 7 steps after 3 s of quiet (`ProjectDataService.Persistence.cs`, `CivilProjectQaAutomaticService.cs`).
5. While a CE object is selected, the contextual ribbon tab is re-shown on every idle tick (`CeContextualTabController.cs` 117, 171-204). Stops when nothing is selected. Quick check: press Esc during a slow phase.
6. Manager's 60 s status check can rebuild the whole CE ribbon when its message changes (BUG-092 family).
7. Structural's autosave also watches Civil drawings and saves plus backs up the whole drawing on the main thread after 10 min 15 s of quiet.
8. Minor: Structural's idle detector logs every second while active (background writer, cheap).
Checked and fine: selection observer, highlights, attachment queue (holds one), Xref watcher (throttled), no doubled reactors, pipe draw overrule filtered, undo trace gated by CDDEBUG.

**MEASURED (28 Sep evening, installed 3.0.11, Codex passes 16/16C, timing lines in the Civil log):** the main freeze is found. One pit grip-move -> `ApplyPendingLinkUpdates` took **3,681 ms** (another 3,144 ms; typically 200-540 ms). In that single call CE re-evaluated and rewrote **49 different pipes across the whole network** (~60-75 ms each) and re-saved the whole project data about every 400 ms. Schedule refresh 50-131 ms and draw order under 6 ms were minor; the round-1 incremental cache refresh worked (only one fallback all evening). Round 3 builder dispatched: touch only the moved pit's pipes, skip unchanged writes, one save per command.

**Second audit, Structural + Manager (28 Sep, read-only; hypotheses until measured):**
1. Structural palette "drawing health" re-reads every object in model space (up to 100,000) at idle every 1-3 minutes while its Job Time tab is visible, plus on drawing switch (`Structural/UI/Palette/MainPalette.xaml.cs` 737, 830-834 -> `DrawingDiagnosticsService.cs` 52-243). Top Structural suspect; matches "slow, then clears".
2. Structural autosave saves and backs up Civil-only drawings too, on the main thread (`DrawingAutoSaveService.cs` ~283, 524-531); no Civil check exists.
3. Beam linking erase clean-up scans all of model space after any command that erased something (only when beam linking is on) (`BeamLinkService.CascadeErase.cs` 40-70).
4. Foundation monitor drains 24 touched objects per idle tick, one transaction each (`FoundationMonitor.cs` 137-234). Bounded.
5. Manager telemetry heartbeat every 60 s: file only, no drawing access. No background thread touches the drawing anywhere in Structural/Manager.
**Queued:** Structural speed builder (items 1-3) after the Civil fix lands.

**Next step:** add always-on timing lines to items 1-6 (milliseconds, entity count, trigger), install, reproduce with Codex, then fix the worst.

**Test that catches it (to build):** a timing record per CE event handler (how many milliseconds each spends, and how many times it ran) written to one small file, plus an automated check that no handler is subscribed more than once and no per-edit list grows without being emptied.

**Steps for Tim to confirm the fix:** open a real job drawing, draw and edit about 30 CE pipes and pits for 10 minutes (move pits, CDEDIT, PIT, select labels, open the Inspector), then draw a SPLINE with 20 points and pan/zoom: it must feel as quick as on a fresh start.

**Tim, 29 Sep ~12:20: "it still could be faster but its working much better".** His session today was mostly a Structural drawing; Civil timing shows nothing slow, and Structural has no timing lines yet (its log is still 97% idle-detector lines - the IdleDetector fix went to the Civil trunk in #350 but Structural ships from its own branch). Structural speed round 2 dispatched: port the IdleDetector fix, add [PERF] timing to Structural hot paths, fix obvious per-edit scans.

**TIM'S WORD, 29 Sep 2026 ~12:15, drafting live on Civil 3.0.13: "its working way faster though".** Tim-accepted as a clear speed improvement in real use (rounds 1-4 installed). Kept open only for Codex's timing confirmation on 3.0.14 and the remaining items (Structural speed fix is in 1.0.82 but not yet Codex-timed).

**Status:** IN PROGRESS (28 Sep evening) - Civil fix BUILT, draft PR #350 (`09e15a4a`, on top of timing PR #349): CE refreshes only the objects an edit touched at idle (full re-read kept as a logged safety net above 200 objects, after Undo/Redo, on open, or on error); the double back-to-back re-read removed; draw order re-applied only to touched objects; the endless idle save retry replaced by a proper document lock; Structural idle log only on idle/active changes. NOT changed: schedule-cell refresh (no index yet) and the start-of-command project sync (both still full passes; next round). Builds 0 errors (Civil + Structural, both lanes); full Civil net10 12,117 passed / 8 failed (known AddSystemCommand/Boyd family). Independent Opus review running. Structural speed fix builder running. Not installed, not tested in AutoCAD.

**Codex 30 Sep pass18: speed evidence on installed Civil 3.0.15.** First command in a fresh drawing, a 20-point spline: ApplyPendingLinkUpdates 26.7 ms, PipeUpdates 0.1 ms count=0 (was 3,249 ms count=49 on 3.0.12) = Codex-accepted, `P18_screenshots\Q1_spline.png`. Network pit grip move (six pipes followed): 644.2 ms total (pipe updates 455.4 ms, schedule refresh 185.7 ms); STRETCH 452.6 ms; a later grip 258.0 ms; final spline and pan felt responsive. The "examined/written" counters the brief asked for were absent from the log = BLOCKED. Screenshots `Q1_P3_moved.png`, `P7_STRETCH.png`, `P14_spline20.png`. Report: `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (checks 16-18, 32, 35, 42).

---

## BUG-188

**Command / Area:** CEBLOCKS (CE Blocks palette, Manager - Modules/Manager/Services/CeBlocksInsertService.cs).

**Symptom:** Tim (28 Sep, live in AutoCAD): "ALL TEXT TAGS WITHIN BLOCKS NO LONGER WORK THROUGH THIS, WHY BOTHER UPGRADING TOOL PALETTE IF THAT WORKS BETTER". A block placed via CEBLOCKS shows no text where the office block has an attribute-based tag (e.g. a pit/beam mark). Also no live drag/rotation preview while placing - a plain point pick then (only if the tool asks for it) a plain angle prompt, not a moving picture of the block.

**Expected behaviour:** Same as AutoCAD's own INSERT / the old Tool Palette - every attribute definition on the office block becomes a real AttributeReference with its value shown (default or asked), and the block previews at the cursor (dragging and rotating live) before the pick is confirmed.

**Root cause (found in code, 28 Sep):** `CeBlocksInsertService.Insert` wblock-clones the block DEFINITION then appends a bare `BlockReference` straight to model space - it never reads the block's `AttributeDefinition`s or creates matching `AttributeReference`s at all, so any attribute-based text is silently absent. Placement uses `Editor.GetPoint`/`GetAngle` (static prompts), not a `Jig` - so there is no live preview of the actual block image while placing or rotating.

**Reference:** Modules/Manager/Services/CeBlocksInsertService.cs (the Insert method, lines ~61-113).

**Status:** IN PROGRESS - fixed and merged to master, PR #333 (28 Sep 09:55; `AppendAttributesFromDefinition` added, verified by the release chat directly plus the builder's own revert-and-confirm-tests-fail check). Placement/rotation preview jig also built. Installed 28 Sep 11:20 (Civil 3.0.10/Manager 1.1.10) - this is one of the two live fixes Tim was actively blocked by. **Not yet Tim-confirmed in AutoCAD** (his check: place an attribute-tagged block, confirm the tag shows and stays editable; repeat with Explode) - do not mark FIXED until he does. CEBLOCKS smart redesign (tabs/search/recent/stamp mode, PR #337) also merged and installed same cycle; verified it left the attribute fix's code untouched.

**Also raised by Tim, same message, separate/bigger items (own workflow cards, not a quick fix):**
1. Ribbon visual quality across CE and CE STRUC tabs - "not of the level Apple/Autodesk would build", icons inconsistent/scattered. Needs a design pass with Tim's visual review, not a blind rebuild.
2. CEBLOCKS overall redesign - Tim wants it to work "like the tool palette but way smarter": auto-select the right tabs for the drawing being worked on, live placement preview, live rotation preview. The text-tag fix above and a placement jig are the immediate BUG-188 fix; the smart-tab-selection-by-drawing-type part is a bigger feature needing its own reviewed workflow card before code starts (AGENTS.md command/workflow review gate).

---

## BUG-187

**Command / Area:** CD, Existing line then back to Stormwater, Civil 3.0.6. Found by Codex pass 13 (N3), 27 Sep 2026.

**Symptom:** CD from DP1 to P11 (both ends Detected, route 3,116 mm, "Ready to start the pipe"); Existing > More > Drawing > Include known grade OFF, Back > Stormwater: only the end rings show - no proposed pipe and no "AT 1 IN 100" preview label. Cancelled.

**Expected behaviour:** switching back to Stormwater shows the proposed pipe and its grade label in the preview, ready to start.

**Reference:** report step 12 and screenshots N3-* in C:\Lisp Files\_TEST_COPIES_20260923\P13_screenshots; log 10:39:32-10:41:32. Test that catches it: a CD preview test that toggles Existing / Include known grade / Stormwater and asserts the proposed pipe and label are in the preview.

**Status:** IN PROGRESS (28 Sep 2026: found already fixed in source before this entry was ever actioned — commit `73c7d402`, "Fix BUG-186 ... and BUG-187 ...", 27 Sep 2026, an ancestor of `origin/master`. Root cause was NOT the CD preview jig/picture — `CdPlanPreviewControl`'s real-drawing picture only ever overlays end rings on the drawing as it already is and never drew a ghost proposed-pipe line in the working state either (confirmed by comparing N3-recognised-route.png against N3-FAIL-stormwater-no-preview-label.png: the picture is pixel-identical). The actual fault was `CdViewModel.ApplyPipeTypeDefaults` silently resetting "Pipe grade: Set my own / 1 in 100" back to "Standard" every time a pipe-type button was pressed, including a press back to a type already configured — fixed with `CdViewModel.HasChosenGrade`. The 3.0.6 build Codex pass 13 tested predates this fix (73c7d402 lands after the `Version: Civil 3.0.7` commit). Verified by reading + added `CdViewModelTests.PipeTypeSwitch_AwayAndBack_KeepsTheVisibleGradePreviewText` (asserts the visible `GradePreviewText`, not just the internal flags) on branch `claude/bug-186-187-cd-cdedit-fixes`, PR pending. Not yet Tim-confirmed in AutoCAD on a build that actually contains the fix (3.0.8+) — do not mark FIXED until then.)

---

## BUG-186

**Command / Area:** Edit 2 Pipes (CDEDIT batch) "Carry downstream", Civil 3.0.6. Found by Codex pass 13 (N4), 27 Sep 2026.

**Symptom:** selected P10 to P11 and P11 to P8, grade 1 in 100, Carry downstream: the preview correctly showed P8 to P9 lowered 20 mm (18.93, downstream 18.90 to 18.88), but Apply refused: "The pipe batch was refused and rolled back. Nothing was changed. Pipe P8 → P9 changed after the preview." Log 10:37:51: CDEDIT atomic pipe batch failed, InvalidOperationException. Also seen (not proven): after cancelling an earlier preview, a pipe label read 1 IN 96 instead of 1 IN 100.

**Expected behaviour:** Apply writes all three pipes as previewed; ONE U puts them back.

**Reference:** report step 10, screenshots N4-* in P13_screenshots. Likely the "changed after the preview" check compares the downstream pipe against a snapshot taken before the batch's own upstream edits (the batch changes P8's outlet, then sees P8 to P9 as changed). Test that catches it: a batch of two pipes plus a carried downstream pipe applies without the stale-preview refusal, and a genuine outside change still refuses.

**Fix built 29 Sep ~02:40: PR #361** - the Detention defaults cleared the grade fields, so the 'user chose a grade' memory read false afterwards and the next type press re-applied Standard. Now the user's choice is remembered separately and restored for every type except Detention (which still shows its from-inverts grade). CdViewModelTests 39/39 both lanes; full Civil net10 no new failures. Banked for 3.0.13; Codex re-runs the exact sequence.

**REOPENED by Codex pass 17 (29 Sep, 3.0.12, which contains `73c7d402`): B2 FAIL** - New Pipe: Set my own, 1 in 100; switch to Detention, Existing, then back to Stormwater: Standard is selected again and the custom field hidden. The fix does not hold for this sequence (Existing in between). Needs a builder.

**Status:** IN PROGRESS (28 Sep 2026: found already fixed in source before this entry was ever actioned — commit `73c7d402`, "Fix BUG-186 ... and BUG-187 ...", 27 Sep 2026, an ancestor of `origin/master`. The hypothesis above is confirmed correct by reading the code: `TryBuildCascadedPreparedTarget` (`PipeEditCommand.Batch.cs`) now captures `beforeEvidence` from `step.Context` BEFORE `ApplyContextToViewModel` rewrites the cascaded pipe's invert-label sides into it. Read the full write path to confirm the "genuine outside change still refuses" half of the suggested test shape also holds: cascaded targets join the SAME `preparedTargets` list the shared, unmodified revalidate comparison walks — no separate or weaker check on the cascade path. The 3.0.6 build Codex pass 13 tested predates this fix (73c7d402 lands after the `Version: Civil 3.0.7` commit) — Codex was correctly reproducing a real, already-fixed-in-source bug against a stale installed build. Added `PipeBatchBeforeEvidenceTests.CascadedTargets_JoinTheSameListTheSharedRevalidateCheckWalks_SoAGenuineOutsideChangeStillRefuses` on branch `claude/bug-186-187-cd-cdedit-fixes`, PR pending. The "1 IN 96" observation remains unproven, not chased further. Not yet Tim-confirmed in AutoCAD on a build that actually contains the fix (3.0.8+) — do not mark FIXED until then.)

---

## BUG-185

**Command / Area:** Structural beam commands 1/2 (support to support / point), metre-unit drawings. Found by the train 6 review's scratch probe (640 planner cases), 26 Sep 2026; same result on installed 1.0.76.

**Symptom (from the planner, not yet seen in AutoCAD):** a beam at exactly 45 degrees against a NON-square column in a drawing set up in metres is refused (3 of 640 probe cases). It refuses; it never links the wrong end.

**Expected behaviour:** a 45-degree beam from a rectangular column in a metres drawing places like any other angle.

**Reference:** `BeamCommandSourceCompatibility.MatchesAcquiredAxis` (support face / axis reproduction tolerance at 45 degrees with a non-square column, metre drawing unit factor). Low priority: mm drawings and square columns are unaffected.

**Status:** IN PROGRESS (fix built 27 Sep: PR #295, 45-degree tie tolerance; Opus review MERGE; ships tonight in Structural 1.0.78; needs an AutoCAD check)

---

## BUG-184

**Command / Area:** Structural beam commands 1 and 2 (support-linked beams; D2 follow when a column moves). Found by the train 6 Opus review (code reading only), 26 Sep 2026.

**Symptom (suspected, not yet seen in AutoCAD):** a beam placed with command 1 between two supports picked RIGHT to LEFT (or top to bottom) may record each support against the wrong beam end. Moving one of those columns later would then move the far end of the beam instead of the end sitting on the column.

**Expected behaviour:** each support is linked to the beam end that sits on it, whichever order the drafter picked them in.

**Reference:** the support role comes from pick order (`BeamCommandAutoCadSelectedSourceReader.cs` ~132-151); the beam is written in standard direction (left to right / bottom to top, `BeamPlacementPlanner.cs` ~301-304); the writer measures the start role from `beam.StartPoint` (`AutoCadBeamAtomicWriteGateway.cs` ~292-300, 363-369) and nothing remaps it for commands 1/2 (commands 4/5 use `BeamSpecialEndpointRoleMapper.ToCanonicalAxisRole`). The same fix also allows the held-back "support to a point heading left or down" change from PR #270. Test needed in AutoCAD: command 1 from C2 (right) to C1 (left), then MOVE C1 300 and check which beam end follows.

**Proven 26 Sep (core console on 1.0.76 + behaviour tests):** right column +300 moved the LEFT end; left column -300 moved the RIGHT end; vertical beam, top column up moved the BOTTOM end.

**Status:** FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS13_2026-09-27.md, step R6: right-first and top-first supports - only the moved end followed, ONE U restored)

---

## BUG-183

**Command / Area:** Structural MOVE of a support column that carries a CE beam (D2 slice 1 follow, PR #250), Structural 1.0.76. Found by Codex pass 12 (B5), 26 Sep 2026.

**Symptom:** MOVE C1 @-300,0: the beam end and label follow and CE says "One U undoes both", but ONE U leaves the column AND the beam moved. ROTATE of the same column is undone correctly.

**Expected behaviour:** one U after the MOVE puts the column, beam end and label back.

**Reference:** cause proven headless: `DrawingAutoSaveService` (MOVE-only text-anchor repair) took a document lock on Idle after every MOVE; AutoCAD keeps that lock as its own Undo step. Fix drafted: PR #269 (claude/struc-p12-b5-move-one-undo -> claude/struc-d1-prep).

**Status:** FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS13_2026-09-27.md, step R5: MOVE +/-300 and ROTATE 90, ONE U restored column, beam end and label)

---

## BUG-182

**Command / Area:** Structural beam command 4 (point mode), and command 1 from a column to a point heading left or down; beam refusal wording (UX-BEAM-01). Found by Codex pass 12 (B4), 26 Sep 2026.

**Symptom:** command 4 refuses every beam with the generic "CE hit an internal problem it could not put into a plain reason"; command 1 from C1 to a point down/left is refused with the same generic line.

**Expected behaviour:** command 4 places the beam; command 1 works in every direction; any refusal gives a plain reason.

**Reference:** preview drew 3 items but expected 2 (`BeamSpecialTransientPreviewRenderer.cs`); axis compared against the flipped line (`BeamCommandSourceCompatibility.cs`). Fix drafted: PR #270. About 502 internal codes still show the generic line (question for Tim in release-v3 item 256).

**Status:** FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS13_2026-09-27.md, step R4: command 4 point mode and command 1 left/down/diagonal placed, ONE U each)

---

## BUG-181

**Command / Area:** STRUCDEBUG (Structural 1.0.76, PR #231). Found by Codex pass 12 (B3), 26 Sep 2026.

**Symptom:** typing STRUCDEBUG gives `Unknown command "STRUCDEBUG"`.

**Expected behaviour:** STRUCDEBUG offers [ON/OFF/Status/Clear].

**Reference:** its class was never added to the assembly's `[assembly: CommandClass(...)]` list. Fixed in PR #265 (merged to claude/struc-d1-prep) with a guard test for any unlisted command class; ships in the next install.

**Status:** FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS13_2026-09-27.md, step R3: STRUCDEBUG ON/OFF/Status)

---

## BUG-180

**Command / Area:** Civil contextual Pipe / Pit / Source ribbon tabs (UX-RIBBON-01, PR #243, `Shared/CE_SHARED/Services/CeContextualTabController.cs`). Found by Codex pass 12 (N8), 26 Sep 2026.

**Symptom:** with the Plug-ins tab in front, selecting a CE pipe or pit shows the right panels but the ribbon stays on Plug-ins - no Pipe or Pit tab comes to the front.

**Expected behaviour:** like AutoCAD's Hatch and Text editors, selecting a pipe brings its tab to the front; Escape or Close returns.

**Reference:** Codex fix job `fixn8` queued for Sunday 27 Sep 00:05 (Codex's Sunday share). Touches CE_SHARED, so Manager must be rebuilt from the same commit.

**Triage 29 Sep (release chat 04): fix found in code, 947a00c2 (PR #296), present in the installed Civil 3.0.13. Status stays open until a Codex/Tim check confirms it in AutoCAD; queued for Codex pass 18.**

**Status:** OPEN (fix queued)

**Codex 30 Sep pass18: NOT TESTED.** The Home and Annotate ribbon tabs were absent in the test session, so the Home-then-shift-pick check was skipped as instructed (R12). Sweep C1 items "Home then shift-pick BUG-180" and the contextual-tab items are also NOT TESTED (not reached). Reports: `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 46), `CODEX_SWEEPC1_2026-09-30.md` (items 72-77).

**Codex 30 Sep sweep C1: NOT TESTED again.** The current workspace (TIM 2026 SETUP) has no Home tab, so the exact Home-then-shift-pick could not be run; no workspace setting was changed. Related C1 observations on the contextual tab: a single CE pipe selected shows the Pipe tab and Escape / typed CDCLOSETAB clear it (Codex-accepted narrow PASS, objects 1,280 unchanged); the Pit tab Close button does nothing (BUG-225). Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (items 72-77, 612, 613, 617).

---

## BUG-179

**Command / Area:** DP (and every source placement: IO, OF, FO, GIO, CDSOURCE), Civil 3.0.5. Found by Codex pass 12 (N1), 26 Sep 2026.

**Symptom:** after a PIT split, Edit 2 Pipes and U on DWG-B, a downpipe at a clear point is refused: "Downpipe could not be placed. Nothing was changed"; log: rolled back, eUnknownHandle.

**Expected behaviour:** the downpipe is placed; a pipe CE cannot read and that the downpipe does not touch is skipped, as the landing check already skips it.

**Reference:** the second (after-write) read was stricter than the first and only forgave CE's own errors. Fix drafted: PR #268 (both reads forgive the same things; the stale handle is named in the log). Headless replay of the pass 12 sequence: FAIL on master, PASS with the fix.

**Status:** FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS13_2026-09-27.md, step R2: after split / Edit 2 Pipes / U, DP at a clear point placed)

---

## BUG-178

**Command / Area:** PIT / CD / DP / IO / OF / FO / GIO / CDSOURCE carry-on (UX-STD-01, PR #238), Civil 3.0.5. Found by Codex pass 12 (U4, N2), 26 Sep 2026.

**Symptom:** place a pit, then press Esc at the next pit's first prompt, then U: the command line says "PIT" but nothing is undone - the first U undoes an empty cancelled PIT; a second U is needed.

**Expected behaviour:** Esc stops the run and ONE U removes the last placed item.

**Reference:** the next command was queued straight away and its cancel left an empty Undo step. Fix drafted: PR #272 (the next item's first question is asked inside the finishing command; a pick is handed over as a world point). Only Tim's AutoCAD can prove a real Esc (a script cannot press Esc). Decision for Tim: Esc at a LATER question of the next item still leaves one empty U step, like any cancelled command - accept (recommended) or move each command's whole set-up into the finishing command (bigger, next train).

**Status:** FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS13_2026-09-27.md, step R1: CD, PIT and DP - Esc at the next first prompt, ONE U removed the last item)

---

## BUG-177

**Command / Area:** CDPIPEOBJ (Draw a pipe as one AutoCAD object, AutoCAD 2027 only) — Civil ribbon, "CE" tab coverage guard. Found 26 Sep 2026 by the release chat's builder while adding the Start Here / My Role buttons (`GetPanels_KeepsEveryVisibleCivilCommandReachable` failed on `CDPIPEOBJ` before any of this session's own changes).

**Symptom:** CDPIPEOBJ is a real, visible command in `Assets/Config/command-registry.json` (not marked hidden or expert) but is not on any panel of the CE ribbon tab, in `CeCvlRibbonContributor.cs`. A colleague can only reach it by typing the command; there is no ribbon button, icon, tooltip or keytip for it anywhere.

**Expected behaviour:** either CDPIPEOBJ gets a ribbon home (most likely the Draw panel, beside CD, since it is a pipe-drawing variant) with Tim's approval of where and how it should look, or it is deliberately marked `hidden`/`expert` in the registry with a reason, so the coverage guard and the ribbon agree on what "every visible command is reachable" means.

**Reference:** `Modules/Drainage/Assets/Config/command-registry.json` (CDPIPEOBJ entry); `Modules/Drainage/Services/CeCvlRibbonContributor.cs`; guard test `Modules/Drainage.Tests/Services/CeCvlRibbonContributorTests.cs::GetPanels_KeepsEveryVisibleCivilCommandReachable`.

**Release chat, 26 Sep:** Tim already ruled UX-PIPE-08 (decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md, "Items queued for Tuesday, settled early"): CDPIPEOBJ is to be HIDDEN from the ribbon and Help now (still typed for testing) and retired once CD draws the one-piece pipe and Tim accepts it - so "no ribbon button" is intended. Action: mark CDPIPEOBJ hidden in the command registry so the ribbon-reachability guard stops expecting a button (queued with UX-PIPE-08). **Status:** IN PROGRESS (27 Sep: CDPIPEOBJ hidden from ribbon and Help, still works typed - PR #291; ships tonight in Civil 3.0.7)

---

## BUG-171

**Command / Area:** Civil pipe upgrade (old pipe made into a CE pipe object: open-time or on-demand upgrade, C7) and Edit Pipe.

**What Tim did / what happened:** 24 Sep 2026 about 15:10 on `3.0.1+7d85c40f` (verbatim): *"I UPGRADED AN OLD PIPE AND IT OPENS AS A DETENTION PIPE WHEN IT SHOULDVE BEEN A STORMWATER."*

**Expected behaviour:** an upgraded old pipe keeps the system it was drawn as (stormwater here). Where the old pipe does not say, the system is Unknown and CE asks; it never silently becomes Detention.

**Test that catches it:** upgrade fixtures of an old stormwater pipe (by layer / by record) read back as Stormwater; one with no system evidence reads back Unknown, never Detention.

**Tim's AutoCAD steps:** open a copy of an older drawing with a stormwater pipe drawn before 23 Sep, upgrade it the way you did today, double-click it: Edit Pipe shows Stormwater.

**Cause (builder's diagnosis, 24 Sep):** not the upgrade. Every upgrade path keeps the pipe's handle, XData and record, and its stored type stays Stormwater. The fault is where the type is read back for display: `PipeTruthResolverService.ParsePipeTypeLabel` had no case for "Stormwater Pipe", so a correct Stormwater record was discarded and replaced by a layer-name guess that reads Detention. Edit Pipe, its preview and CDINSPECTOR's live check share that method.

**Status:** IN PROGRESS — round 1 (PR #175, `ParsePipeTypeLabel`'s missing "Stormwater Pipe" case) merged into master, then re-installed as part of Civil `3.0.2+f0aca3f9`; **Codex pass 9 still recorded N5 FAIL on that exact build** (`CODEX_TEST_REPORT_PASS9_2026-09-24.md`, step 21): an old AGI→P1 branch pipe, label `100 DIA. UPVC PIPE AT 1 IN 100 MIN.` with no special-system wording, still opened Edit Pipe as Detention after the older-pipe label question.

**Round 2 cause (builder's diagnosis, 24 Sep, second pass):** PR #175 fixed `ParsePipeTypeLabel` correctly, but never reached — the real fault is one level up, in `PipeTruthLogic.ParsePipeAnnotationText` (the pipe's own linked-label reader, `ResolveField`'s highest-priority evidence source). Its Detention keyword check (`IndexOf("DETENTION PIPE")`) can never match CE's own generated Detention label (`PipeAnnotationTextFormatter.FormatMainLabel`'s Detention case ends `"...{grade} {length}m DETENTION"` — "PIPE" and "DETENTION" are never adjacent), so the type always fell through to whatever fallback the caller passed. For the CDEDIT-LEGACY-01 older-pipe bootstrap path, that fallback is the pipe's own raw, never-confirmed stored link-data value — wrongly Detention for this pipe.

**Round 2 status:** IN PROGRESS — built, not installed. **Draft PR #196** (`claude/bug-171-still`, branched fresh from `origin/master`): `PipeTruthLogic.ParsePipeAnnotationText` now classifies Detention from the text's own words (reusing the existing length+"DETENTION" regex already used for the required-length field), and an unmarked label that still looks like an ordinary CE pipe annotation resolves to Stormwater on its own terms (CE's own "no keyword = Stormwater" convention), instead of echoing an unrelated fallback. Builder's report: 3 lanes 0 errors; 590 focused Pipe/PipeTruth/PipeEdit/workshop/upgrade/C7 tests passed; a wider 2422-test `*Pipe*` sweep reproduced only the 4 already-documented pre-existing WPF window-fit/DPI failures. 4 new tests reproduce both the genuine-Detention-label gap and the exact N5 scenario; both confirmed failing before the fix. Never mark fixed until Tim confirms in AutoCAD.

---

## BUG-172

**Command / Area:** Civil ribbon (CE tab) pictures.

**What Tim did / what happened:** 24 Sep 2026 about 15:10 on `3.0.1+7d85c40f` (verbatim): *"RIBBON ICONS FOR STRUCTURAL LOOK GREAT, CIVIL ONES ARE MISALIGNED AND WRONG."* Which buttons: screenshot asked for.

**Expected behaviour:** every Civil button has its own correct picture, the same size and aligned like the Structural tab (#147 look).

**Test that catches it:** a picture guard: every visible Civil command resolves to its own picture file of the right sizes; a rendered ribbon strip compared by eye.

**Tim's AutoCAD steps:** look along the CE tab: every picture matches its button and sits level with its neighbours, as on CE STRUC.

**Status:** IN PROGRESS — 28 Sep 2026, branch `claude/bug172-civil-ribbon-icons` (base `origin/master`
a945ab93). Measured (not guessed): the Civil and Structural tabs share one layout code path
(`CE_SHARED`'s `RibbonBuilder`), so there is no separate Civil alignment bug — three buttons drew no
picture at all (Ask CE / CEASK, Reverse Flow / CDREVERSEFLOW on the Pipe contextual tab, and Close on
all three contextual tabs), which is what read as "misaligned and wrong" next to Structural's fully-
pictured rows. Fixed in `CE_SHARED/Services/CeRibbonIconCatalog.cs` (added the missing `CEASK` and
`CDREVERSEFLOW` catalog entries — `CDASK` was only CEASK's retiring alias, unreachable by the real
command string) and `Modules/Drainage/Services/CeCvlRibbonContributor.cs` (removed a `ClosePanel`
override that pointed at a file that never existed, discarding CDCLOSETAB's own real icon).
`Modules/Structural` untouched. Six more commands (CDPERIMETER, CDTWL, CDDEST, CDPAVE, CDKERB,
CDSPOONDRAIN) have no real artwork anywhere in the repo and still show the generic wrench — flagged for
Tim to supply pictures, not faked. New picture-guard test
`Modules/Drainage.Tests/Services/CivilRibbonPictureCoverageTests.cs`, confirmed red before the fix and
green after. Full REGRESSION_LOG.md entry at the top. Never mark FIXED until Tim confirms in AutoCAD.

---

## BUG-176

**Command / Area:** CDRG raingarden + grated inlet (GIO) landing on a pipe. Found by Codex pass 11 (N4), 25 Sep 2026 evening; cause proven overnight by the release chat's builder.

**What happens:** CDRG four boundary points, Close, Place, pick a fresh straight pipe: the grated-inlet preview disappears and nothing is placed; the command line says "The optional GIO landing changed or could not be verified". Cause: CDRG can only land the inlet on a pipe run that records which pit is at each end (HasExactOwners needs both Start/EndOwnerHandleOverride). Pipes drawn with CD never record that, and PIT's split records only the new pit's end, so on an ordinary pipe the landing is PipeRun/LegacyUnsupported and CDRG's route falls to ExistingOwner - it quietly refuses. Before draft PR #251 nothing was logged.

**Expected behaviour:** Tim to decide (sent to the V3 plan discussion chat 26 Sep): (a) CDRG places the inlet the same way DP already does on those pipes - raingarden and inlet two steps inside the one command, one U removes both (recommended); (b) stay strict and say plainly which pipe lacks its end records and how to fix it; (c) make CD and PIT record both ends.

**Test that catches it:** on a DWG-B copy, CDRG onto a CD-drawn straight pipe places the raingarden and its inlet on the pipe; one U removes both.

**Tim's AutoCAD steps:** after the fix, CDRG with four boundary points, Close, Place, pick an ordinary pipe: the grated inlet lands on the pipe; one U removes the raingarden and the inlet.

**Tim's ruling (UX-SRC-05, 26 Sep, via the V3 plan discussion chat):** "cdrg and dp are not pipe dependent if anything they are similar to pits which in most cases get placed prior to pipes connecting them" - none of the three options; the premise was wrong. CDRG and DP place anywhere, like pits, before any pipe exists; pipes drawn later connect TO them the way they connect to pits (auto-join UX-PIPE-02b). **Status:** OPEN - diagnostics only in **draft PR #251** (b26695d4); build to Tim's ruling queued. Also needs PR #249 (N8 read-back fix) before any inlet can land in a drawing like DWG-B. Never mark fixed until Tim confirms.

**Codex 30 Sep pass18: BLOCKED again, with a different refusal.** CDRG boundary, Close, Place, picked an ordinary new 225 UPVC pipe on the DWG-B_P18 copy: "The Civil source data could not be verified. Nothing will be placed here. Reason: The drawing and project do not describe the same complete pipe set. Move the source and pick again, or press Esc." Esc removed everything; the inlet landing itself is unproven. The fix for this bug (PR #346) is on the live line; that drawing had earlier been through the pipe-end record guard (BUG-208). Screenshot `P18_screenshots\B3_GIO_data_guard.png`; report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 82, section "05:07 Melbourne - B3 BUG-176"). UX: the message says "move the source and pick again", which cannot fix a whole-drawing mismatch.

---

## BUG-175

**Command / Area:** Edit Pipe data collection (`Modules/Drainage/Commands/PipeEditCommand.DataCollection.cs`). Found in code 24 Sep 2026 while clearing up after BUG-171; not reported by Tim.

**What happens:** a crude layer-name guess (`TryGetPipeTypeFromLayer`, plain "DETENTION" / rising-main text match, lines ~141-146) sets the pipe type first. The proper answer (PipeTruthResolverService, line ~162) overwrites the type, but by then two things have already used the crude guess and are never corrected: the rising-main vs charged destination read from the "PIPE TO x" label (line ~157 -> 470 -> 537-540) and the expected flow direction behind the reverse-arrow reading (line ~148 -> 392-393 -> 639-641). A pipe on a layer that looks like a rising main but is not one (or the reverse) could open with the wrong destination field or arrow state.

**Expected behaviour:** one answer for the pipe type (the truth resolver), decided before anything uses it; the crude copy removed (one code path per behaviour).

**Test that catches it:** a pipe on a rising-main-looking layer whose record says Stormwater opens with the stormwater destination and arrow; and the reverse case.

**Tim's AutoCAD steps:** after the fix, double-click a rising main and a stormwater pipe next to it: each shows its own destination and flow arrow as drawn.

**Status:** IN PROGRESS — built, MERGED to master, not yet installed/Tim-confirmed. **PR #179** (`49ea9be0`, merge commit `25a6503a`, merged 2026-09-24) — verified again 2026-09-28 by a fresh builder dispatched to fix this bug: the fix is already on `origin/master`, no further code change needed. The true type is resolved once via `PipeTruthResolverService.ResolvePipeContext`, before `AnalyzeAttachmentState` (reverse-arrow) and `HydrateContextFromAttachments` (destination) run; the crude local `TryGetPipeTypeFromLayer` in `PipeEditCommand.DataCollection.cs` is deleted (confirmed absent from that file by search — it survives only as `PipeTruthResolverService`'s own internal fallback, which is fine per the fix brief). Full write-up: `REGRESSION_LOG.md` "BUG-175" (2026-09-24), including two dedicated test fixtures (`PipeEditCommandDataCollectionTests`, `PipeEditCommandDataCollectionOrderTests` — one is a literal source guard against the crude guess ever coming back). Builder's report: 3 lanes 0 errors; focused Pipe/PipeTruth/PipeEdit tests 2402 passed / 4 failed (pre-existing window-fit/DPI baseline, unrelated) / 6 skipped. Never mark fixed until Tim confirms in AutoCAD (his steps below).

---

## BUG-174

**Command / Area:** command-line questions (keyword prompts) across Civil and Manager; seen in CDDESIGN.

**What Tim did / what happened:** 24 Sep 2026 about 15:25 on `3.0.1+7d85c40f`, CDDESIGN printed "[CE] Look through this job's folders for its rating report and offer the site and roof areas? [Yes No] <Yes>:". Tim (verbatim): *"IT SAYS YES OR CE WHICH IS NOT A QUESTION CHAMP"*. The leading "[CE]" tag is in square brackets, and AutoCAD offers bracketed text in a question as a choice, so the choices read Yes / CE. (The release chat first misread the screenshot and asked Tim what was wrong.)

**Expected behaviour:** a question offers only its real choices (here Yes and No); the [CE] tag never appears inside a question.

**Test that catches it:** a source guard: no keyword prompt message contains bracketed text other than its keyword list (helpers included).

**Tim's AutoCAD steps:** run CDDESIGN: the question's choices (click or F12) are only Yes and No. Repeat in 2024.

**Status:** IN PROGRESS — built, MERGED to master, not yet installed/Tim-confirmed. **PR #177** (`claude/bug-174-ce-tag-in-prompts`, merge commit `61b97c96`, merged 2026-09-24) — verified again 2026-09-28 by a fresh builder dispatched to fix this bug: the fix is already on `origin/master`, no further code change needed. `CivilDesignCommand.cs` (CDDESIGN's storm-report offer, the council-from-job-folder offer, both `AskYes` call sites), `SourceDestinationCommand.cs` (CDDEST's "record destinations" ask) and `PipeCrossingSplitService.cs` (the shared `AskOnce` helper) all carry the tag-free wording — confirmed by reading the current source; every remaining "[CE]" in Drainage/Manager is inside a plain `WriteMessage` line, never inside a keyword prompt's message. The general source guard added by that PR, `KeywordPromptBracketTagGuardTests.KeywordPromptMessages_CarryNoBracketTagThatIsNotARealKeyword` (`Modules/Drainage.Tests/Commands/KeywordPromptBracketTagGuardTests.cs`), still passes on current master: re-run 2026-09-28 on net10.0-windows with real AutoCAD 2027 (native `CE_TRANSFORM_2027.arx` built first) — 1/1 passed. Drainage (net48/net8.0-windows/net10.0-windows) and Manager (net48/net8.0-windows/net10.0-windows) both build 0 errors. Never mark fixed until Tim confirms in AutoCAD (his steps below).

---

## BUG-173

**Command / Area:** Civil Edit Pipe (CDEDIT on a pipe) and New Pit / PIT windows: look.

**What Tim did / what happened:** 24 Sep 2026 about 15:10 (verbatim): *"PIT WINDOW DOESNT LOOK GREAT IN COMPARISON TO HOW THE CD WINDOW LOOKS"* (screenshot of New Pit, Levels & text tab: narrow cramped left pane, labels jammed against units, large empty areas, small plan preview, text-only section preview) and *"CDEDIT WINDOW FOR PIPES SHOULD LOOK SIMILAR OR THE SAME AS THE NEW PIPE"*.

**Expected behaviour:** the Pit windows and Edit Pipe look and work like the CD / New Pipe window (the design reference, Tim 23 Sep 22:10): same layout, spacing, header, footer, preview treatment.

**Test that catches it:** off-screen renders compared side by side with New Pipe; fit and preview/footer bounds at 1080p and 1440p, scales 1.0, 1.25 and 1.5, including detention, plastic and six connections; control inventory Kept/Moved/Combined/Replaced.

**Tim's AutoCAD steps:** open PIT, Edit Pit and double-click a pipe: each looks like the CD window you draw pipes with.

**Status:** IN PROGRESS for native acceptance. Pit one-page [PR #184](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/184) is ready for review at `a760d7d4`: all 20 new scaling failures cleared, 304 requested/pit and 599 wider fit checks pass, three Civil Release builds have zero errors, and the full Civil run has 10,935 passed / 6 existing non-Pit failures / 19 skipped. Thirty-two 150% dark/light New/Edit Pit renders were inspected. The real-drawing preview still needs command-owner plan-anchor/dry-run integration. Pipe one-page PR #180 remains separate. Neither is installed or Tim-accepted; the combined 2027/2024 native check remains.

---

## BUG-170

**Command / Area:** Civil "Creative Engineering | What's New" window (`Modules/Drainage/Dialogs/WhatsNewDialog.xaml`, content from the What's New catalogue), shown on the first AutoCAD start after a version change.

**What Tim did / what happened:** 24 Sep 2026 about 15:05, first start on `3.0.1+7d85c40f`; the window opened. Tim (verbatim, with a screenshot): *"SMALL AND HARD TO READ DUE TO COLOURS"*. Seen in the screenshot: a small window (about 490 x 530) with a scrolling list; gold headings with a dotted gold underline and grey body text on dark; the subtitle is cut off mid-word ("...a drainage network. Her"). **Also found by the release chat:** some entries describe things that are not built, e.g. "One CE tab: Civil, Structural and Manager buttons live on a single CE tab" (there are still three tabs; the unified ribbon is a later, planned step), and possibly the contextual "Pipe, Pit and Source tabs" and the "Status dot". Telling colleagues about features that do not exist breaks the never-describe-what-is-not-there rule.

**Expected behaviour:** readable at a glance in dark and light: larger window and text, high-contrast body text, plain gold headings without dotted underlines, nothing clipped; every entry true of the installed version (checked against the code), anything not built removed or marked "coming".

**Test that catches it:** a catalogue test that every What's New entry names a command or window that exists and is visible in the ribbon registry; a render test at 1920 x 1080 scale 1 and 1.25 that no text is clipped.

**Tim's AutoCAD steps:** delete nothing; type the What's New command (or start AutoCAD after the next version change); check it opens large enough to read without leaning in, the headings and text are easy to read in dark and light, the top line is complete, and every item describes something you can actually find on the ribbon.

**Status:** IN PROGRESS — the fix is already on `master` (not just the side branch this entry names). `codex/whatsnew-readable` @ `4465e22d` ("Fix BUG-170 What's New readability and release claims") and the later `deaac3e2` follow-up are both ancestors of `origin/master` (currently `3ce52a6b`, confirmed 28 Sep with `git merge-base --is-ancestor`). No new branch or PR was needed or opened.

**Re-verified 28 Sep 2026 (separate session, checked against current code, not the stale status line):** confirmed the fix is real and unbroken on `master`. `WhatsNewDialog.xaml` is 760×640 (was ~490×530), resizable, with a fixed footer and a scrolling reading list; the code-behind (`WhatsNewDialog.xaml.cs`) renders every heading and body line from `TextPrimaryBrush`/`AccentBrush` with no `TextDecorations` anywhere — the dotted gold underline is gone. `Assets/Config/whats-new.json` (version 3.0.1) no longer makes the "one CE tab" claim or any other checked-off Round-2 claim; its 15 entries (CDEDIT, PIT, CD, CDDESIGN, CDRAINFALL, CDLPD, CDCHECK, CDIMPORTXCIVIL, CDIMPORTLANDXML, CDSURVEY, CDWT, CDDASHBOARD) were each checked by hand against `command-registry.json` — every one exists, none is `hidden`. The exact tests the carpark asked for already exist and pass: `WhatsNewCatalogueTests` (registry+ribbon existence, old-name absence, parse tolerance) and `WhatsNewWindowRenderTests` (real off-screen WPF window, dark/light × 100%/125%, header/footer/subtitle bounds, per-row clipping/trimming checks, PNG capture) — **26/26 passed** on a from-scratch `-p:SkipDevBundle=true` net10.0-windows build (native `CE_TRANSFORM_2027.arx` prerequisite rebuilt first). The eight PNGs under `docs/image/V3_WINDOWS/whatsnew-*.png` were regenerated and inspected directly (dark and light, 100% and 125%): large, high-contrast, plain gold/blue headings, full unclipped subtitle, no dotted underline. Full Civil net10 suite also run as a wider check (no source touched, so this is drift/flake evidence, not a regression check for a real change): 12,081 run, 12,057 passed, 5 failed, 19 skipped — at or inside the documented ~6-failure baseline, none of them What's New tests. Nothing further to fix in code. **Not marked FIXED — Tim has not yet seen this in AutoCAD** (this entry has never recorded an install, and none was authorised in this session).

---

## BUG-169

**Command / Area:** Structural RC (rectangular revision cloud; `Modules/Structural/Commands/LegacyPortCommands.cs`, shipping branch `claude/struc-d1-prep`). Asks "Keep OSNAP ON?", then two corners; draws on layer CLOUD with CE arc lengths and returns to 25CONT.

**What Tim did / what happened:** Tim, 24 Sep 2026 about 11:10: "WE ALSO NEED TO UPDATE THE RC COMMAND AS ITS A BIT GLITCHY ATM"; about 11:20: "RC GOES WRONG WHEN I PRESS ENTER AFTER USING IT, TO USE IT AGAIN, IT DOESNT RESET THE LAYER PROPERLY. ALSO THIS HAPPENS WITH OTHER COMMAND IN STRUCTURAL MODULE, LAYER SHOULD BE STORED BEFORE AND THEN RESTORED AFTER COMMANDS". So: run RC, draw a cloud, press Enter to repeat, and the current layer is wrong afterwards. The same happens with other Structural commands. Note: RC is documented to "return to 25CONT" (a fixed layer), not to the layer the drafter was on.

**Expected behaviour (Tim's rule):** every Structural command that draws on its own layer stores the drafter's current layer before it starts and puts it back when it ends: after finishing, after Escape, after an error, and when repeated with Enter. Commands whose job is to set the layer (the Line styles pen buttons, Set All) are the exception.

**Test that catches it / Tim's AutoCAD steps:** to be written once the symptom is known.

**Cause (builder's diagnosis, not yet re-checked by the release chat):** RC handed REVCLOUD to AutoCAD with `SendStringToExecute`, which runs only after RC has ended, so Enter repeated REVCLOUD, not RC; and RC always switched back to a fixed 25CONT. The strip footing commands (SFC, SFCT, SFCB, BSFC, BSFCT, BSFCB) had the same hand-off, and worse: the footing was drawn on the drafter's own layer instead of STRIP FOOTINGS. CML had the Enter-repeat fault only.

**Restore built 29 Sep ~16:40: PR #386** - RC back to its pre-`8d382ec0` mechanism and settings (same prompt, rectangular cloud, arc 4.5 paper / 90 at DIMSCALE 20 / 450, layer CLOUD colour 12, every REVCLOUD variable restored on end/Escape/error); plus only: your layer/colour/linetype come back, and Enter repeats RC (RC queues one silent "RC" after REVCLOUD so it becomes the repeat command; ignored after 10 s). SFC/BSFC/CML left as they are (they never had RC's cloud settings; since 24 Sep they draw on STRIP FOOTINGS as BUG-169 intended). 21 RC tests compare against the old values. Going into Structural 1.0.86.

**REGRESSION reported by Tim, 29 Sep 2026 ~16:00 (live, Structural 1.0.85): "YOU RUINED RC, IT NO LONGER WORKS HOW IT USED TO, I WANTED YOU TO FIX ONE THING AND ITS CHANGED THE PROPERTIES COMPLETELY".** Cause found: the BUG-169 fix (commit `8d382ec0`, 24 Sep, installed since) rewrote RC wholesale - it dropped RC's saved REVCLOUD settings (create mode, arc variance, approx/min/max arc lengths) and changed how REVCLOUD is driven, instead of changing only the layer restore and Enter-repeat Tim asked for. Builder dispatched (`claude/rc-restore-original`): restore RC exactly to its pre-`8d382ec0` drawing behaviour, then add back only the layer restore and Enter-repeat. Goes into Structural 1.0.86. Lesson: a fix for one symptom must not rewrite the command's settings.

**Status:** IN PROGRESS — CODE COMPLETE, MERGED, AND ALREADY INSTALLED; only Tim's AutoCAD confirmation is outstanding. **PR #163** (`claude/struc-layer-restore`, tip `8d382ec0`, base `claude/struc-d1-prep`) merged 25 Sep 2026 — native commands now run REVCLOUD/MLINE inline via `Editor.Command` instead of the deferred `Document.SendStringToExecute`, and one shared helper (`LegacyToolCommon.RestoreCurrentLayer`) puts back the layer the drafter was on (only if it still exists and isn't frozen), used by RC, SFC/SFCT/SFCB/BSFC/BSFCT/BSFCB and the generic `CommandExecutionService.RestoreState` every other CeTextService command already runs through; CML's Enter-repeat fixed the same way (no layer change). **Installed on Tim's PC 25 Sep 18:19 as Structural `1.0.75+838f95ee`** (register #78) and still live in every later cumulative train off `struc-d1-prep` (confirmed present through at least `1.0.80`, 28 Sep) — this is not a pending deploy.

**Re-verified 28 Sep 2026 (separate session, re-diagnosed from current code rather than trusting the note):** confirmed the fix is real and unbroken — `NativeTimToolsService.CreateRevisionCloud` runs `ed.Command("_.REVCLOUD")` inline with the layer captured/restored in a `finally`; `CeTextService.ExecuteSfMline`/`ExecuteClosedMlineCommand` run MLINE the same way; `LegacyToolCommon.RestoreCurrentLayer` checks existence/frozen state before restoring and never throws; `LayerRestoreOnRepeatContractTests` (14 tests, source-contract style — no live AutoCAD Document in this test host) all pass on the current `struc-d1-prep` tip; no later commit has touched the fixed files. All 3 Structural lanes (net48/net8.0-windows/net10.0-windows) still build 0 warnings/0 errors on current `struc-d1-prep`. **Grepped the whole Structural module for the same shape (CLAYER switch + `SendStringToExecute` hand-off) beyond the named commands** — no other match found: `ML` (bare MLINE alias) and Copy-Rotate/Move-Rotate (`CR`/`MR`, legacy Lisp bridge) and the mirror-queue/native-copy-fallback macros use `SendStringToExecute` but never switch CLAYER, so Enter-repeat of them is a no-op (same outcome either way) and there is no layer to lose; every other CLAYER-switching command (BATTER, breakline, load-bearing wall, rafter/joist, level mark, rebar, section mark, dimensions, hatch, SWELD weld mark) already draws synchronously and restores CLAYER itself in a `finally` or via the shared `CommandExecutionService` wrapper, so none of them had this bug. Nothing further to fix in code. Tim's 2027 and 2024 AutoCAD checklist is in REGRESSION_LOG.md ("BUG-169 — commands return to the layer you were on" section). Never mark fixed until Tim confirms in AutoCAD.

**Codex 30 Sep pass18: mostly PASSED on installed Structural 1.0.86 (Codex-accepted, steps + screenshots):** DIMSCALE 100 gives arcs 450 (`P18_screenshots\RC_100_arc450.png`); DIMSCALE 20 with Yes gives 90 (`RC_20_cloud.png`); paper space 4.5 (`RC_paper_arc4p5.png`); inside a viewport 90 (`RC_viewport_arc90.png`); layer CLOUD colour 12 (`RC_layer_colour12.png`); Enter repeats RC and its OSNAP question (`RC_Enter_repeat.png`); Escape mid-cloud leaves nothing (`RC_cancel.png`); the drafter's layer (TIE DOWN) and OSMODE 21759 restored (`RC_OSMODE_restored.png`). One FAIL: the first U after a cloud leaves it, the second removes it = BUG-215. Not tested: comparison with an older drawing's cloud (none in the copies). Report: `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (checks 84-92).

---

## BUG-168

**Command / Area:** CE command-line keywords in Drainage and Manager; first seen in CDGRIPDIAG.

**Symptom:** Tim clicked Off in the CDGRIPDIAG F12 list and the command line selected On.

**Expected behaviour:** clicking Off must turn the guard off. Each displayed choice must have its own unambiguous typed shortcut.

**Reference:** Tim, 24 Sep 2026: "IF AN END USER CLICKS ON THE OFF THEN IT ALWAYS SHOWS AS SELECTED AS ON IN THE COMMAND LINE CAN YOU ENSURE THIS IS FIXED THROUGHOUT". Draft PR #155, `codex/keyword-shortcuts` at `825c12ac`; REGRESSION_LOG.md KEYWORD-SHORTCUTS.

**Status:** **FIXED for CDGRIPDIAG — Tim confirmed in AutoCAD 24 Sep 2026 about 15:10 on 3.0.1+7d85c40f** (clicked Off, command line said OFF: "WORKS"). The same fix covers the other Civil prompts (PR #155); those were not each clicked by Tim. The 2024 check is still open.

## Status Summary

| ID | Command / Area | Status |
|----|---------------|--------|
| [BUG-168](#bug-168) | CE command-line F12 keywords — clicking Off can select On | IN PROGRESS — source fix in draft PR #155; 16 focused checks pass and three Drainage Release lanes build with 0 errors. No install or AutoCAD acceptance. |
| [BUG-162](#bug-162) | Tests — `InternalCivilCommands_RebuildOnlyAfterAnAcceptedPipeChange` fails on master and on the installed build | OPEN — stale check, not lost code. Found 23 Sep 2026 by the E-HOLD chat. Nothing to test in AutoCAD. |
| [BUG-161](#bug-161) | Release / trunk — `master` did not contain what is installed in AutoCAD; the next install from it would silently remove this month's Civil work | **FIXED — PR #87 merged 23 Sep 2026, master `b02f3ec7`.** Tim ruled: bring it all in, nothing left out. **Proof after merging: commits in AutoCAD but not on master = 0**, and master contains the installed build `d90659cf`, the 16 Sep payload `d0ffe1a2`, the previous master `38f1d98a` and the 23 Sep Civil work `9ba29f04`. Three lanes built 0 errors; 10,125 tests ran with the failing names identical to the recorded baseline. **No AutoCAD test needed — nothing installed by merging; Tim already runs `d90659cf`.** Root cause recorded: register #78's "LIVE RIGHT NOW" was stale, so the 23 Sep trunk ruling was made on the wrong live line. |
| [BUG-160](#bug-160) | Pipe end dragged on a grade-held pipe — plan IL text rewritten over a hand-typed bottom level; schedule keeps the typed number | OPEN — SUSPECTED from reading the code, 23 Sep 2026. NOT seen in AutoCAD. Same drawing-vs-schedule split fixed for CDPROPAGATE on 15 Sep. |
| [BUG-159](#bug-159) | Ordinary polylines (REC / PLINE) — midpoint grips square instead of stretch grips, hover menus gone | **FIXED — Tim confirmed in AutoCAD 24 Sep 2026 about 15:10 on 3.0.1+7d85c40f** ("WORKS NOW": CDGRIPDIAG On, plain rectangle keeps AutoCAD grips and hover menu, CE pipe keeps CE grips). |
| [BUG-093](#bug-093) | Civil linked-pipe attachment point grips — visible grips reject every drag sample | OPEN — exact AutoCAD debug evidence captured; isolated grip repair required after the active Drawing Intelligence stage. |
| [BUG-092](#bug-092) | Manager startup/workspace change — repeated CE ribbon rebuild causes noticeable lag | IN PROGRESS — Tim approved the bounded repair on 2026-08-25; exact live failure/source provenance recorded; no deployment yet. |
| [BUG-089](#bug-089) | Structural Commands `2`/lintel placement — valid L2/L4 stops at `LINTEL_BOUNDARY_MISSING` | IN PROGRESS — exact deployed `bd517ef` field failure recorded; source diagnosis/correction routed under STRUCTURAL. |
| [BUG-090](#bug-090) | Plugin-wide `CE_VERSION` / About CE Suite — clipped rows and no visible source commit | SOURCE COMPLETE — exact combined `8ac6a9c` clean/pushed/audited; deployment and AutoCAD field proof remain. |
| [BUG-091](#bug-091) | `CD` free-point/current-pipe endpoints, `CDEDIT` local Apply and invert-MText mask truth | IN PROGRESS — Tim approved DR-CD-01; isolated bounded source writer authorised, no deployment. |
| [BUG-084](#bug-084) | Civil drawing lifetime — closed DWGs retained project/database/cache state | FIXED IN CODE — 2026-07-27. net48/net10 regression tests and zero-error builds pass; awaiting controlled AutoCAD open/close/reopen memory verification. |
| [BUG-083](#bug-083) | `PIT` / pit edit windows — closed windows retained by the parts-catalogue event | FIXED IN CODE — 2026-07-27. net48/net10 regression tests and zero-error builds pass; awaiting controlled AutoCAD WPF open/close memory verification. |
| [BUG-082](#bug-082) | CE command-line builds — reusable `dotnet.exe` workers retain RAM after builds finish | FIXED — 2026-07-27. Explicit lightweight `-nr:false`; 10/10 safety tests and controlled Civil/Structural/Manager net48+net10 builds passed with zero new persistent workers. |
| [BUG-058](#bug-058) | `CDIMPORTXCIVIL` — IO/OF registration logs "registered=18" but NO ProjectData entries persist | IN PROGRESS (2026-07-03 PM) — **FIXED IN CODE (d77f8d2)**, awaiting deploy + Tim's retest. Root cause: registered rows had blank EntityHandle → purged by SyncWithDrawing before save + invisible to Pass F. Now linked to the real drawn blocks. |
| [BUG-059](#bug-059) | `CDIMPORTXCIVIL` — pipe records duplicate/accumulate (93 records for ~35 real pipes) | IN PROGRESS (2026-07-03 PM) — **FIXED IN CODE (round 4), awaiting Tim's retest.** Refined root cause from real ProjectData: PRIMARY = re-import cleanup only removed pit-connected pipes, so blank-ended + source-tag-ended (OF/IO/DP) pipes survived every Replace and accumulated (pits are handle-cleared → never doubled); SECONDARY = model-space + anonymous-block scan lanes both emit the same pipe. Fix: every imported pipe now carries the import batch id (`PipeData.ImportBatch`) and cleanup removes ALL tagged pipes + legacy criterion; geometric dedup pass (layer+dia+length+endpoints) before insertion. See REGRESSION_LOG 2026-07-03 "Import Quality round 4". |
| [BUG-060](#bug-060) | `CDIMPORTXCIVIL` — self-pipe P1→P1 still created despite SelfPipeGuard + SelfPipeRepairService | IN PROGRESS (2026-07-03 PM) — **FIXED IN CODE (d77f8d2)**, awaiting deploy + Tim's retest. Root cause: repair patched only the ProjectData JSON mirror; the authoritative Xrecord relink (`LinkPipeEndpointsToPits`, ~12 call sites incl. pit schedule open) had no same-pit guard and resurrected P1→P1 every time. Guard now applied at that layer. |
| [BUG-061](#bug-061) | `CDIMPORTXCIVIL` — multi-segment pipes imported as individual per-segment pipes with IL texts everywhere | OPEN (2026-07-03) — analysis crew (with BUG-059) locating the vertex-split; fix design = chain-merge continuous segments with no pit between. |
| [BUG-062](#bug-062) | `CDIMPORTXCIVIL` — X01 pit block inserted with wrong rotation | OPEN (2026-07-03) — suspect the source drawing's rotated UCS (log: scan transform ~8.6°) is applied to position but not consistently to block rotation. |
| [BUG-063](#bug-063) | `CDIMPORTXCIVIL` — council stub not inserted; existing council pipes not shown | OPEN (2026-07-03) — source has a P1→council DN450 (DesignCheck pipe 108B67 from=P1 to=blank); no "existing infrastructure" concept in import. Related: BUG-056 (CDRUNSOLVE existing-connection concept). Needs design + Tim's conventions for existing services. |
| [BUG-064](#bug-064) | `CDDASHBOARD` → "Propose fixes for all…" shows nothing at all on the imported drawing | OPEN (2026-07-03) — no window appears. Even if zero issues are fixable (likely, given the import mess), it must SAY so ("0 fixable issues — N skipped because…"), never silently do nothing. Related BUG-057. |
| [BUG-065](#bug-065) | `CDIMPORTXCIVIL` — pipes don't terminate at the pit outline (35CONT) — they overrun/underrun the pit box | OPEN (2026-07-03) — drafting-quality: pipe ends should trim to the pit boundary the way hand-drawn CD pipes do. |
| [BUG-066](#bug-066) | `CDIMPORTXCIVIL` — pit labels + cover levels strewn everywhere / on top of other elements | OPEN (2026-07-03) — junction de-confliction v2 insufficient on the real drawing. Needs Tim's screenshot to judge target quality; likely reruns after BUG-059 dedup (half the clutter is the doubles' labels). |
| [BUG-067](#bug-067) | Pit schedule export garbage after Xcivil import (junk inlet rows "s"/"IOs"/"OFs"/blank, duplicated inlets, P1-inlet-from-P1, wrong DIAs) | OPEN (2026-07-03) — largely downstream of BUG-058/059/060/061 (connectivity garbage in → schedule garbage out); re-evaluate after those land; any residual junk-row parsing is its own fix. |
| [BUG-068](#bug-068) | `CDIMPORTXCIVIL` — imported network doesn't land where the architectural xref sits | OPEN (2026-07-03) — import applies the source drawing's UCS transform (log: origin 363104,5782560, rotated ~8.6°); needs a ruling on the anchor convention (align to arch xref? prompt for insertion point/2-point align?). Question for Tim. |
| [BUG-070](#bug-070) | `CDEDIT`/`PITEDIT` — AI suggestion strips showed 3 decimals, Tim works to 2 | IN PROGRESS (2026-07-03) — coded, 96/96 unit tests green, awaiting Tim's AutoCAD confirm. |
| [BUG-071](#bug-071) | `CDEDIT` grade-mismatch popup + rising-main continue popup — too small, text clipped | IN PROGRESS (2026-07-03) — coded (SizeToContent + wider min size), manual-test only, awaiting Tim's AutoCAD confirm. |
| [BUG-072](#bug-072) | `CDEDIT`/`PITEDIT` — pit P-number label jumps on resize | IN PROGRESS (2026-07-03) — glitch fix coded, 5/5 tests green, awaiting Tim's AutoCAD confirm. Block-upgrade CANCELLED (Tim: keep PIT LABEL 2). |
| [BUG-073](#bug-073) | `CD` draw-first — pipe preview showed stale/default data (no true fall/length/invert) | IN PROGRESS (2026-07-03) — coded, 28/28 filtered tests green, awaiting Tim's AutoCAD confirm. |
| [BUG-074](#bug-074) | `CD` — smartify pipe text + flow arrow placement (auto-pick + click-to-move) | IN PROGRESS (2026-07-03) — coded, tests skip on dev box (verified in console harness), net48 0 errors, awaiting Tim's AutoCAD confirm. |
| [BUG-075](#bug-075) | `CD`/`CDEDIT` — invert text lands on top of pipe (near-vertical footprint + no edit-path clash re-check) | IN PROGRESS (2026-07-03) — coded, 71/71 tests green, awaiting Tim's AutoCAD confirm. |
| [BUG-076](#bug-076) | `CD` dialog — upstream→downstream live suggestion (mix: standard grade / keep current fall) | IN PROGRESS (2026-07-03) — coded, 10/10 tests green, awaiting Tim's AutoCAD confirm. |
| [BUG-077](#bug-077) | `CD` — pit inlet→outlet drop carries down the system (5mm fixed, detect-else-default) | IN PROGRESS (2026-07-03) — coded incl. wiring, 12/12 tests green, net48 0 errors, awaiting Tim's AutoCAD confirm. |
| [BUG-078](#bug-078) | `CDEDIT` — can't move invert text above/below on an already-drawn pipe | IN PROGRESS (2026-07-03) — coded (pipe's own annotations were self-clashing the toggle), 37/37 fixture green, net48 0 errors, awaiting Tim's AutoCAD confirm. |
| [BUG-079](#bug-079) | `CDFALL` (FallCommand) — (a) block-overwrite + internal-text overlap; (b) arrow points 180° OPPOSITE the drag; (c) FALL_GRADE text mispositioned until Block-Editor open/close; (d) round-3: grade thrown to TOP + text forced horizontal; (e) round-4: symbol renders WRONG on insert but CORRECT after a manual BEDIT/BCLOSE — the block self-evaluates correctly, the code's manual overrides were fighting it | FIXED IN CODE (round 4, 2026-07-07). (a) `FallPatchPolicy.ShouldPatch` false for ALL origins. (b) removed `+π` reversal + rewrote `ComputeFallDynamicParams` (KEPT). (e) SIMPLIFIED `ApplyFallBlockOrientation` to set only the (correct) arrow params then force the block's OWN re-evaluation via a strengthened `RegenBlockReference` (RecordGraphicsModified + QueueForGraphicsFlush + full `Editor.Regen()`); DELETED the round-1..3 manual overrides (`SyncBlockAttributesFromDefinition`/`FlipAttributeRotations`/`PlaceFallAttributesRelativeToArrow` + pure helpers) that were producing the stale wrong render. Full Drainage.Tests green net10 3541/0/13; plugin net10 0 errors. Branch claude/vigorous-wilson-7e7e91. **ROUND 5 (2026-07-07): CDFALL now inserts Tim's new "FALL SYMBOL 2" block** (preferred-variant wiring mirroring PIT BLOCK 3; ships via `Installer/source_blocks/FALL SYMBOL 2.dwg`; flip param confirmed "Flip state1"; orientation maths unchanged). Full Drainage.Tests green net10 3546/0/13. **ROUND 6 (2026-07-07): readability-only flip + unambiguous insert log** — down-right (~315°) fall text was rendering UPSIDE-DOWN because round-4's Angle1∈[0,180]+flip scheme used the flip to point the arrow. Rewrote `ComputeFallDynamicParams`: `Angle1 = bearing` (full 360°, DXF-confirmed Angle1 max = 2π), `FlipState = 1` ONLY for bearings ∈ (90°,270°) (readability). Fixed the `Block Insert` log to print the RESOLVED name (`inserted=FALL SYMBOL 2`), not the logical request name. FALL tests 47/47 green net10. Awaiting Tim's AutoCAD confirm — all 8 dirs: arrow follows drag AND text readable (down-right must NOT be upside-down); command line shows `inserted=FALL SYMBOL 2`; FIELD-TEST RISK: assumes Angle1 accepts 360° (if block is range-limited to 180°, upper-half arrows point wrong — block fix, not code). **ROUND 7 (2026-07-07): flip reverses the ARROW, not just the text.** Tim updated FALL SYMBOL 2 so Flip flips the text — field-testing 8 dirs proved Flip=1 ALSO reverses the arrow (renders at Angle1+180°). Round-6 assumed text-only, so NW/W/SW came out 180° backwards and due-South's text never flipped. Rewrote `ComputeFallDynamicParams`: bearing ∈ (90°,270°] → `((bearing+180°)%360°, 1)` (pre-compensate so the flip's reversal lands the arrow on the bearing, text readable); else `(bearing, 0)`. Boundary EXCLUSIVE at 90° (due-North no flip), INCLUSIVE at 270° (due-South now flips). 8-dir table: E 0°→(0°,0) NE 45°→(45°,0) N 90°→(90°,0) NW 135°→(315°,1) W 180°→(0°,1) SW 225°→(45°,1) S 270°→(90°,1) SE 315°→(315°,0), all render at the requested bearing. FALL tests 42/42 green net10, plugin 0 errors, `-p:SkipDevBundle=true`. Branch claude/vigorous-wilson-7e7e91. Awaiting Tim's AutoCAD confirm — all 8 dirs arrow follows drag (NW/W/SW no longer backwards) AND text readable (due-South now flipped). **ROUND 8 (2026-07-07): snap near-cardinal drags for a consistent flip.** Roughly-straight drags wobbled across the due-South (270°) / due-North (90°) text-flip boundary → inconsistent inserts. Added pure `SnapFallBearingToCardinal(bearing, tol)` in `BlockService` (snaps to E/N/W/S within ~3°, 0/2π wrap handled, diagonals never snap); `FallCommand` calls it at tolerance=3° before `ApplyFallBlockOrientation`, so ~269°/~271° both resolve to exactly 270°. New `SnapFallBearingToCardinalTests`. Full FALL filter 179/0 green net10, plugin 0 errors, `-p:SkipDevBundle=true`. Awaiting Tim's AutoCAD confirm — roughly-straight-down drag consistent across repeats; diagonals/off-cardinals unaffected. |
| [BUG-056](#bug-056) | `CDRUNSOLVE` — fails when the network discharges to an existing council line | OPEN (2026-07-03) — Tim will handle outside the parallel session. Root cause DIAGNOSED (see detail): the downstream walk silently drops the terminal pipe whose `To` is blank and anchors on the last pit's usually-blank invert; no "existing connection" concept. Fix design + failing-test plan documented in the detail section. |
| [BUG-057](#bug-057) | `CDDASHBOARD` → "Propose fixes for all…" — some proposed-fix logic incorrect | OPEN (2026-07-03) — Tim will handle outside the parallel session. Symptom reported during TIM_CHECKLIST Part 2; SPECIFIC wrong proposals not yet captured — first step is collecting examples from Tim. |
| BUG-055 | `CESHEETS` Publish Issue PDF (suspected) / Autodesk `AdDwfPdk.dll` | OPEN (2026-07-02) — AutoCAD CER crash ~13:19, access violation `0xC0000005` in **AdDwfPdk.dll** (Autodesk's DWG→PDF publish engine, **NOT CE code**), during idle ~26 min after a takeoff export. Minidump faulting module confirmed via `System.Reflection.Metadata` parse (no cdb on machine). Suspected trigger: CESHEETS **Publish Issue PDF** (combined-PDF via `DWG-To-PDF.pc3`) — UNCONFIRMED, awaiting Tim's confirmation of the action + whether it recurs. Possibly same feature as BUG-051 (prior Publish-Issue crash in `styleeng.dll`, since moved to main thread). If it recurs on Publish Issue PDF: try resetting `DWG-To-PDF.pc3` / repair AutoCAD; it's an Autodesk plotter fault, not a CE bug to code-fix. |
| [BUG-054](#bug-054) | REFEDIT in-place xref editing — REFCLOSE→Save back fails | OPEN (2026-06-24) — "objects in working set reference objects outside working set / Application reference missing: ACAD → AcDbLinetypeTableRecord". Office user on OLD **v2.1.0**. Hypothesis: CE reactor not suspended during REFEDIT tangles a linetype ref. Needs diagnosis (repro with CE unloaded / on v2.1.11). |
| [BUG-053](#bug-053) | `CE_CVL` `LinkService.OnObjectModified` (live reactor) — diagnosis mis-named `CompoundBoundsOverrule` | IN PROGRESS — **DEPLOYED v2.1.11 (2026-06-24)**, awaiting Tim's AC test. The named overrule is **dead code** (`if(false)`); the real live `BlockReference.get_Name()` → `eWasOpenForWrite` AV is the `OnObjectModified` reactor (`IsPitBlock`). Reactor now classifies from the handle cache; overrule hardened too. |
| [BUG-051](#bug-051) | `CESHEETS` — Publish Issue (combined PDF) | FIXED 2026-06-15 — PDF plotting was on a background thread (`Task.Run`), crashing AutoCAD in `styleeng.dll`. Now runs on the main thread + `CeThreadGuard` backstop. Tests green; awaiting Tim's AutoCAD confirmation. |
| [BUG-049](#bug-049) | `CEADS` (CE Drafting Standards / settings window) | OPEN — crashes AutoCAD on open (2026-06-05). Likely StaticResource theme-lookup crash. Fix in v2.0 build. |
| [BUG-050](#bug-050) | Beam label placement — direction-dependent side bug | FIXED 2026-06-09 — `CanonicalizeBeamDirection` added to `TryPlaceBeamLabel`; S8 now passes. Awaiting Tim's AutoCAD confirmation. |
| [BUG-001](#bug-001) | `C` alias / Copy Rotate / Move Rotate | OPEN — `C` confirmed ✓ T19 (2026-05-20). CR/MR deferred to Tim externally. |
| [BUG-002](#bug-002) | TEXTEDIT on DBTEXT | FIXED 2026-05-13 — Tim confirmed "works for now". BUG-002 residual (10% edge case) still parked pending repro. |
| [BUG-010](#bug-010) | CDCALC crashes again on open (refix of BUG-112 insufficient) | FIXED — 2026-05-20 (re-confirmed T1 ✓ after 3 successful opens 2026-05-19) |
| [BUG-003](#bug-003) | CDCALC → CE Standard Orifice Pit Detail (v3.0) | OPEN — new feature, separate session |
| [BUG-004](#bug-004) | Layer / draw order / colour / text / dims manager (v3.0) | FIXED — 2026-05-20 (T2 ✓; note: command alias is `CDMANAGER`, not `CDLAYERMANAGER`) |
| [BUG-005](#bug-005) | CDEDIT — invert text above/below glitch on Rising Main | FIXED 2026-05-08 — ✅ T21 Pass (checklist item 21 "CDEDIT near-vertical pipe: inverts stay") |
| [BUG-006](#bug-006) | Rising Main flow arrow — too far from pipe (lane spacing) | FIXED 2026-05-08 — ✅ T20 Pass (checklist item 20 "Rising Main flow arrow offset") |
| [BUG-007](#bug-007) | Monday batch — 16 items coded/verified. See detail below. | PARTIAL — 9 ✅, 4 ❌ still failing, 2 skipped (no STRUC), 1 separate session |
| [BUG-008](#bug-008) | PITSCHEDULE — rows not sorted on open, only after manual Sort press | FIXED 2026-05-13 — Tim confirmed. |
| [BUG-009](#bug-009) | CDEDIT pit remark — also appears on inlet line | FIXED — 2026-05-20 (T17 ✓). Mirror-related follow-up tracked as BUG-036. |
| [BUG-011](#bug-011) | CD / CDEDIT west callouts — text justify wrong | IN PROGRESS — agent fixing 2026-05-13 |
| [BUG-012](#bug-012) | CDFALL — FALL + 1:80 not left-justified, "1" doesn't line up under "F" | IN PROGRESS — agent fixing via block-definition edit 2026-05-13 |
| [BUG-013](#bug-013) | Build / NuGet — net48 Serilog must be pinned 4.0.0 | FIXED 2026-05-13 (commit `e4546f6b`) — documented |
| [BUG-014](#bug-014) | CD auto-calc grade — "1:N" and "N MIN." failed to parse | FIXED 2026-05-13 (commit `13fc5acb`) — awaiting Tim's AutoCAD confirmation |
| [BUG-015](#bug-015) | CD Custom Grade "1:80" written to pipe text verbatim as "AT 1 IN 1:80" | FIXED 2026-05-13 — awaiting Tim's AutoCAD confirmation |
| [BUG-016](#bug-016) | CD Custom Grade textbox didn't auto-engage Custom mode | DEFERRED 2026-05-14 → resolved in v2.1 Phase 2 (CD button-conversion replaces the radio+textbox pattern entirely). Tim confirmed initial VM-level fix didn't resolve the UX issue in AutoCAD; tackling at the UI redesign level instead. |
| [BUG-017](#bug-017) | Whole plugin breaks when UCS is not set to World | PARTIAL — T23/T24/T25 ✓ 2026-05-20; T22 regression captured as BUG-035 (PIT post-CD rotates in rotated UCS). |
| [BUG-018](#bug-018) | PIT BLOCK 2 — adopt `C:\Lisp Files\PIT BLOCK 2.dwg` as the standard pit block for all users | FIXED — 2026-05-20 (T18 ✓). Installer payload follow-up = BUG-037. |
| [BUG-019](#bug-019) | Charged pipe text needs pipe material prefix | FIXED — 2026-05-20 (T7 ✓). |
| [BUG-020](#bug-020) | CDWT Riser + Dropper tagged "DP" instead of "R" / "D" | IN PROGRESS — attribute sweep kept inside the single CDWT transaction (2026-09-13 rebuild, `SyncAllAttributesInTransaction`); awaiting Tim's AutoCAD test of R1/D1 visible text. |
| [BUG-021](#bug-021) | Invert text placed below pipe when "Above" selected; pipes at ~92-95° angle (NW→SE direction) | IN PROGRESS — coded 2026-05-21 (round 4 R4.3), awaiting Tim's AutoCAD test. Unified `GeometryHelper.GetAbovePerpendicularAngle` — "Top" = +Y always, West=Top only as a fallback for purely vertical pipes. Replaces the `|sin|>|cos|` branch that misfired at Tim's azimuth-280° pipe. 20+ tests across all four quadrants. |
| [BUG-022](#bug-022) | CDSTRIP — Floor Waste blocks placed on the MLINE (drawn line) not centred within the strip drain perimeter | PARTIAL — middle FWs ✓ 2026-05-20; end/corner FWs need additional inset (BUG-028 — fixed in this batch). Fall-arrow restyle = BUG-029 (deferred). |
| [BUG-023](#bug-023) | Split rising main (PARK-032) UX confusing; invert levels shown at the breakline (which isn't a real node) | PARTIAL — mechanics confirmed working 2026-05-20. UX issues split into BUG-030..034 (all deferred to next batch). |
| [BUG-024](#bug-024) | CD/CDEDIT auto-calc produced "random" grades; MIN./MAX. labels leaked; CDEDIT didn't refresh grade on invert edit | IN PROGRESS — coded 2026-05-21 (round 4 R4.1), awaiting Tim's AutoCAD test. Pipe text now ALWAYS shows the actual achieved grade computed from stored inverts (`round(L/|fall|)`) in every mode. No more target-vs-achieved mixing. |
| [BUG-025](#bug-025) | Invert input `1.10` displays as `1.11` (IEEE 754 ceiling overshoot in auto-calc) | IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test. Round 2 fix: new `preserveInlet` overload on `ApplyCalculatedInvertRule` — the user-typed end is now preserved verbatim regardless of which auto-calc direction was used. Solves the minDrop short-pipe interaction the round 1 IEEE fix didn't reach. |
| [BUG-026](#bug-026) | CE Inspector grade panel disagrees with pipe label (15 m × 0.150 m showed 1:94 instead of 1:100) | IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test. Round 2: transitive fix via BUG-126 (stored inverts now match typed values). Added diagnostic log in Inspector grade path so stored vs computed values are visible. |
| [BUG-027](#bug-027) | Default + AutoCalc " MIN." suffix policy needed for steeper-than-configured grades | IN PROGRESS — coded 2026-05-21 (round 4 R4.2), awaiting Tim's AutoCAD test. Tim's locked decision: NO MIN./MAX. suffix anywhere. `ApplyMinimumGradeSuffixRule` is now a no-op. |
| [BUG-028](#bug-028) | CDSTRIP — end + corner FW need additional 50 mm / 25 mm inset along strip direction(s) | IN PROGRESS — coded 2026-05-21 (round 4 R4.5), awaiting Tim's AutoCAD test. Corner inset now per-justify: Top=0, Center=25 mm, Bottom=50 mm. End FWs always 50 mm regardless. Tests rewritten. |
| [BUG-029](#bug-029) | CDSTRIP — replace current fall arrow with a `25DIMS` QLeader (Tim leader type) | IN PROGRESS — coded 2026-05-21 (round 4 R4.4), awaiting Tim's AutoCAD test. Simple Polyline + Solid arrowhead on 25DIMS — two-way flow from high points between adjacent FWs. MLeader path removed. |
| [BUG-030](#bug-030) | Rising main continuation prompt — F12 dynamic input shows "Yes/Ce" instead of "Yes/No" | IN PROGRESS — coded 2026-05-20 (Batch B), awaiting Tim's AutoCAD test. Replaced `[CE]` bracket prefix with `CE:` colon prefix in keyword prompts so F12 dynamic input no longer mis-parses the first bracket. |
| [BUG-031](#bug-031) | Rising main continuation prompt should be a popup dialog, not a command-line prompt | IN PROGRESS — coded 2026-05-21 (round 4 R4.6 + R4.7) → R6.6 → **R7.1** (2026-05-22).  R7.1: breakline glyph rebuilt as a 6-vertex Z-polyline (mirrors STRUC's BL command); the block insert path that kept misfiring is retired.  5 new unit tests in `BreaklinePolylineTests`.  Awaiting Tim's AutoCAD test. |
| [BUG-032](#bug-032) | Rising main linked halves not surfaced in CE Inspector | IN PROGRESS — coded 2026-05-21 (round 4 R4.8), awaiting Tim's AutoCAD test. Diagnostic logging added to PopulateRisingMainPairing so the next test surfaces why the badge stays blank; ⇔ glyph replaced with plain text in case of font issue. |
| [BUG-033](#bug-033) | Small-diameter pipes (<100 mm) — flow arrow inserted too far from pipe line | IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test. Root cause: the lane 0/1 clash detection in `PipeCreationService` used a FIXED 200 mm search radius, false-triggering on a 50 mm pipe's own MLINE and bumping to lane 1 (+275 mm). Fix: clash radius now scales with pipe diameter (`max(radius + 25 mm, 80 mm)`). |
| [BUG-034](#bug-034) | Rising main continuation context — after first half placed, CD/CDEDIT should auto-pick Continuation mode | IN PROGRESS — coded 2026-05-20 (Batch B), awaiting Tim's AutoCAD test. Simpler version: persist breakline mode via `LastIsRisingMainBreakline` (already wired) + added diagnostic log line for visibility. Auto-detect of orphan first-half deferred as BUG-034b. |
| [BUG-035](#bug-035) | Rotated UCS — PIT placed inside or right after CD rotates by itself (T22 regression of BUG-017) | IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test. Defensive fix: PitCommand now zero-checks the just-inserted block reference rotation and forces it to 0 if non-zero. Diagnostic log surfaces the residual rotation when triggered so the root-cause source can be chased next round. New `UcsGuardService.GetActiveSavedUcsRotationRadians` API added for future UCS-aware variants. |
| [BUG-036](#bug-036) | Pit cover-level text — must stay linked to parent pit when user runs MIRROR | IN PROGRESS — coded 2026-05-21 (round 4 R4.9), awaiting Tim's AutoCAD test. `MovePitAttachments` now refreshes stored offset when the pit didn't move this round but the attachment was repositioned (MIRROR/grip). Fixes the MIRROR-then-MOVE snap-back bug. |
| [BUG-037](#bug-037) | Verify `PIT BLOCK 2.dwg` ships in installer payload to other CE machines | IN PROGRESS — verified 2026-05-20 (Batch B), no code change required. Documented in REGRESSION_LOG: installer build_installer.ps1 line 56 includes the .dwg in $blocks; BlockService resolver finds it first. Awaiting Tim's installer-build confirmation. |
| [BUG-038](#bug-038) | Inspector — paired rising-main inverts show as one merged row | IN PROGRESS — coded 2026-05-21 (round 4 R4.8 — bundled with BUG-032), awaiting Tim's AutoCAD test. Diagnostic logging added; full functional verification depends on what the log surfaces next test. |
| [BUG-040](#bug-040) | CDWT — when user picks an EXISTING PIT, prompt total + detention; reuse = difference; insert plain MText (no MLeader) | RETIRED FROM CDWT — 2026-09-13. Tim ruled CDWT is water tanks only; the pit-detention branch was removed in the CV4-9/15 rebuild (`docs/workflows/CV-04_CDWT_WATER_TANKS_ONLY_ATOMIC_2026-09-13.md`). A detention-pit annotation tool needs its own card. |
| [BUG-041](#bug-041) | Custom grade rejected polylines with more than 2 vertices | IN PROGRESS — coded 2026-05-21 (round 4 R4.11), awaiting Tim's AutoCAD test. Removed the 2-point limit in CdCommand vertex collection. Grade label uses total polyline length per R4.1. |
| [BUG-042](#bug-042) | Add breakline ability to regular (gravity) pipes, downhill direction | IN PROGRESS — coded 2026-05-21 (round 4 R4.12), awaiting Tim's AutoCAD test. New `IsGravityBreakline` ViewModel property + `IsAnyBreaklineRequested` predicate. Linkage code reused from rising main. |
| [BUG-043](#bug-043) | DTEXT double-click glitch + 25DIMS always to front | IN PROGRESS — coded 2026-06-02, awaiting Tim's AutoCAD test. CE-data guard in CompoundEditModeService; ATTRIB added to bypass list; draw order removed from CDSRZ + CDTPZ. |
| BUG-044 | CD command threw "side-DB test mode" on every pipe draw | IN PROGRESS — coded 2026-06-04, awaiting AC test. `PipeCreationService.isSideDb` now only true when caller explicitly passed a different DB. See REGRESSION_LOG. |
| BUG-045 | Pit label / cover text left behind on first move of session | IN PROGRESS — coded 2026-06-04, awaiting AC test. Cold-cache geometric follow in `MovePitAttachments`. See REGRESSION_LOG. |
| BUG-046 | CD STILL crashed (side-DB) after BUG-044 — ReferenceEquals on AC Database wrappers is unsound | IN PROGRESS — coded 2026-06-04, awaiting AC test. Explicit `IsSideDatabaseOperation` flag replaces reference inference. SUPERSEDES BUG-044. |
| BUG-047 | "Simple Pipe" mode stuck on with Recall Last Settings | IN PROGRESS — coded 2026-06-04, awaiting AC test. Simple-pipe is now one-shot, not persisted. |
| BUG-048 | Invert level text boxes styling regressed | OPEN — needs screenshot of CD dialog invert section. Not fixed blind. |

---

## BUG-167

**Command / Area:** the release build, `Installer\build_installer.ps1`, at "Creating payload.zip" (`Compress-Archive`). Area: release packaging, which Tuesday's colleague installer needs.

**Symptom:** twice on 23 Sep 2026, at 22:36 and 23:33, the build finished every lane (Legacy, Net8, Modern, object enabler, shared config and 17 blocks all verified), then stopped at "Creating payload.zip...". `payload.zip` stayed at 0 bytes. The Windows PowerShell 5.1 process stopped using CPU, with its main thread waiting inside Windows ("Executive"). It was left 40 minutes the first time and 12 the second, then stopped by hand. The 18:54 build the same evening zipped normally.

**What is known:**
1. There was no Defender detection. CPU load was 15%. AutoCAD was closed.
2. Defender's `MpOav.dll` is loaded in the hung process.
3. The machine had five test runs and two Codex builds going at the time.

**Not known:** what the zip is waiting on.

**Workaround used:** the local install (`Deploy-Local-AsAdmin.ps1`) copies from `Installer\payload_build`, not from the zip. The 23 Sep 23:50 install therefore deployed the finished build after checking that all three lanes read the master commit. The installer .exe, the archive copy and the source snapshot were not made for that build.

**Expected behaviour:** `payload.zip` is written in under a minute (806 files, 134 MB).

**Test that catches it:** run `build_installer.ps1` on a quiet machine and time the zip step. If it hangs again, try `[System.IO.Compression.ZipFile]::CreateFromDirectory` on the same folder from PowerShell 7, and check whether Defender real-time scanning of the new zip is the wait.

**Steps for Tim to confirm the fix:** the colleague installer builds end to end, and `payload.zip` opens.

**Reference:** found by the release chat during the 23 Sep night install.

**Built 29 Sep ~06:00: PR #364** - both Compress-Archive calls in build_installer.ps1 replaced with .NET ZipFile (temp name then rename, clear error); isolated test showed identical entries. Will be exercised for real by tonight's install build (include #364 in the combine).

**Status:** OPEN. It must be fixed or understood before the Tuesday colleague package is built.

---

## BUG-166

**Command / Area:** double-clicking a CE level label (an IL text) should open Edit Pipe (`CompoundEditModeService`, the TEXTEDIT redirect). Area C (CD / pipe editing).

**Symptom:** Codex pass 1, step B-L1, 23 Sep 2026 about 14:33, on the DWG-B fresh test copy: double-clicked "IL 16.98" beside P1. AutoCAD's own text editor started (*"TEXTEDIT Select an annotation object or [Undo/Mode]:"*), and Edit Pipe never opened. Codex pressed Escape twice.

**What is known (read from `%APPDATA%\CE_CVL_SUITE\logs\ce_cvl_structured_20260923.log`):**
1. CE decided correctly: *"exact cached text 1104C1 routes to pipe 109835"*.
2. It posted the cancel (*"CANCELCMD posted=true for TEXTEDIT"*) and scheduled Edit Pipe for when AutoCAD goes idle.
3. **TEXTEDIT did not end.** 2.5 s later the log still says *"command running during TEXTEDIT"*, and no TEXTEDIT end line follows. For BEDIT (pits, 14:26) the same cancel ended the command in 43 ms, and Edit Pipe started half a second later.
4. The line *"starting CDEDIT in command context"* never appears. So the idle-time start never ran, or the queued edit expired while TEXTEDIT waited for Escape.
**Not known:** which of those two, so no fix yet (a blind change to command-cancel timing is how the 4 Sep Test Day 3 bug happened).

**Expected behaviour:** double-clicking a CE level label opens Edit Pipe on its pipe, the same as double-clicking the pipe.

**Test that catches it:** Codex list, step B-L1b (added 23 Sep): double-click the IL label and **wait 15 s without pressing anything**; then press Escape **once** and wait 10 s. Record the command line and the structured log lines containing `TryRedirectToCdEdit`.

**Steps for Tim to confirm the fix:** double-click a pipe's IL label: Edit Pipe opens on that pipe.

**Reference:** found by Codex (pass 1, B-L1), diagnosed by the release chat from both CE logs, 23 Sep 2026.

**Experiment result (Codex B-L1b, 15:25 and 15:26):** TEXTEDIT stays in in-place editing through 15 s; one Escape returns it to its own Multiple prompt; it never ends, so the queued Edit Pipe never runs. The log shows CE routed and posted the cancel both times.

**Fix:** PR #107 (`a2f56f43`). When redirecting a text editor, CE empties the pre-picked set before the cancel, so the command stops at its prompt, where the cancel lands as it does for BEDIT. Cannot be proven headless.

**Status:** IN PROGRESS — fix merged 23 Sep; not installed; Codex re-runs B-L1 after the install; then Tim confirms

---

## BUG-165

**Command / Area:** CE Manager automatic updates (`Modules/Manager/Services/CePluginInstallerService.cs`, `CompareVersions` / `IsNewerBuild`). Area REL. Nothing Tim sees today.

**Symptom:** live in the OLD Manager on Tim's PC (`96e7d76a`): its trace log shows *"staging CE_CVL_SUITE → 2026.0420.1549"* at every AutoCAD start, 54 times since 7 Sep, observed to change nothing (Civil stayed on Version 3). Latent in the new Manager. Older CE builds used date-style version numbers (`2026.0420.1549`, still named in the IT Admin approval of 28 Apr). `CompareVersions` parses both as version numbers, so `2026.420.1549` counts as **newer** than `3.0.0`. If such a build ever carried a valid signed approval, Manager would "update" a Version 3 machine back to it.

**What stops it today:** the new Manager only stages an approval that carries the signed, pinned identity; the April and July approvals do not, so they are refused (*"This approval predates exact signed-content verification"*). Read from source 23 Sep; not run.

**Expected behaviour:** a date-style version is never treated as newer than a 3.x release; going backwards is only ever an explicit rollback.

**Test that catches it:** a unit test: `IsNewerBuild(installed 3.0.0, available 2026.0420.1549)` returns false.

**Steps for Tim to confirm the fix:** none in AutoCAD.

**Reference:** found by the release chat while checking the deploy chat's question "does Manager refuse to go backwards", 23 Sep 2026.

**Status:** IN PROGRESS — fix merged 23 Sep 2026 (PR #92, `c1d0b7db`; Manager tests 233/233); not installed on Tim's PC yet

---

## BUG-164

**Command / Area:** AutoCAD closing, with the CE plugins loaded. **Tim, 23 Sep 2026, asked whether he sees a crash message when closing AutoCAD: *"Sometimes"*.** Whether CE is involved is not established.

**Symptom:** Tim sees a crash message on closing AutoCAD *"Sometimes"* (23 Sep, in answer to a question; not a report of one event). Windows has saved an AutoCAD crash report (`acad.exe.<number>.dmp` in `C:\Users\TimothyBrand\AppData\Local\CrashDumps\`) close to an install, five times. Report time against install time: 16 Sep **16:03** against the 16:06 deploy; 16 Sep **22:32** against the 22:31 and 22:57 deploys; 23 Sep **09:33** against the 09:34 "AutoCAD is closed" and the 09:36 deploy; 23 Sep **11:05** against the 11:05 to 11:07 deploy attempt; 23 Sep **11:25** against the 11:26 deploy. Three other reports on 16 Sep (11:52, 12:17, 17:57) are not near an install.

**What is known:** the report times (read from the drive, 23 Sep). **What is NOT known:** whether each report is a crash on closing, which module failed, and whether CE is involved. That needs the reports opened with a debugger. None is installed on this PC (`dotnet-trace` only).

**Expected behaviour:** AutoCAD closes cleanly. A colleague must not see "AutoCAD has stopped working" every time they close it.

**Test that catches it:** close AutoCAD with a CE drawing open; no new `acad.exe.*.dmp` appears in `C:\Users\TimothyBrand\AppData\Local\CrashDumps\`.

**Steps for Tim to confirm the fix:** open AutoCAD, open a drainage job, close AutoCAD normally. No crash message, and no new report file with that time.

**Reference:** found by the release chat (`CE_ACAD / release-v3-colleagues / plan / 01`) while looking for BUG-163 evidence. Handed with BUG-163 to the tanks chat. **The reports hold AutoCAD's memory, which can include drawing content: read them where they are, never copy them into a repository.**

**CAUSE PROVEN, 23 Sep 2026 (Windows event log, Application events 1026/1000):** 18 closes from 15 to 23 Sep ended in an access violation in `CWnd.ShowWindow`, called from `PaletteSet.set_Visible` in `InspectorPaletteService.Shutdown()` (17) and `CeAssistantPaletteService.Shutdown()` (1), reached from `PluginInitialization.Terminate()`. It is CE's own code. All 8 crash reports match those times. None of them is the CDWT crash (BUG-163).

**Fix:** both shutdowns release the palette without hiding it. Guard tests fail on the old code, pass now (6/6). Merged: PR #90, `master` `aeb03763`. **Not installed.** Goes out with the next install on Tim's PC.

**Installed:** 23 Sep 2026 12:18, Civil `3.0.0+aeb03763` on Tim's PC (read back by hand, every lane).

**Codex evidence, 23 Sep about 14:45 (pass 1, steps C1 and C2):** three normal closes of AutoCAD with the CE Inspector open and expanded, on the DWG-A test copy. No crash message; the window closed cleanly each time. **No new crash report:** the newest `acad.exe.*.dmp` is still the 12:12 one, which was a deliberately stopped test instance. That compares with 18 crashing closes between 15 and 23 Sep. C3 and C4 were still to run. This is evidence, not acceptance.

**Codex pass 17 (29 Sep 00:48, Civil 3.0.12): B5 PASS - three normal shutdowns with the Inspector open (QUIT, QUIT with two drawings, main X), no crash report. Codex-accepted** (with the 23 Sep three clean closes). Tim can still reject.

**Status:** IN PROGRESS — installed 23 Sep 12:18; Codex saw three clean closes; **waiting for Tim to confirm in AutoCAD**

**Codex 30 Sep sweep C1: a different crash, relation Unknown (BUG-224).** AutoCAD crashed at 07:55 closing a saved drawing copy through COM `Document.Close(false)`: faulting module coreclr.dll, exception 0xc0000005, dump `acad.exe.4120.dmp` not yet read. This BUG-164 fix (palette shutdown on QUIT) is present in the installed 3.0.15; this crash was on closing one drawing, not quitting, and there is no evidence it is BUG-164 returning. Status of this bug unchanged (still waiting for Tim).

---

## BUG-163

**Command / Area:** `CDWT` (water tanks), placing a tank. Area G. Colleague release blocker (area REL).

**Symptom:** Tim, Test Day 16 Sep: AutoCAD shows **"AutoCAD cannot continue"** and closes when he picks the callout point while placing a tank. Codex reproduced it on 17 Sep (its W4): 4500 L underground, 1000 L detention, underdeck plan, Place tank; the insertion and callout prompts appeared, **no ghost of the tank followed the cursor**, and picking the callout position crashed AutoCAD before the riser / dropper / Base RL questions.

**Expected behaviour:** a ghost of the real tank follows the cursor at the insertion point; then CE asks about callout, riser and dropper, then Base RL; the tank is placed. No crash.

**What is known:** CE's own error handling never sees it and **no CE log line exists for it** (the 18 Sep fixes chat). Cause **not established**; no fix attempted. Evidence: `C:\TimOS\retired\_TEST_COPIES_20260917\package\FAILURE_EVIDENCE_REGISTER_2026-09-17.md`, section W4, with `evidence\w4-crash.jpg` and `evidence\w4-capture-window.log` (that folder may name real jobs: read it, never copy it into a repository). The crash reports listed under BUG-164 include ones from 16 Sep that may be this crash.

**Test that catches it:** Codex run list Part B step **B-T8** (the crash probe: at the callout prompt press Enter instead of picking). No automated test exists yet.

**Steps for Tim to confirm the fix:** `CDWT`, Underground, 4500 L, set a detention share, pick the underdeck plan, **Place tank**, pick an insertion point (a ghost of the tank follows the cursor), then pick the callout point. **Right looks like:** no crash; CE asks about riser and dropper, then Base RL; the tank is drawn.

**Reference:** `decisions\2026-09-16_TEST_DAY_RESULTS.md`; `archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-18.md` step N9. Logged 23 Sep 2026 by the release chat; it had never been in this file. Tim, 23 Sep: start a chat on it now.

**EVIDENCE FOUND 23 Sep 2026 — AutoCAD's own crash report** (`%LOCALAPPDATA%\Autodesk\CER\6d903fba…\1789566209810`, written 16 Sep 23:43, the minute of Codex's W4 run). Read as text; the minidump itself was not opened (no debugger installed):

1. **Where it died:** inside AutoCAD's own point pick — `Editor.GetPoint` ← `WaterTankCommand.PromptOptionalPoint` ← `BuildAndApply` ← `PlaceWaterTank`. That is the **callout** prompt (not the riser step after it). Faulting module `KERNELBASE.dll`; the report carries the flag `win_message_queue_full`. No .NET unhandled exception recorded.
2. **Drawing:** `dwg-b.dwg`. Last commands: CDINSPECTOR, BEDIT, then the CDWT group.
3. **Just before it** (first-chance, handled): `eFilerError` from `Entity.GeometricExtents` on object `1041DE` inside `LinkService.CollectTextBoxesNear` (the callout live words), and the tank-ghost lookup failure since fixed by W-09/W-10.
4. **Lead, NOT proven:** during that pick CE forces *Nearest* object snap (`NearestOnlyOsnapScope`). An object whose outline cannot be read (`eFilerError`) sat near the tank; the drawing had had its pipes converted that day to the **16 Sep version of the CE pipe object**, which was rebuilt on a Polyline on 17 Sep after problems. AutoCAD snapping to an unreadable object during the pick would fit. If so, the 17 Sep rebuild may already have removed the cause.
4a. **PROBE RESULT, 23 Sep 12:24 (headless AutoCAD 2027, read-only, on a copy of the drawing saved at 23:42, one minute before the crash):** object `1041DE` is **not** a CE pipe object. It is a pasted block `A$Cf97f4bf9` (layer BLOCKS) holding a **PDF underlay** (`AcDbPdfReference`), a text and a wipeout. The PDF underlay's outline cannot be computed (`eFilerError`), so neither can the block's. It is the only such object among 1,084 in model space. (AutoCAD's crash-time recovery copy would not open headless: ErrorStatus 190.) **The 16 Sep pipe-object lead in item 4 is withdrawn.** **New lead, NOT proven:** CE forces Nearest snap during the callout pick; snapping at or near that damaged underlay may be what stopped AutoCAD. **Supporting facts (deploy chat, from source, 23 Sep):** Nearest-only is forced by `NearestOnlyOsnapScope` (OSMODE 512, whatever it was before) and **only at the callout prompt** (`WaterTankCommand.cs:220`, BUG-127); the riser and dropper prompts do not force it. It landed in `3197e3d4` on 15 Sep, the day before Tim's crash. **Any fix needs Tim's ruling:** Nearest at the callout is his BUG-127 request. **Repro for Codex:** Part T of the one list, on `C:\Lisp Files\_TEST_COPIES_20260923\DWG-B_16SEP_PRECRASH.dwg`.
5. **Next (earlier plan, kept for the record):** (a) identify object `1041DE` in the 16 Sep copy of `DWG-B` (`C:\TimOS\retired\_TEST_COPIES_20260917`) with a headless read — what type it is; (b) Codex step B-T8 / A-N9 on today's build, on a drawing converted with today's pipe object; (c) only then decide whether CE should stop forcing Nearest snap at the callout pick.

**RESULT, 24 Sep 2026 about 09:09 (Tim's own test, run with the deploy chat):** the original conditions were used: the 16 Sep drawing from its real job folder, the PDF underlay visibly loaded, and the callout picked right over the PDF. CDWT completed: tank WT16 with its callout, riser and dropper; the callout was calibrated in two attempts. No AutoCAD crash dump (the newest is still 23 Sep). Build `3.0.0+c78a350d`. This is the first test with the PDF actually loaded; the two on 23 Sep had it unresolved, so they could not decide it. **The Nearest-over-PDF lead is disproven.** No change to Nearest-only at the callout: Tim's BUG-127 behaviour stays, and that snap ruling comes off his list. Most likely explanation, NOT proven: on 16 Sep the plan block name could never resolve, which has since been fixed with `WithName`. Repo record: PR #152 (record only); PR #91 closed as superseded.

**Status:** NOT REPRODUCED. Tim-tested 24 Sep 2026 in the original conditions on `c78a350d`; the Nearest-over-PDF lead is disproven. Not marked FIXED, because no fix was aimed at it. Reopen with the AutoCAD error report if CDWT ever crashes again. See the 28 Sep addendum below for the next concrete experiment.


**Caveat, 23 Sep about 15:50 (deploy chat and release chat):** the eFilerError on `1041DE` (a block holding a PDF underlay, `AcDbPdfReference` 104110) was measured headless on a copy with **no PDF beside it**. Headless may not load PDF underlays at all. So it may belong to the missing or unloaded underlay, not to the PDF. Codex's Part T copy shows "Missing or invalid reference" at the underlay too. **A "no crash" result in Part T does not disprove this bug**: nobody has yet tested the 16 Sep state, with the PDF resolvable, in full AutoCAD.

**FRESH LOOK, 28 Sep 2026 (BUG-163 chat, code + raw-evidence read; no live AutoCAD in this session, so no new repro attempt):**

1. Read the raw 16 Sep capture itself, not just the CER summary: `evidence\w4-CE_CVL_SUITE.log`. Its **last line**, 23:43:28.996 (the crash was captured at 23:44:05, per `w4-capture-window.log`) is exactly the tank-ghost failure already named in item 3 above: `[CDWT] tank ghost not shown: The master drawing no longer contains the plan block 2510L UNDERDECK WATER TANK / (2150L x 1900W x 800H) (1900 x 2150 mm).` Nothing from CE is logged between that line and the crash. This confirms, from the primary log rather than the CER summary, the timing the 24 Sep "most likely explanation" (W-09/W-10, the caption-as-block-name bug) already relies on — it does not prove causation.
2. **A specific, still-live mechanism, not previously named, for that same explanation:** the ghost failure comes from `WaterTankPlanBlockSource.EnsurePlanBlockDefinitionInTransaction` (`Modules/Drainage/Services/WaterTankPlanBlockSource.cs`), called by `WaterTankCommand.ShowTankGhost` right after the insertion point is picked and *before* the callout prompt opens (`WaterTankCommand.cs`, current master). When the named block is not in the master, that method opens a **second `Database`** from disk (`new Database(false, true)` + `ReadDwgFile`), starts a `Transaction` on it, finds the block missing, throws, and both are torn down via `using` (transaction aborted, side database closed) — synchronously, in the second before the callout `GetPoint` call begins. That open/abort/close sequence is **unchanged by the W-09/W-10 fix**; it just isn't triggered for the tank Tim placed on 24 Sep, because that tank's name now resolves. It would run again, identically, for any tank whose recorded plan block is genuinely missing from the master (renamed block, edited master, wrong Settings folder). Nobody has tested whether *that* still crashes on the current build.
3. **The one experiment that would settle it, live AutoCAD, no code change needed:** on the current installed build, deliberately force the same "plan block not found" path CDWT hit on 16 Sep — e.g. point the Civil Standard Details folder (Settings) at a scratch copy of the master with the chosen tank's plan block renamed, run `CDWT`, pick that tank, place it (the same `[CDWT] tank ghost not shown` warning should print, and no ghost appears), then pick the callout point. If AutoCAD crashes again, the side-database churn in `EnsurePlanBlockDefinitionInTransaction` — not the specific caption bug — is the real mechanism, and it is open today for any tank whose plan block goes missing. If it does not crash, the 16 Sep crash more likely came from something specific to that job/session that has not recurred, and BUG-163 stays a genuine "not reproduced."
4. No code changed this session (diagnosis only — no confirmed mechanism, and no live AutoCAD to run the experiment above). Does not touch Tim's BUG-127 NEAREST-at-callout ruling.
- **Status unchanged:** NOT REPRODUCED, not marked FIXED. The residual risk in item 2 (missing plan block → side-database churn immediately before a point pick) is the next concrete thing to try, either if BUG-163 resurfaces or before it is closed for good.
---

## BUG-162

**Command / Area:** Automated tests only — `Modules/Drainage.Tests/Services/LinkServiceCommandPerformanceContractTests.cs`,
`InternalCivilCommands_RebuildOnlyAfterAnAcceptedPipeChange`. Nothing Tim sees in AutoCAD.

**Symptom:** the check fails on master `b02f3ec7` and on the installed `d90659cf` (also absent from `d0ffe1a2` and
`10ac480d`). It looks in `PipeEditCommand.Update.cs` for the exact text `if (coordinatedUpdateCommitted)`.
Commit `5ea79fd1` (13 Sep, "Close CDEDIT supplementary transaction gaps") deliberately widened that line to
`if (coordinatedUpdateCommitted || coordinatedUpdateCommitOutcomeUnknown)`, and the check was never moved with it.

**Why it matters:** every chat that runs this group sees one red it did not cause, and may either waste time on it
or learn to ignore reds. It is **not** a sign that the 23 Sep merge dropped work (checked: the old text is missing on
every line since 13 Sep).

**Expected behaviour:** the check accepts the widened condition (and still fails if the guard disappears).

**Test that catches it:** the check itself, green on master.

**Steps for Tim to confirm the fix:** none in AutoCAD.

**Reference:** found by the `pipe-points-locking-grade-invert` chat while running the command-scan tests for PR #88.

**Status:** FIXED — 2026-09-23 (test only: PR #93 merged, `master` `7627ed39`; the check now follows the widened guard, group 54/54; nothing to test in AutoCAD)

---

## BUG-161

**Command / Area:** Release — which code line the next AutoCAD install is built from. Not a drawing command.

**Symptom:** the plugin's trunk (`master`, `3eb912d7`, set 23 Sep 2026 on Tim's "Live is the trunk") does not contain what is actually installed in AutoCAD. The installed DLL reads product version `3.0.0+d0ffe1a2…` (16 Sep 22:38 commit, the 16 Sep test-day payload). Master was built from `10ac480d` (15 Sep 14:42), because deploy register #78 still says `10ac480d` is live. **174 changes that are in AutoCAD today are not on master** (checked 23 Sep 2026 09:40 with `git log --no-merges --cherry-pick --right-only HEAD...d0ffe1a2`). Among them: per-job rainfall and the CDCALC computations sheet (IFD-01), the C7 pipe object rebuild, the CDWT tank window (W-01), the Pipe/Pit Update truthfulness fixes (BUG-154 to 156), and the 15 Sep fix that stops CDPROPAGATE writing over a level typed by hand (`4f04b19d`).

**What would go wrong:** the next install from master would silently take all of that out of Tim's AutoCAD, and any test after it would be testing an older plugin than the one he has now.

**Expected behaviour:** master holds everything installed, or Tim rules which of the 16 Sep payload is deliberately left out (Test Day 16 Sep failed much of it). Register #78 names the real live commit.

**Test that catches it:** before any deploy, `git merge-base --is-ancestor <commit in the installed DLL's version> <commit being deployed>` must succeed, or the deploy chat must name what it removes and have Tim's yes.

**Steps for Tim to confirm the fix:** none in AutoCAD. The chat that fixes it shows the check above passing, and register #78's "LIVE RIGHT NOW" names `d0ffe1a2` (or whatever is installed then).

**Reference:** `decisions\2026-09-23_TRUNK.md`; GitHub issue #78; found by the `pipe-points-locking-grade-invert` chat, which is not the owner. Belongs to whichever chat owns the trunk and deploys.

**Count check (E-HOLD chat, 23 Sep 2026 10:35, after PR #87):** before the merge, master `38f1d98a` lacked **204** changes that are in the installed `3.0.0+d90659cf` (deployed 09:35-09:36), by `git log --no-merges --cherry-pick --right-only`; PR #87 brought in 206. The "eight" in the fixing chat's report does not match this count. After the merge: 0 installed changes missing from master `b02f3ec7`; 6 master changes not yet installed (command-count guard, CDWT-LINK-01, SML/CHECKML, AGENTS.md x2, DATA-01 placeholders), which the next deploy carries. Also: BUG-161 was written at ~09:40 from a DLL read taken just before the 09:36 deploy and never re-read, so it named `d0ffe1a2` and 174 when the installed build had already changed.

**Status:** FIXED — 2026-09-23 (PR #87 merged, master `b02f3ec7`; nothing to test in AutoCAD)

---

## BUG-160

**Command / Area:** Moving the end of a CE pipe (grip drag, STRETCH) when the pipe's grade choice is Default minimum, Default standard or Custom (a "grade-held" pipe). Area E.

**Symptom (suspected — found by reading the code on 23 Sep 2026, not seen in AutoCAD):** if the pipe's bottom level was typed by hand, dragging the pipe end longer or shorter re-works that bottom level from the grade and writes the new number into the IL text on the plan and into the pipe's own stored levels, while the project record (what the pit schedule reads) keeps the hand-typed number. The plan and the schedule then disagree about the same pipe end, with nothing said on the command line.

**Expected behaviour (Tim, 23 Sep 2026: "if i changed something i always need to confirm if the automatic number is correct or not"):** nothing typed by hand is silently kept or silently overwritten. The move opens the preview window, which shows the typed number and the automatic number side by side; Tim picks. Plan text and schedule always end up showing the same number. See `decisions\2026-09-23_HOLD_GRADE_HOLD_LEVELS.md`.

**Real example:** 375 pipe, 20 m at 1 in 100, top IL 10.50, bottom IL typed by hand as 10.30. Drag the end so it is 25 m long. Plan text would show IL 10.25; the schedule would still show 10.30.

**Test that catches it:** a grade-held pipe with a hand-typed bottom level, lengthened; assert the plan IL text, the pipe's stored level and the project record all hold the typed value, and the grade label shows the re-worked grade.

**Steps for Tim to confirm the fix:** draw a pipe at a set grade, open Pipe Edit and type the bottom level by hand, drag the pipe end 5 m further, then open the pit schedule. The IL on the plan and the schedule must show the same number (the one you typed), and the grade label must have changed.

**Reference:** `Modules/Drainage/Services/LinkService.Utilities.cs` — `ApplyGradeLockToInverts` computes the new level without checking the hand-typed flags; `ProjectDataService.UpdatePipeInvertsByHandle` refuses it for the record, but `WriteGradeLockInvertsToEntities` still writes the plan text. Related idea: IDEAS_INBOX 23 Sep 2026, "locked to a grade or locked to an invert".

**Part 1 BUILT (28 Sep ~20:30): PR #354 (`576db45e`)** - Edit Pipe now marks a level as typed only when you actually changed it (numeric compare, 0.0005 m; carry-downstream and CE's own calculations never count). Review MERGE-WITH-FIXES, all fixed; PipeEdit/CdViewModel 193/193; full Civil net10 12,109 passed / 7 known failures. Banked for the next install + Codex pass. Part 2 (the pick window) still ON HOLD below.

**Status:** ON HOLD (28 Sep ~20:10) - PR #352 stays draft, NOT merged. Opus review DO-NOT-MERGE: (1) the "typed" flag is unreliable: pressing OK in Pipe Edit marks BOTH levels typed whenever the boxes are filled (`PipeEditCommand.Update.cs` ~1398-1399, ~1515-1516), even a level CE calculated or a diameter-only save, so after any Pipe Edit save the pipe would freeze its bottom level (this flag bug also affects master: the record refuses updates while plan text changes, widening the original symptom); (2) keeping the typed value with a message is the Claude proposal Tim SUPERSEDED on 23 Sep - he wants to see both numbers and pick; (3) the message repeats on every later update; (4) wrong grade in the message on cross-plan breaklines. **Next:** fix the typed flag first (only a level the user actually changed is typed); then design the pick step as a workflow card (a grip drag cannot stop to ask mid-drag, so the choice has to come at the end of the move, e.g. a small preview window) and ask Tim. Stop-gap question queued for Tim.

**Tim, 29 Sep 2026 (plan/05, clickable): APPROVED the pick window** - when you let go of a grip drag on a grade-held pipe end whose bottom level was typed, a small window asks "Keep your 10.30 / Use automatic 10.25". Part 2 = Codex builds the window (ruling B) + Claude builds the behaviour on top of part 1 (#354). Queue item A5 in `areas/release-v3-colleagues-QUEUE.md`. The stop-gap is not needed.

---

## BUG-158

**Command / Area:** CDCALC — Prepare export / calculation export package, and the test that was supposed to cover it.

**Symptom:** The CE drainage computations sheet — the document that actually goes to the council — is dropped from the calculation export without saying so, whenever anything in its build path fails. Nothing warns on screen; the export simply comes out one section short. In the test harness this happens every single run, because building the sheet reaches `ProjectDataService.Current`, which initialises from the active AutoCAD drawing (`ProjectDataService.Mutations.cs:119`, `Application.DocumentManager.MdiActiveDocument`). With no drawing open it throws, `CalculationExportPackage.CaptureComputationsSheet` catches it, logs, and returns null.

**Expected behaviour:** With Detention, Pipe Flows, Catchments and WSUD all ticked, the export has **five** sections — computations sheet, detention, pipe flows, catchments, WSUD. The sheet leads the export by design ("the computations sheet itself leads the export, because that is the document that goes to the council", `CalculationExportPackage.cs:56-60`). If it genuinely cannot be built, the user should be told, not silently given a shorter export. Dropping it quietly is allowed by R-27's warn-never-block, but R-27 says *warn*, and no warning reaches the user.

**Reference:**
- `Modules/Drainage/Services/CalculationExportPackage.cs:56-62` (section assembly), `:210-250` (`CaptureComputationsSheet` and its swallowing catch).
- `Modules/Drainage.Tests/ViewModels/CalculationsV2ViewModelTests.cs:507` — `PreviewPackage_AllSections_RetainsStatusAndUsesAdvisoryWsudAuthority` asserts `Sections.Count == 4`.

**Why it went unnoticed:** the assertion is **stale, not wrong at the time**. It was written 10 Sep (`42dbda09`, "Integrate selected calculation PDF and Excel exports"). `CaptureComputationsSheet` was added afterwards by `514d4148` (the IFD-01/F1 per-job-rainfall work now in live) and the assertion was never updated. It kept passing only because the sheet was always throwing, so the count stayed at 4. The expectation of 4 therefore encoded the silent omission instead of catching it.

**How it surfaced:** the 16 Sep test-harness change on `claude/cd-pit-live-integration-c1af97` (`09d439f9`) — taking `acdbmgd` from the real AutoCAD install and `accoremgd` from the reference package — removed the exception that was hiding it. The test then correctly reported 5. **This is not a regression from the CD/PIT window work**; the same failure occurs on live `c1af9781` with the same harness. In real AutoCAD, `Application.DocumentManager` works, the sheet builds, and 5 is the correct production count.

**Fix, agreed with Tim 16 Sep — to be done AFTER the CD/PIT AutoCAD test pass, not before, so the branch does not drift from the payload being deployed:**
1. Change the assertion to 5 and assert explicitly that a `ComputationsSheet` section is present with a non-blank status, so a future silent omission fails the test rather than being encoded in it.
2. Decide whether a failed sheet build should surface to the user rather than only reaching the CE log. Tim's call — R-27 permits warn-never-block, but the user currently gets no warning at all.

**Still to confirm in AutoCAD (cheap, same code path):** run CDCALC with detention on, export, and check the computations sheet is actually in the output. If it is missing in real AutoCAD too, this stops being a test problem and becomes a live export defect.

**Triage 29 Sep (release chat 04): fix found in code, 842b2490 / 308ea803 (PR #347), present in the installed Civil 3.0.13. Status stays open until a Codex/Tim check confirms it in AutoCAD; queued for Codex pass 18.**

**Status:** OPEN

**Codex 30 Sep pass18: BLOCKED (no evidence either way).** CDCALC > Print > Sections and export > Preview package on DWG-B_P18: "Council: not stated"; no council computations sheet available, no export made. Needs a copy with a council set. Screenshot `P18_screenshots\B4_no_council.png`; report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (checks 45 and 83).

## BUG-058

**Command / Area:** `CDIMPORTXCIVIL` (monorepo `Modules/Drainage`) — IO/OF pit registration

**Symptom:** After importing Mike's 26612 package, all 18 IO/OF pits show "has no ProjectData entry — run CDLINK to register" in CDCHECKDWG, even though the import log ends with `source-tag-register summary: registered=18 stillUnresolved=0`.

**Expected behaviour:** Every IO/OF marker the import draws is registered so pipes connect to it and no CDLINK homework remains.

**Root cause (diagnosed 2026-07-03):** the registered PitData rows carried `EntityHandle=""` + source-space positions. `ProjectDataService.SyncWithDrawingCore` purges blank-handle pits — called at `XcivilImportService.cs:1249` immediately AFTER registration and BEFORE the save, so all 18 rows died in memory. Even if they survived, Pass F matches by EntityHandle and could never see them.

**Fix:** capture the drawn block's target handle + position in `InsertImportedTaggedSourceBlock`, thread through `XcivilSourceBlockSource.InsertedHandle/InsertedPosition` into the registration plan.

**Status:** IN PROGRESS — fix coded 2026-07-03 PM, tests running; awaiting Tim's AC retest after next deploy.

## BUG-059

**Command / Area:** `CDIMPORTXCIVIL` — entity scanning / pipe recognition

**Symptom:** Single fresh import produces the network ~2-4×: pipes on top of one another, "mis-aligned double pipes" (~1.09 m offset pairs), IL texts everywhere; DesignCheck shows nearly every connection as an identical pair.

**Expected behaviour:** One consultant pipe = one CE pipe.

**Root cause (REFINED 2026-07-03 PM, from the MAIN drawing's real ProjectData — 93 pipe records / ~35 real, pits NOT doubled):** PRIMARY = the re-import Replace cleanup only removed pipes whose From/To referenced an imported PIT id, so blank-ended and source-tag-ended (OF/IO/DP) pipes survived every Replace and ACCUMULATED across re-imports (pits are handle-cleared → never doubled; multiplier 2x/4x/8x = number of re-runs). SECONDARY = single-run dual emission: model-space + anonymous-block scan lanes can both emit the same pipe (Civil 3D stacks plan/profile/section views in one block); AddPipe dedupes per-call only.

**Fix (round 4, coded 2026-07-03 PM):** `PipeData.ImportBatch` stamp on every imported pipe (Xcivil + LandXML lanes) + cleanup removes ALL batch-tagged pipes (union with the legacy pit-connected criterion; hand-drawn pipes provably never removed) + geometric dedup before insertion (layer + diameter + length + endpoint pair, 25 mm grid, best-evidenced copy kept, discards logged). See REGRESSION_LOG "Import Quality round 4".

**TIM'S TWIN-PIPE RULING (2026-07-03 PM):** real parallel pipes closer than ~1 m exist ONLY as detention twin pipes — no other case. The dedup key is safe for those (twins offset well beyond the 25 mm grid, and same-diameter twins still differ in endpoints). Follow-up noted: `BuildImportedPipeData` hardcodes `DetentionTwinPipes = false` ("contractor uses single detention pipes only") — conflicts with Tim's ruling that twin detention runs DO occur; verify how an imported twin-detention run should be modelled when one appears in a real package.

**Status:** IN PROGRESS — round-4 fix coded + committed (d48f8d5), awaiting deploy + Tim's double-import retest.

## BUG-060

**Command / Area:** `CDIMPORTXCIVIL` / `LinkService.RelinkAllPipesToPits` — self-pipe P1→P1

**Symptom:** DesignCheck reports "Invert violation: P1→P1" + circular dependency P5→P4→P3→P2→P1→P1; pit schedule shows P1 with an inlet "FROM P1".

**Expected behaviour:** A pipe can never start and end at the same pit, anywhere in the system.

**Root cause (diagnosed 2026-07-03):** three layers — (1) `SelfPipeRepairService` patches only the ProjectData JSON mirror, never the authoritative Xrecord link data that CDCHECKDWG's graph reads; (2) it clears only `To`, so the schedule still associates the pipe with P1; (3) `LinkPipeEndpointsToPits` (the Xrecord relink used by the pit schedule, ProjectData load and the import itself) has no same-pit guard, so both ends of the short stub re-snap to P1 on every relink — the self-pipe resurrects after every repair. Contributing: the "stub" 108B67/108B91 is a zero-plan-length pipe with 1.5 m fall (a riser/dropper) whose both ends sit inside P1's hitbox.

**Fix:** same-owner guard in `LinkPipeEndpointsToPits` (clear the farther/unlocked end) via new pure `SelfPipeGuard.IsSameOwner`/`SelectEndpointToClear`.

**Status:** IN PROGRESS — fix coded 2026-07-03 PM, tests running; awaiting Tim's AC retest after next deploy.

## BUG-061

**Command / Area:** `CDIMPORTXCIVIL` — "multi-segment pipes drawn as individual segments with ILs everywhere"

**Symptom / diagnosis (2026-07-03):** NOT a polyline-splitting bug (multi-vertex polylines import as ONE pipe). What Tim sees is the BUG-059 triplication: each wall-pair copy produces its own short "merged" centerline with its own invert texts. Residual (post-059): add a chain-merge for genuinely-segmented runs (collinear continuous segments with no pit between → one pipe).

**Status:** OPEN — re-evaluate after BUG-059 lands.

## BUG-062

**Command / Area:** `CDIMPORTXCIVIL` — X01 pit rotation

**Symptom:** X01 inserts rotated incorrectly.

**Root cause (diagnosed 2026-07-03):** X01 is recovered via the centroid-polyline fallback (`XcivilEntityScanner.Pits.cs:312-352`) which derives rotation from a 2-point `CI-STRM-DRAN-DPIT-CNTR` polyline's direction (`atan2(dy,dx)−90°`) instead of the real block insertion angle. Independent of the (correct) global UCS transform.

**Built 29 Sep (Sonnet 5.5 builder): PR #365** - when XCIVIL import merges a pit's block with its CNTR line, the block's own rotation now always wins (the CNTR direction only when there is no block); mirrored blocks are folded so a pit is never turned 180 degrees; each pit records where its rotation came from. 11 new tests; full Civil net10 7 known failures only. Banked for the next install.

**Status:** OPEN.

## BUG-063

**Command / Area:** `CDIMPORTXCIVIL` — council stub + existing council pipes not imported

**Symptom:** The council connection stub isn't inserted; existing council pipes in the consultant drawing aren't shown at all.

**Notes (2026-07-03):** the stub IS scanned (as a zero-length riser-like pipe at P1 — see BUG-060) but has no resolvable destination; there is no "existing infrastructure" concept in the import (related: BUG-056's existing-connection concept for CDRUNSOLVE). Needs design + Tim's conventions for how existing services should be drawn/layered.

**Status:** OPEN — design item, needs Tim input.

## BUG-064

**Command / Area:** `CDDASHBOARD` → "Propose fixes for all…"

**Symptom:** Clicking it on the imported drawing shows nothing at all — no window, no message.

**Expected behaviour:** If zero issues are fixable it must say so and why ("0 fixable — N skipped because …"), never silently no-op. (Wrong-proposal content is BUG-057.)

**Built 29 Sep (Sonnet 5.5): PR #366** - CDDASHBOARD "Propose fixes for all" is always clickable and always reports what it proposed and what it skipped, grouped by reason (e.g. "3 fixes proposed across 2 pipes. 5 items skipped: ..."); when nothing is fixable it says so and zooms to the skipped pipes. What gets fixed is unchanged. 7 new tests; full Civil net10 7 known only. Banked. (Uses a message box for the result - Codex UX pass to judge.)

**Status:** OPEN.

## BUG-065

**Command / Area:** `CDIMPORTXCIVIL` — pipe/pit drafting join

**Symptom:** Imported pipes don't terminate on the pit outline (the 35CONT pit box) — they overrun or stop short.

**Expected behaviour:** Pipe ends trim to the pit boundary exactly like hand-drawn CD pipes.

**Built 29 Sep (Sonnet 5.5): PR #368** - XCIVIL import had its own copy of the pit-wall maths (every pit an unrotated square; a near-miss snapped to the pit centre). It now uses CD's own `PitOutline.TrySnapToWall` with the imported pit's real size, type and rotation. Invert levels are unchanged (still read from the pit's level text; not re-worked at the trimmed end) - question for Tim below. 7 new tests; full Civil net10 7 known only. Banked. **Tim, 29 Sep 2026 (plan/05, clickable): keep the imported levels; flag anything suspect in Project Review, nothing changes silently** - the flag is queue item A6.

**Status:** OPEN.

## BUG-066

**Command / Area:** `CDIMPORTXCIVIL` — annotation placement

**Symptom:** Pit labels and cover levels strewn everywhere, on top of other elements, despite the v2 junction de-confliction.

**Notes:** likely halves after BUG-059 (the doubles' labels are most of the clutter). Needs Tim's screenshot to set the quality bar.

**Status:** OPEN — re-evaluate after BUG-059.

## BUG-067

**Command / Area:** Pit schedule after Xcivil import

**Symptom:** Exported schedule has junk inlet rows ("s", "IOs", "OFs", blank FROM), duplicated inlets, P1 listing an inlet from itself, wrong DIAs.

**Notes:** mostly downstream of BUG-058/059/060/061 — connectivity garbage in, schedule garbage out. Known residual: `PitScheduleBuilder.BuildInletFromDisplay`/`GetOtherEndId` renders "FROM P1" for a pipe whose other end is blank — display should be blank/"(existing)" instead. Re-audit the export after the import fixes land.

**Built 29 Sep ~05:30: PR #363** (on top of BUG-193): the schedule no longer guesses the pit's own ID as the FROM value; a pipe whose upstream end is genuinely unresolved now shows "Unknown" instead of a silent blank (a pit with no inlet stays blank). Builder's full suite reported 8 failures vs the 7 known - the next install gate checks by name. Banked. Tim to confirm "Unknown" is acceptable wording on a plotted schedule (listed under For Tim). **Tim, 29 Sep 2026 (plan/05, clickable): "Unknown" APPROVED** for the FROM column where CE genuinely cannot tell.

**Status:** OPEN.

## BUG-068

**Command / Area:** `CDIMPORTXCIVIL` — placement/alignment

**Symptom:** The imported network doesn't land where the architectural plans are xrefed.

**Notes (2026-07-03):** the import applies the source drawing's rotated UCS transform (~8.6° on this job) correctly in itself, but nothing anchors the result to Tim's sheet setup.

**TIM'S RULING (2026-07-03 PM):** snap to where the architectural xref sits — the drainage plan is drawn ON TOP of the arch plan, so pits/pipes must land at their real-life positions relative to that building. No pick-points prompt wanted. Design task: resolve the arch xref's placement in Tim's drawing (insertion transform) and map the consultant's real-world/site coordinates onto it — investigate how Tim's typical CVL drawing is set up (arch xref at origin? rotated? scaled?) and how Mike's XCivil coordinates relate, then anchor the import to that instead of (or in addition to) the source-UCS transform.

**Status:** OPEN — ruling received, design/build pending.

## BUG-069

**Command / Area:** `CDIMPORTXCIVIL` — mirrored annotation texts (Tim's screenshots, 2026-07-03 PM)

**Symptom:** Several imported annotation texts render MIRRORED/backwards: the "FANU…"-style labels attached to small leader arrows near pipes (visible at the P1 junction and both sides of P4 in Tim's screenshots — "FANU155", "FANU157", "FANU2…" all read right-to-left), while neighbouring CE texts (IL/CL, pipe labels) read correctly.

**Expected behaviour:** No imported or CE-generated text is ever mirrored.

**Notes:** Import Quality v2 cleared `IsMirroredInX/Y` on raw DBText created via the shared `TextService` — these mirrored strings survive, so they come from a DIFFERENT path. Two hypotheses to check: (a) they are consultant source texts (Civil 3D structure/pipe name labels?) copied across as supplemental content without mirror normalization; (b) they are block ATTRIBUTES or MText (fall-arrow/leader annotations) which the DBText-only guard never touches. Also check the spot-level texts (P18.974 family) for the same fault. Identify the creation site first, then extend the mirror guard there.

**29 Sep (Sonnet 5.5): PR #369 HELD, not banked.** The builder did not find the site that mirrors the imported labels; instead it added a shared 'make text readable' guard to block attributes, source-tag labels and imported pit cover text. That changes existing behaviour broadly (pit attributes on blocks rotated 90-270 degrees would flip and swap justification), without a proven cause. Needs: a Codex reproduction on the original drawing type to find the real source, then a narrow fix. Not installed.

**Status:** OPEN — filed from screenshots; investigate after round-4 retest (the duplicate purge will also remove many of the affected copies).

## BUG-070

**Command / Area:** `CDEDIT` / `PITEDIT` — AI suggestion strips (grade/invert strip, pit-setup strip)

**Symptom:** The CDEDIT grade/invert suggestion strip and the PITEDIT pit-setup suggestion strip (cover level / invert level) showed 3 decimal places (e.g. "18.500"), while Tim works to 2 decimal places everywhere else for invert/cover/RL values.

**Expected behaviour:** Both strips show 2 decimal places, matching the codebase-wide convention (confirmed by grep across `Modules/Drainage`).

**Reference:** `Modules/Drainage/ViewModels/CdViewModel.GradeSuggestion.cs`, `Modules/Drainage/ViewModels/PitSuggestionViewModel.cs`, `Modules/Drainage/Commands/PitCommand.cs`. Filed from Tim's CD-smartify field report (2026-07-03).

**Status:** IN PROGRESS (2026-07-03) — coded, 96/96 unit tests green on net48, awaiting Tim's AutoCAD confirm. See REGRESSION_LOG.md "BUG-070" for full detail (files/lines changed, deliberately-left 3dp sites, and why).

## BUG-071

**Command / Area:** `CDEDIT` "Grade mismatch" popup + rising-main "Continue on another plan?" popup

**Symptom:** Both dialogs were hard-locked at a small fixed size with `ResizeMode="NoResize"` — the message text could get clipped/unreadable on a longer mismatch message.

**Expected behaviour:** The dialog always grows to fit its full message; nothing is ever clipped.

**Reference:** `Modules/Drainage/Dialogs/GradeMismatchDialog.xaml`, `Modules/Drainage/Dialogs/ContinueRisingMainDialog.xaml`. Filed from Tim's CD-smartify field report (2026-07-03).

**Status:** IN PROGRESS (2026-07-03) — coded (SizeToContent="Height" + Auto message row + wider min size), manual-test only (pure XAML), awaiting Tim's AutoCAD confirm. See REGRESSION_LOG.md "BUG-071" for full detail.

## BUG-072

**Command / Area:** `CDEDIT` / `PITEDIT` — pit P-number label position on resize

**Symptom:** Resizing a pit jumps the "P#" label to the wrong place (shoves outward even when the pit is made smaller; near-centre labels fling across the circle — Tim's first screenshot).

**Expected behaviour:** On resize the label keeps its side/gap relative to the pit (grow → out, shrink → in), never crosses the circle.

**Reference:** `Modules/Drainage/Helpers/PitAnnotationShift.cs` (new), `Modules/Drainage/Commands/PitEditCommand.cs` (ShiftAnnotation). Filed from Tim's CD-smartify field report (2026-07-03).

**Status:** IN PROGRESS (2026-07-03) — glitch fix CODED, 5/5 unit tests green, awaiting Tim's AutoCAD confirm. Block-upgrade sub-task CANCELLED 2026-07-03 (Tim: keep PIT LABEL 2 — the jump was purely a code glitch, now fixed).

## BUG-073

**Command / Area:** `CD` (draw-first mode) — WPF dialog pipe preview

**Symptom:** In draw-first mode the pipe preview didn't reflect reality — no true fall/length, invert on/off not shown, not a true reflection of what would be drawn.

**Expected behaviour:** The preview shows the real drawn length + fall/grade and the actual invert on/off state, updating live.

**Reference:** `Modules/Drainage/Commands/CdCommand.GradeSuggestion.cs`, `Modules/Drainage/ViewModels/CdViewModel.Preview.cs`. Filed from Tim's CD-smartify field report (2026-07-03).

**Status:** IN PROGRESS (2026-07-03) — CODED, 28/28 filtered unit tests green on net48, awaiting Tim's AutoCAD confirm. See REGRESSION_LOG.md "BUG-073".

## BUG-074

**Command / Area:** `CD` — pipe text + flow arrow placement ("move to another segment")

**Symptom:** Pipe text + flow arrow always land on the longest segment; moving them means answering a prompt and typing a segment number — not smart, not quick.

**Expected behaviour:** Smart auto-pick of the clearest/most-readable segment (avoids pits/other labels, prefers a flatter segment), with a quick CLICK-to-move override + live preview instead of typing numbers. (Tim's choice: "smart auto-pick + click to move", 2026-07-03.)

**Reference:** `Modules/Drainage/Services/QuickModeService.cs` (TryGetPreferredPipeTextSegment), `ArrowService.cs`, `PipeTextPlacementService.cs`, `CdCommand.Arrows.cs`. Filed from Tim's CD-smartify field report (2026-07-03).

**Status:** IN PROGRESS (2026-07-03) — CODED (pure `PipeTextSegmentChooser` + pick-then-snap move), 17 tests (skip on dev box per Acdbmgd gap; logic verified in console harness 14/14), net48 0 errors, awaiting Tim's AutoCAD confirm. Follow-ups: wire clash probe into auto-pick; duplicate old prompt still in PipeEditCommand.Attachments.cs (do in BUG-078). See REGRESSION_LOG.md "BUG-074".

## BUG-075

**Command / Area:** `CD` / `CDEDIT` — invert (IL) text placed on top of the pipe

**Symptom:** Invert text chosen to sit "above" clashes with another pipe/object, then goes "below" but lands ON TOP of the pipe instead of clearly under it — happens on near-vertical pipes (Tim's second image) and "almost without reason" on others too.

**Expected behaviour:** "Below" always sits clearly clear of the pipe; a chosen side that clashes is re-checked and flipped on the EDIT path too, not just at creation.

**Reference / diagnosis (2026-07-03):** (a) vertical-pipe direction — `GeometryHelper.GetAbovePerpendicularAngle` vertical fallback + `TextService.CalculateResolvedInvertAnchorPoint`/`GetInvertPerpendicularDirection` (~lines 652-678) push "Bottom" the wrong way for near-vertical pipes; (b) clash-avoidance (`PipeCreationService.DetectPreferredInvertPosition`) only runs at CREATE time, never re-checked when the user edits/toggles. Filed from Tim's CD-smartify field report.

**Status:** IN PROGRESS (2026-07-03) — CODED, 71/71 targeted tests green on net48, awaiting Tim's AutoCAD confirm. Root cause was the rotated-text FOOTPRINT attachment (not the anchor); fix derives the attachment corner from the true perpendicular. Edit-path clash re-check added. See REGRESSION_LOG.md "BUG-075". (Follow-up: XCIVIL import path still on legacy table.)

## BUG-076

**Command / Area:** `CD` dialog — upstream→downstream live suggestion

**Symptom (gap):** Changing the upstream (first) invert doesn't offer a suggested downstream (second) invert + fall; the user works it out by hand.

**Expected behaviour:** On upstream change, suggest downstream + fall. Tim's ruling (2026-07-03): MIX of "apply standard grade for the DN over the drawn length" and "keep the current fall" — i.e. if a fall is already set, hold it and re-base downstream from the new upstream; otherwise default to the standard/min grade for the pipe size. Builds on the BUG-073 preview wiring.

**Reference:** `Modules/Drainage/ViewModels/CdViewModel.*` + the grade-suggestion engine (`CdCommand.GradeSuggestion.cs`). Parked during CD-smartify field report (2026-07-03).

**Triage 29 Sep (release chat 04): fix found in code, ad285577 (UpstreamDownstreamSuggest), present in the installed Civil 3.0.13. Status stays open until a Codex/Tim check confirms it in AutoCAD; queued for Codex pass 18.**

**Status:** OPEN (2026-07-03) — building alongside/after BUG-075.

## BUG-077

**Command / Area:** `CD` — pit inlet→outlet drop propagated down the system

**Symptom (gap):** As you work down a run, the small drop between a pit's inlet invert and outlet invert (Tim's example: 5mm) isn't carried down the system automatically — the user re-establishes it each pit.

**Expected behaviour:** Detect the inlet→outlet drop used by the upstream pit(s) in this system and continue it downstream automatically; if there's no upstream pit to learn from, fall back to a configurable default (5mm). Tim's rulings (2026-07-03): (1) on a DIAMETER INCREASE keep the SAME small invert drop (NOT obvert/soffit matching); (2) base drop = "detect upstream, else default". Make it hands-off for the user (auto-applied, editable). Builds on BUG-076's upstream→downstream engine.

**Reference:** `Modules/Drainage/ViewModels/CdViewModel.*` + grade-suggestion engine + a settings-backed default drop (add to UserSettings, default 5mm). Filed from Tim's CD-smartify field report (2026-07-03).

**Status:** IN PROGRESS (2026-07-03) — CODED incl. wiring (pure `PitDropResolver` 12/12 green + `PitInvertDropMm` setting + `ApplyPitDropIfKnown` in BuildSuggestionContext), net48 0 errors, awaiting Tim's AutoCAD confirm. Junction pits use first inlet (schedule convention). See REGRESSION_LOG.md "BUG-077".

## BUG-078

**Command / Area:** `CDEDIT` — can't move invert (IL) text above/below on an already-drawn pipe

**Symptom:** After a pipe is drawn, CDEDIT does not let Tim move the invert text above or below — the above/below choice appears to have no effect on edit.

**Expected behaviour:** Toggling above/below in CDEDIT re-places the invert text on the chosen side (using the corrected placement geometry from BUG-075).

**Reference:** likely `PipeEditCommand` invert path and/or the CdViewModel FirstInvertIsAbove/SecondInvertIsAbove handling in edit mode. Investigate precisely after BUG-076 lands (its agent is editing CdViewModel now) to avoid a file clash. Filed from Tim's CD-smartify field report (2026-07-03).

**Status:** IN PROGRESS (2026-07-03) — CODED, root cause = BUG-075's clash-recheck didn't exclude the pipe's own sibling annotations (self-clash on short pipes flipped the toggle back); fix excludes them + prompt cleanup. 4 new pure tests green (37/37 fixture), net48 0 errors, awaiting Tim's AutoCAD confirm. See REGRESSION_LOG.md "BUG-078".

## BUG-079

**Command / Area:** `CDFALL` — `Modules/Drainage/Commands/FallCommand.cs` + `BlockService` (FALL SYMBOL block)

**Symptom:** Placing a pavement fall block with CDFALL messes up: it OVERWRITES the FALL SYMBOL block and displaces the block's INTERNAL text (the FALL / FALL_GRADE attribute text ends up in the wrong location inside the block).

**Expected behaviour:** CDFALL inserts a FALL SYMBOL at the pick with correct orientation and grade, WITHOUT redefining/overwriting an existing drawing-local FALL SYMBOL block or shifting its internal attribute text.

**Reference / first-pass diagnosis (2026-07-04):** `FallCommand.cs` inserts `BlockService.BLOCK_FALL` ("FALL SYMBOL"), then `SetAttribute("FALL"/"FALL_GRADE")`, then `BlockService.ApplyFallBlockOrientation` (dynamic block). Two suspects: (1) `BlockService.InsertBlock` likely REDEFINES the block from the shipped source DWG on every insert (same pattern as the pit blocks), clobbering any drawing-local FALL SYMBOL and resetting internal attribute/text positions; (2) the dynamic-block orientation step (`ApplyFallBlockOrientation`) or the SetAttribute writes displace the internal text (note the existing guard comment in FallCommand ~line 112 about applying orientation AFTER SetAttribute so attribute writes "cannot reset the block's internal dynamic state" — the fragility is known). Investigate whether InsertBlock should reuse an existing block definition instead of redefining, and whether the source FALL SYMBOL.dwg's attribute positions are correct.

**Confirmed diagnosis (2026-07-06, code trace):** First-pass suspect (1) — reimport/redefine on every insert — is **RULED OUT**. `GetBlockNameVariants("FALL SYMBOL")` has no variant and `ShouldReloadPreferredBlock`/`IsPreferredBlockFile` return false for FALL (only PIT BLOCK 3 / PIT LABEL 2 / Pit Schedle / TIM_CVL_ARROW force-reload), so once FALL SYMBOL is in the drawing it is NOT re-read from the source DWG. **Actual root cause:** `EnsureBlockDefinition` calls `ApplyDefinitionPatches` → `PatchFallSymbolBlockDefinition(db)` on EVERY insert (`BlockService.cs` ~L299/L322/L363; def ~L426–L484). That BUG-012 patch edits the FALL SYMBOL **block DEFINITION's** AttributeDefinitions (forces `HorizontalMode=TextLeft`, sets `AlignmentPoint=Origin`, snaps `FALL_GRADE.X` to `FALL.X`); `ApplyFallBlockOrientation` (~L973) then calls `SyncBlockAttributesFromDefinition` which re-derives the placed reference from that mutated shared definition. Mutating the shared definition shoves every FALL SYMBOL's internal FALL/1:80 text — exactly the "overwrites the block + moves internal text" report. Full trace: `CE_ACAD_PLUGIN/docs/HANDOFF_2026-07-06.md`.

**Tim's ruling (2026-07-06):** **Option 1 (preserve the drawing's FALL block as-is) FIRST** — stop CDFALL rewriting the block's internal text layout at drop-time (gate/remove `PatchFallSymbolBlockDefinition` from the FALL path; if 1:80 justification is still wanted, bake it once into the master `FALL SYMBOL.dwg` at `C:\Lisp Files\`, not at runtime). Fall back to **Option 2 (force-reimport the shipped master)** only if Option 1 doesn't hold up. Trade-off Tim accepted: removing the runtime patch regresses BUG-012 (left-justify) unless the master DWG is correct.

**REOPEN / real root cause (2026-07-06, DXF evidence — SUPERSEDES the ruling above):** Option 1 (preserve-first) shipped but was NOT enough — CDFALL into a BRAND-NEW drawing still came out wrong (FALL and "1:80" OVERLAPPING on one line). Comparing the master `FALL SYMBOL.dwg` against a CDFALL-inserted result, both exported to DXF, shows the master is now **CORRECT**: FALL at Position (-460, 59.209), FALL_GRADE at (-460, -259.35) — two separate left-justified lines (no group-72). After insert, the in-drawing definition is **corrupted**: both attributes at X≈0 and BOTH at Y=59.209 (grade dragged up onto FALL). Cause = `PatchFallAttributeDefinition` setting `AlignmentPoint = Point3d.Origin` + `HorizontalMode = TextLeft` re-anchors the attributes to the origin and the X collapses. So the BUG-012 patch is now **obsolete AND harmful** — the master is authoritative and correct, and the patch mangles it. Option 1 only stopped the patch for `AlreadyInDrawing`; it still ran on `FreshlyImportedFromMaster` / `ReloadedFromMaster`, re-breaking the master on every fresh import.

**Fix (2026-07-06):** `FallPatchPolicy.ShouldPatch(FallDefinitionOrigin)` now returns `false` for ALL origins — the patch never runs. `PatchFallSymbolBlockDefinition` is left in `BlockService.cs` but is now dead code (never invoked); the block-insertion + rotation logic (`OrientFallBlock` etc.) is untouched. The inserted FALL SYMBOL keeps the master's attribute positions exactly. Test `Modules/Drainage.Tests/Helpers/FallPatchPolicyTests.cs` rewritten (4/4 pass, RED→GREEN); full Drainage suite 3515/0/13 green (net10, `-p:SkipDevBundle=true`).

**PURGE NOTE for Tim:** a drawing that already contains the previously-corrupted FALL SYMBOL keeps reusing that bad copy (`AlreadyInDrawing` path is not touched). To see the fix in such a drawing, PURGE the FALL SYMBOL block and re-insert, or test in a new drawing. **NEEDS TIM (optional, not done):** make FALL SYMBOL reload-from-master on insert (like PIT BLOCK 3) so existing drawings self-heal — left out because it would overwrite legitimate per-drawing edits on every drop.

**29 Sep (Sonnet 5.5): the stranded July BUG-079 FALL rounds 1-8 landed as PR #370 (stacked on #367).** CDFALL now inserts FALL SYMBOL 2 (old FALL SYMBOL still recognised); arrow follows the drag with no 180-degree reversal; left-pointing falls use the block flip so text stays readable; drags within 3 degrees of E/N/W/S snap; one text-patch path that never writes the alignment point. CDCHECK arrow read-back and the slab re-apply scan updated to match. Full Civil net10 12,289 passed / 5 known. Banked; needs a Codex visual check of all 8 drag directions and a slab with falls. Open for Tim: should CDSLAB also let the block evaluate itself (July finding) - left unchanged.

**Status:** FIXED IN CODE — latest is **ROUND 8** (2026-07-07): near-cardinal drags now SNAP to the exact cardinal (E/N/W/S) within ~3°, so roughly-straight drags no longer wobble across the due-South/due-North text-flip boundary and insert inconsistently. Diagonals never snap. Round 7 (flip reverses the ARROW, Angle1 pre-compensated for the left half + due-South) remains the orientation baseline. Branch `claude/vigorous-wilson-7e7e91`. NOT deployed; awaiting Tim's AutoCAD confirm (drag roughly-straight-down repeatedly → same result every time; diagonals unaffected). See the round-7 and round-8 details below + REGRESSION_LOG "BUG-079 (round 8)" / "(round 7)" for the checklists. (Earlier rounds' status lines retained below for history.)

**ORIENTATION + TEXT-REGEN FOLLOW-UP (2026-07-06, from a field recording of the deployed CDFALL):** two more CDFALL defects, separate from the block-overwrite half above:
1. **Arrow points 180° OPPOSITE the drag.** User dragged the fall direction to the LOWER-RIGHT (SE ≈ 315°); the placed arrow pointed UP-LEFT (NW ≈ 135°) — an exact reversal. **Root cause:** `FallCommand.cs` added `+ Math.PI` to the picked bearing ("point away from the pick"), contradicting the confirmed design (ARCHITECTURE_UPGRADE_PLAN.md Track 0: "pick direction to the RIGHT → arrow points right" — the drag IS the arrow bearing). A drifted cardinal table in `ComputeFallDynamicParams` compounded it. **Fix:** removed the `+π` in `FallCommand`; rewrote `ComputeFallDynamicParams` to the confirmed spec — arrow bearing in [0°,180°) → `(Angle1=bearing, Flip 0)`; in [180°,360°) → `(Angle1=bearing−180°, Flip 1)` (flip only for readable text; block convention: Flip 1 → arrow = Angle1−180°). Locked with `Modules/Drainage.Tests/Services/FallDynamicParamsTests.cs` (E/N/W/S + 4 diagonals).
2. **FALL_GRADE ("1:80") text mispositioned until Block-Editor open/close.** The bottom grade text only landed correctly after the user opened+closed the Block Editor (a regen). **Root cause:** setting Angle1/Flip State1 via the API does not immediately rebuild the dynamic block's anonymous representation, so `SyncBlockAttributesFromDefinition` read STALE (pre-flip) attribute positions. **Fix:** added `RegenBlockReference` (mark dirty + `Editor.Regen()`) BEFORE the sync so it reads the re-evaluated flipped geometry — the same effect as the Block-Editor step; `FlipAttributeRotations` now runs LAST so its readable rotation is not clobbered. Preserves user-entered TextStrings.

**Follow-up status:** FIXED IN CODE (2026-07-06), branch `claude/vigorous-wilson-7e7e91`. FALL unit tests green on net10 (156/0). The runtime regen/flip behaviour is finicky AutoCAD-runtime — **NEEDS TIM's AutoCAD field test** (see REGRESSION_LOG "BUG-079 orientation + text-regen" checklist). NOT deployed.

**FOLLOW-UP — ROUND 3 (2026-07-07, from Tim's field test + a reference symbol he supplied):** two remaining defects. (a) For FLIPPED (downward/left) directions the grade "1:80" was thrown to the TOP of the symbol instead of below the fall line (field case: down-right drag ~333°, Angle1=153.239°, Flip=Flipped). (b) The text was forced HORIZONTAL — per Tim's reference it must run PARALLEL to the arrow (tilt WITH the fall direction), left-justified, both texts anchored at the arrow's TAIL, FALL above / grade below, readable. **Root causes:** (a) Flip State1 mirrors the geometry vertically, negating each attribute's BCS Y — so FALL (+59, above) and FALL_GRADE (−259, below) SWAP; `SyncBlockAttributesFromDefinition` reads the mirrored geometry. (b) `ComputeReadableFallTextRotation` returned only 0/π, which `FlipAttributeRotations` wrote as the WCS rotation → horizontal. **Fix:** (a) added `ComputeFallAttributePosition` (pure) — WCS position by PURE ROTATION of each attribute's DEFINITION BCS anchor about the bearing (never the flip), so FALL stays above / grade below AND both keep the shared tail-start X, for all 8 dirs; `PlaceFallAttributesRelativeToArrow` writes those onto the references LAST (writes ONLY `.Position` — preserves left-justification / tail anchor; avoids the ca4f5aad (0,0,0) wipe since defs are left-justified per BUG-012; re-reads + warns if not stuck). (b) rewrote `ComputeReadableFallTextRotation` → returns the bearing (text parallel to the line), +180° only in the left half (90°,270°) so it's not upside-down, NEVER horizontal-snapped. Locked with `FallAttributePositionTests.cs` (8 dirs above/below + 333° case) and rewritten `FallBlockOrientationTests.cs` (8 dirs: rotation parallel-to-bearing AND readable; 333° tilts, not horizontal).

**Round-3 status:** FIXED IN CODE (2026-07-07), branch `claude/vigorous-wilson-7e7e91`. FALL suite green on net48 (53/53). **NEEDS Tim's AutoCAD field test** — place a fall in all 8 directions; for each verify: text TILTS with the arrow (parallel, never horizontal); "FALL" above the line, "1:80" directly below; both left-justified and starting at the arrow tail; both read left-to-right (see REGRESSION_LOG "BUG-079 follow-up round 3" checklist). NOT deployed. (net10 not runnable on this dev box — no autocad-2027-ref DLLs.)

**FOLLOW-UP — ROUND 4 (2026-07-07, decisive new field evidence):** on the deployed build the fall symbol rendered WRONG on insert, but after the user did `BEDIT` then `BCLOSE` it snapped to CORRECT on its own — FALL/1:80 tilted parallel to the arrow, stacked at the arrow TAIL, FALL above / grade below, readable, arrow correct. i.e. **the block's OWN dynamic re-evaluation (what BEDIT/BCLOSE forces) produces the correct layout.** This proves the round-1..3 manual attribute overrides were FIGHTING the block: they read its half-evaluated anonymous geometry and wrote their own positions/rotations on top, causing the stale/wrong insert render that only self-corrected after the manual Block-Editor cycle. **Fix:** `ApplyFallBlockOrientation` now keeps only the (confirmed-correct) arrow params (`ComputeFallDynamicParams` → Angle1/Flip State1) and then calls a STRENGTHENED `RegenBlockReference` (`RecordGraphicsModified` + `QueueForGraphicsFlush` + full `Editor.Regen()`) to force the block's own BEDIT/BCLOSE-equivalent re-evaluation + graphics rebuild on insert. The three manual overrides + their pure helpers (`SyncBlockAttributesFromDefinition`, `FlipAttributeRotations`, `PlaceFallAttributesRelativeToArrow`, `ComputeReadableFallTextRotation`, `ComputeFallAttributePosition`, `FallAttributePerpendicularOffset`) are DELETED (git preserves them as the fallback); `ComputeFallDynamicParams` (arrow direction) is KEPT. `FallAttributePositionTests.cs` deleted; `FallBlockOrientationTests.cs` rewritten to guard the new wiring (must call RegenBlockReference; must NOT re-add the overrides). CDSLAB shares `ApplyFallBlockOrientation` — unchanged signature, benefits too.

**Round-4 status:** FIXED IN CODE (2026-07-07), branch `claude/vigorous-wilson-7e7e91`. Full Drainage.Tests suite green on **net10** (3541/0/13), Drainage plugin net10 builds 0 errors, `-p:SkipDevBundle=true`. **NEEDS Tim's AutoCAD field test — the crux is that the symbol must render CORRECTLY ON INSERT with NO Block-Editor step** (place falls in all 8 directions → FALL above / grade below / tilted parallel to arrow / at tail / readable, immediately; also confirm CDSLAB fall arrows). See REGRESSION_LOG "BUG-079 follow-up round 4" checklist. NOT deployed.

**ROUND 5 — switch CDFALL to the new "FALL SYMBOL 2" block (2026-07-07):** Tim rebuilt the fall block from scratch as **FALL SYMBOL 2** (`C:\Lisp Files\FALL SYMBOL 2.dwg`) to be the authoritative, correct master, replacing the old "FALL SYMBOL". Wired CDFALL to prefer it, mirroring the sanctioned PIT BLOCK 3 pattern: `GetBlockNameVariants("FALL SYMBOL")` → `{ "FALL SYMBOL 2", "FALL SYMBOL" }`; `IsPreferredBlockFile` prefers `FALL SYMBOL 2.dwg`; `ResolveInsertedBlockName` therefore imports it under the name "FALL SYMBOL 2" so a fresh CDFALL inserts the new block while old "FALL SYMBOL" drawings still work. Confirmed FALL SYMBOL 2's dynamic params from its DXF: rotation **"Angle1"** (exact) and flip **"Flip state1"** (lowercase 's' — updated the SetDynamicProperty call; match was already case-insensitive); attribute tags FALL / FALL_GRADE present. `ApplyFallBlockOrientation` / `ComputeFallDynamicParams` maths UNCHANGED (round-4 version preserved). Shipped the DWG into `Installer/source_blocks/FALL SYMBOL 2.dwg` (single source copied by installer + dev-bundle step; old FALL SYMBOL.dwg kept alongside). Tests: new `FallSymbolVariantTests.cs` (6) + updated `BlockShippingTests.cs`; full Drainage.Tests green net10 **3546/0/13**, 0 build errors, `-p:SkipDevBundle=true`.

**Round-5 status:** FIXED IN CODE (2026-07-07), branch `claude/vigorous-wilson-7e7e91`. NOT deployed; awaiting Tim's AutoCAD confirm. **FIELD-TEST RISK:** the arrow-bearing/flip convention is ASSUMED identical between old and new block — could not be mechanically proven (no old DXF to diff, no AutoCAD here); maths left untouched. Test all 8 directions specifically — if arrows point 180° wrong or mirror, it's a block-authoring/convention mismatch, not the name wiring. See REGRESSION_LOG "BUG-079 (round 5)" checklist.

**ROUND 6 — readability-only flip + unambiguous insert log (2026-07-07, from Tim's FALL SYMBOL 2 field test):** (a) Dragging DOWN-RIGHT (~315°, SE) placed the arrow correctly but the FALL / "1:80" text was UPSIDE-DOWN. Root cause: the round-4 `ComputeFallDynamicParams` folded Angle1 into [0,180°] and set Flip=1 for ALL bearings in [180,360°) to point the arrow — that flip turned the down-right text upside-down. Tim confirmed FALL SYMBOL 2's flip is for READABILITY ONLY and its rotation supports 360°. **Fix:** rewrote `ComputeFallDynamicParams` — `Angle1 = bearing` (full 360°, arrow follows drag directly); `FlipState = 1` ONLY when bearing ∈ (90°,270°) (left half, text would be upside-down), else 0. Down-right 315° now = (315°, 0), readable. Rewrote `FallDynamicParamsTests` to this convention (47/47 FALL tests green, net10). (b) The CDFALL command-line log read `Block Insert: name=FALL SYMBOL` even though FALL SYMBOL 2 is inserted — it printed the LOGICAL request name, not the resolved reference name. Confirmed via code trace the insert IS genuinely FALL SYMBOL 2 (`EnsureBlockDefinition`→`ResolveInsertedBlockName` resolves the variant; the reference is built from that ObjectId). **Fix:** the log now prints `requested=… inserted={blockRef.Name}` (new `ResolveBlockRefName` helper) in both `InsertBlock` overloads + jig insert. **DXF finding:** `FALL SYMBOL 2.dxf` `AcDbBlockRotationParameter "Angle1"` angle-max (group 142) = 2π = 360°, snap (175) = 0 → Angle1 accepts a full circle, so `Angle1 = bearing` is not clamped.

**Round-6 status:** FIXED IN CODE (2026-07-07), branch `claude/vigorous-wilson-7e7e91`. NOT deployed; awaiting Tim's AutoCAD confirm. **FIELD-TEST RISK:** fix assumes Angle1 accepts 0–360° (DXF confirms). If a future block edit range-limits Angle1 to [0,180°], upper-half arrows (N/NW/W/SW/S) would point wrong — a BLOCK fix (re-open rotation to 360°), not code. Test all 8 directions: arrow follows drag AND text readable (never upside-down); down-right (SE) specifically must read normally. Command line should show `inserted=FALL SYMBOL 2`. See REGRESSION_LOG "BUG-079 (round 6)" checklist.

**ROUND 7 — flip reverses the ARROW, not just the text (2026-07-07):** Tim updated FALL SYMBOL 2 so its Flip parameter flips the text; field-testing all 8 directions proved Flip=1 ALSO reverses the arrow (renders at Angle1+180°), not text-only as round 6 assumed. So NW/W/SW came out 180° backwards and due-South's text never flipped. **Fix:** rewrote `ComputeFallDynamicParams` — bearing ∈ (90°,270°] → `((bearing+180°)%360°, 1)` (pre-compensate 180° so the flip's reversal lands the arrow back on the true bearing, text readable); else `(bearing, 0)`. Boundary EXCLUSIVE at 90° (due-North no flip), INCLUSIVE at 270° (due-South now flips). 8-dir table: E 0°→(0°,0) NE 45°→(45°,0) N 90°→(90°,0) NW 135°→(315°,1) W 180°→(0°,1) SW 225°→(45°,1) S 270°→(90°,1) SE 315°→(315°,0). `FallDynamicParamsTests` rewritten (42/42 green net10).

**Round-7 status:** FIXED IN CODE (2026-07-07), branch `claude/vigorous-wilson-7e7e91`. NOT deployed; awaiting Tim's AutoCAD confirm. Test all 8 dirs: arrow follows drag (NW/W/SW no longer backwards) AND text readable (due-South now flipped). See REGRESSION_LOG "BUG-079 (round 7)" checklist.

**ROUND 8 — snap near-cardinal drags so the text-flip is consistent (2026-07-07, from Tim's field report):** With round-7 orientation correct for all 8 directions, dragging **roughly straight down** (or up) still gave inconsistent results — tiny mouse wobbles landed the bearing on either side of the due-South (270°) / due-North (90°) flip boundary, so two near-identical straight-down drags could flip the text differently ("inserts the other way"). **Fix:** added pure helper `SnapFallBearingToCardinal(bearing, toleranceRad)` in `BlockService.cs` — normalises to [0,2π); if within tolerance of a CARDINAL (E=0, N=π/2, W=π, S=3π/2, with 0/2π wrap handled) returns that exact cardinal, else returns the bearing unchanged. The 45° diagonals are NOT cardinals, so they never snap. `FallCommand` calls it with tolerance = 3° right after computing the bearing, before `ApplyFallBlockOrientation` — so ~269° and ~271° both resolve to exactly 270°, one consistent result. New `SnapFallBearingToCardinalTests.cs` (269/271/268/267.5→270, 266→266, 88/92→90, 181→180, 359.5→0 & 0.5→0 wrap, diagonals unchanged, 250→250). Full FALL filter 179/0 green net10, plugin 0 errors, `-p:SkipDevBundle=true`.

**Round-8 status:** FIXED IN CODE (2026-07-07), branch `claude/vigorous-wilson-7e7e91`. NOT deployed; awaiting Tim's AutoCAD confirm. **What to test:** drag roughly-straight-down repeatedly (wobbling slightly) → same insert every time; same for up/left/right; a clear diagonal (~315°/~135°) must NOT snap (arrow follows the diagonal); an off-cardinal non-diagonal (~250°) must NOT snap. **Trade-off:** a drag intended as, say, 272° will be pulled to 270° — adjust `CardinalSnapToleranceRad` in `FallCommand` if finer near-cardinal control is wanted. See REGRESSION_LOG "BUG-079 (round 8)" checklist.

## BUG-080

**Command \ Area:** `CDEDIT` vs auto-design (`AutoDesignService.SizeConnectionPipe`) — the same UPVC pipe is allowed two different maximum velocities

**Symptom:** A UPVC pipe sized in CDEDIT is held to a **3.0 m/s** scour ceiling. The very same UPVC pipe sized by auto-design's connection/inlet pipe step is held to **6.0 m/s** — auto-design hardcodes the material as UPVC but never asks the material table, so it falls back to the generic default. Because a higher ceiling lets a smaller pipe "pass", auto-design can hand back a **smaller diameter** than CDEDIT would for identical flow and material. Nothing warned that the two disagree.

**Expected behaviour:** One material, one ceiling, everywhere — a UPVC pipe should be judged against the same maximum velocity no matter which command sizes it.

**Reference:** `Modules/Drainage/Services/AutoDesignService.cs` (`SizeConnectionPipe` — sizes against `PipeSizingStandards.CreateDefault()`, i.e. `UnverifiedDefaultMaxVelocityMs` = 6.0, while setting `Material = "UPVC"`) vs `Modules/Drainage/Services/MaterialVelocityLimits.cs` (`GetMaxVelocityMs("UPVC")` = 3.0). Found 2026-07-17 during the clean-slate §6.6 item 9 audit.

**BLOCKED ON TIM — this is an engineering decision, not a coding one.** Both 3.0 and 6.0 are UNVERIFIED placeholders that have never been checked against AS/NZS 3500 / AS 2200. Making them agree today means choosing which guess wins, which would silently change what pipe sizes the plugin recommends on real jobs. Tim's ruling 2026-07-17: **leave both numbers, flag the clash.** Both paths now carry the "velocity limit unverified" advisory, so neither can be mistaken for authoritative while this stands. Resolve it when Tim supplies the confirmed AS/NZS values — at which point it collapses into the same one-place change as the rest (replace the numbers, flip `MaterialVelocityLimits.AreScourLimitsVerified` to `true`). Do NOT "tidy" it by routing auto-design through `MaterialVelocityLimits` in the meantime — that is exactly the silent engineering change this bug exists to prevent.

**Status:** OPEN — deliberately deferred, awaiting Tim's AS/NZS values. See REGRESSION_LOG.md "CLEAN-SLATE §6.6 item 9".

## BUG-056

**Command / Area:** `CDRUNSOLVE` (monorepo `Modules/Drainage`)

**Symptom:** On a real project whose private drainage system discharges into an EXISTING council
line (e.g. P1 → C1 → existing council stub at approx IL 16.61 → existing 375 pipe → council pit X1),
CDRUNSOLVE fails at the preview stage: "Could not solve this run — Pit 'C1' has no known invert
level to anchor the run on." It doesn't know where our system ends and the council system begins.

**Expected behaviour:** The solve should anchor on the council connection's known IL (the 16.61)
and work every upstream invert/grade back from there; the discharge pipe must be part of the run;
existing/council pipes must never be re-graded/re-sized by the proposal.

**Reference / diagnosis (2026-07-03, parallel session — full detail in that session's investigation):**
- `ProposalApplyService.WalkDownstreamRun` (`Modules\Drainage\Services\ProposalApplyService.PlanBuilders.cs:381-408`)
  breaks BEFORE adding a pipe whose `To` is blank — the terminal discharge pipe (downstream end on
  the council line resolves to `To=""`) is silently dropped from the run.
- `BuildRunInputs` (`PlanBuilders.cs:419-494`) then anchors on the last walked pit's free-text
  `InvertLevel` (usually blank → the error above; if filled, the solve "succeeds" while ignoring
  the council IL — silently wrong).
- Existing pipes ARE representable (`PipeType.ExistingPipe`, ProjectData `Material="EXISTING"`),
  but pits/GIO connection blocks have no existing/council concept; the long-section tool already
  treats an ExistingPipe at the run end as an external connection with its recorded invert
  (`LongitudinalSectionViewModel.cs:465-509`) — reusable precedent.
- Agreed fix shape (not built): (1) walk keeps the terminal pipe + terminal metadata; (2) auto-anchor
  on a touching `Material=="EXISTING"` stub's recorded invert; (3) prompt fallback "pick the
  connection point + type its fixed IL" when detection fails; (4) hard guard: no plan changes ever
  emitted for existing-material pipes. Failing-test names sketched:
  `WalkDownstreamRun_TerminalPipeHasBlankTo_FinalPipeIsNotSilentlyDropped`,
  `BuildRunInputs_RunEndsAtExistingCouncilStub_AnchorsOnStubInvertNotPitInvert`,
  `BuildRunInputs_ExplicitAnchorProvided_UsesIt`, `BuildRunSolvePlan_ExistingMaterialPipe_ProducesNoChanges`
  (fixture precedent: `ProposalApplyServiceTests.cs:215-361`).
- Open engineering questions for Tim: invert-to-invert vs obvert match at the connection; drop
  across the connection (0 vs 30mm-style); detention pipes (450 DIA storage-sized) — hold diameter,
  solve inverts only?; how the connection is marked in drawings (EX pipe stub / GIO block / linework).

**Status:** OPEN (Tim handling outside the parallel session)

---

## BUG-057

**Command / Area:** `CDDASHBOARD` → filter Errors → "⚒ Propose fixes for all…" (monorepo `Modules/Drainage`)

**Symptom:** During TIM_CHECKLIST Part 2 testing (2026-07-03) Tim reported the preview→apply→undo
mechanics WORK, "but some of the logic is incorrect" — i.e. at least one category of proposed fix
computes a wrong value or wrong resolution.

**Expected behaviour:** Every proposed fix in the preview table must be engineering-correct before
apply is trusted.

**Reference:** First step is capturing from Tim WHICH proposals were wrong (pit/pipe + proposed vs
correct value, or a screenshot of the preview table). No diagnosis yet.

**Status:** OPEN (Tim handling outside the parallel session)

---

## BUG-053

**Command / Area:** `CE_CVL_SUITE` — `CompoundBoundsOverrule` (the Civil suite's "compound bounds" `DrawableOverrule`). Triggers whenever the Civil suite is loaded **and** Compound Behaviour is effectively ON. This is a CE_CVL bug — CE_STRUC was investigated and ruled out.

**Symptom (AutoCAD terms):** AutoCAD 2027 crashes (hard close → Autodesk Customer Error Report) while working on xref-heavy / roof drawings. Recurring — 5 crash reports in 5 days (19 Jun, 22 Jun ×2, 23 Jun ×2 2026). The 23 Jun 13:09 crash (the only one with a full diagnostic payload) was on `X26-01_Roof - Stage 1.dwg` (a roof xref in job 26-01). It fires during AutoCAD's own `OBJRELUPDATEALL` command (AutoCAD runs this itself — e.g. around xref reload/compare — to refresh every object's reactors/associativity). Crash signature: `ACCESS_VIOLATION (0xC0000005)` read, faulting module `acdb26.dll`.

**Root cause (high confidence — exact API match):** `CompoundBoundsOverrule` is a `DrawableOverrule` registered on **every BlockReference** (`PluginInitialization.cs:107-117` → `Register()` → `Overrule.AddOverrule(RXClass.GetClass(typeof(BlockReference)), …)`, `Overrule.Overruling = true`). Its `WorldDraw` runs during regen/redraw, which `OBJRELUPDATEALL` triggers across all objects. For a registered CE compound block (e.g. a DOWNPIPE on a roof plan), `WorldDraw → IsCircleSourceBlock` reads **`blockRef.Name`** at `CompoundBoundsOverrule.cs:220`. Reading a DBObject property while AutoCAD has the object open-for-write (which it is, mid-`OBJRELUPDATEALL`) throws `eWasOpenForWrite` — and the crash report's managed first-chance exception is exactly `Autodesk.AutoCAD.Runtime.Exception: eWasOpenForWrite at Autodesk.AutoCAD.DatabaseServices.BlockReference.get_Name()`. On .NET 10, this reentrant acdb access from an overrule's graphics-flush path corrupts native state → AV in `acdb26.dll`. Confirmed live: `CD_Settings.json` has `"compoundBehaviorEnabled": true`, so the early-out at `CompoundBoundsOverrule.cs:183` does not fire and the `.Name` path is live. CE_STRUC ruled out: it has zero overrules, and its structured log shows only JobTime idle-ticks (no commands, no reactor work, zero warnings/errors) for the 2 minutes before the crash. Same bug FAMILY as Civil's earlier `BLK-009`/`BLK-011` audit fixes; `BLK-011` removed the transaction + `PLOTTINGSTATE` poll from `WorldDraw` but left the `.Name` (and `.IsDynamicBlock` / `.DynamicBlockTableRecord`) reads in `IsCircleSourceBlock`.

**Expected behaviour:** Civil's faint dashed compound-bounds box renders without ever crashing AutoCAD — including during `OBJRELUPDATEALL` / regen on xref + AEC drawings.

**Fix direction (do in a CE_CVL session — its own build/deploy/tests/carpark):**
1. Remove ALL DBObject property reads from `CompoundBoundsOverrule.WorldDraw` / `IsCircleSourceBlock` — do not read `blockRef.Name`, `.IsDynamicBlock`, or `.DynamicBlockTableRecord` in `WorldDraw`. Decide "is this a circle source block?" from the pre-built per-database cache only (keyed by handle/ObjectId, populated on `DocumentActivated` / deferred from `ObjectModified` — the same pattern `LinkService.IsCeCompoundBlock` already uses safely). Store an `IsCircle` flag alongside the cached pit/source positions so `WorldDraw` is a pure cache lookup + geometry draw.
2. Fix the fail-open default: the six `?? true` sites (`CompoundBoundsOverrule.cs:183`, `CompoundTransformOverrule.cs:74`, `CompoundGripOverrule.cs:68/89`, `CompoundSelectionService.cs:99`, `CompoundEditModeService.cs:121`) read `CompoundBehaviorEnabled ?? true`, but `UserSettings.CompoundBehaviorEnabled` defaults to **false** (`UserSettings.cs:348`). If settings ever fail to load, the overrules turn ON. Change to `?? false` to honour the default-off.
3. Audit the other overrules for property reads inside their callbacks: `CompoundTransformOverrule` (on `Entity` — every entity!), `CompoundGripOverrule` (Mline), `PipeDrawableOverrule`, `PipeOsnapOverrule`.
4. Add a source-inspection guard test (like the existing `AuditPhase23GuardTests` BLK-011 test) asserting `WorldDraw`/`IsCircleSourceBlock` contains no `.Name` read.

**Immediate stopgap (no rebuild):** set Civil's Compound Behaviour OFF — `"compoundBehaviorEnabled": false` in `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` with AutoCAD closed, or via the Civil settings UI. Trade-off: hides the dashed compound-bounds box + compound pit/pipe grouping until the fix ships. Also: a **Debug** build of CE_CVL + CE_SHARED is currently deployed (net10) — worth replacing with Release.

**Reference:** `CE_CVL_SUITE/Services/CompoundBoundsOverrule.cs` (`WorldDraw` ~174, `IsCircleSourceBlock` ~217-236, `.Name` read line 220, settings gate line 183), `CE_CVL_SUITE/Services/LinkService.Compound.cs:243` (`IsCeCompoundBlock` — the safe cache pattern to copy), `CE_CVL_SUITE/Models/UserSettings.cs:348` (default false), `CE_CVL_SUITE/CE_CVL_SUITE/PluginInitialization.cs:107-117` (overrule registration). Crash report: `C:\Users\TimothyBrand\AppData\Local\Autodesk\CER\6d903fba…\1782184142524` (23 Jun 13:09). CE_STRUC structured log `ce_struc_structured_20260623.log` clears CE_STRUC.

---

**⚠ CORRECTION — REAL ROOT CAUSE (CE_CVL session, 2026-06-23):** The diagnosis above named the wrong code path. `CompoundBoundsOverrule` (and the whole compound suite: Grip/Transform/Bounds/Selection/ContextMenu) is **dead code on every shipped build** — its registration sits inside `if (false)` at `PluginInitialization.cs:113` (introduced in commit `6d304ded`; `PROJECT_STATE.md:21` already noted "DEAD CODE … do NOT chase"). It is never registered, so its `WorldDraw` never runs and cannot be the live crash. The `compoundBehaviorEnabled: true` setting is irrelevant because the overrule isn't registered. The diagnosis checked the setting but not the `if(false)` gate.

The **real live crash** is the same exception in a path that IS registered: `LinkService.OnObjectModified` (the database ObjectModified reactor). For each changed block it called `IsPitBlock(blockRef, db)` → `GetEffectiveBlockName` → reads `blockRef.Name` (and, for dynamic blocks like DOWNPIPE, opens a nested transaction reading `.DynamicBlockTableRecord`). During `OBJRELUPDATEALL` on a roof drawing the DOWNPIPEs are modified with the block held open-for-write → `eWasOpenForWrite at BlockReference.get_Name()` → native AV in `acdb*.dll`. **Proof in our own logs:** `PROJECT_STATE.md:52` records the PERF-003 (16 Jun) session logging `5× [ERROR] LinkService OnObjectModified failed: eWasOpenForWrite at BlockReference.get_Name()`. The only registered overrules are the two Pipe overrules (on Polyline) — neither reads a BlockReference's `.Name`, so the `get_Name()` signature cannot come from them.

**Fix applied (2026-06-23):**
1. **Live fix (stops the crash):** `OnObjectModified`'s BlockReference branch now classifies the block from the `PitPositions`/`SourcePositions` handle caches — no `.Name`/`.IsDynamicBlock`/`.DynamicBlockTableRecord`/`GeometricExtents` reads. Unknown blocks are deferred to `ProcessPendingSourceRegistrations` (command-end, real transaction) which now classifies pits too. This completes the BLK-009 reactor-safety rule for the BlockReference branch.
2. **Overrule hardened (per the brief, latent-safe for re-enablement):** `CompoundBoundsOverrule` is now a pure handle-cache lookup (`LinkService.IsCircleSourceBlockCached` + `TryGetCachedPitExtents` + live `.Position`); the obsolete definition-ObjectId cache (`_circleBlockIds`/`BuildCircleBlockIdCache`) is gone.
3. **Fail-open default fixed:** all six `?? true` sites → `?? false` (the live one is `CompoundEditModeService`).
4. **Audit:** the two LIVE overrules (`PipeDrawableOverrule`, `PipeOsnapOverrule`) read no `.Name` — safe. The gated `CompoundTransformOverrule.IsCompoundRoot` still reads `br.Name`; a warning comment now flags it must go cache-first before re-enabling.
5. **Tests:** 4 new `AuditPhase23GuardTests` BUG-053 guards (reactor has no `IsPitBlock`/`TryGetPitExtentInfo`; overrule has no `.Name`; settings default false; classifier registers pits). Build 0-err net48 + net10; 22/22 guard tests green both TFMs.

**Trade-off (documented):** reactor-time pit *resize* detection was dropped (it required the `GeometricExtents` nested read). A grip-resized pit re-links its pipes on the next cache rebuild / CDEDIT / CDREBUILDLINKS instead of instantly. `CheckHitboxOverlap` uses cached extents until the next rebuild.

**Status:** IN PROGRESS — **DEPLOYED v2.1.11 (2026-06-24)** to the dev bundle (Legacy net48 + Modern net10), layered on Tim's now-committed v2.1.10 batch (master `b6900f9e`). Coded, builds 0-err, guard tests 29/29 green. NOT fixed until Tim confirms in AutoCAD. Do not mark FIXED until the roof/xref drawing runs `OBJRELUPDATEALL` (or an xref reload) without crashing.

---

## BUG-054

**Command / Area:** `REFEDIT` / `REFCLOSE` — in-place external reference (xref) editing, save-back.

**Symptom (AutoCAD terms):** While editing an xref in place and choosing **REFCLOSE → Save**, AutoCAD refuses with: *"Cannot save back changes because objects in the working set reference objects outside of the working set. The Refedit session is still active."* F2 history then shows: *"Errors found in references to other objects: ** Application reference missing: ACAD, to AcDbLinetypeTableRecord."* The edit can't be saved back into the xref. Seen on a **structural** sheet (N16 bars, S01–S05 tabs) that also carries civil bits (DP downpipes). Reported by Tim 2026-06-24; affected user is on the **OLD v2.1.0** plugin.

**Expected behaviour:** REFCLOSE → Save writes the in-place xref edits back without a "reference outside working set" error.

**Hypothesis (needs confirming, NOT yet diagnosed):** The CE link reactor (`LinkService.OnObjectModified` + the `OnCommandEnded` apply phase) has **no REFEDIT awareness** — `REFEDIT`/`REFCLOSE` are absent from every suspend list in `OnCommandWillStart` (only CLEAN/FASTSAVE/UNDO/SAVE/REGEN/TEXTEDIT/COPY-family suspend). So during an in-place xref edit the reactor still fires on working-set objects and the apply phase can modify them (relink, attachment updates, `LayerService.ApplyConfiguredDrawOrderForCommand`), which can introduce a reference (e.g. a linetype/layer that lives in the host, not the working set) → REFCLOSE save-back validation fails with exactly this message. v2.1.0 ALSO predates the `IsCeOwned` foreign-drawing skip (AUD-04a/PL-071, 2026-06-03), so on v2.1.0 the reactor fires even on a non-civil (structural) drawing.

**Likely fix (if confirmed CE-caused):** add `REFEDIT`/`REFCLOSE`/`REFSET` to the reactor's suspend set so CE link processing pauses for the whole in-place-edit session (mirrors the CLEAN/FASTSAVE bulk-suspend). Same family as BLK-009 (the audit already flagged REFEDIT as a danger zone for the reactor).

**Diagnosis progress (2026-06-24):**
- **Q2 ANSWERED — v2.1.11 does NOT fix it** (Tim: "still happening for them on v2.1.11"). So it is NOT just the old version; the IsCeOwned skip didn't help (→ the edited drawing likely HAS CE content, or it's not the reactor at all).
- **New finding:** CE assigns custom linetypes — CE layers use `PolylineLinetype="DASHED"` / `MlineLinetype="HIDDEN"` (`LayerService.cs:67-125`), loaded via `LoadLineTypeFile`/template-WblockClone (`LayerService.cs:395-460`). So a CE pipe/mline inside the xref references DASHED/HIDDEN, which the CE plugin loads into the **host** linetype table → a plausible STATIC cause (object references a host-only linetype across the working-set boundary), distinct from the reactor (dynamic) cause. The reactor-suspend fix would only address the dynamic cause.
- **Still the decisive test (Q1):** does it repro with the CE bundle **renamed/disabled**? Fails anyway → AutoCAD/drawing (linetype baked into the drawing, or pure AutoCAD limitation). Saves fine → it's the live CE reactor → ship the reactor-suspend fix.
- **Q3 still open:** are the edited objects CE (pipes/pits) or structural?

**Reference:** `CE_CVL_SUITE/Services/LinkService.Reactors.cs` (`OnCommandWillStart` suspend lists ~487-522; no REFEDIT), `docs/audit_report.md:80-81` (REFEDIT flagged as a reactor danger zone under BLK-009). Screenshots: 2026-06-24 (REFCLOSE save-back dialog + F2 "Application reference missing: ACAD, to AcDbLinetypeTableRecord").

**Status:** OPEN — reported 2026-06-24, parked pending diagnosis (questions above). Do NOT fix blind; confirm CE-caused + the v2.1.11-vs-2.1.0 behaviour first.

---

## BUG-051

**Command / Area:** `CESHEETS` — Publish Issue (combined-PDF publishing).

**Symptom:** Publishing the combined PDF for a job crashed AutoCAD (the crash surfaced on the next `OPEN`). Autodesk crash report: `ACCESS_VIOLATION` / null read in `styleeng.dll`.

**Root cause:** PDF plotting (`PlotEngine` + `PlotProgressDialog`) was run on a background thread via `Task.Run`. Plotting touches AutoCAD's status-bar tray (UI-thread-bound) and the drawing database, which are main-thread-only → cross-thread exception + corrupted plot/style engine → native crash.

**Fix:** Publishing now runs synchronously on the main thread; added `CeThreadGuard.EnsureMainThread` as a fail-fast backstop in `ExportLayoutsToCombinedPdf`. Also fixed a non-fatal rev-toggle NRE in the publish dialog (BUG-051b). Full detail + test names in `CE_STRUC_SUITE/REGRESSION_LOG.md`.

**Reference:** `CE_STRUC_SUITE/UI/Dialogs/CeSheetsWindow.xaml.cs`, `Services/ExportService.cs`, `Services/CeThreadGuard.cs`.

**Status:** FIXED — 2026-06-15. Coded, NUnit tests green (18/18) on both TFMs. Awaiting Tim's AutoCAD confirmation (do NOT close until confirmed).

---

## BUG-049

**Command / Area:** `CEADS` (also `CEADMINSETTINGS`) — the CE Drafting Standards / settings window.

**Symptom:** Typing `CEADS` (or opening it from the menu) **crashes AutoCAD outright** — AutoCAD closes with no warning. No CE log line is written for the crash (the structured log just shows the plugin re-initialising afterwards). Reproduced live during the v2.0 command review on 2026-06-05.

**Expected behaviour:** `CEADS` opens the Drafting Standards window (layers, material grades, rebar sizes, steel sections) without crashing.

**Reference:** `LayerManagerWindow` / `CeAdminSettings` window. Crash signature matches the managed-exception-escaping-AutoCAD pattern (e0434352h family — same as BUG-001/002/003). Most likely a theme `StaticResource` lookup failing as the window loads — identical class of bug to the Civil suite's Round-12 "Cannot find resource named 'BaseWindowStyle'" crash, which was fixed by switching theme `StaticResource` → `DynamicResource`. Ties into the v2.0 task of aligning CE_STRUC_SUITE theming to CE_CVL_SUITE.

**Status:** OPEN — to be fixed in the v2.0 build (kept as the survivor settings command; see V2_0_CHANGES.md High priority).

---

## BUG-001

**Command / Area:** `C` alias (Copy), Copy Rotate (`CR`), Move Rotate (`MR`)

**Symptom:** The `C` alias only allows a single placement — it exits after the first copy instead of staying active for multiple placements. Copy Rotate and Move Rotate no longer behave the way they did in `COPY ROTATE.LSP`.

**Expected behaviour:** The `C` alias should keep the copy command running for as many placements as needed (matching AutoCAD's native COPY multiple-placement behaviour). Copy Rotate and Move Rotate should work exactly as they did in `COPY ROTATE.LSP`.

**Reference:** `TIM_TOOLS_COMBINED.lsp` — `C:C`, `C:CopyRot`, `C:MoveRot`. See REGRESSION_LOG BUG-096.

**Note (2026-05-08 fix):**
- `C:C` — now uses `COPYMODE=0` (AutoCAD loop mode). ✅ Confirmed pass T22.
- `C:CopyRot` — redesigned: select → pick base → pick destination → pick rotation angle. No in-place copy at WCS origin.
- `C:MoveRot` — same new pattern as CopyRot (move then rotate in place).

**Note (2026-05-12 fix — CopyRot bug):**
- `"P"` after `_.COPY` selects the SOURCE objects, not the copies — so originals were being rotated instead of the copies. Fixed by snapshotting `entlast` before COPY, then walking `entnext` after COPY to collect all newly created entities (`TIM:NewEnts` helper). COPYMODE forced to 1 during COPY to prevent loop mode breaking the handoff to ROTATE.
- `C:MoveRot` confirmed correct — `"P"` after `_.MOVE` is the moved objects (now at destination). No change needed.

**Note (2026-05-14 fix — pickfirst, v2.1 Phase 1):**
- All three commands now explicitly capture the implied selection via `(ssget "_I")` so pickfirst works reliably under LISP `(command ...)` calls (AutoCAD sometimes drops the implied set across LISP invocations).
- `C:C` — if implied selection exists, COPY receives it via `(command "_.COPY" sset "")`; otherwise it falls back to AutoCAD's native prompt. COPYMODE=0 preserved.
- `C:MoveRot` / `C:CopyRot` — try `(ssget "_I")` first; only print the "select objects" prompt and call `(ssget)` if no pickfirst set exists. Pre-select → straight to base-point prompt; no Select message.
- Aliases `C:MR` / `C:CR` unchanged.
- **Regressed in Tim's 2026-05-14 test:** `C` post-select-with-area broken; `C` multi-placement broken (`(command "_.COPY" sset "")` returns mid-command, COPYMODE restore happens while COPY is paused); `CR` / `MR` pickfirst doesn't trigger. Root cause = LISP `(command)` is non-blocking when partial args are passed.

**Note (2026-05-14 C# migration, v2.1 Phase 1):**
- Migrated all three commands to C# in `CE_CVL_SUITE/Commands/CopyMoveRotateCommands.cs`. LSP versions (`C:C`, `C:CopyRot`, `C:MoveRot`, `C:MR`, `C:CR`, `TIM:NewEnts`, `TIM:MCR-ERROR`) deleted from `TIM_TOOLS_COMBINED.lsp` (file now 1034 lines, was 1153).
- Pickfirst via `ed.SelectImplied()`; falls back to `ed.GetSelection()` only when implied is empty. No collision with the LSP non-blocking command bug — `ed.Command(...)` blocks until COPY exits, so COPYMODE=0/restore happens at the right moment.
- `CR` uses `Entity.Clone()` then `TransformBy(combined rotation·displacement)` inside a single transaction — keeps copies off the WCS origin even momentarily (the historical CopyRot artefact-at-origin bug cannot recur).
- `MR` does in-place `TransformBy` on the captured selection — originals move and rotate, nothing left at source.
- **Known collision flagged for Tim's review:** `CE_STRUC_SUITE/Commands/CeTextCommands.cs:87` also registers `[CommandMethod("C")]` (a CopyMultiple via `CeTextService.Run("C")`). At work (STRUC not loaded) CVL's `C` wins. At home (both loaded) whichever plugin AutoCAD loads first wins. Tim needs to decide which one owns `C` and de-register the loser. `CR` and `MR` are unique to CVL — no conflict.

**Status:** FIXED (C only) — 2026-05-20; CR/MR investigation deferred to Tim externally. `C` alias multi-placement confirmed ✓ T19. Tim is handling the CR/MR external investigation himself.

---

## BUG-002

**Command / Area:** `TEXTEDIT` / `DDEDIT` on standard DBTEXT objects

**Symptom:** Running TextEdit on a regular DBTEXT entity causes the text to glitch. After the command finishes, the text cannot be moved, seen, or edited — the only fix is to close and reopen the entire drawing.

**Expected behaviour:** TextEdit should open the text for in-place editing and return the DBTEXT to a fully normal, selectable state when done.

**Reference:** `Services/CompoundEditModeService.cs` — DBText bypass branch.

**Note (2026-05-12 fix attempt — INSUFFICIENT):** Same root cause hypothesis as BUG-114 / PL-015 / PL-068. `CompoundEditModeService` called `ed.SelectImplied()` to read the pick buffer at line 145, then in the DBText bypass branch at line 174 returned without restoring it via `SetImpliedSelection`. Fix: added `ed.SetImpliedSelection(ids)` inside the DBText bypass branch before `return`. **HOWEVER, Test 212 still fails 2026-05-12 evening.** Command line shows `(nil nil)` — strongly suggests a LISP `defun` is intercepting TEXTEDIT before C# code runs. Next investigation: grep all `.lsp` files in `Common/` and `TIM_TOOLS_COMBINED.lsp` for `(defun c:textedit`, `(defun c:ddedit`, and any double-click reactor LSP override.

**Status:** ❌ STILL BROKEN — coded fix insufficient. CRITICAL: daily-use task.

---

## BUG-003

**Command / Area:** `CDCALC` → CE Standard Orifice Pit Detail (CE_CVL_SUITE v3.0)

**Symptom:** CDCALC produces hydraulic calculation results (orifice sizing, pit dimensions) but there is no automated way to turn those results into a CE-standard orifice pit detail drawing. The engineer has to manually create the detail, which is slow and error-prone.

**Expected behaviour:** After CDCALC completes, the plugin should offer to generate a fully dimensioned orifice pit detail drawing using CE standard annotations, correct layer/colour/text/dimension settings, and the calculated specifications populated automatically.

**Reference:** `Commands/CalculationsCommand.cs`, CE standard orifice pit detail template

**Triage 29 Sep (release chat 04): fix found in code, orifice pit detail generator + writer, present in the installed Civil 3.0.13. Status stays open until a Codex/Tim check confirms it in AutoCAD; queued for Codex pass 18.**

**Status:** OPEN

---

## BUG-004

**Command / Area:** Layer / Draw Order / Colour / Text / Dimensions Manager (CE_CVL_SUITE v3.0)

**Symptom:** There is no centralised manager for the CE drawing standard. Layer colours, draw orders, text styles, and dimension styles are coded in multiple places (LayerService, individual commands, config JSON) with no single UI for Tim to review or override them without opening the code.

**Expected behaviour:** A dedicated manager dialog (accessible via a CD command) where Tim can view and override the CE standard layer colours, draw orders, text styles, and dimension styles for the current drawing. Changes persist to the user settings JSON and apply to all subsequent commands.

**Reference:** `Services/LayerService.cs`, `Services/ThemeService.cs`, `Models/UserSettings.cs`

**Note (2026-05-12):** CDLAYERMANAGER extended to a 3-tab "CE Drawing Standards Manager":
- **Tab 1 "Draw Order"** — existing content unchanged
- **Tab 2 "Layer Colours"** — 23 CE layers listed; Override ACI column editable; saved to `UserSettings.LayerColours.Overrides`; `LayerService.EnsureLayer` now resolves overrides automatically via `ResolveColour()`
- **Tab 3 "Label & Dim Styles"** — opens existing CDLABELSTYLE dialog; DIMSTYLE button runs AutoCAD native command

**Clarification (2026-05-20):** the AutoCAD command alias is `CDMANAGER`, NOT `CDLAYERMANAGER` as the earlier Monday test checklist said. Tim confirmed T2 ✓ on 2026-05-20.

**Status:** FIXED — 2026-05-20.

---

## BUG-005

**Command / Area:** CDEDIT on a Rising Main pipe

**Symptom:** When opening CDEDIT on an existing Rising Main pipe, the "From SPS Invert" and "To Invert" text labels appear in the wrong above/below positions relative to the pipe — described as a "weird glitch" (exact positions to be confirmed by Tim in next test round).

**Expected behaviour:** The invert text labels should remain in exactly the same above/below positions they were in when originally placed, the same as any other pipe type.

**Reference:** `Commands/PipeEditCommand.cs` — `InferInvertIsAbove`, `DeterminePositionalSideForInverts` (currently returns "FIRST" always — stub implementation), `CreateInvertWithZoom`.

**Note (2026-05-08 investigation):** The UPSTREAM/DOWNSTREAM label swap bug was fixed as BUG-090b. The "above/below" glitch for near-vertical pipes was traced to `InferInvertIsAbove` using West=Top convention while the rest of the system uses East=Top. Fixed 2026-05-08 (REGRESSION_LOG BUG-095) using a dot-product approach that delegates to `QuickModeService.GetAnnotationPerpendicularAngle`.

**Status:** IN PROGRESS — coded 2026-05-08, awaiting AutoCAD Monday test

---

## BUG-006

**Command / Area:** Flow arrow placement — Rising Main pipes

**Symptom:** The flow arrow on a small-diameter Rising Main (e.g. 50mm dia) was placed too far from the pipe. Arrow appeared to be offset by approximately one annotation lane (275mm) more than expected.

**Expected behaviour:** Flow arrow should sit at `pipe_radius + 125mm` from the pipe centreline when there is no annotation text below the pipe. If annotation text exists below the pipe, the arrow should step below that text (or sit adjacent to it).

**Reference:** `Services/PipeCreationService.cs` — clash check in step 5 did not exclude the invert MTexts placed in step 4. Fixed 2026-05-08 (REGRESSION_LOG BUG-094) by adding `result.PipeTextId`, `result.FirstInvertId`, `result.SecondInvertId` to the `arrowExclude` set.

**Status:** IN PROGRESS — coded 2026-05-08, awaiting AutoCAD Monday test

---

## BUG-008

**Command / Area:** PITSCHEDULE — row sort order on open

**Symptom:** When PITSCHEDULE opens, the rows are not always in the correct order. The sort only becomes correct after manually pressing the Sort button. The auto-sort on dialog load is either not firing or firing before the data is fully populated.

**Expected behaviour:** PITSCHEDULE should open with rows already in the correct sort order — no manual Sort button press required.

**Reference:** `ViewModels/PitScheduleViewModel.cs` — sort logic called on data load.

**Note (2026-05-12 fix):** Root cause was `ApplyPersistedSortOrder` honouring partial/stale `LinkedRowSortOrder` maps even when they covered only a few rows — producing a mixed visual order. Fix: if the saved sort map covers less than 90% of linked rows, treat it as stale and fall through to natural `PitIdComparer.Natural` order. Commit `a0d15709`. Awaiting Test 241.

**Status:** IN PROGRESS — coded 2026-05-12, awaiting AutoCAD test 241

---

## BUG-009

**Command / Area:** CDEDIT — pit remark appears on inlet line as well as pit

**Symptom:** When CDEDIT is used on a pit to add a remark, the remark text annotation appears on the inlet pipe/line connected to the pit as well as on the pit itself. Tim only wants one remark label per pit.

**Expected behaviour:** The remark annotation should be written to the pit entity only. Connected inlet lines must not receive a remark label.

**Reference:** `Commands/PitEditCommand.cs` or `Commands/PipeEditCommand.cs` — remark write logic likely iterates connected entities rather than targeting the pit only.

**Note (2026-05-12 fix):** Found in `Services/ScheduleLinkService.cs` (the pit-attachment writer iterating attachments). It iterated every linked entity including pipe polylines and wrote the remark there too. Added a guard: `if (entity is Polyline) continue;` — only `BlockReference` (pit label) and `MText` (cover text) get the remark. Commit `6cc78225`.

**Note (2026-05-20):** Tim confirmed T17 ✓. Mirror-related question raised — captured as BUG-036.

**Status:** FIXED — 2026-05-20.

---

## BUG-007

**Command / Area:** Monday batch — all items coded 2026-05-08, awaiting AutoCAD confirmation

**Symptom:** N/A — tracking entry for the full Monday test batch.

**Expected behaviour:** All 16 items below pass in AutoCAD.

**Reference:** See REGRESSION_LOG.md BUG-085 through BUG-096

**Monday test checklist:**

*CE_CVL_SUITE plugin (12 items):*
1. Rising Main warning banner hides when "Rising Main" radio button clicked (BUG-086)
2. "RISING MAIN TO P1" label text resolves correctly, not "TO SPS" (BUG-085)
3. PIT command — Inspect Drawing button → pan/zoom → Enter → dialog reopens, no crash (BUG-087)
4. Callout drag: live L-shape preview visible during placement (BUG-088)
5. Callout placed LEFT of pipe: left-justified text, correct leader side (BUG-089)
6. CDEDIT on pipe with callout: callout does not move after OK (BUG-090)
7. CDEDIT on Rising Main: SPS end = UPSTREAM, P1 end = DOWNSTREAM (BUG-090b)
8. TG command: drag cursor sets length AND rotation simultaneously, no separate length prompt (BUG-091)
9. CDFALL / CDSLAB: arrow points downhill correctly (BUG-092)
10. CDFALL / CDSLAB: no crash (BUG-093)
11. Rising Main flow arrow sits at pipe_radius + 125mm, not one lane too far (BUG-094)
12. CDEDIT on near-vertical pipe: inverts stay on their original sides after OK (BUG-095)

*TIM_TOOLS_COMBINED.lsp (3 items — BUG-001, BUG-096):*
13. `C` alias — select objects, pick base, place multiple copies without re-selecting; press Escape to exit. Also works with pre-select (select first, then type C).
14. `CopyRot` / `CR` — select → pick base → pick destination → pick rotation angle. Copy appears at destination, rotated; original stays at source; **no spurious object at WCS origin** (especially important with a custom UCS active).
15. `MoveRot` / `MR` — same workflow as CopyRot; original moves to destination and is rotated there; nothing left at source; no WCS-origin artefact.

*Verify-only (no code fix — 1 item):*
16. TEXTEDIT / DDEDIT on a plain DBTEXT — text is editable, no glitch, entity fully selectable/moveable after edit. (BUG-002 — may already be fixed by Phase 3 overhaul; confirm pass/fail Monday.)

**Confirmed results:**
1. ✅ Rising Main warning banner hides (BUG-086) — T10 Pass
2. ✅ "RISING MAIN TO P1" label correct (BUG-085) — T11 Pass
3. ✅ PIT Inspect Drawing — T12 Pass
4. ❌ Callout drag L-shape preview (BUG-088) — T13 Fail → re-fixed as BUG-106, T190 ✅ east pass, T197 ❌ west still failing (BUG-111)
5. ❌ Callout LEFT placement (BUG-089) — T14 Fail → T196 ✅ east pass, T197 ❌ west still failing (BUG-111)
6. ❌ CDEDIT callout doesn't move (BUG-090) — T15 Fail → fix applied 2026-05-08, **never retested after fix**
7. ✅ CDEDIT Rising Main UP/DOWN correct (BUG-090b) — T16 Pass
8. ✅ CDTG drag sets length + rotation (BUG-091) — T17 Pass
9. ❌ CDFALL direction (BUG-092/095/104) — T18 Fail → still failing T180-T182; needs block definition edit
10. ✅ CDFALL no crash (BUG-093) — T19 Pass
11. ✅ Rising Main flow arrow offset (BUG-006/094) — T20 Pass
12. ✅ CDEDIT near-vertical inverts (BUG-005/095) — T21 Pass
13. ✅ C alias multiple placements — T22 Pass
14. ⏭ CopyRot / CR — Skipped (CE_STRUC_SUITE not loaded at work)
15. ⏭ MoveRot / MR — Skipped (CE_STRUC_SUITE not loaded at work)
16. ❌ TEXTEDIT on plain DTEXT — T25 Fail (may require CE_STRUC_SUITE to resolve)

**Status:** PARTIAL — 9 ✅ Pass, 4 ❌ still failing (callout west BUG-111, CDEDIT callout needs retest, CDFALL direction needs block edit, TEXTEDIT), 2 ⏭ Skipped pending STRUC suite

---

## BUG-010

**Command / Area:** `CDCALC` — dialog refuses to open (REOPEN of REGRESSION_LOG BUG-112)

**Symptom:** Running `CDCALC` produces a Customer Error Report (CER) and the dialog never displays. Command line shows `[CE] Error during CDCALC — see CE log for details`. New CER folder contents on machine: `C:\Users\TimothyBrand\AppData\Local\Autodesk\CER\6d903fba150168a4abc949c7d407680bbfba5e80\1778553767520`. The 2026-05-12 fix (changed `BoydsCalcViewModel` computed properties from `private set` to `public set`) was not sufficient — CDCALC still crashes after a fresh AutoCAD restart with the new DLL deployed.

**Expected behaviour:** Running `CDCALC` opens the Calculations dialog with all tabs (Boyd's, Rational, WSUD, Print) usable. No CER. No "[CE] Error during CDCALC" on command line.

**Reference:** `Commands/CalculationsCommand.cs`, `ViewModels/BoydsCalcViewModel.cs`, `ViewModels/RationalMethodViewModel.cs`, `ViewModels/WsudViewModel.cs`, `ViewModels/CalculationsV2ViewModel.cs`, `Dialogs/CalculationsV2Dialog.xaml*`, `ce_cvl_structured_2026*.log`

**Note (2026-05-12 evening — investigation needed):**
- Read CER folder `1778553767520` for actual exception type and stack trace
- Read latest `ce_cvl_structured_2026-05-12*.log` for the structured log entry
- Check ALL CDCALC-bound viewmodels for `private set` on properties bound in XAML (Boyd was fixed but Rational/WSUD/Print may have the same issue)
- Consider PL-050 (AssemblyLoadContext) — was the prior fix for the related CDFEEDBACK ALC issue still effective? Fresh AutoCAD restart (no hot-reload) was used — so ALC should have been fine. Confirm by checking `Plugin.cs` initialization.
- Consider XAML resource lookup — `BaseWindowStyle`, `BoolToVis`, etc. — verify these resolve at dialog construction time
- Check if any `Application.Current.Resources` lookup is happening during VM construction (would fail if WPF Application not yet initialized)

**Status:** FIXED — 2026-05-20. Tim re-confirmed T1 ✓ on 2026-05-20 after 3 successful opens recorded in the structured log on 2026-05-19. The 2026-05-13 fix held; the REOPENED label was a false alarm caused by an intermittent state that no longer reproduces.

---

## BUG-011

**Command / Area:** `CD` / `CDEDIT` — pipe callout (MLeader text label) placed WEST of the pipe

**Symptom:** When a pipe callout is placed to the WEST (left) of the pipe — either as the initial placement during `CD`, or after editing via `CDEDIT` — the text justify ends up as **RIGHT** instead of LEFT. The text appears mirrored / reads back-to-front, and the leader line approaches from the wrong side. Manually selecting the text and changing Justify to LEFT fixes that one instance, but the next callout placed on the west reproduces the bug.

**Expected behaviour:** West-of-pipe callouts must place with Justify=LEFT from the moment of placement so the text reads left-to-right and the leader attaches cleanly to the left edge of the text block. Mirror of the east placement, no manual correction needed.

**Reference:**
- Originally tracked as **BUG-111** in `REGRESSION_LOG.md` (see also `PL-018`, `BUG-088`, `BUG-089`, `BUG-090`, `BUG-106`).
- Last fix attempt 2026-05-11 (T197) — east placement passes; west placement still fails. Fix was applied to the east code path but did not reach the west branch, OR a second assignment overwrites the LeftAlignment value.
- Suspect files: `TextService.cs` callout text creation; the MLeader text justification setter; any post-placement transform that flips Position↔AlignmentPoint.

**Investigation hints (for next session):**
- Grep for `TextHorizontalMode.TextRight` and `TextHorizontalMode.TextLeft` in `TextService.cs` and the callout placement path.
- Check whether the west branch sets `attr.HorizontalMode = TextHorizontalMode.TextLeft` or leaves the default (which may be Right after a Position/AlignmentPoint swap).
- Compare with the FALL block's `FlipAttributeRotations` helper (`BlockService.cs:904`) — that helper does swap Position↔AlignmentPoint correctly. The callout code may need the same swap, or it may be doing the swap and then re-applying the wrong justification.

**Triage 29 Sep: already fixed in code** (Tim's 15 Sep ruling BUG-128: callout text left-justified both sides, `TextService.GetCalloutTextAlignment`); 8-direction test added in PR #367. Stays open until Codex/Tim confirms.

**Status:** OPEN — deferred to next update after v2.0 ship 2026-05-12.

---

## BUG-012

**Command / Area:** `CDFALL` — FALL + FALL_GRADE attribute justification

**Symptom:** After CDFALL completes, the FALL block's two attributes are not left-justified to CE drafting standard. The "1" of "1:80" should line up vertically with the "F" of "FALL" along the arrow direction (so they read as a stacked left-aligned label). Currently they take whatever justification the FALL SYMBOL block definition holds, which doesn't match the CE drafting standard.

**Expected behaviour:**
- Both FALL and FALL_GRADE attribute references render with HorizontalMode = TextLeft.
- The leftmost character of FALL_GRADE ("1") sits directly under the leftmost character of FALL ("F"), aligned along the arrow direction (BCS X), regardless of arrow rotation.

**Reference:**
- Source: `Services/BlockService.cs` — `ApplyFallBlockOrientation`, `SyncBlockAttributesFromDefinition`.
- Block definition: FALL SYMBOL dynamic block (loaded from CE block library).
- First attempt rolled back in commit `ca4f5aad` — `AlignFallAttributesLeftJustified` set `AlignmentPoint = Point3d.Origin` and called `AdjustAlignment(db)`, which wiped Position back to (0,0,0). Text rendered far off the visible drawing.

**Investigation hints:**
- The correct fix is to edit the FALL SYMBOL block definition's `AttributeDefinition` objects directly (set `HorizontalMode = TextLeft`, set both Position.X values equal in BCS) rather than fighting `SetAttributeFromBlock` after the fact. Once the definition matches the standard, `SyncBlockAttributesFromDefinition` will propagate correctly.
- Modifying the block definition can be done either (a) at plugin load time as a one-shot patch to the current drawing's BlockTable, or (b) by editing the source FALL SYMBOL.dwg in the CE block library so all new drawings inherit the fix.
- Do NOT touch `AlignmentPoint` on the `AttributeReference` after sync — `AdjustAlignment` uses it to recompute Position and resets the position to origin if AlignmentPoint is (0,0,0).

**Built 29 Sep (Sonnet 5.5): PR #367** - `PatchFallAttributeDefinition` still wrote the alignment point as the drawing origin on every FALL SYMBOL insert, dragging both texts to X=0 and stacking "1:80" onto FALL. Now: already-left text untouched; centred/right text left-justified from where it was anchored; alignment point never written. A drawing that already holds a damaged FALL SYMBOL must be PURGEd first. **Found: the BUG-079 fixes on branch `claude/vigorous-wilson-7e7e91` never reached the trunk** (audit dispatched).

**Status:** OPEN — first attempt reverted 2026-05-12 (commit `ca4f5aad`). Deferred to v2.0.1.

---

## BUG-013

**Command / Area:** Build / NuGet dependency management (CE_CVL_SUITE.csproj)

**Symptom:** Plugin commands listed in the bundle manifest but invoking any of them returns "Unknown command" on AutoCAD 2022. No error visible in the AutoCAD command line. The plugin DLL physically exists at the expected path, loads cleanly in PowerShell, but AutoCAD silently rejects the assembly load — meaning `Initialize()` never runs, no logs are written, and every CE command is silently broken.

**Expected behaviour:** The plugin loads on AutoCAD 2022 and registers commands normally.

**Reference:** Resolved in commit `e4546f6b` (2026-05-13). Root cause documented in `REGRESSION_LOG.md` Session 2026-05-13 entry. The actual fix is in `CE_CVL_SUITE/CE_CVL_SUITE.csproj`: for the net48 build, `Serilog` is pinned to 4.0.0 and `Serilog.Sinks.File` to 6.0.0 to match the strong-name version reference embedded in `Serilog.Sinks.Debug 3.0.0`. Shipping any newer Serilog version on net48 silently fails the assembly bind under AutoCAD's .NET Framework loader.

**Diagnostic that found it:** Fusion bind logging (`reg add HKLM\SOFTWARE\Microsoft\Fusion /v EnableLog /t REG_DWORD /d 1 /f` then restart AutoCAD, check `C:\FusionLogs\`). Any time a CE plugin silently fails to load, enable Fusion logging on the failing machine before guessing at fixes — the bind log will show the exact failed assembly reference.

**Note (2026-05-13 lesson):** When bumping Serilog or any of its sinks in future, bump them as a matched set and verify on AutoCAD 2022 before shipping. Strong-named NuGet packages embed exact version references; mismatches silently break the load with no on-screen error.

**Status:** FIXED — 2026-05-13. Documentation only — kept here as a permanent reminder of the version-pin trap.

---

## BUG-014

**Command / Area:** `CD` command auto-calc grade — `MathHelper.TryParseGrade`

**Symptom:** Two failure modes in auto-calc grade:
1. User entering "1:80" as a Custom grade — the CD command rejected it with "Invalid custom grade for auto-calc. Enter a numeric value like 100." even though "1:80" is the standard CE drafting notation.
2. With the Default Minimum radio button selected (the shipped default), the configured value "100 MIN." in `UserSettings.Grade.DefaultMinimumValue` failed to parse. The parser silently fell through to a hard-coded fallback of 60, applying a 1:60 grade instead of the configured 1:100. No warning shown.

**Expected behaviour:** `TryParseGrade` should accept every grade format civil engineers actually type: bare denominator, "1:N", "1 in N", "N MIN." / "N MAX." (with or without trailing period), and combinations like "1:80 MIN.".

**Reference:** `CE_CVL_SUITE/Helpers/MathHelper.cs:TryParseGrade`. Caller is `CdCommand.cs:TryGetAutoCalcGrade` (~line 1038). 6 new unit tests added in `MathHelperTests.cs`.

**Status:** FIXED — 2026-05-13 (commit `13fc5acb`). Awaiting Tim's AutoCAD confirmation.

---

## BUG-015

**Command / Area:** `CD` command Custom Grade input — `CdCommand.BuildGradeValue` / `FormatGradeForDisplay`.

**Symptom:** Sibling of BUG-014. The parser now *accepts* "1:80" so auto-calc no longer errors, but the value flowed straight into the drawing unchanged — pipe text became `300 DIA. UPVC PIPE AT 1 IN 1:80` and XData stored `"1 IN 1:80"`. Same garble for `"1:100 MIN."` → `"AT 1 IN 1:100 MIN."`.

**Expected behaviour:** Whatever notation the user types, the drawing output should always be the canonical `1 IN N` form — `"1:80"` → `"AT 1 IN 80"`, `"1:100 MIN."` → `"AT 1 IN 100"` (band rule), `"1:150"` → `"AT 1 IN 150"` (preserve real grade).

**Root cause:** `BuildGradeValue` returned `vm.CustomGrade` verbatim, and `FormatGradeForDisplay` only ran the band rules when `double.TryParse` succeeded — which it never does on `"1:80"`. Both call sites needed prefix-stripping.

**Fix:**
1. New `MathHelper.TryNormalizeGradeText(raw, out normalized)` — strips `"1:"` / `"1 in "` prefix, canonicalises any `" MIN." / " MAX."` suffix to upper-case + period, returns rounded integer denominator.
2. `FormatGradeForDisplay` now strips prefix/suffix inline (preserving decimal precision for the band parse so `"89.9"` still hits the 50–89 band), then for outside-band values falls back to the canonical form via `TryNormalizeGradeText`.
3. `BuildGradeValue` normalises `vm.CustomGrade` before returning, so both pipe text and XData get the clean denominator.
4. `GetConfiguredDefaultGradeValue` normalises the settings value defensively in case a user types `"1:100 MIN."` into Advanced Settings.

**Tests:**
- 11 new MathHelper.TryNormalizeGradeText tests covering bare, prefix, suffix, combined, lower-case, non-numeric, empty, null.
- 4 new GradeFormatTests verifying `"1:80" → "100 MIN."`, `"1:150" → "150"`, `"1:100 MIN." → "100"`, `"1 IN 80" → "100 MIN."`.
- All 70 grade-related tests pass on net48; the pre-existing 50–89 → "100 MIN." band still holds at boundary "89.9".

**Reference:** `CE_CVL_SUITE/Helpers/MathHelper.cs:TryNormalizeGradeText`, `CE_CVL_SUITE/Commands/CdCommand.cs:FormatGradeForDisplay` / `BuildGradeValue` / `GetConfiguredDefaultGradeValue`.

**Status:** FIXED — 2026-05-13. Awaiting Tim's AutoCAD confirmation.

---

## BUG-016

**Command / Area:** `CD` command Custom Grade textbox — `CdViewModel.CustomGrade` setter + `CdDialog.xaml`.

**Symptom:** Tim ran CD, saw the Custom row showing `○ Custom  1 in [____]`, typed `80` into the textbox, placed a pipe. Pipe text came out as `… AT 1 IN 100 MIN.` instead of the expected `… AT 1 IN 80`. The dialog had silently stayed in Default mode and used the auto-calc fallback.

**Expected behaviour:** The "1 in [____]" hint makes the input self-explanatory — typing a number into that box should ALWAYS treat the input as Custom mode at grade 1 in N. No need to click the radio button first.

**Root cause:** Two issues working together:
1. The TextBox carried `IsEnabled="{Binding IsGradeCustom}"`, so it was disabled while Default mode was selected. The user could see the textbox but couldn't actually enter text into it (or entered text was silently rejected, depending on WPF focus state).
2. The `CdViewModel.CustomGrade` setter wrote the new value but did NOT engage Custom mode, so even when the textbox WAS enabled, the dialog could remain in Default with no visual feedback.

**Fix:**
1. Removed `IsEnabled="{Binding IsGradeCustom}"` from BOTH Custom textboxes in `CdDialog.xaml` (regular grade card AND the wide-layout variant at line 952).
2. Added auto-engage logic to `CustomGrade` setter — when the new value is non-empty/non-whitespace AND Custom mode isn't already selected, flip `IsGradeCustom = true`. Programmatic clears (empty / whitespace) don't trigger the engage so pipe-type resets can still set `CustomGrade = ""` without yanking the radio across.

**Tests:** 4 new NUnit tests in `CdViewModelTests.cs`:
- `CustomGrade_SetFromDefault_AutoEngagesCustomMode`
- `CustomGrade_SetFromFromInverts_AutoEngagesCustomMode`
- `CustomGrade_ClearedProgrammatically_DoesNotEngageCustomMode`
- `CustomGrade_WhitespaceOnly_DoesNotEngageCustomMode`

All 76 grade-related tests pass on net48.

**Reference:** `CE_CVL_SUITE/ViewModels/CdViewModel.cs:CustomGrade` setter, `CE_CVL_SUITE/Dialogs/CdDialog.xaml` lines 273-275 + 952.

**Status:** FIXED — 2026-05-13. Awaiting Tim's AutoCAD confirmation.

---

## BUG-017

**Command / Area:** Whole CE plugin (Civil + Structural). Affects ALL commands when run with a non-WCS UCS.

**Symptom:** When the active UCS is not aligned with World (any rotated/translated/named UCS), running CE plugin commands causes the plugin to "completely shit itself" — exact failure mode TBC (crashes, misplaced entities, blank dialogs, or all three). Reported by Tim 2026-05-14 during Phase 1 testing.

**Expected behaviour:** Every command should work identically regardless of active UCS. Pit positions, pipe geometry, callouts, and inverts should land in the correct world position no matter what the UCS rotation/translation is.

**Reference:**
- The codebase already mixes UCS and WCS conventions inconsistently. Recent example: PARK-014 consolidation found that `PipeEditCommand.ComputeSpsInwardOffset` had a misleading comment claiming WCS while `context.UcsPoints` is UCS. The duplicate's "defensive" `DrawingService.TransformToWorld` was actually load-bearing.
- High-risk call sites: anywhere that compares pipe-endpoint points to `PitData.Position` (which is WCS), anywhere that places blocks at user-picked points without explicit `TransformToWorld`, hitbox tests, snap detection, schedule row resolution.
- Likely the same root cause in many places — code assumes UCS==WCS.

**Investigation hints (for next session):**
1. Get Tim to repro: rotate UCS 30°, then try CD / PIT / CDEDIT / CDFALL / PITSCHEDULE — capture the exact failure for each. Pictures help.
2. Search for direct point comparisons: `grep -rn "p.Position\[0\]\s*-\s*\(.*\)\.X\|p.Position\[1\]\s*-\s*\(.*\)\.Y"` and audit each one for a missing `TransformToWorld`.
3. Audit `ed.GetPoint(...)` callers: every world-space comparison downstream must transform first. Sample fix pattern is at `CdCommand.cs:1160`.
4. Audit block insertion: `BlockReference.Position` setter expects WCS; if Tim's click point goes in without conversion, the block lands at the wrong place.
5. Consider adding a `DrawingService.RequireWorldUcsOrTransform(...)` helper that wraps the common pattern.

**Note (2026-05-14 fix):** New `Services/UcsGuardService.cs` hooks every document's `CommandWillStart` / `CommandEnded` / `CommandCancelled` / `CommandFailed`. On a CE command starting, it captures the current UCS via `Matrix3d.Identity` comparison and switches the editor to World; on the matching End/Cancelled/Failed, restores the saved UCS. Nested-command safe (depth counter — inner CE commands only bump depth, restore fires only when outer command ends). CE filter built via reflection over `[CommandMethod]` attributes in the CE_CVL_SUITE assembly at plugin load (HashSet of ~43 names); falls back to prefix match ("CD", "CE") + literal whitelist (PIT, DP, IO, OF, FO, TG, SL, GIO, C, CR, MR, etc.) if reflection ever fails. Zero-touch on the 25 existing command files. Wired into `PluginInitialization.cs` next to `AdminTelemetryService.Initialize`.

**Status:** PARTIAL — 2026-05-20. Tim confirmed T23 / T24 / T25 ✓; T22 surfaced a new regression where a PIT placed inside or right after CD rotates by itself in a rotated UCS. New entry BUG-035 captures the regression.

---

## BUG-018

**Command / Area:** PIT block library — adopt `C:\Lisp Files\PIT BLOCK 2.dwg` as the standard pit block for all users.

**Symptom:** Tim has a newer/better PIT BLOCK definition at `C:\Lisp Files\PIT BLOCK 2.dwg` that should replace whatever the plugin currently inserts/references for pit blocks. The current pit block in the bundled block library is out of date or doesn't match Tim's preferred geometry. Until the swap is made, the rollout cannot happen consistently across all users.

**Expected behaviour:** All pit-insertion commands (PIT, IO, OF, FO, DP, etc.) and the schedule/inspection code should reference the PIT BLOCK 2 geometry. The block should be staged into the installer payload so every user gets it on update.

**Reference:**
- Source file: `C:\Lisp Files\PIT BLOCK 2.dwg`.
- Likely staging location: `CE_CVL_SUITE/Installer/source_blocks/` (existing pattern for FLOOR WASTE, SOURCE, etc.).
- Likely code touchpoints:
  - `Services/BlockService.cs` — `BLOCK_PIT` constant or similar.
  - Whatever loads the pit block definition on first use (probably `BlockService.LoadFromLibrary` or similar).
  - `Commands/PitCommand.cs` — dynamic property names for SPS_RADIUS, XWidth, YWidth must still apply on the new block (verify dynamic properties match).
  - `network-catalogue.json` if the block reference is named there.

**Investigation hints (for next session):**
1. Open `PIT BLOCK 2.dwg` in AutoCAD — confirm its block name (BEDIT → Block Editor → block name).
2. Diff against the current bundled PIT block: dynamic properties (SPS_RADIUS, X_WIDTH, Y_WIDTH), visibility states (Class C/D/Step/Solid/Grated/SPS), insertion point, layer assignments.
3. If dynamic property names differ, every existing drawing's pits would break on update — Tim's call whether to (a) match property names, (b) write a migration shim, or (c) accept the break.
4. Stage into installer + bump version.

**Note (2026-05-14 discovery + fix):** PIT BLOCK 2 was already partly wired up — `BlockService.GetBlockNameVariants` (line 125) prefers `"PIT BLOCK 2"` over `"PIT BLOCK"`, `Installer/source_blocks/PIT BLOCK 2.dwg` is staged, `Installer/build_installer.ps1` copies it into the bundle, and Tim's `%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Blocks\PIT BLOCK 2.dwg` exists. NEW drawings created after the latest install already get PIT BLOCK 2 automatically.

The remaining gap was OLD drawings (already on the user's disk) where a `"PIT BLOCK"` block definition exists from before — AutoCAD never re-imports a block definition that's already in the drawing. Fix: new `[CommandMethod("CDREFRESHBLOCKS")]` in `Commands/RefreshBlocksCommand.cs`. The command iterates `{ "PIT BLOCK", "PIT BLOCK 2", "PIT LABEL", "PIT LABEL 2" }`, resolves each via `BlockService.GetBlockFilePath`, and uses `Database.Insert(blockName, sourceDb, true)` to redefine the existing in-drawing definition from the bundled DWG. BlockReference handles, positions, and dynamic property values on existing references all persist (those live on the reference, not the definition). Registered as hidden / expert in `command-registry.json` (group "Repair" / "Advanced" alongside CDDEBUG, CDTRIAGE).

**Status:** FIXED — 2026-05-20. Tim confirmed T18 ✓. Installer payload verification (does PIT BLOCK 2 ship to all CE machines?) spawned as follow-up BUG-037.

---

## BUG-019

**Command / Area:** `CD` — Charged Pipe text generation in `TextService.CreatePipeText` (or wherever charged-pipe label formatting lives).

**Symptom:** When the user picks the Charged Pipe pipe-type and enters a "Charged to" destination, the resulting drawing label does not include the pipe MATERIAL prefix. Tim expects the standard format like `100 DIA. UPVC CHARGED TO WT1` (or similar) — material in front of the charged-to phrase.

**Expected behaviour:** Charged-pipe text should follow the same `{diameter} DIA. {material} CHARGED TO {destination}` pattern that gravity and rising-main labels use. Material is read from `vm.Material` and prepended.

**Reference:** `Services/TextService.cs` — `CreatePipeText` / `BuildPipeText` formatter for `PipeType.ChargedPipe`. Compare against `BuildPipeText` for `RisingMain` which already includes material.

**Status:** FIXED — 2026-05-20 (T7 ✓ confirmed by Tim).

---

## BUG-020

**Command / Area:** `CDWT` — Riser + Dropper sub-block auto-tagging in `Commands/WaterTankCommand.cs`.

**Symptom:** After CDWT places the water tank WT block, then prompts for Riser + Dropper insertion points, the Riser and Dropper blocks get registered in ProjectData and visible auto-tag attributes with the prefix `DP` (the down-pipe tag pool) — e.g. `DP1`, `DP2`. Tim wants them tagged with their OWN distinct prefixes: `R` for Riser (`R1`, `R2`, ...) and `D` for Dropper (`D1`, `D2`, ...).

**Expected behaviour:** Riser uses prefix `R`, Dropper uses prefix `D`. Both should still be linked to their parent WT tag for inspector / schedule purposes. The DP tag pool stays exclusively for actual down-pipes.

**Reference:** `Commands/WaterTankCommand.cs` — riser/dropper placement section. `Services/SourceTagService` (or equivalent) — `AllocateNextTag` call site likely passes `"DP"` for both; needs `"R"` and `"D"` respectively.

**Note (2026-05-20):** Tim re-tested T12/T13 ✗. The CODE side was correct (`AllocateNextTag` with "R" / "D" categories) but the BLOCK DEFINITION attribute is still named "DP" on the source RISER.dwg and DROPPER.dwg files (the AutoCAD attribute tag, not the drawing label). When AutoCAD inserts the block it draws the "DP" attribute next to the block — alongside the R/D label we draw via `EnsureTagLabel`, the visible result is two competing labels.

**Code fix this batch (2026-05-20):** `Commands/WaterTankCommand.cs` `PromptAndPlaceSubBlock` now calls `BlockService.SetAttribute(subId, tagCategory, allocatedTag)` after insertion — writing to "R" / "D" if the source DWG has been updated, or falling back to "DP" with a log warning if the legacy attribute name is still in place. `CDREFRESHBLOCKS` extended to redefine RISER and DROPPER in existing drawings.

**Manual edit still required:** Tim must open `C:\Lisp Files\RISER.dwg` in the AutoCAD block editor (BEDIT), rename the attribute tag from `DP` to `R`, save. Repeat for `C:\Lisp Files\DROPPER.dwg` renaming the tag to `D`. Then run CDREFRESHBLOCKS in any open drawing to pull the renamed defs in. After the rename, the code already writes to the new "R"/"D" attribute names.

**Note (round 3, 2026-05-20):** Tim's T12/T13 image showed the inserted RISER block rendering "DP" as the attribute VALUE (not just the tag name). That means `SetAttribute` calls were failing silently — neither "R" nor "DP" matched whatever the actual attribute tag name on the shipped DWG is. The block then kept its AttributeDefinition's DEFAULT VALUE (which happens to be the literal string "DP").

**Code fix (round 3, 2026-05-20):** new `WaterTankCommand.SyncAllAttributesToAllocatedTag` sweeps EVERY `AttributeReference` on the just-inserted block and overwrites its `TextString` with the allocated tag — no name matching required. Safe because RISER/DROPPER source DWGs only carry one tag attribute each. Logs every attribute tag name encountered so the actual name is revealed in the runtime log, enabling a future hard rename of the block definitions.

**Status:** IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test.

---

## BUG-021

**Command / Area:** CD invert placement at near-vertical / steep angles (NW-to-SE direction at approximately 92-95° from north).

**Symptom:** Tim drew a pipe at ~92° azimuth and another at ~95.986° (both close to horizontal but with a slight southward tilt — NW-to-SE direction). MText pipe label placed correctly. But the IL invert text was placed BELOW the pipe even though the "Above" toggle was selected, and the text overlapped the pipe geometry. Initially suspected the clash/clearance model; on reflection, looks like the perpendicular-side detection is flipping at these specific angles.

**Expected behaviour:** When "Above" is selected (PARK-012 / PARK-033 per-invert toggle), IL text always sits on the AutoCAD-above side of the pipe regardless of segment angle. No overlap with the pipe geometry.

**Reference:**
- `Services/TextService.cs` — invert placement, specifically `CalculateResolvedInvertAnchorPoint` + `GetInvertPerpendicularDirection`.
- `Commands/PipeEditCommand.cs` — `InferInvertIsAbove` (already fixed once for near-vertical case as BUG-005 / BUG-095). Might have a different edge case at these specific angles.
- `Services/QuickModeService.GetAnnotationPerpendicularAngle` — used as the perpendicular-side helper.
- The "West=Top" convention vs "East=Top" convention in `GetInvertPerpendicularDirection` may be flipping at near-horizontal angles tilted slightly south.

**Note (Tim's diagnosis):** Started thinking clash model, then realized text was clearly placed on the wrong side (above-style placement landed below). Suggests perpendicular-direction sign error at the specific angle.

**Investigation hints:**
- Repro: draw a pipe with the exact angle Tim hit (~92° from north = ~358° from east, or +358 mod 360). Trace `GetInvertPerpendicularDirection(anchorPoint, segAngle, topSide=true)` and check whether the returned direction is above or below the pipe.
- Look at the `IsNearVertical` branch in `GetInvertPerpendicularDirection` — Tim's angle is close to but NOT vertical, so it falls into the non-vertical branch. Check the `pointsUp` calculation for an off-by-sign at angles just past horizontal.

**Note (2026-05-20):** Tim retest T8 ✗. The 2026-05-19 fix updated `TextService.GetInvertPerpendicularDirection` to use the `|sin|>|cos|` criterion — but `QuickModeService.TryGetQuickInvertPlacement` and `QuickModeService.GetAnnotationPerpendicularAngle` carried the SAME `IsNearVertical(±10°) + yIsNeutral` logic and were never updated. Those two helpers compute the actual per-end placement perpendicular for the IL MText anchor in CD's auto-place path, so the fix never reached the actual writer.

**Code fix this batch (2026-05-20):** ported the `|sin|>|cos|` criterion into BOTH `QuickModeService.TryGetQuickInvertPlacement` (lines ~200) AND `QuickModeService.GetAnnotationPerpendicularAngle` (lines ~275). Tests extended (`InvertPerpendicularTests`) to cover 88°, 95°, 272° — all green.

**Note (round 3, 2026-05-20):** Tim's T8 retest after round 2 fix still showed wrong-side text. Root cause: `PipeEditCommand.InferInvertIsAbove` (the CDEDIT round-trip inference) was still using the legacy `IsNearVertical` ±10° window. For Tim's near-horizontal 92° azimuth (math 358°) pipe, the inference returned the wrong `isAbove` flag, the save re-wrote with the flipped position, and the text moved to the wrong side.

**Code fix (round 3, 2026-05-20):** `PipeEditCommand.InferInvertIsAbove` now uses the canonical `|sin(segAngle)| > |cos(segAngle)|` criterion (same as `TextService.GetInvertPerpendicularDirection`). Diagnostic log emitted for every inference call. Tests extended with `Top_Math358_*`, `Top_Math355_*`, `Top_Math45_*`, `Top_Math89_*`, `Top_Math91_*`, `Top_Math178_*`, `Top_Math182_*` (7 new cases, all green).

**Status:** IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test.

---

## BUG-022

**Command / Area:** `CDSTRIP` — Floor Waste placement at corners + 12m centres along straight runs.

**Symptom:** Tim runs `CDFW` standalone — Floor Waste block lands centred on the user's pick point (the block's insertion point IS the visual centre of the FW symbol). Tim runs `CDSTRIP` — Floor Waste blocks land ON the MLINE (the drawn line where the user picked vertices) instead of CENTRALLY within the 100mm-wide strip drain perimeter. So they appear offset from where Tim expects them.

**Expected behaviour:** Floor Waste blocks in CDSTRIP should land on the strip drain's CENTERLINE (the middle of the 100mm-wide footprint), not on the user-drawn polyline. When the user picks Top / Center / Bottom justification, the MLINE's CENTERLINE is offset from the user's clicks:
- `Top` justification → user clicks are along the TOP edge → centerline is 50mm BELOW (perpendicular, towards Bottom side).
- `Center` justification → user clicks are along the centerline → no offset.
- `Bottom` justification → user clicks are along the BOTTOM edge → centerline is 50mm ABOVE.

The Floor Waste insertion points must be computed on the centerline, not on the user-drawn polyline.

**Reference:** `Commands/StripDrainCommand.cs` — Floor Waste placement loop. The current code likely iterates vertices + midpoints on `points` (user's picks) directly. Need to compute the perpendicular offset based on justification and shift each insertion point onto the centerline.

**Investigation hints:**
- The MLINE width is 100mm (constant). Centerline offset is `width / 2 = 50mm`.
- Justification "Top" → MLINE renders with the line at the TOP edge of the 100mm footprint. Centerline is 50mm below in the perpendicular direction.
- Justification "Bottom" → MLINE renders with the line at the BOTTOM edge. Centerline is 50mm above.
- Justification "Center" → MLINE renders with the line through the centre. No offset.
- "Above" / "Below" for the perpendicular direction must match how AutoCAD's MLINE justify renders the 100mm width — typically right-of-direction = "Top" in the MLINE convention, but verify against the actual draw.
- For each segment, compute its segment direction `θ`, then perpendicular `θ ± π/2` depending on justification. Shift each FW insertion point by `(50 * cos(perp), 50 * sin(perp), 0)`.

**Status:** PARTIAL — 2026-05-20. Tim confirmed middle FWs ✓. End and corner FWs still need additional inward insets (50 mm for ends, 25 mm in each direction for corners) — captured as BUG-028, fixed in this batch. Fall-arrow restyle to QLeader (`25DIMS` style) deferred as BUG-029.

---

## BUG-023

**Command / Area:** `CD` — Rising Main split-across-plans workflow (PARK-032 multi-plan).

**Symptom:** When Tim draws a rising main with the "Place Breakline" toggle on, the workflow places a breakline glyph at the pipe end. The plugin currently treats the breakline endpoint as a real node for invert purposes — IL annotations get drawn at the breakline. This isn't physically meaningful: the breakline is a drawing artifact (representing "this pipe continues on another plan"), not a pit or structure. Showing an IL there confuses the end user, and the user doesn't know where invert levels should actually go for the two halves.

**Expected behaviour:**
- The breakline endpoint must NOT show an IL annotation. The only IL annotations on a split rising main should be at the TWO real endpoints: the SPS pit (start, low IL) and the destination pit (end on the ground-floor plan, high IL).
- For the linked pair (basement half + ground-floor continuation half):
  - Basement half IL on the SPS end (low IL) — shown.
  - Basement half IL on the breakline end — HIDDEN (breakline isn't a node).
  - Ground-floor half IL on the breakline end — HIDDEN.
  - Ground-floor half IL on the destination pit end — shown (high IL).
- The two "breakline end" inverts should be SHARED — they represent the same physical point. The user only enters ONE invert value at the high transition point.
- Workflow should be clearer: maybe a banner / hint / on-screen guidance describing the two-step process and where inverts go.

**Reference:**
- `Commands/CdCommand.cs` — rising main breakline path; invert prompting logic.
- `Services/TextService.cs` — `CreateInvertText` / invert annotation placement; needs to skip the breakline-end invert.
- `Services/LinkService.RepairAudit.InvertPropagation.cs` — `TryGetBreaklineLink` / `SetBreaklineLink` already track the linked-half handle. Extend to share invert state between the two halves.
- `Services/PitScheduleBuilder.cs` — already filters the continuation half so PITSCHEDULE shows ONE row; needs to also use the COMBINED inverts (SPS to destination) not the per-half stored values.

**Investigation hints:**
- The cleanest model: store invert ONCE per physical pipe (SPS end + destination end). Two halves SHARE the high invert (= the breakline IL). When the user enters inverts on the basement half, they enter SPS invert + the high (breakline) invert. When they draw the ground floor half later, the high invert is auto-populated from the linked pair; only the destination invert is requested.
- Visually: don't draw IL labels on the breakline side of either half. Use the `SecondInvertEnabled = false` flag on the basement half (breakline side) and `FirstInvertEnabled = false` on the ground-floor half (also breakline side).
- The CD dialog needs to communicate this clearly. Possibly: when "Rising Main + Breakline" is selected AND a continuation pair exists, show a banner like "Inverts: enter SPS invert below. The high (transition) invert is shared with the other plan." or similar.

**Note (Tim 2026-05-19):** Decided after testing the PARK-032 work shipped earlier today. The mechanics work but the UX needs polish.

**Status:** ✅ Built 2026-05-19. Implemented in three pieces:
- `Services/LinkService.RepairAudit.InvertPropagation.cs` — three new public methods: `TryGetPipeStoredInverts`, `SyncBreaklineInvertToLinkedHalf` (propagates breakline-end IL between paired halves), `SyncBreaklinePairOnLink` (one-shot copy at pair-creation time).
- `Commands/CdCommand.cs` — after a basement breakline lands, erases the just-drawn second-invert MText (no IL label at the breakline). After a continuation half is paired, erases the just-drawn first-invert MText and calls `SyncBreaklinePairOnLink`. New helper `EraseBreaklineEndInvertText` also clears the attachment record.
- `Commands/PipeEditCommand.cs` — on CDEDIT save, reads `TryGetBreaklineLink` and skips drawing the IL MText at whichever end is the breakline (the stored value still updates via `StorePipeInverts`). After the invert text block, calls `SyncBreaklineInvertToLinkedHalf` so any change to the breakline-end IL propagates to the partner half automatically.

**Status:** PARTIAL — 2026-05-20. Mechanics confirmed working (IL labels hidden at breakline; auto-sync between paired halves OK). Multiple UX issues raised after testing — captured as BUG-030 (F12 keyword), BUG-031 (popup dialog), BUG-032 (Inspector visibility), BUG-033 (small-diameter arrow offset), BUG-034 (continuation auto-mode). All deferred to next batch.

---

## BUG-024

**Command / Area:** `CD` + `CDEDIT` — Auto-Calc grade + pipe text label.

**Symptom:** Tim reported on 2026-05-19:
1. *Default + Auto-Calc:* expected second invert at 1:100, pipe text "AT 1 IN 100". Got "random grades" — second invert came out at e.g. 1:91 or 1:104 depending on pipe length, label sometimes showed "1 IN 100 MIN." or "1 IN 25" (short pipe).
2. *Custom + Auto-Calc:* second invert not actually computed from the typed Custom value.
3. *Multi-segment:* same misbehaviour; total polyline length wasn't reflected in the computed inverts.
4. Editing inverts on plan via CDEDIT did NOT refresh the "AT 1 IN N" pipe text.

**Expected behaviour:**
- Default + Auto-Calc → drop ≥ length/100 at 2dp precision (always 1:100 or steeper); label always reads "1 IN 100" — no MIN./MAX. suffix ever.
- Custom N + Auto-Calc → drop ≥ length/N at 2dp; label "1 IN N".
- Multi-segment → uses total polyline length.
- 2dp invert precision throughout.
- CDEDIT refreshes the grade label whenever inverts are edited.

**Reference:**
- `Helpers/MathHelper.cs` — `CalculateInvertDrop` and `ApplyCalculatedInvertRule` rewritten.
- `Commands/CdCommand.cs` — `BuildGradeValue` returns configured grade verbatim for Default+AutoCalc; `FormatGradeForDisplay` reduced to direct normalisation (band rules removed).
- `Commands/PipeEditCommand.cs` — `BuildGradeValue` aligned with CD; `ResolveEffectiveGradeMode` returns "inverts" for Default+both-inverts case so CDEDIT refreshes the label.
- `Models/UserSettings.cs` — `DefaultMinimumValue` default changed to `"100"`.

**Status:** ✅ Built 2026-05-19. 78 grade tests green on net48 and net10.0-windows. Full per-step AutoCAD test checklist lives in REGRESSION_LOG.md under **BUG-118** (the regression log uses its own sequential numbering — BUG-118 there ↔ BUG-024 here). Awaiting Tim's AutoCAD confirmation.

**Known leftover (parked for next round):**
- CDEDIT Rising Main destination still hardcoded to "WT" — TODO marker in code, separate touch-up.
- CDPROPAGATE per-pipe override input still doesn't parse " MIN." / " MAX." suffix.

**Note (2026-05-20 retest results):**
- T6 ✓ (CDEDIT refresh on invert edit).
- T4 ✗ — Tim entered Custom 80 + AutoCalc and got "1 IN 100 MIN." (Default path leaking past Custom). Fix this batch: hoisted Custom check above Default in `BuildGradeValue` so Custom always wins.
- T3 partial — Default + Auto-Calc had no "MIN." suffix for steeper-than-configured grades. Fix this batch: BUG-027 adds the suffix back via `MathHelper.ApplyMinimumGradeSuffixRule` (band rule [N-3, N] = no suffix, steeper = `{N} MIN.`).
- T5 partial — Inspector showed wrong grade (15 m × 0.150 m → "1:94"). Fix this batch: BUG-026 aligns Inspector rounding with CD's pipe-text rounding (Math.Round AwayFromZero).
- Invert input value drift (1.10 → 1.11) reported across T3/T4/T5 — fixed this batch as BUG-025 (IEEE 754 pre-round before Math.Ceiling).

**Status:** PARTIAL — most issues fixed this batch (BUG-025, BUG-026, BUG-027, T4 fix). T6 ✓.

**Note (round 3, 2026-05-20):** Tim's 2026-05-20 retest STILL showed "1 IN 100 MIN." after picking Custom 80 + AutoCalc. Existing unit tests pass — the dialog runtime state must transiently lose `IsGradeCustom` during a WPF toggle binding race while `CustomGrade` still has the typed value. New round 3 fix introduces `CdCommand.IsCustomGradeEffective(vm)` predicate (single source of truth based on EITHER the flag OR the textbox value) + diagnostic logging at every grade decision, so the next failure surfaces the actual VM state in the log.

**Status (round 3):** IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test.

---

## BUG-025

**Command / Area:** `CD` auto-calc — invert display drift (e.g. typed `1.10` displays as `1.11`).

**Symptom:** Tim noticed across T3, T4, T5 that an entered invert of `1.10` reproducibly displays as `1.11` on the drawing for short pipes. Affects every pipe under those tests.

**Expected behaviour:** Typed invert is preserved at 2 dp; the computed (auto-calc'd) opposite-end invert is exactly `typed ± L/N` at 2 dp precision.

**Reference:** `Helpers/MathHelper.cs` — `CalculateInvertDrop` + `ApplyCalculatedInvertRule`.

**Root cause:** `Math.Ceiling(distance / grade * 100.0) / 100.0` is bitten by IEEE 754 floating-point noise — `5.0 / 100.0 * 100.0` evaluates to `5.000000000000001` on some inputs, which ceilings to `6` and yields a drop of `0.06` instead of the expected `0.05`. One cent of overshoot in the drop bumps the computed opposite end by 1 in the last decimal place.

**Fix (2026-05-20):** pre-round the scaled value to 9 dp before `Math.Ceiling`:
- `Math.Round(raw * 100.0, 9, AwayFromZero)` neutralises the ULP-scale noise while preserving fractional cents that should round up.
- Applied in both `CalculateInvertDrop` and the inner drop-ceiling step of `ApplyCalculatedInvertRule`.

**Test:** `MathHelperTests.CalculateInvertDrop_5mAt100_StaysAt0_05`, `_1mAt100_StaysAt0_01`, `_8mAt100_StaysAt0_08`, `_15mAt100_StaysAt0_15` (added 2026-05-20). All passing.

**Note (round 2, 2026-05-20):** Tim's T3/T4/T5 retest STILL produced `1.10 → 1.11` on SHORT pipes. The round 1 IEEE fix solved the long-pipe drift but did NOT address the minDrop interaction. When the user typed the DOWNSTREAM invert and the pipe is short enough that `minDropMm` exceeds the natural drop, the `ApplyCalculatedInvertRule` function (which always treated `inlet` as authoritative) shifted the user's value by `minDrop − rawDrop`.

**Code fix (round 2, 2026-05-20):** new `ApplyCalculatedInvertRule` overload with `preserveInlet` flag. When `preserveInlet=false` (= user typed the downstream), `outlet = Round(rawOutlet)` is preserved and the inlet is computed UP from there. `CdCommand` + `PipeEditCommand` now pass `preserveInlet = !autoCalcDownToUp` so the user-typed end always round-trips verbatim. Legacy 4-arg signature kept for back-compat (defaults to preserveInlet=true). 4 new tests cover both directions and minDrop.

**Status:** IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test.

---

## BUG-026

**Command / Area:** CE Inspector — grade panel reports a denominator that disagrees with the pipe-text label.

**Symptom:** T5 — 15 m pipe with exactly 1:100 fall (drop 0.150 m). Pipe-text label says "1 IN 100" (correct). Inspector grade panel says "1:94".

**Expected behaviour:** Inspector grade should agree with the pipe-text label when both read the same inverts.

**Reference:** `Services/InspectorPaletteService.cs` — `BuildPipeHealthWarnings` (line ~1779 was using `gradeN:F0` for display, while CD's `BuildGradeValue` uses `Math.Round(grade, AwayFromZero)`).

**Root cause:** `F0` format uses banker's rounding (`ToEven`); `Math.Round(grade, MidpointRounding.AwayFromZero)` does not. For grades sitting near a half-value, the two methods produce different integer denominators. CD's pipe-text rounds away-from-zero (the canonical CE choice); Inspector rounded banker's-style.

**Fix (2026-05-20):** Inspector now rounds with the same `Math.Round(_, AwayFromZero)` policy CD uses. Both the achieved-grade display and the configured-minimum display switched from `F0` to `long`-cast rounded values.

**Test:** Manual — exercise in Inspector with a 15 m × 0.150 m pipe and confirm "1:100".

**Note (round 2, 2026-05-20):** Tim still saw "1:94". The Inspector code rounding is correct — the wrong number must come from wrong STORED inverts. That's the BUG-025 bug, not a separate Inspector bug. With BUG-025 round 2 fix (`preserveInlet` overload) the stored values now match the typed values, so Inspector reads back correctly. Additional diagnostic log added to Inspector grade path so stored vs computed values are visible per-pipe.

**Status:** IN PROGRESS — coded 2026-05-20 (transitive via BUG-025 round 2), awaiting Tim's AutoCAD test.

---

## BUG-027

**Command / Area:** `CD` / `CDEDIT` — Default-Minimum + Auto-Calc " MIN." suffix policy.

**Symptom:** Tim wants the `MIN.` suffix on the pipe-text label when Auto-Calc produced a grade steeper than the configured minimum (the standard CE drafting convention). The 2026-05-19 fix stripped the suffix entirely. T3 results showed flat "1 IN 100" labels for steep pipes where Tim expected "1 IN 100 MIN.".

**Expected behaviour (Default-Minimum + Auto-Calc only):**
- Achieved within `[N - 3, N]` band → label `1 IN {N}` (no suffix).
- Achieved < N-3 (steeper) → label `1 IN {N} MIN.`.
- Achieved > N (shallower — auto-calc anomaly) → log warning AND label `1 IN {N} MIN.`.
- Custom mode → label is the exact configured grade, NEVER suffixed.
- Default-Standard mode → label is the exact configured grade, NEVER suffixed (Standard means "the design grade", not "the minimum").

**Reference:** `Helpers/MathHelper.cs` — new `ApplyMinimumGradeSuffixRule` helper. Wired into `CdCommand.BuildGradeValue` and `PipeEditCommand.BuildGradeValue` via new `ApplyDefaultAutoCalcGradeSuffix` helpers in each command.

**Fix (2026-05-20):** new pure helper that takes `configured` and `achieved` denominators, returns the label string (with or without suffix). `FormatGradeForDisplay` updated to PRESERVE a present " MIN." / " MAX." suffix (the BUG-024 stripping behaviour kept everything else the same).

**Test:** 8 new MathHelper tests cover the band rule + shallower-than-min anomaly. `GradeAutoCalcTests` extended with `Custom + AutoCalc` and `Default + AutoCalc + steeper-than-config` cases. All passing.

**Note (round 2, 2026-05-20):** Tim's clarification "within 2 or 3 grades of 100" — the round 1 band was half-open `[N-3, N]` which over-suffixed mild overshoots. Round 2 made the band SYMMETRIC `[N-3, N+3]`. Above-band (achieved > N+3) now produces a NEW " MAX." suffix instead of the legacy "log warning + still MIN." behaviour. Tests rewritten: explicit upper boundary at N+3, MAX. at N+4 / N+100.

**Status:** IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test.

---

## BUG-028

**Command / Area:** `CDSTRIP` — Floor Waste corner / end placement.

**Symptom:** After BUG-022 fix landed every Floor Waste on the centerline of the strip drain. Middle FWs (mid-segment, interior) look right. But the FW at every OPEN END sits flush against the open edge — Tim wants it pulled 50 mm inwards along the strip travel direction so the open end has visible "shoulder" geometry. Similarly, FWs at corners (vertex where two segments meet) sit ON the vertex. Tim wants them pulled 25 mm in along EACH of the two meeting strip directions (a 25 mm step in both directions) so the FW sits inset INTO the elbow of the corner.

**Expected behaviour:**
- First / last vertex of an OPEN polyline → 50 mm inset along the single adjacent strip direction.
- Interior vertex (corner) → 25 mm in each of incoming + outgoing strip directions.
- Closed polyline → every vertex is a corner.

**Reference:** `Commands/StripDrainCommand.cs` — new `ApplyVertexInset` method called from `PlaceFloorWasteBlocks` after the existing `ComputeCornerCenterlinePoint` shift.

**Status:** IN PROGRESS — coded 2026-05-20 (Batch B), awaiting Tim's AutoCAD test. Constants `FLOOR_WASTE_END_INSET_MM = 50` and `FLOOR_WASTE_CORNER_INSET_MM = 25`. `ApplyVertexInset` promoted to `internal static` with 8 pure-math unit tests passing on net48 + net10.

---

## BUG-029

**Command / Area:** `CDSTRIP` — fall arrow style.

**Symptom:** Tim wants the existing CDSTRIP fall arrow (filled polygon arrow at segment midpoint) replaced with a QLeader using the `25DIMS` leader style (Tim's preferred leader type), flowing TOWARDS each Floor Waste.

**Expected behaviour:** QLeader instead of filled polygon. Style = `25DIMS`. One leader per segment, head pointing TOWARDS the nearest FW.

**Reference:** `Commands/StripDrainCommand.cs` — `PlaceFlowArrowsPerSegment` (current filled-polygon implementation). Replace with `MLeader` API call using the `25DIMS` style.

**Code fix (2026-05-20, Batch B):** Removed `PlaceFlowArrowsPerSegment` + `AppendArrowSolid` + dead constants entirely. New `PlaceFallArrowMLeaders(doc, placedFwList)` creates one `MLeader` per Floor Waste on layer `25DIMS` (auto-ensured), inheriting the database's active mleader style (`db.MLeaderstyle` — picks up Tim's "CE / TIM" style if active). Arrowhead AT the FW; text "FALL" 1500 mm upstream of it. `PlaceFloorWasteBlocks` now returns `List<FloorWastePlacement>` (position + upstream unit vector) so the MLeader pass has the per-FW geometry it needs.

**Status:** IN PROGRESS — coded 2026-05-20 (Batch B), awaiting Tim's AutoCAD test.

---

## BUG-030

**Command / Area:** `CD` — Rising Main continuation prompt (F12 dynamic input).

**Symptom:** After placing the first half of a split rising main, the next-pipe prompt shows the keyword shortcut `[Yes/Ce]` in the F12 dynamic input. Should be `[Yes/No]`.

**Expected behaviour:** AutoCAD's dynamic input shows `[Yes/No]` for the continuation prompt.

**Reference:** `Commands/CdCommand.cs` — rising main breakline branch. The `PromptKeywordOptions` keyword string is likely `Yes\nNo` but the second keyword's display abbreviation is being collapsed to "Ce" — possibly because "C" / "Ca" are taken by other keywords in scope. Add an explicit `.Keywords.Add("No", "No", "No")` with the third-argument display alias.

**Code fix (2026-05-20, Batch B):** Root cause was NOT the keyword list — it was the leading `[CE]` literal in the prompt TEXT. AutoCAD's F12 dynamic input grabs the FIRST `[…]` bracket as the keyword list, then merges it with the actual `[Yes/No]` to render `Yes/Ce`. Fix: replaced the leading `[CE]` prefix with `CE:` (colon, no brackets) on the two surviving rising-main prompts in `CdCommand.cs`. Third prompt (BUG-031) is replaced entirely by a popup.

**Status:** IN PROGRESS — coded 2026-05-20 (Batch B), awaiting Tim's AutoCAD test. Going forward: project-wide convention is `CE:` prefix (not `[CE]`) for all CE prompts.

---

## BUG-031

**Command / Area:** `CD` — Rising Main continuation UX.

**Symptom:** The continuation prompt is currently a command-line / F12 prompt. Tim wants it surfaced as a WPF popup dialog — easier to spot during a multi-plan workflow.

**Expected behaviour:** When user is about to place the second half of a split rising main, show a popup ("Continue from previous rising main? [Yes] [No]") instead of a command-line prompt.

**Reference:** `Commands/CdCommand.cs` — rising main continuation branch.

**Code fix (2026-05-20, Batch B):** New `Dialogs/ContinueRisingMainDialog.xaml(.cs)` — minimal WPF modal with one-line label "Continue this rising main on another plan?" + Yes/No buttons. ESC = No (safe default — no breakline placed); Enter = Yes (default). Replaces the cmd-line `PromptKeywordOptions` block in `PromptBasementHalfBreakline` with a `PromptContinueRisingMainPopup()` helper that wraps the dialog in `DialogService.ShowDialog`. Failsafe: any dialog exception falls back to default No + log warning.

**Status:** IN PROGRESS — coded 2026-05-20 (Batch B), awaiting Tim's AutoCAD test.

---

## BUG-032

**Command / Area:** CE Inspector — Rising Main linked halves.

**Symptom:** When the user clicks on either half of a split rising main, CE Inspector does NOT show that this pipe is linked to its partner half (no field, no warning, no cross-link indicator).

**Expected behaviour:** Inspector should show a field like "Linked to: handle XYZ (basement half)" or "Linked to: handle XYZ (continuation half)" with a click-to-zoom option.

**Reference:** `Services/InspectorPaletteService.cs` — extend the pipe panel build to read `LinkService.TryGetBreaklineLink` and surface the partner handle.

**Code fix (2026-05-20, Batch B):** New `PipeRisingMainPairing` (text), `HasPipeRisingMainPairing` (bool), `PipeRisingMainPartnerHandle` properties on `InspectorViewModel`. New `PopulateRisingMainPairing(pipeOid)` called from `PopulatePipe` — reads `LinkService.TryGetBreaklineLink` and emits "⇔ Linked half: {handle} ({role})" / "⇔ Awaiting continuation at ({x},{y}) ({role})" depending on data state. New highlighted `Border` in `InspectorPanelControl.xaml` shows only when `HasPipeRisingMainPairing` is true. Combined-inverts line (BUG-038) lives inside the same border.

**Status:** IN PROGRESS — coded 2026-05-20 (Batch B), awaiting Tim's AutoCAD test.

---

## BUG-033

**Command / Area:** Small-diameter pipe (DIA < 100 mm) — flow arrow placement.

**Symptom:** For small-diameter pipes (e.g. 50 mm DIA risers), the flow arrow is inserted too far from the pipe line — visually disconnected from the pipe it should be annotating.

**Expected behaviour:** Arrow offset should scale with pipe radius (the existing offset is probably a hard-coded `125 mm` that's correct for 150-300 mm pipes but excessive for 50 mm pipes).

**Reference:** `Services/PipeCreationService.cs` / `Services/ArrowService.cs` — find the arrow-offset constant. Replace with `Math.Max(pipeRadius + 125, MIN_VISIBLE_OFFSET)` or similar.

**Note (2026-05-20):** Root cause was NOT the `ARROW_OFFSET` constant — it was the lane-bumping logic in `PipeCreationService`. For a 50 mm pipe at lane 0, the natural offset is `25 + 125 = 150 mm` (correct). The +275 leakage came from the clash detection check (fixed 200 mm search radius) false-triggering on the pipe's own MLINE and bumping the arrow to lane 1 (+275 mm = total 425 mm — exactly what Tim measured).

**Code fix (2026-05-20):** `Services/PipeCreationService.cs` — clash detection radius now scales with pipe diameter: `clashRadius = Math.Max(pipeRadius + 25 mm, 80 mm)`. Tight enough that small pipes don't self-trigger; large enough (≥80 mm) that 600 mm pipes still detect real clashes. Diagnostic log on bump. New `ArrowOffsetTests` (9 tests) cover the offset formula and clash-radius computation.

**Status:** IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test.

---

## BUG-034

**Command / Area:** `CD` / `CDEDIT` — Rising Main continuation mode auto-pick.

**Symptom:** After placing the first half of a split rising main, the next CD invocation with `Rising Main` selected does NOT automatically default to "Continuation mode" — Tim has to manually answer the continuation prompt. Tim wants the dialog to AUTO-PICK continuation when an unmatched basement half exists.

**Expected behaviour:** On CD or CDEDIT with Rising Main + Place Breakline, if there's already an open basement half in the drawing (one without a paired continuation), default to Continuation mode without prompting.

**Reference:** `ViewModels/CdViewModel.cs` initialization — query `LinkService` for unmatched basement halves at dialog open.

**Code fix (2026-05-20, Batch B):** Simpler version per brief — `UserSettings.Options.LastIsRisingMainBreakline` persists across CD invocations and is restored by `ApplyStoredSettings` (already wired since PARK-032). Added a diagnostic log line in `CdViewModel.ApplyStoredSettings` that surfaces the persisted flag on every restore so Tim can confirm in the log. Full auto-detection of unpaired first-halves at dialog-open is deferred as **BUG-034b** — relies on calling `LinkService.TryFindUnpairedBreaklineRisingMain` from the VM constructor with extra error handling because the VM is instantiated outside an AutoCAD transaction.

**Status:** IN PROGRESS — coded 2026-05-20 (Batch B), awaiting Tim's AutoCAD test.

---

## BUG-035

**Command / Area:** Rotated UCS — PIT placed inside or right after CD.

**Symptom:** T22 — with a rotated UCS active, run `CD` to place a pipe, then immediately run `PIT` to place a pit. The pit rotates by itself (block reference acquires a non-zero rotation independent of the user's input). Standalone PIT (T24) works fine.

**Expected behaviour:** PIT block must NOT acquire a rotation from the rotated UCS — must always be placed at rotation = 0 in WCS (or whatever the user specified).

**Reference:** UCS guard service set up via BUG-017 swaps UCS to World on command start and restores on end. The CD command's UCS restore on End is happening BEFORE the next command (PIT) reads UCS — so PIT runs in the user's rotated UCS again, but maybe the block insertion code that reads the world-rotation isn't transforming correctly.

**Investigation hint:** Compare `PitCommand` block insertion vs `CdCommand` block insertion. Both should use `BlockService.InsertBlock(rotation: 0.0)` which expects WCS rotation. If PIT is being passed `ed.CurrentUcs.Rotation` somewhere it should be using `0.0`, that's the bug.

**Code fix (2026-05-20):** pragmatic defensive measure in `PitCommand` — `BlockService.InsertBlock` is already called with `rotation=0.0`; after insertion we re-open the block reference in a fresh transaction, read `BlockReference.Rotation`, and force it to `0.0` if non-zero. This is a no-op when the original call succeeded and a rescue when an upstream source has injected a rotation. Diagnostic log emitted when the zero-out actually triggered so the residual rotation magnitude is visible. New `UcsGuardService.GetActiveSavedUcsRotationRadians` API added for future UCS-aware variants (not used in this batch).

**Status:** IN PROGRESS — coded 2026-05-20, awaiting Tim's AutoCAD test.  Note this is a defensive fix that masks the root cause. The next round can chase the upstream rotation source using the diagnostic log.

---

## BUG-036

**Command / Area:** Pit cover-level MText — survives MIRROR operation while staying linked to parent pit.

**Symptom:** When the user runs AutoCAD's native `MIRROR` command on a pit + its cover-level MText, the MText loses its attachment record to the parent pit. CDEDIT then sees them as two separate entities.

**Expected behaviour:** The mirror operation must preserve the `LinkService` attachment record. After mirror, CDEDIT still recognises the MText as linked to the pit.

**Reference:** `Services/LinkService.RepairAudit.*` — the attachment record is stored on the pit's extension dictionary. AutoCAD's MIRROR does NOT replicate extension dictionaries to the mirrored copy. A reactor or post-process hook is needed.

**Code fix (2026-05-20, Batch B):** Pragmatic option (c) per brief — new `CDREFRESHLINKS` command. Walks every pit, reads each linked attachment's stored offset, and forces the attachment's position to `pit.Position + offset`. Re-running after MIRROR snaps stranded text back into place. New `Services/LinkService.RefreshLinks.cs` (`LinkService.RefreshAllPitAttachments(db)`), `Commands/RefreshLinksCommand.cs`, command registry entry. Option (a) — making the cover text an attribute of the PIT BLOCK 2 — was DEFERRED because the brief lists "editing PIT BLOCK 2.dwg in BEDIT" as a STOP condition. Documented for the next round.

**Status:** IN PROGRESS — coded 2026-05-20 (Batch B), awaiting Tim's AutoCAD test.

---

## BUG-037

**Command / Area:** Installer payload — `PIT BLOCK 2.dwg`.

**Symptom:** BUG-018 confirmed PIT BLOCK 2 works locally on Tim's machine. Need to verify the installer ships `PIT BLOCK 2.dwg` to other CE machines (the existing build_installer.ps1 stages it; need to confirm the rolled MSI/EXE actually contains it).

**Expected behaviour:** Every CE_CVL_SUITE.bundle install across the office has `Contents\Blocks\PIT BLOCK 2.dwg` present.

**Reference:** `CE_CVL_SUITE\Installer\build_installer.ps1` (5-minute audit — confirm file is in the file list, confirm the staging step copies it, confirm a fresh build of the installer .EXE/.MSI lists it via `7z l` or similar).

**Audit result (2026-05-20, Batch B) — verified, no code change required:**
- `Installer/build_installer.ps1` line 56 lists `"PIT BLOCK 2.dwg"` in the `$blocks` array copied to `bundle/Contents/Blocks/`.
- `Installer/source_blocks/PIT BLOCK 2.dwg` is present and tracked in git.
- `Installer/payload_build/CE_CVL_SUITE.bundle/Contents/Blocks/PIT BLOCK 2.dwg` is staged in the most recent build output.
- `Services/BlockService.cs::GetBlockFilePath` resolves the bundle `Contents/Blocks` folder FIRST (line ~93–96), and `GetBlockNameVariants` returns `"PIT BLOCK 2"` as the FIRST variant for any "PIT BLOCK" request — so installed plugins find PIT BLOCK 2 ahead of any user-writable fallback.

**Status:** IN PROGRESS — verified 2026-05-20 (Batch B). No code change; awaiting Tim's installer-build + colleague-machine confirmation.

---

## BUG-038

**Command / Area:** CE Inspector — paired rising-main inverts displayed as one merged row.

**Symptom:** Tim's T16: Inspector showed each rising-main half as a separate pipe row with its own SPS / breakline / destination inverts. Because the breakline-end invert is shared between the two halves, the same number appeared in both halves — making the link feel disconnected even with the BUG-032 badge.

**Expected behaviour:** For a paired rising main, Inspector shows a single combined invert line: `SPS IL X → breakline IL Y → destination IL Z`. The underlying data model (two separate Polylines + PipeData rows) is unchanged — only the presentation merges.

**Reference:** `Services/InspectorPaletteService.cs` — extend `PopulateRisingMainPairing` (the BUG-032 helper) to ALSO resolve the partner pipe's PipeData and emit a combined-inverts string.

**Code fix (2026-05-20, Batch B):**
- `ViewModels/InspectorViewModel.cs` — new `PipeRisingMainCombinedInverts` (string) + `HasPipeRisingMainCombinedInverts` (bool).
- `Services/InspectorPaletteService.cs` — new `BuildPairedInvertSummary(thisHalfId, partnerHandle, thisIsContinuationHalf)`. Resolves partner by handle hex via `db.TryGetObjectId`; reads both halves' `PipeData` from ProjectDataService; emits `"SPS IL {basement.From} → breakline IL {basement.To ?? continuation.From} → destination IL {continuation.To}"`. Order independent of which half is selected.
- `Controls/InspectorPanelControl.xaml` — the BUG-032 badge `Border` now wraps a `StackPanel` with the original link line + a second TextBlock bound to `PipeRisingMainCombinedInverts` with its own `Visibility` so the badge still appears even when only the link (not the inverts) is resolvable.

**Status:** IN PROGRESS — coded 2026-05-20 (Batch B). Round 4 (2026-05-21, R4.8) added diagnostic logging to `PopulateRisingMainPairing`. Awaiting Tim's AutoCAD test — the log will surface why the badge stays blank when Tim expects it.

---

## BUG-040

**Command / Area:** `CDWT` — pit-detention mode (R4.10 / round 4 / 2026-05-21).

**Symptom:** Tim's request: "if I select a pit, it should just ask for total capacity then how much detention and the reuse is just the difference between the two and then the callout doesn't use an mleader like cd command at all it just inserts text".

**Expected behaviour:**
- CDWT command-line offers a pit pick first.  If a pit is picked, prompt total capacity then detention; derive reuse = total − detention; insert a plain MText callout on layer 25TEXT above the pit; skip the riser/dropper prompts.
- If the user presses Enter (no pit), fall back to the legacy water-tank flow.

**Reference:** `Commands/WaterTankCommand.cs` — `TryRunDetentionPitMode`, `BuildPitDetentionCalloutText`, `ResolvePitTag`.

**Status:** RETIRED FROM CDWT — 2026-09-13. Tim: "This command is for water tanks only". The `TryRunDetentionPitMode` / `BuildPitDetentionCalloutText` / `ResolvePitTag` branch was removed in the CV4-9/15 CDWT rebuild; annotating an existing detention pit needs its own reviewed card before it returns as a separate tool.

---

## BUG-041

**Command / Area:** `CD` — Custom grade multi-segment polyline support (R4.11 / round 4 / 2026-05-21).

**Symptom:** Tim picked Custom grade and tried to draw a 4-vertex polyline. Plugin warned "Custom grade selected — limited to straight pipe (2 points)" and stopped accepting clicks after the second point.

**Expected behaviour:** Custom grade allows any number of segments. Pipe label uses the total polyline length divided by the actual achieved drop (per R4.1) for grade display.

**Reference:** `Commands/CdCommand.cs` — vertex collection loop.

**Code fix:** Removed the `allowMultiple` short-circuit that rejected multi-segment Custom polylines.

**Status:** IN PROGRESS — coded 2026-05-21, awaiting Tim's AutoCAD test.

---

## BUG-042

**Command / Area:** `CD` — regular (gravity) pipe breakline (R4.12 / round 4 / 2026-05-21).

**Symptom:** Tim wants the breakline mechanism to apply to non-rising-main pipes too, so a gravity pipe can be split across plans the same way. Direction reverses: the basement / destination side is the LOW invert, not the high one.

**Expected behaviour:** A new "Place breakline" toggle visible for ALL pipe types (not just Rising Main). Linkage logic identical to the rising-main case.

**Reference:**
- `ViewModels/CdViewModel.cs` — `IsGravityBreakline`, `ShowGravityBreaklineToggle`, `IsAnyBreaklineRequested`.
- `Commands/CdCommand.cs` — breakline gate uses `vm.IsAnyBreaklineRequested` instead of `IsRisingMain && IsRisingMainBreakline`.

**Status:** IN PROGRESS — coded 2026-05-21, awaiting Tim's AutoCAD test. UI gating in the CD dialog XAML still needs Tim's UX confirmation on where to surface the new toggle.

---

## Round 6 (2026-05-22) — 14-item batch summary

All entries below: `IN PROGRESS — coded 2026-05-22 (R6), awaiting Tim's AutoCAD test`.  Round 6 corrects the R5 / R5b output Tim rejected.  Full detail in `CE_CVL_SUITE/REGRESSION_LOG.md` under the "Round 6 (2026-05-22)" section.

| ID | Area | Status |
|----|------|--------|
| [R6.1](#r6-1) | `CD` — Continuation-of-previous-pipe toggle (manual; removes R5.3 auto-detect) | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.2](#r6-2) | `CD` — remove old "Place Breakline" RM-specific button | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.3](#r6-3) | `CD` — Cross-plan break grade uses COMBINED length | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.4](#r6-4) | `CD` — Same-plan break: visual split + REAL length + two glyphs | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.5](#r6-5) | `MOVE / MIRROR` cover-text displacement-tracking cache | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.6](#r6-6) | `CD` — breakline rotation: 0° offset (was +π/2) + diagnostic log | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.7](#r6-7) | `CD` — Custom + AutoCalc crash; single-source-of-truth grade | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.8](#r6-8) | `CD` — "1 IN 100 MIN." suffix in Default + one-invert + no AutoCalc | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.9](#r6-9) | `CDSTRIP` — corner FW corner-only shift, no centerline stack | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.10](#r6-10) | `CDSTRIP` — fall arrows via native Leader + TIM LEADER dimstyle | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.11](#r6-11) | `CDSTRIP` — new STRIP DRAIN layer (ACI 10); 25DIMS reverted | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.12](#r6-12) | `CD` — Rising main downhill warning | IN PROGRESS — coded 2026-05-22 (R6) |
| [R6.13](#r6-13) | Pit UI regression — investigated; no recent git change to PitDialog | IN PROGRESS — coded 2026-05-22 (R6); awaiting Tim's specific repro |
| [R6.14](#r6-14) | Revert R5b `PipeDirectionHelper` overshoot at PipeCreationService + InspectorPaletteService | IN PROGRESS — coded 2026-05-22 (R6) |

### R6.1
**Command / Area:** `CD` — manual continuation toggle (replaces R5.3 auto-detect).
**Fix summary:** New `IsContinuationOfPrevious` ToggleButton in PIPE BASICS.  When ON, plugin scans for an unpaired cross-plan break anchor.  Found → pipe-type locked, banner shown.  Not found → inline warning + Start disabled.  Mutex with Cross-plan / Same-plan break.
**Status:** IN PROGRESS — coded 2026-05-22 (R6), awaiting Tim's AutoCAD test.

### R6.2
**Command / Area:** `CD` PIPE BASICS — legacy RM breakline toggle.
**Fix summary:** "Place Breakline (basement ↔ ground crossover)" ToggleButton removed from CdDialog.xaml.  Cross-plan break (Item 1) replaces it for all pipe types.  Viewmodel property `IsRisingMainBreakline` remains, written only via `IsCrossPlanBreak` setter mapping.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).

### R6.3
**Command / Area:** `CD` — grade calc for paired half-pipes.
**Fix summary:** New helper `CdCommand.GetCombinedBreaklineLengthMm` returns `ownLength + partnerLength` when paired.  Wired into `LinkService.Utilities.cs::UpdatePipeGradeFromInverts` and `InspectorPaletteService.cs::CollectPipeWarnings`.  Same helper handles same-plan break REAL length (Item 4).
**Status:** IN PROGRESS — coded 2026-05-22 (R6).  Tests: `BreaklineGradeTests`.

### R6.4
**Command / Area:** `CD` — same-plan break workflow.
**Fix summary:** `TryPlaceSamePlanBreak` rewritten — two pick points, polyline split into halfA / halfB, two breakline glyphs at the break endpoints, real-length prompt with default = drawn length.  New XData on `PipeLinkData`: `SamePlanBreakPartnerHandle`, `SamePlanBreakRealLengthM`, `SamePlanBreakRole`.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).

### R6.5
**Command / Area:** `LinkService.PipeMoveHelpers.cs::MovePitAttachments`.
**Fix summary:** Replaced R5b unconditional live-wins with per-attachment displacement-tracking cache.  Decision matrix: pit moved + text stayed put → apply pitDelta; text moved independently → accept new baseline; text already followed → no extra move.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).  Tests: `PitTextDisplacementTests` (5 scenarios).

### R6.6
**Command / Area:** `CD` BREAKLINE block rotation.
**Fix summary:** `authoredOffset` reduced from `+π/2` to `0` in `TryPlaceRisingMainBreakline`.  Diagnostic log records `pipeAngle / authoredOffset / appliedRotation` so the offset can be tuned if the block was authored differently.  BREAKLINE.dwg is not in source_blocks — could not programmatically inspect authored angle.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).

### R6.7
**Command / Area:** `CD` GRADE + AutoCalc.
**Fix summary:** Separate "1 in N" AutoCalc textbox REMOVED.  `TryGetAutoCalcGrade` reads from `vm.CustomGrade` (Custom mode) or configured default (Default mode).  Eliminates the two-fields-out-of-sync crash.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).  Tests: `GradeAutoCalcTests.BuildGradeValue_CustomPlusAutoCalc_DoesNotCrash_LabelIsCustomVerbatim`.

### R6.8
**Command / Area:** `CD` pipe text label — Default + one invert + AutoCalc OFF.
**Fix summary:** `BuildGradeValue` appends ` MIN.` to the configured default in this case.  Trailing period included.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).  Tests: `GradeAutoCalcTests.BuildGradeValue_DefaultMode_OneInvertNoAutoCalc_ReturnsMinSuffix`.

### R6.9
**Command / Area:** `CDSTRIP` corner FW placement.
**Fix summary:** `PlaceFloorWasteBlocks` — at a CORNER, use the raw vertex as the base position (NOT the centerline-corrected position) before applying the corner perpendicular-into-strip shift.  No more 75 mm stack.  END FWs and intermediate FWs unchanged.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).  Tests: existing `StripDrainInsetTests`.

### R6.10
**Command / Area:** `CDSTRIP` fall arrows.
**Fix summary:** `EmitSingleArrow` now creates a native `Leader` entity using the TIM LEADER dimstyle.  Polyline + Solid-triangle geometry removed.  `EnsureLeaderDimstyle` imports the dimstyle from `CE_A1_C01 - VERTICAL.dwg` when absent.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).

### R6.11
**Command / Area:** `CDSTRIP` layers.
**Fix summary:** `LAYER_FALL_MLEADER` now points to `LAYER_STRIP_DRAIN` (was `25DIMS`).  Strip drain MLINE + fall arrows on STRIP DRAIN (ACI 10, CONTINUOUS).  Floor Wastes unchanged.  Previous `EnsureLayer(25DIMS, …)` call removed — 25DIMS is now untouched by CDSTRIP.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).

### R6.12
**Command / Area:** `CD` CURRENT STATUS warnings — rising main downhill.
**Fix summary:** `TryGetInvertWarning` fires for rising-main pipes when downstream invert is LOWER than upstream invert.  Text: `"Downstream invert is lower than upstream. Rising main flow is uphill — check inverts."`  Gravity warning unchanged.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).

### R6.13
**Command / Area:** Pit dialog UI.
**Investigation:** Git history shows `PitDialog.xaml` last modified in V2.1 sweep (commit `2ba980ac`) — long before R5/R5b.  No regression source is visible in recent committed code.
**Status:** Awaiting Tim's specific repro — leaving PitDialog at V2.1 state until clarified.

### R6.14
**Command / Area:** Revert R5b overshoot.
**Fix summary:** PipeCreationService arrow-swap restored to `if (RisingMain && Second > First) swap`.  InspectorPaletteService `gravity` predicate restored to `pipeType != PipeType.RisingMain`.  Helper class `PipeDirectionHelper` retained but only used where Items 1/3/12 explicitly require it.
**Status:** IN PROGRESS — coded 2026-05-22 (R6).

---

## Round 5 (2026-05-22) — 14-item batch summary

All entries below: `IN PROGRESS — coded 2026-05-22, awaiting Tim's AutoCAD test`.

| ID | Area | Status |
|----|------|--------|
| [BUG-CDAGI](#bug-cdagi) | `CDAGI` — recursion fix + AG_LINE template import | IN PROGRESS — coded 2026-05-22 |
| [BUG-CDPERP](#bug-cdperp) | `CD` — perpendicular invert text diagnostics + truth-table tests | IN PROGRESS — coded 2026-05-22 |
| [BUG-CDCONT](#bug-cdcont) | `CD` — continuation popup → in-dialog banner + pipe-type lock | IN PROGRESS — coded 2026-05-22 |
| [BUG-CDBR](#bug-cdbr-rot) | `CD` — breakline glyph rotation +90° | IN PROGRESS — coded 2026-05-22 |
| [BUG-036-R5](#bug-036-r5) | `MIRROR / MOVE` cover text staleness check unconditional | IN PROGRESS — coded 2026-05-22 |
| [BUG-CDWT](#bug-cdwt) | `CDWT` — MLeader callout + drop reuse prompt | IN PROGRESS — coded 2026-05-22 |
| [BUG-CDGR](#bug-cdgr) | `CD` GRADE UX redesign (Default/Custom, AutoCalc N, mismatch popup) | IN PROGRESS — coded 2026-05-22 |
| [BUG-CDBR-8](#bug-cdbr-toggles) | `CD` — Cross-plan / Same-plan break toggles | IN PROGRESS — coded 2026-05-22 |
| [BUG-CDDIR](#bug-cddir) | `CD` Pipe direction helper (rising main UP, gravity DOWN) | IN PROGRESS — Round 5b 2026-05-22 (per-call-site adoption + 13 unit tests) |
| [BUG-CDPP](#bug-cdpp) | `CD` Pipe preview redesign (bigger text, layer colour, typed IL, label, arrow) | IN PROGRESS — Round 5b 2026-05-22 (full redesign + VM properties wired) |
| [BUG-CDLAYOUT](#bug-cdlayout) | `CD` Text & Arrow section sizing | IN PROGRESS — Round 5b 2026-05-22 (preview row shrunk 140→112) |
| [BUG-CDSTRIP](#bug-cdstrip) | `CDSTRIP` — corner FW perpendicular-into-strip per justify | IN PROGRESS — coded 2026-05-22 |
| [BUG-CDAC](#bug-cdac) | `CD` AutoCalc multi-segment total length verified + diagnostic | IN PROGRESS — coded 2026-05-22 |
| [BUG-CDISP](#bug-cdisp) | Inspector same-plan break badge | IN PROGRESS — Round 5b 2026-05-22 (XData flag + badge wired) |
| [BUG-144](#bug-144) | CDSURVEY: typing A at Approve cancelled the intake (R3 item 4) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R4 batch); awaiting Tim's retest on the next payload |
| [BUG-145](#bug-145) | Pit grip-move: labels followed by the previous move's delta (stale baseline), 'works then doesn't' (R3 item 1) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R4 batch); awaiting Tim's retest on the next payload |
| [BUG-146](#bug-146) | Tidy-up after MOVE saw no pipes on the established route (pipes=0) (R3 item 2) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R4 batch); awaiting Tim's retest on the next payload |
| [BUG-147](#bug-147) | CDFW / CDSOURCE still rolled back on a duplicate 'AGI' tag via endpoint claims (R3 item 3) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R4 batch); awaiting Tim's retest on the next payload |
| [BUG-139](#bug-139) | CDFW / CDSOURCE refused: 'pit(s) have no CE identity yet (WT16)' — a CDWT tank counted as an unidentified pit (R2 item 6) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R3 batch); awaiting Tim's retest on the next payload |
| [BUG-140](#bug-140) | Pit grip-move: label and cover text moved twice, 'glitch and move separately' (R2 item 5) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R3 batch); awaiting Tim's retest on the next payload |
| [BUG-141](#bug-141) | Tidy-up after MOVE found 'no clear spot (on the block)' — the pit at the pipe end counted as an obstacle (R2 item 4) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R3 batch); awaiting Tim's retest on the next payload |
| [BUG-142](#bug-142) | CDSURVEY: 'Unknown command CESURVEYREVIEW' — Manager loaded without the command, nothing stored (R2 item 8) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R3 batch); awaiting Tim's retest on the next payload |
| [BUG-143](#bug-143) | CDPIPEOBJ look: thin lines instead of CD's fat dashed band + magenta walls (R2 item 9) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R3 batch); awaiting Tim's retest on the next payload |
| [BUG-127](#bug-127) | CD / CDWT callout picks: NEAREST is the only running snap while a callout point is picked (R1 items 1–2) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-128](#bug-128) | West callout text: ALWAYS left-justified, landing meets the block at its east end (Tim's ruling 1, R1 items 2–3) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-129](#bug-129) | Wrapped pipe label: background mask box spans the whole pipe (R1 item 4) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-130](#bug-130) | Text tidy-up after MOVE never ran on the established route — no [TidyUp] lines (R1 items 6–8) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-131](#bug-131) | P9 pit grip-move left its cover text and label behind; P10 fine (Tim's ruling 5, R1 item 6) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-132](#bug-132) | CDFW / CDSOURCE rolled back: 'projected source tag names more than one source' (R1 item 14) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-133](#bug-133) | No live words on object picks — CDSURVEY / CDPROFILE / CDBREAK (R1 item 11) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-134](#bug-134) | CDSURVEY blocked by one outlier RL — now WARN, point kept as Unknown (Tim's ruling 2, R1 item 11) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-135](#bug-135) | CDPIPEOBJ: walls dashed/thin, pipe layer recoloured white, lag on redraw (R1 items 15, 17, 19) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-136](#bug-136) | CDEDIT 2×450 → 2×100 leaves labels and arrow far out (R1 image 2) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-137](#bug-137) | Base RL typed at CDWT goes into the tank record and CDINSPECTOR (Tim's ruling 4) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-138](#bug-138) | Pipes wider than the pit side they enter ASK to upsize; pit size list in Settings (Tim's ruling 3) | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload |
| [BUG-106](#bug-106) | Callout placement: snapping should force NEAREST only while a callout is being placed (and the snap toggle menu should show that state); callout placement "doesn't work properly" — Tim asks for the native ObjectARX route | FIXED IN SOURCE — 2026-09-14 evening (REGRESSION_LOG BUG-106): measured in accoreconsole — text now sits 300 landing + 125 gap from the elbow, west callouts get a westward landing and right-attached text; awaiting Tim's retest in the next payload |
| [BUG-105](#bug-105) | Twin (2 x) detention pipe fall arrow sits 325 mm from the nearest pipe edge; single pipes use 125 mm — must be one default in Settings, same for both | FIXED IN SOURCE — 2026-09-14 evening (REGRESSION_LOG BUG-105): D7 = two Settings values (single, twin) both default 125 mm, twin arrow measured from the outer barrel; awaiting Tim's retest in the next payload |
| [BUG-104](#bug-104) | Double-click linked text edit (pipe IL / pit CL) updates data but says nothing on the command line | FIXED IN SOURCE — 2026-09-14 (REGRESSION_LOG "Acceptance batch 14 Sep"); awaiting retest |
| [BUG-103](#bug-103) | CDWT Insert refused at Accept: "The accepted pit output has an unsupported type" (callout MLeader not admitted as a tank attachment) | FIXED IN SOURCE — 2026-09-14 ~16:00: Tim rebuilt the master as plan-only DXF; picker offers all 40 inserted plans named from their titles, anonymous copies cloned into named job blocks; ghost before callout; base-RL callout wording still undecided; awaiting retest |
| [BUG-102](#bug-102) | CDFW / CDSOURCE refused before any pick: "The Civil source data could not be verified" with no reason shown | FIXED IN SOURCE — 2026-09-14 round 7: THREE layered causes fixed today (decision-row shape; non-landable twin centreline; xref handles colliding with the job's own handles in the evidence keys — `SourceEvidenceIdentityRule`); awaiting retest |
| [BUG-101](#bug-101) | CDSTRIP Accept refused "A staged fall arrow differs from the accepted plan" — AutoCAD hides the arrowhead on a 600 mm shaft that rounds under twice the 300 mm head; `[Undo] [Undo]`; "Zero justification" | FIXED IN SOURCE — 2026-09-14 (REGRESSION_LOG BUG-101); awaiting Tim's AutoCAD retest |
| [BUG-100](#bug-100) | CDSTRIP/CDAGI/CDWT preview: typed `A` (Accept) treated as Cancel; keyword list printed twice | typed `A` CONFIRMED by Tim 2026-09-14 10:05 (b312bf0f); the doubled list on the vertex prompt moved to BUG-101 |
| [BUG-098](#bug-098) | Pit label on the plan (P10) disagrees with the stored pit ID (P8) — CDINSPECTOR, long section and schedule follow the record, the drawing text does not; no diagnostic flags it | CONFIRMED by Tim 2026-09-14 15:35 ("CDINSPECTOR WORKED"): `Use plan label P10` renamed the record; plan label = authority (memory `plan-label-is-authority`) |
| [BUG-099](#bug-099) | CDINSPECTOR diagnostics line shows `âœ—` instead of ✗ (cover-depth row) — UTF-8 glyph mangled in the palette text | FIXED IN SOURCE — 2026-09-14 (one 0x97 byte made Roslyn read InspectorPaletteService.cs as code page 1252; glyphs now escaped); awaiting retest |

Full per-item detail (symptoms, root cause, files touched, tests, AutoCAD checklists) is in `CE_CVL_SUITE/REGRESSION_LOG.md` under the "Round 5 (2026-05-22)" section.

### BUG-CDAGI
**Command / Area:** `CDAGI` — `ResolveEffectiveLinetype` infinite recursion + AG_LINE template import.
**Symptom:** CDAGI threw InvalidOperationException; trace showed `ResolveEffectiveLinetype` recursing into itself.
**Fix summary:** Rewrote helper as a flat linetype-table lookup. AG_LINE imported from `CE_A1_C01 - VERTICAL.dwg` if missing; clear error if neither source has it.
**Status:** IN PROGRESS — coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDPERP
**Command / Area:** `CD` — invert text perpendicular for pipes drawn N→S.
**Symptom:** Inverts appeared on the wrong perpendicular side.
**Fix summary:** Pure-math truth-table verified for all 8 directions (tests pass). Diagnostic logs added at both invert call sites in `PipeCreationService` to expose `segAngle / topSide / perpAngle / endpoint` for further trace.
**Status:** IN PROGRESS — coded 2026-05-22; awaiting Tim's log dump from a NS pipe + azimuth-92/280 cases.

### BUG-CDCONT
**Command / Area:** `CD` — continuation popup→banner + pipe-type lock.
**Symptom:** Popup appeared AFTER dialog; pipe drew as the wrong type.
**Fix summary:** Continuation detected BEFORE dialog opens; banner displayed in-dialog; pipe-type ToggleButtons disabled while locked; basement type forced via existing setters.
**Status:** IN PROGRESS — coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDBR-ROT
**Command / Area:** `CD` — breakline block rotation.
**Symptom:** BREAKLINE block rotated incorrectly relative to pipe.
**Fix summary:** Block rotation = `pipeSegmentAngle + π/2`.
**Status:** IN PROGRESS — coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-036-R5
**Command / Area:** `MIRROR` cover text then `MOVE` pit — snap-back.
**Symptom:** Cover text snapped to pre-mirror position when pit moved.
**Fix summary:** Removed `!pitMoved` clause from `offsetStale` predicate; live position always wins.
**Status:** IN PROGRESS — coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDWT
**Command / Area:** `CDWT` — callout style + reuse prompt.
**Symptom:** Reuse prompted separately; callout was plain MText.
**Fix summary:** Reuse derived from `total - detention`; callout uses MLeader (`TextService.CreateCalloutMLeader`); text wording locked to two variants — no "UNDERGROUND" prefix.
**Status:** IN PROGRESS — coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDGR
**Command / Area:** `CD` GRADE section + AutoCalc.
**Symptom:** "From Inverts" confusing; AutoCalc grade tied to Custom textbox.
**Fix summary:** "From Inverts" removed (migrates to Default). Two toggles only. New "1 in N" textbox for AutoCalc denominator. Custom mode label is VERBATIM. Mismatch popup at ±10% via `Dialogs/GradeMismatchDialog`.
**Status:** IN PROGRESS — coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDBR-TOGGLES
**Command / Area:** `CD` — new Cross-plan / Same-plan break toggles.
**Fix summary:** Cross-plan toggle re-uses the existing rising-main / gravity breakline flow. Same-plan toggle prompts for a break point post-draw and inserts the BREAKLINE block; pipe remains one polyline with no continuation.
**Status:** IN PROGRESS — coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDDIR
**Command / Area:** Pipe direction helper.
**Fix summary:** Round 5: `Helpers/PipeDirectionHelper.cs` added.  Round 5b: per-call-site adoption — `PipeCreationService.cs` arrow swap, `InspectorPaletteService.cs` gravity-flow warning + grade-health gate, `CdCommand.TryPrimeContinuationContext` basement anchor direction.  13 NUnit tests cover every `PipeType` × `GetFlowDirection`, `DownstreamInvertIsHigher`, and `FirstEndIsUpstream`.  All pass on net48 + net10.0-windows.
**Status:** IN PROGRESS — Round 5b coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDPP
**Command / Area:** `CD` Pipe Preview pane.
**Fix summary:** Round 5b — full redesign per Tim's markup.  `PipePreviewControl.xaml.cs` rewritten with `FirstInvertText`, `SecondInvertText`, `PipeText`, `PipeStrokeBrush`, `PipeStrokeThickness`, `ArrowPointsRight` dep props.  `CdViewModel.cs` exposes `PreviewFirstInvertDisplay` / `PreviewSecondInvertDisplay` / `PreviewPipeTextDisplay` / `PreviewPipeColour` (ACI→WPF brush per layer) / `PreviewPipeThickness` (diameter-scaled) / `PreviewArrowPointsRight` (via `PipeDirectionHelper`).  Bigger text (≥12pt inverts, 14pt label), pipe spans 80 % of pane width, arrow at midpoint pointing upstream→downstream.
**Status:** IN PROGRESS — Round 5b coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDLAYOUT
**Command / Area:** `CD` Text & Arrow section.
**Fix summary:** Round 5b — preview row shrunk 140 → 112 (~0.8×).  Text & Arrow card lives inside Column 0's StackPanel; reclaiming the preview's vertical space gives the body row roughly 1.5× more breathing room for the card without explicit row-star sizing.
**Status:** IN PROGRESS — Round 5b coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDSTRIP
**Command / Area:** `CDSTRIP` corner Floor Waste inset.
**Symptom:** Corner FWs sat in the wrong place per justify.
**Fix summary:** Corner shift is now perpendicular-into-strip per adjacent segment (both segments oriented into the corner). TOP/BOTTOM = 50 mm, CENTER = 0. END FWs unchanged. New tests cover all 4 segment-direction quadrants.
**Status:** IN PROGRESS — coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDAC
**Command / Area:** `CD` AutoCalc + multi-segment polyline.
**Fix summary:** Verified `GetPolylineLength` already sums all segments; added a single `[CE] AutoCalc: segments=N totalLength=L N=… drop=…` diagnostic log; added unit test for 3-segment 15 m polyline.
**Status:** IN PROGRESS — coded 2026-05-22, awaiting Tim's AutoCAD test.

### BUG-CDISP
**Command / Area:** Inspector same-plan break badge.
**Fix summary:** Round 5b — fully wired.  `LinkService.State.cs` adds `HasSamePlanBreak` bool on `PipeLinkData`.  `LinkService.RepairAudit.InvertPropagation.cs` adds `SetSamePlanBreak` / `TryGetSamePlanBreak` (XData via existing transport).  `CdCommand.TryPlaceSamePlanBreak` persists the flag on glyph placement.  `InspectorViewModel` exposes `PipeSamePlanBreakBadge` + `HasPipeSamePlanBreak`; `InspectorPaletteService.PopulateSamePlanBreakBadge` reads it and sets the badge to `|⨯| visual break`.  `InspectorPanelControl.xaml` renders a small accent-soft border when present.  No click action wired (per Tim's spec).
**Status:** IN PROGRESS — Round 5b coded 2026-05-22, awaiting Tim's AutoCAD test.

---

## BUG-087

**Command / Area:** Structural `CEHATCH` / `11BH` — direct ordinary-pattern hatch creation.

**Symptom:** In live verified Structural 1.0.56, Tim ran `CEHATCH`, chose Objects, selected one valid boundary and selected BRASS/`11BH`. AutoCAD created the candidate, then CE reported `AutoCAD did not retain the required hatch background` and rolled the whole operation back.

**Expected behaviour:** A valid associative BRASS hatch is created on the approved layer, with no visible background, exact pattern/scale/angle and valid boundary links. One Undo removes it. Save/reopen and Properties retain the same result.

**Safety result:** PASS. `_.U GROUP` rollback was verified and no attempted hatch remained.

**Functional result:** The original 1.0.56/1.0.62 failure was corrected through the Structural hatch repair train. Live Structural 1.0.72 exact source `9af408a501d98787cfe9992bc406c91231aef411` removed the failing direct-new hatch reopen path and retained the strict hatch-state/rollback contract. Tim then confirmed `HATCH WORKS HOWEVER`, accepting CH/EH/native hatch MOVE for the reported defect. Source-only 1.0.73 exact `4a5927a10a628eae7edb6821045f7bbbcdcc76f5` retains the accepted hatch paths byte-identically.

**Retained release check:** The reported CH/EH/native-MOVE defect is closed. The future consolidated 1.0.73 field batch still checks background/association, Undo and save/reopen as wider successor evidence; it must not reopen the accepted fix or trigger a historical-version redeployment.

**Status:** FIXED — 2026-08-14. Tim confirmed the live 1.0.72 result in AutoCAD: `HATCH WORKS HOWEVER`.

---

## BUG-086

**Command / Area:** Structural command `C2` — support block insertion and dynamic Visibility property.

**Symptom:** `C2` no longer inserts the correct support block/dynamic state. The inserted support shows the wrong visibility/state.

**Expected behaviour:** `C2` inserts the approved support block with Visibility value exactly `2 No 89 x 89 x 6.0 SHS`.

**Decisive evidence:** A blank/new drawing inserts correctly. Existing drawings fail because a stale same-name resident dynamic block definition wins over the approved plugin asset. The stale definition's list is missing `2x89SHS`, `125 SHS`, and `200 x 75 PFC`, so this is not merely a wrong Visibility assignment.

**Approved workflow:** Detect the outdated resident definition, warn `Existing support block definition is outdated`, then prompt `[Upgrade/Cancel] <Cancel>`. Never silently redefine. Cancel leaves the drawing unchanged with no insertion residue. Upgrade deliberately refreshes from the approved asset and must account for every existing instance because redefining the shared definition affects all inserts.

**Mandatory Upgrade invariant:** Every existing support must remain visually and spatially identical. Preflight and snapshot each reference's handle/ObjectId, visibility state by name, insertion position, rotation, XYZ scale, normal/orientation, mirrored state, layer/display properties, attributes and all other dynamic values. Verify every currently used legacy state exists and is compatible in the approved definition before mutation. Refresh and restore inside one atomic transaction, then re-read every instance and validate properties plus visible geometry/location within AutoCAD tolerance. Any mismatch or unprovable state aborts and rolls back the entire change, creates no new C2 insert and reports the exact blocking instance/state. The only intended visible change is that future C2 insertions can use approved `2x89SHS` and the definition gains its missing states. One Undo must revert the successful Upgrade/new insertion operation.

**Reference:** Later map `C2` registration → insertion service → governed support block asset → import/redefine policy → drawing-resident definition → dynamic `Visibility` property. Compare block name/version and all existing instances before any Upgrade route.

**Source result:** Structural 1.0.67 exact `ff36a304fd89bee3c12c5e61326ffa96887a4730` implements the approved Upgrade/Cancel and preservation workflow. It passed focused 95/95 guards and an independent exact-head audit with no P0–P3 finding. The correction is an ancestor of fully verified source-only 1.0.73 exact `4a5927a10a628eae7edb6821045f7bbbcdcc76f5`.

**Status:** IN PROGRESS — source correction verified; awaiting the single consolidated Structural 1.0.73 deployment and AutoCAD preservation check. Do not redeploy the historical 1.0.67 candidate separately.

---

## BUG-085

**Command / Area:** Structural beam placement command `1`.

**Symptom:** Tim selected a first support block or line, selected a second object, entered beam text `B1`, and AutoCAD reported `Beam not placed. [XREF_OBJECT_LIMIT_EXCEEDED]` instead of placing the beam. Tim confirmed neither selected object was inside an Xref, so that error is misleading for the reproduced local-object case.

**Expected behaviour:** Acquire each endpoint independently from either a selected object or a picked point. All four combinations must work: object→object, object→point, point→object, and point→point. Cancel or any unsupported/Xref case must leave no partial beam, and one Undo must remove a successful beam.

**Reference:** Structural beam endpoint acquisition for exact registered command `1`. The regression matrix covers local/Xref support blocks and lines, all four endpoint combinations, Cancel, Undo, and no partial output.

**Root cause:** `1` is the exact registered command. Endpoint capture succeeds, then optional background evidence traverses a nearby host Xref. `BeamCommandAutoCadReadScope` charges every child object against the visited-object budget before type/visibility/corridor relevance filtering; object 4,097 throws `XREF_OBJECT_LIMIT_EXCEEDED` and aborts placement. The same later scan explains both local-object and point-only failures. Separately, mixed object/point endpoint modes are not implemented. First Line + Enter currently means use the whole line, so the repair preserves that default and adds an explicit `[Point/WholeLine]` choice.

**Source result:** The endpoint-mode correction is audited at exact source `d44c7b429fc96a641ab45fbe26f9522e61562c53` and is an ancestor of fully verified source-only 1.0.73 exact `4a5927a10a628eae7edb6821045f7bbbcdcc76f5`.

**Status:** IN PROGRESS — source correction verified; awaiting the single consolidated Structural 1.0.73 deployment and AutoCAD endpoint matrix. Do not redeploy the historical 1.0.60/1.0.62 candidates separately.

---

## BUG-088

**Command / Area:** Structural beam placement commands `2` and `1` — lintel fallback and beam-label position.

**Symptom:** In live Structural 1.0.72, command `2` with label `L4` stopped before Preview with `B1_FORCED_SIDE_NOT_CLEAR` and placed no beam. Command `1` with label `RB9` placed the beam and text, but the text was far away from the beam line.

**Expected behaviour:** `L4` uses the established outside midpoint fallback when the outside side is fully known but blocked, reaches Preview and places the complete lintel if accepted. `RB9` keeps its label beside its governing beam face. Cancel writes nothing; one Undo removes beam and label; save/reopen preserves the accepted result.

**Source result:** Structural 1.0.73 exact `4a5927a10a628eae7edb6821045f7bbbcdcc76f5`, tree `c15935e1edb8daec788a7745905b7dbe3f2cf080`, restores the known-side lintel midpoint fallback and limits label-offset drivers to nearby overlapping parallel faces. It passed independent exact-head audit, focused DesignCore 128/128 on all three lanes, host/runtime 59/59, three Release builds with zero warnings/errors, and corrected full net10 1017/1017. Live remains 1.0.72.

**Status:** IN PROGRESS — source correction verified; awaiting fresh closed-AutoCAD authority to deploy exact 1.0.73 and run the consolidated L4/RB9/LL1/C2/hatch/DBText/Undo/save-reopen batch.

---

## BUG-089

**Command / Area:** Structural beam placement command `2` — lintel labels `L2` and `L4`.

**Symptom:** Against exact repaired deployment record `d7e7362`, both `L2` and `L4` stop before Preview with `LINTEL_BOUNDARY_MISSING` and leave no retained beam. Tim entered `LL2` instead of the requested `LL1`, but no rerun is required because the two valid lintel failures already reject the candidate.

**Expected behaviour:** A valid Command `2` lintel obtains or resolves the established inside/outside boundary evidence, reaches Preview and places one beam/label when accepted. Cancel leaves nothing and one Undo removes the complete accepted pair. Native locked-layer, Xref, REFEDIT and unsupported-object protections remain unchanged.

**Reference:** deployed audited production `bd517ef49ce74f6ad8a931bbc5bfb609987bab82`, deployment record `d7e7362`; `BeamCommandAutoCadPlacementEvidenceReader.CaptureBoundaries` and `BeamPlacementPlanner.ResolvePlacement`.

**Preserved evidence:** `RB9`, Undo, Cancel, `CH`, `EH`, centred/right-justified DBText and save/reopen passed. `C2` is inconclusive because no beam remained after Undo/failed lintel placement; it is not a C2 defect result.

**Status:** IN PROGRESS — exact AutoCAD failure recorded 2026-08-20; STRUCTURAL source diagnosis/correction routed. AutoCAD may remain open. No rollback/deployment is authorised.

---

## BUG-090

**Command / Area:** Plugin-wide `CE_VERSION` / Structural-owned About CE Suite WPF window.

**Symptom:** The fixed-size window clips its lower AutoCAD/runtime content and does not expose the source commit needed to prove the loaded candidate. The visible rows show Civil `v2.1.20`, Structural `v1.0.73` and Manager `v1.0.5`, but not exact source provenance.

**Expected behaviour:** At normal Windows/AutoCAD scaling, every loaded module row, AutoCAD/runtime row and exact source/deployment identity is readable without hovering or clipping. The window may grow/scroll rather than hide evidence.

**Reference:** `Modules/Structural/UI/Dialogs/AboutDialog.xaml`, `AboutDialog.xaml.cs`, `Services/VersionInfoService.cs`; screenshot `C:\Autodesk\CERef\ST-BEAM-06-BatchB-d7e7362-20260820\batch-b-failed-acceptance.png`, SHA-256 `83736E471E9049FA5821FBD5F644632082BCCA4B9A8F60B942FD52B7E6EBF13E`.

**Status:** SOURCE COMPLETE — exact combined candidate `8ac6a9cde1467a3e83eedb6a20aae4a9fa6b86a7`, tree
`3c0cd714f2d3035c037aca26f810c1890ffcd56c`, is clean/pushed and independently audited PASS with no P0-P3. Focused
proof passed 13/13 and net48/net8/net10 production builds passed 0 warnings/0 errors. It is not deployed; fresh
closed-AutoCAD authority and 100/150/200% field proof remain.

---

## BUG-091

**Command / Area:** Drainage `CD` free-point AutoCalc, `CDEDIT` local pipe Apply and invert-label MTEXT mask.

**Symptom:** `CD` cancels a deliberately drawn free-point pipe with `Both endpoint identities must be proven before
AutoCalc can begin.` `CDEDIT` move/add/remove operations no-op with `Pipe host writeability is unknown and Apply is
ineligible.`

Exact record SHA `FDBA5C42B672BD4882243672531446ED6AEB68046C64AAA9945158C29DF2F844` proves a second attempt created a
150 pipe and then resolved start `P3@117213`/end `P2@117113` at exact 0.00, while that same pipe immediately reports
CDEDIT writeability Unknown. The invert-label call records `mask=False`, yet the diagnostic always says masked; the
created MText truthfully follows `useMask`, so the settings handoff and positive visible output require review.

Screenshot SHA `75515C02740E05CBDA4F6C1A7E42DE3B8BA973B8263C1A6CF8E1B73A80B92357` adds an exact overlap case: a picked
termination on an existing current-drawing CE pipe falls through to broad Xref extents and is labelled `XREF · Unknown`,
disabling Start Pipe. Tim approved current host pipe as a first-class endpoint before Xref fallback only on an exact
geometric hit, with one deterministic topology/ownership/label/schedule junction and one Undo; Xref stays read-only.

A direct valid-current-drawing CDSOURCE reproduction also resolves Unknown: the stable `SOURCE:<handle>` identity and
tag are present, but the role mapper recognises only special LPD/IO/DP/OF/fixed tags. DR-CD-01 now includes one unique
nonblank generic Source role; duplicate, ambiguous, empty-tag and Xref evidence remains blocked.

**Expected behaviour:** A deliberately picked free-point pair receives explicit command-owned start/end identity so
AutoCalc can reach Preview without pretending the ends are pits or network connections. A specifically selected CE
pipe in the current drawing may Preview/Apply the reviewed edit when exact database/owner/native protection evidence
proves it local and writable. Locked-layer, Xref, REFEDIT, foreign or unsupported targets remain unchanged and name
the exact refusal reason. Cancel leaves no residue and one accepted change is one Undo.

**Reference:** Canonical `9abf95d`; `Modules/Drainage/Services/CdDrawFirstFlowService.cs` and
`Modules/Drainage/Engineering/Pipe/PipeEditLabelPreflight.cs`; approved CV-01E4 implementation `130c00f` is canonical
ancestry; Control card `DR-CD-01_CD_CDEDIT_LOCAL_EVIDENCE_REFUSALS.md`.

**Status:** IN PROGRESS — Tim explicitly approved DR-CD-01. One isolated DRAINAGE source writer is authorised on
canonical `9abf95d`; deployment/live AutoCAD authority is not. CDWT and pipe-grade display/range work are separately
parked.

---

## BUG-084

**Command / Area:** Civil drawing open/close lifetime and project data.

**Symptom:** repeatedly opening and closing Civil drawings during one AutoCAD
session could retain old drawing/project state and steadily increase memory.

**Expected behaviour:** closing a drawing releases CE's managed references to
that drawing while other open drawings continue normally.

**Reference:** `ProjectDataService`, `LinkService.OnDocumentToBeDestroyed`,
`PitBlockMigrationService`, and Stage 3 memory audit.

**Fix:** the existing close event now guarantees release through a `finally`
path. CE clears the per-database version cache, current drawing/project
references and pending Idle-save state where applicable. Plugin shutdown also
unhooks the pit-migration activation event and clears its native-pointer cache.

**Verification:** `RuntimeMemoryLifetimeTests` passes 2/2 on net48 and 2/2 on
net10. Civil Release builds pass with zero warnings and zero errors on both
lanes. Every command used `-p:SkipDevBundle=true -nr:false`.

**Status:** FIXED IN CODE — 2026-07-27. Awaiting controlled AutoCAD
open/close/reopen memory verification.

---

## BUG-083

**Command / Area:** `PIT` and pit-edit WPF windows.

**Symptom:** every opened PIT window attached itself to the global parts
catalogue event, so closing the window did not free its full view-model.

**Expected behaviour:** closing the window removes its listener; a newly opened
window still receives catalogue updates normally.

**Reference:** `PitViewModel`, `PitDialog.OnClosed`, and Stage 3 memory audit.

**Fix:** `PitViewModel` now has safe repeatable cleanup, and `PitDialog` runs
that cleanup whenever it closes.

**Verification:** `RuntimeMemoryLifetimeTests` proves the global subscriber
count returns to its original value and repeat cleanup is safe on net48 and
net10. Civil Release builds pass with zero warnings and zero errors on both
lanes. Every command used `-p:SkipDevBundle=true -nr:false`.

**Status:** FIXED IN CODE — 2026-07-27. Awaiting controlled AutoCAD PIT-window
open/close memory verification.

---

## BUG-082

**Command / Area:** CE plugin command-line build, test and publish processes.

**Symptom:** after several CE worker tasks compile or test the plugins, dozens of
`dotnet.exe` helpers can remain in memory. MemGuard recorded 38 helpers using
4.88 GB, contributing to Windows slowing down even though AutoCAD itself was
using about 1.13 GB.

**Expected behaviour:** build helpers may exist while work is compiling, but
finished MSBuild workers should close rather than accumulating for the rest of
the session.

**Reference:** `CE_ACAD_PLUGIN/Directory.Build.rsp`,
`Installer.Tests/BuildSafetyTargetTests.cs`, and the Stage 3 memory audit.

**Fix:** every normal CE `dotnet build`, `dotnet test`, and `dotnet publish`
command now requires explicit lightweight `-nr:false`. The existing installer
build/publish commands carry it, and `Directory.Build.rsp` provides a repo-root
backup. Full cache disabling remains reserved for final audits.

**Verification:** 10/10 build-safety tests passed. Controlled Release builds for
Civil, Structural and Manager passed with zero errors on net48 and net10, and
each finished with zero new persistent `dotnet.exe` worker PIDs after five
seconds.

**Status:** FIXED — 2026-07-27. No AutoCAD test is required. Previously orphaned
`/nodeReuse:true` workers are not repaired by this preventive change and remain
a separate one-time cleanup decision.

---

## BUG-050

**Command / Area:** Beam label placement — all beam commands (1, 2, 4, 5, 8 etc.) that call `BeamTextPlacementService.TryPlaceBeamLabel`.

**Symptom:** If you draw a beam from LEFT to RIGHT and run the label command, the label lands on one physical side (e.g. below). If you draw the SAME beam from RIGHT to LEFT (reversed endpoints), the label lands on a DIFFERENT physical side or at a different offset distance — even though the geometry is identical. The label position changes depending on which end you clicked first when drawing the beam.

**Expected behaviour:** The label should always land on the same physical side at the same perpendicular distance regardless of which endpoint is pt1 and which is pt2.

**Root cause:** `TryPlaceBeamLabel` computes `preferredSide` from the xref-vote (negCount vs posCount), where the signed distance of an xref wall changes sign when the beam direction is reversed. A wall that gives `negCount=1` for a forward beam gives `posCount=1` for the reversed beam. This flips `preferredSide`, but the `FinalOffset` formula then picks a different xrefBase (`furthestPosDist` vs `furthestNegDist`) that yields a different physical offset — so both the side AND the magnitude change. `SelectSideBaseDistance` was designed for a fixed-direction perpAngle convention (J16), but that convention breaks when pt1/pt2 are swapped.

**Reference:** `CE_STRUC_SUITE/Services/BeamTextPlacementService.cs` — `TryPlaceBeamLabel`, `FinalOffset` closure, `SelectSideBaseDistance`. Confirmed by headless test S8 (2026-06-09).

**Evidence from S8:**
- Forward beam (0,0)→(5000,0) with wall at Y=+200: label lands at Y=-400 (perpDist=400, below beam). ✓
- Reversed beam (5000,0)→(0,0) with identical wall: label lands at Y=0 (perpDist=0, ON beam). ✗
- diff=400 drawing units.

**Fix:** Added `CanonicalizeBeamDirection(pt1, pt2)` to `BeamTextPlacementService` and called it at the very start of `TryPlaceBeamLabel` (before computing `beamDir`, `mid`, `angles`). The helper ensures the beam always runs left-to-right (horizontal) or bottom-to-top (vertical) so `perpAngle` and `SignedDistanceToBeam` produce consistent physical-side signs regardless of draw direction. `angles` is recomputed from canonical points. Confirmed by headless rig: S8 now passes (23/23 PASS, 0 fail). Files changed: `CE_STRUC_SUITE/Services/BeamTextPlacementService.cs`.

**Status:** FIXED 2026-06-09 — awaiting Tim's AutoCAD confirmation.

---

## BUG-052

**Command / Area:** PIT BLOCK 3 — force-adoption + elimination of PIT BLOCK 2 across the suite. PIT/IO/OF/etc. inserts, drawing-open behaviour, installer payload.

**Symptom (Tim, 2026-06-12):** "Why are we on v2.1.3 and still not force-using PIT BLOCK 3? Why hasn't it shipped? How does it get rid of all use of PIT BLOCK 2?"

**Root cause found:**
1. **PIT BLOCK 3.dwg was never in the running bundle.** `DeployToDevBundle` (the dev workflow) copies only the DLL/assets/icons/runtimes — NOT block `.dwg` files. Blocks ship only via the installer EXE, and no EXE has been built since PB3 was added to `source_blocks` on 9 Jun. The bundle's `Contents\Blocks\` was frozen at an old install (only `PIT BLOCK 2.dwg`, dated 4 Feb). So the code's "prefer PB3" preference could never find the file → silently fell back to PB2.
2. **Current design is PREFERENCE, not FORCE.** New pits prefer PB3; old drawings keep PB2/PB until someone manually runs `CDREFRESHBLOCKS`. Nothing auto-forces.
3. **PB2 is deliberately KEPT** (recognised, 2nd variant, shipped) — by design it coexists, it does not get eliminated.

**Tim's decisions (2026-06-12):** FULL FORCE + ELIMINATE PB2; deliver via FULL INSTALLER EXE for the office.

**DONE this session (safe, immediate):**
- `DeployToDevBundle` now syncs `Installer\source_blocks\*.dwg` → bundle `Contents\Blocks` every dev build (root-cause fix so blocks never go missing again).
- Copied `PIT BLOCK 3.dwg` into the running bundle NOW → new pits resolve PB3 immediately (Tim can verify: place a pit → Properties reads "PIT BLOCK 3").

**REMAINING (force + eliminate) — gated on AC-closed + Tim's one real-drawing test before office EXE:**
- **Auto-redefine on drawing open:** wire the `CDREFRESHBLOCKS` redefine (`db.Insert(name, PB3sourceDb, true)`) to run once-per-database on open/first-CE-touch (reuse the hardened once-per-db `EnsureDrawingDiscovered` hook + CommandInProgress guard — DO NOT add a new DocumentActivated reactor; this is the recurring-regression zone, see memory regression_dbtext_dtext_doubleclick). Redefines in-drawing PB/PB2 defs from PB3.dwg → all existing pits show PB3 geometry automatically.
- **Eliminate the PB2 NAME (destructive):** reassign every pit BlockReference from "PIT BLOCK 2"/"PIT BLOCK" to the "PIT BLOCK 3" definition (preserve dynamic props: SPS_RADIUS, X/Y width, visibility states), then purge the PB2/PB defs so Properties reads "PIT BLOCK 3" everywhere. PRECONDITION: verify PB2↔PB3 dynamic-property names are identical (PB3 was built from PB2 — likely safe, but MUST confirm or pits break — the 2026-06-09 note warned of exactly this). Drop PB2 from `GetBlockNameVariants`, remove `PIT BLOCK 2.dwg` from `source_blocks`, keep recognition ONLY for the in-session migration pass.
- **Verify:** unit tests (variant order now `["PIT BLOCK 3","PIT BLOCK"]`; every-recognition-site test) + headless redefine/reassign round-trip (isolated accoreconsole, runs with AC open).
- **Ship:** close AC → build net48+net10 (DLL now carries blocks) → bump 2.1.4 → build installer EXE → Tim test: open an OLD PB2 job → all pits read "PIT BLOCK 3", SPS grip works, PITSCHEDULE/CDEDIT fine, nothing lost → THEN distribute EXE.

**Update 2026-06-12 (code complete, headless-proven):** `PitBlockMigrationService` built (pure
planner + apply + auto-on-open trigger + CDREFRESHBLOCKS wiring). PB2↔PB3 confirmed structurally
identical (15 ents, 0 attrs) so redefine + RENAME (handle-preserving) is safe — no reference swap,
CE link graph intact. Tests: 8 planner + 3 wiring + headless T3 (7/7 incl. handle preserved, name→PB3,
still recognised). Full suite 1918/1944. Residual v1 limits: mixed PB2+PB3 drawings keep a few PB2
names (geometry uniform); PB2.dwg still shipped/recognised for un-migrated drawings (final cleanup
gated on rollout). REMAINING: Tim closes AC → deploy v2.1.4 (DLL now carries blocks) → build office
EXE → Tim runs the 5-step AC test in REGRESSION_LOG → distribute.

**Status:** IN PROGRESS — code + tests + headless DONE 2026-06-12; gated on AC-closed deploy + Tim's real-drawing test before office EXE.

---
## BUG-093

**Command / Area:** Civil linked-pipe attachment point grips / AutoCAD `GRIP_STRETCH`

**Symptom:** The linked-pipe grips are visible, but dragging them does not move the intended label,
flow arrow or invert attachment. AutoCAD debug output repeats `session-missing-fail-closed` for a
temporary `DBText` with `handle=0`, `ObjectIdNull=True` and `databaseNull=True`.

**Expected behaviour:** AutoCAD's temporary drag copy should preview the selected CE attachment
movement, while final acceptance writes only through the verified real drawing object and retains
Cancel/Undo, locked-layer, Xref and REFEDIT protections.

**Reference:** Grip debug evidence supplied by Tim on 2026-08-31. AutoCAD calls the point-grip move
path on a transient `DBText` copy that has lost the source grip session, so the current final-write
safety gate correctly rejects it but also prevents any preview movement.

**Triage 29 Sep: SUPERSEDED in code** - the faulting class `PipeAttachmentFlipGripOverrule` is no longer registered (last wired 25 Aug, `c160b175`; a contract test asserts it stays unregistered). AutoCAD 2027 uses the native grip module `CE_CVL_NATIVE_GRIP_2027.arx`; older lanes use `PipeAttachmentActionGripOverrule`, which has no drag override. Needs an AutoCAD retest of the Slide/Offset/Flip grips (Codex), then close. Removing the dead class is a separate tidy-up (not done).

**Status:** OPEN — decisive runtime evidence captured. Repair must carry verified source-session
identity into the transient drag preview without allowing the transient copy to become write authority.

---

## BUG-092

**Command / Area:** CE Suite Manager startup and CE ribbon rebuild after an AutoCAD workspace change

**Symptom:** Tim reports that Manager creates substantial lag. The exact live Manager failure record at
`2026-08-25 15:00:45 AEST` says the CE ribbon build/validation retried 60 times after
`WSCURRENT` (workspace) changed, then gave up. The live Modern Manager is `1.0.5`, SHA-256
`C6D94A9455256E802043439EDE38C0331F62DEA3106592F49383DFA81DD22EB5`, with embedded source
commit `51044f08ef8707d6ef7c787a1045259190e5530c`.

**Expected behaviour:** Manager should create or repair the CE ribbon once when AutoCAD is ready. A normal
workspace change must not keep rebuilding every 500 ms, hold an idle handler for about 30 seconds, or retry
60 times. A failed validation should stop quickly, retain existing working ribbon access where possible and
record one useful fault without slowing drafting.

**Reference:** `Modules/Manager/Services/CeUnifiedRibbonService.cs`; the live implementation has
`MaxBuildAttempts = 60`, `RetryDelay = 500 ms` and a `30 s` contributor settle window. The immutable signed
Manager `1.0.6` package is not approved for installation because its Project Control branch forked before the
newer live ribbon and signed-release safeguards. Reconcile those lines before producing a replacement package.

**Status:** IN PROGRESS — Tim approved the bounded repair with “LETS DO IT” on 2026-08-25. No live plugin,
AutoCAD drawing or Claude-owned Architectural Change Review screen has been changed.

---

## BUG-094

**Command / Area:** Civil CDEDIT pipe selection (MLINE / PLINE)

**Symptom:** Tim reports on 2026-09-07 that CDEDIT does not open consistently when picking the pipe MLINE versus its PLINE.

**Expected behaviour:** Picking either visible representation of the same owned CE pipe opens the same pipe editor. Respect locked-layer, Xref, REFEDIT and unsupported-object protections; do not select a different pipe.

**Reference:** Reported during Reverse Flow acceptance on c5ce0057. Investigate the CDEDIT selection-to-owner route after the active Reverse Flow value/plan correction is confirmed.

**Status:** IN PROGRESS — Tim authorised larger lunch build/test on 2026-09-07. CDEDIT shared-picker correction deployed in96e7d76a on2026-09-07; combined Civil5960pass/1known calibrationfail/17skip. Awaiting Tim's MLINE/PLINE AutoCAD acceptance; not marked FIXED.

---

## BUG-095

**Command / Area:** Civil assisted design / historical detention-storage calibration (GE 24-115)

**Symptom:** Larger lunch test sweep on 2026-09-07 computes required storage 1.80417316 m3 versus fixture 2.58 m3 for GE24-115, a 30.07080776% difference exceeding the existing 30% bound. PSD 6.54 L/s versus5.87 and orifice71mm versus63mm remain within their existing comparison bounds. One of ten calibration tests fails.

**Expected behaviour:** Assisted proposals must agree with the approved calculation basis, or clearly retain the discrepancy for engineer review. Do not alter locked historic fixture values or widen tolerances merely to pass.

**Reference:** Modules/Drainage.Tests/Services/AutoDesignBackTestTests.cs; AutoDesignService delegates to DetentionSizingService and bundled council profiles. Reproduced independently in pre-lunch ab4c51f5 release checkout (civil-calibration-baseline.trx) as well as owner broad sweep. No engineering calculation code changed by the lunch CDEDIT/editor work. Logs C:/Autodesk/CERef/LunchBuild-20260907. Actual fixture comment names Boyd's sheet while profile uses Swinburne; exact source/basis reconciliation remains to be established, not guessed.

**Status:** OPEN — engineering calibration discrepancy, baseline-reproduced. No model/tolerance change or field acceptance claimed. Retain before claiming Level3 assisted design complete.

---

## BUG-096

**Command / Area:** Structural release verification / source packaging inputs

**Symptom:** The full combined solution cannot build its Structural release tests because Modules/Structural/Installer/PackageContents.xml is absent. The same missing file produces one error for each of the three AutoCAD runtime lanes.

**Expected behaviour:** Release assertions read the authoritative Structural installer manifest. Do not substitute Civil's manifest or disable the assertions to pass.

**Reference:** Modules/Structural.ReleaseTests/CE_STRUC_SUITE.ReleaseTests.csproj and StructuralManifestReleaseTests.cs; Modules/Structural/MONOREPO_NOTE.md records that Installer was deliberately excluded from the import. Independent lunch review 2026-09-07, logs C:/Autodesk/CERef/LunchBuild-20260907/build-checks. Correct producer build ordering removed the separate harness-copy errors.

**Status:** LOCALLY CORRECTED 2026-09-08 at 3ccb9e59 — restored the real historical Structural manifest verbatim from cf5bb756 (blob 5d4fd29c48d71f14a89aea8471bf1ca5a91958b5). The now-runnable exact test inventory exposed a second defect: discovery omitted NUnit ordinary tests. Recognising both simple and parameterised test-builder interfaces retains all eight expected identities/assertions. Offline tests pass 8/8 on net48/net8/net10; full release matrix still pending. No Structural product/installer/live deployment change and no native test needed for this offline repair. Evidence: C:/Autodesk/CERef/Colleague-20260908/verification/structural-release-input-corrected*.

---

## BUG-097

**Command / Area:** Command inventory and AI tool-list verification

**Symptom:** Lunch command-truth tests run after the build-order fix but pass 18/20. The tool count expects 107 and finds 95; Civil compiled commands CDGRIPROUTE, CDPIPEATTACHMENTACTION and COPYMULTI are absent from the compared registry.

**Expected behaviour:** Published command/tool inventories match the approved actual commands, with internal routing commands explicitly classified. Never simply update expected counts or expose internal commands to obtain green tests.

**Reference:** Tests/CE.CommandTruth.Tests; logs C:/Autodesk/CERef/LunchBuild-20260907/build-checks. Existing findings reproduced on the pre-C2 owner base plus build wiring and Reverse Flow guards. No command registration, tool exposure or test assertion changed by lunch integration.

**Status:** LOCALLY CORRECTED 2026-09-08 at 0233ff05 — the central Civil migration receipt was stale (95 recorded versus 107 existing command rows), not a missing AI-tool set. Audited twelve existing additions, recorded two grip routes and the retained COPYMULTI helper as hidden/unqualified compatibility metadata, and refreshed the exact receipt to110 rows. Restored COPYMULTI outside the net10 CR/MR split using its existing implementation, as required by the 25 August C-to-Circle retirement decision. Unchanged cross-runtime/compiled assertions now pass21/21; Civil retirement guards4/4NET10. No parity exemption, new staff/AI qualification or live deployment. Final native COPYMULTI acceptance is deferred with the product; full release matrix still pending. Logs: C:/Autodesk/CERef/Colleague-20260908/verification/command-truth-copy-restored.trx and copymulti-circle-retirement.trx.
## BUG-098

**Command / Area:** pit labels vs stored pit identity (plan label text, CDINSPECTOR, long section, schedule).

**Symptom (Tim, 2026-09-14 09:40 AEST, live bundle fc42544a):** the plan shows pit labels P10 and P9 on a 2 × 100 UPVC detention pair; CDINSPECTOR on the pit labelled P10 reports ID **P8** with "→ 100 UPVC to P9"; the long section drawn afterwards is headed P9 → P8 (follows the record). CDDASHBOARD reports no issue. The section was drawn after the labels were already in this state.

**Expected:** the label text on the plan, the stored pit ID, the section header and the schedule all say the same pit number; a mismatch must be flagged as Unknown/needs attention by the automatic QA, not silently accepted.

**Root cause:** not yet established. Candidates: a renumber that updated the record but not the label attribute (or the reverse), or a hand-edited label. Evidence to gather: `CDINSPECTOR` on the pit labelled P9 (does it say P9 or P7?), the pit schedule rows, and whether the labels were typed by hand or produced by a CE renumber.

**Triage 29 Sep (release chat 04): fix found in code, 813b4672 / 4a79f5ee (pit label mismatch warning), present in the installed Civil 3.0.13. Status stays open until a Codex/Tim check confirms it in AutoCAD; queued for Codex pass 18.**

**Status:** OPEN — logged 2026-09-14; not fixed. Diagnose before touching either the label or the record.

**Codex 30 Sep pass18: BLOCKED (fixture not reachable).** Legacy pit P6 showed Inspector "not recorded / Unknown" until Edit Pit was opened; changing the plan label P6 to P66 with EATTEDIT made the recorded number follow at once, so the "label differs from record" state could not be created and the mismatch warning was not exercised. Screenshots `P18_screenshots\T098_Inspector_unknown.png`, `T098_label_synced.png`; report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 43, section "03:09 Melbourne - Inspector triage").

---

## BUG-099

**Command / Area:** CDINSPECTOR diagnostics text.

**Symptom:** the cover-depth diagnostic reads `Cover depth: 0 mm  âœ—  (min 300 mm)`; the ✗ glyph (`InspectorPaletteService` cover/grade symbols) is rendered as `âœ—`, i.e. UTF-8 bytes shown as Latin-1 somewhere between the service and the palette. Also "Cover depth: 0 mm" on a pit whose cover and invert are both 19.45 — the 0 mm may itself be a data symptom (pit invert = cover level).

**Triage 29 Sep (release chat 04): fix found in code, 813b4672 (Unicode glyphs), present in the installed Civil 3.0.13. Status stays open until a Codex/Tim check confirms it in AutoCAD; queued for Codex pass 18.**

**Status:** OPEN — reported 2026-09-14 on the fc42544a test drive.

**Codex 30 Sep pass18: BLOCKED (no symbols shown).** Inspector Selected object > Checks (blank), Drawing health > Refresh (11 pits, 49 pipes, Findings dash), On plan: no tick or warning symbol appeared, so neither a garbled nor a correct symbol was seen. Screenshot `P18_screenshots\T099_no_symbols.png`; report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (check 44).

---

## BUG-144

**Command / Area:** see REGRESSION_LOG.md "R4 fix batch" (15 Sep 2026).

**Symptom:** CDSURVEY: typing A at Approve cancelled the intake (R3 item 4).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R4 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R4 fix batch".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R4 batch); awaiting Tim's retest on the next payload

---

## BUG-145

**Command / Area:** see REGRESSION_LOG.md "R4 fix batch" (15 Sep 2026).

**Symptom:** Pit grip-move: labels followed by the previous move's delta (stale baseline), 'works then doesn't' (R3 item 1).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R4 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R4 fix batch".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R4 batch); awaiting Tim's retest on the next payload

---

## BUG-146

**Command / Area:** see REGRESSION_LOG.md "R4 fix batch" (15 Sep 2026).

**Symptom:** Tidy-up after MOVE saw no pipes on the established route (pipes=0) (R3 item 2).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R4 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R4 fix batch".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R4 batch); awaiting Tim's retest on the next payload

---

## BUG-147

**Command / Area:** see REGRESSION_LOG.md "R4 fix batch" (15 Sep 2026).

**Symptom:** CDFW / CDSOURCE still rolled back on a duplicate 'AGI' tag via endpoint claims (R3 item 3).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R4 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R4 fix batch".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R4 batch); awaiting Tim's retest on the next payload

---

## BUG-139

**Command / Area:** see REGRESSION_LOG.md "R3 fix batch" (15 Sep 2026).

**Symptom:** CDFW / CDSOURCE refused: 'pit(s) have no CE identity yet (WT16)' — a CDWT tank counted as an unidentified pit (R2 item 6).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R3 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R3 fix batch".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R3 batch); awaiting Tim's retest on the next payload

---

## BUG-140

**Command / Area:** see REGRESSION_LOG.md "R3 fix batch" (15 Sep 2026).

**Symptom:** Pit grip-move: label and cover text moved twice, 'glitch and move separately' (R2 item 5).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R3 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R3 fix batch".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R3 batch); awaiting Tim's retest on the next payload

---

## BUG-141

**Command / Area:** see REGRESSION_LOG.md "R3 fix batch" (15 Sep 2026).

**Symptom:** Tidy-up after MOVE found 'no clear spot (on the block)' — the pit at the pipe end counted as an obstacle (R2 item 4).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R3 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R3 fix batch".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R3 batch); awaiting Tim's retest on the next payload

---

## BUG-142

**Command / Area:** see REGRESSION_LOG.md "R3 fix batch" (15 Sep 2026).

**Symptom:** CDSURVEY: 'Unknown command CESURVEYREVIEW' — Manager loaded without the command, nothing stored (R2 item 8).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R3 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R3 fix batch".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R3 batch); awaiting Tim's retest on the next payload

---

## BUG-143

**Command / Area:** see REGRESSION_LOG.md "R3 fix batch" (15 Sep 2026).

**Symptom:** CDPIPEOBJ look: thin lines instead of CD's fat dashed band + magenta walls (R2 item 9).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R3 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R3 fix batch".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R3 batch); awaiting Tim's retest on the next payload

---

## BUG-127

**Command / Area:** see REGRESSION_LOG.md entry "BUG-127" (R2 fix batch, 15 Sep 2026).

**Symptom:** CD / CDWT callout picks: NEAREST is the only running snap while a callout point is picked (R1 items 1–2).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-128

**Command / Area:** see REGRESSION_LOG.md entry "BUG-128" (R2 fix batch, 15 Sep 2026).

**Symptom:** West callout text: ALWAYS left-justified, landing meets the block at its east end (Tim's ruling 1, R1 items 2–3).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-129

**Command / Area:** see REGRESSION_LOG.md entry "BUG-129" (R2 fix batch, 15 Sep 2026).

**Symptom:** Wrapped pipe label: background mask box spans the whole pipe (R1 item 4).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-130

**Command / Area:** see REGRESSION_LOG.md entry "BUG-130" (R2 fix batch, 15 Sep 2026).

**Symptom:** Text tidy-up after MOVE never ran on the established route — no [TidyUp] lines (R1 items 6–8).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-131

**Command / Area:** see REGRESSION_LOG.md entry "BUG-131" (R2 fix batch, 15 Sep 2026).

**Symptom:** P9 pit grip-move left its cover text and label behind; P10 fine (Tim's ruling 5, R1 item 6).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-132

**Command / Area:** see REGRESSION_LOG.md entry "BUG-132" (R2 fix batch, 15 Sep 2026).

**Symptom:** CDFW / CDSOURCE rolled back: 'projected source tag names more than one source' (R1 item 14).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-133

**Command / Area:** see REGRESSION_LOG.md entry "BUG-133" (R2 fix batch, 15 Sep 2026).

**Symptom:** No live words on object picks — CDSURVEY / CDPROFILE / CDBREAK (R1 item 11).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-134

**Command / Area:** see REGRESSION_LOG.md entry "BUG-134" (R2 fix batch, 15 Sep 2026).

**Symptom:** CDSURVEY blocked by one outlier RL — now WARN, point kept as Unknown (Tim's ruling 2, R1 item 11).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-135

**Command / Area:** see REGRESSION_LOG.md entry "BUG-135" (R2 fix batch, 15 Sep 2026).

**Symptom:** CDPIPEOBJ: walls dashed/thin, pipe layer recoloured white, lag on redraw (R1 items 15, 17, 19).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-136

**Command / Area:** see REGRESSION_LOG.md entry "BUG-136" (R2 fix batch, 15 Sep 2026).

**Symptom:** CDEDIT 2×450 → 2×100 leaves labels and arrow far out (R1 image 2).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-137

**Command / Area:** see REGRESSION_LOG.md entry "BUG-137" (R2 fix batch, 15 Sep 2026).

**Symptom:** Base RL typed at CDWT goes into the tank record and CDINSPECTOR (Tim's ruling 4).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-138

**Command / Area:** see REGRESSION_LOG.md entry "BUG-138" (R2 fix batch, 15 Sep 2026).

**Symptom:** Pipes wider than the pit side they enter ASK to upsize; pit size list in Settings (Tim's ruling 3).

**Expected behaviour:** as recorded in the REGRESSION_LOG entry and the R2 tick-list.

**Reference:** Modules/Drainage — REGRESSION_LOG.md "R2 fix batch F1–F12".

**Status:** FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG R2 batch F1–F12); awaiting Tim's retest on the next payload

---

## BUG-106

**Command / Area:** callout placement (CD / CDWT / text callouts), object snap behaviour, MLeader route.

**Symptom (Tim, 14 Sep 2026 16:45):** while a callout is being placed the running snaps should toggle to NEAREST only, and the snap toggle menu should show that state; the callout itself "doesn't work properly". Tim asks to move the callout onto the native ObjectARX route.

**Status:** FIXED IN SOURCE — 2026-09-14 evening. Evidence (3 screenshots 17:10): leader straight to text = wrong. Probe in accoreconsole 2027 found the jig placed the text only 300 mm from the elbow (AutoCAD needs 300 + 125) and west callouts kept an eastward dogleg. Fixed in `TextService` (`CALLOUT_TEXT_STANDOFF`, `SetCalloutLandingDirection`, east-Left/west-Right alignment). NEAREST-only snaps during placement and the native ObjectARX route are NOT built (see D1 card). Awaiting Tim's retest.

---

## BUG-105

**Command / Area:** twin (2 x) detention pipe fall arrows.

**Symptom (Tim, 14 Sep 2026 16:45):** the arrow sits 325 units from the nearest pipe edge on a twin pipe; a single pipe uses a 125 offset. One default, on the Settings page (settings-first), used by both.

**Status:** FIXED IN SOURCE — 2026-09-14 evening (Tim's D7 ~18:30: TWO Settings values, single and twin, both default 125). Cause: the arrow kept the single-barrel formula on twins, clashed with its own barrel and was bumped a lane (+275 → 325). Now measured from the twin envelope; both values on the Civil Settings page under "FLOW ARROW". Awaiting Tim's retest.

---

## BUG-104

**Command / Area:** linked text edits (double-click pipe IL / pit CL), command-line reporting.

**Symptom:** the text and the Civil data update but the command line says nothing (Tim, 14 Sep 2026 Group 3).

**Root cause:** `LinkedTextEditBatch.Run` spoke only on failure (quiet success was the earlier spec).

**Status:** FIXED IN SOURCE — 2026-09-14: `[CE Civil] Linked text edit stored: N Civil value(s) updated.` / `nothing changed`. Awaiting retest.

---

## BUG-103

**Command / Area:** CDWT Insert, Accept.

**Symptom:** `[CE] The accepted pit output has an unsupported type.` — nothing placed. Tim also reports "riser and dropper blocks wrong, same with wt block" (not yet understood; screenshot requested).

**Root cause:** the callout is an MLeader; `RegisterPitAttachmentInCallerTransaction` admitted only BlockReference/MText.

**Status:** FIXED IN SOURCE — 2026-09-14 (MLeader admitted). Block-appearance part OPEN.

---

## BUG-102

**Command / Area:** CDFW, CDSOURCE (shared source backbone preview gate).

**Symptom:** `[CE] The Civil source data could not be verified. Nothing will be placed here.` before the first pick, on Tim's test drawing (12 pits / 50 pipes). No reason visible anywhere.

**Root cause:** not yet known — the exception message was only a diagnostic (off by default). Candidates: "The drawing and project do not describe the same complete pipe set" (pipe polyline set ≠ record), snapshot read/preflight failure.

**Status:** FIXED IN SOURCE — 2026-09-14 round 2. Tim's `Reason:` line read "A decision row has missing or unsupported fields": the shape check demanded all eight fields as strings; identity fields stay mandatory, note fields optional (REGRESSION_LOG round 2). Awaiting retest.

---

## BUG-101

**Command / Area:** CDSTRIP Accept (atomic read-back of the fall-arrow Leaders); vertex prompt wording; preview wording.

**Symptom:** typed `A` at the preview → `[CE] A staged fall arrow differs from the accepted plan.` — nothing drawn. `Next point [Undo] [Undo]`. `Preview: … Zero justification` after choosing Center.

**Root cause:** AutoCAD hides a Leader arrowhead when the shaft is shorter than 2 × Dimasz × Dimscale (= 600 mm for TIM LEADER); the shaft was exactly 600 and rounds to 599.999… in most directions (measured in accoreconsole 2027: 599 no head, 600/601 head). The atomic read-back saw `HasArrowHead == false` and refused. The old route drew those arrows headless silently.

**Status:** FIXED IN SOURCE — 2026-09-14 (REGRESSION_LOG BUG-101): shaft 610 mm, every-degree guard test, prompt/wording fixes, specific read-back message. Awaiting Tim's AutoCAD retest.

---

## BUG-100

**Command / Area:** CDSTRIP, CDAGI, CDWT Accept prompt (and CDSOURCE/CDWT prompt wording).

**Symptom:** typing `A` at "Place this strip drain? [Accept/Cancel] <Accept>" cancelled the command; only Enter accepted. The keyword list was printed twice.

**Root cause:** `GetKeywords` reports a typed keyword as `PromptStatus.OK`; the code only accepted `PromptStatus.Keyword`. Message strings duplicated the keyword list AutoCAD appends.

**Status:** typed `A` CONFIRMED by Tim 2026-09-14 10:05 AEST on b312bf0f (the CDSTRIP preview accepted). The remaining doubled keyword list on the vertex prompt is tracked as BUG-101.

---

## BUG-449

**Command / Area:** Codex W39 on the installed Structural 1.0.109 (5aff4fe6), 9 Oct 03:54 to 04:13, report CODEX_VERIFYW39_2026-10-09.md. PASS 4, FAIL 0, BLOCKED 1. **(1) PASS:** C1 with a typed text point (19600,300) and number 1 prints "Text placed at the top right (CR1).", asks "Enter a number to append to 'C' (or press Enter to exit):", draws the column and label C1, prints "[CE] Beam linking is switched off in Settings, so the support is not linked."; one U removes column and label, REDO brings both back. TS1 the same with number 2. **(2) PASS:** Esc at "Pick desired support text location" prints *Cancel*, removes the half-placed column, CLAYER stays "0", no _Dot line. **(3) PASS:** beam command 1 on the two columns, "Beam placed. One UNDO removes the complete beam.", U / REDO together, no BEAMLINKMIGRATE mention. **(4) Settings:** Tim's three settings files identical start and end (Structural 4AB7CC9F, 28,361 bytes; no rows added by 1.0.109), settings-save lines 2,184 before and after, SAVETIME back to 5. **(5) W39-02 BLOCKED, and it is my brief, not the product:** a bare Enter at the support text question prints "Text placed at the right (CR1)." (the BUG-437 fix works: no "Invalid point."), but Enter then runs the normal text command with NO point made up (SupportBlockCommands.cs HandleSupportTextPlacement: "No point is made up: the text command places the label as it does today"). That command asks "Enter text for 'C' or <1>:" (the number typed in W39-01 is remembered, so it shows the remembered-text form, not "Enter a number to append"), then "Specify insertion point:"; a bare Enter there is "Invalid point." and Esc cancels, so the second column stayed unlabelled. **What a drafter sees:** the line "Text placed at the right (CR1)." is printed BEFORE the label is placed and promises a placement that has not happened; the next two questions look like a different command. Wording only, not a crash, nothing is lost. S-27 carries #812 b7aaa225, a wording commit for this step; the S-27 Opus finalizer is asked to trace this path. **(6) Start-up lines (still there on 1.0.109, Civil half fixed by #826 in C-26):** "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL", "Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager" and "; error: syntax error" (BUG-435). **(7) Note:** restoring SAVETIME to 5 printed one automatic-save line after both U/REDO pairs were complete (no pair interrupted).

**Status:** W40 (9 Oct 04:42 to 05:01, Structural 1.0.109, PASS 4, FAIL 0) re-ran the W39-02 case with the real prompts and it WORKS: bare Enter at the text question prints "Text placed at the right (CR1).", then "Enter a number to append to 'C' (or press Enter to exit):", number 2, "Specify insertion point:" 22600,300, then an extra "Top or Bottom [T/B] <T>:" (Enter) and the C2 label sits at the picked point; one U takes column and label together, REDO brings both back. A bare Enter at the number question exits and leaves the column without a label (by design, "or press Enter to exit"). After a remembered number the question reads "Enter text for 'C' or <2>:" and Enter accepts it. What is left is WORDING only: "Text placed at the right (CR1)." prints before the label is placed (S-27 carries #812 b7aaa225 for this step; the S-27 finalizer is tracing it). Filed 9 Oct by the controller; wording item stays OPEN. Never FIXED until Tim confirms in AutoCAD. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-450

**Command / Area:** S-27 Opus finalizer findings (9 Oct, TRAIN_S27_FINALIZER_REPORT.md; GO at 52bdb4b5 = e325135e + the finalizer's one wording commit; nothing HIGH or MEDIUM). **The commit:** a bare Enter at "Pick desired support text location" printed "Text placed at the right." before anything was placed (#812 had only dropped "(CR1)"); it now reads "Label on the right: enter its text, then click where it goes." with a pin test (RED on the old line, 5 of 5 green now) and an 8-line REGRESSION_LOG entry. Codex W39-02 was NOT a code fault (the "Enter text for 'C' or <1>:" question was right because W39-01 had used 1); W40 proved the real route. **Checked and fine:** the hand-merged framing legend (#804: heading drawn once, retyped heading kept and moved, all five layout numbers from Settings, 9 legend tests present); CSLEVELCARRY (#825: off and hidden, switch checked first, never unlocks a layer, never reads Xref content, refuses read-only drawings and REFEDIT, one Undo, registry valid at 370); #818 (roof/floor setout unchanged while off); Tim's Structural CS_Settings.json will grow once, by exactly the 13 new keys, no existing value changes. **Seven LOWs, none blocking:** (1) the picked-point line still shows "(CR1)" and says "placed" before the number question (SupportBlockCommands.cs:929); (2) Esc at the text step keeps the column and prints "Support text command failed: Command cancelled." (old S-26 LOW 1, needs Tim's choice); (3) the CSLEVELCARRY off sentence still says the Settings page is "still to be built" (LevelCarryCommandService.cs:37); (4) a few CSLEVELCARRY layout numbers are still in the code (label gap, the 5% "equally near" margin: Settings-first rule); (5) CSLEVELCARRY "Start again": an old copy on a locked layer drops out of CE's record and is never tidied later; (6) if the other level's drawing cannot be opened the reason goes only to the log (the drafter still gets "could not read ... nothing was changed"); (7) the legend tests check code text and number rules, not the drawn heading size: Codex must look at it.

**Status:** OPEN (LOWs). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-451

**Command / Area:** Codex W41 on the installed Structural 1.0.109 (9 Oct 05:20 to 05:45, usage 57% to 59%, DWG-S1_VC7_b.dwg copy, report CODEX_VERIFYW41_2026-10-09.md): the DAY1 "not seen" steps 14, 18, 19, 20. PASS 0, BLOCKED 5, FAIL 0, none of it a proven CE fault; most is my brief and Codex clicking a prompt keyword. **Seen:** (1) BT1: prompts "Specify second point of bracing (drag preview, ENTER for 0°/2700) [Zero]:", "Bracing truss number [1-9] <1>:", "Preview length: 4000 rotation: 0°", "CE could not tell from the Xref walls which side the brace should go. Flip it by hand if it is on the wrong side.", "Toggle flip? [Yes/No]:" then "Flip unchanged."; U echoes BT1, REDO "Everything has been redone"; second BT1 Esc gives "Operation cancelled."; no _Dot line (the view clipped the truss, so its look is not read). (2) CSREOBAR: bar size, number and spacing each show their default once (PASS for the doubled-default guard); the next question is "Face [Top/Bottom/tAndB] <Bottom>:" then "Start of the bar extent:"; Codex's click on the strip hit the clickable tAndB keyword, so placement was not reached. (3) FPFC: second and later FPFC with PF1 asks "Warning: Label 'PF1' already exists. Use anyway? [Yes/No/Increment] <Increment>:" and prints "[FOUNDATION] Auto-incremented to 'PF5'." then PF6; NO size questions are asked (sizes come from saved values); insertion point and "Additional rotation around center <0>:"; "[FOUNDATION] Redrew footing system 'Footing Network': 6 footings. Nothing needs attention."; two green square outlines but no label text visible at the view used. **Not understood (W42 re-checks):** (a) R1: typing P at "Pick LEFT beam or wall [Object/Point] <Object>:" gave "Pick point: P" and "Invalid point." (the click hit the keyword first); the RIGHT question then wanted an object and the test area had none; (b) FSF: after "Select centerline (Line/Polyline/Arc) or press Enter for 2-point line:" + Enter, Codex saw NO "Specify start point:" prompt and an empty command line, yet U echoed FSF and REDO worked; the code (FoundationService.cs TryGetOrCreatePathDriver) should ask for the start point, so this is either a lost Enter or a real fault; (c) where the pad footing label text is. **DAY1 re-marking:** nothing becomes SEEN from W41 except: BT1 U/REDO and Esc on 1.0.109, CSREOBAR defaults once on 1.0.109. **Lesson (brief rule added in W42):** never click the command strip while a prompt is open.

**Status:** OPEN (observations; W42 re-run in progress). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-452

**Command / Area:** C-26 Opus finalizer findings (9 Oct, TRAIN_C26_FINALIZER_REPORT.md; GO at 2162e2f5 = 13346fbc + one fix commit; nothing HIGH, one MEDIUM FIXED, ten LOWs). **MEDIUM (fixed):** #811 wrote the administrator-list path into the Manager trace file unscrubbed when the list could not be read, so the real Windows login (C:\Users\<login>) went into the trace; the #822 test caught it. Fix: the path and the error text of the three new #811 trace lines now go through the existing CePiiScrub.ScrubHere; new test DamagedAdminList_TraceLine_CarriesNoLoginOrProfileFolder (fails on the old code); Manager 655 of 655. **For Tim's start-up lines (BUG-435):** #826 stops Civil writing to acad.cuix, but entries ALREADY in an existing profile stay, so "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL" will most likely still print on his PC; the "CE Manager" menu line and "; error: syntax error" are not touched by this train and the source of the syntax error is still unknown. Codex should check "no new acad.cuix.ce_bak and the CE CVL entries do not grow", not "acad.cuix unchanged" (AutoCAD saves it itself). **LOWs:** (1) a damaged approvals file shows nothing on screen (approval just disappears, reason in the trace only; better than 3.0.39); (2) #800: the unknown-material 6 m/s still has three copies outside the one table (UserSettings.cs:1156, SettingsSizingStandards.cs:96, SettingsService.cs:150); (3) #800: two hard-coded 3.0 m/s fallbacks (InspectorPaletteService.cs:3207, InvertPropagation.cs:155) used only when Settings cannot be read now read "your Settings value" when nobody set it; (4) #816: Tim's rotated Civil logs (5.26 and 5.32 MB) are just over the 5 MB per-file cap and are always left out of the zip (the contents file says so); (5) older Manager trace lines from before this train still write raw Windows error text (cure: one scrub inside CeAdminTelemetryService.Trace, a Team item); (6 to 10) smaller wording and test-pin LOWs in the report. **#817 and #823 are NOT in C-26** (desk ruling: #817 re-cut for C-27; #823 e169d6ae goes to C-27 with #827 and #828).

**Status:** OPEN (LOWs). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-453

**Command / Area:** Codex W43 on the installed Structural 1.0.110+9babe787 (9 Oct 05:57 to 06:15, usage 59% to 60%, report CODEX_VERIFYW43_2026-10-09.md): PASS 4, FAIL 1. **(1) PASS, the new wording:** C1, bare Enter at the text question prints "Label on the right: enter its text, then click where it goes." (the old "Text placed at the right (CR1)." is gone), then "Enter a number to append to 'C' (or press Enter to exit):" 1, "Specify insertion point:" 19600,300, "Top or Bottom [T/B] <T>:" Enter, and the green C1 label sits at the picked point; layer back to 0; one U (echo C1 GROUP) and REDO (echo GROUP C1, "Everything has been redone") pass. **(2) PASS:** C1 with a typed point prints "Text placed at the top right (CR1)." (unchanged), then "Enter text for 'C' or <1>:" Enter, and the second label appears. **(3) FAIL (wording, already LOW 3 of BUG-450):** CSLEVELCARRY, CSROOFSETOUT and CSFLOORSETOUT each print a plain switched-off sentence and draw nothing (DBMOD unchanged), but each ends "The Settings page for it is still to be built." That tells a drafter the switch cannot be reached. Cure (Team): drop that last sentence once the Settings rows exist, or say where the switch lives; Settings-first rule. **(4) PASS, the first-start settings growth:** Structural CS_Settings.json grew ONCE at the first 1.0.110 start (06:00:39) from 28,361 bytes (4AB7CC9F) to 28,872 bytes (D3890D56): exactly the 13 expected keys added (LevelCarry x8, FramingLegend x5), 0 values changed, 0 removed; the CE log line "Settings file updated with new default rows (CS_Settings.json). No value you set was changed." appears once today. CD_Settings.json (ACD64E79) and the TIM_CE_CADTOOLS CS_Settings.json (622A246F) are byte-identical. **NEW BASELINE for Structural CS_Settings.json: 28,872 bytes, D3890D560A451133.** Settings-save lines 228 / 1,956 unchanged, SAVETIME back to 5, AutoCAD closed cleanly with No. **(5) Harness note:** a click on the command strip hit the Reference keyword at the rotation question again (three extra prompts, all answered with a bare Enter, no angle guessed); no CE fault.

**Status:** OPEN (wording). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-454

**Command / Area:** Codex W44 on the installed Structural 1.0.110+9babe787 (9 Oct 06:15 to 06:45, usage 60% to 62%, DWG-S1_VC7_b.dwg copy, report CODEX_VERIFYW44_2026-10-09.md): PASS 2, FAIL 1, BLOCKED 2. Brief rule held: no click on the command strip while a prompt was open (one typing fault in FEDIT, retried once as the rules allow). **PASS (DAY1 steps 18 and 21 can be re-marked SEEN on 1.0.110, 9 Oct 06:32 and 06:40):** CSREOBAR shows bar size, number, spacing and face once each, then "Start of the bar extent:", "End of the bar extent:", "Preview: BM1  8-N12-200 CTS x 4000 LG, BOTTOM", "Place this reo bar? [Yes/No] <Yes>:" and "BM1: 8-N12-200 CTS x 4000 LG, BOTTOM."; one U echoes CSREOBAR and removes the bar, REDO restores it. FEDIT on a pad: "[FEDIT] You picked CE's outline: editing PF5...", "Current: PF5, Pad footing, 600x600", new X size 700 (test input), "[FEDIT] PF5 updated."; U echoes FEDIT, REDO says "Everything has been redone", and a second FEDIT reads "Current: PF5, Pad footing, 700x600" (size after REDO confirmed). **BLOCKED (R1, DAY1 step 14):** with two real beams placed, R1 takes the LEFT and RIGHT beam picks (Enter = Object, then click) and then asks "Pick TOP/near side [Object/Point] <Object>:", which needs a third object (a top beam or wall); nothing was drawn, so U/REDO were not reached. Not a fault; W45 needs a third beam. **BLOCKED, and seen TWICE (W41 and W44), possibly a real fault (FSF, DAY1 step 19):** after "Enter text <SF1>:", "Enter width for SF 1 <300>:" and "Enter depth <0 to skip>:" the question "Select centerline (Line/Polyline/Arc) or press Enter for 2-point line:" + ONE Enter ends the command silently: no "Specify start point:", no strip, no label (U still echoes FSF). The code (FoundationService.cs TryGetOrCreatePathDriver, ~3744) is written to ask for the start point after Enter, but builds the PromptEntityOptions WITHOUT AllowNone, and AutoCAD does not return a plain Enter for an entity question unless AllowNone is true, so the 2-point-line route the prompt advertises is probably unreachable (HYPOTHESIS from reading code; not proven). Suggested fix (Team): set AllowNone = true on that prompt and add a pin test; Tim can still draw a strip by picking a line or polyline. **FAIL (FPFC, DAY1 step 20):** a pad footing is placed ("[FOUNDATION] Auto-incremented to 'PF5'." then "Redrew footing system 'Footing Network': 5 footings. Nothing needs attention.") but NO label text is visible at zoom height 1500; no size questions are asked. Not known whether a label entity exists or where it sits; needs a code read (label layer, text height versus view) and a Codex look with LIST of the pad's label by the next W-run. **Settings:** all three files byte-identical to the start of the run (Structural 28,872 bytes D3890D56), SAVETIME back to 5, clean exit with No.

**Status:** OPEN (FSF Enter and FPFC label need a Team look; R1 needs a W45 with a third object). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-455

**Command / Area:** Codex W45 on the installed Civil 3.0.40+1200744d / Manager 1.1.40+1200744d (train C-26, install 47; 9 Oct 06:55 to 07:16, usage 63% to 64%, DWG-B1_VC7.dwg copy, report CODEX_VERIFYW45_2026-10-09_065710.md): PASS 3, FAIL 1, BLOCKED 1 (BLOCKED = a phantom fifth item in my brief). **(1) PASS, versions and health:** status bar CE MANAGER v1.1.40 [Modern], CE CVL SUITE v3.0.40 [Modern], CE STRUC SUITE v1.0.110; CEHEALTH "[OK] CE Civil Suite v3.0.40", "[OK] CE Structural Suite v1.0.110", "[OK] The office IT folder ... can be reached.", "[CEHEALTH] All checks passed." **(2) The start-up lines REMAIN, all three (BUG-435):** "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL", "Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager" and "; error: syntax error" (the finalizer had warned the CVL line would stay on a PC whose profile already holds the entry; the other two were never in C-26). The acad.cuix* file list and times were recorded before and after in the evidence folder (menus_start.json, menus_end.json); no judgement made. **(3) PASS, CESUPPORT (#816, #811 scrub):** the zip holds 10 files plus its index (WHAT_IS_IN_THIS_ZIP.txt): the Civil logs of the last 14 days, the Structural and Manager traces and one Manager session file; 8 items left out are listed with reasons (rotated logs over 5 MB, older than 14 days, 68 non-CE files); NO real login or computer name in any entry name or index line, and the drawing name is absent. The index says "Never in it: drawings ... menu files or install ids" and tells the reader what was left out. **(4) FAIL / not proven (#819):** a flat pipe drawn P10 to P9 with 18.500 at both ends gets the label "100 DIA. UPVC PIPE FLAT", but the Edit Pipe window still shows the grade selector "Pipe grade / Standard / Set my own / 1 in / 100" (known gap 5 of DAY1). #819 changed the read-only PREVIEW line (CdViewModel.Preview.cs GradePreviewText: "Grade: FLAT (same inverts)" and "Flow: FLAT (same inverts)"), which Codex did not find in the window, so the #819 text itself is NOT yet seen in AutoCAD. Next look: open the Edit Pipe and New Pipe windows on a flat pipe and read the preview/summary lines (not the selector). **(5) Other:** a design-warnings modal "Pipe is essentially flat - no measurable fall ... Warnings are informational - the pipe has been saved." appears and is acknowledged with Enter; U after the Edit Pipe Cancel echoed CDEDIT (not the pipe creation: the cancelled Edit Pipe leaves its own undo step, as noted in BUG-373), REDO said "Everything has been redone"; TEXTSCR did not expose a usable text window late in the run. **(6) Settings:** all three files unchanged (Structural 28,872 bytes D3890D56), SAVETIME back to 5, clean exit with No.

**Status:** OPEN (start-up lines remain; #819 preview line to be looked at). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-456

**Command / Area:** C-27 Opus finalizer findings (9 Oct, TRAIN_C27_FINALIZER_REPORT.md; GO at 319ba688 = 0daeefd6 + one fix commit; nothing HIGH, one MEDIUM FIXED, ten LOWs and one INFO). **MEDIUM (fixed, #827):** a short pipe from a pit to a downpipe (or another tagged block) standing within 3.2 m of the same pit got the new report line "CE left its other end open ... join it with CD", which is untrue (the far end sits on the downpipe and the import records the pipe as P8 to DP1); it would have appeared once per downpipe branch. The line is now written only when the far end belongs to nothing; test fails on the unfixed head, passes now. **Checked and fine:** X-Civil import end-matching (#827 + #828) cannot join an end to the wrong pit (near end joined as before, far end to no pit), never drops a pipe, an open end is always reported in both import routes and only after the pipe is really drawn, one U takes back the whole import, no layer unlocked, Xref and REFEDIT untouched. **BUG-061 pipe (source object B365D):** now drawn, about 1.3 to 1.7 m of 100 mm pipe, one end joined to P8's wall, the other left where the consultant drew it; the old "was not imported" line is gone, replaced by "The 1.x m pipe drawn from P8 (consultant's object B365D) ends near P8 again: CE left its other end open ..." (no line when the far end sits on a downpipe). #828: the three distances (3200 / 500 / 1600 mm) are read from Settings with those defaults, bad values fall back with one report line; Tim's CD_Settings.json is never written at start-up, the next Settings save adds only the new xcivilImport block; no Settings window row yet (documented follow-up, short of the Settings-first rule but better than numbers in code). #823: the stale CHECK marker is erased inside the same command as the Edit Pipe Save (one U brings level and marker back together; REDO guard passes, baseline file unchanged); on a locked layer the marker is left with the line "[CE] Layer \"CE GRADE CHECK\" is locked, so CE left a grade warning marker ... CE never unlocks a layer"; the grade-key fix compares the grade setting itself, not its spelling. #829 and #830 wording and heading only. **Main LOWs:** (1) pipes shorter than the pit's pull distance (0.5 to 1.6 m) can still collapse to a dot, as in 3.0.40; (2) the line says "drawn from P8" even when the pipe was drawn towards P8, and the length is measured after the pull onto the wall; (3) in the LandXML route an open end keeps the pit name from the LandXML file; (4) the What's New subtitle says 3.0.41 above a list that is still the 3.0.1 catalogue; (5) #828's own REGRESSION_LOG entry tells the tester to hand-edit CD_Settings.json (must only happen on a test profile); (6 to 10) smaller wording and test pins in the report. **Assembler:** #827's own log entry had a bell character and a carriage return where backslash paths were meant, which made git treat the whole log as binary; repaired in its own one-line commit 8ffdcee6. Tests: Civil net10 16,472 run / 1 old red (Glen Eira), Manager 655 of 655, net48 focused 1 old stale redo-guard line.

**Status:** OPEN (LOWs). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-457

**Command / Area:** second independent Opus review (read only, no build, 9 Oct, REDO_SAFETY_SECOND_REVIEW_20261009.md) of whether anything in the Civil code writes to the drawing, or takes the kind of access that loses REDO, between the user's U and REDO. **Answer:** nothing found in the installed Civil 3.0.40 or the C-27 train on any route traced. (1) Pit Schedule marker (#805): level, IL text and marker are written inside the PITSCHEDULE command, one U takes the whole visit and REDO brings it back (Codex saw this on 3.0.38, W35/W36; the code that matters is unchanged). (2) #823 marker erase in Edit Pipe Save: same command, same undo step; a marker on a locked layer is left with one line; on a frozen or off layer it is still erased and U brings it back. (3) Automatic work (Inspector, Project QA, XREF checks, link refresh, pipe upgrade) waits for the next command after a U; Tim's "Wait after Undo" is 0. (4) Open PRs #835, #839, #837, #847, #842, #844, #850 are all OFF by default and write only inside their own command; #838 adds a step at the end of every U and REDO that is not behind its setting (it only reads, but its comment gives the wrong reason). **MEDIUM:** (a) the automatic guard test (RedoSafeCallGraphTests) cannot see inside async code, misses many ordinary ways of changing an object, and ignores a new write added to code that already writes; #835 adds such a write (safe, inside MOVE) with no test change; (b) the building blocks treated as safe, such as reading the drawing in the Inspector after a U, were measured once each in the command-line-only AutoCAD, not in full AutoCAD; (c) a 'resume' step in the end-of-command code can write before the U handling runs; it would break REDO only if a CE command ended early and left a flag set (no normal way found), and the test file's justification for that hook omits it. **LOW:** six items in the report (for example the marker clean-up check sits after a drawing read has started; Manager reloads its menus on every drawing switch while its menu install keeps failing). **ROUTES CODEX HAS NEVER WALKED (section 4 of the report has steps):** Edit Pipe removing the marker (W48-04b walks it), U with a pipe selected and the Inspector open, U then switch drawings then back then REDO, U after MOVE or COPY, U after PIT or CD, UNDO with a count or the Undo drop-down then REDO, an autosave firing during the wait, hovering over a pit during the wait, Civil, Structural and Manager all loaded together.

**Status:** OPEN (test gaps and unwalked routes; no defect found). Filed 9 Oct by the controller.

---

## BUG-458

**Command / Area:** HUNT-C-01 (HIGH): PIT, PP, CD, Edit Pit and the Pit Schedule all run while an Xref is open for in-place editing (REFEDIT). The one start check every Civil command uses (Services/DrawingSafetyService.cs:32-89) never looks for a reference edit; PIT lands the pit and then refuses its number label (Services/BlockService.cs:2500: "Pit retained without its number label"), CD (Commands/CdCommand.cs:38-247) and Edit Pit (Commands/PitEditCommand.cs:631-652 into CeBatchEditApplyCoordinator.cs:292-321) have no check at all. I think AutoCAD adds objects made during REFEDIT to the reference being edited, so a new pit or pipe could be saved back into a consultant's Xref at REFCLOSE (NOT verified; breaks the native-protection rule on REFEDIT). Right result: one plain refusal such as "Finish or close the reference edit (REFCLOSE) first. Nothing was placed." Smallest fix: one REFEDITNAME check in CommandPreFlightCore, and the same check when the Pit Schedule opens. No test covers it. To SEE (Codex): copy drawing with an Xref, REFEDIT, pick it, OK, PIT, place a pit, read the lines and the REFCLOSE question, then REFCLOSE Discard. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_CIVIL_2026-10-09.md (Max-account Opus agent, read-only, 9 Oct 08:41-08:53, installed Civil rel-20261009e 1200744d; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet; Codex W50 will SEE it). Filed 9 Oct by the controller from the Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-459

**Command / Area:** HUNT-C-02 (MEDIUM): Edit Pit with the pit label or the cover text on a locked layer changes the pit, then stops with the vague line "[CE] Error during PITEDIT - see CE log for details." The pre-check looks at the pit only (Commands/PitEditCommand.cs:631-652) although its comment says it catches locked layers; the size is written first (:573), the label move fails quietly (:1574-1627), the number write and the cover text open their objects for writing with no lock check (:1347 into BlockService.cs:2400 rejectLockedLayer false, :2289; :1423). The careful "Part of this edit already reached the drawing ... press Undo once" message (Commands/Editing/CeEditRetryPolicy.cs:83-86) is never shown and the project record is not updated, so the drawing (600) and the schedule (450) disagree. Right result: refused before anything changes, naming the locked layer, "Nothing was changed." Smallest fix: run the writable check on each pit attachment before the first write. To SEE: lock the pit label layer, PITEDIT a 450 pit to 600, Save. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_CIVIL_2026-10-09.md (Max-account Opus agent, read-only, 9 Oct 08:41-08:53, installed Civil rel-20261009e 1200744d; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet; Codex W50 will SEE it). Filed 9 Oct by the controller from the Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-460

**Command / Area:** HUNT-C-03 (MEDIUM): PIT with the pit label layer locked leaves an empty label circle it cannot remove ("[CE] Pit retained. Its number label could not be verified or removed; review that label before issue."). PIT checks only the pit layer (Commands/PitCommand.cs:303-310); the label block is inserted with no lock check (:428-434; BlockService.cs:854-884); the number write refuses (BlockService.cs:2508-2509); the clean-up erase opens the label for writing (PitCommand.cs:541-559) and I think AutoCAD refuses on a locked layer. The cover text layer is not checked either. Right result: refused before the pit goes in, like a locked pit layer. Smallest fix: also check the label layer (when Add label is ticked) and the cover text layer at PitCommand.cs:304. To SEE: lock the pit label layer, PIT, place a pit, click the label and cover spots, look for an empty circle. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_CIVIL_2026-10-09.md (Max-account Opus agent, read-only, 9 Oct 08:41-08:53, installed Civil rel-20261009e 1200744d; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet; Codex W50 will SEE it). Filed 9 Oct by the controller from the Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-461

**Command / Area:** HUNT-C-04 (MEDIUM): CDRULES and CDCHECK can say "Nothing was changed" after something was changed. CDRULES records the run in the drawing (Commands/RulesCommand.cs:111), saves its list (:112), may apply fixes (:116, :204); any failure after :111 lands in the one catch (:118-121) with "CDRULES could not read the drawing. Nothing was changed." CDCHECK prints "Nothing in the drawing was changed." (Commands/SpineCheckCommand.cs:161) before the Connect/Disconnect/Flow/Main actions it then offers (:183-191, :334-359); its catch (:193-201) says "Nothing was changed" and calls a failed file save "could not read the drawing". Right result: the sentence says what happened ("The check ran and was recorded in the drawing, but the list could not be saved: <reason>."). Smallest fix: track whether the run record or a fix was written and pick the end sentence from that. To SEE: make %APPDATA%\CE_CVL_SUITE\logs read-only for the test, CDRULES, P, read the last line, CLOSE and see whether AutoCAD asks to save; put the folder back. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_CIVIL_2026-10-09.md (Max-account Opus agent, read-only, 9 Oct 08:41-08:53, installed Civil rel-20261009e 1200744d; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-462

**Command / Area:** HUNT-C-05 (MEDIUM, R-00): the New Pipe "typed grade does not match the levels" question uses a fixed 10 percent on the 1-in-N figure (Commands/CdCommand.Grade.cs:244-250), while the Pit Schedule note reads the Settings value "achieved grade note tolerance" (ViewModels/PitScheduleViewModel.Data.cs:1891-1892, default 10 in Models/UserSettings.cs:670) and compares the fall per metre (Services/PitScheduleGradeNote.cs:94-98): the two disagree on the same pipe (levels giving about 1 in 111 on a held 1 in 100: New Pipe asks, schedule silent; about 1 in 90.5: New Pipe silent, schedule shows the red CHECK note). Modules/Drainage.Tests/Commands/GradeAutoCalcTests.cs locks the fixed 10 percent in. Smallest fix: New Pipe calls the same comparison with the Settings value. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_CIVIL_2026-10-09.md (Max-account Opus agent, read-only, 9 Oct 08:41-08:53, installed Civil rel-20261009e 1200744d; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-463

**Command / Area:** HUNT-C-06 (MEDIUM, R-00): levels typed in the Pit Schedule are rounded to 2 decimals in code (ViewModels/PitScheduleViewModel.Data.cs:1852 for IL, :1752 for cover, format "0.00") while CD reads the Settings value "calculated decimals" (Commands/CdCommand.cs:499, Models/UserSettings.cs:604) and PIT writes the cover text as typed (Services/PitAnnotationTextFormatter.cs:28-29): 20.055 becomes 20.05 or 20.06, cover 21.5 reads "CL 21.5" from PIT but "CL 21.50" from the schedule. Goes against Tim's ruling that a typed level is never moved (INT-059 item 23). I think the 2022-2024 and 2027 builds round 20.055 differently (not verified). C8ScheduleLevelWriteTests uses 2-decimal levels only. Smallest fix: one level formatter that reads the Settings decimals for the schedule, PIT and Edit Pit, and tell the drafter when a figure was rounded. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_CIVIL_2026-10-09.md (Max-account Opus agent, read-only, 9 Oct 08:41-08:53, installed Civil rel-20261009e 1200744d; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-464

**Command / Area:** HUNT-C-07 (MEDIUM): the Pit Schedule skips the read-only check. PIT, CD and Edit Pit refuse on a read-only drawing ("[CE] PIT cannot run - drawing is read-only."); Commands/PitScheduleCommand.cs:19-40 opens the window with no DrawingSafetyService.CommandPreFlight call and the view-model has no IsReadOnly test (editing is gated on Xref mode only, ViewModels/PitScheduleViewModel.cs:390), so a drafter can type levels and Stop overriding (writes IL text and the CHECK marker) and then QSAVE fails and the work is lost. Right result: the window opens view-only, edit cells greyed, with "This drawing is read-only, so the schedule can be viewed but not changed." Smallest fix: check read-only (and the REFEDIT check of BUG-458) when PITSCHEDULE opens. To SEE: open a job copy read-only, PITSCHEDULE, type a level, Stop overriding, Close, QSAVE. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_CIVIL_2026-10-09.md (Max-account Opus agent, read-only, 9 Oct 08:41-08:53, installed Civil rel-20261009e 1200744d; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet; Codex W50 will SEE it). Filed 9 Oct by the controller from the Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-465

**Command / Area:** HUNT-C-08..15 (eight LOWs, reading only): (08) pit cover text takes whatever text style is current (Commands/PitCommand.cs:730, PitEditCommand.cs:1795, PitEditCommand.Batch.cs:862) while pipe labels use Standard (Services/TextService.cs:1455); (09, R-00) pit text sizes and offsets are fixed in code (cover text height 180 Services/TextService.cs:27, cover corner offset 200 or 250 PitCommand.cs:27-28 and PitEditCommand.cs:28-29, SPS label heights 300 and 250 PitCommand.cs:30-31; SpsLabelTests locks them in); (10) Edit Pit on a round pump pit (SPS) ignores the radius for its labels (PitEditCommand.cs:343-349, :1873-1893, :2214-2242; PIT uses the diameter, PitCommand.cs:868-873); (11) SPS numbering can repeat a number (SPS1 and SPS3 present, next is SPS3 again: number from the count not from the numbers in use, PitCommand.cs:955-956, :962-992, set after the window so the already-used check never sees it); (12) Civil quietly puts back a CE layer's colour and linetype every time it draws (Services/LayerService.cs:439-451; the Structural copy is BUG-367); (13) with "draw the route first" OFF a flat pipe gets the Uphill Pipe Warning box (Commands/CdCommand.cs:831 uses >= so equal levels count as uphill; fix: >); (14) Esc at "Press Enter to reopen PIT" reopens the window (PitCommand.cs:152-157, PitEditCommand.cs:282-287); (15) CDCHECK leaves the item it jumped to selected, so the next ERASE or MOVE acts on it at once (SpineCheckCommand.cs:292, :306, :324). Also noted: on 3.0.41 the Pit Schedule line "Override enabled for linked row." becomes "Your typed value is waiting. Right-click the row and choose Stop overriding to write it to the drawing." (DAY1 step 10 wording changes). HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_CIVIL_2026-10-09.md (Max-account Opus agent, read-only, 9 Oct 08:41-08:53, installed Civil rel-20261009e 1200744d; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-466

**Command / Area:** HUNT-S-01 (MEDIUM-HIGH): FPFC auto-numbering takes the size of the pad you started from. Typing FPFC, Enter at "Enter text <PF1>:" (PF1 exists) and Enter at "Use anyway? [Yes/No/Increment] <Increment>:" gives "Auto-incremented to 'PF5'." but the saved size is looked up with what was TYPED (PF1), not the new mark (Services/FoundationService.cs 1176-1183; PromptElementText 3958-3979 returns the typed text; CheckDuplicateLabel 3981-4031 makes PF5). So PF5 is drawn at PF1's size with no size question (exactly what Codex saw in W44, and DAY1 lists it as expected). The remembered default stays "PF1" (line 3977), so every later FPFC asks the "already exists" question again; answering No ends the command with no sentence (4011, 1177). Right result: a new mark asks its size with PF1's size offered as the default; the default text moves on to the next free mark. To SEE (Codex W51): PF1 at 600 x 600, FPFC, Enter, Enter: expect PF5 at 600 x 600 with no size question. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_STRUC_2026-10-09.md (hunt_struc run 1, read-only, MAX account, 9 Oct about 09:00, installed Structural rel-20261009f 9babe787 = 1.0.110; code reading only; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet; Codex W51 will SEE it). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-467

**Command / Area:** HUNT-S-02 (HIGH where a rotated UCS is used): BT1, R1 (Point option) and FPFC put things in the wrong place in a rotated UCS: they write the clicked point into the drawing without turning it from the UCS to World. BT1: Commands/BracingCommands.cs 266-275 and Services/BracingService.cs 1673; R1: Commands/RafterJoistCommands.cs 1310-1314; FPFC: Services/FoundationService.cs 1190-1207; FSF two-point line: 3773-3791. C1, CSREOBAR and the beam command do convert (C1's own comment says it is needed, SupportBlockCommands.cs 245-247). Structural has no UCS guard of its own (Civil's UcsGuardService reads Civil commands only). I think C1's rotation hands a World point to AutoCAD's ROTATE (SupportBlockCommands.cs 775) so the column may swing about the wrong point (not proven). Fine on a World UCS, which is why no test caught it. To SEE: UCS Z 30, BT1 click two wall corners; FPFC; R1 Point option. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_STRUC_2026-10-09.md (hunt_struc run 1, read-only, MAX account, 9 Oct about 09:00, installed Structural rel-20261009f 9babe787 = 1.0.110; code reading only; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-468

**Command / Area:** HUNT-S-03 (MEDIUM, roof-down order UX-STRUC-13): columns placed with beam linking OFF are invisible to the level-below tools. The only place CE looks for posts coming down is the beam-to-support links (Services/FoundationService.LoadPath.cs 185-262 CollectLoadPathPosts; the level-above markers LoadTrace.cs 57 and the footing grips Grips.cs 104 use the same list). With beam linking OFF (Tim's setting) C1 prints "[CE] Beam linking is switched off in Settings, so the support is not linked." (SupportBlockCommands.cs 385-404), so a C1/TS1 post carries nothing down; CSLOADPATH says "No beam-end or post supports found to check". Tim's call against STRUC-ROOF-DOWN-PRODUCTION_CARD_2026-10-04: read C1, TS1, DS1 and C2 support blocks directly as posts, linked or not. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_STRUC_2026-10-09.md (hunt_struc run 1, read-only, MAX account, 9 Oct about 09:00, installed Structural rel-20261009f 9babe787 = 1.0.110; code reading only; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-469

**Command / Area:** HUNT-S-04 (MEDIUM): FEDIT Esc at "Select new type [ExternalBeam/...]" still saves the edit. Esc at that one question is not cancel: the code carries on, renames, resizes, saves and redraws (Services/FoundationService.cs 1908-1920, then 1924-1970); every other FEDIT question stops on Esc. Right result: Esc ends FEDIT with nothing changed and a line saying so. To SEE (Codex W51): FEDIT on a pad, X size +100, Yes at "Change footing type?", Esc at the type question, then read the pad's size. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_STRUC_2026-10-09.md (hunt_struc run 1, read-only, MAX account, 9 Oct about 09:00, installed Structural rel-20261009f 9babe787 = 1.0.110; code reading only; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet; Codex W51 will SEE it). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-470

**Command / Area:** HUNT-S-05 (MEDIUM, "I think"): FSF picking an existing footing's outline as the centre line may lose the new strip at once. FSF accepts any line, polyline or arc and moves it to the footing layer with no check that it is one of CE's own outline lines (Services/FoundationService.cs 3744-3767); CE's outlines are exploded into exactly those shapes (2909-2924); each redraw erases every outline line it remembers (3525-3555) and runs straight after FSF (1332). With the Enter route broken (BUG-454) picking a line is the only way. Right result: refuse CE's outline lines with "That is the outline of footing SF2. Pick or draw a centre line." To SEE: draw one FSF strip, FSF again and pick one of its long outline edges. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_STRUC_2026-10-09.md (hunt_struc run 1, read-only, MAX account, 9 Oct about 09:00, installed Structural rel-20261009f 9babe787 = 1.0.110; code reading only; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-471

**Command / Area:** HUNT-S-06 (MEDIUM): R1, BT1, C1 and TS1 ignore metre, centimetre and inch drawings. R1 uses fixed millimetres (25 "too short", 300 depth, +200 width: Commands/RafterJoistCommands.cs 27-28, 315-319, 597): in a metre drawing a 4.2 m bay says "Member length is too short to place the block." (untrue). C1/TS1 insert the column at scale 1 with millimetre offsets (SupportBlockCommands.cs 65-69, 290): an 89 SHS column comes out 89 m wide. BT1 converts only the typed length (BUG-433), the block goes in at scale 1 (Services/BracingService.cs 1673-1677). Footing commands convert or warn (S-7, INT-026). To SEE: new drawing, UNITS Metres, two lines 4.2 apart, R1 Point option. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_STRUC_2026-10-09.md (hunt_struc run 1, read-only, MAX account, 9 Oct about 09:00, installed Structural rel-20261009f 9babe787 = 1.0.110; code reading only; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-472

**Command / Area:** HUNT-S-07 (MEDIUM): on a layout tab or during REFEDIT, R1, BT1, C1, TS1, BTX, FSF and FPFC still write into Model space and never check REFEDIT or the space (R1 RafterJoistCommands.cs 202; BT1 BracingService.cs 1672; C1/TS1 SupportBlockCommands.cs 285; BTX BeamTextConvertCommands.cs 103 and 155; FSF FoundationService.cs 3787; FPFC 3806). The beam command refuses with a plain line ("Beam commands require model space outside REFEDIT", Services/ConnectedDesign/Host/BeamCommandAutoCadContext.cs 52-56) and so does CSREOBAR (Services/ReoBarService.cs 88-92). Worst case BTX: text picked on a layout is erased there and re-made in Model space at the layout's coordinates, so it vanishes from the sheet. Right result: the same refusal line for every Day 1 command. To SEE: a layout tab (not inside a viewport), C1 and click; BTX a layout text. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_STRUC_2026-10-09.md (hunt_struc run 1, read-only, MAX account, 9 Oct about 09:00, installed Structural rel-20261009f 9babe787 = 1.0.110; code reading only; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-473

**Command / Area:** HUNT-S-08 (MEDIUM, symptom "I think"): locked layers: BT1, C1, TS1 and BTX have no locked-layer check. CSREOBAR uses CE's shared check and plain line (LayerService.cs 219-236; ReoBarService.cs 150-155); BT1, C1, TS1 and BTX do not. BT1: after the brace is added the flip question opens it for changing (BracingService.cs 1748, 1762) and BT1 has no error catch (BracingCommands.cs 255-361 has only a finally); I think WALL BRACING TYPE BT1 locked plus Yes or Esc at "Toggle flip?" ends in an AutoCAD error with the brace left in place. BTX opens each picked text for changing with no catch (BeamTextConvertCommands.cs 102, 154): locked text probably ends in an error box, nothing converted. C1/TS1 rotation uses AutoCAD's ROTATE (SupportBlockCommands.cs 775), which I think skips a column on a locked SUPPORT COLUMN layer with no CE sentence. Right result: check first, say one plain line, draw nothing; never unlock. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_STRUC_2026-10-09.md (hunt_struc run 1, read-only, MAX account, 9 Oct about 09:00, installed Structural rel-20261009f 9babe787 = 1.0.110; code reading only; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-474

**Command / Area:** HUNT-S-11 (MEDIUM): FEDIT renaming a pad to a mark that already exists silently overwrites that mark's saved size. FEDIT takes any new label with no "already exists" question (FPFC has one) (Services/FoundationService.cs 1827-1833) and writes this pad's size into the saved size for the NEW mark (1957-1965): FEDIT PF5 (700 x 600) renamed PF1 makes the saved PF1 700 x 600, so every later FPFC PF1 is 700 x 600 while the PF1 pads already on the plan stay 600 x 600. Right result: ask "PF1 already exists at 600 x 600. Use PF1's size, keep this pad's size for PF1, or pick another mark?" and record the answer. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_STRUC_2026-10-09.md (hunt_struc run 1, read-only, MAX account, 9 Oct about 09:00, installed Structural rel-20261009f 9babe787 = 1.0.110; code reading only; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-475

**Command / Area:** HUNT-S-09, 10, 12, 13, 14, 15 (LOW / docs) and causes for older bugs: (S-09) the DAY1 page was wrong about R1: it asks "Pick LEFT beam or wall", "Pick RIGHT beam or wall", "Pick TOP/near side", "Pick BOTTOM/far side" and then "Enter the tag text <R1>:" (Commands/RafterJoistCommands.cs 105-155, 541), and each pick is a question first ("[Object/Point] <Object>": Enter, THEN click at "Select object:", 1281-1318): FOUR picks, DAY1 step 14 CORRECTED 9 Oct (W44 only reached the third); later a click at the first question should pick directly (design question for Tim). (S-10) R1: Esc at "Select object:" asks the same question again (1318-1339); only a second Esc ends it. (S-12, Settings-first and no-hard-blocks R-00/R-27) footing sizes: any size, width or depth over 10000 is refused with "Value must be 10000 or less." (Services/FoundationService.cs 4033, 4150-4162) = a hard block; the 3000 mm "exceeds typical range" warning (4034, 4137) and the 600 pad default (36) are fixed in code while the strip width default comes from Settings (31). (S-13, Tim's call) BT1 ignores the Settings "Longest wall brace (mm)" that AB and BB obey (BracingCommands.cs 49-59, 170 vs 296-302); never decide without Tim. (S-14) code-word sentences on the command line: R1 "[R1] Direction=Horizontal angle=0deg (dynamic=0, residual-rotate=0)." and "[R1] Inserted 'RAFTER-JOISTV2' on layer 'RAFTERS', tagged R1." (RafterJoistCommands.cs 227-228), BT1 "Flip toggled to 1." (BracingService.cs 1769), raw AutoCAD errors "[CE_STRUC_SUITE] Rotation fallback: <error>", "Rotation failed: <error>", "C1 insert failed: <error>" (SupportBlockCommands.cs 312, 816, 857), FEDIT "Select new type [ExternalBeam/InternalBeam/Thickening/StripFooting/PadFooting]" (FoundationService.cs 1901), beam command "Beam placed, but its post-write update needs review." and "Drawing evidence needs review." (BeamCommandAutoCadRoute.cs 400, 408). (S-15) BTX drops the text's own colour, linetype, width factor and slant (BeamTextConvertCommands.cs 112-121, 160-171); a missing height becomes a fixed 250. CAUSES for BUG-454: (a) the FPFC label is 2.5 x DIMSCALE tall in a millimetre drawing (FoundationService.cs 5068-5071, 2973); with DIMSCALE 1 and the annotation scale set instead it is 2.5 mm and invisible at a 1500 zoom (metre drawings already fall back to the annotation scale, 5077-5085); next Codex check: LIST the new PF label and read its height and DIMSCALE (W51 does); (b) FSF Enter: agreed, no AllowNone (3744-3749). HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_STRUC_2026-10-09.md (hunt_struc run 1, read-only, MAX account, 9 Oct about 09:00, installed Structural rel-20261009f 9babe787 = 1.0.110; code reading only; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-476

**Command / Area:** BLOCKS COLLEAGUE INSTALL. HUNT-M-01 (HIGH): there is no administrator list anywhere yet, so the first colleague to click "Admin Dashboard" in the CE Manager window (CEMANAGER) and answer Yes to "Set up CE administrator - make this Windows account the office administrator?" becomes THE office administrator, and Tim is locked out. Tim must become administrator first (Tim's own yes: nobody else writes the shared office policy). On the drive at 08:50 neither CE Plugin Admin\policies\admin-users.json (office folder) nor %APPDATA%\CE_CADTOOLS\CE_Admin\policies\admin-users.json (Tim's PC) exists. With no list, every PC is told "needs setup" and shown the button (Modules/Manager CeAdminPolicyService.cs 55-69; PluginManagerWindow.xaml.cs 60-61 and 796-818). When the office folder is reachable the seed writes the SHARED list (CeAdminPolicyService.cs 138-149), and once a shared list exists it wins over any list on Tim's PC (47-50), so Tim's button disappears. There is no "add an administrator" control anywhere in Manager, yet three messages say "ask an existing administrator to add you (Manager, Policies tab)" (CeAdminPolicyService.cs 124-125, PluginAdminWindow.xaml.cs 157-158, PluginManagerCommands.cs 142-144); getting Tim back would mean editing the office file by hand. The new administrator can then use Approve, Roll Back, Canary and Promote to All (BUG-477). I think: if a colleague cannot write to the office folder the seed falls back to "administrator on this PC only" (158-169), in jargon (not proven; depends on their SharePoint rights). Right result: Tim runs Manager > Set up CE administrator on his own PC first, with the office folder synced, and checks the shared admin list file exists in the office policies folder; the team hides the button on any PC whose user is not already on a list, and builds a real "add an administrator" control or rewords the three messages. To SEE (Codex, on a test Windows account, never Tim's): open CEMANAGER and check whether "Admin Dashboard" shows; after Tim seeds the list, check it is gone for the test account. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-477

**Command / Area:** HUNT-M-02 (MEDIUM): Manager's Roll Back is still offered and live, with no switch to hide it. CEMANAGERADMIN > Updates tab > "Roll Back Approved Release" is a normal working button (PluginAdminWindow.xaml 236-239; handler PluginAdminWindow.xaml.cs 216-246). It asks "are you sure", then writes a "Rolled Back" record that every PC acts on at its next start (CeApprovedReleaseService.cs 394-441, 498-611). DAY1 gap 3 and BUG-441 say do not offer it until one PC proves the installer accepts an older version; the only protection today is the administrator list, and there is none yet (BUG-476). Its messages also end "needs AutoCAD closed and the approved installer run", which a colleague cannot do (BUG-478). Right result: a Settings switch "Show Roll Back", default OFF, with the button hidden while it is off (R-27: hide, do not block). To SEE (Codex): open CEMANAGERADMIN > Updates and check the Roll Back button is not there. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-478

**Command / Area:** HUNT-M-03 (HIGH for the update channel): "Close AutoCAD, then use the approved installer" cannot be done by a colleague, so updates through Manager never finish. After "Get update ready", and on the status line, CE says "ready to install - close AutoCAD, then use the approved installer" or "run the CE installer to finish it" (CeReleaseStatusService.cs 70, 79, 116, 134; CePluginDescriptor.cs 309, 315; PluginManagerWindow.xaml.cs 616, 673, 682). The only installer that finishes a staged update is CE_CVL_SUITE_Installer.exe and it runs only when given four folder paths on its command line (Installer/CeInstallerApplication.cs 82-89); double-clicked it stops with "No installer operation was supplied." Nothing in Manager starts it (no caller anywhere in the repo besides its tests); the two PowerShell files in Installer/ are retired and exit with "RETIRED ... cannot install CE". On a job: the update sits in %APPDATA%\CE_CADTOOLS\CE_Admin\update-staging for ever and the amber status stays; the office install scripts (BUG-483) install whatever bundle sits in the office folder, not the staged copy. Right result (needs Tim's word on the route): either a "Finish update" step that starts the installer with the right folders after AutoCAD closes, or every message reworded to name the real route (the deploy chat's install script) until then. To SEE: approve a test build, click Get update ready, close AutoCAD, follow the on-screen words exactly and record where they fail. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-479

**Command / Area:** HUNT-M-04 (MEDIUM): an old April Structural approval makes CE say a newer Structural is approved, and the button then refuses in jargon. On the drive CE Plugin Admin\releases\CE_STRUC_SUITE\approved.json approves "1.0.117.0001" (28 Apr 2026) with no signed-content fingerprint; installed Structural is 1.0.110. The version compare reads 1.0.117 as newer than 1.0.110 (CePluginInstallerService.cs 148-162; the BUG-165 guard only catches year-style numbers), and the status line does not check the approval is valid before saying "New version approved: CE Structural Suite 1.0.117.0001 - in CE Suite Manager click Get update ready ..." (CeReleaseStatusService.cs 119-135). Get update ready then fails with "This approval predates exact signed-content verification. Approve the candidate again." (CeApprovedReleaseService.cs 690-691). I think: every PC with Structural and the office folder synced shows this amber line on the 2025 to 2027 ribbon (not drawn on 2022 to 2024; not seen on the ribbon). Right result: the administrator removes or replaces the April Structural approval (office file; Tim's call), and the team counts only approvals that pass the signed check and says in plain words "this approval is out of date, ask the office". To SEE: open CEMANAGER on a PC with Structural 1.0.110 and read the status line and the Structural row. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-480

**Command / Area:** HUNT-M-05 (MEDIUM): the status line says "CE is current." when the office folder cannot be reached at all. When the office folder is missing no approvals are read (CeApprovedReleaseService.cs 33) and the status falls through to "CE is current." (CeReleaseStatusService.cs 138); CEHEALTH does warn about the folder, the status line does not. On a job: a colleague at home without OneDrive, or whose office folder synced under a different name (Manager looks in only two places, CePluginInstallerService.cs 46-71), sees a green "current" for months while the office has moved on. Right result: say "CE cannot see the office folder, so it cannot tell if you are up to date." To SEE: rename the office folder on a test account, restart AutoCAD, read the status line. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-481

**Command / Area:** HUNT-M-06 (MEDIUM): Manager loads its own menu file and switches AutoCAD's classic menu bar ON (MENUBAR = 1) at every AutoCAD start. At start-up it loads CE_SUITE_MANAGER_MENU.cuix (Plugin.cs 172-175 into CeSuiteManagerMenuService.cs 765-791), reloads every menu, and sets MENUBAR to 1 whenever it is not 1 (794-799); the generated menu also carries "CE Manager" toolbars marked to show (572-576). A colleague who turned the menu bar off finds it back on at every start. I think this loaded menu is also what keeps the "Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager" start-up line (BUG-435); whether the toolbars appear depends on the workspace (not seen). So the DAY1 sentence "CE never edits your AutoCAD profile or acad.cuix on its own" is not safe to tell colleagues while this runs (DAY1 reworded 9 Oct). Right result: stop changing MENUBAR (a Settings switch, default OFF), and decide whether the old Manager menu is needed at all now the ribbon exists. To SEE: set MENUBAR to 0, restart AutoCAD, type MENUBAR and read the value. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-482

**Command / Area:** HUNT-M-07 (MEDIUM): CESUPPORT says the zip "has not been sent anywhere", but on Tim's PC the Desktop is inside OneDrive. Tim's Desktop is ...\OneDrive - Creative Engineering\Desktop and the "CE Support" folder is there. The zip goes to the Desktop "CE Support" folder (CeSupportBundleService.cs 53-55) and the message and the notes inside say "Support file saved on this PC ... It has not been sent anywhere" (93-96, 170). OneDrive copies the zip to the company account as soon as it is made; it stays in the company account and is already scrubbed, so this is a truth problem more than a leak, but the sentence is untrue there (colleagues with the office OneDrive setup are likely the same; not checked on their PCs). DAY1 now says so beside the CESUPPORT steps. Right result: save to a local CE folder (for example %LOCALAPPDATA%\CE Support) and open it, or say "saved to your Desktop (OneDrive may copy it to your account)". To SEE: run CESUPPORT and compare the folder it names with where OneDrive syncs. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-483

**Command / Area:** HUNT-M-08 (MEDIUM): the install files in the office folder install old builds, need administrator rights and promise automatic updates (publishing is Tim's call). Read only: Install-All-CE-Plugins.ps1 in the office folder root installs Manager, Structural and Civil into C:\ProgramData\Autodesk\ApplicationPlugins, asks for administrator rights (lines 26-36) and ends "Future updates install automatically when you open AutoCAD." (line 150, untrue). CE SUITE MANAGER\Install-CESuiteManager.ps1 also asks for administrator rights and writes ProgramData (19-32) and says "Future CE plugin updates will install automatically ... no action required." (94-95). The bundles beside them are Civil 2.1.14, Structural 1.0.41 and Manager 1.0.0; the Civil script installs per user (%APPDATA%) instead. A PC without administrator rights cannot install Manager this way at all; a colleague who later runs Install-All gets old copies in ProgramData beside their 3.0 copies in %APPDATA%, and Manager prefers the ProgramData copy when it lists tools (CePluginRegistryService.cs 56-58), so it would report the old version (I think AutoCAD would then load both copies; not tested). The Civil and Install-All scripts also write install-metadata.json with the real Windows name and computer name into the bundle (lines 88-97 and 111-120), at a place Manager never reads (Contents\config\install-metadata.json, CePluginRegistryService.cs 395). The plan text is wrong too: areas/release-v3-colleagues.md line 187 says these scripts copy into the user's plugin folder; for Manager and Install-All they copy into ProgramData. Already known, not counted here: delete-then-copy with no backup and no AutoCAD check (area file line 232, ROLLBACK_GUIDE line 212). Right result (Tim's call): move the old scripts and builds into an "OLD - do not use" sub-folder and put one plain "how to install" note beside the real pilot package. To SEE: list the office folder root and check no runnable install script remains there. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-484

**Command / Area:** HUNT-M-09 (MEDIUM): CEHEALTH says "All checks passed" without checking Manager, the Civil and Manager pair, or two copies of one tool. CEHEALTH walks the tool list, which leaves Manager out on purpose (CePluginRegistryService.cs 52-54), so Manager never gets a line (Codex W45's output shows no Manager line). It never compares the Civil and Manager versions, although they must ship the same shared file (memory rule "CE_SHARED is one assembly identity"; INT-069 item 11), and it keeps only the first copy of each tool it finds (56-58), so a second copy is never reported (PluginManagerCommands.cs 176-222). On a job: a colleague with Civil 3.0.41 and an older Manager gets "All checks passed" while the shared file may be the wrong one. Right result: add a Manager line, a "Civil and Manager are a matching pair" line and a "two copies found" warning. To SEE: CEHEALTH on Tim's PC shows a Manager line and a pair line. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-485

**Command / Area:** HUNT-M-10 (MEDIUM, not proven in AutoCAD): Refresh and "Send waiting reports" copy into the office folder with nothing to catch an error. The Manager window's Refresh and "Send waiting reports" buttons, and the admin window's Refresh and "Upload pending" buttons, call the office-folder copy directly with no error catch (PluginManagerWindow.xaml.cs 502-508, 760-764; PluginAdminWindow.xaml.cs 137-142, 165-167); the copy loop stops on the first failure (CeAdminStorageService.cs 159-163). It bites when the office folder is read-only for a colleague or OneDrive is holding a file. I think the error then escapes the window and AutoCAD shows its own error box or closes (AutoCAD's handling is closed to us; not proven). CEMANAGERREFRESH does catch it but prints the raw Windows error, which carries the login folder. Right result: catch it, keep the reports waiting, and say "Could not reach the office folder; reports will wait on this PC." To SEE (Codex, test account with a read-only office folder): click Refresh in CEMANAGER and record what appears. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-486

**Command / Area:** HUNT-M-11 (MEDIUM, "I think"): on AutoCAD 2022 to 2024, getting an update ready may fail on long folder names. The staged copy goes to %APPDATA%\CE_CADTOOLS\CE_Admin\update-staging\<tool>\<version>\<77-character fingerprint folder>\<tool>.bundle\... (CeUpdateStagingService.cs 328-363). On Tim's PC 96 staged files already have paths over 260 characters (longest about 272) with a 12-letter Windows name; Structural's deepest file inside the bundle is 112 characters. I think the 2022 to 2024 lane runs on the older .NET inside AutoCAD, where paths over 260 characters may fail unless Windows long paths are switched on (not proven; a longer Windows name makes it worse). Right result: a much shorter staging folder (for example a 12-character fingerprint) and a test with a 30-character user name. To SEE (Codex, AutoCAD 2024 test copy): approve a test build, click Get update ready, read the result. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---

## BUG-487

**Command / Area:** HUNT-M-12..15 (four LOWs, reading only): (12) colleagues' status line will carry Tim's "feedback notes waiting" count and it never clears: the count reads %USERPROFILE%\Creative Engineering\Creative Engineering - IT Admin\CE Diagnostics\feedback on any PC (CeFeedbackInboxService.cs 20-49; the comment assumes a colleague has no such folder, but they do whenever the office folder is synced there), nothing ever calls "mark as seen" (86, no caller), and there are 4 notes there today, so every such PC would read "4 feedback notes waiting." for ever; fix: show the count only to the administrator and wire "mark as seen". (13) The "Send waiting reports" hover text is no longer true (PluginManagerWindow.xaml 226 still says support zip files are sent and carry your Windows name and this PC's name; support zips found waiting are now deleted, never sent (CeAdminStorageService.cs 152-157) and reports carry coded names (CeAdminTelemetryService.cs 92-93, 125-126, 223-224)); fix: reword to what is sent now. (14) A tool not yet on the PC is got ready for C:\ProgramData, which needs administrator rights (CePluginInstallerService.cs 214-218; CePluginRegistryService.cs 146-148; PluginManagerWindow.xaml.cs 870-874); Tim moved installs to the per-user folder on 12 Jun because ProgramData needed administrator rights and AutoCAD 2027 did not pick it up (comment kept in Installer/Program.cs 363-372); fix: use %APPDATA%\Autodesk\ApplicationPlugins for a first install too. (15) Raw program words on the command line and in the fault report box: at AutoCAD start "[CE_SUITE_MANAGER] Telemetry initialization failed: <Windows error>" and "... Workspace menu initialization failed: ..." (Plugin.cs 101, 110, 123), "[CEMANAGER] Workspace menu install skipped: Application.LoadPartialMenu returned false." or "prepare-output: <error>" (CeSuiteManagerMenuService.cs 139, 149, 272, 788), and every colleague's start-up text lists "CEMANAGERADMIN - Open the administrator dashboard" (Plugin.cs 164); the fault report says it could not save "in the office IT folder or on this PC" (PluginManagerWindow.xaml.cs 746-748) but only ever tries the office folder whenever it exists (CeDiagnosticsService.cs 285-289), and offline it says "Fault report sent" when it was only written to the local OneDrive copy; fix: plain sentences with a next step, and drop the administrator line from colleagues' start-up text. ALREADY IN THE CARPARK AND STILL TRUE AT MANAGER 1.1.41 (not new, listed so nobody refiles them): (a) BUG-425 S2-009: CEMANAGERDIAG / "Send a fault report" still writes the real Windows name and computer name into the office folder (CeDiagnosticsService.cs 54-55, 279, 291); (b) BUG-425 S2-016 and S2-017: a failed background staging is not recorded and staged copies are never removed (108 MB of old copies in Tim's staging folder today); (c) BUG-425 S2-007: "Starts with AutoCAD" rewrites the installed tool's own start-up file (CePluginRegistryService.cs 241-279); (d) BUG-435: the three start-up lines (BUG-481 is the Manager part of the cause, as the hunt reads it). The hunt also skipped everything already in BUG-425 (S2-001 to S2-025), BUG-441 (Roll Back, see BUG-477), BUG-452, BUG-455 and BUG-170. Checked and fine: the closed-AutoCAD installer is careful (refuses while acad or accoreconsole runs, checks the signed release and every file fingerprint, keeps a rollback copy, swaps whole folders, puts the old one back on failure: SafeBundleInstaller.cs 139-365); Manager makes no network calls; CESUPPORT contents are scrubbed as W45 saw. Not checked: nothing was run; settings transfer (none found in Manager or the installer); colleagues' OneDrive, rights and Desktop; the deploy chat's pilot install script; Civil and Structural code. HUNT file: C:\CE_PLAN\areas\release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (hunt_mgr run 1, read-only, MAX account, 9 Oct 08:40-08:54; installed Manager 1.1.41 / Civil 3.0.41 at 660487d1, Structural 1.0.110; code, office folder and installed files read only; nothing built or run; none seen in AutoCAD).

**Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Manager and installer bug hunt. Never FIXED until Tim confirms in AutoCAD.

---
