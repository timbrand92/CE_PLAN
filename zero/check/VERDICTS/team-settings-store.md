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
