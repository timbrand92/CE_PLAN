# cx_cr25 — independent design review of batch-4 robot drafts

29 October 2026, Melbourne (AEDT). I read Tim's RULES and ROUTER, the plan pointers, B4 specification, all eight drafts, cards D05/D13/D21/D24, the release gap plan, B3 driver limitations, N25/N27/N28/N29, their B7 review, the two setups, runner/driver implementation and allow-lists, and relevant product source using only `git show` / `git grep` on `origin/claude/rel-20261026z` in `C:\Lisp Files\CE_ACAD_PLUGIN`. That ref resolves to `09126560f98acc4fd6ca4be298d087307a89a259`. I did not open AutoCAD, execute a case, validate through the runner, call a driver or guard, build, install, test code, or delegate. This report is the only file I created or edited.

## FOR TIM

1. **Two drafts are sound; two need stronger checks.** All four have a plausible route through the robot as written; none has a definite spelling or prompt fault. The weak ones could miss a real drawing mistake.

2. **The label check needs tightening.** Moving P8 by 10 mm can pass even if its invert text stays completely behind. Its later Tidy labels check cancels instead of allowing changes, so that part cannot prove protection during an applied tidy.

3. **The schedule check needs tightening.** P1A is checked somewhere between P1 and P2, rather than immediately after P1. P4, P5 and P6 could disappear or sit out of order without failing that check.

4. **Do not raise the count to 20 of 40 from this review.** After real passes, the group-order check could finish D21's current-setting claim. The layer check could finish its built drawing-object portion, but D24 still leaves layer colours and other promised behaviour unproved.

5. **Nothing needs your testing today.** The report gives the case writer exact changes. For example, a pit label block can sit on the right layer while its number inside uses a different layer; the present layer check reads the block only.

---

## ANSWER FIRST

1. **Primary verdicts, four main drafts:** SOUND 2 (N32, N33); NEEDS FIX 0; WEAK 2 (N31, N34); WRONG CARD 0; BY DESIGN FAILS 0. These are design verdicts, not runtime passes. Two drafts need assertion/scope changes before their full written claims deserve approval; no definite execution repair was established.

2. **Card disagreements are separate findings:** literal D13 step 3/assertion 1 would fail by design for the normal attached text described here; D24's common “pipe-text layer” wording disagrees with the two actual layers. Neither disagreement authorises changing the card to match a passing case.

3. **Twins:** N32 and N34 have source-supported changes expected to produce failed CHECKs; N33 has a reversed-expectation CHECK, not a changed drawing; N31 can fail its count CHECK without proving that the pit-move tidy was exercised. No twin has an observed red in this review.

4. **Line references:** all case line numbers below refer to the files in `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_29oct_b4`. Product paths are relative to `Modules/Drainage/` at the ref above. Driver paths are relative to `C:\Lisp Files\_ACAD_DRIVER`.

## Per-case findings

