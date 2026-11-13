# Second review: the 14 Nov trial batch (PR 2094, PR 2092, PR 2099)

**Reviewer:** trust-review helper. **Written:** Sat 14 Nov 2026, 01:22 PC clock. **Scope:** what changed since each first review, plus a sanity pass over each whole pull request. Read only: no build, no test run, no AutoCAD, no core console, nothing merged, nothing pushed to the plugin repo, no GitHub comment. **Installed builds, read from the bundle files on this PC:** Civil `3.0.90.2+5c89ce30`, Structural `1.0.126+8de95c34`.

## Verdicts

1. **PR 2094 (BUG-1457, CLEAN and FASTSAVE over a template; Structural), head `226edc6c`: NOT YET.** The template file is never written now, and a normal saved drawing is untouched. But the path added since the first review, a template opened on purpose, prints two untrue things: every time, a summary saying "the simpler clean-up was used"; and from FASTSAVE (whose tidy-up is off by default) "CE cleaned it" when nothing was cleaned. Two small fixes in one file, then a rebuild.
2. **PR 2092 (BUG-1355, CDRUNSOLVE at a pit with two pipes leaving it; Civil), head `d686e787`: BATCH-READY.** All four FIX FIRST items are done, correctly. The core-console check is honest about the route-finding and fails on the installed build, but it proves less than its write-up says (section 2 below; not blocking).
3. **PR 2099 (BUG-1298, CDLPD takes only a CE pipe; Civil), head `9c3f088e`: BATCH-READY.** Both small fixes are done; the behaviour is the same as at the first review's GO.
4. **Overall:** put 2092 and 2099 in the batch now (both Civil, one bundle). Add 2094 (Structural, its own bundle) once the two fixes below are pushed and rebuilt; it does not hold up the Civil pair.

---

# FOR TIM

1. **CDRUNSOLVE at a split (2092): ready.** At a pit with two pipes leaving it, it now asks "2 pipes leave pit P10. Which way does the run go? A = to P9, B = to P4." Type A or B and the run follows that pipe. Enter stops the run at that pit and says so. Esc cancels. This works with or without an LPD. The preview window now says when the run stops part way, instead of "council assets untouched".
2. **CDLPD (2099): ready.** Click a kerb line or a boundary as the LPD pipe and you get one line: "That line is not a CE pipe ... Run CDLPD again and pick a CE pipe, a pit or a block, or choose to pick a point." Nothing is drawn or stored.
3. **CLEAN and FASTSAVE over a template (2094): one more small fix first.** The part that matters is right: a drawing you never saved is not cleaned or saved, one line tells you to use Save As, and the template file is never touched. The fault is only in the words for a template you open on purpose: CLEAN's summary says "the simpler clean-up was used" (it was not), and FASTSAVE says "CE cleaned it" although FASTSAVE cleans nothing unless you turned that switch on. About ten minutes to fix, then a rebuild.
4. **Two choices still waiting for you (not urgent; DRAFT defaults are built):** the wording of the A/B question at a split; and whether a template you open on purpose is cleaned and left unsaved (built that way now) or refused.

---

# PR 2094 (BUG-1457), `7a94d8e8` to `226edc6c`

## 1. Were the six first-review items done

1. **Item 1, template opened on purpose (DRAFT default): done in behaviour, wrong in two places in the words.** `StopIfSaveUnsafe` now stops only a never-saved drawing (`DrawingSaveGuard.cs:116`). A template or standards file (.dwt, .dwtx, and now .dws, `:40-42`) is cleaned and not saved. See section 3 items 1 and 2.
2. **Item 2, name test only when DWGTITLED cannot be read: done** (`DrawingSaveGuard.cs:54`). New test: a drawing AutoCAD says is saved, named with a web address or a bare file name, may be saved.
3. **Item 3, the never-saved line: done.** "This drawing has never been saved, so CE did not run CLEAN and saved nothing. Use Save As to give it a name, then run CLEAN again." True whatever the drawing was started from; no template bracket.
4. **Item 4, the wrong comment about read-only and in-place editing: done** (`DrawingSaveGuard.cs:108-112`).
5. **Item 5, the second inventory test: removed.** The older `NoSideEffectDrawingSaveTests` (wider pattern) still pins every drawing save. `REGRESSION_LOG.md` items 3 and 6 still speak of the removed test ("a test lists them", "every db.SaveAs in Structural is listed"); tidy, not blocking.
6. **Item 6, build record: done.** Scratch build at `226edc6c` (Structural net10 Release, SkipDevBundle, 0 errors, DLL `1.0.126+226edc6c`, SHA-256 `7972646A...`), recorded in `EVIDENCE_CLEAN_TEMPLATE.md`. The pull request comment says 388 related tests passed "before this commit"; I could not confirm a test run at the head itself.

