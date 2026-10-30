# Robot case drafts for the top 12 robot-provable items (Fri 30 Oct 2026, about 12:15 Melbourne, read-only drafter, Opus)

**What this is.** Twelve ready-to-validate robot case drafts, each with its failing twin, written as plain text below with the file name each should get. Nothing was run, built, installed or opened in AutoCAD. No case file was created anywhere; the only file written is this one. No git write.

**Sources read:** `C:\TimOS\RULES.md`; `areas\TEST_NEXT_40_ITEMS_30OCT.md` (the ranked 40); `areas\RETEST_SMOKE_SETS.md`; `C:\Lisp Files\_ACAD_DRIVER\cases\README_CASES.md`; the cases R01, R16, R18, R28, R36, R37, N04, N27, the drafts N43 and N43_BROKEN, and the three shared setups SETUP-P8, SETUP-P8x2, SETUP-R47; the plan lines in `04_REFERENCE\ux-plan\V3_UX_PLAN.md`; cards 1.5, 1.7 and 6.7; Tim's rulings in `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`; and the installed Civil 3.0.86 source (`origin/claude/rel-20261029a`, 5888ee75, read with `git show` / `git grep` only) for prompts and printed lines.

---

## ANSWER FIRST

1. **12 cases drafted, each with a failing twin (24 case texts).** Names N45 to N56, in the order of the ranked 40, skipping the items that are not new robot work.
2. **Which 12.** Ranked items 5 to 15 (less item 16, a Codex look), then item 21 in place of items 17 to 20:
   1. **Items 17 and 18** (UX-SCHED-06, UX-PIPE-05) already have drafts (N40, N35); not drafted again.
   2. **Item 19** (UX-LSEC-01, long section drawn) needs the Profiles window's Insert / Apply button pressed; the robot's press list does not allow it (README batch 3 item 5 lists the refused buttons, and no allow-list change was made). A case written now would only come back BLOCKED.
   3. **Item 20** (UX-RESUME-01) needs one case to span two AutoCAD starts; the case format cannot express that.
   4. So item 21 (UX-LBL-04, Tidy moves only CE labels) is the twelfth.
