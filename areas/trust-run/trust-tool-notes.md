# Lane trust-tool-notes: rewriting the core tool notes from the installed code

One dated line per batch (PC clock). Source: installed Civil 3.0.90 code copy at C:\CE_WORK\scratchudit_civil (commit cf059dcf). Nothing run in AutoCAD.

1. **Fri 13 Nov 2026 00:34:** rewrote PIT, PP, CDLPD, CDEDIT, CDPITCOVERFLIP from the code, each fact with file and line. New faults seen: CDPITCOVERFLIP ribbon button does nothing; PP opens a different window from PIT; CDLPD search distances not converted in metre drawings; Edit Pipe single Save has no locked-layer check.
2. **Fri 13 Nov 2026 00:37:** rewrote CDRENUMBER, DP, IO, OF, FO from the code. New faults seen: DP never says whether its junction on the main was recorded; source commands print a failed-placement line twice; overflow and front overflow split pipes (question for Tim).
