# Structural markup review-to-correction daily card

**Planning checkpoint:** 2026-09-17T01:40:43.7535667+10:00. This card deepens approved [ST-09 Markup, checklist, notes and time](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-09_MARKUP_CHECKLIST_NOTES_TIME.md>) ST9-3–8 and ST9-15 into a single drafter review path. It keeps markup review distinct from engineering design, shared issue, provider/privacy authority and implementation owned elsewhere.

> **Read with:** [W9/W10/W11 interaction cards](structural_w7_w11_interaction_cards.md), [workflow card W9](structural_workflow_cards.md), [evidence-program interface contract](evidence_program_interface_authority_contract.md), [integrated walkthrough](structural_multifloor_interaction_walkthrough.md) and [ST-09](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-09_MARKUP_CHECKLIST_NOTES_TIME.md>). Current UI/source observations are [CEMARKUP entry](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/UiCommands.cs:80>), [CEMARKUP preview](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/MarkupAICommands.cs:30>) and [preview-window controls](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/UI/Dialogs/MarkupPreviewWindow.xaml:25>). The review/apply interface below is **Proposed** unless ST-09 expressly approves it; no runtime behavior is claimed.

## What opens, and what is retained

| Entry or visible control | Source observation / approved meaning | Proposed daily use |
|---|---|---|
| CEMARKUP / CEMARKUPVIEW | Source declares a markup entry and a modeless visual-preview route. The observed window has a page selector, Open PDF, Refresh, current-drawing canvas, overlay/callout canvas and a read-only item grid: Page, Type, Command, confidence, OK, status and text. | **Main: Markups** opens the active review package or states that none is active. Select one row; the header names package/revision/page, target drawing/layout/view/level, item identity and current decision. The source page remains beside the drawing preview. |
| CEMARKUPPARSE, CEMARKUPPLAN, CEMARKUPPREVIEW | Current declarations parse, build plans and preview a next group. Those declarations do not prove approved privacy, alignment, selection or safe drawing impact. | **More: Evidence and plan** shows extraction mode, provider/transmission state, package revision, row classification, required alignment and exact registered CE tool proposed for one selected correction. No provider upload follows from opening this card. |
| CEMARKUPRUN / CEMARKUPUNDO | Current source can prompt to run a group and exposes an Undo command. ST9-7–8 requires a stricter approved target: individually reviewed findings, actual result preview, explicit Apply and exact batch Undo. | The normal daily path never treats a generic run prompt or command success as approval/receipt. Apply is enabled only for a registered CE tool and an individually approved, current drafting/coordination item. Exact group Undo remains a future proof gate. |

## Select, align and decide one item

| Step | What the drafter sees and does | Result boundary |
|---|---|---|
| **1. Select source evidence** | Choose one already available markup package and page. The selected item shows original image/text, revision, page, classification/confidence, prior decision and source status. **Open source page** and **Refresh** are visible actions, not automatic imports. | A different page/revision is a separate candidate. No corpus/history scan, provider upload, master change or drawing action starts here. |
| **2. Match the right drawing** | Select the intended drawing/layout/view and identify **two or more known alignment points**. Preview source page, current drawing and overlay together; show sheet, scale, rotation and revision states. | Unknown sheet, scale, rotation, revision or insufficient alignment is **Unknown** and blocks correction Apply for this item. It cannot be solved by extents, title block, Xref or nearest object. |
| **3. Select the target deliberately** | For a drafting/coordination item, select the local target compound or explicitly choose **No target / Needs review**. Header shows drawing/layout/view/level and stable identity for both item and target. | A same-looking mark on another level, protected background, Xref, locked object or nearby annotation stays unselected. Existing Manual/pinned presentation is displayed, never silently reset. |
| **4. Classify before any drawing plan** | Choose **Drafting correction**, **Drawing coordination**, **Engineering decision**, **Unclear**, or **Already resolved**. The selected classification, reviewer and date form the item decision. | Engineering text such as a requested member-size/change creates a decision/check item only. It does not select a command or modify the drawing. Unclear remains Unknown. Already resolved requires visible current-drawing evidence, not a confidence score. |

## Main correction path — draft only what is permitted