1. **N31 — hand-placed text through a pit move. Verdict: WEAK.** Main SHA-256 prefix `707DAB4421B8`; twin `1511AFC4F088`.

   **What it can prove:** the selected start invert text was hand-moved 5 mm; P8 then moved 10 mm; that same text moved no more than 20 mm; a later preview reports one clashing hand-placed text. It does not prove the card's 500 mm pit move leaves the pipe label at its original drawing coordinates.

   **False pass at line 83:** `number $pm_moved <= 20` accepts zero, movement in the wrong direction, or a small unwanted tidy displacement. A broken attachment-following path can therefore pass while the marked text remains behind. This is less than the title's “only carried with its pipe end”.

   **Exact strengthening:** after line 83, add `number $pm_moved > 1` to reject a stationary text. Then change the title/EXPECTED wording at lines 13/26 to “moves more than 1 mm and no more than 20 mm”; this remains a bounded-movement check, not exact attachment geometry. Exact carry proof needs the expected X/Y position derived from this pipe's segment, T and offset, then assertions against that position; those stored values are not exposed by the present case verbs.

   **Preview versus apply:** lines 67–68 request `All` and then Esc. `Commands/TidyLabelsCommand.cs:55–89` previews without writing, returns immediately when WillMove is zero, and applies only after Yes. Thus line 86's zero displacement and line 87's unchanged count are expected even for an unprotected text when the preview is cancelled. They remain useful no-write checks, but are not an applied-tidy protection test.

   **Exact scope correction:** after line 30 add `NOT_AUTOMATED The later CDTIDYLABELS operation is a preview followed by Esc; it does not exercise an applied tidy.` Then qualify lines 13/26/27 and record line 93 accordingly. Do not simply append Yes: when WillMove is zero no question exists, as B7 found in N27. An apply test needs another known movable clash so the question actually appears, then Yes, then a read of both texts.

   **Twin and true-red requirement:** twin line 59 should fail only if the unmarked text actually moves more than 20 mm during the pit move. Line 60 should fail because the hand-placed count is zero. If only line 60 fails, it proves the switch changes marking/counting, not that the pit move's tidy would otherwise move this text. The desk must require failure of line 59 for the pit-move protection claim; a generic FAIL is insufficient.

   **Twin repair for scope, not execution:** after twin line 58 add `number $pm_moved > 1` if the main lower-bound check is adopted. Then change main line 30, twin lines 2/7 and the spec's profile-A claim: this is a contrast with tidy ON and hand-placed protection OFF, not D13's literal profile A, which changes neither switch (card line 415). Both variants explicitly turn tidy ON.

   **DERIVED audit:** `Services/LinkService.PipeAttachmentUpdates.cs:98–250` computes `onSeg = start + segment * clamp(T)` and adds the perpendicular offset, without consulting PlacedByHand. `PitMoves.cs:536` and `Reactors.cs:749` call the tidy after moves. `TextClashTidyUp.cs:244–366` honours the mark and counts clashing held texts. These support the mechanism, not the exact 9.5–10 mm estimate, a guaranteed 275 mm twin move, or exactly one clash after this new 10 mm move.

   **Remaining D13 lines:** steps 2–3 use a pipe label moved 1000 mm and a pit moved 500 mm; assertion 1 requires P2=P1 within 1 mm. N31 substitutes an IL text and 5/10 mm moves. Profile A's actual settings and recorded outcome remain unproved by this pair; assertion 3's four restored settings hashes requires future session evidence. N27's reviewed tidy preview does not settle the pit-move wording.

2. **N32 — every new main drawing object on its office layer. Verdict: SOUND for that scoped claim.** Main SHA-256 prefix `BB0D461CE2B8`; twin `EC73AE1E03B5`.

   **What it proves if it passes:** the eight newly appended model-space objects have the expected categories and layers, with CLAYER read as BLOCKS before work, after PIT and after CD. The eight category counts sum to eight, and the total is asserted, so an extra top-level object cannot quietly escape the layer checks. Selecting the pit by its expected layer at line 54 is not tautological: count=1 at line 77 fails if the pit is elsewhere.

   **Source confirmation:** `LayerService.cs:54,127,134,138,142,146` defines STORMWATER PIPE, 25TEXT, 20TEXT, ARROW, STORMWATER PIT and STORMWATER PIT LABEL. `PitCommand.cs:399,485,805` assigns pit/label/cover layers; `TextService.cs:197,1199` assigns pipe text and invert layers; `ArrowService.cs:41,499` identifies TIM_CVL_ARROW and ARROW. These names are real defaults, not guesses.

   **Eight is conditional, not a universal CE total:** `PipeCreationService.cs:1104–1126` makes the output roles depend on single-pipe mode, pipe type, text, supplementary text, visible inverts and arrow choices. Eight is consistent with the N25/N28 profile: three pit objects plus five pipe objects. It is not confirmed by source alone for arbitrary remembered settings, and it has not been seen for this combined draft.

   **One-layer-per-object limitation:** `case_runner_lib.ps1:310–327` enumerates model-space entries and reads each entry's Layer. It does not enumerate block contents or attribute layers. `PitCommand.cs:356` explicitly checks a separate pit-number attribute layer through `BlockService.GetPitLabelNumberLayer`. A block's layer is not proof that all its internal geometry/text uses that layer. N32 is strong for the eight top-level objects, not every entity in the drawing database.

   **Exact wording changes recommended:** at lines 2/3/10/11/20 replace “every new object” with “every new top-level model-space object” wherever the broader wording occurs; at lines 2/11 remove the whole-card claim. After line 24 add `NOT_AUTOMATED Block contents and attribute layers are not read; layer-table colours and linetypes are not read.` No execution line needs changing for the scoped layer proof.

   **Optional EXPECTED consistency:** line 20 promises exactly CL 19.000, but lines 57/80 only recognise a CL-prefixed text. After line 58 add `field $covers text -> $covt`; then after line 81 add `equals $covt "CL 19.000"`. This closes an incidental wording gap; the layer claim itself does not depend on that text value.

   **Twin is a credible real-action red:** line 11 changes `layerNames.names.20TEXT` to CETWIN20TEXT. `Models/UserSettings.cs:79,2358`, `LayerService.cs:367` and `Rules/LayerNameRule.cs` confirm that exact configuration path and resolution. `acad_driver_witness_v2.ps1:3587–3610` permits a digit-leading key segment and creates missing object groups. The proposed nested key is not a parser fault.

   **Required twin evidence:** line 28 must fail with actual `CETWIN20TEXT | CETWIN20TEXT`, while line 27 finds two IL texts and line 26 keeps CLAYER. A missing text, failed setup or refused guard is an irrelevant failure. After line 28 optionally add `equals $ill "CETWIN20TEXT | CETWIN20TEXT"` as a passing control. The twin covers the IL layer comparison only; it does not independently demonstrate every layer assertion going red.

   **Remaining D24 lines:** N28 supplies assertion 1's five completed Esc/Cancel paths on its reviewed build. N32 supplies assertion 2 for this ordinary pipe and labelled pit, using the product's distinct 20TEXT/25TEXT layers. Card steps 1/3 and assertion 3's L0/L1 colour/linetype record remain absent; the “never recolour” feature remains outside the claimed built behaviour. Other pipe-type layers and block contents are not covered. This is not whole UX-LYR-01 acceptance.

