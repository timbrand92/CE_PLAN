# Structural commands sorted: keep, later or hide (Thu 12 Nov 2026)

**STATUS: PROPOSAL for Tim to change.** Every Structural command in the installed build (1.0.126, commit 8de95c34, 375 entries in the command list), sorted in the order you draft: roof, upper floors, walls and ground, footings last. Nothing is built, moved or deleted. Replaces the Structural part of `CORE_TICK_LIST_05NOV.md`. Feeds card TRUST-S1 and `areas\trust-plan-structural.md`.

**The three words:**
1. **KEEP:** a button on the Structural core tab from day one.
2. **LATER:** no button for now. A candidate to join one at a time, after its own three days on your real jobs.
3. **HIDE:** no button on the colleague tab. It can still be typed, and nothing is deleted.

---

# FOR TIM

**Of 375 entries, 32 keep a button, about 75 are LATER, and the rest are typed only (most of those are duplicate names, hatch and text codes, line styles and fault-finding tools).** Change anything that looks wrong. The 10 questions at the bottom are the ones only you can answer.

Evidence is thin. It comes from your command log on real jobs (59 days from 3 Jun: DS 211, BEAM 211, BB 134, DS1 93, AB 93, C1 60, then a tail), each tool's description, and the 6 Nov audit. The log misses some commands, and no colleague's use is known.

---

## Structural core tab, left to right

**1. Roof (3)**
1. **R1:** rafter marks on RAFTERS. Open: bay sizes not reaching the block (BUG-584, fix installed, untested).
2. **P1:** purlin marks. Today it falls to the Annotate panel because its entry has no group.
3. **BT1:** roof bracing truss. Joins only once card S4 stops its trusses being added to wall totals (BUG-499).

**2. Floors (19)**
1. **1:** regular beam. The log calls the beam tools "BEAM"; which number is used most is not known.
2. **2:** lower beam.
3. **4:** special beam.
4. **5:** beam offset helper.
5. **BDL:** paired BEAM and BEAM LOWER lines.
6. **BSET:** pick a point inside the building so beam labels go the right way.
7. **BSETLIST:** list the stored inside points.
8. **BSETRESET:** clear the stored inside points.
9. **DS:** double stud marker. Card S3 first.
10. **DS1:** double stud with tag. Card S3 first.
11. **TS1:** triple stud with tag. Card S3 first.
12. **C1:** column marker. Card S3 first (size from the schedule ignores the floor, BUG-501).
13. **C2:** column type picker. Card S3 first.
14. **SDS:** change to double stud.
15. **SDS1:** change to tagged double stud.
16. **STS1:** change to tagged triple stud.
17. **SC1:** change to column marker.
18. **SC2:** change column type. Open on the switch tools: a neighbour's label can move (BUG-975).
19. **FJ1:** joist marks on JOISTS.

**3. Bracing (7)**
1. **AB:** A bracing.
2. **BB:** B bracing.
3. **ABS:** switch A and B. (ABSWITCH, STRUCABS are the same tool under other names.)
4. **CSBRACINGPANEL:** bracing required against provided. Card S4 first.
5. **STRSCHEDCREATE:** make the bracing, pier and tie-down schedules. Card S4 first (one row short, BUG-497).
6. **STRSCHEDREFRESH:** refresh a schedule. Card S4 first (erased braces stay, BUG-498). Marked expert today; the core list, not the expert mark, decides (card TRUST-S1 decision 6).
7. **STRSCHEDSYNC:** push schedule values back to the blocks.

**4. Tools (3)**
1. **CLEAN:** clean up and save. Card S2 first (its words disagree with what it does).
2. **CEHELP:** help.
3. **CESETTINGS:** Structural settings. Card S2 first for Reset Defaults.

---

## LATER (no button now; each joins one at a time)

**Roof**
1. **RJSET:** R1 and FJ1 settings (expert).
2. **CSROOFSETOUT, CSPOINTLOAD:** roof setout and roof point loads. Built and switched off; cards DRAFT.

