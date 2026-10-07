# Accuracy read of the three release documents (Thu 8 Oct 2026, Melbourne time)

**Job:** controller 06's adversarial accuracy reader. Every factual claim in `RELEASE_NOTES_2026-10-07.md`, `ROLLBACK_GUIDE_2026-10-07.md` and `PILOT_CHECKLIST_2026-10-07.md` was checked against what is INSTALLED now and fixed in place.

**Truth sources used (read only):**
1. **Installed versions, read from the program files 8 Oct:** Civil 3.0.34+62514a67, Manager 1.1.34+62514a67, Structural 1.0.104+ebc1654d, all three lanes (Legacy, Net8, Modern).
2. **Code:** the C-20 assembly worktree `c20asm` at 62514a67 (Civil, Manager) and commit ebc1654d (Structural), read with `git show` / `git grep` only. No build, no checkout.
3. **Codex AutoCAD reports:** CODEX_VERIFYW10 to W17 in `C:\Lisp Files\_TEST_COPIES_20260923`.
4. **Plan:** release queue items 196 to 211, `BUG_CARPARK.md`, the C-20 and S-21 finalizer reports.
5. **Install scripts and logs:** `install_c32_civil_manager.ps1`, `install_c33_structural.ps1` (and their diffs against c30/c31), `C:\ce_rc_scratch\install_c30.log`, `install_c31s.log`, `install_c32.log`, `install_c33s.log`; a read-only listing of every `_PRE_` backup in `%APPDATA%\Autodesk\ApplicationPlugins` with its program-file version and CE_SHARED hash.

**Not done:** no AutoCAD, no Codex, no build, no test; Tim's settings files not opened. Nothing in these documents is marked accepted: Tim has accepted nothing.

---

## 1. Answer first

1. **Counts (one numbered line = one claim; a line holding two different facts counted twice):**
   - **Release notes:** TRUE 74, WRONG 9, UNPROVEN 39, OUT OF DATE 26.
   - **Rollback guide:** TRUE 42, WRONG 5, UNPROVEN 3, OUT OF DATE 12.
   - **Pilot checklist:** TRUE 56, WRONG 11, UNPROVEN 12, OUT OF DATE 10.
2. **The biggest errors:**
   1. **All three documents described 3.0.33 / 1.1.33 / 1.0.103 as live.** Installed since 8 Oct 00:50 / 00:56 is 3.0.34 / 1.1.34 / 1.0.104. The rollback worked examples would have rolled back from the wrong version.
   2. **The Pit Schedule window was described as refusing "8" beside P8.** Codex W14 FAILED it in AutoCAD: the window took "2" beside P2 and "p1" over P1 with no line (BUG-420, not fixed in 3.0.34). The pilot told colleagues to renumber there. Now: renumber with Edit Pit, never in the window.
   3. **The pilot said Stop overriding puts the cover back.** It does the opposite: the typed cover stays ("The values you typed stay."), Codex saw it on 3.0.34.
   4. **R1 was said to ask "Enter the tag text <R1>:" first.** R1 asks four picks first ("Pick LEFT beam or wall [Object/Point] <Object>:" ...); the tag question is fifth and its default is the last tag used.
   5. **Footing prompts were misquoted:** "Enter width for SF SF1:" is really "Enter width for SF 1 <300>:" (only when the mark has no size yet); CSREOBAR's default is the last size used (N12 on Tim's PC, not N16) and there is a Spacing question the pilot left out.
   6. **"Edit Pit has no clash check" was still listed as a known limit.** Fixed in 3.0.34 (#758) and Codex saw the refusal (W16).
   7. **The rollback guide read as if every PC has `_PRE_` backups.** Only PCs installed the release chat's way do (Tim's PC). The colleague hand install (REL-09) is still proposed, and the CE installer program keeps its rollback copy elsewhere (`<plugin>_<operation>.bundle.rollback`).
3. **The rollback steps themselves are right.** They are exactly the reverse of what the install wrappers do: the wrappers rename the live folder to `<name>_PRE_<short build code of the version being replaced>_<yyyyMMdd-HHmmss>.backup`, copy the new bundle in, check 822 / 78 / 2007 files against a manifest and that Civil and Manager carry the same CE_SHARED, and rename the backup straight back if the copy fails. Every backup name in the guide was read against its program-file version.
4. **Structural order is right in all three:** roof, upper floors, ground floor / slab / raft, footings last.

