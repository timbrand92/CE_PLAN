# R-006. Hatch grips, "Recreate boundary", and grips done properly

**Written:** 18 Nov 2026, Melbourne. **Method:** read-only. Old code read with `git show` and `git grep` only (nothing checked out, nothing built or run). AutoCAD was not started. Registry not read. Autodesk help read online; two Autodesk support pages and one Autodesk blog page refused to load (listed under "Not verified").

## The short answer for Tim

1. **Most likely cause of the hatch trouble:** probably plain AutoCAD, not CE. I am about 85 per cent sure the installed CE plug-ins are not changing hatch grips or "Recreate boundary" (nothing in their code touches a hatch, and every polyline hook is limited to CE pipes and beams). I cannot see your hatch, so this is a judgement, not a proof.
2. **What your screenshot matches:** AutoCAD's own rule that a hatch NOT linked to its boundary ("non-associative") shows grips on its own boundary plus one round centre grip, while a linked ("associative") hatch shows only the round centre grip. Why some edges have no grip I could not explain from the documents.
3. **"Recreate boundary":** Autodesk's help says it makes one new, unlinked closed polyline (or a region) around the hatch. Separate pieces are reported by users when the hatch has islands or was merged from several areas. I found no Autodesk statement for your exact case.
4. **Two-minute check:** read the Associative line on the hatch, then read PICKSTYLE, GRIPS, GRIPMULTIFUNCTIONAL, HPBOUND, and try the same hatch shape in a blank drawing from the office template (full list in A3).
5. **Different grip icons on ordinary objects:** not possible on AutoCAD 2027 as far as we have proven. Our own drawn icons were tried on 4 Sep and AutoCAD painted nothing. What does work on an ordinary object: a grip in a chosen place, a words-on-hover tip, and one grip with a hover menu.
6. **Why the trial crashed:** most likely the custom grip answered "Failure" when clicked (the old shipping code was written to avoid exactly that). Not proven; a safe one-change-at-a-time test is in B2.
7. **The one rule that protects native behaviour:** our code may only run for an object that carries our note, and AutoCAD itself must do that filtering before our code is called.

---

## Part A. Why are native hatch grips and "Recreate boundary" misbehaving?

### What is installed (so I read the right code)

1. **Civil 3.0.90.15** (product version string on the installed DLL, commit 2c8b7b1a, bundle installed 16 Nov 14:18). Also in its bundle and loaded at AutoCAD start: a 2027 grip file (`CE_CVL_NATIVE_GRIP_2027.arx`) and a 2027 pipe-object file (`CE_CVL_OBJECTS_2027.dbx`), both listed in its `PackageContents.xml` (lines 194 to 204).
2. **Structural 1.0.126.1** (commit d4edbc19, DLL dated 14 Nov 01:35).
3. **Manager 1.1.89** (commit cf059dcf, DLL dated 2 Nov).
4. **Two small trial bundles** are also in the plug-ins folder: `CE.Transform.Trial.2027` (loads only when you type CETESTCR or CETESTMR) and `CE.AutoCADLink.2027` (loads at start, a synthetic read-only test adapter, 23 KB). I searched the compiled AutoCADLink files for the words Overrule, ObjectModified, CommandEnded, PointMonitor, ImpliedSelectionChanged and SetSystemVariable: no hits. Its source is not in the repository, so that is a text check only.
5. **A stray file:** `CE_TRANSFORM_2027.arx` sits in the Civil bundle folder but is not listed in `PackageContents.xml`, so AutoCAD does not load it.
6. I searched these three exact commits, not `rel-20261114a` (older, dated 5 Nov, so less accurate than the installed commits). For Structural I used its installed commit (above) rather than guessing the newest `rel-` branch.
7. **"The latest update" candidates:** Civil went in on 13, 14 and 16 Nov; Structural on 14 Nov; Manager on 2 Nov. The 16 Nov Civil change touched only the pipe object and explode handling (files `CeCvlPipeObject.cpp`, `LinkService.Compound.cs`, `ExplodeKeepsPipeAnnotationPolicy.cs`; nothing about hatch, grips or selection). An AutoCAD 2027 update cannot be ruled in or out from here.

### A1. Is an old CE plug-in interfering? (how sure: I think not, about 85 per cent)

**Every overrule, with the class it sits on and its filter** (all at the installed commits; line numbers are in that commit):

