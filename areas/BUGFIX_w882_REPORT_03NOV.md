# BUG-882 report, 3 Nov 2026 (B-187 provisional) — NO PR OPENED

## FOR TIM
1. **Fault confirmed, not fixed.** The installer still asks Windows for administrator rights. `Installer/app.manifest` line 7 reads `requireAdministrator` on `origin/claude/rel-20261102a`.
2. **Why I stopped:** this needs your call, and a Settings switch cannot cover it. Windows reads that line before any CE code runs, so "ON by default, OFF restores the old behaviour" cannot be built. It can only be a build-time change.
3. **What I found:** the installer already puts the plugin in the colleague's own folder (per-user AppData, `Program.cs` around line 363). The admin rights are only needed for a best-effort clean-up of old machine-wide copies in ProgramData and Program Files (`Program.cs` 376-409), and for reading the Edge update registry keys (reads work without admin).
4. **The question for you (one line):** may the installer run as the colleague, with no admin prompt? If so, the old machine-wide clean-up would be skipped with a warning and a colleague with an old ProgramData copy may see commands twice. Or do you want it to run as a normal user and only ask for admin when an old copy is found?
5. **Related:** BUG-883. Running the installer with no arguments still exits with usage (64), so a colleague cannot self-install anyway. Fixing 882 alone does not unblock self-install. 9 Nov pilot stays a hand install.
6. **Nothing proven in AutoCAD.** No code changed, no tests run, no robot case.

## Technical
- Base checked: `origin/claude/rel-20261102a` after `git fetch`. `Installer/app.manifest:7` = `requireAdministrator`. Not ALREADY FIXED.
- No worktree created, no build or test run, so the isolation listings (APPDATA folders) were not needed and nothing real could have changed.
- Suggested robot case once approved: N-series installer check, run the built installer as a standard user, expect no UAC prompt and the bundle in `%APPDATA%\Autodesk\ApplicationPlugins`; switch-off control not possible (build-time manifest), so the control is the previous build.
- CE_SHARED untouched.
