# Review: PR 2099 `claude/trust04-b1298-lpd-pipe-only` (BUG-1298: CDLPD takes any plain polyline you click as the pipe), head `c788a0ea`

**Reviewer:** trust-review helper. **Written:** Fri 13 Nov 2026, 22:46 PC clock. **Base:** `cf059dcf` (installed Civil 3.0.90); one commit on top. `LpdCommand.cs` and `LpdService.cs` are byte-identical between `cf059dcf` and the trial build on Tim's PC (`9714ffdd`, Civil 3.0.90.2). Draft. Read only: no build, no test run, no AutoCAD. **Lane that owns the branch:** trust-safety-fixes (its 12:12 line: built, 285 of 285 unit tests, broken twin 3 of 6 fail).

**Verdict: GO** (fit for the robot test on copies). The fault is real, and the change closes it on every route CDLPD has for choosing the pipe, using the same check the point route already used. Two small fixes before Codex reads the words or the branch merges; neither stops the robot test.

---

# FOR TIM

1. **The fault is real.** In CDLPD, if you chose "pick an object" and clicked a kerb line or a boundary by mistake, CE took it as the pipe. It put the LPD marker and note at that line's end and stored it as your legal point of discharge.
2. **What you see now:** clicking anything that is not a CE pipe gets one line: "That line is not a CE pipe, so it cannot be the LPD pipe ... Nothing was changed." No marker, no note, no stored LPD. Clicking a real CE pipe works exactly as before.
3. **One wording fix needed:** the line goes on to say "Pick a CE pipe, a pit or a block, or press Enter to pick a point", but CDLPD has already finished by then. It should say "Run CDLPD again and pick ...".
4. **Older drawings:** a polyline on a CE pipe layer is still accepted, the same as the "pick a point" route has always done.

---

# Findings (file and line at `c788a0ea` unless marked `9714ffdd`)

## 1. Is the fault real in the installed code, and by which path

