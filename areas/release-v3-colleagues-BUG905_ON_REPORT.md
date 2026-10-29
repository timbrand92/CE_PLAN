# B-033 BUG-905: CDCALC Boyd's hard-ground runoff 0.9 switched ON (draft PR)

**Run:** Thu 29 Oct 2026, Melbourne time. Team, Sonnet. Base `claude/rel-20261026z` (Civil 3.0.85, `09126560`). Branch `fb/bug905-hard-ground-on`. Every build used `-p:SkipDevBundle=true -nr:false --disable-build-servers`. AutoCAD was not started. Nothing closed, retargeted, deleted or marked FIXED. `CE_SHARED` untouched.

---

## FOR TIM (read this first)

1. **What changes on the drawing side:** in CDCALC, the Boyd's tab will now count roof and paved area at 0.9, not 1.0. It is the same figure CDDESIGN already used, so one site now gives one storage figure in both. Your OSD4W printout also uses 0.90 for existing hard area.
2. **Worked example (the Boyd's tab's own sample site):** site 746 m2, roof and paved 414 m2, soft ground 332 m2 at 0.30.
   1. **Before:** effective area 414 x 1.0 + 332 x 0.3 = **513.6 m2**, overall C 0.688.
   2. **After:** effective area 414 x 0.9 + 332 x 0.3 = **472.2 m2**, overall C 0.633. That is the same C CDDESIGN reports for that site.
   3. **Storage:** smaller. On the default storm rows and a 7.9 L/s discharge the Boyd's volume moved from 2.56 m3 to 2.08 m3 (a test read this from the program). The worst storm on the default figures moves from 10 min to 5 min.
3. **What you will see change:**
   1. **CDCALC Boyd's tab:** Effective area, overall C, storage volume and critical duration. Nothing else on the tab.
   2. **A Boyd's result saved earlier** (worked at 1.0) will say "Results need checking" until you work it again.
   3. **CDDESIGN, CDCHECK and CDRULES answers do not change.** CDDESIGN already used 0.9.
4. **Where 0.9 lives:** still in Settings (`detention.hardGroundRunoffC`, 0.9), not in the program. Change it there and both CDCALC and CDDESIGN follow.
5. **Switch:** `detention.boydsUsesHardGroundC`, now ON. An older Settings file with no entry reads ON. A file that says false stays false (the old 1.0 comes back exactly).
6. **My mistake, first:** I did not confirm the 0.9 against the Civil and Drainage Design Guidebook. The guidebook notes in `02_COUNCIL_RULES` do not state a hard-ground C; the Engineering Rulebook lists "impervious C 0.90" as an office value. So 0.9 rests on your word and the rulebook line, not a guidebook page. If the guidebook disagrees, change the one Settings value.
7. **Not proven:** nobody has opened this in AutoCAD. Built and unit-tested only.
8. **Test in AutoCAD (copy of a job):** CDCALC, Boyd's tab. Type site 746, roof and paved 414, soft ground 332 at 0.30. Effective area reads **472.2 m2** (not 513.6). Then close AutoCAD, set `detention.boydsUsesHardGroundC` to false in a fresh copy of the Settings file, reopen: it reads 513.6 again.

---

## TECHNICAL DETAIL

1. **PR:** #1856 (draft) against `claude/rel-20261026z`.
2. **Where the fix lives (confirmed on the shipping line):** HUNT2-C-06 added `detention.boydsUsesHardGroundC` (default OFF) and `detention.hardGroundRunoffC` (0.9), merged into train C-35 (9 Oct). On 3.0.85: `Modules/Drainage/ViewModels/BoydsCalcViewModel.cs` about line 233 (the effective-area line reads `AutoDesignService.HardGroundRunoffC` when the switch is on, else 1.0); `Modules/Drainage/Services/AutoDesignService.cs` about 62-69 is the single reader of the Settings value (blank, zero, negative or above 1 falls back to 0.9). The carpark's file names still hold; the carpark and window text are stale about the fix existing (as batch 4 said).
3. **Change:** `Modules/Drainage/Models/UserSettings.cs` `BoydsUsesHardGroundC` default false to true, documentation now ends "Default: on."; comment in `BoydsCalcViewModel.cs`. No new key, no new write, command, regen, view or system variable.
4. **Tests changed or added:**
   1. `HardGroundRunoffCTests`: default ON and written as true; empty file, older file and typed true read ON, typed false reads false, through BOTH `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant`; other detention defaults unchanged; switch OFF gives 513.6 (the control); ON gives 472.2; `hardGroundRunoffC` 0.8 flows to the Boyd's tab (value from Settings).
   2. Four existing tests pinned the old 1.0 figures and now pin the switch OFF: `BoydsCalcViewModelTests`, `BoydsStartsBlankTests`, `KingstonCdcalcRecordedOriginTests` (this fixture also had Assume lines that would have silently skipped at 0.9), `StormStillRisingTests` (also pins the ON answer, 5 min).
5. **Results:**
   1. Focused net10 run: 92 passed.
   2. Full Civil net10 run (20,812 tests): 20,775 passed, 5 failed, 32 skipped. Two of the five were mine (`StormStillRisingTests`, `KingstonCdcalcRecordedOriginTests`): fixed, then re-run with their fixtures: pass. `Diagnostic_MessagesReachTheLogFile` failed in the full run and passes alone (log-folder interference, not Boyd's). Two IL-shape tests (`FinalLandingProducerCollapses...`, `RefusedNativeCallbackInvalidatesTheManagedSession...`, both in `SourceAtomicCoordinatorDependencyTests`) still fail: they inspect code I did not touch, and the same two are in the known-failures note. I did not build the base to prove them pre-existing.
   3. **The full suite was not re-run after the two pin fixes** (the first full run took about 50 minutes on a busy PC and one earlier full run hung and had to be stopped); only the affected fixtures were re-run. Say so if you want a clean full run in the assembly.
   4. net48 compile of the Civil project (Debug): 0 errors, 242 warnings.
6. **Switch-off control:** with the key false, 513.6 m2 and 10 min critical storm return exactly (tests above).
7. **Not proven:** AutoCAD behaviour; the guidebook value (see FOR TIM 6); Settings page row (none exists for this key, none added); the two IL-shape failures on the base.

## Robot case (name in the N31 / C31 style): C32_boyds_hardc

1. **Setup:** fresh copy of a job; Settings copy with `detention.boydsUsesHardGroundC` absent (default ON). AutoCAD started by the robot.
2. **Types:** `CDCALC`, Boyd's tab, then site area `746`, roof and paved area `414`, soft ground area `332`, soft ground C `0.30`, permitted discharge `7.9`.
3. **Checks (ON):** the Effective area field reads **472.2** and the Overall C reads **0.633**; the storage volume reads about **2.08 m3**.
4. **Control (OFF), case C32_boyds_hardc_off:** same typing after the robot sets `boydsUsesHardGroundC` to false in a byte copy of Settings before launch (the setting is read at start-up, not mid-session): Effective area **513.6**, Overall C **0.688**, volume **2.56 m3**.
5. **Optional second check:** run CDDESIGN on the same site: its "Hard ground C (impervious, post-dev)" line reads 0.90, matching the ON case.
