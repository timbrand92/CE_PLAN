1. **ANSWER FIRST — HIGH 1 / MEDIUM 5 / LOW 0.** Six additional findings, verified-by-reading at the nominated Civil release. No AutoCAD result is claimed. Tests below are for the AI test lane, not Tim.

2. **Most important: a label deliberately slid with CE's own menu can be moved again by Tidy labels.** The slide saves its position but does not remember that a person placed it. This happens even with hand-placement protection switched ON. The pit-cover tidy also ignores hand placement.

3. **Other effects on a drawing.** Preview and Apply can choose different moves; a cover text can land outside the area checked in preview; a layout cover text can be reported as moved when it stayed put. Dense drawings hit a fixed stop, while a very small slide setting creates enormous amounts of work before the preview appears.

---

1. **Scope and authority.** Independent labels/tidy-up hunt, 22 October 2026, Melbourne; desk plan/03, card 1.4 and its hand-placement dependency. Read RULES, ROUTER, START_HERE, MASTER_PLAN, the Civil E area and the approved Batch 1 labels card. The specific read-only brief overrides its appended worktree/build/PR text. R-00 and R-27 remain applicable; this report proposes no new hard block or engineering value. Civil + Manager colleague release remains 9 November; Manager administrator work stays parked.

2. **Pinned source.** After `git fetch origin`, Civil/Manager `origin/claude/rel-20261022m` resolves to `40ee0a36f7960145743954b39859eb6c3af92869`; Structural `origin/claude/rel-20261022s2` resolves to `2c9a96942a024888a5ab520600f2d5025de83036`. All finding references below are paths under `Modules/Drainage/` at the Civil commit. Structural's nominated command/callout paths yielded no matching tidy/label-slide implementation in the scoped search; no finding is inferred from that absence. Installed DLL identity was not checked.

3. **Earlier work excluded.** Read `AUDIT_C58_C60_S40_S41_2026-10-22.md` and the Civil, Gate and Structural `CODEX_AUDIT_*_22OCT.md` reports before the hunt. Do not recount their preview-initialisation writes, rejected plain-label rescue reservation, ModelSpace-only obstacle scan, insufficient rescue search margin, ground-versus-paper distance or already-known ordinary candidate unit issue. Xref/hatch avoidance and missing Settings controls were already recorded limitations. The layout finding below concerns a separate writer refusal and false success count, not the previously reported obstacle-space defect.

4. **Evidence and tests.** VERIFIED-BY-READING establishes the source path/arithmetic, not observed AutoCAD behaviour. Suspected host effects are expressly separated below. Every test is NOT RUN. Future fixtures are synthetic disposable drawings, World UCS, millimetres unless stated, with exact CE ownership records and isolated Settings. Fixture creation must check actual entity extents and records before running the command; a visual approximation is insufficient. Repeat applicable native cases on AutoCAD 2024/net48 and 2027/net10. No build, test, AutoCAD, installation, source edit, branch or sub-agent was used. Only this findings file is authored.

**Numbered findings**

