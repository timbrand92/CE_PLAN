# Answer: design\ROUNDING.md at 65be7a4 (the one rounding routine)

**Answer: FIX THE PAGE FIRST, on eight short edits. Both readers say so. One point is a clash between rulings and goes to the control room for Tim (section 2).** Written Sat 21 Nov 2026, about 3:07 am. By reading only. Honest reader: one Claude helper on Opus: `C:\CE_WORK\check\reports\rpage_honest_REPORT.md` (every figure in the page's cases checked by hand and right). Adversarial reader: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\rpage_adv_REPORT.md`. (A slip of the check room's: the readers were first set up on a commit that does not exist; the page was re-copied from 65be7a4 and both readers read the real text.)

## 1. The edits (each one short)

1. **The printer's fixed forms, complete** (both): one entry point for drawn measurements (a tenth of a millimetre); fixed outputs for the window's three-place working (levels, depths and falls: a 1 mm fall reads "0.001", D-393 item 3, D-395), the two-place plan figure, the grade box and the check wording (say how many places a grade has in a check sentence: case 1's "200.004" has no form that prints it).
2. **The sheet form only on the sheet** (both): the source test fails any window-form figure that reaches a preview, label, plot or schedule cell; add a planted Pit label printing "CL 5.755".
3. **One check owner** (adversarial): the solver, Run, labels, lid wording and schedule all read the same decision made once on exact inputs, with the tolerance from the settings store.
4. **The caller list, complete** (adversarial): every direct, indirect, data, script and template caller with its destination; an unaccounted caller fails.
5. **The allow-list written out** (both): each entry with its reason (pixels, counts, timings, slab millimetres, Boyd's inflow, which is D-284 not D-283); anything not listed fails.
6. **No grade means no "TBC"** (both): an unknown grade leaves the grade off the label (D-413 item 3); a known tiny grade stays visible; "TBC" is only "CL TBC"; the assumed-level prefix carried through the sheet form.
7. **The Pit boundary** (adversarial): the Pit window supplies a pit's worked levels and depth (D-436); the schedule or Run cannot hold a worked cover or depth.
8. **Stronger tests:** the padlock test changes the source while locked, reopens, then unlocks (a padlock that did nothing would pass four reads of an unchanged figure); a legacy grouped note under each supported Windows region; the full 299.53 mm sentence, 299.5 mm, the 294.9 and 295.0 mm pair, −0.004 printing 0.00.

## 2. For the control room (a clash between rulings, for Tim)

**A pipe at exactly 1 in 200.004 against a 1 in 200 limit: pass or warn?** D-380 (Tim confirmed: "a grade passes at two decimal places") passes it; D-350, D-411 and D-424 (checks on exact figures; D-411 and D-424 drafts) warn. Both readings warn at 200.04, and only 200.004 sits between them. The check room's earlier rounding verdicts listed 200.004 passing as a blocker on the D-411 and D-424 reading; that was wrong to treat as settled. Recommended (both readers lean opposite ways): mark the case DRAFT on the page with both outcomes, and ask Tim; the adversarial reader recommends the exact warning with "1 in 200.004" written in the check so the drafter can see why; the honest reader reads D-380 as deciding it (pass).

## 3. Ruled since (control room, about 3:08 am)

Tim's confirmed ruling wins: **D-380, "a grade passes at two decimal places".** A GRADE is compared with its limit at two decimal places: 1 in 200.004 is 200.00 and PASSES; 1 in 200.04 warns. The D-411 and D-424 drafts stand only where they do not conflict: LEVELS, depths, covers and clashes are checked exact against the tolerance; the window may still show the worked grade ("200.04", "94.6"). The page states this as RULED, not as a draft with two outcomes (it replaces section 2's recommendation). The only point still for Tim is the LABEL at 200.04 (D-411 item 1).

---

# Second answer: the page at 5a77b22 (the eight edits and the D-380 ruling read back)

**Answer: BUILD FROM IT.** Written Sat 21 Nov 2026, about 3:28 am. By reading only, by the check room itself (65be7a4 to 5a77b22: one file, 62 lines added, 14 removed; a "Changed since 65be7a4" list at the top). The hand-over named the tip "dd16a31", which does not exist; the branch's real tip is 5a77b22 ("the check room's eight edits and the D-380 grade ruling"), and that is what was read.

1. **All eight edits are in:** one entry point for drawn figures (a tenth of a millimetre, once) and one printer with six figures (level, depth, fall, grade, shortfall, cover) and a fixed form for each destination (window working to three places: a 1 mm fall reads 0.001 beside 0.00 on the plan; sheet two places half up: 12.6 prints 12.60, 5.755 prints CL 5.76; grade box and label; check wording); the source test rejects a window-form figure on a preview, label, plot or schedule cell, a planted "CL 5.755" and a truncation to "CL 5.75" included; one check owner (`Things/Checks.cs`) on exact inputs with the store's tolerance; every caller recorded with its destination; the allow-list with a purpose for each entry (Boyd's inflow, D-284); an unknown grade omitted from the label, a tiny known grade kept, APPROX. kept; the Pit window owns a pit's levels and depth (D-436); the padlock, regional, 299.53, 299.5, 294.9 and 295.0, and −0.004 cases.
2. **The D-380 ruling stated as RULED:** a grade is compared with its limit at two decimal places (10.0002 m falling 0.050 is 1 in 200.004, compared as 200.00: Suits; 10.002 m is 200.04: warns); the 0.01 comparison kept in both flatness rows, fed the exact grade; levels, depths, covers and clashes exact against the tolerance. The label at 200.04 stays with Tim (D-411 item 1).
3. **What this means:** the rounding routine may be rebuilt from this page (team/exact-rounding's code is not carried as it stands; its tests and the honest caller list come over). A6's replacement, the Pit window's depth figures and the pipe run wait for that build's MERGE (D-432). Checked by reading only.
