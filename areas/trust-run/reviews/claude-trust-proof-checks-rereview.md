# Re-review: draft PR 2050, `claude/trust-proof-checks` (headless proof checks for steps 1, 5, 6), head moved `c24af34e` to `03af5393`

**Reviewer:** lane trust-review (eighth run), Fri 13 Nov 2026, 03:44 PC clock. Read only.
**What was read:** the fix commit `08781653` (`TrustChecks.cs`, `ProofSession.cs`, `REGRESSION_LOG.md`, the harness README) and the two merges `98d81717` and `03af5393` (both resolve only `REGRESSION_LOG.md`), against `reviews\claude-trust-proof-checks.md`.

---

# FOR TIM

1. **All three earlier problems are fixed:** "nothing changed" is now counted from the drawing's own record of every object changed, added or erased, not from AutoCAD's changed flags; each of the two "changes nothing" checks also runs a deliberately faulty version and fails if it is not noticed; CE's record in memory is compared as whole text.
2. **Also fixed:** the name lookup that made all four checks come out BLOCKED in AutoCAD's core console.
3. **Verdict: GO** for the evidence lane to run the four checks in the core console on copies. Not run yet by anyone. Built yes (lane, 0 errors). Tested: not run. Installed no (test tooling). Accepted no.

---

## 1. The three FIX FIRST items

1. **The changed counter that could not fail: FIXED.** A watch on the drawing's own object events (changed, added, erased; "opened for writing" for the detail line only) runs around each call (`TrustChecks.cs` 287-329). DBMOD is kept for information only. The harness's own line is drawn under the watch and the check stops as BLOCKED if the watch saw nothing (380-394), so a watch that is deaf in this AutoCAD cannot give a false PASS.
2. **No broken twin: FIXED.** TRUST-OPEN-01 runs CE's record update where the read should be and fails if that is not noticed (line 72; the record is one line behind, so the update must write). TRUST-READONLY-01 turns the switch off and uses CDGRAPH's old way, the one seen to write on the installed build, and fails unless that is noticed AND adds the line as a pipe (134 onward). The switch is forced on for the real check, put back in a `finally` (139), and the PC's own value is printed in the detail line (my earlier note 3.3).
3. **The record in memory compared by pipe count only: FIXED.** Each measurement also compares CE's record in memory as whole text, written by the same text writer CE stores it with (397-410). A filled-in size on an existing pipe now shows.

## 2. Worth knowing

1. **The object watch also sees a rewrite of an unchanged value** (setting a value fires the object's changed event). So run on PR 2053's and 2055's builds, it would catch the "Civil active" mark rewrite and the end-of-command record write those reviews describe, which a record-text comparison can miss.
2. **The other two checks** (TRUST-UPDATE-01, TRUST-UNKNOWN-01) are unchanged apart from the lookup; my earlier review raised nothing on them.
3. **The lookup change** reads a property when no field of that name exists (`ProofSession.cs` 303-312): harmless.
4. **Stacking:** now on step 6 at `98d81717`, which carries step 5's new commit `d0cf644c`. Build at this head before running.
5. **No client name, job number, street or suburb** in the diff.

## 3. Not checked

1. Not built or run by me. Whether AutoCAD's core console raises the object events the watch listens for is exactly what the self-test in item 1.1 will show on the first run.
