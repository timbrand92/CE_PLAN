# Claude driver run 26: isolated test settings profile for Q4 (Sun 18 Oct 2026, 02:39 to 02:46 Melbourne, PC clock)

**Installed builds (nine DLLs read first with readdll.ps1):** Civil 3.0.53+b06126db, Manager 1.1.53+b06126db, Structural 1.0.118+9a8e5d4e. Legacy, Net8 and Modern of each carry the same version text.

**Answer first.** The profile proof FAILED at the first step, so I stopped as the brief says. **AutoCAD never reached CE.** The driver's direct start (`launch -Env`) opened AutoCAD with a message "Customization file load failed. File not found: acad", which no allowed driver action can close. Nothing on the checklist was tested.

Counts: **PASS 0, FAIL 0, BLOCKED 5 (CDTIDYLABELS, CDCHECKS routes, double-click setting read, quick edit with tools ON, any other OFF tool), 0 proven.** Structural was never attempted (the driver refuses its variable, see B3).

**Q4 evidence per tool:**
1. **Tidy labels (CDTIDYLABELS): Q4 evidence: no.**
2. **Checks list (CDCHECKS, CDHUB and CDCHECKCURRENT routing): Q4 evidence: no.**
3. **Double-click opens Edit window (mouse only): Q4 evidence: no** (never read; mouse is BLOCKED for the driver anyway).
4. **Quick edit with the new tools ON: Q4 evidence: no.**

Driver calls (counted by a wrapper, every call): 7 of 70. AutoCAD ran about 5 minutes (one session, no drawing ever open). AutoCAD is closed. Nothing was saved.

## A. Setup (all of it worked)

1. **Before launch.** `Get-Process acad,accoreconsole` showed nothing. Codex queue.log last line was `END verifyW65 08:38`, no START without an END.
2. **Hashes of Tim's real settings, before and after: identical.** CD_Settings.json ACD64E79A33B, CS_Settings.json 622A246F7D3B, CE_CVL_SUITE settings.json EFE307C4FC74. I only copied CD_Settings.json and edited the copy.
3. **Key names, read from source (`origin/claude/rel-20261018b`, read only):** `linking.tidyLabelsEnabled` (UserSettings.cs:571), `checks.checksCommandEnabled` (:2425), `doubleClick.opensEditWindow` (DoubleClickSettings.cs:26). The copy was written with all three `true` and read back as `true`. Tim's file held none of them, so I added the groups to the copy.
4. **How Civil finds its settings folder (source, `SettingsService.ResolveSettingsFolder`):** with `CE_LOG_DIR_OVERRIDE` set it reads `<folder>\settings\CD_Settings.json`. That matches what the brief said. The same variable also moves the logs, Help state and learning store, so the folder would have shown CE log files if CE had started.
5. **Scratch folder was `C:\ce_rc_scratch\ce_q4_profile_run26`, not Windows Temp.** The driver's README (run 8 section) says `-Env` accepts only a folder strictly inside `C:\ce_rc_scratch`. I used that and did not try Temp.
6. **Fresh copies** CLD80_B1 (from DRV1_B1, 34BBE37C2EA4) and CLD80_S1 (from DRV2_S1, 950AFDF6E523): both matched their sources. Never opened. Both deleted at the end.

## B. What happened

1. **The launch.** `launch C:\ce_rc_drv\CLD80_B1.dwg -Env CE_LOG_DIR_OVERRIDE=C:\ce_rc_scratch\ce_q4_profile_run26`. The driver started `acad.exe` directly (child of the driver window, no Explorer, no AcLauncher). It removed 36 environment names containing KEY, TOKEN, CLAUDE and similar (names listed in the driver reply, no values). After 243 s the driver reported "AutoCAD did not become idle on the drawing within 240 s (AutoCAD is running but is not registered for COM automation... Nothing was started.)".
2. **Why: a dialog.** `ui windows` showed a second window "AutoCAD Message" (not on the driver's allow-list, so view-only and unclickable). I read it by taking a picture of that one window (observation only, no click, no keys). It says: **"Customization file load failed.  File not found: acad"** with one OK button. AutoCAD used about 2.3 s of CPU in 4 minutes: it was waiting on that button.
3. **The Structural variable is refused, as the brief warned.** `launch ... -Env CE_STRUC_SUITE_APPDATA_ROOT=...` printed "REFUSED: only the variable CE_LOG_DIR_OVERRIDE may be set (got 'CE_STRUC_SUITE_APPDATA_ROOT'); nothing was started". So Structural cannot get an isolated profile through this driver at all today.
4. **I did not press OK, and I did not retry.** The driver has no action that clicks "AutoCAD Message" (`dismiss-modal` only covers the known CE pop-ups). Going round it (my own click or key) is against the driver rules and the brief. I ended the AutoCAD the driver launched with `quit -Kill` (allowed: "pid 31248 is the AutoCAD this driver launched"). It was killed; no other AutoCAD was touched; none is running now.

## C. What I know and do not know

1. **Known:** the direct start is what breaks. README says this path was "never run against a real AutoCAD" and "needs Opus review"; this is its first real use and it fails. Earlier runs all used the Explorer hand-off and never saw this message.
2. **Not known (I did not find out, and will not guess):** why AutoCAD cannot find the "acad" customization file on a direct start. The README itself notes that skipping AcLauncher means the start-up is not identical. Possibilities worth the tooling worker's time, none checked: the start-up folder (`C:\ce_rc_drv`), a profile or support-path setting that AcLauncher or Explorer supplies, or one of the 36 removed variables.
3. **Not known:** whether a normal double-click start still works after this failed start. I did not launch again. A failed direct start has precedent for upsetting the profile (2 Oct note: "No Profile name exists: Tim", "Customization file load failed" after a crash; the desk made a backup then). **The next normal start should be watched; I did not write to the registry or the profile, but I also did not read them.**
4. **Not known:** whether Tim's real settings or logs were touched. Settings hashes are identical before and after. The scratch folder held only my edited copy of CD_Settings.json (CE never started, so no logs appeared), and I deleted the folder.

## D. My mistakes (plainly)

1. **First two driver calls refused for no `-Who`.** I acquired the lock but did not set `ACAD_DRIVER_WHO`. Cost: 2 of the 7 calls, no effect.
2. **Waited the full 243 s** for a launch that was stuck on a dialog from the first minute. The driver's own limit; I could not shorten it.
3. **Files left on disk:** none. Scratch profile folder deleted, both CLD80 copies deleted. My helper scripts are in the session scratchpad only.

## E. What Tim and the desk need to do

1. **Tim: nothing in AutoCAD.**
2. **For the tooling worker (one job):** make `launch -Env` start AutoCAD so it finds its customization file, or give the driver a way to start AutoCAD through the Explorer path with one extra variable. Then rerun this brief unchanged. The profile files, key names and `settings` sub-folder are proven correct on paper (A3, A4) and need no change. Then also allow `CE_STRUC_SUITE_APPDATA_ROOT` (or say Structural stays untestable).
3. **For the desk:** Q4 still has zero STRONG rows. This run changes nothing in the Q4 flip list.

**Built, tested, installed, accepted:** installed builds; this run tested nothing in AutoCAD. Not Tim-accepted, not Codex-accepted.

**What I did NOT test:** every tool on the checklist, Structural, the profile isolation itself (CE never loaded), the Windows Temp folder (driver forbids it), the registry and AutoCAD profile after the failed start, and whether Explorer-started AutoCAD still works.

AUTOCAD CLOSED
