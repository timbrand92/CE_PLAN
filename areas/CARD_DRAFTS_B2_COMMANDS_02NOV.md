# Card drafts: commands touched by the b2 train (C-79b2), cards still missing (Mon 2 Nov 2026, Melbourne)

Written by Sonnet (Team, read-only) on CE 00's order. Only this file was written. Nothing was built, tested, installed or opened in AutoCAD. The robot was not run. Tim's settings files were not read. Nothing here is approved.

The brief named the output file as `C:\CE_PLANreas\...` (a lost backslash). I wrote it to `C:\CE_PLAN\areas\` beside the other card drafts. CE 05: move it if you meant somewhere else.

---

## FOR TIM

1. **Answer: one new card is needed, and it is drafted below.** The b2 train (C-79b2) has 16 pull requests. 15 already have a card in the other 02 Nov card drafts. The one with no card is #1944 (BUG-296): the rescue of a pit's saved data after the drawing's record is rebuilt.
2. **What #1944 does on the drawing.** In a drawing set up in metres, a re-made pit could take the lid, remarks and levels of a different pit up to 200 m away. After the fix the search reaches 200 mm, as it always meant to. Millimetre drawings are unchanged. It is rare, and you only see it after pits are erased and re-made.
3. **What "b2" is.** Branch `rel-20261110a`, head d4ce878e, checked after a fresh fetch. b1 (`rel-20261108a`, cf059dcf) sits under it. Between b1 and b2 the changes are Civil only (Drainage code, its tests, the change log, and one version line). Manager and Structural are untouched.
4. **What is installed.** The brief says Civil 3.0.89 = commit 61fd6fbc. I did not read the installed DLL, I took that from the brief. None of the 16 b2 pull requests (and not b1's head either) is inside 61fd6fbc, so all of them are new since 3.0.89.
5. **One thing to check, CE 05.** The installer file on b2 says AppVersion **3.0.89**, where b1 says 3.0.90. So b2 does not yet carry its own version number. Whoever builds b2 needs to bump it, or the installed bundle will look like 3.0.89 again.
6. **Nothing for Tim to decide.** The one question on the new card is a recommendation, with the reason.
7. **Not proven, anywhere:** none of this has been opened in AutoCAD. b2 is not installed. No robot PASS, no Codex PASS, nothing accepted.
8. **What I read:** RULES.md, the b2 first-parent list, each PR head's ancestry against 61fd6fbc, the changed-file list, the BUG-296 change-log entry and code diff, and the headings and PR lines of the existing card drafts. **What I did not do:** read every PR's code in depth, run `gh` (it is not on this shell's path), build, test, or open AutoCAD.

---

## CARD 1 of 1: a re-made pit gets back only its own saved data (#1944, BUG-296)

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** Pit record rebuild (the quiet repair that runs when a drawing's drainage record is rebuilt, for example after pits were erased and re-made). A pit whose id and handle both changed gets its old lid, remarks, schedule tick and levels back from "a saved pit within 200 mm". In a metre drawing that "200 mm" was being read as 200 m, so a re-made pit could take the data of another pit up to 200 m away.
2. **Ribbon or trigger.** No button of its own. It runs inside the check that many commands start with (`PIT`, `PIPEEDIT`, `PITEDIT`, the Hub, Dashboard, Diagnostics, `CDLINK` and the Xcivil import all call it). So it appears the moment a drawing's record is found out of step. GUESS: the exact trigger moment is not shown in anything I read.
3. **Works today.** Saved pit data is put back by the pit's own id first, then its entity handle, and as a last resort by a saved pit within 200 drawing units. In a millimetre drawing that is 200 mm. In a metre drawing it is 200 m.
4. **What the train or PR changes.** PR #1944 (B-126, BUG-296, head e5bccf42), in C-79b2. The last-resort reach becomes 200 mm in the drawing's own units (0.2 in a metre drawing). Millimetre and unitless drawings stay exactly 200. Switch `linking.recoveryPositionMatchReadsDrawingUnits`, ON by default, read at each recovery. OFF gives the old 200 drawing units exactly.
5. **Suggested class: Modify.** A search reach changes size; nothing else moves. Suggestion only.
6. **Prompts and windows.** None. It is quiet. Not changed on purpose (the change log says so): the label-to-pit match that still uses a mixed figure (waits on BUG-321 and BUG-243), the Xcivil import (assumes millimetre drawings), and the items marked warning-only.
7. **Selection.** None.
8. **Preview.** None.
9. **Drawing output.** None new. The only effect is which saved pit's data goes back onto a re-made pit. **Xref, locked layer, REFEDIT:** the change log says no new write, command, regen, view or system variable, and nothing touches a layer, Xref or REFEDIT object. I read the diff: it only passes the drawing's units into the existing search. I did not run it.
10. **Cancel, Escape, Undo and Redo.** No new prompt, so nothing to cancel. The change log says "revert this commit" for undoing the change itself. Whether Undo after a rebuild puts the data back as it was is not looked at.
11. **Save and reopen.** The restored data is saved in the drawing's record as it is today. Nothing new is stored.
12. **Assets, data and Settings.** The switch above (settings file `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, not read). Files: `Rules/RecoveryPositionMatchRule.cs` (new), `Services/ProjectDataRecoveryGuardService.cs`, `Services/ProjectDataService.Recovery.cs`, `Services/ProjectDataService.cs`, `Models/UserSettings.cs`.
13. **Performance.** One number changes; the search is the same size of work.
14. **Discovery.** Nobody has to find it. If Tim wants a visible sign, there is none in this change.
15. **Example drawing and expected result.** A drawing set up in metres with two pits 5 m apart. Make the drawing's record rebuild with pit B erased and re-made in the same spot. Expected: B gets its own lid and remarks back (within 0.2 m) and does not take A's. With the switch OFF, B could take A's. In a millimetre drawing, expected result is identical with the switch ON or OFF. The change log says whether a pit 0.1 m away still gets its data: yes, in a unit test.
16. **Older family card.** Not found in the card drafts I searched. BUG-296 was left open by C-5 (#491) as "needs the drawing's units carried into the recovery path" and this finishes that list. It stays open: the change log says "Not marked FIXED".
17. **Tim's AutoCAD checklist.** (Not run by anyone. Best run by the robot or Codex first, on a copy.)
    1. Open a copy of a drawing with its units set to metres. Check with the command `UNITS`.
    2. Note the lid and remarks on two pits about 5 m apart. Open the Pit list and write them down.
    3. Erase one pit and make a new pit in the same place with `PIT`. Then run `CDLINK` (or any command that rebuilds the record).
    4. Open the new pit. Expected: it does not show the other pit's lid or remarks.
    5. Repeat in a millimetre drawing. Expected: nothing different from before.
    6. Set `linking.recoveryPositionMatchReadsDrawingUnits` to false in the settings file **before AutoCAD starts** and repeat step 3 in the metre drawing. Expected: the old behaviour.
18. **Questions only Tim can answer.**
    1. **Is the 200 mm reach itself right?** Context: the fix keeps the old 200 mm figure and only reads it in the right units. What I understand: nobody has re-examined whether 200 mm is the right reach. Recommendation: keep 200 mm. A pit re-made by a drafter in the same spot is normally within a few millimetres, and a wider reach risks the wrong pit again. On a job: a pit nudged 300 mm by hand before the rebuild would not get its remarks back, and would come up blank for you to refill. Not decided.
19. **NOT proven.** Built: yes (the finalizer reports net10 and net48 compile for the train, from the change log, not re-run by me). Tested: yes, 7 unit tests in `Bug296RecoveryPositionUnitsTests` (switch ON by default through two settings reads, typed OFF kept, a pit 5 m away does not take its neighbour's data in a metre drawing, a pit 0.1 m away still gets its data, millimetre drawings identical ON and OFF). Installed: no. Tim-accepted: no. Nobody has driven a real rebuild in AutoCAD.

---

## Skipped: already covered (15 pull requests)

Card files are in `C:\CE_PLAN\areas\`. For each one I confirmed the PR number appears in the file named and that its PR head is NOT inside 61fd6fbc (read with `git merge-base --is-ancestor`). I did not re-read every card's full text, only that the PR has a place in it (a card, or a card section).

1. **Pit Schedule, long section and the misc card** (`CARD_DRAFTS_LONGSECTION_MISC_02NOV.md`):
   1. #1938 (BUG-1193, long section follows a curved boundary)
   2. #1939 (BUG-765, ground line reads level texts on a survey layer only)
   3. #1937 (BUG-1155, SOURCE RECREATED wording; carried in b2 as a net difference only, its own branch is not merged)
   4. #1974 (the CDSL and CDTRENCHGRATEAUDIT wording)
2. **Cover and CDRULES** (`CARD_DRAFTS_COVER_RULES_02NOV.md`):
   1. #1897 (BUG-903, one cover figure), #1920 (BUG-903, cover measured to the pipe top), #1960 (BUG-80, one velocity table)
3. **Redesign Apply and CDDESIGN** (`CARD_DRAFTS_CDDESIGN_02NOV.md`):
   1. #1874 (BUG-1096, reuse boxes), #1954 (BUG-1108, reuse share minimum), #1956 (BUG-1156, a draft keeps unknown fields), #1965 (roof paved C)
4. **Edit Pipe and New Pipe** (`CARD_DRAFTS_EDIT_PIPE_02NOV.md`, `CARD_DRAFTS_NEW_PIPE_02NOV.md`):
   1. #1919 (grade mismatch warning; in both files), #1927 (recall last standard grade; New Pipe file), #1967 (BUG-1235, grade warning figures; Edit Pipe file)
5. **Labels** (`CARD_DRAFTS_LABELS_02NOV.md`):
   1. #1946 (BUG-321, label scale and units)
6. **CDCALC and CDWT** (`CARD_DRAFTS_CDCALC_CDWT_02NOV.md`): #1965 is also named here.

## Skipped: not a user-facing command

1. **The finalizer commits** (`d4ce878e`, `773d45db`, `c01788a7`, `2869183a`, `d35d30eb`, `2490fd60`): tests, a comment restored, byte-order marks restored, the change-log entry, and two layer-word list defaults documented so an audit test passes. No command changes. The two layer-word lists belong to #1939, already carded.
2. **The assembly merge commits** (the `Merge #...` lines): they only join the pull requests above.

## Things worth knowing

1. **Version line, again.** `Installer/PackageContents.xml` on b2 reads 3.0.89 (b1 reads 3.0.90). The first-parent list shows no "Version:" commit on top of b2. Nobody has told me b2's number. Whoever builds it should state which.
2. **The existing card files carry old branch wording.** Several name a branch that is no longer the latest (for example the LONGSECTION_MISC card says the five are "not on rel-20261102a"). That is a snapshot, not live truth.
3. **Manager and Structural.** No change at all between b1 and b2. The only non-Drainage file in the b2 difference is the installer's version line.
4. **FILL_WORKFLOW_CARDS_02NOV.md** lists all 16 b2 PRs under "cards: jobs 502 to 510". #1944 is in that list but I found no card for it in any card file. The card above fills that gap.
