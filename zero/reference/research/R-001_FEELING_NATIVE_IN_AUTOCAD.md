# R-001 Feeling native in AutoCAD

**Made:** Mon 16 Nov 2026, for the zero plan. **Asked by:** D-044 ("COMMAND NAMES AND RIBBON FEELS SEPARATE AND IT DOESNT FEEL LIKE A GOOD EXTENSION OF AUTOCAD"), D-046, D-047, D-048, D-045.
**Picture version for Tim:** `..\..\pictures\new_plugin_native_feel.html`.
**Status:** research and recommendations. Nothing here is a decision. Nothing here says how the plugin is built; where a finding touches that, it is marked "to be proven" for Stage 4.

## How to read this note

1. **Every finding has a source line** (page title, address, product version or date if the page shows one) and **how sure** (high / medium / low).
2. **"Read on this PC"** means the fact was read from AutoCAD 2027's own files on the owner's PC (read only; AutoCAD was not started or touched). Those are the best evidence there is for AutoCAD 2027.
3. **"From memory, not checked"** marks anything I could not confirm on a page.
4. **Pages that refused to open** are listed in the closing section. Autodesk's forum and blog sites refused every request (error 403), so most user-opinion evidence is thin.
5. Most Autodesk help pages carry no date; the version in the address is given instead. Several are the AutoCAD LT or older-year copy of a page that is the same topic in full AutoCAD.

---

## A. How AutoCAD's own tools sit in the ribbon

1. **Tabs hold panels; panels hold buttons.** "Ribbon tabs do not contain any commands or controls; instead, they manage the display of ribbon panels on the ribbon."
   Source: About Customizing Ribbon Tabs, help.autodesk.com/cloudhelp/2018/ENU/AutoCAD-LT/files/GUID-E2EEEA2A-4449-49E6-94DE-F02F778A686F.htm (2018 copy). Sure: high.
2. **AutoCAD 2027's always-there tabs:** Home, Insert, Annotate, Parametric, View, Manage, Output, Add-ins, Collaborate (Express Tools and Featured Apps come from their own files). The Home tab's panels in that file are Draw, Modify, Annotation, Layers, Block, Properties, Groups and Clipboard (Utilities and View, which I remember on screen, were not confirmed in the file).
   Source: read on this PC, AutoCAD 2027's own menu file (acad.cuix, dated Feb 2026). Sure: high.
3. **Tabs that come and go ("contextual tabs").** "Ribbon contextual tab states control the display of ribbon tabs on the ribbon" when certain commands are active or when an object is selected. Autodesk's two examples: Hatch Selected shows the Hatch Editor tab; Block Editor Mode shows the Block Editor tabs.
   Source: About Customizing Ribbon Contextual Tab States, help.autodesk.com/cloudhelp/2018/ENU/AutoCAD-LT/files/GUID-46187AC0-F25B-4A19-8E95-1722D780596F.htm. Sure: high.
4. **The full list of what triggers a come-and-go tab in AutoCAD 2027: 35 triggers.** Two kinds. **"Something is selected":** a hatch (Hatch Editor), a table cell (Table Cell), an Xref (External Reference), a multileader (Multileader), an image, a PDF / DWF / DGN underlay, an associative array (Array), a section, a point cloud, a layout. **"A command is running":** hatch being made (Hatch Creation), text being edited (Text Editor), block editor open (Block Editor), editing a reference in place (Edit Reference), array being made (Array Creation).
   Source: read on this PC, acad.cuix ribbon section (35 tab selector rules). Sure: high.
5. **What is on Hatch Creation, and how it closes.** Six panels in work order: Boundaries, Pattern, Properties, Origin, Options, Close. The last panel is one button, Close Hatch Creation, which "Exits HATCH and closes the contextual tab"; Enter or Esc do the same. Hatch Editor (hatch selected) is the same layout.
   Source: Hatch Creation Ribbon Contextual Tab, help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-LT/files/GUID-CF9C88AB-CD49-44A4-8A85-C26F60B828DA.htm (2026). Sure: high.
6. **Selection tabs close by deselecting.** Civil 3D's help says it outright: "Contextual ribbon tabs are displayed automatically when you select an object or invoke an object-specific command" and "Most contextual tabs can be closed simply by deselecting the object."
   Source: About the Autodesk Civil 3D Ribbon, help.autodesk.com/cloudhelp/2024/ENG/Civil3D-UserGuide/files/GUID-CEC80555-4DB7-4841-B63A-1F1E0743F270.htm (2024). Sure: high.
7. **A come-and-go tab can be shown two ways:** as its own tab ("Full") or folded into the tab already showing ("Merged"). The help names the two choices but does not explain them further.
   Source: To Customize a Ribbon Contextual Tab State, help.autodesk.com/cloudhelp/2018/ENU/AutoCAD-LT/files/GUID-CCBA1348-8FC4-4094-A4FB-73A34D3063CD.htm. Sure: medium (what "Merged" looks like on screen was not seen).
