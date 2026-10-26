# Codex burn briefs, round 2, Mon 26 Oct 2026 night (written about 21:55 Melbourne by the Team desk, Sonnet)

## FOR TIM

1. **Twenty more Codex briefs are written and queued: ten second-opinion reviews (cx_rv19 to cx_rv28) and ten small bug fixes (cx_bd21 to cx_bd30).** Nothing was run. No AutoCAD, no Codex, no build, no install, none of your settings files touched.
2. **The reviews are cheap and read-only.** Each one makes Codex an independent reader of one to three draft PRs (the six Structural PRs going into train S-45, the BUG-861 diagnostic PR, the ArchUnitNET baseline, and the eleven Civil/Manager PRs in train C-69). Each says plainly whether Codex disagrees with the Opus verdict, and why. Cost 2 each, 20 in total.
3. **The fixes are one real bug each,** all on the newest Civil/Manager release branch, each with a test that fails first, a switch that starts ON, a log entry and a draft PR that is never merged. Cost 8 each, 80 in total.
4. **Cost against the burn.** Reviews 20 plus fixes 80 is 100. Codex was at 36 percent with the cap at 97, so about 61 points fit. Reviews run first, so all ten reviews and about seven fixes fit; the last fixes will wait on the queue's own cap check unless the weekly reset lands first. Round 1's six fixes (cx_bd15 to cx_bd20) are still ahead of these in the file, so they run before the reviews: tell me if you would rather the reviews went first.
5. **What I need from you: nothing.** No engineering number is chosen in any brief. One soft spot: BUG-1098 (Kingston tank credit) and BUG-1095 (council minimum runoff coefficient) change a design figure, but both use values already stored for the council and both stop with BLOCKED if the stored value is marked as not yet sourced.

---

## THE REVIEWS (filler queue, model gpt-6-astra, high, cost 2)

All write `C:\CE_PLAN\areas\CODEX_PR_REVIEW_<name>.md` with an answer-first block, verdict MERGE / MERGE-WITH-FIXES / HOLD / REJECT per PR with exact fixes, and an "agrees / disagrees with Opus" line. They read the live head with gh and change nothing on GitHub.

1. **cx_rv19: S-45 #1792 and #1793.** FADOPT raft EB label question and the unknown pad size (not invented). The two PRs clash in three files; Codex says how a merge resolves and whether either switch changes an existing drawing.
2. **cx_rv20: S-45 #1794 and #1795.** MarkupAI switch and Share learning data (privacy default OFF), and the one-line Structural start-up. Codex checks Cancel, Escape and U, and what an old settings file does.
3. **cx_rv21: S-45 #1796 and #1797.** Wording-only PRs. Codex proves from the diff that no value or condition changed and lists every changed string.
4. **cx_rv22: #1798 and the ArchUnitNET baseline.** The BUG-861 REDO diagnostic switches (must change nothing while OFF) and, because the TOOL-ARCH-01 adoption PR does not exist yet, the trial PR #1780 checked against your 26 Oct ruling. If the adoption PR appears before it runs, Codex reviews that instead.
5. **cx_rv23: C-69 #1781, #1782, #1783.** Metre drawing pipe lengths 1000 times short (Codex recomputes the 275 mm example), the CDREPAIR line on paste, and the printed sheet colour.
6. **cx_rv24: C-69 #1784 and #1785.** One pipe-speed limit everywhere (looks for a missed caller) and the pit drop box.
7. **cx_rv25: C-69 #1787 and #1786.** Detention orifice and gravity (recomputes the 0.025 percent claim), and the slab minimum falls on Settings.
8. **cx_rv26: C-69 #1790 and #1789.** CDDESIGN connection pipe assumption and the WSUD and Charged system starting figures (every old and new default compared).
9. **cx_rv27: C-69 #1791 plus the whole train.** Strip drain and reach distances on Settings, then a check that all eleven C-69 PRs merge in order without a clash the list does not already name.
10. **cx_rv28: C-69 #1788.** The privacy PR (Manager uploading the plugins' own outbox). Read twice: exactly what leaves the PC, whether the scrub works, whether anything needs your word before it is ever switched on.

