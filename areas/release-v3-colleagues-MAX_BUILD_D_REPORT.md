# Max build D: Structural fixes for train S-43 (Fri 23 Oct 2026, Melbourne, Sonnet 5.5)

Base: `origin/claude/rel-20261023s` = **e6d597c0fbc25e78118760887a70810e0890c9a9** (Structural 1.0.122, the installed S-42). Inputs read: `AUDIT_ENGINEERING_STRUCTURAL_2026-10-22.md`, the Structural entries of BUG-873 to BUG-1034 (`CARPARK_NEW_ENTRIES_23OCT.md`), and the Structural lines of `FINDINGS_LEDGER_22OCT.md`. Everything below is **built and unit-tested only. Nobody has opened any of it in AutoCAD. No bug is marked fixed.**

---

## ANSWER FIRST

1. **Five DRAFT PRs, all against `claude/rel-20261023s`.** Four change something a drafter sees (XCLMTXT schedule box on a turned UCS, window size at 150 per cent, CEMEMBER zero-decimal names, CEMEMBER layer words and frozen-layer warning); one is a test-only guard.
2. **The audit's HIGH and its most-likely-wrong-number MEDIUM are already fixed at the base.** XCLMTXT now says UA for unequal angles and keeps `250UB25.7` (PR #1533, merged into S-42 as c490b307). I read the base code to confirm: `ExcelMTextService.cs` line 5812 picks EA only when the legs are equal, and `NormalizeUcUbWholeNumbers` no longer exists. Nothing to build.
3. **Of the other six audit MEDIUMs, three already have an open fix PR (I commented on each: bracing, tag heights, hatches on a wrong LTSCALE), and three need Tim's word** (LBH at 1:100, SBEAM against CEMEMBER size, the fixed template hatches). Options are in section 4.
4. **Totals:** Structural.Tests net10: **5,566 passed, 0 failed, 0 skipped** (integration of the four code branches, 14 chunks). DesignCore net10: 2,197 and 2,198 total, **5 failed, the same five release-settings names that fail at S-42**. net48 standalone build: 0 compile errors.
5. **Not done:** nothing in AutoCAD, no Codex, no deploy, no install. One audit item I judged unreachable (section 3, item 5) and one I would not build without Tim (section 4, item 5).

---

## 1. The five PRs

1. **BUG-1014 (ledger F-215): XCLMTXT schedule box turns with the UCS.** PR **#1695**, branch `fb/max-s43-ucs-frame`, head **c5990580**.
   1. **What Tim will see:** with the UCS turned 90 degrees, the member sizes already turned but the schedule box and the white backing boxes stayed square to World, so the text sat outside its box. All three block inserts now turn with the UCS about their own insertion point. UCS at World or only moved: no change.
   2. **Tests:** the source guard `XclmTxtUcsBlockTests` **failed on the base (1 of 1)**; after the fix it passes with `XclmTxtUcsBlockOrientationTests` (3 cases: 90 degrees, 45 degrees, World or moved). Focused run 4 of 4. Whole suite: see section 2.
   3. **Real-AutoCAD check:** on a copy of a millimetre drawing that has the MEMBER SCHEDULE block, type UCS, Z, 90. Run XCLMTXT with a small schedule and Insert Selected. The box must be turned 90 degrees like the size text, with the text inside it and the white backing boxes behind single marks turned the same. Then UCS, World and insert again: square to the page as before. One U after each insert removes the whole schedule.
2. **BUG-955 and BUG-956 (ledger F-139, F-140): windows sized in screen units and fitted to the screen.** PR **#1696**, branch `fb/max-s43-win-dpi`, head **22d1f3ed**.
   1. **What Tim will see:** at 150 per cent, Drawing Sheets, Settings and the other windows opened over AutoCAD came up 1.5 times too big with their bottom buttons off the screen. They now open at their designed size inside the screen. The Steel picker (SBEAM), RC member window and Structural Settings ask for at least 1340 x 820, 1060 x 850 and 1180 x 850, bigger than a 1080p screen at 150 per cent (1280 x 720 usable); on such a screen they now come down to the screen and scroll instead of hiding Place or Save. On a big screen nothing changes.
   2. **Tests:** `AutoCadWindowHostGuardTests` **failed on the base (2 of 2)**; with the fix 11 of 11 (2 guards plus 9 sums: 100 and 150 per cent, unreadable screen, minimum sizes, shrink, move up, second monitor to the left).
   3. **Real-AutoCAD check:** on a screen set to 1920 x 1080 at 150 per cent, run CESHEETS, CESETTINGS, SBEAM and RCBEAM. Each window must open fully inside the screen with its bottom buttons visible, and if it is smaller than designed you must be able to scroll to every button. Repeat at 100 per cent on a big screen: windows look exactly as before.