8. **The user's own settings for these tabs:** OPTIONS, Selection tab, Contextual Tab States: "Retain Pickfirst Selections When Commands Are Invoked From a Contextual Tab" and "Object Selection Maximum for Contextual Tab Display".
   Source: Ribbon Contextual Tab State Options Dialog Box, help.autodesk.com/cloudhelp/2021/ENU/AutoCAD-LT/files/GUID-E0353176-0BDA-440B-B7DD-0AFD84A2D2F2.htm (2021). Sure: high. Whether a setting stops the tab jumping to the front: from memory, not checked.
9. **Can an add-on put its panel inside AutoCAD's own tab (Home, Annotate)?** On paper, yes: an add-on's menu file can carry a tab set to "Merge Tab Only: merges with the main file's tab that has the same alias", and "You can merge any number of ribbon tabs together as long as the aliases are the same." But Autodesk's only worked example is merging into the Add-ins tab. No Autodesk page was found showing an add-on panel merged into Home or Annotate, or saying what happens after the user changes workspace.
   Source: About Customizing Ribbon Tabs (as item 1). Sure: medium that it can be done; low that it stays put. **To be proven.**
10. **Can an add-on have its own come-and-go tab?** Yes. A 2011 article by an Autodesk engineer shows a tab that appears only when a chosen set of objects is selected. Two limits he states: it works "only at the tab level" (not for single panels or buttons), and the check must be quick because it runs at every selection. The office's present Civil plugin already shows three such tabs (pipe, pit, source) "as coded"; what the drafter sees on screen was not checked (TOOLS_TODAY T-050).
    Source: Displaying an AutoCAD ribbon tab contextually using .NET, Through the Interface, keanw.com/2011/10/displaying-an-autocad-ribbon-tab-contextually-using-net.html (7 Oct 2011). Sure: high that it can be done; the article is old, so how it is done in 2027 is **to be proven**.
11. **Autodesk's guidance on when to use a split button, a gallery or a slide-out:** not found. No Autodesk page was found that gives design rules for choosing between them. What exists is how to make each in the customising editor. See "Not found".

## B. How Civil 3D presents pipe networks

1. **Selecting a pipe or structure brings up a Pipe Networks tab**, and when two kinds of thing are selected together a "Multiple" tab appears. Civil 3D's come-and-go tabs end with a "Launch Pad" panel: commands "you might use next in your workflow".
   Source: About the Autodesk Civil 3D Ribbon (A.6). Sure: high for the behaviour; medium for the panel names on the pipe tab (Labels & Tables, General Tools, Modify, Network Tools, Analyze, Launch Pad are from memory and a 2021 training sheet, not from an Autodesk page I could open).
2. **Drawing pipes uses a small floating toolbar, Network Layout Tools,** with 12 controls: network properties, surface, alignment, parts list, structure list, pipe list, connection point choice, draw mode (pipes and structures / pipes only / structures only), upslope-downslope toggle, delete, the table view, undo. The current parts list, surface and alignment names show along the bottom.
   Source: Network Layout Tools, help.autodesk.com/cloudhelp/2024/ENG/Civil3D-UserGuide/files/GUID-7FF3AB4F-B75A-473F-939A-0E726E8C1FB6.htm (2024). Sure: high.
3. **Moving a structure carries the pipe ends.** "When you move a structure, all pipe ends connected to it move along with the structure." "Levels of the original pipe ends connected to the structure are typically maintained."
   Source: About Grip Editing Structures in Pipe Networks, help.autodesk.com/cloudhelp/2024/ENG/Civil3D-UserGuide/files/GUID-D533CDFB-4B7A-49F6-9423-F8744893E191.htm (2024). Sure: high.
4. **Moving a pipe does not carry the structure, and breaks the join** unless the end goes back where it was. Dragging a pipe end onto another structure joins it: "you can connect to it when a glyph appears next to the grip."
   Source: About Editing Pipe Networks Using Grips, help.autodesk.com/cloudhelp/2024/ENG/Civil3D-UserGuide/files/GUID-0B02D311-808D-49AC-8C61-84FAF9D6B54C.htm (2024). Sure: high. (This is the same behaviour the owner chose in D-031: connected, not merged.)
5. **Four grips on a pipe:** each end (move that end), the middle (move the whole pipe), a length grip (lengthen or shorten one end, direction held), and a size grip at the middle that shows the available sizes as lines to snap to with a tip showing the value.
   Source: as item 4. Sure: high.
6. **Parts come from a catalogue, cut down to a parts list per job,** and the parts list also carries each part's default look and rules, so "you don't have to search the full catalogue".
   Source: About the Part Catalog and Parts Lists for Pipe Networks, help.autodesk.com/cloudhelp/2027/ENU/Civil3D-UserGuide/files/GUID-2A52D123-516A-46A4-BFA4-DD56984BC21F.htm (2027). Sure: high.
7. **A pipe network can be edited in at least five different places:** grips, the layout toolbar, the Pipe / Structure Properties windows, the table view (Panorama), and the tree (Prospector), plus 14 separate tasks (swap part, rename, split, merge, reconnect, match levels and more).
   Source: Editing Pipe Networks, help.autodesk.com/cloudhelp/2024/ENG/Civil3D-UserGuide/files/GUID-7E2A7B7C-7455-4548-BA7E-D92540774C3F.htm (2024) for the 14 tasks; the five places are partly from memory. Sure: medium.