1. **Civil, pipe drawing:** `PipeDrawableOverrule` and `PipeOsnapOverrule`, both on Polyline, both with an XData filter for the CE pipe marker (`Modules/Drainage/Services/PipeOverruleService.cs` lines 55 and 77; 436 and 457). AutoCAD itself rejects every other polyline before our code runs. Draws the pipe walls only; no grips.
2. **Civil, pipe grip guard:** `PipePlanGripOverrule`, on Polyline, XData filter (`PipePlanGripOverrule.cs` lines 43 and 64). Its only job is to flatten a grip drag to the plan and refuse a collapse to under 1 mm. Lines 94 to 99 hand every non-pipe straight back to AutoCAD. It adds and removes no grips (its own comment, lines 26 to 29).
3. **Civil, pit cover-text flip grip:** `PitCoverTextFlipGripOverrule`, on MText with a custom filter (`PitCoverTextFlipGripOverrule.cs` lines 36 and 45). Not polylines, not hatches.
4. **Civil, pipe label action grips (managed route):** `PipeAttachmentActionGripOverrule` on MText and BlockReference with NO filter (`PipeAttachmentActionGripOverrule.cs` lines 130 to 134, 156 and 171). It is registered on your PC now because your `grip-route.txt` says "managed" (`GripRouteService.cs` lines 65 to 70). It exits at once for any text or block that is not a recorded pipe label or arrow. Today's CE log (18 Nov) shows it was asked only about BlockReference (2 times) and MText (10 times), never Polyline or Hatch.
5. **Civil, native grip file (C++):** `NativeGripProbe.cpp` line 942 (the class), 1143 (MText) and 1153 (BlockReference). Same two classes only. Custom drawn icons are switched off in it (line 46).
6. **Civil, off:** `CompoundGripOverrule` (Mline), `CompoundTransformOverrule` (every Entity, line 47), `CompoundBoundsOverrule` (blocks). All three sit under `if (false)` in `PluginInitialization.cs` lines 145 to 152, so they are never registered. `SlabCompoundMoveAutoCadAdapter` (every Entity, line 86) is held by `StartupEnabled = false` at line 74.
7. **Structural, footings:** `FootingGripOverrule` on Line and Polyline (`FootingGripOverrule.cs` lines 53 and 54) with an extension-dictionary filter (line 181), switched off by default in Settings, and it adds grips only after asking AutoCAD for its own first (line 192).
8. **Structural, beams and columns:** `StructuralBeamGripOverrule` on Line and Polyline with an extension-dictionary filter (`StructuralFrameGripOverrule.cs` lines 67, 68 and 367); `StructuralSupportGripOverrule` on BlockReference with a custom filter (lines 66 and 256). Both call AutoCAD's grips first (lines 325 and 378) and add three or one extra grip only on a beam or column with a CE record.
9. **Nothing anywhere is registered on Hatch.** No GeometryOverrule, SubentityOverrule, HighlightOverrule, PropertiesOverrule or ObjectOverrule exists in the shipping Civil, Structural or Manager code. (ObjectOverrule is used only in the trial code, not in the installed plug-ins.)
10. **Protocol extension:** `PipeAttachmentGripMenuPE` is attached to MText only (`PipeAttachmentGripMenuPE.cs` lines 38 to 40 in the attach routine), and returns "not mine" for every other MText grip.

**Drawing-wide listeners that see hatch and polyline work (they look, they do not change geometry):**

11. **Civil, `LinkService`:** listens to every object added, changed or erased (`LinkService.cs` lines 1601 to 1603). The handlers (`LinkService.Reactors.cs` lines 19 to 76 and 78 on) only note handles in memory; the file says no transaction is opened there. A drawing with no CE content is skipped (lines 39 to 48 and 95 to 100).
12. **Civil, selection reader:** `CivilSelectionObserver` reads your selection after every click (`CivilSelectionObserver.cs` lines 82, 99 to 126, 172). It writes the selection back only when a CE twin-pipe redirect changed it (lines 196 to 200). Skipped in a drawing with no Civil content (lines 113 to 120). This is the one hook that touches every click on every object, so it is the first thing I would look at if the two-minute checks point at CE. Its own file records two earlier crashes from rewriting the pick-first set.
13. **Civil, `CompoundEditModeService`:** notes the time of every double-click (line 195 to 200) and reacts only when the command that starts is PEDIT, PROPERTIES, BEDIT, EATTEDIT or a text editor (`DoubleClickEditTable.cs` lines 96 to 99, 89 to 111). HATCHEDIT is not in the list. It also sets BLOCKEDITLOCK for one BEDIT and restores it (lines 146 to 176).
14. **Civil, `UcsGuardService`:** switches UCS to World and back, but only for CE commands (`UcsGuardService.cs` lines 340 to 343, 401, 470).
15. **Structural, `BeamLinkService`:** listens to every modified or erased object (`BeamLinkService.Reactors.cs` lines 139 to 140). Every modified Line or Polyline is queued (lines 232 to 240) and, at the end of the command, opened for READ in a transaction; a plain polyline has no CE record so the code commits and moves on (`BeamLinkService.AttachmentUpdates.cs` lines 296 to 308). It writes only when a CE record exists. This runs on every plain polyline in a Structural drawing, including any polyline made by "Recreate boundary". It does not join, split or alter it.
16. **Structural, other listeners:** `FoundationMonitor` (`FoundationMonitor.cs` lines 94 to 99), `DrawingAutoSaveService` (lines 477 to 482), `ReoBarMonitor` (line 65), `RedoWindowGuard`, `BeamHoverService` (point monitor, line 70). I read their entry points only, not every line.

**System variables and hatch commands:**

