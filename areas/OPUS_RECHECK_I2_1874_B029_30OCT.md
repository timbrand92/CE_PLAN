# Opus re-check I2: PR #1874 (B-029, BUG-1096 and BUG-1098), new head 1b8b4af1 (Fri 30 Oct 2026, 19:34 Melbourne)

This is an independent, read-only re-check of head `1b8b4af1b50214e903f9fe8cf67742da8876faa6` on branch `fb/bug1096-reuse-boxes`, against the earlier head `d1f3cb40`. I fetched the branch read-only, and the fetched tip matches `1b8b4af1`. `git diff d1f3cb40 1b8b4af1` shows one commit and four files (+97 −6). I built nothing, ran no tests, opened no AutoCAD and changed no repository file. The only extra thing I ran was a small text-measuring script in my scratchpad. It measured the new hint in Segoe UI using Windows' own text engine.

## FOR TIM

1. **Verdict: KEEP-WITH-NOTE, same train as before.** It belongs on the next train built on the C-78 line, alongside #1872. It is not for 3.0.87. Both review fixes are in and correct, and nothing else changed.
2. **The grey hint is now one line:** "Optional. Shown on the result beside the storage, never taken off it." By measurement it is 357 of the 360 units of width available, so it just fits. If it ever drops a word onto a second line, nothing is cut off and nothing scrolls. The page is about three lines shorter than before.
3. **The warning is now true on every route I traced.** For example: on a Kingston job with a tank typed, the sheet says "Kingston gives the permitted discharge, and CDDESIGN has no box for it yet, so there is no storage figure and no reuse credit." It says that only when the figure really is Unknown. Detention switched off, and a council CE works out itself, each get their own sentence.
4. **One thing to remember later:** the day CDDESIGN gets a permitted-discharge box, that sentence must change. Otherwise a drafter who leaves the box blank would be told "no box".
5. **The robot line for case N100 is on line 341, not 340.** The text is `NEEDS CONFIRMATION (Unknown) — no credit taken`, and the dash is a long dash. Matching only on "NEEDS CONFIRMATION (Unknown)" is safe: no other line in the plugin prints it.
6. **Not proven:** nobody has looked at the window, at 100 % or at 150 %. Nothing has run in AutoCAD. I did not re-run the test counts, but they add up exactly. BUG-1096 and BUG-1098 stay OPEN. Draft #1817 still needs closing as replaced.

---

## DETAIL

### 1. The hint and the page layout

1. **The hint is one line, and it is still true.** It is at `Modules/Drainage/ViewModels/CivilDesignWindowViewModel.cs:697`: "Optional. Shown on the result beside the storage, never taken off it." (69 characters). It is still true:
   1. **Never taken off:** the design keeps the gross storage. The credit section is headed "informational — design uses the GROSS SSR" (`Services/AutoDesignOrchestrator.cs:336`).
   2. **Shown beside the storage:** the credit is printed next to the gross figure, never in place of it (`:338-347`).
   3. **What it dropped:** "litres kept for reuse, not the detention part" and the note that the roof figure is read from the rating report. That is an acceptable loss under the cockpit rule, because the box labels still say what goes in each box.
