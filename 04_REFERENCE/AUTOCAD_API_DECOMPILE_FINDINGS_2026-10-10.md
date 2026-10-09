# AutoCAD API findings from the decompiled wrapper and headless tests (10 Oct 2026)

**What this is.** Tim, 10 Oct 2026: *"do what you need to and do all the additional things decomp can help with"*.
AutoCAD 2024, 2026 and 2027 .NET wrappers were decompiled (read-only, `C:\Tools\AcadDecomp\`, never in a repo),
26 headless tests and 3 speed measurements ran in the AutoCAD 2027 core console on blank throwaway drawings, and
two read-only audits of the plugin code were done (Civil, Manager and Shared on `master` 650c0c19; Structural on
`claude/struc-d1-prep` d10534e7). The short rules distilled from this are API guardrail 8 in
`ENGINEERING_RULEBOOK.md`. Evidence: `C:\Tools\AcadProbe\runs\` (local only).

**What was NOT tested:** the full AutoCAD window (only the core console), the "Save changes?" order on closing,
AutoCAD 2026 and 2024 behaviour (read from code only, not run), and real job drawings. Nothing in the plugin was
changed.

---

## 1. Crash-risk audit of the plugin: no live crash found

1. **Reading an object after its transaction ended (about 25 places).** Measured harmless today: AutoCAD returns
   the real values, no error. Worst-looking examples, all fine by measurement: `BlockService.cs:230`,
   `CompoundGripOverrule.cs:112`, `RunSolveCommand.cs:314`, `CdSurveyCommand.cs:44`, Structural
   `FoundationService.Marks.cs:357` and `:371`. Undocumented behaviour, so new code should still copy values out
   before Commit; not worth a bug each.
2. **New object disposed before Commit (10 places,** e.g. `TextService.cs:753`, `ArrowService.cs:125`,
   `CdCommand.Breakline.cs:421`, Manager `CeBlocksInsertService.cs:147`, Structural `CeSheetsSyncService.cs:1642`).
   Measured safe: the object stays in the drawing after Commit, and fetching it again in the same transaction
   (`LinkService.Split.cs:2123`, split-pipe level text) gives a fresh working copy (test D7). No place reads the
   disposed copy itself, which is the one thing that does crash AutoCAD (test D5).
3. **Drawing compared or used as a dictionary key (about 25 places).** Measured in 2027 (test G1): different
   wrapper objects for one drawing compare equal and work as dictionary keys. 2024/2026 compare by the same native
   pointer (read, not run). The Test Day 4 note in `DatabaseIdentityComparer.cs` ("dictionary keyed by the wrapper
   misses" on 2027) is NOT reproduced headless; the comparer is harmless, keep it. If the miss is ever seen again in
   full AutoCAD, capture which two Database objects disagreed.

## 2. Speed audit: real but moderate costs, all on "after every command" paths

Measured (2,000 blocks, AutoCAD 2027 core console):
- plain block name read: ~3 ms per 2,000; layer name: ~4 ms; opening every object in model space: ~3 ms per 4,000.
- **real CE dynamic pit (`PIT BLOCK 3`):** CE's effective-name routine (a separate transaction per dynamic block)
  ~110 ms per 2,000 pits; the same with a name cache per block definition ~29 ms.
- **dynamic-block property list:** ~270 ms per 2,000 pits, the costliest read.

Ranked by likely effect on Tim (read from code, cost scaled by the numbers above):
1. **Each moved/edited pipe triggers about 6 whole-drawing pit scans** (`LinkService.Geometry.cs:226`,
   `RemovePipeLinksFromAllOwners` twice + 4 endpoint-owner searches). With 300 pits ≈ 16 ms per scan, about
   0.1 s per pipe: moving 20 pipes ≈ 2 s. Fix: one pit index per command end, reused for every pipe.
2. **Cache rebuild after every U/UNDO/REDO and CE command: three model-space passes**, each classifying pits
   through the slow effective-name routine (`LinkService.Cache.cs:497-702`, called from `Reactors.cs:709` and
   others). Fix: cache "is a pit" per block definition id; merge the passes.
3. **Draw-order pass after nearly every Civil command** (`LayerService.cs:919`) opens every object and reads its
   layer name. Cheap per object (~2 µs) but on 50,000 objects ≈ 0.1 s each time. Fix: compare `LayerId`, skip when
   nothing on those layers changed.
4. **Schedule-cell refresh opens all of model space after every link update** (`ScheduleLinkService.cs:393`).
5. Structural: **`FoundationMonitor` clones the whole foundation registry per modified object**
   (`FoundationService.cs:465`); `ConnectedFollowApply.cs:173` reads support-block names per moved block; the
   Home-panel health sample opens up to 100,000 objects at Idle (`MainPalette.xaml.cs:833`).
- Clean (checked): pipe/pit overrules, hover, ObjectModified reactors, Manager, CE_SHARED.

## 3. Ribbon: why the CE contextual tab had to be propped up

Read in AutoCAD 2027's ribbon code (AcWindows): on every selection change AutoCAD hides every visible tab marked
"contextual" that its own CUIX rules did not ask for. `ShowContextualTab` sets that mark, so AutoCAD hides CE's
tab again, which is why `CeContextualTabController` needs its Idle watchdog (Test Day 5-09/5-10). Just before
hiding, AutoCAD raises the public event `RibbonServices.RibbonPaletteSet.ContextualTabDisplayed`, and its
`e.HiddenTabs` is the very list it then hides. Taking CE's tab out of that list should keep it up with no watchdog
and no flicker. Read only; not tried. The code comment that `ShowContextualTab` "registers the tab with that
manager" is not what the 2027 code does.

## 4. The question list from the audit (a to g): answers

- a. `CommandEnded`: drawing still write-locked by the ending command; writing there worked. `DocumentToBeDestroyed`:
  reports Write lock and application context, but writing there **killed AutoCAD**; in the console it fired after
  the discard-changes answer.
- b. Force-open on a locked layer: straight `ForWrite` + force works (edit commits, layer stays locked); read + force
  then `UpgradeOpen` is refused (eOnLockedLayer).
- c. Reads after Commit: real values, no error. Writes after Commit: AutoCAD dies.
- d. Dispose of a transaction-owned object: no double delete on Abort or Commit; reading the disposed copy kills AutoCAD.
- e. `Database.Insert` onto an existing block name: redefines in place, same ObjectId.
- f. `SaveAs` over its own file: works with OpenForReadAndAllShare (with or without CloseInput); fails safely
  (eFilerError, file untouched) with the stricter share modes.
- g. 2026 vs 2027 API: only `Database.Equals(db1, db2)` / `GetHashCode` changed (see guardrail 8).