17. **PICKSTYLE:** Structural sets the "group" bit of PICKSTYLE at start-up if it is off, and puts the old value back at shutdown (`GroupSelectionService.cs` lines 20 to 44 and 46 to 65; called from `Plugin.cs` lines 186 and 314). It sets only bit 1 and leaves bit 2 (the "select an associative hatch's boundary with it" bit) as it was. PICKSTYLE is the variable that decides whether clicking an associative hatch also selects its boundary objects. This is the nearest thing to a hatch-selection change in CE, so read it (A3 step 3).
18. **Hatch creation variables:** CE's Structural hatch commands (EH, CH, WH, PH, 21H and so on) set HPASSOC, HPLAYER, HPGAPTOL and others, and restore them in a `finally` block (`HatchCommands.cs` lines 1898 to 1923 and 575 to 581). CLEAN sets HPNAME, HPLAYER and HPCOLOR for new hatches only (`CleanPipelineService.cs` lines 593 to 597) and says it leaves existing hatches alone (line 584). No code anywhere sets HPBOUND, HPBOUNDRETAIN, GRIPS, GRIPOBJLIMIT, GRIPMULTIFUNCTIONAL, PEDITACCEPT, PLINETYPE or HPGAPTOL outside those hatch commands.
19. **A CE command that runs Recreate boundary itself:** Structural H2A ("convert hatches to associative") runs AutoCAD's own HATCHGENERATEBOUNDARY on each selected hatch, erases the hatch, and re-hatches against the new boundary (`HatchCommands.cs` lines 606 to 735, call at 652). If you ran H2A, the hatch is a new one. The code expects the native command may return several objects (it collects a list, line 649 to 656). Not a hook, a command you choose.
20. **No command hook for hatch commands:** I found no handler that reacts to HATCH, HATCHEDIT, -HATCHEDIT, HATCHGENERATEBOUNDARY or BOUNDARY, and none that joins, explodes or PEDITs polylines at the end of a command in Civil, Structural, Manager or Shared. The only PEDIT and JOIN mentions are the command-name lists in `ExternalMutationCommandPolicy.cs` lines 25 to 31 and 56 to 71 and `NativeEditPlan.cs` line 510, which decide how CE re-links a pipe after you used them.
21. **Command names:** the only Structural command names that collide with AutoCAD shortcut keys are CH, EH, PH and WH (`HatchCommands.cs` lines 211 to 257). CH is also AutoCAD's own short key for Properties. None is HATCH, H, BO or HE.

**Earlier reports in the records:**

22. `C:\CE_PLAN\BUG_CARPARK.md` has no report about hatch grips or recreated boundaries. The nearest is BUG-194 (line 6348): a plain closed polyline on layer HATCHOUTLINE brought up CE's Pipe ribbon tab on 29 Sep. That is a ribbon decision, not a grip change, but it shows plain polylines have been misread as CE objects before. The repository's `REGRESSION_LOG.md` (at the installed commit) has no entry about hatch grips or Recreate boundary.
23. **Today's CE log (18 Nov):** no line mentioning hatch, polyline grips or PICKSTYLE. Only the label and block grip lines in item 4.

**Plain verdict for A1:** I found nothing in the installed CE code that touches a hatch or alters a plain polyline. The two things I could not close: (a) the compiled files could differ from the source at the same commit (I matched them by product-version string only); (b) other add-ins on your PC, and CE's selection reader (item 12), were not cleared by testing.

### A2. Could it be plain AutoCAD?

All claims below come from pages I fetched (page title and site named). The pages I could reach were the AutoCAD LT 2027 help, an AutoCAD LT Mac 2019 help page and the AutoCAD help set; the full AutoCAD 2027 page for the same topic did not come up in search. Treat "LT 2027" as the same hatch engine, which is likely but not stated.

