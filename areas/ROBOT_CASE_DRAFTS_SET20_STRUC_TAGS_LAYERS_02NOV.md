# Robot case drafts, SET 20: Structural bearer tags, layers and RD (Mon 2 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** Four robot cases, each with a broken twin, drafted on paper for fixes #1895, #1906, #1912 and #1907. The other two fixes (#1913 and #1918) cannot be driven by the robot, so they have Codex looks instead. Nothing was built, run, installed or opened in AutoCAD. No case file was created in the cases folder: the only file written is this one. No git write.

---

## FOR TIM

1. **4 robot cases drafted, each with a broken twin (8 case texts).** W1895 (a new bearer size gets the next free BR mark), W1906 (CSTAGBEARERS adds only a label, and Esc during THCL leaves nothing behind), W1912 (CSTAGBEARERS refuses a locked 25TEXT), W1907 (RD asks for the arc or circle first).
2. **Codex-only (BLOCKED-FOR-ROBOT, 2 fixes).** #1913 (a mistyped layer lineweight) and #1918 (Apply CE Standard Layers). Both need the CE Admin Settings "Drawing Layers" window, which the robot's press list does not include, and #1913 also needs a typed table cell and a "Save Layer Changes" button the robot refuses. Codex looks are below.
3. **Needs an Opus review BEFORE it is run (locked layer):** W1912, and the #1918 Codex look. Neither case unlocks anything: W1912 locks a layer on a throw-away copy and the copy is never unlocked or saved.
4. **Example of what W1912 checks.** Tag one bearer normally (it works). Lock layer 25TEXT. Tag a second bearer. Right = the command line says "Layer 25TEXT is locked" and nothing new is drawn. The twin turns the fix's own switch off and must fail.
5. **Not run until a Structural build with these fixes is installed.** The installed Structural bundle is dated 27 Oct; these six fixes are still open pull requests. Until then every case would show the OLD behaviour, so a run now would only repeat the red twins.
6. **Could NOT verify:** that the robot AutoCAD loads the Structural bundle in the case session (the folder is installed, but I did not open AutoCAD); that the full-path SETTING line is accepted by the runner (the same doubt as SET18); the exact wording of the locked-layer line.
7. **Not proven by anything here:** every printed line marked DERIVED was read from the PR code or text, not seen on a run. The robot cannot see a drawing, so none of these says how anything looks.
8. **Nothing for you to test or decide now.** All six bug entries stay OPEN.

---

## 1. How the drafts were written

