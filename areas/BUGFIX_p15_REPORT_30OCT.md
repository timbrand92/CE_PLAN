# BUGFIX p15 report: B-068 BUG-467 on the Structural line (Fri 30 Oct 2026, job p15)

## ANSWER FIRST

**No twin PR was opened, because the Structural line (origin/claude/rel-20261026s, head 204dfad2, Structural 1.0.125) already contains the BUG-467 fix.** Nothing to build. #1883 was not touched.

## FOR TIM

1. **What I found:** the same fix is already in the Structural build, from an earlier job called HUNT-S-02 (PR #879, merged). BT1, AB, BB and the R1 Point option already turn your clicked points from the current UCS to World, so in a UCS rotated 30 degrees the brace and rafter tag land on your click. FPFC and FSF are fixed there too.
2. **What a drafter sees differently from this job:** nothing. No code changed.
3. **The difference from #1883:** #1883 adds a Settings switch (Bracing.PickedPointsFollowUcs) so the old behaviour can be restored. The Structural line's fix has no switch (it is always on). I did not add a switch on top of a fix that already works, because that would be a second code path for the same behaviour (rule 1). Say so if you want the switch anyway.
4. **#1885 and #1886 (B-065):** both exist already as Structural twins, base claude/rel-20261026s, both open drafts. I did not repeat them.
5. **Still to check in AutoCAD (not proven by me):** type UCS, Z, 30. Run BT1, click two wall corners: the brace sits on the corners and the drag preview follows the cursor. Repeat with R1 (Point option) and FPFC. Then UCS, W and run BT1 once: same as before. This is the HUNT-S-02 checklist, not yet run in AutoCAD.
6. **Mistakes of my own:** I started a cherry-pick of #1883's commit before reading the Structural code, and it conflicted in every file; I aborted it and read the code instead. No harm done; the branch is unchanged.

---

## Technical detail

1. **Base:** worktree C:\ce-fx\p15, branch claude/bug-467-rotated-ucs-s1026 at 204dfad2 (no commits, not pushed). Cherry-pick of ebae176c (the #1883 commit) conflicted in all seven source files because the Structural line already carries the fix; aborted.
2. **Where the fix lives on rel-20261026s:**
   - Commands/BracingCommands.cs:279 (BT1, `ToWcs`), 587 and 600 (AB/BB first point), 746 (jig base point turned to UCS and answer back to World); the Wall path (S-32 finalizer, f79e17e6) hands World ends.
   - Services/BracingService.cs:1419 (BracingPointJig takes the UCS matrix for the preview line).
   - Commands/RafterJoistCommands.cs:1367 (R1 base point to UCS) and 1377 (R1 click to World).
   - Services/FoundationService.cs:1248 and helpers at 4830 and 4834 (FPFC centre and typed rotation; FSF two-point and bored pier).
   - Commits 2a395832 (HUNT-S-02) and f79e17e6. REGRESSION_LOG.md line 1507 has the entry.
3. **Existing test:** Modules/Structural.Tests/Services/HuntS02UcsTests.cs (source pins). I did not run it: nothing was changed, so no build or test was needed. No dotnet command was run in this job.
4. **Not proven:** that the fix works in a rotated UCS in AutoCAD (never seen); the BT1 jig preview assumption (AutoCAD hands the jig a UCS point) flagged in the HUNT-S-02 log entry; whether the Civil-line #1883 (base rel-20261102a) is needed at all depends on whether that line has HUNT-S-02 (not checked: out of this job's scope).
5. **Robot case:** the case that would prove it is one in the style N31_dp_time, e.g. `S_ucs_bt1`: type `UCS` then `Z` then `30`, run `BT1`, pick two points, then read the inserted brace block's insertion point and rotation from the drawing through the driver and compare with the two World points (the UCS-to-World transform of the clicks). Switch-off control: none exists on this line (no switch); the control is UCS `W`, where the same BT1 must give the same result as before. Not built or run here.
6. **Settings listings (names, times, sizes only), before and after: identical.** Folders listed: %APPDATA%\CE_STRUC_SUITE, CE_CVL_SUITE, CE_SUITE, TIM_CE_CADTOOLS (CD_Settings.json last written 2026-10-04 08:22, 15270 bytes, unchanged). Listings saved at C:\ce-scratch\p15\before.txt and after.txt. Before:
   - CE_STRUC_SUITE: CS_Settings.json 35613 bytes, 2026-10-30 19:54:14; CS_Settings.json.PRE_TIM_YES_20261020.bak 34858 bytes, 2026-10-18 10:00:24
   - CE_CVL_SUITE: settings.json 672 bytes, 2026-09-16 12:13:17; settings.PRE_WORKSHOP_20260916.json.bak 672 bytes, 2026-09-16 11:55:58
   - CE_SUITE: no settings files
   - TIM_CE_CADTOOLS: CD_Settings.json 15270, CD_ProjectData.json 8278, CD_RecentValues.json 11948 (2026-10-30 21:53:36), CS_Settings.json 351713, others unchanged
7. **Build number:** B-068 (BUILD_REGISTER item 91 and 115). CE 05 to record: BUG-467 already fixed (without a switch) on the Structural line by HUNT-S-02 (#879) in 1.0.125; #1883 stays as the Civil-line reference copy.
8. **Worktree:** C:\ce-fx\p15 left in place, clean (git clean -fdXq run), nothing committed.