1. **Associative or not decides which grips show.** AutoCAD LT 2027 help, page "Common Options (Hatch and Gradient Dialog Box)": an associative hatch shows "a single, circular grip called the control grip" and no boundary grips, because its boundary can only be changed by editing the boundary objects it is linked to. A non-associative hatch shows the control grip and the boundary grips, and you edit the hatch's own boundary directly.
2. **Grip menu.** AutoCAD LT Mac 2019 help, page "To Reshape a Hatch or Fill": hovering over a boundary grip on a non-associative hatch gives a menu that depends on the grip type, for example a straight segment can be converted to an arc or given a new vertex. Polyline and spline boundaries of an associative hatch show multi-functional grips on those boundary objects. An associative hatch whose boundary opens loses its association and stays as it was.
3. **Grip settings.** AutoCAD 2026 help, page "Just Grip It!": hovering over a grip shows a menu on multifunctional grips; not all grips have menus; GRIPOBJLIMIT hides grips when a selection has more objects than the limit (default 100). AutoCAD help, page "GRIPMULTIFUNCTIONAL (System Variable)": 0 off, 1 Ctrl-cycling, 2 hover menu, 3 both (default 3).
4. **What Recreate boundary makes.** AutoCAD Mac 2018 help, page "To Re-create the Boundary Object for a Hatch Object": you choose polyline or region and whether to associate it with the hatch. AutoCAD LT Mac 2015 help, page "HATCHGENERATEBOUNDARY (Command)": it "creates a new non-associative polyline boundary around the selected hatch". The right-click Generate Boundary route cannot make an associative boundary.
5. **What controls polyline against region.** AutoCAD LT 2022 help, page "HPBOUND (System Variable)": 1 makes a polyline, 0 makes a region, the value is not saved with the drawing (it starts at 1 each session), and a polyline or region is created only when HPBOUNDRETAIN is on.
6. **Why several polylines.** Community posts only (Autodesk Community and CADTutor forums, not staff): a merged hatch or a hatch with islands gives a separate outline round each piece; a boundary with a self-crossing or loop is reported as a problem. No Autodesk page I could read says that a single closed outer loop made of lines and arcs should come back as separate polylines, or that it should always come back joined.
7. **Known defect or change in 2026 or 2027.** I found none about hatch grips or recreated boundaries. The nearest are an Autodesk forum thread on the BOUNDARY command misbehaving in AutoCAD 2025 (ObjectARX forum, opened by a developer; I read only the title) and community reports that block text is now picked up as a boundary in 2025. Treat "no known defect" as "I did not find one", not as "none exists".
8. **Autodesk support article, title only:** "Generation of hatch boundary creates lines instead of closed polylines in AutoCAD products". Its title matches your second symptom closely. The page refused to load for me, so I cannot tell you its cause or fix. Worth opening in your own browser.
9. **My reading of your screenshot (judgement, not fact):** square grips at some vertices plus a round centre grip fits a non-associative hatch. If it is non-associative, "Recreate boundary" is exactly what you would reach for, which suggests the hatch lost its link at some point (a boundary opened, a boundary erased, or the hatch was made by picking a point with association off). Why some edges lack a grip I cannot say; one possibility is that a curved or spline edge is built from fewer grip points than the straight ones, but that is a guess.

### A3. Two-minute checks for Tim (all read-only; nothing changes a saved setting)

To read a variable, type its name and press Enter. AutoCAD shows the current value in brackets; press Enter again WITHOUT typing anything to keep it.

1. **Look first, no typing:** click the hatch. Does it show just one round grip, or square grips round the edge too? Note which edges have no grip. Open the Properties palette (it only reads) and note "Associative": Yes or No.
2. **Same check by command:** type LIST, pick the hatch, press Enter. Read the Associative line and the number of loops. Press Esc to close the text window.
3. **Read these values and write them down:** PICKSTYLE, GRIPS, GRIPMULTIFUNCTIONAL, GRIPOBJLIMIT, HPBOUND, HPBOUNDRETAIN, HPGAPTOL. (HPBOUND resets to 1 each session, so it is only meaningful today.) If PICKSTYLE reads 1 or 3 that is normal when Structural is loaded.
4. **Blank drawing test:** File, New, pick the office template (the template is read, not changed). Draw a rectangle with one curved side, hatch it by picking its inside, click it, then do the same with a hatch made by selecting the boundary object. Compare the grips with your screenshot. Close without saving.
5. **New against old:** is it only hatches drawn before the 14 to 16 Nov installs, or does a hatch you draw today do the same? A hatch made today in a blank drawing that looks like your screenshot points to plain AutoCAD behaviour.
6. **What is under the hatch:** after you recreate the boundary, click the new outline. One highlighted outline means one polyline; several separate pieces means several objects. Type LIST on one piece: it says LWPOLYLINE, LINE or ARC. Then undo with U.
7. **The cleanest separator:** do step 4 on a colleague's PC that has AutoCAD 2027 and no CE plug-ins (or on yours if you have a second install without them). The same result there rules CE out. Do not unload plug-ins or change SECURELOAD.
8. **Two more reads I can do for you without touching AutoCAD:** read today's CE logs after you try the hatch, and read the Autodesk support article once you can open it.

---

## Part B. For the new plug-in: grips done properly

**Evidence used:** the zero-plan trial notes (`C:\CE_PLAN\zero\stage4\TRIAL_RESULTS.md`, Trial 2 lines 206 to 216 and Trial 8 lines 218 to 227), the trial code (`C:\CE_WORK\trials\zero\core\MouseTrials.cs`), the old plug-in's own grip code and its research note `docs/research/GRIP_GLYPHS_RESEARCH_2026-09-04.md`, `C:\CE_PLAN\zero\design\SITUATIONS.md` (G12, line 763), `C:\CE_PLAN\zero\stage6\PERFORMANCE.md` (section 2 item 6, section 4 item 3), the AutoCAD 2027 .NET wrappers in `C:\Tools\AcadDecomp\2027\acdbmgd` and `accoremgd`, and the ObjectARX help in `C:\Tools\ArxDocs`.

### B1. Can an ordinary polyline or block show different grip icons?

