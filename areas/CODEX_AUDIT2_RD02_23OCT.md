1. **ANSWER FIRST — Structural Settings-first audit, 23 October 2026, Melbourne.** New findings: **HIGH 0 / MEDIUM 2 / LOW 1**. All three are **SURE, verified-by-reading**. None was tested in AutoCAD. These are faults in drawing output or permitted engineering input, not claims that a particular structural design complies with an Australian Standard.

2. **Most important — MEDIUM, RD02-01.** Column details replace the selected bar diameter with one fixed drawing size. At 1:20, an N12 bar becomes a **40 mm circle**, while the preview uses 12 mm. It can visibly cross the tie and misrepresent the cover arrangement.

3. **Second — MEDIUM, RD02-02.** A circular column cannot be entered with 14 or 18 bars. The window permits only seven fixed counts. Rectangular columns and beams have similar fixed count limits. The office cannot change those permitted counts through Settings or an editable table.

4. **Third — LOW, RD02-03.** The timber picker refuses a quantity of 10, even with valid dimensions and grade. Its limit of nine is fixed in code. This is an uncommon case, but it stops an engineer-specified member from being entered.

5. **Action.** Give the builder these three cases and the tests below. No test or engineering decision is requested from Tim by this report. Existing findings are excluded; their BUG numbers appear below.

---

1. **Evidence and scope.** Read `C:\TimOS\RULES.md`, `ROUTER.md`, the CE plan start/map/Structural area and R-00/R-27. Searched `BUG_CARPARK.md` before source inspection, then compared candidates against the earlier audits. Read the supplied `AUDIT_C58_C60_S40_S41_2026-10-22.md`, the three `CODEX_AUDIT_*_22OCT.md` reports, `AUDIT_ENGINEERING_STRUCTURAL_2026-10-22.md` and `release-v3-colleagues-R00_STRUC_2026-10-09.md` for exclusions.

2. **Exact source.** Fetched the plugin origin. The later, area-specific brief governs: Structural `origin/claude/rel-20261023s` = `e6d597c0fbc25e78118760887a70810e0890c9a9`, whose source version is 1.0.122. Civil/Manager `origin/claude/rel-20261023m` resolved to `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`. The older 22 October branches were not substituted for these targets. Installed DLL identity was not independently checked.

3. **Method.** Used a detached, clean worktree at `C:\ce-cx\rd02`, with source inspection through `git show`, `git grep`, `git diff` and tree/history metadata. Traced engineering constants, Settings models and readers, editable catalogues, window inputs, command callers and drawing writers. Compared the Structural changes since the earlier audited release. The owned worktree was checked clean and removed; its path no longer exists. No branch or plugin commit was created.

4. **Meaning of SURE.** The value, missing office control and reachable failure path are established from the pinned code. The native tests below are specifications for later execution, not recorded passes or observed screenshots. Severity reflects the particular failure: misleading geometry or a normal engineering input refused is MEDIUM; the uncommon timber-count refusal is LOW. No HIGH structural calculation failure was established.

**Numbered new findings, ranked**

