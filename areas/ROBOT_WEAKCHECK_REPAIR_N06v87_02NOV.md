# Robot weak-check repair: N06v87 (drafted Mon 2 Nov 2026, Melbourne; Sonnet, read-only drafting)

## FOR TIM

1. **Verdict: REPAIRABLE with the robot alone.** No Codex look is needed. The case is about layer names and the current layer, which the robot reads straight from the drawing.
2. **What the case claims:** after you place a pit and a pipe with PIT and CD, the layer you were drawing on is still BLOCKS, and the new objects land on the office layers (pit on STORMWATER PIT, arrow on ARROW).
3. **Why it was weak:** it only recorded where the pipe, the pipe label and the IL texts went, and never judged them. On 1 Nov the IL texts were fixed. Pipe and label are still not judged. The "broken twin" changes the current layer by hand, so it proves the check can read a number. It does not prove the check notices a new object landing on the wrong layer.
4. **The repair:** judge the pipe (STORMWATER PIPE) and the pipe label (25TEXT) as well. Add two new twins that move a new object onto layer 0 and must fail on the layer check itself.
5. **Not proven even after the repair:** that CE's own restore of your current layer is what keeps it at BLOCKS (the twin cannot undo CE's restore); "never recolour an existing layer" (not built); the pit label layer (case N05); the Esc paths (case N28).
6. **Nothing was built, run or installed for this.** It is a draft. It needs a validate run, one AutoCAD run of the three cases in a free window (after 5:30 pm), and an independent review before it counts.

---

## 1. What the case claims (plain English)

1. **Case:** `N06v87`, file `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_v387_30oct\N06_office_layers_current_layer_keptv87.case.txt`. Plan item UX-LYR-01 (daily card D24), the installed part only.
2. **Claim:** after the shared setup (one PIT at 150000,-80000 and one CD pipe to 170000,-80000) the current layer reads BLOCKS, nothing new is on layer 0 or BLOCKS, the new pit is on STORMWATER PIT and the flow arrow is on ARROW.
3. **Whole or part:** PART. The card's other half, "an existing layer is never recoloured", is not built (card D24, corrections item 3). The case can never count for the whole card.
4. **Source read (not run):** `Modules/Drainage/Services/LayerService.cs` on `origin/claude/rel-20261102a` (3fbb9da5) names STORMWATER PIPE (line 54 and 98), 25TEXT for pipe text (127), 20TEXT for invert text (134), ARROW (138), STORMWATER PIT (142). So the layer names the case should judge are confirmed in the source, not only seen in runs.

## 2. Why the check is weak (exact lines)

Read: the case file, its twin `N06_brokenv87.case.txt`, the ledger (six rows for N06v87), the run reports aW4, aF1v, bF1v, pcF1v, peR2 and tW1, `C78_REVIEW_A_REPORT.md`, `OPUS_CASE_REVIEW_V87_30OCT.md` (item 7, "fine"), and the case's review file.

1. **Weak line A: `record $pipel "layer of the new pipe object"`** in the ASSERT block. A record is written to the report and never judged. If the pipe went onto layer 0 the case would still PASS. Every run so far saw STORMWATER PIPE, and the source says STORMWATER PIPE.
2. **Weak line B: `record $labl "layer of the new pipe label"`.** Same fault. Every run saw 25TEXT, and the source says 25TEXT.
3. **Weak line C (the twin): `v3 setvar CLAYER 0` in `N06_brokenv87.case.txt`.** The twin makes its own red by changing the current layer itself, then asserts `equals $cl "BLOCKS"`. The recorded failure is `value '0' (expected 'BLOCKS')` (tW1, 31 Oct). That proves `equals` can read a changed number. It never shows a check going red because CE put an object on the wrong layer. Seven of the eight judged checks (`count $on0`, `count $onb`, `count $pits`, `count $arrows`, `equals $arrl`, `count $ils`, `equals $ill`) have no twin at all.
4. **Already repaired on 1 Nov (CE 02):** `count $ils = 2` and `equals $ill "20TEXT | 20TEXT"` were added. The case passed with that text in peR2 (2 Nov 00:47, sha 16012E38...). Its review file still carries the OLD sha B90209B7..., so the review no longer counts for the current text. Check the run reports for the live sha before relying on any ACCEPTED-READY line.
5. **Twin run history:** the only twin run (tW1, 31 Oct) was on the OLD twin text (sha 382FB0E3...). It has not been run against the repaired case.
6. **Not weak, said plainly:** the BLOCKS check itself is real (the case reads CLAYER from the drawing after CE has finished). Its red is just self-made.