1. **Can we add grips to an ordinary object without making a custom object?** Yes. A grip overrule on the Polyline or BlockReference class adds our grips beside AutoCAD's own. This is proven on 2027: the old Civil label grips and the Structural beam, column and footing grips all do it today, and Trial 2 in the zero plan logged "built-in + custom, now 4 grips" on an ordinary polyline.
2. **What we can control per grip (proven or in the API):** its position; a words tip when the cursor rests on it (`GetTooltip`); whether a click starts an action instead of a drag (a "trigger grip"); and one grip that opens a hover menu of choices through AutoCAD's own multifunctional-grip menu (the `MultiModesGripPE` protocol extension). The hover menu was proven on AutoCAD 2027 on MText by you on 4 Sep 2026 ("Slide / Offset / Flip", T5 in the research note). GRIPMULTIFUNCTIONAL must be 2 or 3 for the hover menu to show; a drafter who set it to 0 or 1 gets no menu.
3. **Distinct drawn icons (a different shape or colour): not available on 2027 as far as we have proven.** Four ways were tried on 4 Sep and AutoCAD called our drawing code and then painted nothing, not even the normal square: managed `ViewportDraw` with an open outline, managed `ViewportDraw` with a filled circle (two settings of `ForcedPickOn`), managed `WorldDraw` with a filled circle, and the native `setViewportDraw` (note lines 14 to 28 and the results table in the research note). Autodesk's own 2022 class handout says drawn icons work through AutoCAD 2023; whether 2027 changed that is unknown. Cause 4 in the note ("2027 does not paint custom grip glyphs") stands but is not confirmed by Autodesk. So: do not promise a distinct icon. The nearest safe substitutes are a different position (for example set in from the pipe end), the hover tip, and the hover menu.
4. **What a user without the plug-in sees:** the plain native grips and nothing else. Our grips come from code that is not in the drawing. The note on the object (extension dictionary or XData) is inert data.
5. **Versions:** the grip overrule and `GripData` exist in the managed API from AutoCAD 2013 on, so 2022 to 2027 all get the extra grip; the hover menu needs the multifunctional-grip feature (2015 on, my reading of the help, not tested on 2022 to 2026 by us). The old plug-in comment says a managed drawing callback paints nothing on 2027 and the native C++ route fared the same, so no version differences were found there.
6. **Dynamic blocks:** the office's dynamic blocks already have AutoCAD's own triangle and arrow grips, drawn by AutoCAD for the block's own parameters. That is the only route to genuine triangle and arrow icons (note's last section) and costs new block definitions; it is not a grip overrule at all.

### B2. Doing it without disturbing native objects

**Exact filtering (rules for the build):**

1. **Register on the narrowest class** the object really is: Polyline for pipes, BlockReference for pits. Never Entity, Curve or Hatch. Never register a GeometryOverrule, SubentityOverrule, OsnapOverrule or HighlightOverrule on a class-wide basis: hatch boundary picking and "Recreate boundary" read geometry through those routes (my reading, not tested), and they have no per-object filter that costs nothing.
2. **Let AutoCAD filter before our code runs.** Two native filters exist and the old code uses both and says so in its comments: `SetExtensionDictionaryEntryFilter(name)` (Structural, `FootingGripOverrule.cs` line 181) and `SetXDataFilter(appName)` (Civil, `PipePlanGripOverrule.cs` line 43). The zero plan stores each join as a soft pointer in the object's own extension dictionary (Trial 1), so the extension-dictionary filter with our dictionary name is the natural fit: a plain polyline or a hatch boundary never reaches our code. `SetIdFilter` exists in the API (`Overrule.cs` lines 75 to 83 in the decompiled wrapper) but a list of ids does not survive copy and paste, so do not use it.
3. **Avoid `SetNoFilter` and `SetCustomFilter` with a managed `IsApplicable`** on Polyline. Both make AutoCAD call managed code for every polyline on every selection. The old Civil label overrule uses `SetNoFilter` on MText and BlockReference with a cache lookup (comment at `PipeAttachmentActionGripOverrule.cs` lines 152 to 156); that is acceptable for labels, not for polylines, which a hatch workflow touches constantly.
4. **Keep every native grip, add ours.** First line of `GetGripPoints` is `base.GetGripPoints(...)`, then add (every old overrule does: `FootingGripOverrule.cs` line 192, `StructuralFrameGripOverrule.cs` lines 325 and 378). If the bit flag `GripPointsOnly` is set, return after the base call (old code line 196 and 329): that call asks for plain points, and our `GripData` objects must not be added to it. Do not override `GetStretchPoints` or `MoveStretchPointsAt`, so STRETCH, MOVE and the native drag stay exactly as AutoCAD does them.
5. **Do not replace a native protocol extension.** The `MultiModesGripPE` hover menu is attached with `AddX` on a class. The ObjectARX help for `addX` says it files our object under the class key and returns "whatever protocol extension object is already present". I read that as: it replaces what was there for that class. The old code attached it to MText, which has no native multifunctional grips (its own comment says AutoCAD has none on text). A Polyline DOES have native vertex menus (Stretch, Add Vertex, Remove Vertex, Convert to Arc), so attaching ours to Polyline could remove them for every polyline in the drawing. UNVERIFIED, high risk: do not attach a hover-menu extension to Polyline until a test shows the native menu survives. The safe version of "open the window" is a plain trigger grip (no menu).

