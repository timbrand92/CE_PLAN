# Verdict: team/settings-store-main at a08e421 (the per-drawing CE settings store, rebuilt on main)

**Verdict: HOLD. Four blockers, each reproduced on the bench with the proof saved. This is the first verdict on this branch: fix round one of two follows.** Written Fri 20 Nov 2026, about 7:40 pm. Checked on the bench only.

**Who checked.** Compile gate by the check room in its own worktree: the whole solution builds, the AutoCAD plug-in project included. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\set2_adv_REPORT.md`, proofs in `set2_adv_proofs\` (47 cases of its own: 24 pass, 23 fail). Honest check: Team helper, Claude Opus 5.5: still running at the time of writing (`set2_honest_REPORT.md`); a hold needs one true blocker and four are proven, so the answer is given now and the honest half is added at the foot when it lands. It can add to the list for this same round; it cannot turn four reproduced blockers into a merge. The dropped tip d6e718b was never given a verdict; its two reports were read as input only.

## 1. Counts seen

Eleven projects build, no warnings, no errors. Pretend drawing 687 of 687 pass; the bench 432 run and pass; all 14 settings tests pass, and each fails on at least one broken copy. Brain speed tests miss their one-second limit on main and on the tip alike under tonight's load. Eighteen files changed against main at 6d27628. There is no Settings window on this branch and nothing in the released tools calls save or reset yet.

## 2. Blockers

1. **Saving one setting can lose another, and can wipe a record that is not ours.** Save a cover gap of 533, let the next read of the record fail, save a number spacing of 617: the save reports success and the gap reads back as the office 400. Two valid edits interleaved lose one. Save and reset both discard a record of the same name that carries another owner or a newer format mark: an unreadable record is treated as empty, and reset removes by name. (An edit that loses drawing content: D-348, D-414.) Keep a record that cannot be verified, refuse in words, and make read, change and write one protected step.
2. **The store writes into a drawing whose units the tools refuse.** Save writes a record into inch, metre and unknown-unit drawings; reset on an unknown-unit drawing removes a saved value. (A hard limit: D-344, D-390, D-403, D-418.) The store itself asks the drawing's units at save and at reset, whoever calls it.
3. **An unusable saved distance reaches the sheet without a word.** A saved 0, or a value too small for its format, puts the pit number exactly on the pit centre; a saved 1e100 draws it that far away; a key written twice (617 then 21) draws at 21. No warning in any case. (The ruling built the opposite way: a damaged value falls back to the office value WITH a warning, R-36; the circle stays 150 mm clear of the pit, D-406 item 5.) Check each distance for what it is used for; refuse a record that says a thing twice.
4. **A missing or mislabelled office row gives a false distance, silently.** With the office row removed (or the whole office list missing) the number lands at an old built-in 900 with no warning; an office row changed to 0.9 with the unit m places the number 0.9 mm from the pit. (Tim's rule: every engineering value lives on Settings, none built in: R-34, R-36, rule 15.11, D-414.) Loading the office list checks that every row a tool needs is there and in its unit; a missing row stops the tool in words.

## 3. Not this branch's (owed by the Pit and Pipe builds before Stage 1 is released)

1. **The saved default pipe is not used.** With 100 mm, HDPE, 1 in 83 saved, a new pipe is labelled "100 DIA. UPVC PIPE AT 1 IN 100" (D-414 items 1 and 3).
2. **The saved cover gap is not used.** A drawing with 539 saved and one on the office 400 both place the cover level in the same spot (D-402 item 1).
The builder deferred both tool connections in writing. They go on the follow-up list against the Pit and Pipe builds; the store does not merge as "settings work" for those two until they are joined.

## 4. To fix in the same round

1. **The list of settings is short of D-419's draft list:** 8 of 16 are there (number spacing 900, cover gap 400, invert gap 200, slide 1,000, circle gap 150, pipe size 100, material UPVC, grade 1 in 100). Missing: the marker's size and its gap, the 50CONT layer and its 70 mm width, the CE NO PLOT layer name, the 0.02 drop, the 75 mm pipe-label distance, the 5 mm tolerance. Three rows no ruling lists are present (sump 0; the two mask factors 1.2 and 1.1): name the ruling or take them out. Only the number spacing is joined to a tool.
2. **One office change needs two files edited:** changing the office 900 to 837 moves new numbers but the tool list still says 900, and seven of the fourteen tests fail because they repeat the figure. One home for each figure (rule 15.11); tests read the office value, they do not repeat it.
3. **A text setting takes a number and a number reader takes text** (material "617" reads back as 617); a missing pair cannot be told from a setting never saved.
4. **The pit check now takes its expected spot from the same sum as the placing:** it can agree with a wrong sum. Give it its own.
5. **An empty reset must leave an empty drawing:** a variant that wrote a marker-only record on reset passed all 14 tests.

## 5. For the control room (no ruling found)

1. **The largest sensible distance** for each setting (a bound to refuse beyond).
2. **Typing today's office value:** if he types 900 while the office is 900 and the office later changes to 837, does this drawing stay at 900 ("set in this drawing") until reset? Recommended: yes.
3. **Copies:** does a whole-drawing WBLOCK carry the drawing's settings, and a selected-object copy leave the other drawing's alone? Recommended: yes to both; an older plug-in keeps keys it does not know.
4. **Default material when he then picks another size:** stay HDPE, or follow the size rule (150 gives UPVC SN8)?
(D-419's list and movement rule are items 7 and 8 in the decisions file; the brief called them 6 and 7.)

## 6. What held up

Two drawings open together keep separate values; a reopened drawing keeps its own; copying a pit and its labels leaves the other drawing's settings alone; there is no shared cache. Text, a decimal comma, a negative, blank, a wrong unit, NaN and overflow all fall back to the office figure WITH a warning. A plain read writes nothing. A changed setting moves nothing by itself: an existing tag, hand-moved or not, stays through a save and an ordinary edit; a new tag takes the new value (D-419 item 8).

## 7. Owed in AutoCAD (after a merge; nothing is run on Tim's PC under D-420)

Save, close, reopen; two drawings; Save As; a file copy; WBLOCK of part and of the whole; INSERT; xref reload; one Undo and one Redo of a save and of a reset; a failed save leaving nothing half-written; a read-only drawing; a newer record opened by an older plug-in; whether a plain read marks the drawing as changed; the real text spots and the plotted sheet. Recipes: `set2_adv_proofs\host-checks.md`.

## 8. Ruled since (control room, 7:38 pm, D-425, DRAFT)

1. **Every distance is more than 0 and no more than 10,000 mm.** Outside that, not a number, or a key written twice: refused with words naming the setting, and the office value is used. A missing or mislabelled office row STOPS the tool, naming the row; a distance is never invented. (Blockers 3 and 4 are fixed to this.)
2. **His typed 900 stays** when the office value later becomes 837, shown "set in this drawing", until "Back to office values".
3. **A whole-drawing WBLOCK carries the settings;** a part copy leaves the other drawing's alone.
4. **His saved HDPE stays when he picks 150:** his setting wins; the size rule applies only while the material is the office's.
5. **The store is not "built" until Pit and Pipe read every setting on D-419 item 7's list.** (So section 3 and section 4 item 1 are part of this job, not follow-ups.)

## 9. The honest half (landed about 8:05 pm): the halves split, the HOLD stands

Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\set2_honest_REPORT.md`. Its answer was MERGE, with this reasoning: it found the same faults (its follow-ups 1 to 6 are this page's blockers 1 to 4, at `CeSettingsStore.cs:59`, the adapter's write and remove, `OfficeSettings.cs:150`), but nothing in the released tools calls save or reset yet, so it judged them harmless today and said any branch that adds a caller must be held.