1. **What I read.** `C:\TimOS\RULES.md`; `README_CASES.md` in full (including the refused-button list); `acad_driver_v3.allowlist.json`; the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` and the Structural draft set `ROBOT_CASE_DRAFTS_SET18_STRUC_FOOTINGS_02NOV.md` (same day, same Structural settings problem); `R09s_new_switch_off_broken`; `R23` (locked layer set up with `_.-LAYER _LOCK`); `S467a` and `CASE_WRITING_STRUC_REPORT_30OCT.md`; the six PR texts (`gh pr view`) and the diffs of #1912 and #1906; the PR branch code for `TimberSubfloorService.cs` (CSTAGBEARERS), `CeTextService.cs` (THCL) and `DimensionCommands.cs` (RD), read with `git show` only; the carpark entries by line; `BUGFIX_x1`, `BUGFIX_s11` and `BUGFIX_s15` reports.
2. **Is there already a case? No, checked again.** Searched the whole cases folder (including every `drafts_*` folder) for the bug numbers, the PR numbers, `CSTAGBEARERS`, `CSSUBFLOORGRID` and the names W1895, W1906, W1907, W1912, W1913, W1918: no hit. Searched `ROBOT_CASE_DRAFTS_*.md`: only SET18 mentions BUG-1200, and only to say the Escape case is NOT driven there. The ledger holds no case for any of them (its only hits were hex strings that happen to contain a number). So all six are open for drafting.
3. **Fixture.** DRV2_S1 (the Structural copy, exists in `C:\ce_rc_drv`), not DRV1_B1: the same choice SET18 and the 30 Oct Structural cases made. DRV1_B1 is a Civil drawing. Empty ground used: x 28000 to 38000, y -22000 to -4000 (east of the four pads and of the S467 test area at 17000 to 21000, -3300). If a first run shows an object there, move every case together.
4. **Switch twins.** Each twin sets the PR's own switch OFF before AutoCAD starts, with the FULL path (`%APPDATA%\CE_STRUC_SUITE\CS_Settings.json`), because a bare `CS_Settings.json` expands to the Civil folder. UNPROVEN, as in SET18: nobody has run that path. If the runner refuses it the twin comes back BLOCKED, not red. Fallback route twins are named under each case. No twin has `hashes-unchanged`. Main cases start with `settings-arm`; twins do not (their SETTING line uses the guard).
5. **Switch names, read from the PR code.** `TimberSubfloor.MarksReadTextLayer` (#1895, confirmed in the PR text and code), `TimberSubfloor.TagBearersLabelOnly` and `FootingWidth.RectTextCommitsOnceAccepted` (#1906, confirmed in `S8NewSwitchDefaultsTests`), `TimberSubfloor.LockedLayerRefusesTagging` (#1912, confirmed in `UserSettings.cs`), `Annotation.ArcDimSelectsGeometryFirst` (#1907, confirmed in the PR text and `DimensionCommands.cs`).
6. **The prompts.** CSTAGBEARERS asks (from the #1906 branch code): "Select a hand-drawn bearer (line or polyline), or press Enter to finish:", then "Bearer size/species for the selected bearer(s) <...>:", then "Also place stump/pier supports? [Yes/No] <No>:", then a "Preview:" line and "Apply these tags? [Yes/No] <No>:". In #1912 the locked-layer check sits AFTER the stump question and BEFORE the Preview line, so a chain that ends at "No" is complete when the layer is locked. THCL (from the #1906 branch): base text, "Add column over text? [Y/N] <N>:", "Enter X size (width):", "Enter Y size (height) <same as X>:", "Specify insertion point (center):", then (square pad, so no rotation question) "Pick desired text insertion point:". RD (from the #1907 branch): "Select arc or circle to dimension [?]:", then "Dimension type [Length/Radius/Diameter] <...>:" for an arc and "[Radius/Diameter]" for a circle. All DERIVED, not seen on a run.
7. **Typing rules obeyed.** Every `type` chain is a complete command, no `(`, no SAVE-type word, no trailing `{NL}` that would make a second Enter repeat the last command. Lines are drawn by typed coordinates, then picked by a typed point inside a zoomed view (README batch 3 item 3). `REVIEWED_AGAINST` is left empty. Order numbers 890 to 897. `SLOT fresh`.
8. **No protection is bypassed.** No case unlocks a layer, touches an Xref, uses REFEDIT or goes around anything. W1912 locks one layer on the session copy with AutoCAD's own `_.-LAYER _LOCK` (the R23 form) and never unlocks it.
9. **To validate offline:** copy each block to its file name in a new folder (suggested `cases\drafts_struc_tags_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. I did not run this.

---

## 2. The case texts

### Case 1 of 4: W1895, a new bearer size gets the next free BR mark (#1895, BUG-1184)

**Intended file:** `W1895_new_bearer_size_next_br_mark.case.txt`

```
# BUILD PENDING: needs a Structural build that contains #1895 (branch claude/p13-bug1184-bearer-marks on origin/claude/rel-20261026s). On the installed 1.0.125 this case is the old fault and fails.
# W1895 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1895 (BUG-1184), switch TimberSubfloor.MarksReadTextLayer, default ON.
# Route: three hand-drawn bearers, CSTAGBEARERS run three times: 150x50 F17, 200x75 F17, 150x50 F17. The PR says the labels must read BR1, BR2, BR1. Before the fix every run restarted at 1 because it read the bearer layer while the labels are written on 25TEXT.
# DERIVED (from the PR code, not seen on a run): the prompt order described in the set's part 1 item 6; that the label text reads 'BR1 150x50 F17' (the PR text and the SubfloorMarkScanRules.TryParseLabel pattern give 'BR<n> <size>'); the final line 'Tagged 1 bearer(s)'. The text is read from whatever label object CE draws (TEXT or MTEXT): the select reads the 'text' field.
CASE W1895
TITLE Three CSTAGBEARERS runs with 150x50 F17, 200x75 F17, 150x50 F17 give the labels BR1, BR2, BR1 (a new size gets the next free mark, a repeated size keeps its mark)
PLAN_ITEM BUG-1184 (PR #1895) PART: bearer marks in one drawing session through CSTAGBEARERS. NOT whole: CSSUBFLOORGRID, stump and pier SPR marks, save and reopen, and the two-sizes-on-one-mark warning line are not driven (see NOT_AUTOMATED)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 890
TIMEOUT 900
BUG BUG-1184
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED Run 1 adds the label BR1 150x50 F17, run 2 adds BR2 200x75 F17, run 3 adds a second BR1 150x50 F17 (so two labels read BR1 150x50 F17 and one reads BR2 200x75 F17), and no label reads BR1 200x75. Each run ends with a 'Tagged 1 bearer(s)' line. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests pin the scan rule; only a real CSTAGBEARERS shows which labels the live commands write and which layer they read back.
NOT_AUTOMATED CSSUBFLOORGRID, stump and pier SPR marks, save and reopen (README: CE never saves, the runner will not), and the warning line for a mark already shared by two sizes.
NOT_AUTOMATED The text position and look of the labels (recorded, not judged).
STEPS
  settings-arm
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm
  type "_.ZOOM{NL}_W{NL}28000,-22000{NL}36000,-8000" -Force
  wait
  type "_.LINE{NL}30000,-10000{NL}33000,-10000" -Force
  wait
  type "_.LINE{NL}30000,-12000{NL}33000,-12000" -Force
  wait
  type "_.LINE{NL}30000,-14000{NL}33000,-14000" -Force
  wait
  ms-count -> $c0
  type "CSTAGBEARERS{NL}31500,-10000{NL}{NL}150x50 F17{NL}No{NL}Yes" -Force -TimeoutSec 120 -> $r1
  wait
  type "CSTAGBEARERS{NL}31500,-12000{NL}{NL}200x75 F17{NL}No{NL}Yes" -Force -TimeoutSec 120 -> $r2
  wait
  type "CSTAGBEARERS{NL}31500,-14000{NL}{NL}150x50 F17{NL}No{NL}Yes" -Force -TimeoutSec 120 -> $r3
  wait
  ms-new $c0 -> $new
  select $new "text~BR1 150x50 F17" -> $br1
  select $new "text~BR2 200x75 F17" -> $br2
  select $new "text~BR1 200x75" -> $bad
  field $br1 text -All -> $br1_text
  field $br2 text -All -> $br2_text
ASSERT
  count $br1 = 2
  count $br2 = 1
  count $bad = 0
  history count "Tagged 1 bearer(s)" = 3
  copy-unchanged $copy0
  record $r1 "FULL run 1 (each question, the Preview line, to see whether the chain stayed in step)"
  record $r2 "FULL run 2"
  record $r3 "FULL run 3"
  record $br1_text "every label reading BR1 150x50 F17"
  record $br2_text "every label reading BR2 200x75 F17"
```

**Weak point.** If the first run shows a different Preview or label wording (for example no space, or a trailing text), change the three `text~` patterns to what the `record` lines printed. If the chain goes out of step, the `$r1` record shows where.

**Twin:** `W1895_BROKEN_switch_off.case.txt`

```
# W1895_BROKEN DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1895: the PR's own switch TimberSubfloor.MarksReadTextLayer set OFF before AutoCAD starts, so the scan reads the bearer layer only (the old behaviour) and every run starts again at BR1. Same route, same checks.
# UNPROVEN: the SETTING line uses the FULL path because a bare CS_Settings.json expands to the Civil folder. If the runner refuses the path or the key, this comes back BLOCKED. Fallback route twin: run only the first and third CSTAGBEARERS with the 200x75 F17 run left out and expect BR2 anyway (it cannot appear). Do NOT add hashes-unchanged.
# Expected red: 'count $br2 = 1' (no BR2 label appears) and 'count $bad = 0' (the 200x75 label reads BR1). The route checks (three 'Tagged 1 bearer(s)' lines) still pass, which shows CSTAGBEARERS itself ran.
CASE W1895_BROKEN
TITLE BROKEN VARIANT of W1895: the marks-read-25TEXT switch OFF, so every run restarts at BR1 (must FAIL)
PLAN_ITEM red-before-green proof for W1895 (BUG-1184, PR #1895)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 891
TIMEOUT 900
BUG BUG-1184
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1895
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json TimberSubfloor.MarksReadTextLayer false
REVIEWED_AGAINST
EXPECTED Same checks as W1895. With the switch OFF the 200x75 F17 bearer is also called BR1, so the BR2 check and the no-BR1-200x75 check fail.
WHY_NOT_UNIT_TEST It exists only to prove W1895's checks can go red.
NOT_AUTOMATED As W1895.
STEPS
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm
  type "_.ZOOM{NL}_W{NL}28000,-22000{NL}36000,-8000" -Force
  wait
  type "_.LINE{NL}30000,-10000{NL}33000,-10000" -Force
  wait
  type "_.LINE{NL}30000,-12000{NL}33000,-12000" -Force
  wait
  type "_.LINE{NL}30000,-14000{NL}33000,-14000" -Force
  wait
  ms-count -> $c0
  type "CSTAGBEARERS{NL}31500,-10000{NL}{NL}150x50 F17{NL}No{NL}Yes" -Force -TimeoutSec 120 -> $r1
  wait
  type "CSTAGBEARERS{NL}31500,-12000{NL}{NL}200x75 F17{NL}No{NL}Yes" -Force -TimeoutSec 120 -> $r2
  wait
  type "CSTAGBEARERS{NL}31500,-14000{NL}{NL}150x50 F17{NL}No{NL}Yes" -Force -TimeoutSec 120 -> $r3
  wait
  ms-new $c0 -> $new
  select $new "text~BR1 150x50 F17" -> $br1
  select $new "text~BR2 200x75 F17" -> $br2
  select $new "text~BR1 200x75" -> $bad
  field $br1 text -All -> $br1_text
ASSERT
  count $br1 = 2
  count $br2 = 1
  count $bad = 0
  history count "Tagged 1 bearer(s)" = 3
  record $r2 "FULL run 2 with the switch OFF"
  record $br1_text "labels reading BR1 150x50 F17"
```

---

### Case 2 of 4: W1906, CSTAGBEARERS adds only a label, and Esc during THCL leaves nothing behind (#1906, BUG-1185 and BUG-1200)

**Intended file:** `W1906_tag_label_only_and_thcl_esc_leaves_nothing.case.txt`

```
# BUILD PENDING: needs a Structural build that contains #1906 (branch claude/s8-bug1185-1200 on origin/claude/rel-20261026s). On the installed 1.0.125 this case is the old fault and fails.
# W1906 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1906 (B-084, BUG-1185 and BUG-1200), switches TimberSubfloor.TagBearersLabelOnly and FootingWidth.RectTextCommitsOnceAccepted, both default ON.
# Part A (BUG-1185): one hand-drawn bearer line is picked TWICE in one CSTAGBEARERS run. Right: one 'already selected' line, one label, NO second line drawn on top. Old: two picks counted, a second Line per pick plus a label.
# Part B (BUG-1200): THCL 91, no column, 600 x 600 (square, so no rotation question), centre 22000,-12000, then Esc at 'Pick desired text insertion point:'. Right: nothing in the drawing, and the 600 size is NOT saved, so the next THCL 91 asks 'Enter X size (width):' again. Old: the outline is left and the size is kept, so the next THCL 91 goes straight to 'Specify insertion point (center):'.
# DERIVED (from the PR branch code, not seen on a run): every prompt in the chains; the line 'That bearer is already selected. It will be tagged once.' (TimberSubfloorService.cs on the PR branch); that a square pad skips the rotation question (isRectangular false when X = Y). UNCONFIRMED: where THCL keeps the saved size and that nothing else in the drawing changes at Esc. The count of objects is read, not a layer.
CASE W1906
TITLE CSTAGBEARERS with one bearer picked twice adds one label and no extra line; THCL 91 600 x 600 ended with Esc at the text point adds nothing and a second THCL 91 asks the X size again
PLAN_ITEM BUG-1185 and BUG-1200 (PR #1906) PART: picked-twice and label-only for a STRAIGHT bearer, and Esc at the text point of THCL. NOT whole: a bent bearer (label on the bend, not across the chord), the other THCL-family commands (THCR, BTHCL, BTHCR, PFCL, PFCR, BPFCL, BPFCR), a rectangular pad rotated 30 degrees, and the look of the temporary outline are not driven (see NOT_AUTOMATED)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 892
TIMEOUT 900
BUG BUG-1185
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED Part A: picking the one bearer twice prints 'That bearer is already selected. It will be tagged once.'; no new Line is added (the bearer is the only line); exactly one label reading BR1 150x50 F17 is added. Part B: after THCL 91, N, 600, Enter, centre, and Esc, the object count is the same as before THCL; the next THCL 91 and N stops at 'Enter X size (width):' and not at 'Specify insertion point (center):'; after Esc again the object count is still the same. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests pin the pure rules and the order of the source lines; only a live CSTAGBEARERS and a live THCL with a real Escape show what is left in the drawing.
NOT_AUTOMATED A bent bearer, THCR, BTHCL, BTHCR, PFCL, PFCR, BPFCL, BPFCR, a rotated rectangular pad (needs a rotation answer, not driven), the temporary outline on screen (a Codex look), and Undo.
NOT_AUTOMATED The exact side-pick wording is DERIVED; it is recorded.
STEPS
  settings-arm
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm
  type "_.ZOOM{NL}_W{NL}20000,-22000{NL}36000,-8000" -Force
  wait
  type "_.LINE{NL}30000,-10000{NL}33000,-10000" -Force
  wait
  ms-count -> $c0
  type "CSTAGBEARERS{NL}31500,-10000{NL}31500,-10000{NL}{NL}150x50 F17{NL}No{NL}Yes" -Force -TimeoutSec 120 -> $tag
  wait
  ms-new $c0 -> $newtag
  select $newtag "object=AcDbLine" -> $newlines
  select $newtag "text~BR1 150x50 F17" -> $labels
  ms-count -> $c1
  type "THCL{NL}91{NL}N{NL}600{NL}{NL}22000,-12000" -Force -TimeoutSec 120 -> $th1
  esc-prompt -> $th1e
  wait
  ms-count -> $c2
  type "THCL{NL}91{NL}N" -Force -TimeoutSec 120 -> $th2
  esc-prompt -> $th2e
  wait
  ms-count -> $c3
ASSERT
  contains $tag "That bearer is already selected. It will be tagged once."
  count $newlines = 0
  count $labels = 1
  history has "Tagged 1 bearer(s)"
  contains $th1 "Pick desired text insertion point:"
  equals $c2 $c1
  contains $th2 "Enter X size (width):"
  not-contains $th2 "Specify insertion point (center):"
  equals $c3 $c1
  copy-unchanged $copy0
  record $tag "FULL CSTAGBEARERS with the bearer picked twice"
  record $newtag "every object the tag run added"
  record $th1 "FULL first THCL up to the text point"
  record $th1e "FULL what Esc printed after the first THCL"
  record $th2 "FULL second THCL 91 (the size memory check)"
```

**Known weak points.** If the first THCL chain goes out of step (for example DRV2_S1 already remembers a size for the TH bucket), `$th1` shows it; change the `600` and the blank Enter to what the prompts really ask. If CE draws no label object that `select` can read as `text`, part A shows `count $labels = 0` and `$newtag` shows what was drawn.

**Twin:** `W1906_BROKEN_switch_off.case.txt` (both of the PR's switches OFF before AutoCAD starts)

```
# W1906_BROKEN DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1906: BOTH of the PR's own switches (TimberSubfloor.TagBearersLabelOnly and FootingWidth.RectTextCommitsOnceAccepted) set OFF before AutoCAD starts, so CSTAGBEARERS counts both picks and draws a second line, and THCL saves the size at once and leaves its outline on Esc. Same route, same checks.
# UNPROVEN: the SETTING lines use the FULL path because a bare CS_Settings.json expands to the Civil folder. If the runner refuses the path or a key, this comes back BLOCKED. Fallback route twin: none that keeps both halves; run the two halves as two cases instead.
# Expected red: 'contains $tag "That bearer is already selected..."', 'count $newlines = 0', 'count $labels = 1', 'equals $c2 $c1', 'contains $th2 "Enter X size (width):"' and 'equals $c3 $c1'. The route checks ('Tagged 1 bearer(s)' present, the first THCL reaching 'Pick desired text insertion point:') still pass.
CASE W1906_BROKEN
TITLE BROKEN VARIANT of W1906: both PR switches OFF, so the picked-twice bearer gets extra lines and THCL Esc leaves an outline and a saved size (must FAIL)
PLAN_ITEM red-before-green proof for W1906 (BUG-1185 and BUG-1200, PR #1906)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 893
TIMEOUT 900
BUG BUG-1185
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1906
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json TimberSubfloor.TagBearersLabelOnly false
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json FootingWidth.RectTextCommitsOnceAccepted false
REVIEWED_AGAINST
EXPECTED Same checks as W1906. With the switches OFF the second pick is counted and a Line is drawn per pick, THCL leaves its outline at Esc, and the next THCL 91 skips the size question, so six checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1906's checks can go red.
NOT_AUTOMATED As W1906.
STEPS
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm
  type "_.ZOOM{NL}_W{NL}20000,-22000{NL}36000,-8000" -Force
  wait
  type "_.LINE{NL}30000,-10000{NL}33000,-10000" -Force
  wait
  ms-count -> $c0
  type "CSTAGBEARERS{NL}31500,-10000{NL}31500,-10000{NL}{NL}150x50 F17{NL}No{NL}Yes" -Force -TimeoutSec 120 -> $tag
  wait
  ms-new $c0 -> $newtag
  select $newtag "object=AcDbLine" -> $newlines
  select $newtag "text~BR1 150x50 F17" -> $labels
  ms-count -> $c1
  type "THCL{NL}91{NL}N{NL}600{NL}{NL}22000,-12000" -Force -TimeoutSec 120 -> $th1
  esc-prompt -> $th1e
  wait
  ms-count -> $c2
  type "THCL{NL}91{NL}N" -Force -TimeoutSec 120 -> $th2
  esc-prompt -> $th2e
  wait
  ms-count -> $c3
ASSERT
  contains $tag "That bearer is already selected. It will be tagged once."
  count $newlines = 0
  count $labels = 1
  history has "Tagged 1 bearer(s)"
  contains $th1 "Pick desired text insertion point:"
  equals $c2 $c1
  contains $th2 "Enter X size (width):"
  not-contains $th2 "Specify insertion point (center):"
  equals $c3 $c1
  record $newtag "every object the tag run added with the switch OFF"
  record $th2 "FULL second THCL 91 with the switch OFF"
```

---

### Case 3 of 4: W1912, CSTAGBEARERS refuses a locked 25TEXT (#1912, BUG-1186). LOCKED-LAYER ITEM: OPUS REVIEW BEFORE IT IS RUN

**Intended file:** `W1912_cstagbearers_refuses_locked_25text.case.txt`

```
# BUILD PENDING: needs a Structural build that contains #1912 (branch claude/s15-bug1186 on origin/claude/rel-20261026s). On the installed 1.0.125 this case is the old fault and fails.
# W1912 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). LOCKED-LAYER ITEM: needs an Opus review before it is run (native protection rule). PR #1912 (B-091, BUG-1186), switch TimberSubfloor.LockedLayerRefusesTagging, default ON.
# Route: tag bearer 1 with 25TEXT unlocked (proves the route works and creates the layer), lock 25TEXT with AutoCAD's own _.-LAYER _LOCK (the R23 form), tag bearer 2. Right: the second run says Layer 25TEXT is locked, CE drew no bearer tags, nothing changed, and adds nothing. CE must NOT unlock the layer: this case never unlocks it and never reads it back as unlocked; the refusal itself is the proof (CE would not have refused had it unlocked the layer), as in R23.
# DERIVED (from the PR code and text, not seen on a run): the refusal line '[CSTAGBEARERS] Layer 25TEXT is locked, so CE drew no bearer tags. Unlock it and try again. Nothing changed.' (the exact words of LayerService.LockedLayerLine are DERIVED from the PR text, so only 'Layer 25TEXT is locked' is asserted); that the refusal comes after the stump question and before the Preview line (TimberSubfloorService.cs on the PR branch); that 25TEXT is created by the first tag run.
CASE W1912
TITLE With 25TEXT locked, CSTAGBEARERS says layer 25TEXT is locked and draws nothing; the same command with 25TEXT unlocked tagged the first bearer normally
PLAN_ITEM BUG-1186 (PR #1912) PART: CSTAGBEARERS on a locked 25TEXT, bearers only (No to stumps). NOT whole: CSSUBFLOORGRID, a locked BEARERS - SUBFLOOR layer, and a locked STUMPS AND PIERS layer with stumps placed are not driven (see NOT_AUTOMATED)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 894
TIMEOUT 900
BUG BUG-1186
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED Tag run 1 (25TEXT unlocked) ends 'Tagged 1 bearer(s)' and adds objects. After 25TEXT is locked, tag run 2 prints a line holding 'Layer 25TEXT is locked', prints no 'Preview:' line, and the object count does not change. The layer is still locked at the end (shown only by the refusal itself). The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests use a stand-in for the lock test; only AutoCAD's real layer lock and the real CSTAGBEARERS show whether the command stops before it writes.
NOT_AUTOMATED CSSUBFLOORGRID (its floor outline and joist direction need more picks), a locked BEARERS - SUBFLOOR layer, a locked STUMPS AND PIERS layer with stumps placed, and an Xref layer.
NOT_AUTOMATED That the layer is STILL locked afterwards is shown only by the refusal; the lock flag itself is not read (as in R23).
STEPS
  settings-arm
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm
  type "_.ZOOM{NL}_W{NL}28000,-22000{NL}36000,-8000" -Force
  wait
  type "_.LINE{NL}30000,-10000{NL}33000,-10000" -Force
  wait
  type "_.LINE{NL}30000,-12000{NL}33000,-12000" -Force
  wait
  ms-count -> $c0
  type "CSTAGBEARERS{NL}31500,-10000{NL}{NL}150x50 F17{NL}No{NL}Yes" -Force -TimeoutSec 120 -> $ta
  wait
  ms-count -> $c1
  type "_.-LAYER{NL}_LOCK{NL}25TEXT{NL}{NL}" -Force -> $lock
  wait
  type "CSTAGBEARERS{NL}31500,-12000{NL}{NL}150x50 F17{NL}No" -Force -TimeoutSec 120 -> $tb
  esc-prompt -> $tbe
  wait
  ms-count -> $c2
  windows-snapshot -> $win_end
ASSERT
  contains $ta "Tagged 1 bearer(s)"
  history count "Tagged 1 bearer(s)" = 1
  history has "Layer 25TEXT is locked"
  not-contains $tb "Preview:"
  equals $c2 $c1
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $ta "FULL tag run 1 (25TEXT unlocked)"
  record $lock "FULL what the layer lock said"
  record $tb "FULL tag run 2 (25TEXT locked)"
  record $tbe "FULL what Esc printed after tag run 2"
```

**Known weak point.** `contains $ta "Tagged 1 bearer(s)"` reads the type reply; if the reply is cut before that line, the `history count` check is the real one. If the first-run chain goes out of step, `$ta` shows it and the case is a set-up problem, not a fault in CE. The lock chain `_.-LAYER _LOCK 25TEXT` fails quietly if 25TEXT did not exist (tag run 1 creates it).

**Twin:** `W1912_BROKEN_switch_off.case.txt`

```
# W1912_BROKEN DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1912: the PR's own switch TimberSubfloor.LockedLayerRefusesTagging set OFF before AutoCAD starts, so CSTAGBEARERS goes on to its Preview line with 25TEXT locked (the old behaviour: it would write on the locked layer). Same route, same checks. This twin does NOT unlock anything: 25TEXT stays locked. The chain ends at the stump answer, so the command waits at its Preview and 'Apply these tags?' question and Esc cancels it: nothing is written, which is why the object-count check passes here and only the refusal and Preview checks go red.
# UNPROVEN: the SETTING line uses the FULL path because a bare CS_Settings.json expands to the Civil folder. If the runner refuses the path or the key, this comes back BLOCKED. Fallback route twin: none (the old behaviour needs the switch).
# Expected red: 'history has "Layer 25TEXT is locked"' and 'not-contains $tb "Preview:"'. The route checks (run 1 tagged, the lock, the object count) still pass.
CASE W1912_BROKEN
TITLE BROKEN VARIANT of W1912: the locked-layer switch OFF, so CSTAGBEARERS does not refuse a locked 25TEXT (must FAIL)
PLAN_ITEM red-before-green proof for W1912 (BUG-1186, PR #1912)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 895
TIMEOUT 900
BUG BUG-1186
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1912
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json TimberSubfloor.LockedLayerRefusesTagging false
REVIEWED_AGAINST
EXPECTED Same checks as W1912. With the switch OFF there is no refusal line and the second run prints its Preview line, so two checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1912's checks can go red.
NOT_AUTOMATED As W1912.
STEPS
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm
  type "_.ZOOM{NL}_W{NL}28000,-22000{NL}36000,-8000" -Force
  wait
  type "_.LINE{NL}30000,-10000{NL}33000,-10000" -Force
  wait
  type "_.LINE{NL}30000,-12000{NL}33000,-12000" -Force
  wait
  ms-count -> $c0
  type "CSTAGBEARERS{NL}31500,-10000{NL}{NL}150x50 F17{NL}No{NL}Yes" -Force -TimeoutSec 120 -> $ta
  wait
  ms-count -> $c1
  type "_.-LAYER{NL}_LOCK{NL}25TEXT{NL}{NL}" -Force -> $lock
  wait
  type "CSTAGBEARERS{NL}31500,-12000{NL}{NL}150x50 F17{NL}No" -Force -TimeoutSec 120 -> $tb
  esc-prompt -> $tbe
  wait
  ms-count -> $c2
  windows-snapshot -> $win_end
ASSERT
  contains $ta "Tagged 1 bearer(s)"
  history count "Tagged 1 bearer(s)" = 1
  history has "Layer 25TEXT is locked"
  not-contains $tb "Preview:"
  equals $c2 $c1
  not-contains $win_end "Creative Engineering"
  record $tb "FULL tag run 2 with the switch OFF"
  record $tbe "FULL what Esc printed after tag run 2"
```

---

### Case 4 of 4: W1907, RD asks for the arc or circle first (#1907, BUG-640)

**Intended file:** `W1907_rd_picks_arc_or_circle_first.case.txt`

```
# BUILD PENDING: needs a Structural build that contains #1907 (branch claude/s11-dim-arc on origin/claude/rel-20261026s). On the installed 1.0.125 RD asks the type first and this case fails.
# W1907 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1907 (B-087, BUG-640), switch Annotation.ArcDimSelectsGeometryFirst, default ON.
# Route: a circle (centre 30000,-9000, radius 1000) and a three-point arc (34000,-9000 through 35000,-8000 to 36000,-9000) are drawn by typed commands. RD is typed, the circle is picked at 31000,-9000, and the case reads the type question, then ends it with Esc BEFORE any type is chosen (so RD saves nothing and places no dimension). The same for the arc at 35000,-8000, and Esc at the first question.
# DERIVED (from the PR branch code, not seen on a run): 'Select arc or circle to dimension [?]:', 'Dimension type [Radius/Diameter] <...>:' for a circle, 'Dimension type [Length/Radius/Diameter] <...>:' for an arc, and the OLD first question 'Dimension arc type [Length/Radius/Diameter/?] <...>:'. The default inside the angle brackets depends on the last type used (not read here). RD saves the chosen type to the settings only after a type is chosen, so Esc at the type question writes nothing; settings-arm restores by hash anyway.
CASE W1907
TITLE RD asks Select arc or circle first, then offers Radius and Diameter for a circle and Length, Radius and Diameter for an arc; Esc places nothing
PLAN_ITEM BUG-640 (PR #1907) PART: the order of the questions and which types are offered. NOT whole: that AutoCAD accepts the already-picked arc or circle and shows its normal preview and placement, the polyline-arc route, a placed dimension and its measurement, and one Undo (all need a placement click after the type is chosen; see NOT_AUTOMATED)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 896
TIMEOUT 900
BUG BUG-640
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED RD prints 'Select arc or circle to dimension' first. Picking the circle then prints a type question that offers Radius and Diameter only; picking the arc prints one that offers Length, Radius and Diameter. Esc at each ends RD. The old first question 'Dimension arc type' never appears. The object count does not change after the circle and arc are drawn, and the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests pin the type policy; only the live RD shows the order of the questions and what AutoCAD does with an object handed to it.
NOT_AUTOMATED Choosing a type and placing the dimension (the placement click after the preview), that AutoCAD accepts the pre-picked object, a polyline arc segment, one U afterwards, and the default type shown after one has been used. Codex look below is not needed for the order; the placement half needs a person or a pointer case after this one passes.
STEPS
  settings-arm
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm
  type "_.ZOOM{NL}_W{NL}26000,-14000{NL}38000,-4000" -Force
  wait
  type "_.CIRCLE{NL}30000,-9000{NL}1000" -Force
  wait
  type "_.ARC{NL}34000,-9000{NL}35000,-8000{NL}36000,-9000" -Force
  wait
  ms-count -> $c0
  type "RD{NL}31000,-9000" -Force -TimeoutSec 60 -> $rc
  esc-prompt -> $rce
  wait
  type "RD{NL}35000,-8000" -Force -TimeoutSec 60 -> $ra
  esc-prompt -> $rae
  wait
  type "RD" -Force -TimeoutSec 60 -> $rn
  esc-prompt -> $rne
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  contains $rc "Select arc or circle to dimension"
  matches $rc "Dimension type \[Radius/Diameter\]"
  contains $ra "Dimension type [Length/Radius/Diameter]"
  contains $rn "Select arc or circle to dimension"
  history absent "Dimension arc type"
  equals $c1 $c0
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $rc "FULL RD with the circle picked"
  record $ra "FULL RD with the arc picked"
  record $rn "FULL RD with Esc at the first question"
```

**Known weak point.** The type question is checked in two shapes (a regular expression for the circle, plain text for the arc) because the circle's text must not offer Length. If the first run shows the question text is wrapped differently, adjust both to what `$rc` and `$ra` printed. If the typed point 31000,-9000 does not pick the circle (the pick box misses), the reply says "Nothing Selected" and the case is a set-up problem; try zooming tighter (README batch 3 item 3).

**Twin:** `W1907_BROKEN_switch_off.case.txt`

```
# W1907_BROKEN DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1907: the PR's own switch Annotation.ArcDimSelectsGeometryFirst set OFF before AutoCAD starts, so RD asks 'Dimension arc type [Length/Radius/Diameter/?]' first (the old order). Same route, same checks. The typed point lands on a keyword question and is refused ('Requires keyword' style reprompt); Esc ends it. Nothing is placed.
# UNPROVEN: the SETTING line uses the FULL path because a bare CS_Settings.json expands to the Civil folder. If the runner refuses the path or the key, this comes back BLOCKED. Fallback route twin: none (the old order needs the switch).
# Expected red: 'contains $rc "Select arc or circle to dimension"', the circle and arc type-question checks, 'contains $rn "Select arc or circle to dimension"' and 'history absent "Dimension arc type"'. The object count check still passes.
CASE W1907_BROKEN
TITLE BROKEN VARIANT of W1907: the geometry-first switch OFF, so RD asks the type before the object (must FAIL)
PLAN_ITEM red-before-green proof for W1907 (BUG-640, PR #1907)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 897
TIMEOUT 900
BUG BUG-640
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1907
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json Annotation.ArcDimSelectsGeometryFirst false
REVIEWED_AGAINST
EXPECTED Same checks as W1907. With the switch OFF the first RD question is the old type question, so the geometry-first checks and the 'Dimension arc type' absent check fail.
WHY_NOT_UNIT_TEST It exists only to prove W1907's checks can go red.
NOT_AUTOMATED As W1907.
STEPS
  copy-info -> $copy0
  v3 setvar OSMODE 0 -> $osm
  type "_.ZOOM{NL}_W{NL}26000,-14000{NL}38000,-4000" -Force
  wait
  type "_.CIRCLE{NL}30000,-9000{NL}1000" -Force
  wait
  type "_.ARC{NL}34000,-9000{NL}35000,-8000{NL}36000,-9000" -Force
  wait
  ms-count -> $c0
  type "RD{NL}31000,-9000" -Force -TimeoutSec 60 -> $rc
  esc-prompt -> $rce
  wait
  type "RD{NL}35000,-8000" -Force -TimeoutSec 60 -> $ra
  esc-prompt -> $rae
  wait
  type "RD" -Force -TimeoutSec 60 -> $rn
  esc-prompt -> $rne
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  contains $rc "Select arc or circle to dimension"
  matches $rc "Dimension type \[Radius/Diameter\]"
  contains $ra "Dimension type [Length/Radius/Diameter]"
  contains $rn "Select arc or circle to dimension"
  history absent "Dimension arc type"
  equals $c1 $c0
  not-contains $win_end "Creative Engineering"
  record $rc "FULL RD with the switch OFF, circle point typed"
  record $rn "FULL RD with the switch OFF, first question"
```

---

## 3. Codex look notes (BLOCKED-FOR-ROBOT)

Evidence for every look goes in `C:\CE_WORK\codex\<look name>\`. Work on a COPY of a drawing only. Never accept, save or capture a folder the Save or Open box opened in. Both looks use the CE Admin Settings window; neither may unlock a layer to make a result look right.

### Look A: #1913 (B-091, BUG-1187), a mistyped layer lineweight keeps the layer and says why. BLOCKED-FOR-ROBOT

**Why:** the window is CEADMINSETTINGS, page Drawing Layers. It is not in the robot's press list, the fix needs a typed table cell, and the save button is "Save Layer Changes", which the robot refuses (every button starting "Save" is on its refused list). A window-only fix. About 5 minutes.

1. **Setup.** On a COPY of any Structural drawing, type `-LAYER`, then `N`, then `AUDIT-WEIGHT`, then Enter; then `LW` (lineweight), `0.50`, `AUDIT-WEIGHT`, Enter, Enter. (The layer must exist at 0.50 mm.)
2. **Steps.** Type CEADMINSETTINGS (or CEADS). Open Drawing Layers. Find the row AUDIT-WEIGHT. Click its Lineweight cell and type `typo` (replace the whole cell). Press Save Layer Changes. Read the message. Close the window.
3. **Right looks like.** A plain message that says: Lineweight "typo" is not a lineweight, so layer AUDIT-WEIGHT was not changed (DERIVED from the PR text). The row reloads showing 0.50. No "Updated layer" line. In the drawing the layer AUDIT-WEIGHT is still 0.50 mm. Repeat with the cell left empty: same refusal, no change.
4. **Also right.** Type `0.35` (a real weight): it saves, and the message says it updated the layer. (Valid values 0.50, 0.50 mm, Default, ByLayer, ByBlock save as before.)
5. **Wrong looks like.** After `typo` the layer silently becomes Default, and the status line says "Updated layer".
6. **Known limit (from the PR).** The refusal also leaves other cell edits on that row unsaved until the weight is fixed. Note whether that is surprising; do not treat it as a fault.
7. **Switch-off check.** With `Options.LayerLineweightTypoKeepsOriginal` set false in the Structural settings file BEFORE AutoCAD starts (settings are read at launch), repeat: the layer becomes Default quietly. Restore the settings file afterwards.
8. **Evidence.** Screenshot of the window after Save with the message visible, a screenshot of the layer's lineweight in the Layer Properties Manager, in `C:\CE_WORK\codex\L1913\`.

### Look B: #1918 (B-100, BUG-1224), Apply CE Standard Layers leaves lock, freeze and on/off alone. BLOCKED-FOR-ROBOT. LOCKED-LAYER ITEM: OPUS REVIEW BEFORE IT IS RUN

**Why:** the button is in the CE Admin Settings Drawing Layers window, which is not in the robot's press list. The robot can set up the layer states by typed `-LAYER` commands, but cannot press the button. The PR author's own robot sketch (BUGFIX_x1 report, S49_apply_layers_keep) also needs that button, so it cannot be a robot case either. About 8 minutes. This is the one place where a layer is DELIBERATELY locked and the button is pressed on it: the whole point is that the button must not unlock it. Never unlock BEAM by hand to "make it pass". Work on a copy only.

1. **Setup (typed, on a COPY of a Structural drawing that has the CE standard layers).** `-LAYER`, `LO`, `BEAM` (lock BEAM); `F`, `25TEXT` (freeze 25TEXT); `OFF`, `35CONT` (turn 35CONT off); `C`, `1`, `BEAM` (recolour BEAM red so a colour reset is visible). Press Enter to leave. Current layer 0. Note the four states in a screenshot of the Layer Properties Manager.
2. **Steps.** Type CEADMINSETTINGS (or CEADS), open Drafting Standards, Drawing Layers, press Apply CE Standard Layers. Read the status line. Close the window.
3. **Right looks like.** BEAM is STILL locked, 25TEXT is STILL frozen, 35CONT is STILL off, and BEAM's colour is back to its standard colour (not red). Current layer still 0. The status line reads (DERIVED from the PR text and the x1 report): "CE standard layers applied." followed by the left-alone lines, for example "Left 1 locked layer as you set it: BEAM.", "Left 1 frozen layer as you set it: 25TEXT." and "Left 1 turned off layer as you set it: 35CONT.".
4. **Wrong looks like.** BEAM unlocked, 25TEXT thawed or 35CONT back on; or the status line is only "CE standard layers applied.".
5. **One U afterwards.** Type U once and write down what came back (colour only, everything, nothing). The carpark asks; there is no pass or fail rule.
6. **Switch-off check.** With `Options.ApplyStandardsKeepsLockFreezeOnOff` set false in the Structural settings file BEFORE AutoCAD starts, repeat steps 1 to 3: BEAM is unlocked, 25TEXT thawed, 35CONT on, and the status line reads only "CE standard layers applied." (old behaviour). Restore the settings file afterwards.
7. **Evidence.** Screenshots of the Layer Properties Manager before and after, and of the status line, in `C:\CE_WORK\codex\L1918\`.

---

## 4. Fixes skipped, and why

1. **#1913 (BUG-1187) and #1918 (BUG-1224):** no robot case; Codex looks above (a window the robot cannot press, a typed table cell, a refused "Save" button).
2. **CSSUBFLOORGRID in #1895 and #1912:** it needs a closed floor outline pick and a joist direction (two points), more prompts whose exact order was not read in full in the time allowed. Only CSTAGBEARERS is driven; CSSUBFLOORGRID is left as a NOT_AUTOMATED line. A later case could add it.
3. **The BUG-1185 bent-bearer half and the BUG-1200 rotated rectangular pad (#1906):** the bent bearer needs a polyline with an arc; the rotated pad needs a rotation answer and the look of the temporary outline. Left for a Codex look or a second case.
4. **The placement half of RD (#1907):** a placed dimension needs a click after AutoCAD's own preview and then a U. Not drafted; the order of the questions is the part the robot can prove.
5. **BUG-1193 and BUG-634:** named in the PR texts as not in these PRs; not touched.

---

## 5. What was read, built and tested (plain)

1. **Read:** the rules, the case README and the driver's press list, the finished example drafts (TOP12 and SET18), the R09s twin, R23, S467a and the 30 Oct Structural report, the six PR texts, the diffs of #1912 and #1906, the PR-branch code for CSTAGBEARERS, THCL and RD, the carpark entry titles, the x1, s11 and s15 reports, the ledger, and every cases folder.
2. **Built:** nothing. **Tested:** nothing. **AutoCAD:** not opened. **The case runner:** not run, not even its offline validate. No file was written except this one.
3. **NOT proven:**
   1. That any of the four cases runs, or that its chain stays in step with the real prompts (every prompt is DERIVED from the PR branch code).
   2. That the robot AutoCAD loads the Structural bundle (the folder is installed, dated 27 Oct; the fixes are not in it).
   3. That the full-path SETTING line is accepted by the runner and that the five switch keys exist or are read from that file at launch.
   4. The exact wording of the locked-layer line, and the exact text of the labels (BR1 150x50 F17) the commands draw.
   5. That a typed point at "Select a hand-drawn bearer" or "Select arc or circle" picks the line, circle or arc (it should, inside a zoomed view; unconfirmed on these commands).
   6. That `_.-LAYER _LOCK 25TEXT` works the same way as in R23 for a layer CE has just created.
4. **Opus review before any run:** W1912 and Look B (locked layer). W1906 and W1907 use Esc but no Undo or REDO. None of the cases touches an Xref.
5. **The bug entries stay OPEN.** Nothing is FIXED until the cases pass in two sessions, are reviewed, and a build with the fixes is installed.
