# TOOL NOTE: Design inputs (CDDESIGN)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Opens the Design window** (tabs: Start, Setup, Areas and route, Results, During) where you set the job's council, land use, areas, head and detention answer, and work out the design.
2. **Can confirm the legal point of discharge** (picked in the drawing) and, in From-markup mode, confirm the agreed setup.
3. **Can offer figures from the job's rating report and council letters** found in the job folder.

## 2. What it changes in the drawing

1. **Before anything is asked** it marks the drawing as a CE drawing (Structural drawings are skipped).
2. **Work out design:** nothing; it says "nothing has been drawn".
3. **Save Draft:** writes the design draft into the drawing, and land use and council into CE's record if changed. Draws nothing, agrees nothing.
4. **Confirm setup** (From-markup mode): land use, council, draft, and the agreed design.
5. **Confirm LPD:** saves land use, places the LPD marker (GUIDELINES) and note (25TEXT), writes the outlet record. Says "One U reverses this change".
6. **Cancel or Close:** nothing new (a line says if a changed council was not saved).

## 3. What it will not do

1. **No start-up checks:** read-only, REFEDIT, Paper Space and drawing type are checked only at Confirm LPD, after the window.
2. **Confirm LPD refuses** a locked or protected output layer ("LPD was not placed. The prepared output layer 'X' is protected or unavailable"), an existing LPD on a locked layer or Xref ("The existing LPD is protected by AutoCAD. Nothing was changed"), and REFEDIT ("Finish REFEDIT before confirming this outlet").
3. **No whole-drawing record update;** it reads CE's record as already loaded.
4. **Reading council letters and rating reports needs AutoCAD 2027.**

## 4. What it asks you, and what Enter means

1. **"Look through this job's folders for its rating report and offer the site and roof areas?"** (inside a job folder, when something is missing): Enter = Yes. Esc skips. Then "Use the report's site area, or keep what is entered?" for each mismatch: Enter or Esc = Keep.
2. **Markup found:** "Switch this discipline to From markup / supplied design?" Enter = Yes; Esc = No ("Staying on Design from scratch").
3. **No council loaded:** the job-folder suburb offer. Enter = Yes, unless the job names a council CE does not know, then Enter = No. Then possibly a council-letter search (2027 only).
4. **Design window:** no default button. Cancel (Start tab) or Close; Esc closes.
5. **Confirm LPD: "Pick the legal point of discharge or press Esc":** Enter or Esc cancels: "No outlet picked. Nothing changed." and the window comes back with your edits. Then "Pick the LPD note location or press Enter for beside the outlet": Enter = beside the outlet.

## 5. When it says Unknown or "needs checking"

1. **Damaged draft:** "The saved Design draft could not be read. Starting a fresh draft." (and the next Save Draft replaces it; see 7).
2. **Which rainfall curve was used** is noted (the office curve unless a Settings switch is on).

## 6. How to undo it

1. **Confirm LPD: U once** (it says so). Save Draft and land use are also inside the one command. Not proven in AutoCAD.

## 7. Known faults

**Still there in this build**
1. **BUG-866:** the office rainfall curve is used for detention; its own note says it reads about 7 to 9 per cent high. Needs Tim's word.
2. **BUG-1088:** the pipe sizer takes the first size that works at any needed grade, with no preferred grade.
3. **BUG-1096, 1100:** no reuse tank is set and no "ask on every job" step exists.
4. **BUG-1099:** the council's own before-development C and lot-size Tc table are stored but never used.
5. **BUG-1110:** warns about council C values it never uses; soft-ground C always from Settings.
6. **BUG-1116:** lots of 1,000 m² and over get no note.
7. **BUG-1143:** an unreadable draft is overwritten by the next Save Draft with no backup.
8. **BUG-1156:** an older CE can wipe newer agreed-design answers (the draft has no version).

**Partly fixed**
1. **BUG-319:** a typed area over CDCALC's is kept but CDCALC's wins on reopen; areas with thousands separators are not read.
2. **BUG-342:** two of six parts fixed; the older-build wipe is BUG-1156; paste and array parts not checked.
3. **BUG-508:** a note says which curve the flows used; the job curve is used only with a switch (off).
4. **BUG-538:** rising-main sizes are Settings; Bayside storm, reuse credit and the orifice constant still fall back to built-in numbers because no shipped council profile carries them.
5. **BUG-539:** hard-ground C is Settings here; pump sizing still uses a fixed 0.90.
6. **BUG-904:** notes when the worst storm is the first or last; the storm list is unchanged.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-174, 259, 365, 506, 509, 510, 511, 967, 1004, 1091, 1095, 1106:** each has a change in this build (see the sources).
2. **BUG-490, 783, 785, 812:** fixed, but in redesign sign-off and the Pit Schedule, not this window.

**New in code, no bug covers it**
1. **Confirm LPD saves land use first;** if the outlet is then refused, the land use stays saved.
2. **Free-text council and suburb boxes on Start** are not the council the design uses.
3. **Fixed engineering numbers:** office rainfall curve, storm list 5 to 180 min, pump C 0.90, pump ladder and 30 min empty time, Bayside 1 in 20, orifice constant 21.9.

