# Questions for Tim before the colleague pack is final

**Desk, Thu 22 Oct 2026.** Pages 01 to 05 in this folder are DRAFTS for Max on Mon 9 Nov 2026. These questions are the ones only Tim can answer. Each has a recommendation, and the drafts already use it, so nothing waits on him (INT-073). Before writing these, the desk checked START_HERE, the release area file, the decisions of 17 and 20 Oct 2026, QUESTIONS_FOR_MONDAY and the release reference pages of 7 to 9 Oct 2026, so none of these is already answered there.

---

## A. Install day

1. **Who installs on Max's PC, and when on 9 Nov?** The install is by hand, with AutoCAD closed, about 5 minutes (your ruling of 20 Oct: "yes" to the deploy chat's route). Someone has to be at Max's PC.
   - **Recommend:** you, at 8:40 on Mon 9 Nov, following page 02 with the desk on the line.
   - **On the day:** about 10 minutes of Max's morning. The desk cannot reach his PC remotely.
2. **Is Max on AutoCAD 2027?** The plan says so (INT-069), but nobody has looked.
   - **Recommend:** Max types `ABOUT` and sends you the year this week.
   - **If not:** AutoCAD 2022 to 2024 have never been driven in AutoCAD with this build, so the pilot would be blind.
3. **Max's old CE Structural (July 1.0.41): leave it, switch it off, or remove it?** Structural is not part of this release.
   - **Recommend:** leave it installed but use Enable/Disable on Restart in CEMANAGER to switch it off, so nothing old runs next to the new Civil.
   - **On a job:** Max would not have the old Structural commands until Structural ships.
4. **An old Manager in Max's all-users plugin folder (ProgramData)** would load first and can hide the ribbon. Removing it needs administrator rights.
   - **Recommend:** you or IT check Max's PC the week before. You parked Manager administrator work on 20 Oct, so the desk will not do it without your word.
5. **Where does the frozen release copy sit?** Putting it in the shared IT Admin folder is publishing.
   - **Recommend:** a separate `CE V3 PILOT` folder, so the July copies other colleagues use stay untouched. This needs your yes.
6. **The old install scripts and builds in the IT Admin folder** (BUG-483): move them to an OLD folder?
   - **Recommend:** yes, before 9 Nov, so nobody runs a July script over Max's new install.

## B. What Max is allowed to do

7. **Real jobs or copies only, and for how long?**
   - **Recommend:** copies only for the first week (page 01 says so). Then real jobs once Codex has passed the frozen build and you have had 5 working days with no new bug.
8. **CDDESIGN, CDRUNSOLVE and CDTWL during the pilot.** The 22 Oct engineering review found that storage can come out about 18 per cent short, that concrete pipes are sized as UPVC, and that CDTWL miscounts on metre drawings.
   - **Recommend:** tell Max to use them for drafting only, never for an issued number, until the fixes and your rulings land (page 04, items 7 to 16).
9. **Tools switched OFF in the shipped set-up.** These are the Checks list, CDCHECKIGNORE, wrong-layer rows, Tidy labels and its extras, and the double-click edit windows.
   - **Recommend:** keep each OFF for Max until Codex passes it. Then it turns on for you and Max together (your Q4 rule).
   - **Note:** the Checks list and Tidy labels are listed as [CHECK] on page 01 because their switch state on your PC has not been read for this pack.
10. **F2 runs CLEAN in a CE drawing.** You chose to keep it ("commonly used by me to save").
    - **Recommend:** keep it, and tell Max plainly on page 04 (done).
    - **Alternative:** a Settings switch that turns it off for colleagues. This would be a new plan item.

## C. Support and feedback

11. **Can Max write to the CE Plugin Pilot Results folder?** You said yes on 8 Oct, but the desk cannot set SharePoint sharing, and nobody has confirmed it works.
    - **Recommend:** share it with Max ("can edit") this week. Page 05 points there.
12. **Reply time.** How quickly should Max expect an answer to a report?
    - **Recommend:** the same working day for anything that stops him, and the weekly Monday session for the rest.
13. **Practice drawing for the first 10 minutes** (page 01, section 4). No sample drawing ships with CE, and a real job is client data, so you pick it.
    - **Recommend:** a blank office template, so there is no client data and you only need to name the template.

## D. Engineering calls that change what page 04 tells Max

These are already on the Monday list (22 Oct, late). They are repeated here only because the pack wording depends on them.

14. **Rainfall curve note:** change "reads high" to "may be high or low, by up to about 8 per cent". Recommend yes.
15. **Cover:** add the pipe wall from a Settings table. Recommend yes.
16. **Pit drop:** warn when the outlet's pipe top sits above the inlet's. Recommend yes.
17. **Minimum grade table:** 375 at 1 in 300 but 450 and larger at 1 in 200. Is that right?
18. **Inspector versus CDRULES:** when they disagree, which one should Max trust?
    - **Recommend:** CDRULES (council first), with the Inspector made to match.

## E. The pack itself

19. **Format:** are these pages fine as they are, or should the desk turn 01 and 05 into a printed one-pager each, with the screenshots?
    - **Recommend:** a printed 01 and 05 beside Max's monitor. 02 is for the person installing.
20. **Screenshots:** page 02 has [SCREENSHOT] placeholders.
    - **Recommend:** Codex takes them on a test copy on your PC after the freeze (about Mon 2 Nov), during one of the free AutoCAD windows.

## Desk readings recorded (no answer needed unless Tim disagrees)

1. **Which build Max gets:** the frozen release build that is also on your PC, with your working switches as his starting values. This follows your 24 Sep rule ("whatever version youve installed for me") and ruling B4 (colleagues get only builds marked as a release). The build marked as the release is the one on your PC at the freeze.
2. **Manager updates:** none for Max until you approve the update route (ruling F2). Updates are by hand, as on page 02.
