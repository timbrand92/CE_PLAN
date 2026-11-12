# TOOL NOTE: Overflow (OF)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places an overflow symbol** at the point you pick, tagged OF1, OF2 ...
2. **On a pipe run it splits the pipe** into two, with the overflow between them.
3. **Carries on** to the next one until Esc.

## 2. What it changes in the drawing

1. **Draws** the OVERFLOW block on DOWNPIPES and a small tag label "OF" on GUIDELINES (does not plot).
2. **Splits a pipe run** it lands on. **Free pipe end:** becomes that end's owner. **Pit (2027 only):** writes an overflow-to-pit link.
3. **Before the point question:** marks the drawing as a CE drawing, makes the DOWNPIPES layer if missing, loads the block. No whole-drawing record update on the normal route.
4. **Tag numbers are never reused.**

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **Ambiguous, overlapping, or on another source:** asks you to pick again.
3. **Locked DOWNPIPES or GUIDELINES layer:** checked after the pick. On the normal route (a pick you make in the drawing, in open ground, on a pit or on a free pipe end) a locked layer is refused inside the one-step placement, which rolls back; the line you read is "The source could not be placed. Nothing was changed - see CE log for details." It does not name the layer (the CE log holds "The source or GUIDELINES layer is locked. Nothing was placed."). The plain locked-layer line appears only on the fallback route (a point handed in by another command, or a pick not taken as a landing).
4. **Missing block file:** only "OF command cancelled."; reason in the CE log.

## 4. What it asks you, and what Enter means

1. **"Specify overflow insertion point":** Enter is not accepted. Esc: "OF command cancelled."
2. **Refused spot:** "Move the source and pick again, or press Esc."
3. **Next one:** "Pick the next OF, or press Esc to stop."
4. **No tag question, no window.**

## 5. When it says Unknown or "needs checking"

1. **Landing words** after each one say what it joined or split.

## 6. How to undo it

1. **U once per overflow,** including any split. Not proven in AutoCAD.

## 7. Known faults

**Still there in this build** (shared with all source commands)
1. **BUG-1209:** no placing on a pit on AutoCAD 2022 to 2026.
2. **BUG-1118:** the placing preview is a fixed size in drawing units.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1145:** an Xref'd Pit Schedule reading "OUT OF DATE" when nothing changed. The check now covers only what the schedule shows (switch on), for schedules placed after this change. Not OF's own code.

**Filed under OF but belongs to FO**
1. **BUG-1236:** see the FO note. OF itself shows "OF" correctly.

**Question for Tim, not a fault**
1. **An overflow splits a pipe it lands on,** because only downpipes are kept from splitting. The rule's own note names inspection openings, GIOs, floor wastes and trench grates as the in-line ones; overflows are not named.

## 8. On AutoCAD 2022 to 2024

1. **Pit landing refused.** Also on 2025 and 2026.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1:** `Commands\SourceBlockInsertCommands.cs:75-82`, `113-126`, `876-891`; `Services\BlockService.cs:42`.
2. **1.2, 2.2, 7 question:** `Rules\SourceLanding.cs:58-69`; `Services\LinkService.SourceLanding.cs:663-725`.
3. **1.3, 4.3:** `SourceBlockInsertCommands.cs:895-899`; `Services\PlacementContinuationService.cs:43-76`.
4. **2.1:** `Services\LayerService.cs:150-152`; `Services\SourcePlacementService.cs:468, 495`; label words `Rules\SourceNumbering.cs:24, 34-50`.
5. **2.3:** `SourcePlacementService.cs:415-420`; `BlockService.cs:949`.
6. **2.4:** `Services\SourceTagService.cs:196-240`.
7. **3.1:** `SourceBlockInsertCommands.cs:122`; `Services\DrawingSafetyService.cs:61-131`.
8. **3.2, 4.2:** `Rules\SourceLanding.cs:103-137`; `Rules\SourcePickPipeRecordRule.cs:49-54`; `BlockService.cs:920-928, 979-1000`.
9. **3.3:** `SourcePlacementService.cs:1384-1404`, `1440-1443`; `LinkService.SourceLanding.cs:612-617`; `SourcePlacementService.cs:596-602`. Route choice: `Rules\SourceLanding.cs:202-212`, `SourcePlacementService.cs:1640-1646` (a free spot, a pit and a free pipe end are all Supported, so they take the one-step placement at `462-475`); the plain locked-layer line is the fallback route only.
10. **3.4:** `BlockService.cs:952`; `SourceBlockInsertCommands.cs:888`.
11. **4.1 (Enter):** `BlockService.cs:1610-1615`.
12. **7 BUG-1145:** `Models\UserSettings.cs:701-706`; `Services\ProjectDataFingerprintService.cs:45-91`; `Services\PitScheduleStatusService.cs:196`.
13. **7, 8 shared:** `Services\SourceCloneMapNativeBridge.cs:185-229`; `SourcePlacementService.cs:1656-1658`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:33; corrected after independent review. Nothing was run in AutoCAD.
