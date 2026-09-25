# ST-06 — Foundations, piers and reinforcement

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-145`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# ST-06 — Foundations, piers and reinforcement

## Current AutoCAD state

| Commands | What happens now | Treatment |
|---|---|---|
| `FST` | Stores commonly used foundation sizes | **Keep and improve** |
| `THC`, `PFC` | Creates thickening/pad-footing rectangles | **Rebuild preview and compound behaviour** |
| `SF`, `REB`, `RIB` | Draws strip footings and raft beams from selected/drawn paths | **Keep core; improve workflow** |
| `FADOPT` | Finds legacy geometry by layers and nearby labels | **Unsafe inference: preview and confirm** |
| `FEDIT` | Edits through a long prompt sequence | **Replace with focused visual editing** |
| `FREGEN/FREGENALL` | Regenerates linked foundation graphics | **Keep with bounded scope** |
| `FDELETE` | Deletes an entire foundation system | **Too broad: rebuild** |
| `BP`, `SPW…` | Duplicate bored-pier workflows | **Consolidate while retaining aliases** |
| `SCREWPILE` | Uses a block, but falls back to an approximate circle | **Remove fallback; use Approved asset** |
| `STUMPFOOTING` | Places circular/rectangular footings repeatedly | **Keep; improve preview and identity** |
| `RBL` | Draws rebar line, ticks and label | **Working tested core; rebuild as compound** |
| `RBC` | Draws circular reinforcement arrangement | **Working core; clarify radius and cover** |
| `STR`, `BWT` | Stirrup and bar-weight commands remain registered | **Already ruled for permanent retirement** |
| `FSTEXPORT` | Produces a separate MText footing schedule | **Move schedule output to ST-07** |

## Decisions ST6-1–ST6-15

| # | Recommended decision |
|---:|---|
| **ST6-1** | ST-06 owns raft beams, thickenings, strip/pad footings, bored piers, screw piles, stump footings and reinforcement placement. ST-07 owns schedules. |
| **ST6-2** | `FST` becomes the canonical **Foundation workspace**. Preserve frequent aliases including `THC`, `PFC`, `SF`, `REB`, `RIB`, `BP`, `SPW`, `RBL` and `RBC`. |
| **ST6-3** | The drawn driver is the geometry authority; its embedded CE record owns type, mark, size, depth, source and approval status. The size library is project information—not an automatic engineering designer. |
| **ST6-4** | Missing size/depth becomes **Unknown**, never zero. User-entered values are marked Manual/Designed with their source. CE cannot invent a footing size from the mark or from historical popularity. |
| **ST6-5** | Placement workflow: **select/draw geometry → choose type/mark/size → live complete preview → Flip/Rotate if relevant → Apply**. Preselection is supported so existing linework can be converted without redrawing it. |
| **ST6-6** | `REB`, `RIB` and `THC` require an explicitly selected raft/slab host. The relationship is permanent. Moving the host rechecks its foundation elements; CE never chooses a host merely because it is nearby. |
| **ST6-7** | `FADOPT` becomes Preview-only initially. It lists proposed geometry, labels and types individually. Timothy confirms ambiguous matches; proximity alone cannot adopt or relabel anything. |
| **ST6-8** | Every footing element is one compound: driver geometry, generated outlines/hatch, label and design data. The raft host is shared and is not owned or deleted by any individual beam/thickening. |
| **ST6-9** | MOVE updates only the selected foundation group. COPY creates fresh identities and links to the correct host. EDIT preserves manual label placement. ERASE offers **Element only** or **Entire system**, showing exact counts before Apply. |
| **ST6-10** | `FREGEN` preserves authored positions and approved values. `FREGENALL` is an explicit Manager action with a preview count. No regeneration on drawing open and no whole-drawing scan while drafting. |
| **ST6-11** | Consolidate `BP`, `SPW`, `SPW3`, `SPW6` and `SPWC` on one bored-pier engine while retaining aliases. Preview clearly selects **At cut: green/solid** or **Below: yellow/hidden**, plus 300/450/600 diameter and approved hatch state. |
| **ST6-12** | Screw-pile and stump-footing graphics must come from stable, individually Approved AS-01 assets in the Plugin bundle. If the asset is missing, placement is blocked—never substitute an approximate circle or use `C:\Lisp Files`. |
| **ST6-13** | `RBL` and `RBC` become compounds. The preview displays bar size, spacing/count, zone, orientation and exact final label. For `RBC`, state explicitly that the picked radius is the **bar-centre radius**, avoiding cover ambiguity. |
| **ST6-14** | Permanently remove `STR` and `BWT` from ordinary command registration as already ruled. `FSTEXPORT` redirects to the single ST-07 schedule engine so the drawing cannot contain two disagreeing footing schedules. |
| **ST6-15** | Automate foundation geometry, host relationships, copy identity, regeneration, deletion, schedules and rebar arrangements. Timothy’s final AutoCAD check is approximately six representative actions in 10–12 minutes. |

## AutoCAD examples

### Raft internal beam

```text
Preselect centreline
Command: RIB

