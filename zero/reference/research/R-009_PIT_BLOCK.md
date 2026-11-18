# R-009 The office pit block (revision 1)

Read-only research, Wed 18 Nov 2026 (D-215). Nothing was built, run, installed or opened in AutoCAD. Both blocks were read from copies only: the DXF text copy of the office master drawing (`C:\CE_WORK\scratch\blocks_review\master_copy.dxf`), the A1 civil template copy and `pit_seed.dwg` under `C:\CE_WORK\civil_tests\`, and `PIT BLOCK 2.dwg` / `PIT BLOCK 3.dwg` taken out of git (old plug-in, ref `origin/claude/rel-20261114a`, `Installer/source_blocks/`). The DWG copies were read with the ACadSharp library already on the PC (`C:\CE_CIVIL\tests\CeCivil.DwgRead.Tests\bin\Debug\net10.0\ACadSharp.dll`, version 3.8.35; also in the NuGet cache). Working files: `C:\CE_WORK\scratch\pit_block_study\`.

## The short answer for Tim

1. **Use PIT BLOCK 3, with a few edits.** Your stretch design is the right one for the plug-in: the size is two numbers it can read back after anyone grips or types a new size, and a new size needs no new drawing.
2. **"Stormwater Pit" stays readable on old drawings** (a 16-line list of its state names in the plug-in's data), but new pits should be PIT BLOCK 3.
3. **The one real gap in BOTH blocks:** the solid inner wall line is not a line at all. It is the frame of the mask (wipeout). If a drawing has wipeout frames off or "show but don't plot", the inner wall vanishes or does not print. Add a real line (edit 1).
4. **Next most useful:** plain names ("Kind", "Length", "Width"), a 50 mm step instead of the fixed list of five sizes, and a "Plastic pit" state.
5. **Leave alone:** no attributes for the tag or cover level, not annotative, base point already at the centre, all objects already ByLayer.
6. **Save the edited block under a new name** (for example "PIT BLOCK 4") so drawings the old plug-in made with PIT BLOCK 3 are never disturbed.
7. **Your 10-minute trial** is in section F.

## A. What each block is, exactly

### A1. "Stormwater Pit" (the 16-state block in the template and the master)

1. **What it is:** one dynamic block with ONE parameter, a visibility parameter. No stretch, no lookup, no flip, no base point parameter, no attributes, no text. Insertion units "unitless".
2. **What Properties shows:** under Custom, one drop-down called **"Visibility1"** (the parameter's label), with 16 states: 350x350 Grated pit, 350x350 Junction pit, 450x450 Grated Pit, 450x450 junction pit, 600x600 Grated Pit, 600x600 Junction, 600x900 Grated Pit, 600x900 Junction, 750x750 Grated Pit, 900x900 Junction Pit, 900x900 Grated Pit, 600x1200 Detention Pit, SPS Vertical, SPS Horizontal, Enviss Sentinel, Settling Tank. The spelling and capitals are not consistent ("junction pit", "Junction", "Junction Pit").
3. **Grips:** one visibility grip (the triangle), placed about 950 right and 950 below the insertion point, outside the pit.
4. **What is stored:** 59 objects; each state shows 3 to 6 of them.
5. **A grated state (for example 450x450):** a mask (wipeout) 450 square on STORMWATER PIT; a user-defined line hatch 450 square on GRATED TRENCH (spacing 125); an outer square 750 on PITS HIDDEN (dashed). So the wall is drawn 150 thick.
6. **A junction state (for example 900x900):** a mask 900 square on STORMWATER PIT; two diagonal cross lines on STORMWATER PIT with colour forced to 9; an outer square 1200 on PITS HIDDEN.
7. **Wall thickness drawn:** 100 (350 grated), 125 (350 junction), 150 (every other size). Fixed per state.
8. **600x900 states:** 900 along the sheet (X), 600 up (Y). There is no 900-up version; you turn it.
9. **600x1200 Detention Pit (the orifice pit, E-010):** two 600 x 600 chambers side by side with a 150 gap (the baffle), the left one crossed (solid lid), the right one hatched (grate), inside a 1650 x 900 dashed outline. The name "600x1200" does not describe it (the JOB_C schedule calls the same pit 600 x 600).
10. **SPS Vertical:** two dashed circles, 1800 and about 1900 diameter, with a 600 x 900 crossed lid and grate. Fixed size.
11. **SPS Horizontal:** a dashed 6000 x 2200 tank outline with a 900 x 600 lid. **Enviss Sentinel:** 600 square with a grid grate. **Settling Tank:** a 1960 x 810 dashed box with a solid fill (colour 138).
12. **Inner wall line:** there is no inner wall line object except in the 750 state. Everywhere else the solid inner square you see is the mask's frame. (I checked every mask's trimmed outline: they all sit exactly on the inner size, so they are correct, they are just frames, not lines.)
13. **Not ByLayer:** the cross lines (colour 9), the 350 grated outer square (colour 6, linetype HIDDEN2), the settling tank fill (138) and its mask (colour 7, HIDDEN).
14. **Base point:** the block's origin, which is the pit centre in every state (the horizontal SPS tank is off-centre).
15. **With NO plug-in:** pick the pit, choose a state from the Properties drop-down or click the triangle grip. Anything not in the 16 is impossible without exploding and redrawing.

### A2. "PIT BLOCK 3" (your stretch design; the master copy and the old plug-in's file match)

1. **What it is:** a dynamic block with a visibility parameter, six linear parameters, eight stretch actions and one scale action. No lookup, no flip, no rotation, no base point parameter, no attributes, no text. Insertion units millimetres.
2. **The visibility parameter, label "GRATED_OR_SOLID":** 5 states: GRATED PIT, SOLID PIT, SPS GRATED PIT, SPS SOLID PIT, DETENTION PIT. Each state also lists which distance parameters and grips belong to it, so the detention grips only show on the detention state, and so on.
3. **The six distances, as Properties labels them:**
   1. **Y_WIDTH** (up the sheet) and **X_WIDTH** (along the sheet): the pit's inner size. Default 350 x 350. Base location **Midpoint**, so the pit grows equally about its centre and the insertion point stays at the centre. Value set: a **list** of 350, 450, 600, 900, 1200. Grip: one arrow at a corner.
   2. **X_WIDTH_DETENTION_SOLID** and **X_WIDTH_DETENTION_GRATED:** the length of each orifice pit chamber (default 600 each). Base location Start point at the baffle, so each chamber grows outward. Same list of five sizes.
   3. **Y_WIDTH_DETENTION:** the chambers' width (default 600). Its two stretch actions use multipliers 0.5 and -0.5, so it grows equally both ways. Same list.
   4. **SPS_RADIUS:** the pump well's radius (default 900, so 1800 diameter). No value set (free). Drives a scale action on the two circles, so the wall scales with it.
4. **The stretch actions:** Stretch_NORTH, _SOUTH, _EAST, _WEST (the main pit; they move the mask, the hatch, the cross lines and the dashed outer square together), Stretch_WEST_SOLID, _EAST_GRATED, _NORTH_BOTH, _SOUTH_BOTH (the orifice pit).
5. **What each state shows:**
   1. **GRATED PIT:** mask 350 square (STORMWATER PIT), line hatch (GRATED TRENCH, spacing about 97), dashed outer square 550 (PITS HIDDEN).
   2. **SOLID PIT:** mask, two cross lines on GRATED TRENCH (ByLayer, so they print colour 9 like the old ones), dashed outer square.
   3. **SPS GRATED / SPS SOLID:** the lid (as above) plus two dashed circles, 1800 and 1900 diameter, both on PITS HIDDEN.
   4. **DETENTION PIT:** the same two-chamber layout as the old block (left crossed, right hatched, 150 baffle gap, 1650 x 900 dashed outline at the default sizes).
6. **Wall thickness:** 100 everywhere and at every size (the stretch moves the outer square by the same amount as the inner). The orifice pit walls are 150.
7. **Inner wall line:** as in the old block, only the mask's frame. No line object.
8. **Base point:** the block origin, which is the centre of the pit (centre of the baffle for the orifice pit).
9. **ByLayer:** every object is ByLayer colour, linetype and lineweight. Cleaner than the old block.
10. **"PIT BLOCK 2"** (old plug-in file only, not in the master): the same parameters, names and lists; the only difference found is that its cross lines are on STORMWATER PIT instead of GRATED TRENCH.
11. **With NO plug-in:** pick the pit; in Properties choose the state, then pick X_WIDTH and Y_WIDTH from their drop-downs (only the five sizes), or drag the corner arrow grips, which jump between the five sizes. A typed or dragged size that is not one of the five snaps to the nearest one (from memory, not proven here).

## B. For a drafter by hand: which is quicker and safer

1. **450 x 450 grated pit.** Stormwater Pit: one pick ("450x450 Grated Pit"). PIT BLOCK 3: grated is the default state, then X 450 and Y 450: three settings. **Quicker: Stormwater Pit.** (A "Size" lookup, edit 4 in section E, makes PIT BLOCK 3 one pick too.)
2. **600 x 900 pit turned 90 degrees.** Stormwater Pit: pick "600x900 Grated Pit", then ROTATE 90. PIT BLOCK 3: X 600, Y 900, no rotation. **Both fine; PIT BLOCK 3 slightly quicker.**
3. **900 x 900 junction pit.** Stormwater Pit: one pick, 150 walls drawn. PIT BLOCK 3: SOLID PIT, X 900, Y 900; walls drawn 100. **Stormwater Pit quicker and looks like today's sheets.**
4. **Orifice pit with two chambers.** Stormwater Pit: fixed at two 600 x 600 chambers; a 600 x 900 chamber means exploding and redrawing. PIT BLOCK 3: each chamber's length and their shared width set separately. **PIT BLOCK 3 clearly better.** In both, the name ("Detention") is wrong for what it is.
5. **An odd council size, 900 x 600.** Stormwater Pit: no state, but 600x900 rotated 90 is the same pit. PIT BLOCK 3: X 900, Y 600. A truly odd size (750 x 450, 1050 x 1050) is impossible in PIT BLOCK 3 today (750 and 1050 are not in its list) and in Stormwater Pit except 750 x 750. **Neither; PIT BLOCK 3 becomes the only good answer once its list becomes a 50 mm step (edit 3).**
6. **Plastic 300 diameter pit.** Neither block has one. Today the office draws the 350 grated state with "PP" text beside it, and nothing in the block says plastic (E-009). PIT BLOCK 3 cannot go below 350 square. **Neither; add a "Plastic pit" state (edit 5).**
7. **Pump well.** Stormwater Pit: "SPS Vertical" is fixed at 1800 diameter. PIT BLOCK 3: the diameter is free (typed as a radius, which is an odd way to think about a well) and the lid size is set. **PIT BLOCK 3 better.**
8. **Safety by hand overall.** Stormwater Pit cannot make a wrong combination, but cannot make anything new. PIT BLOCK 3 can make anything in its list, but shows six distance boxes with programmer names, and changing X_WIDTH while on the detention state changes nothing you can see, which is confusing. The old plug-in had exactly this trouble (its bug "SPS SOLID PIT must apply X/Y" in `PitDynamicPropertyTests`).

## C. For the plug-in: driving it and reading it back

1. **Reading the kind and size after anyone has edited it by hand.**
   1. **Stormwater Pit:** the size and kind are words inside a state name. The plug-in needs a line per state (inner size, wall, kind), the spelling must match exactly, and a state renamed in somebody's copy of the block becomes unknown. A 600x900 tells the plug-in nothing about which way is which except through the block's rotation.
   2. **PIT BLOCK 3:** the kind is one of five words; the size is two numbers that are the INNER size of the pit. Whatever a person does with grips or Properties, the numbers read back true. **Much better.**
2. **Setting it.** Setting a visibility state is one word that must match exactly. Setting a stretch is a number. Autodesk's own reference says that setting a value that is not in a list or range "succeeds and no error is returned" but nothing changes (verified in the ObjectARX reference, `AcDbDynBlockReferenceProperty::setValue`). So the plug-in must always read the value back after setting it and say so if it did not take. This applies to both blocks, but bites PIT BLOCK 3 harder while its list holds only five sizes.
3. **The allowed sizes.** The plug-in can ask the block for its list of allowed values, but only for a LIST; for an increment or a min/max range Autodesk returns nothing (verified, `getAllowedValues`). That is fine: the plug-in keeps the office sizes in its own list (`pit_sizes.csv`, D-135) and the block only has to accept them.
4. **Which distances apply in the current state.** The API has "visible in current visibility state" for each property (verified, AutoCAD 2027 `DynamicBlockReferenceProperty.VisibleInCurrentVisibilityState`). PIT BLOCK 3 already lists its parameters per state, so the plug-in can tell that the detention distances apply only to the detention state.
5. **A mirrored or scaled pit.** The distances are in the block's own units, so a pit scaled by 2 still says 350 while it is drawn 700. Both blocks allow non-uniform scaling today ("Scale uniformly" is off in both). The plug-in must treat any scale other than 1 (or -1 for a mirror) as "size not known" and say so. A mirrored orifice pit swaps which chamber is on which side; the plug-in reads that from the negative scale.
6. **The anonymous block copy (*U).** Any pit that differs from the block's default draws itself through an anonymous block. The plug-in must read the real name through the reference's "dynamic block definition" (verified, `BlockReference.DynamicBlockTableRecord`), never the name of the block it points at. Autodesk says that anonymous copy may be shared and must not be edited directly (verified). Same for both blocks.
7. **The reference's own dictionaries.** Every dynamic block reference keeps AutoCAD's own data in its extension dictionary. That is what tripped CEPIT3 and CEPIT5 at midday (a dictionary where a plain record was expected). The fix in `BUILD_LOG.md` entry 30 (touch only the plug-in's own `CE_` entries) works for either block.
8. **RESETBLOCK.** Puts the pit back to the block's default (verified, `resetBlock`): for PIT BLOCK 3 that is a 350 x 350 grated pit. The plug-in's self-check should notice the block no longer matches the size it noted. Same risk for both blocks.
9. **ATTSYNC.** Neither block has attributes, so it does nothing to them. (One more reason not to add attributes: see E, "leave alone".)
10. **Exploding.** Either block turns into loose lines and the plug-in can no longer tell it is a pit. Converting to a plain block freezes it at its current look (verified, `convertToStaticBlock`). Same for both.
11. **Where the inner wall is, so a pipe stops on it (D-102).**
   1. **PIT BLOCK 3:** inner wall = centre plus or minus half of X and half of Y, turned by the block's rotation. Read straight from the block. No wall thickness needed, because the pipe stops at the inner line.
   2. **Stormwater Pit:** only from a data line per state (the Pit tool's drafts already say "the wall's place for each state is not in any data list").
   3. **Both:** the visible inner line is a mask frame, so it depends on the drawing's wipeout frame setting (the office drawings have it on: `SHEET_SETUP.md` item 116). A real inner line (edit 1) removes that dependence.
12. **A new size or kind later (the foundation's test).**
   1. **New size, Stormwater Pit:** a new state, 3 to 6 new objects drawn in the Block Editor, the block redefined in every drawing, and a new data line. Fails the test.
   2. **New size, PIT BLOCK 3:** today, one value added to the list in the Block Editor plus one data line. With a 50 mm step (edit 3): nothing in the block, one data line. Passes.
   3. **New kind, either block:** a new visibility state with its own look. For PIT BLOCK 3 that is one state for every size; for Stormwater Pit one state per size. A truly new shape always needs drawing once; that is fair.

## D. Recommendation

1. **Use PIT BLOCK 3 with changes, saved under a new name**, for every new pit the plug-in places.
2. **Why:** its size is two plain numbers that read back true after any hand edit, it is all ByLayer, and a new size is a data line, not a redrawn block.
3. **Its gaps are small and fixable by you in under an hour:** a real inner wall line, plain names, a 50 mm step, and states for plastic and bought-in units.
4. **Keep reading Stormwater Pit** on old drawings through a 16-line list of its state names; never write it on new pits.
5. **Settle the names before the plug-in uses them,** because after that the names are the contract between the block and the plug-in.

## E. What Tim could change in the block to make it better

Most valuable first. "Old drawings" means pits already placed: PIT BLOCK 3 is not on any of the three jobs read (E-011), but the old plug-in placed it on colleagues' drawings by these exact names. So do every edit on a copy and **save it under a new name with BSAVEAS (for example "PIT BLOCK 4")**: then no old drawing changes at all.

1. **Draw a real inner wall line.**
   1. **The edit:** in the Block Editor, draw a closed polyline exactly on the 350 x 350 mask, on layer STORMWATER PIT, ByLayer, drawn on top of the mask. Add it to the four main stretch actions' selection sets (pick the action, right-click, Action Selection Set, Modify Selection Set; window-select the corners the same way the mask is). Make it visible in the grated, solid and pump states. Do the same for the two orifice chambers (with their own stretch actions). For the pump well, move the inner circle from PITS HIDDEN to STORMWATER PIT so the well shows a solid inner and dashed outer like a pit (D-039).
   2. **Why it helps you:** the inner wall prints whatever the wipeout frame setting is in that drawing or in a colleague's drawing. Today, with frames off, a pit is a hatch with no edge.
   3. **Why it helps the plug-in:** D-102 and D-039 ask for a solid inner line; this makes it a real object that plots with no plug-in (D-015), and the plug-in can check it against the numbers.
   4. **Work:** about 15 minutes. **Old drawings:** none if saved as a new name.
2. **Give everything plain names.**
   1. **The edit:** visibility label "GRATED_OR_SOLID" becomes **"Kind"**. States: GRATED PIT (keep), SOLID PIT becomes **JUNCTION PIT**, DETENTION PIT becomes **ORIFICE PIT** (D-104's word; "detention pit" means something else since D-105, any pit you tick for storage), SPS GRATED PIT and SPS SOLID PIT become **PUMP PIT GRATED** and **PUMP PIT SOLID**. Distances: X_WIDTH becomes **"Length"** (along the sheet), Y_WIDTH becomes **"Width"** (up the sheet), the orifice ones become **"Chamber 1 length"**, **"Chamber 2 length"** and **"Chamber width"** (chamber 1 = the solid one). Rename the label in Properties (Property Labels, Distance name); the action names do not show to users and can stay.
   2. **Why it helps you:** Properties reads in drafting words, and nobody wonders which "WIDTH" is which.
   3. **Why it helps the plug-in:** it finds each property by its name; plain names make the data list readable by you and stop a mix-up like the old SPS bug.
   4. **Work:** about 10 minutes. **Old drawings:** none if saved as a new name. Do this once, before the plug-in uses the names; do not rename again after.
3. **Change the five-size list to a 50 mm step.**
   1. **The edit:** for Length, Width and the three orifice distances, Value Set: Dist type **Increment**, increment 50, minimum 300, maximum 2400.
   2. **Why it helps you:** the grips still snap and show tick marks, but 750, 1050 or 1650 now work; every office size (350, 450, 600, 900, 1200) is a multiple of 50.
   3. **Why it helps the plug-in:** any office size from `pit_sizes.csv` simply works, so a new size is one data line and nothing in the block. A council size never "silently does not take".
   4. **What you lose:** the drop-down of five sizes in Properties (you type instead). Edit 4 gives the drop-down back.
   5. **Work:** about 5 minutes. **Old drawings:** none if saved as a new name.
4. **Add a "Size" lookup with a Custom row (optional, for hand speed).**
   1. **The edit:** a lookup parameter "Size" and lookup action, input properties Length and Width, rows "350 x 350", "450 x 450", "600 x 600", "600 x 900", "900 x 600", "900 x 900", "1200 x 900", and tick "Allow reverse lookup" so a typed or dragged size shows "Custom" (how reverse lookup shows "Custom" is from memory; check it in the trial).
   2. **Why it helps you:** one pick sets both sizes, like the old block, and odd sizes still work.
   3. **Why it helps the plug-in:** little; it reads Length and Width, not the lookup. A new standard size means one more row here as well as the data line, so only add it if you will use it by hand.
   4. **Work:** about 15 minutes. **Old drawings:** none if saved as a new name.
5. **Add a PLASTIC PIT state.**
   1. **The edit:** a new visibility state showing the same objects as GRATED PIT (new state, "show the same objects"). With edit 3 it can be set to 300 x 300. If you want round plastic pits as well, a second state using a small circle with its own diameter distance.
   2. **Why it helps you:** no loose "PP" text needed to know what it is (the cover text can still say PP).
   3. **Why it helps the plug-in:** today nothing in the block says plastic (E-009); the plug-in could only guess from text beside it.
   4. **Work:** 5 minutes (square), about 15 (round). **Old drawings:** none.
6. **Make the pump well a diameter, not a radius.**
   1. **The edit:** redraw the SPS distance across the full circle (centre to centre through the middle), base location Midpoint, label **"Diameter"**, re-attach the scale action to it.
   2. **Why it helps you and the plug-in:** wells are specified by diameter; the schedule and the plug-in both talk in diameters.
   3. **Work:** about 5 minutes. **Old drawings:** none if saved as a new name.
7. **Tick "Scale uniformly"** (Block Editor, nothing selected, Properties, Block section).
   1. **Why it helps you:** nobody can squash a pit with a non-uniform scale and make the size boxes lie.
   2. **Why it helps the plug-in:** a pit's numbers then match what is drawn unless someone uniformly scales it, which the plug-in flags.
   3. **Work:** 1 minute. **Old drawings:** none. Mirroring still works (from memory).
8. **Bought-in units as states** (only when the plug-in reaches them; D-104 lists them for day one).
   1. **The edit:** copy the Enviss Sentinel, Settling Tank and SPS Horizontal geometry from Stormwater Pit into new states, with no stretch attached (they are fixed products).
   2. **Why:** one pit block for everything; a new product is one new state.
   3. **Work:** about 10 minutes each.
9. **Wall thickness as its own setting (low value; do only if you want big pits to look like today's sheets).**
   1. **The edit:** a "Wall" distance with a list of 100 and 150 and stretch actions that move only the dashed outer square.
   2. **Why it helps you:** 900 pits get the 150 walls the old block drew; today PIT BLOCK 3 draws 100 at every size.
   3. **Why it barely helps the plug-in:** the pipe stops at the inner wall, which it already knows from Length and Width.
   4. **Work:** about 20 minutes, fiddly. **Old drawings:** none.
10. **Orifice pit with both lids solid (optional).** A council asked for "class C solid covers on both orifice pit chambers". A second state, ORIFICE PIT SOLID, showing the cross on both chambers. About 5 minutes.

**Leave these alone (they would not help):**

1. **Attributes for the pit number or cover level.** Today the tag is its own block (a number in a masked circle) and the cover level is its own masked text at plus or minus 45 degrees; D-181 says both move with the pit and keep a hand-moved offset, and the plug-in does that. Inside the pit block: the circle mask could not move with the attribute, a turned pit would turn its tag, ATTSYNC and RESETBLOCK would put hand-moved labels back to where the block says (from memory), and old jobs would have two ways of tagging a pit. The only gain (a no-plug-in move carries the labels) is not worth that.
2. **Annotative.** A pit is a real-size object drawn 1:1 in model space (D-194). Annotative would be wrong.
3. **A base point parameter.** The origin is already the centre and the size grows about the centre. Adding one changes nothing useful.
4. **A rotation or flip parameter.** Use the block's own rotation (JOB_A pits turned to 147, 207, 209 degrees) and Length/Width for a turned rectangle. MIRROR does the orifice pit.
5. **The grate hatch.** It stretches with the pit; leave it.
6. **ByLayer.** Already clean in PIT BLOCK 3. Keep it that way.
7. **"Allow exploding".** Leave it on (nothing restricts users unless really serious); the plug-in says when a pit has been exploded.
8. **The block's name.** It is one data line in the plug-in. Only the BSAVEAS name matters.
9. **Nothing in the block needs the plug-in to look right,** and none of the edits above changes that.

## F. A 10-minute trial on a COPY

1. **Get a copy:** start a new drawing from the office template (or any blank mm drawing). Copy one PIT BLOCK 3 from the master into it (Ctrl+C / Ctrl+V, or Design Center). Do not save anything back into the master or the template.
2. **Open it:** BEDIT, pick PIT BLOCK 3, then **BSAVEAS "PIT BLOCK TRIAL"** straight away, so you are only editing the trial copy.
3. **Edit 3 and part of edit 2:** pick the X_WIDTH parameter. In Properties: Distance name "Length"; Value Set, Dist type Increment, increment 50, minimum 300, maximum 2400. Do the same for Y_WIDTH as "Width".
4. **Edit 1:** RECTANG from -175,-175 to 175,175 on layer STORMWATER PIT. Add it to the four stretch actions Stretch_NORTH, _SOUTH, _EAST, _WEST (Action Selection Set, Modify Selection Set; window the corner each action already windows). In the visibility states, show it in GRATED PIT and SOLID PIT, hide it in the detention state.
5. **Close and insert:** BCLOSE, save changes, INSERT PIT BLOCK TRIAL in model space on layer STORMWATER.
6. **What good looks like:**
   1. Properties shows **Length** and **Width**. Type 750: the pit becomes 750 long, the hatch fills it, the dashed outer square stays 100 outside, and the insertion point stays in the middle.
   2. Type 760: it snaps to 750 or 800, not to some other size.
   3. Drag the corner grip: tick marks every 50 mm.
   4. Type WIPEOUTFRAME, set 0 (this trial drawing only): the solid inner wall line is still there. PLOT preview: it prints. Set it back to 1.
   5. Switch to SOLID PIT: the cross and the inner line both fit the 750.
7. **If any of that does not happen, tell me which step.** Throw the trial drawing away afterwards.

## G. What I could not read or verify

1. **Nothing was seen in AutoCAD.** Every behaviour on screen is read from the stored block data or from Autodesk's reference, not watched.
2. **From memory, not proven here:** that a typed or dragged size not in a list snaps to the nearest list value; whether Properties hides the distances that do not belong to the current state; how reverse lookup shows "Custom"; that ATTSYNC and RESETBLOCK reset attribute positions; that MIRROR still works with "Scale uniformly" ticked; that the wipeout frame setting is saved in each drawing; that redefining a block keeps existing pits' values when names are unchanged.
3. **Verified against Autodesk's files:** setting a value outside a list or range returns no error and changes nothing; "allowed values" come back only for a list; "visible in current visibility state"; the dynamic block definition and anonymous block properties; RESETBLOCK; converting to a plain block (AutoCAD 2027 decompiled .NET wrappers in `C:\Tools\AcadDecomp\2027\acdbmgd` and the ObjectARX reference in `C:\Tools\ArxDocs\arxref`).
4. **The stretch arithmetic** (that the main pit grows equally about its centre) is read from the "Midpoint" base location and the action multipliers, not watched.
5. **Which state Stormwater Pit falls back to on RESETBLOCK** was not worked out.
6. **PIT BLOCK 2 is not in the master;** it was read only from the old plug-in's file.
7. **ACadSharp** read all three DWG copies and their parameters in memory, but drops the dynamic block data when it writes DXF, so the fine geometry of the DWG copies was compared through the master DXF and the parameter lists, not object by object.
8. **Whether PIT BLOCK 3 sits on colleagues' drawings made with the old plug-in** is likely (the old plug-in drove it by these names) but was not checked; hence the advice to save under a new name.
