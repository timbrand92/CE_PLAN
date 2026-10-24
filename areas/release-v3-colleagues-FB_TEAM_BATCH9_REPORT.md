# Team fix batch 9: BUG-1055, BUG-1056, BUG-1057, BUG-1058, BUG-1059 (24 Oct 2026, Melbourne)

## ANSWER FIRST

Base: `origin/claude/rel-20261023m` at `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (Civil 3.0.72). Built and unit-tested only. Nobody has opened anything in AutoCAD. No bug marked FIXED.

1. **BUG-1055 (CDPIPEOBJ says 0.0 m): fixed in draft PR #1759, head `8044f6aeb96ccd938c508ad6dc693f00b68eccfa`, branch `fb/b9-BUG-1055-pipeobj-length-units`.** Cause confirmed on the base at `NativePipeObjectCommands.cs:110` (length / 1000 whatever the drawing units). The line now converts through the one drawing-units-to-millimetres helper. Message only. Tests: 5 new (do not compile on the base). Drainage net10 run in chunks by test group, every chunk 0 failed: Rules 3,525; Commands 949; ViewModels 1,934; Dialogs 1,450; Helpers 538; Models 110; Controls 111; Diagnostics 3; Learning 42; Settings 4; Core + Checks 367; Services A 160, B 1,238, C 1,822, D-H 724, I-O 1,885 (17 skipped), P-R 2,703, S 1,471, T-Z 774 (2 skipped). That is about 20,000 tests, none failed. Drainage net48 build 0 errors. No switch (wording fix, R-00).
   **Real-AutoCAD check:** (1) copy with INSUNITS 6, CDPIPEOBJ, pick 0,0 then 10,0, Enter, width 100, Single: expect "Pipe object drawn: 10.0 m, 100 mm". (2) INSUNITS 4, pick 0,0 and 10000,0: same line.
2. **BUG-1056 (CDTWL habitable-floor freeboard): skipped, needs Tim's word.** The TWL solver is protected and the carpark says Tim must choose which floor evidence CE may use. Codex FA03 skipped it for the same reason (#716 and #1082 hold unwired floor engines). Options: (a) explicit recorded floor levels with a source (recommended, the line can name its evidence); (b) a separately approved way of reading nominated floor text. Whichever, the 300 mm Frankston value belongs in a sourced Settings row and CDTWL never blocks.
3. **BUG-1057 (council speed limits): skipped, needs Tim's word.** Protected rulebook; Tim must say which bands apply and under what flow condition (Maroondah 0.75 half full or more, 1.0 below; max 5.0). Options: (a) a confirmed full-bore council band per council in Settings (recommended: preserves the stated flow condition); (b) a separate part-full check. Never one stricter global value. Overlaps #696 and #1208.
4. **BUG-1058 (Darebin 30 m pit spacing): skipped, needs Tim's word.** The 80 m office default is already editable (CEMANAGER > Settings > Civil > Civil defaults > Design Standards > Max. Pipe Run Length). Options: (a) a source-backed council interval in the council profile (recommended); (b) a named project exception. Do not change the global 80 m.
5. **BUG-1059 (Maroondah DN150 1 in 80): skipped, needs Tim's word.** Protected rulebook; Tim must confirm the 1 in 80 scope (ordinary pipe versus detention or outlet). Options: (a) a council grade by size and use looked up before the office ladder, showing both figures (recommended); (b) a named project exception. Overlaps #1208 (office ladder).

**What I did NOT test:** anything in AutoCAD; the net8.0-windows lane; the Manager tests; the council figures themselves (the PDFs were not re-fetched; all are the audit's recorded extracts). The Services A to C chunk once hit my 560 second guard with no result on a first combined run; run alone, A, B and C each passed in under 30 seconds, so I treat that as a hung test host, not a failure (I killed my own two leftover test hosts).

## Duplicate check (done before any work)
1. `gh pr list --state all --search` for BUG-1055, "Pipe object drawn", CDPIPEOBJ and NativePipeObjectCommands: no PR fixes this sentence. #507 (BUG-323/324/325) fixes the normal pipe editor and labels, not CDPIPEOBJ's sentence (Codex FA02 item 6 says the same).
2. Read `CODEX_FIXAUDIT_FA02` (RD04-05: skipped as a protected C7 command, same fix suggested) and `CODEX_FIXAUDIT_FA03` (RD05-01 to RD05-04: all four skipped). `git ls-remote origin cx4/*` shows fa01 to fa07 only; none touches these.
3. BUG-1055 was not on a protected file: `NativePipeObjectCommands.cs` is the C7 command but the change is one sentence, not geometry or the colleague gate (which is untouched).

## Housekeeping
1. Private worktree `C:\ce-fx\b9a` removed. Test runs left three untracked evidence DWG/markdown files in that worktree under `docs/evidence`; they were never committed and went with the worktree.
2. Free space on C: was 20 GB before the first build, 18 GB after.
3. Not edited: DESK_LOG.md, QUEUE.md, BUG_CARPARK.md. Shared, Installer and Settings files untouched.