## 2. The template path, traced two levels

1. **CLEAN on a template opened on purpose:** `StopIfSaveUnsafe` gives TemplateFile, not NeverSaved, so CLEAN carries on. The clean-up runs in memory (purge, XREF layer, text styles to STANDARD, ByLayer, REGENALL).
2. **Save stage** (`CleanPipelineService.cs:167-173`): returns "not saved (template or standards file)" and sets the template flag. No managed save, no command QSAVE.
3. **Then the safety-net save runs anyway:** at line 197 the drawing is "not saved", so `TryFallbackSave` runs. Its stage (`:285-292`) checks again, returns the same words and marks the safety net as used.
4. **Summary** (`EmitSummary`, `:757` onwards): "Done in ... N steps done, 0 failed, the simpler clean-up was used, drawing not saved." followed by both "OK QSave" and "OK Fallback Save" step lines.
5. **Last line** (`:217-221`): "This is a template or standards file (.dwt or .dws). CE cleaned it but did not save it; use QSAVE if you meant to change it."
6. **The template file is never written:** confirmed by reading. Both the managed save and command QSAVE sit behind the check, and `DrawingAutoSaveService.cs:165-171` refuses as well.

## 3. New risk added by the fixes

1. **Untrue summary on every template clean (`CleanPipelineService.cs:197`).** "The simpler clean-up was used" is printed although no clean-up happened in the safety net. This is the exact case the robot's step (d) and a Codex look would read, so the look would fail on words.
2. **Untrue "CE cleaned it" from FASTSAVE (`CleanPipelineService.cs:220`, words at `DrawingSaveGuard.cs:82-83`).** FASTSAVE runs only REGENALL unless "FASTSAVE also cleans" is on (`CleanPipelinePlan.cs:11-13`; off by default, `UserSettings.cs:372`). So on a template FASTSAVE does nothing and then says it cleaned it.
3. **Rare edge:** an error before the save stage (outside a step) leaves the template flag unset. The last line is then the loud "WARNING: drawing was NOT SAVED. Save it yourself now. Current file='...dwt'", which invites a QSAVE over the template. Closed by fix 1 below.
4. **Change from installed for a template opened on purpose:** installed saved straight into it; now it is cleaned in memory and not saved. AutoCAD asks "Save changes?" when it is closed, and Yes writes the cleaned template: the drafter's own choice. Safer than installed.
5. **Normal saved drawings: unchanged.** DWGTITLED 1 and a .dwg path give "may save"; the name test no longer runs when DWGTITLED can be read. A never-saved drawing is stopped before anything changes; there is no prompt, so Cancel and Escape do not arise. Nothing new is written on any refusal.
6. **No new setting, no engineering number.** The sheet sync's refusal (`CeSheetsSyncService.cs:1834-1835`) now also covers .dws but still says ".dwt"; a sheet register never lists a .dws, so cosmetic only.

## 4. Fix before the batch

1. **`CleanPipelineService.cs`, just after line 72 and at line 197:** decide once, before any step, whether the file is a template: `bool templateNotSaved = DrawingSaveGuard.CheckDocument(doc, DrawingSafetyService.GetDrawingPath(doc)) == DrawingSaveGuard.Verdict.TemplateFile;` (drop the later assignment at line 170), and skip the safety net for it: `if (!qsaveDone && !templateNotSaved)`. Result: no "simpler clean-up was used", no second save step, and the template line shows even after an early error. Keep the save stage's own check as it is.
2. **`CleanPipelineService.cs:220` with `DrawingSaveGuard.cs:82-83`:** say "cleaned" only when clean-up steps ran. For FASTSAVE with its tidy-up off, for example: "This is a template or standards file (.dwt or .dws). FASTSAVE did not save it; use QSAVE if you meant to save it." Add a test for each wording and one that the safety net is skipped for a template.
3. **Not blocking:** correct `REGRESSION_LOG.md` items 3 and 6 about the removed test.

---

# PR 2092 (BUG-1355), `0f496074` to `d686e787`

## 1. Were the four FIX FIRST items done

