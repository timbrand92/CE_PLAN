# Structural ribbon — families, drop-downs and duplicates (draft, 26 Sep 2026)

**Status:** DRAFT. Behaviour already ruled by Tim 25 Sep 2026 (UX-STRUC-02 to 05,
`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Structural front door"). This card turns that ruling into a
build-ready plan for the AGENTS.md review gate: what works today, what changes, and the open build questions.
**Nothing here is built.** No code starts until Tim approves this card.
**Read from:** the command registry on the shipping branch (`claude/struc-d1-prep`, commit `0945bdf6`,
`Modules/Structural/Assets/Config/command-registry.json`, 329 commands), the Structural ribbon builder
(`Modules/Structural/Services/CeStrucRibbonContributor.cs`), and the shared ribbon code in `Shared/CE_SHARED` on
both the Structural line and `origin/master`.

---

## FOR TIM

### 1. What this card covers

1. **The ribbon:** turning today's alphabetical dropdown lists into named families — Beam, Text, Tag, and a
   picture gallery for Hatch — each one remembering your last pick, about 40 tools on show instead of everything.
2. **The duplicates:** commands that do the same thing under two, three or four different typed names get one
   real command; the others keep working as silent typed shortcuts.
3. **The "Legacy" utilities:** 29 commands under that heading move into the family they actually belong to, and
   the word "Legacy" disappears from what you see.
4. **The hidden test/diagnostic commands:** CEDEBUG and JOBTIMERDEBUG (and a few more like them) stop showing to
   drafters.
5. Every typed command keeps working exactly as it does today. This card only changes what you see and click —
   never what a typed command does.

### 2. What works today, in drawing terms

1. **The Structural ribbon already has 7 panels** — Beams, Columns & Footings, Rebar & Bracing, Annotate, Line
   styles, Schedules, CE — each with a handful of named buttons plus dropdown lists it calls "flyouts" (a plain
   AutoCAD-style dropdown menu, alphabetical, no picture, no memory of your last pick).
2. **Everything not explicitly named lands in one of those dropdowns automatically**, sorted by the command's
   group in the registry. So the ribbon does not literally show all 329 typed commands as buttons — most are
   already one click inside a dropdown. But those dropdowns are flat and alphabetical, not the family structure
   you asked for.
3. **The word "Legacy" is on the ribbon today.** The Utilities/Legacy group opens as a dropdown literally titled
   "Legacy Drafting" on the Annotate panel.
4. **Hatching (43 commands) is one flat dropdown** on the Annotate panel today, no pictures, no gallery.
5. **The 56 text/tag codes are one flat dropdown** ("Beam & Support Tags") on the Annotate panel — every code
   alphabetical, nothing grouped by what it actually marks.
6. **Diagnostics are not hidden today.** CEDEBUG ("Text Tag Diagnostics") and JOBTIMERDEBUG ("Time Tracking
   Diagnostics") are both set to show (not hidden) in the registry, so they appear in their dropdowns for every
   drafter, not just for testing.
7. **Duplicate commands are not merged today.** Where two typed names do the same job (see section 4), the
   registry holds them as two, three or four separate entries with the identical description. Today's dropdown
   shows every one of them side by side — open "Legacy Drafting" and you see "Centreline Symbol" four times in a
   row, with no way to tell which one to click.
8. **CETOOLS, CENOTES, CECHECKLIST, CETOOLSTOGGLE:** already ruled 25 Sep (UX-RIBBON-04, not re-asked here).
   CETOOLS stays on the Structural ribbon; CECHECKLIST and CETOOLSTOGGLE merge into it with their old names kept
   as typed shortcuts; only CENOTES moves into Manager; STRIPLAYERSMERGE and STRUCLINKTEXT stay typed-only in
   Structural (no ribbon button). CESTRUC (the Structural Command Window / StrucSuiteWindow) is explicitly **not
   decided** — Tim: *"needs to be revisited in detail before deciding"* — so this card leaves it exactly as it is.

### 3. What needs to change, family by family

Grouped the way you'd actually look for them on a job, not alphabetically.

1. **Beam family — Modify.** Today: one "Beam" button (command 1) plus a flat "Beam Drafting" dropdown holding
   commands 2, 4, 5, BDL, BEXT and the rest of the Structural/Beam group (18 commands), alphabetical, no
   memory. **Change to:** a Beam drop-down button — face click runs your last-used beam type, the arrow opens
   Regular / Lower / Special / Offset as named picks, remembering whichever you used last.
2. **Text family — Modify.** Today: text-drafting commands (COPYM/CEMCOPY, R2LTXT, and others) sit scattered
   across Annotate's "Legacy Drafting" and "Beam & Support Tags" dropdowns. **Change to:** one Text drop-down
   grouping the drafting-text tools together, remembering the last pick.
3. **Tag family — Modify (per UX-STRUC-04, already ruled).** Today: all 56 text/tag codes sit in one flat
   "Beam & Support Tags" dropdown, typed only, no on-drawing pick-and-place tool. **Change to:** the 56 codes
   keep working exactly as typed today (nothing retired); one new **Tag** tool is added to the ribbon: pick the
   object, pick the side, and it remembers your side choice next time.
4. **Hatch gallery — Rebuild.** Today: 43 hatching commands (20 patterns, 18 template presets, 5 CE hatch tools)
   are one flat alphabetical dropdown with no picture. **Change to:** a picture gallery, tiled, remembering the
   last tile picked — the way AutoCAD's own Hatch ribbon gallery works.
5. **Utilities/Legacy family — Modify (per UX-STRUC-05, already ruled).** Today: 29 commands under one dropdown
   literally called "Legacy Drafting". **Change to:** sorted into the family each tool actually belongs to (list
   in section 5) with the word "Legacy" gone from every label a drafter sees.
6. **Duplicates — Modify.** One real command per tool; the other names become silent typed shortcuts. Full list
   in section 4. Ribbon and Help show one name only; every other typed name still works exactly as before.
7. **Diagnostics — Modify (hide).** CEDEBUG, JOBTIMERDEBUG and a short list of similar test-only commands
   (section 6) stop appearing on the ribbon and in Help/search for ordinary drafters; the typed command still
   works for anyone who knows it (Tim, Codex, a builder chasing a fault).
8. **CE panel — Keep**, with the CETOOLS/CECHECKLIST/CETOOLSTOGGLE/CENOTES merge already ruled (item 2.8) folded
   in.
9. **Line styles panel — Keep as is.** Already a compact, working picker; not part of this card's scope.

### 4. Every duplicate group in today's registry (27 groups, one real command each)

Read directly from the registry on 26 Sep 2026. For each group this card recommends the shortest, most
AutoCAD-style code as the one shown on the ribbon and in Help; every other name keeps working as a silent typed
shortcut. This recommendation is Open question 1 below — Tim may prefer a different pick in any row.

1. **Centreline Symbol:** CENTERLINE, CENTRELINE, CL, CLINE → recommend **CL**.
2. **Slab Thickening Outline and Tag:** THC, BTHC, THCL, THCR → recommend **THC** (BTHC/THCL/THCR are the
   "over" and left/right variants — confirm with Tim these are truly the same tool before merging; see Open
   question 2).
3. **Pad Footing Outline and Tag:** PFC, BPFC, PFCL, PFCR → same left/right caveat as above → recommend **PFC**.
4. **Strip Footing Multiline and Tag:** SFC, BSFC, SFCB, SFCT → recommend **SFC**.
5. **Strip Footing Over Multiline and Tag:** BSFCB, BSFCT → these are the "over" pair of #4; recommend keeping
   as their own tool (an "over" version is a different drawn result, not a duplicate — see Open question 2).
6. **Slab Thickening Over Outline and Tag:** BTHCL, BTHCR → same "over" caveat.
7. **Pad Footing Over Outline and Tag:** BPFCL, BPFCR → same "over" caveat.
8. **Column Over Tag:** BPC, BPCL, BPCR → same "over" caveat.
9. **Column Tag — Right:** CR1, PCR → recommend **PCR**.
10. **Column Tag — Left:** CL1, PCL → recommend **PCL**.
11. **Switch A/B Bracing:** ABS, ABSWITCH, STRUCABS → recommend **ABS**.
12. **A-Bracing:** AB, STRUCAB → recommend **AB**.
13. **B-Bracing:** BB, STRUCBB → recommend **BB**.
14. **Finished Floor Level Mark:** FFL, FFLMARKER, FLMK → recommend **FFL**.
15. **Scabble Line:** SCAB, SCABBLE → recommend **SCAB**.
16. **Reinforcing Bar Line:** RBL, REBARLINE → recommend **RBL**.
17. **Reinforcing Bar:** RB, REBAR → recommend **RB**.
18. **Move and rotate:** MOVEROT, MR → recommend **MR**. This tool is already the shared Transform team's to own
    (design record TF-01: one Shared Transform entry for Civil and Structural together); this card only records
    the duplicate, TF-01 owns the merge.
19. **Copy and rotate:** COPYROT, CR → recommend **CR**, same TF-01 note as above.
20. **Copy Multiple:** CEMCOPY, COPYM → recommend **COPYM**.
21. **Change to Tagged Triple Stud:** STS1, TTS1 → recommend **TTS1**.
22. **Change to Tagged Double Stud:** SDS1, TDS1 → recommend **TDS1**.
23. **Change to Double Stud:** SDS, TDS → recommend **TDS**.
24. **Change to Column Marker:** SC1, TC1 → recommend **TC1**.
25. **Assign Selected Objects to Floor:** EXCELCAPTURESELECTION, EXCELMAPFLOOR → recommend **EXCELCAPTURESELECTION**
    (matches the other Excel-import command names already in use).
26. **Assign Drawing Area to Floor:** EXCELCAPTUREAREA, EXCELMAPFLOORAREA → recommend **EXCELCAPTUREAREA**.
27. **Structural Command Window:** CE_STRUC_SUITE, CESTRUC → **not decided** (UX-RIBBON-04 OPEN 2); left alone
    until Tim's detailed review.

**Already correctly merged, nothing to do:** BEXT/BEXTEND (Beam Extend) already shows as one command with the
other as a typed alias — the pattern every row above should copy.

**A data-quality point worth flagging, not asking:** for several of the pairs above (AB/STRUCAB, ABS/ABSWITCH/
STRUCABS, BB/STRUCBB) the registry already lists one as an "alias" of the other in its data — but the alias
field does not currently stop the aliased name from also being its own separate, visible ribbon entry. Both
show today. The merge in this card has to fix that display bug as well as sort the remaining plain-duplicate
rows, or the ribbon will look "merged" in the data but still show doubles.

### 5. The 29 Utilities/Legacy commands, sorted into families

1. **Annotate family (marks, joints, dividers):** CENTERLINE/CENTRELINE/CL/CLINE (Centreline Symbol), CJ
   (Construction Joint), CJSS (Swap Construction Joint and Saw Cut), SSC (Slab Saw Cut), DIV (Divide with Cross
   Marks), DIVX (Divide with Paired Cross Marks), FFL/FFLMARKER/FLMK (Finished Floor Level Mark), MTS
   (Standardise Text Styles).
2. **Rebar & Bracing family:** RB/REBAR (Reinforcing Bar), RBL/REBARLINE (Reinforcing Bar Line).
3. **Columns & Footings family:** SPW (Bored Pier 450), SPW3 (Bored Pier 300), SPW6 (Bored Pier 600), SPWC
   (Bored Pier with Concrete Hatch), SCAB/SCABBLE (Scabble Line).
4. **Drawing setup / CE panel:** LU (Import Drawing Settings — already flagged in `areas\structural.md` as
   needing improvement, not part of this card), CPB (Copy and Paste as Block).
5. **Shared Transform tools, not a Structural family (TF-01 owns these):** COPYROT/CR (Copy and rotate),
   MOVEROT/MR (Move and rotate). Recorded here so nothing is lost; they leave the "Legacy" bucket but do not
   need a new Structural home — TF-01's single shared entry is the destination.

### 6. Diagnostic and test commands to hide from drafters

Not asked as a question — already covered by the 25 Sep front-door ruling ("presented as part of the polished
version"). Listed here so the build has an exact list, read from the registry's own Diagnostics group plus the
two named examples:

1. **CEDEBUG** (Text Tag Diagnostics) — currently visible, must be hidden.
2. **JOBTIMERDEBUG** (Time Tracking Diagnostics) — currently visible, must be hidden.
3. **BEAMLINKDEBUG, BEAMLINKMIGRATE** — already hidden in today's registry; keep hidden.
4. **CEMARKUPBENCH** (Check Markup Reading Accuracy) — a test/accuracy tool, not a drafting command; recommend
   hiding alongside the two named ones (Open question 3).
5. Hiding is a registry flag only — Tim, Codex and a builder can still type any of these commands directly; only
   the ribbon, Help and search stop showing them to ordinary drafters.

### 7. The shared ribbon contract — what it supports today, and what has to change

You asked this card to say plainly what the shared ribbon code can and cannot do yet, because it decides whether
"a Beam drop-down that remembers your last pick" and "a Hatch gallery with pictures" are buildable now or need
other work first.

1. **Civil and Manager already have it.** `origin/master`'s copy of `CE_SHARED` (5 Sep 2026, the "R1" ribbon
   update Tim reviewed as design pack item #58) added a real drop-down button — one face action plus an arrow
   that opens named picks — and a picture gallery where the last tile picked stays ticked. This is exactly the
   drop-down and gallery behaviour UX-STRUC-02 asks for.
2. **Structural's own copy of `CE_SHARED` is older and cannot do either yet.** The Structural line still
   references the pre-5-September `CE_SHARED`, whose ribbon builder can only build a plain dropdown menu (what
   this card calls a "flyout") — no dedicated face button, no picture gallery, no memory of the last pick.
3. **Why they differ:** Civil and Structural's copies of the shared code split apart months ago and have not
   been brought back together (the same split the Structural D1 card records: common ancestor `01380d16`, 402
   commits on the Structural line since, 1,382 on master). Structural's shipped bundle deliberately does **not**
   carry its own copy of `CE_SHARED.dll` — a build check refuses to package one — because Civil and Manager's
   copy is the one that loads first and every module must agree on a single version.
4. **What must change before this card can be built:** the Structural line has to take on master's newer
   `CE_SHARED` (the drop-down and gallery code), the same way and at the same time as the D1 card's own
   dependency on master's shared object-naming code — not a separate, second exercise. Until that happens, this
   card's ribbon changes can be designed and agreed with Tim, but the drop-down/gallery pieces cannot be built.

### 8. The full experience

1. **Where you start:** the CE Structural ribbon tab, same seven panels as today (Beams, Columns & Footings,
   Rebar & Bracing, Annotate, Line styles, Schedules, CE); only what is inside four of those panels changes.
2. **Trigger:** click the family face button to run your last pick, or the arrow beside it to choose a different
   one from that family (Beam, Text, Hatch) or pick-and-place a Tag.
3. **Prompts:** unchanged — every family still runs its underlying typed command's own prompts once you pick it.
4. **Selection, preview, drawing output:** unchanged per command; this card only changes how you find and start
   a command, never what it draws.
5. **Cancel / Escape:** unchanged, same as each underlying command today.
6. **One Undo:** unchanged, same as each underlying command today. This card adds no new drawing-writing
   behaviour of its own.
7. **Save/reopen:** nothing to store — the "last pick remembered" setting lives with your CE preferences, not in
   the drawing.
8. **Settings:** none of this is an engineering value, so nothing moves to the Settings page; the "remembered
   last pick" is a per-user ribbon preference.
9. **Discovery:** Help and CEPALETTE (command search) show the one canonical name per duplicate group and the
   family name for grouped tools; every typed shortcut still resolves and runs, it just is not the name shown.

### 9. Example drawing and checklist

1. **Test drawing DWG-S1:** any Structural job drawing already carrying one of each family's typical objects —
   a beam, a column and footing, some bracing, a hatched slab, a couple of tagged members. No client content
   (built to look like a job, or copied from a fixture, never a real address).
2. **Automated guard (build-time, no AutoCAD needed):** a test that loads the registry and fails if any two
   visible commands share an identical label without one being registered as the other's alias — this is what
   would have caught today's AB/STRUCAB-style double display before it shipped.
3. **Automated guard:** every typed command name in the registry (canonical and shortcut alike) still resolves
   to a working `CommandMethod` — nothing is silently dropped by the rename.
4. **Tim's AutoCAD checklist, once built:**
   - Open DWG-S1. Click the Beam family face button: your last-used beam type runs. Click the arrow: Regular,
     Lower, Special and Offset are all there, named plainly.
   - Open the Hatch gallery: you see pictures of the patterns, not a text list; pick one, hatch a slab, reopen
     the gallery — your pick is ticked.
   - Click the new Tag tool: pick a beam, pick a side, it tags; run it again on another beam, same side without
     re-picking.
   - Type FFLMARKER (a duplicate's old name) at the command line: still works, still draws the same mark.
   - Open Help or CEPALETTE and search "centreline": one result, not four.
   - Confirm CEDEBUG does not appear anywhere on the ribbon, Help or CEPALETTE — then type it directly: it still
     runs.
   - Confirm nothing under the old "Legacy" heading still says "Legacy" anywhere you can see it.

### 10. Slices, smallest first

1. **Slice 1 — hide the diagnostics.** Registry-only change (section 6); no ribbon code touched; lowest risk,
   can go first and alone.
2. **Slice 2 — fix the double-display bug** for the already-partially-aliased groups (AB/STRUCAB and its two
   pairs) so an alias never shows as a second visible entry. Proves the underlying mechanism works before the
   bigger duplicate-merge slice.
3. **Slice 3 — merge the remaining 24 plain duplicate groups** (section 4) into one canonical name each, once
   Tim has answered which name wins in each row.
4. **Slice 4 — sort the 29 Utilities/Legacy commands** into their families and drop the word "Legacy" (section
   5). Independent of the drop-down/gallery work; can land before or after slice 5.
5. **Slice 5 — bring the Structural line onto master's `CE_SHARED`** (section 7), coordinated with the D1 card's
   own need for master's shared object-naming code. This is the blocking slice for slices 6 and 7.
6. **Slice 6 — build the Beam and Text drop-downs and the one Tag tool**, once slice 5 lands.
7. **Slice 7 — build the Hatch picture gallery**, once slice 5 lands; can run in parallel with slice 6.

### Open questions

1. **Which name wins in each duplicate group (section 4)?** *Recommended: the shortest, most AutoCAD-style code
   in each row, as listed.* Example: typing FLMK still works either way; only which name shows on the ribbon and
   in Help changes.
2. **Are the "over" and left/right variants (THC/BTHC/THCL/THCR and its four sibling groups) genuinely the same
   drawn result, or different outlines that only share a label?** *Recommended: treat left/right and "over" as
   real, separate tools (not part of the duplicate merge) until someone who knows the footing/slab detailing
   confirms they draw the same thing — merging two tools that actually draw differently would be a silent
   change, which the plan does not allow.*
3. **Hide CEMARKUPBENCH from drafters alongside CEDEBUG and JOBTIMERDEBUG?** *Recommended: yes — it is an
   accuracy-testing tool (see the Markup QA card), not a drafting command.*
4. **Exact target list for "about 40 tools shown"?** *Recommended: leave the precise number to the builder once
   the family and duplicate merges are built — the ruling gives a target, not a fixed count, and forcing an
   exact 40 before build risks cutting something a drafter uses daily.*

---

*Everything below this line is for the builder. Nothing below needs Tim to read, decide or do anything.*

---

## For the builder

### Pinned source (read 26 Sep 2026)

1. **Shipping Structural line:** `origin/claude/struc-d1-prep`, tip `0945bdf6` ("Add Structural SWELD tick-run
   weld mark"). Registry: `Modules/Structural/Assets/Config/command-registry.json`, 329 commands (`version`
   `"2026.03.18"`).
2. **Ribbon presentation:** `Modules/Structural/Services/CeStrucRibbonContributor.cs` (389 lines).
   `StructuralRibbonDefinitionService.Build` reads `CommandRegistryService.Instance.GetVisible(includeExpert:
   true)`, so a registry `hidden: true` flag is what removes a command from this path today.
3. **Shared ribbon code, Structural's copy:** `Shared/CE_SHARED/Services/RibbonBuilder.cs` and
   `Shared/CE_SHARED/Contracts/ICeRibbonContributor.cs` on `claude/struc-d1-prep` — pre-R1, builds `Large`,
   `Compact` and `Flyout` (`RibbonSplitButton` with `IsSplit = false`, a plain dropdown of children) only. No
   `Split`, `Gallery`, `CeRibbonGallery` or `CeRibbonContractV3` types exist on this copy.
4. **Shared ribbon code, master's copy:** `Shared/CE_SHARED/Contracts/CeRibbonContractV3.cs` (added 5 Sep 2026,
   "R1 — CE_SHARED ribbon contract additions", design authority `docs/design/V3_UI/windows/01_RIBBON.md` §9.2,
   Tim's review #58) and the matching `RibbonBuilder.cs` `BuildSplitButton` / `BuildGalleryButton` methods:
   `CeRibbonGallery.CurrentItemCommand` is exactly the "last tile ticked" mechanism section 7 describes.
5. **Structural does not ship its own `CE_SHARED.dll`:** `Modules/Structural/CE_STRUC_SUITE.csproj` references
   `Shared/CE_SHARED/CE_SHARED.csproj` at compile time but its packaging targets assert
   `Exists('$(_BundleWin64)\CE_SHARED.dll')` is an **error** for a standalone Structural package, and a
   PowerShell binary/deps scan fails the build if `CE_SHARED` text appears in the packaged Structural DLL or its
   deps manifest — consistent with memory `ce-shared-one-assembly-identity.md` ("Structural 1.0.74 has none").
6. **Duplicate-label groups (27):** produced by grouping every `commands[]` entry by its exact `label` field,
   26 Sep 2026, against the pinned commit above. Re-run before building in case the registry has moved again —
   it grew from 307 (25 Sep 23:19 ruling) to 329 in the one day between the ruling and this card.
7. **Registry group/subgroup counts (26 Sep 2026):** Structural 107 (Text Tags 56, Supports 19, Beam 18,
   Bracing 9, Rafter/Joist 3, Site 2), Hatching 43 (Patterns 20, Template Presets 18, CE Hatch Tools 5),
   Utilities 42 (Legacy 29, Xrefs 7, Export 4, Cleanup 2), Administration 26 (Markup 11, Diagnostics 4, Help 3,
   Workspace 5, System 2, Standards 1), Line styles 21, Section Details 21, Annotation 15, Foundations 13,
   Schedules 9, Footings 4, Scheduling 1, no group assigned 27. These differ from the 25 Sep 23:19 ruling's
   figures (307 total, Text Tags 56, Hatching 38, Utilities/Legacy 29, Beam 16) because the registry moved on
   between that reading and this one — Text Tags and Utilities/Legacy counts held, Hatching and Beam grew by a
   few, and the total grew by 22 (includes the new SWELD weld-mark command from the same commit).
8. **The "no group assigned" 27** (listed in full in the raw data this card was built from) currently fall
   through `ResolvePanel`'s catch-all to the Annotate panel (or the `CESHEETS`-prefix special case to Schedules).
   They include several already-correct entries (CE_RL/CE_SSL/CE_NGL — genuinely different level-mark types, not
   duplicates of each other or of CE_LEVELMARK/LM) and several that belong in the Utilities/Legacy sort
   (WALLSTRS, LBW, SF/SFC, THC, PFC, SCREWPILE, STUMPFOOTING, R2LTXT, ML, CML) but are not tagged with a group
   today, so they need a group/subgroup assignment as part of slice 4, not just the 29 already labelled
   "Legacy".
9. **Related design record already in `04_REFERENCE`:** the civil-system-design planner's
   `structural_registry_gap_dispositions.md` and `structural_command_identity_reconciliation.md` (16 Sep 2026)
   cover a related but not identical question — source `[CommandMethod]` declarations with no registry row at
   all, and registry rows with no matching declaration. Their figures (301 source attributes, 251 registry
   entries) predate the current 329-command registry and use different workflow-card numbering (`ST-*`, `W0-
   W11`) to this V3-plan front-door ruling. Treat as background evidence only; do not mix their counts with this
   card's.

### Automated guards to write with this card

1. **No two visible commands share a label unless one names the other in its `aliases` array** (catches the
   AB/STRUCAB-style double display).
2. **Every registry `command` and every `aliases[]` entry still resolves to a working `[CommandMethod]`** after
   the canonical-name relabelling.
3. **A hidden command's typed name still runs** (CEDEBUG, JOBTIMERDEBUG and the rest of section 6) — hiding is a
   discovery-only change, never a functional retirement.
4. **Registry round-trip:** the file stays valid JSON and `CommandRegistryService.GetVisible` returns the same
   total working-command count before and after the merge (only display count should fall).

### Open dependencies before a builder starts

1. Tim's answers to the four Open questions above.
2. Slice 5 (Structural onto master's `CE_SHARED`) is shared work with the D1 card's own `Shared/CE.Spine`
   dependency — coordinate one plan for bringing the Structural line forward, not two competing ones.
3. Confirmation from whoever knows footing/slab detailing on Open question 2 before slice 3 touches the four
   "over"/left-right groups.
