# ST-02 — Supports, bracing and joist markers

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-68`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# ST-02 — Supports, bracing, rafters and joists

## How the commands work today

| Tool | Current AutoCAD workflow | Assessment |
|---|---|---|
| `DS/DS1/TS1/C1/C2` | Pick insertion point → rotate block → pick label location → enter label → CE links the nearest beam | Useful but too many steps; nearest-beam linking is wrong for shared supports |
| `SDS/SDS1/STS1/SC1/SC2` | Select support → change type → recalculate centre → rotate again → recreate nearby labels | Rebuild; known to misbehave and may capture unrelated nearby text |
| `AB/BB` | Pick first end → drag second-end preview → auto-flip → optional flip prompt | Strong working core |
| `BT1` | Choose two endpoints → enter BT number → auto-flip | Useful; less proven than AB/BB |
| `ABS` | Select one or more braces → switch A↔B | Good batch workflow |
| `R1/FJ1` | Four geometry picks → enter tag → CE chooses a collision-free position | Rebuild; Timothy has already ruled that it does not work as intended |
| `P1` | Same marker engine plus optional 1200 mm lap | Keep hidden; live command is missing from the command register and its lap rule is unapproved |

## Proposed support workflow

```text
Run DS1
   ↓
Pick support centre
   ↓
CE aligns/centres it in the wall
   ↓
Move label preview and click
   ↓
Type/accept mark
   ↓