3. **Audit finding 9 (ledger F-133): CEMEMBER finds `310UB32.0`.** PR **#1697**, branch `fb/max-s43-cem-names`, head **4cff3d0a**.
   1. **What Tim will see:** typing `310UB32.0` (or `310 ub 32.00`) at the section name question finds 310UB32 instead of "no section called". `310UB32.4` still says no section called, because rounding a real decimal onto a neighbour would be a guess.
   2. **Important limit:** `250UB25.7` and `410UB59.7` still say "no section called" until the BUG-818 section list carries the supplier names. The catalogue holds the rounded names (`250UB26`, `410UB60`), and I did not map a typed decimal onto them.
   3. **Tests:** **red on the base** (1 failed of 8 in `CeMemberPromptsTests`), green after; CEMember tests 134 of 134. DesignCore whole run 2,197 total, 2,192 passed, 5 failed (same five as S-42).
   4. **Real-AutoCAD check:** run CEMEMBER, Side; at the section name question type `310UB32.0`: the next question appears for 310UB32. Type `310 ub 32.00`: same. Type `310UB32.4`: no section called, asks again.
4. **Audit findings 78 and 80 (ledger F-078, F-080): CEMEMBER layer words.** PR **#1698**, branch `fb/max-s43-cem-layers`, head **ffe90c5c**.
   1. **What Tim will see:** with 25CONT locked, CEMEMBER used to say "SBEAM output layer is locked, dependent or unavailable". It now says "CEMEMBER: The layer 25CONT is locked (or belongs to an Xref), so CEMEMBER will not draw on it. Unlock the layer and run CEMEMBER again. Nothing drawn." Nothing is unlocked and nothing is drawn. With a layer frozen or switched off, CEMEMBER drew and said "placed" while the lines were invisible; it still draws (no new hard stop, R-27) and now adds a line naming the frozen layer. SBEAM keeps its own words.
   2. **Tests:** 3 new cases in `CeMemberLayerWordingTests`. The class did not exist on the base, so the project does not compile there (that is the red). DesignCore whole run 2,198 total, 2,193 passed, 5 failed (same five as S-42).
   3. **Real-AutoCAD check:** on a copy, lock 25CONT and run CEMEMBER, Side, pick two points: the new sentence appears, nothing is drawn, 25CONT stays locked. Unlock, freeze 25CONT, run again: the member is placed and a line says 25CONT is frozen and the lines will not show. Thaw it: the member shows. One U removes the whole run.
5. **Audit finding 10 (ledger F-134): guard for the three uncited tables.** PR **#1699**, branch `fb/max-s43-table-guard`, head **22af0770**.
   1. **What it does:** test only, no value changed. It fails the day any Structural or DesignCore source other than the files that hold them reads `GetMinCover`, `GetSteelGrades` or `StandardLapLength`, so a wrong lap, cover or steel-grade number cannot reach a drawing before cited values are on the Settings page (R-00).
   2. **Tests:** 3 of 3. It is a tripwire, so it **passes on the base by design** (nothing reads the tables); one test proves it can tell a reader from a non-reader.
   3. **Real-AutoCAD check:** none needed.

---

## 2. Evidence and method

