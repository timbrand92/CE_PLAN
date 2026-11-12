# Trust probes: what AutoCAD showed (run night of 12 to 13 Nov 2026)

**Written by:** lane trust-acad-evidence. **Build tested:** the one installed on Tim's PC: Civil 3.0.90 and Manager 1.1.89 (commit `cf059dcf`), in AutoCAD 2027. **Where:** made-up and old test copies only, fresh copies under a scratch folder. No client drawing, nothing installed, no setting changed (the four settings files were hashed before and after and are byte-identical). **Four states:** Built n/a. Tested yes (this is test evidence). Installed n/a. Accepted no.

---

# FOR TIM

**The short answers**

1. **Does one U put CE's record back?** Yes for every case I could undo, with one exception. CDSYNC, CDGRAPH and Edit Pit each put the record back exactly with one U. The exception is the change CE makes when a drawing opens (pipes turned into CE pipes). One U does nothing there. The only way back is the backup file CE saves beside the drawing.
2. **Do the "read-only" tools really only read?** No. CDGRAPH, CDDIAG and the Project Review window (CDDASHBOARD) quietly update CE's record. Edit Pit does too, even if you press Cancel. CDCHECKCURRENT and CEHEALTH did not change it.
3. **How slow is Check Current Drawing?** Very fast. CE's own log says 8 to 65 thousandths of a second on every drawing I tried, including a made-up 200-pit, 370-pipe job. What is slow is CDSYNC: 4 minutes 6 seconds on that same job.
4. **Does CE make up values?** Yes, and it writes them into the record without telling you. A plain line on the pipe layer becomes "100 dia UPVC". A pit block with no label becomes "P8" or "P2", 350 x 350, a plastic pit, left out of the schedule. In a metre drawing the pit gets 350 (millimetre) beside a 0.6 (metre) pit.
5. **Does the pit symbol swap run on opening?** Yes, even in a drawing that has nothing to do with Civil. It renames the old pit block to the new one and prints nothing of its own. AutoCAD just says "Regenerating model".

**What each probe means for the plan**

1. **P2, Undo (step 5 and 8):** the Undo worry is much smaller than feared. A visible line plus one U is enough for CDSYNC, CDGRAPH and Edit Pit. The open-time change is the one that needs a different answer (the plan already moves it into Check this drawing).
2. **Read-only claims (step 5):** the fix list for step 5 is now exact: CDGRAPH, CDDIAG, CDDASHBOARD and Edit Pit must stop updating the record, or must say one line when they do.
3. **Timing (step 1):** the opening line can run the check on any size of job. It must never call CDSYNC; that is what takes minutes.
4. **Made-up values (step 6):** confirmed on the installed build, in both millimetre and metre drawings. The metre drawing is worse, because the invented pit size is in millimetres next to a real size in metres.
5. **Pit swap on open (step 8):** confirmed it runs in a non-Civil drawing. This is why "Nothing changes on open" needs the swap moved out of the open event.

**What I did NOT test (so do not treat as known)**

1. Edit Pit with the Save button (the driver cannot press it).
2. Edit Pipe, new pit (PIT), new pipe (CD).
3. A U pressed after other commands in between.
4. AutoCAD 2022 to 2024, Structural and Manager commands.
5. Any real job, any colleague PC.

---

# DETAIL

## 0. Set-up

1. **AutoCAD:** I started it through the driver (Explorer hand-off), 22:49 Thursday, and closed it at 23:55 with the driver's quit. A second start (after the driver's 60-minute pass limit) took 43 seconds. No AutoCAD was running before or after. `autocad.json` was in `auto` mode, outside Tim's hours.
2. **Copies (all fresh, all under `C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY`):**
   1. **A1:** a copy of the standard test drawing with 11 pits and 49 pipes, millimetres, 1,034 drawn objects. Used for most probes.
   2. **LARGE:** the largest CE test copy by file size (1.3 MB): 1,285 objects, 27 CE pipes. A 4 MB "consultant copy" in the test folder is not a CE drawing, so I did not use it.
   3. **SYNTH:** a made-up job built by script in a copy: 200 pits in a grid of 12 m, 370 plain two-point polylines on the pipe layer. I aimed for about 300 pipes; the grid gave 370, which is the harder case.
   4. **METRE:** the small test drawing with one pit, scaled by 0.001 and INSUNITS set to 6.
   5. **BLANK2:** a blank AutoCAD template with one old PIT BLOCK 2 symbol, no CE data, saved, then opened fresh.
