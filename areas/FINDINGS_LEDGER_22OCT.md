# Findings ledger: every audit, hunt, sweep and review finding, deduplicated, checked and triaged (complete, 23 Oct 2026)

Compiled Fri 23 Oct 2026 (Melbourne) by Opus 5.5 for desk plan/03. This replaces the first version (Sonnet, 00:18 the same morning, 151 findings from 14 sources). Read only: no plugin source changed, nothing built or run, no AutoCAD, no Codex. BUG_CARPARK.md was not edited: the new entries are in `areas/CARPARK_NEW_ENTRIES_23OCT.md` for the desk to append. Nothing here is built, tested, installed or Tim-accepted unless an entry says so.

**Installed builds (the code every check read):** Civil 3.0.70 / Manager 1.1.70 = `origin/claude/rel-20261022m` @ `40ee0a36`; Structural 1.0.121 = `origin/claude/rel-20261022s2` @ `2c9a9694` (both resolved again today).

---

## ANSWER FIRST (for Tim)

1. **246 distinct findings, 1 of them false.** HIGH 41, MEDIUM 138, LOW 66 (the false one is not counted). 151 came from the first ledger; 95 are new from the 16 code sweeps, the five late hunts and the second Manager review.
2. **By area:** Civil engineering numbers 41; Civil commands, Undo and Checks 30; Civil records, schedules and sheets 21; Civil imports 11; Civil labels and Tidy labels 13; Wording and windows 49; Release, installer and Manager 28; Privacy and security 5; Structural 47.
3. **By source:** first ledger (14 audits and hunts) 151; Codex sweeps S01 to S16 60; Codex late hunts (records, design, privacy, compat, Structural commands) 24; Opus Manager second review 11. Two sweep findings were the same as first-ledger ones and were merged (S08-01 into F-006, S14-03 into F-126), and review item B3 was merged into sweep S16-01 (F-219).
4. **NEW and real, HIGH or MEDIUM: 157** (HIGH 28, MEDIUM 129). Each has a ready carpark entry, **BUG-873 to BUG-1029**. 89 of them were re-checked against the installed code today; the rest stand on the source's own reading (Opus engineering and wording audits, Codex hunts). 30 already have a fix drafted in an open PR but no carpark entry yet (mostly the wording PR #1534, on HOLD).
5. **Already covered by an existing BUG or carpark entry: 17** (BUG-725, BUG-788, BUG-852, BUG-861 to BUG-872 and the two XCLMTXT entries). One of those needs a status change: **BUG-788 must be reopened** (F-154: its installed fix missed the Xref reader).
6. **False: 1.** S09-02 ("Edit Pit moves a pit twice in a moved UCS") is wrong: CE switches to World UCS for every CE command, Edit Pit included. **Unproven or gates, no carpark entry: 5** (two suspected findings, three release gates). **LOW, no carpark entry: 66.**
7. **The checks changed 44 ratings, all downwards** (25 HIGH became MEDIUM or LOW, 19 MEDIUM became LOW) where the harm is smaller than first stated, for example a metre-drawing-only fault, a switch that is OFF by default, or a few milliseconds. Both ratings are shown on every entry.

### The 12 findings most likely to hurt a colleague on 9 Nov (Civil + Manager, hand install)

1. **F-156 (BUG-966).** **CDSPOON never works.** Every spoon drain is rolled back with "failed exact readback. No spoon output was committed." CE checks for the old colours after Batch 5 made the spoon ByLayer.
2. **F-006.** **CDRULES and CDCHECKS judge grade on the straight pit-to-pit distance** (BUG-867): a bent pipe at 1 in 240 passes as 1 in 170. Fix in #1530, not installed.
3. **F-157 (BUG-967).** **A Blue Factor report's garden and lawn go in as roof and paving.** A 1,000 m2 site with 500 m2 of roof and drive enters CDDESIGN as 1,000 m2 of hard surface.
4. **F-153 (BUG-964).** **Network redesign sets each pit to the far end of its outgoing pipe,** so the incoming pipe drops 170 mm into the pit and the outlet starts higher; the preview calls it a good design.
5. **F-007.** **The network solver treats every pipe as UPVC** (BUG-868): a concrete 375 is sized for 200 L/s and carries 154. #1537 is on HOLD.
6. **F-009 (BUG-876).** **An X-Civil or LandXML Replace can make a pit vanish:** the old pit is erased, then the new one cannot be drawn on a locked cover-text layer.
7. **F-010 (BUG-877).** **On the import review page, choosing a different file and clicking Read source draws the OLD file.**
8. **F-004 (BUG-874).** **Esc after a CD pipe with a callout leaves the callout unlinked:** erase the pipe and the leader stays behind.
9. **F-155 (BUG-965).** **Refreshing a placed Pit Schedule turns "2/375" into "375" and a 3000 trench grate into "300 x 300",** while the Pit Schedule window still shows the right values.
10. **F-152 (BUG-963).** **CDPROPAGATE writes the upstream level into the only IL text left** when the upstream IL is hidden: the text beside the downstream pit reads 9.60 where the schedule says 9.50.
11. **F-046.** **The Pit Schedule measures depth to the outlet pipe, not the pit floor** (BUG-869): 0.85 m and no step irons where the pit is 0.95 m and needs them. Fix in #1531.
12. **F-160 (BUG-970).** **CDTWL joins two separate detention systems that both use P1-P2** and can say "That is enough" when neither system is.

Also close behind: F-161 (an unreadable CE record is rebuilt and saved over, so manual schedule rows are lost; rare), F-122 (CEHEALTH says Civil is OK when it is not loaded), F-124 (the Updates & Rollback button tells Max he is not an administrator), F-219 (a Manager button can type CDREPAIR into a running TEXT command) and F-008 (the rainfall note says "high"; it reads 6 to 8 per cent low; Tim's word).

### What the desk does next

1. **Append** `areas/CARPARK_NEW_ENTRIES_23OCT.md` to BUG_CARPARK.md (BUG-873 to BUG-1029) and set the "Next BUG ID" line to BUG-1030. The same file lists the status notes for existing entries (BUG-788 reopen, BUG-725, BUG-802, BUG-834, BUG-008).
2. **Build the top 25 below** in the next cycle (Sonnet for protected files, Codex for the rest), after the C-61 merge order in the two PR reviews.
3. **Fix #1534's garbled characters** before anything else in the wording lane: it carries the four HIGH wording findings.
4. **Tim's questions** (batched below) go in the Monday 08:40 batch; builders use the recommended answers as DRAFT meanwhile.

---

## Top 25 NEW fixes for the 9 Nov Civil + Manager pilot

Ranked by harm on a colleague's PC with default switches. Only findings with no fix in flight. Protected files (common.txt) mean a Sonnet builder; Codex takes the rest. Base: `claude/rel-20261022m` (Civil 3.0.70 / Manager 1.1.70) unless stated; where a related PR exists, stack on it so the two do not clash.

1. **F-156 (BUG-966), HIGH, CDSPOON rejects its own ByLayer output and rolls the whole spoon back.** `Services/SlabService.cs:2264, 2418, 2421` (check ByLayer, not entity colour). **Lane:** Codex. **Base:** rel-20261022m.
2. **F-157 (BUG-967), HIGH, Blue Factor garden and lawn areas counted as roof and paved.** `Rules/BlueFactorReport.cs:39, 100-115` (garden and lawn to pervious; 'Other' as Tim's default answer, DRAFT). **Lane:** Codex. **Base:** rel-20261022m.
3. **F-153 (BUG-964), HIGH, Network redesign stores each pit's level as the FAR end of its outgoing pipe.** `Services/NetworkDesignService.cs:329-356` and `NetworkRedesignSolverService.OutputValidation.cs:188-194`; same file as #1537. **Lane:** Codex. **Base:** stack on #1537 (`cx/eng-pipe-material-c60`).
4. **F-160 (BUG-970), HIGH, CDTWL merges two systems that reuse pit numbers.** `Services/DetentionTwlService.cs:112-118`, `Rules/DetentionBranchCollector.cs:85-170` (carry identities, ask which set). **Lane:** Codex. **Base:** stack on #1538 (`cx/eng-twl-units-c60`).
5. **F-009 (BUG-876), HIGH, Replace deletes the old imported pit before checking whether the new one can be drawn (new cover text needs a locked layer).** `Services/XcivilImportService.cs:1921, 1950, 975, 986` (check the new pit's layers before erasing the old). **Lane:** Codex. **Base:** rel-20261022m.
6. **F-010 (BUG-877), HIGH, Choosing another file on the import review page then clicking Read source imports the previously read file.** `Commands/LinkCommands.ImportXcivil.cs`, `Dialogs/CivilImportWindow.xaml.cs:73-77`, `ViewModels/CivilImportWindowViewModel.cs:60-75`. **Lane:** Codex. **Base:** rel-20261022m.
7. **F-004 (BUG-874), HIGH, Esc after an accepted CD placement throws away the deferred callout registration, so the pipe and its callout are not linked.** write deferred callout registrations on the CD cancel path (`LinkService.Reactors.cs:1420, 1557`). **Lane:** Sonnet (LinkService.Reactors/Registration protected). **Base:** rel-20261022m.
8. **F-152 (BUG-963), HIGH, CDPROPAGATE writes the upstream level into the only remaining (downstream) IL text.** `LinkService.RepairAudit.InvertPropagation.cs:974-995`; do F-173 in the same pass. **Lane:** Sonnet (LinkService.RepairAudit protected). **Base:** rel-20261022m.
9. **F-155 (BUG-965), HIGH, Linked-cell Refresh drops "2/" twin prefix and trench grate length.** `Services/ScheduleLinkService.cs:2001-2026, 2619-2638` (reuse PitScheduleBuilder's formatters). **Lane:** Codex. **Base:** rel-20261022m.
10. **F-161 (BUG-971), HIGH, An unreadable drawing record is replaced by a rebuilt one.** `Services/ProjectDataService.Persistence.cs:197-287, 823-905, 1293-1310`; do F-179 in the same pass. **Lane:** Sonnet with Opus review (save path). **Base:** rel-20261022m.
11. **F-011 (BUG-878), HIGH, The single-level shortcut gives a pipe an invert the file explicitly names for another pipe.** `Services/XcivilPipeInsertionService.cs:428-482` (named inverts outrank the single-level shortcut). **Lane:** Codex. **Base:** rel-20261022m.
12. **F-158 (BUG-968), HIGH, CDRENUMBER crashes AutoCAD on a looped pipe record.** `Rules/PitRenumberPlanner.cs:91-143` (on-path loop guard); do F-202 in the same pass. **Lane:** Codex. **Base:** rel-20261022m.
13. **F-019 (BUG-885), MEDIUM, Installer packaging rebuilds the files instead of sealing the accepted candidate (the "payload 85" failure).** the hand-install route copies only the frozen, signed, Codex-tested candidate; edit the existing `Installer/build_installer.ps1`, no new script. **Lane:** Sonnet with Opus review. **Base:** rel-20261022m.
14. **F-122 (BUG-946), MEDIUM, CEHEALTH prints "[OK] CE Civil Suite v3.0.70" (and can end "All checks passed") when Civil is installed but not loaded.** `Modules/Manager/Commands/PluginManagerCommands.cs:187-245` (a NotLoaded warning). **Lane:** Codex. **Base:** rel-20261022m.
15. **F-124 (BUG-948), MEDIUM, The CE Tools "Updates & Rollback" ribbon button sends an ordinary colleague to an administrator-only route and opens no window.** `Modules/Manager/Services/CeToolsRibbonDefinitionService.cs:26-29` (open the Manager Updates page for a colleague). **Lane:** Codex. **Base:** rel-20261022m.
16. **F-219 (BUG-1017), MEDIUM, Manager buttons type their command name into a command that is already running.** `PluginManagerWindow.xaml.cs:894-901` and `CeBlocksPaletteService.cs:46` via `RibbonBuilder.BuildSendString`. **Lane:** Codex for the Manager window; Sonnet for the CE Blocks palette (protected). **Base:** rel-20261022m.
17. **F-032 (BUG-892), MEDIUM, Clicking an Inspector problem count (Flat / backfall pipes, shallow pits and the rest) takes a write lock and a transaction even when the list is empty.** `Services/InspectorPaletteService.cs:2752-2800` (return before the lock on an empty list). **Lane:** Codex. **Base:** rel-20261022m.
18. **F-141 (BUG-957), MEDIUM, Pressing Enter in the Settings search with no matches saves the whole draft and closes Settings.** `Dialogs/AdvancedSettingsDialog.xaml.cs:57-72` (Enter in search never presses Save). **Lane:** Codex. **Base:** rel-20261022m.
19. **F-178 (BUG-987), MEDIUM, CDSYNC can give a plain pit a nearby pit's lid, remarks and schedule tick.** `Services/ProjectDataRecoveryGuardService.cs:105-232` (identity first, position last); do F-228 in the same pass. **Lane:** Codex. **Base:** rel-20261022m.
20. **F-209 (BUG-1011), MEDIUM, A typed Depth never reaches its edit helper and is lost by Stop overriding.** `ViewModels/PitScheduleViewModel.Data.cs:1157-1290, 1814-1850`. **Lane:** Codex. **Base:** rel-20261022m.
21. **F-196 (BUG-999), MEDIUM, CDRUNSOLVE feeds zero flow to the sizer and then says every invert already matches.** `Services/ProposalApplyService.PlanBuilders.cs:555`, `Commands/RunSolveCommand.cs:140-178` (say honestly it could not solve); do F-195 in the same pass. **Lane:** Codex. **Base:** stack on #1537.
22. **F-159 (BUG-969), HIGH, CDNEWDWG keeps the first job's record when the job folder is changed.** `Dialogs/NewJobDrawingDialog.xaml.cs:61-202` (re-read the job record when the folder changes). **Lane:** Codex. **Base:** rel-20261022m.
23. **F-123 (BUG-947), MEDIUM, A damaged prepared update cannot be repaired by clicking Get update ready again: the old folder blocks the fresh copy every time.** `Modules/Manager/Services/CeUpdateStagingService.cs:370-432` (set a damaged stage aside). **Lane:** Codex with Opus review. **Base:** rel-20261022m.
24. **F-201 (BUG-1004), MEDIUM, Design says "Nothing has changed since the design was agreed" after the orifice head or the detention answer was changed and saved.** `Rules/AgreedDesignRules.cs:219-233`, `Models/AgreedDesignSnapshot.cs` (orifice head and detention answer). **Lane:** Codex. **Base:** rel-20261022m.
25. **F-224 (BUG-1019), MEDIUM, CDCALC treats levels at or below RL 0.00 as "not set".** `ViewModels/DetentionSystemViewModel.cs:708-845, 1278-1296` (levels at or below RL 0); do F-226 in the same pass. **Lane:** Codex. **Base:** stack on #1538.

**Next in line:** F-200 (CEFIND P1A), F-189 (FALL arrow rotation), F-240 (older-AutoCAD menu, if Max is on 2024), F-039 to F-041 (import results, Replace position, multi-page PDF), F-197 to F-199 (X-Civil spot levels, labels, fall arrows), F-169 (CDJOINT), F-170 (Pipe Flows), F-206 (REMARKS cell), F-236 to F-238 (already in #1535).

---

## Needs Tim's word (one batch for Monday 08:40; builders use the recommended answer as DRAFT)

1. **Carried from the first ledger:** rainfall note (F-008, BUG-866); cover to the outside of the pipe, cover between pits, obvert matching, council numbers in code (F-042, F-043, F-052, F-053); the grade ladder (F-045, F-074); one hard-ground C and pipe length wall to wall (F-047 suspected, F-050, F-067); Structural drawing behaviour (F-055, F-056, F-081, F-127, F-128, F-130, F-132, F-134, F-136, F-137); label and Settings names (F-063, F-064, F-103, F-104); install route and gates (F-016, F-017, F-023, F-025, F-026); window-first CD extra U (F-033, now LOW); unitless drawings (F-076); self-cleansing speed (F-077).
2. **Metre drawings (F-183, F-184, open BUG-287 / BUG-338):** every Civil pipe-width writer assumes 1 unit = 1 mm. Does the office ever draw true metre drawings? Recommend: say no, and warn on a metre drawing rather than convert.
3. **Speed-warning advice (F-203):** CDRULES says "reduce the pipe size" when a pipe is too slow, which makes it slower. Recommend: "Steepen the grade" / "Flatten the grade or add a drop pit" only.
4. **Spine rollback (F-180):** keep the permanent identities and roll back the rest (recommend), or refuse.
5. **Pit Schedule order (F-229):** drop the BUG-008 90 per cent rule so adding one pit keeps your order (recommend yes, then re-test BUG-008).
6. **Job timer (F-208):** should the first 5 idle minutes count? Recommend no; the double count on 'count that time' is a plain fault either way.
7. **Long-section pit depth (F-225):** recorded floor or lowest connected pipe, whichever is lower (recommend), with a warning when they disagree.
8. **Older-AutoCAD menu (F-240):** one menu entry per CE tool on AutoCAD 2022 to 2024 (recommend yes).
9. **Smaller:** schedule-only lid and remarks overrides (F-210), a typed 0.000 trench-grate cover (F-212), non-associative hatches in CEHATCHCHANGE (F-232), office hatches on CE layers in Hatch Audit Repair (F-233), where diagnostics reports live (F-246).

---

## How to read an entry

1. **Severity:** the higher of the sources, then the 23 Oct check. Where the check found the harm smaller (or larger), both are shown: "HIGH (source HIGH; check MEDIUM)" and the checked figure is used in the counts.
2. **Check:** "Opus" or "Sonnet" = re-read today at the installed commit by a checker (batches V1 to V8; notes kept in the desk scratchpad, not in the repo). "Source-verified" = the source's own reading only, not re-checked today.
3. **Status:** NEW with its BUG number in the new carpark file; FILED (an existing carpark entry covers it); LOW (no carpark entry); GATE (release evidence, goes to the gap plan); UNPROVEN; FALSE.
4. **Protected:** a file Codex may not edit (C:\Lisp Files\_CODEX_RUNNER\common.txt): the builder must be Sonnet/Claude. Everything under Modules/Structural needs a Structural brief.
5. **Test:** one deterministic line. The source report has the full fixture.

---

## Register map of the first ledger (F-001 to F-151)

1. **NEW, with a carpark entry (90):** F-003 (BUG-873), F-004 (BUG-874), F-005 (BUG-875), F-009 (BUG-876), F-010 (BUG-877), F-011 (BUG-878), F-012 (BUG-879), F-014 (BUG-880), F-015 (BUG-881), F-016 (BUG-882), F-017 (BUG-883), F-018 (BUG-884), F-019 (BUG-885), F-020 (BUG-886), F-021 (BUG-887), F-024 (BUG-888), F-029 (BUG-889), F-030 (BUG-890), F-031 (BUG-891), F-032 (BUG-892), F-034 (BUG-893), F-035 (BUG-894), F-036 (BUG-895), F-037 (BUG-896), F-038 (BUG-897), F-039 (BUG-898), F-040 (BUG-899), F-041 (BUG-900), F-042 (BUG-901), F-043 (BUG-902), F-045 (BUG-903), F-049 (BUG-904), F-050 (BUG-905), F-051 (BUG-906), F-052 (BUG-907), F-053 (BUG-908), F-055 (BUG-909), F-056 (BUG-910), F-057 (BUG-911), F-058 (BUG-912), F-065 (BUG-913), F-083 (BUG-914), F-084 (BUG-915), F-085 (BUG-916), F-086 (BUG-917), F-087 (BUG-918), F-088 (BUG-919), F-089 (BUG-920), F-090 (BUG-921), F-091 (BUG-922), F-092 (BUG-923), F-093 (BUG-924), F-094 (BUG-925), F-095 (BUG-926), F-096 (BUG-927), F-097 (BUG-928), F-098 (BUG-929), F-099 (BUG-930), F-100 (BUG-931), F-101 (BUG-932), F-102 (BUG-933), F-103 (BUG-934), F-104 (BUG-935), F-105 (BUG-936), F-106 (BUG-937), F-107 (BUG-938), F-108 (BUG-939), F-109 (BUG-940), F-110 (BUG-941), F-111 (BUG-942), F-112 (BUG-943), F-113 (BUG-944), F-114 (BUG-945), F-122 (BUG-946), F-123 (BUG-947), F-124 (BUG-948), F-127 (BUG-949), F-128 (BUG-950), F-129 (BUG-951), F-130 (BUG-952), F-131 (BUG-953), F-132 (BUG-954), F-139 (BUG-955), F-140 (BUG-956), F-141 (BUG-957), F-142 (BUG-958), F-143 (BUG-959), F-144 (BUG-960), F-145 (BUG-961), F-149 (BUG-962).
2. **FILED already:** F-001 BUG-862; F-002 BUG-863; F-006 BUG-867; F-007 BUG-868; F-008 BUG-866 (Tim's word, question 1 for Monday); F-013 BUG-864; F-022 BUG-852; F-027 BUG-861; F-028 BUG-865; F-044 BUG-870; F-046 BUG-869; F-048 BUG-871; F-054 BUG-872; F-125 Carpark entry AUDIT-XCLMTXT-ANGLES; F-126 Carpark entry AUDIT-XCLMTXT-DECIMALS.
3. **LOW, no carpark entry:** F-033, F-060, F-061, F-062, F-063, F-064, F-066, F-067, F-068, F-069, F-070, F-071, F-072, F-073, F-074, F-075, F-076, F-077, F-078, F-079, F-080, F-081, F-082, F-115, F-116, F-117, F-118, F-119, F-120, F-121, F-133, F-134, F-135, F-136, F-137, F-138, F-146, F-147, F-148, F-150, F-151.
4. **Release gates, no carpark entry:** F-023, F-025, F-026. **Unproven (suspected):** F-047, F-059.
5. **The first ledger's draft numbers BUG-873 to BUG-972 are void.** They were never appended (the carpark still says next is BUG-873). Use only the numbers in this file.
6. **The "BUG-866 used twice" note in the first ledger is resolved:** the CDCHECKIGNORE Undo entry is now `BUG-CDCHECKIGNORE-UNDO-C60`; BUG-866 is the rainfall note. #1524's code comments still say BUG-866 (rename at next touch).

---

## Part A: findings that arrived after the first ledger (F-152 to F-246)

Sources: CODEX_SWEEP_S01 to S16 (23 Oct), CODEX_HUNT_RECORDS / DESIGN / PRIVACY / COMPAT / STRUCTCMDS (22 Oct brief), REVIEW_CEMEMBER_AND_MANAGER Part B (Opus, 23 Oct). The settings hunt never landed (11 of the 12 hunt files exist). REVIEW_CEMEMBER Part A (CEMEMBER against Tim's design) has no defects in the drawing rules; its gaps are the missing window and the uncorrected section list (BUG-818), already recorded.

152. **F-152. CDPROPAGATE writes the upstream level into the only remaining (downstream) IL text**
   - **Severity:** HIGH. **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S03 S03-01. **Installed:** Civil 3.0.70.
   - **For Tim:** Hide the upstream IL on a pipe, then CDPROPAGATE 9.50 at the downstream pit. The IL text beside the downstream pit reads "IL 9.60" (the upstream level) while the schedule says 9.50, and the command still says "Updated 1 pipes".
   - **Where:** Modules/Drainage/Services/LinkService.RepairAudit.InvertPropagation.cs:974-995 (called from :799). **Command:** CDPROPAGATE (LinkCommands.cs:475); no switch
   - **Check (Opus, 23 Oct):** VERIFIED. Edit Pipe "Hidden" stops the first IL text being drawn at all (PipeEditCommand.Update.cs:760 `if (vm.FirstInvertHidden) skipFirstInvertText = true;`). The cascade then finds one IL text and always gives the first one found the first-end value.
   - **Existing BUG / PR:** none (grep for UpdateIlAnnotationsForPipe, and for hidden/one-IL with propagate/cascade, in carpark, FB list and ledger: no match). **Status:** NEW, **BUG-963**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet (protected file); base claude/rel-20261022m. **Test:** P1->P2 10 m, IL 10.00/9.90, first IL Hidden; CDPROPAGATE P2 9.50; expect the single text beside P2 = "IL 9.50" (today "IL 9.60").

153. **F-153. Network redesign stores each pit's level as the FAR end of its outgoing pipe**
   - **Severity:** HIGH. **Area:** Civil engineering numbers. **Source:** CODEX_SWEEP_S04 S04-01. **Installed:** Civil 3.0.70.
   - **For Tim:** A-B-C at 1 in 100, outlet C 10.000. The redesign preview gives B to C leaving B at 10.200 but A to B arriving at B at 10.030, so the pipe drops 170 mm into the pit and the outgoing pipe starts higher. Pit B is set to 10.000. The preview offers this as a good design.
   - **Where:** Modules/Drainage/Services/NetworkDesignService.cs:329-356; OutputValidation.cs:188-194. **Command:** CDHUB > Network redesign (preview and Apply). The same Design service feeds CDRUNSOLVE and auto-design (RunSolveCommand.cs:143, AutoDesignOrchestrator.cs:212), so those are likely affected too (not traced further)
   - **Check (Opus, 23 Oct):** VERIFIED. The design walk sets the pit level to the outgoing pipe's downstream end (at the next pit down), not its upstream end at this pit. So every incoming pipe arrives below the outgoing pipe. The output check compares the same wrong pair, so it agrees with itself.
   - **Existing BUG / PR:** none. BUG-868 (F-007) is the same file but a different defect (every pipe treated as UPVC). **Status:** NEW, **BUG-964**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** NetworkDesignService.Design, chain A->B->C, 20 m each, 1:100, outfall C 10.000, drop 0.030; expect B->C upstream 10.200, A->B downstream 10.230, pit B 10.200

154. **F-154. Xref cache by drawing ID hides a SAVEAS copy's different pit data (BUG-788 fix bypassed)**
   - **Severity:** HIGH. **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S05 S05-01. **Installed:** Civil 3.0.70.
   - **For Tim:** Xref Stage 1 and Stage 2 (a SAVEAS copy) into a sheet and open PITSCHEDULE: you still get one source with Stage 1's pits. Stage 2's extra pits and changed levels are missing, and the "same internal drawing ID" warning never shows.
   - **Where:** Modules/Drainage/Services/PitScheduleXrefDiscoveryService.cs:394-413; core PitScheduleXrefDiscoveryCore.cs:63. **Command:** PITSCHEDULE > Source > Drainage XREFs (switch PitScheduleXrefSeparatesSaveAsCopies, default ON)
   - **Check (Opus, 23 Oct):** VERIFIED. ReadProjectRecord gives back the first Xref's record for any later Xref with the same FingerprintGuid, before it reads the second drawing. So the core's "same ID, different data" check (PR #1404) always sees the same data and never fires.
   - **Existing BUG / PR:** BUG-788 (its own report already cites PitScheduleXrefDiscoveryService.cs:394-398; the installed fix PR #1404 changed only the core). Reopen BUG-788 rather than file a new bug. **Status:** FILED as BUG-788. **Note:** Reopen BUG-788: its installed fix (#1404) changed only the core; the Xref reader still returns the first drawing's record for a SAVEAS copy. **Fix kind:** code. **Protected:** no. **Lane:** none (no entry). **Test:** run the discovery ADAPTER (not the core alone) on two loaded DBs with equal FingerprintGuid and different CE JSON; expect 2 entries, one not offered with "same internal drawing ID ... different pit data"

155. **F-155. Linked-cell Refresh drops "2/" twin prefix and trench grate length**
   - **Severity:** HIGH. **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S05 S05-02. **Installed:** Civil 3.0.70.
   - **For Tim:** A placed schedule that correctly shows "2/375" for twin tanks and "3000" for a trench grate changes to "375" and "300 x 300" when you press Refresh (or after any edit that refreshes linked cells), while the Pit Schedule window still shows the right values.
   - **Where:** Modules/Drainage/Services/ScheduleLinkService.cs:2001, :2020, :2026, :2619-2638. **Command:** PITSCHEDULE Refresh; also every automatic RefreshLinkedCells (for example after a Pit Schedule diameter sync); no switch
   - **Check (Opus, 23 Oct):** VERIFIED. Refresh uses its own formatters: FormatDiameter ignores DetentionTwinPipes, and BuildPitSizeText has no trench grate branch. The window rows use PitScheduleBuilder (GetPipeScheduleDiameterDisplay, BuildPitSize) and get them right. Also seen: a pump pit refreshes to "0 x 0" where the builder gives blank.
   - **Existing BUG / PR:** none (grep for twin/2/375 with refresh, TgLength with linked: only this report). **Status:** NEW, **BUG-965**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** linked schedule with twin 375 pipe and TG pit (TgLengthMm 3000, 300x300); RefreshLinkedCells; expect MText "2/375" and "3000" unchanged

156. **F-156. CDSPOON rejects its own ByLayer output and rolls the whole spoon back**
   - **Severity:** HIGH. **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S06 S06-01. **Installed:** Civil 3.0.70.
   - **For Tim:** Trace a spoon drain with CDSPOON and Close: nothing is left on the drawing and the command line says the spoon boundary or hatch "failed exact readback. No spoon output was committed." It fails every time, standalone or inside a slab.
   - **Where:** Modules/Drainage/Services/SlabService.cs:2264, :2279, :2308, :2418, :2421. **Command:** CDSPOON (SpoonCommand.cs:24, :150); no switch
   - **Check (Opus, 23 Oct):** VERIFIED. Batch 5 card 5.3 (commit 8f743e93) made the boundary and hatch ByLayer (256), but the readback check written earlier (dd7db7c8) still wants entity colour 2 and 35. So every placement throws inside verify and is aborted.
   - **Existing BUG / PR:** none (grep for "failed exact readback" and CDSPOON rollback: none). **Status:** NEW, **BUG-966**. **Fix kind:** code (check the layer colour, or that the entity is ByLayer, instead of the entity index). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** fresh mm drawing, CDSPOON standalone 10000,10000 / 12000,10000 / 12000,11000 / 10000,11000 / Close; expect "CDSPOON complete." and one closed boundary + one SOLID hatch, both ByLayer

157. **F-157. Blue Factor garden and lawn areas counted as roof and paved**
   - **Severity:** HIGH. **Area:** Civil engineering numbers. **Source:** CODEX_SWEEP_S07 S07-01. **Installed:** Civil 3.0.70.
   - **For Tim:** A Blue Factor report with 400 m2 roof, 100 m2 drive, 300 m2 garden and 200 m2 lawn on a 1000 m2 site goes into CDDESIGN as "Roof and paved area 1000 m2" instead of 500, so the whole site is treated as hard surface.
   - **Where:** Modules/Drainage/Rules/BlueFactorReport.cs:39, :100-115. **Command:** CDDESIGN (Yes to "look through the job's folders for its rating report")
   - **Check (Opus, 23 Oct):** VERIFIED. The parser accepts Roof|Paved|Garden|Lawn|Other and stores every area as ImperviousAreaM2. TotalImperviousM2 adds up all rows, and the offer labels it "Roof and paved area", which CDDESIGN applies.
   - **Existing BUG / PR:** none (grep for Blue Factor with garden/lawn: only this report). **Status:** NEW, **BUG-967**. **Fix kind:** code (Garden/Lawn kept out of the impervious total; how to treat "Other" may need Tim's word). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** BlueFactorReport.Parse on the 4-line fixture; expect TotalImperviousM2 = 500 and PerviousAreaM2 = 500

158. **F-158. CDRENUMBER crashes AutoCAD on a looped pipe record**
   - **Severity:** HIGH. **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S08 S08-02. **Installed:** Civil 3.0.70.
   - **For Tim:** If the drawing has two pipes recorded running opposite ways between the same two pits, typing CDRENUMBER can close AutoCAD before the renumber list appears.
   - **Where:** Modules/Drainage/Rules/PitRenumberPlanner.cs:91-104, :142; PitRenumberNetworkBuilder.cs:102-129. **Command:** CDRENUMBER (PitRenumberCommand.cs:28, :69); no switch
   - **Check (Opus, 23 Oct):** VERIFIED. LongestUpstreamPathLength recurses with no in-progress guard (the cache is written only after the recursion returns). The builder takes any From/To pair without a loop check, and the command calls the planner directly. Two opposite pipes P11->P12 / P12->P11 (or a pipe from a pit back to itself) recurse until the stack runs out. A .NET stack overflow cannot be caught, so AutoCAD closes.
   - **Existing BUG / PR:** none (grep for renumber with loop/cycle/stack: only this report). **Status:** NEW, **BUG-968**. **Fix kind:** code (on-path guard; report the loop in plain words, no hard block). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** PitRenumberPlanner.Compute with edges P10<-{P12,P13}, P12<-P11, P11<-P12; expect it returns (a finite list or a loop message), no StackOverflow

159. **F-159. CDNEWDWG keeps the first job's record when the job folder is changed**
   - **Severity:** HIGH. **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S10 S10-01. **Installed:** Civil 3.0.70.
   - **For Tim:** Working in job 26-901, CDNEWDWG with the job folder changed to 26-902 makes the sheet in 26-902, but its title block REF NO (and any client and address) says 26-901. The preview shows the wrong number too.
   - **Where:** Modules/Drainage/Dialogs/NewJobDrawingDialog.xaml.cs:61, :121-128, :202; Commands/NewJobDrawingCommand.cs:51-56, :92-98. **Command:** CDNEWDWG
   - **Check (Opus, 23 Oct):** VERIFIED. The dialog keeps the record loaded for the guessed folder (`_jobRecord`) and never reloads it when the folder box changes. RefreshPlan prefers its JobNumber and passes it to the plan builder, and OnCreate returns that plan's TitleBlockUpdates. The command writes them into the new drawing in the new folder.
   - **Existing BUG / PR:** none (CODEX_SWEEP_S16 CDNEWDWG item is the file name, a different defect). **Status:** NEW, **BUG-969**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** folders 26-901/26-902 each with CE_JobRecord.json; open 26-901\seed.dwg, CDNEWDWG, set folder 26-902, Create; expect DWGPROPS REF NO = 26-902

160. **F-160. CDTWL merges two systems that reuse pit numbers**
   - **Severity:** HIGH. **Area:** Civil engineering numbers. **Source:** CODEX_HUNT_DESIGN DESIGN-01. **Installed:** Civil 3.0.70.
   - **For Tim:** Two separate detention systems in different schedule sets, both numbered P1-P2: CDTWL picks "P2" without asking which, adds both systems' pipes (measured with the wrong set's pit positions) and can say "That is enough" when neither system is.
   - **Where:** Services/DetentionTwlService.cs:112-118; Rules/DetentionBranchCollector.cs:85-135, 150-170; Commands/DetentionTwlCommand.cs:91. **Command:** CDTWL (no switch)
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG-871/F-048 is units, BUG-913 proposal is sump; PR #1538 CDTWL units is different). **Status:** NEW, **BUG-970**. **Fix kind:** code (carry handles/spine keys, not printed numbers). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** reviewer fixture (sets A and B, P1-P2 each, TWL 10.300, need 2.5 kL); expect a choice between A-P2 and B-P2 and one pipe per branch (today one choice, two pipes, about 3,427 L "enough").

161. **F-161. An unreadable drawing record is replaced by a rebuilt one**
   - **Severity:** HIGH. **Area:** Civil records, schedules and sheets. **Source:** CODEX_HUNT_RECORDS R-02. **Installed:** Civil 3.0.70.
   - **For Tim:** If the CE record in a drawing cannot be read (for example written by a newer CE), running CDSYNC rebuilds pits from the drawing and saves over the old record, so manual schedule rows and pit remarks are gone for good.
   - **Where:** Services/ProjectDataService.Persistence.cs:197-287, 823-905, 1070-1130, 1293-1310. **Command:** CDSYNC and any command that saves the project record after a failed load
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grepped unreadable record, LoadFromDrawingLight, PROJECT_DATA corrupt). **Status:** NEW, **BUG-971**. **Fix kind:** code (keep "present but unreadable" state; hold that record's write and keep a copy). **Protected:** yes. **Lane:** Sonnet (protected file); base claude/rel-20261022m. **Test:** drawing whose PROJECT_DATA has lastPitNumber="BROKEN"; run sync+save; expect original chunks unchanged and a visible message (today replaced).

162. **F-162. "Preview drawing updates" writes and saves drawings at once**
   - **Severity:** HIGH. **Area:** Structural. **Source:** CODEX_SWEEP_S13 S13-01. **Installed:** Structural 1.0.121.
   - **For Tim:** Change a closed sheet's revision from A to B and click "Preview drawing updates": the closed DWG is already saved with revision B before you see anything, and closing the window does not undo it.
   - **Where:** CeSheetsManagerWindow.xaml.cs:505-540; Services/CeSheetsUpdateService.cs:124-135; Services/CeSheetsSyncService.cs:835-890; UI/Palette/SheetsPanel.xaml.cs:183. **Command:** CESHEETSCLASSIC (manager window) and the Sheets palette button; normal CESHEETS window not checked
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grepped "Preview drawing updates", CESHEETSCLASSIC, UpdateAllDrawings; BUG-495 is Publish Issue revision, different). **Status:** NEW, **BUG-972**. **Fix kind:** code (preview = read-only change list, then a separate Apply) plus wording. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** closed B.dwg REVISION=A, manifest row B; click preview; expect B.dwg SHA-256 and REVISION unchanged (today REVISION=B, file rewritten).

163. **F-163. Swapping two sheet numbers points both rows at one DWG and archives the other**
   - **Severity:** HIGH. **Area:** Structural. **Source:** CODEX_SWEEP_S13 S13-02. **Installed:** Structural 1.0.121.
   - **For Tim:** Swap S01 and S02 in the sheet list and Apply Renames: both rows now open S01.dwg (which holds the old S02 drawing) and the other drawing is moved into the Superseded folder.
   - **Where:** Services/CeSheetsSyncService.cs:469-536, 690-740. **Command:** CESHEETSCLASSIC > Preview Renames > Apply Renames
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grepped ApplyRenamePlan, ArchiveUnusedProjectDrawings, sheet rename/swap). **Status:** NEW, **BUG-973**. **Fix kind:** code (map from a snapshot of the original row-to-file assignment; archive from the final set). **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** manifest rows S01->S02.dwg target, S02->S01.dwg target, both files present; ApplyRenamePlan; expect two distinct DwgPaths and ArchivedUnusedDrawingCount 0 (today both S01, count 1).

164. **F-164. Rows excluded from the XCLMTXT schedule still set the C2 support size**
   - **Severity:** HIGH. **Area:** Structural. **Source:** CODEX_SWEEP_S14 S14-02. **Installed:** Structural 1.0.121.
   - **For Tim:** exclude C2 = 200 SHS in XCLMTXT and insert the rest; the printed schedule has no C2, but typing C2 silently uses 200 SHS instead of asking you for the size.
   - **Where:** Modules/Structural/Services/XclmTxtService.cs:277, :303-331. **Command:** XCLMTXT (Insert Selected) then C2 (also any support command whose name matches a schedule mark); no switch
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grep for MemberSchedule / XclmTxtService / schedule snapshot in carpark, fix briefs, ledger: no hits). **Status:** NEW, **BUG-974**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** Preview rows B1/310UB32 (Include, Ground) and C2/200 SHS (Include=false); call TryPersistMemberSchedule path via insert: saved MEMBER_SCHEDULE holds 1 row (B1) and FindByCode(db,"C2") returns null.

165. **F-165. Switching a support moves and recreates nearby text that belongs to another support**
   - **Severity:** HIGH. **Area:** Structural. **Source:** CODEX_SWEEP_S15 S15-01. **Installed:** Structural 1.0.121.
   - **For Tim:** two supports 200 mm apart; SDS on the first one and turning it 90 degrees also swings the second support's label round to the wrong place, and the label becomes a new object.
   - **Where:** Modules/Structural/Commands/SupportBlockCommands.cs:562-580, :665-745, :1772-1830, :1905-1935. **Command:** SDS, SDS1, SC2 and every other S* support switch (and TDS); no switch
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grep CaptureSupportSideTextLabels / side-text label / neighbour support: no hits). **Status:** NEW, **BUG-975**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** Supports A (0,0) and B (200,0), DBText on SUPPORT TEXT at (245,145); SDS on A, rotation 90: the text keeps its handle, insertion (245,145,0) and rotation 0.

166. **F-166. A failed read of the notes file lets the next new note overwrite every earlier note**
   - **Severity:** HIGH. **Area:** Structural. **Source:** CODEX_SWEEP_S15 S15-03. **Installed:** Structural 1.0.121.
   - **For Tim:** if your notes file is damaged or held by OneDrive for a moment, adding one note in the Notes palette leaves a file with only that note; your notes from every other drawing vanish with no warning.
   - **Where:** Modules/Structural/Core/Notes/SharedNotesManager.cs:350-375, :1060-1110. **Command:** CENOTES (+ Note, Save) and the Notes browser; no switch
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grep notes_data / SharedNotesManager: no hits). **Status:** NEW, **BUG-976**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** Isolated DataFolder, notes_data.json with 2 notes prefixed "S15_CORRUPT!"; AddNote("S15 THIRD") returns false and the file bytes are unchanged.

167. **F-167. SBEAM uses UCS pick numbers as World coordinates**
   - **Severity:** HIGH. **Area:** Structural. **Source:** CODEX_HUNT_STRUCTCMDS SC-01. **Installed:** Structural 1.0.121.
   - **For Tim:** move the UCS to a detail at 10000,20000 and pick a beam from local 0,0 to 3000,0: SBEAM draws it back at World 0,0 to 3000,0, nowhere near the detail.
   - **Where:** Modules/Structural/Commands/SbeamCommandRunner.cs:159-198, :234. **Command:** SBEAM (elevation and section routes); no switch
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (F-055 is CEMEMBER's Z/section-axis loss, a different command; no SBEAM UCS entry in carpark or ledger). **Status:** NEW, **BUG-977**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** UCS Origin 10000,20000; SBEAM 310UB32 Side Elevation, picks 0,0 and 3000,0: outline end stations at World X 10000 and 13000, Y 20000.

168. **F-168. A second AutoCAD process skips Structural start-up**
   - **Severity:** HIGH. **Area:** Structural. **Source:** CODEX_HUNT_COMPAT COMPAT-01. **Installed:** Structural 1.0.121.
   - **For Tim:** Open a second AutoCAD (same or other year) while the first is running: the second has no CE STRUC ribbon or background services and says another copy is active, until the first AutoCAD is closed.
   - **Where:** Modules/Structural/Plugin.cs:76, 125-130, 451-475. **Command:** Structural load at AutoCAD start (no switch)
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grepped PluginRuntime, RuntimeMutex, second AutoCAD process). **Status:** NEW, **BUG-978**. **Fix kind:** code (process-scoped name, e.g. add the process id). **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** create the named mutex in a helper process, then call TryAcquireRuntimeMutex in a second process; expect true (today false).

169. **F-169. CDJOINT erases the old joints before the questions that can still cancel**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S09 S09-01 (also HUNT_DATALOSS_SILENT DS-06, never filed). **Installed:** Civil 3.0.70.
   - **For Tim:** CDJOINT on a slab that already has joints, Enter for Yes to "Clear and regenerate", then Esc at "Select slab type": every joint line and SC label disappears, nothing is redrawn and nothing is said. Only U brings them back.
   - **Where:** Modules/Drainage/Commands/CdJointCommand.cs:77-112, :500-528. **Command:** CDJOINT; no switch
   - **Check (Opus, 23 Oct):** VERIFIED. EraseJoints commits its own transaction at "Clear and regenerate? Yes". Esc at the slab type or spacing prompt, or a grid with no joints, then returns before StoreSlabs, so the slab record still lists the erased handles.
   - **Existing BUG / PR:** HUNT_DATALOSS_SILENT_2026-10-12 DS-06 (identical, same lines; never given a BUG number, not in BUG_CARPARK). **Status:** NEW, **BUG-979**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** slab 9000x6000 with a 3000 grid; CDJOINT, Yes, Esc at slab type; expect the 3 baseline line/label handles still live and the stored list unchanged

170. **F-170. Pipe Flows keeps the first pipe's grade when another pipe is picked**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Civil engineering numbers. **Source:** CODEX_SWEEP_S11 S11-01. **Installed:** Civil 3.0.70.
   - **For Tim:** In CDCALC Pipe Flows, pick a 1 in 50 pipe then a 1 in 200 pipe from the list: the grade box stays 50, the flow shown is about double the true capacity, and the grey note can name the second pipe's inverts.
   - **Where:** Modules/Drainage/ViewModels/PipeFlowCalcViewModel.cs:159-217; Dialogs/CalculationsV2Dialog.xaml:573. **Command:** CDCALC > Pipe Flows > SELECT FROM DRAWING list (no switch)
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grepped carpark/FB/ledger for PipeFlowCalc, prefill, IsBlankOrDefault; only BUG-592 zero-input, different). **Status:** NEW, **BUG-980**. **Fix kind:** code (remember which fields CE filled itself; refill those on the next pick). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** view model with pipes A (1:50, RCP) and B (1:200, RCP); set SelectedPipeId=A then B; expect SlopeRatio "200" and hint naming B (today "50").

171. **F-171. LandXML stated in millimetres is scaled x1000**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Civil imports. **Source:** CODEX_SWEEP_S11 S11-02. **Installed:** Civil 3.0.70.
   - **For Tim:** A LandXML file that says it is in millimetres, with pits 1 m apart, comes in with the pits 1 km apart.
   - **Where:** Modules/Drainage/Helpers/LandXmlParser.cs:125, 189, 446-460. **Command:** CDIMPORTLANDXML (no switch)
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** BUG-725 / FB-17 (FB-17 item 2 names exactly `linearUnit="millimeter"` multiplied by 1000, same lines 189 and 446-460). **Status:** FILED as BUG-725. **Note:** Same defect as BUG-725 / FB-17 item 2 (linearUnit millimeter scaled by 1000). **Fix kind:** code. **Protected:** no. **Lane:** none (no entry). **Test:** parse the reviewer's S11_MM.xml; expect P1 (1000,1000) and P2 (1000,2000) unscaled, separation 1000 units (today 1,000,000).

172. **F-172. Two XREF pits with the same local handle merge into one schedule group**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S11 S11-03. **Installed:** Civil 3.0.70.
   - **For Tim:** In a combined schedule from two drainage XREFs, the second drawing's pit can print with a blank pit number, size, outlet and cover, so its row reads as another inlet into the first drawing's pit.
   - **Where:** PitScheduleViewModel.Schedule.cs:410-449; PitScheduleViewModel.Data.cs:812-826. **Command:** PITSCHEDULE, Source = Drainage XREFs (no switch)
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG-788/LM-45 is source discovery merging SAVEAS copies, a different key). **Status:** NEW, **BUG-981**. **Fix kind:** code (add SourceDrawingIdentity to the group key for external rows). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** IsFirstRowInGroup on two external rows, same SourcePitHandle "2A1" and set Main, different SourceDrawingIdentity; expect true for index 1 (today false).

173. **F-173. CDPROPAGATE certifies a fall that the 2-decimal write removes**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S12 S12-01. **Installed:** Civil 3.0.70.
   - **For Tim:** Override a 1 m pipe to 1 in 300 in the cascade preview: it says OK, both inverts are saved as 10.00 (flat), and the command line still says "Min grade: 1:300".
   - **Where:** Models/PropagationPlan.cs:50-57; Services/LinkService.RepairAudit.InvertPropagation.cs:686, 780-832, 917. **Command:** CDPROPAGATE (Cascade Preview, Override 1:N cell)
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG-782 is the kept-hand-level end, different; F-070 is CDRULES wording). **Status:** NEW, **BUG-982**. **Fix kind:** code (check and report on the rounded strings actually written; keep Tim's 2dp format). **Protected:** yes. **Lane:** Sonnet (protected file); base claude/rel-20261022m. **Test:** plan row length 1000 mm, new levels 10.003333/10.000; expect flat-when-written = true and no "1:300" in summary (today false and "1:300").

174. **F-174. Title-Xref layer sync freezes layers of another Xref whose name contains the title name**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Structural. **Source:** CODEX_SWEEP_S13 S13-03. **Installed:** Structural 1.0.121.
   - **For Tim:** With title Xref TITLE on the layout and an unrelated Xref TITLE_DETAIL in model space, updating a revision A sheet freezes TITLE_DETAIL|REV_B, so its linework disappears.
   - **Where:** Services/CeSheetsSyncService.cs:2156-2172, 2175-2245, 2290-2298. **Command:** Sheets palette "Preview drawing updates" (SyncManifest); any sync that reaches title-Xref layers
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grepped IsTitleXrefLayerMatch, title xref freeze). **Status:** NEW, **BUG-983**. **Fix kind:** code (match the bound Xref's exact name/hierarchy, not substrings). **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** IsTitleXrefLayerMatch("TITLE_DETAIL|REV_B", {"TITLE"}); expect false (today true).

175. **F-175. CEMARKUPUNDO undoes in whichever drawing is active and marks the batch undone before U runs**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Structural. **Source:** CODEX_SWEEP_S14 S14-01. **Installed:** Structural 1.0.121.
   - **For Tim:** run a markup batch in drawing A, switch to drawing B and type CEMARKUPUNDO: B loses its last step, A's note stays, and CE records A's batch as undone, so running it again in A puts a second copy of the note on top.
   - **Where:** Modules/Structural/Services/MarkupAIWorkflowService.cs:209-251; MarkupAIExecutionService.cs:215-226; MarkupAIRuntimeState.cs:18. **Command:** CEMARKUPRUN then CEMARKUPUNDO after a drawing switch; no switch
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grep of BUG_CARPARK, FIX_BRIEFS, ledger for CEMARKUPUNDO / Markup Undo / MarkupAIRuntimeState: no hits). **Status:** NEW, **BUG-984**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** Two drawings; CEMARKUPRUN one NATIVE:NOTE in A; activate B, draw LINE; CEMARKUPUNDO: expected refusal naming drawing A, B's line still present, A's plan status still Executed.

176. **F-176. BEXTEND treats an arc segment of a polyline as a straight chord and says it reached the boundary**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Structural. **Source:** CODEX_SWEEP_S15 S15-02. **Installed:** Structural 1.0.121.
   - **For Tim:** extend a beam to a curved wall drawn as a polyline arc and it stops on the straight line between the arc's ends, up to the full arc depth short, while CE says it reached the boundary.
   - **Where:** Modules/Structural/Commands/BeamExtendCommands.cs:228-252, :170-215. **Command:** BEXTEND (and alias BEXT if registered); no switch
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (carpark line 40 "BEXTEND/FEDIT doubled defaults ... FADOPT arc" is a different defect). **Status:** NEW, **BUG-985**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** LINE (0,0)-(3000,0); LWPOLYLINE (5000,-2000) bulge 1 to (5000,2000); BEXTEND End, None: beam end = (7000,0,0).

177. **F-177. CSREOBAR previews the true sloping length then flattens the bar and rewrites the note shorter**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Structural. **Source:** CODEX_HUNT_STRUCTCMDS SC-02. **Installed:** Structural 1.0.121.
   - **For Tim:** pick a bar from 0,0,0 to 3000,0,4000: the preview and command line say 5000 LG, but the bar drawn, its note and the bar schedule all say 3000.
   - **Where:** Modules/Structural/Services/ReoBarService.cs:130-192, :486-496, :745-766. **Command:** CSREOBAR, then CSBARSCHEDULE; no switch
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (no CSREOBAR slope/Z entry in carpark or ledger). **Status:** NEW, **BUG-986**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** World UCS, CSREOBAR N16 3 100 Top, 0,0,0 to 3000,0,4000, Yes: completion line, note text and extent length all agree (either 5000 along a 3D bar, or a stated plan-length rule with matching preview).

178. **F-178. CDSYNC can give a plain pit a nearby pit's lid, remarks and schedule tick**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Civil records, schedules and sheets. **Source:** CODEX_HUNT_RECORDS R-01. **Installed:** Civil 3.0.70.
   - **For Tim:** In a metre drawing, a new pit with no levels yet sitting 10 m from a pit marked "Class D, KEEP P2, not in schedule" can swap: after CDSYNC the new pit drops out of the schedule with Class D, and the other one comes back in.
   - **Where:** Services/ProjectDataRecoveryGuardService.cs:105-232, 347-365; Services/ProjectDataService.cs:636-662. **Command:** CDSYNC (any full EnsureDrawingDataCurrent)
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (ledger PERF-01 / proposed BUG-970 is speed of the same loop, not wrong matches). **Status:** NEW, **BUG-987**. **Fix kind:** code (reserve id/handle matches first; position only for unmatched; tolerance in drawing units via Settings). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** RestorePitUserData with pits P1 (0,0) default and P2 (10,0) Class D/KEEP P2/excluded and their own snapshots; expect each keeps its own values (today swapped).

179. **F-179. An old PC-side project file beats a valid drawing record with empty lists**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Civil records, schedules and sheets. **Source:** CODEX_HUNT_RECORDS R-03. **Installed:** Civil 3.0.70.
   - **For Tim:** Delete the last pit and pipe in a job and reopen it: CE can bring back old rainfall, land use and numbering choices from a file on this PC, so the same DWG behaves differently on a colleague's PC.
   - **Where:** Services/ProjectDataService.Persistence.cs:197-287. **Command:** any drawing open / first CE command (project load)
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grepped legacy file precedence, CD_ProjectData_; BUG-489 only logs that path). **Status:** NEW, **BUG-988**. **Fix kind:** code (any successfully read drawing record wins). **Protected:** yes. **Lane:** Sonnet (protected file); base claude/rel-20261022m. **Test:** valid embedded record with empty lists and landUse=residential plus legacy file landUse=commercial; load; expect residential (today commercial).