1. **F1 — HIGH — hand-placement protection misses CE's own slide/move commands and pit cover text. VERIFIED-BY-READING.**

   **File:line:** `Services/LinkService.PipeAttachmentActions.cs:323`, `:334`, `:340`, `:352`; `Services/LinkService.SegmentAnalysis.cs:278`; `Commands/AnnotationEditCommand.cs:89`, `:105`; `Services/ExternalMutationCommandPolicy.cs:14`, `:51`, `:82`; `Services/LinkService.Reactors.cs:1286`; `Services/LinkService.TextClashTidyUp.cs:244`, `:251`, `:312`; `Services/LinkService.TidyPitText.cs:87`, `:100`.

   **What happens in AutoCAD:** right-click a pipe label, choose **CE Civil: Slide along pipe**, and place it carefully beside other notes. Later Tidy labels can move it again. Moving a pit's cover level text by hand does not protect that text from the pit-cover tidy either.

   **Exact failure:** with `HandPlacedLabelsStay=true`, the slide writer rebuilds the attachment with `PlacedByHand = previous?.PlacedByHand ?? false`. Its only explicit change to this flag is clearing it for Reset Position. The only production assignment to true is in `TidyOnePipe`, reached with `placedByHandHandles` from the successful external attachment-move route. `CDPIPEATTACHMENTACTION` and `CDANNOTATIONEDIT` are absent from the external-command tracking lists. CDANNOTATIONEDIT updates placement but does not call that marking path. Separately, the pit-cover planner constructs `new TidyItem(box, true, candidates)` without consulting hand placement at all. These are missing protection paths with the switch ON, not criticism of the deliberate OFF default.

   **DETERMINISTIC TEST — pipe fixture:** one straight CE pipe P1-P2, one ordinary pipe label L1 with exact original placement and `PlacedByHand=false`, all layers unlocked. Enable `TidyLabelsEnabled` and `HandPlacedLabelsStay`; disable pit tidy, neighbour rearrangement and leader-out. Put other attachments outside the test area.

   **Typed/click steps:** select L1 and right-click **CE Civil: Slide along pipe**; pick a point 250 mm farther along the pipe. Assert CE log contains `Civil pipe attachment action accepted: action=SlideAlongPipe`. Record L1's new position and inspect its saved attachment flag. Add ordinary MTEXT `CLASH` over L1, leaving at least its original position clear. Type `CDTIDYLABELS`, `Select`, select P1-P2, Enter; answer Yes if offered.

   **Assertion:** the accepted hand action must set the flag true; preview must count L1 as placed by hand and its position must remain identical after Yes. Source instead retains false and offers an automatic move. Repeat independently with `CDANNOTATIONEDIT`, select L1, `Move`, base `0,0`, destination `250,0`; assert the same lasting protection. Compare with ordinary `MOVE` of L1 alone as a control; do not assume every grip route is equivalent.

   **DETERMINISTIC TEST — cover fixture:** CE pit P3 connected to the selected pipe, cover text C3, `TidyMovesPitText=true` and hand protection ON. Use `MOVE` on C3 alone to place it at a different clear corner. Add MTEXT `COVER CLASH` over that position, with another corner clear. Type `CDTIDYLABELS`, `Select`, select its pipe, Enter, Yes. Assert C3's position remains unchanged and it is reported as hand-placed. The current pit planner instead offers a move. Record C3's Location before/after and any `[PitCoverFlip]` line.

   **Why green tests miss it:** `HandPlacedLabelMarkTests` checks the boolean rule, serialisation, native-route source string and Reset clearing. It does not execute the right-click slide or CDANNOTATIONEDIT, and does not exercise a cover-text hand move through Tidy labels.

2. **F2 — MEDIUM — the preview does not reserve earlier pipes' proposed moves, so Apply is a different plan. VERIFIED-BY-READING.**

   **File:line:** `Commands/TidyLabelsCommand.cs:55`, `:78`, `:85`; `Services/LinkService.TextClashTidyUp.cs:159`, `:186`, `:359`, `:363`, `:408`, `:709`.

   **What happens in AutoCAD:** two overlapping pipe labels can produce “Will move 2”, but after Yes only one moves. Other arrangements can change the chosen destination. The drafter approved a list that is not the list applied.

   **Exact failure:** pipes are processed in stable handle order. Preview returns at line 364 before updating the shared scan. Every later pipe therefore sees earlier labels at their old positions. Apply changes the first pipe and refreshes its obstacle boxes before planning the next. The command discards preview's plan and runs the entire planner again; it neither applies the accepted plan nor verifies equivalence.

   **DETERMINISTIC TEST — fixture:** two CE pipes A and B, A first in ordinal handle order, with just one in-play plain text attachment each. Both text boxes are 100 by 100 mm: A `(0,0)-(100,100)`, B `(50,0)-(150,100)`. A's pipe direction is north and B's east; their bodies and other attachments are outside these boxes and all candidate destinations. Current/original placements agree; slide step 125 mm. Both unmarked/unlocked; leader-out, neighbour rearrangement and pit tidy OFF. The fixture writer must seed genuine placement records without making these labels hand-placed.

   **Typed steps:** `CDTIDYLABELS`, `All`, record all preview lines, `Yes`; record final text locations and summary. Repeat from a fresh copy, reversing selection order with `Select` while preserving handles.

   **Assertion:** accepted and applied label handles/positions/counts must agree. Source predicts A moves north 125 mm. Preview also moves B east 125 mm because it still sees A's old box; Apply sees A's new box and leaves B unchanged. Thus preview 2 versus actual 1, without any user edit between them. Selection order should not change this result because the implementation sorts handles.