---

## 2. Release notes: what was WRONG, OUT OF DATE or UNPROVEN, and what I changed

**WRONG (9), all fixed:**
1. **"CEHEALTH prints one line per product."** It lists Civil and Structural only, plus an office IT folder line; Manager's version is on the status bar. Fixed.
2. **CEHEALTH quoted as "[OK] Civil v3.0.32".** The real line is "[OK] CE Civil Suite v3.0.34" (W16 exact). Fixed with the full W16 text.
3. **Pit Schedule window refuses "8" beside P8.** Codex FAIL (W14, BUG-420). Rewritten as "does NOT refuse yet".
4. **"From 3.0.33 [a bare 8] is refused"** (known limits). True for New Pit and (3.0.34) Edit Pit, not the window. Fixed.
5. **R1 prompt order.** Fixed (four picks, then the tag).
6. **ABFLIPAUTO shown as "<Off>".** The default shown is the user's current value (Tim's is On, BUG-413). Fixed.
7. **"CETEXT" called a command.** There is no CETEXT command; it is CE's shared text tool behind the label commands. Fixed.
8. **CSREOBAR questions.** Bar size default is the last size used; a "Spacing (mm) <200>:" question comes after the bar count (W11c). Fixed.
9. **"A second FPFC with PF1 ... Enter makes PF2."** Increment gives the next FREE number (Codex got PF5). Fixed.

**OUT OF DATE (26), all updated:** the version header and "installed" lines; "3.0.33/1.0.103 not yet opened by Codex" (W14, W15 since); New Pit cover blank and number refusal "not verified" (W14 PASS); BUG-408 Stop overriding sentence (seen on 3.0.34, W16); closing two drawings (W14 PASS); Manager "no new behaviour" (1.1.34 renames its report file); BT1 duplicate _Dot line "not verified" (W15, W17 PASS); BTX empty-selection line (1.0.104 says "in that window", W17); BATTER/support "pick again after the command ended" (reworded in 1.0.104); FST Delete + U evidence (W15 added); STRETCH millimetres attributed to 1.0.103 (it is 1.0.104, #759); Civil machine report file name (coded since 3.0.34); steep-pipe ruling "not in these releases" (it is in 3.0.34, values only); "two Civil changes held out" (#722 and #740 are in 3.0.34); BUG-408 in "not done"; Edit Pit clash check (fixed); "Undo takes it back" on Stop overriding (U after closing takes back the whole Pit Schedule visit, W16); FST grip/STRETCH units mix (now only rounding differs); BT1 file path and "✗ ERROR" lines (gone in 1.0.104, W17); Civil report login (coded since 3.0.34, old file kept); "3.0.33 / 1.0.103 built, not installed" in the sources.

**Added:** a new section 2 for Civil 3.0.34, Manager 1.1.34 and Structural 1.0.104 from queue items 209 to 211 and the C-20 / S-21 finalizer reports, including the CDFIXFLATPIPES steep-pipe change the C-20 finalizer said Tim must see (BUG-423), the Edit Pit "press Update" vs Save wording, and the old real-named report files.

**UNPROVEN (39), kept and marked "Not checked in AutoCAD":** the placed-cell and plan-label pit-number routes (2.2 items 1 to 10 of the old numbering), Recall Last (Codex could not see the button on the New Pit window, though the code has one), CDRENUMBER's renumber (blocked: "Apply? <No>" default, now stated), the grade-note and moved-pipe items, CDRECOVERINVERTS, the two-drawing text edit, old metre grades (three Codex attempts gave no grades), CEMANAGERDIAG wording, CESURVEYREVIEW, R1 tag question, AB flip message, BDL, SBEAM/SBEAMEDIT, STRUCLINKTEXT, beam settings fallback, hatch/stirrup/basement questions, FST Cancel DBMOD, FST Re-link sentences, footing unit lines, the charged rising pipe flip message, and the STRETCH line in 1.0.104.

---

## 3. Rollback guide: what was WRONG, OUT OF DATE or UNPROVEN, and what I changed

**WRONG (5), all fixed:**
1. **"Every CE install keeps the version it replaced."** Only installs done the release chat's way (Tim's PC). Added a "Which PC this is for" paragraph and a technical note on the CE installer's own rollback copy.
2. **"PIPE_OBJECT" named as a command.** No such command; replaced with PIT.
3. **"Older pairs exist down to 3.0.16 and 1.1.16."** They go back to 3.0.0 / 1.1.0 (24 Sep); there is no 3.0.19 pair. Fixed.
4. **"Older [Structural] ones exist down to 1.0.87."** They go back to 1.0.74 (23 Sep); those older than 1.0.76 hold only the 2027 lane. Fixed.
5. **"Install-CECvlSuite.ps1 ... is retired."** Nothing records it as retired: the plan (REL-09) still names the three IT Admin install files as the colleague route, and says they delete the old folder with no backup. Reworded to the real reason not to use them for a rollback.