3. **Whole or part, said in every PLAN_ITEM line.** Only **4 of the 12 can claim the whole card** on this fixture: UX-NAMES-06, UX-CPLAN-25, UX-CMD-03 and UX-DP-02. The other 8 are honest PART claims, because the whole card needs something the robot cannot reach (an Xref, a second drawing, a window, the ribbon, or the command register file). Each one names the missing part in NOT_AUTOMATED.
4. **Every printed line marked DERIVED was read from the installed source, not seen on a run.** First runs will need one or two fix-ups (the planner's 50 percent allowance holds).

---

## FOR TIM

1. **Done.** Twelve robot tests written on paper for the next items on the list, each with a deliberately wrong copy that must fail (that proves the test can catch a fault).
2. **Example.** Test N48 draws three identical pipes side by side and checks every one of them gets its own label, "225 DIA. UPVC PIPE AT 1 IN 200", never "TYP." That is your 27 Sep ruling "Label each".
3. **What they cover honestly.** Four of the twelve can tick a whole plan item if they pass. The other eight tick part of an item, because the rest needs a picture, the ribbon or a second drawing.
4. **Two safety notes for the desk, not for you.**
   1. N47 (the job timer) runs the real timer, so a robot run may add a few minutes of "no job" time to your time records.
   2. N49 (Enter repeats) changes the "last used pipe type" while it runs; the case puts it back before it ends.
5. **Nothing for you to test or decide.** These go to the robot after the C-77 install, then to an Opus reviewer.

---

## 1. How the drafts are written (read before validating)

1. **Format.** Exactly the README format: header lines, `STEPS`, `ASSERT`. Every `type` chain is a complete command, no `(`, no SAVE-type word. Every twin carries `VARIANT_OF` and `EXPECT-FAIL BROKEN-VARIANT`, keeps the route checks, and reverses one check only.
2. **REVIEWED_AGAINST is left empty** in every draft, as the README requires; no review file is written.
3. **Order numbers** 450 to 573, so they sort after the N40 to N44 drafts.
4. **Fixture** DRV1_B1 (millimetres, INSUNITS 4) for every case; `SLOT fresh` everywhere.
5. **Validate first, without AutoCAD:** copy each block to its file name in a new drafts folder (suggested `cases\drafts_top12_30oct\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.
6. **Empty ground used.** 138000 to 172000 by -77000 to -98000 is the area SETUP-P8, R36, R37 and N04 already use as empty ground. Points west of 150000 (140000 to 148000) have not been used by an accepted case before: if any first run shows an unexpected object there, move every draft's x by +0 / y by -15000 together (the -95000 band R36 uses).

---

## 2. The twelve cases

### Case 1 of 12: N45, new typed names start CD, CS or CE (ranked item 5, UX-NAMES-02)

**Intended file:** `N45_new_names_cd_cs_ce_answer.case.txt`

```
# N45 DRAFT (read-only drafter, Opus, Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 5 of TEST_NEXT_40_ITEMS_30OCT.md.
# Tim, 27 Sep 2026 01:56: "CD = Civil, CS = Structural, CE = shared". New typed names start CD, CS or CE; old names keep working (UX-NAMES-01, case N46).
# Route: each new V3 name is typed alone; its own first prompt is answered with Esc. A name AutoCAD does not know prints 'Unknown command'.
# Prompts read from installed Civil 3.0.86 source (origin/claude/rel-20261029a): CDAGI and CDPERIMETER 'AG drain pipe property' / 'Perimeter drain pipe property' (AgiCommand.cs 184); CDTG 'Specify trench drain start point:' and on Esc 'TG command cancelled.' (SourceBlockInsertCommands.cs 159, 162); CDRG 'Specify first raingarden point:' (N04); CDFW Esc 'CDFW cancelled - nothing was placed.' (R36); CDPROFILE 'Select starting CE pit for profile review:' (R28).
# CEFIND and CSREOBAR first prompts are NOT known: only 'not Unknown command' is checked for them. CSREOBAR is the only CS command any robot run has typed (runs 43 to 47, driver v2); if the Structural module is not loaded on the robot's AutoCAD it prints Unknown command and this case FAILS for that reason (say so in the report, do not loosen the check).
# Remembered values: NO (nothing is placed).
CASE N45
TITLE New V3 typed names answer: CDAGI, CDPERIMETER, CDTG, CDRG, CDFW, CDPROFILE, CEFIND and CSREOBAR each start their own prompt, none says Unknown command, nothing is drawn
PLAN_ITEM UX-NAMES-02 PART: the typed half (new names starting CD, CS or CE are real commands). NOT whole: that EVERY new or renamed command since 27 Sep starts CD, CS or CE is a command-register check the reviewer makes on the installed command-registry.json files (see NOT_AUTOMATED)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 450
TIMEOUT 900
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED Each of the eight names starts a command: CDAGI prints 'AG drain pipe property [None/Charged/Suspended] <None>:', CDPERIMETER 'Perimeter drain pipe property [None/Charged/Suspended] <None>:', CDTG 'Specify trench drain start point:', CDRG 'Specify first raingarden point:', CDPROFILE 'Select starting CE pit for profile review:'; Esc ends each; CDFW ended by Esc prints 'CDFW cancelled - nothing was placed.'; no line in the whole case says 'Unknown command'; the object count and the drawing file on disk do not change; no CE window is left open.
WHY_NOT_UNIT_TEST Whether a typed name reaches a command depends on what the loaded plugin registered inside the live AutoCAD session.
NOT_AUTOMATED The register half: the installed Civil register (Modules/Drainage/Assets/Config/command-registry.json on rel-20261029a) also lists names that do not start CD, CS or CE (PIT, PP, DP, IO, OF, FO, GIO, PITSCHEDULE, PITDELETE, TG, MR, CR, MOVEROT, COPYROT, COPYMULTI, PIPEEDIT, PITEDIT, PIPEPITLINK, PIPEPITUNLINK). The reviewer must check from git history that each was named BEFORE 27 Sep 2026 (old names are allowed forever); this drafter did not check their dates.
NOT_AUTOMATED Structural and Manager registers are not read. Ribbon labels (UX-NAMES-03) are a Codex look.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDAGI" -Force -TimeoutSec 90 -> $t_agi
  esc-prompt -> $e_agi
  type "CDPERIMETER" -Force -TimeoutSec 90 -> $t_per
  esc-prompt -> $e_per
  type "CDTG" -Force -TimeoutSec 90 -> $t_tg
  esc-prompt -> $e_tg
  type "CDRG" -Force -TimeoutSec 90 -> $t_rg
  esc-prompt -> $e_rg
  type "CDFW" -Force -TimeoutSec 90 -> $t_fw
  esc-prompt -> $e_fw
  type "CDPROFILE" -Force -TimeoutSec 90 -> $t_prof
  esc-prompt -> $e_prof
  type "CEFIND" -Force -TimeoutSec 90 -> $t_find
  esc-prompt -> $e_find
  type "CSREOBAR" -Force -TimeoutSec 90 -> $t_cs
  esc-prompt -> $e_cs
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  history absent "Unknown command"
  contains $t_agi "AG drain pipe property [None/Charged/Suspended] <None>:"
  contains $t_per "Perimeter drain pipe property [None/Charged/Suspended] <None>:"
  contains $t_tg "Specify trench drain start point:"
  contains $t_rg "Specify first raingarden point:"
  history has "CDFW cancelled - nothing was placed."
  contains $t_prof "Select starting CE pit for profile review:"
  not-contains $t_find "Unknown command"
  not-contains $t_cs "Unknown command"
  equals $c1 $c0
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $t_find "FULL what CEFIND printed (first prompt not known before this run)"
  record $t_cs "FULL what CSREOBAR printed (first prompt not known before this run)"
  record $e_tg "FULL what Esc printed for CDTG"
```

**Twin:** `N45_new_names_cd_cs_ce_answer_BROKEN.case.txt`

```
# N45_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). Proves the 'Unknown command' check can go red: it types one made-up CD name that no plugin registers, so 'Unknown command' MUST appear. Every other route check is kept.
CASE N45_BROKEN
TITLE BROKEN VARIANT of N45: a made-up name CDNOSUCHNAME is typed and the case still expects no Unknown command (must FAIL)
PLAN_ITEM red-before-green proof for N45 (UX-NAMES-02)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 451
TIMEOUT 600
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N45
REVIEWED_AGAINST
EXPECTED Wrong on purpose: CDNOSUCHNAME prints Unknown command, so 'history absent "Unknown command"' fails; CDAGI and CDTG still print their prompts.
WHY_NOT_UNIT_TEST It exists only to prove N45's main check can go red.
STEPS
  ms-count -> $c0
  type "CDAGI" -Force -TimeoutSec 90 -> $t_agi
  esc-prompt -> $e_agi
  type "CDNOSUCHNAME" -Force -TimeoutSec 60 -> $t_bad
  wait
  type "CDTG" -Force -TimeoutSec 90 -> $t_tg
  esc-prompt -> $e_tg
  wait
  ms-count -> $c1
ASSERT
  contains $t_agi "AG drain pipe property [None/Charged/Suspended] <None>:"
  contains $t_tg "Specify trench drain start point:"
  equals $c1 $c0
  history absent "Unknown command"
  record $t_bad "FULL what the made-up name printed"
```

---

### Case 2 of 12: N45w, the Civil short codes CDWT and CDLPD stay (ranked item 6, UX-NAMES-06)

**Intended file:** `N45w_civil_short_codes_stay.case.txt`

```
# N45w DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 6. The planner put it in N45; it is its own case here so each PLAN_ITEM is one card.
# Tim, 27 Sep 2026 01:57: "Keep short codes". CDWT, CDLPD and the like stay; the ribbon shows plain words anyway.
# 'And the like' read as the Civil short codes visible in the installed 3.0.86 register (not hidden): CDWT, CDLPD, CDSL, CDTG, CDRG, CDFW, CDSC, CDCJ. Their first prompts are mostly NOT known (CDWT may open a window): every name is followed by close-windows then esc-prompt, and only 'not Unknown command' plus 'nothing drawn' is judged. close-windows with no window open is assumed harmless (R28 used it with a window only): if the runner calls that BLOCKED, drop the close-windows lines for the names that printed a prompt.
# Remembered values: NO.
CASE N45w
TITLE The Civil short codes CDWT, CDLPD, CDSL, CDTG, CDRG, CDFW, CDSC and CDCJ still answer when typed, none says Unknown command, nothing is drawn
PLAN_ITEM UX-NAMES-06 WHOLE for the typed rule ("CDWT, CDLPD and the like stay"). The ruling's second clause ("the ribbon shows plain words anyway") belongs to UX-NAMES-03 and is a Codex look, not part of this card's claim
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 460
TIMEOUT 900
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED Each short code starts its own command (prompt or window); Esc or close ends it; no line in the case says 'Unknown command'; the object count and the file on disk do not change; no CE window is left open.
WHY_NOT_UNIT_TEST Only the live AutoCAD session shows which typed names the loaded plugin answers.
NOT_AUTOMATED What each short-code window looks like and its ribbon button words (Codex look, UX-NAMES-03).
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDWT" -Force -TimeoutSec 120 -> $t_wt
  close-windows -> $w_wt
  esc-prompt -> $e_wt
  type "CDLPD" -Force -TimeoutSec 120 -> $t_lpd
  close-windows -> $w_lpd
  esc-prompt -> $e_lpd
  type "CDSL" -Force -TimeoutSec 90 -> $t_sl
  esc-prompt -> $e_sl
  type "CDTG" -Force -TimeoutSec 90 -> $t_tg
  esc-prompt -> $e_tg
  type "CDRG" -Force -TimeoutSec 90 -> $t_rg
  esc-prompt -> $e_rg
  type "CDFW" -Force -TimeoutSec 90 -> $t_fw
  esc-prompt -> $e_fw
  type "CDSC" -Force -TimeoutSec 90 -> $t_sc
  close-windows -> $w_sc
  esc-prompt -> $e_sc
  type "CDCJ" -Force -TimeoutSec 90 -> $t_cj
  close-windows -> $w_cj
  esc-prompt -> $e_cj
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  history absent "Unknown command"
  contains $t_tg "Specify trench drain start point:"
  contains $t_rg "Specify first raingarden point:"
  history has "CDFW cancelled - nothing was placed."
  equals $c1 $c0
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $t_wt "FULL what CDWT printed"
  record $w_wt "windows CDWT opened"
  record $t_lpd "FULL what CDLPD printed"
  record $t_sl "FULL what CDSL printed"
  record $t_sc "FULL what CDSC printed"
  record $t_cj "FULL what CDCJ printed"
```

**Twin:** `N45w_civil_short_codes_stay_BROKEN.case.txt`

```
# N45w_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). Same route; one check reversed: it expects CDWT's typed result to contain 'Unknown command'. CDWT is in the installed register, so it must FAIL.
CASE N45w_BROKEN
TITLE BROKEN VARIANT of N45w: expects CDWT to be unknown (must FAIL: it answers)
PLAN_ITEM red-before-green proof for N45w (UX-NAMES-06)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 461
TIMEOUT 600
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N45w
REVIEWED_AGAINST
EXPECTED Wrong on purpose: CDWT starts a command, so 'contains $t_wt "Unknown command"' fails; the CDTG prompt check passes.
WHY_NOT_UNIT_TEST It exists only to prove N45w's typed check can go red.
STEPS
  ms-count -> $c0
  type "CDWT" -Force -TimeoutSec 120 -> $t_wt
  close-windows -> $w_wt
  esc-prompt -> $e_wt
  type "CDTG" -Force -TimeoutSec 90 -> $t_tg
  esc-prompt -> $e_tg
  wait
  ms-count -> $c1
ASSERT
  contains $t_tg "Specify trench drain start point:"
  equals $c1 $c0
  contains $t_wt "Unknown command"
  record $t_wt "FULL what CDWT printed"
```

---

### Case 3 of 12: N46, old typed names keep working (ranked item 7, UX-NAMES-01)

**Intended file:** `N46_old_names_still_work.case.txt`

```
# N46 DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 7.
# Tim, 26 Sep 2026 07:49: "Forever, as silent shortcuts (Recommended)". Renamed or merged names keep working when typed, indefinitely; they never appear in the ribbon, Help or tooltips.
# Old names in the installed 3.0.86 Civil register: PIPEEDIT and PITEDIT (aliases of CDEDIT, and hidden), TG (hidden; the same method as CDTG, SourceBlockInsertCommands.cs 128-129), CDASK (alias of CEASK), LINKPIPEPIT (alias of PIPEPITLINK), CLEARPIPEPITLINK (alias of PIPEPITUNLINK).
# Driven here: PIPEEDIT, PITEDIT and TG only. CDASK opens the Ask CE window (not on the robot's read list); LINKPIPEPIT and CLEARPIPEPITLINK change pipe links and their first prompt is not known, so typing them blind could change the drawing: they are NOT driven.
# DERIVED: the CDEDIT pick prompt contains 'Select' (UX-SEL-01: nothing selected, the command asks to pick). Not seen on a run.
# Remembered values: NO.
CASE N46
TITLE Old typed names PIPEEDIT, PITEDIT and TG still start the renamed commands (CDEDIT's pick prompt, the trench drain start point), never Unknown command, nothing drawn
PLAN_ITEM UX-NAMES-01 PART: three of the six old names in the installed Civil register are typed and answer. NOT whole: CDASK, LINKPIPEPIT and CLEARPIPEPITLINK are not typed (window or link change), Structural old names are not typed, and "never shown in ribbon, Help or tooltips" is a register and Codex check
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 470
TIMEOUT 600
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED PIPEEDIT and PITEDIT each ask the drafter to pick (the CDEDIT pick prompt) and Esc ends them with no window opened; TG prints 'Specify trench drain start point:' and Esc prints 'TG command cancelled.'; no 'Unknown command' anywhere; the object count and the file on disk do not change.
WHY_NOT_UNIT_TEST Whether an old name reaches the new command depends on the names registered inside the live AutoCAD session.
NOT_AUTOMATED CDASK, LINKPIPEPIT, CLEARPIPEPITLINK (see the header). Structural old names (UX-NAMES-05, CS stage) are not typed: no Structural case or fixture exists yet.
NOT_AUTOMATED "Never shown in ribbon, Help or tooltips": the reviewer reads 'hidden: true' for PIPEEDIT, PITEDIT and TG in the installed register; the ribbon and Help need a Codex look.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "PIPEEDIT" -Force -TimeoutSec 90 -> $t_pe
  esc-prompt -> $e_pe
  type "PITEDIT" -Force -TimeoutSec 90 -> $t_pi
  esc-prompt -> $e_pi
  type "TG" -Force -TimeoutSec 90 -> $t_tg
  esc-prompt -> $e_tg
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  history absent "Unknown command"
  contains $t_pe "Select"
  contains $t_pi "Select"
  contains $t_tg "Specify trench drain start point:"
  history has "TG command cancelled."
  equals $c1 $c0
  not-contains $win_end "Edit Pipe"
  not-contains $win_end "Edit Pit"
  copy-unchanged $copy0
  record $t_pe "FULL what PIPEEDIT printed"
  record $t_pi "FULL what PITEDIT printed"
```

**Twin:** `N46_old_names_still_work_BROKEN.case.txt`

```
# N46_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). Types an old-looking name that was never registered (PIPEEDITX) and still expects its pick prompt: it must FAIL.
CASE N46_BROKEN
TITLE BROKEN VARIANT of N46: an unregistered name PIPEEDITX is expected to ask for a pick (must FAIL: Unknown command)
PLAN_ITEM red-before-green proof for N46 (UX-NAMES-01)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 471
TIMEOUT 600
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N46
REVIEWED_AGAINST
EXPECTED Wrong on purpose: PIPEEDITX is unknown, so 'contains $t_bad "Select"' fails; TG still answers.
WHY_NOT_UNIT_TEST It exists only to prove N46's check can go red.
STEPS
  ms-count -> $c0
  type "TG" -Force -TimeoutSec 90 -> $t_tg
  esc-prompt -> $e_tg
  type "PIPEEDITX" -Force -TimeoutSec 60 -> $t_bad
  wait
  ms-count -> $c1
ASSERT
  contains $t_tg "Specify trench drain start point:"
  equals $c1 $c0
  contains $t_bad "Select"
  record $t_bad "FULL what PIPEEDITX printed"
```

---

### Case 4 of 12: N47, the job timer runs for the open drawing (ranked item 8, UX-TIME-01)

**Intended file:** `N47_job_timer_session_runs.case.txt`

```
# N47 DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 8.
# Tim, 26 Sep 2026: "Automatically per job drawing (Recommended)". Opening a drawing in a job folder starts that job's timer (discipline noted); the status bar shows job, discipline and time; switching drawings switches job.
# Installed source (3.0.86): JobTimeTracker.cs 155 logs 'JobTime: session created — <job number or "no job #"> <drawing> (ID ...)' when a drawing opens; 323 'JobTime: auto-paused (idle) — <drawing>'; 345 'JobTime: auto-resumed — <drawing> was idle <n> min'. Idle time-out comes from CD_Settings.json jobTime.idleTimeoutMinutes (default 5).
# PROBLEM FOUND WHILE DRAFTING: the 'session created' line is written when the copy OPENS, which is BEFORE the case's log start byte (README batch 2 item 1), so 'log civil has' cannot see it. This case therefore proves the timer is RUNNING for this drawing by the idle pair, which IS written inside the case: idle time-out set to 1 minute, wait 80 s, then one harmless typed command.
# DERIVED: the jobTime key path, that the idle check fires while AutoCAD sits at the Command prompt, and the exact dash character in the log lines (matched with a regex that accepts any dash).
# HAZARD for the desk: the timer is real. A run adds a 'no job #' session to Tim's job-time records (weekly export folder) like every robot AutoCAD session already does. Check tests-can-touch-tims-real-files before the first run.
# Remembered values: NO.
CASE N47
TITLE The Civil job timer is running for the open drawing: after 1 minute idle it logs a pause naming this drawing, and the next command logs the resume
PLAN_ITEM UX-TIME-01 PART: a timer session exists and runs for the drawing that was opened (no job folder: the robot copy is not in a job folder). NOT whole: the job-folder branch (job number and discipline), the status-bar text and 'switching drawings switches job' are not driven (one drawing per case, status bar not readable)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json jobTime.idleTimeoutMinutes 1
ORDER 480
TIMEOUT 600
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED With the idle time-out at 1 minute, sitting 80 seconds at the Command prompt makes the Civil log say 'JobTime: auto-paused (idle) — <this drawing's name>'; typing REGEN then makes it say 'JobTime: auto-resumed — <this drawing's name> was idle <n> min'; nothing is drawn.
WHY_NOT_UNIT_TEST The timer hangs off the live document events and AutoCAD's idle state; only a running AutoCAD with an open drawing shows it.
NOT_AUTOMATED The 'session created' line at open (before the log start; recorded via log-read below if the runner returns the whole file, not judged). The status-bar pane text. The job-folder branch and drawing switching. The 'ask on return' click (UX-TIME-02) is not answered.
STEPS
  ms-count -> $c0
  sleep 80
  type "_.REGEN" -Force -> $regen
  wait
  sleep 3
  log-read civil -> $lg
  ms-count -> $c1
ASSERT
  log civil has "JobTime: auto-paused (idle)"
  log civil has "JobTime: auto-resumed"
  matches $lg "JobTime: auto-paused \(idle\) \S+ \S*DRV1_B1"
  equals $c1 $c0
  record $lg "FULL what log-read returned (look for 'session created')"
  record $regen "what REGEN printed"
```

**Twin:** `N47_job_timer_session_runs_BROKEN.case.txt`

```
# N47_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). Same route WITHOUT the 80 s idle wait: the timer cannot pause in 3 seconds, so the pause line must be absent and the check FAILS. Proves the pause check reads the log, not an old line.
CASE N47_BROKEN
TITLE BROKEN VARIANT of N47: expects an idle pause with no idle time (must FAIL)
PLAN_ITEM red-before-green proof for N47 (UX-TIME-01)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json jobTime.idleTimeoutMinutes 1
ORDER 481
TIMEOUT 300
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N47
REVIEWED_AGAINST
EXPECTED Wrong on purpose: no idle time passes, so 'JobTime: auto-paused (idle)' is not in the new log bytes and the check fails.
WHY_NOT_UNIT_TEST It exists only to prove N47's log check can go red.
STEPS
  ms-count -> $c0
  type "_.REGEN" -Force -> $regen
  wait
  sleep 3
  ms-count -> $c1
ASSERT
  equals $c1 $c0
  log civil has "JobTime: auto-paused (idle)"
```

---

### Case 5 of 12: N48, three identical pipes get three labels, never TYP. (ranked item 9, UX-CPLAN-25)

**Intended file:** `N48_three_pipes_three_labels.case.txt`

```
# N48 DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 9.
# Card 1.7 (BATCH1_DAY1_PLAN_LABELS_CARD): Tim, 27 Sep: "Label each." No "TYP.". Classification KEEP: "needs only a test that proves it (two identical neighbouring pipes, both labelled)".
# Route: SETUP-P8 places pipe 1 (150000,-80000 to 170000,-80000, 18.000 / 17.900). Pipes 2 and 3 are typed the same way 5 m and 10 m south (same inverts, so the same size, material and 1 IN 200). 5 m apart so the 2000 mm 'near' check of R18 picks one label per pipe.
# Label wording and distance rule from R18 (accepted route): '225 DIA. UPVC PIPE AT 1 IN 200', insertion point within 2000 mm of the pipe middle and above the pipe line. The size 225 comes from what the New Pipe window shows on this PC (R18 note).
# Remembered values: YES (CD typed three times; the same values every time).
CASE N48
TITLE Three identical neighbouring pipes each get their own label '225 DIA. UPVC PIPE AT 1 IN 200' near their own middle; no label says TYP.
PLAN_ITEM UX-CPLAN-25 WHOLE (card 1.7: every pipe labelled, never "TYP.", proven on identical neighbouring pipes as the card asks)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8
ORDER 490
TIMEOUT 1200
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After three CD runs of identical 20 m pipes at y -80000, -85000 and -90000, the drawing holds exactly three new label texts containing ' DIA. ', one within 2000 mm of each pipe's middle (160000,-80000 / -85000 / -90000) and above its own pipe line; each reads exactly '225 DIA. UPVC PIPE AT 1 IN 200'; no new text contains 'TYP.'.
WHY_NOT_UNIT_TEST Whether a label is written for each pipe, or skipped as a repeat, is decided by the live label writer looking at the real neighbouring pipes.
NOT_AUTOMATED Reading direction and rotation of each label (a Codex look, UX-CPLAN-23).
STEPS
  type "CD{NL}150000,-85000{NL}170000,-85000{NL}" -Force -ExpectWindow "New Pipe" -> $p2_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $p2_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $p2_e
  wait
  type "CD{NL}150000,-90000{NL}170000,-90000{NL}" -Force -ExpectWindow "New Pipe" -> $p3_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $p3_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $p3_e
  wait
  ms-new $n0 -> $all_new
  select $all_new object=CeCvlPipeObject -> $pipes
  select $all_new "text~ DIA\. " -> $labels
  select $labels "near=160000,-80000,2000" -> $lab1
  select $labels "near=160000,-85000,2000" -> $lab2
  select $labels "near=160000,-90000,2000" -> $lab3
  field $lab1 text -> $t1
  field $lab2 text -> $t2
  field $lab3 text -> $t3
  field $lab1 y -> $y1
  field $lab2 y -> $y2
  field $lab3 y -> $y3
  select $all_new "text~TYP\." -> $typ
  field $labels text -All -> $all_text
ASSERT
  count $pipes = 3
  count $labels = 3
  count $lab1 = 1
  count $lab2 = 1
  count $lab3 = 1
  equals $t1 "225 DIA. UPVC PIPE AT 1 IN 200"
  equals $t2 "225 DIA. UPVC PIPE AT 1 IN 200"
  equals $t3 "225 DIA. UPVC PIPE AT 1 IN 200"
  number $y1 > -80000
  number $y2 > -85000
  number $y3 > -90000
  count $typ = 0
  record $all_text "FULL every new label text"
  record $labels "the label objects (handle, layer, x, y)"
```

**Twin:** `N48_three_pipes_three_labels_BROKEN.case.txt`

```
# N48_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). Same route; reversed count: expects only ONE label for the three identical pipes (the 'TYP.' behaviour Tim ruled out). The product labels each, so it must FAIL.
CASE N48_BROKEN
TITLE BROKEN VARIANT of N48: expects one shared label for three identical pipes (must FAIL: three labels)
PLAN_ITEM red-before-green proof for N48 (UX-CPLAN-25)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8
ORDER 491
TIMEOUT 1200
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N48
REVIEWED_AGAINST
EXPECTED Wrong on purpose: three labels exist, so 'count $labels = 1' fails; the three-pipe count passes.
WHY_NOT_UNIT_TEST It exists only to prove N48's label count can go red.
STEPS
  type "CD{NL}150000,-85000{NL}170000,-85000{NL}" -Force -ExpectWindow "New Pipe" -> $p2_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $p2_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $p2_e
  wait
  type "CD{NL}150000,-90000{NL}170000,-90000{NL}" -Force -ExpectWindow "New Pipe" -> $p3_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $p3_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $p3_e
  wait
  ms-new $n0 -> $all_new
  select $all_new object=CeCvlPipeObject -> $pipes
  select $all_new "text~ DIA\. " -> $labels
ASSERT
  count $pipes = 3
  count $labels = 1
```

---

### Case 6 of 12: N49, Enter repeats CD with the last pipe type (ranked item 10, UX-CMD-03)

**Intended file:** `N49_enter_repeats_cd_last_values.case.txt`

```
# N49 DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 10.
# Tim (UX-CMD-03): "Same command, last values". Enter or Space repeats the last CE command starting from the size and type last used.
# Route: CD once with the pipe TYPE changed from the default (C2.IsChargedPipe ticked; field id used by earlier cases), Esc; then ONE bare Enter at the Command prompt with the two points chained in the same type string (README batch 2 item 6: typed text is refused while CE waits). The New Pipe window that opens must already show Charged ticked.
# The pipe SIZE field id is not used by any case (unknown), so 'size' is read from the dump text only (recorded, not judged). Size and type are one card clause; the type half is judged, the size half is recorded: see PLAN_ITEM.
# DERIVED: a leading {NL} in a type chain is sent as a bare Enter at the Command prompt; the control value reads 'True' / 'False'. If the runner refuses a chain that starts with {NL}, use 'type " {NL}150000,-85000..."' (Space repeats too) and say so in the review.
# HAZARD (remembered values): the case CHANGES the last-used pipe type to Charged. It restores it before ending: the repeated window is set back to unticked and its pipe placed, then that pipe is taken back with U (U does not undo the remembered-values file). Check CD_RecentValues.json after the first run.
CASE N49
TITLE After a charged CD pipe, one Enter at the Command prompt repeats CD and its New Pipe window opens with Charged already ticked
PLAN_ITEM UX-CMD-03 WHOLE for the CD route (Enter repeats the same command with the last type used); the size half of 'size and type' is recorded, not judged, until the size field id is known (reviewer to decide part or whole)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 500
TIMEOUT 1200
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED The first New Pipe window opens with Charged unticked; it is ticked and the pipe placed (150000,-80000 to 170000,-80000, 18.000 / 17.900), Esc ends CD. One bare Enter then starts CD again (no other command typed) and, after the two chained points, the New Pipe window opens with Charged already ticked. The case then unticks it, places that pipe and takes it back with one U.
WHY_NOT_UNIT_TEST The repeat comes from AutoCAD's own Enter-repeat of the last command plus CE's remembered values in the live session.
NOT_AUTOMATED The pipe size carried over is recorded from the window dump, not judged. Space as the repeat key is not driven. Other CE commands repeating (PIT, DP) are not driven.
STEPS
  ms-count -> $c0
  type "CD{NL}150000,-80000{NL}170000,-80000{NL}" -Force -ExpectWindow "New Pipe" -> $a_t1
  ui-dump "^New Pipe" -TimeoutSec 60 -> $w1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui2-set "New Pipe" "C2.IsChargedPipe" "true"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $a_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $a_e
  wait
  type "{NL}150000,-85000{NL}170000,-85000{NL}" -Force -ExpectWindow "New Pipe" -> $b_t1
  ui-dump "^New Pipe" -TimeoutSec 60 -> $w2
  ui2-set "New Pipe" "C2.IsChargedPipe" "false"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $b_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $b_e
  wait
  ms-new $c0 -> $new
  select $new object=CeCvlPipeObject -> $pipes
  type "U" -Force -> $u1
  wait
ASSERT
  control $w1 "C2.IsChargedPipe" value "False"
  control $w2 "C2.IsChargedPipe" value "True"
  history absent "Unknown command"
  count $pipes = 2
  contains $u1 "CD"
  record $b_t1 "FULL what the bare Enter and the two points printed"
  record $w2 "FULL the repeated New Pipe window (size read here)"
```

**Twin:** `N49_enter_repeats_cd_last_values_BROKEN.case.txt`

```
# N49_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). Same route; the first CD is placed WITHOUT ticking Charged, and the case still expects the repeated window to show Charged ticked. It must FAIL. No remembered-value hazard: Charged is never ticked.
CASE N49_BROKEN
TITLE BROKEN VARIANT of N49: expects Charged in the repeated window when it was never used (must FAIL)
PLAN_ITEM red-before-green proof for N49 (UX-CMD-03)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 501
TIMEOUT 1200
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N49
REVIEWED_AGAINST
EXPECTED Wrong on purpose: the repeated window shows Charged unticked, so 'control $w2 ... value "True"' fails; the repeat itself (window opens) passes.
WHY_NOT_UNIT_TEST It exists only to prove N49's control-value check can go red.
STEPS
  type "CD{NL}150000,-80000{NL}170000,-80000{NL}" -Force -ExpectWindow "New Pipe" -> $a_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $a_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $a_e
  wait
  type "{NL}150000,-85000{NL}170000,-85000{NL}" -Force -ExpectWindow "New Pipe" -> $b_t1
  ui-dump "^New Pipe" -TimeoutSec 60 -> $w2
  ui-press "New Pipe" "Cancel" -> $b_cancel
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $b_e
ASSERT
  history absent "Unknown command"
  control $w2 "C2.IsChargedPipe" value "True"
```

---

### Case 7 of 12: N50, a preview is enough, no "Are you sure?" (ranked item 11, UX-STD-02)

**Intended file:** `N50_preview_then_apply_asks_nothing.case.txt`

```
# N50 DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 11.
# Tim, Q39: "No, the preview is enough (Recommended)". Preview, one click, done; one U takes it back. Only deleting CE's link records still asks.
# Two preview commands: (1) CDPERIMETER, route of R37 (accepted prompts): the 'Preview:' line, then ONE question 'Place this perimeter drain? [Accept/Cancel] <Accept>:' answered by Enter. That one question IS the click; nothing else may ask. (2) CDTIDYLABELS with the Tidy switch on, route of R16 (accepted): 'Will move 1' preview, then ONE question 'Move this label now? [Yes/No] <No>:' answered Yes.
# DERIVED: after Yes the start invert text IL 18.000 at P8 moves 275 mm (R16's preview number), and nothing else asks. Not seen on a run (R16 always answered Esc). Avoid REDO (BUG-861).
# Remembered values: YES (SETUP-R47 types PIT and CD); the guard restores CD_Settings.json.
CASE N50
TITLE After a preview, CDPERIMETER places on one Enter and Tidy labels moves on one Yes; no 'Are you sure', no second question; one U takes each back
PLAN_ITEM UX-STD-02 PART: the two preview commands on the Day-1 drafting path (CDPERIMETER, CDTIDYLABELS). NOT whole: the other preview commands (CDAGI, CDKERB, Pit Schedule place/update, broken Xref repair) and the 'only deleting CE link records asks' exception are not driven
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.tidyLabelsEnabled true
SETUP SETUP-R47
ORDER 510
TIMEOUT 1500
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CDPERIMETER (150000,-95000 to 152000,-95000, levels 18 and 17.9) prints the Preview line, asks 'Place this perimeter drain?' once, and Enter places PD<n>; one U removes it. Then, with the SPOT LEVEL 10EC5D moved onto the P8 invert text as in R16, CDTIDYLABELS All previews 'Will move 1', asks 'Move this label now?' once, and Yes moves the IL 18.000 text 275 mm (within 5 mm) with no further question; no line anywhere says 'Are you sure' or 'Confirm'; the object count is unchanged by the tidy.
WHY_NOT_UNIT_TEST The number of questions between preview and change is the live command conversation in AutoCAD.
NOT_AUTOMATED One U after the tidy is not driven (one Esc-free U after a pick is the BUG-861 route); the label's new look is a Codex look.
STEPS
  ms-count -> $c0
  type "CDPERIMETER{NL}{NL}150000,-95000{NL}152000,-95000{NL}{NL}{NL}18{NL}17.9{NL}" -Force -TimeoutSec 90 -> $pd
  wait
  esc-prompt -> $pde
  wait
  ms-count -> $c1
  type "U" -Force -> $u_pd
  wait
  ms-count -> $c2
  select $new_all "text~^IL 18\.000$" "near=150000,-80000,1500" -> $il0
  field $il0 handle -> $ilh
  field $il0 x -> $il_x0
  field $il0 y -> $il_y0
  pick-first "10EC5D"
  type "_.MOVE{NL}0,0{NL}81839,-53713" -Force -> $spot_move
  wait
  type "_.ZOOM{NL}_W{NL}148500,-81500{NL}152500,-78500" -Force
  wait
  ms-count -> $cnt0
  type "CDTIDYLABELS{NL}All{NL}Yes" -Force -> $tidy
  wait
  sleep 2
  esc-prompt -> $tidy_esc
  wait
  ms-count -> $cnt1
  ms-new $n0 -> $after_tidy
  select $after_tidy "handle={$ilh}" -> $il1
  dist $il1 "{$il_x0},{$il_y0}" -> $moved
ASSERT
  contains $pd "Preview: perimeter drain, 2 vertices, open."
  contains $pd "Place this perimeter drain? [Accept/Cancel] <Accept>:"
  contains $pd "Perimeter drain PD"
  number $c1 > $c0
  equals $c2 $c0
  history count "Place this perimeter drain?" = 1
  history has "[CE] Will move 1"
  history count "Move this label now?" = 1
  number $moved = 275 +- 5
  equals $cnt1 $cnt0
  history absent "Are you sure"
  history absent "Confirm"
  record $pd "FULL CDPERIMETER"
  record $tidy "FULL CDTIDYLABELS with Yes"
  record $tidy_esc "what the closing Esc printed"
  record $moved "how far the CE invert text moved (mm)"
```

**Twin:** `N50_preview_then_apply_asks_nothing_BROKEN.case.txt`

```
# N50_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). CDPERIMETER part only (no setting, no setup, fast). Reversed: expects TWO 'Place this perimeter drain?' questions (an extra 'are you sure' round). The product asks once, so it must FAIL.
CASE N50_BROKEN
TITLE BROKEN VARIANT of N50: expects a second question after the preview (must FAIL: asked once)
PLAN_ITEM red-before-green proof for N50 (UX-STD-02)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 511
TIMEOUT 600
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N50
REVIEWED_AGAINST
EXPECTED Wrong on purpose: the question is asked once, so 'history count ... = 2' fails; the preview and placement checks pass.
WHY_NOT_UNIT_TEST It exists only to prove N50's question count can go red.
STEPS
  ms-count -> $c0
  type "CDPERIMETER{NL}{NL}150000,-95000{NL}152000,-95000{NL}{NL}{NL}18{NL}17.9{NL}" -Force -TimeoutSec 90 -> $pd
  wait
  esc-prompt -> $pde
  wait
  ms-count -> $c1
  type "U" -Force -> $u_pd
  wait
ASSERT
  contains $pd "Preview: perimeter drain, 2 vertices, open."
  number $c1 > $c0
  history count "Place this perimeter drain?" = 2
```

---

### Case 8 of 12: N51, a trench drain by two points, outlet picked, one U (ranked item 12, UX-SURF-01)

**Intended file:** `N51_trench_drain_two_points_u.case.txt`

```
# N51 DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 12.
# Tim, 27 Sep 18:57: "Draw by two points". Pick start and end; drawn in the legend style with width and grate class; outlets to the pit or pipe picked.
# Prompts from installed 3.0.86 SourceBlockInsertCommands.cs: 'Specify trench drain start point:' (159), 'Specify trench drain end point:' (168), 'Trench width <default>:' (201, Enter = default), 'Trench grate style [Standard/ACO] <Standard>:' (698), 'Grate class [A/B/C/D] <C>:' (737), 'Cover Level (m AHD) or [Blank] <enter to skip>:' (763), the outlet pick 'Select outlet pit or pipe (Enter to skip):' (AgiCommand.cs 218), then 'Trench grate placed. Tag: TG<n>. Length: <mm>mm Width: <mm>mm Rotation: <deg>deg Outlet: <label>.' (400). Block TRENCH GRATE on layer TRENCH GRATE.
# The outlet is the SETUP-P8 pipe, picked ON its line at 160000,-80000 after a zoom (README batch 3 item 3: a typed point picks nothing outside the view).
# DERIVED: nothing is asked between the command start and the start point; whether TG offers 'Pick the next TG' after placing (an esc-prompt ends it either way); the outlet label wording. Class B is typed so the class answer is not the default; where class B shows is recorded, not judged.
# Remembered values: YES (CD typed by SETUP-P8; CDTG remembers width and class: the last class becomes B for the next run on this PC).
CASE N51
TITLE CDTG by two points 5 m apart, class B, outlet picked on a CE pipe: one TG placed on layer TRENCH GRATE, 5000 mm long, naming its outlet; one U takes it back
PLAN_ITEM UX-SURF-01 PART: two points, width default, class chosen, outlet to a picked pipe, one U. NOT whole: 'drawn in the legend style' (what the grate looks like) is a Codex look, and the outlet to a PIT (not a pipe) is not driven
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8
ORDER 520
TIMEOUT 1200
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CDTG asks the start point, end point, width, style, class, cover level and outlet in that order; with 140000,-80000 / 145000,-80000, default width, Standard, class B, no cover level and the outlet picked on the new pipe, it prints 'Trench grate placed. Tag: TG<n>. Length: 5000mm ... Rotation: 0deg Outlet: ...'; exactly one new TRENCH GRATE block on layer TRENCH GRATE; one U takes the trench drain back (object count as before).
WHY_NOT_UNIT_TEST The two picks, the outlet pick on a real pipe and the placed block come from the live command in the drawing.
NOT_AUTOMATED The grate's legend look, its width on the plan and where class B is shown (record only). An outlet to a pit. The ACO style.
STEPS
  type "_.ZOOM{NL}_W{NL}138000,-83000{NL}172000,-77000" -Force
  wait
  ms-count -> $c0
  type "CDTG{NL}140000,-80000{NL}145000,-80000{NL}{NL}{NL}B{NL}{NL}160000,-80000" -Force -TimeoutSec 120 -> $tg
  wait
  esc-prompt -> $tge
  wait
  ms-count -> $c1
  ms-new $c0 -> $new
  select $new "name~^TRENCH GRATE" -> $tgb
  field $tgb layer -> $tg_layer
  field $new object -All -> $new_types
  type "U" -Force -> $u1
  wait
  ms-count -> $c2
ASSERT
  contains $tg "Specify trench drain start point:"
  contains $tg "Specify trench drain end point:"
  contains $tg "Trench width <"
  contains $tg "Grate class [A/B/C/D]"
  contains $tg "Select outlet pit or pipe (Enter to skip):"
  history has "Trench grate placed. Tag: TG"
  history has "Length: 5000mm"
  history has "Rotation: 0deg"
  history has "Outlet: "
  history absent "TG command cancelled."
  count $tgb = 1
  equals $tg_layer "TRENCH GRATE"
  equals $c2 $c0
  record $tg "FULL CDTG"
  record $tge "FULL after the Esc"
  record $new_types "object types CDTG added"
  record $u1 "FULL what U echoed"
```

**Twin:** `N51_trench_drain_two_points_u_BROKEN.case.txt`

```
# N51_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). Same route WITHOUT the outlet pick (Enter skips it) but still expects the 'Outlet: ' words in the placed line. It must FAIL. No SETUP needed (no pipe to pick).
CASE N51_BROKEN
TITLE BROKEN VARIANT of N51: expects an outlet named when the outlet was skipped (must FAIL)
PLAN_ITEM red-before-green proof for N51 (UX-SURF-01)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 521
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N51
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the outlet skipped the placed line has no 'Outlet:' part, so 'history has "Outlet: "' fails; the placement and U checks pass.
WHY_NOT_UNIT_TEST It exists only to prove N51's outlet check can go red.
STEPS
  type "_.ZOOM{NL}_W{NL}138000,-83000{NL}172000,-77000" -Force
  wait
  ms-count -> $c0
  type "CDTG{NL}140000,-80000{NL}145000,-80000{NL}{NL}{NL}B{NL}{NL}" -Force -TimeoutSec 120 -> $tg
  wait
  esc-prompt -> $tge
  wait
  ms-new $c0 -> $new
  select $new "name~^TRENCH GRATE" -> $tgb
  type "U" -Force -> $u1
  wait
  ms-count -> $c2
ASSERT
  history has "Trench grate placed. Tag: TG"
  count $tgb = 1
  equals $c2 $c0
  history has "Outlet: "
```

---

### Case 9 of 12: N52, DP and OF keep placing until Esc (ranked item 13, UX-STD-01)

**Intended file:** `N52_dp_of_carry_on_until_esc.case.txt`

```
# N52 DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 13. R01 covers PIT and CD; this covers the source commands.
# Tim, Q9 and follow-up (25 Sep): placing commands (pipe, pit, source) carry on until Enter or Escape; "Every time" the window opens for every item.
# Installed 3.0.86: SourceBlockInsertCommands.cs 897 prints '[CE] Pick the next <tag>, or press Esc to stop.' after each tagged source (DP seen on a run: N04 'Pick the next DP'). The OF text is DERIVED from the same line.
# Route copied from SETUP-P8x2 (accepted R01): typed text is lost while CE waits at a prompt, so the SECOND DP and the SECOND OF are placed by real mouse clicks (v3 pt-click -Blind after a zoom and v3 view-read); each run is ended by one v3 esc-key. DP and OF open no window, so 'the window opens for every item' is not in play for them.
# Remembered values: NO.
CASE N52
TITLE DP and OF each keep placing until Esc: two downpipes from one DP run, two overflows from one OF run, each run logged completed, nothing refused
PLAN_ITEM UX-STD-01 PART: the source half for DP and OF (R01 is the PIT and CD half). NOT whole: IO, FO, CDFW and CDRG runs, and the 'window opens for every item' clause for windowed sources, are not driven
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 530
TIMEOUT 1200
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED DP at 140000,-95000 prints 'Downpipe placed.' and '[CE] Pick the next DP, or press Esc to stop.'; a click at 142000,-95000 places a second downpipe; Esc stops it. OF at 146000,-95000 likewise offers '[CE] Pick the next OF, or press Esc to stop.'; a click at 148000,-95000 places a second; Esc stops it. Two new DOWNPIPE DYNAMIC WITH MASK inserts exist; the object count after OF is higher than after DP; the Civil log says 'Command outcome: DP completed' and 'Command outcome: OF completed' and neither 'cancelled'.
WHY_NOT_UNIT_TEST The carry-on is a live chain of AutoCAD prompts; only the drawing shows that the second pick really placed a second source.
NOT_AUTOMATED The OF block name is not known, so OF is counted by objects added and by the prompt count, not by block name. IO, FO, CDFW, CDRG.
STEPS
  type "_.ZOOM _C 145000,-95000 20000"
  wait
  v3 view-read
  ms-count -> $c0
  type "DP{NL}140000,-95000" -Force -TimeoutSec 90 -> $dp1
  v3 pt-click "142000,-95000" -Blind -> $dp_click2
  sleep 3
  v3 esc-key
  sleep 3
  wait
  ms-count -> $c1
  ms-new $c0 -> $new_dp
  select $new_dp "name=DOWNPIPE DYNAMIC WITH MASK" -> $dps
  type "OF{NL}146000,-95000" -Force -TimeoutSec 90 -> $of1
  v3 pt-click "148000,-95000" -Blind -> $of_click2
  sleep 3
  v3 esc-key
  sleep 3
  wait
  ms-count -> $c2
ASSERT
  history count "[CE] Pick the next DP, or press Esc to stop." = 2
  history count "Downpipe placed." = 2
  count $dps = 2
  history count "[CE] Pick the next OF, or press Esc to stop." = 2
  number $c2 > $c1
  history absent "was not placed"
  log civil has "Command outcome: DP completed"
  log civil has "Command outcome: OF completed"
  log civil absent "Command outcome: DP cancelled"
  log civil absent "Command outcome: OF cancelled"
  record $dp1 "FULL first DP"
  record $of1 "FULL first OF"
```

**Twin:** `N52_dp_of_carry_on_until_esc_BROKEN.case.txt`

```
# N52_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). DP half only, and the second click is NOT made: the case still expects two downpipes. It must FAIL (one downpipe).
CASE N52_BROKEN
TITLE BROKEN VARIANT of N52: expects two downpipes from one DP run with only one pick (must FAIL)
PLAN_ITEM red-before-green proof for N52 (UX-STD-01)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 531
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N52
REVIEWED_AGAINST
EXPECTED Wrong on purpose: one downpipe is placed, so 'count $dps = 2' fails; the first 'Pick the next DP' line passes.
WHY_NOT_UNIT_TEST It exists only to prove N52's object count can go red.
STEPS
  type "_.ZOOM _C 145000,-95000 20000"
  wait
  v3 view-read
  ms-count -> $c0
  type "DP{NL}140000,-95000" -Force -TimeoutSec 90 -> $dp1
  sleep 3
  v3 esc-key
  sleep 3
  wait
  ms-new $c0 -> $new_dp
  select $new_dp "name=DOWNPIPE DYNAMIC WITH MASK" -> $dps
ASSERT
  history has "[CE] Pick the next DP, or press Esc to stop."
  count $dps = 2
```

---

### Case 10 of 12: N53, the drafter draws the DP connection pipe, CE never auto-routes (ranked item 14, UX-DP-02)

**Intended file:** `N53_cd_from_dp_joins_downpipe.case.txt`

```
# N53 DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 14.
# Tim (UX-DP-02): "Draw each". The drafter draws each downpipe's connection pipe; CE does not auto-route them.
# Route: SETUP-P8 (pit P8 at 150000,-80000 with its outgoing pipe at IL 18.000). DP placed at 140000,-80000 (N04 wording: 'Nothing nearby. The source connects when a pipe is drawn to it.'), Esc. Proof 1 (no auto-route): no pipe object is added by DP. Then CD from the DP to the pit P8, inverts 18.300 / 18.200 (above the pit's outgoing 18.000). Proof 2 (the drafter's pipe joins both ends): the flow line names the DP and P8.
# DERIVED: the flow line reads 'Flow: DP<n> -> P8' (from the accepted 'Flow: P8 -> Open end' wording of SETUP-P8 and the DP tag DP<n>); not seen on a run.
# Remembered values: YES (CD typed).
CASE N53
TITLE A downpipe placed near a pit gets no pipe by itself; the pipe the drafter draws from the DP to pit P8 joins both ends and flows DP to P8
PLAN_ITEM UX-DP-02 WHOLE (the drafter draws each DP connection pipe; CE does not auto-route; the drawn pipe joins the DP and the pit)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8
ORDER 540
TIMEOUT 1200
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED DP at 140000,-80000 prints 'Downpipe placed. Tag: DP<n>.' and adds one downpipe and NO pipe object. CD from 140000,-80000 to 150000,-80000 with inverts 18.300 / 18.200 adds exactly one pipe object and prints a flow line from that DP to P8; nothing says 'Free end' for the new pipe.
WHY_NOT_UNIT_TEST Joining depends on the live hit areas of the real downpipe and pit in the drawing.
NOT_AUTOMATED Level 3 network proposals (UX-L3-15..19, on request) are not driven; that they stay off unless asked is read only from 'no pipe added by DP'.
STEPS
  ms-count -> $d0
  type "DP{NL}140000,-80000" -Force -TimeoutSec 90 -> $dp
  esc-prompt -> $dp_esc
  wait
  ms-count -> $d1
  ms-new $d0 -> $after_dp
  select $after_dp "name=DOWNPIPE DYNAMIC WITH MASK" -> $dps
  select $after_dp object=CeCvlPipeObject -> $auto_pipes
  type "CD{NL}140000,-80000{NL}150000,-80000{NL}" -Force -ExpectWindow "New Pipe" -> $cd_t1
  ui2-set "New Pipe" "C2.FirstInvert" "18.300"
  ui2-set "New Pipe" "C2.SecondInvert" "18.200"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $cd_t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $cd_e
  wait
  ms-new $d1 -> $after_cd
  select $after_cd object=CeCvlPipeObject -> $drawn_pipes
ASSERT
  history has "Downpipe placed. Tag: DP"
  count $dps = 1
  count $auto_pipes = 0
  count $drawn_pipes = 1
  history has "Flow: DP"
  history has "-> P8"
  record $cd_t2 "FULL what Start Pipe printed"
  record $cd_e "FULL what the Esc printed"
```

**Twin:** `N53_cd_from_dp_joins_downpipe_BROKEN.case.txt`

```
# N53_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). DP half only. Reversed: expects the DP to bring its own connection pipe (the auto-route Tim chose against). It must FAIL.
CASE N53_BROKEN
TITLE BROKEN VARIANT of N53: expects a pipe drawn automatically when a DP is placed near pit P8 (must FAIL)
PLAN_ITEM red-before-green proof for N53 (UX-DP-02)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8
ORDER 541
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N53
REVIEWED_AGAINST
EXPECTED Wrong on purpose: no pipe is added by DP, so 'count $auto_pipes = 1' fails; the DP placement check passes.
WHY_NOT_UNIT_TEST It exists only to prove N53's no-auto-route check can go red.
STEPS
  ms-count -> $d0
  type "DP{NL}140000,-80000" -Force -TimeoutSec 90 -> $dp
  esc-prompt -> $dp_esc
  wait
  ms-new $d0 -> $after_dp
  select $after_dp object=CeCvlPipeObject -> $auto_pipes
ASSERT
  history has "Downpipe placed. Tag: DP"
  count $auto_pipes = 1
```

---

### Case 11 of 12: N54, an AG drain as a simple CE run with outlet and grade check (ranked item 15, UX-SURF-04)

**Intended file:** `N54_cdagi_run_outlet_grade_u.case.txt`

```
# N54 DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 15. R37 and R37b cover the perimeter half; this is the AG half.
# Tim, 27 Sep 19:09: "CE run, own style". Drawn like a pipe run in the legend AG style with an outlet to a pit; grade check and label only, no full hydraulics.
# Installed 3.0.86 AgiCommand.cs / AgiCommand.Apply.cs: 'AG drain pipe property [None/Charged/Suspended] <None>:', 'Specify first AGI drain vertex:' (vertex word DERIVED), 'Select outlet pit or pipe (Enter to skip):', two invert levels, 'Preview: AG drain, 2 vertices, open. Grade: ...', 'Place this AGI drain? [Accept/Cancel] <Accept>', then '[CE] AG drain AGI<n> placed. Vertices: 2. Closed: no. Outlet: <label>. Grade: ... One Undo removes it and its record.' Layer AGI DRAIN. Tag prefix AGI (DRV1_B1 already holds four AGI blocks, so n is not 1).
# Millimetre drawing on purpose (BUG-1052, metre drawings, is not installed).
# DERIVED: 18.5 then 18.4 over 5 m reads 1:50 and 'meets the office minimum 1:100' (R37's 1:20 line is the accepted form); the levels are asked start then end and the run falls towards the outlet end (BUG-649 reads which end is nearer the outlet).
# Remembered values: YES (CD typed by SETUP-P8).
CASE N54
TITLE CDAGI draws a 5 m AG drain as one CE run on layer AGI DRAIN, outlet picked on a CE pipe, grade 1:50 checked against the office 1:100, no hydraulics; one U takes it back
PLAN_ITEM UX-SURF-04 PART: the AG half (outlet, grade check, own layer, one U); with R37 and R37b (perimeter) this completes the typed card EXCEPT 'outlet to a PIT' (a pipe is picked here) and 'legend AG style' (a Codex look)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8
ORDER 550
TIMEOUT 1200
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CDAGI with property None, vertices 140000,-80000 and 145000,-80000, the outlet picked on the new pipe at 160000,-80000 and levels 18.5 / 18.4 prints 'Preview: AG drain, 2 vertices, open. Grade: 1:50' and 'meets the office minimum 1:100', asks 'Place this AGI drain?' once, and on Enter prints 'AG drain AGI<n> placed. Vertices: 2. Closed: no. Outlet: ...'; one polyline is added on layer AGI DRAIN; no velocity or flow figure is printed; one U removes it.
WHY_NOT_UNIT_TEST The vertices, the outlet pick on a real pipe and the drawn run come from the live command.
NOT_AUTOMATED Outlet to a pit. The AG legend look (AG_LINE linetype seen on the plan). Charged and Suspended (UX-SURF-05).
STEPS
  type "_.ZOOM{NL}_W{NL}138000,-83000{NL}172000,-77000" -Force
  wait
  ms-count -> $c0
  type "CDAGI{NL}{NL}140000,-80000{NL}145000,-80000{NL}{NL}160000,-80000{NL}18.5{NL}18.4{NL}" -Force -TimeoutSec 120 -> $ag
  wait
  esc-prompt -> $age
  wait
  ms-count -> $c1
  ms-new $c0 -> $new
  select $new "object~^AcDbPolyline$" -> $ag_line
  field $ag_line layer -> $ag_layer
  type "U" -Force -> $u1
  wait
  ms-count -> $c2
ASSERT
  contains $ag "AG drain pipe property [None/Charged/Suspended] <None>:"
  contains $ag "Select outlet pit or pipe (Enter to skip):"
  matches $ag "Preview: AG drain, 2 vertices, open\. Grade: 1:50"
  contains $ag "meets the office minimum 1:100"
  contains $ag "Place this AGI drain?"
  matches $ag "AG drain AGI\d+ placed\. Vertices: 2\. Closed: no\. Outlet: "
  history absent "velocity"
  history absent "AG drain refused"
  count $ag_line = 1
  equals $ag_layer "AGI DRAIN"
  equals $c2 $c0
  record $ag "FULL CDAGI"
  record $age "FULL after the Esc"
  record $u1 "FULL what U echoed"
```

**Twin:** `N54_cdagi_run_outlet_grade_u_BROKEN.case.txt`

```
# N54_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). Same route; the run is drawn and the case expects it on the charged layer 'AGI DRAIN CHARGED' although the property answer was None. It must FAIL.
CASE N54_BROKEN
TITLE BROKEN VARIANT of N54: expects a plain AG drain on the charged layer (must FAIL: it is on AGI DRAIN)
PLAN_ITEM red-before-green proof for N54 (UX-SURF-04)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-P8
ORDER 551
TIMEOUT 1200
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N54
REVIEWED_AGAINST
EXPECTED Wrong on purpose: the line is on AGI DRAIN, so 'equals $ag_layer "AGI DRAIN CHARGED"' fails; the placed line and U checks pass.
WHY_NOT_UNIT_TEST It exists only to prove N54's layer check can go red.
STEPS
  type "_.ZOOM{NL}_W{NL}138000,-83000{NL}172000,-77000" -Force
  wait
  ms-count -> $c0
  type "CDAGI{NL}{NL}140000,-80000{NL}145000,-80000{NL}{NL}160000,-80000{NL}18.5{NL}18.4{NL}" -Force -TimeoutSec 120 -> $ag
  wait
  esc-prompt -> $age
  wait
  ms-new $c0 -> $new
  select $new "object~^AcDbPolyline$" -> $ag_line
  field $ag_line layer -> $ag_layer
  type "U" -Force -> $u1
  wait
  ms-count -> $c2
ASSERT
  matches $ag "AG drain AGI\d+ placed\."
  equals $c2 $c0
  equals $ag_layer "AGI DRAIN CHARGED"
```

---

### Case 12 of 12: N55, Tidy labels moves only CE labels (ranked item 21, UX-LBL-04)

**Intended file:** `N55_tidy_moves_only_ce_labels.case.txt`

```
# N55 DRAFT (Fri 30 Oct 2026; NOT RUN, NOT REVIEWED). Ranked item 21 (taken in place of items 19 and 20: see ANSWER FIRST item 2 of the report). The planner proposed the name N57; renamed N55 so the numbers stay in order.
# Card 1.5: Tim, 26 Sep: "Avoid everything, move only CE." Today the tidy steers clear of model-space text, multiline text, leaders, dimensions, tables, blocks, CE pipes and pit outlines, and only ever moves CE pipe attachments; Xref content and hatches are NOT avoided yet (card: MODIFY).
# Route of R16 (accepted) plus Yes, with a plain AutoCAD TEXT added by the drafter 1 m east of the P8 invert text: the SPOT LEVEL 10EC5D (a non-CE block) is moved onto the invert text; Tidy then moves the CE invert text and must NOT move the spot level block or the plain text.
# DERIVED: TEXT prompts (start point, height, rotation, text, then an empty Enter ends it in AutoCAD 2027); the invert text moves 275 mm (R16's preview figure).
# Remembered values: YES (SETUP-R47); the guard restores CD_Settings.json.
CASE N55
TITLE Tidy labels with Yes moves the CE invert text 275 mm and leaves the drafter's SPOT LEVEL block and a plain TEXT exactly where they were
PLAN_ITEM UX-LBL-04 PART: 'only CE labels move' and 'avoid' for a block and a plain text. NOT whole: Xref content and hatches (the card's MODIFY items) are not driven: no Xref test drawing exists and the card says they are not built yet
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.tidyLabelsEnabled true
SETUP SETUP-R47
ORDER 560
TIMEOUT 1500
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED A plain TEXT 'PLAIN NOTE' typed at 151000,-80500 and the SPOT LEVEL block 10EC5D moved as in R16; CDTIDYLABELS All then Yes moves the CE text IL 18.000 at P8 by 275 mm (within 5), the SPOT LEVEL block by 0 mm and the plain text by 0 mm (within 0.5 each); the moved invert text does not land within 300 mm of the plain text; the object count is unchanged by the tidy.
WHY_NOT_UNIT_TEST What the live tidy treats as movable or as an obstacle depends on the real objects in the drawing.
NOT_AUTOMATED Xref text and hatches (card 1.5 items 3 and 5). Locked layers. Labels of other disciplines. Whether the new spot is the 'best' one (Codex look).
STEPS
  type "_.TEXT{NL}151000,-80500{NL}100{NL}0{NL}PLAIN NOTE{NL}" -Force -> $txt
  wait
  ms-new $n0 -> $after_txt
  select $after_txt "text~^PLAIN NOTE$" -> $pt0
  field $pt0 handle -> $pth
  field $pt0 x -> $pt_x0
  field $pt0 y -> $pt_y0
  select $new_all "text~^IL 18\.000$" "near=150000,-80000,1500" -> $il0
  field $il0 handle -> $ilh
  field $il0 x -> $il_x0
  field $il0 y -> $il_y0
  pick-first "10EC5D"
  type "_.MOVE{NL}0,0{NL}81839,-53713" -Force -> $spot_move
  wait
  ent-read 10EC5D -> $spot1
  type "_.ZOOM{NL}_W{NL}148500,-81500{NL}152500,-78500" -Force
  wait
  ms-count -> $cnt0
  type "CDTIDYLABELS{NL}All{NL}Yes" -Force -> $tidy
  wait
  sleep 2
  esc-prompt -> $tidy_esc
  wait
  ms-count -> $cnt1
  ent-read 10EC5D -> $spot2
  ms-new $n0 -> $after_tidy
  select $after_tidy "handle={$ilh}" -> $il1
  select $after_tidy "handle={$pth}" -> $pt1
  dist $il1 "{$il_x0},{$il_y0}" -> $il_moved
  dist $pt1 "{$pt_x0},{$pt_y0}" -> $pt_moved
  field $pt1 x -> $pt_x1
  field $pt1 y -> $pt_y1
  dist $il1 "{$pt_x1},{$pt_y1}" -> $il_to_plain
ASSERT
  count $pt0 = 1
  count $il0 = 1
  history has "[CE] Will move 1"
  number $il_moved = 275 +- 5
  number $pt_moved = 0 +- 0.5
  equals $spot2 $spot1
  number $il_to_plain > 300
  equals $cnt1 $cnt0
  record $txt "FULL what TEXT printed"
  record $tidy "FULL CDTIDYLABELS with Yes"
  record $spot2 "the SPOT LEVEL block after the tidy"
  record $il_to_plain "distance from the moved invert text to the plain text (mm)"
```

**Twin:** `N55_tidy_moves_only_ce_labels_BROKEN.case.txt`

```
# N55_BROKEN DRAFT (Fri 30 Oct 2026; NOT RUN). Same route; reversed: expects the plain TEXT to have moved too (the 'moves everything' behaviour Tim ruled out). It must FAIL.
CASE N55_BROKEN
TITLE BROKEN VARIANT of N55: expects the drafter's plain TEXT to move under Tidy labels (must FAIL: it stays)
PLAN_ITEM red-before-green proof for N55 (UX-LBL-04)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.tidyLabelsEnabled true
SETUP SETUP-R47
ORDER 561
TIMEOUT 1500
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N55
REVIEWED_AGAINST
EXPECTED Wrong on purpose: the plain text stays, so 'number $pt_moved > 1' fails; the CE invert text move check passes.
WHY_NOT_UNIT_TEST It exists only to prove N55's 'stays put' distance check can go red.
STEPS
  type "_.TEXT{NL}151000,-80500{NL}100{NL}0{NL}PLAIN NOTE{NL}" -Force -> $txt
  wait
  ms-new $n0 -> $after_txt
  select $after_txt "text~^PLAIN NOTE$" -> $pt0
  field $pt0 handle -> $pth
  field $pt0 x -> $pt_x0
  field $pt0 y -> $pt_y0
  select $new_all "text~^IL 18\.000$" "near=150000,-80000,1500" -> $il0
  field $il0 handle -> $ilh
  field $il0 x -> $il_x0
  field $il0 y -> $il_y0
  pick-first "10EC5D"
  type "_.MOVE{NL}0,0{NL}81839,-53713" -Force -> $spot_move
  wait
  type "_.ZOOM{NL}_W{NL}148500,-81500{NL}152500,-78500" -Force
  wait
  type "CDTIDYLABELS{NL}All{NL}Yes" -Force -> $tidy
  wait
  sleep 2
  esc-prompt -> $tidy_esc
  wait
  ms-new $n0 -> $after_tidy
  select $after_tidy "handle={$ilh}" -> $il1
  select $after_tidy "handle={$pth}" -> $pt1
  dist $il1 "{$il_x0},{$il_y0}" -> $il_moved
  dist $pt1 "{$pt_x0},{$pt_y0}" -> $pt_moved
ASSERT
  number $il_moved = 275 +- 5
  number $pt_moved > 1
```

---

## 3. What each draft leans on that no run has shown (check these first on the first run)

1. **N45:** CEFIND and CSREOBAR first prompts; CSREOBAR needs the Structural module loaded on the robot's AutoCAD.
2. **N45w:** whether `close-windows` with no window open is harmless; CDWT, CDLPD, CDSC, CDCJ first prompts.
3. **N46:** the CDEDIT pick prompt contains "Select".
4. **N47:** the jobTime settings key path; that the idle pause fires at the Command prompt within 80 s of a 1-minute time-out; what `log-read civil` returns (whole file or new bytes).
5. **N48:** none beyond R18's accepted wording; the 5 m spacing is chosen so the 2000 mm search finds one label each.
6. **N49:** a type chain starting with `{NL}` as a bare Enter; the control value text "True"/"False"; that the remembered type is restored.
7. **N50 and N55:** the 275 mm move after Yes (only the preview figure has been seen); TEXT's prompt order.
8. **N51:** nothing asked before the start point; the outlet wording.
9. **N52:** the OF carry-on line (DP's is seen).
10. **N53:** the flow line "Flow: DP<n> -> P8".
11. **N54:** the AG vertex word, the 1:50 grade line, and which level is asked first.

---

## 4. Order to run and the re-test rule

1. **After the C-77 install** (the planner's point 3: the install restarts the two-pass clock), validate all 24 texts, then run pack A without settings: N45, N45w, N46, N48, N49, N51, N52, N53, N54 and their twins.
2. **Pack B, settings guard sessions:** N47 (jobTime), N50 and N55 (Tidy switch ON), with their twins. N50 and N55 share setting and setup, so they share one guarded session group.
3. **Smoke sets touched (RETEST_SMOKE_SETS.md), for the desk's area map:** N48, N49, N53 touch New Pipe / CD (area 2) and the labels set S6; N51, N52, N53, N54 touch sources (area 8) and layers S7; N50 and N55 touch Tidy labels (S6); N47 touches the Settings set S1 only through its own key.
4. **Opus review files** are written only after two clean passes on the same build and a red twin, as the README requires. None is written here.

---

## 5. What I did NOT verify (RULES 5.9)

1. **Nothing was run or validated.** No AutoCAD, no runner, not even `case_runner.ps1 validate`. The case texts follow the README and the accepted cases line by line, but a validator error is possible.
2. **Prompts and printed lines** were read from the 3.0.86 source on `origin/claude/rel-20261029a`. A newer line, `origin/claude/rel-20261030a`, exists (probably C-77); I did not diff it. Re-read the quoted lines on whatever is installed before the first run.
3. **The installed build** was taken from the planner's file, not from the DLL's product version (RULES 8.4). Read it before the first run.
4. **Whole-card judgements** (4 WHOLE, 8 PART) are mine; the independent reviewer decides.
5. **The register names in N45's NOT_AUTOMATED** (PIT, PP, MR and so on) were not checked for their dates; that check is the reviewer's.
6. **The empty-ground assumption** for x 140000 to 148000 was not checked against the master drawing.
7. **No client names, job addresses or secrets** appear in any draft; the fixture is the existing DRV1_B1 robot master.

---

## Summary (under 100 words)

12 robot case drafts with 12 failing twins, ready for validation: N45 (UX-NAMES-02), N45w (UX-NAMES-06), N46 (UX-NAMES-01), N47 (UX-TIME-01), N48 (UX-CPLAN-25), N49 (UX-CMD-03), N50 (UX-STD-02), N51 (UX-SURF-01), N52 (UX-STD-01), N53 (UX-DP-02), N54 (UX-SURF-04), N55 (UX-LBL-04). Four claim a whole card (NAMES-06, CPLAN-25, CMD-03, DP-02); eight are honest parts. Items 17 and 18 already had drafts; 19 and 20 cannot be robot cases today (a refused button, a two-start case). Nothing run; lines marked DERIVED come from the 3.0.86 source.