180. **F-180. CDSPINEUPGRADE Rollback removes permanent identities**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Civil records, schedules and sheets. **Source:** CODEX_HUNT_RECORDS R-04. **Installed:** Civil 3.0.70.
   - **For Tim:** Run CDSPINEUPGRADE Apply on an old job, then CDSPINEUPGRADE Rollback: the pits and pipes lose the permanent identities they were just given, while their numbers on the drawing look the same.
   - **Where:** Commands/SpineUpgradeCommand.cs:40-55, 140-175; Services/LinkService.Spine.cs:195-212, 713-726; Services/ProjectDataService.Spine.cs:230-239. **Command:** CDSPINEUPGRADE > Rollback (hidden in registry)
   - **Check (Opus, 23 Oct):** PARTLY (the removal is real; calling it an R-27 breach needs Tim's word, because it only undoes keys the same upgrade added, on a hidden repair command)
   - **Existing BUG / PR:** none (grepped spine rollback, RollbackSpine). **Status:** NEW, **BUG-989**. **Fix kind:** needs Tim's word (keep keys and roll back the rest, or refuse) then code. **Protected:** yes. **Lane:** Sonnet (protected file); base claude/rel-20261022m. **Test:** object with no SPINE_ID; Apply then Rollback; expect SPINE_ID still present and a refusal line (today removed, "Rolled back 1 of 1 identities").

181. **F-181. Startup telemetry sends the access token over plain HTTP or to an unapproved address**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Privacy and security. **Source:** CODEX_HUNT_PRIVACY H01. **Installed:** Civil 3.0.70.
   - **For Tim:** If a PC's CE cloud address is typed as http://, opening AutoCAD sends the CE access key unencrypted in the background, even with AI turned off.
   - **Where:** Services/FleetTelemetryStartupService.cs:49-75; Services/TelemetryQueueService.cs:131-205. **Command:** AutoCAD start-up (Civil load); Settings fleetTelemetry.heartbeatEnabled default ON
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** related BUG-557 route 8 (heartbeat had no switch; now has one) but not the HTTPS/approval gap; none exact. **Status:** NEW, **BUG-990**. **Fix kind:** code (require https and the approved host; no auto-redirect). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** HttpHandlerOverride capture, CE_CLOUD_URL=http://127.0.0.1:18765, dummy auth; TryFlushAsync; expect zero requests (today one POST with x-api-key).

182. **F-182. AI chat sender follows redirects past the approved address**
   - **Severity:** MEDIUM (source HIGH; check MEDIUM). **Area:** Privacy and security. **Source:** CODEX_HUNT_PRIVACY H02. **Installed:** Civil 3.0.70.
   - **For Tim:** CE checks the cloud address before asking AI, but if that address forwards the request, the question, drawing facts and access key go to wherever it forwards without a second check.
   - **Where:** CE.AI.Core/AnthropicChatClient.cs:36-38, 117-130; Controls/CeAssistantControl.xaml.cs:687-711. **Command:** CDASK (and markup / X-Civil vision paths using the same sender); AI master switch must be ON
   - **Check (Opus, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG-557 route 7 covers only the seat check, which does refuse redirects). **Status:** NEW, **BUG-991**. **Fix kind:** code (redirects off in the shared AI sender). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** real HttpClientHandler against loopback A returning 307 to B; SendAsync; expect B receives nothing and an error (today B gets body and key).

183. **F-183. Pit Schedule writes a mm diameter as the pipe polyline width in a metre drawing**
   - **Severity:** LOW (source HIGH; check LOW). **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S02 S02-01. **Installed:** Civil 3.0.70.
   - **For Tim:** In a drawing set to UNITS = Metres, changing a pipe from 300 to 375 in the Pit Schedule makes the pipe band 375 m wide. But CD itself already draws pipes 300 m wide in that kind of drawing, so it only matters if the office really uses true metre drawings, which is your open BUG-287 question.
   - **Where:** Modules/Drainage/Services/LinkService.cs:1077-1084; caller ViewModels/PitScheduleViewModel.Data.cs SyncDiameter (~1858-1864). **Command:** PITSCHEDULE (Rows, diameter cell, Stop overriding); no switch
   - **Check (Opus, 23 Oct):** PARTLY. The write is real: `RefreshPipeVisualByHandle` puts the mm number straight into every vertex width. But the same thing happens in every pipe width write in Civil, including CD's own drawing: `PipeEntityService.cs:70` and `DrawingService.CreatePipePolyline` (called from `PipeCreationService.cs:209`) also draw the pipe with width = mm diameter. In a metre drawing CD would already draw a 300-wide pipe, so the "0.300 before" fixture is hand-made, and Pit Schedule just behaves like every other path. This is the open BUG-287 metre-drawing question (CE pit blocks are mm blocks inserted at ...
   - **Existing BUG / PR:** BUG-287 / BUG-338 family (metre drawings, open question for Tim); no exact entry (grep for RefreshPipeVisualByHandle and pipe width in metres: none). **Status:** LOW, no carpark entry. **Note:** Part of the open metre-drawing question BUG-287 / BUG-338: every Civil pipe-width writer assumes 1 unit = 1 mm, CD included. **Fix kind:** needs Tim's word (BUG-287), then code in every pipe width writer at once. **Protected:** yes. **Lane:** none (no entry). **Test:** mm drawing (INSUNITS 4), ordinary pipe 300; PITSCHEDULE outlet 375 + Stop overriding; expect width 375. Metre case only after Tim's BUG-287 ruling.

184. **F-184. Ordinary pipe outline (MLINE) scale is the mm diameter in a metre drawing**
   - **Severity:** LOW (source HIGH; check LOW). **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S03 S03-02. **Installed:** Civil 3.0.70.
   - **For Tim:** In a UNITS = Metres drawing, CD on a colleague's PC draws a 225 pipe with its outline 225 m wide. The pipe band is just as wide, so this only matters if the office uses true metre drawings.
   - **Where:** Modules/Drainage/Services/MlineService.cs:66, :397; Services/PipeCreationService.cs:209-222. **Command:** CD (ordinary pipe path: pipe-object upgrade held by default on colleagues' PCs, option pipeObjectUpgrade = Automatic)
   - **Check (Opus, 23 Oct):** PARTLY. True as read: `mline.Scale = scale` with scale = mm diameter, and there is no units conversion. This is the path on colleagues' PCs (PipeObjectUpgradeGate default "Automatic" = no upgrade off the test-bed PC). But the pipe polyline drawn next to it also gets width = mm diameter (PipeEntityService.cs:70, DrawingService.CreatePolyline). So the whole ordinary pipe assumes 1 unit = 1 mm, the same as CE's mm pit blocks. Converting only the outline would leave the band and the outline different sizes. Same BUG-287 question as S02-01.
   - **Existing BUG / PR:** BUG-287 / BUG-338 family (no exact entry); fix together with S02-01. **Status:** LOW, no carpark entry. **Note:** Same BUG-287 metre-drawing question as F-183; fix all pipe-width writers together once Tim rules. **Fix kind:** needs Tim's word (BUG-287), then code in every pipe width writer. **Protected:** no. **Lane:** none (no entry). **Test:** INSUNITS 4, CD 225 from 0,0 to 10000,0; expect MLINE scale 225 and polyline width 225 (the metre expectation waits for Tim's ruling)

185. **F-185. PITEDIT transforms the pit position through the UCS twice**
   - **Severity:** none (FALSE) (source HIGH; check false). **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S09 S09-02. **Installed:** Civil 3.0.70.
   - **For Tim:** No fault: CE switches to World UCS for the length of every CE command (the "[CE] PITEDIT - UCS temporarily switched to World" line), so editing a pit with a moved UCS keeps the pit and its cover text in the right place.
   - **Where:** Modules/Drainage/Commands/PitEditCommand.cs:133, :1790, :1889 (only reachable without the guard). **Command:** PITEDIT
   - **Check (Opus, 23 Oct):** FALSE. The reviewer missed UcsGuardService. It is subscribed at start-up (PluginInitialization.cs:128) and, on CommandWillStart for every CE CommandMethod (found by reflection; PITEDIT is also in the fallback list at :62; only COPYMULTI/CR/MR are excluded), it sets the UCS to World before PITEDIT runs. So inside PITEDIT `DrawingService.TransformToWorld` multiplies by the identity matrix, and both the record position and the cover text corner stay at the block position.
   - **Existing BUG / PR:** none. **Status:** FALSE, no entry. **Note:** FALSE: UcsGuardService sets World UCS for every CE command, PITEDIT included (UcsGuardService.cs:401, restored :470), so the double transform cannot happen. **Fix kind:** test only (optional: a guard test that PITEDIT is in the UCS-guard set). **Protected:** yes. **Lane:** none (no entry). **Test:** UCS Origin 10000,20000; PITEDIT P1, cover 10.10, Enter for BR; expect record (10000,20000) and cover text at the same world point as with World UCS

186. **F-186. Compare background drops the OLD position of a moved roof or boundary**
   - **Severity:** MEDIUM. **Area:** Civil imports. **Source:** CODEX_SWEEP_S01 S01-01. **Installed:** Civil 3.0.70.
   - **For Tim:** When a consultant moves a roof 4.5 m in the Xref and you run CDXREFCOMPARE, the "Nearby CE objects to check" list names the pit beside the new roof but not the pit that used to sit beside the old roof, and next time it forgets the old roof ever existed.
   - **Where:** BackgroundXrefGeometryDiffService.cs:74, :106-109; BackgroundXrefAffectedObjectsService.cs:35-49; BackgroundXrefCompareCommand.cs:102-113, :135-144. **Command:** CDXREFCOMPARE (also the automatic one-line background-changed notice leads to it); no switch found, runs by default
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grep of BUG_CARPARK, ledger and FB for BackgroundXref / Compare background / CDXREFCOMPARE found no matching entry). **Status:** NEW, **BUG-992**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Pure unit test: previous roof 0..10000, current roof 4500..14500 (same category), pits at (-500,5000) and (15000,5000) in mm; run Diff then FindAffected; expected both pits listed, current code lists only the second.

