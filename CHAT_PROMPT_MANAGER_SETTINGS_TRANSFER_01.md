NAME THIS CHAT: CE_ACAD / manager / build / 01 (rename yourself in your first reply)

# Build prompt — "Move My Settings" inside the CE plugin (Manager)

Written 30 Sep 2026 by `CE_ACAD / general / fix / 01`. Tim's decision and his words: `C:\CE_PLAN\decisions\2026-09-30_SETTINGS_TRANSFER_IN_PLUGIN.md`. Read `C:\TimOS\RULES.md`, `C:\TimOS\ROUTER.md`, `C:\CE_PLAN\areas\manager.md` and `C:\CE_PLAN\BUILDER_BRIEF_COMMON.md` (hard rules, build flags, reference assemblies) first. Say which item you are on before any work: **manager — M-SET-01 Move My Settings**.

## What Tim wants, in one paragraph

Staff move their AutoCAD setup (ribbon/CUIX, command aliases, plot styles, printers, palettes, templates, Options profile) to a new PC or a new AutoCAD version from a button in the CE plugin. The engine already exists and is Tim-accepted: the standalone **CE AutoCAD Settings Transfer** tool. You add the doorway; you do not rewrite the engine.

## The engine you are shipping (read before touching anything)

1. Source: `C:\Lisp Files\CE_AcadSettings` (its own LOCAL git repo, no remote; last commit `1e15c01` or later). WPF, .NET 8, 87 xUnit tests (`CE_AcadSettings.Tests`). Read its `CLAUDE.md` and the top entry (BUG-004) of its `REGRESSION_LOG.md`.
2. Status: 2027 -> 2026 Tim-accepted in AutoCAD 30 Sep ("it works"). 2022 -> 2027 and 2027 -> 2027 PC-to-PC: built, sandbox-tested with real packages, NOT tried in AutoCAD.
3. Its approved publish command (self-contained single exe, ~72 MB) is in its `CLAUDE.md`. Do not invent another.
4. **Registry trap:** your Bash/PowerShell commands see a PRIVATE copy of HKCU, not Tim's real registry (found 30 Sep; see BUG-238 in `BUG_CARPARK.md`). Never state what is in Tim's AutoCAD profile from your own shell; the tool's tests use a throwaway `HKCU\Software\CEAcadSettingsTests` key, which is fine.

## What to build

### Part A — bring the engine into the plugin repo (one home)

1. Import `C:\Lisp Files\CE_AcadSettings` into the plugin repo as `Tools/CE_AcadSettings/` WITH its history (`git subtree add --prefix=Tools/CE_AcadSettings <local path> main`), tests included. Before committing: confirm `.gitignore` keeps out `bin/`, `obj/`, `*.ceacad`; run the leak scan; no `.ceacad` package, and no real package path, ever goes in the repo (the replay test takes paths from `CEACAD_REPLAY_PACKAGES` at run time).
2. Its 87 tests must run and pass in the plugin repo (`dotnet test Tools/CE_AcadSettings/CE_AcadSettings.Tests/...`).
3. After your PR merges (not before), put a one-line `MOVED.md` in `C:\Lisp Files\CE_AcadSettings` pointing to the new home. Never delete that folder without Tim's yes.

### Part B — two small engine fixes queued by the settings chat (combine them now so there is one install)

1. Post-import check gives a FALSE warning for `General Configuration\MenuFile` (AutoCAD stores the menu name without `.cuix`, e.g. `...\support\acad`); treat the value as found when `<value>.cuix` exists. Test first (RED), then fix.
2. After import, if `Editor Configuration\SaveFilePath` (autosave folder) names a LOCAL folder that doesn't exist (seen: `C:\Autosaves` on Tim's 2026 PC), create it and log `~ Created autosave folder <path>`. Never create network paths. Test first.

### Part C — the engine learns to be launched by the plugin

Add command-line options to the tool (keep double-click behaviour exactly as today when no options are given):

1. `--mode save|load|undo` opens the right tab with everything pre-chosen; `--version <Rxx.x>` and `--profile "<name>"` preselect the AutoCAD version and profile the user was in.
2. `--wait-pid <acad pid>`: the tool shows "Waiting for AutoCAD to close..." and does nothing until that process has exited (then a short settle wait). Never export/import while that AutoCAD is still running.
3. Package location default: a CE folder in the user's OneDrive for Business (`%OneDriveCommercial%`). The folder name is NOT decided — put it in one constant and list it as "assumed, Tim to confirm". Fallback when OneDrive isn't there: Documents. `--mode load` preselects the newest package there (the user can still browse).
4. `--mode undo` preselects the newest `Backup_*.ceacad` in `%AppData%\CE_AcadSettings\Backups` and says in plain words what it will put back (version, profile, date).
5. `--acad-exe "<path>"`: when given, the finish screen shows a **Start AutoCAD** button that starts that acad.exe with `/p "<profile>"`.
6. When launched from the plugin, hide the "install CE plugins" option (the plugin is already there).
7. Pure logic (argument parsing, newest-package pick, backup pick) goes in testable classes with unit tests.

