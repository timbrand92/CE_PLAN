# Claude driver run 27: first robot pass with driver v2 (Sun 18 Oct 2026, PC clock 05:44 to 06:10)

**Installed builds (nine DLLs read first with readdll.ps1):** Civil 3.0.53+b06126db, Manager 1.1.53+b06126db, Structural 1.0.118+9a8e5d4e (Legacy, Net8 and Modern of each carry the same text).

## ANSWER FIRST

1. **Counts: PASS 9, FAIL 1, BLOCKED 1, UNPROVEN 1, SKIPPED 3** (15 numbered checks, section B).
2. **Q4 evidence, Claude-seen only (not Codex-accepted, not Tim-accepted):**
   1. **Tidy labels (CDTIDYLABELS): Q4 evidence NO.** It runs with the switch ON and prints its preview, but nothing on the test drawing needed moving, so Apply, U, REDO and the timing were never reached.
   2. **Checks list (CDCHECKS, CDHUB, CDCHECKCURRENT routing): Q4 evidence YES.** The palette opened, I read its screenshot, and both old commands routed into it with their "now part of Checks" line. CDCHECK kept its command-line answer.
   3. **Double-click opens the Edit window: Q4 evidence NO.** Mouse only, so the driver cannot do it (SKIPPED).
   4. **Quick edit with the new tools ON: Q4 evidence YES.** Typed MOVE (twice), STRETCH, U and REDO ran; no CE window opened; the Pit Schedule was unchanged.
3. **BUG-650 (stored pit level blanking): did NOT reproduce on a pit I placed myself.** Bottom level 20.000 survived CDFW with Esc, CDSOURCE with Esc and CDSYNC (read in Edit Pit before and after). Limits in B10 to B13.
4. **Edit Pipe cascade: FAIL on this drawing.** Arriving level raised 17.30 to 17.50; the pipe leaving the pit stayed at 17.25 (expected 17.45) and no "Recalculate" question was ever seen. I cannot tell a fixture limit from a real fault (B14).
5. **Settings restore proof: Tim's four real settings files hash exactly the same at the start and the end.** The driver restored CD_Settings.json itself and said so. Hashes in section A.
6. **AUTOCAD CLOSED, SETTINGS RESTORED.** Both verified (section A).

## A. Conditions and proofs

1. **Pre-flight (all met):** `Get-Process acad,accoreconsole` empty; the only `tester_run` cmd.exe was my own (pid 71116); Codex queue.log ended `END verifyW65 08:38` with no START open; `settings-temp status` showed NO entry. My claude process id was 74084 and I passed `-HolderPid 74084` on every `lock acquire`. Unique lock names: `Claude-run27` (session 1) and `Claude-run27b` (session 2).
2. **Real settings hashes, start of pass:** CD_Settings.json (TIM_CE_CADTOOLS) ACD64E79A33B; CS_Settings.json (TIM_CE_CADTOOLS) 622A246F7D3B; CS_Settings.json (CE_STRUC_SUITE) 24D8E5F7D87B; settings.json (CE_CVL_SUITE) EFE307C4FC74.
3. **Real settings hashes, end of pass (read by me after both quits):** ACD64E79A33B, 622A246F7D3B, 24D8E5F7D87B, EFE307C4FC74. Identical. Both `quit` results printed `settings_hash_check = "the 4 settings files have the same SHA-256 as at the start of the pass"`. No `!!!!`, no `>>>>`, no conflict, no `-Force`.
4. **What I changed in the real CD_Settings.json (before launch, `settings-temp set`):** `linking.tidyLabelsEnabled`, `checks.checksCommandEnabled`, `doubleClick.opensEditWindow`, each to true. Changed hashes were 9D27B04C..., F7FEE3DD..., 00EBD84A667B. Tim's file held none of the three groups; the driver added them.
5. **Restore sequence in session 1:** `settings-restore` while AutoCAD ran (`restored_kept`, hash ACD64E79A33B equals the original, backup kept as designed), then `quit` (`restored_verified`, hash equals the original), then `settings-temp status` (0 entries). Backup folder empty, no `settings_guard.json`.
6. **Session 2 changed no setting at all.** Its `quit` confirmed the four hashes again.
7. **Driver file hashes, before and after (unchanged):** acad_driver.ps1 C9BA503D4636; acad_driver_witness.ps1 0B1116C64249; acad_driver_witness_v2.ps1 D3669ADC2925; allow-list A6109A4DA670. Fixtures DRV1_B1 34BBE37C2EA4 and DRV2_S1 950AFDF6E523, unchanged.
8. **Copies:** CLD91_B1 and CLD91_S1 (session 1), CLD92_B1 (made from DRV1_B1, hash 34BBE37C2EA4 checked). Never touched a DRV fixture. CLD91_S1 (Structural) was copied but never opened. I deleted all five test files by name, including the two CE `_PRE_C7_` backups.
9. **Calls (counted by a wrapper, every call):** session 1 = 66, session 2 = 66, both under 70. Time: session 1 about 12 minutes, session 2 about 12 minutes. Not used: `arm`, the Settings window, `click-canvas`, `dialog-path`, `-Force` on any restore.