3. **F3 — MEDIUM — pit-cover preview checks a translated rectangle, but Apply changes the text's rotation and anchor too. VERIFIED-BY-READING.**

   **File:line:** `Services/LinkService.TidyPitText.cs:84`, `:90`, `:100`, `:119`, `:120`; `Rules/PitTextTidyRule.cs:31`, `:47`; `Services/LinkService.PitCoverText.cs:135`, `:146`, `:150`, `:151`, `:152`.

   **What happens in AutoCAD:** a cover text that was rotated or rearranged can be offered a clear corner, then turn and land on another note when Yes is pressed. The preview's checked footprint is not necessarily the footprint that will be drawn.

   **Exact failure:** candidates mirror the centre of the current World-axis bounding rectangle about the pit. Clash checks and reservations use that unchanged rectangle plus a translation. The writer instead mirrors `cover.Location`, resets Rotation using the corner's 45/315-degree rule, and changes Attachment to MiddleLeft/MiddleRight. Only the corner name survives from plan to writer. For text that is not already in the standard corner orientation/attachment, these transformations are different; no post-transform clash check exists.

   **DETERMINISTIC TEST — fixture:** P3 at `(0,0)`, rotation 0, connected pipe away from the test text. C3 is horizontal, MiddleLeft at `(100,-100)`, measured extents `(100,-110)-(300,-90)`; this represents a user-adjusted cover text. Hand protection OFF to isolate geometry; pit tidy ON. Put note A inside `(110,-105)-(120,-95)` and note B around `(180,180)`. Keep all other corners clear and all layers unlocked. Before the command, use a detached copy of C3 and the writer's actual Location/Rotation/Attachment operations to assert note B intersects the resulting TR text extents but not the predicted rectangle. Adjust note B within that difference region if font metrics require it; save the resulting exact fixture.

   **Typed steps:** `CDTIDYLABELS`, `Select`, select P3's pipe, Enter. Record “to the top right of the pit”, then Yes. Read C3's Rotation, Attachment and GeometricExtents; compare against the fixture's predicted rectangle and note B.

   **Assertion:** the accepted candidate's checked footprint must equal the written footprint and remain clear. The current planner predicts only a 200 mm upward translation, rectangle `(100,90)-(300,110)`. The writer sets Location `(100,100)`, Rotation 45 degrees, MiddleLeft, producing a different footprint. Assert no intersection with note B; current composition can fail. This test must use real MText extents, not another rectangle-only model.

4. **F4 — MEDIUM — layout cover text is counted as moved although its writer always refuses it. VERIFIED-BY-READING.**

   **File:line:** `Services/LinkService.TidyPitText.cs:39`, `:68`, `:71`, `:116`; `Services/LinkService.PitCoverText.cs:118`; `Services/LinkService.PipeAttachmentGrip.cs:1016`; `Commands/TidyLabelsCommand.cs:104`.

   **What happens in AutoCAD:** on a layout sheet, Tidy labels can announce that a pit cover text moved while the text remains exactly where it was. The refusal is only in the CE log.

   **Exact failure:** selection explicitly supports current-layout pipes; the cover planner reads `db.CurrentSpaceId` and increments `outcome.WillMove` before writing. The shared mover rejects any attachment whose OwnerId is not local ModelSpace. A false return logs “left where it is”, but does not subtract the planned count or update an outcome failure count. The final command feeds planned `WillMove` into “Moved”. This remains a defect even after correcting the separately audited obstacle-space scanner.

   **DETERMINISTIC TEST — fixture:** Layout1 in PSPACE contains a CE pit P3, connected CE pipe and C3 cover text with valid ownership/links. Pit tidy ON; pipe labels have no clashes. C3 clashes with an ordinary sheet note and has a clear alternative corner. For this pinned release, add a model-space note with the same numeric XY extents as the sheet obstacle, so its already-known wrong-space scan also sees the clash. There must be exactly one planned cover move.

   **Typed steps:** `PSPACE`, `CDTIDYLABELS`, `All`, record “Will move 1”, `Yes`; record final summary, C3 Location and CE log.

   **Assertion:** actual successful moves, not planned moves, must determine “Moved”. Current source predicts “Moved 1”, unchanged C3 Location, and a log line containing `outside local ModelSpace and cannot be changed`. Require an honest left-alone explanation on the command line and continued processing of supported objects. This finding does not authorise weakening Xref or locked-layer protection.