**Why the check room still holds:**

1. **Blocker 4 needs no save at all.** With the office row or the whole office list missing, the Pit tool draws the number at a built-in 900 with no words; an office row of 0.9 with the unit m draws 0.9 mm. That is on the read side, which the Pit tool calls today. (The honest check confirms the code: its follow-up 5.)
2. **A blocker is a fault that COULD lose drawing content** (D-346), and the store's save and reset are the thing being merged. Putting a save that wipes a record it cannot read onto the main line, on the promise that the next branch will be held, moves the fault, it does not close it.
3. **D-425 item 5:** the store is not "built" until Pit and Pipe read every setting; the honest check found the same eight missing and that only the number spacing is read by a tool.

**What the honest half adds for this same round (no extra strike):** its seven take-outs show the 14 tests are honest for what they cover (isolation, office fall-back, the source word, damage words each caught), but "Back to office values" taken out fails only one test; a newer version's record layout is read as damaged and then replaced WHOLE on the next save (part of blocker 1); two rows carry the wrong status (the 150 mm and 1,000 mm are Tim's rulings D-406 item 5 and D-405 item 5, not "the brief's figure"; the sump is D-406 item 8); the 75 mm label gap is still read straight from the tool list by the Pipe tool, outside the store; a damaged record prints its warning once for EVERY pit placed (say it once per command); the writer's report file should not be in the product tree.