## B. The 15 checks

1. **CDTIDYLABELS preview, switch ON: PASS.** Typed `CDTIDYLABELS`, `All`, `Yes`. With the switch ON it did not offer to switch itself on. Printed: "Will move 0 · Placed by hand (left alone) 0 · No clear spot found 1", "No clear spot found: pipe P3 -> P2 label. Move it by hand.", "No CE label needs to move." (The extra `Yes` then went to the command line as an unknown command; harmless.) Screenshot `robot_shots\run27\tidy_labels_preview.png`: the command line is hidden in this layout, so the picture shows the drawing, not the preview text.
2. **CDTIDYLABELS Apply, U, REDO, time, locked layers: BLOCKED.** Run three times (two pit MOVEs of P3 first, 400,300 and -1500,900); always 0 to move, because the only candidate label has no clear spot (the drawing border block owns the spaces). My LISP read found **no locked layer** in the drawing, so "locked layers untouched" is also unprovable here. The one text-search LISP I tried found no TEXT objects near the pit (the labels are not plain text), so I could not build a clash by moving one label. **Needs a fixture with two labels that really overlap.**
3. **CDCHECKS: PASS.** Opened the palette "Creative Engineering | Checks (CDCHECKS)": "Checks: 62 to look at · 244 OK · 312 not known", "Nothing in the drawing was changed." Screenshot `robot_shots\run27\checks_palette.png` read: header, Look at / Ignored tabs, list, Show where, Check again, Close.
4. **CDHUB routes to Checks: PASS.** "Civil Hub is now part of Checks. Design proposals are in Project Review (CDDASHBOARD)." then the same Checks summary.
5. **CDCHECKCURRENT routes to Checks: PASS.** "What CE Found is now part of Checks." then the same summary.
6. **CDCHECK unchanged: PASS.** Complete chain `CDCHECK` / `Problems` gave the old command-line answer (212 objects, 184 connections, 4 Unresolved, "Pipe-to-pit fit: not checked for 35 pipe ends", full list saved, "See them all in the Checks palette (CDCHECKS)."). **As the README warns, a last question was left waiting:** "Jump to item number (1-4) or [Ends]". One `esc-prompt` ended it cleanly (`*Cancel*`, `command_ended true`). Side effect to know: CDCHECK wrote its own list into Tim's real CE log folder, `C:\Users\TimothyBrand\AppData\Roaming\CE_CVL_SUITE\logs\cdcheck-CLD91_B1-20261017-185014.txt` (CE's normal behaviour, not a settings file, left in place).
7. **CDRULES unchanged: SKIPPED.** Not run; I spent the calls on the BUG-650 and cascade items first.
8. **Double-click opens the Edit window: SKIPPED.** Mouse only; the driver has no double-click.
9. **Quick edit with the tools ON: PASS.** `pick-first` pit P3 (109D56), typed `_.MOVE 0,0 400,300`: no CE window; "[CE Civil] pipe P3 -> P2 label: no clear spot ... left where it is". Typed `_.ZOOM _E` then `_.STRETCH` (crossing window on the end of pipe 109E23, 6 objects, `0,0` to `300,0`): no CE window. `U` named STRETCH; `REDO` printed "Everything has been redone". `ui windows` before and after showed only the AutoCAD frame plus the permanent docked palettes. **Pit Schedule unchanged:** same window text ("Will be placed: 27 rows · All sets · All systems", "95 data issues") and the same tree hash 274F3291C14D before and after. **Limit:** the tree lists row names, not cell values, so unchanged cell numbers were not read.
10. **BUG-650, stored pit level, CDFW Esc: PASS (limited variant).** Placed pit P8 myself: typed `PIT` with point 10000,-90000, `ui set` cover 21.000, ticked "Sump pit · own bottom IL", `ui set` bottom level 20.000, `ui press` Continue placement. Saved the copy, reopened it, `CDEDIT` on P8 (handle 11C5AA): bottom level read **20.000**. `CDFW` then `esc-prompt` at "Specify floor waste insertion point": "CDFW cancelled - nothing was placed." Re-read Edit Pit after CDSOURCE Esc and CDSYNC: still **20.000**, cover 21.000, sump on. **Limit:** I read it in the Edit Pit window, not the Pit Schedule (the Schedule tree does not show level cells), and on a pit I placed, not on P1/P2 of a strip+AGI drawing as in Codex's original case.
11. **CDSOURCE Esc: PASS.** `esc-prompt` at "Source type [Roof drain/Air-conditioning unit/Overflow pipe/Hot-water unit/Custom] <Roof drain>": "CDSOURCE cancelled - nothing was placed."
12. **CDSYNC after the Esc paths: PASS for the level.** "CDSYNC complete. Pits relinked: 12, Pipes relinked: 49" and the stored level was unchanged. **Not checked:** the BUG-698 pipe-size change (I did not open the Pit Schedule after CDSYNC).
13. **BUG-650 variant "label edited so only a CL line remains": UNPROVEN.** `PIT` asked two more questions after Continue placement (label point, cover-text point). I answered both with Esc (three Esc calls in all) and CE reported "Pit placed successfully" with no label at all, so there was no label to edit. I did not run the typed text edit on another pit's label.
14. **Edit Pipe cascade: FAIL on this fixture, cause unproven.** Arriving pipe 10A98D (P4 to P3): upstream 17.40, downstream 17.30. The pipe leaving P3 (109E23): upstream 17.25, downstream 17.13 (so the pit drop is 50 mm). `ui set` both ends +0.20 (17.60 / 17.50), `ui press` Save pipe and close. No question window appeared (`new_windows` empty, AutoCAD not busy, no `[CDEDIT-CASCADE]` line), and 109E23 still read **17.25 / 17.13**, not 17.45. Source says a single Edit Pipe asks unless the pipe's direction changed, or the pit has no stored handle (`PipeEditCommand.Update.cs`, the modal question is `DialogService.Confirm`). Possible causes I cannot separate: this older drawing's pit has no link handle; the question window has a title that is not on the driver's list so it was never shown; a real fault. **Needs Codex or a fixture drawn fresh with CD.**
15. **Other T2 cases: SKIPPED.** The 70-call budget was spent on checks 1 to 14.