## THE FIXES (filler queue, model gpt-6.1-sol, high, cost 8)

Each brief copies the carpark entry in, adds notes, and says: stop with ALREADY-COVERED if an open PR now fixes it, BLOCKED if it needs a number from you or a protected file.

1. **cx_bd21: BUG-1095.** The council minimum runoff coefficient is never applied (Darebin 0.80 floor: a 600 m2 lot comes out 0.70). Alternate if covered: BUG-1217.
2. **cx_bd22: BUG-1053.** LandXML cover and invert levels in millimetres are not converted to metres (cover 100200 shown as 100200 m).
3. **cx_bd23: BUG-1102.** CDWT gives no warning when an above-ground detention tank breaks a council's underground rule (Banyule 100 percent). Warning only; the default answer is not changed.
4. **cx_bd24: BUG-1104.** No warning for a tank orifice below the council minimum (Manningham 25 mm). Warning only; the rule itself is not built.
5. **cx_bd25: BUG-1201.** Pressing Escape at the first CDSL point still leaves a SPOT LEVEL block in the drawing.
6. **cx_bd26: BUG-1107.** The Inspector always says "No outlet registered" for a raingarden, even when its pipe goes to a pit.
7. **cx_bd27: BUG-1110.** CDDESIGN warns about council values it never used, and a council's own published soft-ground C never wins.
8. **cx_bd28: BUG-1216.** CDHELP opens the previous command's page after CDRAINFALL, CDDESIGN, CDCHECKS or CDRUNSOLVE.
9. **cx_bd29: BUG-1098.** Kingston tank credit uses the wrong rule and over-credits big tanks (6,000 L credits 1.50 m3, council says 1.00). Latent today because BUG-1096 means the credit does not yet reach a real job; the brief says so.
10. **cx_bd30: BUG-1044.** Two stage drawings that both have pit P1 give an empty Pit Schedule; the fix lists the other pits and names the clash.

## WHY THESE TEN, AND WHAT WAS LEFT OUT

1. **Left out because they need your word:** BUG-1088 and BUG-1091 (preferred grade and DN450-plus ladder), BUG-1099 (council discharge figure), BUG-901, 902, 907, 908.
2. **Left out because of a protected file:** BUG-1222 (Edit Pipe), BUG-1141, 1148, 1161, 1209, 1195 (placement and link code).
3. **Left out because they add a refusal:** BUG-1144 (Apply would refuse on a damaged record); you allow only two hard blocks.
4. **Left out because they need a window:** BUG-1096 and BUG-1100 (reuse credit box in CDDESIGN) belong to the window lane.
5. **Weakest choices:** BUG-1216 and BUG-1201 are lower impact (help page, a stray block) but are real and quick; BUG-1098 is correct but latent.

## WHAT I DID NOT CHECK (RULES 5.9)

1. **No brief was run.** Each build's cause is taken from the carpark entry's file and line numbers; I did not open the code. A wrong cause makes Codex write BLOCKED, which costs the 8 points.
2. **Open-PR coverage** was checked against the text of the newest 1,500 open PRs and the cx_bd01 to cx_bd20 briefs. A PR that fixes a bug without naming its number would be missed; each brief tells Codex to search again at start.
3. **The ArchUnitNET adoption PR did not exist** (only trial #1780) when I looked.
4. **Heads for the C-69 PRs** are not repeated in the review briefs; Codex reads the live head and compares with the list file.

## FILES

1. **Briefs:** `C:\Lisp Files\_CODEX_RUNNER\cx_rv19.txt` to `cx_rv28.txt` and `cx_bd21.txt` to `cx_bd30.txt`.
2. **Queue lines:** appended to `C:\CE_PLAN\desk_jobs\FILLER_QUEUE.txt` after each file existed (reviews, then builds).
3. **Scratch (throwaway, not a build script):** `C:\ce-fx\burn2_briefs\gen.ps1`.