## 8. On AutoCAD 2022 to 2024

1. **No reading of council letters or rating reports:** "CE can read the rating report on AutoCAD 2027". Also on 2025 and 2026.
2. **Everything else the same.**

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.4:** `Commands\CivilDesignCommand.cs:35-157`; `Dialogs\CivilDesignWindow.xaml:35, 152, 188, 211, 223, 333-340`; `Dialogs\CivilDesignWindow.xaml.cs:84-88`.
2. **2.1, 7 new:** `CivilDesignCommand.cs:46`; `Services\ProjectDataService.Persistence.cs:903-957`.
3. **2.2:** `ViewModels\CivilDesignWindowViewModel.cs:805`.
4. **2.3:** `CivilDesignCommand.cs:238-246`; `Services\CivilProjectStartDraftStorage.cs:17, 77-101`.
5. **2.4:** `CivilDesignCommand.cs:215-237`; `CivilDesignWindowViewModel.cs:744`.
6. **2.5, 3.2, 7 new 1:** `CivilDesignCommand.cs:177-213`; `Commands\LpdCommand.cs:279-284, 322-323, 393-398`; `Services\LayerService.cs:471-475`.
7. **2.6:** `CivilDesignCommand.cs:247-251`.
8. **3.1:** `CivilDesignCommand.cs:179` (only pre-flight call).
9. **3.3:** `Services\DetentionTwlService.cs:412`.
10. **3.4, 8.1:** `Services\StormReportReader.cs:201-205`; `CivilDesignCommand.cs:304-312`.
11. **4.1:** `CivilDesignCommand.cs:470-484, 594-603`. **4.2:** `CivilDesignCommand.cs:545-551, 727`. **4.3:** `CivilDesignCommand.cs:95-99, 666, 695`; `Rules\JobCouncilOfferRule.cs:43`. **4.5:** `CivilDesignCommand.cs:160-176, 308, 317-326`.
12. **5.1:** `CivilDesignCommand.cs:50-52`. **5.2:** `Services\AutoDesignService.cs:116-124`; `Models\UserSettings.cs:3296`.
13. **7 still there:** BUG-866 `Rules\RainfallCurve.cs:152-171, 244-247`; BUG-1088 `Services\PipeSizingSolver.cs:39, 197-262`; BUG-1096 `Services\CivilDesignService.cs:147-169`; BUG-1100 `Services\ReuseCreditService.cs:60-63`; BUG-1099 `Rules\CouncilRuleValues.cs`, `Assets\Config\council-profiles.json:842-843`; BUG-1110 `AutoDesignService.cs:324, 722-729`; BUG-1116 `Services\RationalFlowService.cs:375-387`; BUG-1143 `CivilProjectStartDraftStorage.cs:36-41, 88-99`; BUG-1156 `Models\CivilProjectStartDraft.cs`, `CivilDesignWindowViewModel.cs:612-637`.
14. **7 partly:** BUG-319 `CivilDesignService.cs:89-103, 238-240`; BUG-342 `JobCouncilOfferRule.cs:43`, `Rules\DesignKeptAreaRule.cs:20-27`; BUG-538 `UserSettings.cs:3816-3824`, `Models\CouncilProfileModels.cs:223, 245`, `ReuseCreditService.cs:86-95`, `AutoDesignService.cs:436-438`; BUG-539 `Services\PumpSizingService.cs:75`; BUG-904 `Services\DetentionSizingService.cs:158-164`.
15. **7 fixed:** BUG-174 `CivilDesignCommand.cs:476, 545`; BUG-259 `CivilDesignCommand.cs:160-176, 226-237`; BUG-365 `CivilDesignWindow.xaml`; BUG-506 `Services\DesignProposalReport.cs:308-316`; BUG-509 `DesignProposalReport.cs:173`; BUG-510 `AutoDesignService.cs:62-69`; BUG-511 `CivilDesignService.cs:164-166`; BUG-967 `Rules\BlueFactorReport.cs:89-107`; BUG-1004 `Rules\AgreedDesignRules.cs:224-229`; BUG-1091 `Services\SettingsSizingStandards.cs:133-136`; BUG-1095 `AutoDesignService.cs:102-111`; BUG-1106 `Rules\StormReportOffer.cs:123-130`; BUG-490 `Services\NetworkRedesignSignOffService.cs:31-32`; BUG-783 `Services\ScheduleCellOverrideText.cs`; BUG-785 `Services\ScheduleLinkService.cs:2734-2755`; BUG-812 `Services\NetworkRedesignScheduleReviewService.cs:920`.
16. **7 new 2:** `CivilDesignWindow.xaml:59, 63`. **7 new 3:** `RainfallCurve.cs:152-171`; `DetentionSizingService.cs:66-67`; `PumpSizingService.cs:75, 85, 92, 159`; `Services\OrificeSizer.cs:55`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:06. Nothing was run in AutoCAD.
