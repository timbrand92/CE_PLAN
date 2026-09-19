# CE_CVL_SUITE — Parking Lot

Items noted during development that are worth doing but not urgent enough to block current work.
Pick these up at the start of a future session.

---

## PL-072: Civil commands + reactors must stay out of Structural drawings — ✅ BUILT 2026-06-04, awaiting AC verify

**What:** Tim works structural jobs and civil jobs in the same AutoCAD. The civil plugin's CD commands would run on (and stamp) structural drawings, and once stamped the reactors treated that structural drawing as civil forever. PL-071 stopped the reactors meddling with content-less drawings; PL-072 adds the command-side gate and a positive Structural signal so civil tools self-disable on structural drawings.

**Decision order (first match wins):** explicit in-drawing tag (CDDISCIPLINE / first-use prompt) → CE STRUC file-name token `_STR_`/`_CVL_` → existing civil content (legacy) → otherwise ask once. Structural ⇒ CD commands blocked with one-off `Yes` override, reactors inert. Headless host never prompts.

**Fix:** New `Services/DrawingDisciplinePolicy.cs` (pure rules, 16 unit tests), `Services/DrawingDisciplineService.cs` (NOD tag `CE_CVL_DISCIPLINE`, prompts, headless bypass), `Commands/DisciplineCommand.cs` (`CDDISCIPLINE`). Hooks: `DrawingSafetyService.CommandPreFlight` (gate), `ProjectDataService.MarkDrawingActive` (safety net), `LinkService.Utilities.IsCeOwnedDrawing` (reactor authority). Registered `CDDISCIPLINE` in `command-registry.json`.

**Status:** Code complete + build-verified. net10 `0 err`; unit suite `1126 pass / 6 pre-existing env-fail / 36 skip` (16 new tests pass, baseline failures unchanged). The earlier `DrawingService.cs` blocker (parallel PITSCHEDULE session) resolved itself — tree compiles clean. **Deploy + AC verify still pending** — AutoCAD was open so the dev-bundle copy was skipped; close AC + rebuild to deploy (build bumped to v2.1.0.1). See REGRESSION_LOG FEATURE (PL-072).