187. **F-187. Show where reads its "closest view 2000 mm" as drawing units**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S01 S01-02. **Installed:** Civil 3.0.70.
   - **For Tim:** In a metre drawing, clicking Show where on a 0.6 m pit row in the Checks list zooms out until the pit is a speck, because the "2000 mm" closest view is applied as 2000 m.
   - **Where:** ChecksListPaletteService.cs:215, :251-252; ShowWhere.cs:74, :116-120; AutoCadShowWhereSurface.cs:58-59. **Command:** CDCHECKS (Show where on a row); CDHUB and CDCHECKCURRENT also open the list when the switch is on. Switch: checks.checksCommandEnabled (ChecksSettings.ChecksCommandEnabled), default OFF (UserSettings.cs:2829)
   - **Check (Sonnet, 23 Oct):** VERIFIED (only reachable when the one Checks list is switched on, default OFF)
   - **Existing BUG / PR:** none. **Status:** LOW, no carpark entry. **Fix kind:** code. **Protected:** no. **Lane:** none (no entry). **Test:** Unit test ShowWhereView.Compute with box 0.6 x 0.6 drawing units, INSUNITS 6 and min view 2000 mm: expected view width 2.0 (drawing units) not 2000; same box at INSUNITS 4 sized 600 gives width 2000.

188. **F-188. (LOW, listed only, not verified) Back restores a view saved in a different drawing**
   - **Severity:** LOW. **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S01 S01-03. **Installed:** Civil 3.0.70.
   - **For Tim:** Find a pit in drawing A, switch to drawing B, press Back in the Inspector, and B jumps to A's position and zoom.
   - **Where:** CeZoomHighlightService.cs:39, :142, :149-167. **Command:** CEFIND then Inspector Back
   - **Check (Sonnet, 23 Oct):** not checked (listed only, as asked)
   - **Existing BUG / PR:** unchecked (BUG_CARPARK line 10470, W49-02, is a different two-drawing problem). **Status:** LOW, no carpark entry. **Note:** Listed only; not re-checked. **Fix kind:** code. **Protected:** no. **Lane:** none (no entry). **Test:** not written

189. **F-189. CDCHECK's FALL arrow direction check ignores a rotated block**
   - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S02 S02-02. **Installed:** Civil 3.0.70.
   - **For Tim:** If you rotate a FALL symbol 180 degrees so it points away from its grated pit, CDCHECK still treats it as aimed at the pit and says nothing (and a correctly turned arrow can keep a false "points away" warning).
   - **Where:** FallArrowDirectionReviewService.cs:145-175; Rules/FallArrowGeometry.cs:131-170; Services/Checks/ChecksResultReader.cs:143-149. **Command:** CDCHECK (All); CDCHECKS / CDRULES share the same reader. No switch; default on
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG-588 is about the saved listing not holding this warning, a different defect). **Status:** NEW, **BUG-993**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Unit test on TryReadFallArrow output or Review: arrow with Angle1 0, flip 0, block rotation pi at (0,0), grated pit at (5000,0), tolerance 45 deg: expected one away finding with difference about 180.

190. **F-190. The compact (workshop) Inspector shows a metre pipe's Drawn length in millimetres without converting**
   - **Severity:** MEDIUM. **Area:** Wording and windows. **Source:** CODEX_SWEEP_S02 S02-03. **Installed:** Civil 3.0.70.
   - **For Tim:** Click a 10 m pipe in a metre drawing with the normal Inspector open: Connections > Drawn length says 10 mm instead of 10000 mm.
   - **Where:** InspectorPaletteService.cs:860, :1128; ViewModels/InspectorViewModel.cs:120-143. **Command:** CDINSPECTOR (select a pipe); editors.workshopLayout default ON
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG-323 fixed the other Inspector path only; PR #1546 is Inspector type, not length; PR #1530 is rule length, not Inspector). **Status:** NEW, **BUG-994**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Fixture pipe polyline of length 10.0 with INSUNITS 6: the drawn-length string passed to ShowCivilPipeRecord is "10000 mm"; with length 10000 at INSUNITS 4 it is also "10000 mm".

191. **F-191. A pit label stops accepting later style changes once its text loses "CL:" and "IL:"**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Civil labels and Tidy labels. **Source:** CODEX_SWEEP_S02 S02-04. **Installed:** Civil 3.0.70.
   - **For Tim:** Apply the Compact label style (just "P1"), then switch back to Default and press Apply to drawing: the pit labels stay "P1" and CE says no matching labels were found.
   - **Where:** LabelStyleService.cs:210-235, :418; ViewModels/LabelStyleDialogViewModel.cs:199-218. **Command:** CDLABELSTYLE (Apply to drawing). No switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** LOW, no carpark entry. **Fix kind:** code. **Protected:** no. **Lane:** none (no entry). **Test:** Pit with attached MText "P1" (recorded in pit attachments) and active Default style: ApplyAllToDrawing returns 1 and the text becomes "P1  CL:10.000  IL:9.000"; currently returns 0.

192. **F-192. Inspector health drill-down zooms away from the pits it selected when the UCS is moved**
   - **Severity:** MEDIUM. **Area:** Wording and windows. **Source:** CODEX_SWEEP_S02 S02-05. **Installed:** Civil 3.0.70.
   - **For Tim:** With a user UCS set, clicking "Unconnected pits" (or any health count) in the Inspector selects the right pits but the view jumps to empty space and the command line still says "Zoom fit applied".
   - **Where:** InspectorPaletteService.cs:268-282, :2752-2806; DrawingService.cs:595-660. **Command:** CDINSPECTOR > Show full detail > Drawing health buttons (failing grade, low cover, unconnected pits, disconnected pipes, duplicate numbers, missing levels). No switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** NEW, **BUG-995**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** UCS origin 100000,0 and a pit extents (-300,-300)-(300,300) world: the resulting view centre is (0,0); current code gives about (100000,0).

193. **F-193. Mirroring manually placed pipe text in CD loses the pipe's link to the text**
   - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Source:** CODEX_SWEEP_S03 S03-03. **Installed:** Civil 3.0.70.
   - **For Tim:** In CD with manual pipe text, answer Yes to "Do you want to mirror the text?", then move the pipe: the mirrored label stays behind.
   - **Where:** MirrorService.cs:133-149; CdCommand.cs:771-780. **Command:** CD (manual pipe text, Yes to mirror); no switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG at carpark line 8369 is about AutoCAD's own MIRROR on a pit, a different path). **Status:** NEW, **BUG-996**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Mirror a registered MText through MirrorEntity and assert the original handle still resolves (or the pipe record holds exactly the live handle); then move the pipe and assert the text moves by the same displacement.

194. **F-194. Updating one older long section rewrites every copy that shares its block definition**
   - **Severity:** MEDIUM. **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S03 S03-04. **Installed:** Civil 3.0.70.
   - **For Tim:** Copy a long-section block to keep an older view, then press Update Existing on the original in CDCALC (Older longitudinal): the copy changes too, even if it sits on a locked layer.
   - **Where:** LongitudinalSectionService.cs:452-504; ViewModels/LongitudinalSectionViewModel.cs:700-718. **Command:** CDCALC > Older longitudinal > Update Existing. The tab is shown by default
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. Related but different: BUG-758 (older tab lacks CDPROFILE admission checks; fix is in 3.0.70 via PR #1407/#1408). **Status:** NEW, **BUG-997**. **Fix kind:** code (give the selected insert its own definition first; do not add a hard block, R-27). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Section block A and copy B reference one definition; UpdateExistingSection(A) with a changed vertical scale: B's nested scale note keeps the old text (needs its own definition); currently both change.

195. **F-195. Network redesign shows pit floor levels as the pipe's "before" levels, then rejects Apply as stale**
   - **Severity:** MEDIUM. **Area:** Civil engineering numbers. **Source:** CODEX_SWEEP_S04 S04-02. **Installed:** Civil 3.0.70.
   - **For Tim:** In CDHUB Network redesign, a pipe arriving 30 mm above the pit floor is reported as "levels changed after the preview" and Apply stays greyed out, though you changed nothing.
   - **Where:** NetworkRedesignPreviewService.Projection.cs:197-200; NetworkRedesignDrawingProjector.cs:305-309; NetworkRedesignApplyTicketService.cs:472-480; NetworkRedesignHubViewModel.cs:318. **Command:** CDHUB > Network redesign > Build read-only preview / Apply approved redesign. No switch found; reachable by default
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (F-007/BUG-868 is the UPVC-only solver, a different defect). **Status:** NEW, **BUG-998**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Unit test of the projection and ticket: pit IL 10.300, arriving pipe ToInvert 10.330 unchanged since preview: ticket must have no "levels changed" reason and the preview's before-IL must be 10.330.

196. **F-196. CDRUNSOLVE feeds zero flow to the sizer and then says every invert already matches**
   - **Severity:** MEDIUM. **Area:** Civil engineering numbers. **Source:** CODEX_SWEEP_S04 S04-03. **Installed:** Civil 3.0.70.
   - **For Tim:** CDRUNSOLVE on a normal run finishes with "every invert already matches the solved design" even though it solved nothing and your inverts are untouched.
   - **Where:** ProposalApplyService.PlanBuilders.cs:555, :72-110; NetworkDesignService.cs:223, :281; PipeSizingSolver.cs:63; RunSolveCommand.cs:140-178. **Command:** CDRUNSOLVE (also the hand-off from Edit Pit). No switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (F-007 / BUG-868 / PR #1537 concern the hard-coded UPVC material in this same solver, not the zero flow). **Status:** NEW, **BUG-999**. **Fix kind:** code (feed real flow, or say honestly it could not solve; needs Tim's word on whether Run Solve is meant to be a level-only calculation). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** BuildRunInputs -> Design -> BuildRunSolvePlan for a one-pipe run A-C (cover 12.0, ILs 10.6/10.0): plan must carry an error or warning shown to the drafter, never an empty plan reported as "matches"; currently EffectiveChanges 0 with only a warning.

197. **F-197. CDIMPORTXCIVIL moves the pits and pipes to the host drawing but leaves spot levels and fall arrows behind**
   - **Severity:** MEDIUM. **Area:** Civil imports. **Source:** CODEX_SWEEP_S06 S06-02. **Installed:** Civil 3.0.70.
   - **For Tim:** When CDIMPORTXCIVIL automatically shifts a far-away consultant layout onto your drawing, the pits and pipes land in the right place but the spot levels and FALL arrows stay at the old coordinates.
   - **Where:** XcivilImportService.cs:696-712, :1134, :1172; XcivilPitInsertionService.cs:899-965, :1047-1100. **Command:** CDIMPORTXCIVIL (when the auto-translation trigger fires). No switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (F-040 / proposed BUG-908 concern LandXML Replace target extents, not the Xcivil spot and fall lists). **Status:** NEW, **BUG-1000**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Call TranslateXcivilImportData with a translation of (985000, 990000) and one spot and one fall candidate at (15000,12000) and (15000,14000): expected (1000000,1002000) and (1000000,1004000); currently unchanged.

198. **F-198. Xcivil import: a text already used by a neighbour blocks the next pit from taking its own label**
   - **Severity:** MEDIUM. **Area:** Civil imports. **Source:** CODEX_SWEEP_S06 S06-03. **Installed:** Civil 3.0.70.
   - **For Tim:** Importing a consultant layout with two close pits labelled P10 and P20, the second pit can come in as a made-up P11 even though P20 is sitting right there.
   - **Where:** XcivilScheduleService.cs:795-845 (loop at :817-830); XcivilImportService.cs:473 (caller), :562. **Command:** CDIMPORTXCIVIL. No switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** NEW, **BUG-1001**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Two pit sources at (10000,10000) and (11000,10000), texts P10 at (10000,12000) and P20 at (11000,13000): expected P10 and P20 assigned, unresolved 0; currently second pit unresolved and later "P11".

199. **F-199. Xcivil import: a rotated exported fall-arrow block loses its direction**
   - **Severity:** MEDIUM. **Area:** Civil imports. **Source:** CODEX_SWEEP_S06 S06-04. **Installed:** Civil 3.0.70.
   - **For Tim:** Two fall arrows that point at right angles in the consultant's drawing, because one block was rotated 90 degrees, both come in pointing the same way with the same 1:100 text.
   - **Where:** XcivilEntityScanner.cs:1759-1917; XcivilPitInsertionService.cs:1087-1100. **Command:** CDIMPORTXCIVIL. No switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** NEW, **BUG-1002**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Block definition with a line (0,0)-(1000,0) and text "1:100"; two references on layer FALL, rotation 0 and 90 degrees: imported Angle1 values must differ by 90 degrees; currently both 180.

200. **F-200. CEFIND says a registered pit like P1A is "not in this drawing"**
   - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S07 S07-02. **Installed:** Civil 3.0.70.
   - **For Tim:** Type CEFIND then P1A (or C2, or P1A-P2) for a pit that is clearly there and CE answers "P1A is not in this drawing."
   - **Where:** CeFindQuery.cs:54-102; Commands/CeFindCommand.cs:80-111. **Command:** CEFIND (and the Pit Schedule, Checks and Project Review Show where do not use it). No switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (carpark CEFIND entries at lines 5978-5996 are about the drawing being marked changed). **Status:** NEW, **BUG-1003**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** CeFindQuery.Parse("P1A") must return Kind PitId and Parse("P1A-P2") must return PipeEndpoints; currently both Unrecognised.

201. **F-201. Design says "Nothing has changed since the design was agreed" after the orifice head or the detention answer was changed and saved**
   - **Severity:** MEDIUM. **Area:** Civil engineering numbers. **Source:** CODEX_SWEEP_S07 S07-03. **Installed:** Civil 3.0.70.
   - **For Tim:** Agree the design with a 0.45 m orifice head, later change it to 0.60 m and Save Draft: reopening CDDESIGN still shows "Nothing has changed since the design was agreed."
   - **Where:** AgreedDesignRules.cs:67-83, :219-233; Models/AgreedDesignSnapshot.cs; ViewModels/CivilDesignWindowViewModel.cs:141-164, :515-520, :562-585. **Command:** CDDESIGN (During). No switch found
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (PR #1549 changes the soft C display only; F-072 is the soft C value). **Status:** NEW, **BUG-1004**. **Fix kind:** code (add head and detention to the snapshot and the During list). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Agreed snapshot head 0.45 vs current head 0.60 (all else equal): Compare returns one change and IsUnchanged is false; currently zero changes and true.

202. **F-202. CDRENUMBER can give the main-line numbers to the shorter branch**
   - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S08 S08-03. **Installed:** Civil 3.0.70.
   - **For Tim:** CDRENUMBER numbers a short 20 m side run before a 100 m run feeding the same pit, so the "longest main line first" numbering comes out wrong.
   - **Where:** PitRenumberPlanner.cs:97-143; Rules/PitRenumberNetworkBuilder.cs:121-129; Commands/PitRenumberCommand.cs:69-104. **Command:** CDRENUMBER. No switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** NEW, **BUG-1005**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Planner unit test with edges P10<-P11 (100 m), P10<-P12 (10 m), P12<-P13 (10 m): expected order P10, P11, P12, P13; currently P10, P12, P13, P11.

203. **F-203. A rule warning on pipe speed advises changing the pipe size the wrong way**
   - **Severity:** MEDIUM. **Area:** Civil engineering numbers. **Source:** CODEX_SWEEP_S08 S08-04. **Installed:** Civil 3.0.70.
   - **For Tim:** When CDRULES warns that a pipe is too slow it tells you to reduce the pipe size, which makes it slower; when too fast it says increase the size, which makes it faster.
   - **Where:** Rules/RuleFixAdvisor.cs:78-87; Rules/RulebookEngine.cs:415-438; Rules/RuleExplainer.cs:27-37. **Command:** CDRULES (Explain), CDCHECKS rows; no switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (PR #1534 wording and #1530 real length do not touch these two lines). **Status:** NEW, **BUG-1006**. **Fix kind:** wording (needs Tim's word on the replacement advice, since it is engineering guidance). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** RuleFixAdvisor for an R-02 Warn finding returns an action that contains neither "reduce the pipe size" nor "increase the pipe size"; R-01 Warn likewise.

204. **F-204. CDRG closes the raingarden outline within 1 drawing unit (1 m in a metre drawing)**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S09 S09-03. **Installed:** Civil 3.0.70.
   - **For Tim:** In a drawing set to metres, drawing a raingarden 4 m long and 0.5 m wide, the fourth corner is treated as "back at the start", so the garden finishes as a triangle with half the area (1.0 m2 instead of 2.0 m2).
   - **Where:** SourceBlockInsertCommands.cs:495-507 (tolerance), :608 (completion line). **Command:** CDRG (no switch)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. Related only: BUG-771 and BUG-773 are other CDRG outline faults at different lines; BUG-4251 family (metre-unit drawings) is the same kind of cause, not the same defect.. **Status:** LOW, no carpark entry. **Fix kind:** code. **Protected:** no. **Lane:** none (no entry). **Test:** Empty metre drawing (INSUNITS=6), CDRG with points 0,0 / 4,0 / 4,0.5 / 0,0.5; expected 4 vertices and 2.0 m2 (today 3 vertices, 1.0 m2); control in mm with 0,0 / 4000,0 / 4000,500 / 0,500 gives 4 vertices and 2.0 m2.

205. **F-205. CDFALL treats a direction pick within 1 drawing unit as "no direction" and points east**
   - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Source:** CODEX_SWEEP_S09 S09-04. **Installed:** Civil 3.0.70.
   - **For Tim:** In a metre drawing, placing a fall arrow and picking the direction 0.5 m to the north gives an arrow pointing east, with no warning.
   - **Where:** FallCommand.cs:83-99. **Command:** CDFALL (no switch)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG-079 family is about flip/orientation of a valid angle; BUG-4251 family is metre-drawing units generally). **Status:** NEW, **BUG-1007**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Metre drawing (INSUNITS=6), CDFALL insertion 0,0, direction 0,0.5, ratio 80; expected log `FALL orientation: input=90.0` (today 0.0); mm control with direction 0,500 already gives 90.0.

206. **F-206. Pit Schedule REMARKS cell cannot be edited and Restore Cell does nothing on it**
   - **Severity:** MEDIUM. **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S10 S10-02. **Installed:** Civil 3.0.70.
   - **For Tim:** Double-click a Remarks cell in the Pit Schedule and you get "This cell cannot be edited" instead of a typing box.
   - **Where:** PitScheduleDialog.xaml.cs:328-364 and :180-184; PitScheduleViewModel.cs:133-136, :1054-1059. **Command:** PITSCHEDULE (no switch)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG_CARPARK line 1038 is about text typed into the DRAWN table, and the 14 Oct custom-remarks bug is about the CUSTOM REMARKS box losing characters; neither is this). **Status:** NEW, **BUG-1008**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Schedule with one current-drawing pit, double-click REMARKS cell, expect an edit box (today the status line reads "This cell cannot be edited."); unit form: `ResolveTemplateColumnProperty("REMARKS")` must return "Remarks".

207. **F-207. Clicking an Xref pit row in the Pit Schedule looks up the handle in the host drawing**
   - **Severity:** MEDIUM. **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S10 S10-03. **Installed:** Civil 3.0.70.
   - **For Tim:** Clicking pit P3 in a schedule built from an attached drainage drawing can zoom to and select some unrelated object in your current drawing, or print "P3 is not in this drawing" while P3 is plainly visible in the attached one.
   - **Where:** PitScheduleDialog.xaml.cs:246-265; CeZoomHighlightService.cs:69-124. **Command:** PITSCHEDULE with Source set to Drainage XREFs (switch is a window choice; default source is the current drawing, so this only happens after choosing Xrefs)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** NEW, **BUG-1009**. **Fix kind:** code (skip the zoom for external rows, or say it is unavailable; real Xref navigation would be larger and may need Tim's word). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Host drawing with an object whose handle equals an Xref pit's handle; click the Xref row; expected no selection of the host object (today it selects it); with no host object at that handle, expected no "not in this drawing" message for an Xref row.

208. **F-208. Idle time offered back on return includes minutes already counted**
   - **Severity:** MEDIUM. **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S10 S10-04. **Installed:** Civil 3.0.70.
   - **For Tim:** Walk away for 6 minutes, come back and click "Click to count that time": the job timer adds 11 minutes, not 6. If you ignore the offer, the first 5 minutes of the break are still counted.
   - **Where:** JobTimeTracker.cs:314-340, :367-374, :464-471; JobTimeSession.cs:202-212. **Command:** automatic job timer (no command); Settings idleTimeoutMinutes default 5
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG_CARPARK lines 9854-9886 are privacy/time-log file items, not this arithmetic). **Status:** NEW, **BUG-1010**. **Fix kind:** needs Tim's word (whether the first 5 minutes should count is a billing rule; the double count on accept is plainly wrong). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Session with threshold 300 s: tick 300 s, fire idle, return with IdleDuration 360 s, call RestoreIdleTime(360); expected TrackedSeconds 360 (today 660).

209. **F-209. A typed Depth never reaches its edit helper and is lost by Stop overriding**
   - **Severity:** MEDIUM. **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S11 S11-04. **Installed:** Civil 3.0.70.
   - **For Tim:** With Auto-calculate depth off, you type a depth in the Pit Schedule and it looks accepted, but the pit's levels do not change and Stop overriding then blanks the depth while saying your values stay.
   - **Where:** PitScheduleViewModel.Data.cs:1157-1179, :1270-1290, :1814-1850. **Command:** PITSCHEDULE, Auto-calculate depth unticked (default ticked)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG_CARPARK 1136 is the depth rule for SPS pits; the Depth cell wiring tests are helper-only). **Status:** NEW, **BUG-1011**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Linked unlocked pit, AutoCalculateDepth=false, raise `PropertyChanged` for Depth="2.00" through the subscribed row; expected OutletInvert (or InletInvert) changes per `PitScheduleDepthEditPlanner` (today unchanged).

210. **F-210. A schedule-only override on Lid type or Remarks still writes the pit record**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S11 S11-05. **Installed:** Civil 3.0.70.
   - **For Tim:** Turn on Row Override in the Pit Schedule, change a lid type, then Restore Cell: the cell goes back on screen but the pit's saved lid type is already the new one.
   - **Where:** PitScheduleViewModel.Data.cs:1301-1330; ProjectDataService.Mutations.cs:1339-1378. **Command:** PITSCHEDULE, Enable Row Override then edit LID TYPE or REMARKS (no switch)
   - **Check (Sonnet, 23 Oct):** VERIFIED (the code behaviour); whether it is wrong depends on a design ruling
   - **Existing BUG / PR:** none. **Status:** LOW, no carpark entry. **Fix kind:** needs Tim's word (the comments suggest lid and remarks are deliberately kept in the pit record; the window text says otherwise). **Protected:** no. **Lane:** none (no entry). **Test:** Pit with LidType "Class A Solid Lid", enable override, set row LidType "Class B Solid Lid" via the subscribed row; `GetPitByHandle(h).LidType` expected "Class A Solid Lid" while override is active (today "Class B Solid Lid").

211. **F-211. Long section misses the closing side of a closed boundary polyline**
   - **Severity:** MEDIUM. **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S11 S11-06. **Installed:** Civil 3.0.70.
   - **For Tim:** A pipe that crosses the last side of a closed property boundary (the side drawn from the final corner back to the first) gets no boundary mark on its long section.
   - **Where:** LongitudinalSectionViewModel.cs:1181-1223. **Command:** CDPROFILE (and the older long-section output)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. Same function as FB-20 / BUG-764 (marks measured on a straight line, not along a bent pipe), which does not mention closed polylines. Flag to the FB-20 builder: fix both in one pass.. **Status:** NEW, **BUG-1012**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Closed lightweight polyline (0,0),(10000,0),(10000,10000),(0,10000) on the boundary layer; segment list from `CollectBoundarySegments` expected 4 segments (today 3), and a pipe from (-5000,5000) to (5000,5000) expected one boundary mark at 5.00 m.

212. **F-212. A typed trench-grate cover level of 0.000 is treated as "not known"**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Civil engineering numbers. **Source:** CODEX_SWEEP_S12 S12-02. **Installed:** Civil 3.0.70.
   - **For Tim:** If you place a trench grate and deliberately type a cover level of 0, Edit Pipe's grade suggestion says the surface level is unknown and skips the cover check at that end.
   - **Where:** PitData.cs:72-94; SourceBlockInsertCommands.cs:754-789. **Command:** CDTG then Edit Pipe (double-click the pipe); also CDRULES, CDPROFILE and other readers of `KnownCoverLevelRl`
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. Related: BUG-432 created the placeholder rule and BUG-757 is about the old placeholder on the long section; neither covers a newly typed zero.. **Status:** LOW, no carpark entry. **Fix kind:** needs Tim's word (a record field such as a "cover entered" flag would be needed to tell old placeholders from typed zeros; legacy drawings must stay "unknown"). **Protected:** no. **Lane:** none (no entry). **Test:** `new PitData{PitType="TG",CoverLevel="0.000"}.KnownCoverLevelRl()` after a CDTG typed 0 expected 0.0 (today null); the legacy fixture with a blank-origin "0.000" must stay null.

213. **F-213. Agreed-design record does not hold the hard-ground runoff coefficient**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Civil engineering numbers. **Source:** CODEX_SWEEP_S12 S12-03. **Installed:** Civil 3.0.70.
   - **For Tim:** If the office hard-ground runoff setting is changed after a design was agreed, CDDESIGN's During page still says "Nothing has changed since the design was agreed" while the weighted runoff coefficient in the new answer differs (for example 0.66 versus 0.48).
   - **Where:** AgreedDesignSnapshot.cs:119-128; AgreedDesignRules.cs:106, :179, :206. **Command:** CDDESIGN (During page)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (HUNT2-C-06 in BUG_CARPARK 10037 put this value on the Settings page; it did not add it to the agreed record). **Status:** LOW, no carpark entry. **Fix kind:** code, plus an old-record rule (an agreement saved without the value must read "not recorded", never "unchanged"); a new record field means a schema addition. **Protected:** no. **Lane:** none (no entry). **Test:** Agreed snapshot with hard-ground C 0.9, current 0.6; `Compare` or `NotChecked` expected non-empty (today both empty so `IsUnchanged` is true).

214. **F-214. Saving the sheet list advances the "last scanned" time without scanning**
   - **Severity:** MEDIUM. **Area:** Structural. **Source:** CODEX_SWEEP_S13 S13-04. **Installed:** Structural 1.0.121.
   - **For Tim:** After a colleague adds a new sheet layout to a drawing, clicking Save sheet list in the Sheets window makes it say the list matches the drawings, and the new layout is missing from the list and from issuing until you press a scan button.
   - **Where:** CeSheetsManifestService.cs:36-50 and :55-76; CeSheetsManagerWindow.xaml.cs:270-285, :486-497. **Command:** CESHEETS / CESHEETSCLASSIC (Sheets window and palette); no switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** NEW, **BUG-1013**. **Fix kind:** code (stamp the time only in the scan path, keep a separate saved-at time); Structural brief required, Codex may edit only on a Structural brief. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** Save a manifest scanned at T0, touch a tracked DWG at T1 > T0, call `Save` at T2 then `IsStale`; expected true (today false).

215. **F-215. Rotated UCS: schedule text turns, live schedule frame does not**
   - **Severity:** MEDIUM. **Area:** Structural. **Source:** CODEX_SWEEP_S14 S14-04. **Installed:** Structural 1.0.121.
   - **For Tim:** If you rotate the UCS 90 degrees and then insert the member schedule, the beam sizes turn with your UCS but the schedule box stays square to World, so the text no longer sits inside its box.
   - **Where:** Modules/Structural/Services/ExcelMTextService.cs:3640-3642, 3710, 3717, 4897-4898, 4975-4978. **Command:** XCLMTXT then Insert Selected (the static-frame fallback, CreateStaticScheduleFrame, does follow the UCS, but only runs when the block is missing or fails)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (F-055 is the same family for CEMEMBER, not this command). **Status:** NEW, **BUG-1014**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** Synthetic mm drawing with MEMBER SCHEDULE block, UCS Z 90, XCLMTXT Insert Selected at 0,0: frame BlockReference.Rotation must equal 90 degrees (today 0) and match the size MTEXT rotation.

216. **F-216. RIB (and REB) refused for no slab, but the line is already changed or drawn**
   - **Severity:** MEDIUM. **Area:** Structural. **Source:** CODEX_SWEEP_S14 S14-05. **Installed:** Structural 1.0.121.
   - **For Tim:** Pick an ordinary line for RIB on a drawing with no slab and CE says "No slab perimeter contains the selected point" but has already moved your line onto the SLAB INTERNAL BEAM layer (or left a new loose line if you clicked two points).
   - **Where:** Modules/Structural/Services/FoundationService.cs:1312-1351, 3816-3896. **Command:** RIB and REB (both pass requiresRaftHost: true, :1112 and :1115); THC likely the same shape at :1103
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** NEW, **BUG-1015**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** Line (0,0)-(3000,0) on layer AUDIT-CENTRELINE, no slab: RIB / 1 / 300 / 0, pick the line; after the refusal the line's layer must still be AUDIT-CENTRELINE (today SLAB INTERNAL BEAM).

217. **F-217. Xref copy and paste drops "inverted" and "clip off"**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Structural. **Source:** CODEX_SWEEP_S14 S14-06. **Installed:** Structural 1.0.121.
   - **For Tim:** Copy an Xref that has its clip inverted (or switched off) and paste it into another drawing: you get a normal clip, so the Xref can show the opposite part, or a clip you had off comes back on.
   - **Where:** Modules/Structural/Services/NativeCopyPasteXrefService.cs:100, 289-295, 359-366. **Command:** CXREF then PXREF (LegacyPortCommands.cs:32-35)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG-618 is related, not the same: CXREF fails with eInvalidKey on a plain Xref). **Status:** LOW, no carpark entry. **Fix kind:** code. **Protected:** yes. **Lane:** none (no entry). **Test:** Source Xref with polygon clip and `SpatialFilter.Inverted = true`: after CXREF/PXREF into a clean drawing the pasted filter must report Inverted true (today false); same for `Definition.Enabled = false`.