1. **Confirmed by reading.** `Commands/LpdCommand.cs` (`9714ffdd`) 56 to 76: on the object route, a clicked entity that resolves to a `Polyline` is used at once. Its nearer end becomes the LPD point (`pipeId`, `endIndex`, `endPoint`). No check that it is a CE pipe.
2. **What then gets written** (`9714ffdd` 164 to 232): the LPD label and callout are drawn at that line's end, and `LpdService.SetLpdData` stores the LPD against that polyline's handle. The plain polyline has no CE record, so the note's level comes out blank (`ResolveInvertAtPipeEnd`, which reads CE's pipe record and finds none) and the pipe From/To tag is skipped. The stored LPD and the marker at the wrong place are real, and whatever reads the stored LPD (step 7's start point, once PR 2058 lands) would read a kerb line. Which installed tools read it today was not traced.
3. **The point route already refused it:** `LpdService.TryFindNearestPipeEnd` (`9714ffdd` 446 to 490) only looks at polylines that pass `IsCandidatePipe`.

## 2. Does the fix close it on every path

1. **Object route, polyline:** closed. `LpdCommand.cs` 67 to 73 refuses before the line's ends are read, using `LpdService.IsPipeForLpd(pline)` (`LpdService.cs` 699), which is the existing `IsCandidatePipe` (709 to 720): a CE pipe object, or a polyline on a CE pipe layer.
2. **Object route, pipe outline or twin line:** still resolved to its pipe first (line 63, `PipePickService.TryResolvePipe`), so it passes.
3. **Object route, pit block:** the pipe comes from the pit's own CE pipe records (`TryResolveLpdFromPit`) or the nearest-end search, which uses `IsCandidatePipe`. Already safe.
4. **Object route, other block (kerb outlet, connection point):** nearest-end search, `IsCandidatePipe`. Already safe.
5. **Point route:** `IsCandidatePipe`, unchanged.
6. **Anything else clicked** (a line, an arc): unchanged, "Selection is not a pipe, pit, or block."

## 3. Nothing written on refusal; locked layers and Xrefs

1. **Nothing is drawn or stored on refusal.** The check sits inside a read-only transaction, before any label, callout, LPD record or pipe tag.
2. **One thing to know (not new, not this PR's to fix):** CDLPD is on CE's list of commands after which CE rewrites its record at the command's end even with nothing waiting (`LinkService.cs` `9714ffdd` 61 to 81, `RecordFlushCommands`; `FlushPendingSave`, `ProjectDataService.Persistence.cs` `9714ffdd` 437 to 470). So after the refusal, CE's record is written back unchanged into the drawing, which counts as a drawing change. The same happens on every early stop of CDLPD today. That is PR 2064's subject. The 2073 cure on Tim's PC already stops it writing another drawing's record. "Nothing was changed" is true of what the drafter can see.
3. **Locked layers and Xrefs:** the refusal changes nothing, so neither arises. A plain polyline inside an Xref is picked as the Xref block and goes the "other block" route, as today.

## 4. One code path per behaviour

1. **The product has one check.** Both routes now call `IsCandidatePipe`.
2. **But the tests check a copy.** The PR adds a second, AutoCAD-free version, `IsPipeForLpd(bool, string, ICollection<string>)` (`LpdService.cs` 702 to 703), which writes the same rule out again. No product code calls it. Five of the six test cases test only this copy. If `IsCandidatePipe` were later changed to take any polyline, those five would still pass. Only the source-order test would notice that the guard line was removed. See fix item 1.

## 5. Settings and hard-coded values

1. **No new setting.** The CE pipe layers come from the existing layer settings (`LayerService.GetPipeLayerDefinition`, through `BuildPipeLayerMap`). No engineering value is involved.

## 6. Wording the drafter sees

1. **Plain and true in what it says happened.** It names the cause and ends "Nothing was changed."
2. **Its advice is for a prompt that has gone.** The command returns straight after the line (`LpdCommand.cs` 70 to 72), so "Pick a CE pipe, a pit or a block, or press Enter to pick a point" (`LpdService.cs` 705 to 707) points at nothing. Pressing Enter at the bare command prompt repeats CDLPD and opens its window again, which is not what the line promises. See fix item 2.

## 7. Tests

1. **Real in part:** the source-order test fails without the fix (no guard line before the end points are read). The five rule cases fail only against the copied rule (section 4).
2. **Only AutoCAD can prove (robot, copies only):** (a) a plain polyline on layer 0, and one on a boundary layer: refused, nothing drawn, no LPD stored (CDLPD again shows the earlier LPD unchanged). (b) A real CE pipe: LPD set as before, note level from that pipe end's stored invert. (c) An older drawing's pipe drawn as a polyline on a CE pipe layer: accepted. (d) A pipe outline (double-line pipe): accepted through its pipe. (e) Save, reopen: the earlier LPD still in place after a refusal.

## 8. Risk to normal use

1. **Low.** A real CE pipe passes exactly the check the point route has always used. The one group that loses out is a hand-drawn polyline on an ordinary layer used as a stand-in for a pipe; it is now refused with a plain line, which is the bug's own expected behaviour.

---

# Before Codex looks or the branch merges (neither stops the robot test)

1. **`LpdService.cs` 702 to 720: make the tested rule the shipped rule.** Have `IsCandidatePipe` call the AutoCAD-free version, for example `return IsPipeForLpd(PipeEntityService.IsPipe(pline.ObjectId), pline.Layer, layerMap?.Keys);`, so the five rule cases test what CDLPD and the point route actually run. Re-run the broken twin against `IsCandidatePipe` itself.
2. **`LpdService.cs` 705 to 707: correct the advice.** Suggested: "That line is not a CE pipe, so it cannot be the LPD pipe. Nothing was changed. Run CDLPD again and pick a CE pipe, a pit or a block, or choose to pick a point." (Or re-ask the pick instead of ending; the words must then match.)

# Worth knowing

1. **Merge joins:** PRs 2058, 2061, 2067 and the BUG-1299 and BUG-1301 drafts edit the same two files; text conflicts expected, no clash of behaviour by reading (2058 adds its check before the window, above this one).
2. **A polyline on a CE pipe layer with no CE record** is still accepted as the LPD pipe, on both routes. Its LPD is stored but no pipe gets the LPD tag. Today's behaviour on the point route; not this bug.

# Could not verify

1. The build and the 285 tests (no build or test run, by rule).
2. Which entity types `PipePickService.AllowPipeClasses` lets the pick take on AutoCAD 2022 to 2024 (net48); not traced.