**What each `GripData` method must return (from the 2027 enum `Ok, Failure, NoRedrawGrip, GripHotToWarm, GetNewGripPoints` and the ObjectARX help, where `eFailure` means "an error has occurred and the grip operation has failed"):**

6. **`OnHotGrip` (the click):** return `GripHotToWarm`. The old Civil code says why in its comment (`PipeAttachmentActionGripOverrule.cs` lines 549 to 551): "Return the documented warm state instead of leaving AutoCAD in an unspecified failure state." Do the real work later, not in the click: queue a request and start the command at Idle (the old Structural grips do exactly this: `FootingGripOverrule.cs` lines 156 to 169, with a try and catch that can never throw).
7. **Settings on the grip, as the old working code sets them:** `TriggerGrip = true`, `ForcedPickOn = true`, `HotGripInvokesRightClick = false`, `GizmosEnabled = false`, `ModeKeywordsDisabled = true`, `RubberBandLineDisabled = true`, `DrawAtDragImageGripPoint = false`, `IsPerViewport = false` (`PipeAttachmentActionGripOverrule.cs` lines 525 to 534).
8. **`OnHover`, `OnRightClick`, `WorldDraw`, `ViewportDraw`:** do not override them at first. The base class returns `Failure` from `OnHover` by default (decompiled `GripData.cs` lines 486 to 489), so leave it unoverridden and AutoCAD does not call it.
9. **`GetTooltip`:** plain words, short; return null if unsure.
10. **`OnGripStatusChanged` on the overrule:** release anything we kept when the status is `GripsDone` (old code `FootingGripOverrule.cs` lines 298 to 303).

**Known ways this goes wrong (with the evidence we already hold):**

11. **Returning `Failure` from the click:** the likeliest cause of the 17 Nov crash (below).
12. **Letting AutoCAD's grip outlive our object:** AutoCAD holds our `GripData` after `GetGripPoints` returns. If our code keeps no strong reference, the managed object can vanish before AutoCAD draws or clicks it. Civil hit this on 2027 ("could disappear before AutoCAD painted or clicked them", `PipeAttachmentActionGripOverrule.cs` lines 368 to 371; Structural repeats the lesson at `StructuralFrameGripOverrule.cs` lines 159 to 162). Fix: keep each grip in a static list keyed by `ObjectId`, remove it at `GripsDone` and when the drawing closes. The zero-plan trial did not do this.
13. **Keeping `Entity` references:** keep only `ObjectId`s between calls. Open objects for read inside a short `StartOpenCloseTransaction`, never for write, and never inside a grip callback during a regen. An access violation inside AutoCAD cannot be caught by a `catch` in our code.
14. **Grips at stale positions:** compute positions fresh in every `GetGripPoints` from the live object; never cache a position. When `GetGripPoints` returns `GetNewGripPoints` AutoCAD asks again, so a click can move grips legitimately.
15. **Grips too close to the native ones:** on 3 Sep three Civil grips sat inside one pixel and looked invisible (`NativeGripProbe.cpp` comment, lines 41 to 43). Space ours from the native vertex grips by a few pixels, derived from `curViewUnitSize` and `gripSize` (old `StructuralFrameGrips.Spacing`).
16. **Slow selection:** a loose filter calls managed code for every object picked. The zero-plan rule is "nothing may watch every object or every command" (`PERFORMANCE.md` section 2 item 6). With the native filter the cost for an unmarked polyline is a dictionary check inside AutoCAD. Measure it every night: select 1,000 plain polylines with and without the plug-in.
17. **Stretch, PEDIT, JOIN, hatch picking:** we do not override stretch or the geometry routes, so STRETCH, PEDIT and JOIN see an ordinary polyline. The note on a joined polyline is a separate question (what the new polyline keeps), already a Trial 1 matter. For hatch picking and Recreate boundary the protection is item 1 plus the test in B4.

**What most likely crashed AutoCAD on 17 Nov (diagnosis from the trial code, not proven):**

18. The trial grip (`MouseTrials.cs` lines 14 to 26) differs from the old, working shipping grip in four ways. In order of how likely I think each is:
   1. `OnHotGrip` returns `ReturnValue.Failure` (line 17). AutoCAD is told the operation failed and has no defined recovery for a trigger grip; the old Civil code was written to avoid it. The log shows "OnHotGrip" ran and AutoCAD closed straight after.
   2. `HotGripInvokesRightClick = true` (line 16) with a managed `OnRightClick` returning two `MenuItem` objects (lines 18 to 23). The ObjectARX help for the right-click callback says return values of redraw and hot-to-warm are ignored there, so a click that must both run a click action and open a menu has no clean answer. The "menu asked for" line never appeared in the log, so the crash came before our menu code logged anything.
   3. The grip is not retained (line 33 adds a fresh `ZtGrip` to the collection and keeps no other reference). The click did reach our code, so the object was alive at that moment, which makes this the least likely single cause, but it is the same mistake Civil already paid for.
   4. `ForcedPickOn` and `TriggerGrip` were not set, so AutoCAD may have treated the extra point as a normal draggable grip whose click behaviour is undefined for our class. Unproven.