3. **How CE's record was read:** a read-only script attached to AutoCAD and read the drawing's own dictionary `CE_CVL_SUITE_PROJECT`, key `PROJECT_DATA` (a JSON text split into 255-character pieces). It hashed the text and also a fingerprint of every drawn object. It cannot run while a CE window is open, so each "after" reading was taken after the window closed.
4. **The record contains a random id** (`spineKey`) that changes on every update, so two updates of the same drawing never hash the same. I compared lengths and contents, not only hashes.
5. **Settings:** hashes before and after, all four files: `CD_Settings.json` ACD64E79A33B, `CS_Settings.json` (Civil) 622A246F7D3B, Civil `settings.json` EFE307C4FC74, Structural `CS_Settings.json` 50AA09900E3E. Identical. I changed no CE setting.

## 1. P2, Undo: does one U put CE's record back exactly?

For each case: read the record, run the thing, read, press U once, read.

1. **Opening a drawing (the pipe conversion).** On open, CE printed "49 pipe(s) upgraded to CE pipe objects, 49 given their CE identity. Backup: ..._PRE_C7_...dwg". The drawing was already marked changed. I pressed U once: record and drawing were identical before and after. **Answer: no. U does nothing. There is nothing to undo.** The backup file beside the drawing is the only way back, and (plan finding 17) it copies the last saved file.
2. **CDSYNC** (record in sync with the drawing). CDSYNC printed "Pits relinked: 11, Pipes relinked: 49". It changed the record (603,456 to 605,005 characters) and moved or rewrote 25 plan objects (10 arrow and label blocks, 14 pipe-text notes, 1 plain text), none of the pits or pipe lines. One U: record hash and drawing hash both back to the "before" values. **Answer: yes, exactly.**
3. **Edit Pit opened and closed (Cancel), record in sync.** Record and drawing identical afterwards. Nothing to undo.
4. **Edit Pit opened and closed (Cancel), record behind the drawing** (one plain polyline added on the pipe layer first). Record changed (600,384 to 601,002 characters, one new pipe entry). One U: record back to the "before" length and content. **Answer: yes.** Note that Cancel did not stop the update: it ran before the window opened.
5. **A tool that triggers the hidden update after one plain polyline** (CDGRAPH). Record changed by the same one pipe entry; the drawing did not change. One U: record back exactly. **Answer: yes.** I did not press U after CDDIAG or the dashboard; they write the same entry.
6. **Not shown by this probe:** U after a longer chain of commands, Redo, and whether the new pipe entry's removal also removes anything else the sync changed on a very different drawing.

**Two things to know.**

1. In these tests the record before U and after U matched exactly, apart from the random id which changed by itself.
2. The first reading after the first open of A1 (603,456 characters) was not the same as the reading after later fresh opens of the same file (600,384). I could not explain the 3,000-character difference. It is a reminder that the record is not "the same every time you open".

## 2. P1, timing: how long does CDCHECKCURRENT take?

CE's own log line is the measure: "Command outcome: CDCHECKCURRENT completed N ms". The driver's own wall time (2 to 5 seconds) is mostly the driver's overhead; a trivial command costs 2 to 4 seconds the same way.

1. **LARGE copy** (1,285 objects): 8, 10 and 10 ms.
2. **A1** (1,034 objects, first run, record behind): 309 ms.
3. **SYNTH 200 pits, 370 pipes, no CE record:** 25, 26, 41 and 38 ms.
4. **SYNTH after CDSYNC (record in sync):** 44, 57 and 65 ms.
5. **For comparison, the commands that are slow:** CDSYNC on SYNTH 245,952 ms (4 min 6 s). CDGRAPH on A1 about 6 s, CDDIAG 9.8 s, Project Review window about 59 s with the window open (includes my wait), Edit Pit 15 to 36 s (includes my steps).
6. **What this means:** at these sizes the check is far below a second. A size limit for the opening line is not needed on these jobs; I do not know how it behaves on a drawing with tens of thousands of objects (nothing that large exists in the test copies).
7. **Not proven:** whether the palette keeps working after the command line says done; the 245 s CDSYNC figure is one run, on one machine under no other load; "5 items need checking" was shown on SYNTH both before and after CDSYNC and I did not read what the five are.

## 3. Read-only claims: which tools change the record?

Condition: record behind the drawing (one plain polyline on `STORMWATER PIPE`, record taken before). A fresh copy for each tool.

