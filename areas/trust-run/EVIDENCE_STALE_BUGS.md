# Evidence for the "fixed in code, never seen" bugs (lane trust-acad-evidence)

**Written:** Fri 13 Nov 2026, 02:10. **Build tested: the INSTALLED one** (Civil 3.0.90, commit `cf059dcf`, AutoCAD 2027), real AutoCAD on fresh copies of the standard test drawing under `C:\CE_WORK\scratch\trustprobe`. No status in `BUG_CARPARK.md` was edited; the controller does that from this file under RULES 13.3. Nothing installed, no CE setting changed (four settings files hashed before and after: identical; FILEDIA was set to 0 for one try and put back to 1, read back).

**Three words only:** seen fixed, seen still broken, could not be tested this way. Built / Tested / Installed / Accepted: nothing here is Tim-accepted. "Seen fixed" is robot evidence in real AutoCAD on a copy; Codex looks were not part of this.

---

# FOR TIM

1. **BUG-650, Esc in the floor waste command wiping stored pit inverts: SEEN FIXED.** On a copy with 8 pits holding levels (P1 16.930, P2 17.080, P3 17.250, P4 17.400, P5 17.530, P6 17.670, P7 17.650, C1 16.820) and 25 pipes holding levels, I typed CDFW and pressed Esc at its first question: every one of the 8 pit levels and 25 pipe levels was still there. Then I placed a floor waste properly: the levels were still there. One U after each put CE's record back exactly.
   1. **One thing it still does:** a cancelled CDFW rewrites CE's record quietly. The only changes are the stored format number (2.2 to 2.3) and an identity added to each of the 49 pipes. No level or size changed. That is the "CE changes its record without telling" fault, not the level loss.
2. **BUG-1255, Pit Schedule Excel export: COULD NOT BE TESTED THIS WAY.** The driver never presses an Export button, and the save box is AutoCAD's own window. What I could read: AutoCAD 2027 still ships ClosedXML 0.102.2 and CE's bundle still ships 0.102.3 (the clash that caused the fault is still there). The installed code has a fix for it (it answers a refused request with AutoCAD's own copy, switch on by default). Whether it works is not seen.
3. **BUG-458, commands running while a reference is open for editing: COULD NOT BE TESTED THIS WAY.** Starting the reference edit opens AutoCAD's own "Reference Edit" dialog, which the driver cannot press. I got as far as picking the reference and answering the nesting question; the dialog then blocked everything, and Esc closed it. Nothing was changed.
4. **Still to do from the ten Tim should care about:** BUG-683, 681, 290, 968, 674, 780, 785, 756 and 969 were not attempted tonight. The queue's other items came first. Each needs its own drawing set-up.

---

# DETAIL

## BUG-650 (CDFW cancel clears stored pit inverts)

1. **Drawing:** copy of the standard test drawing, 11 pits, 49 pipes, millimetres. CE's record read as before (`TRUST_PROBES_13NOV.md` section 0).
2. **Before:** 8 pits with a stored invert (list above), 25 pipes with a stored from or to invert.
3. **Test A, Esc at the first question:** typed CDFW; the command line showed "Specify floor waste insertion point"; one Esc: "CDFW cancelled - nothing was placed." After: the same 8 pit inverts, the same 25 pipes with inverts. Drawing fingerprint unchanged (1,034 objects). The record text grew from 600,382 to 603,310 characters. Compared field by field with CE's random ids ignored, the only differences are the top-level format number "2.2" to "2.3" and 49 pipes each gaining an identity key. No pit or pipe value changed.
4. **Undo after test A:** one U ("CDFW" in the undo line): record back to 600,382 characters, the exact opening hash.
5. **Test B, a floor waste placed** (typed insertion point on empty ground): "Floor waste placed. Tag: FW1." Objects 1,036. The same 8 pit inverts and 25 pipe inverts. One U ("CDFW"): record and drawing back exactly to the opening state.
6. **Matches the carpark entry's guard:** "Both established inverts must remain ... and no floor waste/tag may remain." Seen for both the cancel and the placement. Not tried: the strip-and-AGI drawing the entry used (it is not among the test copies), a pit with a sump bottom, and save and reopen.
7. **Why it is fixed (not tested here):** `trust-safety-fixes` found the fix at commit `da006db6`, in since Civil 3.0.70; this evidence is consistent with that.

## BUG-1255 (Pit Schedule Export Excel)

1. **Cannot be pressed:** the driver's never-press list contains "Export"; the Pit Schedule is a window on the driver's read list and its Export button is not on any press list.
2. **Files read (read only):** `C:\Program Files\Autodesk\AutoCAD 2027\ClosedXML.dll` is 0.102.2.0; the installed bundle's `Modern\ClosedXML.dll` is 0.102.3.0; same publisher key. So the clash condition in the carpark entry is unchanged.
3. **The claimed fix, from the code copy at the installed commit:** `PluginInitialization.cs:61-63` registers a handler that answers a refused request for the Excel library with AutoCAD's copy; `UserSettings.UseAutoCadLoadedClosedXml` defaults to true; `PitScheduleViewModel.Schedule.cs:126-147` also turns a library load fault into one plain line. Whether the save box then opens is not seen.
4. **What would settle it:** a person (or Codex with screen control) pressing Export Excel in the Pit Schedule on a copy and reporting whether the save box opens. Nothing else can.

## BUG-458 (commands during REFEDIT)

1. **Set-up that worked:** a made-up drawing attached as a reference to a copy, zoomed, then `-REFEDIT`, a pick on the reference, "Select nesting level [Ok/Next] <Next>:" answered with Ok.
2. **What blocked it:** after Ok, AutoCAD opened its own Reference Edit dialog (even with FILEDIA at 0). The driver rejects typed text while it is open and has no way to press it. One Esc closed it; AutoCAD was idle again. I restored FILEDIA to 1 and read it back.
3. **So PIT, PP, CD and the Pit Schedule were never run with a reference open for editing.** The claimed fix (`DrawingSafetyService.cs:78-90`) is unseen.
4. **What would settle it:** a person or Codex clicking OK in that dialog on a copy, then typing PIT, PP and PITSCHEDULE.

## Tidy-up

AutoCAD closed with the driver's quit; lock released; the four settings files byte-identical. My scratch build copies and DXF exports were deleted; C: free rose from 34.6 to 38 GB. The reference test left no file in the testset folder (it used a copy).
