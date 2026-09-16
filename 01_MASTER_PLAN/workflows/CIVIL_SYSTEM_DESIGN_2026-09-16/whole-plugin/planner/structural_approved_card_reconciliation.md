# Structural approved-card reconciliation supplement

**Planning-only supplement.** This records approved Structural requirements that source route inventory alone must not flatten into generic “Keep/Modify” language. It does not claim implementation, testing, installation or Tim acceptance. Source locations identify current route evidence only; the listed approved cards govern intended behaviour.

## W0 / ST-09 — Coordination, notes and time

| Retained route | Approved end-user contract | Source/status boundary |
|---|---|---|
| `CEMARKUP` and `CEMARKUPDWGEXPORT` | Intake order is **Bluebeam FDF/XML**, then local PDF text/geometry, then provider-neutral visual interpretation only where separately approved. Before an external provider receives pages, show file/pages/provider/transmission warning and Upload / local only / Cancel. Match exact DWG/layout with **two or more** known alignment points; Unknown sheet/scale/rotation/revision cannot Apply. Classify engineering text as a decision/check item, never an automatic drawing change. | `ST9-3–8` approved. Existing source routes are not proof that this safe path is built. External COM, Python/pyAutoCAD, LISP/scripts, blind command strings and arbitrary actions remain prohibited. |
| `CECHECKLIST` | Becomes the visible face of one deterministic `QA-01` checklist, with Civil, Structural, Coordination and Issue sections. Automatic Fail/Unknown cannot be changed manually to Pass; N/A needs a reason. | `ST9-9–10` approved. Retain the older route until transition acceptance; shared QA semantics stay with root. |
| `CENOTES` / note placement | Classify the note; retain links to project/drawing/layout/element/calculation/schedule/markup. For concurrent changes show **Keep mine / Keep shared / Merge / Cancel**. Drawn note placement selects an approved style, previews native annotation and retains the relationship without overwriting either record. | `ST9-11–12` approved. Current last-save-wins source is not accepted behaviour. |
| `JOBTIMEREDIT`, `JOBTIMERDEBUG` | Use stable project identity; unknown drawings are Unassigned/not billable. After five inactive minutes pause/exclude idle and offer a visible restoration choice on return. Store corrections as append-only adjustments, retaining active time, excluded idle, manual adjustments, user/project/drawing/session and reason. | `ST9-13–15` approved. Debug remains expert-only. Time data must not be flattened into “save/reopen unchanged”. |
| `CETOOLS`, `CEMARKUP`, `CENOTES`, `CECHECKLIST` transition | Familiar commands remain while they transition to CE Manager **Coordination**; older palettes/windows retire only after transition acceptance. | `ST9-1–2`; Manager surface ownership remains root-owned. |

## W7 / ST-03 and ST-04 — drafting semantics that must stay exact

| Family | Approved retained behaviour |
|---|---|
| Dimensions/leaders | `AD`/`LD` retain native associative dimensions and their normal prompt flow; `Q`/`QD` retain native editable leader/text. `MLL`/`MLR` preview full leader/text/arrow; `F` flips side. `RD` refuses unsupported geometry. Styles are local/portable and previous layer/style/snaps restore. (`ST3-1–6`) |
| Levels/sections/breaklines | `FFL`/`RL`/`SSL`/`NGL` use trusted source or Manual/Unknown, never `0.000`; whole compound previews and `F` flips. `LMU` targets recognised CE level marks only, then Preview → Apply → one Undo. Section marks preview both bubbles/hatch direction/reference; copy gives a new identity. `BL` is current space/UCS-aware and plotted-scale sized. (`ST3-7–13`) |
| Text and tags | All familiar aliases map to one visible preset: role/prefix/layer/**plotted** height/justification/preferred side/rotation. `F` flips, `R` changes reference/alignment, Tab cycles ranked alternatives. A full prefix result previews without double-prefixing. Text↔MText preserves link; manual label position is retained; last-used text is session/drawing visible default only. (`ST4-2–14`) |
| Repair/conversion | `DSET`/`DSET1`/`DUP` consolidate to selected scope + existing/proposed style/scale preview + Apply + one Undo; never force save. `R2LTXT` only recognises eligible text and previews selected count. (`ST3-12`; `ST4-11`) |

## W2 / W7 / ST-05 — exact utilities and Xref contract

| Route | Approved retained behaviour |
|---|---|
| Hatches including `H2A` | Keep the frequently used structural hatch conventions and native associative result. `H2A` proves a replacement before erasing its old hatch; unresolved boundaries remain untouched. Full hatch properties and plotted scale remain review inputs. (`ST5-1–10`) |
| `CXREF` → `PXREF` | Preview preserves attachment/overlay choice, original coordinates or explicit Pick location, units, Xclip and layer overrides. Never edit source DWGs or their internal layers. (`ST5-11–12`) |
| `FASTSAVE` / `CLEAN` | `FASTSAVE` saves only. `CLEAN` is audit → counted/selectable repairs → preview → explicit Apply → one Undo; it never forces `QSAVE`. (`ST5-13–14`) |

## W5 — FST manager action boundary correction

The previous high-use contract incorrectly treated all manager actions as draft edits controlled by **Save Size Library / Cancel**. Source shows a split:

| Current action | Observed source effect | Required planning treatment |
|---|---|---|
| Size-library row edits | `FstManagerWindow.xaml.cs:230–264,648`; Save calls `CommitAllEdits()` at `:524–529`; Cancel only closes at `:531–534`. | Retain draft separation for **size-library edits only**. A row is project information, not engineering approval (`ST6-3`). Acceptance: edit row → Cancel → reopen shows no persisted draft; Save → reopen shows saved location. |
| Regenerate selected/all | `:376–386` invokes `FoundationService.RegenerateSystemFromUi` immediately and refreshes. | Existing action is immediate, not draft. Targeted reviewed replacement needs scope/count preview, retained manual/pinned values and a defined action-level Undo before changing it (`ST6-9–10`). |
| Rename system | `:455–466` prompts then immediately invokes `RenameSystemFromUi`. | Existing action is immediate. Retain source/identity/revision evidence; target preview/confirmation must not be misrepresented as existing. |
| Delete element/system | `:426–443` and `:505–521` confirm then invoke deletion immediately. System dialog says “This cannot be undone.” | Existing deletion is immediate. `ST6-9` requires **Element only / Entire system**, exact counts before Apply. Acceptance must cover rename/delete → Cancel close → reopen separately from size-library Cancel, and prove defined Undo/backup only when implemented. |

## Representative acceptance additions

1. Bluebeam markup → local-PDF fallback → two alignment points → overlay preview → one drafting correction → exact batch Undo; then a changed revision refuses stale Apply.
2. Concurrent note edit: preserve both versions through Keep mine/Keep shared/Merge/Cancel; place a linked drawing note with preview.
3. Start time in a registered drawing, switch projects, leave idle, return and choose treatment; manually adjust once and verify an additive ledger entry rather than a rewrite.
4. `H2A`: a mix of convertible and unresolved hatches retains unresolved originals; Undo restores converted ones. `CXREF/PXREF` retains overlay/attachment, units, Xclip and overrides.
5. FST: change one library row then Cancel/reopen; separately regenerate, rename and delete with their immediate current effects recorded. Future replacement must prove the approved scoped preview/Undo before old behaviour can retire.
