# TOOL NOTE: Floor waste (CDFW)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places one floor waste symbol** at the point you pick, tagged FW1, FW2 ...
2. **On a pipe run it splits the pipe** into two, with the floor waste between them.
3. **One per command.** It does not carry on to the next one.

## 2. What it changes in the drawing

1. **Draws** the FLOOR WASTE block on DOWNPIPES and a small tag label on GUIDELINES (does not plot).
2. **Splits a straight pipe run** it lands on, tidies the labels and makes the two halves CE pipe objects. **Free pipe end:** becomes that end's owner. **Pit (2027 only):** writes a link to the pit.
3. **No whole-drawing record update before the pick** any more. It only makes CE's record this drawing's, without saving.
4. **Landing on a pit or pipe end by the older route:** runs the full record update after the pick, then places, splits the nearest pipe and rejoins pipe ends.
5. **Before the pick it also:** marks the drawing as a CE drawing, makes the DOWNPIPES layer if missing (an existing unlocked layer gets CE's colour and linetype back), and loads the block.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **Block file missing:** "CDFW refused - FLOOR WASTE.dwg is not in the drawing or any trusted block path. Stage the block and retry CDFW. Nothing was placed." Checked before the pick.
3. **Ambiguous, overlapping, or on another source:** asks you to pick again ("X is already at this point ... Move clear of X and pick again.").
4. **Locked DOWNPIPES or GUIDELINES layer:** checked after the pick. On the normal route (a pick you make in the drawing, in open ground, on a pit or on a free pipe end) a locked layer is refused inside the one-step placement, which rolls back; the line you read is "Floor waste could not be placed. Nothing was changed - see CE log for details." It does not name the layer (the CE log holds "The source or GUIDELINES layer is locked. Nothing was placed."). The plain locked-layer line appears only on the fallback route (a point handed in by another command, or a pick not taken as a landing). The older route has no lock check.

## 4. What it asks you, and what Enter means

1. **"Specify floor waste insertion point":** a live preview with green or red words. Enter is not accepted. Esc: "CDFW cancelled - nothing was placed."
2. **A refused spot:** asks again until a good pick or Esc.
3. **No window, no tag question.**

## 5. When it says Unknown or "needs checking"

1. **Landing words:** "Floor waste placed. Tag: FWn." plus what it joined or split.

## 6. How to undo it

1. **U once.** The placement is one change inside one command. Not proven in AutoCAD.

## 7. Known faults

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-650:** Cancel no longer clears stored pit inverts. CDFW no longer runs the full update before the pick, and that update now keeps a stored invert unless the pit's label shows an IL line. Still true: the update can switch a pit's "show invert" off and copy the label's text above and below into the record.
2. **BUG-1223, part 1:** a pick on an inspection opening sitting on pipe ends now compares like with like (switch on).

**Partly fixed**
1. **BUG-1223, part 2:** that pick is now refused with words naming the existing opening, rather than placed. Which outcome is right is Tim's call.

**New in code, no bug covers it**
1. **DOWNPIPES layer colour and linetype are reset** before the first question if the layer exists and is unlocked.
2. **A refused pick can print two lines,** its reason and then "CDFW cancelled".

## 8. On AutoCAD 2022 to 2024

1. **Pit landing refused** ("Source-to-pit placement is unavailable: Exact source COPY receipts are unavailable on this AutoCAD version."). Also on 2025 and 2026, because only the 2027 build (net10) has the check component.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1:** `Commands\FloorWasteCommand.cs:31`, `57-73`; `Services\SourcePlacementService.cs:392`.
2. **1.3:** `FloorWasteCommand.cs:57-75` (one call, no `PlacementContinuationService`).
3. **2.1:** `Services\LayerService.cs:150-152`; `SourcePlacementService.cs:204-208, 468, 495`.
4. **2.2:** `SourcePlacementService.cs:1046-1091`, `1215-1230`, `1274-1287`.
5. **2.3, 7 BUG-650:** `FloorWasteCommand.cs:41-45`; `Services\ProjectDataService.Mutations.cs:244-289`.
6. **2.4:** `SourcePlacementService.cs:1322-1378` (record update at 1332).
7. **2.5, 7 new 1:** `SourcePlacementService.cs:418-420`; `LayerService.cs:478-496`; `Services\BlockService.cs:949`.
8. **3.1:** `FloorWasteCommand.cs:36`; `Services\DrawingSafetyService.cs:61-131`.
9. **3.2:** `FloorWasteCommand.cs:49-54, 99`.
10. **3.3, 4.2:** `Services\BlockService.cs:920-928, 979-1000`; `Rules\SourcePickPipeRecordRule.cs:49-54`.
11. **3.4:** `SourcePlacementService.cs:1384-1404`, `1440-1443`; `Services\LinkService.SourceLanding.cs:612-617`; `SourcePlacementService.cs:596-602`. Route choice: `Rules\SourceLanding.cs:202-212`, `SourcePlacementService.cs:1640-1646` (a free spot, a pit and a free pipe end are all Supported, so they take the one-step placement at `462-475`); the plain locked-layer line is the fallback route only.
12. **4.1 (Enter):** `BlockService.cs:1610-1615`; cancel words `FloorWasteCommand.cs:65-70`.
13. **5.1:** `FloorWasteCommand.cs:72-74`.
14. **7 BUG-650:** `Services\ProjectDataService.cs:984-998`.
15. **7 BUG-1223:** `LinkService.SourceLanding.cs:443-450, 501-509`; `Rules\SourcePickPipeRecordRule.cs:26-31`; `Models\UserSettings.cs:774-775`.
16. **7 new 2:** `FloorWasteCommand.cs:65-70`.
17. **8.1:** `Services\SourceCloneMapNativeBridge.cs:185-229` (`#if NET10_0_OR_GREATER`; reason text at `227`); `LinkService.SourceLanding.cs:491-493` (the "Source-to-pit placement is unavailable: " wrapper); `CE_CVL_SUITE.csproj` targets net48, net8.0-windows (2025/2026) and net10.0-windows (2027).

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:33; corrected after independent review. Nothing was run in AutoCAD.
