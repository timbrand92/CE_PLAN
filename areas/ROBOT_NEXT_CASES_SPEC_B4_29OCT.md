# Robot next cases, batch 4: 4 new draft checks (29 Oct 2026)

Written Thu 29 Oct 2026, about 09:00 to 09:50 Melbourne (PC clock), by an Opus case drafter (CE 02 Robot and Codex Testing session; read and write documents only). Nothing was run in AutoCAD, nothing built or installed; the only runs were the robot's offline format check and an offline test of the new text patterns. Installed build when written: **Civil 3.0.85** (commit 09126560, branch claude/rel-20261026z; DLL product version read from all three runtime folders at 09:20). Every source line below was read from that commit with `git show` / `git grep`.

## ANSWER FIRST

### FOR TIM

1. **Where we are:** 18 of the 40 everyday tools are Claude-accepted (ledger items 24 and 26). It may really be 20: two named checks already passed whole but are not in the list of 18 (finding 4 below; the desk checks).
2. **What I did:** wrote 4 new robot checks, each with a "deliberately wrong" twin that must fail. They sit in a side folder, so the robot ignores them until a Team robot job tries them.
3. **Two of them aim to finish a tool, so the count can rise:**
   1. **Office layers (D24):** one labelled pit and one pipe; the robot reads the layer of every new object (pit, pit number, cover level, pipe, pipe label, both IL texts, flow arrow) and checks your current layer stays BLOCKS. With yesterday's Esc check this covers the whole card as built.
   2. **Pit Schedule groups (D21):** pits typed as LPD, OG, CP10 and CP2 come out LPD, OG, P1 to P10, CP2, CP10, then C1. With yesterday's P8 check this covers the whole card for your setting.
4. **Two cover a switched-off part (your file has both switches OFF):**
   1. **Hand-placed label when its pit moves (D13):** a pipe text you dragged by hand is carried along with its pipe end when the pit moves, but CE never shoves it somewhere else.
   2. **"Natural" schedule order (D21 refinement):** P1A goes straight after P1, and SPS2 comes before SPS10.
5. **What it could mean:** if both "finish" checks pass twice and the reviewer agrees, 18 rises to 20 of 40 (22 if the desk confirms finding 4).
6. **A correction to yesterday's plan:** it said the robot cannot type a pit number. It can: the New Pit window is one page and the number box is on it. That is what made the D21 groups testable.
7. **Recent buttons (D05): not drafted, on purpose.** The buttons are built, but they sit behind the New Pipe window's "More..." button, not on the main page. A check would fail by design. The robot is not allowed to press "More..." yet.
8. **Not drafted, and who has them:**
   1. **Codex look:** which way the pipe label reads (D10); the robot cannot read a text's angle.
   2. **Your word:** the raingarden label (D07, Monday question 15); CDFEEDBACK "Send report" (D29) needs the spare login and your yes.
   3. **Needs a robot permission first:** hide grade (D06) is also behind "More...".
9. **Two questions for your Monday list (nothing to do now):**
   1. **D13:** when you move a pit, should a pipe label you dragged by hand ride along with the pipe (CE today), or stay exactly where you put it? I recommend "ride along", so it stays beside its pipe end. Example: move P8 500 mm east; the IL text you nudged comes with it, still nudged.
   2. **D05:** should the recent diameter, material and invert buttons be on the main New Pipe page? I recommend yes; the card says one click. Example: today you click More..., then 225.
10. **Something to know:** all four checks place pits or pipes on test copies, so they rewrite your "last values used" file (the robot records it before and after). Nothing touches your real drawings.
11. **What you need to do:** nothing.

---

## Technical detail

### A. The 4 drafts (folder `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_29oct_b4\`, 8 files)

