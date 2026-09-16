# Overnight block — the windows chat (16→17 Sep 2026)

Tim: *"CAN YOU PLEASE PREPARE OVERNIGHT SEQUENCE"* (to this chat, 16 Sep evening). Two other chats already have
overnight blocks (C7/PLACE-01 chat; K/L chat). This block takes only what is this chat's, in Tim's priority order.
**Nothing is deployed overnight.** Builder then auditor, in this chat. Morning pack by 8 am 17 Sep:
`C:\CE_PLAN\01_MASTER_PLAN\MORNING_PACK_WINDOWS_2026-09-17.md`.

## Items (in order; each = failing test → build → passing test → open the real artefact → REGRESSION_LOG → commit → push)

1. **CDWT — W-01..W-05 (Tim's top priority; ruling B suspended for CDWT).** The tank window opens FIRST, before any
   command-line question; asks the tank type; lists tanks in order of size with their dimensions shown; picks the
   plan block and details from the Civil Standard Details folder (Tim's 13 Sep ruling); then the command places.
   Order of asking must "follow logic": type → size → placement. Unit-test the ordering and the list; render the
   window to PNG and open it.
2. **Computations sheet — BUG-158 / F1-01..F1-05 (unclaimed; taken here unless Tim says otherwise).** The PDF leads
   with a CREATIVE ENGINEERING letterhead sheet (no "CALCULATIONS PACKAGE" blank cover), body in order (basis of
   design → PSD / storage → volume tables → orifice → provenance), no `Note:` prefixes, no repeated detention
   section. **The auditor opens the PDF** — the 27 green text tests were the lesson.
3. **CD window polish, same idiom as PIT:** the two level "Set" toggles become ticks that say what they mean;
   invert row aligned; header chip one line at 150%. Render and open the PNGs.
4. **Audit pass (auditor role, same chat, high thinking):** re-run the full suite (quote executed count and the
   23 known names), re-read every diff, open every PNG and the PDF, re-check the four guards (PreviewAvailable,
   two TryUpdatePipeAttachmentDisplay call sites, PitEditCommand shift path, DialogService fit fallback).
5. **Morning pack** — one page, three lists: built / test this (exact steps, what "right" looks like, 2027 lane;
   2024 where it applies) / needs Tim.

## Fences

- Own files only: `Dialogs/PipeOnePageLayout.cs`, `PitOnePageLayout.cs`, `Controls/*Preview*`, `PlanAreaRenderer`,
  `PitConnectionStub*`, `PitCornerGuide`, `ViewModels/CdViewModel*`, `PitViewModel*`, the preview parts of
  `PitEditCommand` / `PipeEditCommand*`, **all of CDWT** (`WaterTank*`, `Rules/TankLibrary.cs` shared read-only with
  K/L — K/L reads it, this chat may change it and says so in the pack), and the computations sheet files
  (`Rules/ComputationsSheetV3.cs`, `Rules/ComputationsRecord.cs`, `Services/ComputationsRecordBuilder.cs`,
  `Services/CalculationExportPackage.cs`, the PDF writer it calls).
- Never: `CdCommand*`, `LinkService*`, `NativeObjects*`, `PipeTruthResolverService*` (C7 chat); `LpdCommand`,
  `LpdService`, `PitAnnotationShift`, `PitEditCommand.Resize`, `DetentionBranchCollector`, `StormReport`,
  `PropagationPlan`, `RepairAudit.*` (K/L chat); `Shared/CE_SHARED` (say so first).
- Every build/test: `-p:SkipDevBundle=true -nr:false --disable-build-servers` + the three `_AcadRef*` paths;
  AutoCAD 2027 on PATH for tests; quote executed counts; compare failure names against the 23.
- Park anything needing Tim's decision (write the question, never decide it). Out of unblocked work → stop, say so.
- If stopped early (usage limit, blocker) the pack still lands, saying where and why.

## Baseline at the start of the block

Trunk `claude/ce-civil-handoff-sept-16-5623ca` @ `595c8672`. Live `6505fb5a`. Full suite 9804 run / 9764 passed /
23 failed (known names) / 17 skipped. Payload waiting (built, not installed): PIT-CONN-01, CD-PREVIEW-01a, POLISH-01,
PIT-TYPE-01, CLICK-01, DRAG-01, PERF-003, DRYRUN-01, PIT-TWEAKS-01 (PENDING_TESTS L8–L15).