1. **Environment:** one private worktree per fix under `C:\ce-mx` (`sa`, `sb`, `sc`, `sd`, `sf`) plus one throwaway integration worktree (`si`, the four code branches merged; the merge needed no hand resolution, even in `REGRESSION_LOG.md`). All removed. Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1` on every command, foreground or waited on, own `TEMP` and `CE_LOG_DIR_OVERRIDE`. `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`; AutoCAD 2027 folder on PATH for net10. Nothing was deployed. The local clone `C:\Lisp Files\CE_ACAD_PLUGIN` was not edited or built in.
2. **Whole-suite run:** a one-shot run of Structural.Tests passed 4,616 and then hung (a test host inactivity timeout, 8 minutes), so I ran 14 chunks of up to 30 test classes, as S-42 did, leaving out `SbeamEditAutoCadEvidenceReaderTests`: 347, 341, 214, 285, 357, 354, 424, 309, 370, 652, 392, 378, 294, 849 = **5,566 passed, 0 failed, 0 skipped**. S-42's own figure was 5,704; I did not reconcile the 138 difference (I picked classes by name, so some fixtures may have been missed), and it does not include the table-guard PR.
3. **net48:** `CE_STRUC_SUITE.csproj` net48 standalone: 0 compile errors. Its post-build "independence" check failed with exit 9009 because `powershell` was not on my shell's PATH; I checked the output by hand (no `CE_SHARED` text in the DLL, no deps file). I did not run the net48 or net8 Structural test legs, or the DesignCore net48 and net8 legs.
4. **Disk:** free space on C: ran between 13 and 18 GB (other builders). One net48 step aborted itself at 13 GB (my runner stops under 14) and I re-ran it at 15 GB. I deleted bin and obj after each fix.
5. **Hygiene:** Tim's four settings files read back at the end with the same sizes and first hash digits S-42 recorded at 09:51 (CD_Settings 15,270 bytes acd64e, CS_Settings 351,713 bytes 622a24, CE_CVL_SUITE settings 672 bytes efe307, CE_STRUC_SUITE CS_Settings 35,259 bytes 2972ce). I did not take my own "before" reading. No PR closed, no branch deleted, no bug marked fixed, DESK_LOG.md, QUEUE.md and BUG_CARPARK.md untouched, no AutoCAD or Codex started.

---

## 3. Skipped because a fix already exists

1. **Audit HIGH 1 (XCLMTXT EA for unequal angles) and MEDIUM 2 (UB and UC rounded):** fixed at the base by #1533 (merged into S-42). Verified in the S-42 code, not just by the PR title. Not re-tested in AutoCAD.
2. **Audit MEDIUM 4, bracing panel (BUG-950):** open PR **#1603**.
3. **Audit MEDIUM 5, TH, PF, BP, column, 18 and setout tag heights (BUG-951, BUG-911):** open PRs **#1596** and **#1598**. The 25C and EBT half (BUG-531) is already in S-41.
4. **Audit MEDIUM 7, hatches refuse on a wrong LTSCALE (BUG-953, BUG-881):** open PRs **#1592** (stacked on **#1577**).
5. **Audit LOW 11, RC section detail invents a bar size (ledger F-135):** not built. The RC window's bar boxes are fixed lists filled from the bar catalogue (`ReinforcementService.GetDesignations`), so a bar that is "not in the list" cannot be picked today; I found no route that stores or types one. If Tim wants a safety net anyway: leave that bar out and print "[CE] N40 is not in the bar list, so its bars were not drawn", never a made-up 16 mm dot.
6. **Ledger F-082 (recovery wording for three switches with no Settings row):** already handled at the base. `SettingsService.LoadRecovery.cs` lines 295 to 298 say "Settings with no page in CESETTINGS stay at their standard value until the file is corrected" when a setting has no page.
7. **Other carpark entries that already have an open fix PR (commented on each, not re-tested):** BUG-974 **#1589**, BUG-977 **#1563**, BUG-978 **#1566**, BUG-975 **#1564**, BUG-976 **#1560**, BUG-973 **#1568**, BUG-972 **#1572**, BUG-984 **#1579**, BUG-985 **#1575**, BUG-986 **#1581**, BUG-1025 **#1587**, BUG-1015 **#1585**, BUG-1016 **#1582**, BUG-1013 **#1584**, BUG-983 **#1574**, BUG-880 **#1604**, BUG-912 **#1590**. The comment on each says I did not build a duplicate and that its base is `claude/rel-20261022s2` (S-41), not the S-42 line, so it needs merging onto `claude/rel-20261023s` for S-43.
8. **BUG-1026 and BUG-1027** (open logs, support zip) are Release, installer and Manager entries, not the Structural module: left alone.

---

## 4. Skipped because it needs Tim's engineering word (one recommendation each)

1. **BUG-949, LBH (load-bearing wall over) at 1:100.** Today the lines are one every 1.1 m of wall, so a 900 mm nib shows 0 or 1 line; the office standard is about 4. **Recommend:** keep LBH at its stated 50 at 1:100 and keep LBUH dots on the paper-density rule (the BUG-748 fix stays). The alternative is to leave both on paper density, which keeps one rule but thins the wall hatch.
2. **BUG-952, SBEAM against CEMEMBER member size.** At 1:100 the same 310UB32 elevation is 298 mm deep from CEMEMBER and 1490 mm from SBEAM. **Recommend:** real size for both, the CEMEMBER way, and treat SBEAM's depth x DIMSCALE/20 as the old "enlarged detail" habit to retire. The alternative is to keep SBEAM as is until it is retired.
3. **BUG-954, fixed template hatches against their scale-aware twins.** "Concrete slab" is 5 times denser than CE's own Concrete at 1:100; "Fence wall under" (dots at 20) is the dot-merge fault BUG-748 fixed for LBUH. **Recommend:** one rule, template presets follow the same density rule as CH, LBH and LBUH, so the same hatch looks the same wherever it comes from.
4. **BUG-909, BUG-910 (CEMEMBER picked plane and UCS; break marks on a layout):** the ledger marks both as needing Tim; no PR; not built.
5. **Audit LOW 13 (ledger F-137), vertical CEMEMBER elevation flips "top of member" with the pick order.** I wrote a bottom-to-top rule and then took it out, because the pick order may be how a drafter chooses the side. **Options:** (a) always bottom to top, so top of member is on the west side whichever end is picked first; (b) ask which side; (c) keep today's behaviour and say so in the prompt. **Recommend (a)**, with the existing "flip" answer for the other side.
6. **Ledger F-079, Space as Enter at the section name question.** Turning Space into Enter would stop a drafter typing `310 UB 32` with spaces (the lookup deliberately ignores spaces). **Recommend:** leave as is.
7. **Audit LOW 12, wind class suggestion has no shielding question.** **Recommend:** add a Shielding question (Full, Partial, None, Not considered) to the suggestion, default "Not considered", and print a Basis line when it is. The cited table (AS 4055 shielding step) must come from Tim.
8. **Audit LOW 10, the values in the three uncited tables.** The guard (#1699) is built; the values need Tim: lap length (the audit's own arithmetic says N12 needs about 552 against 480 in the file at f'c 32 MPa, from memory of AS 3600), cover per exposure class by concrete strength, and the supplier steel grade for UB and UC (300 from memory, not 250 and 350). Nothing should read them until the cited figures are on the Settings page.
9. **Audit LOW 14 (ledger F-138), SBEAM writes the list's old mass and stiffness into every member.** Waits for the BUG-818 section list; nothing to build before it lands.

---

## 5. What I did NOT test

1. **Anything in AutoCAD or accoreconsole.** No window was opened, no command run.
2. **Windows on a second screen with a different scale** from AutoCAD's own screen, and the look of the scroll bars on the three big windows once they are smaller than designed.
3. **The frozen-layer line on the section view** (same helper, not driven).
4. **Structural.Tests on net48 and net8**, DesignCore on net48 and net8, Drainage, Manager, Installer.Tests, and the one hanging class `SbeamEditAutoCadEvidenceReaderTests`.
5. **Merge order on the real train:** my four code branches merge together cleanly (checked), but they were not merged with the 22 open S-41-based PRs listed above; `CeMemberCommands.cs` is also touched by #1590, #1600 and #1604, so expect a small hand merge there for #1698.
6. **That the claims "not re-tested" for the other PRs still hold at the S-42 base.** I saw that each PR exists and what it says, not that its bug still reproduces.

## 6. REGRESSION_LOG

Each of the five branches carries its own entry at the top of `REGRESSION_LOG.md` (the guard's says it is test only). They merged without conflict in the integration worktree.
