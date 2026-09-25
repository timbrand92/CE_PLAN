# ST-05 — Hatching, utilities and Xrefs

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-140`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# ST-05 — Hatching, Xrefs and drawing utilities

## Current AutoCAD state

| Tools | Current behaviour | Treatment |
|---|---|---|
| 18 hatch aliases | One reasonably shared engine | **Keep and refine** |
| `EH`, `CH`, `WH` | Earth, concrete and waffle presets work | **Keep familiar workflow** |
| `21H`, `51H`, etc. | Solid colour hatch shortcuts | **Catalogue as presets** |
| `LBH`, `LBUH`, `BLH` | Structural hatch conventions | **Keep pending asset approval** |
| Objects/Points selection | Supports preselection and internal points | **Keep** |
| Hatch scale | Many commands accept only 1:20 or 1:100 settings | **Rebuild** |
| Hatch creation | Drives AutoCAD’s changing command-line prompts | **Rebuild stable native placement** |
| `H2A` | Recreates hatches as associative | **Unsafe: may erase original before replacement succeeds** |
| `XRL` | Moves every Xref reference onto `XREF` | **Modify with preview** |
| `CXREF/PXREF` | Copies an Xref, Xclip and layer overrides between drawings | **Useful core; modify** |
| `CLEAN` | Purges, changes Xrefs/styles/ByLayer settings and then saves | **Serious broad-write risk: rebuild** |
| `FASTSAVE` | Still runs part of the cleanup system | **Separate saving from cleanup** |
| `MOVEROT/COPYROT` | Duplicate Structural ownership | **Redirect to locked TF shared tools** |

## Decisions ST5-1–ST5-15

| # | Recommended decision |
|---:|---|
| **ST5-1** | ST-05 owns hatch placement/conversion, Xref utilities and controlled drawing cleanup. `MR/CR/MOVEROT/COPYROT` remain owned by the already-approved shared Transform system. |
| **ST5-2** | Keep all familiar hatch aliases. They become catalogue presets on one hatch engine—not 18 separately maintained commands. |
| **ST5-3** | Each preset records its pattern, purpose, layer, colour, plotted density, angle, background and origin behaviour. Only individually **Approved** AS-01 presets become normal defaults; Candidate presets are Preview-only. |
| **ST5-4** | Hatch workflow: **run alias → choose/preselect Objects or pick internal Points → see live result → adjust Scale/Angle/Origin → click Apply**. Esc creates nothing. |
| **ST5-5** | Create native associative AutoCAD hatches. They remain editable through `HATCHEDIT`, grips and Properties. CE must not explode a hatch or replace it with loose lines. |
| **ST5-6** | Replace the current 1:20/1:100-only test. Hatch density is based on the actual plot/viewport scale, supporting normal scales such as 1:20, 1:50 and 1:100. The preview shows the plotted appearance. |
| **ST5-7** | Approved preset angle and origin are initial values. During preview, **R = rotate** and **O = set origin**. `WH` visibly previews its waffle origin before Apply. |
| **ST5-8** | Preserve islands, openings, boundary selection and draw order. Hatches normally move behind linework. Multiple enclosed regions remain independently editable unless the user deliberately combines them. |
| **ST5-9** | Hatches owned by a CE object—such as a load-bearing-wall graphic—store that relationship. General material hatches remain independent. Proximity never creates ownership. |
| **ST5-10** | Rebuild `H2A`. The original hatch remains untouched until the associative replacement is proven. Preserve pattern, scale, angle, origin, islands, layer, colour, background, transparency and draw order. Any failure leaves the original intact. |
| **ST5-11** | `XRL` first reports: **“12 Xref instances will move to CE XREF.”** Preview highlights them; Apply changes only the reference objects—not the source DWGs or their internal layers. One Undo restores all changes. |
| **ST5-12** | `CXREF/PXREF` retains attachment/overlay type, path type, insertion, scale, rotation, Xclip and layer overrides. Paste offers **Original coordinates** or **Pick location**, with a visible preview and unit check. Missing paths block safely. |
| **ST5-13** | Split cleanup from saving. `CLEAN` becomes **Audit → proposed repairs with counts → Preview → explicit Apply → one Undo**. It must never silently merge styles, alter all Xrefs or force ByLayer changes. |
| **ST5-14** | `FASTSAVE` becomes save-only. It performs no purge, style conversion, Xref movement or drafting alteration. `CLEAN` never forces `QSAVE`; Timothy decides when to save. |
| **ST5-15** | Automated tests cover every preset, scale, boundary, cancellation, `H2A` rollback, Xref state and cleanup plan in AutoCAD 2022/2027. Timothy checks approximately six representative actions in under ten minutes. |

## Practical AutoCAD examples

### Concrete hatch

```text
Command: CH
Select closed concrete boundary
Preview: AR-CONC on approved CE layer
Scale: 1:50 plotted density
R: rotate if required
Click: associative hatch placed behind linework
```

Moving the boundary updates the hatch. `HATCHEDIT` continues working normally.

### Safe `H2A`

```text
Select 8 old non-associative hatches
Preview:
  6 can be converted
  2 have unresolved boundaries

