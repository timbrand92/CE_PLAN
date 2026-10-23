# Carpark status edits applied, 23 Oct 2026

Applied to `C:\CE_PLAN\BUG_CARPARK.md` by a builder (Sonnet 5.5). Sources: `areas/ACCEPTANCE_LEDGER_W_SERIES_2026-10-23.md` section 4, and `areas/CARPARK_NEW_ENTRIES_23OCT.md` "Status notes". Every old status line was checked against the file before the edit and matched. No entry was set to FIXED. No heading or number changed.

## Ledger section 4 (13 edits, all applied)

1. **BUG-698.** Old: `FIXED (Codex-accepted, V2-04, Civil 3.0.64)`. New: status unchanged; body line added for Codex W1-03 PASS SURE on 3.0.70.
2. **BUG-753.** Old: `OPEN (installed 3.0.70; not yet tested)`. New: `OPEN` with Codex W3-02 BLOCKED UNSURE; needs runner case C15.
3. **BUG-758.** Old: `OPEN (installed; not yet tested)`. New: `OPEN` with Codex W5-01 PASS SURE for the window half only.
4. **BUG-772.** Old: `OPEN (installed; not yet tested)`. New: `OPEN`, cannot be tested on this build (WSUD tab read-only).
5. **BUG-777.** Old: `OPEN (installed; not yet tested)`. New: `OPEN` with Codex W1-04 SEEN; cross-check not done; wording fault is BUG-1032.
6. **BUG-783.** Old: `OPEN (installed; not yet tested)`. New: `OPEN` with Codex W2-03 BLOCKED; see BUG-1031.
7. **BUG-784.** Old: `OPEN (installed; not yet tested)`. New: `OPEN` with Codex W2-01 NOT TESTED (fixture).
8. **BUG-791.** Old: `OPEN (installed; not yet tested)`. New: `OPEN` with Codex W2-02 PASS SURE; not yet Codex-accepted under RULES 13.3.
9. **BUG-809.** Old: `OPEN (installed; not yet tested)`. New: `OPEN` with item 4 Codex W5-06 BLOCKED; items 1 to 5 untested.
10. **BUG-814.** Old: `OPEN (installed; robot or Codex observation PASS recorded)`. New: `OPEN` with robot PASS runs 34 and 35 and Codex W1-05 BLOCKED.
11. **BUG-817.** Old: `OPEN`. New: `OPEN` with Codex W2-04 FAIL SURE (DBMOD 21 to 21, U echoes PITSCHEDULE).
12. **BUG-855.** Old: `OPEN`. New: status unchanged; body line added for Codex W1-03 (95 before and after, copy already edited, so inconclusive).
13. **BUG-857.** Old: `OPEN`. New: status unchanged; body line added for Codex W4-02 still seen.

The ledger's item 14 (add BUG-1030 to BUG-1034, move "Next BUG ID") was **not applied here: already done** by the desk commit `e9e0197d`. BUG-1030 to BUG-1034 exist and "Next BUG ID" already reads BUG-1035.

## Status notes from CARPARK_NEW_ENTRIES_23OCT (8 notes)

1. **BUG-788.** Old: `OPEN (fix installed ... PR #1404; not yet tested)`. New: `REOPENED 23 Oct 2026`, reason: the Xref fingerprint returns the first Xref's record (S05-01, F-154); fix the adapter, not the core. The earlier status text is kept inside the line.
2. **BUG-725 / FB-17.** Status `OPEN` unchanged; dated note added for S11-02 (F-171), second report of the millimetre x1000 scale.
3. **BUG-802.** Status `OPEN` unchanged; dated note added: F-005 (BUG-875) is the same root, fix together.
4. **BUG-834.** Status unchanged; dated note added: the fix leaves the empty or stale `--approved-version=` bypass and the silent unknown approval (F-020, BUG-886).
5. **BUG-008.** Status `FIXED (Tim confirmed 2026-05-13)` unchanged; dated note added: F-229 (BUG-1023) proposes removing its 90 per cent rule; if Tim agrees it must be re-tested.
6. **BUG-867 and BUG-869.** Statuses unchanged; dated note added to each: BUG-867 second report S08-01; both: #1530 / #1531 are MERGE-WITH-FIXES in REVIEW_CODEX_PRS_B.
7. **AUDIT-XCLMTXT-DECIMALS.** Status unchanged; dated note added for S14-03 (rated HIGH; saved record and drawing text also disagree; #1533 fixes both).
8. **HUNT_DATALOSS_SILENT DS-06 now BUG-979.** Skipped, already applied: BUG-979 exists and its Reference line already names DS-06.

Total: 13 ledger edits applied, 7 of 8 notes applied (8 touched entries), 1 note already in place, ledger item 14 already done.

## Left alone, for your information

1. **Two `## BUG-866` headings:** only one `## BUG-866` heading exists in the file now (line 11709 before these edits). The second was not found; nothing changed.
2. **BUG-466** has its Status written inline inside the body paragraph, not as its own `**Status:**` line. Left as is.
3. **BUG-580** has no clear `**Status:**` line at the top of its entry (only Codex look notes). Left as is.

## Not verified

1. I did not open AutoCAD or any Codex report: the new wording is copied from the ledger and the notes file as written.
2. I did not check the ledger's claims (for example "PASS SURE") against the Codex source reports.
3. I did not run a link or duplicate-number check across the whole carpark, only the edited entries and the headings named above.
