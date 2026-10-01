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
> **Next BUG ID to use:** BUG-327 (BUG-323..326 = Codex VERIFYC5 findings: Edit Pipe route length 30 mm in metre drawing, batch editor refuses whole selection for one legacy pipe, OOPS pit+pipe prints no CE line, AutoCAD fatal error AcSmNav.arx during layer lock) (BUG-322 = pipe label offsets in mm after a schedule edit, redesign approvals not cloned, repeated locked-layer line) (BUG-321 = annotation offsets around scaled pits still mm) (BUG-320 = paste/settings follow-ups from PR #501, BUG-306 design is two PRs) (BUG-319 = CDDESIGN area from CDCALC wins, window should say so at typing time) (BUG-314..316 = Structural Team-lane leftovers: footing memory at close, schedule text/legend questions, settings and units follow-ups) (BUG-317/318 = scaled-pit record size and other PR #497 builder leftovers; test hygiene) (BUG-314..316 left free) (BUG-309..313 = C-5 finalizer leftovers: metre-drawing grade label, OOPS shared-key edge, palette change undone on cancel, held-back labels forgotten on close, native C++ locked-layer opens) (BUG-308 = Codex C4C fails: 80 mm end not linked in a metre drawing, 17-degree landing at centre, CDDESIGN setup not remembered, footer buttons only on Start) (BUG-307 = Glen Eira back-test 34.6% off) (BUG-305 = foreign paste prints no CDREPAIR line and labels stay behind, BUG-306 = New Pit writes CD_Settings.json) (BUG-302..304 = #482 wording, S2 default-on findings, footing follow on 2024) (BUG-300 = Structural footing OOPS and #480 redraw design) (BUG-299 = Structural settings save follow-ups) (BUG-295..298 from the C-4 sign-off: redo-window LOWs, #478 raw distances, 100 mm insertion match, CDFIXPIPEENDS half-change) (BUG-294 = four Structural tests read and rewrite Tim's real CS_Settings.json) (BUG-293 = Edit Pipe grade suggestion in metre drawings still /1000) (BUG-292 record-order level fill, BUG-291 Design grade holds the first drawn end, BUG-290 refresh-before-preview commands) (BUG-285..289 = pipe OOPS has no pipe half, CD to a locked pit one-sided, Metres drawing with mm-sized pits 1000x tighter reach, #450 dropped open-end rescan, CDFIXPIPEENDS no schedule refresh) (BUG-284 = ~15 more locked-layer write paths, BUG-283 = CDIMPORTXCIVIL unlocks ~20 layers, BUG-282 = four cover strips still 600, BUG-281 = saved downpipe radius raw 150) (BUG-280 = two copies of the redo-window rules, Civil and Structural, converge before the V3 single-plugin cutover) (BUG-279 = other Structural places compare AutoCAD Database objects by reference, which never matches in 2027; found by team lane 01 while fixing BUG-275, 1 Oct) (BUG-278 = Edit Pipe + Save can undo the CDFIXPIPEENDS repair (PR #460)) (BUG-277 = Structural bar grip-stretch live length (PR #440), BUG-276 = Structural level set before first save carries into a SAVEAS copy (PR #430)) (BUG-275 = Structural MainPalette compares Database by reference, from PR #459 builder) (BUG-274 = after U of any footing edit the footing monitor redraws the outline again outside a command, so REDO is lost and the drawing is marked changed; from the Opus review of PR #449, 1 Oct) (BUG-273 = a failed Structural job-file save shows raw code text or nothing, from the Opus review of PR #455, 1 Oct) (BUG-272 = Structural job data save fails in AutoCAD 2027 with a Newtonsoft "Method not found", Codex VERIFYS1 log, 1 Oct) (BUG-271 = remaining fixed reach literals + unitless drawings) *(BUG-270 = pipe-end and pit search reaches are fixed 100 mm values not converted for metre drawings (the relink reach in `LinkService.RepairAudit.Relink.cs` / `LinkService.Geometry.cs:1257-1260`, `LinkService.PitOutline.cs:394-405`): same family as BUG-230; BUG-269 = `-ARRAY` of 299 pipes spends 48.8 s in the clean-up (each copied pipe's band, labels and arrow redrawn one at a time, about 163 ms each: `CloneRegeneration.cs:22-60`): do it in one batch with a progress line; both from the Opus review of PR #450, 1 Oct)* (older note follows) BUG-269 *(BUG-268 = a copied pipe already saved wrong by 3.0.16 (From/To names or levels crossed after a pit COPY) is NOT repaired by PR #444 and Edit Pipe + Save re-breaks it: needs a repair command (CDSYNC/CDUPGRADE style, in a command, one Undo, a per-pipe log line, names AND keys moved together); BUG-267 = the OOPS gap for PIT labels is probably the same as the perimeter-drain PD text (#443 fixed the drain only); both from the Opus builders of PRs #443/#444, 1 Oct)* (older note follows) BUG-267 *(BUG-256..266 = Codex verification of the 30 Sep install, 1 Oct 2026 (VERIFYC1: 50 scope items PASS 24 / FAIL 14 / BLOCKED 12; VERIFYS1: 27 items PASS 9 / FAIL 17 / BLOCKED 1): 256 REDO lost after U everywhere (Civil and Structural; the BUG-192 family, the top blocker), 257 tab X Cancel then U names CLOSE, 258 OOPS loses the PD text (BUG-236 fix did not work), 259 CDDESIGN Confirm setup loses the outlet / agreed design, 260 Edit Pipe header/arrow/schedule disagree on direction, 261 false uphill warning on a two-free-end size-only save, 262 locked/skipped messages name handles not items, 263 XCLMTXT invisible review issue, 264 Structural Annotate flyouts cut off, 265 CEADMIN restart request with hotspots 0 + debug lines, 266 far pit COPY takes 5 s in a 304-pipe drawing)* (older note follows) BUG-256 *(BUG-255 = Edit Pipe's own pipe-size suggestion strip still uses a fixed 600 mm minimum cover instead of the rulebook value (council, project, office) while the new Project Review size proposals use the rulebook value: two rules for one behaviour; from the Opus builder of PR #437 fixes F3, 30 Sep)* *(BUG-254 = writing a CE record onto a pit or pipe can silently UNLOCK the item's layer, write, then lock it again: `GetOrCreateLinkDictionary` (`LinkService.Persistence.cs` ~:853-857, 923-937) does this and swallows AutoCAD errors, which conflicts with the native-protection rule (never silently unlock); found by the Opus confirm of train fix A2, 30 Sep; NOT verified by a builder yet)* (older note follows) BUG-254 *(BUG-253 = the pipe batch write protection checks exist twice: `RevalidateSizeTargets` (the pipe size writer, PR #437) and the lambda inside `ApplyPipeBatch` (CDEDIT batch): same helper calls in the same order, only the wording differs: fold them into ONE preflight (design rule 1); from the Opus review of PR #437, 30 Sep)* (older note follows) BUG-253 *(BUG-252 = a silent default pipe roughness of 0.013 remains in the grade-only pipe path (`DesignValidationService.cs` ~:162-163 via `PipeSizingSolver.cs` ~:369) and the Inspector (`InspectorPaletteService.cs` ~:3109), and the roughness word "PE" (`DesignValidationService.cs` ~:31) also matches "EXISTING PIPE" and reads it as PVC; from the Opus confirm of PR #434, 30 Sep)* (older note follows) BUG-252 *(BUG-251 = a Kingston COMMERCIAL job (once the Land use field exists) still uses the RESIDENTIAL PSD storm, pre-development C and time of concentration: K02 gives commercial figures (PSD storm 1 in 10, Tc 7 min, pre-development C the lower of existing C or 0.7); fix = `psdAriBySiteCase` / `tcMinutesBySiteCase` with the same `siteCaseByLandUse` mapping; commercial pre-development C needs the site's existing C so it stays Unknown and needs a Tim card; from the Opus review of PR #433, 30 Sep)* (older note follows) BUG-251 *(BUG-250 = with the older beam-linking ("command 8" linking) switched ON, OOPS after erasing a Structural column still does not relink its beams and prints nothing; the #428 relink sits only in the linking-off branch (`BeamLinkService.Reactors.cs` ~:357-377); the default of `LinkingEnabled` was not read; from the Opus review of PR #428, 30 Sep)* (older note follows) BUG-250 *(BUG-249 = the CDCALC Boyds intensity rows (`BoydsCalcViewModel.cs` ~:87-92: 113 mm/h at 5 min) are fixed numbers not linked to any council or return period; the office curve at 5 minutes gives 105 for 10 years and 88.8 for 5 years; found by the Opus review of PR #427, 30 Sep)* (older note follows) BUG-249 *(BUG-248 = OOPS after erasing a perimeter drain brings the drain back with its record but WITHOUT its PD text, and prints nothing; the same class as BUG-237 (columns); from the Opus review of PR #426, 30 Sep)* (older note follows) BUG-248 *(BUG-247 = two Installer.Tests for the Manager release payload already FAIL on the release line: `ManagerPublishing_RunsOnlyAfterOuterBuildAndValidatesCompleteThreeLanePackage` and `ManagerReleasePayload_HasTrackedManifestAndThreeLaneLocalAssets`; found by the Opus review of PR #425, 30 Sep)* (older note follows) BUG-247 *(BUG-246 = a Pit Schedule cell skipped because its layer is locked / in an Xref / in a reference edit is NOT recorded as out of date: the window's OUT OF DATE badge tracks source changes only; from the Opus review of PR #423, 30 Sep)* (older note follows) BUG-246 *(BUG-244 = after a grip drag / move, an IL-text edit or a relink-all the automatic re-link writes the DRAWN-order levels back, so a pipe between two same-named ends can run uphill again and the arrow is left alone; BUG-245 = a pipe from a pit to an open end still follows drawn order; both from the Opus review of PR #422, 30 Sep)* (older note follows) BUG-244 *(BUG-242 = a raingarden or pavement saved in a metre drawing by the OLD code shows a wrong tiny area (0.0006 m2, shown as "0.0 m2") in the Inspector with nothing saying it is stale; BUG-243 = surface overlay labels are a fixed 250 drawing units tall so unreadable in a metre drawing; both from the Opus review of PR #421, 30 Sep; BUG-241 is left free for the CE_AcadSettings chat)* (older note follows) BUG-241 *(BUG-240 = Tim's real 2027 profile: CE bundle folder 15 times in TRUSTEDPATHS, log folder = the plugin code folder, CE_AcadSettings chat 30 Sep)* *(BUG-239 = council rule findings and the CDAUTO proposal report print internal file paths / GitHub links as the source, from the Opus confirm of PR #420, 30 Sep)* (older note follows) BUG-239 *(BUG-238 = WONT FIX: was read from the Claude app's private registry copy, not Tim's real profile - see its entry; this header said BUG-232 while 232-237 were already used)* (older note follows) BUG-232 *(BUG-230 = other commands assume millimetres (PAVE, raingarden, site-area readers), BUG-231 = PluginInitialization.Terminate still saves at shutdown: both from the Opus reviews of #411/#412, 30 Sep)* (older note follows) BUG-230 *(BUG-224..229 = Codex sweep C1 FINAL report, 30 Sep 2026, installed Civil 3.0.15 / Manager 1.1.15 / Structural 1.0.86: 224 AutoCAD CRASHED closing a saved drawing copy (blocker); 225 Pit contextual tab Close button does nothing; 226 Civil ribbon tooltip says Civil on an Unknown drawing and offers Both; 227 CDS tooltip promises tiers and pages that are not installed; 228 Data Diagnostics tooltip promises a report, CDDIAG prints counts and "coming in v2.1 (PL-032)"; 229 CDMANAGER Draw Order list shows duplicate rows)* *(BUG-223 = CDEDIT / not-drawn-first CD with two same-named ends can still save an uphill pipe, from the #404 Opus review, 30 Sep)* (older note follows) BUG-223 *(BUG-205..222 = Codex pass 18 and sweep C1, 30 Sep 2026, on installed Civil 3.0.15 / Manager 1.1.15 / Structural 1.0.86: 205 CD level-direction choice makes an uphill pipe; 206 OSMODE ended 0; 207 drawn Pit Schedule stale after a pit edit; 208 pipe end grip refused by CE record guard; 209 CDCATCHMENT area 28 million m2; 210 COPY replacement pit unlinked; 211 erase column leaves beam silently; 212 Place schedule fails on a legacy pit; 213 older schedule cannot be re-placed; 214 CEFIND then Esc marks drawing changed; 215 RC needs two U; 216 CDFALLSUGGEST Enter rejected; 217 PD drain shows AG; 218 CSBRACINGPANEL invisible; 219 status bar says v1.1.10; 220 Structural launcher opens unasked; 221 Manager Status cards overlap; 222 Manager Civil settings scroll)* *(BUG-203 and BUG-204 are used, see below; this header said BUG-203 was next until 30 Sep 2026)* *(BUG-202 = constant lag in a Structural drawing on everything - select, hover, draw/edit, move/copy, pan/zoom - Tim suspects polylines, 29 Sep 2026)* *(BUG-195..201 = Codex exploratory run X1 on Civil 3.0.14 / Structural 1.0.85, 29 Sep 2026: XCLMTXT invents floors, Structural schedule text tiny, branch labels overlap, diameter-only CDEDIT changes grade, calculated level labelled staff-entered, CDCHECK Enter does not finish, pit placement jargon)* *(BUG-194 = selecting a plain rectangle in a Structural drawing opens the CE Pipe ribbon tab, Tim live 29 Sep 2026)* *(BUG-192 = REDO says "Nothing to redo" after U in a CE drawing; BUG-193 = typing a size in the Pit Schedule does not resize the drawn pit; both Codex pass 17, 29 Sep 2026)* *(BUG-191 = Inspector "Use plan label" takes a document lock outside a command, suspected unnamed Undo step (U1 family), found by the BUG-190 builder 28 Sep 2026)* *(BUG-190 = CE project data may not reach the DWG on Ctrl+S/close after a palette edit with no command, found by the BUG-189 re-review, 28 Sep 2026)* *(BUG-189 = AutoCAD goes through slow phases after a lot of CE interaction, native SPLINE stays fast, reported by Tim 28 Sep 2026)* *(BUG-188 = CEBLOCKS drops attribute text tags entirely and has no live placement/rotation preview, found by Tim live in AutoCAD, 28 Sep 2026)* *(BUG-186/187 = Codex pass 13 N4 carry-downstream Apply refused, N3 CD preview missing after Existing, 27 Sep 2026)* *(BUG-185 = 45-degree beam against a non-square column refused in metre drawings, train 6 review probe, 26 Sep 2026)* *(BUG-184 = suspected swapped support ends on command 1/2 beams picked right to left, train 6 review, 26 Sep 2026)* *(BUG-178..183 = Codex pass 12 faults on 3.0.5 / 1.0.76, 26 Sep 2026: carry-on Undo, downpipe rollback, contextual tab, STRUCDEBUG unknown, beam command 4, column MOVE Undo)* *(BUG-177 = CDPIPEOBJ is a visible registry command with no ribbon button, found by the release chat's builder while adding Start Here/My Role, 26 Sep 2026)* *(BUG-176 = CDRG places no grated inlet on an ordinary CD-drawn pipe, found by Codex pass 11, 25 Sep 2026)* *(BUG-175 = Edit Pipe decides rising-main destination and reverse arrow from a crude layer-name guess, found in code 24 Sep 2026)* *(BUG-174 = "[CE]" inside command-line questions is offered as a choice, 24 Sep 2026)* *(BUG-173 = Edit Pipe window should match New Pipe; BUG-172 = Civil ribbon pictures misaligned and wrong; BUG-171 = an upgraded old pipe opens as Detention instead of Stormwater; all 24 Sep 2026)* *(BUG-170 = What's New window small, hard to read and partly untrue, 24 Sep 2026)* *(BUG-169 = Structural RC revision cloud "a bit glitchy", symptoms not yet recorded, 24 Sep 2026)* *(BUG-168 = F12 keyword choices can select the wrong action, 24 Sep 2026)* *(BUG-167 = the release zip step (Compress-Archive) hangs intermittently, 23-24 Sep 2026)* *(BUG-166 = double-clicking an IL label starts TEXTEDIT and Edit Pipe never opens; diagnosed, experiment queued, 23 Sep 2026)* *(BUG-165 = Manager would treat the old 2026.0420 build number as newer than 3.0.0, 23 Sep 2026)* *(BUG-164 = AutoCAD crashed on close - CE's palette shutdown; fix installed 23 Sep 12:18, Codex saw three clean closes, awaiting Tim)* *(BUG-163 = CDWT: AutoCAD cannot continue at the callout point, first seen 16 Sep, logged 23 Sep 2026)* *(BUG-162 = stale Pipe Edit source-text check failing on master since 13 Sep, 23 Sep 2026)* *(BUG-161 = the trunk did not contain what is installed in AutoCAD, 23 Sep 2026; FIXED, PR #87 merged)* *(BUG-160 = grade-held pipe rewrites a hand-typed bottom level on the plan but not in the schedule, 23 Sep 2026)* *(BUG-159 = ordinary rectangle midpoint grips square + no hover menu, 16 Sep 2026)* *(BUG-158 = CDCALC computations sheet silently dropped from export, 16 Sep 2026)* *(2026-09-16: BUG-148 to BUG-157 were already used in REGRESSION_LOG.md by other chats - CDPARTS save/reset, PITEDIT label shift, Pipe/Pit Update truthfulness, save-return signal - so this header was stale and IDs resume above them.)* *(BUG-144 to BUG-147 = R4 batch, 15 Sep 2026)* *(BUG-139 to BUG-143 = R3 batch, 15 Sep 2026)* *(2026-09-15: BUG-127 to BUG-138 are the R2 batch F1–F12; BUG-107 to BUG-126 were used as loose references in older rows and are skipped to avoid a clash.)* *(2026-09-07: BUG-094 to BUG-097 record the CDEDIT repair and lunch verification findings.)*
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

## BUG-326

**Command / Area:** AutoCAD FATAL ERROR during Codex VERIFYC5 item C5-12 setup (2 Oct 02:07, installed Civil 3.0.20 / Structural 1.0.88).

**Symptom:** after typing `(command "_.-LAYER" "_LOCK" "25TEXT" "")` the AutoCAD main window disappeared; exception window titled `Exception in AcSmNav.arx ARX Command`, then `FATAL ERROR: Unhandled e0434352h Exception at 905F41CAh` (a managed .NET exception that escaped). Codex did not attribute it to CE; `AcSmNav.arx` is Autodesk's own (Sheet Set / navigation). Cause UNKNOWN: investigation running (Opus a1d3bb4852ccf8d97, report `CRASH_C5_INVESTIGATION_2026-10-02.md`). After the crash the Codex S3 pass could not start AutoCAD normally ("No Profile name exists: Tim", "Customization file load failed ... acad", WebView data-directory error, then "Security - Unsigned Executable File" for CE_STRUC_SUITE.dll: every CE DLL is NotSigned, old and new, so the prompt is not new with 1.0.88; Tim's R26.0 Tim profile has empty TRUSTEDPATHS in the registry view that was read).