Apply converts only the proven 6
The unresolved 2 remain unchanged
One Undo restores all 6
```

The current erase-before-proof behaviour is prohibited.

### Xref copy between coordinated plans

```text
CXREF → select architectural Xref
PXREF in structural drawing

Preview:
  Attachment: Overlay
  Position: Original coordinates
  Units: millimetres
  Xclip: retained
  Layer overrides: 17 retained

Apply → one complete Xref attachment
```

If the target drawing uses different coordinates, choose **Pick location** rather than placing it unseen hundreds of metres away.

### Drawing cleanup

```text
CLEAN

Audit only:
  14 unused definitions
  3 non-standard Xref reference layers
  6 possible style changes
  27 possible ByLayer changes

Nothing changes until Timothy selects repairs and presses Apply.
No automatic save.
```

Reply **“Approve ST-05 all”** or list the decisions to revise.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-141

LBH, LBUH, BLHStructural hatch conventions

THESE ARE USED VERY OFTEN NEED TO KEEP
✅ Approve ST-05 all
This card rebuilds the three most genuinely dangerous tools in the structural set — and they were dangerous in exactly the two ways this whole rebuild targets: destroy-before-verify and mass-silent-change.

🚨 ST5-10 (H2A) — a data-loss fix
"May erase the original before the replacement succeeds" means a failed conversion loses your hatch — gone, with nothing to fall back to. "The original remains untouched until the associative replacement is proven; any failure leaves the original intact" is the prove-then-replace rule — the same principle as RS9 (never delete the working bundle before the new one is verified). Your example is partial-success done safely: 6 convert, 2 have unresolved boundaries → convert the 6, leave the 2, lose nothing. And "the current erase-before-proof behaviour is prohibited" — banned outright, correctly.

🚨 ST5-13 (CLEAN) — the broad-write fix
CLEAN was arguably the scariest tool in the plugin: it purged definitions, rewrote Xrefs, merged styles, forced ByLayer changes — and then saved. Mass silent changes, committed to disk, in one command. Turning it into Audit → proposed repairs with counts → Preview → explicit Apply → one Undo, no auto-save is the read-only-audit + preview-apply treatment (CV8-3 + QA12). Your example nails it — it reports "27 possible ByLayer changes" and does nothing until you select repairs and press Apply. That's the only safe way to run a broad-write tool.

🔧 ST5-14 completes it — save is not cleanup
FASTSAVE mixing save with cleanup meant saving silently also changed your drawing. Separating them — FASTSAVE saves only, CLEAN never forces QSAVE, you decide when to save — removes the trap. Two responsibilities, cleanly split (the ST-04 separation-of-concerns discipline, applied to utilities).

🛡️ ST5-11 + ST5-12 — Xref utilities respect foreign content
XRL reports first ("12 Xref instances will move to CE XREF"), and Apply changes only the reference objects — never the source DWGs or their internal layers. That's the native-protection rule (don't modify foreign/xref content) applied precisely.
CXREF/PXREF keeps full fidelity (attachment type, Xclip, the 17 layer overrides) and offers Original coordinates or Pick location with a unit check — so a copied Xref can't silently land hundreds of metres away or arrive in the wrong units (the CV16 units/datum discipline, at the Xref level).
✅ The hatch family follows the settled model
Presets on one engine (not 18 commands), native associative hatches that stay editable through HATCHEDIT and never get exploded (ST5-5), plotted-scale-aware density replacing the 1:20/1:100-only limitation (ST5-6), ownership by relationship not proximity (ST5-9). Consistent with everything before it.

🔒 Approve — nothing starts
The dangerous utilities are now prove-before-replace, audit-before-write, and save-separated-from-cleanup; MR/CR/MOVEROT/COPYROT correctly defer to the already-locked TF shared Transform system. Ready for the next.
