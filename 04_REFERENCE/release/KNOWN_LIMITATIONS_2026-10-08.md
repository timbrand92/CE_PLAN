# Known limitations, Thursday 8 October 2026 (Civil 3.0.34, Manager 1.1.34, Structural 1.0.104)

**Answer first.** Nothing in these versions is Tim-accepted. Codex has watched part of it work in real AutoCAD on test copies (up to its 8 Oct 02:38 run). The rest is built and unit-tested only. Never a real job yet.

---

## 1. Switched OFF in this version

1. **Level 3 engines.** The levels-proposal engine is off by default. Several Level 3 pieces (detention banner, new-level labels, profile schedule preview) are in the code with nothing calling them yet.
2. **Propose footings (CSFDNPROPOSE).** Hidden and off. Typing it prints only "Propose footings is not switched on in this version. Nothing was proposed or drawn." Codex saw that on 8 Oct; Tim has not yet accepted it.
3. **The issue-preview window.** Not in these versions. Its engine stack is queued for the next Structural train.
4. **Auto-join of pipe ends and the CE bell.** Both off by default.
5. **Others.** Older queue entries (29 Sep) say more new tools ship off (the CD cursor glow, Keep/Automatic grip drag, the notes commands such as CSGENNOTES). I did not confirm each is still off.

---

## 2. What Codex has NOT yet proven in real AutoCAD

1. **Renaming a pit to a free number, on a pit that has pipes.** The pit Codex used had no pipes, so the schedule row and the pipes' From and To were never read.
2. **Machines page of the Admin Dashboard.** CE asked to make the PC the office administrator. Codex said No, so the page was not seen.
3. **Steep-pipe wording on a flat pipe (CDFIXFLATPIPES).** The test drawing had no flat pipe, so the steep line and the Yes/No question were never shown.
4. **The footing "resized in the drawing" millimetre sentence.** It prints after you drag a footing wider with a grip or STRETCH, not after FEDIT. Nobody has tried that yet.
5. **REDO after switching drawing tabs.** It says "Nothing to redo". Seen once (7 Oct). A known limit, not a new fault.
6. **Old metre-drawing grades.** CDRULES on a metre drawing printed no R-03 lines, so "1 IN 100 not 1 IN 100000" is unproven.
7. **Pit Schedule window pit numbers.** On 7 Oct it accepted a bare "2" over P1 and lower-case "p1" with no warning (BUG-420). Not retested on 3.0.34.
8. **Edit Pipe window saving.** Codex was stopped at the "older pipe" question. A saved pipe edit and its U were not seen.
9. **Whole CDRENUMBER.** The default answer is No, so a renumber was never applied and its single U is unproven.
10. **Support block switch (STS1) on a real support block.** Only the two refusals were seen.
11. **Recall Last in New Pit.** The button was not visible on the window Codex saw.
12. **Two drawings open.** Editing text in drawing B without touching drawing A was not proven (the double-click opened Edit Pit instead).
13. **Eye check of ERASE and PIT undo.** The undo lines were seen. Nobody checked by eye that the erased or placed objects returned.
14. **CESUPPORT, CESETTINGS (Structural), BDL, beams 2, 4 and 5, the Foundations window re-link.** Not run by Codex.
15. **AutoCAD 2022 to 2024.** Built and unit-tested. Never opened.

---

## 3. What CE refuses by design

1. **Only two hard blocks, by Tim's rule.** Deleting the spine IDs, and pushing an update on a failed build. Everything else should warn and record.
2. **Locked layers, Xrefs and reference edits are never changed.** CE skips them and says so. It does not unlock.
3. **The 7 Oct source audit found places that do not follow this.** Civil Design stops on missing site inputs. Survey intake can be blocked. Slab boundary edits can be refused. A brace over 2700 mm is cut to 2700. These are open, not decided.
4. **Two places do unlock or re-layer** (see section 4, items 3 and 4).

---

## 4. Open rulings Tim has not made

1. **UPVC pipe speed limit, 3 or 6 m/s.** Edit Pipe uses 3 and Civil Design uses 6. You said "whatever the design document from creative engineering says". The office guide names no maximum speed, and the authority is not yet named. So Civil Design stays at 6, the "Confirmed" tick stays off, and the two screens can disagree on one pipe.
2. **Real Windows login and computer names in machine reports.** New report file names are hidden codes. The old real-named Civil file stays. The Manager report still holds the real login and PC name inside it. Support bundle file names still carry the PC name. Do you want the old files deleted?
3. **X-Civil import (CDIMPORTXCIVIL) unlocks locked layers** while it runs, then relocks, and erases earlier imported items first (BUG-417). Skip locked layers, or ask first? Your call.
4. **Strip-footing layer tidy-up (SF, BSF, STRIPLAYERSMERGE).** You ruled it may run quietly if done properly (INT-065). The fixed version is a draft, not in 1.0.104. Today it still re-layers across the drawing.
5. **Ruled by you, not in this version.** A brace over 2700 mm keeps its drawn length and warns. Same-day re-issue replacing the earlier set. The steepest-pipe limit exists only in the settings file (for CDFIXFLATPIPES), with no row on the Settings window.
6. **Wording you should see once.** CDFIXFLATPIPES now offers a flattened pipe held at 1 in 5 with a "steep" line, where 3.0.33 said "Check by hand" (BUG-423).

---

## 5. Acceptance

1. **Nothing is Tim-accepted yet.** Each "Codex saw it work" means a test copy, with the evidence on file. Items needing engineering judgement (council values, design rules, sizing) still need your word.
2. **The pilot on a real job has not started.**