1. **RD02-01 — MEDIUM — SURE — column bar circles ignore the selected bar diameter. Verified-by-reading.**

   **File:line:** `Modules/Structural/Commands/ColumnDetailCommands.cs:21`, `:103`, `:105`, `:244`, `:246`; actual circle writer `Modules/Structural/Services/StructuralDetailService.cs:394`, `:399`. Preview comparison: `Modules/Structural/UI/Dialogs/RCMemberDialog.xaml.cs:558`, `:578`, `:597`, `:616`.

   **What the drafter sees:** RCRECTCOL and RCCIRCCOL show the chosen bar size in the preview and label, but place every main bar with the same diameter. Changing N12 to N24 changes the label and bar centres, but does not change the diameter of the drawn circles. The office cannot alter that behaviour through Settings.

   **Exact failure:** `BarDotScale = 2.0`; both column writers pass `DIMSCALE * BarDotScale` as the circle diameter. The selected catalogue diameter is used to locate the bar centres, but not to size the circles. The preview uses that catalogue diameter for both. At DIMSCALE 20, the member scale factor is 1 and every main bar is drawn 40 mm across. For a 400 x 400 column, cover 40, N10 ties and N12 main bars, the lower-left bar centre is (56,56), the tie centreline is at x/y 45, and the drawn bar extends down to x/y 36. The correct-sized preview bar extends only to x/y 50. This mismatch exists without any disputed drawing-unit conversion or catalogue correction.

   **R-00 failure:** the engineering representation is controlled by a fixed 2.0 multiplier rather than the office's selected bar data or an explicit office display setting. `SectionDetailCommands.cs:21` has a similarly named constant, but the RCBEAM drawing path uses the selected diameter; that unused constant is not counted separately.

   **Smallest fix:** use the selected catalogue bar diameter multiplied by the existing member scale factor in both column writers, matching the preview and RCBEAM. If symbolic enlargement is an office requirement, expose it as an explicit setting and apply the same rule to preview and drawing; do not silently substitute one diameter for every size.

   **DETERMINISTIC TEST — fixture and typed steps:** later, in an isolated synthetic millimetre model-space drawing, set `INSUNITS` 4, `UCS` World, `DIMSCALE` 20 and `LTSCALE` 200. Type `RCRECTCOL`. Enter width/depth 400/400, main bar N12, two bars per face, tie N10 and cover 40. Capture the preview, click **Place Section**, and type insertion point `0,0`. Select the main-bar circle centred at (56,56), then use Properties or `LIST` to read its radius. Repeat at `1000,0` with main bar N24. Repeat the diameter check with `RCCIRCCOL`, diameter 450, eight N12 bars, N10 ties and cover 40.

   **Assertion:** the first rectangular column's label is `4N12`, its four main-bar circles have radius **6 mm**, and the N24 control has radius **12 mm**. The circular column's eight N12 circles also have radius **6 mm**. The pinned code predicts radius **20 mm in all three cases**, despite different preview diameters. Record circle properties, not hatch extents or the enclosing column outline. No test was run.

2. **RD02-02 — MEDIUM — SURE — fixed bar-count lists prevent the office entering the specified reinforcement. Verified-by-reading.**

   **File:line:** `Modules/Structural/UI/Dialogs/RCMemberDialog.xaml.cs:140`, `:145`, `:149`, `:153`, `:413`, `:441`; controls `Modules/Structural/UI/Dialogs/RCMemberDialog.xaml:82`, `:98`, `:107`, `:116`. Reachable commands and drawing loop: `Modules/Structural/Commands/ColumnDetailCommands.cs:25`, `:172`, `:260`.

   **What the drafter sees:** for a column specified as 14N20, the circular-column list jumps from 12 to 16. Typing 14 cannot enter a custom count. The drafter must abandon this tool or change the specification. There is no Settings list to add the missing count.

   **Exact failure:** the circular list is exactly `{4,6,8,10,12,16,20}`. Rectangular columns permit only 2 through 6 bars per face; beam bottom bars permit 1 through 12, and beam top bars 1 through 8. The controls are selection-only. Result construction reads `SelectedItem`, not free text, and the lists are built locally without reading Settings or a data table. The circular drawing loop already iterates to `spec.BarCount`; it does not impose the seven-value list.

   **R-00/R-27 failure:** engineering counts are restricted by compiled lists. A configurable starting answer would not remove this restriction. This finding concerns unavailable counts and the absence of an override, rather than the previously recorded starting answers.

   **Smallest fix:** accept a positive whole-number count and use office-editable lists only as suggestions. Preserve the existing starting answers, retain numerical validation and warn about questionable arrangements without imposing these fixed engineering limits. The result reader must read the typed count; making the control editable alone is insufficient.

   **DETERMINISTIC TEST — fixture and typed steps:** later, in a synthetic millimetre drawing at DIMSCALE 20, type `RCCIRCCOL`. Enter diameter 600, main bar N20, tie N10 and cover 40. Open **Total bars** and attempt to enter 14. Expected acceptance is a window value of **14**, followed by **Place Section**, insertion `0,0`, label `14N20` and exactly 14 main-bar circles. The pinned code cannot select 14. Repeat with 18. For a rectangular control, type `RCRECTCOL`, set width/depth 800/800 and attempt seven bars per face: after correction the window must retain 7 and output 24 main bars (`4 * (7 - 1)`). Test the count independently of RD02-01's circle-size fault.

   **Assertion:** engineer-entered counts survive from window to label and entity count, with no substitution by the nearest listed count. No structural adequacy is inferred from acceptance of these synthetic inputs. No test was run.