2. **Measured width.** In 12-point Segoe UI (the window's body font, `Themes/LightTheme.xaml:81`, with the hint at `FontSize="12"`, `Dialogs/CivilDesignWindow.xaml:222`), the new hint measures **357.4 of 360** units of width. The reuse group is fixed at 360 wide with no inner margin (`CivilDesignWindow.xaml:215`).
   1. The old hint measured 1,107.5, which is four lines. So the "four lines" in pre-review I was right.
   2. The new hint fits on one line with about 2.6 units to spare. That is tight. A different Segoe UI version, or text rounding, could push "it." onto a second line.
   3. The hint style wraps (`Themes/CivilEditorShellTheme.xaml:71-75`, and `TextWrapping="Wrap"` on the element), so the worst case is two lines. Nothing is cut off sideways.
   4. The new test (`Modules/Drainage.Tests/Services/Bug1096ReuseBoxesTests.cs:165`) checks 80 characters or fewer and no line break. That is a stand-in: **it does not prove one line on screen.**
3. **Second column, no scroll bar at 100 %.** The XAML did not change between the two heads. The group is still `Grid.Column="1"` beside the left fields (`CivilDesignWindow.xaml:215`), and the tab still has no scroll area.
   1. The reuse column is now about 48 units shorter (three fewer lines of 12-point text).
   2. The tallest thing on the page is still the left column, which this diff does not touch.
   3. So the no-scroll estimate from pre-review I stands, with more room than before. **It is still an estimate. Nobody has looked.**
4. **150 % scaling: nothing is worse.** Layout units scale with the screen, so the same text stays the same width at 150 %. The window being taller than a 1920 × 1080 laptop screen at 150 % was there before this PR, on every CDDESIGN page. This diff neither fixes it nor makes it worse.

### 2. The no-storage warning: every route

The warning is built by `NoStorageReuseWarning` (`Services/AutoDesignOrchestrator.cs:299-319`). It is called only from `:164-169`, and only when all of these hold:

- a tank was typed;
- the Settings switch is ON (`ReuseKingstonCouncilTiers`);
- the storage figure is zero or missing (the `else` of `proposal.SsrM3 > 0` at `:156`).

The checks run in this order: detention off first (`:305`), then a council that gives the permitted discharge and an Unknown figure (`:310`), then any other Unknown figure (`:314`), then a catch-all (`:318`).

1. **A council with a reuse rule (Manningham, Kingston, Casey).** All three are council-provided (I checked: the shipped `council-profiles.json` at this head lists exactly eight council-provided profiles). CDDESIGN never passes a permitted discharge (`Services/CivilDesignService.cs:147-173`). So the engine always returns `PsdUnknown: true` with no storage (`Services/AutoDesignService.cs:193-211`), and the sentence at `:310-312` fires. **True:** no dialog has a permitted-discharge box (I grepped every Drainage dialog XAML). The test at `Bug1096ReuseBoxesTests.cs:103` proves this end to end through CivilDesignService for Manningham and Kingston.
2. **A council-provided council with a known figure.** This is not reachable from CDDESIGN at this head. Through the engine directly, a figure supplied gives `PsdUnknown` false, so the "no box" sentence cannot fire. That is correct, and the helper test at `:145` pins it. If that figure still gives zero storage, the drafter gets the catch-all at `:318`: "there is no detention storage figure to credit **yet**". Small wording nit: when the storage is truly nil, the word "yet" suggests something is pending. It is the safe direction (no credit is claimed), so it is not misleading in a way that matters.
3. **An Unknown figure on a council CE works out itself.** CDDESIGN always passes the existing site C as Unknown (`CivilDesignService.cs:162`). For a council whose pre-development C depends on the existing site C, the engine returns `PsdUnknown` (`Services/DetentionSizingService.cs:105-113`). The sentence at `:314-316` reads "the permitted discharge for Frankston is not known yet". **True.** It does not say why, but the engine note on the same sheet does: "...until the existing site C is typed". A computed council with a storage figure never gets here. It goes to the "NEEDS CONFIRMATION (Unknown)" credit path instead (`:156-163`).
4. **Detention switched off.** This is checked first (`:305-307`), so even Kingston gets "detention is switched off for this design, so there is no storage figure to credit". **True,** and it is pinned by the test at `:145`.
5. **No council.** This is not reachable through CDDESIGN: the design will not run without a council ("no council has been set for this job", `Rules/CivilDesignWorkflow.cs:199-201`). Only CDDESIGN sets a reuse tank (`CivilDesignService.cs:169`), so no other caller reaches this sentence. If it ever were reached with an unknown council, the sentence would print the raw id with no quotes, or a blank where the name goes if the id were empty. This is harmless today. I note it only for completeness.
6. **Could it be false or misleading?**
   1. **Today:** no, on any route a drafter can reach.
   2. **When a permitted-discharge box is added** (the open question for the questions chat), the line "CDDESIGN has no box for it yet" becomes false if the drafter leaves the box blank. The sentence must be reworded in that same change, for example to "no permitted discharge has been typed". **Record this against that follow-up.**
   3. **On the same Results text,** the existing engine note says "Enter the council's figure to size the detention" (`DetentionSizingService.cs:109-110`). That sits beside a Watch out line saying there is no box. This was there before; the new line actually makes the true position clearer. It is a small inconsistency, not a defect of this PR.
   4. **Advice gap:** "work the credit by hand" leaves out that the storage must also be sized by hand, because the credit is a share of the storage. Suggest: "work the storage and the credit by hand". This is a wording nit only.
   5. **Growth Areas:** its profile name is "Growth Areas (EDCM)", so that sentence reads "Growth Areas (EDCM) gives the permitted discharge". The EDCM is a manual, not a council. It is understandable but slightly odd. Nit.
7. **Plain English:** yes. No internal id in quotes (the test at `:130` asserts that for all eight councils), no code words, and it says what to do next.

### 3. The robot line for case N100

1. **It is at line 341, not 340.** `Services/AutoDesignOrchestrator.cs:341` is `sb.AppendLine("  Credit:               NEEDS CONFIRMATION (Unknown) — no credit taken");`. At the old head it was line 313. The 28 new lines of the helper moved it.
2. **The dash is a long dash.** I read the bytes of the file at this head: they are `E2 80 94`, which is U+2014, the em dash. The REGRESSION_LOG entry item 4 now says so correctly. The author's original N100 wording in `C:\CE_PLAN\areas\release-v3-colleagues-BUG1096_FIX_REPORT.md` (line 33) still shows a hyphen. CE 02 must change the case. Neither this PR nor I edited it.
3. **Matching on "NEEDS CONFIRMATION (Unknown)" alone is safe.**
   1. This is the only product line in `Modules/` that contains "NEEDS CONFIRMATION" (I grepped the whole tree at this head). The other two hits are tests.
   2. The Watch out line uses lower case "needs confirmation with the council" (`:162`) and has no "(Unknown)", so even a case-blind match cannot hit it.
   3. The line is printed only on the no-rule branch (`:339-343`).
   4. The OFF twin (N100_reuse_boxes_off) still works by absence, because OFF passes no tank (`CivilDesignService.cs:250`).

### 4. Anything beyond the two fixes?

1. **Four files only:**
   1. the test file;
   2. the orchestrator (one call changed at `:168`, one new helper at `:293-319`);
   3. the view model (the hint, `:697`);
   4. `REGRESSION_LOG.md` (a new top entry).
2. **Untouched (I diffed each between the two heads, and every diff is empty):** `Services/ReuseCreditService.cs`, including the hard-coded Kingston figures at `:38-42` (2,000 L minimum, 500 L credit, 2,500 L step, 1,000 L credit, 50 m² roof); every file under `Modules/Drainage/Models` (so no switch changed); and `Assets/` (so the council file is unchanged).
3. **Nothing new is unsafe.** The helper only builds a sentence. It prints no number, blocks nothing and changes no storage. The credit and the storage are worked out exactly as at `d1f3cb40`. OFF is still exact, because the branch at `:164` needs the switch.
4. **Merge picture unchanged from pre-review I.** The only new text conflict is again the top of `REGRESSION_LOG.md` (keep both). Neither train touches the orchestrator or the view model.

### 5. The test figures

1. **The counts add up.** The diff adds 10 test cases: eight council cases at `:122-130`, plus two single tests at `:145` and `:165`.
   1. **Focused:** 33 + 10 = 43. That matches "43 of 43", and I counted 43 test markers in the file at this head.
   2. **Full suite:** the earlier run was 20,807 passed + 32 skipped = 20,839. Adding 10 gives 20,849 total and 20,817 passed, exactly as reported, with skips unchanged at 32.
   3. I did not re-run either suite. I did not check the names of the 32 skipped tests either, but the count is unchanged, so none of the new ones appears to be skipped.
2. **Would the tests catch the change?** Yes for the sentence:
   1. The old head has no `NoStorageReuseWarning`, so the new tests would not even compile against it.
   2. The changed end-to-end test (`:103`) looks for "gives the permitted discharge", which the old sentence did not contain.
3. **Weak spots:**
   1. **The hint test proves characters, not lines on screen.** See 1.2.
   2. **The "known figure" route is tested only by calling the helper directly.** It cannot be driven through CDDESIGN until a box exists.
   3. **That test is loose.** It only checks that the text contains "reuse credit".
   4. **net48 tests were built (0 errors) but not run.** The new code is plain sentence-building, so the risk is low. It is still not proven on 2022 to 2024.

### 6. Verdict

**KEEP-WITH-NOTE. The train is unchanged:** after C-78, on the next train built on the C-78 line (`claude/rel-20261102a` final head), alongside #1872. Not 3.0.87.

1. **Both review fixes are done properly.** The hint is cut to one line, and the warning names the council but only when the figure is Unknown.
2. **Still to do, carried forward:**
   1. **Close draft #1817** as replaced by #1874, and never merge both.
   2. **CE 02 changes robot case N100** to match on "NEEDS CONFIRMATION (Unknown)" only.
   3. **The permitted-discharge box question** goes to the questions chat (recommend yes). When that box is built, reword "CDDESIGN has no box for it yet" in the same change.
   4. **Move Kingston's numbers into the council profile** (R-00) as a follow-up.
3. **Optional wording nits, none blocking:**
   1. "work the storage and the credit by hand";
   2. drop "yet" from the catch-all sentence at `:318`;
   3. "Growth Areas (EDCM)" reads oddly in that sentence.
4. **Still NOT proven:**
   1. Nobody has looked at the window, at 100 % or at 150 %, in light or dark.
   2. The hint fitting on one line is a measurement (357.4 of 360), not a look.
   3. Nothing has run in AutoCAD.
   4. net48 tests have not run.
   5. I did not re-run the test counts.
   6. BUG-1096 cannot pass its own AutoCAD step (a Manningham 1.50 m³ credit line) until CDDESIGN has a permitted-discharge box.
   7. Kingston's 6,000 L tank showing 1.00 m³ is a unit-test fact only.
   8. **BUG-1096 and BUG-1098 stay OPEN.**