218. **F-218. Saving edited checklist templates wipes pending suggestions**
   - **Severity:** MEDIUM. **Area:** Structural. **Source:** CODEX_SWEEP_S15 S15-04. **Installed:** Structural 1.0.121.
   - **For Tim:** If a colleague has sent a suggestion for the checklist and anyone then edits and saves the checklist templates, the waiting suggestion is silently deleted and the review window says there are none.
   - **Where:** Modules/Structural/Core/Checklist/TemplateManager.cs:1290-1316. **Command:** CECHECKLIST, Select Template, Edit Templates, OK
   - **Check (Sonnet, 23 Oct):** VERIFIED (one correction to the reviewer's test: the save only runs after the user clicks Edit Templates and accepts, not on a plain Apply)
   - **Existing BUG / PR:** none. **Status:** NEW, **BUG-1016**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** Temp Templates folder with `pending_changes.json` holding one suggestion plus two template files: call SaveAllTemplates(two templates); the pending file must still exist with one suggestion (today deleted).

219. **F-219. Manager buttons type their command name into a command that is already running**
   - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Source:** CODEX_SWEEP_S16 F1 + Opus Manager review B3. **Installed:** Civil 3.0.70 / Manager 1.1.70 (Manager)..
   - **For Tim:** If you start LINE or TEXT, leave CE Manager open beside the drawing and click Open Repair (or click a block in the CE Blocks palette), AutoCAD gets the word "CDREPAIR" (or "CEBLOCKINSERT") as the answer to its current question, so the point is rejected, or at a "Enter text:" prompt the word is written into your text.
   - **Where:** PluginManagerWindow.xaml.cs:534-540 (BtnOpenRepair_Click) and :894-901 (SendCommand); same helper also serves PluginManagerWindow.xaml.cs:515 (hub button), PluginManagerWindow.Help.cs:102 and :241 (help, CESUPPORT); fallback senders PluginManagerWindow.Help.cs:368 and PluginManagerWindow.Settings.cs:590; CeBlocksPaletteService.cs:46. CePluginRegistryService.cs:320 (NETLOAD for Load Now) is the same shape.. **Command:** CEMANAGER window (Open Repair, hub, help, settings, Load Now buttons); CEBLOCKS palette tiles. No switch; always on.
   - **Check (Sonnet, 23 Oct):** VERIFIED. Two halves. (a) Open Repair and the other Manager launch buttons are NOT covered by Opus B3 (separate defect). (b) The CE Blocks tile half IS Opus review item B3 (same line, same defect); PR #1535 did not fix the palette.
   - **Existing BUG / PR:** CE Blocks half = Opus review item B3 (REVIEW_CEMEMBER_AND_MANAGER_2026-10-23.md). Open Repair half = none (not in BUG_CARPARK, FB-01..25 or F-001..F-151; BUG-828 is the ribbon-only fix of the same family). Matched by grep for CEBLOCKINSERT, BuildSendString, SendCommand, Open Repair.. **Status:** NEW, **BUG-1017**. **Fix kind:** code (one shared Manager dispatcher that calls `RibbonBuilder.BuildSendString(cmd, !string.IsNullOrEmpty(doc.CommandInProgress))`); tests needed: string-builder test per call site.. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** fixture = open drawing, Manager loaded; Run `_.-TEXT`, `0,0`, `2.5`, `0`, then at "Enter text:" click Open Repair; expected = no TEXT entity with string CDREPAIR and Repair window opens. Unit form: the helper returns "\u0003\u0003CDREPAIR\n" when CommandInProgress is non-empty.

220. **F-220. one unreadable palette file removes every CE Blocks tab**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Release, installer and Manager. **Source:** CODEX_SWEEP_S16 F2. **Installed:** Manager 1.1.70..
   - **For Tim:** If STEEL.xtp (or any one of the twelve office palette files) is missing or still syncing from OneDrive, typing CEBLOCKS prints "CE Blocks palette files are unavailable" and no palette opens, so you lose the Civil blocks as well as the steel ones.
   - **Where:** CeBlocksCatalog.cs:39-50; CeBlocksPaletteService.cs:23-27. **Command:** CEBLOCKS (and the ribbon CE Blocks button). No switch; always on.
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grep of carpark for "palette files are unavailable", ".xtp"; ledger and FB lists had no match).. **Status:** LOW, no carpark entry. **Fix kind:** code (read each file inside its own try/catch, keep healthy groups, name the bad group in a warning). **Protected:** no. **Lane:** none (no entry). **Test:** fixture = 12 minimal .xtp files in a temp folder, STEEL.xtp renamed away; `CeBlocksCatalog.Read(folder)` expected = 11 groups returned (Civil present) and a recorded warning naming STEEL, instead of an exception.

221. **F-221. New job drawing puts the paper size where the drawing number belongs**
   - **Severity:** LOW. **Area:** Civil records, schedules and sheets. **Source:** CODEX_SWEEP_S16 F3. **Installed:** Civil 3.0.70 (CE_SHARED + Drainage), Manager 1.1.70 carries same CE_SHARED..
   - **For Tim:** In a job holding "99-001 Civil C01.dwg" and "C02.dwg", New job drawing says it learned the naming from your two drawings but suggests "99-001 Civil A3.dwg" (the paper size), and you must retype the C03.
   - **Where:** NewJobDrawingPlanBuilder.cs:105-106; JobDrawingNamingPatternService.cs:182-190, :294-295. **Command:** CDNEWDWG (registered on net10 / AutoCAD 2027 only); no switch.
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grep CDNEWDWG, SuggestFileName, NewJobDrawingPlan in carpark, ledger, FB: only an unrelated CommandTruth note at carpark line 3764).. **Status:** LOW, no carpark entry. **Fix kind:** code (do not pass paper size as the drawing code; leave the code slot blank/ask, or keep next-number out of scope) + strengthen the test. **Protected:** no. **Lane:** none (no entry). **Test:** fixture = existing names {"99-001 Civil C01.dwg","99-001 Civil C02.dwg"}, Build(..., "99-001","Civil","A3"); expected = SuggestedFileName does not contain "A3".