19. **How to prove it safely next time:** on a test copy, in a free window, with Tim's yes and a fresh AutoCAD (no profile, licence or setting change), one change per run, and a read-back after each:
   1. Run A: the old shipping settings (trigger grip, `HotGripInvokesRightClick = false`, returns `GripHotToWarm`, grip retained, no menu). Expect PASS. This is the baseline, because the same pattern runs daily on 2027.
   2. Run B: take run A and change only the click to return `Failure`. If AutoCAD crashes, item 18.1 is proven. Do this last, on a throwaway copy, and only if Tim agrees to a possible crash.
   3. Run C: take run A and set `HotGripInvokesRightClick = true` with a menu, to test 18.2.
   4. Run D: take run A and drop the retention, to test 18.3.
   5. Each run must also record: was AutoCAD's error window shown, was the drawing unsaved, did a second click work.

### B3. Double-click: taking over from PEDIT

1. **A .NET double-click event cannot cancel the native command.** In the 2027 wrapper, `BeginDoubleClickEventArgs` has only `Location` (decompiled `BeginDoubleClickEventArgs.cs` lines 6 to 10); no Handled or Cancel flag. The ObjectARX help calls it a notice that "the mouse button has been double clicked". That is exactly Trial 8's result: our window opened and PEDIT ran as well. It changes no saved setting.
2. **The old plug-in's route: react when the native command starts.** Listen for the command about to start (PEDIT, PROPERTIES, BEDIT, EATTEDIT, text editors), check that a double-click happened in the last second and a half and that the picked object carries our note, then post a cancel and start our own command (`CompoundEditModeService.cs` lines 203 to 272 and 503 to 521; table at `DoubleClickEditTable.cs`). It is in daily use, with known roughness: on 4 Sep a block editor opened before the posted cancel landed, so the code sets BLOCKEDITLOCK to 1 for that one command and restores it (lines 140 to 176). That is a system-variable change, small and put back, but under rule 1.9 a saved AutoCAD setting change needs Tim's yes; I do not know whether BLOCKEDITLOCK is stored with the drawing or the profile (UNVERIFIED). It writes no CUI file.
3. **The customisation double-click action (CUI):** `DoubleClickAction` and `DoubleClickCmd` exist in the managed customisation classes (ObjectARX help, "Autodesk.AutoCAD.Customization"). Double-click actions in the CUI are keyed by object type, so one for polylines would apply to EVERY polyline, not only ours; the macro would have to check for our note and otherwise run the native edit. Saving it writes a CUIX file, a saved setting, so it needs Tim's yes. Whether an action in a partial CUIX overrides the main one is UNVERIFIED. I would not use it for pipes.
4. **A custom-object double-click:** a custom object class can have its own double-click behaviour, but that is the custom-object route the new design deliberately avoids (ordinary objects with notes). UNVERIFIED how, and not recommended.
5. **Recommendation:** use route 2 only, behind a visible Settings switch that Tim controls, avoiding BLOCKEDITLOCK (pipes need PEDIT and PROPERTIES only, not BEDIT). Offer the grip or the ribbon button as the always-works path, so a missed double-click costs nothing. No CUI file is written and no saved setting changes.

### B4. Recommended design in plain steps, and the test plan

**Design:**

1. **Pits and pipes stay ordinary AutoCAD objects.** A polyline or block, an extension dictionary entry as the hidden note. Anyone without CE edits them normally.
2. **One grip overrule per object type** (one on Polyline, one on BlockReference), each with the native extension-dictionary filter for our dictionary name. No filter by class alone.
3. **First build: one trigger grip, no menu, no drawn icon.** Placed a few pixels in from the object's end or centre, a words tip on hover ("CE: open the pipe window"). Click answers `GripHotToWarm`, queues a request, opens the window at Idle. Retained in a static list until `GripsDone`.
4. **Second build, only after a pass:** a grip at a pipe end joined to a pit (different place and a different tip), then a grade or direction grip. Different icons are promised to nobody. Revisit only if a test shows drawn glyphs paint on 2027.
5. **Hover menu only on BlockReference** (pit blocks), if at all, and only after the test in step 3 below shows the native block menus survive. Never on Polyline until proven.
6. **Double-click:** B3 route 2, switchable, off by default until Tim says.
7. **Nothing else:** no listener on every command, no overrule on Hatch, Entity or Curve, no Geometry, Subentity, Osnap or Highlight overrule.

**Test plan (hatch and polyline behaviour must be identical with and without the plug-in loaded):**

