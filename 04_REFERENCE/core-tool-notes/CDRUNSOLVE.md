# TOOL NOTE: Solve inverts down a run (CDRUNSOLVE)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Works out pipe inverts down a run** from a start pit to an end pit (or the network end), then shows the changes in a preview.
2. **Apply writes the new inverts;** Cancel leaves the drawing unchanged.
3. **Only inverts are written,** not sizes or grades.

## 2. What it changes in the drawing

1. **After Apply:** pipe invert levels in CE's record, the level text on the plan, and pipe-end links.
2. **Before the first question** it runs CE's forced whole-drawing record update, but holds the result in memory: Cancel, Esc or an error puts the record back.
3. **A suggestion record** is written before the preview.
4. **The CE mark** is written only after Apply.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **A pipe on a locked layer** is skipped at write time, after Apply, and named in the summary as still on its old levels.
3. **Needs design flows:** every pit's flow is taken as 0, so a normal run ends with "none of them has a design flow yet" (read from code, not run).

## 4. What it asks you, and what Enter means

1. **"Select the start pit (upstream end) of the run to solve"** (skipped when Edit Pit handed one over): Enter or Esc ends quietly.
2. **"Select the downstream end pit / connection point (or press Enter to use the furthest downstream pit)"** (skipped if a pit named LPD exists): Enter walks to the network end. Esc ends quietly.
3. **Preview window** (only if something changes): Enter = **Apply**. Cancel: "Cancelled - drawing unchanged."

## 5. When it says Unknown or "needs checking"

1. **No design flow:** says so instead of "every invert already matches".
2. **The preview's reason text quotes sizes and grades** that Apply does not write.

## 6. How to undo it

1. **U once** for Apply (one step).

## 7. Known faults

**Still there in this build**
1. **BUG-311:** Cancel or Esc puts back the whole record held in memory, so an edit made in a palette during the questions is lost.

**Partly fixed**
1. **BUG-056:** end-pit pick, anchor and existing-pipe trim are fixed; a last pipe with a blank To is still dropped from the walk.
2. **BUG-999:** the false "already matches" is replaced by a plain error; the cause (every flow is 0) remains.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-290:** the record update is held until Apply and does not overwrite typed levels.
2. **BUG-868:** network sizing uses the pipe material (switch on).

**New in code, no bug covers it**
1. **Every pit's design flow is fixed at 0.**
2. **The run follows the first outgoing pipe by name,** not by schedule set (not proven).
3. **The preview quotes sizes and grades it will not write.**

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1 to 1.3, 2.1:** `Commands\RunSolveCommand.cs:62-212`; `Services\ProposalApplyService.PlanBuilders.cs:105-111`; `Services\LinkService.RepairAudit.InvertPropagation.cs:768`.
2. **2.2, 7 BUG-290, 7 BUG-311:** `RunSolveCommand.cs:77-80, 212`; `Services\ProjectDataService.RecordWriteHold.cs:19-24, 84-86`; `Rules\PipeLevelRefreshRule.cs`.
3. **2.3:** `RunSolveCommand.cs:164`. **2.4:** `RunSolveCommand.cs:194`.
4. **3.1:** `RunSolveCommand.cs:68`; `Services\DrawingSafetyService.cs:61-131`.
5. **3.2:** `InvertPropagation.cs:868`.
6. **3.3, 5.1, 7 BUG-999, 7 new 1:** `PlanBuilders.cs:114-123, 624`; `RunSolveCommand.cs:170-174`; `Services\PipeSizingSolver.cs:63`.
7. **4.1:** `RunSolveCommand.cs:405-467`. **4.2:** `RunSolveCommand.cs:239-266`; `PlanBuilders.cs:509-516`. **4.3:** `RunSolveCommand.cs:176-188`; `Dialogs\ProposalPreviewDialog.xaml:136-143`.
8. **5.2, 7 new 3:** `PlanBuilders.cs:105-111`.
9. **6.1:** `RunSolveCommand.cs:193`.
10. **7 BUG-056:** `RunSolveCommand.cs:232-393`; `PlanBuilders.cs:483, 579-581`.
11. **7 BUG-868:** `Services\NetworkDesignService.cs:98, 262, 708-726`; `Models\UserSettings.cs:2737`.
12. **7 new 2:** `PlanBuilders.cs:480-481`.
13. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:08. Nothing was run in AutoCAD.
