# FOR TIM: base merges on PR 2028 and PR 2030 (5 Nov 2026)

1. **New heads:** #2028 = eeceb0b9, #2030 = 5fc1388d. Normal merge commits of rel-20261026s (8de95c34), pushed without force.
2. **Conflict:** REGRESSION_LOG.md only, in both. I kept both entries. UserSettings.cs untouched, no BOM before or after. The clash between the two PRs is left for CE 01 at assembly.
3. **Built:** Structural net48 compile passes in both. The build then stops at a post-build check step (powershell exited 9009, not found); I did not investigate or run that check by hand.
4. **Tested (net10, isolated settings):** #2028 168 of 169 passed, the 1 fail is Sbeam R8 evidence-reader test, not in this PR. #2030 623 of 624 passed; I did not capture the name of that 1 failure.
5. **NOT proven:** nothing opened in AutoCAD; CE_SHARED standalone check not run; the #2030 failure not confirmed as pre-existing; tests were broader filters (Schedule, Switch, UserSettings), not only the named ones.
6. **My mistakes:** my first conflict-marker fix silently did nothing and I committed markers; I caught it and amended before any push. Nothing wrong reached GitHub.