222. **F-222. Manager treats a Structural helper library as the Structural suite being loaded**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Release, installer and Manager. **Source:** CODEX_HUNT_COMPAT COMPAT-02. **Installed:** Manager 1.1.70 (Structural 1.0.121 supplies the helper name)..
   - **For Tim:** If only Structural's helper file is loaded and the main Structural program is not, CE Manager would show Structural as LOADED, hide Load Now, and CESTRUC would still say unknown command.
   - **Where:** CePluginRegistryService.cs:517-541; CePluginDescriptor.cs:173-199; PluginManagerWindowViewModel.cs:159,188. **Command:** CEMANAGER Status page. No switch.
   - **Check (Sonnet, 23 Oct):** PARTLY. The code fault is real and also present at the Structural ref: loaded-check is a name prefix match. What does not hold up is how a drafter reaches it: the helper (CE_STRUC_SUITE.DesignCore) is only pulled in lazily by the main Structural program, so the main file is normally loaded too whenever the helper is; the "helper only" state needs a manual NETLOAD of the helper or a diagnostic loader.
   - **Existing BUG / PR:** none (grep IsAssemblyLoaded, StartsWith(pluginId, helper librar in carpark, ledger, FB). Related, not same: COMPAT-01 (main loaded but startup failed) and MGR-STATUS-01 exact-match evidence code.. **Status:** LOW, no carpark entry. **Fix kind:** code (exact assembly name match, or require the main DLL name). **Protected:** no. **Lane:** none (no entry). **Test:** fixture = loaded-assembly-name list {"CE_SUITE_MANAGER","CE_STRUC_SUITE.DesignCore"}; ResolveStatus for pluginId "CE_STRUC_SUITE" expected = NotLoaded (today Loaded).

223. **F-223. the pipe-object enabler is judged missing once and never re-checked**
   - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Source:** CODEX_HUNT_COMPAT COMPAT-03. **Installed:** Civil 3.0.70..
   - **For Tim:** If CE's pipe-object file was not loaded the first time Civil asked for it, loading it later (ARX, Load) does not wake it up; CDPIPEOBJ keeps saying "needs the CE pipe object enabler" until you restart AutoCAD.
   - **Where:** CeCvlObjectsBridge.cs:83-99 (and :129, :200, :299 dependents). **Command:** CDPIPEOBJ, CDC7UPGRADE, pipe split, edit/grips on existing pipe objects. Behind PipeObjectUpgradeGate (colleague hold; options.pipeObjectUpgrade, held on colleague PCs by Tim's 26 Sep ruling), so colleagues do not reach CDPIPEOBJ at all; read paths (IsPipeObject, CanEdit) are not behind the gate.
   - **Check (Sonnet, 23 Oct):** VERIFIED for the code; UNPROVEN that ordinary startup order hits it (reviewer says the same).
   - **Existing BUG / PR:** none (grep CeCvlObjectsBridge, CE_CVL_OBJECTS_2027 in carpark; the two hits are about Disable on Restart and the installer .dbx owner check).. **Status:** NEW, **BUG-1018**. **Fix kind:** code (do not cache a negative result, or retry on command; keep API-version check). **Protected:** yes. **Lane:** Sonnet (protected file); base claude/rel-20261022m. **Test:** fixture = bridge with an injectable probe that throws DllNotFoundException then returns version 4; `IsAvailable` called twice expected = false then true (today false, false).

224. **F-224. CDCALC treats levels at or below RL 0.00 as "not set"**
   - **Severity:** MEDIUM. **Area:** Civil engineering numbers. **Source:** CODEX_HUNT_DESIGN DESIGN-02. **Installed:** Civil 3.0.70..
   - **For Tim:** On a job where the pipes sit below RL 0.00 (for example inverts of -1.000 and -1.100), CDCALC invents a top water level of 0.00, adds extra pit storage and a 1,100 mm baffle, and never warns when your typed water level is above the lid.
   - **Where:** DetentionSystemViewModel.cs:708-717, :818-825, :845, :1278-1296. **Command:** CDCALC > Detention system. No switch ("Use pit cover as TWL (suggested)" tick drives the invented value).
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. Same family (zero or negative level treated as missing) as carpark entries at lines 2274 (CDSURVEY drops RL below 0) and 2406 (level exactly 0), but a different command.. **Status:** NEW, **BUG-1019**. **Fix kind:** code (decide "known and finite" separately from sign). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** fixture = one selected pipe IL -1.000/-1.100, DN300; `ComputeSuggestedTwl` expected = -0.700 (today 0.00); with TWL -0.400 and pit cover -0.500, `TwlWarningText` expected = non-empty, 100 mm over.

225. **F-225. long-section pit depth ignores a lower side pipe and the recorded pit floor**
   - **Severity:** MEDIUM. **Area:** Civil records, schedules and sheets. **Source:** CODEX_HUNT_DESIGN DESIGN-03. **Installed:** Civil 3.0.70..
   - **For Tim:** On a long section A-B-C through pit B, if a third pipe leaves B lower than the through pipes (or the pit floor is recorded lower), the section still shows B at the route depth, for example 1.00 m deep, and draws the pit bar ending above that lower pipe.
   - **Where:** ProfileRouteReviewService.cs:403-444; ProfileRouteEvidenceCaptureService.cs:787-880; LongitudinalSectionService.cs:1242, :1364, :1773, :2035-2049. **Command:** CDPROFILE (long section), Review then Apply. Long-section office layout setting must list INVERT DEPTH for the text to show.
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. FB-22 / BUG-766 is the missing branch junction MARK, a different symptom; the report itself says so.. **Status:** NEW, **BUG-1020**. **Fix kind:** code, plus needs Tim's word on which rule wins when the recorded floor and the connected inverts disagree. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** fixture = A-B-C route inverts through B 10.020/10.000, side pipe B-D invert 9.500, B cover 11.000; resolved B depth expected = 1.50 m or an "unresolved depth" warning (today 1.00).

226. **F-226. CDTWL forgets a pit's lid level when that pit's floor or size is missing**
   - **Severity:** MEDIUM. **Area:** Civil engineering numbers. **Source:** CODEX_HUNT_DESIGN DESIGN-04. **Installed:** Civil 3.0.70..
   - **For Tim:** A pit whose cover is known (RL 10.200) but whose floor is unknown is dropped from CDTWL's lid check, so CDTWL reports a higher pit (RL 12.000) as the lowest lid and does not warn that your chosen water level (RL 10.500) is above the low lid.
   - **Where:** DetentionBranchCollector.cs:175-215; TopWaterLevelCandidates.cs:224; DetentionTwlSolver.cs:142; DetentionTwlService.cs:303. **Command:** CDTWL. No switch.
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (HUNT2-C-12..15 at carpark line 10089 cover pit-centre storage, freeboard setting names, CDDESIGN wording, LandXML units; not this).. **Status:** NEW, **BUG-1021**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** fixture = branch with pit LOW cover 10.200, floor blank, no connected invert, plus pit P1 cover 12.000; `LowestCoverLevel` of all pits expected = 10.200 (today 12.000).

227. **F-227. Exact cover and depth limits can be flagged by rounding noise**
   - **Severity:** LOW. **Area:** Civil engineering numbers. **Source:** CODEX_HUNT_DESIGN DESIGN-05. **Installed:** Civil 3.0.70.
   - **For Tim:** A pipe with exactly 300 mm cover or a pit exactly 900 mm deep can be flagged because of tiny rounding in the arithmetic.
   - **Where:** Modules/Drainage/Rules/RulebookEngine.cs:466-470, 666-670. **Command:** CDRULES, CDCHECKS
   - **Check (Sonnet, 23 Oct):** VERIFIED (RulebookEngine.cs:466-470 and :666-670 compare without a tolerance; PitDropRule.cs:155 has one)
   - **Existing BUG / PR:** none. **Status:** LOW, no carpark entry. **Fix kind:** code. **Protected:** no. **Lane:** none (no entry). **Test:** cover 10.700, IL 10.100, DN300: R-04 Pass at 300 mm.

228. **F-228. recovered pit handle is not carried into its schedule override and row order**
   - **Severity:** MEDIUM. **Area:** Civil records, schedules and sheets. **Source:** CODEX_HUNT_RECORDS R-05. **Installed:** Civil 3.0.70..
   - **For Tim:** If a pit block gets a new internal handle (for example after a copy or re-insert) CE says it re-found the pit, but the typed override in the Pit Schedule (say Cover 11.25) and the pit's saved place in the list are left on the old handle, so the schedule shows the drawing value (10.00) and the override sits as "lost source pit".
   - **Where:** ProjectDataService.cs:398-480; ProjectDataService.Recovery.cs:603-650; PitScheduleViewModel.Data.cs:267, :499, :923; PitScheduleViewModel.Schedule.cs:478, :529, :651. **Command:** PITSCHEDULE, CDSYNC and any command that runs EnsureDrawingDataCurrent (runs on drawing load/change). No switch.
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grep ReconcileOrphanedHandlesByPosition, IsOrphaned, "lost their linked source pit" in carpark, ledger, FB).. **Status:** NEW, **BUG-1022**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** fixture = project with pit P1 handle H-old (unresolved) at (0,0), block with H-new, manual row SourcePitHandle=H-old IsLinkedOverride Cover 11.25; run Reconcile + Restore; expected = row.SourcePitHandle == H-new, IsOrphaned false, Cover 11.25.

229. **F-229. adding one pit throws away the saved Pit Schedule order**
   - **Severity:** MEDIUM. **Area:** Civil records, schedules and sheets. **Source:** CODEX_HUNT_RECORDS R-06. **Installed:** Civil 3.0.70..
   - **For Tim:** You put P2 above P1 in the Pit Schedule, add P3, reopen the schedule, and the list is back in P1, P2, P3 order.
   - **Where:** PitScheduleViewModel.Data.cs:904-940; PitScheduleRowOrder.cs:21. **Command:** PITSCHEDULE. Setting linking.scheduleRowOrderByPit default true (does not affect the stale test).
   - **Check (Sonnet, 23 Oct):** VERIFIED. It is the 90% rule added on purpose as the BUG-008 fix (carpark line 7680, FIXED 13 May, Tim confirmed), so changing it needs a decision, not just a bug fix.
   - **Existing BUG / PR:** not a duplicate of BUG-786 (carpark 1120, pit group split, fixed via PR #1422, which this code includes). Root is the BUG-008 90% rule (carpark 7680). Matched by grep ApplyPersistedSortOrder, LinkedRowSortOrder, 90%.. **Status:** NEW, **BUG-1023**. **Fix kind:** code, needs Tim's word (drop the cutoff and treat only unmatched keys as unknown, which reopens the BUG-008 symptom unless re-tested). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** fixture = saved map {P2:0,P1:1}, rows P1,P2,P3; Arrange expected order = P2,P1,P3 (today P1,P2,P3).

230. **F-230. CDSPINEUPGRADE Apply says "nothing to write" before it repairs missing project identities**
   - **Severity:** MEDIUM. **Area:** Civil records, schedules and sheets. **Source:** CODEX_HUNT_RECORDS R-07. **Installed:** Civil 3.0.70..
   - **For Tim:** After a record rebuild, your pits and pipes still carry their permanent IDs in the drawing but CE's project record has lost them; CDSPINEUPGRADE Apply prints "Every object already has its identity. Nothing to write." and leaves the two out of step.
   - **Where:** SpineUpgradeCommand.cs:67-123; LinkService.Spine.cs:74,89; ProjectDataService.Spine.cs:41,62. **Command:** CDSPINEUPGRADE (DryRun / Apply / Rollback). No switch.
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (grep SpineUpgrade, "Nothing to write", W26-26_C01 in carpark; spine in ledger/FB).. **Status:** NEW, **BUG-1024**. **Fix kind:** code (compare object keys with project rows, not just count new keys). **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** fixture = plan with only KeepExistingKey steps (NewKeyCount 0) and project rows with blank SpineKey; run RunUpgrade Apply; expected = project rows filled and message not "Nothing to write".

231. **F-231. CSREOBAR uses the drawing's model units for lengths drawn on a layout**
   - **Severity:** MEDIUM. **Area:** Structural. **Source:** CODEX_HUNT_STRUCTCMDS SC-03. **Installed:** Structural 1.0.121.
   - **For Tim:** In a drawing set to metres, a 100 mm bar drawn straight onto a millimetre layout sheet is labelled "100000" long in the note and the bar schedule, while the text and arrows look the right size.
   - **Where:** Modules/Structural/Services/ReoBarService.cs:138-142, 424, 490-491; Core/Rebar/ReoBarCore.cs:162-167. **Command:** CSREOBAR, CSBARSCHEDULE (refresh)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** NEW, **BUG-1025**. **Fix kind:** code. **Protected:** yes. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. **Test:** Layout in a drawing with INSUNITS 6, bar extent (20,20)-(120,20) in paper space: length must be 100 mm (today 100000); control in metre model space extent 0.1 gives 100 mm.

232. **F-232. CEHATCHCHANGE fails on a hatch that is not associative**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Structural. **Source:** CODEX_HUNT_STRUCTCMDS SC-04. **Installed:** Structural 1.0.121.
   - **For Tim:** Select an old hatch whose boundary link has been lost, pick a CE hatch preset and Apply: instead of changing it, CE reports a failure and puts it back, and if you picked several hatches together none of them change.
   - **Where:** Modules/Structural/Commands/HatchUpgradeCommands.cs:248-262, 513-539; HatchPersistencePolicy.cs:250-255. **Command:** CEHATCHCHANGE
   - **Check (Sonnet, 23 Oct):** VERIFIED (by reading; assumes a non-associative hatch reports Associative false and no boundary links, which is what those words mean)
   - **Existing BUG / PR:** none (BUG-619 is a different cause: eInvalidKey on a normal hatch). **Status:** LOW, no carpark entry. **Fix kind:** needs Tim's word (change non-associative hatches, or refuse them up front with a plain line). **Protected:** yes. **Lane:** none (no entry). **Test:** Native ANSI31 hatch with Associative false, preset Solid 10: either property changes and verification passes, or the command prints a plain "not linked, left as it was" line before touching anything.

233. **F-233. CEHATCHAUDIT Repair swaps an office hatch for the CE preset because it sits on a CE layer**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Structural. **Source:** CODEX_HUNT_STRUCTCMDS SC-05. **Installed:** Structural 1.0.121.
   - **For Tim:** If your office draws a different ground hatch on the CE HATCH EARTH layer, Hatch Audit Repair will turn it into CE's Earth hatch and then say custom hatches were left alone.
   - **Where:** Modules/Structural/Commands/HatchUpgradeCommands.cs:333-374, 413, 455. **Command:** CEHATCHAUDIT (Repair)
   - **Check (Sonnet, 23 Oct):** PARTLY (the mechanism is exactly as described; whether it is a defect is a design call, so the reviewer's "suspected" is right)
   - **Existing BUG / PR:** none (F-081 is related: Audit flags older LBH/LBUH hatches; BUG-748 related). **Status:** LOW, no carpark entry. **Fix kind:** needs Tim's word (is "wrong pattern on a CE layer" a repair or a leave-alone?); the closing wording is a wording fix either way. **Protected:** yes. **Lane:** none (no entry). **Test:** ANSI31 scale 8 angle 45 on HATCH EARTH, Report then Repair: record Custom/unmatched and the pattern name after Repair; expected value depends on Tim's ruling.

234. **F-234. Structural runtime diagnostics keep full drawing paths with no size or age limit**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Privacy and security. **Source:** CODEX_HUNT_PRIVACY H03. **Installed:** Structural 1.0.121.
   - **For Tim:** Every Structural command you run adds a line to a daily history file with the full drawing location (including your job folder name), and those daily files are never cleaned up.
   - **Where:** Modules/Structural/Services/RuntimeDiagnosticsService.cs:106, 858, 919, 1067-1090. **Command:** every tracked Structural command (default ON; setting DiagnosticsEnabled in Settings, VerboseDiagnosticsEnabled default OFF does not matter for command lines)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none (BUG_CARPARK mentions the file only as a settings-defaults note). **Status:** LOW, no carpark entry. **Fix kind:** code (a finite retention, and drawing name instead of full path); the retention length is a settings row. **Protected:** yes. **Lane:** none (no entry). **Test:** Seed runtime_20000101.jsonl and a 6 MiB today file, record one command, restart: old file removed or capped per the new rule, and the new line holds the file name only.

235. **F-235. Markup package ID ".." escapes the package folder**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Privacy and security. **Source:** CODEX_HUNT_PRIVACY H04. **Installed:** Structural 1.0.121.
   - **For Tim:** Opening a damaged or hand-edited saved markup review whose ID is ".." makes CE read and write its action list in the folder above the package folder, so a second such file can show actions that were never in it.
   - **Where:** Modules/Structural/Services/MarkupAIStorageService.cs:176-181, 284-289; MarkupAIWorkflowService.cs:108-113. **Command:** CEMARKUPLOAD (registry entry "Open Saved Markup Review")
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** LOW, no carpark entry. **Fix kind:** code (reject or regenerate a package ID that is not a plain name). **Protected:** yes. **Lane:** none (no entry). **Test:** JSON with PackageId ".." and no parent command-plans.json: after load, no file is created above the Packages folder and the loaded package ID is a safe generated one.

236. **F-236. Open Logs opens a folder with no CE log in it**
   - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Source:** Opus Manager review B1. **Installed:** Manager 1.1.70.
   - **For Tim:** Support asks a colleague to open the logs and send CE_CVL_SUITE.log; CEMANAGERLOGS opens %APPDATA%\CE_CADTOOLS, which holds no CE log, so the real log never arrives.
   - **Where:** Modules/Manager/Services/CeSupportBundleService.cs:218-229 (Civil log is in CE_CVL_SUITE\logs, LoggingService.cs:68-70). **Command:** CEMANAGERLOGS; CE Tools > Open Logs; Manager menu > Logs
   - **Check (Opus (earlier review), 23 Oct):** VERIFIED (Opus Manager review, code and disk; Opus PR review A confirms #1535 targets it)
   - **Existing BUG / PR:** none in carpark; fix drafted in PR #1535 (MERGE-WITH-FIXES). **Status:** NEW, **BUG-1026**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** type CEMANAGERLOGS: the new Explorer window path ends \AppData\Roaming\CE_CVL_SUITE\logs and contains CE_CVL_SUITE.log.

237. **F-237. The support zip leaves out the logs that matter for Structural and grips**
   - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Source:** Opus Manager review B2. **Installed:** Manager 1.1.70.
   - **For Tim:** After a CEMEMBER or grip problem the support zip holds only the short Structural log and no grip log, so the desk needs a second round trip for the file that shows what happened.
   - **Where:** Modules/Manager/Services/CeSupportBundleService.cs:29-54, 132-150; CeDiagnosticsService.cs:300-311. **Command:** CESUPPORT
   - **Check (Opus (earlier review), 23 Oct):** VERIFIED (Opus Manager review, code and disk)
   - **Existing BUG / PR:** none in carpark; fix drafted in PR #1535. **Status:** NEW, **BUG-1027**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** seed a temp profile with the four missing files: the zip has an entry for each, or WHAT_IS_IN_THIS_ZIP.txt names each as left out.

238. **F-238. Ribbon build failures and a broken switch file leave no trace**
   - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Source:** Opus Manager review B4. **Installed:** Manager 1.1.70.
   - **For Tim:** If the CE Tools tab never appears, nothing anywhere says why; a stray comma in manager-switches.json turns every Manager switch off with no message.
   - **Where:** Modules/Manager/Services/CeUnifiedRibbonService.cs:150-172; CeOneGlanceStatus.cs:219-222, 367-370; CeBlocksSettings.cs:72-104. **Command:** AutoCAD start-up (Manager ribbon build)
   - **Check (Opus (earlier review), 23 Oct):** VERIFIED (Opus Manager review)
   - **Existing BUG / PR:** none in carpark; fix drafted in PR #1535. **Status:** NEW, **BUG-1028**. **Fix kind:** code. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** a test ribbon contributor that throws leaves one line in crash_trace.log naming the tab; a broken switch file leaves a 'switch file is broken' line.

239. **F-239. CE Tools tab may be late when Manager starts before Civil and Structural**
   - **Severity:** LOW (source MEDIUM; check LOW). **Area:** Release, installer and Manager. **Source:** Opus Manager review B5. **Installed:** Manager 1.1.70 (Civil 3.0.70 registers).
   - **For Tim:** On a colleague's PC where CE Manager happens to load first, the CE Tools tab (CE Manager, Health, Support, Blocks, Move + Rotate) could be missing for the first half minute or longer after AutoCAD opens.
   - **Where:** Modules/Manager/Services/CeUnifiedRibbonService.cs:53-68; Modules/Manager/Plugin.cs:137-161. **Command:** no command; AutoCAD start-up (net8/net10 ribbon builds only)
   - **Check (Sonnet, 23 Oct):** PARTLY (the code path and the delay are real; whether Manager actually starts first on a colleague's PC is UNPROVEN)
   - **Existing BUG / PR:** none. **Status:** LOW, no carpark entry. **Fix kind:** code (have Register ask Manager to rebuild, or queue the build even with no contributors yet). **Protected:** no. **Lane:** none (no entry). **Test:** Unit: Initialize() with no contributors, then CeRibbonRegistry.Register(test contributor): a rebuild is queued (today not); AutoCAD load order stays UNPROVEN until a robot screenshot from launch.

240. **F-240. AutoCAD 2022 to 2024: the Manager menu lacks six CE tools**
   - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Source:** Opus Manager review B6. **Installed:** Manager 1.1.70 (Civil 3.0.70 for the second menu).
   - **For Tim:** A colleague on AutoCAD 2024 cannot find CE Health, Support Bundle, Version, Survey Review, CE Blocks, Move + Rotate or Copy + Rotate on any menu; they only work if typed.
   - **Where:** Modules/Manager/Assets/Config/ce_toolbar_layout.json; Modules/Manager/Services/CeUnifiedRibbonService.cs:27-43. **Command:** the old-style CE menu on AutoCAD 2022 to 2024 (net48)
   - **Check (Sonnet, 23 Oct):** VERIFIED (and extended: Civil's own older-AutoCAD menu layout lacks them too)
   - **Existing BUG / PR:** none. **Status:** NEW, **BUG-1029**. **Fix kind:** settings row (add entries to the layout file; the commands already exist and are in command-registry.json, which the menu service reads) -- confirm with Tim that a menu entry per tool is wanted. **Protected:** no. **Lane:** Codex or Sonnet; base claude/rel-20261022m. **Test:** Static: Manager's ce_toolbar_layout.json sourceCommand set contains CEHEALTH, CESUPPORT, CE_VERSION, CESURVEYREVIEW, CEBLOCKS, MR, CR (today none).

241. **F-241. Survey Review shows the old survey; its real errors are never logged**
   - **Severity:** LOW. **Area:** Release, installer and Manager. **Source:** Opus Manager review B7. **Installed:** Manager 1.1.70 (view is in Civil 3.0.70).
   - **For Tim:** If the survey review window cannot open you only get "could not be opened" with no reason recorded anywhere; a second survey does update an already open review.
   - **Where:** Modules/Manager/Services/CeCivilSurveyIntakeBridgeSession.cs:127-131, 171-175. **Command:** CESURVEYREVIEW (after CDSURVEY)
   - **Check (Sonnet, 23 Oct):** PARTLY (error-swallowing is VERIFIED; the "shows the old survey" half is FALSE)
   - **Existing BUG / PR:** none. **Status:** LOW, no carpark entry. **Note:** Half false: an open review does follow a new survey; only the swallowed error is real. **Fix kind:** code (log a scrubbed line). **Protected:** no. **Lane:** none (no entry). **Test:** Unit: a bridge factory that throws leaves one scrubbed line in crash_trace.log (today none).

242. **F-242. Move + Rotate and Copy + Rotate lose a pre-selection on the opt-in C# path**
   - **Severity:** LOW. **Area:** Civil commands, Undo and Checks. **Source:** Opus Manager review B8. **Installed:** Civil 3.0.70.
   - **For Tim:** With the C# Move + Rotate switch turned on (AutoCAD 2022 to 2026), selecting objects first and then typing MR still asks "Select objects" again.
   - **Where:** Modules/Drainage/Commands/CopyRotateCommands.cs:151, 200, 287-311. **Command:** MR, MOVEROT, CR, COPYROT, only when Options.UseNativeCopyRotate is ON (default OFF)
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** none. **Status:** LOW, no carpark entry. **Fix kind:** code. **Protected:** no. **Lane:** none (no entry). **Test:** AutoCAD 2026 test profile with the switch ON, three lines selected, MR: first prompt is MOVE's base point, not "Select objects".

243. **F-243. CE Blocks re-reads the office block drawing on every stamp**
   - **Severity:** LOW. **Area:** Release, installer and Manager. **Source:** Opus Manager review B9. **Installed:** Manager 1.1.70.
   - **For Tim:** Stamping 20 bollards with CE Blocks reads the office block library 20 times, so repeated clicks may feel slower than they should, and a library not yet downloaded from OneDrive could pause AutoCAD.
   - **Where:** Modules/Manager/Services/CeBlocksInsertService.cs:83, 99-110, 130-132. **Command:** CEBLOCKS tile then CEBLOCKINSERT stamp loop
   - **Check (Sonnet, 23 Oct):** PARTLY (the repeat read is VERIFIED; the slowdown and the OneDrive freeze are UNPROVEN, no timing)
   - **Existing BUG / PR:** none. **Status:** LOW, no carpark entry. **Fix kind:** code (read once per run); impact needs a timing check first. **Protected:** no. **Lane:** none (no entry). **Test:** Count ReadDwgFile calls across 10 typed points: expect 1 (today 10).

244. **F-244. Manager's assembly resolver serves any same-named DLL, ignores version, never removed**
   - **Severity:** LOW. **Area:** Release, installer and Manager. **Source:** Opus Manager review B10. **Installed:** Manager 1.1.70.
   - **For Tim:** If Civil and Manager ever carry two different CE_SHARED files, this lets Manager hand one tool the other's copy instead of stopping with a clear error.
   - **Where:** Modules/Manager/Plugin.cs:58-89. **Command:** none (AutoCAD plug-in load)
   - **Check (Sonnet, 23 Oct):** PARTLY (behaviour VERIFIED; harm UNPROVEN, only fires when a normal load already failed)
   - **Existing BUG / PR:** none (the BUG-522 case is the trigger, not the same finding). **Status:** LOW, no carpark entry. **Fix kind:** code. **Protected:** no. **Lane:** none (no entry). **Test:** Unit: handler called with "CE_SHARED, Version=99.0.0.0" returns null unless the versions match.

245. **F-245. "Starts with AutoCAD" rewrites the tool's start-up file in place**
   - **Severity:** LOW. **Area:** Release, installer and Manager. **Source:** Opus Manager review B11. **Installed:** Manager 1.1.70.
   - **For Tim:** If AutoCAD or Windows stops in the middle of switching a CE tool's "Starts with AutoCAD" setting, that tool's start-up file can be left half-written and the tool then fails to load.
   - **Where:** Modules/Manager/Services/CePluginRegistryService.cs:260-300. **Command:** CEMANAGER, the "Starts with AutoCAD" switch
   - **Check (Sonnet, 23 Oct):** VERIFIED
   - **Existing BUG / PR:** S2-007 / BUG-425 item (c) (same code, "rewrites the installed tool's own start-up file", then at lines 241-279); the part-written angle is new. **Status:** LOW, no carpark entry. **Note:** Partly BUG-425 item (c) / S2-007. **Fix kind:** code. **Protected:** no. **Lane:** none (no entry). **Test:** Unit: writer made to fail after 100 bytes leaves the original PackageContents.xml byte-identical.

246. **F-246. Diagnostics report goes to the shared office folder; CEMANAGERREFRESH uploads on AutoCAD's thread**
   - **Severity:** LOW. **Area:** Privacy and security. **Source:** Opus Manager review B12. **Installed:** Manager 1.1.70.
   - **For Tim:** Everyone who can open the office folder can read every PC's diagnostics report, and pressing Refresh in CE Manager waits on the office folder copy before AutoCAD responds.
   - **Where:** Modules/Manager/Services/CeDiagnosticsService.cs:300-311; Modules/Manager/Commands/PluginManagerCommands.cs:119-125. **Command:** CEMANAGERDIAG, CEMANAGER "Send a fault report", CEMANAGERREFRESH
   - **Check (Sonnet, 23 Oct):** VERIFIED (code); which of the two is wrong is Tim's call, as the reviewer says
   - **Existing BUG / PR:** partly BUG-488 (the same report's names; coded since) and BUG-552 (office-folder coded rule); the "who may read it" question and the on-thread upload are not in either. **Status:** LOW, no carpark entry. **Note:** Partly BUG-488 / BUG-552. **Fix kind:** needs Tim's word (where reports live); the on-thread upload is code. **Protected:** no. **Lane:** none (no entry). **Test:** CEMANAGERREFRESH with the office share replaced by a synthetic slow share must return in under 1 second (today waits for the copy).

---

## Part B: the first ledger's 151 findings, with today's status

Text as compiled at 00:18 (sources there), with a **23 Oct status** line added to each entry. Draft numbers "proposed BUG-8xx/9xx" have been removed; the real numbers are in the status line.

1. **F-001. The "Command outcome" log line calls a successful Esc-finished PIT, CD or DP "cancelled", and a CE refusal "completed".**
   - **Severity:** HIGH. **Area:** Civil commands, Undo and Checks. **Sources:** OPUS-A finding 1, CDX-C finding 6 (MEDIUM, suspected). **Installed:** Civil 3.0.70 (and Structural 1.0.121 shows three CEMEMBER records as "cancelled", suspected).
   - **For Tim:** the log (and the robot's evidence) says a pit placement that worked did not work.
   - **Where:** `Modules/Drainage/Services/CommandOutcomeLogService.cs:62-80, 184`. **BUG:** BUG-862. **PR:** #1523 (fix drafted). **Fix kind:** code. **Lane:** Sonnet fixer (in flight), then Opus review. **Test:** PIT, place one pit, Esc: the outcome line must not read plain "cancelled".
    - **23 Oct status:** FILED. **Severity:** HIGH (covered by the existing entry and its PR review). BUG-862; fix drafted in #1523 (Claude).

2. **F-002. CDCHECKIGNORE with its switch OFF saves the CE project record into the drawing before it checks the switch, then says "Nothing was changed".**
   - **Severity:** HIGH (Codex), MEDIUM (Opus). **Area:** Civil commands, Undo and Checks. **Sources:** OPUS-A 2, CDX-C 1. **Installed:** Civil 3.0.70 (switch OFF).
   - **For Tim:** the message is false: CE has just rewritten its record in the drawing, twice (seen in the log at 20:34:45).
   - **Where:** `Modules/Drainage/Commands/CheckIgnoreCommand.cs:35-38`; `CeCommandBase.cs:29,43`; `ProjectDataService.cs:249-254`. **BUG:** BUG-863. **PR:** #1525. **Fix kind:** code. **Lane:** Sonnet fixer (in flight). **Test:** switch OFF, `CDCHECKIGNORE`: no "Project data saved" log line and no `PROJECT_ACTIVE` marker added.
    - **23 Oct status:** FILED. **Severity:** HIGH (covered by the existing entry and its PR review). BUG-863; fixed by #1524 (Codex, Opus MERGE) and #1525 (Claude); keep one.

3. **F-003. Tidy labels (CDTIDYLABELS) takes the same writing start-up before its switch, selection, preview and Yes/No, so answering No or pressing Esc still writes to the drawing.**
   - **Severity:** HIGH. **Area:** Civil labels and Tidy labels. **Sources:** CDX-C 1 (second half). **Installed:** Civil 3.0.70 (the switch is OFF for Max).
   - **For Tim:** a "No" to moving labels can still leave the drawing changed.
   - **Where:** `Modules/Drainage/Commands/TidyLabelsCommand.cs:35`; `CeCommandBase.cs:29,43`. **BUG:** NEW (see 23 Oct status). **PR:** none (#1525 covers CDCHECKIGNORE only). **Fix kind:** code. **Lane:** Sonnet fixer (same pattern as #1525). **Test:** `CDTIDYLABELS`, All, No: no write event on the CE project Xrecords.
    - **23 Oct status:** NEW, **BUG-873**. **Severity:** MEDIUM (first rated HIGH) (re-checked today). Opus check: real, but the write is the active-drawing marker and a first-command record save, no label moves. **Lane:** Sonnet (protected file); base claude/rel-20261022m.

4. **F-004. Esc after an accepted CD placement throws away the deferred callout registration, so the pipe and its callout are not linked.**
   - **Severity:** HIGH. **Area:** Civil commands, Undo and Checks. **Sources:** HUNT-UNDO U-01. **Installed:** Civil 3.0.70.
   - **For Tim:** place a pipe with a callout label, press Esc for the next pipe, then erase the pipe: the label stays behind (or the arrow stays at the old position).
   - **Where:** `Services/LinkService.Reactors.cs:1420,1542,1557`; `LinkService.Registration.cs:978`; `Commands/CdCommand.cs:214,235,1196`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** CD with Callout, pipe placed, Esc; the pipe's PIPE_LINK attachment list must contain the MLeader handle.
    - **23 Oct status:** NEW, **BUG-874**. **Severity:** HIGH (re-checked today). Opus check: verified. **Lane:** Sonnet (protected file); base claude/rel-20261022m.

5. **F-005. An ignored Checks warning stays hidden after the design changes, because the remembered fingerprint leaves out the pit, the clearances and the actual/required layer.**
   - **Severity:** HIGH. **Area:** Civil commands, Undo and Checks. **Sources:** CDX-C 2. **Installed:** Civil 3.0.70 (switch OFF).
   - **For Tim:** a "pipe does not fit the pit" warning you accepted stays hidden after the pit is made smaller.
   - **Where:** `Commands/CheckIgnoreCommand.cs:121`; `Services/Checks/ChecksResult.cs:228-235,288-296`; `Services/Checks/IgnoredChecks.cs:198-263`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** ignore a fit row, change only the pit's clear X from 600 to 400: the row must return as "Asked again".
    - **23 Oct status:** NEW, **BUG-875**. **Severity:** MEDIUM (first rated HIGH) (re-checked today). Opus check: real; switch OFF by default; same root as BUG-802 (fix together). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

6. **F-006. CDRULES and CDCHECKS work grade and speed on the straight pit-centre distance, not the drawn route or the real length.**
   - **Severity:** HIGH. **Area:** Civil engineering. **Sources:** OPUS-E 1. **Installed:** Civil 3.0.70.
   - **For Tim:** a bent pipe labelled 1 in 240 is judged 1 in 170 and passes the 1 in 200 minimum; capacity reads 19 per cent high.
   - **Where:** `Rules/RulebookEngine.cs:77,88-89`; `Services/PipeGeometryHelper.cs:128-171`. **BUG:** BUG-867. **PR:** none yet (Codex cx_b07_real_length_c60 queued; brief `areas/CODEX_BUILD_ENG_REAL_LENGTH_22OCT.md`). **Fix kind:** code. **Lane:** Codex build. **Test:** P1 (0,0) to P2 (12000,12000), DN225, 10.000 to 9.900, route 24.0 m: R-03 must Warn "1:240".
    - **23 Oct status:** FILED. **Severity:** HIGH (covered by the existing entry and its PR review). BUG-867; fix in #1530 (MERGE-WITH-FIXES). Also CODEX_SWEEP_S08 S08-01.

7. **F-007. CDRUNSOLVE, the network redesign and size proposals treat every pipe as UPVC.**
   - **Severity:** HIGH. **Area:** Civil engineering. **Sources:** OPUS-E 2. **Installed:** Civil 3.0.70.
   - **For Tim:** on a concrete line the solver thinks the pipe carries about 23 per cent more than it does.
   - **Where:** `Services/NetworkDesignService.cs:286,520`; callers `RunSolveCommand.cs:143`, `AutoDesignOrchestrator.cs:212`, `NetworkRedesignSolverService.cs:23`, `ProposalApplyService.PlanBuilders.cs`. **BUG:** BUG-868. **PR:** none yet (cx_b08 queued). **Fix kind:** code. **Lane:** Codex build. **Test:** two-node network, Q 200 L/s, 20 m, material RCP: expect DN450 (or DN375 at 1 in 77 or steeper), not DN375 at 1 in 130.
    - **23 Oct status:** FILED. **Severity:** HIGH (covered by the existing entry and its PR review). BUG-868; #1537 on HOLD (final head never built; default OFF).

8. **F-008. CDDESIGN calls the office rainfall curve "about 7 to 9 per cent high"; on the two real Glen Eira sheets it reads 6 to 8 per cent LOW.**
   - **Severity:** HIGH. **Area:** Civil engineering. **Sources:** OPUS-E 3. **Installed:** Civil 3.0.70.
   - **For Tim:** storage is about 18 per cent short (job 24-115: 2.12 m3 against 2.58 m3 issued) while the note says safe side.
   - **Where:** `Rules/RainfallCurve.cs:241-247,27-31`; `Services/AutoDesignService.cs:185-188`. **BUG:** BUG-866 (second use of that number; renumber). **PR:** none. **Fix kind:** needs Tim's word (wording only for now). **Lane:** Sonnet fixer after Tim's yes. **Test:** `SizeBoyds` area 640.67, C 0.6718, PSD 5.87: SSR 2.123 m3 (plus or minus 0.005) and the note must not contain "high".
    - **23 Oct status:** FILED. **Severity:** HIGH (covered by the existing entry and its PR review). BUG-866 (Tim's word, question 1 for Monday).

9. **F-009. Replace deletes the old imported pit before checking whether the new one can be drawn (new cover text needs a locked layer).**
   - **Severity:** HIGH. **Area:** Civil imports. **Sources:** HUNT-IMPORT 1. **Installed:** Civil 3.0.70. **Related:** BUG-731, BUG-417.
   - **For Tim:** updating a pit with no cover level to CL 12.00 can make the pit disappear if 25TEXT is locked.
   - **Where:** `Services/XcivilImportService.cs:1921,1950` (X-Civil `:975,986`); `Services/XcivilImportReportService.cs:725-815`; `Rules/XcivilImportLockedLayers.cs:51`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** import old.xml (no elevRim), lock 25TEXT, Replace with new.xml: old P11 handles must survive and a warning must say it was kept.
    - **23 Oct status:** NEW, **BUG-876**. **Severity:** HIGH (re-checked today). Opus check: verified. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

10. **F-010. Choosing another file on the import review page then clicking Read source imports the previously read file.**
    - **Severity:** HIGH. **Area:** Civil imports. **Sources:** HUNT-IMPORT 2. **Installed:** Civil 3.0.70.
    - **For Tim:** you notice the wrong file, pick the right one, and the wrong one is drawn.
    - **Where:** `Commands/LinkCommands.ImportXcivil.cs:73,164-179,400-467`; `Dialogs/CivilImportWindow.xaml.cs:37,49,73`; `ViewModels/CivilImportWindowViewModel.cs:53,60`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** read A.xml, choose B.xml, click Read source: a review of B (P21) must appear and P11 must not be drawn.
    - **23 Oct status:** NEW, **BUG-877**. **Severity:** HIGH (re-checked today). Opus check: verified. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

11. **F-011. The single-level shortcut gives a pipe an invert the file explicitly names for another pipe.**
    - **Severity:** HIGH. **Area:** Civil imports. **Sources:** HUNT-IMPORT 3. **Installed:** Civil 3.0.70. **Related:** BUG-605.
    - **For Tim:** pipe B gets 9.75 m although the file says that level belongs to pipe A.
    - **Where:** `Helpers/LandXmlParser.cs:260,277,328`; `Services/XcivilPipeInsertionService.cs:325-503`; `XcivilImportService.cs:2065`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** named-invert fixture (A refers to P99): B's P31-end invert stays Unknown, log shows `no-level-names-this-pipe`.
    - **23 Oct status:** NEW, **BUG-878**. **Severity:** HIGH (re-checked today). Opus check: verified; live mainly for startRef files until FB-16 lands, then for every real file. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

12. **F-012. Hand-placement protection misses CE's own "Slide along pipe" and CDANNOTATIONEDIT moves and the pit cover text, so Tidy labels moves them again.**
    - **Severity:** HIGH. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F1. **Installed:** Civil 3.0.70 (Tidy labels switch OFF for Max).
    - **For Tim:** slide a label carefully beside other notes, run Tidy labels, and it moves again.
    - **Where:** `Services/LinkService.PipeAttachmentActions.cs:323-352`; `Commands/AnnotationEditCommand.cs:89,105`; `Services/ExternalMutationCommandPolicy.cs:14,51,82`; `Services/LinkService.TidyPitText.cs:87,100`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** slide L1 along the pipe, add clashing MTEXT, CDTIDYLABELS: L1 position unchanged and counted "placed by hand".
    - **23 Oct status:** NEW, **BUG-879**. **Severity:** MEDIUM (first rated HIGH) (re-checked today). Opus check: real; needs two default-OFF switches. **Lane:** Sonnet (protected file); base claude/rel-20261022m.

13. **F-013. CEMEMBER and SBEAM re-set the linetype of an existing 18HIDDEN or 9HIDDEN2 layer (the S-41 fix covered only renamed layers).**
    - **Severity:** HIGH (Codex), MEDIUM (Opus). **Area:** Structural. **Sources:** OPUS-A 3, CDX-S F1. **Installed:** Structural 1.0.121.
    - **For Tim:** one CEMEMBER run turns every dashed line on 18HIDDEN into HIDDEN across the drawing, with no message.
    - **Where:** `Services/CeMemberLineWriter.cs:86-92`; `Services/StructuralDetailService.cs:1902,1915,2017`. **BUG:** BUG-864. **PR:** fix drafted by the desk job, no open PR seen. **Fix kind:** code. **Lane:** Sonnet fixer (in flight). **Test:** make 18HIDDEN on Continuous, run CEMEMBER SI 310UB32: `-LAYER ?` must still list Continuous.
    - **23 Oct status:** FILED. **Severity:** HIGH (covered by the existing entry and its PR review). BUG-864; fix in #1529 (Claude).

14. **F-014. CEMEMBER draws the member and section 1,000 times too big in a metre drawing.**
    - **Severity:** HIGH (Codex), LOW (Opus). **Area:** Structural. **Sources:** OPUS-A 9, CDX-S F2. **Installed:** Structural 1.0.121.
    - **For Tim:** a 310UB32 section comes out 298 m deep; break overshoot and kink have the same fault.
    - **Where:** `Commands/CeMemberCommands.cs:79,128,191`; `Services/CeMemberSectionWriter.cs:102,116`; `Services/CeMemberLineWriter.cs:123`; `DesignCore/SteelSections/CeMemberCatalogue.cs:61`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** INSUNITS 6, CEMEMBER SE 310UB32: section 0.149 by 0.298 m.
    - **23 Oct status:** NEW, **BUG-880**. **Severity:** MEDIUM (first rated HIGH) (re-checked today). Opus check: real; metre Structural drawings are rare and a 1000x member is obvious. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

15. **F-015. Hatch repair puts the old 1:20 value back on a correct new hatch when DIMSCALE and LTSCALE disagree.**
    - **Severity:** HIGH. **Area:** Structural. **Sources:** CDX-S F4. **Installed:** Structural 1.0.121.
    - **For Tim:** a correct LBUH at 1:50 (scale 50) is "repaired" to 20 just because LTSCALE was changed to 1.
    - **Where:** `Commands/HatchUpgradeCommands.cs:343,380,413,576`; `Core/Units/DrawingScaleRule.cs:74`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** LBUH at DIMSCALE 50, LTSCALE 1, CEHATCHAUDIT Repair: pattern scale must stay 50.
    - **23 Oct status:** NEW, **BUG-881**. **Severity:** HIGH (re-checked today). Opus check: verified. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

16. **F-016. The installer needs Windows administrator rights.**
    - **Severity:** HIGH (Codex "BLOCKER"). **Area:** Release, installer and Manager. **Sources:** CDX-G 1. **Installed:** release branch, not an installed build. **Related:** BUG-483.
    - **For Tim:** Max is asked for an administrator login before the installer can help him.
    - **Where:** `Installer/app.manifest:7`; `Installer/CE_CVL_SUITE_Installer.csproj:13`; `Modules/Manager/Services/CePluginInstallerService.cs:45`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (gap plan: cut, hand install for the pilot). **Lane:** Opus design. **Test:** launch the final installer as a standard user: it installs both bundles into that user's folder without elevation.
    - **23 Oct status:** NEW, **BUG-882**. **Severity:** HIGH (re-checked today). Opus check: verified (requireAdministrator). Gap plan: hand install for 9 Nov. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

17. **F-017. There is no normal first-install route: double-clicking the installer installs nothing.**
    - **Severity:** HIGH (Codex "BLOCKER"). **Area:** Release, installer and Manager. **Sources:** CDX-G 2. **Installed:** release branch.
    - **For Tim:** the EXE alone does nothing for Max (usage exit 64; `--install` is retired).
    - **Where:** `Installer/Program.cs:13,21`; `Installer/CeInstallerApplication.cs:77,84,253`; `Modules/Manager/Services/CePluginInstallerService.cs:242`; `CeInstallWords.cs:12`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (hand install now). **Lane:** Opus design. **Test:** from a PC with no CE files, the documented route puts Civil and Manager at their expected versions.
    - **23 Oct status:** NEW, **BUG-883**. **Severity:** HIGH (re-checked today). Opus check: verified (exit 64, payload extraction inside #if false). Gap plan: hand install. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

18. **F-018. The shared approval file stores one PC's absolute folder paths, so another colleague's PC refuses the same approved update.**
    - **Severity:** HIGH (Codex "BLOCKER"). **Area:** Release, installer and Manager. **Sources:** CDX-G 3. **Installed:** Manager 1.1.70 code.
    - **For Tim:** an update approved on your PC points back at your user folder; Max is told it is outside the allowed folder.
    - **Where:** `Modules/Manager/Services/CeApprovedReleaseService.cs:46,107,108,122,751,761`; `CePluginInstallerService.cs:54`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (the gap plan puts it after 9 Nov). **Lane:** Codex build with Opus review. **Test:** approve under root A, copy to root B: `BuildAvailablePlugin` resolves B's package with hashes unchanged.
    - **23 Oct status:** NEW, **BUG-884**. **Severity:** HIGH (re-checked today). Opus check: verified. Gap plan: after 9 Nov. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

19. **F-019. Installer packaging rebuilds the files instead of sealing the accepted candidate (the "payload 85" failure).**
    - **Severity:** HIGH (Codex "BLOCKER"). **Area:** Release, installer and Manager. **Sources:** CDX-G 4. **Installed:** release branch.
    - **For Tim:** Max can get freshly rebuilt files that nobody tested.
    - **Where:** `Installer/build_installer.ps1:185,199,215,235,323,332`; `Installer/ReleaseAuthorityPackaging.cs:379,397`; `CE_CVL_SUITE_Installer.csproj:36,81`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (edit the existing script; no new script). **Lane:** Sonnet fixer with Opus review. **Test:** read the final EXE's embedded ZIP and compare every file's SHA-256 with the frozen candidate: zero missing, extra or changed.
    - **23 Oct status:** NEW, **BUG-885**. **Severity:** MEDIUM (first rated HIGH) (re-checked today). Opus check PARTLY: the EXE never unpacks that payload; the live risk is a hand install copying the script's freshly rebuilt bundle. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

20. **F-020. The older-than-approved refusal can be bypassed by an empty or stale `--approved-version=` argument; an unknown approval is silent.**
    - **Severity:** HIGH. **Area:** Release, installer and Manager. **Sources:** CDX-G 5. **Installed:** release branch. **Related:** BUG-834.
    - **For Tim:** a launcher can install an old signed build even though the office approves a newer one.
    - **Where:** `Installer/CeOfficeApproval.cs:25,30,74`; `Installer/SafeBundleInstaller.cs:268,803,815`. **BUG:** BUG-834 (partly). **PR:** #1492 (BUG-834 base check; does not close the argument bypass). **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** approval 3.0.70, stage 3.0.69, run with omitted, empty and `=3.0.68` flags: all must refuse.
    - **23 Oct status:** NEW, **BUG-886**. **Severity:** MEDIUM (first rated HIGH) (re-checked today). Opus check: verified; PR #1492 does not close it (already in the release). Residual of BUG-834. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

21. **F-021. Civil and Manager can be activated separately, so they can end up with different copies of CE_SHARED.**
    - **Severity:** HIGH. **Area:** Release, installer and Manager. **Sources:** CDX-G 6. **Installed:** release branch.
    - **For Tim:** installing only half a release can break the ribbon or commands, depending on load order.
    - **Where:** `Shared/CE_SHARED/CE_SHARED.csproj:15`; `Modules/Manager/CE_SUITE_MANAGER.csproj:179,207`; `Installer/SafeBundleInstaller.cs:252,281,442`; `CeApprovedReleaseService.cs:138`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Codex build. **Test:** old pair installed, then Civil-only activation of a release with different CE_SHARED: refused or completed as a pair.
    - **23 Oct status:** NEW, **BUG-887**. **Severity:** MEDIUM (first rated HIGH) (re-checked today). Opus check: real; only when one half is activated by hand. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

22. **F-022. Structural in the Civil release branch still claims CE_VERSION, which now belongs to Manager (conditional: only if someone ships Structural from this branch).**
    - **Severity:** HIGH (conditional). **Area:** Release, installer and Manager. **Sources:** CDX-G 7. **Installed:** not an installed build; Structural 1.0.121 is built from a different line.
    - **For Tim:** never build or ship Structural from the Civil branch.
    - **Where:** `Modules/Structural/Installer/PackageContents.xml:12,22`; `Commands/AdminCommands.cs:22`; `Modules/Manager/Commands/PluginManagerCommands.cs:30`. **BUG:** BUG-852. **PR:** #1503 (Structural half) and #1493 (Manager half). **Fix kind:** test only (manifest overlap guard) plus the existing PRs. **Lane:** Sonnet fixer. **Test:** compare all three manifests: command names must not overlap.
    - **23 Oct status:** FILED. **Severity:** HIGH (covered by the existing entry and its PR review). BUG-852; #1503 and #1493.

23. **F-023. A fresh PC's starting values may not match Tim's current behaviour switches.**
    - **Severity:** HIGH (release-evidence gap). **Area:** Release, installer and Manager. **Sources:** CDX-G 8. **Installed:** Civil 3.0.70, Manager 1.1.70.
    - **For Tim:** Max gets the program's defaults, not necessarily the switches you use every day.
    - **Where:** `Modules/Drainage/Services/SettingsService.cs:51,82,160,308,749`; `ViewModels/Shell/CeEditorShellStateStore.cs:40`; `Modules/Manager/Services/CeOneGlanceStatus.cs:254,271,335`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design (comparison), Sonnet for the export. **Test:** export Tim's behaviour values and compare with first-run effective values from an empty profile; list every difference.
    - **23 Oct status:** GATE, no carpark entry. **Severity:** HIGH (source-verified, not re-checked today). Release-evidence gate, not a code defect: compare a fresh profile with Tim's switches (memory: colleagues get Tim's exact setup). Goes to the gap plan, no carpark entry.

24. **F-024. If the installer is killed between retiring the old folder and placing the new one, CE can be gone on restart; there is no uninstall or restore command for a colleague.**
    - **Severity:** HIGH. **Area:** Release, installer and Manager. **Sources:** CDX-G 10. **Installed:** release branch.
    - **For Tim:** a power cut mid-install can leave Max with no CE.
    - **Where:** `Installer/SafeBundleInstaller.cs:314,334,340,351`; `Installer/CeInstallerApplication.cs:120,253`; `Modules/Manager/Services/CeOneGlanceStatus.cs:236`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code plus a written recovery procedure. **Lane:** Codex build with Opus review. **Test:** terminate the installer right after the live rename on a disposable PC; the recovery route restores a complete pair by hash.
    - **23 Oct status:** NEW, **BUG-888**. **Severity:** MEDIUM (first rated HIGH) (re-checked today). Opus check: real; recoverable by hand from the .retiring folder or the roll-back copy. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

25. **F-025. CE's signed-package check does not prove the company's Windows protection will allow the EXE or the native files.**
    - **Severity:** HIGH (environment gate). **Area:** Release, installer and Manager. **Sources:** CDX-G 12. **Installed:** release branch.
    - **For Tim:** the release can pass CE's own check and still be stopped by Max's IT policy.
    - **Where:** `Shared/CE.Release/OfficialReleaseGate.cs:724,829`; `Installer/CE_CVL_SUITE_Installer.csproj:9,33`; `Installer/build_installer.ps1:332`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (IT). **Lane:** Opus design. **Test:** corporate IT runs its normal publisher and Defender checks on the final download and records any refusal.
    - **23 Oct status:** GATE, no carpark entry. **Severity:** HIGH (source-verified, not re-checked today). Environment gate (company IT trust), not a code defect. Gap plan.

26. **F-026. Existing one-piece CE pipes from Tim's PC may not work on older AutoCAD years: the native grip and object files only cover 2027.**
    - **Severity:** HIGH (compatibility gate). **Area:** Release, installer and Manager. **Sources:** CDX-G 13. **Installed:** Civil 3.0.70.
    - **For Tim:** unknown until Max's AutoCAD year is recorded (gap plan question 7).
    - **Where:** `Installer/PackageContents.xml:18,78,138,199,207`; `Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeGate.cs:7,18,55`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** open a synthetic drawing with a native CE pipe in each promised year; inspect, edit, save, undo.
    - **23 Oct status:** GATE, no carpark entry. **Severity:** HIGH (source-verified, not re-checked today). Checked: the native grip and object files load only on R26 (2027) (Installer/PackageContents.xml:199, 207). Colleague PCs hold pipe objects by Tim's 26 Sep ruling. Gap plan question 7 (Max's AutoCAD year).

27. **F-027. REDO is sometimes lost after picking a pit (BUG-861); CE's "REDO safe" list was only measured in the headless console, never with a real selection.**
    - **Severity:** MEDIUM (suspected). **Area:** Civil commands, Undo and Checks. **Sources:** OPUS-A 4, CDX-C (trace only). **Installed:** Civil 3.0.70.
    - **For Tim:** a pick, then REDO, can answer "Nothing to redo" the first time.
    - **Where:** `Services/RedoWindowGuard.cs:10-17`; `CivilSelectionObserver.cs:99-220`; `InspectorPaletteService.cs:1120`. **BUG:** BUG-861. **PR:** none. **Fix kind:** test only (six-row REDO test names the step). **Lane:** Codex build (test). **Test:** LINE, U, pick P3 with the Inspector open, wait 12 s, REDO must say "Everything has been redone".
    - **23 Oct status:** FILED. **Severity:** MEDIUM (covered by the existing entry and its PR review). BUG-861; instrumentation in #1532.

28. **F-028. Every double-click on any attributed block scans every block in the drawing (and #1522 keeps the scan).**
    - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Sources:** OPUS-A (#1522 section). **Installed:** not in 3.0.70 (arrives with #1522).
    - **For Tim:** a survey drawing with thousands of point blocks lags on each double-click.
    - **Where:** branch `b04/bug-859-r2-pick-at-doubleclick` `TryFindBlockUnderDoubleClick`. **BUG:** BUG-865. **PR:** #1522. **Fix kind:** code (fix before #1522 ships). **Lane:** Sonnet fixer. **Test:** 5,000 attributed blocks: under 100 ms between the two log lines.
    - **23 Oct status:** FILED. **Severity:** MEDIUM (covered by the existing entry and its PR review). BUG-865; fix before #1522 ships.

29. **F-029. A finding that returns as "Asked again" cannot be ignored again directly.**
    - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Sources:** CDX-C 3. **Installed:** Civil 3.0.70 (switch OFF).
    - **For Tim:** the Checks window asks you to reconsider, but CDCHECKIGNORE does not offer it.
    - **Where:** `Commands/CheckIgnoreCommand.cs:86`; `Services/Checks/IgnoreFindingPicker.cs:18-27`; `IgnoredChecks.cs:151-158`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** ignore, change a fingerprinted field, CDCHECKIGNORE Ignore: the row is offered.
    - **23 Oct status:** NEW, **BUG-889**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

30. **F-030. Leader-out planning reserves room using a plain label that will not actually move, so a callout can land on it.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** CDX-C 4. **Installed:** Civil 3.0.70 (switch OFF).
    - **For Tim:** Tidy labels can move a callout onto a plain label and report a clear spot.
    - **Where:** `Services/LinkService.TextClashTidyUp.cs:426-437`; `Rules/TidyLeaderOutRule.cs:90-141`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** the `PlanWithLeaderOut` composition with labels A (0,0)-(100,100) and B: final moved boxes must not clash with held boxes.
    - **23 Oct status:** NEW, **BUG-890**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet (protected file); base claude/rel-20261022m.

31. **F-031. Tidy labels checks obstacles in model space even for a layout pipe, and its search margin does not grow with the leader-out distance.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** CDX-C 5. **Installed:** Civil 3.0.70 (Tidy labels OFF).
    - **For Tim:** a layout label can be moved because of model-space text, or run into text on its own sheet.
    - **Where:** `Commands/TidyLabelsCommand.cs:169-176`; `Services/LinkService.TextClashTidyUp.cs:28,425,579-747`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** model-only MTEXT at the same XY as a layout label: the label is not offered for movement.
    - **23 Oct status:** NEW, **BUG-891**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet (protected file); base claude/rel-20261022m.

32. **F-032. Clicking an Inspector problem count (Flat / backfall pipes, shallow pits and the rest) takes a write lock and a transaction even when the list is empty.**
    - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Sources:** HUNT-UNDO U-02. **Installed:** Civil 3.0.70.
    - **For Tim:** clicking a zero count can use up the next U or lose the line you were about to REDO.
    - **Where:** `Services/InspectorPaletteService.cs:271,2752-2796`; `Controls/InspectorPanelControl.xaml:573`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (return at once on an empty list, read-only for the rest). **Lane:** Sonnet fixer. **Test:** LINE, U, click the zero-count button, REDO: line comes back and no transaction is recorded.
    - **23 Oct status:** NEW, **BUG-892**. **Severity:** MEDIUM (re-checked today). Opus check: code path verified; the REDO loss itself is not yet seen in AutoCAD. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

33. **F-033. Window-first CD starts an empty next command, so cancelling that window costs a second U.**
    - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Sources:** HUNT-UNDO U-03. **Installed:** Civil 3.0.70.
    - **For Tim:** with "Pick the route first" OFF, after one pipe, Cancel on the next window then one U leaves the pipe.
    - **Where:** `Commands/CdCommand.cs:239,242`; `Services/PlacementContinuationService.cs:78-89`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** window-first CD, place one pipe, Cancel the next window, one U removes the pipe.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (first rated MEDIUM) (re-checked today). Opus check: real but only with the non-default window-first CD; one extra U, nothing lost. Same class as BUG-178.

34. **F-034. Tidy labels preview does not reserve earlier pipes' proposed moves, so Apply is a different plan from the preview.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F2. **Installed:** Civil 3.0.70 (OFF).
    - **For Tim:** "Will move 2", then Yes moves 1.
    - **Where:** `Commands/TidyLabelsCommand.cs:55,78,85`; `Services/LinkService.TextClashTidyUp.cs:159-709`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** two overlapping labels: preview count equals applied count.
    - **23 Oct status:** NEW, **BUG-893**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet (protected file); base claude/rel-20261022m.

35. **F-035. The pit-cover tidy preview checks a translated rectangle, but Apply also changes rotation and anchor, so the text can land on another note.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F3. **Installed:** Civil 3.0.70 (OFF).
    - **For Tim:** a rotated cover text is offered a clear corner, then turns and lands on a note.
    - **Where:** `Services/LinkService.TidyPitText.cs:84-120`; `Rules/PitTextTidyRule.cs:31,47`; `Services/LinkService.PitCoverText.cs:135-152`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** real MText extents after the write must not touch note B.
    - **23 Oct status:** NEW, **BUG-894**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet (protected file); base claude/rel-20261022m.

36. **F-036. On a layout sheet Tidy labels counts a cover text as moved although its writer always refuses it.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F4. **Installed:** Civil 3.0.70 (OFF).
    - **For Tim:** "Moved 1" and the text has not moved; the reason is only in the CE log.
    - **Where:** `Services/LinkService.TidyPitText.cs:39-116`; `Services/LinkService.PitCoverText.cs:118`; `Commands/TidyLabelsCommand.cs:104`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (wording and counts). **Lane:** Sonnet fixer. **Test:** layout fixture: "Moved" equals real moves and a plain line says why one was left.
    - **23 Oct status:** NEW, **BUG-895**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet (protected file); base claude/rel-20261022m.

37. **F-037. Tidy labels gives up on a pipe at 1,001 nearby text objects and says CE could not read it.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F5. **Installed:** Civil 3.0.70 (OFF).
    - **For Tim:** a crowded drawing leaves an easy clash untouched and says "No CE label needs to move".
    - **Where:** `Services/LinkService.TextClashTidyUp.cs:33,197-203,685,700`; `Rules/TidyLabelsSummaryRule.cs:39`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** 2,000 close text objects: L1 is offered its clear move or an honest bounded-work line.
    - **23 Oct status:** NEW, **BUG-896**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet (protected file); base claude/rel-20261022m.

38. **F-038. A very small slide-step Setting makes Tidy labels enumerate hundreds of thousands of candidates before the preview.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F6. **Installed:** Civil 3.0.70 (OFF).
    - **For Tim:** type 0.001 into Label slide step and AutoCAD seems to hang.
    - **Where:** `ViewModels/AdvancedSettingsViewModel.cs:1489,1648`; `Services/LinkService.TextClashTidyUp.cs:506,558`; `Rules/LabelPlacementRule.cs:65-97`; `Rules/TidyLeaderOutRule.cs:100,111`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (a work budget, no hard block). **Lane:** Sonnet fixer. **Test:** step 0.001: candidate count stays under the budget.
    - **23 Oct status:** NEW, **BUG-897**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet (protected file); base claude/rel-20261022m.

39. **F-039. The import results page lists a skipped pit as "Recorded" and can call a zero-placement import complete.**
    - **Severity:** MEDIUM. **Area:** Civil imports. **Sources:** HUNT-IMPORT 4. **Installed:** Civil 3.0.70.
    - **For Tim:** the command line says the pit was not drawn, the window says Recorded.
    - **Where:** `Commands/LinkCommands.ImportXcivil.cs:219-229,508-518`; `Services/XcivilImportService.cs:1950,2082`; `Services/LandXmlImportReview.cs:107`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** lock STORMWATER PIT, import one pit: the window lists it "Not drawn", not Recorded.
    - **23 Oct status:** NEW, **BUG-898**. **Severity:** MEDIUM (re-checked today). Opus check: verified. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

40. **F-040. LandXML Replace measures the old import to decide the new position, then deletes it, so the replacement can land somewhere else.**
    - **Severity:** MEDIUM. **Area:** Civil imports. **Sources:** HUNT-IMPORT 5. **Installed:** Civil 3.0.70. **Related:** BUG-068.
    - **For Tim:** the same XML lands in different places depending on where the previous import sat.
    - **Where:** `Services/XcivilImportService.cs:1879,1921` (compare the correct X-Civil caller at `:694`); `XcivilPitInsertionService.cs:806-878`; `XcivilImportReportService.cs:604`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (one missing argument). **Lane:** Sonnet fixer. **Test:** clean target A and target B-with-old-import give the same new insertion points within 0.01 mm.
    - **23 Oct status:** NEW, **BUG-899**. **Severity:** MEDIUM (re-checked today). Opus check: verified. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

41. **F-041. A PDF schedule spanning several pages is reduced to one page.**
    - **Severity:** MEDIUM. **Area:** Civil imports. **Sources:** HUNT-IMPORT 6. **Installed:** Civil 3.0.70. **Related:** BUG-781, BUG-804.
    - **For Tim:** pits on the continuation sheet lose their size and levels.
    - **Where:** `Modules/tools/Extract-XcivilPdfSchedule.ps1:480,485,538,685,819`; `Services/XcivilScheduleService.cs:308-361`; `XcivilImportService.cs:733`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Codex build. **Test:** two-page PDF, P11 on page 1 and P12 on page 2: both rows come back.
    - **23 Oct status:** NEW, **BUG-900**. **Severity:** MEDIUM (re-checked today). Opus check: verified. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

42. **F-042. Cover is measured to the inside top of the pipe; the wall thickness is ignored.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 4. **Installed:** Civil 3.0.70.
    - **For Tim:** a concrete 375 showing 320 mm cover really has about 275 mm, below 300.
    - **Where:** `Rules/RulebookEngine.cs:466`; `Services/PipeSizingSolver.cs:387-388`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (after 9 Nov). **Lane:** Opus design then Sonnet. **Test:** RCP 375, cover 11.000, IL 10.305, wall table 45: Warn "cover 275 mm".
    - **23 Oct status:** NEW, **BUG-901**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word (after 9 Nov). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

43. **F-043. Cover is checked only at the two pits, against the lid level, with one figure for every surface.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 5. **Installed:** Civil 3.0.70.
    - **For Tim:** a pipe under a lower garden bed between two raised lids is never checked there.
    - **Where:** `Rules/RulebookEngine.cs:444-474`; `Services/PipeSizingSolver.cs:353-371`; `Models/UserSettings.cs:1736`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (after 9 Nov). **Lane:** Opus design. **Test:** spot levels at 0, 5, 10 m (11.00, 10.65, 10.90): Warn at 5 m, 150 mm.
    - **23 Oct status:** NEW, **BUG-902**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word (after 9 Nov). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

44. **F-044. Moving a pit with a held grade rounds the bottom level to the nearest step, so the pipe can come out flatter than the held grade.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 6. **Installed:** Civil 3.0.70.
    - **For Tim:** a 1 in 100 pipe reads 1 in 102 after a pit move; CD itself writes 1 in 96.
    - **Where:** `Services/LinkService.Utilities.cs:2293-2309`; compare `Helpers/MathHelper.cs:296-323`. **BUG:** BUG-870. **PR:** none yet (cx_b10 queued). **Fix kind:** code. **Lane:** Codex build. **Test:** `ComputeGradeLockLevels(10.00, 9.90, "10.00", "9.90", 15.30, 100, 2, ...)` gives newTo "9.84".
    - **23 Oct status:** FILED. **Severity:** MEDIUM (covered by the existing entry and its PR review). BUG-870; #1551 HOLD (protected wiring needs a Claude builder; review says default ON).

45. **F-045. Different screens judge the same pipe against different minimum grades and covers.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 7. **Installed:** Civil 3.0.70.
    - **For Tim:** the Inspector says OK and CDRULES says Warn on the same DN100 at 1 in 150.
    - **Where:** `Services/DesignValidationService.cs:350`; `Models/UserSettings.cs:1718,1920-1924`; `Rules/RulebookValues.cs:337-358`; `Services/MinimumCoverForChecks.cs:18-30`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (confirm the ladder). **Lane:** Sonnet fixer after the ruling. **Test:** DN100, 15 m, 10.10/10.00: Inspector and R-03 give the same verdict.
    - **23 Oct status:** NEW, **BUG-903**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word (the grade ladder). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

46. **F-046. The Pit Schedule measures depth to the outlet pipe, not the pit floor (Tim's 20 Oct ruling).**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 8. **Installed:** Civil 3.0.70.
    - **For Tim:** schedule says 0.85 m (no step irons), CDRULES says 950 mm (step irons).
    - **Where:** `Rules/PitScheduleDepthRule.cs:32-47`; compare `Rules/RulebookEngine.cs:660-701`. **BUG:** BUG-869. **PR:** none yet (cx_b09 queued). **Fix kind:** code. **Lane:** Codex build. **Test:** `DepthText(false, "11.00", "10.20", "10.15")` with floor 10.05 gives "0.95".
    - **23 Oct status:** FILED. **Severity:** MEDIUM (covered by the existing entry and its PR review). BUG-869; #1531 MERGE-WITH-FIXES (pump pits with no floor lose two rules when ON).

47. **F-047. CDTWL counts some water twice (pipe ends inside pits) and counts water below the orifice that never drains.**
    - **Severity:** MEDIUM (suspected). **Area:** Civil engineering. **Sources:** OPUS-E 9. **Installed:** Civil 3.0.70.
    - **For Tim:** the system holds about 100 L less than CDTWL says, so the top water level comes out low (about 4 per cent on 2,576 L).
    - **Where:** `Rules/DetentionBranchCollector.cs:323-339`; `Rules/DetentionStorageMath.cs:106-125`; `Models/UserSettings.cs:2221-2222`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** orifice pit with 150 mm sump: live storage excludes 54 L and counts 9.4 m of pipe.
    - **23 Oct status:** UNPROVEN, no carpark entry. **Severity:** MEDIUM (source-verified, not re-checked today). Suspected only (OPUS-E 9); needs Tim's rule on wall-to-wall pipe length and dead storage. Question, not a carpark entry.

48. **F-048. CDTWL ignores the drawing's units when it measures pipes.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 10. **Installed:** Civil 3.0.70.
    - **For Tim:** on a metre drawing a full 20 m DN300 pipe holds 1.4 L in CDTWL instead of 1,414 L.
    - **Where:** `Rules/DetentionBranchCollector.cs:323-330`; compare `Services/PipeGeometryHelper.cs:128-153`. **BUG:** BUG-871. **PR:** none yet (cx_b11 queued). **Fix kind:** code. **Lane:** Codex build. **Test:** pits at (0,0) and (20,0), `PositionInsunits` 6, DN300: about 1,414 L.
    - **23 Oct status:** FILED. **Severity:** MEDIUM (covered by the existing entry and its PR review). BUG-871; #1538 MERGE-WITH-FIXES (flip default to ON).

49. **F-049. The storm sweep is too coarse near the peak and says nothing when the worst storm is the first one.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 11. **Installed:** Civil 3.0.70.
    - **For Tim:** CDDESIGN can under-size storage by 2 to 3 per cent (job 24-115: 1.688 m3 at 5 min, 1.734 m3 at 7 min).
    - **Where:** `Services/DetentionSizingService.cs:66-67,156-159`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** area 640.67, C 0.6511, PSD 6.54: SSR at least 1.73 m3 or a note.
    - **23 Oct status:** NEW, **BUG-904**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

50. **F-050. CDCALC's Boyd's tab and CDDESIGN use different hard-ground C, so one job gets two storage figures.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 12. **Installed:** Civil 3.0.70.
    - **For Tim:** job 24-115 gives 2.58, 3.11 and 1.69 m3 depending on the screen.
    - **Where:** `ViewModels/BoydsCalcViewModel.cs:233-237`; `Services/AutoDesignService.cs:62-69`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** same inputs through both give equal SSR.
    - **23 Oct status:** NEW, **BUG-905**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

51. **F-051. R-30 (council detention-pipe grade) still judges pipes that R-06 says cannot be told from downpipes.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 13. **Installed:** Civil 3.0.70. **Related:** BUG-815, BUG-854.
    - **For Tim:** a 100 mm downpipe left marked Detention gets a council warning while R-06 says "not judged".
    - **Where:** `Rules/RulebookEngine.cs:95-106,479-497`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** Manningham DN100 downpipe, Detention ticked, no length: R-30 is Unknown.
    - **23 Oct status:** NEW, **BUG-906**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

52. **F-052. The pit drop check compares inverts only, so a pipe getting bigger can back water up the smaller pipe.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 14. **Installed:** Civil 3.0.70.
    - **For Tim:** 150 in at 10.000 and 300 out at 9.980 passes, but the outlet top sits 130 mm above the inlet top.
    - **Where:** `Rules/PitDropRule.cs:150-156`; `Rules/RulebookEvaluator.cs`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (after 9 Nov). **Lane:** Opus design then Sonnet. **Test:** that pit gives Warn "outlet obvert 130 mm above inlet obvert".
    - **23 Oct status:** NEW, **BUG-907**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word (after 9 Nov). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

53. **F-053. Engineering numbers are still fixed in code (R-00): council values, pump station, sizing, storm, orifice, level limits.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 15. **Installed:** Civil 3.0.70.
    - **For Tim:** for example Kingston's 2000 L block, Manningham factor 0.25, pump C 0.90, X-Civil level limit 0 to 250 m that drops real levels on a high site.
    - **Where:** about 30 files listed in the source (`ReuseCreditService.cs`, `PumpSizingService.cs`, `NetworkDesignService.cs`, `SettingsSizingStandards.cs`, `XcivilLayerRecognition.cs:41-42` and others). **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (values). **Lane:** Sonnet fixer after Tim's values. **Test:** a "no engineering literal" source guard listing those files.
    - **23 Oct status:** NEW, **BUG-908**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's values (R-00). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

54. **F-054. The red back-test GE 24-115 (1.69 vs 2.58 m3) is out of date; the engine's formula is right.**
    - **Severity:** MEDIUM (audit), LOW (carpark). **Area:** Civil engineering. **Sources:** OPUS-E 16. **Installed:** Civil 3.0.70 (test only).
    - **For Tim:** the test feeds 2024 inputs (1 in 5 storm, C 0.35, site rainfall); do not widen the 30 per cent band.
    - **Where:** `Modules/Drainage.Tests/Services/AutoDesignBackTestTests.cs:146-157`. **BUG:** BUG-872. **PR:** none yet (cx_b06 queued). **Fix kind:** test only. **Lane:** Codex build. **Test:** pin `PostDevSoftGroundC: 0.35` and `CouncilProvidedPsdLps: 5.87`: 2.123 m3, 17.7 per cent, passes.
    - **23 Oct status:** FILED. **Severity:** MEDIUM (covered by the existing entry and its PR review). BUG-872; fixed in #1549 (MERGE-WITH-FIXES).

55. **F-055. CEMEMBER keeps only X and Y of the picked points (Z set to 0) and draws a section square to the world, not to the UCS.**
    - **Severity:** MEDIUM (Codex), LOW (Opus). **Area:** Structural. **Sources:** CDX-S F3, OPUS-A 7. **Installed:** Structural 1.0.121.
    - **For Tim:** a member picked on a raised UCS lands at Z 0; a section in a rotated UCS sits at 30 degrees on screen.
    - **Where:** `Commands/CeMemberCommands.cs:125,131,189-191`; `Services/CeMemberLineWriter.cs:124`; `Services/CeMemberSectionWriter.cs:39,43`; house helper `CeStrucCommandBase.cs:94`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** UCS origin at Z 1000: lines stay at World Z 1000 or the command refuses before writing.
    - **23 Oct status:** NEW, **BUG-909**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

56. **F-056. "Follows paper" hatch density and CEMEMBER break marks still use the model drawing scale when drawn directly on a layout sheet.**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** CDX-S F5. **Installed:** Structural 1.0.121.
    - **For Tim:** a break kink is 100 mm on paper instead of 2 mm at DIMSCALE 50.
    - **Where:** `Commands/HatchCommands.cs:1655`; `Core/Units/DrawingScaleRule.cs:56`; `Commands/CeMemberCommands.cs:99`; `DesignCore/SteelSections/CeMemberEngine.cs:219`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** PSPACE, DIMSCALE 50, CEMEMBER with break lines: overshoot 1.5 mm, kink 2 mm.
    - **23 Oct status:** NEW, **BUG-910**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

57. **F-057. EBT and 25C text heights ignore drawing units (metre drawings) and annotation scale (DIMSCALE 0).**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** CDX-S F6. **Installed:** Structural 1.0.121.
    - **For Tim:** 125 m high text in a metre drawing; at DIMSCALE 0 and 1:50 the text plots 5 mm instead of 2.5 mm.
    - **Where:** `Services/CeTextService.cs:27,610,625,4655,5482,5492,5520`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** INSUNITS 6, DIMSCALE 50, EBT: height 0.125 m.
    - **23 Oct status:** NEW, **BUG-911**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

58. **F-058. CEMEMBER ignores the office DefaultScale Setting when DIMSCALE is 0.**
    - **Severity:** MEDIUM (Codex), LOW (Opus). **Area:** Structural. **Sources:** CDX-S F7, OPUS-A 6. **Installed:** Structural 1.0.121.
    - **For Tim:** an office setting of 1:50 still gives 150/200 mm breaks (the fixed 1:100).
    - **Where:** `Commands/CeMemberCommands.cs:98`; `Models/UserSettings.cs:895`; `LegacyToolCommon.cs:147`; `DesignCore/SteelSections/CeMemberEngine.cs:188-190`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** `CeMember.DefaultScale` 50, DIMSCALE 0: command line says 1:50, overshoot 75 mm.
    - **23 Oct status:** NEW, **BUG-912**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

59. **F-059. Long staging paths are the clean-profile default, so a colleague with a long Windows profile path may not be able to prepare an update on older AutoCAD.**
    - **Severity:** MEDIUM (suspected). **Area:** Release, installer and Manager. **Sources:** CDX-G 9. **Installed:** Manager 1.1.70.
    - **For Tim:** works on your PC, may fail on Max's.
    - **Where:** `Modules/Manager/Services/CeUpdateStagingService.cs:109,374`; `CeOneGlanceStatus.cs:245,302,341`; `CeAdminStorageService.cs:32,49`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Codex build. **Test:** a profile path over 260 characters: staging succeeds or refuses cleanly before any partial copy.
    - **23 Oct status:** UNPROVEN, no carpark entry. **Severity:** MEDIUM (source-verified, not re-checked today). Suspected only (long profile path on older AutoCAD); keep for the colleague-PC rehearsal, no carpark entry.

60. **F-060. If Windows denies creating the settings folder on first run, Civil silently falls back to defaults and does not say why preferences are not remembered.**
    - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Sources:** CDX-G 11. **Installed:** Civil 3.0.70, Manager 1.1.70.
    - **For Tim:** Max changes a setting and it is gone next time, with no message.
    - **Where:** `Modules/Drainage/Services/SettingsService.cs:79,93`; `LoggingService.cs:68-98`; `Modules/Manager/Services/CeAdminStorageService.cs:32,51`; `Modules/Manager/Plugin.cs:97`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** deny creation of the settings folder: Settings shows a visible "not saved" explanation.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (first rated MEDIUM) (re-checked today). Opus check PARTLY: the Settings window does say it could not save; only routine 'last used' saves fail silently.

61. **F-061. The slow-check progress line is bypassed when the shared Checks list is enabled.**
    - **Severity:** LOW. **Area:** Civil commands. **Sources:** CDX-C 7. **Installed:** Civil 3.0.70 (both switches OFF). **Where:** `Commands/CheckCurrentDrawingCommand.cs:28-33`; `ChecksListCommand.cs:53-65`; `Services/CurrentDrawingCheckService.cs:43-46`. **BUG:** NEW. **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** with the Checks doorway ON, a 10,000-entity drawing prints a progress line.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

62. **F-062. The double-click "screen pixel" second reading can pick a different downpipe in a metre drawing near 0,0 (before #1522 ships).**
    - **Severity:** LOW. **Area:** Civil commands. **Sources:** OPUS-A (#1522 section). **Installed:** not installed (#1522). **Where:** branch `b04/bug-859-r2-pick-at-doubleclick` `Combine`. **BUG:** NEW. **PR:** #1522. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** metre drawing, downpipes at 0,0 and 300,200, double-click a title-block attribute: AutoCAD's editor opens, CE's does not.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

63. **F-063. The leader-out limits are ground millimetres, not paper millimetres, although entry 1572 says "same paper distance".**
    - **Severity:** LOW. **Area:** Civil labels and Tidy labels. **Sources:** OPUS-A 11. **Installed:** Civil 3.0.70 (switch OFF). **Where:** `Services/LinkService.TextClashTidyUp.cs:425`; `Rules/TidyLeaderOutRule.cs:50`. **BUG:** NEW. **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Sonnet fixer after the ruling. **Test:** DIMSCALE 500 and 20: the clear-spot distance is the same on paper.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

64. **F-064. CDCHECKIGNORE stores the drafter's Windows sign-in name inside the drawing.**
    - **Severity:** LOW. **Area:** Civil commands. **Sources:** OPUS-A 12. **Installed:** Civil 3.0.70 (switch OFF). **For Tim:** a DWG sent to a council carries a staff login name. **Where:** `Commands/CheckIgnoreCommand.cs:121`. **BUG:** NEW. **PR:** none. **Fix kind:** needs Tim's word (initials Setting?). **Lane:** Sonnet fixer. **Test:** ignore one finding: the list line shows the chosen name, not the login.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

65. **F-065. The About window (CE_VERSION) can say "Not loaded" for a tool that is loaded, shows AutoCAD as an internal number (25.1 or 26.0) instead of the year, and falls back to a guessed "2022+".**
    - **Severity:** HIGH (the text can be false). **Area:** Wording and windows. **Sources:** OPUS-UI 7, 8; CDX-G 14 (LOW). **Installed:** Manager 1.1.70.
    - **For Tim:** after a failed read a loaded Civil reads "Not loaded", so a colleague would reinstall for nothing; it also cannot prove the shared files match.
    - **Where:** `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml:67,70,73`; `CeVersionWindow.xaml.cs:34-44`; `Services/CeVersionReport.cs:46-113`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** wording and a Codex look at the window. **Lane:** Sonnet fixer. **Test:** force the read to fail: rows say "CE could not read this. Type CEHEALTH."; the AutoCAD row reads the year.
    - **23 Oct status:** NEW, **BUG-913**. **Severity:** HIGH (source-verified, not re-checked today). Wording fix drafted in #1534 (HOLD: garbled characters in the pushed head). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

66. **F-066. Hydraulic radius uses the nominal size, not the bore.** LOW. Civil engineering. OPUS-E 17. Civil 3.0.70. Safe side (UPVC DN100 under-states capacity about 11 per cent). `Services/DesignValidationService.cs:141-142`; `Services/PipeSizingSolver.cs:313-314`. NEW. No PR. Code. Sonnet fixer. **Test:** DN100 UPVC at 1 in 100 with a 104 mm bore: about 7.5 L/s.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

67. **F-067. CDTWL measures the orifice head to the orifice level, while the equation wants the head to its centre.** LOW (suspected). Civil engineering. OPUS-E 18. Civil 3.0.70. `Services/DetentionTwlService.cs:217-226`; `Services/OrificeSizer.cs`. NEW. No PR. Needs Tim's word. Opus design. **Test:** TWL 10.40, orifice invert 10.00, d 71: report head 364 mm or say "to invert".
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

68. **F-068. Casey's formula uses banker's rounding on exact halves.** LOW. Civil engineering. OPUS-E 19. Civil 3.0.70. `Services/OrificeSizer.cs:65`. NEW. No PR. Code. Sonnet fixer. **Test:** an input giving exactly 54.5 returns 55.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

69. **F-069. The grade label ignores which way the levels fall, so an uphill pipe reads "1 IN 100".** LOW. Civil engineering. OPUS-E 20. Civil 3.0.70. `Services/PipeAnnotationTextFormatter.cs:41`. NEW. No PR. Code. Sonnet fixer. **Test:** `ActualGradeLabel(10000, 10.00, 10.10)` says it rises.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

70. **F-070. The R-03 message can contradict itself after rounding ("actual 1:200 is flatter than 1:200").** LOW. Civil engineering. OPUS-E 21. Civil 3.0.70. `Rules/RulebookEngine.cs:347-351`. NEW. No PR. Wording. Sonnet fixer. **Test:** 20.04 m over 0.10 m prints "1:200.4".
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

71. **F-071. CDCALC boxes accept a comma as a thousands mark, so "0,35" in a C box reads as 35 and is clamped to 1.0.** LOW. Civil engineering. OPUS-E 22. Civil 3.0.70. `ViewModels/BoydsCalcViewModel.cs:277-280`; `DetentionCalcViewModel.cs:138-140`; `OrificeCalcViewModel.cs:158-160`. NEW. No PR. Code. Sonnet fixer. **Test:** Parse("0,35") is rejected or warned.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

72. **F-072. The CDDESIGN window shows the council's soft C (0.35), not the Settings value used (0.30).** LOW. Civil engineering. OPUS-E 23. Civil 3.0.70. `ViewModels/CivilDesignWindowViewModel.cs:741-744`; `Services/CivilDesignService.cs:156`. NEW. No PR. Wording. Sonnet fixer. **Test:** the window line reads "0.30 (Settings; council records 0.35)".
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

73. **F-073. The storm sweep includes storms shorter than the council's Tc (Darebin Tc 10 min, 5-min storm still worked).** LOW (safe side). Civil engineering. OPUS-E 24. Civil 3.0.70. `Services/DetentionSizingService.cs:131`. NEW. No PR. Code. Sonnet fixer. **Test:** Darebin job: first row is 10 min.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

74. **F-074. Minimum grade ladder has odd values and two readers: a DN250 gets no minimum in the solver but 1 in 250 in CDRULES.** LOW. Civil engineering. OPUS-E 25. Civil 3.0.70. `Models/UserSettings.cs:1920-1924`; `Services/PipeSizingSolver.cs:422-437`; `Rules/RulebookValues.cs:337-358`. NEW. No PR. Needs Tim's word (the ladder). Sonnet fixer. **Test:** DN250 in both gives the same minimum.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

75. **F-075. Sizing defaults ignore Tim's 300 mm cover (600 mm cover and 6.0 m/s in `CreateDefault`).** LOW. Civil engineering. OPUS-E 26. Civil 3.0.70. `Services/SettingsSizingStandards.cs:91-99`. NEW. No PR. Code. Sonnet fixer. **Test:** `CreateDefault().MinCoverMm` equals Settings `minimumCoverDepth`.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

76. **F-076. A drawing with UNITS not set is read as millimetres by the rules, so a unitless metre drawing makes every pipe 1,000 times short.** LOW. Civil engineering. OPUS-E 27. Civil 3.0.70. `Services/PipeGeometryHelper.cs:150-153`. NEW. No PR. Needs Tim's word (gap plan question 4). Sonnet fixer. **Test:** unitless record, pits 20 units apart with 6-digit coordinates: reads 20 m or Unknown.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

77. **F-077. The self-cleansing check uses full-bore speed, so "0.6 m/s met" is optimistic at low flow.** LOW (information only). Civil engineering. OPUS-E 28. Civil 3.0.70. `Rules/RulebookEngine.cs:415`; `Services/PipeSizingSolver.cs:256`. NEW. No PR. Needs Tim's word. Opus design. **Test:** none until Tim rules.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

78. **F-078. CEMEMBER draws onto a frozen or off layer and still says "placed".** LOW. Structural. OPUS-A 5. Structural 1.0.121. `SbeamAtomicPlacementWriter.ReadLayerStates`; `SbeamOutputProtectionContract.TryAdmit`. NEW. No PR. Code (warn and carry on, R-27). Sonnet fixer. **Test:** freeze 25CONT, run CEMEMBER: a plain line names the frozen layer.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

79. **F-079. CEMEMBER's section-name question does not take Space as Enter.** LOW. Structural. OPUS-A 8. Structural 1.0.121. `Commands/CeMemberCommands.cs:351`. NEW. No PR. Code. Sonnet fixer. **Test:** type `310UB32` then Space: the next question appears.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

80. **F-080. CEMEMBER's locked-layer refusal says "SBEAM output layer is locked".** LOW. Structural. OPUS-A 10. Structural 1.0.121. `SbeamPlacementPersistenceContract.cs`; `Services/CeMemberLineWriter.cs:74`. NEW. No PR. Wording. Sonnet fixer. **Test:** lock 25CONT: the line starts "CEMEMBER:".
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

81. **F-081. After S-41, CEHATCHAUDIT flags every older LBH and LBUH hatch at 1:50 and 1:100, and Repair rescales them.** LOW. Structural. OPUS-A 13. Structural 1.0.121. `Core/Units/DrawingScaleRule.cs:59-60`; `Commands/HatchUpgradeCommands.cs:563`. BUG-748 (related). No PR. Needs Tim's word. Opus design. **Test:** old LBH at DIMSCALE 100: Report either leaves it or flags it, as Tim chooses.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

82. **F-082. Settings recovery tells the drafter to check three switches (FollowAnyDrawingScale, HatchDensityFollowsPaper, TagTextFollowsLabelHeight) that have no Settings row.** LOW. Structural. CDX-S F8. Structural 1.0.121. `Services/SettingsService.LoadRecovery.cs:282,828,1321`. NEW. #1526 adds Civil rows only. Wording. Sonnet fixer. **Test:** a damaged OFF value: recovery says the key has no Settings page.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

83. **F-083. The Manager window tells colleagues to "run the CE installer", but only the administrator can.**
    - **Severity:** HIGH (the text is false for a colleague). **Area:** Wording and windows. **Sources:** OPUS-UI 1. **Installed:** Manager 1.1.70.
    - **For Tim:** the window and the status line disagree, so Max is told to do something he cannot do.
    - **Where:** `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:177,189`; `Services/CeInstallWords.cs:6-15`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** wording (bind both lines to `CeInstallWords.FinishTheInstall`). **Lane:** Sonnet fixer. **Test:** a colleague sees "ask your CE administrator to finish the install" in both places.
    - **23 Oct status:** NEW, **BUG-914**. **Severity:** HIGH (source-verified, not re-checked today). Fix drafted in #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

84. **F-084. CDCHECKIGNORE prints only 40 rows but says "... and 12 more (type their number to ignore one)", so a drafter can ignore a finding they cannot see.**
    - **Severity:** HIGH. **Area:** Wording and windows. **Sources:** OPUS-UI 13 (CDX-C calls the 40-row display a known limitation). **Installed:** Civil 3.0.70 (switch OFF).
    - **For Tim:** typing 45 ignores finding 45 without ever showing it.
    - **Where:** `Commands/CheckIgnoreCommand.cs:93,141`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code and wording (print all, or say fix some first and run again). **Lane:** Sonnet fixer. **Test:** 50 findings: either all 50 are printed or numbers above 40 are refused.
    - **23 Oct status:** NEW, **BUG-915**. **Severity:** HIGH (source-verified, not re-checked today). Fix drafted in #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

85. **F-085. Two CDCHECKIGNORE refusals contradict each other: one says a finding "CE could not check" can be ignored, the next says a check CE could not run cannot.**
    - **Severity:** HIGH. **Area:** Wording and windows. **Sources:** OPUS-UI 14. **Installed:** Civil 3.0.70 (switch OFF).
    - **For Tim:** the first sentence tells the drafter they can do what the second forbids.
    - **Where:** `Services/Checks/IgnoredChecks.cs:90,93`; `Services/Checks/ChecksResult.cs:305`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** wording. **Lane:** Sonnet fixer. **Test:** the two lines no longer contradict ("a finding to look at, or a not known one").
    - **23 Oct status:** NEW, **BUG-916**. **Severity:** HIGH (source-verified, not re-checked today). Fix drafted in #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

86. **F-086. Manager window uses five names for one update stage ("Installed next start", "Updates ready to get", "Ready next start", "Update ready", "2 · Ready").** MEDIUM. Wording and windows. OPUS-UI 2. Manager 1.1.70. For Tim: a drafter cannot tell whether "Ready" means approved, copied or installed. `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:50,98,99,139,176`. NEW (see 23 Oct status). No PR. Wording (Approved / Copied, waiting / Starts next time). Sonnet fixer. **Test:** the five strings are gone and the three fixed words appear.
    - **23 Oct status:** NEW, **BUG-917**. **Severity:** MEDIUM (source-verified, not re-checked today). Left out of #1534 on purpose (needs each state checked). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

87. **F-087. The unconnected finish-update messages use "record" and give no next step, and one promises "It will finish when every AutoCAD window is closed" although nothing starts the installer.** MEDIUM. Wording and windows. OPUS-UI 5, 6. Manager 1.1.70 (not shown to anyone yet). `Modules/Manager/Services/CeFinishUpdatePlanner.cs:47,52,56`; `CeFinishUpdateStartRule.cs:36`. NEW (see 23 Oct status). No PR (#1508 and #1515 are the unconnected code). Wording plus a guard. Sonnet fixer. **Test:** the "will finish" line cannot appear until a caller that starts the installer exists.
    - **23 Oct status:** NEW, **BUG-918**. **Severity:** MEDIUM (source-verified, not re-checked today). Partly in #1534 (UI-5); UI-6 left out. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

88. **F-088. About window (CE_VERSION) smaller wording faults: a ".NET 10" row drafters cannot act on, "CONFLICT — 2 copies" in capitals with no next step, "<path unavailable>", and three names for one window.** MEDIUM. Wording and windows. OPUS-UI 9, 10, 11, 12. Manager 1.1.70. `UI/Dialogs/CeVersionWindow.xaml:4,34,78-79`; `Services/CeVersionReport.cs:97,101`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** two copies loaded reads "Two copies loaded (3.0.70 and 3.0.69). Close AutoCAD and ask your CE administrator."
    - **23 Oct status:** NEW, **BUG-919**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

89. **F-089. CDCHECKIGNORE's "switched off" message does not say which tab to tick.** MEDIUM. Wording and windows. OPUS-UI 15. Civil 3.0.70 (switch OFF). `Commands/CheckIgnoreCommand.cs:39`; `Services/Checks/IgnoredChecks.cs:88`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the line names CDS > Newer tools > "Allow a finding to be ignored".
    - **23 Oct status:** NEW, **BUG-920**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

90. **F-090. CDCHECKIGNORE says "no CE project record yet" (a software word) with no next step.** MEDIUM. Wording and windows. OPUS-UI 16. Civil 3.0.70 (switch OFF). `Commands/CheckIgnoreCommand.cs:46`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the line reads "This drawing has no CE pits or pipes yet, so there is nothing to ignore. Nothing was changed."
    - **23 Oct status:** NEW, **BUG-921**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

91. **F-091. "CE could not check" means two different things in the Checks window (a value is missing, and CE failed while reading), and the row repeats its own title with no next step.** MEDIUM. Wording and windows. OPUS-UI 20. Civil 3.0.70. `Services/Checks/ChecksResult.cs:153,305-307`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** header "312 not known (a value is missing)"; the read-failure row tells the drafter to run CDCHECK again.
    - **23 Oct status:** NEW, **BUG-922**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

92. **F-092. CDRULES rows use software words: "provenance", "PitSelector size tier", "office seed", "per-type catalogue selection", "fallback velocity".** MEDIUM. Wording and windows. OPUS-UI 21, 23, 24, 25. Civil 3.0.70. `Rules/RulebookEngine.cs:69,250-260,321,411-419`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** a source guard that none of those words reach a user string.
    - **23 Oct status:** NEW, **BUG-923**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

93. **F-093. CDRULES says "no minimum in the rulebook" instead of saying where to set it.** MEDIUM. Wording and windows. OPUS-UI 22. Civil 3.0.70. `Rules/RulebookEngine.cs:345,437,454,625,650`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the line reads "No minimum cover set. Set it in CDS > Design."
    - **23 Oct status:** NEW, **BUG-924**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

94. **F-094. The council-source window shows raw saved data (JSON with EntityHandle and SpineKey) and legal-sounding sentences.** MEDIUM. Wording and windows. OPUS-UI 26. Civil 3.0.70. `ViewModels/CouncilSourceViewModel.cs:63,80,82`; `Rules/RulebookEngine.cs:134`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the window lists values in words ("Diameter 225 mm, upstream IL 10.250"), no handles.
    - **23 Oct status:** NEW, **BUG-925**. **Severity:** MEDIUM (source-verified, not re-checked today). Left out of #1534 (behaviour change). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

95. **F-095. "Unknown" and "not known" are both used for the same thing in what a drafter reads (Settings, council rule values, audit lines, pipe length).** MEDIUM. Wording and windows. OPUS-UI 27, 28. Civil 3.0.70. `AdvancedSettingsDialog.xaml:919,1360`; `Rules/CouncilRuleValues.cs:333`; `Commands/LinkCommands.ReadOnlyAudit.cs:25,30,36`; `Rules/RulebookEngine.cs:333`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** a source guard for "Unknown" in user strings.
    - **23 Oct status:** NEW, **BUG-926**. **Severity:** MEDIUM (source-verified, not re-checked today). Partly in #1534. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

96. **F-096. CDTAG says "CDTAG removed." when nothing was tagged, and prints "CDTAG applied: tag=DP2. Pipes linked to this block: 2."** MEDIUM. Wording and windows. OPUS-UI 30, 31. Civil 3.0.70. `Commands/SourceTagCommand.cs:311,391`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** Enter on an empty tag prints "[CE] No tag typed. This block has no source tag."
    - **23 Oct status:** NEW, **BUG-927**. **Severity:** MEDIUM (source-verified, not re-checked today). Left out of #1534 (reserved for the source-edit PRs). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

97. **F-097. A colleague-facing Settings tooltip names a person and an internal ruling ("Tim decides when to hide it (ruling of 18 Oct)").** MEDIUM. Wording and windows. OPUS-UI 36. Civil 3.0.70. `Dialogs/AdvancedSettingsDialog.xaml:1375`; `CivilSettingsView.xaml:400`; `ViewModels/SettingsValueCatalog.cs`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** a source guard for personal names in Settings strings.
    - **23 Oct status:** NEW, **BUG-928**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

98. **F-098. A Settings tick that changes nothing the drafter can see ("Nothing draws this row today").** MEDIUM. Wording and windows. OPUS-UI 37. Civil 3.0.70. `AdvancedSettingsDialog.xaml:1369`; `CivilSettingsView.xaml:394`. NEW (see 23 Oct status). No PR. Wording (hide it, or label "(no effect yet)"). Sonnet fixer. **Test:** the row is hidden or carries the label.
    - **23 Oct status:** NEW, **BUG-929**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

99. **F-099. Eight Fixes-tab tooltips use software words (stored deletion word, records, drawing identity, Point Order, stored levels, runtime rounding, unlinked, Project QA, native, host drawing).** MEDIUM. Wording and windows. OPUS-UI 38, 39, 40, 41, 42, 43, 44, 45. Civil 3.0.70. `Dialogs/AdvancedSettingsDialog.xaml:1338-1398`; `CivilSettingsView.xaml:363-423`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** a source guard for those words in the Fixes tab.
    - **23 Oct status:** NEW, **BUG-930**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

100. **F-100. The start-up "heartbeat to CE Cloud" tick is worded with software words and does not say plainly what is sent.** MEDIUM. Wording and windows. OPUS-UI 50. Civil 3.0.70. `AdvancedSettingsDialog.xaml:1128-1129`; `CivilSettingsView.xaml:207`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the label reads "At start-up, tell the CE office this PC is running CE (CE and AutoCAD versions and a PC code only)".
    - **23 Oct status:** NEW, **BUG-931**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

101. **F-101. "Furthest a label may move out (mm)" does not say model or paper millimetres (1500 mm is 7.5 mm on a 1:200 sheet).** MEDIUM. Wording and windows. OPUS-UI 51. Civil 3.0.70 (switch OFF). `AdvancedSettingsDialog.xaml:1215-1216,1286`; `CivilSettingsView.xaml:243,313`. Related F-063. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the label reads "(mm in the model, 1500 = 1.5 m)".
    - **23 Oct status:** NEW, **BUG-932**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

102. **F-102. Several new switches have no tick on the Settings page (double-click Edit source window, leave out removed pits, slow-check progress, wrong-layer rows), so the Edit source window is ON and cannot be switched off from Settings.** MEDIUM. Wording and windows. OPUS-UI 52. Civil 3.0.70. `Models/DoubleClickSettings.cs:34`; `Models/UserSettings.cs:1985,2757,2764`. NEW (see 23 Oct status). **PR:** #1526 (adds rows for existing check, progress and double-click settings; confirm it covers all four). Settings row. Codex build (in flight). **Test:** each of the four keys has a row in CDS > Newer tools.
    - **23 Oct status:** NEW, **BUG-933**. **Severity:** MEDIUM (source-verified, not re-checked today). #1526 adds the rows (MERGE-WITH-FIXES: tallest tab 673 px). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

103. **F-103. One window has three names: Preferences (ribbon, CD and Edit Pipe buttons), Settings (title bar, Help) and CE Settings (messages).** MEDIUM. Wording and windows. OPUS-UI 55. Civil 3.0.70. `Assets/Config/ce_toolbar_layout.json:189`; `command-registry.json:327`; `Dialogs/CdDialog.xaml:145`; `Dialogs/AdvancedSettingsDialog.xaml:4`. NEW (see 23 Oct status). No PR. Needs Tim's word (one name). Sonnet fixer after the ruling. **Test:** a source guard that "Preferences" is gone from user strings.
    - **23 Oct status:** NEW, **BUG-934**. **Severity:** MEDIUM (source-verified, not re-checked today). Partly in #1534; protected Edit Pipe window keeps 'Preferences'; one name is Tim's call. **Lane:** Sonnet (protected file); base claude/rel-20261022m.

104. **F-104. Two different things are called "CE Manager" (CDMANAGER is the Drawing Standards Manager; CESURVEYREVIEW means Suite Manager).** MEDIUM. Wording and windows. OPUS-UI 56. Civil 3.0.70, Manager 1.1.70. `Assets/Config/command-registry.json:319`; `Modules/Manager/Assets/Config/command-registry.json:33`. NEW (see 23 Oct status). No PR. Needs Tim's word (naming). Sonnet fixer after the ruling. **Test:** CDMANAGER reads "Drawing Standards (CDMANAGER)".
    - **23 Oct status:** NEW, **BUG-935**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD); naming is Tim's call. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

105. **F-105. Ribbon tooltips use banned words (network topology, schedule drift, compound entity, "Export Entities", "CE data model").** MEDIUM. Wording and windows. OPUS-UI 57. Civil 3.0.70. `Assets/Config/command-registry.json:147,198,252,314,343`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** a source guard for the banned words.
    - **23 Oct status:** NEW, **BUG-936**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

106. **F-106. "Repair Center" is US spelling and its tooltip says "sync, rebuild, upgrade and diagnostics".** MEDIUM. Wording and windows. OPUS-UI 58. Civil 3.0.70. `Assets/Config/command-registry.json:351,355`; `ce_toolbar_layout.json:222`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the label reads "Repair Centre".
    - **23 Oct status:** NEW, **BUG-937**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

107. **F-107. The Manager Refresh tooltip says "upload queued telemetry" and does not say plainly that it sends data.** MEDIUM. Wording and windows. OPUS-UI 59. Manager 1.1.70. `Modules/Manager/Assets/Config/command-registry.json:27`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the tooltip says it sends waiting usage notes to the office.
    - **23 Oct status:** NEW, **BUG-938**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

108. **F-108. Help lists six Settings tabs; the window has eight (Newer tools and Fixes are missing, "Pipes & Pits" should be "Pipes and Pits").** MEDIUM. Wording and windows. OPUS-UI 61. Civil 3.0.70. `Assets/Help/guide-content.js:95`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the Help line names all eight tabs.
    - **23 Oct status:** NEW, **BUG-939**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

109. **F-109. Help says only the office administrator can switch Checks on; any drafter can tick it in Settings.** MEDIUM. Wording and windows. OPUS-UI 62. Civil 3.0.70. `Assets/Help/guide-content.js:58`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the Help line points to CDS > Newer tools.
    - **23 Oct status:** NEW, **BUG-940**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

110. **F-110. CD window (used all day) uses software words: "Use single pipe entity", "validation rules", "no invert or grade validation".** MEDIUM. Wording and windows. OPUS-UI 63. Civil 3.0.70. `Dialogs/CdDialog.xaml:238,244,469`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the checkbox reads "Draw the pipe as one line".
    - **23 Oct status:** NEW, **BUG-941**. **Severity:** MEDIUM (source-verified, not re-checked today). #1534 (HOLD). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

111. **F-111. Inspector and Edit Pit show "Handle", "GIO Handle", "full-detail snapshot" and "reference evidence, not authority".** MEDIUM. Wording and windows. OPUS-UI 64. Civil 3.0.70. `Controls/InspectorPanelControl.xaml:89,266,321`; `Dialogs/PitEditWorkshopDialog.xaml:203`. NEW (see 23 Oct status). No PR. Wording (hide the handle rows for colleagues). Sonnet fixer. **Test:** the handle rows are hidden.
    - **23 Oct status:** NEW, **BUG-942**. **Severity:** MEDIUM (source-verified, not re-checked today). Left out of #1534 (layout change; Edit Pit protected). **Lane:** Sonnet (protected file); base claude/rel-20261022m.

112. **F-112. Repair Centre and CD help page use software words ("Sync Links", "caches from drawing truth").** MEDIUM. Wording and windows. OPUS-UI 65. Civil 3.0.70. `Dialogs/CdRepairDialog.xaml:46,75`; `Dialogs/CdHelpDialog.xaml:94`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the step reads "1. Reconnect pits and pipes".
    - **23 Oct status:** NEW, **BUG-943**. **Severity:** MEDIUM (source-verified, not re-checked today). Left out of #1534. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

113. **F-113. Command-line messages in developer words ("compound root", "no ProjectData record", "slab boundary polyline handle", "not a council profile id", "entity(ies) skipped").** MEDIUM. Wording and windows. OPUS-UI 66. Civil 3.0.70. `Commands/AnnotationEditCommand.cs:57`; `RunSolveCommand.cs:288,467`; `SlabCommand.cs:1229`; `RulebookCommand.cs:158`; `HubCommands.cs:654`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** a source guard for those phrases.
    - **23 Oct status:** NEW, **BUG-944**. **Severity:** MEDIUM (source-verified, not re-checked today). Left out of #1534. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

114. **F-114. CDAUDIT and Recover Inverts print a programmer's dump ("pits=12, pipes=14, duplicate-handle-groups=1", "cached ownership Unknown").** MEDIUM. Wording and windows. OPUS-UI 67. Civil 3.0.70. `Commands/LinkCommands.cs:403,405,2379`; `Commands/LinkCommands.ReadOnlyAudit.cs:36,40`. NEW (see 23 Oct status). No PR. Wording. Sonnet fixer. **Test:** the CDAUDIT line reads "12 pits, 14 pipes. 2 pipes are copies of one another. Type CDREPAIR to fix them."
    - **23 Oct status:** NEW, **BUG-945**. **Severity:** MEDIUM (source-verified, not re-checked today). Left out of #1534. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

115. **F-115. Manager window labels: "Current drawing session" (it is the AutoCAD session) and a "Module" tab (drafters say Civil, Structural, Manager).** LOW. Wording and windows. OPUS-UI 3, 4. Manager 1.1.70. `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:115,122`. NEW. No PR. Wording. Sonnet fixer. **Test:** the strings read "This AutoCAD, right now" and "CE tools".
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

116. **F-116. CDCHECKIGNORE polish: "(!)" and "(?)" have no key line, a wrong reason number ends the command, and three different wordings say when an ignored finding comes back.** LOW. Wording and windows. OPUS-UI 17, 18, 19. Civil 3.0.70 (switch OFF). `Services/Checks/IgnoreFindingPicker.cs:36`; `Commands/CheckIgnoreCommand.cs:111,128`; `AdvancedSettingsDialog.xaml:1260`. NEW. No PR. Wording. Sonnet fixer. **Test:** a key line prints first; a typo at the reason asks again; one "comes back" sentence in all three places.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

117. **F-117. Message openings: the progress line starts "CE:", others start "[CDRUNSOLVE]", "CDAUDIT:", "CopyRot:" or nothing, where 674 messages start "[CE]".** LOW. Wording and windows. OPUS-UI 29, 68. Civil 3.0.70. `Rules/SlowWorkProgressTicker.cs:47-48` and others. NEW. No PR. Wording. Sonnet fixer. **Test:** a source guard that every user message starts "[CE]".
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

118. **F-118. CDTAG and Edit source window polish: two commands in one message, "Show tag label on screen?" versus "...on the drawing", OK greys out with no reason, Help does not mention the window.** LOW. Wording and windows. OPUS-UI 32, 33, 34, 35. Civil 3.0.70. `Commands/SourceTagCommand.cs:322,393`; `Dialogs/SourceEditDialog.xaml:39,55`; `Assets/Help/guide-content.js:42`. NEW. No PR. Wording. Sonnet fixer. **Test:** a space in the tag shows "One word, no spaces (for example DP2)".
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

119. **F-119. Fixes tab polish: one sentence repeated on 32 tooltips, two names for one tab, a vague "Tidy labels (more)" heading, a US-style phrase.** LOW. Wording and windows. OPUS-UI 46, 47, 48, 49. Civil 3.0.70. `Dialogs/AdvancedSettingsDialog.xaml:754,1342,1376,1377`. NEW. No PR. Wording. Sonnet fixer. **Test:** one bold line at the top of the Fixes tab; the repeated sentence is gone from each tooltip.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

120. **F-120. Settings polish: one tick has two different descriptions (tooltip versus Settings search), two Survey boxes in a row, "DEBUGGING" versus "FAULT-FINDING", mixed capitals.** LOW. Wording and windows. OPUS-UI 53, 54. Civil 3.0.70. `AdvancedSettingsDialog.xaml:1089`; `ViewModels/SettingsValueCatalog.cs`; `Dialogs/CivilSettingsView.xaml:169,188,197`. NEW. No PR. Wording. Sonnet fixer. **Test:** the Settings search text equals the tooltip text for CommandOutcomeLines.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

121. **F-121. Small ribbon tooltip polish (CDINSPECTOR, CDSTRIP "100mm-wide", CDSOURCE "user-typed source ID", CDPERIMETER "AG-style engine").** LOW. Wording and windows. OPUS-UI 60. Civil 3.0.70. `Assets/Config/command-registry.json` (several entries). NEW. No PR. Wording. Sonnet fixer. **Test:** none beyond reading the four strings.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

122. **F-122. CEHEALTH prints "[OK] CE Civil Suite v3.0.70" (and can end "All checks passed") when Civil is installed but not loaded.**
    - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Sources:** HUNT-MANAGER MGR-01. **Installed:** Manager 1.1.70.
    - **For Tim:** the command meant to diagnose a missing Civil says Civil is fine, while CE_VERSION says "Not loaded".
    - **Where:** `Modules/Manager/Commands/PluginManagerCommands.cs:184,191,201,206,211,243`; `Services/CePluginRegistryService.cs:517`; `Services/CeHealthChecks.cs:31`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (add a NotLoaded warning). **Lane:** Sonnet fixer. **Test:** NETLOAD only Manager, then CEHEALTH: a "Civil not loaded" warning and no OK line for Civil.
    - **23 Oct status:** NEW, **BUG-946**. **Severity:** MEDIUM (re-checked today). Opus check: verified. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

123. **F-123. A damaged prepared update cannot be repaired by clicking Get update ready again: the old folder blocks the fresh copy every time.**
    - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Sources:** HUNT-MANAGER MGR-02. **Installed:** Manager 1.1.70.
    - **For Tim:** one missing file in the local copy and Max is stuck with "conflicting identity evidence" even after a restart.
    - **Where:** `Modules/Manager/Services/CeUpdateStagingService.cs:370,374,399,401,414,417,430`; `UI/Dialogs/PluginManagerWindow.xaml.cs:666,688`; `Services/CePluginInstallerService.cs:242`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (quarantine the bad copy and stage a new verified one; keep the rejection test). **Lane:** Sonnet fixer with Opus review. **Test:** remove one listed file from the staged bundle, click Get update ready twice: a complete verified stage results and installed hashes are unchanged.
    - **23 Oct status:** NEW, **BUG-947**. **Severity:** MEDIUM (re-checked today). Opus check: verified. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

124. **F-124. The CE Tools "Updates & Rollback" ribbon button sends an ordinary colleague to an administrator-only route and opens no window.**
    - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Sources:** HUNT-MANAGER MGR-03. **Installed:** Manager 1.1.70.
    - **For Tim:** Max clicks the prominent button and gets "This Windows account is not set up as a CE administrator" while the normal Manager window has an Updates page he could use.
    - **Where:** `Modules/Manager/Services/CeToolsRibbonDefinitionService.cs:26`; `Commands/PluginManagerCommands.cs:91,139,148`; `UI/Dialogs/PluginManagerWindow.xaml:161,191`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** non-administrator clicks the button: the Manager Updates page opens and no administrator role is granted.
    - **23 Oct status:** NEW, **BUG-948**. **Severity:** MEDIUM (re-checked today). Opus check: verified. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

125. **F-125. XCLMTXT turns every unequal angle except 150x100x10 into "EA" (equal angle) on the member schedule.**
    - **Severity:** HIGH. **Area:** Structural. **Sources:** OPUS-SE 1. **Installed:** Structural 1.0.121.
    - **For Tim:** a lintel "150x90x10" comes out "150 x 90 x 10 EA"; a fabricator may order the wrong angle.
    - **Where:** `Modules/Structural/Services/ExcelMTextService.cs:5784-5791` (`ExpandMemberAbbreviation`, via `ProcessColumn2Text` line 5161). **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (equal legs = EA, unequal = UA). **Lane:** Sonnet fixer. **Test:** "150x90x10 L ]L" gives UA, "100x75x6" gives UA, "100x100x8" gives EA.
    - **23 Oct status:** FILED. **Severity:** HIGH (covered by the existing entry and its PR review). Carpark entry AUDIT-XCLMTXT-ANGLES; fixed in #1533 (MERGE).

126. **F-126. XCLMTXT rounds every UB and UC to a whole number ("250UB25.7" becomes "250 UB 26", a section that does not exist), against Tim's 19 Oct decimals ruling; its own spelling table also disagrees with the section list.**
    - **Severity:** MEDIUM (the most likely wrong number on an issued Structural drawing). **Area:** Structural. **Sources:** OPUS-SE 2. **Installed:** Structural 1.0.121.
    - **For Tim:** paste "410UB59.7" from the engineer's schedule and the drawing says "410 UB 60"; typing "410UB59" gives "410 UB 59", so one section gets two names on one job.
    - **Where:** `Modules/Structural/Services/ExcelMTextService.cs:6061-6078` (`NormalizeUcUbWholeNumbers`, called at 5172) and the spelling table at 249-342. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** "250UB25.7" output contains "25.7"; "410UB59" and "410UB59.7" never give two designations.
    - **23 Oct status:** FILED. **Severity:** HIGH (first rated MEDIUM) (covered by the existing entry and its PR review). Carpark entry AUDIT-XCLMTXT-DECIMALS; fixed in #1533 (MERGE). Also CODEX_SWEEP_S14 S14-03 (rated HIGH there).

127. **F-127. Since S-41 the load-bearing-wall-over hatch (LBH) at 1:100 is five times sparser (one line every 1.1 m of wall instead of every 225 mm), so a 900 mm nib can show no hatch.**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** OPUS-SE 3. **Installed:** Structural 1.0.121.
    - **For Tim:** the look of a load-bearing wall changes on every 1:100 plan, and a short wall can read as not load bearing. The finalizer said LBH "has had no look".
    - **Where:** `Commands/HatchCommands.cs:120-130`; `Core/Units/DrawingScaleRule.cs:58-60`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (keep paper density for LBUH, keep LBH at 50?). **Lane:** Opus design. **Test:** `HatchPatternScale(50, 50, 100, 1000, anyScale: true, paperDensity: true)` returns 50 if Tim keeps the office value.
    - **23 Oct status:** NEW, **BUG-949**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

128. **F-128. The bracing panel adds up metres of brace of every type and calls the total "sufficient", with no rating per metre.**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** OPUS-SE 4. **Installed:** Structural 1.0.121.
    - **For Tim:** 3.6 m of a weak brace shows green against a requirement worked for a strong one (3.6 x 1.5 = 5.4 kN against 20 kN needed).
    - **Where:** `Modules/Structural.DesignCore/BracingPanelCalculator.cs:157-195`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (a rating per bracing type, from AS 1684.2). **Lane:** Opus design. **Test:** a mixed set with no ratings returns "unknown" or a plain warning, not Sufficient.
    - **23 Oct status:** NEW, **BUG-950**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

129. **F-129. TH, PF, BP, column, 18-text and setout tags use a fixed height (250, 200 or 180) at every scale, so they plot 5 mm at 1:50 beside 2.5 mm notes.**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** OPUS-SE 5. **Installed:** Structural 1.0.121. **Related:** BUG-531.
    - **For Tim:** a PFL label plots 12.5 mm at 1:20 and 5 mm at 1:50.
    - **Where:** `Services/CeTextService.cs:663-780`; `Models/UserSettings.cs:1424,1491,1537,1692`; `RoofSetoutDrawService.cs:96`, `FloorSetoutCommandService.cs:87`, `LintelProposalService.cs:346`, `LevelCarryDrawService.cs:93`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (Tim's ruling "all scales come from the drawing scale" already covers it). **Lane:** Sonnet fixer. **Test:** DIMSCALE 50, PFL "PF1": text height 125, not 250.
    - **23 Oct status:** NEW, **BUG-951**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

130. **F-130. SBEAM and CEMEMBER draw the same member at different sizes at every DIMSCALE except 20 (SBEAM scales depth by DIMSCALE / 20, CEMEMBER draws real size).**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** OPUS-SE 6. **Installed:** Structural 1.0.121.
    - **For Tim:** at 1:100 a 310UB32 elevation is 298 mm deep from CEMEMBER and 1490 mm from SBEAM over the same 6000 mm span.
    - **Where:** `DesignCore/SteelSections/SbeamPlacementPlanner.cs:8,23,87-92`; `Services/SbeamAtomicPlacementWriter.cs:300-310`; `CeMemberElevation.cs`, `CeMemberSection.cs`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (one ruling decides which is right). **Lane:** Opus design. **Test:** `PlanElevation` at DIMSCALE 100 and `CeMemberElevation.Build` give the same depth once Tim rules.
    - **23 Oct status:** NEW, **BUG-952**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

131. **F-131. The scale-aware hatches (EH, CH, LBH, LBUH) refuse to draw when LTSCALE is not exactly 10 x DIMSCALE, a hard stop that R-27 does not allow.**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** OPUS-SE 7. **Installed:** Structural 1.0.121. **Related:** F-015, BUG-614.
    - **For Tim:** a drawing at DIMSCALE 100 and LTSCALE 1 gets no hatch at all, while CEMEMBER warns and draws.
    - **Where:** `Commands/HatchCommands.cs:347-349,1655-1678`; `Core/Units/DrawingScaleRule.cs:63-72`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (warn and carry on). **Lane:** Sonnet fixer. **Test:** `HatchPatternScale(8, 40, 100, 1, anyScale: true)` returns 40 with a warning flag, not null.
    - **23 Oct status:** NEW, **BUG-953**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

132. **F-132. The fixed-scale template hatches in the CEHATCH library disagree with their scale-aware twins, and two (Fence wall under, Dot hatch 9) still have the BUG-748 dots-merge fault.**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** OPUS-SE 8. **Installed:** Structural 1.0.121. **Related:** BUG-748.
    - **For Tim:** at 1:100 "Concrete slab" is AR-CONC 1.0 while CE's own Concrete is 5.0 (five times denser); "Fence wall under" dot rows sit 0.32 mm apart on paper and merge to grey.
    - **Where:** `Commands/HatchUpgradeCommands.cs:45-58`; `Commands/HatchCommands.cs:85-153`; `FoundationInfillService.cs:618-628`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** needs Tim's word (which rule makes each pair equal). **Lane:** Opus design. **Test:** `PlacementScale(Fence wall under, 100, 1000, true, true)` equals `PlacementScale(LBUH, ...)` once Tim chooses.
    - **23 Oct status:** NEW, **BUG-954**. **Severity:** MEDIUM (source-verified, not re-checked today). Needs Tim's word. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

133. **F-133. CEMEMBER refuses the supplier name with decimals ("310UB32.0", "410UB59.7": "no section called ...").** LOW. Structural. OPUS-SE 9. Structural 1.0.121. `DesignCore/SteelSections/CeMemberPrompts.cs:101-117`. NEW. No PR. Code (both forms must work once BUG-818's names land). Sonnet fixer. **Test:** `FindByName(..., "310UB32.0")` returns the 310UB32.0 row.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

134. **F-134. Three engineering tables carry wrong or unsafe values, but nothing reads them yet: lap length 40 x bar size (short by 13 to 31 per cent at f'c 32 MPa), one cover value per exposure class regardless of strength, and steel grades 250/350 for UB/UC (from memory the supplier grade is 300).** LOW. Structural. OPUS-SE 10. Structural 1.0.121. `Assets/Config/rebar-catalogue.json`; `Services/StandardsService.cs:91-116`. Related BUG-534. No PR. Needs Tim's word (cited values on the Settings page). Opus design. **Test:** a guard test that fails the day any command reads `standardLapLength`, `GetMinCover` or `GetSteelGrades` uncited.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

135. **F-135. The RC section detail invents a bar size when the bar is not in the list (N40 bottom bar drawn as a 16 mm dot, with no message).** LOW. Structural. OPUS-SE 11. Structural 1.0.121. `Commands/SectionDetailCommands.cs:93-100`. NEW. No PR. Code (say UNKNOWN, do not invent). Sonnet fixer. **Test:** BotBarSize "N40": a plain line "N40 is not in the bar list", no 16 mm dot.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

136. **F-136. The wind class suggestion has no shielding question, so a fully shielded and an unshielded lot on the same terrain get the same class (often one class apart, N2 against N3).** LOW. Structural. OPUS-SE 12. Structural 1.0.121. `Rules/WindClassSuggestion.cs:33-43,84`. Related BUG-534. No PR. Needs Tim's word. Opus design. **Test:** shielding Full versus None gives different suggestions, or a Basis line says shielding was not considered.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

137. **F-137. A vertical CEMEMBER elevation flips "top of member" with the pick order (a 0.01 mm X difference decides which side).** LOW. Structural. OPUS-SE 13. Structural 1.0.121. `DesignCore/SteelSections/CeMemberPlacement.cs:65,66,79,80`. NEW. No PR. Needs Tim's word (or ask which side). Sonnet fixer after the ruling. **Test:** points (0,0),(0,3000) and the reverse give the same side.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

138. **F-138. SBEAM writes the section list's wrong stiffness and mass into every member it places, and after the list is corrected SBEAMEDIT may read older members as "changed".** LOW. Structural. OPUS-SE 14. Structural 1.0.121. `SbeamPlacementPersistenceContract.cs:451-454`; `UI/Dialogs/SteelSectionPickerDialog.xaml.cs:242-245`; `SteelSectionPickerDialog.Edit.cs:130-133`. BUG-818 (related). No PR. Code (after the list correction). Sonnet fixer. **Test:** place a 150PFC, then correct the list: SBEAMEDIT reports no change the drafter did not make.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

139. **F-139. Structural's shared window host copies screen pixels into WPF window sizes, so Drawing Sheets, Settings and others can open too large and run off the monitor at 150%.**
    - **Severity:** HIGH (conditional on a 150% transform). **Area:** Structural. **Sources:** HUNT-WINDOWS 1. **Installed:** Structural 1.0.121.
    - **For Tim:** on a 5120 x 1440 screen at 150% the lower buttons of CESHEETS can sit beyond the visible screen.
    - **Where:** `Modules/Structural/UI/AutoCadWindowHostHelper.cs:49,59,61,102,105,112,118,164`; callers `Commands/SheetsCommands.cs:25,26`, `Services/CeSettingsUiService.cs:39`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (convert pixels to WPF units, clamp to the monitor work area). **Lane:** Codex build (a window fix, then a Codex look). **Test:** CESHEETS at 150% on the ultrawide: every footer button's rectangle lies inside the work area.
    - **23 Oct status:** NEW, **BUG-955**. **Severity:** MEDIUM (first rated HIGH) (re-checked today). Opus check: real at any display scale above 100 per cent; the window can still be moved. **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

140. **F-140. Several Structural windows have minimum sizes bigger than a 1080p screen at 150% (beam picker 1340 x 820, RC member 1060 x 850, Settings 1180 x 850), so their buttons cannot be reached even by dragging smaller.**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** HUNT-WINDOWS 2. **Installed:** Structural 1.0.121.
    - **For Tim:** the SBEAM picker or Structural Settings cannot show Place or Save on a 1920 x 1080 laptop at 150%.
    - **Where:** `Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml:5`, `RCMemberDialog.xaml:5`, `CeSettingsDialog.xaml:5`; `Commands/SbeamCommandRunner.cs:30`; `UI/AutoCadWindowHostHelper.cs:104,204`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Codex build (then a Codex look). **Test:** SBEAM at 1920 x 1080 and 150%: Cancel and Place are inside the work area.
    - **23 Oct status:** NEW, **BUG-956**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

141. **F-141. Pressing Enter in the Settings search with no matches saves the whole draft and closes Settings.**
    - **Severity:** MEDIUM. **Area:** Wording and windows. **Sources:** HUNT-WINDOWS 3. **Installed:** Civil 3.0.70.
    - **For Tim:** change a value, mistype a search, press Enter, and the change is saved when you were still looking.
    - **Where:** `Modules/Drainage/Dialogs/AdvancedSettingsDialog.xaml.cs:57,62`; `AdvancedSettingsDialog.xaml:237,1432`; `ViewModels/AdvancedSettingsViewModel.cs:1104,1113`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** change a field, search "zzzz", press Enter: the window stays open and the stored value is unchanged.
    - **23 Oct status:** NEW, **BUG-957**. **Severity:** MEDIUM (re-checked today). Opus check: verified. **Lane:** Codex or Sonnet; base claude/rel-20261022m.

142. **F-142. "Remember window position" skips Edit Pipe, Edit Pit, New Pit and CDS because CE's own fitting sets the position to Manual first.**
    - **Severity:** MEDIUM (switch-dependent). **Area:** Wording and windows. **Sources:** HUNT-WINDOWS 4. **Installed:** Civil 3.0.70.
    - **For Tim:** with Remember ticked, the most-used editors still reopen at CE's calculated centre.
    - **Where:** `Services/CeWindowPlacementHook.cs:49,100,101`; `Dialogs/PitWindowLayout.cs:27`; `Dialogs/PipeWindowLayout.cs:13`; `Dialogs/AdvancedSettingsDialog.xaml.cs:82`; `Services/WindowSizingService.cs:173`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Codex build. **Test:** `windowPlacement.remember=true`, move PIPEEDIT 200 px left, Cancel, reopen: top-left within 2 px.
    - **23 Oct status:** NEW, **BUG-958**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

143. **F-143. Civil Hub rejects a valid saved position on a second monitor and moves back to the primary screen; other Civil windows also clamp to the primary work area.**
    - **Severity:** MEDIUM. **Area:** Wording and windows. **Sources:** HUNT-WINDOWS 5. **Installed:** Civil 3.0.70.
    - **For Tim:** leave Civil Hub on the big second screen and it comes back on the small one.
    - **Where:** `Dialogs/CivilHubDialog.xaml.cs:419,449,459,467`; `Services/WindowSizingService.cs:189,214,216`; `Services/CeWindowPlacementHook.cs:26`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Codex build. **Test:** two monitors, Hub at Left=2200 on monitor 2: reopens within 2 px.
    - **23 Oct status:** NEW, **BUG-959**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

144. **F-144. The Checks palette and "What CE Found" keep their old dark or light look after the theme is changed, even after closing and reopening them.**
    - **Severity:** MEDIUM. **Area:** Wording and windows. **Sources:** HUNT-WINDOWS 6. **Installed:** Civil 3.0.70 (Checks palette OFF by default).
    - **For Tim:** choose Light while Checks is dark and it stays dark.
    - **Where:** `Controls/ChecksListControl.xaml.cs:12`; `Controls/DrawingCheckPanelControl.xaml.cs:11`; `Services/ThemeService.cs:107,118,219,220`; `Services/ChecksListPaletteService.cs:57,59`; `Dialogs/AdvancedSettingsDialog.xaml.cs:24`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code. **Lane:** Codex build. **Test:** Dark, open CDCHECKS, switch to Light: the palette BackgroundBrush equals LightTheme.xaml.
    - **23 Oct status:** NEW, **BUG-960**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

145. **F-145. Test-critical fields in Manager and the import review lists have no stable name (no AutomationId or label), so an automated check cannot reliably pick "running build" versus "installed build".**
    - **Severity:** MEDIUM. **Area:** Wording and windows. **Sources:** HUNT-WINDOWS 9. **Installed:** Civil 3.0.70, Manager 1.1.70.
    - **For Tim:** the robot can read the wrong value and pass the window.
    - **Where:** `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:47,52`; `Modules/Drainage/Dialogs/CivilImportWindow.xaml:133,171` (static inventory in the source: 4,542 declarations without a direct identity, mostly labels). **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (see CODEX_BUILD_AUTOMATION_IDS_22OCT.md). **Lane:** Codex build. **Test:** UIA finds the running-build and installed-build fields by name, one match each.
    - **23 Oct status:** NEW, **BUG-961**. **Severity:** MEDIUM (source-verified, not re-checked today). #1527 adds the names (MERGE-WITH-FIXES). **Lane:** Codex or Sonnet; base claude/rel-20261022m.

146. **F-146. The About window (CE_VERSION) is always painted with Manager's light palette while AutoCAD and Manager are dark.** LOW. Wording and windows. HUNT-WINDOWS 7. Manager 1.1.70. `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml:14`, `CeVersionWindow.xaml.cs:17`; `Commands/PluginManagerCommands.cs:31`. NEW. No PR. Code (attach the same appearance service as Manager). Codex build. **Test:** COLORTHEME 0 then CE_VERSION: the About background equals the dark theme value.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

147. **F-147. Escape at "Press Enter to reopen CDEDIT:" in Edit 2 Pipes' Inspect Drawing reopens the editor instead of cancelling.** LOW. Wording and windows. HUNT-WINDOWS 8. Civil 3.0.70. `Commands/BatchEditDialogHost.cs:38,43,47,48`. NEW. No PR. Code (honour the cancel). Sonnet fixer. **Test:** Esc at that prompt: no window reappears and both pipe diameters are unchanged.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

148. **F-148. A normal pit-record refresh compares every pit with every remembered pit (quadratic), even when all identities are intact, before some commands show their first prompt.**
    - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Sources:** HUNT-PERF PERF-01. **Installed:** Civil 3.0.70.
    - **For Tim:** with 2,000 pits in a 10,000-entity survey, typing CDSPOONDRAIN makes CE do about 4,000,000 comparisons before asking for a point, and repeats it every time.
    - **Where:** `Modules/Drainage/Services/ProjectDataRecoveryGuardService.cs:100,117,126,140,169,178`; `Services/ProjectDataService.cs:254,638,660`; `ProjectDataService.Recovery.cs:794`; `Commands/SpoonDrainCommand.cs:39`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (index position candidates once; keep the identity-first rule). **Lane:** Sonnet fixer. **Test:** 2,000 identified pits: candidate work roughly doubles from 1,000 to 2,000 pits (not quadruples), and the co-located recovery fixture still restores the right values.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (first rated MEDIUM) (re-checked today). Opus check: real, but tens of milliseconds.

149. **F-149. Tidy labels tests every distant survey text against every pipe's search area (N texts x P pipes) before planning.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-PERF PERF-02. **Installed:** Civil 3.0.70 (Tidy labels OFF).
    - **For Tim:** 9,000 survey notes and 500 pipes means 4.5 million rectangle tests just to find that the notes are nowhere near a pipe; Yes repeats the work.
    - **Where:** `Services/LinkService.TextClashTidyUp.cs:142,159,191,330,679-747`; `Commands/TidyLabelsCommand.cs:57,92,154`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (a spatial lookup; keep local obstacle completeness). **Lane:** Sonnet fixer. **Test:** 500 pipes and 9,000 distant texts: the distant-text predicate count falls from 4,500,000 to about one test per text.
    - **23 Oct status:** NEW, **BUG-962**. **Severity:** MEDIUM (source-verified, not re-checked today). **Lane:** Sonnet (protected file); base claude/rel-20261022m.

150. **F-150. Moving each pit searches every pit's label memory, twice on an ordinary MOVE (O(pits x attachments)).**
    - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Sources:** HUNT-PERF PERF-03. **Installed:** Civil 3.0.70.
    - **For Tim:** moving 1,000 pits with two labels each does about 4,000,000 prefix checks per MOVE even when no label was deleted.
    - **Where:** `Services/LinkService.PipeMoveHelpers.cs:229,270,423`; `Services/LinkService.PitMoves.cs:235`; `Services/LinkService.SourceMoves.cs:268-302`; `Services/LinkService.Reactors.cs:1136`. **BUG:** NEW (see 23 Oct status). **PR:** none. **Fix kind:** code (key the cache by pit, or prune once per command). **Lane:** Sonnet fixer. **Test:** the second MOVE of 1,000 pits: prefix evaluations drop from 4,000,000 to about the 2,000 own entries; one U restores pits and labels.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (first rated MEDIUM) (re-checked today). Opus check: real, but well under a second per MOVE.

151. **F-151. The record-refresh cache keeps an entry for every closed drawing for the whole AutoCAD session.** LOW. Civil commands. HUNT-PERF PERF-04. Civil 3.0.70. `Modules/Drainage/Services/ProjectDataService.cs:80,238,599,698`; `Services/LinkService.cs:1638,1683`. NEW. No PR. Code (clean up on document close; do not dispose AutoCAD-owned wrappers). Sonnet fixer. **Test:** open, run CDSPOONDRAIN, close 20 copies: the cache holds no key from a closed copy.
    - **23 Oct status:** LOW, no carpark entry. **Severity:** LOW (source-verified, not re-checked today).

---

## Faults inside the draft fix PRs (fix before merge; not carpark entries)

From REVIEW_CODEX_PRS_A (9 PRs: HIGH 3, MEDIUM 12, LOW 20) and REVIEW_CODEX_PRS_B (17 PRs: HIGH 0, MEDIUM 15, LOW about 17). These are faults in unmerged fixes, not in the installed code, so they are tracked on the PRs, not in the carpark.

1. **#1534 wording (HOLD), HIGH x2:** garbled characters in Checks text and 9 command help lines at the pushed head; no test result at that head. It carries F-065, F-083, F-084, F-085. Repair first.
2. **#1528 CE_TEST_STATE (HOLD), HIGH:** not read-only (CE's own start and end handlers still run); never built or tested.
3. **#1526 Settings rows, MEDIUM x2:** tallest tab 673 px over the 670 px limit (move the three Drawing checks ticks to Newer tools); untrue progress tooltip ("status-bar line", "Esc cancels").
4. **#1531 pit floor, MEDIUM x2:** with the switch ON a pit with no recorded floor loses two rules (pump stations); a pipe below the floor still disagrees with R-29.
5. **#1537 pipe material (HOLD), MEDIUM x2:** default OFF keeps BUG-868 live (review says ON); two answers for an Unknown-material pipe.
6. **#1538 CDTWL units, MEDIUM:** flip the default to ON. **#1551 held grade, MEDIUM:** default should be ON; wiring is protected (Claude builder).
7. **#1549 small engineering, MEDIUM:** R-03 prints six decimals on every row. **#1530 real length, MEDIUM:** fix the robot check text.
8. **#1539 FB-01 (HOLD), MEDIUM:** the helper cannot settle the brief's own drawing. **#1550 FB-06 (HOLD):** rule only, protected writer not built.
9. **#1541, #1542, #1543, #1544 (FB-02, FB-04, FB-07, FB-05): REJECT as PRs** (notes only, no code; a log entry would claim work not done). Keep their analysis; the fixes need a Claude builder on the protected files.
10. **#1535 Manager support, MEDIUM:** ships one deliberately failing palette guard (the palette fix is protected: route to Sonnet, F-219). **#1536 guard tests, MEDIUM:** goes red as soon as #1524 lands unless two test lines change.
11. **#1547 / #1548 outcome lines, MEDIUM x3; #1527 automation ids, MEDIUM; #1524, MEDIUM:** AutoCAD proof owed (cases 3 to 8 of its checklist).

---

## Test tooling (REVIEW_TEST_RUNNER, driver v3 phase 1; not shipped to colleagues)

33 findings on the new AutoCAD test runner: **HIGH 6** (1 clean-up acts on an AutoCAD the session never started and can close Tim's AutoCAD left on the Start tab; 2 no time limit on clean-up calls and a dead runner is not noticed; 10 calibration cannot see an error growing towards the screen edges; 11 a stale stored view gives a silent miss; 12 the angled DP text target is a guess and a miss was logged as "no window opened", a false fact in the BUG-859 decision; 32 two passes prove repeatable, not right), **MEDIUM 15** (3, 4, 5, 6, 13, 14, 15, 19, 22, 23, 26, 28, 30, 31, 33) and LOW the rest. Verdict GO WITH FIXES; **no unattended run until 1, 2, 11 and 12 (and 10's nine-point calibration) are fixed and re-reviewed.** Tracked in that review's fix order, not in the plugin carpark.

---

## False or unproven, with the evidence

1. **F-185 (S09-02) FALSE.** `Modules/Drainage/Services/UcsGuardService.cs:401` sets the UCS to World on CommandWillStart for every CE command (PITEDIT is in the list at :62) and restores it at :470, so Edit Pit never transforms an already-world point twice. PitEditCommand.cs:48-52 logs the guard on entry.
2. **F-241 (B7) half false.** An open Survey Review does follow a new survey (`SurveyIntakeReviewView.cs:44` re-renders on `SurveyIntakeReviewSession.Changed`, raised by CDSURVEY). Only the swallowed error is real (LOW).
3. **F-019 partly false.** The installer EXE never unpacks the rebuilt payload (all extraction is inside `#if false`, Installer/Program.cs:21-619); the live risk is a hand install copying the script's freshly built bundle.
4. **F-060 partly false.** The Settings window does say "Settings could not be saved because the settings location is unavailable"; only routine "last used" saves fail silently.
5. **COMPAT-02 (F-222) partly.** The name-prefix fault is real, but the helper library only loads with the main Structural file, so a colleague does not normally reach it (LOW).
6. **S02-01 and S03-02 (F-183, F-184) are not Pit Schedule or MLINE faults on their own:** every Civil pipe-width writer, CD included, assumes 1 unit = 1 mm. They belong to Tim's open metre-drawing question.
7. **Unproven, kept as questions:** F-047 (CDTWL double counting; suspected), F-059 (long profile paths on older AutoCAD; suspected), B5 load order (F-239), B9 timing (F-243), B10 harm (F-244).

---

## Sources read

1. **First ledger and its 14 sources** (AUDIT_C58_C60_S40_S41, AUDIT_ENGINEERING_CIVIL, AUDIT_ENGINEERING_STRUCTURAL, AUDIT_UI_WORDING, CODEX_AUDIT_CIVIL / STRUCTURAL / GATE, CODEX_HUNT_UNDO / IMPORT / LABELS / MANAGER / PERF / WINDOWS): carried as Part B; their HIGH findings and the likely top-30 MEDIUMs re-checked today.
2. **New today:** CODEX_SWEEP_S01 to S16 (62 findings: answer-first and every finding line), CODEX_HUNT_RECORDS (7), DESIGN (5), PRIVACY (4), COMPAT (3), STRUCTCMDS (5), REVIEW_CEMEMBER_AND_MANAGER (12 Manager findings; CEMEMBER part has none), REVIEW_TEST_RUNNER (33, tooling), REVIEW_CODEX_PRS_A and B (26 PRs), CODEX_BUILD_* reports (PR to finding map), FIX_BRIEFS_9NOV (FB-01 to FB-25), CARPARK_RECONCILIATION (status context; its 20 release blockers cross-checked with the 12 above) and BUG_CARPARK BUG-856 to BUG-872 plus the three named entries.
3. **Checks:** nine read-only checker batches (Opus V1, V2, V3, V7, V8; Sonnet V4, V5a, V5b, V6) read every new HIGH and MEDIUM (except Manager review items B1, B2 and B4, already read by that Opus review and the #1535 PR review) and 29 first-ledger findings at the installed commits through `git show`. Results: 111 verified, 11 partly, 1 false, 0 unproven.
4. **Not done:** no build, no test run, no AutoCAD, no Codex; BUG_CARPARK.md not edited; source-verified findings not re-checked today are marked so.
