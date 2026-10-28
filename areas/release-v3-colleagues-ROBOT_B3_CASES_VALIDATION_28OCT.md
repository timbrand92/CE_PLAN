# Robot batch-3 draft cases N23 to N30: validation on the installed build (run Wed 28 Oct 23:12 to Thu 29 Oct 02:25, Melbourne)

Job: desk plan/03, Team robot (Sonnet). Tim was away: every runner call had CE_RUNNER_TIM_AWAY=1. One AutoCAD session at a time, AutoCAD closed for at least 185 seconds between sessions (built into my scratch script `C:\ce-fx\b3val\chain.ps1`, which only calls the existing runner). 23 runner calls, tags n3a1 to n3a6 and n3a3b (3.0.84), n3c1 to n3c8 and n3d1 to n3d8 (3.0.85). Nothing was installed or pushed to Tim's AutoCAD by me. The settings guard and hash restore were the runner's own; every session ended "AutoCAD left 0" with settings differences 0.

## ANSWER FIRST

### FOR TIM

1. **Result:** 7 of the 8 new robot checks PASS twice on the installed build, and each one's deliberately wrong twin fails for its intended reason. They are moved into `cases\` (twins into `cases\variants\`) and are ready for the independent reviewer. Nothing is accepted yet: these are PASS-UNREVIEWED until a reviewer writes a review file.
2. **The one that did not pass is N30 (recent invert buttons): it FAILS, twice, and that is a finding, not a typo.** The New Pipe window that CD opens has no "Recent levels" row at all, so there are no "Use recent invert" buttons to read. Details in item 6.
3. **The build changed while I worked.** I started on Civil 3.0.84. At about 00:20 on Thursday a desk install (job "Desk-install-c75") put Civil 3.0.85 and Manager 1.1.85 in (Structural stayed 1.0.125). My 3.0.84 runs finished before it landed, so none straddles it, but a pair of passes must sit on one build. So I re-ran everything on 3.0.85, and the two counted passes for every case are on 3.0.85.
4. **Per case (run ids are `RUN-<date>-<time>-C<build>-<tag>`, full list in section A):**
   1. **N23 pit catch, the exact 100 mm line (D02): PASS.** 90 mm outside is pulled onto the wall, 110 mm outside stays free. Passes n3c3 and n3d3. Twin FAILS as intended (n3c3).
   2. **N24 CDRENUMBER on the plan labels (D20): PASS.** The robot read every pit label block, one by one, through all four steps. Passes n3c4 and n3d4. Twin FAILS as intended (n3c4).
   3. **N25 pit label lands where you click (D09): PASS after one text fix.** The label landed 0.1 mm from the clicked point. Passes n3c5 and n3d5. Twin FAILS as intended (n3c5: 4.9 mm away).
   4. **N26 CDSYNC keeps the schedule after a cascade: PASS.** Passes n3c6 and n3d6. Twin FAILS as intended (n3c6).
   5. **N27 hand-placed label left alone by Tidy labels (D13, switch on): PASS.** Passes n3c7 and n3d7. Twin FAILS as intended (n3c7).
   6. **N28 current layer kept on every Esc path (D24 part): PASS.** Passes n3c8 and n3d8. Twin FAILS as intended (n3c8).
   7. **N29 a new pit takes its number's place in the Pit Schedule (D21 part): PASS.** Passes n3c1 and n3d1. Twin FAILS as intended (n3c1).
   8. **N30 recent invert buttons (D05 part): FAIL (a finding).** n3c2 and n3d2. Its twin also fails, but for the wrong reason (it fails on "no button at all"), so N30 stays in the drafts folder.
