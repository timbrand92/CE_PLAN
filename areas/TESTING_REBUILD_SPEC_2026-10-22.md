# Testing rebuild: a deterministic test pack (spec, 22 Oct 2026)

Written Thu 22 Oct 2026, about 21:45 to 22:30 Melbourne time, by the desk design job (Opus). **Design only: nothing was built,
AutoCAD and Codex were not started, no settings file or bundle was touched.**
Tim, 22 Oct 21:40: "we need to resolve this testing business, it's not good enough".

Sources read for this spec: `C:\TimOS\RULES.md`; `C:\Lisp Files\_ACAD_DRIVER\README.md`, `DRIVER_TESTER_GUIDE.md` (section 9),
`TYPED_FORMS_S8_C9.md`, `UI_MAP_2026-10-03.md`, `UI_MAP_SESSION7_2026-10-03.md`, the head of `driver_v2_selftest.ps1`, and in
`acad_driver_witness_v2.ps1` the header, verb table, `Initialize-Uia`, `launch`, `quit`, `shot`, `click-canvas`, `dialog-path`, the
allow-list pin and the settings guard; the memory notes `acad-driver-cli`, `accoreconsole-plugin-probe`, `driver-v2-typing-quirks`,
`driver-settings-guard-read-at-launch`, `cdrules-all-saves-full-findings-file`; robot runs 44 to 47; Codex V4 to V10 (heads and fault
lines); `LOG_OUTCOMES_2026-10-22.md`; `decisions\2026-10-20_TIM_ANSWERS.md` item 17; `QUESTIONS_FOR_MONDAY.md` (22 Oct block); the
queued phase 1 job `desk_jobs\tester_run48_driver_v3_phase1.txt`. `CODEX_ACCEPTANCE_BACKLOG_22OCT.md` **does not exist**: the open
items below were collected from the run reports instead.

---

## FOR TIM (answer first)

1. **What goes wrong today.** About 25 AutoCAD test runs since 18 Oct gave almost no accepted items. Two AIs "drive" AutoCAD by
   hand, one step at a time. Codex fails to start about half the time and types into the wrong place (every line became
   PASTECLIP). The Claude robot cannot double-click, right-click or read some CE windows, and runs out of steps. An item needs
   BOTH of them, so one bad run blocks it.
2. **The fix in one line.** The AI stops driving AutoCAD. It **writes a test as a short text file** (open this drawing copy, do
   these steps, check these results). A **plain machine runner** then plays 50 to 150 of those tests by itself, overnight, in
   under an hour, the same way every time, with no AI in the loop while it runs.
3. **Example.** Test C05 says: open a copy with downpipe DP1, double-click the downpipe circle, check the "Edit source" window
   opens with DP1 in the Tag box, press Cancel, check the drawing still says DP1. The runner does it, writes PASS or FAIL with
   the exact line it saw, and takes a picture of the window.
4. **Codex only looks at pictures.** The runner opens each window and saves the picture. Codex gets a 3 KB note with 3 to 5
   pictures and answers "looks right / looks wrong". It never touches AutoCAD again, so it can no longer type into the wrong
   place or leave AutoCAD running.
5. **What the runner adds that the robot lacked:** real double-click, right-click, hover and drag on an exact drawing point;
   reading every box and button of a CE window; and a clean start and finish every time (AutoCAD closed, your settings put back
   and proved by fingerprint).
6. **Build plan:** four steps, each one AI job with its own self-test that must pass. Step 1 is already queued for tonight. The
   first 40 tests are listed in section 5. Target: the first 10 tests running by the end of step 2.