| Classification | Main action and preview | Output / unanswered choice |
|---|---|---|
| **Drafting correction** | Select a registered CE drafting tool and preview the exact selected local output with source markup, old drawing state, proposed result, drawing/view/level, owned label/compound scope and Manual state. Example: a markup asks to move a selected member label. | **Apply one correction** is offered only after the item is aligned, current and explicitly approved. It does not change an engineering value, link a nearby object or override the existing Manual position without a visible Before/Current/Pending confirmation. |
| **Drawing coordination** | Preview a permitted coordination output, such as an approved section reference, against the selected local drawing target and source markup. | The result remains drafting/coordination evidence. It cannot certify connection, bearing, capacity or calculation adequacy. Any missing reference/value remains Unknown. |
| **Engineering decision** | Main shows **Create decision/check item** with markup text, source page/revision, selected drawing target (if any) and unresolved choice. | No drawing correction plan, numeric default, recalculation or command is created. The decision owner and later engineering review are outside this card. |
| **Unclear / Already resolved** | Mark Needs clarification with the original evidence, or attach the selected current-drawing evidence and mark Already resolved. | Neither action changes drawing geometry, labels, calculations or issue state. A later source revision reopens the item for review. |

## More: pre-Apply gate, manual content and truthful receipt

| Review action | Proposed visible control and boundary |
|---|---|
| **Review plan** | Show source package/revision/page/item; target drawing/layout/view/level/identity; registered tool; exact before/after preview; source/Manual/Unknown fields; intended output count; and selected correction scope. A plan cannot include another pending row just because command or page matches. |
| **Recheck before Apply** | Recheck markup revision, target identity, drawing revision, calculation/schedule status where relevant, protection state and preview geometry. Any changed input returns this item to **Needs review** and disables Apply. A Manual label move while the old position is in the plan makes that presentation plan stale; it does not make calculations numerically stale or auto-move the label back. |
| **Apply one reviewed group** | Explicit Apply names the selected item IDs and registered tool. It creates a future group-specific Undo target only after implementation proves that scope. Current CEMARKUPRUN source is not proof of this safe target. |
| **Receipt and retry** | Record each selected item as Complete, Partial, Failed, Absent or Unknown, separating graphics, compound/label relation, source-decision record and action receipt. Before retry, inspect/read back any Partial/Failed/Unknown item; retry requires verified absence or a qualified safe-resume boundary and never reruns Complete work. |
| **Cancel, Park and reopen** | Cancel/Escape before Apply leaves drawing, existing Manual content and source package unchanged. Park preserves review evidence and plan separately from current state. Reopen shows prior/current source revision, alignment, decision, target, plan and receipt; a changed source is not quietly rerun. |

## Fictitious daily review example

A synthetic markup page contains three items on one structural plan: “move the selected B-17 label clear of bracing,” “increase B-17,” and an unreadable cloud. The drafter selects the page, matches it to the local layout with two alignment points and chooses B-17's owned label on the stated level. The first item is **Drafting correction**: source page, current Manual label position and proposed new placement appear together; the drafter approves one registered label-placement preview. The second is **Engineering decision**: it becomes a decision/check item with no member-size change or drawing plan. The cloud remains **Unclear**.

Before Apply, another drafter deliberately moves the B-17 label. The saved markup plan now names the old position, so its presentation correction becomes Needs review. It does not erase the Manual move, change B-17's engineering basis or make a calculation stale. The drafter Refreshes, compares old/current/proposed positions, then Parks the correction. Reopening later shows all three decisions, alignment evidence and no drawing receipt for the Parked item.

## Future representative acceptance

In AutoCAD, use a synthetic annotated PDF/drawing pair to verify: page/source preview; two-point alignment; drawing/layout/view/level/identity display; no Apply for Unknown alignment; drafting versus engineering versus Unclear decisions; selected compound/Manual-position preview; stale-plan rejection after manual move; explicit single-item Apply; exact grouped Undo if built; Complete/Partial/Failed/Absent/Unknown receipt distinction; Cancel/Park/reopen; and no issue/calculation/provider action. Inspect the real source page and drawing before claiming Tested or Tim-accepted.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, issue action, provider/corpus access or client-project scan occurred.
