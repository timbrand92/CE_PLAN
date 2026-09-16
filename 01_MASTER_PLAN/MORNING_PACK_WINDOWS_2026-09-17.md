# Morning pack — windows chat, 17 September 2026

**Everything below is BUILT and unit-tested. Nothing is installed. Nobody has opened any of it in AutoCAD.**
Live is still `6505fb5a` (read the DLL yourself). Branch `claude/ce-civil-handoff-sept-16-5623ca`, tip `17847985`, pushed.
Full Drainage suite on the tip: **9,810 run / 9,771 passed / 22 failed / 17 skipped** — the 22 are the known
pre-existing names; one of the old 23 (`PreviewPackage_AllSections…`) now passes. net48 / net8 / net10 build 0 errors.
Audit pass done: every picture and both printed pages opened; the four guards re-checked (PreviewAvailable separate
from presets; two `TryUpdatePipeAttachmentDisplay` call sites; PitEditCommand shift path unchanged; DialogService fit
fallback intact); no file outside this chat's fence was touched.

## 1. Built overnight (the block), plus what was already waiting on the branch

| Ref | What you will see in AutoCAD |
|---|---|
| **CDWT-W01** | `CDWT` shows the tank window FIRST — no "Adopt or Insert" at the command line. It had been crashing while opening (a radio button fired before its partner existed) and silently falling back to the command line; fixed. "Tag a block already in the drawing" is now a button in the window. |
| **BUG-158 / F1** | `CDCALC` → Export PDF: page 1 is a CE letterhead sheet (logo, CREATIVE ENGINEERING / DRAINAGE COMPUTATIONS, job strip, then Basis → Detention → Storage → Volume tables → Orifice → Where the figures came from). No "Note:" lines, no blank cover, no repeated detention page. XLSX "Computations" tab reads the same. |
| **CD-TICKS-01** | Edit Pipe: the two level "Set" buttons are ticks. |
| Already on the branch (built earlier on 16 Sep) | PIT-CONN-01 pit lists its pipes · CD-PREVIEW-01a new pipe shows the real plan · POLISH-01 · PIT-TYPE-01 stormwater no longer "CHARGED" · CLICK-01 click the picture · DRAG-01 drag the corner badge · PERF-003 lag fix (merged from the lag chat) · DRYRUN-01 the picture shows what Save would do · PIT-TWEAKS-01 sump tick, size drop-down · BUG-159 `CDGRIPDIAG` (merged). |

## 2. Test this (2027; after ONE deploy of the combined payload — say "AutoCAD is closed, deploy")

Full steps are rows **L8–L18** in `PENDING_TESTS.md`. The ones that decide most:

1. **`CDWT`** — the window appears immediately. If the command line asks "Adopt or Insert" first, the window failed
   to open: paste the `[CE]` line.
2. **`CDCALC` → Export PDF → print to PDF → OPEN THE PDF.** Page 1 must be the CE sheet described above. Say what
   still looks wrong on the page.
3. **Edit Pit P10** — the Connected pipes list shows P10→P9 as Entering/Leaving (not CHARGED) with its tag on the
   picture; the picture is the real plan; click a tag → the list follows; drag the gold badge to a corner → the
   label corner list changes.
4. **Dry-run preview, the one test only AutoCAD can prove:** Edit Pit, change 450 → 1200, wait a second (picture
   redraws with the bigger pit and stepped-out label), **Cancel, then `U` once** — only your previous real edit
   undoes. If anything else changes, stop and tell me; I pull the dry-run out (two lines) before anything ships.
5. **Edit Pipe** — real plan along the pipe, gold ring and caption at each end, ticks instead of Set, click a ring →
   cursor in that end's level box. Change diameter and text side, wait: the picture shows the new text.
6. **PERF-003** — a drawing from the Temp folder or a standard-details folder should feel like any other drawing;
   the pit schedule status may lag up to 5 s, never stuck. CE must still refuse to auto-edit a Temp-folder drawing.
7. **New pit / new pipe** — New Pit shows the block with stubs; New Pipe shows the real plan along the picked route.

## 3. Needs Tim (decisions and answers — nothing here was decided for you)

- **"Sump pit · own bottom IL"** — is that what you meant by "BOTTOM IL FOR SUMP PIT – TICK ON/OFF"? If you meant a
  sump depth or a schedule column, that is a bigger item and I need your words.
- **Dry-run Undo** — test 4 above decides whether the throw-away is clean. Untested claim until then.
- **Deploying PERF-003 changes CE_SHARED.** Civil is the only bundle I install; the Structural half of the lag fix is
  NOT live until Structural is redeployed, and Manager's copy of CE_SHARED must be brought into step by hand at
  deploy time (first-loaded wins). I will say this again at deploy.
- **The other two overnight chats** (C7/PLACE-01, K/L) — bring me their branch names and tips; I merge everything
  into one payload and install once. Do not let anyone deploy separately.
- **Rainfall warning appears twice on the sheet** (basis of design and provenance) by the sheet builder's design —
  say if you want it once.
- **Parked, not started:** CD preview text/arrow "where it will land" is covered by the dry-run; nothing else parked
  from this chat. Ideas inbox: `docs/IDEAS_INBOX.md` (three PIT ideas, all built).

## Rollback, per item, if something misbehaves in AutoCAD

Each REGRESSION_LOG entry (LAYOUT-01 … CD-TICKS-01) names its files. The dry-run is two lines (`vm.DryRunPreview = …`
in `PitEditCommand` and `PipeEditCommand`). The bundle backup from the last deploy is
`CE_CVL_SUITE_PRE_0737efa3_20260916_160353.backup`; the next deploy makes a new one and I will name it.