3. **N33 — LPD, OG, P, CP, then the rest. Verdict: SOUND for D21 assertion 3.** Main SHA-256 prefix `DC4CBDA88743`; twin `9F366E0CDD07`.

   **What it proves if it passes:** four new pits exist, placement completes four times, and the displayed primary rows include LPD, OG, P1–P7, P9, P10, CP2, CP10 and C1 in that order. CP10 is deliberately created before CP2. Line 79's positive chain prevents the three negative checks from passing merely because a named group is missing.

   **Source confirmation:** `Helpers/PitIdComparer.cs:33–104` groups exact normalised LPD, exact OG, P followed only by digits, CP followed only by digits, then everything else. P/CP groups compare numerical values; the rest compare names. Thus P2 precedes P10, CP2 precedes CP10, and C1 follows CP10. LPD1 and OG2 are not the first two groups. P8 is absent from this draft's chain because it is absent from the stated baseline; N29 supplies the newly placed P8 check.

   **Typed names are supported:** `WorkshopPitCreation.cs:16` always selects one page; `PitOnePageLayout.cs:39` exposes PitNumber; `PitEditWorkshopDialog.xaml:49` binds it with immediate updates; `WorkshopEditorFocus.cs:75` supplies C2.PitNumber. `PitViewModel.cs:980–990` validates typed names before closing, and `PitNumberAsTyped` preserves them. The stored s7 UI tree independently contains the enabled field, and v2 allows New Pit field setting. B3's “hidden Pit tab” obstacle is superseded.

   **DERIVED row text:** `PitScheduleRow.cs:365–400` supplies “Pit <number>” for a first row and a comma-qualified name for secondary rows. `PitScheduleViewModel.Data.cs:265` uses PitIdComparer.Natural. `ui-cells` joins row/cell names and values with ` | `, so the pattern shape is justified and its `.*` does not need a newline option. The exact new-name UI text remains unobserved on this build; it is not a known impossible expression.

   **Exact changes:** none mandatory for this scoped proof. To pin the legacy profile rather than assume Tim's setting, after line 15 add `SETTING CD_Settings.json linking.pitScheduleNaturalOrder false`; then add the same setting after twin line 9. Current plain names sort identically with either switch value, so this is reproducibility and claim precision, not a discovered failing step.

   **Twin is an assertion red, with a limitation:** twin line 68 demands CP2 before P1, opposite to the source. On a correct complete schedule that CHECK fails. However, it would also fail if CP2 or P1 were missing; the twin checks only four bodies and four completion lines. After line 67 add `contains $rows "Pit CP2= | CP2=CP2 |"`; then add `contains $rows "Pit P1= | P1=P1 |"`. Require those controls to pass before crediting the reversed-order failure.

   **Red strength and card scope:** B7 accepts this reversed-expectation approach for N29. It proves the reader/comparison can reject an incorrect order expectation; it is weaker than making a drawing with the wrong order and failing the original check. N33 alone does not prove assertions 1/2's new P8 placement or assertion 4's refinement. With valid same-build N29 evidence it can finish D21's currently enabled basic/group-order portion, not the switch-ON refinement.

