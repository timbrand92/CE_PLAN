# Core tick list (Thu 5 Nov 2026): which tools colleagues keep

**Update 6 Nov:** the Civil part of this list is replaced by `CIVIL_COMMAND_SORT_06NOV.md`. Structural and Manager below still stand.

**For Tim to mark.** IN = on the ribbon from day one. LATER = hidden, not deleted, joins one at a time. Everything below is a suggestion until Tim marks it. Tim, 5 Nov: "civil is main priority".

**How to read a line:** "clicks" = ribbon clicks on Tim's PC, 7 Sep to 4 Nov. Typed commands are not counted, so a low number does not mean unused. Colleague use is unknown. Status comes from the 29 Oct everyday-tools report and the 2 Nov scoreboard, so it may be a few days old. Nothing was re-run in AutoCAD for this list.

---

## 1. Civil (first)

**Draw**
1. [ ] **PIT:** suggest IN. 9 clicks. Tim checked by hand.
2. [ ] **CD (pipes):** suggest IN. 14 clicks. Tim checked by hand.
3. [ ] **DP (downpipe):** suggest IN. 1 click. Checked by Tim, but a build was still owed on 29 Oct (D07).
4. [ ] **CDRG (raingarden):** suggest IN. 1 click. Same note (D07).
5. [ ] **OF and FO:** suggest IN. 1 click each. Disputed: Tim saw the FO symbol read "OF" (BUG-1236).
6. [ ] **CDSL (survey level):** suggest IN. 2 clicks. Part proven only (D26).

**Edit**
7. [ ] **CDEDIT:** suggest IN. 27 clicks, the most used.
8. [ ] **CDS:** suggest IN. 5 clicks.
9. [ ] **CDRECOVERINVERTS:** suggest IN. Tim checked by hand.
10. [ ] **CDRENUMBER:** suggest IN. Robot and Codex passed; not yet shown to Tim.
11. [ ] **MR and CR (move or copy, then rotate):** suggest LATER, as the first tool on trial. Tim: "so far cr/mr work but not on all objects". Known gaps: a raingarden in the selection stopped the command (BUG-1245); a copied downpipe did not get its own new tag (BUG-1246). Other objects not yet listed.

**Check and schedule**
12. [ ] **PITSCHEDULE:** suggest IN. 2 clicks. Order and Excel export checked by Tim; long schedules over two sheets not proven (D22).
13. [ ] **CDCHECKDWG:** suggest IN. 1 click. Checked by Tim; Codex saw a real fault earlier (D28).
14. [ ] **CDINSPECTOR:** suggest IN. 4 clicks. Not on the everyday list.
15. [ ] **CDSYNC and CDREBUILD:** suggest LATER. CDSYNC is disputed: Codex failed the "keeps the schedule" rerun on 2 Nov.

**Design (these give engineering answers, so they should earn their place)**
16. [ ] **CDWT (tanks):** suggest LATER. 3 clicks.
17. [ ] **CDTWL:** suggest LATER. 1 click.
18. [ ] **CDDEST:** suggest LATER. 3 clicks.
19. [ ] **CDDESIGN and CDCALC:** suggest LATER.

**Help**
20. [ ] **CDHELP:** suggest IN. 7 clicks.
21. [ ] **CDFEEDBACK:** suggest IN. 1 click. Colleagues need a way to report problems.

**Anything else (about 120 other Civil commands):** suggest LATER. Write in any you use daily.

---

## 2. Structural (after Civil)

Uses on real job drawings, from Tim's command log (from 3 Jun 2026). The log misses some commands.

1. [ ] **DS, DS1, TS1, C1, C2 (support blocks) and SDS, SDS1, STS1, SC1, SC2 (switch a support block):** suggest IN. DS 211, DS1 93, C1 60, C2 12, the rest under 10.
2. [ ] **BEAM and BSET, BSETLIST, BSETRESET:** suggest IN. BEAM 211.
3. [ ] **AB, BB, BT1, ABSWITCH (bracing):** suggest IN. BB 134, AB 93.
4. [ ] **R1, FJ1, P1 (rafter, joist, purlin):** suggest IN. Few uses.
5. [ ] **CLEAN:** suggest IN only at 1.0.126 or later, the version that saves again.
6. [ ] **SBEAM:** suggest LATER. AutoCAD crashed in it on Thu 5 Nov (BUG-1275, open).
7. [ ] **CSTIEDOWN, CSWINDCLASS, CSSOILREPORT:** suggest LATER. 2 or 3 uses each.

**Anything else (about 350 other Structural commands):** suggest LATER. Write in any you use daily, because this log is the weakest evidence on the page.

---

## 3. Manager

1. [ ] **Install and update, CE version check:** suggest IN.
2. [ ] **Everything else, including Roll Back Release:** suggest LATER. That button is not proven on a colleague PC (BUG-441, BUG-477).