**Two more questions for the control room:** (e) should each changed row have its own small reset as well as the one "Back to office values" button (D-414 names only the one)? (f) a drawing that already holds an entry of the same name that is not ours: refuse to save settings in it and say so (recommended; never overwrite)?

## 10. Ruled since (control room, 8:15 pm, D-429)

1. **The HOLD stands,** for the three reasons of section 9: "no caller yet" does not turn blockers 1 to 3 into follow-ups.
2. **DRAFT:** a small reset on each changed row, as well as the one "Back to office values" button.
3. **Not a draft:** a same-name entry in the drawing that is not ours is NEVER written to; saving is refused with words.


---

# Second verdict: team/settings-store-main at b495f5e (fix round one)

**Verdict: HOLD, on two blockers; and under D-425 item 5 the store is still not "built". Fix round two (the last) follows.** Written Fri 20 Nov 2026, about 11:56 pm. Checked on the bench only.

**Who checked, and how they split.** Honest: one Claude helper on Sonnet (D-434): `C:\CE_WORK\check\reports\set3_honest_REPORT.md`: MERGE (all four blockers closed; 8 of 16 settings read). Adversarial: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\set3_adv_REPORT.md`, proofs in `set3_adv_proofs\`: HOLD; all 47 earlier cases replayed. **Closed on the bench:** a save losing another setting or wiping a record not ours (blocker 1); writes into a refused-unit drawing (2); a missing or mislabelled office row (4); the saved default pipe and the saved cover gap now reach the drawing. Blocker 3 PARTLY.

## 12. Blockers

1. **A wrong cover verdict can reach the drafter.** With a valid older Job record holding a 17 mm tolerance and an unusable tolerance in the settings record, the Pipe window SAYS the office 5 mm applies, but its check uses 17 mm and calls 290 mm of cover against 300 mm "Suits". One tolerance, from one place, and the window says the one it uses (D-381, D-425 item 1).
2. **A numeric-looking material prints on the pipe:** "6,5" saved as the default material is taken as a material with no warning and the label reads "100 DIA. 6,5 PIPE AT 1 IN 100". A material must be one the office list knows, or refused in words with the office default used (D-425 item 1; the "617" case is fixed, this path is not).

## 13. D-425 item 5 (for the control room, not a blocker by D-346's words)

Eight of the sixteen settings have no reader in Pit or Pipe (the invert gap 200, the slide 1,000, the circle clearance 150, the marker's size and gap, the 50CONT layer and its 70 mm width, the CE NO PLOT layer name): saving or removing each changes nothing drawn. Both halves agree. Under D-425 item 5 the store is not "built" until Pit and Pipe read every one; most of the eight belong to the labels, marker and grips builds, which are not merged. The control room's call: merge the store when its own blockers close and mark it "built" only when those builds read the rest, or hold it until then.

## 14. To fix in the same round

`10000.0000000000001` saved for a distance is accepted and drawn at 10,000 mm (the number is rounded before the limit is checked): check the typed text against the limit; a part WBLOCK may carry the drawing's settings (the hook fires for every WBLOCK, D-425 item 3): owed in AutoCAD, first on that list.

## 15. Ruled since (control room, about 11:57 pm)

1. **The store may MERGE once its own blockers close** (both halves), and is marked "built" only when the labels, marker and grips builds read the other eight settings; each of those builds owes "reads its settings from the store" as a MERGE condition.
2. **ONE source for the tolerance: the store.** Nothing else may hold a tolerance (the older Job record included); blocker 1 of section 12 is fixed that way.


---

# Final verdict: team/settings-store-main at 83d1559 (its LAST fix round)

**Verdict: HOLD, with the one-page open list below. The last round (D-346): the control room decides.** Written Sat 21 Nov 2026, about 2:24 am. Checked on the bench only.

**Who checked, and how they split.** Honest: one Claude helper on Sonnet: `C:\CE_WORK\check\reports\set4_honest_REPORT.md`: MERGE (a legacy 17 mm Job record against a saved 12 gave 12 in both the window and the check; the numeric material and the over-limit distance refused; every earlier case replays clean; it listed every place in `src` and `bench` that holds or reads a tolerance). Adversarial: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\set4_adv_REPORT.md`, proofs in `set4_adv_proofs\`: HOLD; all 65 earlier cases run; two new routes still give a false pass. **Closed:** the older Job record no longer overrides the tolerance; "6,5" is refused with the office material used; the over-limit saved distance no longer draws at 10,000 mm.

## 16. The open list (the one-source ruling of section 15, not yet whole)

1. **Levels takes a second tolerance from an older pipe note, in the shipped set-up:** on a 150 mm pipe with 290 mm of cover against 300 mm, the drawing set to 5 mm and an older pipe note holding 17 mm, the Levels window uses 17 and passes it. One source: the store; an older note's tolerance is ignored (and said, once) (section 15 item 2).
2. **A mislabelled office row can make Pipe announce 5 mm and judge at 17:** the office-link check counts the link but accepts it on the wrong row (`Standards.cs:423`, `OfficeSettings.cs:107`, `CeSettingsStore.cs:66-78`). D-425 item 1: a missing or mislabelled office row STOPS the tool, naming the row.
3. **The Job window can save an over-limit entry as 10,000 mm:** "10000.0000…01" typed in the Job preview reopens at 10,000 (an ordinary 10,001 is refused). Check the typed text against the limit before rounding, on every input path, not only the saved record.

## 17. For the control room

1. **What next for the store?** Recommended: one bounded edit of exactly these three (they are narrow and all on the one-source rule), read back by the check room with one run; the alternative is the adversarial half's recommendation, a one-page design review of "one tolerance source" under D-346. The store is still not "built" (8 of 16 settings read), as section 15 already says.

## 18. Ruled since (control room, about 2:26 am)

ONE bounded edit of exactly the three items of section 16, with one addition: the edit ends with a source test that NO code outside the store reads, holds or defaults a tolerance, listing every caller. Read back with one run by the check room ("both of you": the check room reads it, and the Codex half re-runs its two routes). DRAFT: a tolerance found in an older pipe's note is NOT used; the drawing's setting governs and the window says so once. An over-limit typed entry is refused with words, never saved as 10,000 (D-425 item 1). If the read-back fails, a one-page design follows, no further edit.


---

# Read-back of the bounded edit: team/settings-store-main at fb7f944

**Answer: READ-BACK FAILS. Under section 18 the store now goes to a one-page design ("one tolerance source"), no further edit.** Written Sat 21 Nov 2026, about 3:42 am. Read back by the check room with the Codex reader re-running its routes (gpt-6.2-astra: `C:\CE_WORK\check\reports\setbe_adv_REPORT.md`, proofs in `setbe_adv_proofs\`). The whole solution builds, the plug-in included; the edit's own ten tests pass.

1. **Passes:** (b) a mislabelled office row now STOPS the tool and names it (D-425 item 1); (c) the over-limit Job entry is refused in words and the box keeps 5 mm.
2. **(a) Levels: the sum is right, the window is not:** with an older pipe note at 17 mm and the drawing at 5 mm, Levels now works 290 against 300 as Wrong and prepares the "older note not used" line once, but the window then stops on "unused pipe 1" before showing either (the same fault on 83d1559: it predates the edit, but the drafter still sees no verdict).
3. **The new source test misses all three ways tried:** a literal 5 written into the cover rules turned a valid 11 mm Suits into Wrong; a second settings key (`cover_margin_mm`) let Levels announce 5 mm and pass the shortfall at 17 mm; an optional method parameter defaulting to 5 mm made Levels announce 11 and judge at 5. The test passed each altered copy; it catches only a literal in the named tolerance sum. Its caller list also leaves out four uses of the Job edit the store returns (preview, commit, refusal text, save).
4. **What the design page must settle (recommended):** the store as the ONLY holder of the tolerance, proven by what the source test forbids (any tolerance-like number or key outside the store, in code, data and defaults) rather than by a list; the Levels one-pipe window showing its verdict; the four acceptance cases above.

---

# The rebuilt store: team/settings-store2 at 1cf1b53 (from SETTINGS_STORE.md 0ce96da), first round

**Verdict: HOLD. Both halves hold it.** Written Sat 21 Nov 2026, about 9:57 am. Both halves ran on Codex under D-441, with the four outside-reading test classes excluded:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\ss2_honest_REPORT.md`, evidence in `ss2_honest_evidence_1cf1b53\`.
- **Adversarial half:** gpt-6.2-astra. Report: `ss2_adv_REPORT.md`, with proofs in `ss2_adv_proofs\`.

The first launches died on the Codex runner fault (8:07 to 8:17 am) and were relaunched. The adversarial half's whole build stopped at the missing AutoCAD package; the other ten projects compiled.

**What works:**
- **The ordinary case:** 290 against 300 gives "Wrong, Short by 10 mm" at 5 mm and Suits at 11 mm.
- **The old 17 mm note:** it is ignored.
- **The renamed controls:** the six renamed controls are honest successors under named rulings (T7, T12, T13, T14, Job, "CL TBC").
- **The builder's claim:** the "43 again" claim mostly replays (41 by the same name, plus the renamed ones).

## Blockers

1. **A real clash shows as zero in Pipe** (honest half).
   - **The case:** at a saved tolerance of 0 mm, held inverts 5.300 and 5.204 over 10 m at 1 in 100 give a 4 mm clash. The solver says 4 mm, but the Pipe headline reads **"Out by 0.00"**.
   - **The cause:** the window re-formats the metre figure to two places itself, at `bench/CeCivil.Bench.Core/WindowModel.cs:332` and `windows/pipe.csv:35`, instead of using the rounding owner. Rulings: D-350, D-432.
2. **The source test misses swapped figures** (both halves). Each of these passed it:
   - a renamed helper using 75 mm after the approved 83 mm placement read (`PipeTool.cs:628`);
   - 17 mm substituted at the final cover comparison while the checker still returns 5 mm to the window (`Checks.cs:521`); 290 against 300 then wrongly passes;
   - a second write to the notice turning 5 mm into 17 mm;
   - one assignment capping the allowance at 17 mm (`Checks.cs:503`): 282 against 300 at a saved 20 mm then reads Wrong while still reporting 20 mm, and all 2,205 branch passes still pass;
   - a 17 mm record field: 290 against 300 shows Suits while the grey line says 5 mm.

   The test at `SettingsSourceAudit.cs:242, 269` follows only named references in selected methods. Rulings: D-419 item 7, D-439 item 4, D-440 item 2, page cases 2-4 and 7-9.
3. **A mislabelled office row still works instead of stopping the tool** (adversarial half).
   - **The case:** swap only the captions of the office diameter and tolerance rows. Typing 150 beside "levels and cover tolerance" then made new pipes 150 mm wide with 150 mm labels, while the tolerance stayed at 5 mm.
   - **Related:** unrelated text in the tolerance row's ruling and status fields still gives a verdict.
   - **The cause:** the validator only checks that words exist; the editor shows the captions but saves by the setting's identity. Files: `OfficeSettings.cs:165`, `CeSettingsWindow.cs:81, 114`. Ruling: D-425 item 1.
4. **Pipe hides the decided cover verdict** (adversarial half).
   - **At 11 mm:** both cover checks return Suits and the grey line says 11 mm, but no visible Pipe text says Suits. The card keeps up to two adverse results from other checks.
   - **With cover missing:** neither window shows the required "Cannot check yet" cover answer.

   Files: `pipe.csv:64`, `WindowModel.cs:1938`. Rulings: page cases 1 and 7, D-439, D-440.
5. **One-pipe Levels treats an ordinary end pit as the council connection** (honest half).
   - **The case:** in a drawing of two pits and one pipe, the downstream pit is drawn as a council connection, and its worked 5.21 m invert is called "given" in the preview.
   - **Why it matters:** if the drafter holds that field, OK writes it back as the last pipe's invert. The model makes the last object the connection without checking.
   - **Rulings:** D-350, D-413, and the page's "real parts and sources". This predates the branch, but the branch's new one-pipe path reaches it.
6. **A test that passes on main fails here** (both halves). `StyleKitTests.Every_part_and_the_sample_window_keep_their_layout_facts_from_the_tokens` still expects the old "0.12" wording, where the window now correctly shows 120 mm. Restate it to the ruling (D-440), or fix it.

**Next:** each item comes over as a failing test first, in round 1 of 2.
