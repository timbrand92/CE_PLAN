# BUGFIX ff2016b report (4 Nov 2026): PR #2016 CIVIL-OFF-2 fix-first

## FOR TIM

1. **Result: nothing built, nothing pushed, no new PR.** I stopped on purpose. The fix is not small.
2. **What I looked at:** when you answer "Leave it as it is" on an older drawing, CE writes the Civil OFF mark into the drawing straight away. AutoCAD then asks "Save changes?" on close, even though the message says "Nothing in it has been changed". That is the fault in the review (FIX 1). I confirmed it in the code.
3. **Why I stopped:** the proper fix keeps the OFF answer in CE's memory and writes it only during a save you make. That save hook is the one the code already marks as risky (it can run with no drawing lock, and it is where the Undo/REDO bugs came from). The review itself says this needs its own REDO review. It is not a one-line change, and I was told to stop if it is not small.
4. **FIX 2 (Yes must run the one-action upgrade):** skipped as instructed. The one-action path (CDUPGRADEDRAWING) is slice 4, PR #2018, and is not in this branch.
5. **What I recommend:** one of two choices for you.
   1. **Quick:** change the on-screen line to "Marked Civil OFF. Save the drawing to keep this; nothing else was changed." That is honest, tiny, and safe. The drawing still shows "Save changes?" on close.
   2. **Proper:** a separate small job, "hold OFF in memory, write it inside the save", with a REDO review. Tell me which.
6. **Mistakes of my own:** none that touched anything. I lost a little time finding gh, git and dotnet, which are not on the tool PATH. No tests were run, so the APPDATA before/after listings were not needed; no real file could have changed.
7. **Not proven:** all of this is from reading code. Nothing was run, no AutoCAD, no robot.

## Technical detail

1. **PR:** #2016, head claude/civil-off-2 (95390f64), base claude/civil-off-1. Worktree made under C:\CE_WORK\build\ff2016b, removed again. No commit, no push, no branch left behind.
2. **Fault confirmed:** `Modules/Drainage/Services/OldProjectOpenPrompt.cs:78-81` calls `DrawingDisciplineService.WriteExplicitTag(db, DrawingDiscipline.Off)` under `doc.LockDocument()` immediately, then `Say(... LeftAsItIsLine)`. `OldProjectPolicy.cs:26` says "Nothing in it has been changed". The write opens a transaction on the NOD, so the drawing becomes modified.
3. **Why not small:** an in-memory OFF needs (a) a per-Database pending-OFF flag read by `IsCivilOffTagged` (DrawingDisciplineService.cs:120, used at LinkService.Cache.cs:239, PipeObjectUpgradeOnOpenService.cs:111, OldProjectOpenPrompt.cs:63), and (b) a write inside `LinkService.OnDatabaseBeginSave` (LinkService.cs:1255+), which by its own comments must not take its own lock outside the closing case (BUG-257, U1 family). That is a LinkService change plus a REDO review, not a one-commit tweak. Other readers (`ReadExplicitCodeStrict`, lines ~224, 294) would also not see a memory-only mark.
4. **Robot case (for when a fix is built), name proposal `ff2016_leave_clean`:** open a saved old drawing (no CE stamp), answer No on "CE - older project", read the DBMOD system variable (expect 0 with the fix, 1 on the switch-off control) and the command line for the new wording; then QSAVE, close, reopen and read that no question appears. Switch-off control: set `options.askAboutOlderProjectsOnOpen` false before launch and confirm no question and the old pipe upgrade.
5. **Switch:** unchanged, `options.askAboutOlderProjectsOnOpen` ON by default.
6. **Disk:** C: 68 GB free before and after (worktree removed).