8. **What users praise and complain about (thin evidence).** Praise: networks tied to the ground surface and to long sections cut rework when levels change. Complaints: label defaults are spread over several places (a forum user had to be pointed to a settings window to change which label style "add labels" uses); each pipe type needs its own style set up first; joining a new network to an existing one is called "cumbersome"; a new engineer was told to borrow parts lists and label styles from other jobs or build them from scratch.
   Source: search-result extracts only, from forums.autodesk.com (thread "Add pipe network labels to entire network default styles"), a Civil 3D ideas board page and a 2024 engineering forum thread. The pages themselves refused to open. Sure: low. No source spoke for a small office doing house and unit drainage.

## C. Other well-made tools: things that stay connected and warn

1. **Annotation Monitor (AutoCAD's own).** When on, "it identifies the annotations that have lost associativity by displaying a badge". Clicking the badge opens a short menu for that one item (re-attach it, or erase it). It is switched from a button on the status bar.
   Source: To Work with the Annotation Monitor, help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-LT/files/GUID-DE2691C0-9E3D-4D6F-8FB5-1709AE4969FD.htm (2026). Sure: high.
2. **Associative arrays (AutoCAD's own).** One object made of many, still editable: "you can perform edits directly using grips, with grip menu options that appear when you hover over a grip", or from its own come-and-go tab. EXPLODE turns it back into separate plain objects.
   Source: About Arrays, help.autodesk.com/cloudhelp/2022/ENU/AutoCAD-LT/files/GUID-07CB282A-2C71-46FE-937F-BC3DFB2C068B.htm (2022). Sure: high.
3. **Dynamic blocks (AutoCAD's own).** Each kind of adjustment has its own grip kind (point, linear, rotation, flip, visibility, lookup list, alignment), and the grip's tip says what it will change. A flip grip flips; a lookup grip opens a short list.
   Source: About Grips on Dynamic Blocks, help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-LT/files/GUID-31E1AD7C-387A-46B5-BCFD-6DD2173747C3.htm (2026). Sure: high.
4. **AutoCAD Plant 3D pipe routing.** A "continuation grip" sits on every open pipe end and at branch points: click it to keep drawing from there. A "substitution grip" swaps a part for a compatible one from a small list. When a change cannot be resolved the join is flagged or left open.
   Source: Pipe Routing (topic list) help.autodesk.com/cloudhelp/2026/ENU/Plant3D-UserGuide/files/GUID-9D57F4A5-994F-4C40-BD9B-A03A9CDCBCBF.htm (2026), plus search extracts of "About the Continuation Grip" and "About Substituting Parts". Sure: medium (the two grip pages were read as extracts, not in full).
5. **A stormwater add-on or 12d output:** not studied. No page for a well-reviewed small-site stormwater add-on was found in the time. See "Not found".

## D. Properties palette, Quick Properties and the other places a tool can live

1. **An add-on can show its own facts in AutoCAD's Properties palette for an object.** Autodesk's developer guide calls these "dynamic properties": the palette "displays the dynamic properties along with the object's static properties". The add-on keeps the values: the mechanism "makes no assumptions about where your property data is stored."
   Source: Using IPropertyManager and IPropertyManager2, ObjectARX Developer's Guide, help.autodesk.com/cloudhelp/2018/ENU/OARX-DevGuide/files/GUID-00DB5C7C-4AB8-4A8B-849B-102F2F5E0916.htm (2018 copy); and Dynamic Property Interfaces, same guide, GUID-BF737441-866B-4A04-846F-EB354E0DEC4E. Sure: high that the mechanism exists and is official. Medium that it suits ordinary lines and blocks the way D-048 wants. Whether the facts can sit under a heading named "CE Pipe": from memory yes, not confirmed on a page. **How it is done in 2027: to be proven.**
2. **Quick Properties** is the small card by the cursor: it "displays a customizable subset of the properties displayed by the Properties palette". Which object kinds and which facts show is chosen in the customising editor, and it can be kept in step with the roll-over tip.
   Source: About Customizing Quick Properties, help.autodesk.com/cloudhelp/2018/ENU/AutoCAD-LT/files/GUID-24739CA8-6441-4614-825D-89737967D631.htm. Sure: high. Whether an add-on's own facts can be listed there: not stated on the page; **to be proven.**
3. **Double-click.** A double-click runs "a command that displays either the Quick Properties palette or a specialized editor". In AutoCAD 2027's own set there are 52 double-click actions: 33 open Quick Properties; 19 open a special editor (text, multiline text, dimension text, attribute, block, polyline, multiline, spline, image, Xref, section).
   Source: About Customizing Double Click Actions, help.autodesk.com/cloudhelp/2025/ENU/AutoCAD-Customization/files/GUID-9171FB64-3BA3-4945-8A50-42D0901A0C4C.htm (2025); counts read on this PC from acad.cuix. Sure: high.
4. **Right-click menus.** With objects selected the right-click menu is AutoCAD's Edit menu, and "Object shortcut menus are inserted into" it when one kind of object is selected: one set for a single object of that kind, another for several. While a command runs, "the command's options (keywords within the square brackets) are inserted into this menu."
   Source: About Creating Shortcut Menus, help.autodesk.com/cloudhelp/2018/ENU/AutoCAD-LT/files/GUID-8AE6163C-BBB0-4862-96F1-EB49923E317D.htm. Sure: high.
5. **Grips with their own menu.** Lines, polylines, arcs, splines, hatches, dimensions and multileaders have "multi-functional grips that offer object-specific and, in some cases, grip-specific options". When several selected objects share a grip the special options are not offered.
   Source: About Editing with Grips, help.autodesk.com/cloudhelp/2015/ENU/AutoCAD-Core/files/GUID-01DE459C-21A7-4E92-A1D6-E2C36CD89F0C.htm (2015 copy). Sure: high. That the menu appears when the cursor rests on the grip, and that Ctrl steps through the options: confirmed for arrays (C.2); for other objects from memory.
6. **Roll-over tips** show chosen facts when the cursor rests on an object, per object kind, set in the same editor as Quick Properties.
   Source: search extract of About Rollover Tooltips, help.autodesk.com/cloudhelp/2023/ENU/AutoCAD-Customization/files/GUID-B9D65044-094E-45CC-80AA-319CCBF0B522.htm. Sure: medium (extract only).
7. **The command line helps find names.** AutoComplete fills in the name as you type; mid-string search finds names that contain the letters; AutoCorrect learns your mistypes; a synonym list (91 lines in 2027) lets a plain word find a command, in the form SYMBOL = BLOCK.
   Source: To Work With the Command Line Suggestion List, help.autodesk.com/cloudhelp/2027/ENU/AutoCAD-LT/files/GUID-74478DCE-92D4-49B1-93E9-DCF09D57FA0D.htm (2027); synonym count read on this PC. Sure: high.
8. **Tool Palettes, dynamic input at the cursor:** not researched beyond what is in TOOLS_TODAY (the office palettes hold dragged blocks only). See "Not found".

## E. AutoCAD's built-in short names (aliases), and clashes

1. **Where they live.** AutoCAD 2027's standard alias file (acad.pgp) defines 417 aliases; 385 without the dash forms; **241 are one to four letters.**
   Source: read on this PC, C:\Program Files\Autodesk\AutoCAD 2027\UserDataCache\en-us\Support\acad.pgp ("Program Parameters File For Autodesk AutoCAD 2027", Copyright 2026 Autodesk, file dated Feb 2026). Sure: high. Autodesk's web list (autodesk.com/shortcuts/autocad) refused to open, so the file itself is the source.
2. **An add-on's command name beats an alias.** AutoCAD looks a typed name up in this order: built-in commands; then names "defined by AutoLISP, ObjectARX, and Managed .NET applications"; then system variables; and only then "a command alias, AutoCorrect name, or synonym". So if the plugin defines IO, typing IO runs the plugin's tool and AutoCAD's own IO is silently lost on that PC. A plugin cannot take a built-in command's full name.
   Source: About File Organization (Command Search Procedure), help.autodesk.com/cloudhelp/2025/ENU/AutoCAD-Customization/files/GUID-25616676-EFF2-4060-A06F-19112622A78B.htm (2025). Sure: high.
3. **Today's office names that sit on an AutoCAD alias (8 of the 278 typed names in TOOLS_TODAY):** C = CIRCLE; IO = INSERTOBJ; RC = RENDERCROP; CH = PROPERTIES; CL = CENTERLINE; DIV = DIVIDE; SL = SLICE; TP = TOOLPALETTES. Three of them are in the Release 1 and 2 list: **C, IO, RC.**
   Source: the alias file (item 1) checked against TOOLS_TODAY.md. Sure: high.
4. **Clear of every AutoCAD alias:** PIT, PP, CD, DP, OF, FO, GIO, MR, CR, Q, QD, LD, AD, CJ, SSC. None of the office names is one of the command names found in AutoCAD's own menus either (613 command names checked).
   Source: as item 1, and acad.cuix on this PC. Sure: high for aliases; medium for full command names (the menu file does not hold every AutoCAD command; each new name should be typed once in AutoCAD 2027 before it is promised: **to be proven**).
5. **The owner's PC carries an old hand-made alias file on top.** Its own acad.pgp (1.8 kB, changed 4 Nov 2026) is not Autodesk's: it has C = Copy, Ci = Circle, Pp = Pedit, Q = mltim, Div = Divide, Ds = movedim and about 50 more, some pointing at commands of the bought-in toolkit. So on this PC the standard aliases are not what answers. Colleagues' PCs may differ again.
   Source: read on this PC, %APPDATA%\Autodesk\AutoCAD 2027\R26.0\enu\Support\acad.pgp. Sure: high for this PC; unknown for others.
6. **Candidate new names checked and clear:** FW, TG, WT, LPD, AG, SD, RL, FALL, CE, PSC, TL, ISS, CB, CS (also clear: CA, RN, LEV, STO, CK, SCH, TWL, JOB).
7. **Candidates rejected because AutoCAD owns them:** PS = PSPACE (so pit schedule cannot be PS); RA = REDRAWALL; AR = ARRAY; ST = STYLE; SP = SPELL; TB = TABLE; LS = LIST; CHK = CHECKSTANDARDS; REN = RENAME; RP = RENDERPRESETS; DS = DSETTINGS.
8. **Every one- to four-letter alias in AutoCAD 2027's standard file (241), for checking any later name:**

   1. **3:** 3A = 3DARRAY; 3AL = 3DALIGN; 3DO = 3DORBIT; 3DP = 3DPRINT; 3DW = 3DWALK; 3F = 3DFACE; 3M = 3DMOVE; 3P = 3DPOLY; 3R = 3DROTATE; 3S = 3DSCALE.
   2. **A:** A = ARC; AA = AREA; AAD = DBCONNECT; AC = BACTION; ADC = ADCENTER; AEX = DBCONNECT; AL = ALIGN; ALI = DBCONNECT; AP = APPLOAD; AR = ARRAY; ARM = ACTUSERMESSAGE; ARO = DBCONNECT; ARR = ACTRECORD; ARS = ACTSTOP; ARU = ACTUSERINPUT; ASE = DBCONNECT; ASQ = DBCONNECT; ATE = ATTEDIT; ATI = ATTIPEDIT; ATT = ATTDEF; ATTE = -ATTEDIT; AV = DSVIEWER.
   3. **B:** B = BLOCK; BC = BCLOSE; BE = BEDIT; BH = HATCH; BMOD = BLOCK; BO = BOUNDARY; BR = BREAK; BS = BSAVE; BVS = BVSTATE.
   4. **C:** C = CIRCLE; CAM = CAMERA; CBAR = CONSTRAINTBAR; CH = PROPERTIES; CHA = CHAMFER; CHK = CHECKSTANDARDS; CL = CENTERLINE; CLI = COMMANDLINE; CM = CENTERMARK; CO = COPY; COL = COLOR; CP = COPY; CT = CTABLESTYLE; CUBE = NAVVCUBE; CYL = CYLINDER.
   5. **D:** D = DIMSTYLE; DAL = DIMALIGNED; DAN = DIMANGULAR; DAR = DIMARC; DBA = DIMBASELINE; DBC = DBCONNECT; DC = ADCENTER; DCE = DIMCENTER; DCO = DIMCONTINUE; DCON = DIMCONSTRAINT; DDA = DIMDISASSOCIATE; DDI = DIMDIAMETER; DDIM = DIMSTYLE; DED = DIMEDIT; DI = DIST; DIV = DIVIDE; DJL = DIMJOGLINE; DJO = DIMJOGGED; DL = DATALINK; DLI = DIMLINEAR; DLU = DATALINKUPDATE; DO = DONUT; DOR = DIMORDINATE; DOV = DIMOVERRIDE; DR = DRAWORDER; DRA = DIMRADIUS; DRE = DIMREASSOCIATE; DRM = DRAWINGRECOVERY; DS = DSETTINGS; DST = DIMSTYLE; DT = TEXT; DV = DVIEW; DX = DATAEXTRACTION.
   6. **E:** E = ERASE; ED = TEXTEDIT; EDWF = EXPORTDWF; EL = ELLIPSE; EPDF = EXPORTPDF; ER = EXTERNALREFERENCES; EX = EXTEND; EXIT = QUIT; EXP = EXPORT; EXT = EXTRUDE.
   7. **F:** F = FILLET; FI = FILTER; FOG = RENDERENVIRONMENT.
   8. **G:** G = GROUP; GCON = GEOMCONSTRAINT; GD = GRADIENT; GEO = GEOGRAPHICLOCATION; GR = DDGRIPS.
   9. **H:** H = HATCH; HB = HATCHTOBACK; HE = HATCHEDIT; HI = HIDE.
   10. **I:** I = INSERT; IAD = IMAGEADJUST; IAT = IMAGEATTACH; ICL = IMAGECLIP; IM = IMAGE; IMP = IMPORT; IN = INTERSECT; INF = INTERFERE; IO = INSERTOBJ.
   11. **J:** J = JOIN; JOG = DIMJOGGED.
   12. **L:** L = LINE; LA = LAYER; LAS = LAYERSTATE; LE = QLEADER; LEAD = LEADER; LEN = LENGTHEN; LESS = MESHSMOOTHLESS; LI = LIST; LMAN = LAYERSTATE; LO = -LAYOUT; LS = LIST; LT = LINETYPE; LTS = LTSCALE; LW = LWEIGHT.
   13. **M:** M = MOVE; MA = MATCHPROP; MAT = MATBROWSEROPEN; ME = MEASURE; MEA = MEASUREGEOM; MI = MIRROR; ML = MLINE; MLA = MLEADERALIGN; MLC = MLEADERCOLLECT; MLD = MLEADER; MLE = MLEADEREDIT; MLS = MLEADERSTYLE; MO = PROPERTIES; MORE = MESHSMOOTHMORE; MS = MSPACE; MSM = MARKUP; MT = MTEXT; MV = MVIEW.
   14. **O:** O = OFFSET; OP = OPTIONS; OS = OSNAP.
   15. **P:** P = PAN; P2D = PUSHTODOCSOPEN; P2F = PUSHTOFORMAOPEN; PA = PASTESPEC; PAR = PARAMETERS; PE = PEDIT; PL = PLINE; PO = POINT; POFF = HIDEPALETTES; POL = POLYGON; PON = SHOWPALETTES; PR = PROPERTIES; PRE = PREVIEW; PS = PSPACE; PU = PURGE; PYR = PYRAMID.
   16. **Q:** QC = QUICKCALC; QCUI = QUICKCUI; QP = QUICKPROPERTIES; QVD = QVDRAWING; QVDC = QVDRAWINGCLOSE; QVL = QVLAYOUT; QVLC = QVLAYOUTCLOSE.
   17. **R:** R = REDRAW; RA = REDRAWALL; RC = RENDERCROP; RE = REGEN; REA = REGENALL; REC = RECTANG; REG = REGION; REN = RENAME; REV = REVOLVE; RMAT = MATBROWSEROPEN; RO = ROTATE; RP = RENDERPRESETS; RPR = RPREF; RR = RENDER; RW = RENDERWINDOW.
   18. **S:** S = STRETCH; SC = SCALE; SCR = SCRIPT; SE = DSETTINGS; SEC = SECTION; SET = SETVAR; SHA = SHADEMODE; SL = SLICE; SN = SNAP; SO = SOLID; SP = SPELL; SPE = SPLINEDIT; SPL = SPLINE; SSM = SHEETSET; ST = STYLE; STA = STANDARDS; SU = SUBTRACT.
   19. **T:** T = MTEXT; TA = TEXTALIGN; TB = TABLE; TH = THICKNESS; TI = TILEMODE; TM = TILEMODE; TO = TOOLBAR; TOL = TOLERANCE; TOR = TORUS; TP = TOOLPALETTES; TR = TRIM; TS = TABLESTYLE.
   20. **U:** UC = UCSMAN; UN = UNITS; UNI = UNION.
   21. **V:** V = VIEW; VGO = VIEWGO; VP = VPOINT; VS = VSCURRENT; VSM = VISUALSTYLES.
   22. **W:** W = WBLOCK; WE = WEDGE.
   23. **X:** X = EXPLODE; XA = XATTACH; XB = XBIND; XC = XCLIP; XL = XLINE; XR = XREF.
   24. **Z:** Z = ZOOM.

## F. How AutoCAD itself tracks a drawing set, issues and time

1. **Sheet Set Manager** keeps one list of sheets for a job, with facts held once at job level or sheet level: a custom property is owned by the "Sheet Set" (the same on every sheet, such as a contract number) or by the "Sheet" (different on each, such as who drew it). These feed fields in the title block.
   Source: To Create Custom Properties for Sheet Sets and Sheets, help.autodesk.com/cloudhelp/2027/ENU/AutoCAD-LT/files/GUID-683DA7B0-5FE6-4EFB-AE8A-C80B0D3D0EBC.htm (2027). Sure: high.
2. **Sheet list table.** Right-click the set, Insert Sheet List Table; choose the columns. "If you add a sheet to a subset later on, you will be automatically prompted to update the sheet list table." It asks; it does not update by itself.
   Source: To Add a Sheet List Table, help.autodesk.com/cloudhelp/2027/ENU/AutoCAD-LT/files/GUID-AF75182F-F6B0-4AEC-BBC1-5B82483160CA.htm (2027). Sure: high.
3. **Sending a set out (eTransmit).** Right-click the set, a subset or one sheet, eTransmit. Saved "transmittal setups" hold the choices so they are not re-entered ("It is recommended that you create and save several transmittal setups"), and a note can be added that goes into the report file.
   Source: To Create a Transmittal Package from a Sheet Set, help.autodesk.com/cloudhelp/2027/ENU/AutoCAD-LT/files/GUID-21C65B7B-6E50-46D6-B218-54FF88C17944.htm (2027). Sure: high.
4. **AutoCAD has no built-in list of revisions or issues.** Nothing found in Sheet Set Manager records "Rev A sent to council on this date". Offices do it with custom properties or their own revision rows. Sure: medium (absence of a feature is hard to prove; no page describing one was found).
5. **Activity Insights (AutoCAD 2024 onward)** keeps a dated log per drawing of who did what: new drawing created, saved, saved to new name, shared, referenced, purged, audited, published to PDF or paper, and renames or copies made outside AutoCAD (shown as user Unknown). It logs even when its palette is closed. By default it writes to a folder on the one PC; a team must point everyone at one shared folder.
   Source: About Activity Insights, help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-Core/files/GUID-57A1B411-9F00-4318-9CA1-A6490571597D.htm (2026). Sure: high. (The page says its list of events is partial; "published" is from the 2024 command page, read as an extract.)
6. **The TIME command.** Each drawing carries Created, Last Updated and Total Editing Time. Total editing time "cannot be reset or stopped"; plotting time is not counted; a session closed without saving is not added. A second "elapsed timer" can be switched on, off and reset by the user.
   Source: TIME (Command), help.autodesk.com/cloudhelp/2018/ENU/AutoCAD-LT/files/GUID-990C8D36-CD20-48C0-A711-4F03B33C084C.htm (2018 copy). Sure: high.
7. **Total editing time over-counts.** It runs whenever the drawing is open, in use or not; Autodesk's Express Tool EDITTIME exists to pause the count after a set time with no activity.
   Source: search extracts of a forums.autodesk.com thread "Job Time Tracking" and of EDITTIME (Express Tool), help.autodesk.com/cloudhelp/2016/ENU/AutoCAD-Core/files/GUID-7C2311B0-808D-4605-BE73-0A1500EE28D8.htm. Sure: medium (extracts only).
8. **Drawing properties (DWGPROPS)** hold custom named facts per drawing that fields can show in a title block.
   Source: search extract of Custom Tab (Drawing Properties Dialog Box), help.autodesk.com/cloudhelp/2021/ENU/AutoCAD-LT/files/GUID-8FCDDD74-0FDC-4189-8407-9EC9D7D482C5.htm. Sure: medium (extract only).
9. **The office already records time somewhere:** the Structural program has "job time recording" (TOOLS_TODAY T-032). What it records and whether anyone reads it: unknown.

## G. Autodesk's guidance for add-on makers

1. **Ribbon.** For the Autodesk App Store: "Every plug-in or block library must add a panel to the Plug-Ins tab". "Single panel - add it to the Plug-Ins tab." "Multiple panels - create a dedicated tab named after your plug-in." (AutoCAD 2027's tab is spelled "Add-ins".)
   Source: AutoCAD publisher guidelines, aps.autodesk.com/app-store/publisher-center/autocad-and-autocad-vertical (names AutoCAD 2027; no date shown). Sure: high.
2. **Loading.** "Design your plug-in to load only when needed"; it must work "immediately after installation" with no hand copying.
   Source: as item 1. Sure: high.
3. **Command naming and button pictures:** the guideline page gives no rule for either. The 2011 engineer's article (A.10) says an add-on's file names must be prefixed with the maker's registered symbol; the same habit for command names is from memory, not checked. See "Not found".

---

## Borrow

1. **The tab that appears when you pick the thing, and goes when you let go** (Hatch Editor, Civil 3D's object tabs). Panels in work order, left to right.
2. **A last panel of "what you would do next"** (Civil 3D's Launch Pad): from a pipe, jump to its pit schedule row or its line on Checks.
3. **A pit carries its pipe ends; a pipe moved alone comes off** (Civil 3D grips). Already the owner's rule (D-031): it is also how Autodesk's own pipe tool behaves, so it will feel expected.
4. **A mark beside the grip when an end is about to join** (Civil 3D's glyph), and **a small badge on anything that has come loose, with its two fixes on a click** (Annotation Monitor). That is the amber "not joined" of the concept, done AutoCAD's way.
5. **A "+" grip on an open pipe end to keep drawing from there** (Plant 3D's continuation grip).
6. **A size grip that offers only the real sizes** (Civil 3D's resize grip snapping to the parts list sizes).
7. **Grip menus: rest on a grip, get that part's few actions** (arrays, polylines). Flip label side belongs here first, the ribbon second.
8. **One fact, owned at the right level, shown by fields** (Sheet Set: owned by the set or by the sheet). The job tracker's "stage", "issues" and "waiting on" should be owned by the job and read everywhere.
9. **A dated log written by itself** (Activity Insights) and **time counted by itself** (TIME), with the pause-when-idle idea of EDITTIME.
10. **Saved issue set-ups** (eTransmit transmittal setups): "for council approval" remembers what goes in the set.
11. **Facts in the Properties palette beside AutoCAD's own**, double-click opening Quick Properties or the one right editor (what AutoCAD does for 52 object kinds).
12. **Synonyms:** let "PIPE", "DOWNPIPE" and "SCHEDULE" find CD, DP and PSC in the command line's suggestion list, so the long plain word still works for a new starter.

## Avoid

1. **The same thing editable in five places** (Civil 3D: grips, toolbar, two properties windows, table view, tree). One place for one pit or pipe: Properties. One place for the whole job: the CE panel.
2. **Set-up before you can draw** (Civil 3D's parts lists, style sets and label defaults spread over several windows). The office standards come with the plugin; a drafter never builds a list first.
3. **A floating toolbar that must be opened to draw** (Network Layout Tools). The short typed name and the ribbon button start drawing at once; size and class sit in the command's own options.
4. **Stealing AutoCAD's short names silently.** A plugin name beats an alias without any warning. Three kept names already do (C, IO, RC); no new name may.
5. **A big always-on tab.** Autodesk's own tools keep the permanent tab for making things and show the editing tools only when the thing is picked.
6. **A log that lives on one PC** (Activity Insights' default folder). Job tracking must read one shared place.
7. **Counting every minute a drawing is open as work** (TIME's total). It over-counts lunch and overnight.
8. **Asking "update the table?"** (Sheet list table). Carry-through is automatic in this plugin (CONCEPT section 11, the automation ladder, rung 1).

## What this means for our design

1. **Ribbon: recommend Option B on the picture page.** A short permanent "CE Civil" tab for placing things and whole-job buttons, and Pit / Pipe / Inlet / Tank tabs that appear only while one is selected. It is Autodesk's own pattern (A.3 to A.6), it matches Autodesk's rule for add-ons with several panels (G.1), and a new kind of element later adds one come-and-go tab, not more always-on buttons (D-009).
2. **Option A (CE panels inside Home and Annotate) is "to be proven", not promised** (A.9). Even if it works, Home already has eight or more panels of AutoCAD's own.
3. **Each come-and-go tab is laid out in work order and ends with "Go to"** (Properties, its schedule row, its checks). No Close button is needed: deselecting closes it (A.6).
4. **Flip label side lives in three places that are all AutoCAD's own:** the label's grip menu, the right-click menu, the Pipe tab. One action, one name, three doors.
5. **Short names follow one pattern: the letters already written on the drawing or said in the office.** DP, IO, OF, FO, GIO and PP already do. New ones the same way: FW, TG, WT, LPD, AG, SD, RL, FALL; and for the job: CE (the panel), PSC (pit schedule), TL (tidy labels), ISS (issue), CB (criteria box), CS (computations sheet).
6. **Proposed list, Release 1 and 2: 32 names. 19 the hands know, 13 new.** Kept: PIT, PP, CD, DP, IO, GIO, OF, FO, TG, MR, CR, C, Q, QD, LD, AD, RC, CJ, SSC. New: FW, WT, LPD, AG, SD, RL, FALL, CE, PSC, TL, ISS, CB, CS. Old long names (PITSCHEDULE, CDFW, CDWT, CDLPD and the rest) keep working during changeover.
7. **Three kept names sit on an AutoCAD alias: C (CIRCLE), IO (INSERTOBJ), RC (RENDERCROP).** Recommend keeping them, because staff have typed them for years and the owner's own PC already maps C to Copy; but it is the owner's ruling, and a new starter from another office will expect C to draw a circle.
8. **No edit names.** Double-click a pit or pipe and its facts open in Properties / Quick Properties, as AutoCAD does for its own objects (D.3). PITEDIT, PIPEEDIT and CDEDIT keep working and open the same thing.
9. **Every button's tip shows the short name** in AutoCAD's way ("Pipe" with CD under it), so the ribbon teaches the typed name and the two stop feeling like separate systems.
10. **Add the plain words as synonyms** (D.7) so typing PIPE or SCHEDULE offers CD or PSC.
11. **One pit's or pipe's facts in Properties under "CE Pipe" / "CE Pit"** (D-048): feasible on paper (D.1); to be proven in Stage 4, including whether Quick Properties and the roll-over tip can show the same facts.
12. **Job tracking borrows AutoCAD's own habits:** facts owned once at job level; stage and issue list read from the drawing's revision rows and the Issue step; a dated log written by itself; time counted while the drawing is open and being worked, pausing when idle; all in one shared place. Four things need the owner's ruling: whether time is recorded automatically, who can see whose hours, where the hours allowance comes from, and whether "waiting on" items other than assumptions are typed in the Manager or in the drawing.
13. **Before any new name is promised, type it once in AutoCAD 2027** on a clean PC and on the owner's PC (E.4, E.5).

## Not found / not sure

1. **Autodesk design guidance on when to use a contextual tab versus a panel, a split button, a gallery or a slide-out:** not found. Only how-to pages exist. The recommendations above lean on what Autodesk's own tools do, not on a written rule.
2. **Autodesk rules for naming an add-on's commands and for button pictures:** not found on the publisher page.
3. **Whether an add-on panel merged into Home or Annotate survives a workspace change or an AutoCAD update:** not found. To be proven.
4. **What "Merged" display of a come-and-go tab looks like:** named in the help, not explained, not seen.
5. **Whether clicking a pipe should pull the Pipe tab to the front, and which setting governs that:** from memory there is a choice; not confirmed.
6. **Civil 3D's pipe tab panel names, Pipe Properties and Structure Properties window contents, Prospector:** not read on an Autodesk page (the ribbon overview page names only Launch Pad).
7. **What small-office drafters say about Civil 3D pipe networks:** forums.autodesk.com refused every page (403). Only search extracts were seen. Low confidence.
8. **A well-reviewed stormwater add-on, 12d's AutoCAD output, AutoCAD MEP:** not studied.
9. **Tool Palettes, dynamic input and parametric constraints:** not researched this round.
10. **Whether an add-on's facts can appear in Quick Properties and roll-over tips, and under a named heading in Properties:** not stated on the pages read.
11. **Whether every proposed short name is free of every AutoCAD command name:** checked against 417 aliases, 91 synonyms and 613 menu command names, not against the complete command list.
12. **Pages that refused to open (403):** autodesk.com/shortcuts/autocad; autodesk.com/blogs/autocad (object grips; sheet set custom properties); forums.autodesk.com (all threads).
13. **Not checked in AutoCAD:** nothing in this note was tried in AutoCAD. AutoCAD was not started.
