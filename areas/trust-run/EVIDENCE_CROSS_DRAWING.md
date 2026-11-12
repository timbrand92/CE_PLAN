# CDHELP and CDS in a second drawing: does CE write the first drawing's job into it? (lane trust-acad-evidence)

**Written:** Fri 13 Nov 2026, 04:50. **Build tested: the INSTALLED one** (Civil 3.0.90, commit `cf059dcf`), real AutoCAD 2027, copies only, nothing saved over anything. The AutoCAD used (process started 03:36) is mine, started by this session. **Status: DRAFT evidence, seen on the robot's own run; not Codex-looked, not Tim-accepted.**

---

# FOR TIM

1. **Yes. The mix-up is real and I have seen it happen, in both directions.** If you work in one job, then open a second drawing and, as the very first thing, run Help (CDHELP) or Settings (CDS), CE can write the FIRST job's pits and pipes into the SECOND drawing. Seen on the installed build, four times in six tries.
2. **A drawing with no CE data got a whole job.** I opened a blank drawing second and ran CDHELP. The blank drawing's stored record then held the first job's 11 pits and 49 pipes. Its "changed" counter went from 0 to 1, so closing it would ask "save changes?" and saving would keep that job inside it.
3. **A different job lost its own record.** The second job had 2 pits and 46 pipes. After CDHELP its stored record read 11 pits and 49 pipes (the first job's). Its own 2 pits and 46 pipes were gone from the stored record.
4. **The other way round too.** I read a second job into CE's memory first, then switched to the standard drawing and ran CDHELP: the standard drawing's record (11 pits and 49 pipes) was replaced by the second job's (2 pits and 46 pipes).
5. **CDS does it too,** not only CDHELP: in a repeat, CDS opened and closed with no change did the same thing.
6. **It does not happen every time.** It needs CE to be holding another drawing's record in memory and nothing else to have run in the new drawing first. When I ran any plain AutoCAD command in the second drawing first (a circle, then U), CDHELP and CDS then kept that drawing's own record (only the format number and stored file path were refreshed). In one run after a cancelled PIT and a cancelled CD, CDHELP changed nothing.
7. **What a drafter would see:** nothing at the time (the window opens and closes normally). Later, a tool that reads the record (the schedule, the checks, Edit Pit) could read another job's pits and pipes against this job's drawing, and a blank drawing would ask to save.
8. **Did I check "switching back to A"?** Yes: A's own record was unchanged when I came back to it in the first sequence, because CE's memory at that point was A's.
9. **Do cancelled CD and PIT rewrite the record?** It depends. In a freshly started AutoCAD, a cancelled PIT did rewrite the whole stored record at the end, but the only changes were the format number (2.2 to 2.3) and the stored file path being refreshed; no pit or pipe value changed. A cancelled CDAGI, CDSTRIP and CDRUNSOLVE did the same, and a cancelled CDFW also added identities to the pipes. In the longer session that followed, a cancelled PIT and a cancelled CD changed nothing. A cancelled CD at the uphill question changed nothing either.

**What would settle the cause:** the fix is the one the reviewer proposed: attach the current drawing's record before CE's end-of-command write, or skip the write when nothing is waiting. The foundations lane has a switch for it on PR 2064 (`trust.cancelledCommandWritesNothing`).

---

# DETAIL

**Windows closed:** CDHELP opens "Creative Engineering | Help Centre" and CDS opens "Creative Engineering | Settings (CDS)". The driver closed both with its window-close verb every time (it reported "closed" and AutoCAD went idle). CD_Settings.json kept the same hash (`ACD64E79A33B`) after CDS. The driver did not stop anywhere, so no steps for a person are needed.

**Reading the record:** CE's stored record (dictionary `CE_CVL_SUITE_PROJECT`, key `PROJECT_DATA`) was read over COM before and after, with the pit and pipe counts and the stored drawing path taken from it. "A's job in B" below means pits=11, pipes=49 and a stored path naming copy A.

1. **Sequence 1 (the first run, then reproduced once).** A = the standard test drawing copy, with CDDIAG, CDHELP and CDS run in it. B = a copy of a second, older job (record: 2 pits, 46 pipes, path of its own origin).
   1. B opened: 2 pits, 46 pipes. CDHELP then close: **11 pits, 49 pipes, path = A's copy** (record 37,921 to about 247,000 characters). CDS then close: no further change.
   2. Reproduced in repeat R1 (fresh copies): B 2/46 to 11/49 after CDHELP. DBMOD was already 1 (opening marks the drawing changed) so the counter could not show it.
2. **Sequence 2, the blank drawing (no CE data).** Opened after A and B: before, no CE dictionaries, DBMOD 0. After CDHELP then close: **record present, 11 pits, 49 pipes, path = A's copy; DBMOD 1.** CDS then close: unchanged from that. Reproduced in repeat R2 (DBMOD 0 to 1).
3. **Sequence 3, back to A.** A's record before and after switching back, and after CDHELP and CDS in A, identical (11/49, A's path): in that state CE's memory was A's own record.
4. **CDS alone (repeat R3):** CDDIAG in A, open B (2/46), CDS then close, nothing else: B became 11 pits, 49 pipes, path = A's copy. So CDS is affected, not only CDHELP.
5. **Controls that did NOT show it:**
   1. A fresh second-job copy, a plain command (a circle) and U, then CDS: B kept its own 2/46; path and format number refreshed only (record 37,921 to 38,035).
   2. Repeat R4: A with CDDIAG, open B, a circle and U, then CDHELP: B kept its own 2/46 (path rebound to B).
   3. A fresh second-job copy, CDHELP alone with memory last held by another run of the same job: record kept the same content (only the path changed to the earlier copy's name). A copy of the same job can hide the mix-up; use two different jobs to see it.
   4. A fresh second-job copy and a blank drawing after the controls ran a cancelled PIT and CD in A: CDHELP and CDS changed nothing (DBMOD 1 and 0 as before; blank stayed with no CE dictionaries).
6. **The other order (C3).** A fresh second-job copy opened first and CDDIAG run in it (its record path now its own copy, 2/46); then A made current: before CDHELP A held 11/49 (path A). After CDHELP then close: **2 pits, 46 pipes, path = the second job's copy** (record 600,234 to 390,665 characters). CDS then close: unchanged from that.
7. **Cancelled CD and PIT, details.** First fresh AutoCAD session: PIT then Esc: record text changed (241,927 vs 242,072 characters of record text; the only differences: `version` 2.2 to 2.3 and `drawingPath` re-pointed to the open file; every pit and pipe field equal). One U put it back exactly (`TRUST_PROBES_13NOV.md` section 9). Longer session (C4): cancelled PIT and then cancelled CD in a fresh A copy: record identical before and after each (600,382 characters).
8. **Not proven:** saving the contaminated drawing (I never saved); what exactly a later CE tool does with the wrong record; the dependence on what ran in the previous drawing (my best reading: the first CE command that ends a drawing's use binds the record, and CDHELP and CDS write the record held in memory at their end without first binding it to the current drawing, as the reviewer thought; the drawing pair that shows it needs a CE command like CDDIAG to have run in the first drawing). I also did not run the Edit Pit, Pit Schedule or Project Review windows in a contaminated drawing.
9. **What I did not do:** change any setting; touch anything but copies under `C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY` (copies named CLDTP_X*.dwg); send anything anywhere.
10. **Files:** `C:\CE_WORK\scratch\trustprobe\ab\cross*.txt` (the run transcripts), `reads\X*` (the record dumps).
