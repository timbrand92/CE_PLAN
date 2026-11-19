One-job release | Part 1 of 9: Drawing safety (copy, move, erase, undo) | Built 2, Checked 2, Installed 0, Accepted 0 (of 9)  
Now: The night test can discard unsaved work, and Detention can pass a design with no route to the legal point.

**Counts across all nine parts.** 389 entries survived review. A fault can appear in several parts. A further 125 await checking (514 entries in all). The five figures are **wrong figure / unsafe edit / ruling not built / screen rule / missing test**, in that order.

1. **Drawing safety — 40** (2 / 24 / 4 / 0 / 10)
2. **Pit and Pipe — 101** (23 / 17 / 27 / 20 / 14)
3. **Cover and grade — 40** (23 / 1 / 5 / 7 / 4)
4. **Inlets — 17** (6 / 2 / 6 / 1 / 2)
5. **Legal point and end symbols — 36** (4 / 14 / 9 / 5 / 4)
6. **Pit schedule — 32** (8 / 3 / 6 / 10 / 5)
7. **Job and Unfinished — 42** (12 / 2 / 17 / 4 / 7)
8. **Detention — 46** (18 / 0 / 16 / 8 / 4)
9. **Night tests and handover — 35** (2 / 7 / 7 / 0 / 19)
10. **All parts — 389** (98 / 70 / 97 / 55 / 69)

**Ten most serious findings from the source and bench reviews of `2ce8070`**

1. **Part 9 · Unsaved drawing.** If another AutoCAD session becomes active, the night test can close its drawing without saving. The review recorded no loss. D-116, D-160. [acad_close.ps1:4](../../../CE_CIVIL/acad/night_scripts/acad_close.ps1#L4)
2. **Part 9 · Licence warning.** The night test can try to close AutoCAD when a sign-in or licence warning appears, then force it closed. Rule 1.9, D-121, D-160. [ce_pass.ps1:60](../../../CE_CIVIL/acad/night_scripts/ce_pass.ps1#L60)
3. **Part 1 · Protected pipe.** Moving a pit shifted a pipe end 1,000 mm on a locked layer. The same move affected referenced work. D-216. [EndOfCommand.cs:270](../../../CE_CIVIL/src/CeCivil.Hands/EndOfCommand.cs#L270)
4. **Parts 5 and 8 · Disconnected storage.** Counting an isolated pit raised storage from 1.44 to 1.48 m³ and passed a 1.46 m³ requirement. D-176, D-343. [sums.csv:66](../../../CE_CIVIL/src/CeCivil.Brain/data/sums.csv#L66)
5. **Part 8 · Council limits.** Both Monash checks showed “Suits” with a 64 mm hole against a 65 mm minimum and 41.26% underground storage against a 60% minimum. D-327. [detention.csv:137](../../../CE_CIVIL/bench/CeCivil.Bench.Core/windows/detention.csv#L137)
6. **Parts 5 and 8 · Discharge.** A site with no pit, pipe or outlet still passed at 5.84 L/s. D-176. [sums.csv:159](../../../CE_CIVIL/src/CeCivil.Brain/data/sums.csv#L159)
7. **Parts 1 and 2 · Failed edit.** When the second pipe refused a move, the first stayed 1,000 mm out of place. The recovery message can say the drawing was restored. D-216, D-256. [EndOfCommand.cs:275](../../../CE_CIVIL/src/CeCivil.Hands/EndOfCommand.cs#L275)
8. **Parts 4 and 6 · Wrong inlet level.** Removing a pipe put its held RL 6.66 m against a downpipe whose level was RL 5.32 m in the schedule preview. D-103, D-113. [ScheduleModel.cs:433](../../../CE_CIVIL/bench/CeCivil.Bench.Core/ScheduleModel.cs#L433)
9. **Part 3 · Shallow pipe.** Rounding the invert gave “Suits” at 291.67 mm cover. The 300 mm minimum with 5 mm tolerance requires at least 295 mm. D-318, D-321. [Fact.cs:54](../../../CE_CIVIL/src/CeCivil.Brain/Facts/Fact.cs#L54)
10. **Parts 4, 6, 7 and 8 · Missing drawing commands.** The plug-in offers no drawing command for Inlet, Pit schedule, Job, Unfinished or Detention. The schedule stops at a preview. D-310, D-311, D-338. [Commands.cs:7](../../../CE_CIVIL/src/CeCivil.Acad/Commands.cs#L7)

**Disproved and dropped.** At least three claims were dropped. The nine lists identify one cover example and two schedule claims, and give no complete tally. [Part 3](BY_PART/part_3.md#L160) · [Part 6](BY_PART/part_6.md#L160)
