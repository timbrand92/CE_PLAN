# Real finished jobs: copy and reading-only study (Sun 15 Nov 2026)

Status: DONE for steps 1 to 3 as far as can be done without AutoCAD. Coded names only; the key stays on Tim's PC (see the technical notes).

## FOR TIM

1. **Copied: 5 finished jobs, 5 drawing files, 7.9 MB in all** (limit was 2 GB). Civil (council stormwater): JOB_A (2023), JOB_B (2024), JOB_C (2025). Structural: JOB_D (2024), JOB_E (2025). One drawing file each: the last issued revision of that discipline's drawing. Each copy is at `C:\CE_WORK\realjobs\<code>\sheet01.dwg`, outside every repository and outside OneDrive.
2. **The originals are untouched, and this is how I know.** For every source file I recorded its SHA-256 fingerprint, last-saved time and file flags before and after copying: all identical. The copy also has the identical fingerprint to its source. For each whole job folder I also recorded the file count, total bytes and newest save time before and after: all identical, so nothing was created, changed or removed in those folders. The proof is in `C:\CE_WORK\realjobs\SOURCE_UNTOUCHED_LOCAL_ONLY.txt` (codes and fingerprints only).
3. **"Finished" was tested, not assumed.** Every file in each of the five job folders was last saved more than nine months ago; the most recent save of any file in any of the five is August 2025, about 15 months ago. Each job also has issued drawings as PDFs in its issued-drawings folder, with 4 to 8 issued PDFs per job, not counting set-up sheets.
4. **What could be read without AutoCAD: only the basics.**
   1. **File age of the drawing format:** JOB_A, JOB_C and JOB_E are saved in the current format (AutoCAD 2018 to 2027). JOB_B and JOB_D are saved in the older 2010 to 2012 format (AutoCAD still opens these fine).
   2. **Sizes and counts** per job (technical notes 3 and 4).
   3. **Nothing about the drawing's contents.** Inside a drawing of this type the data is compressed, so no layer names and none of CE's own record names (such as the Civil project record) can be seen from outside. The counts of CE layer names and CE record names came to **zero in all five**, and that zero means "not visible this way", not "not made with CE". I am not claiming either way.
5. **What is needed next:** a time slot with AutoCAD (any session that is free), to open the five copies and read, by CE's own reader, which have CE's record, which record generation, and which layers and blocks were used. The controller arranges that. Nothing else is blocked. No patterns are offered to you yet because none could be honestly read.

Not touched: AutoCAD and the core console were not started; `C:\CE_DrawingIntelligence` was not opened; no code, pull request or install; no agents spawned.

---

## Technical notes

1. **Disk:** C: had 22.8 GB free at the start (limit 15 GB). The copies add 7.9 MB.
2. **How jobs were chosen:** the Projects folder was listed read-only, one level at a time. Jobs from 2022 to 2025 were scanned (file metadata only, no file contents) for: newest save time of any file in the job before 15 Feb 2026; a Civil drawing and, for Structural, a Structural drawing in the job's top level; issued PDFs in the issued-drawings folder; council or legal-point-of-discharge material in the Civil folder. Small drawings and a spread of years were preferred. The five drawing files were all already on this PC (not online-only placeholders; the script refuses any file that is). No file attribute was changed. Reading them did not download anything.
3. **Per job (counts):**
   1. **JOB_A:** 180 files in the job folder, 19 drawings, 13 backups, 8 issued PDFs in 10 issue folders. Copy 1,114,982 bytes. Format AC1032.
   2. **JOB_B:** 63 files, 6 drawings, 5 backups, 4 issued PDFs in 4 issue folders. Copy 1,196,325 bytes. Format AC1024.
   3. **JOB_C:** 174 files, 41 drawings, 6 backups, 7 issued PDFs in 4 issue folders. Copy 1,153,979 bytes. Format AC1032.
   4. **JOB_D:** 216 files, 18 drawings, 13 backups, 8 issued PDFs in 7 issue folders. Copy 2,826,847 bytes. Format AC1024.
   5. **JOB_E:** 169 files, 29 drawings, 4 backups, 5 issued PDFs in 2 issue folders. Copy 2,033,492 bytes. Format AC1032.
4. **Header facts:** AC1024 is the AutoCAD 2010 to 2012 file format; AC1032 is the 2018 to 2027 format. Code page field is the same in all five. The counts above are from the file's first bytes and the folder listing only.
5. **Plain-string search, what was counted and the result:** the names searched for were CE's Civil project record name and its family, CE's Structural record family prefix, the CE shared prefix, the stormwater pipe and pit layer names, "PIT", and generic drawing-database words. The five files were searched as plain text and as two-byte text. Results: no CE record name and no CE layer name appeared in any file. The only hits were the generic database words and one to two chance matches of the three letters "PIT" in the binary data of JOB_A, JOB_D and JOB_E, which mean nothing. Because the contents are compressed, this method cannot answer the question. No text from inside any drawing is quoted anywhere.
6. **Not done, on purpose:** I did not write a decompressor for the drawing format; that is new code and a guess at structure Tim has not asked for. AutoCAD (or a loaded CE reader on the core console) is the right tool, which needs a slot, so I stopped.
7. **Local-only files on Tim's PC (never copied elsewhere):** the key file (code to real folder) is `C:\CE_WORK\realjobs\KEY_LOCAL_ONLY.txt`; the originals-untouched record is `C:\CE_WORK\realjobs\SOURCE_UNTOUCHED_LOCAL_ONLY.txt`; the three helper scripts are in `C:\CE_WORK\realjobs\_scripts\`. The copied drawings carry the clients' title blocks inside them, so screenshots of them stay on this PC.
8. **Scope kept:** copies only, finished jobs only, Civil and Structural, one drawing each. Running Structural tools on the copies was not asked (QUEUES, section "REAL FINISHED JOBS MAY BE COPIED", point 4).