1. **Fixtures (made-up drawing, copies only):** an associative hatch on a rectangle; a non-associative hatch with a curved side (like your screenshot); a hatch with an island; a hatch made from loose lines and arcs; a hatch whose boundary is a spline; a plain polyline, a closed polyline, a block reference, and one noted pipe and one noted pit for contrast.
2. **Test 1, grip list by code, no mouse:** for each fixture call AutoCAD's grip query (`GetGripPoints`) with the plug-in absent and with it loaded. For every plain object the number, positions and types of grips must be identical. For noted objects the plug-in's list must equal AutoCAD's list plus exactly our grips. Run it headless only if Tim allows the headless engine (rule 1.9; the trial notes say it cannot be used without his decision), otherwise inside full AutoCAD in a free window.
3. **Test 2, Recreate boundary:** run HATCHGENERATEBOUNDARY (and HATCHEDIT, Recreate boundary, with HPBOUND 1 and then 0) on every fixture, with and without the plug-in. Record how many objects come out, their types, closed flags, vertex lists and layers. Must be byte-for-byte equal. This test is Tim's current complaint, written as a check.
4. **Test 3, call counter:** the overrule counts how many times AutoCAD calls it. For every plain fixture the count must be zero after selecting, hovering and clicking each grip. A non-zero count is a fail.
5. **Test 4, real mouse, by the Codex robot:** select each hatch fixture, take a screenshot, compare with and without the plug-in. Click a native grip and press Esc; no crash. Double-click a plain polyline: PEDIT opens and no CE window. Double-click a noted pipe: CE window and no PEDIT.
6. **Test 5, our grip safety (the B2 runs A to D):** A must pass before anything else ships.
7. **Test 6, the native menu survives:** on a plain polyline, hover a vertex grip with the plug-in loaded: the native vertex menu (Stretch, Add Vertex, Remove Vertex, Convert to Arc) still appears. This is the guard for B2 item 5.
8. **Test 7, speed:** select 1,000 plain polylines with and without the plug-in; record both times in the nightly log (limit in `PERFORMANCE.md` section 2 item 6).
9. **Test 8, STRETCH, PEDIT, JOIN, EXPLODE and U:** on a noted polyline and a plain one, results and one undo step must match the no-plug-in result except for the note's own handling.
10. **Rule for every run involving AutoCAD:** no profile, no licence, no sign-in, no saved setting changed, no force-close, test copies only. The whole of rule 1.9 goes into the brief word for word.

---

## Not verified

1. **Compiled files against source:** I matched the installed DLLs to commits by product-version string, not by comparing the compiled code to the source.
2. **Whether Tim's hatch is associative, and what the Properties palette says.** I have only the screenshot description.
3. **Why some edges have no grip.** No document read explains it.
4. **Three Autodesk pages refused to load** (access refused): the support article "Generation of hatch boundary creates lines instead of closed polylines in AutoCAD products", the support article "Recreating hatch boundary in AutoCAD", and the blog post "A Better Hatch Experience: Tuesday Tips With Frank". I used only their titles and search summaries. The forum thread "No grips on hatches in AutoCAD 2018" also refused; only its search summary (GRIPMULTIFUNCTIONAL and a third-party module as causes) was seen, so it is UNVERIFIED.
5. **The AutoCAD 2027 (full, not LT) help page for hatch grips** did not come up; the LT 2027 page and older pages stood in. Same for the AutoCAD 2027 HPBOUND and HATCHGENERATEBOUNDARY pages (2022 LT and 2015 LT Mac pages used).
6. **Any AutoCAD 2026 or 2027 update changing hatch grips or recreated boundaries:** none found, not proof none exists.
7. **Whether CE's selection reader (A1 item 12) can alter hatch grips.** It reads and rarely writes the selection; I could not test it.
8. **Other add-ins on Tim's PC.** I did not list them.
9. **`BeamLinkService`, `FoundationMonitor`, `DrawingAutoSaveService`, `ReoBarMonitor`:** I read the Beam clone and queue code, and only the entry lines of the rest.
10. **The `CeCvlPipe` object file:** I searched its source for overrules, reactors and hatch code (none) but did not read it line by line.
11. **That `RXClass.AddX` replaces an existing protocol extension and so would remove native polyline vertex menus** (B2 item 5): my reading of the help, not tested.
12. **That a drawn grip icon paints on 2027 by some route we have not tried.** Autodesk's handout says it works to 2023; our four tries on 4 Sep on 2027 failed.
13. **Which of the four crash differences caused the 17 Nov crash.** Ranked by judgement; the B2 runs would settle it.
14. **Whether BLOCKEDITLOCK is saved in the profile or drawing**, and whether a partial CUIX double-click action overrides the main one (B3).
15. **Whether a custom-object double-click route exists** and how it works (B3 item 4).
16. **Native filters:** that AutoCAD really skips our managed code for an unmarked object when `SetExtensionDictionaryEntryFilter` or `SetXDataFilter` is set. The old code's comments say so and today's log is consistent (no Polyline calls), but I did not measure it.
17. **That hatch boundary picking and Recreate boundary read geometry through Geometry, Subentity or Osnap routes** (B2 item 1): my understanding, not checked.