Finished compound object
```

## ST2-1–ST2-15 for approval

| ID | Recommended decision | Practical AutoCAD behaviour |
|---|---|---|
| **ST2-1** | Preserve insert commands `DS/DS1/TS1/C1/C2`. `SDS/SDS1/STS1/SC1/SC2` mean **switch to that type**. Keep old `TDS/TDS1/TTS1/TC1` as hidden aliases. | Command names and Help finally describe what they actually do. |
| **ST2-2** | Lock the support catalogue: DS 90×90 without label; DS1 90×90; TS1 135×90; C1 89 SHS; C2 uses its approved SHS/RHS/PFC picker. | Running `C2` shows the member-size picker before placement. |
| **ST2-3** | Support insertion uses the block’s physical centre—not its lower corner—as the cursor point. | The crosshair sits where the support will actually land. |
| **ST2-4** | When a clear stud-wall pair exists, centre the support within the approximately 90 mm wall and align it automatically. Otherwise show an orientation preview controlled by the cursor. | Pick the wall intersection once; press `R` only if a 90° rotation is needed. |
| **ST2-5** | A label-bearing support is one compound: block, typed support data and its label. After placement, the label follows the cursor with the real text box visible; click left/right/top/bottom. | No separate cryptic `DSL/DSR/TSL/TSR` workflow for staff. |
| **ST2-6** | Use the active structural schedule to prefill size and mark, but visibly show the source and permit an override before placement. | “C2 — 150×100 RHS from schedule”; Enter accepts it. |
| **ST2-7** | On placement, highlight every beam end that genuinely touches the support footprint. One support may link to several beams. Ambiguous candidates require confirmation. | A column supporting three beams links to all three—not merely the nearest one. |
| **ST2-8** | Support switching uses preselection or one support pick. Show the target outline before Apply; retain centre, rotation, mark, label location and all beam relationships. | Select DS1, run `STS1`, preview the larger footprint, click Accept. |
| **ST2-9** | Switching should not automatically ask for rotation again. Rotation is retained unless Timothy presses `R`. Labels are retained by ownership, never collected from a 260 mm proximity circle. | A nearby column note cannot be erased during a support switch. |
| **ST2-10** | Support MOVE/COPY/ERASE follows ST-01: moving a support updates every linked beam end; copying gives fresh identity and no inherited links unless the beams were copied with it; erasing flags affected beams. | Copying one column cannot steal the original beams. |
| **ST2-11** | Keep the fast AB/BB workflow: first endpoint → live final-block preview → second endpoint. Enter at the second point retains the familiar 2700 mm horizontal default. | The preview shows the actual brace, not merely a guide line. |
| **ST2-12** | AB remains capped at 2700 mm; BB and BT remain uncapped. When AB exceeds 2700, the preview visibly stops at 2700 and displays `MAX`, rather than shortening after the click. | Timothy sees the capped result before placement. |
| **ST2-13** | Auto-flip provides the initial preview. Press `F` to flip before the final click. `ABS` batch-switches A↔B without moving, resizing or reflipping the brace. BT numbering is entered/accepted before placement so the preview shows the finished mark. | No post-insertion “Toggle flip? Yes/No” interruption. |
| **ST2-14** | Rebuild `R1/FJ1`: select the two boundaries being spanned → CE derives direction and span → move the finished marker preview within the bay → click → enter/accept the tag. Four-point input remains a fallback only. Auto-placement becomes a suggestion, never an unseen decision. Keep `P1` hidden until its lap rules are approved. | Placing a floor-joist marker becomes two boundary picks plus one visual placement click. |
| **ST2-15** | All workflows are one Undo and leave nothing after Esc. No whole-drawing beam search during support placement. Automated tests cover sizes, UCS, switching, copied labels and shared supports; Timothy tests one support, one AB brace and one R1 marker in **10 minutes maximum**. | Smooth cursor movement with no support/beam scan lag. |

Recommendation: **approve ST-02 all.** The largest everyday improvement is ST2-14: `R1/FJ1` becomes a visual three-action drafting workflow instead of four abstract geometry picks followed by an invisible placement decision.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-69

THE ISSUE WITH THE PLUGINS IS THAT THERE ARE A LOT OF DRAFTING SITUATIONS AND THERES TOO MUCH FOR ME TO TEST, ITS ALMOST AS IF IT NEEDS TO READ THE CORPUS OF DRAWINGS SINCE 2020 TO UNDERSTAND PLACEMENT OF COLUMN, BEAM LINES, TEXT, BRACING AND ALL DRAFTING ELEMENTS AND THEN HAVE A BACKGROUND ENGINEERING ELEMENT. THE EVIDENCE IS IN THE CORPUS RATHER THAN FROM MY INDIVIDUAL TESTING. ONCE THE COMPLETE PICTURE HAS BEEN ANALISED WE CAN DISCUSS NEW COMMANDS, HOW TO AUTOMATE THINGS BASED OFF CONTEXTUAL AWARENESS, HOW THINGS SHOULD WORK AND HOW TO GET CLOSER OF THE ULTIMATE GOAL WHEREBY EVERYTHING IS DESIGNED AND DRAWN AUTOMATICALLY AND HUMANS CHECK FOR ERRORS ONLY OBVIOUSLY A LONG WAY AWAY BUT THATS THE FINAL GOAL.
✅ Approve ST-02 all
This fixes the two problem tool-families the audit flagged (the SDS-type switches and R1/FJ1) and applies ST-01's shared-support model consistently. Three standouts.

**🎯 ST2-14 — you're right it's the biggest everyday win, and it also fills a rulebook gap**
R1/FJ1 was one of the genuine **unresolved gaps** — the mining flagged it as *"don't work the way Tim intends… TEST, RETHINK, REVISE"* with no defined workflow. You're now **defining** it, and the shape is exactly right:

**four abstract geometry picks + an invisible placement decision** → **two boundary picks + a visible placement you control**

"Auto-placement becomes a **suggestion, never an unseen decision**" is the precise cure for a tool whose *whole problem* was deciding where the marker goes invisibly. You see it, you move it, you place it. And keeping **P1 hidden until its 1200 mm lap rule is approved** is the right blocked-tool handling (CV5-12 pattern — don't ship auto-behaviour from an unapproved rule).

**🚨 ST2-9 — the sharpest safety fix on the card**
The old switch "recreated nearby labels" by sweeping a **260 mm proximity circle** — which means switching one support's type could **capture and erase an unrelated nearby note** (a different column's label, a random annotation). That's proximity-guessing at its most dangerous: *data loss during a routine type change.* "Labels retained by **ownership**, never collected from a proximity circle" kills it. "A nearby column note cannot be erased during a support switch" is the guarantee.

**🏛️ ST2-7 — the shared-support linking fix**
"Link the **nearest** beam" is wrong precisely because supports are shared (ST-01). ST2-7 links **every beam end that genuinely touches the footprint** — so a column under three beams links to all three, not just the closest. That's the ST1-13 model applied at the moment of placement, and it's the direct correction of the flagged "nearest-beam linking is wrong for shared supports."

**✅ Three quick affirms**
**ST2-3** — the crosshair uses the block's **physical centre**, so the support lands where you point (the CDSOURCE base-point problem, structural edition — WYSIWYG placement).
**ST2-12** — when AB hits its 2700 cap, the preview **visibly stops at 2700 and shows MAX** *before* you click, instead of silently shortening *after*. No post-commit surprise (and BB/BT stay uncapped, per the rulebook).
**ST2-8** — switching a support type **retains centre, rotation, mark, label position and all beam links**, changing only the type. No more "recalculate centre → re-rotate → recreate labels" churn.
**🔒 Locked, nothing starts**
The switches stop capturing stray text, the markers stop deciding invisibly, shared supports link to all their beams, and nothing scans the whole drawing mid-placement. Ready for the next.