4. **N34 — P1A and SPS natural order, switch ON. Verdict: WEAK for its full written order claim.** Main SHA-256 prefix `C383BF06A108`; twin `2785BD62FEC1`.

   **Useful proof already present:** the setting is explicitly true; the three named new rows must exist in the positive chain; P1A must occur between P1 and P2 and SPS2 before SPS10. Source `PitIdComparer.cs:49–65,86–104,116–155` supports P1A in the P group, shorter P1 before P1A, and numerical digit-run comparison for SPS2/SPS10. With false, P1A joins the rest after C1 and SPS10 precedes SPS2.

   **False passes:** line 67 jumps from P3 to P7, omitting P4/P5/P6 despite EXPECTED line 21 listing them. Its unrestricted `.*` also allows an unrelated primary pit row between P1 and P1A. A logical counterexample is P1, P4, P1A, P2, P3, P7, P9, P10, C1, SPS2, SPS10 with P5/P6 missing: the present three order checks allow it. This is reasoning from the expressions, not an executed regex test.

   **Exact chain change:** in main line 67 and twin line 60, after the `Pit P3= \| P3=P3 \|` fragment insert `.*Pit P4= \| P4=P4 \|.*Pit P5= \| P5=P5 \|.*Pit P6= \| P6=P6 \|`, then retain the existing P7 and later fragments.

   **Exact adjacency change:** after main line 69 add `matches $rows "Pit P1= \| P1=P1 \|(?:(?!Pit [^=|,]+= ).)*Pit P1A= \| P1A=P1A \|(?:(?!Pit [^=|,]+= ).)*Pit P2= \| P2=P2 \|"`; then add the identical assertion after twin line 62. It forbids another primary pit row in either gap while allowing comma-qualified secondary pipe rows. This proposed expression has not been executed or passed through the parser.

   **Twin is a credible real-action red:** false at twin line 10 changes the comparison rule; existing twin lines 60–62 should all fail for the intended reason. But absent/renamed pits can also fail those expressions, while the two current placement checks still pass. After twin line 59 add presence controls for `Pit P1A= | P1A=P1A |`, `Pit SPS2= | SPS2=SPS2 |` and `Pit SPS10= | SPS10=SPS10 |` using `contains $rows`; then require all three to pass before accepting order failures as the red.

   **DERIVED and card limits:** typed-name support and row formatting are the same source-supported route as N33, not newly observed evidence. This covers the optional refinement in D21 line 630; it does not switch it on for Tim or Max, prove N29's newly placed P8, or add a second whole tool to the count. Names SPS2/SPS10 here are typed identifiers on ordinary pits, not a test of the SPS pit type.

## Things the desk should know first

1. **Acceptance cannot come from this document.** The 24 October amendment in RULES requires two actual sessions on one build, a meaningful red and independent review of the final case. `case_runner.ps1:156–169` skips assertions after a failed step; `Resolve-CaseAcceptance` requires `from_check=true` for a variant red. A blocked UI action, timeout or empty selection causing a step exception is not the intended red.

2. **The 20-of-40 claim needs an explicit scope.** The gap plan's section 3 item 7 counts daily tools, not case files. B7 calls N28/N29 partial. N33 can complete the missing D21 groups; N34 adds another profile of that same tool. N31 remains partial and D13's wording is unresolved. N32 can complete the tested top-level-layer portion, but not the whole D24/UX-LYR-01 promise. “18 to 20” is possible only if the desk explicitly counts the narrowed as-built D24 item after the required runs/review; it is not justified as two newly whole features today.

3. **The other possible recount is separate.** B4 suggests CDSYNC and CDTWL freeboard may already be omitted from the list of 18. I did not audit that ledger or the underlying run artefacts. In particular, B4 itself says the freeboard supporting cases lack 3.0.85 runs. Neither that suggestion nor B7's historical successes is a fresh same-build acceptance here.

