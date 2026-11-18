# Current rulings: The old plug-in (parts bin, carpark, sweep, what gets fixed there, wrong-figure bugs)

Current rulings as of 18 Nov 2026, 1:20 pm (Melbourne), from decisions D-001 to D-225. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Parts bin

1. **The existing plug-in is a parts bin** (D-001); the parts-bin read (Stage 3) ran read-only in the background (D-088).
2. **Left behind:** the special one-piece pipe object; the linking code built around it; facts held in several places with repair commands; the settings store where a new value needs new code; the old windows (D-094).
3. **Taken, each re-checked against a real job first:** the orifice sums, storage in pipes, pits and tanks, the rainfall data and curve, pipe capacity sums with their known-right answers, the office's own blocks, the pit schedule row rules (D-095).
4. **Old council figures:** keep only sourced figures; the rest start blank (D-096).
5. **Drawings made with the old special pipe:** a one-off "make it ordinary" tool, later, after the first release, one drawing at a time on a copy first (D-119).
6. **Old typed names are gone** in the new plug-in (D-053), with the exceptions on RIBBON_AND_NAMES.

### The carpark and the sweep

7. **The sweep of the bug carpark was run,** read-only, sorting every open bug once; nothing in the carpark was changed, closed or deleted (D-206). Result: 597 would happen again, 256 die with the old build, 399 outside the first release, 15 stop work now, 28 not bugs (D-207, R-007).
8. **The 597 recurring bugs sit behind the 27 obstacle course tests** (D-216, D-213).
9. **No rewriting of the old plug-in beyond what stops work or puts a wrong figure on a sheet** (the planning chat's answer in D-213, which Tim met with "yes, write both"; the answer itself is the planning chat's).
10. **The hatch fault in Tim's working AutoCAD was added to the carpark as BUG-1461** (D-206, D-199).

### The two wrong-figure bugs

11. **Both were checked read-only** (D-207). **BUG-866 (rainfall note) is real and not fixed in the installed build;** **BUG-1095 (council minimum C) was real in older builds and is fixed since Civil 3.0.87;** the new plug-in's data would repeat both unless designed against them (D-212, R-008).

## Changed along the way

1. **Nothing on this page has been superseded.** The carpark's rule in `C:\Lisp Files\CLAUDE.md` still applies to the old plug-in.

## Still open on this subject

1. **Freeze the carpark as the old plug-in's list, fix there only what stops daily work, and start the new plug-in with an empty short list:** proposed with the sweep; Tim approved the sweep and did not rule separately on the freeze (D-206). Waits on: Tim.
2. **Sort the ideas inbox the same way:** proposed, not ruled (D-206). Waits on: Tim.
3. **The 15 bugs that stop daily work now in the installed plug-in:** what happens to them is not decided (R-007 pile D). Waits on: Tim.
4. **BUG-866 is real and the fix is not installed;** R-008 says load the site's own rainfall or work storage in CDCALC Boyd's tab with the site's figures meanwhile (R-008). Waits on: Tim.
5. **BUG-1095 fixed since 3.0.87 but not yet proven in AutoCAD;** jobs of three councils sized before 30 Oct 2026 should be re-run (R-008). Waits on: Tim.
6. **BUG-1461 hatch fault:** R-006's two-minute check (Associative, PICKSTYLE, GRIPS, GRIPMULTIFUNCTIONAL, HPBOUND) has not been done (R-006). Waits on: Tim.
7. **The sweep sorted from cut-short text once, mostly medium confidence; nobody re-checked it** (R-007). Waits on: the planning chat.
8. **Old drawings made with the special pipe (D-119) and the live drawing that shows nothing without the plug-in (P-04)** wait for later; the file location for P-04 has not been given. Waits on: Tim.
9. **Keep the old CDCALC side by side for the computations sheet until a new one exists** (FUNCTION_MAP FM-047 recommendation). Waits on: Tim.

## Where the detail lives

1. `DECISIONS.md` D-001, D-053, D-088, D-094 to D-096, D-119, D-199, D-206, D-207, D-212, D-213, D-216.
2. `stage3\PARTS_BIN_REPORT.md`; `reference\research\R-007_BUG_SWEEP.md`; `reference\research\R-008_TWO_WRONG_FIGURE_BUGS.md`.
3. `C:\CE_PLAN\BUG_CARPARK.md` (the old plug-in's list, outside this folder).