## C. Things the pass found that the desk should look at (all unproven beyond what is stated)

1. **A first, wrong attempt on the cascade is itself a finding.** I raised only the arriving end to 17.50, above the upstream 17.40. CE silently **reversed the pipe** (the Inspector went from "Pipe P4 → P3, 17.40 / 17.30" to "Pipe P3 → P4, 17.50 / 17.40"). The source has a "DirectionChanged" branch, so it is designed; I did not see any message telling the drafter. Worth Tim's eye: a drafter raising one end by mistake flips the flow.
2. **U after a cancelled Edit Pipe may do nothing visible.** After that save I opened and cancelled another pipe's Edit window, then typed U: it printed "CDEDIT" and the flipped pipe was still flipped when I reopened it. My reading (not proven): the cancelled window left its own do-nothing undo step. Needs one clean repeat by someone watching.
3. **`answer` refused at PIT's label prompt.** After the first Esc the log's last line was "Specify pit label insertion point: *Cancel*" and `answer` said no CE prompt was waiting, while AutoCAD was in fact still inside PIT (busy). A finding for the tooling worker: the CE-prompt test reads the log, which lags a waiting prompt.
4. **`ui close` on the docked Checks palette said `still_open = true` after 14 s** (the palette was gone a few minutes later). Guide should say: close the Checks palette with its own Close button, which is not yet on the allow-list.
5. **Small wording bug in the settings guard:** after one `settings-temp set` it prints "12 settings file(s) are backed up" while its own list shows one file.
6. **Cancel of PIT labels (Esc at both label questions) still places the pit** ("Pit placed successfully") with no label or cover text. Probably intended; Tim should know it is how a drafter gets an unlabelled pit.
7. The v2 verbs worked as designed here: `settings-temp set/status`, `settings-restore`, `ui set`, `ui press`, `pick-first`, `esc-prompt`, `shot`, `save-copy`, `reopen-copy -Force`, `quit` (with its built-in restore and hash check). Nothing was refused that should have worked, and nothing worked that should have been refused. The Defender false positive did not fire.

## D. What I did NOT test

1. CDTIDYLABELS Apply, its U and REDO, its timing, and locked layers (no fixture).
2. Any Structural tool. No Structural drawing was opened.
3. The double-click setting, CDRULES, the Pit Schedule cell values, CDSYNC's effect on pipe sizes (BUG-698), the label-text variant of BUG-650, a pit with a stored level in a strip+AGI drawing.
4. Whether the cascade question would appear on a freshly drawn pipe network.
5. Nothing was saved except the one `save-copy` of CLD92_B1, which is now deleted. Nothing in Tim's real drawings was opened.

## E. What Tim and the desk need to do

1. **Tim: nothing in AutoCAD.**
2. **Desk:** decide whether to keep the Checks Q4 flip (evidence: this report, Claude-seen); the other three Q4 rows stay without evidence. Hand the cascade (B14) and the tidy apply (B2) to Codex or to a fixture with a real label clash and a freshly drawn pipe network.
3. **Tooling worker:** items C3 and C4 (and C5, C6 for the guide).

**Built, tested, installed, accepted:** installed builds; tested here by a Claude robot in real AutoCAD 2027 on test copies; not Codex-accepted; not Tim-accepted.

AUTOCAD CLOSED
SETTINGS RESTORED