## 3. REPAIRED case (replace the case file; README format)

Changes from the file on disk: two `record` lines become `equals`; one `count $pipes = 1` added so `$pipel` cannot be empty; header comment updated; NOT_AUTOMATED lines tightened. Everything else is unchanged.

```
# N06v87 REPAIR 2 (drafted by Sonnet 2 Nov 2026 for CE 02; NOT RUN). Adds judged checks for the pipe object layer and the pipe label layer (were record-only). Source: LayerService.cs 3fbb9da5 lines 54 and 98 (STORMWATER PIPE), 127 (25TEXT).
# DERIVED: "STORMWATER PIPE" and "25TEXT" come from the source lines above and from five passing runs (aW4, aF1v, bF1v, pcF1v, peR2). They are NOT from the card (card D24 says "record the name"). A deliberate layer rename by Tim would turn these two lines red: that needs his word, not a revert.
# DERIVED: "20TEXT | 20TEXT" (two IL texts on the invert-text layer) from LayerService.cs line 134 and the same runs.
CASE N06v87
TITLE After PIT and CD the current layer is still BLOCKS, nothing new is on layer 0 or on BLOCKS, and the pit, pipe, pipe label, IL texts and flow arrow are each on their office layer
PLAN_ITEM UX-LYR-01 installed part (daily card D24); the never-recolour half is not built
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8v
ORDER 60
TIMEOUT 900
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After SETUP-P8v the current layer CLAYER reads BLOCKS; none of the new objects is on layer 0 or BLOCKS; the one new pit block is on STORMWATER PIT; the one new CE pipe object is on STORMWATER PIPE; the one new pipe label is on 25TEXT; the two new IL texts are on 20TEXT; the one new flow arrow (TIM_CVL_ARROW) is on ARROW.
WHY_NOT_UNIT_TEST Layer choice and the current-layer restore happen in the live drawing's layer table during real PIT and CD runs.
NOT_AUTOMATED This case counts for the PART of UX-LYR-01 that is installed. 'An existing layer is never recoloured' is NOT BUILT; layer-table colours are not read.
NOT_AUTOMATED The pit label layer is covered by N05 (this setup escapes the label prompt, so no pit label exists here).
NOT_AUTOMATED CLAYER after each Esc path is covered by N28, not here.
STEPS
  getvar CLAYER -> $cl
  select $new_all "layer=0" -> $on0
  select $new_all "layer=BLOCKS" -> $onb
  select $new_all object=AcDbBlockReference "layer=STORMWATER PIT" -> $pits
  select $new_all name=TIM_CVL_ARROW -> $arrows
  field $arrows layer -All -> $arrl
  select $new_all object=CeCvlPipeObject -> $pipes
  field $pipes layer -All -> $pipel
  select $new_all "text~^IL " -> $ils
  field $ils layer -All -> $ill
  select $new_all "text~ DIA\. " -> $lab
  field $lab layer -All -> $labl
  field $new_all layer -All -> $all_layers
ASSERT
  equals $cl "BLOCKS"
  count $on0 = 0
  count $onb = 0
  count $pits = 1
  count $arrows = 1
  equals $arrl "ARROW"
  count $pipes = 1
  equals $pipel "STORMWATER PIPE"
  count $ils = 2
  equals $ill "20TEXT | 20TEXT"
  count $lab = 1
  equals $labl "25TEXT"
  record $all_layers "FULL layer of every new object"
```

## 4. REPAIRED twins (README format)

Three twins, each a copy of the repaired case with ONE wrong thing done on purpose. Each must FAIL on a named layer check while every other check still passes. That shows the red is the layer check and not a broken step. The existing `N06_BROKENv87` stays as the CLAYER twin and needs one added line (see 4.3).

