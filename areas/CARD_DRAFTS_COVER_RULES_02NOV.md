# Card drafts 7 of 15: cover, CDRULES and Project Review

Written Monday 2 Nov 2026 (Melbourne) by Sonnet for CE 05, at CE 00's request. Read-only job: this is the only file written. Nothing was built, tested, installed or opened in AutoCAD. No git write command was run (only `git fetch`, `git show`, `git grep`, `git merge-base`, `git log`).

## FOR TIM

1. **Five cards below, all drafts, nothing approved.** Cover (#1897 and #1920), Project Review "Pipe sizes" speed (#1985), CDRENUMBER and "Not saved" wording (#1889 and #1890), the CDRULES "Assumed roughness" line plus the full findings file (#1230), and the speed table plus large-pipe fall (#1960 and #1868).
2. **None of the eight PRs is on the C-78 line (`rel-20261102a`, Civil 3.0.88).** I checked each PR head against the branches: #1889 and #1890 first appear on `rel-20261106a` (C-79a); #1868 on `rel-20261108a` (C-79b1); #1897, #1920 and #1960 on `rel-20261110a` (C-79b2); #1985 and #1230 are on no branch (drafts only). The "cover row" in CDRULES that you can see today is the C-78 cover table (Garden 300, Footpath 100, Driveway 100, Driveway larger vehicles 450, Road 600).
3. **Two cards are really "already there, needs a robot look":** the CDRULES "Assumed roughness" line (#1230 can be closed, the same guard has been on the line since 9 Oct) and the CDRULES All findings file. Neither has been seen in AutoCAD by me or anyone I could find a record of.
4. **Could not pin down:** which ribbon panel holds the Inspector button (I found only its command CDINSPECTOR); where the speed-limit table and the 450 mm and larger fall figure sit on the Settings page (I found no Settings box for either, so I have written "file only, GUESS"); whether the CDCHECK "main outlet" sibling of #1890 has its own carpark entry (I found none).
5. **One thing I found that the reviews did not say plainly:** #1897 and #1920 do not change Project Review "Pipe sizes". That screen still reads one network-wide minimum cover (`PipeSizeNetworkReviewService.cs`, `ResolveMinCoverMm`), not the per-surface table. So a Road pit can be judged 600 on the Inspector and 300 in Project Review. Question 1.
6. **Questions that need you (all in the cards, none turned into decisions):** (1) should Project Review also use the surface cover table; (2) concrete pipe speed, house 6.0 or the CPAA manual's 8 m/s; (3) the 1-in-N figure for 450 mm and larger gravity pipes; (4) a pick-the-outlet question for CDRENUMBER; (5) whether Ignore (CDCHECKIGNORE) is ever switched on for the office.
7. **What was read:** the Opus pre-reviews (S, AB, 1984 to 1988 group, BACKLOG R1 and R4, RECHECK), BUILD_REGISTER items, carpark entries BUG-903, 1258, 1237, 1071, 514, 080, 1091, QUESTIONS 79, 112, 114, decisions 17, 113, 127, 154, 155, the C-78 REGRESSION_LOG entries, the registry, ribbon and code on `rel-20261102a`, and the PR heads' own change-log text.
8. **NOT proven, for every card:** nobody has opened any of this in AutoCAD. Built and unit-tested by the authors only (I re-ran nothing). Installed: only C-78 per the register (I did not read the installed DLL). Tim-accepted: none.

---

## Line status (read with git on Mon 2 Nov)

1. **Civil/Manager line:** `origin/claude/rel-20261102a` is `3fbb9da5` "Version: Civil 3.0.88 / Manager 1.1.88 (C-78)".
2. **PR heads read:** #1897 `b73618c3`, #1920 `aba41924`, #1985 `ad5f254c`, #1889 `ff36dbeb`, #1890 `5e8e208f`, #1230 `a656036a`, #1960 `02d582e3`, #1868 `38c3f825`.
3. **Which branch holds each (git `merge-base --is-ancestor`):**
   1. #1889, #1890: on rel-20261106a, 08a, 10a, 12a. Not on 02a.
   2. #1868: on rel-20261108a, 10a, 12a. Not on 02a or 06a.
   3. #1897, #1920, #1960: on rel-20261110a and 12a only.
   4. #1985, #1230: on no release branch. Drafts.
4. **Stack facts:** #1985 sits on #1857's head `718ec21c` (#1857 is on rel-20261106a and later). #1868 sits on #1841, which is already in C-78 (never merge #1841 again). #1920 sits on #1897.

---

# CARD 1

## DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter:** One minimum cover on every cover screen. A pit judged against the same minimum cover on the Inspector, Civil Hub, repair check and CDRULES, measured to the outside top of the pipe.
2. **Ribbon or trigger (read on the line):**
   1. CDRULES: typed only. Registry label "Rule Check (CDRULES)", hidden, "Check the drawing against the engineering rulebook: velocities, grades, cover, pit drop. Read-only." Ribbon file note: "CDCHECK and CDRULES are typed only."
   2. Inspector: command CDINSPECTOR, label "Inspector", "Open the CE Inspector context palette". I did not find its ribbon panel.
   3. Civil Hub: command CDHUB, label "Civil Hub".
   4. Project Review: tab "CE", panel "Review", large button "Project Review" (command CDDASHBOARD).
   5. Repair check: the CDGRAPH repair audit (Pass D). I did not find a button.
3. **Works today (C-78, what Keep would protect):** CDRULES minimum cover follows the surface the pit sits in (GB-01 slice 2, 29 Oct): Garden 300, Footpath 100, Driveway 100, Driveway (larger vehicles) 450, Road 600 mm, measured to the outside top of the pipe. A council figure or project override wins. A pit with no surface keeps the single office minimum (300). Driveway and Footpath rows add a slab thickness (`minCoverPavedSlabMm`, blank = 100 mm, file only). The row names the surface, e.g. "below 450 mm (Driveway (larger vehicles) surface, office cover table)". The other screens (Inspector, Hub, repair check) still use pit depth against a different minimum (BUG-903 symptom).
4. **What the train or PR changes:**
   1. **#1897 (B-022, C-79b2, 15 files):** these screens now read `RulebookValues.MinCoverFor(pit surface)`: Inspector pit cover row and network summary; Civil Hub; CDGRAPH repair Pass D and health snapshot; Edit Pipe and CD grade/flow strips; pit editor and Smartify strips (Opus S). Switch `checks.screensShareOneCover`, ON, file only. OFF restores each screen's old figure.
   2. **#1920 (B-096, stacked on #1897, C-79b2):** Inspector, Civil Hub and repair check measure to the outside top of the pipe, as CDRULES does (Tim's "10yes", decision 127). New rule `PitCoverToPipeTopRule`, same measure CDRULES uses; wall from the Settings wall table; shallowest pipe into the pit wins. Switch `checks.screensMeasureCoverToPipeTop`, ON. OFF = ground minus pit invert exactly.
   3. **Install together.** Opus S: #1897 alone lets a driveway pit with 250 mm depth pass where it failed before. If #1920 slips, hold #1897.
   4. Tim's "7yes" (driveway slab) is already on C-78 (carpark note, job x3). No new PR.
5. **Suggested class: Modify.** The behaviour changes (Road pit with 400 mm cover to the pipe top now warns on screens that said OK). Suggestion only.
6. **Prompts and windows (wording from the PR change log):**
   1. Inspector pit row: "Cover to the outside top of pipe L1: 400 mm, min 600 mm".
   2. Hub and Inspector summary: "Pit P1 cover is 400 mm to the outside top of pipe L1, below the 600 mm minimum".
   3. Repair check Pass D: "depth 400 mm to the outside top of pipe L1 < 600 mm min".
   4. A pipe whose wall is Unknown in Settings: measured to the inside top and the line says the wall is Unknown.
   5. Known leftover wording: Hub still says "below the 600 mm office target" when 600 is the Road table or a council figure (`CivilNetworkHealthService.cs` line 247 on the line). Opus S says #1920 rewrites it; I did not confirm that.
7. **Selection:** none. The screens read the drawing's recorded pits and pipes. The Edit Pipe/CD strips read the pipe being edited and the pits at its two ends (the strictest end wins).
8. **Preview:** none. Read-only screens and advice strips.
9. **Drawing output:** nothing is drawn or changed (a test pins "no drawing write", per Opus S). No layer, Xref or REFEDIT path is touched, nothing is unlocked. Hub finding severity unchanged (Info).
10. **Cancel, Escape, Undo and Redo:** nothing to undo, as nothing is written. CDRULES itself records its run in the drawing's project record (not a drawing change); not part of this change.
11. **Save and reopen:** screens re-read on open. A pit with no surface, no invert, no diameter or no cover level keeps the old pit-invert figure (stays Unknown, never a green pass).
12. **Assets, data and Settings:** reads `designStandards.minCoverBySurfaceMm`, `minCoverPavedSlabMm`, the council profile, the project override and the Settings wall table. Writes none. Two file-only switches. Trap (Opus S): while `screensShareOneCover` is ON the Settings tick for the older `coverUsesRulebookValue` has no effect. A drafter who unticks it sees nothing change.
13. **Performance:** not measured. GUESS: small; one extra lookup per pit.
14. **Discovery:** CDINSPECTOR, CDHUB and CDDASHBOARD have Help entries in `guide-content.js`. I found no Help entry for CDRULES. The changed wording is the only signal.
15. **Example drawing and expected result (numbers from the PR change log):** Road pit, ground 10.000, pit invert 9.350 (650 to the pit invert), UPVC 225 at invert 9.355 (400 to the pipe top), wall about 20 mm. Before: Inspector and Hub say OK (650 against the office 300). After #1897 and #1920: the Inspector pit row warns "min 600 mm". CDRULES R-04 already warned. Second example: Driveway pit, 250 mm depth. #1897 alone: passes against 200. With #1920: judged on the pipe top, so it fails where the pipe top is under 100 mm.
16. **Older family card:** no cover card found. Closest: `docs\CARDS\CV-02_HYDRAULIC_DESIGN.md` and `docs\workflows\C6_A1_APPROVED_R03_R04_PROPOSALS_2026-09-10.md` (R-04 cover proposals, "no cover rule changes here"). They say nothing about the cover table by surface, the other screens reading the same figure, or the pipe-top measure.
17. **Tim's AutoCAD checklist (on a copy, after a build with #1897 and #1920 is installed):**
   1. Make a Road pit, ground 10.000, pit invert 9.350, one UPVC 225 pipe at invert 9.355. Set the pit Surface to Road in the Pit window.
   2. Type CDRULES, press Enter, choose All. See a "Minimum cover" row warning at 600 mm, naming the Road surface.
   3. Type CDINSPECTOR and select the pit. See the cover row warn with "400 mm" and "min 600 mm".
   4. Type CDHUB. See the pit listed as 400 mm to the outside top of the pipe, below 600.
   5. Open Project Review (tab CE, panel Review) and look at Pipe sizes. Note what minimum it names. Right: the same 600. Likely today (see question 1): the single office 300.
   6. Change the pit Surface to Garden. All three screens should now say 300 and pass at 400.
   7. Press U twice after step 6's change. Nothing from these screens should have been written.
18. **Questions only Tim can answer:**
   1. **Context:** Project Review "Pipe sizes" reads one network-wide minimum cover (`ResolveMinCoverMm`), not the surface table. **What I understand:** #1897 and #1920 do not edit that file. **Recommendation:** yes, make it read the same figure, so no screen disagrees (design rule 1). **On a job:** a Road pit at 400 mm cover to the pipe top is flagged by CDRULES and the Inspector but not offered a deeper size in Project Review.
   2. **Context:** should Edit Pipe and CD strips be told "measured to the pipe top" too? They hold a minimum only, not a measured cover (#1920 log item 7). **Recommendation:** leave as is. Nothing to measure there.
19. **NOT proven:**
   1. **Built:** yes, by the authors (#1897 net48 and net10 per the register; #1920 built on #1897). I did not rebuild.
   2. **Tested:** unit tests only (`Bug903OneCoverFigureTests`, `Bug903PipeTopCoverTests`). The Inspector pit row is proved by a shared routine and a source check only. No test ran "red before, green after" on the old code in the way Opus described for the worked examples I could verify.
   3. **Installed:** not installed. C-78 is the installed line; neither PR is in it.
   4. **Tim-accepted:** no. Nobody has opened the Inspector, Hub or repair check on a Road pit in AutoCAD. BUG-903 stays OPEN.
   5. **Nobody has done:** the two-pits-on-different-surfaces strip case, the no-surface pit, and the Inspector and Hub text look.

---

# CARD 2

## DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter:** Project Review "Pipe sizes" agrees with CDRULES about a blank speed limit. A pipe whose material has no speed limit is judged against the office maximum pipe velocity (6.0 m/s as shipped) on both screens.
2. **Ribbon or trigger:** tab "CE", panel "Review", large button "Project Review" (CDDASHBOARD), then the Proposals window, "Pipe sizes" (`ProjectReviewProposalsDialog.xaml`). CDRULES typed only.
3. **Works today:** on C-78 (and before #1857) a material with a blank or zero speed limit shows "Unknown: no speed limit is set in Settings for "UPVC"" (`PipeSizeNetworkReviewService.cs` line 184). #1857 (C-79a, on rel-20261106a) makes CDRULES judge such a pipe against the office Maximum pipe velocity. Project Review was left saying Unknown: the two screens disagree (BUG-1258).
4. **What the PR changes:** #1985 (B-148, BUG-1258, draft, one commit on #1857's head): Project Review's two speed lookups (`ResolvedStandards`, `MissingSizingValue`) call the same `rulebook.ScourVelocityForCheck(material, ...)` CDRULES uses. A blank material speed takes the office figure and the pipe gets Keep or Upsize. A material with its own speed is untouched. If the office figure is also blank, it stays Unknown with the old words. Switch `pipeSpeedChecks.projectReviewUsesOfficeVelocityForUnsetMaterial`, ON, file only; it is combined with #1857's `unsetMaterialUsesOfficeFigure` so the two screens cannot disagree. OFF = old answer exactly. **On no branch yet.** Opus verdict: KEEP-WITH-NOTE.
5. **Suggested class: Modify.** It turns an "Unknown" into an answer, and Project Review proposals can be applied. Suggestion only.
6. **Prompts and windows:** old text "Unknown: no speed limit is set in Settings for "UPVC"". New: a normal Keep or Upsize row. No new wording was found in the PR text.
7. **Selection:** none. Project Review reads the whole recorded network.
8. **Preview:** the Proposals window already previews each change before it is written ("Review each change before it is written. Rule proposals are applied one at a time", `ProjectReviewProposalsDialog.xaml` line 72). Opus 1984 to 1988: a pipe that used to show nothing can now be offered an Upsize, which you can apply. It still needs your click.
9. **Drawing output:** the review reads the project record and writes nothing to the drawing. If you press Apply on an Upsize, that goes through the existing apply path, not this PR. I did not read that path's layer, Xref and REFEDIT checks for this card. GUESS: unchanged by #1985.
10. **Cancel, Escape, Undo and Redo:** closing the window without applying changes nothing. Undo of an applied proposal is the existing behaviour, not changed.
11. **Save and reopen:** nothing stored by this change.
12. **Assets, data and Settings:** reads Settings `designStandards.maximumPipeVelocity` (office, 6.0) and the material speed table; switch above. No number in code. Not on the Settings page (the author offers a row as a follow-up).
13. **Performance:** not measured. GUESS: none noticeable.
14. **Discovery:** CDDASHBOARD has a Help entry. Nothing explains the speed rule.
15. **Example and expected result:** blank the UPVC speed limit in the settings file. A pipe reads 4.2 m/s (example reading, not measured). CDRULES: judged against 6.0, passes. Project Review before: "Unknown: no speed limit is set in Settings for "UPVC"". After: Keep. A pipe reading 7.0 m/s: both say over 6.0, and Project Review offers an Upsize.
16. **Older family card:** `docs\workflows\C6_A1_APPROVED_R03_R04_PROPOSALS_2026-09-10.md` covers only R-03 and R-04 proposals. It says nothing about speed (R-00 speed rows), "Pipe sizes", or the unset-material rule.
17. **Tim's AutoCAD checklist (after a build with #1857 and #1985):**
   1. On a copy, blank the UPVC maximum speed in the settings file, then start AutoCAD (settings are read at start).
   2. Draw a UPVC pipe that reads under 6.0 m/s. Type CDRULES, Enter, choose All. Note the speed verdict and the limit it names.
   3. Open Project Review (tab CE, panel Review), Proposals, Pipe sizes. Right: the same limit (6.0), not "Unknown".
   4. Draw a pipe over 6.0 m/s. Right: an Upsize is offered, nothing applied until you press Apply.
   5. Set `projectReviewUsesOfficeVelocityForUnsetMaterial` to false, restart: Project Review says Unknown again, CDRULES still gives 6.0 (that is the old split, on purpose).
18. **Questions only Tim can answer:**
   1. **Context:** Project Review proposals can be applied. **What I understand:** a pipe that offered nothing before can now offer an Upsize. **Recommendation:** keep, it is what BUG-1258 asked for. **On a job:** a 150 UPVC with no speed limit set now gets a bigger size offered at 7 m/s instead of silence.
   2. **Context:** the speed table and office figure have no Settings page box on the line. **Recommendation:** leave file-only until the "Switches" tab (decision 126) exists.
19. **NOT proven:**
   1. **Built:** yes, by the author (net48 compile, 0 errors). Needs the C-79 line under it.
   2. **Tested:** 13 new unit tests, 239 of 239 in the focused run on net10 (author's report). None run red before.
   3. **Installed:** no.
   4. **Tim-accepted:** no.
   5. **Nobody has done:** looked at the Pipe sizes window in AutoCAD. CE 02 does not know whether the robot can read its rows (robot case N48).
   6. **Merge note:** needs one blank line added after its change-log entry, or the C-79c log check fails.

---

# CARD 3

## DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter:** CDRENUMBER says what to draw when it cannot find the outlet (#1889, BUG-1237), and Ignore and CDRULEBOOK say "Not saved" when CE did not save (#1890, BUG-1071). Both are word changes on the command line.
2. **Ribbon or trigger:**
   1. **CDRENUMBER:** typed only. Registry "Renumber Pits (CDRENUMBER)", hidden; "has its own guide-content.js entry".
   2. **CDCHECKIGNORE:** hidden, "Not switched on yet", needs `checks.allowIgnoreFinding` (default false).
   3. **CDRULEBOOK:** registry "Rulebook Settings (CDRULEBOOK)", group Layers, subgroup Preferences. I did not read its ribbon placement.
3. **Works today (C-78):**
   1. CDRENUMBER with no pipe leaving any pit to open ground: prints "No pit discharges outside the network — CE could not tell which pit is nearest the outlet." (`PitRenumberNetworkBuilder.cs` line 140) and stops.
   2. CDCHECKIGNORE, when CE holds the drawing's record as unreadable, prints "[CE] Ignored: P1. It stays hidden until the pit, the pipe or the rule value changes. Type U to take it back. Nothing else was changed." (`CheckIgnoreCommand.cs` line 172) although nothing was stored. CDRULEBOOK prints "[CE] Pit invert drop set to X. Run CDRULES to re-check." (`RulebookCommand.cs` line 60), also with nothing stored.
4. **What the PRs change:**
   1. **#1889 (B-067, C-79a, on rel-20261106a and later):** new sentence (below). Switch `linking.renumberNoOutletSaysWhatToDraw`, ON. OFF = the old sentence byte for byte. Still stops at the same point.
   2. **#1890 (B-067, C-79a, same branches):** the save routines now report whether they wrote. A skipped save prints one "Not saved" line and not the success line or the Undo promise. Covers Ignore, Un-ignore and six CDRULEBOOK saves (pit drop by shortcut and by prompt, council set and cleared, cover override set and removed). Switch `linking.saveSkippedSaysNotSaved`, ON. OFF gives the old success lines.
5. **Suggested class: Modify** (wording only; both stops already existed). Suggestion only.
6. **Prompts and windows (exact words from the PR heads):**
   1. **CDRENUMBER, old:** "No pit discharges outside the network — CE could not tell which pit is nearest the outlet."
   2. **CDRENUMBER, new:** "CDRENUMBER numbers the pits from the outlet, but no pipe leaves any pit to open ground or an outfall, so it cannot tell which pit is the outlet. Draw the last pipe from the downstream pit out to an open end (finish it clear of every pit), then run CDRENUMBER again. Nothing was renumbered."
   3. **Ignore, new:** "[CE] Not saved: the CE data in this drawing could not be read, so CE has left it exactly as it is and has not saved this. P1 ... is not ignored and still shows on the Checks list. Nothing was changed, so there is nothing to undo."
   4. **Un-ignore, new:** same first sentence, then "... is still ignored. Nothing was changed, so there is nothing to undo."
   5. **CDRULEBOOK, new:** same first sentence, then "<the pit invert drop> is still <what it was>. Nothing was changed."
7. **Selection:** CDRENUMBER: none (it numbers every plain pit). Ignore: you pick a finding from the list, a reason (Survey, Council requirement, Engineer's judgement, Other) and press Enter.
8. **Preview:** CDRENUMBER normally previews before it renumbers (registry: "Preview and renumber every plain pit number downhill to uphill"). In the no-outlet case it stops before any preview. The others have none.
9. **Drawing output:** nothing written in the new paths. #1890 changes only the return value of the writers; the damaged record stays protected (BUG-971). #1889 writes nothing and touches no layer.
10. **Cancel, Escape, Undo and Redo:** "Nothing to undo" is true for the drawing. Opus S: Ignore still runs the nested CDCHECKIGNOREAPPLY command, which leaves an empty Undo step, so one U may step over it (cosmetic).
11. **Save and reopen:** #1890 is exactly about a drawing whose record cannot be read. After "Not saved", reopening shows the record unchanged.
12. **Assets, data and Settings:** the two switches above (file only). Ignore needs `allowIgnoreFinding` ON. Nothing else.
13. **Performance:** none (words).
14. **Discovery:** CDRENUMBER has a Help entry. I found no Help entry for CDCHECKIGNORE or CDRULEBOOK.
15. **Example and expected result:** Tim's own hand check H13: pit P1, pit P2, one pipe P1 to P2, two older pipes running into P1 from open ends. Run CDRENUMBER. Expected: the new "Draw the last pipe..." sentence, and the labels P1 and P2 unchanged. For #1890: a synthetic drawing with P1 on a wrong layer and `lastPitNumber` set to BROKEN (carpark steps), Ignore P1's finding: expect "Not saved", and the finding still on the Checks list.
16. **Older family card:** none for CDRENUMBER found. `docs\CARDS\CV-01_DRAINAGE_NETWORK.md` is the nearest GUESS and I did not read it for this card. `docs\workflows\ES01_SAVED_RULE_SOURCES_2026-09-12.md` covers CDRULES sources, not Ignore or "Not saved". Neither covers either sentence.
17. **Tim's AutoCAD checklist:**
   1. **#1889:** on a copy, two pits joined by one pipe, no pipe leaving either pit. Type CDRENUMBER, Enter. Right: the "Draw the last pipe..." sentence. Wrong: the old "No pit discharges..." line.
   2. Draw the open-ended pipe it asks for and run CDRENUMBER again. Right: P1 is the pit nearest the outlet.
   3. **#1890** (the robot or Codex builds the unreadable-record drawing; do not do this on a real job): type CDCHECKIGNORE, Enter, pick P1's wrong-layer finding, reason Other, Enter. Right: the "Not saved" line.
   4. Type CDCHECKS. Right: P1's finding is still listed.
   5. Type CDRULEBOOK 50, then CDRULEBOOK Show. Right: the drop is not claimed to be 50 if it did not change.
18. **Questions only Tim can answer:**
   1. **Context:** Tim's plan has a "Which pit is the main outlet?" question. #1889 only says what to draw. **What I understand:** the pick is not built (author's REGRESSION_LOG item 5, Opus S). **Recommendation:** add "pick the outlet pit" as a follow-up build, not now. It is low severity and the sentence now tells you what to do. **On a job:** a drainage-only sketch with no outfall pipe would let you tick the outlet pit instead of drawing a stub.
   2. **Context:** is Ignore (CDCHECKIGNORE) going to be switched on for the office? It is OFF and hidden. **Recommendation:** leave it off until Codex has passed the Checks list. **On a job:** until then the "Not saved" wording only matters on a test drawing.
   3. **Note, not a question:** the CDCHECK main-outlet save (`SpineCheckCommand.cs` lines 476 and 480) has the same fault and needs its own carpark entry (Opus S). I found none; that is for CE 05.
19. **NOT proven:**
   1. **Built:** yes, by the authors; in C-79a (rel-20261106a).
   2. **Tested:** unit tests (7 for #1889, word, decision and source checks for #1890). The "Not saved" path was not driven on a real held drawing; the author says that needs AutoCAD.
   3. **Installed:** no (C-78 is installed per the register; these are C-79a).
   4. **Tim-accepted:** no. Robot cases C31 and C32 are designed, not shown as run in anything I read.
   5. **Nobody has done:** either sentence in AutoCAD.

---

# CARD 4

## DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter:** CDRULES shows "Velocity uses Assumed roughness" only for a pipe whose Manning n is really unconfirmed (BUG-514, PR #1230). Also: CDRULES All saves every finding to a text file, so you can read past the 20-row command line.
2. **Ribbon or trigger:** CDRULES, typed only (registry "Rule Check (CDRULES)", hidden). At the prompt "CE rules: show all findings, problems only, the values in use, or explain each problem" pick All, Problems (the default), Values or Explain. Also Preview and Source keywords exist.
3. **Works today (on the C-78 line):** `RulebookEngine.cs` lines 487 to 490 on rel-20261102a already read `if (roughness.IsAssumed)` before adding the warning. Commit 499b97c8 (9 Oct 2026, "HUNT2-C-10: Assumed roughness warning only when unconfirmed") did this, with the test `AssumedRoughnessWarningTests.cs` (Opus R4). I read the guard on the line myself.
4. **What the PR changes:** nothing needed. #1230 (head `a656036a`, base `rel-20261009w`) is the same one-line guard. Opus R4: CHANGE-NEEDED, close it, do not merge: it edits a protected file and would clash. It is on no branch. BUG-514 should name 499b97c8.
5. **Suggested class: Keep.** "Waiting for a robot look". Suggestion only.
6. **Prompts and windows:** the finding row reads "Velocity uses Assumed roughness" (R-00, "Velocity input provenance", Warn), with the roughness's description beneath. The full list: "[CE] Full list saved: <path>. Drawing geometry unchanged; results recorded in the project." (`RulesCommand.cs` line 115).
7. **Selection:** none (whole drawing). The command line pages 20 rows at a time.
8. **Preview:** none for All or Problems. The Preview keyword opens the existing proposal window, not touched here.
9. **Drawing output:** none. The command records its run in the drawing's project record, not the geometry. I did not re-check the protected-layer behaviour of that record write for this card.
10. **Cancel, Escape, Undo and Redo:** read-only. HUNT-C-04 in the carpark is a separate OPEN note that "Nothing was changed" can be wrong (CDRULES does record the run). Not part of this card.
11. **Save and reopen:** the full list is `%APPDATA%\CE_CVL_SUITE\logs\cdrules-<drawing>-<UTC yyyymmdd-hhmmss>.txt` (memory note, run 34, 20 Oct). Reopening the drawing does not recreate it.
12. **Assets, data and Settings:** reads the confirmed Manning n list (`ManningsNConfirmedMaterials`) from Settings. No new Settings. The All file is written to the log folder.
13. **Performance:** not measured. The command line shows at most 80 rows listed (`MaximumListedRows`) and pages 20; the file holds the full list.
14. **Discovery:** I found no Help entry for CDRULES in `guide-content.js`. Command line only.
15. **Example and expected result:** 30 UPVC pipes. Confirm the UPVC Manning n in Settings, then CDRULES All: no "Assumed roughness" rows for UPVC. Clear the confirmation and run again: one row per UPVC pipe. Before the guard, DAY1 step 13 saw 29 such rows in the summary count.
16. **Older family card:** `docs\workflows\C1_RULECHECK_GEOMETRY_2026-09-07.md` and `ES01_SAVED_RULE_SOURCES_2026-09-12.md` (CDRULES Source). They do not mention the provenance warning, the confirmation list or the saved full-findings file.
17. **Tim's AutoCAD checklist (robot or Codex on a copy, settings set before launch):**
   1. Confirm the UPVC roughness in the disposable settings, start AutoCAD, open a drawing with several UPVC pipes.
   2. Type CDRULES, Enter, choose All. Note the path after "Full list saved".
   3. Open that text file. Right: no "Velocity uses Assumed roughness" row for UPVC.
   4. Clear the confirmation, restart, repeat. Right: one row per UPVC pipe.
   5. Read the saved file, not the command line.
18. **Questions only Tim can answer:** none new. The Manning n values are engineering figures; only Tim's word confirms the values themselves (not part of this card).
19. **NOT proven:**
   1. **Built:** yes, on the line (499b97c8, 9 Oct). #1230 itself is a duplicate and will not be built.
   2. **Tested:** one unit test file (`AssumedRoughnessWarningTests.cs`), run by its author. #1230's author reports red first, then 2,832 green on net10. Not re-run.
   3. **Installed:** I did not read the installed DLL. The guard is on the C-78 source line.
   4. **Tim-accepted:** no. BUG-514 is OPEN in the carpark ("found by reading code; not seen in AutoCAD").
   5. **Nobody has done:** the robot check of the guard in AutoCAD. The full-findings file was used in run 34 (20 Oct) to count BUG-815 rows; I did not re-read that run.

---

# CARD 5

## DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter:** (A) one house-rule maximum-speed table for the auto-design connection pipe and the Edit Pipe grade strip (#1960, BUG-80). (B) CDDESIGN, auto-design and network redesign hold a pipe of 450 mm and larger to the Settings minimum fall (#1868, BUG-1091).
2. **Ribbon or trigger:**
   1. A: auto-design's connection (inlet) pipe step (CDDESIGN) and the Edit Pipe grade strip. Edit Pipe is a pipe-context window; I did not trace its ribbon button.
   2. B: CDDESIGN, network redesign with preserve existing sizes, auto-design, and New Pipe's suggested grade. Registry command CDDESIGN; I did not read its ribbon placement.
3. **Works today (C-78):**
   1. A: a uPVC pipe is held to 3.0 m/s in CDEDIT and Project Review, but to 6.0 m/s in the auto-design connection pipe and the Edit Pipe grade strip. Auto-design can hand back a smaller pipe than Edit Pipe would accept (BUG-080).
   2. B: Settings holds a minimum fall row for 450 mm and larger gravity pipes (`largeGravityMinGradeN`, blank as shipped). Edit Pipe and CDRULES read it. The sizer drops it. With the row set to 200, a DN450 at 30 L/s comes out about 1 in 890 to 1 in 1,509 in redesign, where Edit Pipe says 1 in 200 (carpark BUG-1091).
4. **What the PRs change:**
   1. **#1960 (B-120, C-79b2, on rel-20261110a and later):** the connection pipe and the Edit Pipe grade strip read the same Settings velocity table: uPVC 3.0, concrete 6.0, metal 4.0, unknown 6.0 m/s, source "house rule" (plan rule R-01; Tim's 17 Jul "leave both numbers" is what R-01 resolved). Switch `pipeSpeedChecks.sizingReadsMaterialTable`, ON. OFF = 6.0 everywhere in those two places. **Engineering result changes (register item 223):** a uPVC connection pipe on a high flow can come out ONE SIZE LARGER than before. A pipe over its limit warns, never blocks. Whole-network sizing screens and `pipeSpeedChecks.useMaterialLimit` (OFF) are left alone.
   2. **#1868 (B-019, C-79b1, on rel-20261108a and later):** `SettingsSizingStandards.ForEveryMaterial` also keeps the 450-and-up rows when the large-pipe figure is set. Switch `pipe.largePipeRedesignReadsMinFall`, ON. **With the row blank (as shipped) nothing changes on any screen.** OFF restores the six ordinary sizes exactly. On C-78 it sleeps. It stacks on #1841, already in C-78.
5. **Suggested class: A is Modify (a shipped engineering result changes). B is Keep with Modify later (asleep until you type a figure).** Suggestion only.
6. **Prompts and windows:**
   1. A: the Edit Pipe grade strip flags a uPVC pipe above 3.0 m/s (example in the PR log: a DN150 at about 4 m/s). I did not find the exact warning words in the text I read.
   2. B: with the row blank the existing line "No minimum fall set for this size" stays. With a figure set, the proposed fall is no flatter than it.
7. **Selection:** A: the pipe being edited, or the lead-in for the connection pipe. B: the network being redesigned. No new picks.
8. **Preview:** the redesign and Project Review preview windows already exist. A steeper proposed fall on a big pipe can push upstream pipes deeper and raise more cover warnings on a flat site (Opus AB). That is the figure working, warnings only.
9. **Drawing output:** none from the PRs; both change readings, not drawing writes (Opus AB, PR logs). Applying a proposal uses the existing apply path. No layer is touched and nothing is unlocked.
10. **Cancel, Escape, Undo and Redo:** nothing written by these changes. Existing apply Undo unchanged.
11. **Save and reopen:** the speed table and the large-pipe figure live in Settings, not in the drawing. Opus AB: the switch is read live, but the large-pipe FIGURE comes from the settings file read at launch, so a robot must set both before AutoCAD starts.
12. **Assets, data and Settings:**
   1. A: `designStandards.scourVelocityByMaterial` (the table), `pipeSpeedChecks.sizingReadsMaterialTable`. I found no Settings page box for the table in the XAML on the line: GUESS file only.
   2. B: `designStandards.largeGravityMinGradeN` (blank) and `pipe.largePipeRedesignReadsMinFall`. Also no page box found in the XAML. The size list (450 to 2400) is fixed in code. Opus AB also noted a second copy of the 1 in 100 seed in `PipeSizingModels.cs` (low).
13. **Performance:** not measured. GUESS: none noticeable.
14. **Discovery:** I found no Help entry. The Edit Pipe warning and the redesign result are the only signs.
15. **Example and expected result:**
   1. A: uPVC connection pipe, flow high enough to read about 4 m/s in a DN150 (full bore about 70 L/s by my arithmetic, assuming internal diameter near 150 mm; GUESS on the real bore). Before: sized to 6.0, passes. After: held to 3.0, so it comes out one size larger, or the strip warns. Concrete stays at 6.0.
   2. B: existing DN450 carrying 30 L/s needs only about 0.19 m/s, so the 0.6 m/s minimum decides the grade. Row blank: unchanged (about 1 in 1,509). Row set to 1 in 200: the redesign proposes no flatter than 1 in 200. The 1 in 200 used here is the carpark's example, not a figure you have given.
16. **Older family card:** `docs\CARDS\SH-04_SETTINGS_STANDARDS.md` and `docs\CARDS\CV-02_HYDRAULIC_DESIGN.md` are the nearest. I did not read them for this card. Neither can cover the house-rule speed table (R-01, 31 Oct), the 450-and-up fall row (GB-01, 29 Oct) or the sizer reading it.
17. **Tim's AutoCAD checklist (robot or Codex on a copy, settings set before launch):**
   1. **A:** settings: uPVC speed 3.0, switch ON. Run CDDESIGN on a connection with a uPVC pipe at high flow. Note the diameter. Right: one size larger than a run with `sizingReadsMaterialTable` set to false.
   2. Open Edit Pipe on a uPVC DN150 at about 4 m/s. Right: the strip warns above 3.0. A concrete pipe at 4 m/s does not.
   3. **B (row blank, as shipped):** run a network redesign with preserve existing sizes on a DN450 carrying 30 L/s. Right: same answer as before, "No minimum fall set for this size".
   4. **B (row set to 200 in disposable settings):** same run. Right: grade 1 in 200, not about 1 in 1,500. Edit Pipe on that pipe also says 1 in 200.
   5. Run CDRULES on the same pipe. Right: it names the same minimum.
18. **Questions only Tim can answer:**
   1. **Context:** the CPAA manual gives 8 m/s for precast concrete pipe, the house table 6.0 (QUESTIONS 114, BUILD_REGISTER 223). **What I understand:** the manual states no uPVC figure, so uPVC 3.0 stands; the 6.0 versus 8 is two sources disagreeing (decision 176). I found no answer in the decisions folder. **Recommendation:** keep 6.0 and say on the Settings page "house rule; CPAA manual allows 8". Changing it moves results on every concrete network. **On a job:** a concrete pipe at 7 m/s is flagged under 6.0, passes under 8.
   2. **Context:** #1960 makes a uPVC connection pipe one size larger at high flow. **Recommendation:** accept, it is the R-01 house rule you already approved. But see it once on a real-shaped flow before it installs (the register says this is your call). **On a job:** a 150 connection becomes a 225 where the flow is near the limit.
   3. **Context:** #1868 does nothing until you give a figure for 450 mm and larger gravity pipes (decision 113: the guidebook gives none; "bigger pipes get their own figure", left blank). **Recommendation:** ask the engineers, or give 1 in 200 only if you agree. I have not invented one. Your office table already shows 450 and larger at 1 in 200 (QUESTIONS line 108), and Manningham is 1 in 200. **On a job:** a DN600 trunk would be held to your figure instead of falling at 1 in 1,500.
19. **NOT proven:**
   1. **Built:** yes, by the authors. #1960 net48 compiles, 7 new tests; #1868 31 of 31 focused and full Civil net10 20,840 total with 0 failed (PR log). I did not rebuild.
   2. **Tested:** unit tests only. #1960's agreement test could not compile on the old code, so the fail-first proof is only the switch-OFF case reproducing the old 6.0 versus 3.0 split. #1868's tests: blank row unchanged, row 200 holds a DN450 at 30 L/s, switch OFF gives the old answer.
   3. **Installed:** no. #1960 is in the C-79b2 branch (not installed); #1868 in C-79b1 (not installed). Installed is C-78 per the register.
   4. **Tim-accepted:** no. BUG-80 is OPEN and BUG-1091 is OPEN. BUG-80's speed values themselves are an engineering-judgement item and need your word.
   5. **Nobody has done:** a robot case showing the "one size larger" result (CE 02 needs one), or a look at either change in AutoCAD.
