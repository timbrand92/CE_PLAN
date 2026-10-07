# Known limitations, Thursday 8 October 2026 (installed now: Civil 3.0.35, Manager 1.1.35, Structural 1.0.105)

**Answer first.** Nothing here is Tim-accepted. Codex has watched part of it work in real AutoCAD on test copies, up to its 8 Oct W20 run. W18 was on Civil 3.0.34 and Structural 1.0.104; W19 on Structural 1.0.105 (the U and REDO cases); W20 on Civil 3.0.35 (a short check). Manager 1.1.35 is installed (8 Oct 03:59) but no Codex pass has looked at it. The rest is built and unit-tested only. Never a real job yet.
**A ruling is not a fix.** Section 4 lists what Tim has ruled (INT-065 to INT-069). Unless a line says "built", it is NOT in the installed version.

---

## 1. Switched OFF in this version

1. **Level 3 engines.** The levels-proposal engine is off by default. Several Level 3 pieces (detention banner, new-level labels, profile schedule preview) are in the code with nothing calling them yet.
2. **Propose footings (CSFDNPROPOSE).** Hidden and off. It prints only "Propose footings is not switched on in this version. Nothing was proposed or drawn." Codex saw that on 8 Oct.
3. **The issue-preview window.** Not in these versions. Its engine stack is queued for the next Structural train.
4. **Auto-join of pipe ends and the CE bell.** Both off by default.
5. **Others.** Older queue entries (29 Sep) say more new tools ship off (CD cursor glow, Keep/Automatic grip drag, notes commands such as CSGENNOTES). Not re-confirmed.

## 2. What Codex has NOT yet proven in real AutoCAD

1. **Edit Pit free-number rename on a pit with pipes.** Seen on 3.0.34 (W18: label, schedule and pipe From all read 77); its own U is unproven.
2. **Machines page of the Admin Dashboard.** CE asked to make the PC the office administrator; Codex said No.
3. **Steep-pipe wording (CDFIXFLATPIPES).** No test drawing has had a pipe flattened the old way, so the steep line and the Yes/No question were never shown.
4. **The footing "resized in the drawing" millimetre sentence.** It prints after a grip or STRETCH resize, not after FEDIT. Not seen yet.
5. **REDO after switching drawing tabs.** It says "Nothing to redo". A known limit.
6. **Old metre-drawing grades.** CDRULES on a metre drawing printed no R-03 lines.
7. **Pit Schedule window pit numbers.** On 7 Oct (3.0.33) it accepted a bare "2" over P1 and lower-case "p1" with no warning (BUG-420). Civil 3.0.35 carries a fix (PR 766) that nobody has seen in AutoCAD. BUG-426 (open, MEDIUM): typing p1 after a typed 9 still leaves 9 in the cell. **W20 on 3.0.35:** a bare 2, p2 or P2 over P1 was refused; p1 and "P 1" stayed P1; the BUG-426 case was not reached.
8. **Edit Pipe window saving, whole CDRENUMBER, Recall Last, two-drawing text edits.** Not seen: the older-pipe question stopped Codex, CDRENUMBER defaults to No, the Recall Last button was not visible, and the double-click opened Edit Pit.
9. **STS1 on a real support block, eye check of ERASE and PIT undo.** Only the refusals and the undo lines were seen.
10. **CESUPPORT, CESETTINGS (Structural), BDL, beams 2, 4 and 5, Foundations re-link.** Not run by Codex.
11. **AutoCAD 2022 to 2024.** Built and unit-tested. Never opened.
12. **Double-clicking a pit's plan label (BUG-430, seen by Codex W20 on 3.0.35).** It opens AutoCAD's own attribute editor, not Edit Pit. **Colleagues: use PITEDIT to change a pit.** Also open: the override tick stays ticked on the pit-number cell after Stop overriding.
13. **Structural writes new default rows into your settings file at its first start after an upgrade (BUG-429, seen by Codex W19 on 1.0.105).** About 20 new rows were added and none of your own values changed. It is harmless: all the new features are off. Tim has ruled that CE will log one line saying so (INT-071 item 6); that line is not built.

## 3. What CE refuses by design

1. **Only two hard blocks, by Tim's rule.** Deleting the spine IDs, and pushing an update on a failed build. Everything else should warn and record.
2. **Locked layers, Xrefs and reference edits are never changed.** CE skips them and says so. It does not unlock.
3. **The 7 Oct source audit found places that do not follow this and are still open:** Civil Design stops on missing site inputs, survey intake can be blocked, slab boundary edits can be refused. Today a brace over 2700 mm is still cut to 2700 (Tim has ruled otherwise, section 4).
4. **Two places still unlock or re-layer today:** CDIMPORTXCIVIL (BUG-417) and the strip-footing layer tidy-up (SF, BSF, STRIPLAYERSMERGE). Tim has ruled on both (section 4); neither fix is installed.