**Floors and beams**
3. **XCLMTXT (and EXCELMTEXT):** read the member schedule from Excel. C1 and C2 take their sizes from it, so it may belong in the core: question 2.
4. **BEXTEND, BEXT:** extend a beam to a boundary.
5. **BTX:** turn beam text into the CE form.
6. **8:** beam settings (expert).
7. **SUPTEXTAUTO:** support tag placement.
8. **CE_MEMBERLABEL:** leadered member label.
9. **SBEAM, SBEAMEDIT:** steel and timber sections. Wait until the 5 Nov crash (BUG-1275) is reproduced on a copy and shown not to happen (a guard exists; the crash is not proven fixed) and the section list check (BUG-818, 819). CEMEMBER replaces them later.
10. **RCBEAM, RCRECTCOL, RCCIRCCOL:** concrete beam and column sections.
11. **CEMEMBER:** the SBEAM replacement. Typed only, no window yet.
12. **CSLEVELCARRY, CSPLANLEVEL, CSLINTELPROPOSE, CSLINTELTABLE, CSFRAMINGLEGEND, CSMEMBERSCHED, CSFLOORSETOUT:** roof-down plan tools. Built, mostly switched off; cards DRAFT.
13. **CSUNITCOPY, CSUNITTOOLS, CSUNITTAGS:** multi-unit jobs.

**Walls and ground**
14. **CSBRACINGREQUIRED:** set the required bracing per direction.
15. **ABFLIPAUTO:** turn A bracing labels the right way.
16. **CSTIEDOWN, CSTIEDOWNTYPES:** tie-downs (2 or 3 uses each in the log).
17. **CSWINDCLASS, CSSOILREPORT:** wind class and geotech report (2 or 3 uses each).
18. **LBW, CSLOADPATH:** load-bearing walls and the load path check.
19. **CSWALLMARK, CSWALLSCHEDULE:** wall marks and schedule (switched off).
20. **CSSUBFLOORGRID, CSTAGBEARERS, CSSUBFLOORSET:** timber subfloor.
21. **CSBSMTWALL, CSPUMPPIT, CSPUMPPITSCHEDULE:** basements.
22. **BATLINE, BATTER:** batter lines.

**Footings (last)**
23. **FST, FSTEXPORT:** the footing manager and footing schedule.
24. **FSF, FPFC, FTHC, RIB, REB:** footing and raft elements.
25. **FEDIT, FDELETE, FREGEN, FREGENALL, FADOPT, CSMARKSRENUMBER:** manage footings. Open: OOPS after erasing a footing line (BUG-300).
26. **BP, CSPIER, SPW, SPW3, SPW6, SPWC:** piers. Open: BP says nothing when the pier size is not on the block (BUG-536).
27. **SF, SFC, PFC, THC, STUMPFOOTING, SCREWPILE:** older footing shapes.
28. **CSFDNPROPOSE, CSFOOTINGSCHEDULE, CSFOOTINGLEGEND, CSRCBEAMSCHEDULE, CSINFILL:** footing proposals and schedules (some switched off).
29. **CSREOBAR, CSBARSCHEDULE, CE_REBARLINE, CE_REBARCIRCLE:** reo bars.

**Across all floors**
30. **AD, LD, Q, QD:** dimensions and leaders with office styles. Probably daily: question 1.
31. **CE_LEVELMARK, CE_LEVELUPDATE, FFL, CE_RL, CE_NGL, CE_SSL:** level marks. Probably daily: question 1.
32. **CE_SECTIONMARK:** section marks. Open: side pick gives the wrong bubble (BUG-630).
33. **BL:** break line.
34. **CEHATCH:** one hatch button instead of 38 preset buttons (your 25 Sep ruling UX-STRUC-07): question 6.
35. **FASTSAVE:** quick clean and save. Today hidden as a duplicate name of CLEAN, though it does less.
36. **CESHEETS, CEPROPS:** sheets, register and issue. Open: HIGH fault in Publish Issue (BUG-495).
37. **CEMARKUP family (11 commands):** engineer's markup review. Switched off.
38. **CECHECKLIST, CENOTES:** drawing checklist and shared notes.
39. **XRL, XRLFAST, CXREF, PXREF:** Xref layer tools.
40. **RC:** revision cloud.
41. **STRUCEXPORTPDF, STRUCEXPORTCSV, STRUCEXPORTBLOCKS, CEEXPORTNOTES:** exports.
42. **CEARCHREVIEW:** architect's drawing changed.
43. **CEPALETTE, CETOOLS:** command search and the tools palette.

---

## HIDE (typed only; nothing deleted)