1. **N31 `N31_hand_placed_text_kept_through_pit_move` (card D13 profile B, switch ON; the pit-move half). Hash 707DAB4421B8; twin 1511AFC4F088.**
   1. **Proves:** with `linking.tidyLabelsEnabled` and `linking.handPlacedLabelsStay` on (two SETTING lines), N27's route (IL 18.000 at P8 moved by hand 0,-5; SPOT LEVEL 10EC5D moved onto it), then pit P8 moved 0,10 with MOVE: the pit moves 10 mm, "1 found", no Edit Pit window, and the hand-placed text moves no more than 20 mm (carried with its pipe end, never shoved clear). CDTIDYLABELS All afterwards counts "Placed by hand (left alone) 1", lists no "start invert text would move" line, moves the text 0 mm, and the object count is unchanged.
   2. **Why 10 mm, not the card's 500 mm:** `UpdatePipeAttachments` (LinkService.PipeAttachmentUpdates.cs) "moves every recorded text of the pipe with it" by its stored segment, T and offset and never reads the mark (R12 on 3.0.85: IL texts carried 1894 to 1999 mm for a 2000 mm pit move). A 500 mm move carries the text about 500 mm, so the card's "P2 = P1 within 1 mm" would fail by design, and the text would leave the spot level so no clash would be left to test. 10 mm keeps the clash.
   3. **Rests on:** the clash tidy that a pit move sets off (`TidyTextClashesAfterNativeMove`, routes "pit-boundary" in LinkService.PitMoves.cs and "established" in LinkService.Reactors.cs); `HandPlacedLabelRule.StaysPut` read in `TidyOnePipe` for every movable role; HandPlacedLabelRule.cs's own words (Tim, 26 Sep 2026: "Stays where you put it"): "no CE tidy moves it afterwards"; N27 (part-ready on 3.0.85).
   4. **DERIVED:** carried distance at most 20 mm (expected about 9.5 to 10); "Placed by hand (left alone) 1" after the pit move; 0 mm in the tidy.
   5. **Cannot prove:** the card's literal step 3 (a card question, finding 3); the "pipe label" itself (the invert text is the one with a proven clash; the rule marks any pipe text moved on its own); Tim's switch-OFF setting.
   6. **Twin (also the card's profile A):** the same steps with `handPlacedLabelsStay` false. Intended reds: "$pm_moved <= 20" (the pit move's tidy moves the unmarked text clear, DERIVED about 275 mm as R16) and the count line. **If only the count line fails, report it:** N31 then proves only that the mark survives a pit move.
