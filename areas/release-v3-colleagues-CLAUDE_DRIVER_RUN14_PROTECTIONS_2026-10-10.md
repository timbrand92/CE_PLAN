# CLAUDE DRIVER RUN 14: typed-only protection checks (#870, #880 to #885), Sat 10 Oct 2026

Run window 08:44 to 09:00 PC clock (Melbourne). Driver: `acad_driver_witness.ps1` only, through a counting wrapper. **70 of 70 driver calls used** (budget reached; one call per individual call). Test copy CLD22_B1 (from DRV1_B1, hash-checked equal) and CLD22_B2 (a read-only copy of the same file).

## Answer first

1. **One protection proved: #881 (Pit Schedule view-only on a read-only drawing). PASS.** Exact sentences are in section 3.
2. **#880 (PIT refuses during REFEDIT): BLOCKED, three times, all three my own wedges.** I could not get a typed REFEDIT started on a loaded Xref. The refusal sentence was never reached.
3. **#882 (locked label layer): BLOCKED.** I locked the label layer and unlocked it again, but the driver (correctly) will not press "Continue placement" (PIT) or "Save pit and close" (Edit Pit). Nothing could reach the point where the PR's refusal sentence is printed.
4. **#870: SKIPPED. #883, #884, #885: SKIPPED** (no typed form in the PR, and the calls ran out).
5. **Counts:** PASS 1 (#881), BLOCKED 2 (#880, #882), SKIPPED 4 (#870, #883, #884, #885). FAIL 0.
6. **My mistakes, plainly:** three times I left AutoCAD stuck at a question and had to kill it (`quit -Kill`, the allowed route for the AutoCAD the driver launched). Each cost about four calls. The cause each time was a typed line I had not proven complete first, which the brief told me to do. Nothing of Tim's was touched; every kill was on a test copy that was never saved.
7. **AUTOCAD CLOSED** (acad count 0 checked after the last quit, 08:59:48). FILEDIA is back at 1 (the driver's restore read it back as 1).

## 1. Versions installed (nine DLLs read with readdll.ps1)

1. **Civil** 3.0.44+b7eed253df3f, Legacy 6C9C91FA2FC4, Net8 0117F2EDD64E, Modern 37DCB42C8005.
2. **Manager** 1.1.44+b7eed253df3f, Legacy 270EAFD07B7A, Net8 7F7BFED95C4D, Modern 762825AE390E.
3. **Structural** 1.0.113+2e0cf385030f, Legacy 5AD4C11F5988, Net8 8E97370E6F56, Modern F72DAFEEF802.
4. These match the versions in the brief. AutoCAD was not running at the start (`Get-Process acad` empty).
5. **Witness recorder:** `witness check` then `witness load` worked (SECURELOAD 0, sha256 49E79D6D... equals the pin). It was loaded in each of the three AutoCAD sessions I started; only the first session's log holds the PIT, CDEDIT and PITSCHEDULE evidence below.

## 2. System variables

1. **Before (first launch):** OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS", CTAB "Model", REFEDITNAME "" (empty), FILEDIA 1.
2. **After:** I did not change OSMODE, SAVETIME or CLAYER (the driver only allows setvar on FILEDIA, CMDECHO, UNDOCTL, and I typed no LISP setvar). I could **not read them again**: the budget was spent on restoring FILEDIA and quitting. So "unchanged" is by construction, not by a reading.
3. **FILEDIA:** I set it to 0 (driver setvar) so `-XREF` would take a typed file name. The first kill skipped the driver's restore ("skipped: AutoCAD is busy") and FILEDIA stayed 0 across restarts (it is saved in AutoCAD's own profile). The last launch set it to 1 and the clean quit read it back as 1. If you ever see a file-open dialog missing in AutoCAD after a killed driver run, this is why.
4. **Layer lock:** `STORMWATER PIT LABEL` lock flag went 0 to 4 (locked) and back to 0 (unlocked) on CLD22_B1 only. Read back by LISP both times.

## 3. Item by item

### #870 BUG-457 (redo checker): SKIPPED
1. The PR (`claude/bug-457-redo-guard`) is the automatic Undo/Redo checker and one end-of-command step. It has no typed form and no Xref behaviour. Its own AutoCAD line is "nothing new to see; re-run the REDO walk".
2. The brief's "PIT inside an Xref edit" is #880, not #870. Run 10 recorded the same mismatch.

### #881 HUNT-C-07 Pit Schedule on a read-only drawing: PASS (installed older head)
1. **How:** `open "C:\ce_rc_drv\CLD22_B2.dwg"` (read-only by default; result `read_only = true`, DBMOD 0).
2. **PIT, typed `PIT` then a line break then `10000,-90000`:** AutoCAD printed `Command: PIT`, then **`[CE] PIT cannot run - drawing is read-only.`** No window opened (`window_appeared = false`). The second line (the point) then went to `Command:` and AutoCAD said `Unknown command "10000,-90000".` That is harmless, but it is the cost of sending a point to a command that refused at once.
3. **PITSCHEDULE (`-ExpectWindow "Pit Schedule"`):** the window "Creative Engineering | Pit Schedule" opened. Read with `ui tree`:
   1. `Relink and recalculate` is **disabled**.
   2. `+ Add Row`, `− Remove Row`, the up and down arrows and `Reset Sort` are **disabled**.
   3. `Continue to Place / update` is **disabled**.
   4. `Custom remarks for the selected pit` (the remarks box) is **disabled**.
   5. Refresh, Export CSV, Export Excel and Close are enabled (reading still works).
4. **The explanation line:** after one click on the Source tab (`ui click "Pit Schedule" "Source" -Index 1`) the window shows, under "SCHEDULE SOURCE / Current drawing": **"This drawing is read-only, so the schedule can be viewed but not chang..."** The driver's tree cuts the text at 70 characters, so the end of the sentence ("...ed") is inferred from the PR text, not read.
5. **Witness (B2):** PIT start 08:51:03, end 08:51:03, 2 object-modified events, 0 appended, 0 erased. PITSCHEDULE start 08:51:16, end 08:52:30, 4 object-modified events, 0 appended, 0 erased. See finding 4 in section 5.
6. **Not reached:** the grid cells themselves (`ui type` into a row cell; Codex saw no cell editor on a click in W56), the right-click "Move group to set" menu (needs a right-click; SKIPPED), and the REFEDIT half of #881 ("PITSCHEDULE refuses during REFEDIT": BLOCKED with #880).

### #880 HUNT-C-01 PIT, CD, Edit Pit refuse during REFEDIT: BLOCKED
Expected sentence from the PR (not seen): `[CE] PIT cannot run while a reference is being edited in place (REFEDIT). Finish or close it (REFCLOSE) first. Nothing was changed.`

What happened, in order (each is a finding for the tooling worker):
1. **The drawing has no loaded Xref.** A LISP read of the block table showed five Xrefs (four XW26xx, one 22547_XCivil), all flag 12 (no "resolved" bit), so none is loaded. Same as Codex W56.
2. **Attempt 1:** `-XREF`, `A`, `C:\ce_rc_vc7\DWG-B5_VC7.dwg`, point, as one chain. AutoCAD echoed the path as `C \ce_rc_vc7\DWG-B5_VC7.dwg` (the **driver replaced the colon**; that is its drive-path rule, not something I may route around) and **with FILEDIA 1 AutoCAD opened its "Select Reference File" dialog**. AutoCAD then sat waiting; `wait` said "still busy (command active)"; `cancel` is refused under the alarm; `ui windows` listed the dialog as view-only. Ended with `quit -Kill`. BLOCKED by FILEDIA.
3. **Attempt 2 (FILEDIA 0, then the path without a drive, the file `DRV2_S1.dwg` beside CLD22_B1):** AutoCAD printed `"DRV2_S1" loaded: C:\ce_rc_drv\DRV2_S1.dwg`, then `Specify insertion point or [Scale/X/Y/Z/Rotate/PScale/PX/PY/PZ/PRotate]:`, and I typed only the point. It then **asked for the X scale, Y scale and rotation**, which the brief's `0,0 1 1 0` form had shown and I dropped. Stuck at a prompt, killed. My error.
4. **Attempt 3:** the same with `1`, `1`, `0` added. **The Xref attached and loaded** (X scale `1`, Y scale `1`, rotation `0`, `needs_input = false`). I put it at 2000000,2000000 so none of the drawing's own objects could be hit by the pick.
5. **LISP read of the first objects in the Xref block:** an INSERT, MTEXT, then LWPOLYLINE footings. First footing vertex was (-300,-300), so 1999700,1999700 in the drawing.
6. **`-REFEDIT` then `1999700,1999700`:** AutoCAD printed `Select reference: 1999700,1999700` then **`Reference not found.`** and kept waiting at the prompt (the typed point did not select the Xref: probably the pick aperture is tiny at that distance and the view was never zoomed there). Stuck, killed, budget spent. **No PIT, CD, PITSCHEDULE or CDEDIT was typed in a REFEDIT session. The #880 sentence was never printed.**
7. **For the next try (needs the tooling worker):** a typed REFEDIT form that can pick (a window zoom to the Xref first, then a point on it; or a Xref placed at 0,0 in view; or a pre-selected Xref if `-REFEDIT` honours it). I do not know the prompts after `Select reference:`; I did not guess them.

### #882 HUNT-C-02/03 locked pit label or cover-text layer: BLOCKED
Expected sentences from the PR (not seen): PIT: `Pit not inserted - layer 'STORMWATER PIT LABEL' is locked. Unlock the layer, then run PIT or PP again.` Edit Pit: `The pit label is on locked layer STORMWATER PIT LABEL (unlock it, then run the edit again).`

1. **Typed reads (LISP, `-AllowLisp`), before locking:**
   1. Pit handle 109768 is an INSERT of the anonymous block `*U182` on layer `STORMWATER PIT` at (77780.0, -25569.9). Its P2 label is the INSERT `PIT LABEL` handle **10981A on layer `STORMWATER PIT LABEL`** at (78979.1, -24542.2). The label layer exists in the drawing.
   2. The two MTEXT "P2" objects an exact-text search finds (handles 1152D4 on `35TEXT` and 1152C6 on `25TEXT`) are in the title-block area at y about -190000, not the pit's label. The pit's label is the block, not text.
   3. The layer `STORMWATER PIT` (the pit itself) is the one PIT already protects (older behaviour).
2. **Lock:** the typed chain `-LAYER`, `LO`, name cannot end by itself because the driver trims trailing line breaks (the layer command then waits for another option). I used one complete line instead: `(command "_.-LAYER" "_LO" "STORMWATER PIT LABEL" "")` (this is typed LISP, `-AllowLisp`). Lock flag read back as 4. Unlock the same way: read back as 0.
3. **PIT with the label layer locked:** `PIT` + line break + `10000,-90000` opened the **New Pit** window as normal (AutoCAD printed `Specify pit insertion point: 10000,-90000`). The window holds "Pit label block on plan [On]" and "Cover level text on plan [On]", so the rule should fire on placement. But the only button that places is **`Continue placement`** (id `C2.PlaceCommand`), which is on the driver's never-press list, and it is disabled until a cover level is typed. I did not type one. I closed the window with `ui close` (the PIT command then ended without a CE message; witness below). **BLOCKED: the refusal sentence cannot be reached through the driver.**
4. **Edit Pit with the label layer locked:** I pre-selected the pit by LISP (`PICKFIRST` 1, one object selected), typed `CDEDIT` (`-Force -ExpectWindow "Edit Pit"`), and the window "Creative Engineering | Edit Pit" opened for P2 (900 x 900 mm, cover 18.91). I typed 1200 into "Pit plan length (mm)" (`ui type ... -Index 1`, value read back 1200). Then `ui click "Edit Pit" "C2.PlaceCommand"` was **refused by the driver: "control name 'Save pit and close' contains 'Save'; nothing was pressed."** I closed the window with `ui close` (nothing saved). **BLOCKED.**
5. **What this means:** #882's two refusal sentences can only be seen by someone pressing Continue placement or Save pit and close: that is Codex or Tim, in AutoCAD. The checklist for them is the PR's own "What to test in AutoCAD" (lock the label layer, PIT then click a spot; PITEDIT 450 to 600 then Save).
6. **Witness (B1):** `-LAYER` lock 08:49:13 (1 object modified: the layer record); PIT 08:49:15 to 08:49:37 (8 object-modified events, 0 appended, 0 erased); CDEDIT 08:49:58 to 08:50:35 (2 modified, 0 appended, 0 erased); `-LAYER` unlock 08:50:51 (2 modified). DBMOD stayed 1 throughout (no new change to the drawing counted).

### #883, #884, #885: SKIPPED
1. **#883** (CDRULES and CDCHECK end sentences): CDRULES has no typed form I could prove complete; CDCHECK as `CDCHECK` + line break + `Problems` is marked UNTESTED in the README. Not run.
2. **#884** (New Pipe grade question reads the Settings tolerance) and **#885** (Pit Schedule levels use the Settings decimals): both are Settings-driven wording or format changes with defaults unchanged. They need the New Pipe or Pit Schedule windows on a writable drawing with a typed level. Out of calls.

## 4. Driver calls

70 of 70, counted per call by a wrapper (the log is in the session scratchpad). Rough split: setup and reads 16; layer reads and lock/unlock 7; PIT and Edit Pit windows 8; read-only copy and Pit Schedule 9; the three Xref and REFEDIT attempts 12; three kills and restarts 12; FILEDIA restore and clean quit 6.

## 5. Findings for the tooling worker (none worked around)

1. **`-XREF` with FILEDIA 1 opens a file dialog.** The driver cannot see it (not on the allow-list), the alarm fires, `cancel` is refused, only a kill ends it. A typed Xref attach needs FILEDIA 0 first. Suggest the driver refuse or warn on `-XREF`, `XREF`, `XATTACH`, `-INSERT` with a file name when FILEDIA is not 0.
2. **A killed driver run leaves FILEDIA at 0 in AutoCAD's own profile** (the restore is skipped when AutoCAD is busy). Suggest `quit -Kill` write down "FILEDIA still 0" and the next `launch` restore it first.
3. **The driver removes the colon of a drive path from typed text** (`C:\` arrives as `C \`). So a typed file name can only be relative to the drawing's folder. Fine as a safety, but the brief's `-XREF A <fullpath>` form can never work; a file beside the drawing can.
4. **A refused or cancelled command still shows object-modified events in the witness:** PIT refused on a read-only drawing showed 2, PITSCHEDULE on a read-only drawing showed 4, PIT cancelled in its window showed 8, CDEDIT cancelled showed 2, with nothing appended or erased and DBMOD unchanged. These are almost certainly objects opened for write and left unchanged (the record does not say what changed), but the recorder cannot tell "opened" from "changed". For the redo-safety question ("did anything write after U?") that is exactly the thing worth separating. A before and after of the object's content would settle it.
5. **`-REFEDIT` at a typed point said "Reference not found."** and stayed at "Select reference:". The next prompts after a successful pick are not known. Nobody has a proven one-line REFEDIT form yet.
6. **The trailing-line-break trim** means a command that ends on an empty Enter (`-LAYER LO name` then Enter to leave the option list) cannot be typed as a chain; only a LISP `(command ...)` line can.

## 6. What a Claude driver can and cannot cover here

1. **Can:** read-only drawing behaviour (PIT refusal sentence, Pit Schedule disabled controls and the explanation line), typed LISP reads of layers, handles and positions, locking and unlocking a layer, opening CE windows and reading what they show.
2. **Cannot (by design):** press Continue placement or Save pit and close, so any protection that prints its sentence only on place or save (#882) belongs to Codex or Tim.
3. **Cannot yet:** start a REFEDIT. Until the tooling worker has a proven form, #880 and the REFEDIT half of #881 stay with Codex or Tim (PR text: REFEDIT an Xref, OK, type PIT, expect the one line, then REFCLOSE and Discard).
4. **Recommendation:** do not repeat this run until the tooling worker has (a) a proven REFEDIT chain and (b) the FILEDIA guard. Then #880, #881 (REFEDIT half) are about six calls.
