# C-79b1 area test plan and sizing (CE 02, Sun 1 Nov 2026, from CE 01's PR list TRAIN_C79B_PR_LISTS_2026-11-01.md)

## ANSWER FIRST

1. **Sizing: about 42 to 45 case-runs, about 1.7 hours of robot time at 26 an hour. That is UNDER the 60-run line, so no question for Tim on size.**
2. **No question for Tim on protection either.** None of the 18 PRs changes how locked layers, Xrefs or REFEDIT are handled: #1891 only reads a layer's locked flag and refuses to draw on it, #1940 keeps its copy inside the drawing's own dictionary, and the three PRs in the two protected persistence files (#1892, #1952, #1970) write only CE's own records. The finalizer still reads every write path, as CE 01 says.
3. **One new fixture serves seven PRs: a drawing whose saved CE record is damaged on purpose.** It serves #1892, #1940, #1943, #1952, #1958, #1970 and part of #1953. It is one Team builder job. Without it only about 4 of the PRs can be proved by the robot.
4. **Robot-provable: 11 PRs** (a case, a broken twin, two starts of the case and one of the twin = 3 runs each = 33 runs). **Codex look: 6 PRs.** **Nothing to run: 1 PR** (#1922, test projects only).
5. **Smoke: about 10 runs** (N91 always, the record and Undo cases, one case per shared file).

## Per PR (merge order from CE 01)

1. **#1922 (BUG-1257, test projects only): no case.** The check is the settings fingerprints before and after the run (my standing 30-minute check) plus the finalizer's statement that no shipped DLL behaviour changes. 0 runs.
2. **#1868 (large-pipe minimum fall): ROBOT.** SETTING line types a 1-in-N figure for 450 mm and larger pipes; draw a 450 mm pipe flatter than it and read the warning; the twin leaves the figure empty (must show no warning). 3 runs. Needs the exact figure and wording from the PR (writer reads them from the code, never from memory).
3. **#1891 (copied downpipe gets its own next tag, no label on a locked layer): ROBOT.** Copy a placed downpipe, read the new tag (DP2 after DP1); lock the label layer, copy again, read that no label was drawn and one line names the layer. Twin: switch OFF. 3 runs.
4. **#1892 (one unreadable pit or pipe record no longer stops CE remembering every pit's links): ROBOT with the damaged-record fixture.** 3 runs.
5. **#1940 (damaged outlet roles: one warning, kept copy, Apply carries on): ROBOT with the fixture.** Reads the warning line and that the copy (a hidden record inside the drawing's own CE dictionary) exists; U removes it. 3 runs.
6. **#1943 (unreadable LPD record gives one warning): ROBOT with the fixture.** 3 runs.
7. **#1945 (CDDESIGN warns once when approved outlets were approved under another file path): ROBOT.** Fixed in the re-check (SameDatabase). 3 runs. Tim's open wording question stays open; the case asserts the shipped words.
8. **#1950 (refused twin detention pipe upgrade puts the main line back): ROBOT only if an older twin detention pipe drawing exists; otherwise CODEX LOOK.** I will ask the writer to check the corpus first. 3 runs or 0.
9. **#1952 (Undo lifts the 'cannot save over an unreadable record' hold; PROTECTED FILE): ROBOT with the fixture.** Damage the record, U, then make a CE change and check it saves; REDO puts the hold back. 3 runs. The U/REDO steps are driven and judged, so the case must close every prompt.
10. **#1880, #1951 (Inspector and CDCHECK read the saved drawing record when none is loaded; one shared rule): CODEX LOOK.** The Inspector is a palette; the robot reads a pit's pipe list badly (R19 run B5). One look covers both.
11. **#1953 (Inspector shows the newer kept list when a save failed), #1955 (Undo in drawing A after a pick in drawing B): CODEX LOOK.** Both need two open drawings and a failed save; the robot cannot hold a second drawing steady. One look covers both.
12. **#1958 (an unreadable saved list is logged once per drawing): ROBOT with the fixture.** Pick three pits, count the log lines (1, not 3). 3 runs.
13. **#1969 (Edit Pipe stores a typed level with a full stop on a comma-decimal PC): CODEX LOOK, or Tim's other PC.** The test needs the Windows regional decimal set to a comma; the robot must not change Tim's regional settings. Unit tests carry the rest.
14. **#1970 (Edit Pipe says so when it could not write the level onto the pipe): ROBOT.** Needs a pipe the write fails on (the fixture's damaged pipe, or a locked layer: read the PR for the trigger). 3 runs.
15. **#1972 (Edit Pipe's downstream question comes after the change is accepted): ROBOT.** Modelled on R11 and R17 (Edit Pipe cascade). NOTE: Opus found CHANGE-NEEDED; the case must be written against the head AFTER CE 05's fix commit. 3 runs.
16. **#1923 (double-click on a pit label stops AutoCAD's attribute editor first): CODEX LOOK now; the robot twin pair N42c style later.** Only if its shipped default is OFF (Tim 22 Oct); if ON it is not merged. 0 runs now.

## Totals

1. **Robot cases: 11** (#1868, #1891, #1892, #1940, #1943, #1945, #1950?, #1952, #1958, #1970, #1972) = 33 runs (30 if #1950 goes to a Codex look).
2. **Smoke: about 10 runs.** N91 (always), the record and Undo cases R19/R24 style, N40 (Pit Schedule) and one case per shared file named by TRAIN_C79A_CHANGED_FILES.txt style mapping (LinkService.cs, ProjectDataService.cs, PipeEditCommand.Update.cs, InspectorPaletteService.cs).
3. **Codex look list: 6 PRs** in about 3 looks: (#1880, #1951), (#1953, #1955), #1969, #1923. #1950 maybe.
4. **Total: about 42 to 45 case-runs, about 1.7 hours.** Robot time is not the limit.

## What has to be built first (the real work)

1. **The damaged-record fixture** (1 Team builder job, a Sonnet job with an Opus read): a copy of DRV1_B1 whose CE pit-and-pipe record, outlet-roles record and LPD record are each damaged in a way the code reads as 'unreadable' (the PRs' own unit tests show the byte shapes). Made-up drawing only.
2. **Case writing: two Team Opus writer jobs** (5 to 6 bugs each), then ONE Opus paper review of all of them, as in wave 1. Case files must use Civil's 1-in-100 setups, hidden writers, the Esc and close rules from the wave 1 brief.
3. **Timing:** C-79b1 installs Wed 4 Nov evening. The cases must be READY by Wed 4 Nov 17:30; pass a and b run on the C-79b1 build after install (about 1.7 hours), so the writer jobs should start by Mon 2 Nov, after wave 1's writers.

## What I need from others

1. **CE 01 or the finalizer:** the final head of each PR (the cases are written against the heads in the PR list; #1972 and #1923 will move).
2. **CE 00:** a GO for the fixture builder job and the two writer jobs (the Team meter allows it; wave 1 used 12 writers and 3 reviewers).
3. **Tim:** nothing now. His wording questions (#1945 folder-path comparison) stay in QUESTIONS_FOR_MONDAY.
