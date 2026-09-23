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
> **Next BUG ID to use:** BUG-166 *(BUG-165 = Manager would treat the old 2026.0420 build number as newer than 3.0.0, 23 Sep 2026)* *(BUG-164 = AutoCAD crashed on close - CE's palette shutdown; fix merged 23 Sep 2026, not installed)* *(BUG-163 = CDWT: AutoCAD cannot continue at the callout point, first seen 16 Sep, logged 23 Sep 2026)* *(BUG-162 = stale Pipe Edit source-text check failing on master since 13 Sep, 23 Sep 2026)* *(BUG-161 = the trunk did not contain what is installed in AutoCAD, 23 Sep 2026; FIXED, PR #87 merged)* *(BUG-160 = grade-held pipe rewrites a hand-typed bottom level on the plan but not in the schedule, 23 Sep 2026)* *(BUG-159 = ordinary rectangle midpoint grips square + no hover menu, 16 Sep 2026)* *(BUG-158 = CDCALC computations sheet silently dropped from export, 16 Sep 2026)* *(2026-09-16: BUG-148 to BUG-157 were already used in REGRESSION_LOG.md by other chats - CDPARTS save/reset, PITEDIT label shift, Pipe/Pit Update truthfulness, save-return signal - so this header was stale and IDs resume above them.)* *(BUG-144 to BUG-147 = R4 batch, 15 Sep 2026)* *(BUG-139 to BUG-143 = R3 batch, 15 Sep 2026)* *(2026-09-15: BUG-127 to BUG-138 are the R2 batch F1–F12; BUG-107 to BUG-126 were used as loose references in older rows and are skipped to avoid a clash.)* *(2026-09-07: BUG-094 to BUG-097 record the CDEDIT repair and lunch verification findings.)*
>
> **BUG-082 status correction (2026-07-27):** FIXED in code. Focused tests and controlled Civil/Structural/Manager net48+net10 builds passed with zero new persistent workers. Historical orphan workers remain a separate one-time cleanup.

> **Monday test target:** 2026-05-12 — 16 items total (12 plugin, 3 LSP, 1 verify-only). See BUG-007 checklist.

> **Round 6 (2026-05-22):** 14-item corrective sweep over R5/R5b output Tim rejected — `IN PROGRESS`, awaiting AutoCAD verification.  See "Round 6 (2026-05-22)" section below.

> **Round 7 (2026-05-22):** 2-item disciplined batch — (R7.1) Breakline rebuilt as a procedural Z-polyline (no more block-rotation surprises); (R7.2) Pit dialog layout tightened.  Coded, units green on both TFMs, awaiting AutoCAD verification.  See REGRESSION_LOG.md "Round 7 (2026-05-22)" section for full detail.

> **Round 11 (2026-05-25):** 3-item Cross-plan break polish — (R11.1) non-rising-main grade calc now uses combined length for all GradeModes (was inverts-only); (R11.2) breakline-end invert stays hidden across refreshes by persisting `SecondInvertHiddenFromPlan` at draw time; (R11.3) CDEDIT respects breakline suppression on unpaired basement halves too (was paired-only).  Both TFMs compile clean, +2 new unit tests in `GradeAutoCalcTests` pass.  Awaiting AutoCAD verification.  See REGRESSION_LOG.md "Round 11 (2026-05-25)" section for full detail.

> **Round 12 (2026-05-25):** 3-item batch — (R12.1 BUG-XAML) CD command crashed at dialog load with `Cannot find resource named 'BaseWindowStyle'` — `ContinueRisingMainDialog.xaml` + `GradeMismatchDialog.xaml` switched from `StaticResource` to `DynamicResource` for theme-level brushes/styles; (R12.2 BUG-CDGR) Cross-plan break paired halves displayed wildly different grades (1 IN 21 vs 1 IN 3 for the same logical pipe) — `LinkService.UpdatePipeGradeFromInverts` now uses the REAL endpoint inverts (basement.FirstInvert + continuation.SecondInvert) and writes the shared label to BOTH halves; (R12.3 BUG-CDIL) Continuation toggle didn't pre-populate the breakline-end IL on the continuation's First Invert field — new `LinkService.TryGetBreaklinePipeBasicsAndInverts` plus a `vm.FirstInvert = basementSecondInvert` set in `TryAttachContinuationAnchor`.  Both TFMs compile clean.  +1 new unit test `BuildGradeValue_CrossPlanPair_UsesRealEndpointInverts_SharedAcrossHalves` in `GradeAutoCalcTests` (23/23 GradeAutoCalcTests pass on both TFMs).  Awaiting AutoCAD verification.  See REGRESSION_LOG.md "Round 12 (2026-05-25)" section for full detail.

---

## Status Summary

| ID | Command / Area | Status |
|----|---------------|--------|
| [BUG-162](#bug-162) | Tests — `InternalCivilCommands_RebuildOnlyAfterAnAcceptedPipeChange` fails on master and on the installed build | OPEN — stale check, not lost code. Found 23 Sep 2026 by the E-HOLD chat. Nothing to test in AutoCAD. |
| [BUG-161](#bug-161) | Release / trunk — `master` did not contain what is installed in AutoCAD; the next install from it would silently remove this month's Civil work | **FIXED — PR #87 merged 23 Sep 2026, master `b02f3ec7`.** Tim ruled: bring it all in, nothing left out. **Proof after merging: commits in AutoCAD but not on master = 0**, and master contains the installed build `d90659cf`, the 16 Sep payload `d0ffe1a2`, the previous master `38f1d98a` and the 23 Sep Civil work `9ba29f04`. Three lanes built 0 errors; 10,125 tests ran with the failing names identical to the recorded baseline. **No AutoCAD test needed — nothing installed by merging; Tim already runs `d90659cf`.** Root cause recorded: register #78's "LIVE RIGHT NOW" was stale, so the 23 Sep trunk ruling was made on the wrong live line. |
| [BUG-160](#bug-160) | Pipe end dragged on a grade-held pipe — plan IL text rewritten over a hand-typed bottom level; schedule keeps the typed number | OPEN — SUSPECTED from reading the code, 23 Sep 2026. NOT seen in AutoCAD. Same drawing-vs-schedule split fixed for CDPROPAGATE on 15 Sep. |
| [BUG-159](#bug-159) | Ordinary polylines (REC / PLINE) — midpoint grips square instead of stretch grips, hover menus gone | OPEN — NOT diagnosed. One suspect (PipePlanGripOverrule, the only unfiltered whole-Polyline overrule, new since 15 Sep). CDGRIPDIAG built to settle it; awaiting Tim run. No deploy. |
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

## BUG-165

**Command / Area:** CE Manager automatic updates (`Modules/Manager/Services/CePluginInstallerService.cs`, `CompareVersions` / `IsNewerBuild`). Area REL. Nothing Tim sees today.

**Symptom:** live in the OLD Manager on Tim's PC (`96e7d76a`): its trace log shows *"staging CE_CVL_SUITE → 2026.0420.1549"* at every AutoCAD start, 54 times since 7 Sep, observed to change nothing (Civil stayed on Version 3). Latent in the new Manager. Older CE builds used date-style version numbers (`2026.0420.1549`, still named in the IT Admin approval of 28 Apr). `CompareVersions` parses both as version numbers, so `2026.420.1549` counts as **newer** than `3.0.0`. If such a build ever carried a valid signed approval, Manager would "update" a Version 3 machine back to it.

**What stops it today:** the new Manager only stages an approval that carries the signed, pinned identity; the April and July approvals do not, so they are refused (*"This approval predates exact signed-content verification"*). Read from source 23 Sep; not run.

**Expected behaviour:** a date-style version is never treated as newer than a 3.x release; going backwards is only ever an explicit rollback.

**Test that catches it:** a unit test: `IsNewerBuild(installed 3.0.0, available 2026.0420.1549)` returns false.

**Steps for Tim to confirm the fix:** none in AutoCAD.

**Reference:** found by the release chat while checking the deploy chat's question "does Manager refuse to go backwards", 23 Sep 2026.

**Status:** OPEN

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

**Status:** IN PROGRESS — fix merged 23 Sep 2026, not installed, not tested in AutoCAD

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

**Status:** OPEN

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

**Status:** OPEN

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

**Status:** OPEN

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

**Status:** OPEN

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

**Status:** OPEN.

## BUG-065

**Command / Area:** `CDIMPORTXCIVIL` — pipe/pit drafting join

**Symptom:** Imported pipes don't terminate on the pit outline (the 35CONT pit box) — they overrun or stop short.

**Expected behaviour:** Pipe ends trim to the pit boundary exactly like hand-drawn CD pipes.

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

**Status:** OPEN — logged 2026-09-14; not fixed. Diagnose before touching either the label or the record.

---

## BUG-099

**Command / Area:** CDINSPECTOR diagnostics text.

**Symptom:** the cover-depth diagnostic reads `Cover depth: 0 mm  âœ—  (min 300 mm)`; the ✗ glyph (`InspectorPaletteService` cover/grade symbols) is rendered as `âœ—`, i.e. UTF-8 bytes shown as Latin-1 somewhere between the service and the palette. Also "Cover depth: 0 mm" on a pit whose cover and invert are both 19.45 — the 0 mm may itself be a data symptom (pit invert = cover level).

**Status:** OPEN — reported 2026-09-14 on the fc42544a test drive.

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
