# Re-review 2: PR 2043 `claude/trust-core-settings-e13111` (TRUST-03, the office setup, switch OFF)

**Reviewer:** lane trust-review (ninth run), 13 Nov 2026 04:14 PC clock. **Head reviewed:** `d9600322` (one commit since `ee76f4c7`: "second review fixes"). Against `reviews\claude-trust-core-settings-e13111-rereview.md`. Read by a helper reader; the order of writes in "Make this the office setup" re-read by me. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. "What this PC runs with" now goes through the very same start-up corrections CE makes when it loads your settings, so CE Health will not call an office-values PC different.
2. "Make this the office setup" now keeps a dated copy of your settings before it marks your PC, and the settings are re-read straight after Apply, Put back or Make.
3. Nothing calls these yet (the window is not built), and the switch is OFF, so today's CE is unchanged.

**Verdict: GO** for the robot on copies, with one small fix to carry before the window is built. GO means fit for testing on copies, never merge or install.

---

## The two open items from the last review

1. **Start-up corrections skipped: FIXED.** The seven corrections now live in one function, `SettingsService.ApplyStartupCorrections` (`Modules\Drainage\Services\SettingsService.cs` 159-304). The real loader calls it with its messages on (324); the comparison calls it with messages off (`Services\OfficeSetupService.cs` 215). The helper compared the removed loader lines with the new function word for word: the only differences are the `if (announce)` guards on the log lines; the call sits in the same place in the same error handling. One code path: now true.
2. **Make rewrote the settings file with no kept copy: FIXED, one small fault.** A dated `.before-make-office-<date>.bak` is made before the settings file is rewritten, never overwriting an existing one (`OfficeSetupService.cs` 288-297, read by me), and the message names it (300-301).

## Small fix to carry

1. **"Nothing was changed" can be untrue in Make.** The office file is written first (`OfficeSetupService.cs` 285, read by me), then the kept copy is made with "never overwrite" (292). If that copy fails (a second press in the same second, a locked file), the catch says "The office setup could not be made (...), so nothing was changed." (306) although the office file was already rewritten. Make the copy first, or say what was done.

## Worth knowing

1. **The automatic reload** re-reads the settings in the running AutoCAD only when the file changed is that session's own settings file (`OfficeSetupService.cs` 523-530), using the normal start-up load (`SettingsService.OfficeSetup.cs` 11-15). It does not touch an open Settings window's unsaved edits, but saving that window afterwards writes its own copy back over the office values (flagged last time, still true): the window contract should offer Apply only with the Settings window closed.
2. **With the switch OFF** Apply refuses before writing (462) and the start-up line stops at once (`PluginInitialization.cs` 263). Put back and Make do not check the switch themselves, but nothing calls them yet. Switch OFF by default (`Models\UserSettings.cs` 2316).
3. **A once-only correction can undo an office value** on a colleague's file that never had that correction (for example a step-iron depth of exactly 1000), now visible at once because of the reload. Unlikely (the office step-iron rule is 900); Apply could mark the file as already corrected.

## What I did not check

1. Built nothing, ran nothing; the 36 office-setup tests are the lane's.
2. Whether any CE tool keeps settings changes only in memory, which a reload would drop.
3. Nothing in AutoCAD.
