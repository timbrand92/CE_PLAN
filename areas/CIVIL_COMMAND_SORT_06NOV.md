# Civil commands sorted: keep, fold in or hide (Fri 6 Nov 2026)

**STATUS: PROPOSAL for Tim to change.** Every Civil command at the installed build (3.0.90), sorted by the steps from the voice talk. Nothing is built, moved or deleted. Replaces the Civil part of `CORE_TICK_LIST_05NOV.md`.

**The three words:**
1. **KEEP:** a button on the ribbon.
2. **FOLD IN:** becomes part of Check this drawing. Until that is built and proven, the old command stays as it is.
3. **HIDE:** no button. It can still be typed, and nothing is deleted.

---

# FOR TIM

**Of 145 commands, 47 keep a button, 34 more fold into Check this drawing, and 64 have no button.** Change anything that looks wrong. The 11 questions at the bottom are the ones I can't sort without you.

Evidence is thin. It comes from each tool's description, your ribbon clicks (typed commands aren't counted) and the overnight check. No colleague's use is known.

---

## CE Drainage tab, left to right

**1. Pits (6)**
1. **PIT:** place a pit.
2. **PP:** quick 350 x 350 plastic pit.
3. **CDLPD:** legal point of discharge. This is the start point.
4. **CDEDIT:** edit the pit or pipe you pick. Your most used button. It serves pits and pipes.
5. **CDPITCOVERFLIP:** move cover text to another corner.
6. **CDRENUMBER:** renumber pits from the outlet up. Currently no button.

**2. Downpipes and tanks (11)**
1. **DP:** downpipe.
2. **IO:** inspection opening.
3. **OF:** overflow.
4. **FO:** front overflow. Open fault: the symbol reads "OF" (BUG-1236).
5. **GIO:** gross inlet.
6. **CDFW:** floor waste. Open fault: cancelling clears stored pit inverts (BUG-650). Fix before it goes in.
7. **CDTG:** trench grate.
8. **CDRG:** raingarden.
9. **CDWT:** water tank.
10. **CDSOURCE:** generic source.
11. **CDTAG:** tag or retag a source.

**3. Pipes (11)**
1. **CD:** draw a pipe.
2. **CDREVERSEFLOW:** turn a pipe around.
3. **CDTIDYLABELS:** slide labels clear of other text.
4. **CDANNOTATIONEDIT:** move one label or arrow.
5. **CDMA:** move a flow arrow.
6. **CDTEXTSEG:** move pipe text to another segment.
7. **CDSL:** spot level.
8. **MR:** move and rotate. First tool on trial: doesn't work on all objects yet.
9. **CR:** copy and rotate. Same note.
10. **CDSTRIP:** strip drain. Tim, 7 Nov: used on normal jobs. Placed with pipes by Claude, not yet confirmed by Tim.
11. **CDAGI:** AGI drain. Same note.

**4. Check this drawing (2)**
1. **Check this drawing:** new, not built. Until then this button opens CDCHECKCURRENT, which is read only.
2. **CDINSPECTOR:** shows what you've selected. The "click a pit, see what it's linked to" work would go here.

**5. Schedules (2)**
1. **PITSCHEDULE:** Excel export fails in 2027 (BUG-1255) and plastic pits drop out silently (BUG-1274). Both need fixing first.
2. **CDPROFILE:** long section.

**Everyday help, end of the tab (6)**
1. **CDHELP:** help.
2. **CDS:** your preferences.
3. **CDFEEDBACK:** report a problem. Help promises a send step that doesn't exist (BUG-1215).
4. **CEBLOCKS:** office blocks palette.
5. **CDMANAGER:** layer colours and draw order.
6. **CDNEWDWG:** new job drawing. Currently typed only.

## CE Design tab (9)

1. **CDDESIGN:** design inputs.
2. **CDCALC:** drainage calculations.
3. **CDRAINFALL:** the job's rainfall curve.
4. **CDTWL:** top water level.
5. **CDRUNSOLVE:** solve inverts down a run.
6. **CDDEST:** where each downpipe ends up.
7. **CDRULES:** check against the engineering rulebook.
8. **CDRULEBOOK:** rulebook settings for the job.
9. **CDSYSTEM:** put pipes in a system.

---

## FOLD IN to Check this drawing (35, including CDCHECKCURRENT, which holds the button until then)

**Checks that only read (14)**
1. **CDCHECKCURRENT, CDCHECK, CDCHECKS, CDCHECKIGNORE, CDCHECKIGNOREAPPLY:** the check lists.
2. **CDAUDIT, CDAUDITDETAIL, CDGRAPH, CDDIAG:** audits and counts. CDGRAPH and CDDIAG run the sync today.
3. **CDHUB, CDDASHBOARD:** the Civil Hub and design-check dashboard. CDDASHBOARD runs the sync today.
4. **CDIMPORTAUDIT, CDTRENCHGRATEAUDIT, CDCONFIRM:** a further audit each, and confirming a pipe end.