7. **One decision for you (section 4), recommended answer YES:** a logic result (a drawing value, a log line, a command-line
   message) is accepted when the runner passes it **in two separate AutoCAD sessions** on the same build. Anything you would
   look at (a window, wording, a hatch's look) still needs a runner PASS **plus** a Codex look at the runner's picture.
   Engineering choices still need your word. On a job this means: "the pipe moved to layer 0 adds one wrong-layer row" can be
   accepted by the machine; "the About window is not clipped" still needs Codex's eyes.
8. **Not tested by this spec:** nothing in it has run. Risks it must prove first are in section 6.

---

## 1. Architecture

### 1.1 Plain English

1. **A test pack is a folder of text files.** One file = one test (a "case"). Each case names a master drawing, the settings it
   needs, numbered steps, and the checks to make.
2. **A runner plays the cases.** It is a PowerShell script on this PC. It uses the existing safe driver (driver v2) for the
   lock, the settings guard, starting AutoCAD and ending it. It adds the missing hands (mouse) and eyes (window reading).
3. **No AI at run time.** The runner follows the file exactly. The same file gives the same result every time, or it tells us
   AutoCAD or CE behaved differently.
4. **Every case starts on a fresh copy** of a master drawing and never saves over anything. Your settings are changed only
   through the settings guard and are put back and proved by fingerprint (SHA-256) at the end.

### 1.2 Files and folders (all new; driver v2 stays untouched)

1. `C:\Lisp Files\_ACAD_DRIVER\acad_driver_v3.ps1`: the NEW verbs only (pointer, window reading, fixed file dialog, entity
   reads, lifecycle). It calls `acad_driver_witness_v2.ps1` as a child process for every verb v2 already has (lock, launch,
   type, quit, settings guard, pick-first, msgbox-answer, save-copy). v2's guards therefore still apply to everything v2 does.
2. `C:\Lisp Files\_ACAD_DRIVER\acad_driver_v3.allowlist.json`: the windows v3 may read and the buttons it may press. Pinned by
   SHA-256 inside `acad_driver_v3.ps1`, the same way v2 pins its own list (section 6.6 says who edits it).
3. `C:\Lisp Files\_ACAD_DRIVER\pack\pack_runner.ps1`: reads case files, groups them into AutoCAD sessions, runs them, writes the
   reports.
4. `C:\Lisp Files\_ACAD_DRIVER\pack\cases\C01_lifecycle.case.txt` and so on: one file per case.
5. `C:\Lisp Files\_ACAD_DRIVER\pack\fixtures.json`: the master drawings the pack may copy, each with its SHA-256. Masters live in
   `C:\ce_rc_drv\pack_fixtures\` (copied once from the existing `DRV*` masters, never edited afterwards).
6. Run output: `C:\Lisp Files\_TEST_COPIES_20260923\pack_runs\<run id>\` (copies, pictures, `report.json`, `report.md`). This
   folder is local only and never goes into a repo (pictures can show drawing content). The Markdown report is copied to
   `C:\CE_PLAN\areas\PACK_RUN_<run id>.md` by the desk with drawing paths removed.
7. `C:\Lisp Files\_ACAD_DRIVER\v3_selftest.ps1` and `pack\pack_selftest.ps1`: the phase self-tests.

### 1.3 The case file (plain text, one step per line)

Example (illustration of the format; real names are filled by the phase 2 builder from the UI map and `ui-dump`):

```
CASE      C05
TITLE     DP1 Edit source: Cancel changes nothing
PROOF     deterministic            # or: look  (a Codex look card is produced from the pictures)
FIXTURE   PKFIX_DP1                # name in fixtures.json; the runner copies it to CLDP<run>_C05.dwg
PROFILE   default                  # settings profile (section 1.5); cases with the same profile share one AutoCAD start
TIMEOUT   90                       # seconds for the whole case
STEPS
  1  ent-find      $dp  block name=CE_DP attr TAG=DP1     # COM read, no LISP
  2  pt-dblclick   ent $dp part=outer-circle
  3  ui-wait       "Edit source" 10
  4  ui-read       "Edit source" "Tag" -> $tag
  5  shot          "Edit source" C05_edit_source
  6  ui-press      "Edit source" "Cancel"
  7  ui-wait-gone  "Edit source" 10
  8  wait-idle     20
ASSERT
  1  equals        $tag "DP1"
  2  history-new   has "Nothing was changed"
  3  ent-attr      $dp TAG = "DP1"
  4  log-new       civil absent "[ERR]"
```

Rules for the format:
1. `#` starts a comment. `$name` holds a value read by a step. Text with spaces goes in double quotes.
2. A step that cannot be done (window never opened, verb refused) stops the case as **BLOCKED**, not FAIL, with the refusal text.
3. `pack validate <file>` checks a case offline (known verbs, quotes, fixture exists, profile exists) before any run.
4. Cases never contain SAVE, a drawing path outside the pack folders, or a raw LISP line (see 1.4 item 4).

### 1.4 Step kinds

The verbs marked (v2) already exist and are proven; the runner calls driver v2 for them. The rest are new in v3.

1. **Typed command and answers (v2 `type`).** Always the complete chain in one string (`"CDTWL`n10`n18.70"`), never a bare command
   left waiting (the 15-minute wedge rule). Keyword defaults by a second line break (memory `driver-v2-typing-quirks`).
2. **Esc at a waiting prompt (v2 `esc-prompt`)**, **Edit Pipe message box (v2 `msgbox-answer`)**, **select by handle (v2 `pick-first`)**,
   **save and reopen a copy (v2 `save-copy`, `reopen-copy`)**.
3. **System variables.** `getvar` through COM (v2). `setvar` in v3 only for names on the v3 allow-list, each marked `drawing`
   (saved in the drawing, harmless on a copy, for example DIMSCALE, INSUNITS, CLAYER) or `profile` (kept in Tim's profile, for
   example OSMODE, PICKFIRST, DBLCLKEDIT): a `profile` variable is read first, set, and put back at the end of the case and again
   at quit, and the case FAILS LOUDLY if the read-back differs.
4. **Reading values without LISP.** A typed LISP line wedged AutoCAD in run 47 (1.7 cores, only a kill helped). So v3 reads the
   drawing through COM, which never waits at a prompt: `ent-read <handle> <property>` (Layer, ObjectName, TextString,
   PatternName, PatternScale, InsertionPoint, Center, Radius, the attributes of a block) via `HandleToObject`; `ent-find` (all
   objects matching type, layer, block name, attribute value, through a COM selection set with a filter, deleted afterwards);
   `ent-count` (same filter, returns a number); `layer-read <name>` (colour, linetype). LISP stays allowed only inside the
   proven v2 `pick-first` route.
5. **Command-line history (v2 `history`)** and **new history since the step** (`history-new`, read by byte offset from AutoCAD's
   own log file, so old lines never count).
6. **CE logs by byte offset.** The runner records the size of each CE log at case start (Civil `CE_CVL_SUITE.log` and
   `ce_cvl_structured_<date>.log`, Structural `ce_struc_suite.log` and `ce_struc_structured_<date>.log`, Manager log) and reads
   only the bytes written after it. Assertions: `log-new <log> has "<text>"`, `absent "<text>"`, `count "<pattern>" = N`. The
   Civil outcome line format seen in runs 46 and 47 is `[INFO] Command outcome: <COMMAND> completed|cancelled|failed <n> ms`.
   The runner never deletes or edits a log (run 44 deleted two Structural logs by a typing slip: the runner has no delete verb
   for logs).
7. **Settings fingerprints.** The four files (CE `CD_Settings.json`, `TIM_CE_CADTOOLS\CS_Settings.json`, `CE_CVL_SUITE\settings.json`,
   Structural `CS_Settings.json`) are hashed at pack start, before and after every session, and at pack end. Expected at the
   time of writing (desk record item 32): CD ACD64E79A33B, CS 622A246F7D3B, settings.json EFE307C4FC74, Structural 2972CE70C514.
   Note: run 46 saw CE itself rewrite the Structural file at start-up (F68292935180 to 2972CE70C514); the runner reports such a
   change as "changed by CE at start, not by the runner" when it happens before the first step.
8. **Pictures (v2 `shot`, plus a check).** Every picture is saved with its SHA-256. Two pictures in one run with the same
   SHA-256 but different names make the second one **DUPLICATE** (Codex V4 had 35 identical pictures). A one-colour picture is
   **BLANK**. Neither can be used as evidence.
9. **NEW: pointer actions (v3).** `pt-click`, `pt-dblclick`, `pt-rclick`, `pt-hover`, `pt-drag`. Target: a world point `x,y`, or
   `ent $var part=<name>` (a point on that object worked out from its COM geometry: on the circle line, the insertion point of
   an attribute, the midpoint of a pipe line). How it works:
   1. Read the view while AutoCAD is idle: VIEWCTR, VIEWSIZE, SCREENSIZE, VIEWDIR, VIEWTWIST, WORLDUCS, PERSPECTIVE, CTAB (the
      same reading v2 `click-canvas calibrate` makes). Plan view of the world, no twist, no perspective, Model tab only; anything
      else is refused in phase 1 (UCS and twist support can come later with its own proof).
   2. Find the drawing area window inside AutoCAD whose size equals SCREENSIZE (v2 `Find-V2Canvas`) and read its screen
      rectangle from Windows. The driver process declares itself per-monitor DPI aware before reading any rectangle, so the
      numbers are real pixels on the 5120 x 1440 screen, never 96-DPI guesses.
   3. Pixel = canvas left + width/2 + (x - centre x) x (height / VIEWSIZE); pixel y = canvas top + height/2 - (y - centre y) x
      (height / VIEWSIZE).
   4. Before any event: AutoCAD is the foreground window; the window under the target pixel is the drawing area (v2
      `ClassifyPoint`), so a CE palette or another program in the way refuses the action; `SetCursorPos`, then `GetCursorPos`
      must read the same pixel (this is the pointer check; `(grread)` is NOT used because it waits for input like a prompt).
   5. Events by `SendInput`. Double-click = two down/up pairs inside the Windows double-click time and distance. Right-click =
      right down/up. Hover = move, then wait the given milliseconds. Drag = left down, at least 10 moves along the line, left up.
   6. After the action the mouse is put back where it was.
   7. Preconditions read and recorded for every pointer case: PICKFIRST, DBLCLKEDIT, SHORTCUTMENU, SELECTIONPREVIEW, ROLLOVERTIPS.
      A case that needs a value different from Tim's profile sets it with the `profile` rule in item 3.
   8. **Human-at-the-PC guard.** Pointer actions move Tim's real mouse. Before every pointer step the runner reads Windows'
      last-input time; if a human used the keyboard or mouse in the last 120 seconds (input the runner did not make), it waits
      up to 10 minutes, then marks the remaining pointer cases BLOCKED ("PC in use"). The pack also refuses to start inside
      Tim's AutoCAD in-use hours (RULES 1.8: weekdays 8:30 am to 2:00 pm and 3:00 to 5:30 pm Melbourne).
10. **NEW: window reading (v3 `ui-dump`).** Lists every control of one window as JSON: control type, name, automation id, value,
    on/off state, enabled, visible, screen rectangle, and the tab it sits on. Works for CE WPF windows (Edit source, About CE
    Suite, Settings, X-Civil import, the Checks palette) and AutoCAD's own dialogs (Enhanced Attribute Editor). Reading needs the
    title on the v3 read list; pressing (`ui-press` by automation name or id) needs the button on the v3 press list. Windows UI
    Automation is loaded first in every v3 process (`Add-Type -AssemblyName UIAutomationClient, UIAutomationTypes`).
11. **NEW: the fixed file dialog (v3 `dialog-path`).** The 20 Oct fault "Unable to find type
    [System.Windows.Automation.AutomationElement]" is now explained by the code: in `acad_driver_witness_v2.ps1`,
    `Invoke-V2DialogPath` uses that type (`$A = [System.Windows.Automation.AutomationElement]`, about line 3211) **before** it
    calls `Get-UiWindows`, which is the function that loads UI Automation (`Initialize-Uia`, line 1039, called at line 1115).
    Every driver call is a fresh PowerShell process, so nothing had loaded it yet. Why it worked on 18 Oct is not known (I did
    not find out). v2 stays untouched; v3 carries its own `dialog-path` that loads UI Automation first, with the same refusals
    as v2 (test folders only, never a fixture master, never a Save dialog). It also gets a `dialog-cancel` (presses the Open
    dialog's own Cancel) so an open file dialog can no longer stop `quit` (run 39 needed a kill).
12. **NEW: safe lifecycle (v3 `session-run`).** For each session:
    1. No `acad.exe` running, the lock free, the settings guard empty, the four fingerprints read. Otherwise BLOCKED, nothing started.
    2. `lock acquire "Pack"`, then `settings-temp set` for each value of the profile (BEFORE launch: CE reads settings only at
       start, memory `driver-settings-guard-read-at-launch`).
    3. `launch` the first copy (Explorer route, v2). A "What's New" pop-up is dismissed by v2 `dismiss-modal`.
    4. **Ready check (echo round trip):** type `_.ID <run number>.<session number>,0` and wait for `X = <that number>` in the new
       history. Only then is the session ready. Fails twice = session BLOCKED.
    5. Cases run one after another. Between cases: `closeonly` the copy (never saved), `open -Writable` the next fresh copy.
    6. **End, always (a `finally` block, also on Ctrl-C and on the runner's own watchdog):** close any CE window still open
       through its listed Cancel/Close (read by `ui-dump`); cancel an open file dialog; `quit`; if AutoCAD is still there after
       60 s, `quit` again; if still there after another 60 s, `quit -Kill` (v2 kills only the AutoCAD it launched); then
       `settings-restore`; `lock release`; check that no `acad.exe` is left; re-read the four fingerprints and compare with the
       pack start; remove the stale `.dwl`/`.dwl2` lock files of the run's copies only.
    7. If any fingerprint differs after the restore, the pack STOPS (no further session) and the report's first line says so.
       This replaces the conveyor's hand clean-up.

### 1.5 Sessions and profiles

1. CE reads settings only at start-up, so cases that need a switch (for example `checks.allowIgnoreFinding` true) are grouped in
   one **profile**: one profile = one AutoCAD start. Profiles live in `pack\profiles.json` (name, list of settings-guard keys and
   values). `default` = Tim's settings unchanged.
2. The runner orders sessions by profile, then cases by number. Target: 4 to 6 AutoCAD starts for 40 cases.
3. Time budget (from runs 44 to 47): launch about 60 to 90 s, ready check 5 s, a typical case 20 to 60 s, Cascade Apply up to
   120 s, quit 5 s normally (but 240 s seen in runs 42, 45, 46: the 60 s + 60 s + kill rule caps it at about 2.5 minutes).
   Estimate for 40 cases: about 35 to 45 minutes. For 150 cases about 2 hours, so the full pack runs overnight and an
   "after install" pack of the 40 core cases runs in under an hour.

---

## 2. Assertions and result format

### 2.1 Plain English

Every test ends with one of three words and the line that proves it: **PASS** (every check true), **FAIL** (a check was false;
the actual value is shown next to the expected one), **BLOCKED** (the runner could not do a step; this is a tool problem, not a
CE bug). A FAIL is tried once more on a fresh copy before it counts.

### 2.2 Rules

1. **Assertion kinds:** `equals`, `history-new has|absent`, `log-new <log> has|absent|count`, `ent-read ... =`, `ent-attr`,
   `ent-count ... =`, `layer-read ... =`, `sysvar NAME = value`, `window-open "<title>"`, `window-gone "<title>"`,
   `control "<window>" "<name>" value|enabled|exists`, `file-hash <settings file> unchanged`, `file-exists <pattern>` (for
   example the `cdrules-*.txt` list that `CDRULES All` saves), `shot ok` (saved, not BLANK, not DUPLICATE).
2. **Evidence line:** each assertion writes the exact text matched or the value read (for example `log: [INFO] Command outcome:
   CDTWL completed 118 ms`, or `PatternScale = 125 (expected 125)`).
3. **Numbers** compare with a stated tolerance (`= 17.50 +-0.005`); without one they must match exactly.
4. **Flaky rule:** a FAIL is rerun ONCE straight away on a new copy in the same session. FAIL then PASS = **FLAKY** (never
   accepted, listed at the top of the report, the case gets a flaky count). FAIL then FAIL = **FAIL**. A BLOCKED case is not rerun
   (rerunning a tool fault hides it).
5. **Known-failure marker:** a case may carry `EXPECT-FAIL BUG-nnn` while a fix is pending. Its FAIL is then reported as "still
   fails (BUG-nnn, known)"; its PASS is reported as "now passes: candidate for acceptance". This keeps open bugs in the pack.
6. **Record-only cases** (`PROOF record`) collect a value for a decision that Tim has not made yet (for example which window a
   double-click on the green DP label should open, Monday question 3). They never PASS or FAIL; they report what happened.

### 2.3 Report

1. **Run id:** `PACK-<yyyymmdd>-<hhmm>-C<civil build>` (for example `PACK-20261023-0100-C3.0.70`).
2. **Header, read live, never from a document (RULES 8.4):** the product-version string of each loaded CE DLL (Civil, Manager,
   Structural) read from the installed bundle files; the AutoCAD version; the SHA-256 (first 12) of `acad_driver_witness_v2.ps1`
   (expected 120EE24D15B2), its allow-list (5B542F2145F4), `acad_driver_v3.ps1`, its allow-list, `pack_runner.ps1`, every
   fixture master; the four settings fingerprints at start and end; the screen size, the Windows scale factor of the AutoCAD
   monitor and the DPI awareness in use; start and end time (Melbourne).
3. **`report.json`:** one object per case: id, title, proof kind, profile, fixture, copy name, result, rerun result, duration,
   each step (verb, arguments, seconds, ok, refusal), each assertion (kind, expected, actual, evidence, ok), pictures (path,
   SHA-256, BLANK/DUPLICATE flags).
4. **`report.md`:** ANSWER FIRST (counts of PASS, FAIL, FLAKY, BLOCKED, still-failing known bugs, "now passes" candidates; any
   settings or lifecycle alarm first), then one numbered line per case with its evidence line. No tables.
5. **Look cards:** for every `PROOF look` case the runner writes `looks\<case>.md` (section 3) next to the pictures.

---

## 3. What stays with Codex

### 3.1 Plain English

Codex stops driving AutoCAD. The runner opens each window, takes the picture and writes what the window is. Codex only answers
"does this look right?" for 3 to 5 pictures at a time.

### 3.2 Rules

1. **Codex does only looks:** the appearance of a window (clipping, overlaps, layout), wording a human reads, what a hatch or a
   label looks like on the drawing (RULES 4.5 and 5.7). Everything else is decided by assertions.
2. **The runner does the pre-step** (open the window, set the zoom, hover the object, place the hatch at 1:20) and the picture,
   inside the pack run. Codex is never asked to start AutoCAD, type, click or quit. That removes the faults seen in V4 to V10:
   "native screen tools unavailable", PASTECLIP typing, wrong object picked, AutoCAD left running, the 5120 x 1440 versus
   1920 x 1080 scaling confusion.
3. **A look brief is about 3 KB** (today 35 to 45 KB): run id and builds (one line each); then per look: the picture path, one
   sentence on what the window or drawing area is and how the runner got there, two to four "right looks like" lines (for
   example "five rows, each with a version number, nothing cut off at the right edge"), and the answer format: `PASS`, `FAIL`
   or `UNSURE`, one sentence, and the area of the picture that decided it.
4. **One brief per pack run**, generated by the runner from the look cards (no hand-written briefs). The conveyor queues it
   after the run (section 7).
5. A picture flagged BLANK or DUPLICATE is never put in a brief; that look is BLOCKED in the report instead.
6. If Codex says FAIL or UNSURE, the desk reads the picture itself before raising a bug (RULES 6.1).

---

## 4. Acceptance rule proposal (for Tim to rule on)

### 4.1 In plain words

1. **Logic results:** a value in the drawing (a layer, a scale, a level, a tag), a CE log line, or a command-line message.
   **Proposal:** accepted when the deterministic case PASSES in **two separate AutoCAD sessions** (two pack runs, or two
   sessions of one run on two fresh copies) on the **same installed build**. Recorded as **"Pack-accepted (build, date, run
   ids)"**. Example: "moving pipe P3 to layer 0 adds exactly one wrong-layer row, and U takes it away" (C20).
2. **Things a person looks at:** a window, wording on screen, how a hatch or label looks. **Proposal:** accepted when the case
   PASSES (the window opened, every expected control and value is there, the buttons work) **and** a Codex look at the runner's
   picture from that same run says PASS. Recorded as **"Codex-accepted (build, date, run id)"**, exactly as today. Example: the
   About CE Suite window (C12) needs both: the runner proves the five version rows and the Close button; Codex proves nothing is
   cut off.
3. **Engineering judgement** (council values, design rules, sizing choices, any look-and-feel choice): still needs **Tim's word**,
   unchanged.
4. **Why this keeps the intent of RULES 13.3 (two independent proofs):** for logic, the two proofs are two separate AutoCAD
   sessions on fresh copies with no AI choosing anything at run time (today's "robot + Codex" pair proves the same thing less
   reliably). For windows, a machine proof and a pair of eyes stay separate, so RULES 5.7 ("a window is never accepted by a
   machine") still holds.
5. **What changes from today:** Codex looks at a picture of the real window taken on Tim's PC in real AutoCAD, instead of driving
   AutoCAD itself. RULES 4.5 says "a Codex PASS in real AutoCAD on Tim's PC (copies only, screenshots and the exact steps
   recorded)": the picture is from real AutoCAD on Tim's PC and the steps are the case file, but this is a change Tim should
   confirm.

### 4.2 The question for Tim (queue for work hours, RULES 1.8)

**Context:** testing is moving from "two AIs drive AutoCAD" to "a machine plays written tests; Codex looks at its pictures".
**Recommendation: YES to both parts,** because the machine is exact and repeatable and the two-AI route produced almost no
acceptances in 25 runs.
1. Logic items accepted by two passing pack sessions on the same build ("Pack-accepted")? YES / NO.
2. Window and wording items accepted by a pack PASS plus a Codex look at the pack's picture ("Codex-accepted")? YES / NO.

Until Tim answers, nothing is marked accepted by the pack alone; the pack results count as the "robot" half of today's rule.

---

## 5. The first 40 cases

Fixture names: `DRV1_B1` (Civil test drawing: pit 109D56, pipe P3 handle 10A98D used in runs 44 to 47), `DRV2_S1` (Structural),
`DRV15_METRE` (a metres source for the X-Civil import), `PKFIX_DP1` (NEW: made once in phase 2 by the case F01 below: a copy of
`DRV1_B1` with one downpipe DP1 placed by the DP command and saved through v2 `save-copy`; its hash goes into `fixtures.json`),
`PKFIX_TB` (NEW: a copy with a title block, if `DRV1_B1` has none: the phase 2 builder checks). Profiles: `default`, `checks-on`
(`checks.checksCommandEnabled` true, `layerChecks.wrongLayerRows` true), `ignore-on` (`checks.allowIgnoreFinding` true), `tidy-on`
(`linking.tidyLabelsEnabled` true), `pitlabel-on` (the pit-label double-click switch: key name to be read from source).

**F01 (fixture maker, run once, not counted):** fixture DRV1_B1, place a downpipe with the DP command chain (prompt order read
from source by the phase 2 builder), check one block with TAG = DP1 exists, `save-copy` as the master `PKFIX_DP1`.

### 5.1 Lifecycle and pointer proof

1. **C01 Clean start and finish.** Fixture DRV1_B1, profile default. Steps: session start, ready check, `closeonly`, session end.
   Assert: ready check line seen; no `acad.exe` after the end; lock free; four fingerprints equal to the pack start; no new
   `[ERR]` line in any CE log. **Deterministic.**
2. **C02 Pointer calibration.** Fixture DRV1_B1. Steps: `type "_.CIRCLE 1000,1000 200"`, read its handle with `ent-find`;
   `pt-click` a point **on the circle line** (1200,1000; a click at the centre of an unfilled circle selects nothing, so the
   phase 1 job's "click at its centre" is corrected here), read the pick-first set through COM; Esc; `pt-click` an empty point
   (5000,5000); repeat at three zoom levels (`_.ZOOM _C 1000,1000 1000`, `5000`, `20000`) and after `_.-PAN`. Assert: the set holds
   exactly the circle each time and is empty for the empty point; the computed pixel and the read-back cursor pixel agree within
   2 pixels. **Deterministic.**
3. **C03 Start-up log is clean.** Fixture DRV1_B1. Assert on the start-up bytes of every CE log: `[ERR]` count = 0; known
   warning lines listed (the pit-block "untrusted location" note seen in run 44 is reported, not failed). **Deterministic.**

### 5.2 Double-click and downpipe (BUG-859, #1499, BUG-860, pit-label switch)

4. **C04 DP1 double-click opens Edit source.** Fixture PKFIX_DP1. Steps: `pt-dblclick` on the DP1 outer circle line;
   `ui-dump "Edit source"`; `shot`. Assert: window "Edit source" open (not "Enhanced Attribute Editor"); Tag box value DP1.
   **Deterministic + look** (window appearance).
5. **C05 DP1 Edit source Cancel.** As C04, then `ui-press Cancel`. Assert: window gone; new history has "Nothing was changed"
   (exact wording from the #1499 card); attribute TAG still DP1 (COM). **Deterministic.**
6. **C06 DP1 tag change, U, REDO.** As C04, `ui-set "Tag" DP2`, press OK. Assert: TAG = DP2; after U TAG = DP1; after REDO TAG =
   DP2 and history has "Everything has been redone". **Deterministic.**
7. **C07 Other parts of the downpipe.** `pt-dblclick` on the red centre mark, then on the angled DP text. Assert: the window that
   opens for each (title from `ui-dump`) equals the #1499 card's expected window; close each by Cancel. **Deterministic.**
8. **C08 Green DP label (BUG-860).** `pt-dblclick` on the green DP label. Records the window or editor that opens (TEXTEDIT today).
   **Record-only** until Tim answers Monday question 3.
9. **C09 Pit label, switch off.** Profile default. `pt-dblclick` on a pit label of pit 109D56. Assert: AutoCAD's "Enhanced
   Attribute Editor" opens; press its Cancel; no CE window opened. **Deterministic.**
10. **C10 Pit label, switch on.** Profile pitlabel-on. Same double-click. Assert: "Creative Engineering | Edit Pit" opens with the
    pit's name in its name box; press "Cancel without saving". **Deterministic + look** (Monday question 2 asks for this look
    before the switch defaults to on).
11. **C11 Title block attribute.** Fixture PKFIX_TB. `pt-dblclick` on a title block attribute. Assert: AutoCAD's own editor
    opens, no CE window; Cancel. **Deterministic.**

### 5.3 CE windows

12. **C12 About CE Suite (BUG-852).** `type "CE_VERSION"`, `ui-dump "About CE Suite"`, `shot`, `ui-press Close`. Assert: five rows;
    the versions shown equal the DLL product versions in the report header; no row says CONFLICT or Not loaded; the window closes
    and AutoCAD is idle after (runs 44 and 46 could not close it and needed a kill). **Deterministic + look** (clipping, V5-02).
13. **C13 Settings window tabs.** Profile default, `settings-temp arm` first (v2 gate). `type "CDS"`, `ui-dump`, `ui tabs`, select
    each of the six tabs (Drafting, Pipes and Pits, Design, Survey, Display, Advanced) and `shot` each; press Cancel. Assert:
    six tabs; each tab lists more than 30 controls; status text "No changes. Everything shown is saved."; four fingerprints
    unchanged after quit. **Deterministic + look** (six pictures).
14. **C14 Settings Cancel discards.** `settings-temp arm`; CDS; `ui-set` "Minimum fall on a pipe, millimetres" to a new value
    (no key pressed: never Enter in this window); press Cancel. Assert: the settings file hashes are unchanged before the
    guard's restore runs (the restore must have nothing to do). **Deterministic.**
15. **C15 Checks palette list.** Profile checks-on. `type "CDCHECKS"` (chain form), `ui-dump` the Checks palette, `shot`. Assert:
    the row count read from the palette equals the totals line on the command line ("N to look at, N OK, N not known"); no row
    name shows a raw handle. **Deterministic + look.**

### 5.4 Ignoring a check (CDCHECKIGNORE, #1517)

16. **C16 Ignore switched off.** Profile default. `type "CDCHECKIGNORE"`. Assert: history has "Ignoring a finding is switched off in
    CE Settings. Nothing was changed."; log has "Command outcome: CDCHECKIGNORE completed". **Deterministic.**
17. **C17 Ignore, list shorter, U straight after.** Profile ignore-on. Chain the ignore of the first row (one `type` string),
    list, U, list. Assert: the "and N more" count drops by 1 after the ignore; after U the row is back and the count is the
    baseline (run 47's clean WT10 check). **Deterministic.**
18. **C18 Ignore, re-list, U, U.** Profile ignore-on. Ignore, list (a read), U, U. **EXPECT-FAIL (run 47 finding, fix planned in
    C-61):** after the fix the row must be back after the second U. **Deterministic.**
19. **C19 Un-ignore.** Profile ignore-on. Ignore a row, then `"CDCHECKIGNORE`nUnignore`n1"`. Assert: the row is back, count at
    baseline. **Deterministic.**

### 5.5 Wrong-layer rows (#1511, #1512)

20. **C20 Pipe moved to layer 0.** Profile checks-on. `pick-first "10A98D"`, `type "_.CHPROP`n_LA`n0`n"`, `CDRULES All` (full list
    saved to a text file, memory `cdrules-all-saves-full-findings-file`). Assert: `ent-read 10A98D Layer = 0`; the saved list has
    exactly one more wrong-layer row than the baseline run, naming P3; after U the count is back to the baseline. **Deterministic.**
21. **C21 Pit moved to layer 0.** Same with pit 109D56. **Deterministic.**

### 5.6 Command outcome log lines

22. **C22 Ten Civil commands write one outcome line each.** Profile tidy-on. CDINSPECTOR, CDTWL (complete chain), CDTIDYLABELS
    (preview then Esc), PIT (point then cancel), CD (cancelled at its first prompt), CDEDIT (open and cancel), CDRECOVERINVERTS,
    PITSCHEDULE (open, close), CDSYNC, CDCHECKCURRENT. Assert per command: exactly one new line `Command outcome: <NAME>
    completed` or `cancelled`, as the case file states for that command. **Deterministic.**
23. **C23 A forced failure writes "failed".** Runs 46 and 47 could not force one (CDEDIT on a plain LINE and CDTWL with "abc" both
    ended normally). The phase 3 builder must find, from source, one input that makes a Civil command end in its failure path
    on a test copy, and record why. Until then the case is **BLOCKED (no failure trigger known)**. **Deterministic.**
24. **C24 Check progress lines (#1514).** Profile checks-on. CDCHECKCURRENT. Assert: one or two plain progress lines and then
    "Drawing check complete"; when the check takes under 0.5 s no progress line (read the time from the outcome line).
    **Deterministic.**
25. **C25 Structural and Manager outcome lines.** CSREOBAR (complete chain from run 44), LBUH, CE_VERSION. **EXPECT-FAIL (run 46
    finding: none of them writes a line today).** Assert after the fix: one outcome line each in the Structural or Manager log.
    **Deterministic.**

### 5.7 Structural

26. **C26 LBUH hatch scale at 1:20, 1:50, 1:100 (BUG-748).** Fixture DRV2_S1. For DIMSCALE 20, 50, 100 (setvar, drawing
    variable): LBUH chain, then `ent-read` of the new hatch. Assert: PatternName DOTS; layer "HATCH 231 - LOAD BEARING WALL
    UNDER"; PatternScale 20, 50, 100 (run 46 measured 50 at DIMSCALE 50, "was 20"). A `shot` of each hatch at a fixed zoom.
    **Deterministic + look** (dots evenly spaced on paper, V9-02).
27. **C27 LBH hatch scale at 1:20, 1:50, 1:100.** Same with LBH. Assert: ANSI31, "HATCH 11 - LOAD BEARING WALL OVER", PatternScale
    50, 125, 250 (125 at DIMSCALE 50 measured in run 46). **Deterministic + look.**
28. **C28 CEMEMBER section route (#1518, V9-04).** One complete chain with SE (a separate answer is refused while the prompt waits,
    run 46). Assert: the new history has no "Centreline/Top/Bottom" question; the member is drawn (`ent-count` up). **Deterministic**
    (+ look for V9-01 outline in a later case).
29. **C29 25C note text (V9-03).** Chain 25C, point, text. Assert: the prompt in the history asks for text, not a number; one new
    MTEXT with the typed text and height 125 at the drawing's scale. **Deterministic.**
30. **C30 S-HID layer (V9-05).** After C28's CEMEMBER on a fresh copy: `layer-read S-HID`. Assert: colour 3, linetype DASHED; the
    member's hidden lines are on S-HID (`ent-count layer=S-HID` > 0). **Deterministic.**

### 5.8 REDO (BUG-861, BUG-416)

31. **C31 REDO after a typed pick of a pit, five repeats.** Fixture DRV1_B1, one drawing open. Five times: `_.LINE` chain (closed
    by `esc-prompt`), U, `pick-first "109D56"`, wait 12 s, REDO. Assert each time: "Everything has been redone". Run 47 run B got
    "Nothing to redo" with a second drawing open; this case is the one-drawing control. **Deterministic.**
32. **C32 REDO after a mouse pick of a pit, five repeats.** Same with `pt-click` on the pit instead of `pick-first`.
    **Deterministic.**
33. **C33 REDO after a right-click CE item (BUG-416).** `pt-click` the pit, `pt-rclick`, `ui-dump` the context menu, press the CE
    select item by name, Esc, then REDO. Assert: "Everything has been redone"; closing the copy asks no save question. If the
    context menu cannot be read through UI Automation the case is BLOCKED with that reason (risk in 6.5). **Deterministic.**
34. **C34 REDO with a second drawing open.** As C31 with a second fresh copy open (run 47 run B). Assert as C31. Together C31 and
    C34 settle which difference loses REDO. **Deterministic.**

### 5.9 X-Civil import, CHECK THE SCALE (BUG-505)

35. **C35 Metres source.** Fixture target DRV1_B1 copy, source a copy of DRV15_METRE. CDIMPORTXCIVIL, `ui-press "Choose DWG*"`, v3
    `dialog-path` (the fixed one), `ui-dump` the import window, `shot`, press Close. Assert: the CHECK THE SCALE line names metres;
    `ent-count` of the target unchanged after Close. **Deterministic + look** (the wording on screen).
36. **C36 Unitless source.** Same with a source copy set to INSUNITS 0 (setvar, saved with v2 `save-copy` as a fixture once).
    **Record-only** until Tim answers Monday question 1 (soft note or nothing); then it becomes deterministic.

### 5.10 Civil regressions that passed in runs 44 to 47 (keep them passing)

37. **C37 Tidy labels names the pipe (BUG-856).** Profile tidy-on. `"CDTIDYLABELS`nAll"`. Assert: a new history line matching
    `pipe P\d+ -> .* would move \d+ mm`. **Deterministic.**
38. **C38 Recover inverts totals.** CDRECOVERINVERTS. Assert: "26 pipes recovered", "24 skipped", "5 pipes have only one of their
    two invert texts". **Deterministic.**
39. **C39 Water level freeboard.** `"CDTWL`n10`n18.70"`. Assert: "Only 40 mm between the water and the lid of pit C1 (150 mm is
    wanted)." **Deterministic.**
40. **C40 Edit Pipe cascade, U, REDO.** `pick-first "10A98D"`, `"CDEDIT`nY"` with ExpectWindow, `ui set` first invert 17.60 and
    second invert 17.50, press "Save pipe and close", `msgbox-answer "*Recalculate*" Yes`, Cascade Preview Apply (120 s allowed).
    Assert: "Updated 4 pipes and 3 pits from P3 (IL 17.50)"; U echoes CDEDIT; REDO "Everything has been redone"; `ent-read` of
    the invert text after U shows the old level. **Deterministic.**

**Next after 40 (phase 3 stretch or phase 4):** CDSYNC leaves the Pit Schedule unchanged except the issue count (runs 44 to 46);
quick edits (MOVE by handle) open no CE window; CSREOBAR U and REDO; New Pipe "Start Pipe" timing (the 30 s watchdog hit in runs
43 to 47; v3 must give it a slow-press allowance); V9-01 Z section outline look; About window after a second drawing opens.

---

## 6. Build plan

Four phases. Each is one Sonnet job (RULES model routing: Sonnet builds and tests) followed by an Opus review job of the new
code before the next phase starts (model routing: Opus for anything touching Settings). Each phase ends with a self-test that
must PASS twice in a row, in a free AutoCAD window, with the four fingerprints unchanged and no `acad.exe` left.

### 6.1 Phase 1: driver v3 (already queued: `desk_jobs\tester_run48_driver_v3_phase1.txt`)

1. **Build:** `acad_driver_v3.ps1`, `acad_driver_v3.allowlist.json`, `v3_selftest.ps1`, `README_V3.md`. Verbs: `ui-dump`,
   `ui-press`, `ui-set`, `dialog-path` (fixed), `dialog-cancel`, `pt-click`, `pt-dblclick`, `pt-rclick`, `pt-hover`, `pt-drag`,
   `ent-read`, `ent-find`, `ent-count`, `layer-read`, `setvar` (with the drawing/profile rule), `session-run`. v2 files untouched.
2. **Self-test must prove, with real AutoCAD on the installed build:**
   1. UI Automation loads in a fresh process (the AutomationElement fault cannot recur): `ui-dump` of About CE Suite, Settings
      (after `settings-temp arm`) and the Checks palette return JSON; About closes by its Close button (`ui-press`).
   2. Case C02 (calibration) at three zooms and after a pan: largest pixel error reported, must be 2 pixels or less.
   3. `pt-dblclick` on DP1 (circle, centre mark, DP text) and on a pit label, reporting the window each opens (BUG-859 data).
   4. `dialog-path` on the X-Civil import "Choose DWG" dialog with a harmless test file, and `dialog-cancel` closing a dialog.
   5. `session-run` of a throw-away case three times in a row, each ending with no `acad.exe`, lock free, fingerprints unchanged.
3. **Correction to the queued job text:** its item 2 says "pt-click at its centre" of a circle; click a point on the circle line
   instead (C02). This spec is that job's contract, so the job follows this.
4. **Report:** `C:\CE_PLAN\areas\release-v3-colleagues-DRIVER_V3_PHASE1_REPORT.md` with every new file's size and SHA-256.

### 6.2 Phase 2: the runner, the reports and cases C01 to C10

1. **Build:** `pack\pack_runner.ps1` (parse, validate, group by profile, run, flaky rerun, `finally` clean-up), the JSON and
   Markdown report writer, the look-card writer, `fixtures.json`, `profiles.json`, case F01 and cases C01 to C10.
2. **Self-test (`pack_selftest.ps1`):** offline: the parser on 15 good and bad case files (bad verb, missing quote, unknown
   fixture, LISP text, SAVE word: each refused with a clear reason). Live: the pack C01 to C10 twice; both runs give the same
   result per case; total under 15 minutes; the report header shows the real DLL versions; one deliberately wrong assertion
   (a copy of C01 expecting a wrong value) gives FAIL, a rerun, and FAIL.
3. Then the Opus review of phase 1 and phase 2 together.

### 6.3 Phase 3: cases C11 to C40

1. **Build:** the 30 case files, the `pitlabel-on` key name and the C23 failure trigger read from source, fixture PKFIX_TB if
   needed, the C36 unitless source.
2. **Self-test:** the full 40-case pack twice, in under an hour each; per case the same result both times, or FLAKY explained;
   every look card has a non-blank, non-duplicate picture.

### 6.4 Phase 4: the pack in the conveyor

1. The desk's existing `codex_conveyor.ps1` gets a new queue line kind `pack|<case list>|<profile list>` that runs
   `pack_runner.ps1`, then queues the generated look brief for Codex. No new Windows scheduled task and no new deploy or build
   script (RULES 10.5): the existing desk loop adds a pack line (a) when the product version of an installed CE DLL changes
   (after every install) and (b) nightly at 01:00 Melbourne.
2. **Self-test:** a simulated install (the desk writes the pack line by hand) runs the pack and the look brief end to end; the
   conveyor's hand clean-up does not run because the pack ended cleanly.

### 6.5 Risks and how each phase proves them

1. **UI Automation may not see AutoCAD's own windows** (the Enhanced Attribute Editor, the right-click menu, message boxes whose
   buttons show as "Pane"). Phase 1 item 2.3 dumps the Enhanced Attribute Editor; C33 proves or BLOCKS the right-click menu;
   message boxes keep using v2 `msgbox-answer`, which is proven.
2. **DPI scaling on the 5120 x 1440 screen.** The process declares per-monitor DPI awareness; the Windows scale factor is
   recorded; C02 measures the error at three zooms and after a pan. If Windows scaling is not 100 percent, C02 also runs with
   AutoCAD on the other monitor (if one exists) to prove the mapping there.
3. **AutoCAD focus.** Windows may refuse to bring AutoCAD to the front. Every pointer step checks the foreground window and the
   window under the pixel first and refuses otherwise (v2 `BringToFront` and `ClassifyPoint` are proven to 1 pixel). C02 and
   C32 prove it on real clicks.
4. **Tim using the PC.** The human-at-the-PC guard (1.4 item 9.8) and the in-use hours refusal; phase 2 self-test proves the
   guard by reading last-input time with no AutoCAD running.
5. **First quit takes 240 s** (runs 42, 45, 46). The 60 s + 60 s + kill rule caps it; phase 1 item 2.5 proves three clean ends.
6. **A typed LISP line can wedge AutoCAD.** v3 reads through COM only; the parser refuses `(` in typed text.
7. **CE rewrites a settings file at start** (run 46). The runner separates "changed at start by CE" from "changed during the
   run" by reading the fingerprints just before the first step.
8. **Pictures showing private drawing names** (V8 saw the Recovery Manager). Pictures are taken of one window only (v2 `shot`
   refuses a covered window); the pack folder is local only; after a kill the runner removes the run copies' `.dwl` files so
   the Recovery Manager does not appear.

### 6.6 Allow-lists, pins and hashes: who changes what

1. **Driver v2 files are never edited by this work:** `acad_driver_witness_v2.ps1` (SHA-256 starts 120EE24D15B2), its allow-list
   (5B542F2145F4) and `calls_v2.json`. `acad_driver_v3.ps1` checks both hashes at start and refuses to run if either changed
   (that would mean someone edited v2 without the review).
2. **The witness recorder pin** (`$script:WitnessPinnedSha256` in the v2 witness drivers) is not touched; a case that needs the
   recorder calls v2 `witness load` unchanged.
3. **The v3 allow-list** (`acad_driver_v3.allowlist.json`) is pinned by its SHA-256 inside `acad_driver_v3.ps1`. The phase 1
   builder writes the first list and its pin. Every later change (a new window or button) = the builder edits the JSON and the
   pin line in one diff; an **Opus review job** reads that diff and approves it; the **desk** then records the new hashes of both
   files in `release-v3-colleagues-DESK_CONTINUITY_RECORD.md` and in the hash-check line of every brief and pack header. The
   never-press words of v2 (Save, Delete, Publish, Send, Reset, Restore and the rest) are copied into the v3 list unchanged and
   can only grow.
4. **The first v3 list** reads: Edit source, About CE Suite, Creative Engineering | Settings (read; Cancel only, Save never),
   Checks, X-Civil import, the Open file dialog, Enhanced Attribute Editor (read; Cancel only), Edit Pit, Edit Pipe, New Pipe,
   Cascade Preview. Press: Close (About), Cancel, OK (Edit source only), "Cancel without saving", "Choose DWG*", and the v2
   buttons the 40 cases use.
5. **Case files and the runner are not pinned** (they are plain test data and test code), but every report header prints their
   hashes, so a changed case is visible.

---

## 7. Changes to the desk process

1. **Robot passes (an AI calling the driver one step at a time) stop being the acceptance route** once phase 2 passes. The AI's job
   becomes writing and fixing case files (Sonnet), reading pack reports, and raising bugs. A robot pass is still allowed for
   exploring a new command before its case is written.
2. **Codex stops driving AutoCAD** once phase 2 passes: no new Codex driving briefs after V10. Codex gets one 3 KB look brief per
   pack run. Until then the conveyor keeps its current queue.
3. **The conveyor:** after every install, the 40 core cases; nightly at 01:00 the full pack; then the look brief. It no longer
   kills AutoCAD or deletes the lock by hand after a pack run, because the runner's end step does it; the hand clean-up stays
   only for Codex and robot jobs.
4. **A FAIL becomes a bug in `C:\CE_PLAN\BUG_CARPARK.md`** with the case id as "the test that catches it" (RULES 13.1); a fixed bug
   keeps its case with no EXPECT-FAIL marker so it can never quietly come back.
5. **Acceptance wording** follows section 4 once Tim rules; until then the pack is the "robot" half of today's rule.
6. **Tim does nothing in this process** (decisions item 17), except answer the section 4 question and the engineering questions.

---

## What this spec did NOT check

1. Nothing was run: no AutoCAD, no Codex, no driver call.
2. I read the v2 driver selectively (verb table, launch, quit, shot, click-canvas, dialog-path, UI Automation loader, pins), not
   all 373 KB.
3. The DP command's prompt order, the pit-label switch's key name, the exact "Nothing was changed" wording of Edit source and a
   failure trigger for C23 are not known here; phases 2 and 3 read them from source.
4. Whether `DRV1_B1` contains a title block was not checked (C11 may need a new fixture).