### 4.1 Twin B: the new pit is moved to layer 0 (new file `N06_broken_pit_on_layer0v87.case.txt`)

```
# N06 twin B (drafted by Sonnet 2 Nov 2026 for CE 02; NOT RUN). After the setup the case moves the new pit to layer 0 with CHPROP (same route as the accepted N59 twin: pick-first then CHPROP). The pit-on-layer check and the nothing-on-layer-0 check must FAIL.
# DERIVED: the CHPROP typed chain is copied from N59_cdcheck_wrong_layer_row_BROKEN. UNPROVEN here: that {$ph} is accepted inside pick-first. If the runner refuses it, read the handle with select/field and use ent-read style braces as the README allows for ent-read; ask CE 05 before inventing a verb.
CASE N06_broken_pit_on_layer0v87
TITLE BROKEN VARIANT of N06: the new pit is moved to layer 0 by the case, so the pit-layer and layer-0 checks must FAIL
PLAN_ITEM red-before-green proof for N06 (UX-LYR-01 installed part)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8v
ORDER 62
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N06v87
REVIEWED_AGAINST
EXPECTED This variant is wrong on purpose: the new pit sits on layer 0, so 'count $pits = 1' and 'count $on0 = 0' fail. The CLAYER, arrow, pipe, label and IL text checks still pass, which shows the red is the pit check.
WHY_NOT_UNIT_TEST It exists only to prove N06's pit-layer and layer-0 checks can go red from a real wrong layer.
STEPS
  select $new_all object=AcDbBlockReference "layer=STORMWATER PIT" -> $pit0
  field $pit0 handle -All -> $ph
  pick-first "{$ph}"
  type "_.CHPROP{NL}_LA{NL}0{NL}" -Force -> $chp
  wait
  esc-prompt -> $chp_e
  getvar CLAYER -> $cl
  select $new_all "layer=0" -> $on0
  select $new_all "layer=BLOCKS" -> $onb
  select $new_all object=AcDbBlockReference "layer=STORMWATER PIT" -> $pits
  select $new_all name=TIM_CVL_ARROW -> $arrows
  field $arrows layer -All -> $arrl
ASSERT
  equals $cl "BLOCKS"
  count $on0 = 0
  count $onb = 0
  count $pits = 1
  count $arrows = 1
  equals $arrl "ARROW"
```

### 4.2 Twin C: the new pipe label is moved to layer 0 (new file `N06_broken_label_on_layer0v87.case.txt`)

```
# N06 twin C (drafted by Sonnet 2 Nov 2026 for CE 02; NOT RUN). Same route as twin B, on the pipe label. The label-layer check and the nothing-on-layer-0 check must FAIL. This is the twin for the check this repair adds.
CASE N06_broken_label_on_layer0v87
TITLE BROKEN VARIANT of N06: the new pipe label is moved to layer 0 by the case, so the label-layer and layer-0 checks must FAIL
PLAN_ITEM red-before-green proof for N06 (UX-LYR-01 installed part)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8v
ORDER 63
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N06v87
REVIEWED_AGAINST
EXPECTED This variant is wrong on purpose: the new pipe label sits on layer 0, so 'equals $labl 25TEXT' and 'count $on0 = 0' fail. The CLAYER, pit, arrow and pipe checks still pass.
WHY_NOT_UNIT_TEST It exists only to prove N06's new pipe-label check can go red from a real wrong layer.
STEPS
  select $new_all "text~ DIA\. " -> $lab0
  field $lab0 handle -All -> $lh
  pick-first "{$lh}"
  type "_.CHPROP{NL}_LA{NL}0{NL}" -Force -> $chp
  wait
  esc-prompt -> $chp_e
  getvar CLAYER -> $cl
  select $new_all "layer=0" -> $on0
  select $new_all object=AcDbBlockReference "layer=STORMWATER PIT" -> $pits
  select $new_all object=CeCvlPipeObject -> $pipes
  field $pipes layer -All -> $pipel
  select $new_all "text~ DIA\. " -> $lab
  field $lab layer -All -> $labl
ASSERT
  equals $cl "BLOCKS"
  count $on0 = 0
  count $pits = 1
  equals $pipel "STORMWATER PIPE"
  equals $labl "25TEXT"
```