**Raised:** 2026-06-04 (Tim's "structural jobs shouldn't get civil commands/reactors") | **Priority: High — built, pending verify**. Builds on PL-071.

---

## PL-071: CE reactors should short-circuit in non-CVL drawings

**What:** The CE plugin attaches `OnObjectModified` / `OnObjectErased` / `OnCommandWillStart` reactors to EVERY drawing AutoCAD opens, not just CE-managed drawings. Tim hit a DBText / DDEDIT / MOVE corruption (R22, 2026-05-27) in a totally non-CVL drawing — the plugin was meddling with foreign content because it had no way to tell that drawing wasn't ours. R22 surgically excluded plain DBText/MText/AttributeDefinition from the queue, but the deeper fix is a drawing-type guard at the top of every reactor handler.

**Fix:** Add `IsCeOwnedDrawing(db)` helper that checks for the presence of CE ProjectData (or a CE-specific named dictionary entry) on the database. Call it as the first thing in `OnObjectModified`, `OnObjectErased`, `OnBeginDeepClone`, `OnCommandWillStart`. If false → return immediately.

**Files:** `Services/LinkService.Reactors.cs`, `Services/LinkService.cs` (add the helper), possibly `Services/CompoundEditModeService.cs` too.

**Why parked:** R22 already stops the user-visible bug; the broader scope change has bigger blast radius and deserves a focused session. Don't risk it during v2.1 ship prep.

**Raised:** 2026-05-27 (Tim's "this was in a non-CVL drawing" finding during R22) | **Priority: Medium — quality-of-life, not blocking**

---


## PL-070: Version 2 — In-plugin feature suggestion box

**What:** Add a "Suggestion Box" panel or dialog to the CE plugin where users can browse a curated wishlist of planned features, upvote/prioritise items, or submit new feature ideas. Different from CDFEEDBACK (which captures bug reports and improvement notes saved locally as JSON). This would be a more structured, product-roadmap-style interface — e.g. a palette or dialog listing feature cards with a status (Planned / In Progress / Released), a vote counter, and a free-text submission field. Submissions could save locally (same JSON-file approach as CDFEEDBACK) or post to a lightweight remote endpoint.

**Fix:** New command `CDSUGGESTIONS` (or embedded as a tab in the CDFEEDBACK dialog). UI: scrollable list of feature cards from a local/remote JSON feed, each with title, description, status badge, and upvote button. Submission form at the bottom. Local storage fallback if no network.

**Files:** New `Dialogs/SuggestionBoxDialog.xaml`, `ViewModels/SuggestionBoxViewModel.cs`, `Commands/FeedbackCommand.cs` (extend or add CDSUGGESTIONS), `Assets/Config/command-registry.json`

**Raised:** 2026-05-11 | **Priority: Low — version 2 enhancement**

---

## PL-069: Double-click pit block opens Block Editor instead of CDEDIT

**What:** Test 178 — double-clicking a CE pit block opens AutoCAD's native Block Editor (`BEDIT`), not `CDEDIT`. The CE double-click reactor for pit blocks is either not registering or not firing correctly.

**Fix:** In the entity double-click reactor (likely in `LinkService.Reactors.cs` or a `WblockCloneReactor` / `XrefReactor`), ensure pit blocks are matched and CDEDIT is invoked. Check `ObjectOverrule` or `EditorInputContextReactor` event subscription for pit block handles.

**Files:** `Services/LinkService.Reactors.cs` (or wherever the double-click override is registered)

**Raised:** 2026-05-10 | **Priority: High — core UX broken**

---

## PL-068: TEXTEDIT double-click on plain AutoCAD text still intercepted by CE
**Status:** ❌ **STILL BROKEN** (Tests 211/212/213 Fail 2026-05-12 evening). The C# `SetImpliedSelection` fix in `CompoundEditModeService` was applied but the command line shows `Command: _textedit / Select an annotation object or [Undo/Mode]: / Command:  (nil nil)` — the `(nil nil)` strongly suggests a **LISP `defun` is intercepting TEXTEDIT/DDEDIT** and returning nil before the C# bypass can act. **Next session must grep all .lsp files for `(defun c:textedit` and `(defun c:ddedit`** (search `Common/`, `TIM_TOOLS_COMBINED.lsp`, any plugin-loaded LISP). Tim very upset — daily-use task killing productivity.

**What:** Test 177 — double-clicking a plain DTEXT/MTEXT entity does not open the native AutoCAD text editor. CE is still intercepting the double-click for all entity types instead of only for CE-registered entities (pits, pipes, sources).

**Fix:** In the double-click reactor, check the entity type before overriding. Only intercept double-click for entities that match CE block names or are on CE-managed layers. All other entity types should fall through to AutoCAD's default behaviour.

**Files:** `Services/LinkService.Reactors.cs` — double-click override selector

**Raised:** 2026-05-10 | **Priority: High — breaks normal AutoCAD text editing**

---

## PL-067: CDFALL / CDSLAB fall arrow text upside-down and "flies off"
**Status:** ✅ FIXED 2026-05-12 — awaiting AutoCAD test (Test 238). Root cause: FALL SYMBOL dynamic block's Flip State flips the arrow geometry but leaves attribute text following block's BCS rotation, so labels render upside-down for arrows in the 90°–270° half. Fix: `BlockService.ComputeReadableFallTextRotation` + `FlipAttributeRotations` apply readable WCS rotation per attribute. Commit `b97b8c3f`.

**What:** Tests 175, 176 — the FALL label text appears upside-down before the grade number is entered, then the grade text "flies off" (appears at wrong position) when inserted. All fall arrow orientations are affected (leftward confirmed, others likely). The fall label text needs the same readable-angle clamp applied to SC/CJ labels (PL-057).

**Also:** T173 notes fall label glitching even when gradient is correct.

**Fix:** In CDFALL block attribute placement and CDSLAB auto-fall symbol placement, apply the angle normalisation: if the arrow direction puts text in the 90°–270° range (upside-down), rotate text by +180°. Mirror the pattern used by pipe MTEXT in the CD command.

**Files:** `Commands/FallCommand.cs` (CDFALL), `Services/SlabService.cs` (auto-fall symbol placement)

**Raised:** 2026-05-10 | **Priority: High — affects all fall annotations**

---

## PL-066: Pit cover text must not show custom remarks (schedule only)
**Status:** ✅ VERIFIED 2026-05-12 — code already correct. `BuildPitCoverText` in both PitCommand.cs and PitEditCommand.cs composes from `TextAbove` / `PP` (plastic) / `CL` / `IL` / `TextBelow` only — `CustomRemarks` is never added. No code change needed.

**What:** Test 171 — user confirmed that custom remarks (e.g. "LOCKING LID") must **not** appear in the pit cover text MText block. Remarks are only for the PITSCHEDULE. The test expectation was wrong — treat this as a design decision change.

**Fix:** Remove the custom remarks line from the cover text MText template in `TextService` (or wherever cover text is composed). Remarks should only appear in `PitScheduleService` output.

**Files:** `Services/TextService.cs` — `CreateCoverText` or `ComposeCoverTextLines` method

**Raised:** 2026-05-10 | **Priority: Medium — output correctness**

---

## PL-065: CDINSPECTOR vs CDDASHBOARD show different pit/entity counts

**What:** Test 169 — CDINSPECTOR Diagnostics shows 0 Pits / 0 Pipes before Refresh, and even after Refresh the numbers may differ from CDDASHBOARD (which showed 10 Pits, 31 Pipes in the same drawing). The two panels use different data sources or different scan logic.

**Fix:** Ensure CDINSPECTOR Diagnostics uses the same scan routine as CDDASHBOARD audit. Ideally both call a shared `ProjectDataService.ScanDrawing()` method so counts are always consistent.

**Files:** `Controls/InspectorPanelControl.xaml.cs` (Diagnostics tab refresh), `Services/DesignCheckService.cs`

**Raised:** 2026-05-10 | **Priority: Medium — data trust issue**

---

## PL-064: CDSLABEDIT — redesign as geometry-edit with reactor (not a dialog)

**What:** Tests 164–167 — CDSLABEDIT crashes with `[CE] Error in CDSLABEDIT` on all code paths. More importantly, user has requested a fundamental redesign: **no dialog**. Instead, `CDSLABEDIT` should leave the slab boundary as a normal editable AutoCAD polyline and use a reactor to automatically regenerate joint lines and fall symbols whenever the polyline vertices are moved (grip-edit, STRETCH, etc.).

**Proposed approach:**
1. `CDSLABEDIT` command selects the slab boundary polyline and activates CE's slab reactor (if not already active)
2. User edits the polyline normally using AutoCAD grips or STRETCH
3. On each geometry change event, the reactor: re-clips SC/CJ joints to the new boundary, re-triangulates falls, updates control point spot levels
4. No dialog required — all data lives in the polyline's XData

**Files:** `Commands/SlabEditCommand.cs`, new `Services/SlabReactorService.cs`

**Raised:** 2026-05-10 | **Priority: High — CDSLABEDIT completely non-functional**

---

## PL-063: CDINSPECTOR Diagnostics — duplicate pit ID silently reduces pit count
**Status:** ✅ VERIFIED 2026-05-12 — code already correct. `DiagnosticsViewModel.RefreshFromCurrentData` lines 94–99 groups pits by ID and raises a `DiagIssue` Error: `"Duplicate pit ID '<id>' — <N> pits share this tag."` Pit count uses `data.Pits.Count` (line 77) which is the full count, not deduplicated. No code change needed.

**What:** Test 162 — when two pit blocks have the same ID/tag, CDINSPECTOR Diagnostics deduplicates them (treats as one entity) and shows a lower pit count. It does NOT raise a duplicate-ID warning in the Issues list. The user cannot detect the conflict from diagnostics.

**Fix:** In the Diagnostics scan, after collecting all pit entity handles, group by ID. Any group with count > 1 should add a `DiagnosticIssue` with severity Error: `"Duplicate pit ID '{id}' — {n} pits share this tag."` Keep all pits in the count (don't deduplicate — show actual entity count).

**Files:** `Controls/InspectorPanelControl.xaml.cs` or `Services/DiagnosticsService.cs` — pit collection loop

**Raised:** 2026-05-10 | **Priority: Medium — silent data integrity failure**

---

## PL-062: CDINSPECTOR Diagnostics Issues section — white background (unreadable)
**Status:** ✅ FIXED 2026-05-12 — awaiting AutoCAD test (Test 240). GroupBox + ListBox + ListBoxItem now bound to `{DynamicResource BackgroundBrush}` / `{DynamicResource TextBrush}` / `{DynamicResource BorderBrush}` so the Issues panel renders correctly on dark theme. Commit `a0d15709`.

**What:** Tests 160, 161 — the Issues list in the Diagnostics tab has a **white background**, making dark text unreadable against the CE dark theme. The `ListBox` or `ItemsControl` used for the issues list has no explicit background override, defaulting to the system white.

**Fix:** In `Controls/InspectorPanelControl.xaml`, set the Issues `ListBox` background to `{StaticResource BackgroundBrush}` (or `Transparent`) and set `ItemContainerStyle` foreground to `{StaticResource TextBrush}`.

**Files:** `Controls/InspectorPanelControl.xaml` — Issues ListBox definition

**Raised:** 2026-05-10 | **Priority: Medium — usability**

---

## PL-061: CDINSPECTOR Raingarden panel shows no data (area or outlet)
**Status:** ✅ VERIFIED 2026-05-12 — code already correct. `InspectorPaletteService.PopulateRaingarden` populates `RaingardenName` / `RaingardenArea` / `RaingardenOutlet` / `RaingardenGioHandle`. `InspectorPanelControl.xaml` lines 401–426 bind all four. If the panel shows blank in AutoCAD, the bug is in CDRG XData being missing — file a separate item with the affected drawing.

**What:** Tests 157, 158 — hovering a CDRG boundary polyline in CDINSPECTOR switches to Raingarden mode and shows the header "RAINGARDEN: RG1" correctly. However, the panel body shows only "Label style: Default" and a Label Styles button — no boundary area (m²) and no outlet pit information.

**Fix:** In the Raingarden inspector panel, read the CDRG XData for area (stored at placement) and outlet pit handle. Display: Area (m²) and Outlet (pit name or "None"). Use the same two-column key/value layout as the pit panel.

**Files:** `Controls/InspectorPanelControl.xaml` (Raingarden section), `Controls/InspectorPanelControl.xaml.cs` — `PopulateRaingardenPanel()`

**Raised:** 2026-05-10 | **Priority: Medium — feature incomplete**

---

## PL-060: CDJOINT SC lines end ~290mm short of slab boundary
**Status:** ⏸ **PENDING retest** (Test 221 — 2026-05-12 evening). Boundary is now reached on simple slabs ✅, but Tim notes the original failure mode was a slab containing a **pit** — needs retest with pit-in-slab to confirm the grid splits correctly around pit exclusion zones AND still reaches the outer boundary.

**What:** Test 143, 144 — generated SC lines terminate approximately 290mm inside the slab boundary (yellow polyline outline) rather than at the boundary itself. The intersection/clip calculation is undershooting — possibly clipping to an offset from the boundary or to the polyline's centreline rather than its edge.

**Fix:** In the SC line clip logic, ensure the intersection is computed against the actual polyline vertex path (not a width-offset version). Check whether the polyline width or any buffer margin is being subtracted from the clip target.

**Files:** `Services/SlabJointService.cs` — SC line generation and boundary clipping step

**Raised:** 2026-05-10 | **Priority: High — joints don't reach slab edge**

---

## PL-059: CDJOINT SC grid origin should be from nearest corner vertex, not centre
**Status:** ⚠️ **PARTIAL — DESIGN DISCUSSION NEEDED** (Test 220 — 2026-05-12 evening). The mechanical fix works ✅ (origin is now at SW corner vertex), BUT Tim has a **fundamentally different design strategy** for joint layout. Side-by-side comparison shows Tim's manual layout (right) vs Claude's algorithmic grid (left) — very different approaches. **Do NOT make further code changes until Tim provides the design rules** (likely involves: joints parallel to slab edges not world axes; spacing-from-pour-strips logic; construction sequence considerations). See PL-056 — same theme.

**What:** Tests 143, 145, 146 — the SC grid is currently placed starting from the geometric centre of the slab bounding box and extending outward at the selected spacing. The correct behaviour is to start the grid from **a specific corner vertex** of the slab (e.g. the vertex closest to the origin, or a user-nominated corner) and extend the pattern from there. This ensures joints align with the slab start point and match construction joint conventions.

**Fix:** In `SlabJointService`, instead of computing grid lines from `(centreX ± n*spacing)`, find the slab boundary vertex with the lowest X+Y value (or lowest X, breaking ties by Y) and use that as `(originX, originY)`. Generate grid lines as `originX + n*spacing` (vertical) and `originY + n*spacing` (horizontal), clipped to the slab boundary.

**Files:** `Services/SlabJointService.cs` — grid origin calculation

**Raised:** 2026-05-10 | **Priority: High — SC grid doesn't start from corner**

---

## PL-057 (UPDATED): SC/CJ joint labels must rotate to align with the line, not always horizontal
**Status:** ✅ **FIXED — confirmed in AutoCAD** (Tests 218 + 219 Pass 2026-05-12). Tim: "this works now yes thank you".

**What:** Tests 146, 150, 153 and general SC/CJ label complaint — "CJ" and "SC" text labels are placed horizontally (upright) regardless of the angle of the joint line. User wants labels to **sit on the line** — i.e. rotate to match the line's angle, using `DBText` (same rotation logic as pipe MTEXT in the CD command). The readable-angle clamp still applies: if the line angle would make text upside-down (angle 90°–270°), flip by 180° so text reads from the right or bottom.

**Files:** `Services/SlabJointService.cs` and `Commands/SlabJointCommand.cs` (CDCJ, CDSC) — label DBText placement after each joint line

**Raised:** 2026-05-10 (updated) | **Priority: Medium**

---

## PL-058: CDSL — spot level block missing "P" prefix on label
**Status:** ✅ FIXED — confirmed in AutoCAD test 187 (duplicate of PL-043, fixed by same change).

**What:** Test 156 — `CDSL` places the spot level block and inserts the RL value correctly, but the label is missing a **"P" prefix**. The RL value should be displayed with a "P" prefix (e.g. `P100.050` rather than `100.050`). This may be an attribute tag issue or a missing prefix in the `SpotLevelService` / `CdSlCommand` that writes the block attribute value.

**Clarification needed:** Confirm exactly what the "P" prefix should look like in the placed block — e.g. is it `P 100.050`, `P100.050`, `RL 100.050`, or a numbered prefix like `P1`?

**Files:** `Commands/CdCommand.cs` (CDSL method), `Services/SpotLevelService.cs` (if exists) — attribute value assignment on block insert

**Raised:** 2026-05-10 | **Priority: Medium — cosmetic but affects output**

---

## PL-057: CDCJ / CDSC — joint label text not always readable (rotation bug)

**What:** Tests 150–153 — "CJ" and "SC" text labels placed at the midpoint of joint lines are not always rotated correctly. Text may appear upside-down or at angles that make it unreadable depending on the direction the line was drawn.

**Expected behaviour:** Labels should always be readable from the bottom or right side of the page — standard AutoCAD text orientation convention. The rotation should be clamped to the 0°–90° readable range: if the line angle is between 90° and 270° (text would be upside-down), flip the rotation by 180° so the text reads from the bottom.

**Fix:** In the label placement code (wherever `TextEntity` or `DBText` is created for CJ/SC labels), apply:
```csharp
double angle = lineAngle;  // 0–2π range
if (angle > Math.PI / 2 && angle <= Math.PI * 1.5)
    angle -= Math.PI;   // flip upside-down text
rotation = angle;
```

**Files:** `Commands/SlabJointCommand.cs` or `Services/SlabJointService.cs` — label placement after each joint line is drawn (applies to both CDCJ and CDSC, and to the auto-labels placed by CDJOINT)

**Raised:** 2026-05-10 | **Priority: Medium — affects readability of all joint labels**

---

## PL-056: CDJOINT — SC joint design approach needs review

**What:** Test 142 — the SC grid generates technically correctly (uniform orthogonal grid at the selected spacing). However Tim noted this isn't how joints would be designed in practice. A design discussion is needed to understand the real-world rules: joints may follow slab geometry (not always orthogonal to world axes), may have different spacings in X vs Y, or may need to account for pour strips and construction sequence.

**Action:** Hold a design review session to define the actual joint layout rules, then revise the CDJOINT algorithm accordingly.

**Files:** `Commands/SlabJointCommand.cs` (or wherever CDJOINT is implemented), `Services/SlabJointService.cs`

**Raised:** 2026-05-10 | **Priority: Medium — functional but design accuracy needed before release**

---

## PL-055: CDJOINT — slab type menu input validation UX
**Status:** ⚠️ **Likely Pass — pending invalid-input retest** (Test 217 — 2026-05-12 evening). Tim: "command works"; needs explicit retest with `9` then `X` then Enter at the slab type prompt to confirm error → re-prompt → Enter accepts default.

**What:** Test 141 — the slab type menu (1–4 / C) appears and works, but the input validation behaviour is "weird". Investigation needed: does entering an invalid character (e.g. 5, X, Enter) show a clear error message? Does it re-prompt or exit? Does the previously-used type asterisk (*) render correctly?

**Files:** `Commands/SlabJointCommand.cs` — the menu prompt loop

**Raised:** 2026-05-10 | **Priority: Low — UX polish**

---

## PL-054: CDSLAB [New] mode crashes at 5th control point
**Status:** ⚠️ DEFENSIVE FIX 2026-05-12 — awaiting AutoCAD test. Without an exception log we couldn't pinpoint the crash. Per-point inner work (TransformToWorld, survey RL lookup, pit cover, FSL prompt) now wrapped in try/catch so the underlying exception is logged with the point number, the user sees `[CE] Error on control point N: <message>`, and the loop continues for re-pick. Converts the silent crash into a recoverable + diagnosable state. Commit `a5c26e4d`.

**What:** Running `CDSLAB` and choosing `[New]` to draw a new boundary polyline, then picking 4 control points and pressing Enter/C — the command crashes with `[CE] Error during CDSLAB — see CE log for details.` at the moment it prompts for the 5th control point. Tested on a drawing with a survey loaded AND without a survey — both crash. CDSLAB with an existing boundary polyline (the normal flow tested in earlier sessions) is unaffected.

**Root cause (suspected):** Bug in the control-point collection loop — possibly an off-by-one index error, a fixed-size collection limit (4 items?), or a failed RL/FSL lookup on the 5th point.

**Fix:** Check the CDSLAB new-boundary mode control point loop. Ensure the collection is dynamic (not capped at 4). Add a try/catch around the FSL lookup for each point to surface the actual exception.

**Files:** `Commands/SlabCommand.cs` (or `Services/SlabService.cs`) — the new-boundary control-point input loop

**Raised:** 2026-05-10 | **Priority: High — blocks normal CDSLAB new-boundary workflow**

---

## PL-053: CD dialog — pipe preview visual improvements

**What:** The pipe preview diagram in the CD dialog is functional but Tim has requested improved visuals and layout. Specific improvements to define in a follow-up design discussion — candidates include:
- Pit icons (filled circles) at each end of the pipe line instead of raw endpoints
- Depth/cover indicators on the vertical axis
- Gradient shading on the pipe body to suggest depth
- Cleaner invert label placement (currently can overlap at narrow widths)
- Upstream / downstream labels (U/S and D/S) at each end
- Rising Main indicator text when in rising main mode

**Files:** `Controls/PipePreviewControl.xaml.cs` (all drawing is in `Redraw()`), `Controls/PipePreviewControl.xaml`

**Raised:** 2026-05-10 | **Priority: Medium — polish before v2.0 release**

---

## PL-052: What's New — show from installer.exe before AutoCAD opens

**What:** User wants to show a What's New / welcome screen to colleagues after running the installer, before AutoCAD even launches. Current implementation shows it inside AutoCAD on first load — not visible to colleagues who haven't opened AutoCAD yet.

**Approach:** Create a small standalone WPF executable (`CE_CVL_SUITE_Welcome.exe`) that the installer launches as its final step. It shows the same What's New content in a self-contained window with a "Launch AutoCAD" or "Close" button. No AutoCAD dependency — pure WPF exe targeting net8.0-windows.

**Files:** New project `CE_CVL_SUITE_Welcome\` (standalone WPF exe). Installer script updated to launch it post-install.

**Raised:** 2026-05-10 | **Priority: Medium — pre-release**

---

## PL-051: What's New popup not showing on first load (silent crash)

**What:** Test 114 — popup does not appear even after deleting `last_version.txt`. No error is shown because `CheckAndShowWhatsNew` wraps everything in `catch { }`.

**Root cause (suspected):** `WhatsNewDialog` uses `{StaticResource BaseWindowStyle}` in its XAML. When shown from the AutoCAD Idle event at startup, the theme resources may not yet be merged correctly. `ThemeService.PreloadThemeResources(this)` is called before `InitializeComponent()` but the Idle-event timing is earlier than any user-triggered command — `Application.Current.Resources` may not be fully populated at that point.

**Fix:**
1. Add a `try/catch` inside `CheckAndShowWhatsNew` that writes the exception to `C:\Temp\CE_CVL_DEBUG.txt` so the actual error is captured (temporary diagnostic).
2. If the issue is theme resources not loaded at Idle time: pre-load theme resources from `PluginInitialization.Initialize()` rather than deferring to dialog open time, so they are always available.
3. Alternatively: defer `CheckAndShowWhatsNew` to the first CD/PIT command invocation rather than the Idle event.

**Files:** `PluginInitialization.cs`, `Dialogs/WhatsNewDialog.xaml.cs`, `Services/ThemeService.cs`

**Raised:** 2026-05-10 | **Priority: High — blocks Test 114/115**

---

## PL-050: CDFEEDBACK / CDCALC — WPF AssemblyLoadContext conflict with ADDINMANAGERMANUAL hot-reload

**What:** Tests 124–126 and 135–139. Both `CDFEEDBACK` and `CDCALC` fail with resource-not-found errors when tested via ADDINMANAGERMANUAL hot-reload on .NET 8. Root cause:
- Bundle DLL (loaded at AutoCAD startup) and bin-output DLL (loaded by ADDINMANAGERMANUAL) share the same assembly name `CE_CVL_SUITE`.
- .NET 8 cannot load two assemblies with the same identity into the Default AssemblyLoadContext — ADDINMANAGERMANUAL's DLL lands in a separate (non-default) ALC.
- WPF's `Application.LoadComponent` resolves assembly names via the Default ALC only → finds the stale bundle DLL. But dialog instances come from the non-default ALC → WPF sees a mismatch → "component does not have a resource" exception.

**Code fixes already applied:**
- `FeedbackDialog.xaml.cs`: `ThemeService.PreloadThemeResources(this)` added before `InitializeComponent()` ✓
- `CalculationsV2Dialog.xaml`: `<BooleanToVisibilityConverter x:Key="BoolToVis"/>` added to `<Window.Resources>` ✓

**Remaining deployment step:** Close AutoCAD → copy `bin\x64\Debug\net8.0-windows\CE_CVL_SUITE.dll` to bundle → restart AutoCAD fresh. After restart both tests should pass — no ADDINMANAGERMANUAL needed.

**Note for future hot-reload sessions:** ADDINMANAGERMANUAL is unreliable for WPF-dialog testing when the bundle DLL and bin output share the same assembly name. Either: (a) always restart AutoCAD after changes that affect WPF dialogs, or (b) temporarily use a different AssemblyName suffix during development.

**Files:** `Dialogs/FeedbackDialog.xaml.cs`, `Dialogs/CalculationsV2Dialog.xaml`

**Raised:** 2026-05-10 | **Priority: High — blocks Tests 124/125/126 and 135/136/137/138/139** | **Code fix done — pending fresh restart**

---

## PL-049: Remove GUIDELINES layer circles from source block placement

**What:** Every source block placed (DP, IO, TG, OF etc.) places a circle on a layer called `GUIDELINES` alongside the source block. This circle no longer serves a purpose — the user confirmed it is not needed and should be removed.

**Fix:**
1. In the source block insert command (`SourceBlockInsertCommands.cs` or equivalent), remove the code that places the circle on the GUIDELINES layer
2. Remove any code in `MoveSourceLabelsAfterExternalCommand` / `ApplyPendingSourceMoves` that attempts to move GUIDELINES circles (this code will become dead)
3. The GUIDELINES layer itself can remain (AutoCAD allows empty layers; no need to purge)

**Note:** Existing drawings will still have old GUIDELINES circles. These are harmless and can be manually deleted or purged by the user. No migration/cleanup code needed.

**Files:** `Commands/SourceBlockInsertCommands.cs` (or wherever source block placement is handled)

**Raised:** 2026-05-10 | **Priority: Low — cleanup only**

---

## PL-048: CDRG auto-complete when user snaps back to first vertex

**What:** When drawing a CDRG polygon, if the user snaps to the first vertex (Endpoint snap at the start point) and clicks, the command should detect the closure and automatically complete the polygon — no need to type `C`. This is standard AutoCAD polyline behaviour and what end users will naturally expect.

**Where to look:** `Commands/SourceBlockInsertCommands.cs` — in the `PlaceRaingarden()` jig loop. After each `PromptStatus.OK` vertex, check if the new point is within tolerance of `vertices[0]`. If it is (and there are ≥ 3 vertices already), treat it as a `Close` — erase temp segments and complete the polyline.

**Files:** `Commands/SourceBlockInsertCommands.cs`

**Raised:** 2026-05-10 | **Priority: Low — UX enhancement**

---

## PL-047: MOVE of pit does not update pit label, cover text, or connected pipe endpoints (regression from PL-037)
**Status:** ✅ FIXED — confirmed in AutoCAD test 179 (Pass 2026-05-11).

**What:** Before PL-037, moving a pit via the `MOVE` command triggered CE reactors mid-command which updated pit label, cover text, and connected pipe endpoints (same as grip-dragging the pit). After PL-037, reactors are suppressed during `MOVE` to prevent callout flicker. The post-MOVE reconciliation (`RebuildRuntimeCaches`) only updates caches — it does not move attached entities.

**Result:** MOVE of a pit only moves the pit block itself. Pit label block, cover text MText, and connected pipe endpoint annotations are left behind at original coordinates. Grip-drag still works correctly (uses reactor path which was not changed).

**Fix:** Apply the same post-MOVE entity reconciliation pattern as PL-038 (source label follow). After `MOVE` ends (`OnCommandEnded`), detect which pit blocks changed position (compare pre/post from `ProjectDataService` position cache). For each moved pit, move its linked label block and cover text by the same delta. Also update connected pipe endpoint inverts and annotations.

**Concrete steps:**
1. Cache pit block positions before the MOVE command in `CacheExistingSourcePositions` (extend to include pits)
2. In `OnCommandEnded`, call `MovePitLabelsAfterExternalCommand(db, state)` — modelled exactly on `MoveSourceLabelsAfterExternalCommand`
3. For pit label: read linked ObjectId from pit block's extension dictionary, apply delta
4. For cover text: read linked MText ObjectId, apply delta
5. For pipe endpoints: trigger the existing pit-move pipe-endpoint update logic (same as grip-drag path)

**Files:** `Services/LinkService.Cache.cs`, `Services/LinkService.State.cs`, `Services/LinkService.SourceMoves.cs` (new method), `Services/LinkService.Reactors.cs`

**Raised:** 2026-05-10 | **Priority: High — regression, breaks core workflow**

---

## PL-003 (REOPENED): SPS invert text offset still not being applied
**Status:** ✅ FIXED 2026-05-12 — awaiting AutoCAD test (Test 237). Root cause: `PitData.Position` is stored in WCS but pipe `points` arrive as UCS from `ed.GetPoint`. The endpoint-to-pit distance search ran in mismatched coordinate systems, so the SPS pit was never matched, so the offset was never applied. Fix: pre-transform pipe points to WCS via `DrawingService.TransformToWorld` before calling `PipeTruthLogic.ComputeSpsInwardOffset`. Three call sites: PipeCreationService, CdCommand, PipeEditCommand. Commit `b97b8c3f`.

**Session:** 2026-05-10 — confirmed still failing. Tested both pipe-to-SPS and SPS-to-pipe orientations — neither applies the offset.

**Previous fix claimed:** Moved `ComputeSpsInwardOffset` to `PipeTruthLogic`, wired into `PipeCreationService` for both `firstSpsOffset` and `secondSpsOffset`.

**Possible reasons still failing:**
1. The SPS pit type detection inside `ComputeSpsInwardOffset` is not identifying the pit correctly (e.g. checking wrong attribute or wrong pit type enum value)
2. The offset value is computed but not passed through to `TextService.CreateInvertText` correctly
3. The `PipeCreationService` changes were not included in the compiled DLL being tested

**Investigation needed:** Add diagnostic logging to `ComputeSpsInwardOffset` — log the pit type detected and the computed offset. If offset = 0, the pit type detection is wrong. If offset > 0 but text is still inside the circle, the offset is being ignored downstream.

**Files:** `Services/PipeTruthLogic.cs`, `Services/PipeCreationService.cs`, `Commands/CdCommand.cs`

**Raised (reopened):** 2026-05-10 | **Priority: High**

---

## PL-017 (REOPENED): Uphill warning still fires for rising mains

**Session:** 2026-05-10 — confirmed still failing. Rising main with ascending inverts still shows uphill popup. Stormwater pipe with ascending inverts correctly shows the "convert to Rising Main? Yes/No" prompt (different, correct behaviour).

**Previous fix:** Changed the guard from `vm.IsRisingMain` to `pipeType != PipeType.RisingMain && pipeType != PipeType.ChargedPipe` using the locally-captured `pipeType` variable.

**Possible reasons still failing:**
1. There are TWO uphill checks — the fix caught one but not the other
2. The uphill popup is fired from a different method than the one that was patched (e.g. a post-placement validation rather than the inline check)
3. The local `pipeType` variable is captured correctly but there is a second code path (e.g. from `PipeCreationService` or from a `LinkService` reactor) that also fires the warning

**Investigation needed:** Search for all locations that show an uphill warning MessageBox or dialog — find the one that is still firing for rising mains. Add `pipeType != PipeType.RisingMain` guard there.

**Files:** `Commands/CdCommand.cs` (search for all MessageBox/uphill checks), `Services/PipeCreationService.cs`

**Raised (reopened):** 2026-05-10 | **Priority: High**

---

## PL-018 (UNRESOLVED): Callout drag — L-shaped leader and west placement still broken
**Status:** ⚠️ **PARTIAL — Q2/Q3 attachment edge case** (Tests 214/215/216 — 2026-05-12 evening). Justify=LEFT now works ✅ across all sides. BUT initial **Attachment** is wrong when text is placed in **quadrants 2 (NW) and 3 (SW)** relative to the arrowhead — manually stretching the leader slightly triggers a recalc that fixes the Attachment. So the recalc-on-modify path is correct but the initial-placement side-detection misclassifies above-and-west / below-and-west placements. **Root cause likely in `IsCalloutTextOnRight` (or equivalent)** — probably uses `text.X > arrowhead.X` instead of the full leader-vector dot product against the pipe normal.

**Session:** 2026-05-10 — both issues confirmed still failing.

**Issue 1 — First segment forced vertical:** The first leg of the L-shaped leader (from the pipe arrowhead to the elbow point) is always vertical regardless of where the cursor is dragged. The user wants the cursor drag position to determine the elbow point freely — the leader should go diagonally from the arrowhead to wherever the cursor is, then bend horizontally to the text.

**Issue 2 — West placement broken entirely:** Can only place callouts on the east (right) side. Attempting to drag to the west side fails — the callout snaps back to east.

**Previous fix attempted:** Changed `AttachmentPoint.MiddleRight` to always use `AttachmentPoint.MiddleLeft` (text justification fix). This didn't address the leader geometry.

**Root cause (Issue 1):** The jig geometry calculation for the leader is hardcoding the first segment as vertical. The elbow point is probably calculated as `(cursor.X, anchor.Y + some_fixed_offset)` rather than using the actual cursor Y position.

**Root cause (Issue 2):** The side-detection logic (whether cursor is east or west of the pipe) is likely using the wrong comparison, OR the west-placement code path was broken by the AttachmentPoint fix.

**What needs to happen:** The leader jig needs to:
- Draw a line from arrowhead anchor → cursor position (that's the leader)
- Add a short horizontal stub from cursor position extending away from the pipe (that's the text landing)
- Place text at the end of the stub, LEFT-justified always
- Work from any direction the cursor is dragged

**Files:** `Services/TextService.cs` (`CreatePipeTextCallout`, `ApplyCalloutLeaderLayout`, the drag jig implementation)

**Raised (carried over):** 2026-05-10 | **Priority: High — core drafting feature**

---

## PL-046: CDDASHBOARD Re-run Audit — grid does not refresh (rows disappear until dialog close/reopen)
**Status:** ✅ FIXED 2026-05-12 — awaiting AutoCAD test (Test 239). Root cause: SectionOptions.Clear()/Add() during Re-run Audit triggered a deferred TwoWay ComboBox null-write that beat the immediate property setters. Fix: schedule the FilterSection/FilterSeverity restore at `DispatcherPriority.Background` so it runs after the binding's transient null write settles. Commit `a0d15709`.

**What:** Clicking ↺ Re-run Audit causes all grid rows to disappear. Rows return correctly when the dialog is closed and reopened. The audit data IS correct — the problem is the grid binding is not refreshing after the re-audit completes on the background thread.

**Different to PL-030:** PL-030 was a permanent loss caused by stale filter values. This is a UI refresh/binding issue — the underlying `ObservableCollection` is not notifying the DataGrid.

**Likely cause:** The re-audit replaces the results collection on a background thread without marshalling the update to the UI thread (Dispatcher). The DataGrid binding loses sync. On dialog close/reopen a fresh ViewModel is created with correct data.

**Fix:** After the re-audit completes, ensure results are pushed to the UI thread:
```csharp
Application.Current.Dispatcher.Invoke(() =>
{
    Results.Clear();
    foreach (var item in newResults) Results.Add(item);
    OnPropertyChanged(nameof(FilteredResults));
});
```
Or: if the collection is replaced wholesale, rebind the DataGrid's `ItemsSource` on the UI thread.

**Files:** `ViewModels/DesignCheckDashboardViewModel.cs`

**Raised:** 2026-05-10 | **Priority: High — regression in core audit workflow**

---

## PL-045: PITSCHEDULE Custom Remarks column — clarify and fix expected output

**What:** Test 89 confirmed the Custom Remarks column in PITSCHEDULE is not displaying as requested. The PL-028 implementation showed `[LidType] - [CustomRemark]` format, but this is not what was wanted.

**Clarification needed:** Does the user want:
- (A) Only the custom remark text in the Remarks column (no lid type)
- (B) Only the lid type in the Remarks column (no custom remark)
- (C) Some other format

**Current behaviour:** Column may be blank, or showing wrong combination. The lid type was never wanted in the cover text (PL-039 fix pending) — it's possible the lid type is also not wanted in the schedule Remarks column.

**Files:** `ViewModels/PitScheduleRow.cs`, `Commands/PitCommand.cs`, `Commands/PitEditCommand.cs`

**Raised:** 2026-05-10 | **Priority: High — needs Tim to clarify expected format before fixing**

---

## PL-044: Remove deep pit visual warning in PITSCHEDULE — only orange step-irons dot needed

**What:** PITSCHEDULE is showing an unwanted visual warning for deep pits (row colour, badge, or other indicator). The only indicator the user wants is the orange step-irons dot (Remarks cell dot for pits with "step iron" in Remarks). No other deep pit warning is needed.

**Where to look:** `Dialogs/PitScheduleDialog.xaml` — check for row style triggers on depth > threshold. `ViewModels/PitScheduleRow.cs` — check for `IsDeep` or similar property used in style bindings. Remove any row-level colour or badge related to depth.

**Note:** The shallow pit chip in the PIT dialog (Test 43) is separate and unaffected — the warning being removed is only in the PITSCHEDULE grid.

**Files:** `Dialogs/PitScheduleDialog.xaml`, `ViewModels/PitScheduleRow.cs`

**Raised:** 2026-05-10 | **Priority: Medium**

---

## PL-043: CDSL spot level block — "P" prefix before level value
**Status:** ✅ FIXED — confirmed in AutoCAD test 187 (Pass).

**What:** The spot level block placed by `CDSL` (and `SL`) shows only the numeric value (e.g. `19.450`). It should show a **"P"** prefix before the level: `P 19.450` or `P19.450` (confirm exact format with Tim — likely "P" for Pavement/Platform Level).

**Where to look:** `Commands/SpotLevelCommand.cs` — the attribute value set when the block is inserted. Look for where the level string is built and prepend "P ".

**Files:** `Commands/SpotLevelCommand.cs`

**Raised:** 2026-05-10 | **Priority: Medium**

---

## PL-042: CDSLAB auto-added pit control points must not place a spot level block at the pit
**Status:** ✅ FIXED — confirmed in AutoCAD test 174 (Pass 2026-05-11).

**What:** When CDSLAB auto-adds a pit's cover level as a control point (the "Auto-add pits as control points?" prompt), it places a spot level block at the pit's insertion point. This is wrong — the pit block already shows its cover level. The spot level block creates a duplicate marker on top of the pit.

**Fix:** In `SlabCommand.cs`, when a control point is sourced from a pit (i.e. added via the auto-pit path, not manually typed), skip the `SpotLevelCommand.PlaceSpotLevel(...)` call for that point. Manual control points still get a spot level block placed normally.

**Files:** `Commands/SlabCommand.cs`

**Raised:** 2026-05-10 | **Priority: High — visible drawing error**

---

## PL-041: CDSLAB fall gradient 1000× too flat — unit mismatch (mm XY vs m FSL)
**Status:** ✅ FIXED — confirmed in AutoCAD test 173 (Pass 2026-05-11).

**What:** CDSLAB displays the fall ratio as 1000× too flat (e.g. `1:12320` when the correct value is `~1:12`). The root cause is a unit mismatch: AutoCAD model space coordinates are in **millimetres**, but FSL values entered by the user are in **metres**. The gradient calculation divides mm horizontal distance by m vertical difference, giving a result 1000× too large as a denominator.

**Fix:** In `SlabService.ComputeFallForTriangle()` (or wherever the grade ratio is computed), convert to consistent units before dividing:
```csharp
// horizontalDist is in mm; rise is in metres
double gradeRatio = horizontalDist / (Math.Abs(rise) * 1000.0);
// Or equivalently:
double gradeRatio = (horizontalDist / 1000.0) / Math.Abs(rise);
```

**Files:** `Services/SlabService.cs` (`ComputeFallForTriangle` or `BuildFallSymbol` in `Commands/SlabCommand.cs`)

**Raised:** 2026-05-10 | **Priority: High — fall ratio is completely wrong**

---

## PL-040: Fall label text upside down when arrow points left or downward
**Status:** ✅ FIXED 2026-05-12 — awaiting AutoCAD test (Test 238). Same fix as PL-067 — `BlockService.ComputeReadableFallTextRotation` clamps WCS rotation to the readable half; `FlipAttributeRotations` applies it. Commit `b97b8c3f`.

**What:** The PL-010 fix correctly flips the fall arrow to point downhill by adding `+ Math.PI` to the rotation. However, when the resulting arrow angle puts the block in the left-pointing or downward half (i.e. rotation between 90° and 270°), the text label ("FALL 1:xxx") rotates with the block and becomes upside down / mirrored.

**Fix:** After computing the final arrow rotation angle (with the +π flip), check if the angle is in the "upside-down" half-circle. If so, add another π to the **text entity only** (not the arrow block) to keep it readable, and adjust the text justification accordingly. AutoCAD convention: if `angle > π/2 && angle ≤ 3π/2`, the text needs a flip to remain readable.

Alternatively, use a block with an **attribute** for the text — attributes in AutoCAD blocks can be set to auto-flip to stay readable via `MTextAttribute.IsMirroredInX/Y` or `AttributeDefinition.Justify`. This is the more robust long-term solution.

**Files:** `Commands/FallCommand.cs`, `Commands/SlabCommand.cs` (`BuildFallSymbol`)

**Raised:** 2026-05-10 | **Priority: High — text unreadable on angled slabs**

---

## PL-015 (REOPENED): TEXTEDIT still broken — CE handler must explicitly invoke `_TEXTEDIT`
**Status:** ❌ **STILL BROKEN — REOPENED AGAIN** (Tests 211/212 Fail 2026-05-12 evening). C# `SetImpliedSelection` fix was applied but did not resolve the symptom. Command line shows `Command: _textedit / Select an annotation object or [Undo/Mode]: / Command:  (nil nil)` — the `(nil nil)` strongly indicates a **LISP `defun` is intercepting the command** and returning nil before C# code runs. **Next session must:** grep all `.lsp` files for `(defun c:textedit`, `(defun c:ddedit`, `(defun c:edit`, and any double-click reactor in LSP. Search `Common/`, `TIM_TOOLS_COMBINED.lsp`, plugin LSP autoload files. Tim very upset — this is a daily-use task.

**Session:** 2026-05-10 — confirmed still failing after the PL-015 fix.

**Why the PL-015 fix is insufficient:** `ed.SetImpliedSelection(ids)` restores the implied selection but this is not enough. The CE double-click handler has already **consumed the double-click event**. After the CE handler returns, AutoCAD does NOT automatically re-invoke the native TEXTEDIT handler — the native handler was bypassed by the CE registration.

**Root cause:** The CE handler is registered for all entity double-clicks (or specifically for DBText, since CE pipe labels use DBText). When it returns without handling, AutoCAD considers the event handled and does nothing further.

**Correct fix (Option B — preferred):** Before calling `ed.SelectImplied()` (which consumes the selection), do a quick `OpenCloseTransaction` peek at the entity type. CE compounds are **always `BlockReference`** objects. Plain `DBText` is not a `BlockReference`. If the entity is not a `BlockReference`, return immediately WITHOUT consuming the implied selection — the native TEXTEDIT handler then runs normally.

```csharp
// Quick type-check BEFORE consuming the implied selection
var peekResult = ed.SelectImplied();
if (peekResult.Status != PromptStatus.OK) return;
var id = peekResult.Value[0].ObjectId;

using var ocTr = db.TransactionManager.StartOpenCloseTransaction();
var ent = ocTr.GetObject(id, OpenMode.ForRead, false, true);
if (ent is not BlockReference)
    return; // Don't consume — native TEXTEDIT will proceed normally

// Now consume for CE compound processing
// ... existing CE compound handling ...
```

**Alternative (Option A — quick patch):** Keep the current approach but explicitly call `doc.SendStringToExecute("_TEXTEDIT\n", true, false, false)` when the entity is a `DBText` or `MText` before returning.

**Files:** `Services/CompoundEditModeService.cs`

**Raised (reopened):** 2026-05-10 | **Priority: High — native AutoCAD text editing broken when CE plugin loaded**

---

## PL-039: Remove unexpected lid type from pit cover text

**What:** PL-028 added both `LidType` and `CustomRemarks` to `BuildPitCoverText` (the MText block placed beside a pit in the drawing). The lid type was not requested for the drawing cover text — only for the PITSCHEDULE Remarks column. The cover text is now showing e.g. `Class C Grated Lid` as an extra line in the drawing, which the user did not ask for.

**Fix:** In `BuildPitCoverText` in both `PitCommand.cs` and `PitEditCommand.cs`, remove the `LidType` from the appended Remarks line. Decide whether `CustomRemarks` should also remain in the cover text or be drawing-only (confirm with Tim).

**Note:** Tests 116–117 ("Pit cover text shows lid type") were written assuming this behaviour — those tests need to be re-evaluated and updated after the fix.

**Files:** `Commands/PitCommand.cs` (`BuildPitCoverText`), `Commands/PitEditCommand.cs` (`BuildPitCoverText`)

**Raised:** 2026-05-10 | **Priority: High — unwanted text appearing in drawing output**

---

## PL-005: PITSCHEDULE — test on real drawing with mixed pit types

**What:** Run PITSCHEDULE on a drawing that contains: at least one SPS pit, at least one terminal pit, at least one intermediate pit, and at least one DP-fed pit. Verify: correct columns, no missing rows, SPS labelled correctly, single-column output (BUG-011 fix).

**What should happen:** Schedule produces a clean single-column table with all pit types listed correctly. No code changes anticipated — this is a verification run only.

**Raised:** 2026-05-07

---

## PL-006-TB: Toolbar and icon redesign — complete rethink before next version update
⚠️ **Status: ✅ Built and visually confirmed (2026-05-09). CE Civil ribbon tab requires CE_SUITE_MANAGER to be loaded — ribbon does not appear via NETLOAD alone. Tests 62–65 need interactive verification with Tim.**

**What:** The current CE toolbar layout and icon set needed a full redesign.

**Where to look:**
- `Assets/Config/ce_toolbar_layout.json` — current ribbon layout
- `Assets/Config/command-registry.json` — command metadata and icon assignments
- `CE_SUITE_MANAGER` — ribbon loading infrastructure

**Raised:** 2026-05-08

---

---

## ~~PL-007: Integrate new libraries into the plugin~~ ✅ PACKAGES ADDED 2026-05-10

**Session:** 2026-05-10 — verified all requested packages are already in the .csproj.

**Status of each library:**
1. ✅ **Serilog** — integrated 2026-05-09
2. ✅ **CommunityToolkit.Mvvm** — package in .csproj; ViewModel migration deferred (PL-007b)
3. ✅ **MathNet.Numerics** — package in .csproj (v5.0.0); use-in-code deferred (PL-007b)
4. ✅ **NetTopologySuite** — package in .csproj (v2.6.0); use-in-code deferred (PL-007b)
5. ✅ **WPF-UI** — in .csproj for net8/net10 (v4.3.0); control integration deferred (PL-007b)
6. **ScottPlot** — not yet added; rebuild CDPROFILE deferred (PL-007c)

**Remaining:**
- PL-007b: Use MathNet.Numerics in CeCalcService (replace hand-rolled Manning's/iterative solvers)
- PL-007b: Use NetTopologySuite in CeRepairService (crossing pipes, overlapping pits)
- PL-007c: Add ScottPlot and rebuild CDPROFILE chart

**Raised:** 2026-05-09 | **Status:** ✅ Package references confirmed; code integration deferred

---

---

## ~~PL-003 (REOPENED): SPS invert text still placed inside SPS circle~~ ✅ FULLY FIXED 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** The private `ComputeSpsInwardOffset` in `CdCommand.cs` was only wired to the interactive invert path (CDADDINVERT). `PipeCreationService` — used by all Quick Mode placements — called `TextService.CreateInvertText` with `spsInwardOffset = 0.0` (default). See completed entry below.

---

## ~~PL-028: Custom Remarks — update drawing Remarks MTEXT block~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** `BuildPitCoverText` in both `PitCommand.cs` and `PitEditCommand.cs` did not include `LidType` or `CustomRemarks` in the MText content — those fields only appeared in the PITSCHEDULE grid, not on the drawing itself.
**Solution:** Added a Remarks line at the end of `BuildPitCoverText` in both files. Format: `{LidType} - {CustomRemarks}` if both are set; just whichever is non-empty if only one is set. The line appears as the last line of the pit cover text MText, visually separated from the engineering data (CL, IL) above it.
**Files:** `Commands/PitCommand.cs` (`BuildPitCoverText`), `Commands/PitEditCommand.cs` (`BuildPitCoverText`)

---

## ~~PL-027: CDRG — snap to previously drawn segments~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Solution:** Modified `PlaceRaingarden()` in `SourceBlockInsertCommands.cs`. After each `PromptStatus.OK` vertex, `CommitTempRgSegment` writes a `Line` to the database immediately so AutoCAD Osnap works on it. On Undo, the last temp segment is erased via `EraseTempRgSegment`. On Cancel, all temp segments are erased via `EraseTempRgSegments`. After the loop exits (Close keyword), all temp segments are erased before the final polyline is created.
**Files:** `Commands/SourceBlockInsertCommands.cs`

---

## ~~PL-037: Suppress CE reactors during AutoCAD MOVE~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** `"MOVE"` was absent from `ExternalMutationCommands` in `LinkService.cs`. As a result, CE reactors (pit-move, source-move, attachment-update) fired on each entity during MOVE, causing potential callout flicker and partial-move reactions. The reactor suspension infrastructure (`SuspendRuntimeLinking`, `ResumeRuntimeLinking`, `OnCommandWillStart`/`OnCommandEnded`) was already in place for COPY, STRETCH, ROTATE, etc.
**Solution:** Added `"MOVE"` and `"-MOVE"` to the `ExternalMutationCommands` HashSet. The existing path in `OnCommandWillStart` suspends reactors for the duration of MOVE; `OnCommandEnded` runs `ReconcileClones` (no-op — no new entity ObjectIds appear during MOVE), then `RebuildRuntimeCaches` to update position caches from actual drawing geometry. Non-CE drawings are completely unaffected — all reactor activity is gated by `DocStates.TryGetValue(db, ...)`.
**Files:** `Services/LinkService.cs` (line ~86 — `ExternalMutationCommands` set)

---

## ~~PL-038: Source tag label (DBText) does not follow source block when moved~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** `ApplyPendingSourceMoves` (the reactor path) moved pipe endpoints, updated hitboxes, and updated pipe grades when a source block (DP/IO/TG/OF/CDTAG) was grip-dragged or grip-stretched — but never moved the source's tag label (a plain left-aligned DBText stored separately from the block, linked by a handle in the block's extension dictionary under `CE_SOURCE_TAG_LABEL`). The MOVE-command path (`MoveSourceLabelsAfterExternalCommand`) didn't exist at all.

**Two affected code paths:**
1. **Reactor path (grip-drag, grip-stretch):** `ApplyPendingSourceMoves` in `LinkService.SourceMoves.cs`
2. **External-command path (AutoCAD MOVE):** `OnCommandEnded` finally block in `LinkService.Reactors.cs`

**Solution (4 parts):**

1. **`LinkService.State.cs`** — Added `SourceLabelPositions` dictionary to `DocState`. Caches the pre-command DBText position keyed by source handle, enabling the double-move guard.

2. **`LinkService.Cache.cs`** — In `CacheExistingSourcePositions`: reads each source label's ObjectId via `SourceTagService.TryGetLabelId`, reads its position via `GetEntityPosition`, caches in `SourceLabelPositions`. In `RebuildRuntimeCaches`: added `state.SourceLabelPositions.Clear()`.

3. **`LinkService.SourceMoves.cs`** — Two new methods:
   - `MoveSourceLabelIfNeeded(db, blockId, sourceHandle, delta, state)`: opens the label, compares current position to `SourceLabelPositions[handle]` (the pre-command cache). If the label already moved (user grip-dragged block+label together), update cache and skip. If it hasn't moved, `labelEnt.TransformBy(Matrix3d.Displacement(delta))` then update cache. Called from `ApplyPendingSourceMoves` before `MoveLinkedPipes`.
   - `MoveSourceLabelsAfterExternalCommand(db, state)`: iterates all tagged source blocks in modelspace, computes block delta vs `SourceBlockPositions`, calls `MoveSourceLabelIfNeeded` for each. Handles the MOVE-command path.

4. **`LinkService.Reactors.cs`** — In the `OnCommandEnded` finally block: added `MoveSourceLabelsAfterExternalCommand(db, state)` BEFORE `RebuildRuntimeCaches(db, state)`. Ordering is critical — the cache must still hold pre-command positions when the delta/double-move comparisons run.

**Double-move prevention:** When the user selects both the source block and its label and uses MOVE (or grip-drags both), the label moves independently. The cache comparison (`currentLabelPos != cachedLabelPos > SegmentEpsilon`) detects this and skips the code-driven move, preventing double displacement.

**TransformBy safety:** Uses `labelEnt.TransformBy(Matrix3d.Displacement(delta))` — correct for all justification modes of DBText, including TextHorizontalMode.TextLeft (the default used by source tags).

**Files:**
- `Services/LinkService.State.cs` — `SourceLabelPositions` dictionary in `DocState`
- `Services/LinkService.Cache.cs` — label caching in `CacheExistingSourcePositions`; clear in `RebuildRuntimeCaches`
- `Services/LinkService.SourceMoves.cs` — `MoveSourceLabelIfNeeded`, `MoveSourceLabelsAfterExternalCommand`, wired into `ApplyPendingSourceMoves`
- `Services/LinkService.Reactors.cs` — `MoveSourceLabelsAfterExternalCommand` call in `OnCommandEnded` finally block

---

## ~~PL-036: PITDELETE → entity-deletion reactor — ProjectDataService cleanup~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** `ProcessPendingErasures` in `LinkService.Utilities.cs` already handled AutoCAD-side cleanup (cascade-erase of label/cover-text attachments via `CascadeErasePitCompound`, Xdata scrub, pipe-link pruning). The remaining gap was that `ProjectDataService.Current.Pits` still held stale entries for erased pits until `SyncWithDrawingCore` ran on the next full sync.
**Solution:** Added `confirmedErasedPits` tracking inside the existing transaction loop (added `confirmedErasedPits.Add(pitHandle)` after the `!erasedPit.IsErased` undo-guard check). After `tr.Commit()`, calls `ProjectDataService.RemovePitByHandle(h)` for each confirmed-erased pit and `ProjectDataService.RemovePipe(h)` for each erased pipe handle. Both methods are safe no-ops if the handle is not found. Undo is handled: pits restored by undo are excluded from `confirmedErasedPits` because the IsErased check fails for them.
**Files:** `Services/LinkService.Utilities.cs` (`ProcessPendingErasures`)

---

## ~~PL-035: CDRG — raingarden gets own data model type~~ ✅ DONE 2026-05-10

**Session:** 2026-05-10
**Solution:** Created `Models/RaingardenData.cs` with boundary handle, GIO block handle, area (m²), outlet pit handle, name ("RG1", "RG2" etc.), position. Added `Raingardens` list to `ProjectData`. Added `AddRaingarden`, `RemoveRaingardenByHandle`, `GetNextRaingardenName` to `ProjectDataService.Mutations.cs`. Updated `PlaceRaingarden()` in `SourceBlockInsertCommands.cs` to compute boundary area via the shoelace formula and register a `RaingardenData` entry instead of `PitData {Id="RG"}`. Added `IsRaingardenMode` display branch to `InspectorViewModel` and `InspectorPanelControl.xaml`. Added raingarden detection to `InspectorPaletteService`.
**Files:** `Models/RaingardenData.cs` (new), `Models/ProjectData.cs`, `Services/ProjectDataService.Mutations.cs`, `Commands/SourceBlockInsertCommands.cs`, `ViewModels/InspectorViewModel.cs`, `Controls/InspectorPanelControl.xaml`, `Services/InspectorPaletteService.cs`

---

## ~~PL-034: CDSURVEY ground levels — persist between sessions~~ ✅ ALREADY IMPLEMENTED

**Session:** 2026-05-09 (continuation) — verified, no code change needed.
**Finding:** `SurveyService.StoreSurvey(result, db)` already writes the full TIN payload (triangles + spot level fallback points) to the drawing's Named Object Dictionary under key `CE_SURVEY_PAYLOAD`. `SurveyService.TryLoadSurveyPayload(db, out payload)` reads it back on demand. Commands that use survey data — `PitCommand`, `SlabCommand`, `SpotLevelCommand` — call `TryLoadSurveyPayload` at runtime. Since NOD data is part of the DWG file, it survives close/reopen; re-running CDSURVEY is not required in a new session on a previously-surveyed drawing.
**No code changes made.**

---

## ~~PL-033: Slab data model — persist CDSLAB output in ProjectDataService~~ ✅ DONE 2026-05-10

**Session:** 2026-05-10
**Solution:**
1. **Data model:** `Models/SlabData.cs` (already existed) — boundary handle, name, surface type, control points (X/Y/FSL), drainage node handles, fall symbol handles, spot level handles, spoon drain handles. `Models/ProjectData.cs` — added `Slabs` list.
2. **Persistence:** `ProjectDataService.cs` — `EnsureDrawingDataCurrent` syncs from NOD via `SlabService.LoadSlabs(db)`. `SlabCommand.cs` — after `StoreSlabs()` immediately updates `ProjectDataService.Current.Slabs`. Dual-layer: NOD is authoritative (survives undo/redo), in-memory index is rebuilt on each drawing sync.
3. **Edit dialog:** New command `CDSLABEDIT` in `SlabCommand.cs` — prompts entity selection (boundary polyline or fall symbol), resolves SlabData, opens `SlabEditDialog`. Dialog has 3 tabs: Geometry (name, surface type, control points grid with editable FSL), Falls (summary, Regenerate button, triangle fall grid with pass/fail per triangle), Drainage (outlet pit proximity check, FSL vs pit IL check). OK regenerates fall symbols in the drawing.
4. **CDDASHBOARD audit:** New "Surface Drainage" section in `LinkService.RepairAudit.Analysis.cs` — 8 checks: boundary deleted, no drainage outlet, outlet not in network, outlet not in pit schedule, lowest FSL below pit invert, no fall symbols placed, < 3 control points, minimum fall not achieved (per surface type via `SlabService.MinimumFallForSurface`), orphaned fall symbols (on 25CONT, not in any slab).
5. **CDINSPECTOR:** Slab/raingarden display modes added to `InspectorDisplayMode`, `InspectorViewModel`, `InspectorPanelControl.xaml`, `InspectorPaletteService`.
**Files:** `Models/ProjectData.cs`, `Services/ProjectDataService.cs`, `Commands/SlabCommand.cs`, `ViewModels/SlabEditViewModel.cs` (new), `Dialogs/SlabEditDialog.xaml` (new), `Dialogs/SlabEditDialog.xaml.cs` (new), `Services/LinkService.RepairAudit.Analysis.cs`, `Models/InspectorDisplayMode.cs`, `ViewModels/InspectorViewModel.cs`, `Controls/InspectorPanelControl.xaml`, `Services/InspectorPaletteService.cs`

---

## ~~PL-033b: CDCALC improvements~~ ✅ DONE 2026-05-10 (tabs enabled + Catchments tab)

**Session:** 2026-05-10
**Solution:**
1. **Enabled 4 disabled tabs**: Removed `IsEnabled="False"` from Pipe Flows, Boyd's Method, Charged System, Pump System tabs in `CalculationsV2Dialog.xaml`. Replaced "Coming soon" placeholder with full UI (inputs + results) for each.
2. **Wired child VMs**: Added `PipeFlows`, `Boyds`, `Charged`, `PumpSystem`, `RationalMethod` properties to `CalculationsV2ViewModel.cs`. Each tab's `DataContext` binds to the matching child VM.
3. **New Catchments tab**: Created `RationalMethodViewModel.cs` with rational method Q = C × I × A / 360, Melbourne IFD pre-loaded (BOM ARR approximation for Melbourne metro — 10 durations × 7 ARI levels from 1yr to 100yr), ARI + duration selectors, manual intensity override, multi-catchment DataGrid (label, area, C-value, Q per row), total Q display.
4. **CalculationBaseViewModel**: Added `HasWarning` and `Warning` (singular) convenience properties so tabs can bind `HasWarning`/`Warning` directly. `ResetWarnings` now raises PropertyChanged for all three.
**Files:** `Dialogs/CalculationsV2Dialog.xaml`, `ViewModels/CalculationsV2ViewModel.cs`, `ViewModels/RationalMethodViewModel.cs` (new), `ViewModels/CalculationBaseViewModel.cs`

**Remaining PL-033b sub-items (deferred):**
- Catchment data persistence: `CatchmentData` model + ProjectData.Catchments (future session)
- CDDASHBOARD hydraulic audit comparing Q vs pipe capacity (future session)
- WSUD / Annual Runoff Reduction tab (future session)

## PL-033b-legacy: Catchment areas — persist rational method inputs in ProjectDataService

**What:** `CDCALC` is a standalone form. Catchment areas, time-of-concentration, runoff coefficients (C-values), and rational method inputs are not stored in the data model — they exist only during the dialog session and are lost on close. There's no way to audit whether the calculations are consistent with the pipe sizes in the drawing.

**Scope:**
1. **Data model:** Add `Catchments` collection to `ProjectData`. Each catchment: source block handles (DP, IO etc.), area (m²), C-value, Tc (min), computed Q (L/s), tributary pit reference.
2. **CDCALC integration:** On Save/Apply, write catchment data to `ProjectDataService`. On dialog open, load existing catchments.
3. **CDDASHBOARD audit:** Add hydraulic compliance check — compare computed Q for each catchment against the capacity of the downstream pipe.
4. **CDINSPECTOR:** Show Q and C-value when hovering over a source block.

**Where to look:**
- New: `Models/CatchmentData.cs`
- `Services/ProjectDataService.cs` — add `Catchments` collection
- `Services/CeCalcService.cs` — add `RegisterCatchment`, `LoadCatchments`
- `Dialogs/CdCalcDialog.xaml` — wire save/load to ProjectDataService
- `Services/DesignValidationService.cs` — add hydraulic audit rules

**Raised:** 2026-05-09 | **Priority: High — v2.1**

---

## ~~PL-032: CDDIAG diagnostics tab inside CDINSPECTOR~~ ✅ DONE 2026-05-10

**Session:** 2026-05-10
**Solution:** Added a "Diagnostics" tab to the CDINSPECTOR palette (`InspectorPanelControl.xaml`). The existing entity-inspection content was wrapped in a "Properties" TabItem; a new "Diagnostics" TabItem sits alongside it and is always accessible regardless of selection state.

**Diagnostics tab features:**
- **Summary strip**: counts of Pits / Pipes / Slabs / Raingardens with colour-coded numbers
- **↺ Refresh button**: re-reads `ProjectDataService.Current` on demand; shows last-refreshed time
- **Issues list**: scrollable list of colour-coded issues (✓ OK, ℹ Info, ⚠ Warning, ✗ Error) — checks: duplicate pit IDs, pits/pipes with no drawing handle, orphaned pipes with no From/To connection, slabs with no boundary handle / no drainage outlet / no fall symbols, raingardens with no boundary handle
- **Copy Debug Report button**: copies sanitised text report to clipboard (counts + issues + pit/pipe table — no geometry or file-path data)

**New files:**
- `ViewModels/DiagnosticsViewModel.cs` — `DiagnosticsViewModel` + `DiagIssue` + `IssueLevel`
- `ViewModels/InspectorViewModel.cs` — added `Diag` property (exposed to XAML binding)
- `Controls/InspectorPanelControl.xaml` — restructured root from `ScrollViewer` to `TabControl` with Properties + Diagnostics tabs

---

## PL-031: Bug and suggestion reporting tool

**What:** When the plugin is distributed to other users, they need an easy way to report bugs and submit suggestions back to Tim. Currently there is no in-plugin feedback path.

**Suggested design:**
- Small command `CDFEEDBACK` (or button in CDHELP dialog) labelled "🐞 Report a bug / 💡 Send suggestion"
- Dialog with: Type (Bug / Suggestion), Title (1 line), Description (multi-line), optional screenshot path
- On Submit: serialise to JSON and either:
  - **Option A (simplest):** Write to `%APPDATA%\CE_CVL_SUITE\feedback\YYYYMMDD_HHmmss.json` and show "Saved to C:\… — email this file to tim@..."
  - **Option B (better UX):** POST to a free webhook endpoint (e.g. `formspree.io`) over HTTPS — fires an email to Tim automatically
- Include auto-collected context: plugin version, AutoCAD version, OS, drawing name (no geometry data)

**Where to look:**
- `Commands/HelpCommand.cs` — CDHELP dialog as a host, or new `FeedbackCommand.cs`
- New: `Dialogs/FeedbackDialog.xaml` + `ViewModels/FeedbackViewModel.cs`
- `Plugin.cs` — version string for auto-context

**Raised:** 2026-05-09 | **Requested by Tim for end-user distribution**

---

## ~~PL-022: CD dialog — full layout redesign~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Solution:** Restructured `CdDialog.xaml` (3-column full layout mode) and `PipePreviewControl`:
- **Col 0:** Now contains only Pipe Basics + Pipe Type (removed the two-row inner Grid; Secondary Controls GroupBox removed from here).
- **Col 2:** Unchanged — Grade (top) + Flow/Inverts (bottom).
- **Col 4:** Now contains Current Status (Row 0) + Secondary Controls expanders (Row 1, moved from Col 0).
- **Outer Grid Row 2 (new):** Full-width 180px Pipe Preview GroupBox — Visibility bound to `UseFullLayoutMode` so it only appears in the 3-column layout, not the wizard. The outer grid gained a new `Height="180"` row between the body row and the footer row.
- **PipePreviewControl:** Removed the fixed `Height="100"` from the Canvas. Added `MinHeight="100"` to the UserControl. Added `SyncCanvasSize()` helper called from both `Loaded` and `SizeChanged` — explicitly sets `PreviewCanvas.Width/Height` to match the UserControl's actual interior area, making the diagram fill whatever space the parent gives (responsive to window resize).
**Files:** `Dialogs/CdDialog.xaml`, `Controls/PipePreviewControl.xaml`, `Controls/PipePreviewControl.xaml.cs`

---

## ~~PL-021: CDS settings dialog — add theme toggle~~ ✅ DONE 2026-05-09

**Solution:** Added APPEARANCE GroupBox to `AdvancedSettingsDialog.xaml` with a Dark/Light ComboBox. `SelectedTheme` setter in `AdvancedSettingsViewModel` calls `ThemeService.SetTheme()` immediately (live preview). Cancel reverts to the original theme. Persisted via `ThemeService` → `SettingsService.SaveSettings()`.

---

## ~~PL-020: v2.0 launch — first-load "What's New" message~~ ✅ DONE 2026-05-10 (upgraded to WPF dialog)

**Original ask:** command-line text banner on first load.
**User feedback (Test 114):** "I WANTED THIS TO BE A WPF POP UP WITH SOME GOOD INFORMATION AND A BUTTON TO TAKE YOU TO THE HOW TO GUIDE"
**Solution:** Replaced the ASCII box banner with a proper WPF `WhatsNewDialog`. Features:
- Styled header (CE icon + version title)
- Bulleted feature list built dynamically in code-behind
- "How To Guide" secondary button → closes dialog then sends `CDHELP\n` to AutoCAD
- "Got It" primary button → closes dialog
- Version still persisted to `%APPDATA%\TIM_CE_CADTOOLS\last_version.txt` so popup only fires once per version (persist-first pattern prevents infinite loop on dialog crash)
**Also fixed (PL-020 root-cause):** CDFEEDBACK XAML URI error — `AssemblyName` changed from `CE_CVL_SUITE_$(BuildTimestamp)` to stable `CE_CVL_SUITE` in the csproj. WPF pack URIs now always resolve against the stable assembly name. `CreateStablePluginAlias` target updated with condition so it skips the now-redundant self-copy.
**Files:** `Dialogs/WhatsNewDialog.xaml`, `Dialogs/WhatsNewDialog.xaml.cs`, `PluginInitialization.cs`, `CE_CVL_SUITE.csproj`
**Raised:** 2026-05-09 | **Resolved:** 2026-05-10

---

## ~~PL-019: CDEDIT — callout position not preserved (only respects manual move)~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** `QueueDeferredAttachmentRegistration` stores only a handle pair — it never calls `WriteCalloutPlacementData`, so the world position was never recorded for auto-placed callouts.
**Solution:** Replaced all `QueueDeferredAttachmentRegistration` calls with `RegisterAttachment` in both `CdCommand.cs` (manual pipe-text path, line ~367) and `PipeCreationService.cs` (auto-place path, line ~112). `RegisterAttachment` calls `UpdateAttachmentFromEntity` which writes the callout's world position immediately, so CDEDIT always has a saved position to restore.
**Files:** `Commands/CdCommand.cs`, `Services/PipeCreationService.cs`

---

## ~~PL-018: Callout drag — vertical line only; west placement justification wrong~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** `CreatePipeTextCallout` and `ApplyCalloutLeaderLayout` used `AttachmentPoint.MiddleRight` for west (left-of-pipe) text placements. This broke the calibration loop for west placements and produced right-justified text.
**Solution:** Replaced the conditional `textIsRight ? MiddleLeft : MiddleRight` with always `AttachmentPoint.MiddleLeft`. The cursor click position is always the LEFT edge of the text box, regardless of which side of the pipe the callout is placed. Right-justification is never appropriate for pipe callout labels.
**Files:** `Services/TextService.cs` (`CreatePipeTextCallout`, `ApplyCalloutLeaderLayout`)

---

## ~~PL-017: Rising Main — "pipe flows uphill" warning fires after placement~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** The uphill warning guard checked `!vm.IsRisingMain` (ViewModel property) rather than the local `pipeType` variable. In batch placements the VM state can lag, causing false positives.
**Solution:** Changed the guard from `vm.IsRisingMain` to `pipeType != PipeType.RisingMain && pipeType != PipeType.ChargedPipe`, using the local `pipeType` captured at line 145 (`pipeType = vm.SelectedPipeType`). This is immutable for the duration of `ExecutePipeDrawing`.
**File:** `Commands/CdCommand.cs`

---

## ~~PL-016: CD dialog — pipe preview shows downhill slope for rising mains~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Solution:** Added `IsRisingMain` DependencyProperty to `PipePreviewControl`. `Redraw()` swaps `y1`/`y2` canvas coordinates when `IsRisingMain` is true (left = low, right = high) vs. gravity (left = high, right = low). Invert label positions adapt accordingly. Both `PipePreviewControl` occurrences in `CdDialog.xaml` are bound to `{Binding IsRisingMain}`.
**Files:** `Controls/PipePreviewControl.xaml.cs`, `Dialogs/CdDialog.xaml`

---

## ~~PL-014: CDSPOON — show committed segments~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** CDSPOON collected vertices into an in-memory list; no geometry existed in the database during the jig loop, so AutoCAD Osnap had nothing to snap to.
**Solution:** Applied the same temp-segment pattern as PL-027 (CDRG). After each `PromptStatus.OK` point, `CommitTempSpoonSegment` writes a `Line` to the database on the `SLAB PERIMETER` layer. On Undo, the last temp segment is erased via `EraseTempSpoonSegment`. On Cancel, all temp segments are erased via `EraseTempSpoonSegments`. After the loop exits (Close keyword), all temp segments are erased before the final polyline is created.
**Files:** `Commands/SpoonCommand.cs`

---

## ~~PL-013 (PARTIAL): SL block loading + CDSLAB spot levels at control points~~ ✅ DONE 2026-05-10

**Session:** 2026-05-10
**Solution (sub-item 1):** Root cause — `C:\Lisp Files\` block search path only exists on Tim's dev machine. Fix: added assembly directory and its `Blocks\` sub-folder to `BlockService.GetBlockFilePath()` search list (inserted before `BLOCKS_PRIMARY_PATH`), so the block is found wherever the DLL is deployed. Also added an explicit pre-flight check in `SpotLevelCommand.Execute()` — if the block definition cannot be loaded, a helpful error message is shown listing the three valid placement locations. Command exits cleanly instead of silently cancelling.
**Sub-item 2 (spot levels at control points):** Deferred to PL-013b — not yet implemented; slab control-point FSL data is now persisted in `ProjectDataService` via PL-033, making this straightforward in a future session.
**Files:** `Services/BlockService.cs` (search path), `Commands/SpotLevelCommand.cs` (pre-flight check)

---

## ~~PL-009: CDSLAB — snap to slab boundary when picking control points~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** After `CollectPolylineVertices` returned, the boundary existed only as an in-memory `List<Point2d>`. The final polyline was not committed to the database until a later transaction, so Osnap had no entity to snap to during control-point picking.
**Solution:** After `CollectPolylineVertices` returns successfully, immediately commit the boundary polyline to the database in a new transaction and set `existingBoundaryId` to its `ObjectId`. `boundaryPts` is then set to `null` so the final geometry transaction skips polyline re-creation. The boundary is now snappable for the entire control-point picking phase.
**Files:** `Commands/SlabCommand.cs`

---

## ~~PL-008: CDSLAB — visual preview of slab boundary while drawing~~ ✅ DONE 2026-05-09

**Session:** 2026-05-09 (continuation)
**Root cause:** `CollectPolylineVertices` collected points in memory; committed segments were not visible during the jig. Although `UseBasePoint` provided a rubber-band line to the cursor, previously drawn segments were invisible.
**Solution:** Applied the same temp-segment pattern as PL-027 (CDRG). Added `CommitTempSlabSegment`, `EraseTempSlabSegment`, `EraseTempSlabSegments` helpers to `SlabCommand`. `CollectPolylineVertices` now accepts a `Document doc` and `string tempLayer` parameter, commits each confirmed segment immediately, erases the last on Undo, and erases all on Cancel. All temp segments are erased before the method returns; the caller creates the real polyline from the returned point list (or uses the early-commit from PL-009).
**Files:** `Commands/SlabCommand.cs`

---

## COMPLETED

### ~~DONE: PL-031 — CDFEEDBACK: bug/suggestion reporting tool~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09 (continuation)
**Solution:** Full implementation. Created `ViewModels/FeedbackViewModel.cs` (type, title, description, auto-context fields, `CanSubmit` binding), `Services/FeedbackService.cs` (writes timestamped JSON to `%APPDATA%\TIM_CE_CADTOOLS\feedback\`), `Dialogs/FeedbackDialog.xaml` + `.xaml.cs` (form with Bug/Suggestion radio buttons, title TextBox, multiline description TextBox, read-only auto-context panel, Submit/Cancel buttons). Updated `FeedbackCommand.cs` to open the dialog and call `FeedbackService.SaveFeedback` on OK, then print the saved path to the command line.
**Files:** `Commands/FeedbackCommand.cs`, `ViewModels/FeedbackViewModel.cs`, `Dialogs/FeedbackDialog.xaml`, `Dialogs/FeedbackDialog.xaml.cs`, `Services/FeedbackService.cs`

---

### ~~DONE: PL-020 — v2.0 launch "What's New" message~~ ✅ DONE 2026-05-10 (upgraded to WPF dialog + XAML URI fix)
**Session:** 2026-05-10
**v1 (2026-05-09):** ASCII box banner in AutoCAD command line — rejected by user (Test 114).
**v2 (2026-05-10):** Replaced with `WhatsNewDialog` WPF popup. Bulleted feature list, "How To Guide" button (sends `CDHELP\n` to AutoCAD after close), "Got It" primary button. Version persisted to disk BEFORE showing so a dialog crash can't cause an infinite loop.
**Also fixed (same session):** CDFEEDBACK XAML URI error — `AssemblyName` changed from `CE_CVL_SUITE_$(BuildTimestamp)` to stable `CE_CVL_SUITE` in the csproj. All WPF pack URIs now resolve correctly when loaded via the stable alias.
**Files:** `Dialogs/WhatsNewDialog.xaml`, `Dialogs/WhatsNewDialog.xaml.cs`, `PluginInitialization.cs`, `CE_CVL_SUITE.csproj`

---

### ~~DONE: PL-030 — CDDASHBOARD Re-run Audit clears all grid rows~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09
**Problem:** Clicking ↺ Re-run Audit caused all grid rows to disappear. Stale `FilterSection` / `FilterSeverity` values from the previous audit were hiding all rows in the new results.
**Solution:** Reset `_filterSection`, `_filterSeverity`, and `_filterText` backing fields directly (bypassing the property setter to avoid premature refresh) before the re-audit fires, then call `OnPropertyChanged` for each so the UI reflects the reset state.
**File:** `ViewModels/DesignCheckDashboardViewModel.cs`
**Tests:** Test 91, Phase 13 Test 79

---

### ~~DONE: PL-029 — Rising Main material conflict (UPVC CHARGED vs UPVC)~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09
**Problem:** CDINSPECTOR showed amber "Material conflict" on rising mains — `GetDefaultMaterial` returned "UPVC CHARGED" for both `ChargedPipe` and `RisingMain`. `InferMaterialFromText` also over-classified rising mains as "UPVC CHARGED" when PVC/UPVC appeared in the annotation text.
**Solution:** In `GetDefaultMaterial`, separated `RisingMain` into its own case returning plain "UPVC". In `InferMaterialFromText`, removed `pipeType == PipeType.RisingMain` from the "UPVC CHARGED" branch — only an explicit `ChargedPipe` type or the word "CHARGED" in the text triggers that material string.
**File:** `Services/PipeTruthLogic.cs`
**Tests:** Test 92, Phase 13 Test 71

---

### ~~DONE: PL-026 — CDDASHBOARD right-click context menu not showing~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09
**Problem:** Right-clicking any row or item in CDDASHBOARD produced no context menu.
**Solution:** Added `<DataGrid.ContextMenu>` to the DataGrid in `DesignCheckDashboardDialog.xaml` with two items: "Navigate to Entity" (bound to `NavigateCommand`, `CommandParameter={Binding SelectedItem}`) and "Export CSV…" (bound to `ExportCsvCommand`).
**File:** `Dialogs/DesignCheckDashboardDialog.xaml`
**Tests:** Test 90, Phase 10 Test 57

---

### ~~DONE: PL-025 — PITSCHEDULE step irons: orange badge in Remarks cell only~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09
**Problem:** Step irons indicator highlighted the entire DataGrid row in orange — clashed with linked (blue) and deep (red) row colours.
**Solution:** Changed REMARKS from `DataGridTextColumn` to a `DataGridTemplateColumn`. A small orange `Ellipse` (8×8px, `Fill="#FF8C00"`) inside a `DockPanel` is visible only when `HasStepIrons` is True (via `DataTrigger`). Added `HasStepIrons` computed property to `PitScheduleRow`; `Remarks` setter raises `OnPropertyChanged(nameof(HasStepIrons))`. Row background is untouched.
**Files:** `Dialogs/PitScheduleDialog.xaml`, `ViewModels/PitScheduleRow.cs`
**Tests:** Test 88, Phase 9 feedback

---

### ~~DONE: PL-024 — PITSCHEDULE "Reset Sort Order" button missing~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09
**Problem:** Reset Sort Order button had been removed from the PITSCHEDULE footer.
**Solution:** Restored the button (`Content="↺ Reset Sort"`) in the footer Grid at `Grid.Column="4"`, shifting the remaining items (PlanSelectionInfo, Export CSV, Place in Schedule, Close) to columns 5–8. Added the corresponding `<ColumnDefinition Width="Auto"/>` to the footer column definitions.
**File:** `Dialogs/PitScheduleDialog.xaml`
**Tests:** Test 87, Phase 9 Test 50

---

### ~~DONE: PL-023 — CD dialog tooltips not showing~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09
**Problem:** Hovering any field label or button in `CdDialog.xaml` produced no tooltip — `ToolTip` attributes were simply absent.
**Solution:** Added `ToolTip="..."` to: Material ComboBox and its label, Pipe Type section header, all six pipe-type RadioButtons (Stormwater, Suspended, Detention, Existing, Charged To, Rising Main), ChargedDestination TextBox, AutoCalcSecondInvert CheckBox, By Flow radio button, By Pick Order radio button, Start Pipe (OkCommand) button, Cancel button.
**File:** `Dialogs/CdDialog.xaml`
**Tests:** Test 86, Phase 7 Test 40

---

### ~~DONE: PL-015 — TEXTEDIT not working with CE CVL SUITE only~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09
**Problem:** Double-clicking a plain DTEXT entity failed silently. `CompoundEditModeService.TryRedirectToCdEdit` called `ed.SelectImplied()` (consuming the implied selection), then returned without restoring it when the clicked entity was not a CE compound — leaving DDEDIT/TEXTEDIT with no entity to edit.
**Solution:** After determining `rootId` is null/invalid (non-CE entity), call `ed.SetImpliedSelection(ids)` to restore the original implied selection before returning, so AutoCAD's native DDEDIT/TEXTEDIT handler proceeds normally.
**File:** `Services/CompoundEditModeService.cs`
**Tests:** Test 85, Phase 4 Test 25

---

### ~~DONE: PL-012 — CDSLAB pit cover level not pre-filled at nearby control point~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09
**Problem:** Pit snap radius was `const double PitSnapM = 1.5` drawing units = 1.5 mm (the drawing is in mm). No pit within 1500 mm was ever found; FSL prompt always showed a blank default.
**Solution:** Renamed constant to `PitSnapMm` and changed value from `1.5` to `1500.0`. Removed the erroneous `* 1000` multiplication from the nearby-pit log message so the displayed distance is in mm (not µm).
**File:** `Commands/SlabCommand.cs`
**Tests:** Test 83, Phase 6 Test 5

---

### ~~DONE: PL-011 — CDSLAB "drains to Pit P1" message missing~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09
**Problem:** "No drainage node within 500mm" warning fired even with a pit inside the slab boundary. The pit proximity search used `dist = Math.Sqrt(dx*dx + dy*dy) * 1000.0` — the `* 1000.0` multiplied already-mm drawing coordinates by 1000, making all measured distances 1000× too large and always exceeding the 500 mm threshold.
**Solution:** Removed `* 1000.0` from the distance formula in `SlabService`. Coordinates in AutoCAD model space (mm-based drawing) are already in mm — no unit conversion needed.
**File:** `Services/SlabService.cs`
**Tests:** Test 82, Phase 6 Test 2

---

### ~~DONE: PL-010 — CDSLAB + CDFALL fall arrow direction (arrows pointed uphill)~~ ✅ DONE 2026-05-09
**Session:** 2026-05-09
**Problem:** Fall arrows pointed uphill in both CDFALL and CDSLAB. The block's default tip is at +X (rotation = 0). `Math.Atan2(dy, dx)` gives the angle from insertion toward the direction-pick point, which is the uphill direction. `SlabService.ComputeFallForTriangle` returns the correct downhill gradient vector — no changes needed there.
**Solution:** Added `+ Math.PI` to the arrow rotation angle in both `FallCommand.cs` (CDFALL) and `SlabCommand.cs` (CDSLAB `BuildFallSymbol`). This flips the tip 180° to point downhill.
**Files:** `Commands/FallCommand.cs`, `Commands/SlabCommand.cs`
**Tests:** Tests 80–81, Phase 6 Tests 8 + 18

---

### DONE: PL-001 — Rising Main annotation update when converting via uphill-pipe dialog
**Session:** 2026-05-09 (overnight)
**Problem:** Clicking "No" on the uphill-pipe warning dialog (convert to Rising Main) left the original gravity grade text intact.
**Solution:** Already implemented in `CdCommand.cs` (No branch, lines ~534-556): erases existing text, calls `TextService.CreatePipeText` with Rising Main format (`"DIA. UPVC RISING MAIN TO {dest}"`), registers the new text as an attachment, flips arrow to pump direction.
**Tests:** Test 70, Test 11

---

### DONE: PL-002 — CDPROPAGATE invert text update handles both MText and DBText
**Session:** 2026-05-09 (overnight)
**Problem:** Original PARKING_LOT entry described a DBText-only cast at line 188 causing silent failure.
**Solution:** Already implemented in `LinkService.RepairAudit.InvertPropagation.cs`: scan path uses `scanEnt is MText scanMt ? scanMt.Contents : scanEnt is DBText scanDt ? scanDt.TextString` and write path mirrors the same pattern. Comment at line 182 confirms: "all inverts are MText; DBText kept for backwards compatibility."
**Tests:** Functional — no interactive test item assigned

---

### ~~DONE: PL-003 — SPS invert text clears the SPS circle (ComputeSpsInwardOffset)~~ ✅ FULLY FIXED 2026-05-09
**Session:** 2026-05-09 (continuation) — REOPENED and resolved
**Problem (final):** `ComputeSpsInwardOffset` existed in `CdCommand.cs` but was only wired to the interactive CDADDINVERT path. Quick Mode placements go through `PipeCreationService.CreatePipeWithAnnotations`, which called `TextService.CreateInvertText` with the default `spsInwardOffset = 0.0`.
**Solution:** Moved `ComputeSpsInwardOffset` to `PipeTruthLogic` as `internal static double`. Removed the private copy from `CdCommand.cs`. In `PipeCreationService`, compute `firstSpsOffset` and `secondSpsOffset` after determining sides, then pass them to both `CreateInvertText` calls. Both `CdCommand` (interactive) and `PipeCreationService` (Quick Mode) now use `PipeTruthLogic.ComputeSpsInwardOffset`.
**Files:** `Services/PipeTruthLogic.cs`, `Services/PipeCreationService.cs`, `Commands/CdCommand.cs`
**Tests:** Tests 73–74

---

### DONE: PL-006 — Rising Main flow arrow direction corrected in CDEDIT/PIPEEDIT
**Session:** 2026-05-09 (overnight)
**Problem:** Editing a pipe's type to/from Rising Main via CDEDIT left the flow arrow pointing in the original direction.
**Solution:** Already implemented in `PipeEditCommand.cs` (lines ~854–856): in the flow-arrow post-save block, detects `pipeType == PipeType.RisingMain` and swaps `rotFirst`/`rotSecond` so the arrow points low→high (pump direction). Only fires if an arrow already exists (`shouldInsertArrow && !context.ArrowAttachmentId.IsNull`).
**Tests:** Tests 16, 20

---

### DONE: SPS retroactive rename when second SPS placed
**Session:** 2026-05-07
**Problem:** Placing a second SPS pit did not rename the first from "SPS" to "SPS1" in the drawing — `FindLabelBlockIdWithAttributeValue` used an exact block name match (`"PIT LABEL"`) and missed `"PIT LABEL 2"` variants.
**Solution:** Added `BlockService.FindPitLabelBlockIdWithAttributeValue` using the `IsPitLabelBlock` predicate. `AssignSpsLabel` in `PitCommand.cs` now calls this method.
**Regression log:** BUG-019

---

### DONE: SPS auto-number in PIT dialog
**Session:** 2026-05-07
**Problem:** Selecting "SPS" pit type in the PIT dialog left the Pit Number field blank — user had to type the label manually.
**Solution:** Added `AutoSetSpsLabel` to `PitViewModel.cs`. Counts existing SPS pits in `ProjectDataService.Current.Pits` and sets `PitNumber` to "SPS" or "SPS{n+1}" automatically when the type is selected in insert mode.
**Regression log:** BUG-020

---

### DONE: PitSync debug messages printing to AutoCAD command line
**Session:** 2026-05-07
**Problem:** `[CD-DEBUG] ProjectData PitSync: ...` lines appeared on the command line whenever a pit was synced.
**Solution:** Changed `LoggingService.Diagnostic` → `LoggingService.DiagnosticSilent` for all PitSync calls in `ProjectDataService.cs`. Silent variant writes to log file only.
**Regression log:** BUG-018

---

### DONE: Grade rounding discrepancy — pipe text showed "1 IN 9", Inspector showed "1 IN 10"
**Session:** 2026-05-07
**Problem:** `BuildGradeValue` used `Math.Floor` (truncate); `InspectorPaletteService` used `:F0` format (round half-away-from-zero). Grade 9.9 → pipe text "1 IN 9", Inspector "1 IN 10".
**Solution:** Changed `Math.Floor(grade)` to `Math.Round(grade, MidpointRounding.AwayFromZero)` in `CdCommand.BuildGradeValue`. Both now agree.
**Regression log:** BUG-017

---

### DONE: Grade radio buttons redesigned — 3 clear modes
**Session:** 2026-05-07
**Problem:** Four radio buttons (Default / Default Standard / From inverts / Custom) were confusing and overlapping in intent.
**Solution:** Reduced to 3 modes:
- **Default** — computes from inverts + applies label filtering (1:50–89 → `1 IN 100 MIN.`, 1:90–110 → `1 IN 100`, outside range → actual grade + popup warning). Falls back to `1 IN 100 MIN.` if only one invert entered.
- **From inverts (override)** — computes raw grade from inverts, no label substitution, no warnings. For explicitly non-standard pipes.
- **Custom** — manual entry unchanged.
Changed in: `CdCommand.BuildGradeValue`, `CdCommand.BuildPipeText`, `CdCommand.ShowGradeWarningIfNeeded`, `CdViewModel.GradePreviewText`, `CdDialog.xaml` tooltips.

---

### DONE: Grade warning popups for steep / flat pipes
**Session:** 2026-05-07
**Problem:** No user feedback when a pipe grade fell outside the acceptable 1:50–1:110 band.
**Solution:** Added `ShowGradeWarningIfNeeded` in `CdCommand.cs`. Fires after pipe placement when Default mode is used and both inverts are present. Shows an informational `MessageBox` for grades steeper than 1:50 or flatter than 1:110. Suppressed for rising main and charged pipes.

---

### DONE: Grade label logic clarified and implemented
**Session:** 2026-05-07
**Rules confirmed:**
- n < 50 → actual grade shown (steep warning popup)
- n 50–89 → `1 IN 100 MIN.`
- n 90–110 → `1 IN 100`
- n > 110 → actual grade shown (flat warning popup)
- 1 invert only → `1 IN 100 MIN.` automatically
**Implemented in:** `CdCommand.FormatGradeForDisplay`, `CdCommand.BuildGradeValue`
**Tests:** `GradeFormatTests` in `CE_CVL_SUITE.Tests/Commands/GradeFormatTests.cs`

---
