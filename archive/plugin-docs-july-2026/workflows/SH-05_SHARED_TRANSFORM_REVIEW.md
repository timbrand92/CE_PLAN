# SH-05 — Shared Move/Copy Rotate Workflow

**Canonical card ID:** `TF-01` · legacy work-card/file ID: `SH-05`
**Status:** `TF1–TF15` + Tim's refinements ✅ LOCKED · 2026-07-21

**Scope:** `MR`, `MOVEROT`, `CR`, `COPYROT`, their shared implementation/fallback and the office `C` alias.
No command implementation is authorised by this card.

## 1. Current state

| Current implementation | Classification |
|---|---|
| `Copy Rotate.lsp` v2.2 is byte-identical in Civil/Structural and is Tim's proven reference | **Keep as MR/CR behavioural reference and migration fallback** |
| Civil registers `C`, `MR`, `CR`, `MOVEROT`, `COPYROT` | **Modify ownership; CE must release `C`** |
| Structural also registers `MOVEROT` and `COPYROT` | **Retire duplicate registration** |
| Civil native C# MR/CR path exists but defaults off | **Preview until parity evidence + Tim feel check** |
| Structural transform service is another bridge to the same LISP | **Consolidate, not a second implementation** |
| Custom-UCS origin, Cancel/Undo and interactive feel remain incompletely evidenced | **Automate + one representative Tim check** |

## 2. Locked decisions

| ID | Locked decision |
|---|---|
| `TF1` | LISP v2.2 MR/CR behaviour is the gold standard until replacement parity is proven. |
| `TF2` | Office command `C` remains native AutoCAD `COPY`, configured by Tim in PGP; CE does not register/own `C`. |
| `TF3` | CE retains `MR`, `MOVEROT`, `CR`, `COPYROT`; `C` is documented only as the external office/native alias. |
| `TF4` | The four CE transform commands have one Shared owner/registration/asset; Civil/Structural duplicates retire. |
| `TF5` | Consolidate first on the proven LISP MR/CR path; native C# remains Preview until automated evidence + Tim parity pass. |
| `TF6` | Native parity requires identical preselection, prompts, dragging, OSNAP, typed coordinates and native command feel. |
| `TF7` | MR moves originals, then rotates around the destination; nothing remains at source/WCS origin. |
| `TF8` | CR makes one copy and moves/rotates only it around the destination; originals stay untouched. |
| `TF9` | Active UCS is respected; no hidden World conversion or phantom entity at `(0,0,0)`. |
| `TF10` | MR/CR remain blocked in REFEDIT with a clear `Run REFCLOSE first` message. |
| `TF11` | Escape before completion fully rolls back. Enter/0° at rotation explicitly commits move/copy without rotation. |
| `TF12` | Completed MR/CR is one Undo; temporary system variables/selection state always restore. |
| `TF13` | Obey native protection for locked layers, Xrefs and unsupported objects; never bypass AutoCAD safeguards. |
| `TF14` | Keyboard aliases remain primary; one quiet Shared Transform entry + contextual Help aids discovery without reminders. |
| `TF15` | Automate WCS/UCS output, originals/copies, Undo, Escape, sysvars and aliases; one ≤5-minute Tim feel check; retain LISP fallback for one Stable release. |

## 3. `C` ownership correction

```text
PGP / AutoCAD                         CE plugin
C → native COPY                       MR / MOVEROT
(Tim owns alias configuration)        CR / COPYROT
```

CE must not register `[CommandMethod("C")]`, define runtime AutoLISP `c:C`, or change `COPYMODE` on behalf of
the PGP alias. Help may explain the office convention so a new hire expecting Circle understands it.

The untouched v2.2 file remains the migration reference. The shared runtime fallback must expose only MR/CR
behaviour (for example an MR/CR-only derived asset or namespaced internal functions) so loading the fallback
cannot silently override Tim's PGP-owned `C` alias.

## 4. Cancel, finish-without-rotation and Undo

```text
MR/CR → place destination → rotation prompt
                           ├─ angle accepted → commit whole action
                           ├─ Enter or 0°    → commit without rotation
                           └─ Escape         → restore exact starting state

After commit: one UNDO restores the exact starting state.
```

Move-only/copy-only is an explicit completion choice, never an Escape side-effect.

## 5. Plugin-wide native-protection rule

TF13 applies to every present/future transform or edit command, not only these four:

- respect locked layers, Xrefs, REFEDIT boundaries and unsupported-object rules;
- use normal AutoCAD selection/protection behaviour and messages;
- never unlock, detach, explode, clone around or otherwise bypass protection silently;
- any proposed exception requires its own reviewed workflow, preview and explicit user approval.

## 6. Migration and evidence

1. One Shared owner registers MR/CR plus long aliases and calls the proven MR/CR-only fallback.
2. Remove Civil/Structural duplicate registrations; remove `C` registration/definition from CE runtime.
3. Run automated WCS/UCS, selection, object-state, Cancel, Undo, sysvar and alias scenarios.
4. Tim performs one ≤5-minute native-feel comparison.
5. Only then can native C# become Active; keep the LISP fallback through one Stable release.

## 7. Approved outcome, not blanket coding approval

SH-05 behaviour is approved. Implementation still needs an exact owned-file/test slice and Tim's approval
before files outside planning documents change.