### 4.3 Twin A (existing CLAYER twin): keep, add two clean-pass lines

Leave `N06_brokenv87.case.txt` as is, but add these to its ASSERT so the report shows the red is only CLAYER:

```
  count $on0 = 0
  count $pits = 1
```

and these two steps before `getvar CLAYER -> $cl`:

```
  select $new_all "layer=0" -> $on0
  select $new_all object=AcDbBlockReference "layer=STORMWATER PIT" -> $pits
```

Put the new asserts AFTER `equals $cl "BLOCKS"` so the first failure line stays the CLAYER one. Its EXPECTED line then says: the BLOCKS check fails; the pit and layer-0 checks pass.

## 5. What the repaired set proves, and what it does not

1. **Proves (robot alone, once run and reviewed):** after PIT and CD the drawing's current layer is BLOCKS; no new object is on layer 0 or BLOCKS; pit, pipe, pipe label, two IL texts and arrow are each on their named office layer. Each of those layer checks has a twin that fails when that object is on the wrong layer.
2. **Does NOT prove:** that CE's restore of the current layer is what keeps CLAYER at BLOCKS. A twin that disables CE's restore needs an older build or a switch. I found no recorded bug where CD left the layer changed, so I could not name one. If CE 00 wants that, it is a build-level twin and is outside the robot's reach.
3. **Does NOT prove:** the never-recolour half (not built), the pit label layer (N05), Esc paths (N28), layer colours.
4. **Whole or part:** PART of D24, always, until never-recolour is built.

## 6. What I could not confirm (open items)

1. **`pick-first "{$ph}"` is unproven.** The README shows braces for `ent-read {$handle}` only. The runner may refuse braces in `pick-first`. If so, CE 05 must say which verb reads a handle into a pick-first. Run `case_runner.ps1 validate` first. If it cannot be made to work, twins B and C are BLOCKED-FOR-ROBOT and the fallback is the Codex look steps in section 7.
2. **Twin CHPROP leaves the drawing changed** in that case's copy only. The runner reopens a fresh copy per case, so the next case is not affected.
3. **Review file is stale.** `N06_office_layers_current_layer_keptv87.review.txt` names sha B90209B7..., which is the text before the 1 Nov IL fix and before this repair. After this repair is applied, the independent reviewer must write a new review for the new sha. I did not touch it.
4. **Build checked:** read only. Source lines were read from `origin/claude/rel-20261102a` (3fbb9da5). Installed build in the runs was Civil 3.0.88+3fbb9da5. I did not read the installed DLL.

## 7. Fallback only if twins B and C cannot be made to run: Codex look steps

Use a COPY of DRV1_B1, never Tim's drawing. Screenshots and exact steps recorded.

1. **Open** the copy. Type `CLAYER` and press Enter. Write down the value (should be BLOCKS).
2. **Place** a pit: type `PIT`, pick 150000,-80000, press Continue placement, Esc three times.
3. **Place** a pipe: type `CD`, 150000,-80000 then 170000,-80000, first invert 18.000, second invert 17.800, press Start Pipe, Esc once.
4. **Check the current layer:** type `CLAYER`. Right looks like BLOCKS, same as step 1.
5. **Check each new object's layer** by selecting it and reading Properties: pit STORMWATER PIT, pipe STORMWATER PIPE, pipe label (text with "DIA.") 25TEXT, two IL texts 20TEXT, arrow ARROW. Nothing on 0 or BLOCKS.
6. **Twin look:** move the pipe label to layer 0 (select it, set Layer to 0) and confirm Properties shows 0, so a wrong layer is visible when it happens.

## 8. Said plainly

1. **Read:** the case, its twin, the setup, the README, the ledger rows, five run reports, the review file, the Opus and C78 review notes, and `LayerService.cs` on the latest Civil line.
2. **Built, tested, installed:** none. Nothing run, no AutoCAD opened, no file changed except this one.
3. **Not proven:** that the repaired case and the two new twins validate or pass. Section 6 lists what can still stop them.