5. **F5 — MEDIUM — a readable crowded drawing is abandoned at 1,001 nearby text obstacles. VERIFIED-BY-READING.**

   **File:line:** `Services/LinkService.TextClashTidyUp.cs:33`, `:197`, `:201`, `:203`, `:685`, `:700`; `Rules/TidyLabelsSummaryRule.cs:39`; `Commands/TidyLabelsCommand.cs:67`.

   **What happens in AutoCAD:** a congested drawing with 2,000 labels can leave an easily repairable clash untouched. CE says it could not read the pipe, even though all objects were read successfully. It can then say “No CE label needs to move.”

   **Exact failure:** after collecting 1,001 obstacles near a pipe, Filter throws an exception. TidyOnePipe never reaches planning; the per-pipe catch increments `PipesUnreadable`. If all picked pipes hit this threshold, `WillMove` is zero and the command ends. This is a fixed count refusal, not a time budget or a malformed-object check. The limit is per pipe window, so 2,000 widely separated labels do not necessarily trigger it.

   **DETERMINISTIC TEST — fixture:** one east-west CE pipe with one movable unmarked label L1 at a measured 100 by 100 mm box around `(0,0)` and one ordinary note overlapping L1. Add 2,000 separate short TEXT objects in a 50 by 40 grid, 5 mm spacing, starting at `(1000,1000)`. All grid boxes lie inside the pipe's 1,550 mm padded scan and away from L1 and its 125 mm east candidate. No Xrefs, locked layers or unreadable extents; pit tidy OFF.

   **Typed steps:** `CDTIDYLABELS`, `Select`, select the single pipe, Enter. Record preview, skipped-pipe line and log. On a separate otherwise identical fixture reduce the grid below 1,000 nearby obstacles and repeat.

   **Assertion:** L1 must be offered its clear move, or an accurate bounded-work explanation must be given while continuing valid work under R-27. Current dense fixture gives one pipe “that CE could not read”, log `more than 1000 text objects sit near the pipe; nothing was moved`, and no move offer. The smaller fixture reaches planning. Do not classify this deterministic refusal as a measured slow run.

6. **F6 — MEDIUM — accepted slide settings have no practical work bound before preview. VERIFIED-BY-READING; elapsed time and exhaustion are SUSPECTED, not measured.**

   **File:line:** `ViewModels/AdvancedSettingsViewModel.cs:1489`, `:1648`; `Services/LinkService.TextClashTidyUp.cs:506`, `:558`; `Rules/LabelPlacementRule.cs:65`, `:87`, `:97`; `Rules/TidyLeaderOutRule.cs:100`, `:111`.

   **What happens in AutoCAD:** a very small positive slide step can make Tidy labels spend a huge amount of work before it displays the preview. This can affect an ordinary pipe end even when leader-out is OFF. With leader-out ON, crowded callouts add another large search.

   **Exact failure:** Settings accepts any parsed positive step; the runtime rejects only non-finite/nonpositive values. End-label candidate generation uses `for (int k = 1; ; k++)` until a distance limit is exceeded, eagerly stores the results, and then duplicates them for the other side. There is no candidate/work cap or cancellation check. Rescue likewise iterates every distance ring, eight directions, without a work cap. The output obstacle cap in F5 does not limit candidate generation or a blocked rescue search with just one obstacle.

   **DETERMINISTIC TEST — fixture:** isolated Settings step `0.001` mm, end limit 500 mm; one 1,000 mm pipe whose start-invert home T is 0.1, valid original placement, unlocked layer. Leader-out and pit tidy OFF. The rule must generate 400,000 slide positions before reaching the 500 mm limit, then 800,004 total Spot objects including both sides/home/flips/lanes. Even candidates later rejected by the 1 mm movement filter have already been allocated. This count follows directly from the loop, not a timing estimate.

   **Typed steps and assertion:** on a disposable instrumented AutoCAD test process, set **CE Settings > Drafting > Label slide step** to `0.001`, save, type `CDTIDYLABELS`, `Select`, select the fixture pipe, Enter. Put a debugger counter at `SlideTs`'s `ts.Add` and stop the probe at its 10,001st insertion. Assert the command has a finite documented work budget before that threshold, or switches to a bounded search with an explicit outcome. Current code is still eagerly enumerating candidates before any preview. The 10,000 threshold is a proposed regression budget, not an approved engineering minimum. Record the stopped-loop evidence; do not misreport an intentionally interrupted probe as a completed native test.

   **Leader-out companion fixture:** a callout with one nonzero usual candidate, box `(0,0)-(100,100)`, one fixed blocking text box `(-2000,-2000)-(2000,2000)`, step 0.001 mm and maximum 1500 mm. No ring can clear it. The code demands 1,500,000 rings and 12,000,000 directional probes for this one item. Assert bounded search/cancellation rather than relying on wall-clock timing. Any remedy should bound computational work and report an unresolved label; it must not introduce an arbitrary engineering hard block.

