1. **ANSWER FIRST — HIGH: 2 | MEDIUM: 2 | LOW: 0.** The most important finding is a false minimum-grade pass: CE checks the straight distance between pits instead of the pipe's drawn route. A pipe with a real grade near 1:300 can be reported as passing at 1:100. The other findings are a renumbering crash path, numbering the wrong branch first, and pipe-size advice that worsens the velocity warning.

2. **What this means for Tim.** These are four separate faults in code reached by actual Civil commands. All are **verified-by-reading**; none is claimed as reproduced in AutoCAD. The checks below are instructions for a later AutoCAD pass, not tests run during this hunt.

---

1. **Scope and evidence.** Independent CODE SWEEP S08, Civil Rules slice 2 of 2, 23 October 2026, Melbourne date. Read all **113 of 113** files listed in the brief, beginning with the largest central files, using `git show origin/claude/rel-20261022m:<path>`. The fetched ref resolved to `40ee0a36f7960145743954b39859eb6c3af92869` (installed Civil 3.0.70 / Manager 1.1.70). All source locations below refer to that commit; paths are relative to `CE_ACAD_PLUGIN`. Additional callers were read at the same ref. Structural was outside this slice.

   Read the previous findings before this sweep: `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`, and `CODEX_AUDIT_STRUCTURAL_22OCT.md`. Their findings are not repeated here. Suspected issues without a sufficient caller trace were excluded. No source changes, builds, tests, AutoCAD launch, installation or sub-agents were used. Only this findings file is authored by this hunt.

2. **S08-01 — HIGH — A bent pipe can receive a false minimum-grade pass. Verified-by-reading.**

   **Location:** `Modules/Drainage/Rules/RulebookEngine.cs:77`, `:89`, `:349`, `:356`; supporting implementation `Modules/Drainage/Services/PipeGeometryHelper.cs:128`, `:156`.

   **What happens in AutoCAD:** A drafter checks a pipe which goes around an obstruction. CE measures directly between the pits, making the pipe look shorter and steeper. The minimum-grade result can say **pass** even though the actual run is too flat. The same wrong length also feeds the velocity and detention-run checks.

   **Exact failure scenario:** Two pits have centres 10.000 m apart at the same drawing Z. Their connected DN150 gravity pipe has a bent plan route approximately 30 m long, with current upstream IL 10.200 m and downstream IL 10.100 m. Both ends are confirmed, with current diameter and invert evidence. The Settings ladder for DN150 is 1:100 and the drafting warning is no stricter than 1:100. CE calculates `10 / 0.100 = 100`; the drawn route gives approximately `30 / 0.100 = 300`. Ordinary wall trimming does not close this threefold difference.

   **Why the caller does not protect it:** `Commands/RulesCommand.cs:80` reads the live snapshot and `:90` evaluates it. `Services/ProjectDataService.RulebookDrawing.cs:181` refreshes pit positions, while `:185` onwards records pipe vertices as observed evidence. The engine still receives its calculation length from the pit-to-pit helper. That helper takes the square root of the squared coordinate differences; it never reads pipe vertices or arc lengths. `Rules/RulebookDrawingSnapshot.cs:108` only downgrades a pass for an unconfirmed end. The fixture has confirmed ends.

   **DETERMINISTIC TEST — fixture and typed steps:** Use a synthetic Model-space DWG in millimetres, with P10 at (0, 0, 0) and P11 at (10000, 0, 0). A single tracked gravity pipe runs from P10 towards (0, 10000), across towards (10000, 10000), then back to P11; use normal pit-wall trimming and record its actual polyline length. There are no intermediate pits, breaks or detention overrides. Set the levels, diameter and Settings values above. Confirm both ends with `CDCHECK` if necessary. Type `CDRULES`, then `All`.

   **Assertion:** In the P10-to-P11 R-03 command-line result, the current code produces `pass` and `actual 1:100, ladder minimum 1:100`. Compare that with the measured route length divided by 0.100 m: it is near 1:300 and must produce a warning. On the net10 lane, `CDRULES` → `Source` also exposes the retained `Pipe length m` value of 10, instead of the drawn run length. A correction must use the proved route length, or report Unknown when that length cannot be established.

3. **S08-02 — HIGH — Renumbering a network with a reachable loop can exhaust AutoCAD's stack before the preview. Verified-by-reading.**

   **Location:** `Modules/Drainage/Rules/PitRenumberPlanner.cs:91`, `:99`, `:103`, `:142`; admission path `Modules/Drainage/Rules/PitRenumberNetworkBuilder.cs:102`, `:129`, `:163`.

   **What happens in AutoCAD:** A loop in the recorded network can bring down the AutoCAD process when the drafter asks to renumber pits. The fault occurs before the Apply question, so choosing not to apply cannot protect the session.

   **Exact failure scenario:** Use unique pit marks P10, P11, P12 and P13. Recorded pipe directions are P11→P12, P12→P11, P12→P10, P13→P10 and P10→LPD, with LPD not a pit record. The two opposite connections may be separate gravity/rising-main runs or a bad legacy connection; the builder does not filter by pipe type. P10 is the sole outlet candidate and has **two** upstream children. This last condition makes the sorting operation evaluate its length keys, including the loop through P12 and P11.

   **Proof:** The builder accepts these rows and returns a renumberable network. `Commands/PitRenumberCommand.cs:69` calls the planner without a cycle check. Sorting P10's children calls `LongestUpstreamPathLength(P12)`, then P11, then P12 indefinitely. The cache entry is written only after recursion returns. The separate `visited` set at planner line 120 protects the later walk, not this recursive calculation. A stack overflow is therefore reached before the preview at command line 80. This is a code-proven crash path, not an observed crash from this hunt.

   **DETERMINISTIC TEST — fixture and typed steps:** In a disposable AutoCAD session, open a synthetic saved DWG containing those four tracked pits and five pipe rows, with unique valid handles, finite positions, unlocked layers and the exact From/To directions above. Use millimetres and Model space. Type `CDRENUMBER`.

   **Assertion:** AutoCAD must remain open and return usable command-line text: a finite preview or a plain explanation identifying the loop. The faulty path never reaches `Renumber downhill to uphill:` or `Apply? [Yes/No]`; it recurses until stack exhaustion, potentially terminating the AutoCAD window. Do not exercise this fixture in a session holding unsaved work. The repair should handle/report the loop without adding an engineering hard block.

