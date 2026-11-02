# BRIEF w857 — BUG-857: what the X (and Esc) should do on the "Grade mismatch" box

Written 3 Nov 2026 (Melbourne) by w857 (Claude Sonnet 5.5), for Tim via CE 04. Options paper only: no code, no branch, no PR.
Checked against `origin/claude/rel-20261102a` (Civil 3.0.88 head 3fbb9da5), not against memory.

## FOR TIM

1. **The answer you were going to be asked is already built.** Option (a), "the X counts as Cancel, no pipe placed", went into the Civil release branch on 29 Oct (commit c92db9ad, PR #1858, switch `grade.mismatchBoxCloseCancels`, ships ON). Nobody needs to decide between (a) and (b) from scratch. I recommend you confirm (a) as the default and leave it.
2. **What you see with it ON (the default):** type Custom 1 IN 100, inverts 18.000 and 17.900 over 20 m, start the pipe. The box shows the same two buttons plus a **Cancel** button, and a line under the question: "Cancel (or Esc, or the X) places no pipe." Press the X: no pipe, and the command line says "[CE] Grade mismatch box cancelled - no pipe placed. Run CD again to place it (nothing was changed)." Enter still presses "Keep 1 IN 100".
3. **What you see with it OFF:** exactly the old box. Two buttons, no Cancel, X or Esc places the pipe with the typed 1 IN 100.
4. **One thing is still wrong, and it is a separate fault.** Codex (A78c, 1 Nov 22:07, Civil 3.0.88) found that **Esc does not close the box at all**. The Cancel button works; the Esc key does nothing, even though the code says it should cancel. The X on 3.0.88 was not re-tried in that look. So "X cancels" is built but not yet proven in AutoCAD, and "Esc cancels" is seen failing.
5. **My mistake, in the open:** I did not run AutoCAD or any test (not allowed in this job). Everything below is read from the code. I do not know why Esc fails. My guess (not verified): the Esc binding sits on the whole window and the focused "Keep" button or AutoCAD's own window handling swallows the key.
6. **Your call, one line:** "Keep X = Cancel as the default (option a), and let a follow-up fix Esc?" Recommended: **yes**.

## Technical detail

**Where the box opens.** `Modules/Drainage/Commands/CdCommand.cs` around line 585-600 on the release branch: after `TryDetectCustomGradeMismatch` (typed grade differs from the grade the inverts give by more than the Settings tolerance, default 10%), it builds `Dialogs.GradeMismatchDialog(typedN, actualN, mismatchCloseCancels)` and shows it through `DialogService.ShowDialog`. The "Keep 1 IN {typed}" text is `KeepTypedLabel` in `Modules/Drainage/Dialogs/GradeMismatchDialog.xaml.cs`.

**What the X returned, before the fix (the fault as reported).** The dialog's `UseActual` was a plain bool that started false, and only the two buttons set it. Closing with the X left it false and the caller only acted when "Use actual" was chosen, so the pipe went ahead with the typed grade. That is the symptom in the carpark entry. (On master, which is stale, the code is still like this; the release branch is the current code.)

**Option (a): X counts as Cancel.** Already built on the release branch.
- Size: about 34 lines added in the dialog, about 8 in `CdCommand.cs`, a new 35-line `Rules/GradeMismatchChoiceRule.cs`, one setting `MismatchBoxCloseCancels` (default true) in `UserSettings.cs`, tests `Bug857GradeMismatchBoxTests.cs` and entries in the new-switch-defaults test.
- Behaviour: Cancel button, Esc and X all return Cancel, `CdCommand` returns false (no pipe, nothing drawn, so nothing for Undo to undo), one command-line line says so.
- Cost if kept: nothing more to build. Left to do is the Esc fault below and a Codex or robot look.

**Option (b): the box says plainly what the X does.** Not built.
- Size: one text line in `MismatchBody` (for example "Closing this box with the X places the pipe with Keep 1 IN {typed}") plus one test; about 3 lines, no new setting if the behaviour stays as it was.
- Cost: a drafter who closes the box to back out still gets a pipe on the drawing and has to Undo. That is the surprise Codex logged three times (20 Oct, 23 Oct, and again on 3.0.64).

**Recommendation: keep (a) as the default.** It matches your rule UX-WIN-01 ("Enter = Apply, Esc = Cancel", 25 Sep), places nothing on the drawing when cancelled so Undo has nothing to do, and the old behaviour is one Settings switch away. (b) leaves the surprise in place and only explains it.

**Open fault: Esc does not close the box (BUG-857 note, A78c).** Facts from the code: `GradeMismatchDialog.xaml` line 13 has `<KeyBinding Key="Escape" Command="{Binding EscapeCommand}"/>` on the window, and `EscapeCommand` returns `CancelCommand` when the switch is on. The code looks right, so the cause is in how the key reaches the window; I did not find it by reading. A plain candidate fix (about 2 lines, in the same switch): mark the Cancel button `IsCancel="True"` so WPF itself maps Esc to it. Caveat, not verified: the button is Collapsed when the switch is off, and I have not confirmed that a collapsed button still receives Esc, which is harmless (off means old behaviour). That belongs in a window brief for Codex (windows are Codex-owned) and needs a Codex look to prove it.

**Not proven:** X on 3.0.88; Esc (seen failing); that Undo and REDO are untouched (read only: the cancel path returns before any drawing write, so I expect they are, but nobody has run it).

**Robot case to prove it (style N31_dp_time), for whoever builds it:** type CD, Custom grade `100`, first invert `18.000`, second `17.900`, pick two points 20 m apart, Start Pipe; when "Grade mismatch" appears press **Cancel** and check the command-line line starts "[CE] Grade mismatch box cancelled" and the pipe count in the drawing is unchanged. Switch-off control: set `grade.mismatchBoxCloseCancels` to false before launch, repeat, close with the X and check the pipe count rises by one with label "1 IN 100". The X and Esc halves need Codex (the key press and the corner button must be seen).