5. **The one text fix:** N25's second mouse click (the cover text point) was refused by the driver's own safety check, so the case was BLOCKED before any check ran. I moved that click from 30 mm below the label point to 10 mm below it. No check was weakened. Before and after are in section B.
6. **Finding on N30 (for the desk to file; no bug number exists):**
   1. **Steps:** open a drawing, type CD, pick 150000,-90000 then 160000,-90000, Enter. In New Pipe type first invert 18.240, second 18.190, press Start Pipe, press Esc. Type CD again, pick two points 2 m south of the first, Enter. Read the New Pipe window.
   2. **What happens:** the window is one page with no tabs (sections ENGINEERING, DRAFTING and PLAN PREVIEW) and has no "Recent levels:" text and no "Use recent invert ..." button. Its 100 controls run down to the plan preview and end. The tabbed layout that does carry the buttons (`PipeEditWorkshopDialog.xaml` lines 257 to 266 at the installed commit) is not what CD opens.
   3. **What the card expected:** card D05 says the New Pipe and Edit Pipe window shows "Recent:" buttons. The spec's source read put the buttons on the "Levels & Flow" tab and said New Pipe opens on it; the real New Pipe window has no tabs. Whether the Edit Pipe window shows them was not tested. Whether the buttons were removed on purpose when the one-page layout came in is not recorded anywhere I could find.
   4. **Not edited:** all N30 checks left as drafted (the planner's DERIVED button names and order were never seen, so they are neither confirmed nor different).
7. **Four values the planner worked out from the code (marked DERIVED) are CONFIRMED:** N23's sentence and positions, N26's 11 pits and 49 pipes, N27's count line, N29's order. None was different. Details in section D. N30's DERIVED values could not be tested.
8. **Moved into `cases\`:** N23, N24, N25, N26, N27, N28, N29 (twins into `variants\` as N23_broken to N29_broken). N30 stays in `cases\drafts_opus_28oct_b3\`.
9. **One thing to know:** your remembered-values file `CD_RecentValues.json` was rewritten by these runs and not restored (hashes in section G).
10. **What you need to do:** nothing. Next is the independent Opus review of the 7 moved cases, and a desk decision on the N30 finding.

---

## Technical detail

### A. Runs (all on one build per case; 3.0.84 rows are earlier and do not count toward the 3.0.85 pair)

1. **Build, read live at the start:** Civil 3.0.84+94f521cc (Legacy, Modern, Net8), Manager 1.1.84+94f521cc, Structural 1.0.125+204dfad2. **After the C-75 install (read at 00:21, and again at 02:22 at the end):** Civil 3.0.85+09126560, Manager 1.1.85+09126560, Structural unchanged. Every run header names its build. The bundle Contents folder was re-created at 00:21:11.
2. **3.0.84 runs (first pass, before the install):**
   1. n3a1 (2317 Wed): N23 PASS, N23_BROKEN FAIL.
   2. n3a2 (2326): N24 PASS, N24_BROKEN FAIL.
   3. n3a3 (2331): N25 and its twin both BLOCKED (the refused click, section B).
   4. n3a4 (2343): N26 PASS, N26_BROKEN FAIL.
   5. n3a3b (2353): N25 PASS on the fixed text, N25_BROKEN FAIL (4.9 mm).
   6. n3a5 (0003 Thu): N27 PASS, N27_BROKEN FAIL (two guarded sessions s1 and s2, one per case).
   7. n3a6 (0014): N28 PASS, N28_BROKEN FAIL. A note on this run: at its end check the lock was already held by Desk-install-c75, so the runner could not read the lock and guard; AutoCAD was gone and the four settings files equalled the start.
3. **3.0.85 runs, first pass with each twin once:**
   1. n3c1 (0024): N29 PASS, N29_BROKEN FAIL.
   2. n3c2 (0032): N30 FAIL, N30_BROKEN FAIL.
   3. n3c3 (0039): N23 PASS, twin FAIL.
   4. n3c4 (0048): N24 PASS, twin FAIL.
   5. n3c5 (0053): N25 PASS, twin FAIL.
   6. n3c6 (0104): N26 PASS, twin FAIL.
   7. n3c7 (0113): N27 PASS (s2), twin FAIL (s1).
   8. n3c8 (0122): N28 PASS, twin FAIL.
4. **3.0.85 runs, second pass in a new call (a new AutoCAD session each, main case only):** n3d1 (0131) N29 PASS, n3d2 (0137) N30 FAIL, n3d3 (0142) N23 PASS, n3d4 (0149) N24 PASS, n3d5 (0154) N25 PASS, n3d6 (0203) N26 PASS, n3d7 (0211) N27 PASS, n3d8 (0218) N28 PASS. Full ids are `RUN-20261029-<time>-C3.0.85-<tag>`; the n3a1 to n3a4 and n3a3b ids are `RUN-20261028-<time>-C3.0.84-<tag>`, n3a5 and n3a6 `RUN-20261029-<time>-C3.0.84-<tag>`.
5. **Format check first:** `case_runner.ps1 validate` on the draft folder: "16 file(s) checked, 0 invalid". Hashes of all 16 files equalled the spec's.
6. **Final hashes (first 12 of SHA-256), identical in both counted passes, checked before and after the move:** N23 58FBD1B465E0 (twin B41A66C01A42), N24 323E733AB1AC (F4B89D4BCC01), N25 05DD2856042C (83BD8186D7EF), N26 2E6AC04D844F (FACB359D32E4), N27 D86FA0A8F939 (4AEA9A01ACE2), N28 C7EFA22D70C4 (249965280AC8), N29 87FAE114D808 (26D68459ECD6), N30 DF06428BDFFA (1FDFB44C249F, not moved). The scratch script `C:\ce-fx\b3val\summ.ps1` read `file_sha256` from every run JSON.
7. **Gap rule:** every chain started with the 185 s wait (`-FirstGap`) and every session after the first in a chain waited 185 s with AutoCAD closed; a loop also waited while any acad.exe existed. No gap was shortened.

### B. Text fix (before and after)

1. **N25, the cover text click (first failure n3a3, BLOCKED at step 13; twin BLOCKED at step 12).**
   1. **Before:** `v3 pt-click "150000,-78530" -Blind -> $click_cover` (main hash 9806DCDBD32D; twin 3E505B860B71).
   2. **After:** `v3 pt-click "150000,-78510" -Blind -> $click_cover` in both files. The main case's EXPECTED line and one header comment were changed to say 10 mm instead of 30 mm. Hashes now 05DD2856042C and 83BD8186D7EF. No check changed.
   3. **Why:** the driver refused the second click twice at the identical pixel: "the window under the target pixel 2728,877 is not the drawing area (other_window_under_point): a palette, a CE window or another program is in the way. Nothing was clicked." The first click, at the view centre (pixel 2728,706), was accepted. The view is 569 pixels high (100 mm), so 30 mm is 171 pixels, which put the point at pixel 877, low in the drawing area. At 10 mm (pixel 763) both clicks were accepted in all four runs. I did not see what window lies at pixel 877 (no picture); my guess, not a reading, is the floating command line over the bottom of the canvas. This is a route problem, not a CE result; the same refusal family was seen in N20 (batch 2).
   4. **After the fix** both cases were run twice on 3.0.84 (n3a3b) and the main case twice on 3.0.85 (n3c5, n3d5); only the 3.0.85 pair counts.
2. **No other file was edited.** Before copies of the two N25 files: `C:\ce-fx\b3val\N25.orig.txt` and `N25_BROKEN.orig.txt`.

### C. Findings (CE behaviour or tool limits; none changes a check)

I grepped `C:\CE_PLAN\BUG_CARPARK.md` for "recent invert", "recent level", "recent diam", "Use recent", "one-page" and "OnePage": no entry covers finding 1.

1. **N30 / card D05: the New Pipe window has no recent-value buttons (possible desk entry; exact steps in FOR TIM item 6).**
   1. **Evidence:** the window dump of both runs (files `New_Pipe_003418.json` for the first main run and `New_Pipe_003538.json` for its twin, in `C:\Lisp Files\_TEST_COPIES_20260923\pack_runs\ui_dumps\`) lists 100 and 99 controls from the title bar down to "Real plan, north up ..." and contains no "Recent" text and no "Use recent" button. The second run, n3d2, read the same layout. Diameter, material, the grade buttons and the invert boxes (`C2.FirstInvert`, `C2.SecondInvert`) are all there.
   2. **Source cross-check (git show only):** `PipeOnePageLayout.cs` at 09126560 builds this one-page window and has no "recent" row; `PipeEditWorkshopDialog.xaml` has the "Recent levels:" row (line 257) and the buttons (line 266) on its "Levels & Flow" tab; `CdDialog.xaml` (line 961) has an older "Recent:" row.
   3. **Why the twin is not a valid red:** N30_BROKEN's first check fails on "no 'Use recent invert ' at all", so it is red for the same missing-window reason as the main case, not for the wrong levels it was written to prove. Both would need to be re-written once the window has buttons.
   4. **Not established:** whether the Edit Pipe window shows the buttons; whether the one-page layout dropped them on purpose; whether the recent list itself updates (the file's inverts were not read).
2. **N27 (D13): the "Yes" typed in the main case is never asked.** With the switch on, the Tidy labels report reads `[CE] Will move 0 · Placed by hand (left alone) 1 · No clear spot found 1`, then `[CE] No CE label needs to move.` and the case's typed `Yes` goes to AutoCAD as a command (`Unknown command "YES"`). So the Yes-question is not exercised on the main route; the count line and the unmoved text carry the proof. The twin (switch off) does ask and moves the text 275 mm. Harmless to the result; the reviewer should know the card's "even when you answer Yes" is covered only by the count line. Also in that report: `[CE] No clear spot found: pipe P3 -> P2 label. Move it by hand.` (a different label; not part of the case, not judged).
3. **Not a fault, noted: N23 and N25 turn running object snaps off.** v3 setvar reported `OSMODE (profile): 5375 -> 0`; v3 puts it back at the end of the session. With Tim's snaps on (5375) a click near the wall line can be pulled onto it, as the draft already says.
4. **N24's three planner assumptions all held.** `v3 ent-find` ran inside a case (11 labels scanned out of 1034 objects, "11 match"), the P1 to P7 and C1 labels each exist, and the one U echoed `CDRENUMBER`.

### D. DERIVED / UNCONFIRMED values: confirmed or different

1. **N23, all CONFIRMED (n3a1, n3c3, n3d3):**
   1. **The sentence:** `[CE] Pipe end moved to the inside wall of P8 (was 90 mm short of the wall).`
   2. **Positions:** near pipe box x 150225 and far pipe box x 150335, both read exactly (within 1 mm, the check is +- 1).
   3. **Counts:** `Flow: ` appears exactly 2 times, `End is free: open end flagged, connect it later.` exactly 3 times, `Flow: Open end -> P8` once, `Flow: Open end -> Open end` once.
   4. **Pit size:** still the remembered 450 x 450, not set or read by the case.
   5. **Twin (n3a1, n3c3):** the near end at 110 mm: only `no command-line line contains 'Flow: Open end -> P8'` fails.
2. **N24 (n3a2, n3c4, n3d4):** after No every label block reads as before (P9, P10, no P8); the message `Renumber cancelled - nothing changed.` once; after Yes the block that read P9 reads P8 and the P10 block reads P9 (back-reference pattern, same handles 11A09A and 119F9A), no label reads P10 or TEMP, and P1, P2, P4 to P7 and C1 are unchanged (P3 read exactly by `ent-read`); `Renumbered 2 pit(s) downhill to uphill. One Undo restores the old numbers.` once; one U echoes `CDRENUMBER` and both blocks read P9 and P10 again. DBMOD read 1 before and 1 after No (recorded, not judged). The CDRENUMBER question "Which pit is the main outlet?" appears with C1 and X1 as choices and the case answers C1. Twin (n3a2, n3c4): no U, so "P9 block reads P9 again" fails, the only red.
3. **N25:** the distance of the label's insertion point from the clicked point read 0.1 mm (insertion 150000.088, -78500.000) in n3c5 (recorded; check `<= 1` passed). The UNCONFIRMED "within 1 mm at this zoom on this screen" is CONFIRMED. The layer of the cover text is 25TEXT. Twin: the label clicked 5 mm off read 4.9 mm, `$ld = 4.9 (expected <= 1)`, its only red.
4. **N26, CONFIRMED:** after the cascade (4 pipes and 3 pits updated from P3, IL 17.50; U echoes CDEDIT; REDO "Everything has been redone") the schedule shows P3 at 17.50 / 17.45; CDSYNC warns first (`will re-link every pit and pipe ... One U undoes it.`) and then `CDSYNC complete. Pits relinked: 11, Pipes relinked: 49` (the planner's DERIVED 11 / 49 is the drawn count on this fixture; card C42's 12 / 50 belong to another drawing). Object count 1034 before and after; one `Command outcome: CDSYNC completed`; every schedule row and cell equal before and after. Twin (n3a4, n3c6): P3 erased, the equal-rows check is its only red.
5. **N27, CONFIRMED:** `[CE] Will move 0 · Placed by hand (left alone) 1 · ...` (the count line); no line holds `start invert text would move`; the text moved by hand 5 mm (the setup) and 0 mm during Tidy labels; object count 1040 before and after. Twin (switch off): the count line is absent and the text moved 275 mm, two reds, as intended. The two guarded sessions ran separately (s1 twin, s2 main).
6. **N28:** CLAYER read BLOCKS at the start and after all five endings (New Pit "Cancel without saving", Esc at CD's third point, New Pipe "Cancel without saving", a pit ended with three Esc, a pipe ended with one Esc). `[CE] CD command cancelled.` once; object count 1034 at start, after the Pit Cancel and after the Pipe Cancel (equal); one pit and one pipe placed; nothing new on layer 0 or BLOCKS; new objects were on STORMWATER PIT, STORMWATER PIPE, 25TEXT, 20TEXT, 20TEXT and ARROW. What each Cancel printed is recorded (New Pit Cancel: `PIT command cancelled.`). Twin: CLAYER set to 0 in the middle, `value '0' (expected 'BLOCKS')`, the only red.
7. **N29:** the schedule lists P1, P2, P3, P4, P5, P6, P7, P8, P9, P10 in that order and the "P10 before P8" check (`^(?!.*Pit P10= .*Pit P8= )`) passes. Twin: it expects P10 before P8, no match, its only red.
8. **N30:** nothing confirmed: the button names and order were never seen because no button exists in this window (finding C1).

### E. Why each twin's failure is the right one (from the run reports)

1. **N23_BROKEN:** `Flow: Open end -> P8` absent (pit placed, pipe step ran).
2. **N24_BROKEN:** the "P9 block reads P9 again" match fails; the Yes check before it passes.
3. **N25_BROKEN:** `$ld = 4.9 (expected <= 1)`; the label still reads P8.
4. **N26_BROKEN:** the CDSYNC warning check passes; `equals $rows1 $rows0` fails.
5. **N27_BROKEN:** `Placed by hand (left alone) 1` absent and `$tidy_moved = 275`; the first check passes.
6. **N28_BROKEN:** the first check passes; `equals $cl4 "BLOCKS"` fails with `0`.
7. **N29_BROKEN:** the first check passes; the expected "P8 after P10" order has no match.
8. **N30_BROKEN:** both of its checks fail on the missing buttons (not a valid red, see C1).

### F. Moved into `cases\` (hash checked before and after each move; script `C:\ce-fx\b3val\movecases.ps1`, log `moved.txt`)

1. `cases\N23_pit_catch_boundary_90_caught_110_free.case.txt` (58FBD1B465E0), twin `cases\variants\N23_broken.case.txt` (B41A66C01A42).
2. `N24_cdrenumber_plan_labels_one_by_one` (323E733AB1AC), twin N24_broken (F4B89D4BCC01).
3. `N25_pit_label_lands_on_the_picked_point` (05DD2856042C), twin N25_broken (83BD8186D7EF).
4. `N26_cdsync_keeps_schedule_after_cascade` (2E6AC04D844F), twin N26_broken (FACB359D32E4).
5. `N27_hand_placed_label_left_alone_by_tidy` (D86FA0A8F939), twin N27_broken (4AEA9A01ACE2).
6. `N28_current_layer_kept_on_every_esc_path` (C7EFA22D70C4), twin N28_broken (249965280AC8).
7. `N29_new_pit_takes_its_number_place_in_schedule` (87FAE114D808), twin N29_broken (26D68459ECD6).
8. The draft names were already in the `N<nn>_<words>` form, so the main files kept them; the CASE lines are unchanged. The header comments still say "NOT RUN YET" (an edit would change the hash and void the passes). Left in `drafts_opus_28oct_b3`: only N30 and its twin. The cases folder is not a git repository (local to this PC). No `.review.txt`, ledger.json (by hand), existing R or N case, runner or driver file, DESK_LOG.md or BUG_CARPARK.md was written.

### G. CD_RecentValues.json (not restored)

1. **SHA-256 before the first run (read 23:13 Wed, file time 23:08):** 1FB0CF2A330816BD542256A89A2645D8CF14A908D3AFC5E4AED13F690AC5F492. I copied it to `C:\ce-fx\b3val\CD_RecentValues.start.json`, but my version-reading script re-copied it on each of its later reads, so that copy is now a later state; the hash above is the true start.
2. **Seen at 00:20 Thu:** 3CC93C0DAD28A1767F7E1C452C0914683BA0D25E8630AC336784242F14EF5A80.
3. **At the end (02:22 Thu):** 029D77250210A4D0A99517F24991AFA23264E93EAC23EAA0D9BAE2A52A3750D1 (file time 02:21:13).
4. **Cases that type PIT or CD and so rewrite it:** N23, N25, N26, N27, N28, N29 and N30, and their twins (the spec's list). N24 closes the Pit Schedule and may also rewrite filter fields. N30's first window, Start Pipe, writes 18.240 and 18.190 to the front of the recent inverts. The desk decides whether to put the file back.

### H. What was NOT done or tested (RULES 5.9)

1. **No picture was looked at.** Checks read the command line, stored values, object counts, layers, schedule cells and window controls. Not judged: label and leader looks, the cover text's corner, where the hand-placed text sits on the plan.
2. **PASS-UNREVIEWED only.** No independent review has happened; nothing here is Claude-accepted (RULES.md, 24 Oct amendment).
3. **Not tested:** other builds, Tim's own AutoCAD session, Tim's snaps on (OSMODE 5375), the Edit Pipe window's recent buttons, pressing any "Use recent ..." button (never pressed), "Send report", the card's typed label point (D09), "move pit P8 500 mm and the label stays" (D13 step 3), the LPD, OG and CP schedule groups (D21).
4. **Runs on 3.0.84 are not part of the counted pairs** (N29 and N30 were never run on 3.0.84). The passes on 3.0.84 are listed in A2 for the record.
5. **My inference, not a reading:** that the N25 refusal at pixel 877 was a floating command line over the canvas.
6. **Not committed:** the runner's `areas\runner-reports\ledger.json` (shared with other jobs, rows written by the runner).

### I. Files

1. This report; the 46 run report and JSON files for tags n3a1 to n3a6, n3a3b, n3c1 to n3c8 and n3d1 to n3d8 under `areas\runner-reports\` (the runner's own).
2. Case files moved as in F. Scratch on this PC only: `C:\ce-fx\b3val\` (`chain.ps1`, `readver.ps1`, `summ.ps1`, `movecases.ps1`, `dumpnames.ps1`, `blk.ps1`, run logs, the N25 before copies, the two window-dump name lists). Undo for the N25 fix: the before copies; undo for the moves: move the 14 files back by the names in F.

## Summary (under 100 words)

Seven of the eight batch-3 cases (N23 to N29) pass twice on Civil 3.0.85 with every twin failing as intended; they are moved into cases and variants, ready for independent review. N25 needed one click moved (30 mm to 10 mm). Planner values for N23, N26, N27 and N29 were confirmed. N30 fails twice: the one-page New Pipe window has no recent-invert buttons, a finding for the desk, left in drafts. A C-75 install changed 3.0.84 to 3.0.85 mid-job, so the pairs were re-run on 3.0.85. CD_RecentValues.json was rewritten, not restored.