4. **Shared remembered settings can cause irrelevant failures.** These cases inherit ordinary pit type, enabled labels/cover text, schedule inclusion, pipe type, text/arrow options and layer mappings. `PitViewModel.cs:783` enables the number field only when numbering is allowed and AddLabel is true; `PitCommand.cs:463–464` replaces the typed name for an actual SPS pit. A later remembered SPS or unnumbered plastic choice could break both schedule drafts for an unrelated reason. Record or explicitly set the ordinary-pit profile before attributing a failure to sorting.

5. **The comparer is not the only schedule influence.** `PitScheduleViewModel.Data.cs:876–952` reapplies saved row order when its coverage is sufficient; filters and schedule sets also affect displayed rows. Existing N29 evidence supports this fixture's route, but source alone cannot certify the saved drawing state. If new rows appear at the bottom, inspect saved ordering before alleging a broken comparer; do not weaken the expected order to obtain a pass.

6. **Prompt and verb audit:** all used verbs and options exist in `case_runner_lib.ps1:14–29,275–365`. Setup-R47 and Setup-P8 set `$n0` and `$new_all` before use. The PIT/CD Enter/Esc sequences and exact v3 button names match N25/N28/N29 and the allow-list. The N31 MOVE sequence matches the setup's established MOVE form. No undefined variable, definite incorrect prompt, or impossible runner-text regex was found. Draft syntax was read, never executed.

7. **Driver boundaries remain real:** `Get-V3EntityInfo` exposes text and insertion for TEXT/MTEXT, not rotation; these verbs do not read layer-table colour/linetype records. More options and recent buttons are not on the relevant press allow-lists. Source `CivilMoreOptions.cs:25` spells the button `More…` with a single ellipsis character, not three dots. A future permission entry must use the observed exact control name; this report grants none.

8. **D13 recommendation for Tim, not a decision:** I recommend saying that a hand-placed label keeps its chosen offset from its pipe and is protected from automatic clash tidying; moving the pipe or its pit may carry the label with it. For example, after moving P8 500 mm east, its IL text should remain beside that pipe end with the drafter's adjustment retained. The existing absolute-position assertion should remain disputed until Tim settles that behaviour; a 10 mm substitute must not silently redefine it.

9. **D05 recommendation for Tim, not a decision:** I recommend putting recent diameter, material and invert buttons beside their fields on the main New Pipe/Edit Pipe page. Choosing 225 mm should take one click from the page already open, without opening More options first. `PipeOnePageLayout.cs:70–76,149–152` moves selected field rows but leaves the separate recent rows from `PipeEditWorkshopDialog.xaml:99–132,257–266` in More options. The driver permission gap is separate from this placement recommendation; no new layout or permission is approved here.

## What I did NOT check

1. **No runtime evidence:** no AutoCAD window, drawing, screenshot, installed DLL metadata, live settings value, runner validation, regex test, driver call, settings guard or lock was used. The source ref is verified; the installed-build description comes from the brief and prior review, not a fresh DLL inspection.

2. **Unconfirmed DERIVED outcomes:** N31's exact carry displacement, surviving clash/count and twin's 275 mm move; N32's combined eight-object result and live renamed-layer write; N33/N34's actual typed-name acceptance and rendered cell strings. Source supports mechanisms, not these unseen results. B7 is prior review evidence, not a substitute for reviewing future B4 runs.

3. **No hidden acceptance work:** no case, twin, setup, ledger, run report, settings, BUG_CARPARK, DESK_LOG, QUEUE or review.txt was changed. No bug was marked fixed. No acceptance total was changed. No source checkout, worktree, build, install or PR was made. Other jobs' uncommitted plan files were left alone; only this report is to be staged and pushed by name.

4. **No broad quality claim:** block contents, every pipe type, layer-table changes, exact attachment offsets, visual readability, engineering correctness and the current 40-item ledger were not established. Proposed runner lines are review recommendations only; after editing them, the owner needs fresh evidence for the changed case text.

## Summary

Two drafts are sound for their stated parts; two need stronger checks. No definite broken verb or prompt was found. N31 can miss a label left behind; N34 can miss missing or misplaced rows. N32 reads main drawing objects, not block contents or layer colours. N33's groups match the source. Twins need the intended CHECK failures, not merely FAIL. Nothing was run or accepted. Do not claim two newly whole tools or 20 of 40 without resolving scope and obtaining the required evidence.