1. **Fix 1, a stop the drafter can act on: done, by the recommended route.** `RunSolveCommand.cs:100-121` hands a question to the route-finding; `ProposalApplyService.PlanBuilders.cs:521-539` asks whenever the end pit cannot settle a split (no end pit, both legs reach it, neither does, two pipes to the same pit), with or without an LPD. Letters A to Z; Enter stops at that pit; Esc ends the command with "Cancelled - drawing unchanged." (`:122-126`) before any window or write, and the record hold puts the refreshed record back (`:251`).
2. **Why the robot was asked for an end pit with an LPD stored:** `TryResolveEndPit` (`RunSolveCommand.cs:278-287`) skips that question only when a pit's number contains the LPD name (`FindLpdPit`, `PlanBuilders.cs:674-681`). An LPD stored by CDLPD on a stub is not such a pit. So the first review's premise ("with an LPD CDRUNSOLVE never asks") holds only for an LPD-named pit. The new question works either way, so it no longer matters.
3. **Fix 2, split at the start pit: done** (`NothingToSolveLine`, `RunSolveCommand.cs:129`). "Has no outgoing pipe" now appears only for a real dead end.
4. **Fix 3, preview words: done.** When the run ends at the split pit, the window says "Anchored on P10, where the run stops (2 pipes leave it and no way was chosen), at IL ... This solves only the pipes above P10; the pipes below it are not solved." and adds the stop line to its warnings (`:147-150`, `:195-198`). If that pit has no invert, the advice names the pit (`SplitAnchorAdvice`; the words it replaces match `PlanBuilders.cs:752-754` exactly). A run trimmed at an existing pipe still reads as a connection, correctly.
5. **Fix 4, tests: done.** LPD reached by both legs and by neither; Enter never says "pick an end pit"; split at the start pit; two pipes to one pit (named by size, or "first/second listed pipe"); the question's words; the preview words; a source check that Esc ends before the window. Lane figures, not re-run: 87 of 87; both broken twins fail.

## 2. The core-console check RUNSOLVE-SPLIT-01: honest about the route-finding, narrower than its write-up

1. **It runs CE's real route-finding from the build under test.** It calls `WalkDownstreamRun` on the loaded Civil program: the three-part form (which hands on to the same route-finding with nobody to ask) for parts 1 and 2, and the form the command itself calls, with a stand-in answer, for part 3.
2. **The results files match the claim.** Fixed run `%TEMP%\ce-headless-proof\run-20261114-011115` loaded `3.0.90+d686e787` (SHA-256 `0B0AD26F...`, the same as the scratch build): PASS. Installed run `run-20261114-011126` loaded `3.0.90.2+5c89ce30` (SHA-256 `183E7DC8...`, the same as the installed Modern program file I hashed): FAIL, "P10 -> P9" both with no end pit and with end pit C1.
3. **Would it fail without the fix:** yes, for the fault the robot saw (the first-listed pipe). Parts 1 and 2 fail on the installed build.
4. **What it does not prove:**
   1. **Not the command's own question.** The A/B prompt, the letter-to-pipe mapping and the Esc flag live in `RunSolveCommand.cs:101-118` and are not run; only the source check covers them.
   2. **Its "Esc" is really Enter.** A stand-in that answers nothing is what Enter does in the command; Esc in the command cancels the whole run. So the evidence line "Esc at that question: it stops at P10 and changes nothing" (`EVIDENCE_STALE_BUGS.md`, 01:15 entry, FOR TIM item 2.4) describes neither what CDRUNSOLVE does nor anything the check measured: no drawing, no record and no hold are involved. The README entry and the check's own failure text repeat "Esc or Enter".
   3. **Its PASS line claims more than it checks.** Part 1 checks only that the run is not "P10 -> P9"; a route-finding that wrongly took the last-listed pipe would also pass. "Names both pipes" is printed but the offered pipes are never checked.
   4. **Not the command-line lines or the preview window.** Its own detail already says so.
5. **Tighten (not blocking):** check that part 1's run is exactly "P10" and the offered pipes are exactly "P10 to P9, P10 to P4"; call the empty answer "Enter (no choice)"; correct evidence item 2.4 to "Enter at that question: it stops at P10. Esc is not covered by this check."

## 3. New risk added by the fixes

