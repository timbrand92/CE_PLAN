# release-v3-colleagues TEAM LANE 4 log (build/04)

One line per job: time (Melbourne), item, PR, state, usage.

- Sun 04 Oct 01:27 AEST: build/04 headless run 1 started. Job: BUG-385 (Pit Schedule Revert Row Override drops the row on drawing-only pit P11). Base origin/claude/rel-20261015d. Usage: not readable headless (no /usage in -p mode).
- Sun 04 Oct 01:37 AEST: BUG-385 root cause found (NOT Revert-specific, older than C-12: since 80ddbd5f 9 Sep). CE's in-memory record stayed DWG-B1's (11 pits) when FIX_MODERN_PIPE_W1 (14 pits) opened; PITSCHEDULE does not bind it at open, so schedule saves wrote DWG-B1's record into FIX_MODERN (log 01:14:18 saves; 14-11 = the 3 lost rows P8/P11/P12). Desk framing 'drawing-only pit' is wrong: the fixture note says P8/P11/P12 were placed with CE PIT and have records. Failing test pushed 4cd600ab (net10: 2 fail). Draft PR opened. Usage: not readable headless.