1. **Duplicate names of a kept tool (about 30):** STRUCAB, STRUCBB, STRUCABS, ABSWITCH, TC1, TDS, TDS1, TTS1, CENTERLINE, CENTRELINE, CL, CLINE, FFLMARKER, FLMK, REBAR, RB, REBARLINE, RBL, SCAB, SCABBLE, COPYM, CEMCOPY, EXCELMTEXTNEW, BMT2TXT, BTXT2MT and others. They keep working when typed (your 25 Sep ruling: other names kept as typed shortcuts).
2. **The 56 text and tag codes** (18B to 25T, EBB, IBT, CL1, CR1, DSL, TSR, PFCL and the rest): stay typed, as ruled 25 Sep (UX-STRUC-04). The "one Tag tool" from that ruling is not built.
3. **The 38 hatch presets** (6DH to 253EH, 9DH to WH): typed; CEHATCH is the button (LATER line 34). CEHATCHCHANGE, CEHATCHAUDIT, CEHATCHGAP, CEHATCHBATCH typed.
4. **The 21 line style codes** (SL25C to SL70P, SLALL): typed.
5. **Legacy utilities:** CJ, CJSS, SSC, DIV, DIVX, CPB, LU, MTS, ML, CML, R2LTXT, SWELD, DSET, DSET1, DUP, CE_ARCDIM, CE_MLEADERLEFT, CE_MLEADERRIGHT, STRIPLAYERSMERGE, STRUCLINKTEXT, EXCELMAPFLOOR, EXCELMAPFLOORAREA, EXCELCAPTURESELECTION, EXCELCAPTUREAREA, XRLSILENT, XRLCONFIG, XRLINFO.
6. **Detail drawing commands already hidden:** the 12 steelwork details (STLCONN, PORTAL, TRUSS and the rest, marked "Phase 3"), LIGS, COLTIES, WALLREO, WALLSTRS, BSSLAB, CE_STIRRUP, CE_BARWEIGHT, CSGENNOTES, CSLEADERNOTE, CSBOXNOTES, CSSLABSTEP.
7. **Fault-finding and start-up tools:** CEADMIN, CEADMINSETTINGS, CERECOVERY, STRUCDEBUG, BEAMLINKDEBUG, BEAMLINKMIGRATE, CEDEBUG, JOBTIMERDEBUG, JOBTIMEREDIT, CEMARKUPBENCH, XCLMTXTINDEX, CSWAKE, CESTRUC, CE_STRUC_SUITE, CESTRUC_PALETTE_RESTORE, CETOOLSTOGGLE, CE_INSPECT, CESHEETSCLASSIC, CEMARKUPDWGEXPORT, CEAUTOSUPPORT and its three partners, and the two grip commands started by clicking a grip (CESTRUCGRIPEDIT, CSFOOTINGGRIPEDIT).
8. **MR, MOVEROT, CR, COPYROT:** these are the shared move-and-rotate tools, already kept off the Structural tab on purpose and reached from the CE Tools tab. **Verified:** `Services\CeStrucRibbonContributor.cs:53`.

---

## Questions only you can answer

1. **Daily tools the log does not show.** Recommended: add AD, LD, Q, QD and the level marks to the Tools panel if you use them most days. Example: a colleague dimensioning a beam span finds no dimension button and types DIMLINEAR, getting the wrong style. OPEN.
2. **XCLMTXT in the core.** Recommended: **yes, in Floors,** because C1 and C2 read their sizes from what it saves. Example: without it on the tab a colleague places C1 with no schedule and is asked for every size by hand. OPEN.
3. **Beam buttons.** Recommended: **one Beam button** with 1, 2, 4 and 5 inside, labelled in words (Beam, Lower beam, Special beam, Offset). Example: "4" means nothing to a new colleague. OPEN.
4. **BSETLIST and BSETRESET.** Recommended: inside the BSET button, not their own buttons. OPEN.
5. **Footings in the first colleague release.** Recommended: **none;** footings join last, one tool at a time. Example: a colleague would draft roof to ground with CE and footings by hand for the first weeks. OPEN.
6. **One hatch button.** Recommended: **CEHATCH on the Tools panel** as the one hatch button (your 25 Sep ruling). Example: the 38 preset codes still work when typed. OPEN.
7. **SBEAM before CEMEMBER.** Recommended: **typed only** until the 5 Nov crash is reproduced on a copy and shown not to happen. A guard is added; the crash itself is not proven fixed. OPEN.
8. **Tie-downs, wind class and soil report.** Recommended: **LATER,** each after its own three days. OPEN.
9. **CESHEETS (sheets and issue).** Recommended: **LATER** until its HIGH fault (BUG-495) is fixed. Example: Publish Issue is the step that goes to the builder. OPEN.
10. **Anything you use daily that is not in the core.** Write it in. OPEN.

---

## What this did not check

1. **Nothing was run.** The list is the installed command list and its descriptions, not the drawn ribbon.
2. **Command log counts** are carried from `CORE_TICK_LIST_05NOV.md`; the log was not re-read.
3. **Open faults** are carried from the 6 Nov audit and the carpark; only those named in `areas\trust-plan-structural.md` section 8 were checked in the code.
4. **The exact count of duplicate names** depends on which names AutoCAD hides as duplicates when it starts (about 15 by the code reader's count, not re-counted).