**Status:** OPEN (2 Oct 02:20). Do not call it a CE fault until the investigation says so.

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

**Symptom:** (1) footing memory is not cleared at drawing close if FoundationMonitor never attached; pointer reuse could hand a new drawing the old register (fix: Invalidate in `RedoWindowGuard.OnDocumentToBeDestroyed`). (2) every command reads the Database before the undo-family test. (3) #481 LOW 4: `LoadCore` normal-transaction read (`FoundationRegistryService.cs:228`); the drawing-switch inventory test checks file names only; `Database.BeginSave` proof still a follow-up. (4) BUG-304 stays: the Idle redraw has never taken LockDocument (`FoundationService.cs:1593`); needs a 2024 test.

**Status:** OPEN (2 Oct 00:30).

---

## BUG-317

**Command / Area:** scaled pits (from the PR #497 builder).

**Symptom:** the pit RECORD of a pit inserted at scale 0.001 still stores the scaled size (0.6 "mm"): the cause of the 0x0 mm tooltip, wrong Pit Schedule / CDCHECK sizes and a wrong detention length; Edit Pit and Resize writing sizes to scaled pits share it. #497 fixes only the reach/outline reads. Also: scaled-pit linework reads are not cached (cost on a big metre job not measured); CDDESIGN During tab does not compare the orifice head or the detention answer; MOVE logged pipe levels 9.30/9.30 after 9.30/9.00 was entered (Codex C4C, not looked at).

**Status:** OPEN (2 Oct 00:40). Added 2 Oct 01:00 from the Opus review of #497: (4) an offered council accepted from the job folder or letters, then Close, is silently not kept (no "not saved" line); (5) areas taken from the STORM report are saved by Save Draft as if typed, so where they came from is lost on reopen; (6) the Manager version guard (`ManagerReleasePayload_HasTrackedManifestAndThreeLaneLocalAssets`) has been red since the missing `PrepareReleaseCandidateRoot` target; (7) two IL-shape tests (FinalLandingProducer..., RefusedNativeCallback...) fail on the base tip in a Debug build and are not on the known-failure list.

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
