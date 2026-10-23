# Fix briefs, Team batch 3 of 4 (FB-16 to FB-20), report, Sat 24 Oct 2026 about 1:10 am Melbourne

## ANSWER FIRST

Four of the five briefs are fixed as draft PRs; FB-18 is skipped because it needs Tim's design word. Everything is built and unit-tested only. Nobody has opened any of it in AutoCAD. No bug is marked FIXED, no PR closed, no branch deleted, no setting or installed bundle touched.

1. **Base:** `origin/claude/rel-20261023m` at head `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (Civil 3.0.72 / Manager 1.1.72). The brief said `dd13cf58` for this branch; the branch had moved on by my fetch (the version-bump commit "Version: Civil 3.0.72 / Manager 1.1.72 (C-62)" is its head). I branched from the head I fetched.

2. **FB-16, BUG-719, BUG-720, BUG-723, BUG-724: draft PR #1707**, branch `fb/fb16-landxml-import`, head `f9eebcfb36257eaae09d25830fa16acdf05bf1f9`.
   - **Tests:** 10 new (`Fb16LandXmlImportFaithfulnessTests`); 9 fail on the base, the old-spelling test passes on both. Civil net10 full run: **19,558 total, 19,536 passed, 22 skipped, 0 failed.** net48 compile of the Drainage project: 0 errors.
   - **Real-AutoCAD check (FX-16):**
     1. Make a synthetic LandXML in the FIXBRIEFS test folder: 2 structures (P1, P2), 1 pipe naming them with `refStart` / `refEnd`, metres, pipe material "uPVC SN10", diameter 0.300.
     2. In a fresh copy of a mm drawing run `CDIMPORTLANDXML`, choose the file, press Read, then Import.
     3. Right looks like: the review says 2 pits and 1 pipe; one CE pipe is drawn between the two pits; its material label reads "uPVC SN10" (not "UPVC SN8").
     4. Second file: the same with a control pit (name "CP1", desc "Control pit", RectStruct 0.9 x 0.9). Right looks like: the control pit is 900 x 900 overall.
     5. Third file: a RectPipe 1.2 x 0.6. Right looks like: its review row says "1200 x 600 box pipe in the file, drawn as a 1200 mm round ... check the size" and is marked Check, not Read.

3. **FB-17, BUG-725, BUG-728, BUG-729: draft PR #1708**, branch `fb/fb17-landxml-scale-grade-rim`, head `2ed82768e914cf30060db339f145a911471e614c`.
   - **Tests:** 10 new (`Fb17LandXmlScaleGradeRimTests`); 6 fail on the base. Civil net10 full run: **19,558 total, 19,536 passed, 22 skipped, 0 failed.** net48 compile: 0 errors.
   - **Real-AutoCAD check (FX-17):**
     1. Synthetic LandXML with `linearUnit="millimeter"`, two pits at about E 345000 / E 345015 (millimetre values), one pipe with `slope="-0.01"`, and a pit with `elevRim="45.2299999"`.
     2. In a mm drawing run `CDIMPORTLANDXML`, Read, Import.
     3. Right looks like: both pits sit at the file's positions within 1 mm (not 1000 times further out); the pipe label carries 1:100; the cover text reads CL 45.23.
   - **Overlap:** FB-16 and FB-17 both change `LandXmlParser.cs`, in different places. FB-17 branches from the base, not from FB-16, so its tests use the old `startRef` / `endRef` spelling. They should merge with no code conflict; only the top of `REGRESSION_LOG.md` needs both entries kept.

4. **FB-18, BUG-648: SKIPPED, needs Tim's design word.** See "Skipped and why".

5. **FB-19, BUG-760: draft PR #1710**, branch `fb/fb19-level-pipe-grade`, head `b46f0c3251aeceab6a224bd4ef793dcafef16164`.
   - **Tests:** 15 new (13 in `Bug760LevelPipeGradeTests`, 2 in `ProfileRouteReviewServiceTests`). They use new code, so they cannot compile on the base; with the two service changes reverted, 3 of them fail (route not Ready, section not admitted). Civil net10 full run: **19,563 total, 19,541 passed, 22 skipped, 0 failed.** net48 compile: 0 errors.
   - **Real-AutoCAD check (FX-19):**
     1. A 20 m pipe from P1 to P2, both inverts 10.00, no "1 IN N" grade label on the pipe.
     2. Run `CDPROFILE`, pick P1 then P2, Review, Apply.
     3. Right looks like: the section is drawn (before: refused as "pipe grade Unknown"); the PIPE GRADE row reads LEVEL; the speed and full-flow cells for that pipe are blank. In the review window the grade cell reads LEVEL and the speed and flow cells read "Blank (level pipe)".
     4. Also check a rising pipe (P2 invert 10.20): it must still be refused with the "rises along the flow" reason.

6. **FB-20, BUG-764: draft PR #1709**, branch `fb/fb20-boundary-along-pipe`, head `32d8a1556c4d177d4a9bf463cbf4c71f53962050`.
   - **Tests:** 10 new (`LongSectionBoundaryProjectorTests`, a new pure helper, so they cannot compile on the base). Civil net10 full run: **19,558 total, 19,536 passed, 22 skipped, 0 failed.** net48 compile: 0 errors.
   - **Real-AutoCAD check (FX-20):**
     1. A dog-leg pipe: P1 at 0,0, bend at 10000,0, P2 at 10000,10000; a boundary line from 9000,5000 to 11000,5000 on layer A-TITLE BOUNDARY.
     2. Run `CDPROFILE` P1 to P2, Review, Apply.
     3. Right looks like: one BOUNDARY mark at chainage 15.0 m (within 0.05 m). Before: no mark at all.
     4. Also check a straight pipe with the same boundary across it: the mark must be exactly where it was before this change.

7. **Skipped and why:**
   - FB-18 (BUG-648), see below.
   - Nothing else skipped. For none of the ten bugs did a real fix PR already exist: the `gh pr list --search` hits were all other bugs (for example #1268 is BUG-649, not BUG-648; #1578 is BUG-1012).

8. **What I did NOT test:** anything in AutoCAD or accoreconsole; any window or drawn picture (the review-window wording and the drawn LEVEL text are unseen); the net48 test lane (net48 builds only: the Drainage project compiled with 0 errors on all four branches, but no test ran there); the refStart / refEnd spelling against a real Civil 3D or 12d export from the office drive (only the LandXML 1.2 schema, as the brief says); pipes with curved (arc) segments for FB-20 (arcs are followed in 5 degree steps; the code path is not covered by any test and not by the real-AutoCAD check above); Manager (not touched); CE_SHARED (not touched); Structural (not in scope).

## What I checked that differs from the brief

1. **The brief's base head was out of date** (see item 1 above).
2. **FB-18's premise is wrong:** the brief says Accept "draws only the polyline and its AG tag". For an ordinary AG drain (CDAGI) no tag is drawn at all. Only a perimeter drain (PD) gets a drawn tag (`BuildDrainLabel` returns nothing for AG, by design since BUG-217, "AG drains keep exactly the drawing they had (no extra text)").
3. **FB-20's two instructions pull against each other at the end pit:** "marks on straight pipes: identical" and "end pit reads 1.41 m for a pipe leaving at 45 degrees" cannot both hold for an oblique straight end pipe. I kept straight pipes identical for crossings along the pipe and for any end pipe square-on to the boundary, and changed the end-pit reading only where the end pipe's own line meets the boundary (then 1.41 m, as the brief's expected result). Where it does not meet, the old straight distance is used. Say if you want it the other way.
4. **FB-16 carries a size flag, not a "pipe note":** the pipe source has no note field, so the box size goes in a new `SizeCheckNote` on the imported pipe and into the import review row and report line. It is not stored in the drawing's pipe record.
5. **FB-16 (BUG-724) keeps the file's text exactly,** including text such as "Fibre reinforced concrete". I did not trace every later step that looks a material up by CE's own names, so I cannot say how each treats a spelling CE does not list (it may read it as Unknown, which fits "Unknown stays Unknown"). Worth a look on the first real file.

## Skipped and why: FB-18 (BUG-648, AG drain grade label)

**Why it needs Tim:** the approved card (UX-SURF-04, "CE run, own style", "grade check and label only") says "label the grade", but not what the label does when the drain is copied, renumbered, moved or erased. The only existing way to tie a text to a drain is the PD tag mechanism, and that mechanism treats the linked text as the drain's own NUMBER:
   1. **Renumber:** when an AGI record is renumbered, the linked text is rewritten to the new number. A grade label registered that way would turn into "AGI3".
   2. **Copy:** a copied drain's copied text is paired and rewritten to the new number (AGI4). A grade label would be overwritten the same way.
   3. **Erase and Undo:** the same link does handle these, which is why the brief wants it.

**Options (my recommendation first):**
   1. **Recommended: give the grade label its own link kind** (a second, separate attachment type on the drain), so ERASE, Undo and Redo, and MOVE treat it with the drain, but renumber leaves it alone and COPY re-draws a fresh grade label for the copy from the copy's own levels. Drafter sees: label "AG DRAIN AT 1 IN 50" mid-run, follows the drain everywhere, never turns into a number. Needs an Opus review (it touches linking and Undo).
   2. **Simpler: draw the label once, unlinked.** ERASE of the drain leaves the label behind (a stray "AG DRAIN AT 1 IN 50" on the drawing). The brief's own check ("ERASE the run removes the label too") would fail, so I do not recommend it.
   3. **Reuse the PD text link and teach renumber and copy to skip grade labels.** Smallest edit, but it spreads "is this text a tag or a grade label" tests through the PD code; I judge it the riskiest for the PD tag Tim already accepted (BUG-258).

**Questions for Tim (batch, with my recommendation):**
   1. **When an AG drain is copied, should the copy get its own grade label?** Recommend yes, worked out from the copy's own levels (a 20 m copy at the same levels reads the same grade).
   2. **Wording:** "AG DRAIN AT 1 IN 50" is the brief's draft. Keep, or "AG DRAIN 1 IN 50"? Recommend keep.
   3. **Switch:** `agDrain.drawGradeLabel` ON (the card says label, so the missing label is the bug). Agreed in the brief; nothing to decide.

I wrote nothing for FB-18: no branch, no PR.

## Process notes

1. **Builds:** foreground, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, net10 Civil test project only (plus a net48 compile of the Drainage project per branch). AutoCAD refs as in the C-62 assembly report. Private worktrees `C:\ce-fx\fb16`, `fb17`, `fb19`, `fb20` (removed at the end; the four branches stay on GitHub). Free space before each build was 12 to 23 GB (never under 12). No AutoCAD, Codex or accoreconsole was started; no settings file, bundle or ProgramData touched; CE_SHARED unchanged.
2. **A mistake of mine, no cost to the result:** my first FB-16 full run built a stale copy of the parser (restoring a file kept its old time stamp, so MSBuild skipped the rebuild); it showed my own 9 new tests red and the other 19,549 green. I touched the file and re-ran; the run quoted above is the clean one.
3. **PowerShell and Bash here have no `dotnet` or `gh` on PATH;** I used the full paths. Not a change to anything.
4. **Commit messages** each name every bug number in full (BUG-719, BUG-720, BUG-723 and BUG-724; BUG-725, BUG-728 and BUG-729; BUG-760; BUG-764).
5. **PR bases** are `claude/rel-20261023m`. The carpark was not edited; the desk adds the status lines.
6. **Opus review:** none of these four touches reactors, Idle work, first-open work or Undo (FB-20 and FB-19 read and write nothing new in the drawing), so I did not request one. The review-window and section-admission changes in FB-19 are worth the normal train review.

## Summary

FB-16 (#1707), FB-17 (#1708), FB-19 (#1710) and FB-20 (#1709) are draft PRs on the C-62 head. Civil net10 full runs: 19,558 to 19,563 tests, 0 failed. net48 compiles clean. FB-18 skipped: its premise is wrong (no AG tag exists) and the label's copy and renumber behaviour needs Tim's word; three options and a recommendation are above. All untested in AutoCAD; real-AutoCAD steps are in this report.