### Part D — the Manager button and command

Follow `Modules/Manager/CLAUDE.md` "Adding a new command" exactly (registry json, toolbar layout, 16/32 px icons, `[CommandMethod]`, a `Services/CeSettingsMoveService.cs`).

1. Command `CESETTINGSMOVE` (CE prefix = shared, per UX-NAMES). Ribbon button on the Manager tab: **Move My Settings**, with three choices: **Save my settings**, **Load my settings**, **Undo last settings move**. Tooltip says only what is installed.
2. Flow, in this order (safety first):
   a. Any drawing with unsaved changes -> ask the user to save (never save for them, never discard). If they cancel, stop, nothing closes.
   b. Show the one message Tim approved: "AutoCAD will close so your palettes are saved. Save your drawings first." with OK / Cancel.
   c. Start the tool (`Contents\Tools\CE_AcadSettings.exe` in the Manager bundle) with `--mode`, `--version`, `--profile`, `--wait-pid <this acad pid>`, `--acad-exe <this acad.exe path>`. **Confirm the tool process actually started before closing AutoCAD.** If it failed to start: say so plainly, keep AutoCAD open.
   d. Close AutoCAD the normal way (so it writes its palettes).
3. Same button and behaviour in all three lanes (net48 2022-2024, net8 2025-2026, net10 2027). The exe is one file shared by all lanes.

### Part E — packaging

1. `PrepareReleaseBundle` publishes the tool with its approved command and places the single exe at `Contents\Tools\CE_AcadSettings.exe` in the Manager bundle.
2. The package validation currently expects exactly 72 files: update it DELIBERATELY for the new file (and say so in the PR), never by loosening the check.
3. Check the bundle's `PackageContents.xml` does not try to load the exe.

## Rules for this job

1. Your own worktree, branch `claude/manager-settings-move`, draft PR at once; Tim is the only merger. Never install; never open full AutoCAD; never touch `%APPDATA%\Autodesk`, `C:\ProgramData\Autodesk` or Tim's registry; tests use scratch folders and the throwaway test key only.
2. Builds with `-p:SkipDevBundle=true` and the reference flags in `BUILDER_BRIEF_COMMON.md`; all three lanes 0 errors; run builder/test processes at Below Normal priority; heavy runs in Tim's free AutoCAD windows (see RULES 1.8).
3. Do NOT touch the IT Admin copy (`IT Admin\CE_ACADSETTINGS\CE_AcadSettings.exe`, installed 30 Sep, old copy in `previous\`). It stays for PCs without the plugin.
4. Record your item, PR and status in `C:\CE_PLAN\areas\manager.md` (item M-SET-01) in the same step as the work; the tool's own changes go in its `REGRESSION_LOG.md` (now under `Tools/CE_AcadSettings/`).
5. Messages to users: calm, plain, AutoCAD words, no code terms (UX-VOICE-01).

## Report back (short, plain, for Tim)

Per part A-E: BUILT / PARTIAL / SKIPPED and why; PR number; test counts (the tool's and the Manager's); every "assumed, Tim to confirm" choice (at least: the OneDrive folder name; staff vs admin-only button); what was NOT tested.

## Test steps for Tim or Codex in AutoCAD (write these into PENDING_TESTS when built)

1. 2027, drawing open with an unsaved change: Manager tab > Move My Settings > Save my settings. Expect: asked to save the drawing first; then the close message; AutoCAD closes; the tool says "Waiting for AutoCAD to close...", then saves a package into the OneDrive CE folder and shows "Export complete" and a **Start AutoCAD** button; clicking it reopens AutoCAD on the same profile.
2. Cancel at the save question and at the close message: AutoCAD stays open, nothing else happens.
3. Second PC (2027, or 2026): Load my settings. Expect the newest package preselected, a backup line, "VERIFICATION PASSED", no false "MenuFile" warning, the autosave folder created if it was missing; after Start AutoCAD: ribbon, TOOLPALETTES and PLOT (e.g. HP DesignJet T520, DocuCentre SC2022, "Creative Engineering.ctb") all present.
4. Undo last settings move: it names the backup it will restore; after it, the PC is back how it was.
5. Repeat step 1 on 2022-2024 and 2025-2026 lanes: same button, same behaviour.
6. Double-click the exe on its own (no plugin): opens exactly as today.