**OUT OF DATE (12), all updated:** "live today 3.0.33 / 1.1.33 / 1.0.103"; the worked examples in Steps 3 to 7 and section 5 (now 3.0.34 to 3.0.33 with `..._PRE_d2575455_20261008-005047.backup`, and 1.0.104 to 1.0.103 with `CE_STRUC_SUITE_PRE_6f2e9763_20261008-005612.backup`); the "last install misbehaves" pairs; the settings copies (now `settings_pre_1033` and `settings_pre_1034`, Tim's PC only); the CE_SHARED hash list (3.0.34 Legacy 9F0A0A79 added); the sources (install_c32 and install_c33s logs added).

**UNPROVEN (3), softened:** "one new and one old gives a missing CE ribbon" (the plan calls it a risk; the C-20 finalizer read that a mixed pair breaks the machine reports, caught, telemetry only), and "CEMANAGER, Module page" as a place to read the version (twice; replaced by the status bar and CEHEALTH, which Codex saw).

---

## 4. Pilot checklist: what was WRONG, OUT OF DATE or UNPROVEN, and what I changed

**WRONG (11), all fixed:**
1. **"A real job is the next step on the ladder."** The ladder puts Tim acceptance before the pilot, and Tim has accepted nothing. Said so.
2. **CEHEALTH lines** were missing the office IT folder line (W16 exact text now).
3. **Pit Schedule window rename "8" refused** (Codex FAIL W14, BUG-420). Replaced by Edit Pit steps and a "do NOT renumber in the window" line.
4. **"ERASE a pit, then OOPS"** heading; the steps are U and REDO. Fixed.
5. **Stop overriding "the cover goes back to the pit's own value".** The typed cover stays. Fixed with the W16 footer sentence and the U-after-closing note.
6. **CDDISCIPLINE "asks ... <Civil>:".** It first prints the current discipline and the default is the current one (Structural in a structural copy). Told the pilot to press Esc to read it without changing anything.
7. **R1 order.** Fixed as in the release notes.
8. **CSREOBAR "<N16>" and no Spacing question.** Fixed.
9. **FSF "Enter width for SF SF1:".** Really "Enter width for SF 1 <300>:", only when the mark has no size yet. Fixed.
10. **FPFC "Enter X size for PF PF1:".** Really "Enter X size for PF 1" with a default, same condition. Fixed.
11. **"Typing by itself ... happened twice in Codex runs."** Five episodes, traced to Codex's own screen tool, not CE (BUG-421). Fixed.

**OUT OF DATE (10), all updated:** versions to check; status bar text; cover-box-after-restart and New Pit number refusal now proven (W14); the Edit Pit "do not rename" warning (now refused, W16); BUG-408 "known gap" (fixed); BT1 "Duplicate definition" not yet seen (W15, W17 PASS) and the new "loaded" line; BTX no-text line; FEDIT REDO "not proven" (W15, W17 PASS); CSFDNPROPOSE "not proven" (W15, W17 PASS).

**UNPROVEN (12), kept and marked "not proven yet":** Recall Last; Edit Pit free-number rename with pipes; placed-cell rename (also flagged against the known limit that double-click typing in a cell may not reach CE); plan-label rename; "nothing changes" after CDRULES; BDL; SBEAM/SBEAMEDIT; STRUCLINKTEXT; hatch tools; basement wall; FST re-link; centimetre/inch resize lines.

**Added:** STS1 (W17 PASS) under upper floors, BATTER under ground floor, the STRETCH line under footings, the Edit Pit refusal under pit renaming. Section 3D numbering fixed (1, 2, 3).

---

## 5. Things I could not settle (left for the release chat, not Tim)

1. **Recall Last on New Pit.** The window's code has the button in its footer; Codex could not see it (W14). A Codex look at the whole New Pit window settles it.
2. **Sibling documents.** `STAFF_HELP_2026-10-08.md` and `KNOWN_LIMITATIONS_2026-10-08.md` (commit 73b093c) were outside this job. A text search found none of the wrong phrases above in them; they were not read line by line.
3. **The colleague rollback.** A rollback page for a colleague PC can only be written once the colleague install method is settled (question 4 below).

---

## 6. Questions only Tim can answer

1. **CDFIXFLATPIPES now offers steep pipes (3.0.34).** A flattened pipe held at 1 in 5 used to say "Check by hand"; now it is offered with a "steep ... check it" line and Yes writes the levels. Is that how you want your steep-pipe ruling ("no fixed limit, warn above 1 in 10, never a block") to apply here? **Recommend: yes**, it warns and never blocks, as you ruled.
2. **Old report files with your login.** Civil keeps its old machine report named with your Windows login and computer name; Structural deletes its own. Delete the old file at start-up in Civil and Manager too? **Recommend: yes**, it holds nothing the new coded file lacks.
3. **Pilot before your own acceptance?** The plan's ladder puts your acceptance before the colleague pilot, and nothing is accepted yet. **Recommend:** you run the Day 1 checklist yourself on one real job copy first, then hand it to a colleague.
4. **Which colleague, which AutoCAD year, and how installed?** You ruled "By hand, AutoCAD closed" (23 Sep). The hand steps (rename to `_PRE_V3.backup`, copy in) are still marked proposed. **Recommend:** a 2027 colleague first, installed by those steps, so the rollback guide's renames work on their PC too.
5. **Pilot with the Pit Schedule window fault open (BUG-420)?** The checklist now says never renumber in the window and use Edit Pit. **Recommend:** go ahead with that instruction rather than wait for the fix.
6. **F2 runs CLEAN (BUG-411).** Keep F2 on CLEAN, or move CLEAN off F2 so F2 opens the text window again? **Recommend:** move it off F2; colleagues will press F2 by habit.

---

## Tim's answers (INT-069), 8 Oct

Tim, verbatim, in the decisions file (`decisions/2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`): INT-068 "4. as recommended" and INT-069 "... 6. as recommended ... 7. as recommended ... 9. leave as is for now, commonly used by me to save ... 15. as recommended 16. as recommended 17. as recommended". The chat list numbers differ from the six questions above, so each is mapped here. These are rulings, not fixes: the four release documents now say "Tim has ruled; not built yet" where that is true. Nothing is accepted.

1. **Question 1, steep pipes in CDFIXFLATPIPES: YES, as recommended** (INT-068 item 4). A pipe held at 1 in 5 keeps the "steep, check it" line; warn above 1 in 10, never block. The wording is in 3.0.34; Codex has not seen it.
2. **Question 2, old real-named report files: YES, delete them** (INT-069 item 7), in Civil and Manager at start-up as Structural already does. Tim's ruling goes further: scramble the names inside the Manager report and keep PC names out of support-bundle file names. Not built.
3. **Question 3, pilot before your own acceptance: Tim runs the Day 1 checklist himself on one real job copy first** (INT-069 item 15). Done in the checklist.
4. **Question 4, which colleague, AutoCAD year, how installed: a colleague on AutoCAD 2027, installed by hand** (old folder renamed to `_PRE_V3.backup`, new copied in) (INT-069 item 16). **Still open: the colleague's name and the results channel were not supplied.** Left as marked blanks in the checklist.
5. **Question 5, pilot with the Pit Schedule window fault open: GO, with the Edit Pit-only ground rule** (INT-069 item 6). Tim's ruling adds that the window fix is installed in 3.0.35; nobody has seen it in AutoCAD and BUG-426 is open, so the rule stays in the documents.
6. **Question 6, F2 runs CLEAN: NOT TAKEN.** The recommendation was to move CLEAN off F2. Tim chose the other way: "leave as is for now, commonly used by me to save" (INT-069 item 9). BUG-411 stays open; the desk will check what F2 does for Tim. The documents say F2 runs CLEAN in a CE drawing and not to press it expecting a save, and claim nothing more.
