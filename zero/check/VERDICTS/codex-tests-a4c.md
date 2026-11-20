# Answer: the office blocks test list (A4c: the blocks the Stage 1 tools place), codex/tests-a4c at 1ebb640

**Answer: HOLD THE LIST. Eight reasons.** Written Fri 20 Nov 2026, about 5:20 pm, by the check room. Checked on the bench only. First answer on this list as restated to D-404; it counts as round one from the D-416 baseline.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\a4c_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\a4c_adv_REPORT.md`, proofs in `a4c_adv_proofs\` (a cheat turned all 687 pretend-drawing tests green on a product that doubles the plastic pit's scale and whose real drawing code puts a plain circle where the office bend opening goes). They agree; graded here.

## 1. Counts seen (the writer's counts are true)

The whole solution builds, the AutoCAD plug-in project included. Pretend drawing 687: this list 16 cases: 13 targets fail, 3 pass (the control, and two cases marked target that already pass today); 674 older pass. Brain 750, bench 438 (one known on-screen flake passed alone). Saved-drawing reader: 19 pass, 7 WAITING, skipped with reasons (they need the 18 supplied drawings and one saved test drawing, which are not in the repository yet). Only tests changed. Every target fails because the tool places the wrong thing or nothing.

## 2. What is right

The four Stage 1 block names, the attribute PIT_LABEL, the pit's states and the 450 and 350 sizes match D-404, D-390 and D-228. The stand-in circle at a bend and the missing flow arrow are caught. The control really compares the drawing's own PIT BLOCK 3 before and after. The earlier check-room findings on main (the tag never used; a definitions-only file cannot supply the first pit) each have a target. The older tests that drew a stand-in circle were rightly changed.

## 3. Reasons to hold

1. **The privacy scan of the shipped drawings was deleted, and the 18 copies are tied to nothing.** `tests/CeCivil.DwgRead.Tests/ShippedBlocksFileTests.cs`: the test that opened the shipped file and looked for anything naming a job is gone (the scanner now runs only on made-up drawings, lines 273-316). Eighteen readable BLANK drawings under invented names passed the count, open and package-copy checks (lines 58-70, 93-110). Hard limit: no client names in any file. Put the scan back as a waiting check over each real copy; record the 18 approved names and fingerprints when the copies are taken and test against that record; the build folder holds exactly those 18 and no other block drawing.
2. **A numbered pit can go in without the office circle tag.** `tests/CeCivil.Hands.Tests/OfficeTemplateTests.cs:146` (older, left as it was in a file this list edited) demands a pit placed with "Number on plan" ticked and no tag block, and never looks at how the number is drawn; the new target at `OfficeBlocksA4cTests.cs:86` demands the opposite for another path. Both passed together on the cheat. D-398: always the office circle tag. The two must agree, and both refuse a plain-text number (question 1).
3. **Nothing ties the tool to the 18 copies, and his own block can be replaced.** The one source is still the data line `office_blocks_file = office_blocks.dwg` (`src/CeCivil.Brain/data/tools.csv:55`), and `tools.csv:411` still says PIT LABEL. A product that took the wrong source and REPLACED the drawing's own block compiled and passed everything; "never overwritten" is tested for PIT BLOCK 3 only, and the pretend drawing can never replace a block (`Fake/FakeDrawing.cs:110-118`). For each of the four blocks: a bare plan, a plan with the same block, and one with his own hand-changed block, against supplied, template and master specimens that differ; compare the old inserts, the definition and the next insert.
4. **The right name with the wrong thing inside passes.** A five-line change to the real drawing code draws a 365 mm circle for the bend opening: it compiled and all 687 tests passed (`OfficeBlocksA4cTests.cs:226-238` checks a name and a point through the pretend drawing). The reader accepted a 2 mm circle as TIM_CVL_ARROW (`ShippedBlocksFileTests.cs:138, 153-166`) and never looks at the opening's mask (`:144`). D-396, D-400: office artwork intact.
5. **No placement target reads the layer, the scale or the arrow's direction** (`OfficeBlocksA4cTests.cs:36, 75-79, 219, 237`). A plastic pit at scale 2 passed; the data scales the tag by the dimension scale (`tools.csv:401, 415`); an arrow at the drawing origin, on layer 0, never turning with the flow, passed. D-400: scale 1 always; D-414: the layers; D-370: the arrow points with the flow.
6. **The flow arrow is required OFF in the window by an older test** (`PipeWindowFromDrawingTests.cs:147-162`: tick hidden, unticked, value zero) while the new target hands one in around the window (`OfficeBlocksA4cTests.cs:210, 256-264`). D-369: every pipe, on by default. Drive it through the real window, on two pipes flowing opposite ways, away from the origin.
7. **A plastic pit's size and kind.** The test itself types 350 after choosing Plastic (`:60-80, 298-304`): choosing Plastic alone tried 450 by 450 and drew nothing (D-390: Plastic sets 350 by 350). A plastic pit stretched to 450 stayed Plastic (D-402: it becomes Junction).
8. **Older pits are read only after the test marks them as the new tool's.** `OfficeBlocksA4cTests.cs:188-203` (and `PitBlock3Tests.cs:395-405`) attach the new tool's note before reading; the three older inserts as an old drawing really holds them (Stormwater Pit, PIT BLOCK, PIT BLOCK 2, no note) all read as no pit. D-404: older drawings stay readable.

## 4. To fix in the same round

1. **Take `TESTS_REPORT.md` off the branch** (it describes the first round: nine cases, the old tag, one combined drawing).
2. **Two cases marked target already pass today** (the cover reading "CL 5.75"; reading "Stormwater Pit"): relabel them controls. The cover's words and mask belong to the labels list.
3. **The waiting checks must not look like a pass:** an empty input folder gives seven skips and a green run; the release gate must depend on the six real results. "Exactly one definition across the 18" (`ShippedBlocksFileTests.cs:153-157`) may refuse a real set: look at the copies first.
4. **In the copies:** PIT BLOCK 3's stretch controls X_WIDTH and Y_WIDTH; the opening's mask; the 18 drawings getting past the repository's `*.dwg` ignore rule.
5. **Cancel after a block was brought in leaves nothing behind;** the bring-in and the pit are one Undo; a run of pipes gets one arrow each.
6. **One test host.** This list, the units list and A6 each carry their own copy of `Fake/CommandHost.cs` (this one has no Undo record, no read-only or layout state): one host, owned by one job, before any of them merges.

## 5. For the control room

1. **The circle tag cannot be found and "Number on plan" is ticked:** refuse the pit and draw nothing, naming the block (recommended), or draw the pit with no number and say so?
2. **A pipe with a bend when the inspection opening cannot be found:** refuse the pipe (recommended), or draw it without its opening and say so? The target takes either.
3. **Where layers, the text style and linetypes come from on a bare drawing:** D-381 said the tool's own copy of the office set-up; D-404 makes the 18 old block drawings the source of blocks, and they may not hold STORMWATER, 25TEXT or the linetypes. From the 18 where one holds it, or one more set-up drawing shipped beside them?
4. **One block found in two of the 18 copies with different contents:** which does a bare drawing use?

## 6. Owed in AutoCAD (when the copies are in and a build is merged)

Each of the four blocks placed on a bare plan and read back (name, state, layer, scale 1, Z 0, ByLayer, the tag's attribute, the opening's mask); a plan holding his own changed block of each name, unchanged after a placement; a plotted bend with its mask; Cancel and one Undo after a block was brought in; the three older pit blocks opened and read.