## 4. Tim has ruled; NOT built unless a line says built

1. **UPVC speed authority = the CPAA Hydraulics Design Manual** (INT-068, "1. as recommended"). The figures it gives become PROPOSALS for Tim to tick "Confirmed". Until then 3 m/s stays the one unconfirmed value and Civil Design stays at 6, so the two screens can still disagree. The manual has been read (CPAA_VELOCITY_READ_2026-10-08.md, proposals only): it names no UPVC figure.
2. **Pit-outlet speed warning** (AS/NZS 3500.3 clause 5.4.11.2(d)): 1.5 m/s recommended, 2.0 m/s shall not exceed. Warning only, never a block, both figures as Settings rows. Not built.
3. **Detention (CE guide):** warn on a detention pipe flatter than 1 in 200 for pipes 225 mm and larger; show "orifice not required" at 12 L/s or less. Warnings only, both figures on Settings. Not built.
4. **Steep pipe held at 1 in 5** keeps the "steep, check it" line, not "Check by hand". Warn above 1 in 10, never block. The wording is in 3.0.34; Codex has not seen it. The values are still not on the Settings window.
5. **Wall pair gap 350 mm kept** (INT-066 B). **A brace over 2700 mm keeps its drawn length and warns** (INT-066 C). The brace change is not built.
6. **Pit numbers.** A free number typed in the Pit Schedule window waits as a pending override until Review, Update or Stop overriding (no change). **Pilot ground rule: colleagues renumber pits only in Edit Pit.** INT-069 says the window fix is installed in 3.0.35; it is not seen in AutoCAD (item 7 above), so the ground rule stays.
7. **Privacy.** Delete the old real-named Civil report files (Civil and Manager at start-up, as Structural already does). Scramble the names inside the Manager report. Keep PC names out of support-bundle file names. Not built.
8. **CDIMPORTXCIVIL on a locked layer: skip it and say so** (BUG-417; draft PR 765 waits for review). Not built.
9. **F2 is LEFT AS IS for now.** Tim: "leave as is for now, commonly used by me to save". In the setup Codex tested, F2 runs CE's CLEAN command (purge, restyle, regen) in a CE drawing, so colleagues must not press F2 expecting a save. BUG-411 stays open and nothing moves; the desk will check what F2 does for Tim before anyone changes it.
10. **Manager Roll Back Release:** PCs go back at their next AutoCAD start, with an "are you sure". Not built; BUG-425 records that today the button does nothing.
11. **Approving a Civil update also approves the matching Manager update.** Not built; BUG-425 records that today Civil can update without Manager.
12. **CESUPPORT never uploads by itself.** Drawing paths become job numbers. Not built (the code queues the bundle for upload today).
13. **Sheet sync skips sheets a colleague has open, and says which.** Not built.
14. **Unknown footing width asks, with the Settings value pre-filled** (today 300 mm; screw pile 150 mm). Not built.
15. **Flat pipe label (BUG-427): it reads FLAT with no grade figure** when both ends are typed the same (Option A, the later recommendation; Tim to confirm in one line). Built only as a draft; today the label still says 1 IN 100.
16. **Strip-footing layer tidy-up** stays and runs quietly if done properly (INT-065, draft PR 764, not in 1.0.104). **Same-day re-issue** replaces the earlier set. Neither is built.
17. **Five Structural framing cards (A to E) approved, roof first:** roof area setout, floor joist span arrow, framing legend, lintel/support proposals, level above and below (O)/(U). Approved to build; nothing built.

## 5. Still open, and acceptance

1. **Design cards (seven cards, 19 questions).** Tim: "send through to me". He answers them himself; not approved.
2. **Pilot colleague and results folder.** The pilot colleague is **Max** (Tim: "Max - IDK"; no surname given). Results go to the SharePoint folder **CE Plugin Pilot Results** in the Engineering library (https://residentialstructures.sharepoint.com/Engineering/CE%20Plugin%20Pilot%20Results), in a sub-folder named by the date, job numbers only. **OPEN: Tim still has to confirm that Max can write to the Engineering library.** It is not known to work.
3. **Nothing is Tim-accepted yet.** Each "Codex saw it work" means a test copy with evidence on file. Council values, design rules and sizing still need Tim's word.
4. **Pilot order (Tim's ruling).** Tim runs the Day 1 checklist himself on one real job copy before any colleague pilot. That has not happened.