2. **N32 `N32_every_new_object_on_its_office_layer` (card D24 assertion 2; with N28 the whole card as built). Hash BB0D461CE2B8; twin EC73AE1E03B5.**
   1. **Proves:** running snaps off; PIT at 150000,-80000 (cover 19.000) with the label and cover points clicked as N25; CD 150000,-80000 to 170000,-80000 (18.000 / 17.900), one Esc. CLAYER reads BLOCKS at the start, after the pit and after the pipe. Exactly 8 new objects: pit on STORMWATER PIT, PIT LABEL block on STORMWATER PIT LABEL, "CL" text on 25TEXT, pipe on STORMWATER PIPE, pipe label on 25TEXT, two IL texts on 20TEXT, TIM_CVL_ARROW on ARROW; none on 0 or BLOCKS.
   2. **Layer names are NOT derived:** each is in the source at 09126560 (LayerService.cs lines 54, 127, 134, 138, 142, 146; PitCommand.cs 485 and 805; TextService.cs 197 and 1199) AND was seen on 3.0.85 (N28 n3d8 "STORMWATER PIT | STORMWATER PIPE | 25TEXT | 20TEXT | 20TEXT | ARROW"; N25 n3d5 label on STORMWATER PIT LABEL, cover on 25TEXT).
   3. **DERIVED:** only the total of 8 new objects.
   4. **Cannot prove:** "never recolour an existing layer" (not built); the layer table (no verb reads it). The card's "IL texts and the label on the pipe-text layer" is checked as the product builds it (20TEXT and 25TEXT; finding 5).
   5. **Needs:** an unlocked screen (two mouse clicks, N25's route).
   6. **Twin (a real-action red):** SETUP-P8 with `SETTING CD_Settings.json layerNames.names.20TEXT CETWIN20TEXT` (Settings > layerNames, Batch 5 card 5.1). CE then writes the IL texts on CETWIN20TEXT, so "IL texts on 20TEXT" fails while CLAYER and the IL count pass. No clicks. DERIVED: that the v2 guard writes the nested key (its path rule allows it; `Set-V2JsonKey` makes the missing groups).
3. **N33 `N33_schedule_groups_lpd_og_p_cp_then_rest` (card D21 assertion 3; with N29 the whole card for Tim's setting). Hash DC4CBDA88743; twin 9F366E0CDD07.**
   1. **Proves:** four pits placed with their numbers typed in New Pit (`ui2-set "New Pit" "C2.PitNumber"`): LPD, OG, CP10, CP2 (CP10 first on purpose). The schedule lists LPD, OG, P1, P2, P3, P4, P5, P6, P7, P9, P10, CP2, CP10, C1; CP10 is never above CP2; no P pit above LPD or OG.
   2. **Rests on:** `PitIdComparer.CompareLegacy` (groups: exactly "LPD", exactly "OG", P<n>, CP<n>, the rest); `PitNumberAsTyped` (kept as typed; LPD, OG, CP2, CP10 are free and raise no question box); the one-page New Pit window (finding 1).
   3. **DERIVED:** the row text for the typed names (N29's shape "Pit P8= | P8=P8 |"), and that typing C2.PitNumber is taken (never driven).
   4. **Cannot prove:** the refinement (N34); the P8 assertions (N29, two passes on 3.0.85).
   5. **Twin:** a flipped order ("CP2 above P1", what a plain text sort gives), the N09 / N29 shape the reviewers accepted. No switch changes these groups, so no real-action red exists for assertion 3.
4. **N34 `N34_schedule_natural_order_p1a_sps_switch_on` (card D21 assertion 4, switch ON). Hash C383BF06A108; twin 2785BD62FEC1.**
   1. **Proves:** with `linking.pitScheduleNaturalOrder` true, pits typed SPS10, P1A, SPS2 are listed P1, P1A, P2 ... P10, C1, SPS2, SPS10; P1A never below P2; SPS10 never above SPS2.
   2. **Rests on:** `PitIdComparer.CompareNatural` (P1A in the P group: "Q9: P1A sorts straight after P1"; letter and number runs, so SPS2 before SPS10 and C1 before SPS2).
   3. **DERIVED:** the row text for the typed names; C2.PitNumber taken.
   4. **Cannot prove:** Tim's own setting (OFF); this is the switch-ON profile only.
   5. **Twin (a real-action red):** the same steps and checks with the switch written false. By `CompareLegacy`, P1A falls to "the rest" (C1, P1A, SPS10, SPS2 after P10), so all three order checks fail. It also records the order Max gets today.

### B. Not drafted, and why

1. **D05 recent buttons: the card does not match the product as installed; no case that must fail by design.** CD opens `PipeEditWorkshopDialog` (DialogService.cs, `editors.workshopLayout` true in Tim's file), which `PipeOnePageLayout.cs` rebuilds as one page. It moves only the rows named in its list (Diameter, the levels, CreatePipeText and so on). The "Recent:" diameter and material row (PipeEditWorkshopDialog.xaml lines 99 to 132) and the "Recent levels" row (lines 257 to 266) are separate rows, so they stay in the leftover controls that `CivilMoreOptions` shows in "Creative Engineering | More options" behind the "More..." button. So BUG-1226 is real as filed: no Recent buttons on the main page. "More..." is on neither press list (v2 New Pipe; v3 `*New Pipe*`). Card or product: Tim (question 2 above).
2. **D06 hide grade: same place.** The "Show grade in pipe text" toggle (binding ShowGradeInText, xaml line 368) is not moved onto the page, so it is behind "More..." too. A reviewed allow-list entry for "More..." and the "More options" window (press "Back") would open D05 and D06. The batch 3 spec's "select tab verb" is not the fix: there are no tabs.
3. **D07 raingarden:** no RG label exists; Tim's question 15 first. Codex G3 (held for Thursday) reports the facts. DP after a reopen is BUG-1225 (Tim-confirmed fixed 29 Oct).
4. **D10 pipe label reading direction: Codex look or a driver change.** `Get-V3EntityInfo` (acad_driver_v3.ps1 line 830) returns only words and insertion point for TEXT and MTEXT, no rotation. R18 pins the words and the side.
5. **D29 CDFEEDBACK:** only "Send report" is left; it is on both never-press lists, needs the spare login and Tim's yes. N21 covers Cancel.
6. **D22 drawn schedule: a short probe first.** `PitScheduleViewModel.Data.cs` `RefreshPlacedScheduleStatus` sets "blocking differences" whenever the drawing already holds a placed schedule, so "Continue to Place / update" stays off until the changes are reviewed. Codex's disabled button may be by design on DRV1_B1 (unverified whether it holds a placed schedule). The probe should read the window's status line ("Update blocked - review the listed schedule issue." and the like).
7. **D23 Excel export:** "*Export*" is a never-press button and it opens a Save dialog.
8. **D25:** not built. **D26 survey half:** needs a drawing with a stored CDSURVEY survey. **D28:** the desk settles the card first (BUG-606). **D30:** no verb reads the active ribbon tab.
9. **D20 (N24's three extra lines):** not needed for the count (D20 is whole by N15 with Codex G2), and existing cases are not mine to edit.

### C. Instruction for the Team robot job (copy as is)

1. **When:** a free AutoCAD window (weekday 2:00 to 3:00 pm or after 5:30 pm, or the weekend), or Tim's weekday hours only with `CE_RUNNER_TIM_AWAY=1` set on every runner call.
   1. **Build:** read the installed Civil DLL version first (Civil 3.0.85+09126560 when written); all passes for one case must be on that same build. If a new build installs during the job, stop, note it, and restart both passes on the new build.
   2. **Gap:** keep AutoCAD closed for at least 3 minutes between sessions (build the wait into your own script).
   3. **Screen:** N32 clicks with the real mouse (N25's route): the screen must be unlocked. Its twin does not click.
2. **Remembered values:** before the first run, copy `%APPDATA%\TIM_CE_CADTOOLS\CD_RecentValues.json` to your own scratch folder and record its SHA-256. Record it again at the end. Do not restore it; the desk decides. **Every one of the 8 files rewrites it:** N31 and N31_BROKEN (SETUP-R47 types PIT and CD), N32 (PIT and CD), N32_BROKEN (SETUP-P8), N33 and N33_BROKEN (PIT four times, typed pit numbers LPD, OG, CP10, CP2), N34 and N34_BROKEN (PIT three times, SPS10, P1A, SPS2). Levels used are the usual 19.000 cover and 18.000 / 17.900 inverts. Whether CE remembers a typed pit number is not known: say if the file changes in a way that names one.
3. **Format check:** `pwsh -NoProfile -File "C:\Lisp Files\_ACAD_DRIVER\case_runner.ps1" validate "C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_29oct_b4"` must say 8 file(s) checked, 0 invalid.
4. **First pass:** run each draft with its twin, two cases per call, with `run-pack "C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_29oct_b4" -Only "<pair>" -Tag n4a<k> -NoRerun`. The pairs:
   1. `N31,N31_hand_placed_text_kept_through_pit_move_BROKEN` (different SETTING values: two guarded sessions; SETUP-R47 takes 4 to 8 minutes each)
   2. `N32,N32_every_new_object_on_its_office_layer_BROKEN` (N32 needs an unlocked screen; the twin has a SETTING line: two sessions)
   3. `N33,N33_schedule_groups_lpd_og_p_cp_then_rest_BROKEN` (four pits each: up to 20 minutes under load)
   4. `N34,N34_schedule_natural_order_p1a_sps_switch_on_BROKEN` (different SETTING values: two guarded sessions)
5. **Second pass:** repeat every main case in a NEW call (a new AutoCAD session), tag n4b<k>. Run each twin once only.
6. **Fix only mistakes in the draft text** that the runner shows: a wrong prompt word, a BLOCKED step, a wrong variable, a window or button name, a doubled keyword in AutoCAD's log.
   1. **Never weaken or delete a check** because CE behaves differently from its card: that is a finding. Write it in the report for the desk to file.
   2. **DERIVED lines:** if one fails, do NOT edit it; report the exact text or value CE gave. They are: N31 "$pm_moved <= 20", "Placed by hand (left alone) 1", the absent "would move" line, "$tidy_moved = 0"; N32 "count $new = 8"; N33 and N34 the row patterns for the typed names.
   3. **C2.PitNumber (N33, N34):** if `ui2-set "New Pit" "C2.PitNumber"` is refused, BLOCKED or not taken (the schedule shows P8, P11 and so on instead of the typed names), report it with the New Pit dump; do not replace it with another route.
   4. **N31_BROKEN:** read which checks failed. If ONLY the count line failed (and "$pm_moved <= 20" passed), report it plainly: the pit move's own tidy did not move the unmarked text.
   5. **N32_BROKEN:** if the guard refuses the key `layerNames.names.20TEXT`, report it; do not change the key.
7. **After any fix,** run that case twice again (its hash changed, so earlier passes no longer count).
8. **Move when ready:**
   1. **Which cases:** a main case that passed twice, with its twin failing for the intended reason, moves to `cases\`; its twin moves to `cases\variants\`.
   2. **Names:** `N<nn>_<words>.case.txt` and `variants\N<nn>_broken.case.txt`, keeping the CASE line unchanged.
   3. **Hashes:** check each file's SHA-256 before and after the move.
9. **Never:**
   1. **Write or edit** any `.review.txt`, existing R or N cases, the runner or driver files, the allow-lists, `ledger.json` by hand, DESK_LOG.md or BUG_CARPARK.md.
   2. **Press** "More...", Send report, Export, or any "Use recent ..." button.
10. **Report:** write `C:\CE_PLAN\areas\release-v3-colleagues-ROBOT_N_CASES_B4_VALIDATION_<date>.md`. Give per case PASS, FAIL or BLOCKED with run ids, every text fix (before and after), every finding, which cases moved, and the CD_RecentValues.json hashes. Then the desk starts the independent Opus review.

### D. Checks made on the drafts

1. **Validate is offline (read before running):** `case_runner.ps1 validate` dot-sources `acad_driver_v3.ps1 -Library` ("defines the functions and runs nothing"; its only top-level statements are Add-Type, variable settings and the session file's definitions) and `case_runner_lib.ps1` (functions only), then `Read-CaseFile` and `Test-CaseFile`, which read text, hash files and check that the fixture master exists. No AutoCAD, lock, guard or settings call.
2. **Format check:** "8 file(s) checked, 0 invalid" (N31 42 steps 18 checks with SETUP-R47; N32 45 steps 27 checks; N33 47 / 11; N34 37 / 8; twins 33 / 6, 3 / 4 with SETUP-P8, 46 / 4, 37 / 6).
3. **Order patterns tested offline:** a scratch script split N29's recorded 3.0.85 schedule text (run n3d1) into pit blocks and rebuilt six orders. N33's four checks pass on the right order and fail on placing order, plain text sort and "new pits at the bottom"; N33_BROKEN's check fails on the right order. N34's three checks pass on the natural order and all three fail on the legacy order (the twin's case). The pattern `Pit P\d+= ` does not match the sub-rows "Pit P1, pipe from ...".
4. **Verbs and names copied from passing cases:** N27 (hand move, spot move, CDTIDYLABELS), R12 (pit MOVE, "1 found"), N25 (snaps off, zoom, clicks, esc-key), SETUP-P8 (CD), N29 (PIT, Pit Schedule read and Close). New in a case: `ui2-set "New Pit" "C2.PitNumber"` (the id from WorkshopEditorFocus.cs line 75 at 09126560 and ui_map\s7\newpit_tree.txt) and a `layerNames.names.20TEXT` SETTING line.
5. **Non-ASCII:** none in the 8 files; the word that trips Codex briefs is not used.
6. **BUG_CARPARK.md (read only):** no open entry says these tools behave differently from their cards, apart from BUG-1226 (D05, above).

### E. Findings for the desk (RULES 6.2)

1. **The batch 3 spec was wrong about the pit number and partly about tabs.** New Pit always opens one page (`WorkshopPitCreation.OnePageRequested` returns true at 09126560) with a "Pit number" box, id C2.PitNumber, and the plan size boxes "Pit plan length (mm)" and "Pit plan width (mm)" by name (no id; v2 `Find-UiControl` also matches an exact name). New Pipe is also one page. What hides D05 and D06 is the "More..." window, not a tab. So the "select tab" driver verb is not the fix; an allow-list entry for "More..." is.
2. **BUG-1226 diagnosed:** the Recent rows exist in the installed window but sit behind "More..." (section B item 1). A card-or-product question for Tim, not a robot fault.
3. **Card D13 step 3 does not match the product** (B3 finding 3 and B7 finding 5, now with the reason): a pit move carries every text of its pipes, marked or not (`UpdatePipeAttachments`); the mark only stops a CE tidy from moving it. Question 1 for Tim's Monday list.
4. **Possibly 20 of 40, not 18:** "CDSYNC keeps the schedule" (N26, CLAUDE-ACCEPTED-READY whole on 3.0.85, B7 item 3) and "CDTWL freeboard" (R14 with R14h x3, whole on 3.0.80 per ledger item 14) are named checks of the 40 but are not in ledger item 24's list of 18. Note: R14h x3 have no 3.0.85 runs yet (ledger item 26). I did not recount.
5. **Card D24 wording:** IL texts go on 20TEXT (their own layer), the pipe label and the cover text on 25TEXT; the card's "pipe-text layer" for both should be corrected at its next edit.
6. **Card D21 wording:** LPD and OG are exact names in the source; "LPD1" or "OG2" sort with the rest.
7. **AutoCAD pid 30056 was running (started 09:14, Tim's hours).** I did not touch it; nothing I ran talks to AutoCAD.

### F. What this document did not do (RULES 5.9)

1. Nothing was run in AutoCAD; no picture was looked at; no case was run by the runner.
2. No review.txt, ledger, carpark, DESK_LOG, existing case, variant, setup, runner, driver or allow-list file was touched. Only the 8 new draft files, this spec and two scratch files in this session's scratchpad (`b4_regex_check.ps1`, `n29_rows.txt`) were written.
3. Unverified on this PC: that C2.PitNumber takes a typed number on 3.0.85; that the pit move's tidy moves an unmarked text (N31's twin reason); the 8-object count (N32); that the guard accepts the `layerNames.names.20TEXT` key; whether a pit named exactly LPD is treated specially by any other CE tool.
4. The 18-of-40 figure is ledger item 24's; I did not recount it.
5. The drafts folder under `_ACAD_DRIVER` is not in CE_PLAN and is not committed anywhere; nothing was committed or pushed.

## Summary

Four new robot drafts with failing twins (8 files, format check clean) for Civil 3.0.85. Two aim to finish a tool: every new object on its office layer (D24, with N28) and the Pit Schedule groups LPD, OG, P, CP, rest (D21, with N29), made possible because the robot can type a pit number. Two cover switch-ON parts: a hand-placed text through a pit move (D13) and natural order P1A / SPS (D21). D05 is not drafted: its buttons sit behind "More...". If both finishers pass twice and are reviewed, 18 could become 20 of 40.
