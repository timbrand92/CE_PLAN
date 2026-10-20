# Robot gaps from run 32 (Mon 19 Oct 2026)

Source: `areas/release-v3-colleagues-CLAUDE_DRIVER_RUN32_V2_2026-10-19.md`. These are driver or fixture problems, not product bugs, so none is in the bug carpark. Each says what cannot be tested, why, and the smallest change that would unblock it. Nothing here changes a driver file; the driver owner decides.

1. **New Pipe "More..." button refused (blocks #1437, same-plan break and its Cancel).** Untestable: CD with a same-plan break asking the real length first, the 50 m on a drawn 20 m, and Cancel bringing the line back. Why: the break choices sit behind "More..." in the New Pipe window and `ui press "New Pipe" "More*"` is refused by the V2 press allow-list. Smallest change: add "More..." (press only) for windows like `*New Pipe*` to the allow-list, after review.
2. **No drawn Pit Schedule in the test copy and Place cannot be driven (blocks B9, B10).** Untestable: FROM keeps a real pit's number ("C" becomes "C1"), typed figures following their pit, a continuation sheet repeating the pit number. Why: the fixture has no table object, and "Continue to Place / update" is disabled and not on the press list. Smallest change: either a fixture copy that already holds a drawn Pit Schedule table, or "Continue to Place / update" on the allow-list for the Pit Schedule window.
3. **`answer` refused for a path question (blocks CDCHECKDWG).** Untestable: the "damaged data could not be read" line. Why: `answer ""` is refused because the command-line lines show no CE command at a prompt. Smallest change: allow `answer` for the CDCHECKDWG path prompt, or try `type "CDCHECKDWG`n"` once as a reviewed chain; plus a fixture with a damaged record.
4. **No damaged-record fixture (blocks B8 and B19).** Untestable: a failed read in CDCHECKS showing "CE could not check ...", never a green Network OK. Why: no copy with a damaged record exists. Smallest change: one fixture copy with a deliberately damaged pipe record.
5. **No merged inlet row in the fixture (blocks B11).** Untestable: merged rows keep their own pipe. Why: each downpipe has its own row. Smallest change: a fixture copy where two downpipes enter one pit on one row.
6. **CDPROPAGATE low-end and locked-layer cases not attempted (B16, #1400, BUG-782, BUG-797).** Why: a pipe drawn from the low end may raise the Uphill message box, which `msgbox-answer` refuses. Smallest change: allow `msgbox-answer` for the Uphill box, or a fixture pipe already drawn from the low end with a typed level.
7. **CDTAG cannot pick an already-tagged block by a typed point, and pick-first did not work (B14).** Untestable: CDTAG retag refusal (BUG-814 part 1), tag removal (BUG-746). Smallest change: a fixture with two ordinary untagged source blocks, or a verb that selects by handle and then passes it to the command.
8. **CDFIXTAGS fixture is two pit blocks, not two ordinary source blocks (B13).** Untestable: whether the rename applies on a real doubled source (BUG-813, 740, 741, 744, 746). Smallest change: a fixture with two ordinary source blocks both tagged DP3, and one with a multi-word tag ("ROOF DRAIN 1").
9. **`ui windows` and `ui close` hang while a command waits at a prompt (C.3).** Two HARD TIMEOUTs, no harm. Smallest change: a driver rule to run `esc-prompt` first, or have the verbs return at once when a prompt is active.
10. **Slow presses hit the 30 s watchdog.** "Start Pipe" took 41.3 s and "Close" on the Checks list 38 s. Smallest change: add both to `slow_press`.
11. **Pit Schedule read is at the node cap.** `ui tree -Depth 6` read 399 of 400 nodes with one new pit; one more row truncates. Smallest change: raise the node cap, or add a "schedule rows" verb.
12. **Tidy labels Apply, U and REDO of an apply, locked layer and timing figure were not tested.** Why: the case never got past "No clear spot found". Smallest change: none until the tidy bug is fixed; then repeat on the same fixture.
13. **Cosmetic false alarm "AutoCAD may be waiting at a prompt" after CDTAG and CDSYNC** (completed true, no command active). Smallest change: have the driver check the active-command flag before warning.

## Codex L4 blocked looks (19 Oct)

Source: `CODEX_LOOK_L4_20261019_1502.md` (Codex mouse look on installed Civil 3.0.56 / Manager 1.1.56 / Structural 1.0.118). 10 of 17 looks BLOCKED; none is a product fault. Product outcome for each is untested.

1. **L4-02 (Tidy labels on two clashing labels), L4-03a (end grip), L4-03b (label grip), L4-03c (arrow grip), L4-04 (grip copy against plain COPY), L4-06b (pad grip and schedule), L4-06c (rebar live length), L4-09 (CEBLOCKS live placement): the mouse tool cannot move the cursor without clicking.** Every one of these needs click, move without click, screenshot, click. Smallest change: a mouse verb that moves the cursor and holds (hover or drag with the button held), and a Ctrl-held click for L4-04.
2. **L4-06a (Q leader note): typed text became a paste command.** Typing CODEX ARROW at 'Enter first line of annotation text <Mtext>:' produced '_pasteclip / Specify insertion point:' (the third time, after BUG-749). Smallest change: send text to the prompt by a different input method (typed keys, not a paste shortcut) and confirm the prompt shows the text before Enter. Not a CE fault yet.
3. **L4-06d (Structural checklist splitter): the splitter target could not be found.** A 150-pixel drag from the apparent divider did nothing visible, and no close control for the docked palette was identified (it stayed docked until AutoCAD exit). UNSURE. Smallest change: name the splitter and the close control in the look card, or read them from the window tree; then repeat. If the palette truly has no close control, that is a new finding for the Structural lane.

## Run 33 (19 Oct night, Civil 3.0.57): new robot gaps

These are driver or fixture problems, not product bugs. Source: CLAUDE_DRIVER_RUN33_V2_2026-10-20.md.

1. **"Design Warnings" OK press hits the 30 s watchdog.** Untestable: a normal CD run ends cleanly; the press works but the call is cut off and the settings guard defers recovery until quit. Why: the press is not on the slow list. Smallest change: add the Design Warnings OK button to the driver's `slow_press` list (Start Pipe and Checks Close had the same shape in runs 31 and 32).
2. **The docked Checks list cannot be counted past 20 rows.** Untestable: how many R-06 rows exist (BUG-815) beyond the 20 the command line prints. Why: the docked list is virtualised, so `ui tree` shows only the visible items. Smallest change: a CDCHECKS export to a text file, or a driver verb that scrolls and re-reads the list.
3. **Settings switches are read when AutoCAD starts.** Untestable: any run that sets a switch mid-session. Why: the guard changes the file but CE does not re-read it. Smallest change: say so in driver guide 9.3 and make `settings-temp set` print a warning while a test AutoCAD is running.
4. **One launch per session blocks paired controls.** Untestable: the BUG-825 control (6.0 gives no warning) and the old-file path (3.0 with no flag moves to 6.0 once and says so). Why: each needs its own start with a different settings file and the session allowed one launch. Smallest change: allow two launches per session, or a scripted pair of sessions.
5. **Manager Admin Dashboard tabs cannot be read.** Untestable: BUG-835 (which machine reads as behind). Why: the Machines and Updates tabs need a tab click and the read-only rule forbids clicks. Smallest change: allow-list a tab-select on that one window, or read the tab content through the tree without a click.
6. **Settings window and Manager Civil page are forbidden.** Untestable: Reset and Save touching only what changed (BUG-830, BUG-839) and the full BUG-825 save-and-restart chain. Why: the brief bans the Settings window. Smallest change: a Codex look on a test copy of the settings file, with the file hash checked before and after.

## Run 34 (20 Oct, Civil 3.0.58): new robot gap and one gap closed

These are driver or fixture problems, not product bugs. Source: CLAUDE_DRIVER_RUN34_V2_2026-10-20.md.

1. **A block's extents cannot be read.** Untestable: why BUG-141 still names "the block Drawing Border" as the obstacle on DRV1_B1 (run 34 B item 8, "I cannot say why from here"). Why: no read-only driver verb returns a block's bounding box or its attributes, so the border's size cannot be set against the label's search window. Smallest change: a read-only driver verb that prints one object's extents (by handle or block name) and the search window the Tidy labels command would use; or a Codex look in AutoCAD with the Properties palette on the border block.
2. **Closed in run 34: counting R-06 rows past 20 (run 33 item 2).** `CDRULES` with the keyword All saves the whole list to the CE log folder as `cdrules-<drawing>-<time>.txt`, readable without any driver verb. Run 33 item 2 can be treated as closed by that route. Still open as an observation, not a gap: the docked Checks list shows only "Look at" and "Ignored" tabs, so "not known" rows are not listed there.
## Run 35 (20 Oct, Civil 3.0.59): one gap partly closed, two carried

These are driver or fixture problems, not product bugs. Source: CLAUDE_DRIVER_RUN35_V2_2026-10-20.md.

1. **Gap 12 (Tidy labels Apply, U and REDO) is partly closed.** Reachable now: put the start text onto the pit with a typed MOVE, then `CDTIDYLABELS`nAll`nYes` (Apply), `U` and `REDO` all work. Still untested: Apply on a locked layer and the timing figure.
2. **Still open: a block's extents cannot be read** (run 34 gap 1), and it is now the only missing evidence for the BUG-141 Drawing Border half (second attempt that did not take). Smallest change: allow one read-only LISP line (`-AllowLisp`, as already used to read a text's handle) that prints a block's name, layer and bounding box by handle; or a Codex Properties look at the Drawing Border and "SC" blocks. Proposal only, no command is added by this note.
3. **Cosmetic false alarm "AutoCAD may be waiting at a prompt" after CDSYNC** seen again (gap 13). The same words on the first CDTIDYLABELS were a real wait at "Move this label now?", so the alarm cannot be silenced blindly: the driver should check the active-command flag before warning.

## Run 36 (20 Oct, Civil 3.0.60): one gap closed, two carried, one tooling note

These are driver or fixture problems, not product bugs. Source: CLAUDE_DRIVER_RUN36_V2_2026-10-20.md.

1. **Run 34 gap 1 and run 35 item 2 (a block's extents cannot be read) are closed by a different route.** Turn debug logging on and read the CE log: it prints the block's name, layer, corners and the search window it was kept against. No new driver verb is needed. Still missing: a log line for a TEXT obstacle (the "SC" text), proposed as a lane 04 fix queue line (triage file section 17).
2. **Tooling note: debug logging must be set through the settings guard BEFORE launch.** CE reads `options.debugLogging` at AutoCAD start, so a mid-session set does nothing. Run 36 set it before `launch`, read it back from the file (line 158), and the guard restored it to `false` afterwards.
3. **Still open: CDSURVEY has no typed form** (BUG-709 UNPROVEN). It needs a survey XREF or survey DWG and answers the driver cannot type. Smallest change: a fixture drawing with a survey XREF attached, plus a typed form for the answers.
4. **Still open: the same-plan break question (BUG-683) is blocked at "More..." on the New Pipe window** (run 32 item 1): the press allow-list refuses it. Not retried.
5. **Cosmetic false alarm "AutoCAD may be waiting at a prompt" after CDSYNC** seen again (gap 13); `status` right after showed CMDACTIVE=0.

## Run 37 (20 Oct, Civil 3.0.61): two gaps carried, one CE wording gap filed

Source: CLAUDE_DRIVER_RUN37_V2_2026-10-20.md.

1. **Callout drag words ("Would sit on top of ...") still have no typed form.** They appear only while a callout point is dragged with the mouse, and the driver has no hover or drag verb. UNPROVEN for the third run. Smallest change: a drag verb (press, move, release at drawing points) on the driver allow-list.
2. **The Tidy labels "Will move 1 ..." line does not name which pipe's text moves** when an ordinary block is the cause. That is a CE wording gap, not a driver gap: filed as BUG-856 (LOW).
3. **PIT leaves a "Pick the next pit" prompt after the label step**, so a typed CD command behind it is rejected as BUSY. The pass must send `esc-prompt` until "[CE] Stopped" before a typed CD. Tooling note for the driver notes.
4. **Stale helper name after a second lock:** four `settings-temp set` calls were refused with "LOCKED by Claude-run37b" because the helper kept the session 1 name. Refused safely, nothing changed. Tooling note: pass the holder name from the current lock.
5. **Still open and carried:** CDSURVEY (BUG-709) and the same-plan break (BUG-683) have no typed form; not asked this run. Cosmetic "AutoCAD may be waiting at a prompt" false alarm after CDSYNC seen again (gap 13).
6. **Closed again by the log route:** a block's extents are read from the CE debug log (settings guard before launch). The sheet-frame line prints no numbers; low-priority wish list for the desk.

## Run 39 (20 Oct, Civil 3.0.63): the file-dialog verb broke, three evidence limits

Source: CLAUDE_DRIVER_RUN39_V2_2026-10-20.md.

1. **dialog-path fails in this driver version: "Unable to find type [System.Windows.Automation.AutomationElement]".** It worked on 18 Oct (driver v2 report) and failed twice on 20 Oct, so BUG-505 (the CHECK THE SCALE line in the X-Civil import) is BLOCKED and every file-dialog check stays blocked. Likely cause (from the error text only, nobody has read the verb): the verb does not load the Windows UI Automation parts (Add-Type -AssemblyName UIAutomationClient and UIAutomationTypes) before it uses them. **This is a driver change and was NOT made here.** Editing the driver changes its hash, so it is the **next driver-v3 task for the desk**. When it is done, every place that quotes the driver hash must change: the driver-hash check line in each test brief (the old value is 120EE24D15B2 for acad_driver_witness_v2.ps1; the allow-list 5B542F2145F4 changes only if the allow-list file is edited), the desk continuity record, and the start-of-pass and end-of-pass hash checks in the next run job. Until then the safe rule for a tester: do not press "Choose DWG..." (or any button that opens a Windows file dialog) unless dialog-path is proven first on a harmless target.
2. **An open Windows file dialog blocks quit and needs quit -Kill.** The dialog is not on the allow-list, so ui close is refused and quit says AutoCAD did not close gracefully. quit -Kill worked (it only killed the AutoCAD the lock file names, restored the settings and released the lock). Folded into item 1: once dialog-path works, the next tester should be able to cancel the dialog with it.
3. **Manager windows are read-only for the driver, so the first-administrator wording (BUG-476) cannot be read.** The question sits behind a Set-up button and the driver never presses Manager buttons. UNPROVEN until Codex or Tim looks. No driver change proposed: this is the read-only rule working as intended.
4. **The telemetry outbox file cannot show heartbeat content (BUG-557).** On this PC the file stays a 3-byte marker (0 lines) with the switch ON or OFF, so the only evidence is the modified time (moves at start-up with ON, does not move with OFF). A line-level proof would need the cloud settings unset for a test run, which the robot must not touch. Accepted as a limit of the evidence.
5. **New typed form for the gaps list: CDTWL.** type "CDTWL`n10`n18.70" -Enter -Force (volume 10 m3, then a top water level of 18.70 m) works; the lone answer "10" at the volume prompt was refused with lost_foreground, so send the whole answer sequence in one type string.
6. **Carried:** the cosmetic "AutoCAD may be waiting at a prompt" false alarm after CDSYNC (gap 13); the What's New palette is closed by the first quit.

## Run 40 (20 Oct, Civil 3.0.64): right-click items cannot be driven, one launch anomaly

Source: CLAUDE_DRIVER_RUN40_V2_2026-10-20.md.

1. **Right-click menu items cannot be driven.** "CE: Select this run" and "CE: Select whole network" (BUG-416, #1170) exist only as AutoCAD right-click menu items, and the driver has no right-click verb, so the REDO-after-selection check is UNPROVEN. Desk idea only, nothing invented here: either a driver verb that can open a right-click menu, or a typed command that calls the same two actions. Either is a change for the desk to decide; until then it needs Tim or Codex by hand.
2. **One launch anomaly, watch whether it repeats.** `launch` returned ok:false after 240 s ("AutoCAD did not become idle on the drawing"), but AutoCAD was running and Civil had logged Started. The Explorer hand-off did not open the drawing; the driver's own `open -Writable` worked in 4 s. Earlier launches took 22 to 29 s. One occurrence only: note it, and see whether the next runs show it again before treating it as a fault.
