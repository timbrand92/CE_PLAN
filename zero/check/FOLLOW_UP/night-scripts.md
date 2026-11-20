# Follow-ups: the night scripts (`C:\CE_CIVIL\acad\night_scripts`)

Non-blockers, kept so they are not lost. From the honest check of main at 22993fa, Fri 20 Nov 2026 (`C:\CE_WORK\check\reports\night-main_honest_REPORT.md`, section 4). Checked by reading. The blockers are in `VERDICTS\night-scripts-on-main.md`.

1. **The plug-in's own Pit and Pipe windows halt every pass.** `ce_safety.ps1:19` lists six known window titles; anything else of our process is "unknown", the pass stops and the test AutoCAD is left open with a note. Safe, but no Pit or Pipe night test can finish. The fix must not become "any title from our process".
2. **The window list can miss things:** a sign-in page in a browser tab that is not in front; a window from an Autodesk helper program not on the list with no licence wording in its title; panels drawn inside AutoCAD's main window; a window that appears between the last check and the act (`ce_safety.ps1:332-335`). In the other direction, "account" and "trial" match inside harmless words and cause false stops (`:20-21`).
3. **One read goes to whichever AutoCAD answers first.** The helper attaches and reads one property before its owner check (`ce_safety.ps1:180-182`); the "no other AutoCAD running" test is made in only one of the three places the helper is started (`:233`, not `:304, 308`). It is refused before any act.
4. **No list of allowed commands.** `ce_pass.ps1:13, 16` and `ce_cmd.ps1:3, 36` send whatever they are given; PIT, PP and CD are not refused (standing brief 1.3), nor a setting or profile change.
5. **The launcher writes no note and makes no window check.** With a licence or sign-in box showing during launch it waits up to 6 minutes, prints STOP and exits; no note for Tim (`ce_launch.ps1:11-20`).
6. **A test AutoCAD can be left running with no record,** when the launch refuses after starting (`ce_launch.ps1:14, 19, 20, 22, 23`), or when test mode is switched on while the launcher runs (it still starts a real one at line 8). `-drawing` accepts any file (`:3`).
7. **The test copy is known by name, not by folder** (`ce_safety.ps1:186`, `:142`; `ce_launch.ps1:11, 17, 20`). A drawing called `open_me.dwg` from anywhere passes.
8. **Only the active drawing's title is seen before a quit or force** (`ce_safety.ps1:306-308, 332-335`). A second drawing open in the test AutoCAD is not seen.
9. **Step limit 60 s against a command limit of 240 s** (`ce_pass.ps1:13, 56`): a slow, healthy command is judged "no answer" and the ladder can end in a force on a healthy test AutoCAD.
10. **The Melbourne time in the note falls back to the PC's own clock** (`ce_safety.ps1:166`). Harmless in a note; must not be copied into the hours check.
11. **Retired callers** under `C:\CE_WORK\civil_tests` (five files ending `.ps1.retired`). Two of them (`night_1119b`, `night_1119c`) do not go through the safety script at all and take the active AutoCAD directly. They must never be renamed back. No live caller and no scheduled task was found.

**Added from the adversarial pass (Codex gpt-6.2-astra, `C:\CE_WORK\check\reports\night-main_adv_REPORT.md`), 11:30 am:**

12. **A licence or sign-in page inside a window with an ordinary title is not seen** (for example a browser-style host titled "Welcome"); the window title is read to 255 characters only; a window whose owner cannot be named is treated as blank (`ce_safety.ps1:39-44, 65-86`). Which host a real sign-in screen uses is not proven.
13. **A window can appear between the last check and the act** (`ce_safety.ps1:320-323, 332-335`); the sender helpers make no licence or stop check of their own (`:180-196`).
14. **"Still running" is treated as "jammed".** A busy-PC refusal, lost foreground, a failed send or a timeout all go to the close ladder, which can end in a force on a healthy test AutoCAD (`ce_pass.ps1:48-51, 57-60, 74-80`; `ce_safety.ps1:309-335`). D-160 allows a force only for a jam or crash. The normal close's own answer is thrown away (`:323`).
15. **Record, note and log paths are not confined to the test folders** (`ce_safety.ps1:32, 90-100, 163-167`; `ce_pass.ps1:13, 18, 40`): a wrong setting could clear or append to an unrelated file.
16. **The shared helpers can be called with fewer checks than the top scripts** (`ce_safety.ps1:175-191, 205-209, 224-253`): the quit path checks only a supplied process number.
17. **A command error is reported as success** (`ce_safety.ps1:189-200`; `ce_netload.ps1:33-35`): the sender waits for an idle command line and never reads whether the command was known or what the plug-in's own test report said. A night "pass" can therefore be green with nothing proven: matters for the AutoCAD test room's pictures.
18. **A stopped step can leave its sender alive** (`ce_pass.ps1:21-29`; `ce_safety.ps1:205-219`). Not proven live.
19. **The NETLOAD path is a shared staging folder** (`ce_netload.ps1:33`); nothing checks it holds the build under test. Two staged plug-in files there differ and neither is shown to be main's build.

**Not checked by anyone yet:** where the plug-in's own test commands save to (`src/CeCivil.Acad/AcadHost.cs:74` and four others); what AutoCAD itself writes to Tim's profile when a test AutoCAD exits.