Host: Raft Slab 1
Mark: IB2
Width: 300
Depth: Unknown

Preview:
  beam outline
  IB2 label
  host relationship
  Unknown-depth warning

Apply → one compound foundation element
```

CE does not quietly convert the missing depth to `0`.

### Safe legacy adoption

```text
FADOPT → select raft perimeter

Preview:
  6 internal beams confidently matched
  2 labels ambiguous
  1 closed rectangle proposed as TH1

Confirm the 6
Review the 3 exceptions
```

No nearby text is captured automatically.

### Bored pier

```text
SPW3
State: Below
Preview: 300 DIA., yellow, HIDDEN
Click repeatedly to place
Esc finishes cleanly
```

```text
BP
Diameter: 450
State: At cut
Concrete hatch: Yes
Preview: approved green/solid graphic
```

Both use the same engine and stable Approved block.

### Rebar line

```text
RBL
Bar: N12
Spacing: 200
Zone: Top
Pick start → pick end

Preview:
  rebar line and end ticks
  N12-200 T
  proposed label position

Apply → one editable compound
```

MOVE carries its graphics and label. Editing the label does not disconnect it. COPY creates an independent reinforcement item.

Reply **“Approve ST-06 all”** or list the decisions to revise.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-146

✅ Approve ST-06 all
One theme runs through this whole card, and it's the right one for foundations: **CE never fakes engineering.** Not a size, not a graphic, not a value.

**🔒 ST6-3 + ST6-4 — the foundation** **firewall**
The FST size library is a **convenience** (project info you pick from), **not an engineering designer** — it doesn't auto-select the footing. And CE never *invents* a size:

**not from the mark name** (IB2 doesn't imply a size),
**not from "historical popularity"** (that's the corpus firewall — frequency can't establish an engineering value, EV5-3),
**and never as a false zero.** A missing depth is **Unknown with a warning**, a user value is **Manual/Designed with its source**.
Your example is exactly right: *"Depth: Unknown → Unknown-depth warning; CE does not quietly convert the missing depth to 0."* A footing silently sitting at depth 0 is the same dangerous-false-value that's threaded through every card — here it would be a structural one.

**🚫 ST6-12 — the sharpest single fix, and the same principle at the** ***asset*** **level**
SCREWPILE currently **falls back to an approximate circle** when its block is missing — a graphic that *looks* like a screw pile but isn't the approved one. Blocking placement on a missing asset (never substituting a fake, never reaching into C:\Lisp Files) is the honest response. **A wrong-but-plausible graphic is worse than an honest block** — it reaches construction looking correct. Fail-loud beats fail-fake.

**🔍 ST6-7 —** **FADOPT** **stops** **guessing**
It finds legacy geometry "by layers and nearby labels" — proximity inference. Now it's **propose-and-confirm**: each match listed individually, Tim confirms the ambiguous ones, and *"no nearby text is captured automatically."* Your example (6 confidently matched, 3 exceptions to review) is the pattern — adopt what's certain, surface what isn't, guess nothing.

**🏛️ ST6-8 + ST6-9 — shared host protected,** **broad** **delete** **tamed**
The raft **host is shared** — deleting one raft beam can't delete the slab that other beams sit on. That's the ST1-13 shared-resource rule, applied to foundations.
**FDELETE stops being a broad "delete the whole system."** ERASE now offers **Element only** or **Entire system**, showing **exact counts before Apply** (CV19 deletion safety). You see "this removes 14 elements" before it happens.
**📐 ST6-13 — a real engineering-clarity** **fix**
For RBC, stating explicitly that the picked radius is the **bar-centre radius** removes a genuine ambiguity — is it bar-centre, pitch-circle, or cover-to-bar? Getting that wrong means the reinforcement is drawn in the wrong place. Naming it kills the ambiguity.

**✅** **One** **quick** **affirm**
**ST6-14** — STR/BWT retired as previously ruled, and FSTEXPORT redirected to the **single** **ST-07** **schedule** **engine** so the drawing can't hold two disagreeing footing schedules (one-authority for schedules, PS-01).

**🔒** **Approve** **—** **nothing** **starts**
No invented sizes, no fake assets, no false zeros, no proximity adoption, no broad silent deletes, shared hosts protected, and the bored-pier variants consolidated onto one engine with the approved green/solid vs yellow/hidden conventions. Ready for ST-07.