**Repairs that write (21)**
1. **CDREPAIR:** becomes the door itself.
2. **CDSYNC, CDREBUILD, CDREBUILDLINKS, CDLINKDANGLINGPIPES:** the record and link family.
3. **CDUPGRADE (Merge), CDC7UPGRADE, CDSPINEUPGRADE:** bringing a drawing up to date. Replace stays separate, below.
4. **CDFIXTAGS, CDFIXFLATPIPES, CDFIXPIPEENDS:** each becomes a row in the list.
5. **CDPROPAGATE:** pushes inverts along.
6. **CDPIPEOVERRIDE, CDPIPEOVERRIDECLEAR, PIPEPITLINK, PIPEPITUNLINK, LINKPIPEPIT, CLEARPIPEPITLINK:** linking a pipe end by hand.
7. **CDLPDRESET:** moving the start point.
8. **PITDELETE, CDBREAK:** delete a pit with its labels; record a branch joining a main. These two are borderline, see question 11.

---

## HIDE (64)

**Kept separate because of risk (6): typed only, for careful use**
1. **CDREFRESHBLOCKS:** redefines every pit symbol.
2. **CDRECOVERINVERTS:** creates invert text. You've checked this by hand.
3. **CDXREFREPAIR, CDXREFCOMPARE:** Xref work, a different subject.
4. **CDREFRESHLINKS:** tidy after MIRROR.
5. **CDLEGACYAUDIT:** about the PC, not the drawing.

**Site and surface work (15): occasional, Tim 7 Nov**
1. **Slabs:** CDSLAB, CDSLABIMPORT, CDSLABEDIT, CDSLABEREGEN, CDSLABFLOW, CDJOINT, CDCJ, CDSC. CDSLABEDIT is marked unsafe in its own description.
2. **Surface:** CDPAVE, CDKERB, CDSPOON, CDSPOONDRAIN, CDFALL, CDFALLSUGGEST.
3. **Other drains:** CDPERIMETER.

**Import and export (6): question 2**
1. CDSURVEY, CDIMPORTXCIVIL, CDIMPORTLANDXML, CDIMPORTCOMPARE, CDEXPORTENTITIES, CDCHECKDWG. Import has open faults (BUG-602 to 605, BUG-417).

**Other tools (8)**
1. **CDCATCHMENT:** catchment overlay.
2. **CDSRZ, CDTPZ:** tree zones.
3. **CDPARTS:** parts catalogue.
4. **CDPIPEOBJ:** draw a pipe as one object.
5. **CDDISCIPLINE:** set a drawing as Civil or Structural.
6. **CESTARTHERE:** picture tour.
7. **CDSOURCECHANGETYPE:** refuses until built.

**Other names for the same tool (17): typed only**
1. **Pit sizes:** CDPIT350, CDPIT450, CDPIT600, CDPIT900, CDPIT1200.
2. **Old names:** PIPEEDIT, PITEDIT, TG, MOVEROT, COPYROT, CDSETUP, CDLABELSTYLE, CDASK, CEASK, CDMENU, COPYMULTI.
3. **Find:** CEFIND, typed only for now.

**For us, not for drafters (12)**
1. CDDEBUG, CDFOCUS, CDTRIAGE, CDSTARTUPAUDIT, CDEXPORTCORPUS, CDGRIPDIAG, CDGRIPROUTE, CEPERFDIAG, CE_TEST_RUN, CDPIPEATTACHMENTACTION, CDUSEPLANLABEL, CDCLOSETAB.

---

## Questions only you can answer

1. **Slabs, kerbs, spoon drains, strip and AGI drains:** ANSWERED 7 Nov. Tim: "strip and agis yes the rest occasionally". CDSTRIP and CDAGI get buttons; the rest stay typed only.
2. **Survey and import:** ANSWERED 7 Nov. Tim: "surveys are always loaded in as an xref". Read as: AutoCAD's own Xref attach does this job, so no Load Survey button, and the import tools stay typed only.
3. **New job drawing:** does it belong at the left end of the tab, before pits? It's the nearest thing to a front door.
4. **Spot levels (CDSL):** pipes, or with pits?
5. **Long section (CDPROFILE):** schedules, or CE Design?
6. **Downpipe destinations (CDDEST):** CE Design, or with downpipes and tanks?
7. **CDRENUMBER and CDEDIT:** pits is where I've put them. Is that where you look?
8. **Structural:** the talk named two tabs, both Civil. Does Structural stay a third tab for now?
9. **Pit sizes:** do you use the preset sizes by typing them?
10. **CDCHECKDWG (consultant drawing check):** used on real jobs?
11. **PITDELETE and CDBREAK:** normal drafting tools, or repairs?

---

## Worth knowing

1. **Moving buttons is simple.** The Civil ribbon is one hand-written layout, so a tool comes off the ribbon by leaving it out of that layout. It still needs a card and a build.
2. **Hiding doesn't stop typing.** A colleague can still type a hidden command. So this cuts what people see, not what they can reach.
3. **Check this drawing folds 35 commands, but they're not all the same job.** The 14 that only read are the easy part. The 21 that write carry the risk.
