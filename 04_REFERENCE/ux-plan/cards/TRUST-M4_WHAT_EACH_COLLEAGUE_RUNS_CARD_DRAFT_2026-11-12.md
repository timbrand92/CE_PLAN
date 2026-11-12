# TRUST-M4: what each colleague is running, in one place

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card.
**Class:** Modify (Manager's existing report and dashboard). Nothing is retired.
**Source:** Tim, 5 Nov: "EVERYTIME I GIVE SOMEONE A RELEASE IT MAKES THEIR EXPERIENCE WORSE" and "it does random stuff for them and I can't explain why". Trust plan section 7 line 5 (nothing tells Tim a colleague is on a different build or setup). Step M4 of `areas\trust-plan-manager.md`. Pairs with card TRUST-03 (same settings for everyone).

---

## FOR TIM

**When a colleague says "CE did something odd", the first question is what they are running. Today your dashboard can only tell you their Manager version. This card makes one row per PC show all three CE builds, the AutoCAD year and whether they are on the office setup.**

```before
Dashboard, Machines: one row per PC.
  Versions: "CE_SUITE_MANAGER:1.1.89"   AutoCAD: "25.0"
  Civil and Structural builds: not shown.  Office setup: not shown.
```

```after
Dashboard, Machines: one row per PC (names coded, as today).
  Civil 3.0.90 | Structural 1.0.126 | Manager 1.1.89 | AutoCAD 2027 |
  Office setup: yes | Last seen: today 9:14
  A row in amber when it differs from the current release or the office setup.
```

## Decisions for Tim (read these first)

1. **Where you see it.** Recommended: **the existing Machines page of your dashboard,** plus the same line in CE_VERSION on each colleague's own screen. Example: a colleague reports a fault; you open the dashboard and see they are still on Civil 3.0.89 before you ask anything. OPEN.
2. **What counts as "office setup: yes".** Recommended: **every office value matches the office setup file from card TRUST-03; personal values (window positions, recent choices) are not counted.** Example: a colleague who moved the Settings window is still "yes"; one who changed the pipe label height is "no, 1 value differs". OPEN.
3. **Names.** Recommended: **keep the coded names Manager already uses, with a small local key on your PC only** that turns codes into names. Example: the office folder only ever holds codes; your screen shows the colleague's name. OPEN.
4. **Should colleagues see that their own PC is "behind"?** Recommended: **yes, one line in CE_VERSION: "A newer CE is approved; ask Tim."** Example: a colleague on 2024, where no ribbon line appears, still finds out. OPEN.

## 1. What you'd see

1. **On your dashboard, Machines page:** one row per PC with the three CE builds, the AutoCAD year (2027, not "25.0"), office setup yes or no, and when it was last seen.
2. **Amber** when any build differs from the current approved release, or office setup is "no". Normal colour otherwise. No other colours.
3. **On the colleague's CE_VERSION:** the same facts for their own PC, the year in words, and the "behind" line from decision 4.
4. **Nothing pops up** for colleagues. Nothing is asked of them.

## 2. The full experience

1. **Trigger:** Manager already writes a short report at AutoCAD start and copies it to the office folder (Verified, `Modules\Manager\Services\CeAdminTelemetryService.cs:86-104`, `Plugin.cs:172`). This card adds three numbers and one yes or no to that same report. No new route to the office folder.
2. **Why Civil and Structural are missing today:** the report carries only Manager's own name (Verified, `CeAdminTelemetryService.cs:86-104`), and the reports Civil and Structural write are never sent (Verified, `Services\CeAdminStorageService.cs:438-439`). The dashboard already groups reports per PC and lists every version it finds (Verified, `Services\CeAdminAnalyticsService.cs:70-84`), so it shows only Manager.
3. **How the three builds are found:** CE_VERSION already reads all three loaded plugins (Verified, `Services\CeVersionReport.cs:46-51`). The report reuses that reading.
4. **The AutoCAD year:** turned from AutoCAD's internal number into the year (25.0 to 2025, and so on). Today CE_VERSION shows the internal number (Verified, `UI\Dialogs\CeVersionWindow.xaml.cs:49`).
5. **Office setup:** read from the comparison card TRUST-03 builds. Until TRUST-03 exists the column says "not checked yet", never "yes".
6. **Cancel, Undo, drawings:** none. Nothing in any drawing is read or changed.
7. **Offline PC:** the report waits in the PC's outbox as today and goes when the office folder is reachable. The row shows "last seen" so a stale row is obvious.
8. **AutoCAD 2022 to 2024:** the report is written there too; checked on 2024.

## 3. Settings

1. **One switch, "Report all CE builds"** (new, off for the trial, on once accepted). Off = today's report.
2. **No colleague setting.** The report is the same for everyone.

## 4. What it reuses

1. **Manager's existing report and its copy to the office folder.**
2. **CE_VERSION's reading of the three plugins.**
3. **The dashboard's Machines page,** which already has a versions column.
4. **Coded names** (`CePiiHash`) for user and PC, as today.

## 5. How it gets proven

**Robot, two Windows logins on one PC (or a spare PC), AutoCAD 2027:**

1. Start AutoCAD on each; read the report file in the outbox: three builds, the year, office setup, coded names only. A planted real user name in the report must fail the check.
2. Read the dashboard's Machines data: one row per login, matching each CE_VERSION exactly.
3. Change one office value on login B: its row says "no, 1 value differs" (once TRUST-03 exists).
4. A broken twin that leaves Structural out of the report must fail check 2.

**Robot, AutoCAD 2024:** the report carries the same facts.

**Codex:** looks at the Machines page and CE_VERSION: plain words, the year not the internal number, amber only where it should be.

**Tim:** opens the dashboard and checks his own row is right.

## 6. Not known yet

1. **Which colleagues' reports are in the office folder today** (step M1 reads them first).
2. **Whether a colleague's PC can reach the office folder** at every start.
3. **Whether the dashboard's Machines page is readable at a glance** with four more columns; Codex looks before you do.
4. **TRUST-03 is not built,** so "office setup" will read "not checked yet" until it is.

Written from reading Manager 1.1.89 (commit cf059dcf). Nothing here was run.
