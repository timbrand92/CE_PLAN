# New Codex look briefs J1 to J7 (top-40 items 16 and 32 to 37) — Fri 30 Oct 2026

Job CE_ACAD / robot / draft / 37 (CE 02 Robot and Codex Testing, Opus). Written 12:10 to 12:30 Melbourne.
Drafting only: no AutoCAD, no runner, no driver call, no build. Nothing queued: CE 02 queues the briefs.

## ANSWER FIRST

Seven new Codex look briefs are written and in the runner folder, `verifyJ1_c86` to `verifyJ7_c86`.
Each fits one session of 20 minutes or less. Every reading goes through the AutoCAD driver, so Codex no longer
types readings into the command line (the cause of the 30 Oct paste and COMMANDMACROSCLOSE failures).

Three looks will very likely not pass on today's build: J1 fails on the known Excel clash, J3 and J4
will find the feature only part-built. That is the evidence you need to score them honestly.

## FOR TIM

1. **verifyJ1_c86: Pit Schedule to Excel (about 15 minutes).** Press Export Excel on a job copy. Today it
   should FAIL: no save box, just "rendering error" (BUG-1255, AutoCAD 2027's own Excel part clashes with
   CE's). The look copies that message and the one log line word for word. It passes the day a fixed build
   writes a workbook with its "Checking" sheet and Excel opens it. **Removes:** the H3 "blocked" result.
2. **verifyJ2_c86: click a pipe or pit, its green tab comes forward (about 15 minutes).** One click on a pipe,
   then on pit P3: the "Pipe" or "Pit" tab must jump to the front, and Esc must give back the tab you had.
   **Removes:** the D8-04 "fail", which was the brief's mistake: it expected the CE tab back after Esc,
   and forgot the Pit tab's Close button.
3. **verifyJ3_c86: CDCHECK Show where (about 15 to 20 minutes).** Pick finding number 1 from CDCHECK: the
   view must jump to it and mark it, and Esc must clear the mark. The "glow" is not built in 3.0.86, so
   expect "zoom yes, glow no". **Removes:** guessing how much of UX-DI-04 is built.
4. **verifyJ4_c86: pit label at the office spot (about 15 to 20 minutes).** Place one pit on empty ground of
   a copy, skip the label click. Does the label sit where the office's labels sit (measured on P3)? In
   3.0.86 nothing learns the office spot, so expect "no label without a click". One U removes the pit.
   **Removes:** the gap that N25 cannot fill (N25 only proves a clicked label lands on the click).
5. **verifyJ5_c86: "Network OK" in one green line (about 15 minutes).** On a small clean network the Checks
   window should show one green line and fold the passes into one grey line. The Checks window is switched
   off by default, so this look runs only if CE 02 creates `J5_GO.flag`. That lets it switch the setting on
   for the session and put it back byte for byte. Without the flag it stops in 2 minutes, no AutoCAD.
   **Removes:** the "colour and folding are on screen only" blocker.
6. **verifyJ6_c86: override reasons as quick picks (about 15 minutes).** In the Pit Schedule of a copy,
   type over one pit's Remarks. The OVERRIDE REASON cell must offer Survey, Council requirement, Engineer's
   judgement and Other in one click, and accept your own words. Then Close without placing.
   **Removes:** the window-only blocker for UX-STD-04.
7. **verifyJ7_c86: you are the only CE administrator (10 to 15 minutes).** It reads the office list file (one
   entry, your login; I saw exactly that at 12:16 today) and opens the Admin Dashboard to see one allowed user.
   It never adds, edits or answers Yes. **Removes:** the "needs a re-look on 1.1.86" note on UX-ADMIN-01.

**One decision for CE 02, not for you:** you parked "the manager admin stuff" on 20 Oct, then answered
questions 26 and 93 on 29 Oct. J7 only reads, so I wrote it, but CE 02 should confirm before queueing it.

---

## Detail for the desk

### 1. Queue lines, in the order to run (CE 02 adds them; I did not touch CONVEYOR_QUEUE.txt)

```
verifyJ2_c86|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3
verifyJ6_c86|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3
verifyJ1_c86|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3
verifyJ3_c86|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3
verifyJ4_c86|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3
verifyJ7_c86|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3
verifyJ5_c86|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3
```

1. **Why this order.** J2 and J6 only select or type in one window cell: lowest risk, likely PASS. J1 is the
   known FAIL that the builder needs word for word. J3 and J4 use driver chains not yet run by Codex. J7 waits
   for the parking confirmation. J5 last: without `J5_GO.flag` it stops before AutoCAD at almost no cost.
2. **Flags CE 02 may create (I created none):** `C:\Lisp Files\_CODEX_RUNNER\J5_GO.flag` (lets J5 switch
   `checks.checksCommandEnabled` on through the settings guard and restore it) and `J3_GO.flag` (the same, for
   J3's window half only). Without them both briefs make no settings change at all.

### 2. Files written (new only; nothing overwritten, checked before copying)

1. `C:\Lisp Files\_CODEX_RUNNER\verifyJ1_c86.txt` … `verifyJ7_c86.txt` (short launchers, about 2.7 to 3.0 KB).
2. `C:\Lisp Files\_CODEX_RUNNER\verifyJ1_c86_full.txt` … `verifyJ7_c86_full.txt` (full briefs, 28.6 to 31.3 KB).
3. SHA-256 first 12, short then full: J1 58dfe34cb87e / 62f46ef5f489; J2 3fca7cf852b8 / a626ad813fde;
   J3 ddbefa932561 / 74a0e1890065; J4 8cd13a8a848b / aaf44095de0d; J5 bfe250955e5c / 2a51749e7601;
   J6 736dc86b07c6 / 1b9f2c7c0132; J7 1106b62e1a30 / 3f1f82f9e589.
4. Drafts and the two assembly scripts stay in `C:\ce-fx\draft37\` (scratch only).

### 3. How the briefs carry the 30 Oct analysis fixes (CODEX_BLOCKED_ANALYSIS_30OCT.md)

1. **Structure copied from the newest briefs.** Header, SETTINGS line, the N1 to N17 block and changes (a)
   to (h), STANDARD BUILD STEPS, SETUP and CLEAN END come from `verifyC3_c86_full.txt` by line number. N1 to
   N17 are byte-identical to A1_c86 and C3_c86 (same checksum in all seven). Only the look id was swapped in
   (a), (c), SETUP and CLEAN END. H1_c85 and G3_c84 carry older N6 and N14 dates; I used the c86 wording.
2. **Build line** updated to Civil 3.0.86 / Manager 1.1.86 / Structural 1.0.125. I read these ProductVersions
   from the Modern bundle at 12:15 (Civil and Manager 5888ee75, Structural 204dfad2).
3. **Driver instead of typing (item 18).** A new block DR1 to DR10 wins over N2, N8, N17, change (d), TYPED
   VIEWS and shared 2.6 and 5.4 for these runs only. Every reading, typed view, U and REDO goes through
   `acad_driver_witness_v2.ps1` `type -InputFile ... -AllowLisp`. Each LISP line goes in its own file, so
   no PowerShell quoting. CE commands that open a window use `-ExpectWindow`. Ends of prompts use `esc`.
   Selection retries use `pick-first`. TEXTSCR, GRAPHSCR and the princ line are gone; `history 30` replaces
   them. The only own typing left is the final QUIT, with the analysis 18.2 safeguards (click inside the
   text, screenshot before Enter, never Enter on a suggestion box). `restore` before QUIT puts AutoCAD's
   log setting back.
4. **Ready gate (H6 fix).** No driver typing until the title bar shows the copy, CE Tools shows, the command
   line says "Command:", the driver reports idle, and 20 more seconds pass. No drawing in 90 seconds means
   NOT TESTED: SET-UP, never a judged result.
5. **Saved drawings with the pits and pipes.** J1, J2, J3, J4 and J6 copy DRV1_B1 (11 pits, 49 pipes;
   1,080,181 bytes, SHA-256 34BBE37C2EA4, re-read today). J5 copies FIX_MODERN_PIPE_W1 (three pits, two
   current pipes; 977,777 bytes, SHA-256 2A26188CF136, read today). J7 copies the blank drawing. All copies
   go into the look's own folder under `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\`. Tim's files are never
   opened.
6. **View set explicitly (G6 fix).** Every look sets one typed view BEFORE its action, with the judged object
   in the upper part of the screen, clear of the floating command history.
7. **Help window.** None of the seven needs the Help window. J1 reads the CE log line instead of a window.
8. **A1's BUG-1086 result.** Not reused anywhere.
9. **The word "follow".** Searched in all 14 files: 0 hits. (The H1_c85 brief still contains it: "the warning
   follows the TYPED head". Not mine to edit; flag for whoever reruns H1.) `lookCOMMON_full.txt`: 0 hits.

### 4. What the installed source says (commit 5888ee75, read 30 Oct), which shaped each look

1. **J1.** The Excel button shows a save box named Pit_Schedule.xlsx, then the footer line "Excel export
   complete — sheet 1 the schedule, sheet 2 the checking sheet." Sheets: "Pit Schedule" and "Checking", whose
   heading row is PIT No. / FIELD / VALUE / SOURCE. The crash guard prints on the command line only:
   "[CE] <title> rendering error — see CE log for details." The look also records both ClosedXML.dll versions
   (AutoCAD's and CE's) before AutoCAD starts.
2. **J2.** The tabs are titled "Pipe" and "Pit", and both have Close. With `options.jumpToContextualTabOnSelect`
   on (read True today), a tab comes forward on selection. Esc restores the tab showing BEFORE the pick, not
   the CE tab. So D8-04's FAIL was the brief's fault, as the 40-item list guessed.
3. **J3.** CDCHECK's number question zooms (object size × 1.8, never closer than 1000 mm) and selects. The
   glow is not built ("with the glow Setting on the zoom still happens and nothing glows"). The Checks window
   (CDCHECKS) is behind `checks.checksCommandEnabled`, absent today, so OFF.
4. **J4.** Nothing learns a label spot and nothing slides a pit label clear. The only "usual spot" is the
   Esc fallback behind `linking.pitLabelOnEsc`, absent today, so OFF. It puts the label at the window's
   corner (default bottom right) 350 mm beyond the pit. N25 is tagged UX-CPLAN-21, not 22.
5. **J5.** "Network OK: <n> pipes, <m> pits checked" in the success colour, and passes folded into one grey
   line "<n> checked and fine" (no expander). It exists only in the Checks window, so it needs the same switch.
6. **J6.** The four picks live in the Pit Schedule's OVERRIDE REASON drop-down. There is no switch, and the
   cell doubles as the note. The CDCHECKIGNORE picks sit behind `checks.allowIgnoreFinding`, absent today,
   so OFF. That half is only read.
7. **J7.** The office list is `<IT Admin>\CE Plugin Admin\policies\admin-users.json`. Today: option 3
   (the user-profile folder), 26 bytes, 1 entry, equal to the login, no local copy. The Admin Dashboard
   Overview and Policies tabs show "Allowed users:" read-only.

### 5. Notes the desk may want

1. **CD_Settings.json changed today.** Its hash starts 7A5C1475A81C (last written 12:13 on 30 Oct). N6
   still lists ACD64E79A33B. Each brief carries this as note (i): a NOTE, not a stop. The other three
   settings files match N6.
2. **UX-DI-04 and UX-CPLAN-22 are probably part-built or not built on 3.0.86.** J3 and J4 are written to
   record that plainly (DIFFERENT, "NOT BUILT" or "GLOW NOT BUILT"), not to fail CE for a missing feature.
   Tim's ruling for UX-CPLAN-22 ("Learned office spot") has no code behind it at 5888ee75.
3. **UX-STD-08 needs a switch flip to be seen at all**, so J5 is a GO-flag look. The robot's pack-3 settings
   pattern would cover it equally well.

## What I did NOT verify (RULES 5.9)

1. **No brief was run.** Nothing was driven in AutoCAD, and no driver call was made.
2. **The driver calls are untried in these exact forms.** Nobody has proven yet that a Codex-held lock plus
   `-Who "Codex-Jn"` works with `type`, `history`, `pick-first`, `esc` or `restore` on an AutoCAD started
   by explorer.exe. I read the driver source: the lock check accepts the holder's own name, and the
   test-copy check accepts `C:\Lisp Files\_TEST_COPIES*`. Still unproven in AutoCAD.
3. **CDCHECK answered by a three-line chain** (CDCHECK / P / 1) is untried. The driver guide calls the full
   CDCHECK chain "untested".
4. **The PIT chain with `-ExpectWindow "New Pit"`** mirrors the proven CD form and runner case N25, but has
   not been run as a Codex call.
5. **Not known: does FIX_MODERN_PIPE_W1 raise any finding?** If it does, J5 reports "fixture not clean".
6. **Not known: does `D2 esc` accept the pit-label drag prompt?** It should, by the driver's prompt rules,
   but this is unproven.
7. **No offline validate was run.** These are look briefs, not runner cases, so `case_runner.ps1` validate
   does not apply. I did not read its validate function.
8. **Source facts come from the installed commit 5888ee75**, read by three read-only search helpers and
   spot-checked by me. The real words on screen win (N7).
9. **Excel on this PC.** J1 tests for EXCEL.EXE at the usual Office path; I did not check whether it is there.

## Summary

Seven new Codex look briefs (J1 to J7, short and full) are in `_CODEX_RUNNER`, nothing overwritten. All carry
the c86 rule block word for word, the new build line, a driver-only readings block and saved job copies. Each
sets an explicit view and fits 20 minutes. J1 expects the Excel clash FAIL. J2 corrects D8-04. J3 and J4 will
likely show part-built features. J5 and J3's window half need a GO flag. J7 is read-only, pending CE 02's
parking check. Queue order: J2, J6, J1, J3, J4, J7, J5. Nothing was run.
