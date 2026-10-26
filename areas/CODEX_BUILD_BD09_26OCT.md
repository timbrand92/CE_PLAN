ANSWER FIRST — BUG-1113

1. **Status:** BUILD IN PROGRESS, 26 October 2026, Melbourne time. Only BUG-1113 is in scope. Draft PR and final branch head pending.
2. **Base:** fetched origin/claude/rel-20261025r at d8840a0920f97fedc3b94f98e56eb5a4eb6b663e. Brief head was the same. Branch cx4/bug-1113-bluefactor-same-name; own worktree C:\ce-cx\bd09.
3. **Tests:** untouched-base full Civil Release net10 suite running before edits. First attempt stopped before tests: missing CE_TRANSFORM_2027.arx. Added a zero-byte, ignored placeholder at C:\ce-cx\bd09\Modules\Shared.Transform.Native2027\bin\x64\Release\CE_TRANSFORM_2027.arx; AutoCAD 2027 is on the test process PATH. Counts, red and green lines pending.
4. **What Tim will see:** read a Blue Factor report where two townhouses both have a roof to the tank, 120 m2 and 110 m2: the tank-connected roof should show 230 m2, instead of 120 m2. Not yet proven.
5. **Not run:** AutoCAD, real report files, install or deployment. No live settings files are read or written by the new tests.
6. **Known limit:** two separate catchments with the same name, surface AND area still count once. The report repeats each catchment and gives CE no way to tell twins from repeats.
7. **Reading checks:** name-only row filtering confirmed at the fetched base. Neither named Blue Factor branch has additional changes to BlueFactorReport.cs beyond this base; both requested git log checks returned no commits. Garden and lawn reading will stay unchanged.
8. **Safety:** this change reads report text and writes nothing to a drawing. Redo safety (no writes between U and REDO), locked layers, Xrefs and REFEDIT protection are unaffected. No protected file or CE_SHARED will be edited. C: had 51,260,358,656 bytes free at setup.
9. **Undo:** revert this branch's BUG-1113 commits; no installed file has changed.