4. **S08-03 — MEDIUM — Renumbering can choose the shorter branch as the main line. Verified-by-reading.**

   **Location:** `Modules/Drainage/Rules/PitRenumberPlanner.cs:139`–`:143`, especially `:142`.

   **What happens in AutoCAD:** The command promises to number the longest main line first, then its branches. It can instead give the main-line numbers to a much shorter branch, leaving the long run to be numbered afterwards.

   **Exact failure scenario:** P10 is the outlet pit. P11 connects directly to P10 over 100 m. P12 connects to P10 over 10 m, and P13 connects to P12 over another 10 m. P10 also has an outlet pipe to an external LPD. The true upstream choices from P10 are 100 m and 20 m.

   **Proof:** The sort compares only `LongestUpstreamPathLength(edge.UpstreamPitHandle)`. It omits the edge joining that child to the current pit. P11 therefore scores zero, while P12 scores 10 m, and P12 wins. The builder already supplies the omitted lengths at `PitRenumberNetworkBuilder.cs:121`–`:129`. This is not a tie or a handle-order issue. The preview is published by `Commands/PitRenumberCommand.cs:80`–`:85` and the accepted changes go to the apply service at `:104`.

   **DETERMINISTIC TEST — fixture and typed steps:** Use a synthetic millimetre Model-space DWG with pit centres P10=(0,0), P11=(100000,0), P12=(0,10000), P13=(0,20000), all at Z=0. Record straight pipes P11→P10, P12→P10, P13→P12 and P10→LPD, with unique handles and no other pits. Type `CDRENUMBER`; inspect the preview, then answer `No`.

   **Assertion:** The current preview is P10→P1, P12→P2, P13→P3, P11→P4. The promised longest-main-line ordering is P10→P1, P11→P2, P12→P3, P13→P4. The preview alone proves the wrong decision; no drawing edit is required.

5. **S08-04 — MEDIUM — The velocity warning recommends changing pipe size in the wrong direction. Verified-by-reading.**

   **Location:** `Modules/Drainage/Rules/RuleFixAdvisor.cs:81` and `:86`.

   **What happens in AutoCAD:** For excessive full-pipe speed, CE tells the drafter to increase the pipe size. For insufficient self-cleansing speed, it says to reduce the size. At unchanged grade and material, both size changes worsen the very full-pipe speed result CE is checking.

   **Exact failure scenario:** A DN150 gravity pipe at 1:1000, with Manning n=0.011 and a Settings minimum velocity of 0.60 m/s, gives approximately 0.32 m/s. CE recommends reducing its size. DN100 at the same grade and roughness gives approximately 0.25 m/s, further below the minimum. Conversely, DN150 at 1:10 gives approximately 3.22 m/s; increasing it to DN225 raises this to approximately 4.22 m/s. With a fixture scour cap of 3.00 m/s, the recommendation worsens that warning too.

   **Proof:** `RulebookEngine.cs:415` calculates the full-bore velocity and `:431` / `:438` select the warnings. `Services/DesignValidationService.cs:141`–`:148` uses `v = (1/n) × (D/4)^(2/3) × sqrt(1/N)`. At fixed grade and n, speed increases with diameter. `Commands/RulesCommand.cs:100`–`:101` prints the advisor's words; `Rules/RuleExplainer.cs:27`–`:37` also presents them as a fix. This finding is about CE's own full-bore calculation, not a separate fixed-discharge or partially full analysis.

   **DETERMINISTIC TEST — fixture and typed steps:** Use two synthetic, straight, fully connected tracked gravity pipes with pit centres 10 m apart: P20→P21 at IL 10.010→10.000 m, and P22→P23 at IL 11.000→10.000 m. Both are DN150 with the same current material evidence. In Settings, give that material n=0.011 and a 3.00 m/s scour cap, and set the minimum velocity to 0.60 m/s. These are test inputs, not proposed office defaults. Type `CDRULES`, then `Explain`.

   **Assertion:** P20→P21's R-02 explanation contains `Steepen the grade or reduce the pipe size`, and P22→P23's R-01 explanation contains `Flatten the grade or increase the pipe size`. Those diameter alternatives must not be offered as remedies for this calculation. For a follow-up, use `CDEDIT` to change only the first diameter to 100 mm and the second to 225 mm, preserve both pairs of levels, and rerun: the reported speeds move to about 0.25 and 4.22 m/s, respectively.

6. **Summary.** All 113 requested files were read at the installed Civil ref. Four new faults are supported by production caller traces: a false grade pass, a renumbering stack-overflow path, wrong main-branch ordering and reversed diameter advice. Each has a synthetic AutoCAD reproduction and an observable assertion. No tests were run and no code was changed. These findings need correction and native verification before the Civil and Manager colleague release; Manager administrator work remains parked.