1. **CDGRAPH:** changed the record (+1 pipe). Drawing unchanged.
2. **CDDIAG:** changed the record (+1 pipe, same content). Drawing unchanged.
3. **CDDASHBOARD (Project Review window):** changed the record (+1 pipe). Closed through the driver's close verb, not by its Close button (the driver refuses that button).
4. **CDCHECKCURRENT:** record unchanged. Also unchanged with the CE record deleted altogether: it did not create one.
5. **CEHEALTH:** record unchanged. (It belongs to Manager and the code reads plugin state only.)
6. **Also found:** Edit Pit (open then Cancel) changed it the same way (section 1).
7. **Not tested:** the other tools on the "read only" list in the plan, and Structural.

## 4. The invented values

Setup in A1: one polyline with no width on `STORMWATER PIPE` and one `PIT BLOCK 3` on `STORMWATER PIT` with no pit label. Edit Pit opened on the new pit, then Cancel.

1. **The pipe line** (millimetre drawing): diameter "100", material "UPVC", from and to blank, grade mode "default", included in the schedule. This came from the hidden update, with no window shown.
2. **The unlabelled pit** (millimetre drawing): number P8 (the next free), type GRATED PIT, plan size 350 x 350 mm, lid "Class A Grated Lid", cover level blank, bottom level blank, plastic pit yes, in schedule no. The Edit Pit window showed P8, 350 x 350 mm and "Bottom level needs checking". All of it was in the record even though Cancel was pressed.
3. **The same in a metre drawing** (scaled by 0.001, units metres, so the new pit was drawn the same real size as the old one): pipe "100", "UPVC". New pit P2, **xWidth and yWidth 350.0**, lid "Class A Grated Lid", plastic, not in the schedule. The old pit in the same record has **0.6** (metres). So one record holds 350 and 0.6 for pits of the same real size.
4. **My code-reading said Class C lid by default.** AutoCAD showed Class A on both. I report what AutoCAD showed.
5. **Do not mix this up:** the 350 is the block's own default width, not a CE guess. It is still wrong for a block drawn at the wrong size, and in a metre drawing it is in the wrong unit.
6. **Not tested:** what a calculation does with a blank cover or bottom level; Edit Pit with Save; a pit whose size attributes are filled in.

## 5. Pit symbol swap on opening, non-Civil drawing

1. **Setup:** a blank AutoCAD template (no CE data, no discipline tag) with one old `PIT BLOCK 2` symbol and one circle, saved. AutoCAD started fresh on it.
2. **What happened:** the block was renamed to `PIT BLOCK 3` and redefined from the current master. The CE log says "[PitBlockMigration] redefined=1 renamed=PIT BLOCK 2 to PIT BLOCK 3" and "auto-migrated on open". The drawing was marked changed. No CE record was created.
3. **What CE printed on the command line:** nothing about it. The only lines were AutoCAD's own "Regenerating model", plus the usual CE-loaded and "Start with CD, PIT..." lines.
4. **Answer:** it runs in a non-Civil drawing and prints nothing to the drafter.
5. **Not tested:** a drawing with an unusual block of the same name that is not a CE pit; a Structural drawing with PIT BLOCK 3 already in place (the Structural test copy already had PIT BLOCK 3 and did not show a swap line).

## 6. Things I did that need no further action

1. **U pressed once at the first state** (before any change): harmless, nothing printed.
2. **A mistyped INSERT:** one pit was inserted with a rotation of 1 degree and "0" typed at the command line. I pressed U and inserted it correctly. A pit inserted in the metre copy at the wrong scale was undone the same way. No file was affected: nothing was saved except the throw-away blank test copy I built on purpose.
3. **A layer command stuck at a prompt** in the metre copy (that copy had no `STORMWATER PIPE` layer). Two driver Esc presses cleared it.
4. **No screenshots were taken.**

## 7. Files (outside every repository)

1. **Scripts and raw reads:** `C:\CE_WORK\scratch\trustprobe\` (`read_record.ps1`, `probe_tool.ps1`, `step.ps1`, `time_check.ps1`, `build_synth.ps1`, `show_record.ps1`, the `reads` folder with every before and after dump, and `RESULTS_RAW.md`).
2. **Copies:** `C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY\` (A1, LARGE, SYNTH, METRE, NONCIVIL, BLANK2 and the CE-made `_PRE_C7_` backups). Safe to delete when no longer needed.

## 8. Defaults taken for Tim to confirm

1. "Largest test copy" taken as the largest CE test drawing (1.3 MB), not the 4 MB consultant file.
2. The made-up drawing has 370 pipes, not 300.
3. The Edit Pit "no change" case was tested with Cancel only, because the driver cannot press Save.