**Coverage and remaining uncertainty**

1. **Locked layers and Xrefs.** Locked parent pipes are skipped whole at TextClashTidyUp:236. Locked attachments retain no candidates; rescue explicitly refuses items with zero candidates at TidyLeaderOutRule:104. The writer also retains locked attachments. No unlock or forced movement is alleged here. Xref blocks are explicitly excluded as obstacles at TextClashTidyUp:959; that is an already-recorded avoidance limitation, not new evidence of editing an Xref. REFEDIT is refused before selection. Native locked-layer/Xref confirmation remains pending.

2. **Viewport — SUSPECTED additional selection failure, not counted.** TidyLabelsCommand:171 filters using CurrentLayout, without inspecting the active model viewport. In a layout's active model viewport this may exclude the model pipes being viewed. Fixture: one model CE pipe visible through a Layout1 viewport, no paper pipes; double-click inside that viewport, type CDTIDYLABELS, All. Assert the visible model pipe is counted. Capture CTAB, CVPORT and selected entity owner space. This is kept outside the six counts because the supplied audits already discuss space selection and this host route was not driven.

3. **Unreadable attachment — source isolation gap, native fixture unproven, not counted.** BuildTidySearch reads attachment extents at TextClashTidyUp:594 before the per-pipe catch at :197. An extent exception there reaches the whole-pass catch, so the later per-pipe isolation cannot help. A future host probe needs an actual unreadable owned attachment plus a healthy clashing pipe; require the healthy pipe still reaches preview. An empty-text guess is not proof that AutoCAD will throw.

4. **Performance at 2,000 labels.** No timing was measured. Pipe scanning is shared, but windows are checked linearly, each pipe filters the shared list, and each refreshed attachment uses FindIndex. Pit cover text independently calls ScanTextBoxes for each cover (TidyPitText:96), which walks ModelSpace again. Benchmark spread-out and dense 2,000-label fixtures separately, then enable pit tidy and leader-out independently. Record `[PERF] CDTIDYLABELS count` and `apply`, actual moved count and total ModelSpace entity visits; timing alone must not hide F5's skipped work.

5. **Determinism and defaults.** Pipe and attachment ordering are ordinal by handle; candidates sort stably by rank/distance; rescue directions are fixed. Same handles/settings/geometry should repeat the same plan. This does not make preview equal Apply, as F2 demonstrates. Hand, pit, neighbour and leader-out switches must be explicitly recorded in every fixture; testing the master switch alone does not exercise those features. Ordinary unit/scale limitations remain with the earlier audit rather than being counted again.

6. **Delivery boundary.** Findings only; no fix or bug acceptance claimed. No code commit, PR, build, test run, deployment or change to live Settings. The single authorised CE_PLAN report is the handoff. Reversing that report's commit restores its prior absence without touching plugin code.

**Summary — under 100 words**

1. **Summary.** Six new findings: one HIGH, five MEDIUM. CE's own manual placement routes and pit-cover tidy do not honour lasting hand placement. Preview and Apply can disagree; cover-text geometry and successful-move counts can be wrong. Dense drawings hit a fixed obstacle refusal, while tiny positive settings create excessive candidate searches. Every finding has source evidence and a deterministic test specification. All tests remain unrun; timings and native outcomes are unverified. Known space, unit, rescue-reservation and Xref-avoidance issues are excluded from the counts.