3. **RD02-03 — LOW — SURE — timber quantity above nine is hard-refused by a fixed constant. Verified-by-reading.**

   **File:line:** `Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.SteelTimberExtras.cs:91`, `:104`, `:123`; `Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml.cs:164`, `:167`, `:256`, `:479`, `:501`; quantity control `Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml:64`. Live doorway: `Modules/Structural/Commands/SbeamCommandRunner.cs:32`.

   **What the drafter sees:** a timber member specified with ten pieces cannot be entered. The picker says **“Quantity (No.) must be a whole number from 1 to 9.”** Its confirmation button becomes disabled. Changing the timber grade catalogue or Rebar quantity setting cannot change this limit.

   **Exact failure:** `MaxTimberQuantity = 9`; parsing returns false for any larger integer. `BuildTimberMemberInput` then returns null and selection validation prevents confirmation. No Settings value or editable table feeds this threshold. The text composer itself formats the count as an integer; the nine-piece ceiling is introduced by this validation rule.

   **Smallest fix:** remove the fixed nine-piece refusal. If the office wants a warning threshold, put it in Settings and warn while retaining a positive whole-number quantity. Preserve the rejection of malformed numbers; do not silently replace the typed quantity with one.

   **DETERMINISTIC TEST — fixture and typed steps:** later, in a synthetic millimetre drawing with the packaged catalogues available, type `SBEAM`, select **Timber**, choose MGP10, enter width 45, depth 190, and quantity 9. Select Section view and record the enabled confirmation button as the control. Change only Quantity to 10.

   **Assertion:** the window retains 10 and permits confirmation, with at most an office-configured warning. The composed designation must retain `10 No 45 x 190 MGP10`. The pinned code instead shows the exact refusal sentence above and disables confirmation. This is a boundary probe for the office's ability to enter a specification, not a recommendation to design that member. No test was run.

**Known findings excluded — BUG numbers only**

1. **BUG-530; BUG-531; BUG-532; BUG-533; BUG-534; BUG-535; BUG-536; BUG-537; BUG-818; BUG-819.**

**What was not checked**

1. **Native operation.** No AutoCAD, core console, build, unit test, installation or deployment. No screenshot, plot, Undo/Redo, saved drawing, host-version comparison or test fixture was produced. Repeat the proposed native checks on the supported legacy and modern AutoCAD lanes in the authorised test session.

2. **Engineering authority.** No Australian Standard clauses, supplier capacities or office design values were independently validated. No new cover, lap, load or strength factor is recommended. Unused `GetMinCover`, `GetSteelGrades`, lap-length and area-to-spacing helpers were not promoted into live failures merely because they contain numbers.

3. **Coverage limits.** Civil and Manager implementation, Manager administrator work, installed DLLs, live office Settings and private drawings were not audited. This was a targeted Structural source hunt, not a certification of every constant or editable table. The fixed reference-only concrete-grade list was inspected but not counted as another drawing failure. Catalogue loading and recovery were read selectively; malformed-file recovery was not exercised.

4. **Changes and undo.** Only this findings file was authored in CE_PLAN. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md were not edited. Other sessions' work was left alone. To withdraw this report later, revert its single-file documentation commit; there is no plugin change to undo.

**Summary — under 100 words**

1. **Three new findings: two MEDIUM and one LOW.** Column details replace selected bar diameters with a fixed circle size, concrete-member windows exclude specified bar counts, and the timber picker refuses more than nine pieces. Each is traced to a live command and includes a deterministic window or drawing assertion and a smallest fix. Earlier cover, lap, load, catalogue and default-value findings are excluded. Everything is verified by reading only; no AutoCAD or tests ran. The temporary worktree was removed and only this report was authored.