1. **Nothing written on Esc or Enter.** The route-finding is memory only; Esc at the question ends before the window, with the same hold as the existing preview Cancel. **Known, not new:** the quiet record rewrite CE does at the end of a cancelled CDRUNSOLVE (evidence of 13 Nov; PR 2064's subject) applies to this cancel exactly as to the existing ones.
2. **Normal use:** a pit with one pipe leaving it is walked exactly as before (`PlanBuilders.cs:513-518`). The question appears only at a split, including a pit holding two records for one pipe.
3. **No new setting, no engineering number** (the 26-way limit is the alphabet).
4. **Wording, minor and rare:** when three pipes leave a pit and exactly two reach the end pit, the question and the stop line say "2 pipes leave pit P5" (they count the pipes offered, not the pipes leaving). The code comments "(always the case with an LPD)" at `RunSolveCommand.cs:97` and `PlanBuilders.cs:486` are wrong (only an LPD-named pit, and even then one leg reaching it settles the split); not seen by the drafter.
5. **The robot may not be able to answer A or B:** its driver refuses a typed word at a CE prompt (evidence of 13 Nov, 04:10). The 14 Nov run reached CDRUNSOLVE's questions by chaining answers in one typed line; if a letter is refused, the choose path needs Codex.
6. **Still today's behaviour (first review, not blocking):** a pit with one real pipe and one blank-ended pipe still takes whichever is listed first.

---

# PR 2099 (BUG-1298), `c788a0ea` to `9c3f088e`

## 1. Were the two items done

1. **Fix 1, one rule: done.** `IsCandidatePipe` (`LpdService.cs:712-719`) now only gathers the facts and returns the tested rule (`:718`). The answer is the same as before in every case: the CE pipe layers come from a list built to ignore case (`:685`), and asking that list's names uses the same ignore-case test the old lookup did. The five rule cases now test what both CDLPD routes run, and a new source check pins the call.
2. **Fix 2, the advice: done.** "That line is not a CE pipe, so it cannot be the LPD pipe. Nothing was changed. Run CDLPD again and pick a CE pipe, a pit or a block, or choose to pick a point." True when shown: CDLPD has ended (`LpdCommand.cs:68-73`).

## 2. New risk

1. **None found.** The refusal sits in a read-only step before any marker, note or stored LPD. No setting, no number, normal CE pipes pass as before. **Known, not new:** CDLPD's end-of-command record rewrite (seen again on 14 Nov when its window was closed) still happens after a refusal; "Nothing was changed" is true of what the drafter sees.
2. **Built:** 0 errors at the head (scratch `build_s2099`, SHA-256 `811E803E...`); lane: 287 of 287 unit tests; not re-run.
3. **Cannot be robot-tested:** CDLPD's "Continue in drawing" button is not on the robot's press list; it needs a person or Codex.

---

# Merge dry runs (git merge-tree only; no worktree, branch or ref touched)

1. **2094 onto installed Structural `8de95c34`:** clean (the pull request sits straight on it).
2. **2092 onto installed Civil `5c89ce30`:** the product files (`RunSolveCommand.cs`, `ProposalApplyService.PlanBuilders.cs`) merge clean. Four conflicts, all "both sides added an entry in the same place": `CE_HEADLESS_PROOF.csproj` and `ProofCommands.cs` (keep both BUG-1456 checks and the split check), `tools/headless-proof/README.md` (both use item 20: renumber the split check to 22), `REGRESSION_LOG.md` (keep both entries). No reference to the proof project was found in `Installer/` or the Civil project file, so it is not shipped.
3. **2099 onto `5c89ce30`:** only `REGRESSION_LOG.md`.
4. **Both Civil pull requests together:** 2092 with 2099 directly, and 2099 onto the result of `5c89ce30` plus 2092 (as an unreferenced scratch commit): only `REGRESSION_LOG.md` each time. No product file is touched by both.
5. **No clash of behaviour by reading:** neither Civil pull request touches the record writer that PR 2073 and PR 2083 changed; CDRUNSOLVE's hold and CDLPD's end-of-command flush are called as before.
6. **2094 with PR 2074 (report only; 2074 is not in the batch):** conflicts at the start of `CleanPipelineService.Run` (2074's read-only and in-place-edit stops against 2094's never-saved stop) and at the top of `REGRESSION_LOG.md`. Keep both stops, 2074's first, as the 2094 pull request comment says. The end of `Run` merges by itself and reads right: 2074's "steps did not finish" line, then 2094's template line, then 2074's backup-copy line after a save. Not built.

# Could not verify

1. Any build or unit-test count: taken from lane lines and evidence files, not re-run (by rule).
2. Whether 2094's head itself was test-run (its comment says the tests ran before the commit).
3. Anything in AutoCAD: the A/B question as AutoCAD shows it, the preview window words, CLEAN or FASTSAVE on a template, CDLPD's refusal.
4. Whether the robot's driver can send a single letter at a CE prompt.
5. AutoCAD 2022 to 2024 (net48) for all three.

---

# PR 2094 (BUG-1457), third look: `226edc6c` to `2205dfde` (Sat 14 Nov 2026, 01:38 PC clock)

**Verdict: BATCH-READY.** Read only: `git diff 226edc6c..2205dfde`, `CleanPipelineService.Run`, `TryFallbackSave` and `EmitSummary` and the whole of `DrawingSaveGuard.cs` read at `2205dfde`, compared with installed `8de95c34`. No build, no test run, no AutoCAD, nothing merged or pushed to the plugin repo, no GitHub comment.

## 1. The safety-net save can no longer run for a template or standards file

1. **Decided once** (`CleanPipelineService.cs:75`), right after the never-saved stop and before any step or save: `isTemplateFile` from the same `CheckDocument` the save step uses; `templateNotSaved` starts from it (`:96`).
2. **Normal path:** the save step still refuses on its own check (`:173-179`); the safety net is skipped by `if (!qsaveDone && !templateNotSaved)` (`:204`).
3. **Error outside a step, before the save step:** `templateNotSaved` is already true, so the safety net is skipped. Errors inside a step are caught by the step itself and the run carries on to the save step, which refuses.
4. **Error before the `try`** (taking the settings snapshot, opening the undo group): it leaves the command with nothing saved, as installed. Safe.
5. **Undo group:** closes in `finally` as before; nothing about it touches the save.
6. **CLEAN and FASTSAVE:** one method, one path (`LegacyPortCommands.cs:12,15`). The safety net keeps its own template check (`:295-299`), and the managed save refuses too (first review), so a template is never written even if the flag were wrong.

## 2. Every last line is now true

1. **Template opened on purpose, CLEAN (or FASTSAVE with tidy-up on):** summary "N steps done, 0 failed, drawing not saved" (no "simpler clean-up", no "Fallback Save" step line); last line "CE cleaned it but did not save it; use QSAVE if you meant to change it". True.
2. **Template, FASTSAVE with tidy-up off (the default):** only the regen runs; last line "FASTSAVE did not save it and cleaned nothing". True.
3. **Template, error outside a step:** "This is a template or standards file (.dwt or .dws), so CE did not save it. Use Save As to give it a job name." True, no "cleaned", not the loud warning.
4. **Never-saved drawing:** stopped first by `StopIfSaveUnsafe` with the plain Save As line, nothing cleaned or saved; unchanged since the last review.
5. **Normal saved drawing:** the guard says Ok, so `isTemplateFile` and `templateNotSaved` are false and the safety net, summary and "saved <file>" or loud warning are exactly as installed `8de95c34` (the only difference is a DWGTITLED read that cannot throw).

## 3. Messages, writes, settings

1. **No line invites saving over the template unasked.** The loud "Save it yourself now" warning can no longer appear for a template. The normal template line says "use QSAVE if you meant to change it": conditional, and it is the DRAFT default still waiting for Tim (clean and leave unsaved, or refuse).
2. **Nothing written on refusal; no new setting** (the FASTSAVE switch read is the existing one); no jargon in what the drafter reads.

## 4. Tests and merge

1. **The new tests fail on `226edc6c`:** `TemplateFinalLine` does not exist there (the line test cannot compile), `isTemplateFile` is absent (the decided-once test fails), and the changed anchor in `CleanSavesAgainTests` looks for the new condition.
2. **What they exercise:** the line test calls the real `TemplateFinalLine`. The other two are source-text checks (order, the skip sitting directly above the safety-net call, the error flag). `Run` itself cannot be run without AutoCAD, so this is the most a unit test can do.
3. **`git merge-tree --write-tree 8de95c34 2205dfde`:** clean (tree `32396ce7`; `8de95c34` is an ancestor).

## 5. Not blocking (tidy later)

1. **A step that fails inside the clean-up** (for example the purge) is counted as a failed step, not as an error, so CLEAN on a template still says "CE cleaned it" while the summary shows "1 failed". Mostly true; the summary tells the rest.
2. **The two template lines give different advice** (QSAVE normally, Save As after an error). Both are true; settle with Tim's open choice.
3. **Summary step line** still reads "OK QSave - not saved (template or standards file)". Cosmetic.
4. **`REGRESSION_LOG.md` item 6** still speaks of the removed inventory test (item 10 corrects item 3 only).

## 6. Could not verify

1. A build or test run at `2205dfde` (the pull request comment says 390 related tests pass on net10, net8 and net48 build clean, SkipDevBundle).
2. Anything in AutoCAD: CLEAN or FASTSAVE on a scratch copy of a template, the summary and last lines as AutoCAD prints them, AutoCAD 2022 to 2024.
