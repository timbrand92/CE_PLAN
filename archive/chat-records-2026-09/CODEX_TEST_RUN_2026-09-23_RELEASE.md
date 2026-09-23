# CE — Codex AutoCAD test run for the colleague release, 23 September 2026

Paste everything from RUN CONFIG down into a new Codex task.

---

## RUN CONFIG

- **Model: Codex's strongest available model. Thinking: high.**
- **Why:** this run decides what a colleague receives on Tuesday 29 September. A PASS recorded against the wrong build, or a guessed result, puts a broken tool on a colleague's real job.
- **Downgrade option:** none for running the steps. A cheaper model is fine only for tidying the finished report.

---

## 0. What this run is, and who decides

**Tim, 23 Sep 2026:** *"i can get codex to do all testing on autocad whenever up until tuesday"*. You are the AutoCAD tester for the Version 3 colleague release. The release chat (`CE_ACAD / release-v3-colleagues / plan / 01`, Claude) controls every install and reads your report.

**You produce evidence. Only Tim accepts anything.** Built, tested, installed and Tim-accepted are four separate facts.

**Two passes, two builds:**

1. **Pass 1, now:** the build **already installed**, `3.0.0+aeb03763` (installed 23 Sep 12:18 by the release chat, every lane read back by hand). It carries everything built from 16 to 23 Sep plus the close-crash fix (BUG-164). Parts S, R, C, A, V, K and B below.
2. **Pass 2, after Claude installs the colleague package (planned Friday 25 Sep, 2:00 to 3:00pm):** Part Z. **Do not start Part Z until step Z1 reads the new version.**

Area of this run in the plan: `C:\CE_PLAN\areas\release-v3-colleagues.md`.

---

## 1. Rules — follow them exactly (the same rules as the 18 Sep run)

1. **Work on COPIES of drawings only**, in `C:\Lisp Files\_TEST_COPIES_20260923\`. Never the originals. That folder is outside every repository on purpose.
2. **The drawing list is `C:\Users\TimothyBrand\CE_TEST_DRAWINGS_2026-09-17.md`.** It names real job folders. **Never copy a job name, client name or address into `C:\CE_PLAN`, the plugin repo, a commit, or a GitHub issue.**
3. **One of four words per step: PASS · FAIL · BLOCKED · NOT TESTED.** No score, no percentage, no "mostly".
4. **A step with no observation recorded is NOT TESTED.** Never infer one step's result from another.
5. **Screenshot every window step** and every step that says "looks", "reads" or "shows". Name the file by step ID.
6. **On a FAIL, capture all five:** what you did · what you expected · what happened · the exact command-line text · the CE log lines for that minute (`%APPDATA%\CE_CVL_SUITE\logs\`).
7. **If AutoCAD crashes:** say which step, stop that section, restart AutoCAD, carry on with the next section.
8. **Do not fix anything, and do not edit any code, setting file or bundle.** Report and move on.
9. **If you are stopped part-way** (usage limit, crash, Tim needs AutoCAD), **save the partial report** and mark every unreached step NOT TESTED.
10. **Tim needs AutoCAD from 8:30am to 2:00pm and 3:00 to 5:30pm on weekdays.** Run outside those hours unless Tim tells you otherwise himself.
11. **Turn CE diagnostics ON first** and say how in the report.
12. **Re-read this file whenever you pause or finish a part.** The release chat adds to it (new build numbers, new steps) instead of sending a new list. The build number in S1 changes when a new build is installed: **always check S1 against the file, not your memory.**
13. **Do not press F2** on this AutoCAD profile: it runs `CLEAN`, which saved a test copy and, in a second run, Tim's metric drawing template `acadiso.dwt` on 23 Sep. Use `TEXTSCR` or the command-line window to read history.
14. **Keep off Tim's own AutoCAD set-up** (agreed by both release chats, 23 Sep). Use an isolated set-up from `C:\Autodesk\CERef\*-isolate` when the deploy chat has one that runs full AutoCAD with the CE plugins; until then, on Tim's live set-up: **never save a template, a profile or a setting**, answer **No** to every save prompt except on a test copy, and never use F2.
15. **Parts M and X (AutoCAD 2022/2024) are Tim's, on Tuesday, on his virtual machine** (Tim, 23 Sep). Mark them NOT TESTED — Tim's Tuesday check.
16. **State at the top of every report which AutoCAD profile you used** (Tim's own, or which isolated one) and how you started AutoCAD. It cannot be worked out from the results afterwards.

**Report:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_2026-09-23.md`, screenshots beside it. Put a short **FOR TIM** block at the top in plain English, then one row per step ID.

---

## PART S — start-up (gates everything below)

| ID | Step | What "right" looks like |
|---|---|---|
| **S1** | PowerShell: `(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll").VersionInfo.ProductVersion` | **Record the full string.** Pass 1 expects `3.0.0+aeb037639f628e64a98e1cde4d86d2df38c45fcc`. **Anything else: STOP, everything is BLOCKED, tell Claude.** |
| **S2** | Start AutoCAD 2027. Open a COPY of a drainage job. | CE ribbon tab appears. No error dialog, no "unable to load" on the command line. |
| **S3** | Type `CDINSPECTOR`. | It runs. **If any CE command is "Unknown command", stop — nothing below can run.** |
| **S4** | Turn diagnostics on. | Say how you did it. |

---

## PART R — release checks: the three CE plugins together (new)

**Why:** Civil and Manager share one common library, and the first copy AutoCAD loads wins for both. If they disagree, the CE ribbon can silently fail to load. (Tim's Structural 1.0.74 does not use it.) A colleague gets Civil, Manager and Structural together.

**In pass 1 these checks run on the Manager and Structural installed today, which are NOT what ships.** The colleague gets a newer Manager (38 changes never installed) and Structural 1.0.74 plus four window fixes. Those are tested in Part Z only.

| ID | Step | What "right" looks like |
|---|---|---|
| **R1** | Screenshot the whole CE ribbon tab. | Civil, Manager and Structural panels all present. **Icons in their right places** (16 Sep fault R-01 said they were not). Describe anything misplaced. |
| **R2** | Type `CEMANAGER`. | The Manager window opens and shows the installed versions. Record them exactly as shown. Close it. |
| **R3** | Type `CEHEALTH`. | Copy the full command-line output into the report. Any `[WARN]` or `[FAIL]` line is recorded as written. |
| **R4** | Type `CEHELP`. | Structural help opens. Close it. |
| **R5** | In a COPY of a structural job, type `SBEAM` and draw one steel beam; then `RCBEAM` and draw one concrete beam. | Both draw normally. Escape out of each afterwards leaves no half-drawn objects. |
| **R6** | PowerShell: list `CE_SHARED.dll` product versions in `CE_CVL_SUITE.bundle` and `CE_SUITE_MANAGER.bundle`, all lanes. | **All the same version.** Record them. |
| **R7** | Close AutoCAD. Reopen it, reopen the same COPY. | Ribbon loads again with all three. Repeat three times; say if any start differs. |

---

## PART C — AutoCAD closes without crashing (BUG-164, fixed in `aeb03763`)

**Why:** AutoCAD crashed on close 18 times from 15 to 23 Sep; CE's Inspector panel tried to hide itself while AutoCAD was shutting down. Crash reports land in `%LOCALAPPDATA%\CrashDumps` as `acad.exe.<number>.dmp`. **Write down the newest file's time before C1.**

| ID | Step | What "right" looks like |
|---|---|---|
| **C1** | Open AutoCAD, open a COPY of a drainage job, type `CDINSPECTOR` so the Inspector is open. Close AutoCAD normally (answer **No** to saving). | **No crash message.** No new `acad.exe.*.dmp` in `%LOCALAPPDATA%\CrashDumps`. |
| **C2** | Repeat C1 twice more. | Same, each time. |
| **C3** | Open AutoCAD, close the Inspector first, then close AutoCAD. | Same. |
| **C4** | Reopen AutoCAD, open the copy, `CDINSPECTOR`. | The Inspector opens as before. |

---

## PART T — the tank crash, reproduced on purpose (BUG-163)

**Why:** on 16 Sep AutoCAD died during the CDWT callout pick on this drawing. The only damaged object in it is a pasted block holding a **PDF underlay** whose outline AutoCAD cannot compute. A crash here is **expected evidence, not a new failure**. Work on a COPY of `C:\Lisp Files\_TEST_COPIES_20260923\DWG-B_16SEP_PRECRASH.dwg`. Save nothing.

| ID | Step | What "right" looks like |
|---|---|---|
| **T1** | Open the copy. Type `ZOOM`, `C`, `57876,-210513`, height `20000`. The block holding a PDF picture on layer BLOCKS sits there (handle `1041DE`). Screenshot. | You can see where it sits. Record whether the PDF picture shows or is missing. |
| **T2** | `CDWT`, choose any tank, press **Place tank**, pick the insertion point **about 5 m from that block**. At the callout prompt, put the cursor **over the block** and pick there. | **Record exactly what happens.** If AutoCAD stops with "cannot continue", that is the finding: say so plainly, and after restarting note the newest folder in `%LOCALAPPDATA%\Autodesk\CER`. |
| **T3** | Same as T2, but pick the callout point **far from the block** (over 50 m away, nothing else under the cursor). | Record. A difference between T2 and T3 points at the block. |
| **T4** | **Control.** Same as T2, but at the callout prompt **press F3 first** (object snap off; the command line says `<Osnap off>`), then pick over the block. *(Setting OSMODE to 0 before CDWT is NOT a control: CE sets it to Nearest for this prompt whatever it was.)* | Record. If T2 crashes and T4 does not, the Nearest snap is implicated. |
| **T5** | Same as T2, but press **Enter** at the callout prompt instead of picking. | Record. |
| **T6** | Repeat T2 on a COPY of `DWG-A`, picking over any block. | Record. |

**Nobody fixes this on these results alone.** Forcing Nearest at the callout pick is Tim's own BUG-127 request; changing it needs his ruling on Tuesday.

---

## PART A — the 18 September list, now installed and never run

**Everything in `C:\CE_PLAN\archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-18.md` is inside the installed build** (its payload `0a84eb07` was checked as contained in `d90659cf`, which `b02f3ec7` contains, 23 Sep). It has never been run.

1. **Run it all, Parts N onward, in its order** (CDWT first, then CD, PIT and the rest).
2. **Skip its Part S and its "section 0" stop rule** — this list's S1 replaces them. Its S1 said "must not be `d0ffe1a2`"; the installed `b02f3ec7` contains that payload and more.
3. **Its section 3a (the short LPD note) may no longer apply**: overnight fix V1 below changed the default. Record what the note actually reads and move on.
4. **Its section 3b (a cancelled editor still costs one Undo) is still open.** Expect it; report only if it behaves differently.
5. **Its Part X (AutoCAD 2024) cannot run on this PC** — only AutoCAD 2027 is installed here. Mark X1 and X2 **BLOCKED — no AutoCAD 2024/2022 on this PC.** The 2022 check is Part M below and is not yours.

---

## PART V — the eighteen overnight fixes of 19 September, installed and never run

The steps are the table **V1 to V18** in `C:\CE_PLAN\PENDING_TESTS.md`, section *"BUILT overnight 18→19 Sep"*. That section's heading still says NOT INSTALLED; **it is installed now**, inside `b02f3ec7`. Run all eighteen in order, 2027 only.

---

## PART K — the 16 September faults, re-checked by name

Tim's 16 Sep test day recorded **37 faults**: `C:\CE_PLAN\decisions\2026-09-16_TEST_DAY_RESULTS.md`, section 2 (R-01 to R-02, W-01 to W-05, P-01 to P-08, C7-01 to C7-03, L-01 to L-03, T-01, D-01, G-01 to G-04, TWL-03 to TWL-07, F1-01 to F1-05).

1. **For each fault ID, one row: does it still happen on this build?** PASS means the fault is gone; FAIL means it still happens.
2. **Reuse your Part A and V observations where they cover the same thing** — say which step covers it. Where nothing in A or V covers a fault, **reproduce it directly** from the description in that file.
3. **Questions in that file** (P-06, TWL-07, G-04's view) are not faults to reproduce; mark them **NOT TESTED — a question for Tim**.

---

## PART B — the deploy chat's list for this build, folded in (agreed by both release chats, 23 Sep)

Run **`C:\CE_PLAN\CODEX_TEST_RUN_2026-09-23.md`**, Parts **T, R, P, L, D and Z**, in its order. It was written for `b02f3ec7`; the installed `aeb03763` contains it and adds only the close-crash fix and a build-file fix.

1. **Its section 0 and Part S are covered by this list's S1–S4.** Do not run them twice.
2. **Its section 3 lists three known faults** (the cancelled-window Undo, the CDWT crash, the CD window scrolling). Treat them as it says.
3. **Its step IDs clash with this list's letters** (both have an R, a T and a Z). **Prefix its IDs with `B-`** in your report: `B-T1`, `B-R1`, `B-Z1`.
4. **Its Part X (AutoCAD 2024) cannot run on this PC.** Mark it **BLOCKED — no AutoCAD 2024/2022 on this PC**. It is carried to the Monday 2022 check.
5. **Its T8 is the tank crash probe.** A crash there is expected. Say so, restart AutoCAD, carry on.

---

## PART Z — pass 2, on the colleague package (only after Claude says it is installed)

| ID | Step | What "right" looks like |
|---|---|---|
| **Z1** | S1 again. | **A new version string, not `aeb03763`.** Claude will tell you the exact one. If it still reads `aeb03763`, **STOP: Part Z is BLOCKED.** |
| **Z2** | Parts S2–S4 and all of Part R again. | Same as pass 1. |
| **Z3** | **The tank finds its own plan (CDWT-LINK-01), on the package.** Re-run Part B's **T1 to T6**. | The same as in pass 1. Record each as `Z3-T1` and so on. **Never** copy a pass-1 result forward. |
| **Z8** | Re-run every step that was **FAIL** in pass 1 **and was fixed since**. Claude lists them when the package is installed. | Record each as its own row. **Never** copy a pass-1 result forward. |

**Manager — 38 changes never installed on any PC before this package.** Before each step, **save the drawing copy**, so `DBMOD` reads 0.

| ID | Step | What "right" looks like |
|---|---|---|
| **Z9** | `CEMANAGER`. Screenshot every page you open. | The window opens. It shows Civil, Manager and Structural versions that match the package Claude names. **Copy exactly what it says about updates.** |
| **Z10** | In Manager, open **Settings**. Change one harmless value (the theme preview). Press **Discard** or **Cancel**. Close and reopen Manager. | The value is **back as it was**. Nothing saved. |
| **Z11** | Same, but **Apply**. Close and reopen. Then put it back and Apply again. | The change **stays** after reopening, then goes back. |
| **Z12** | In Manager, open **Help**. | Civil help opens and reads in plain English. Record any page that is blank or shows an error. |
| **Z13** | In Manager, open **Project QA** and **Drawing Repair**. Look, then close each with **Cancel**. Type `DBMOD`. | Both open. `DBMOD` reads **0**: looking changed nothing in the drawing. |
| **Z14** | `CESURVEYREVIEW`, then **Cancel**. Type `DBMOD`. | It opens; `DBMOD` reads **0**. |

**Structural — 1.0.74 plus Codex's four window fixes of 15 Sep, never installed.**

| ID | Step | What "right" looks like |
|---|---|---|
| **Z15** | `CESETTINGS`. Change one value, **Save**. Reopen `CESETTINGS`. | The value **stayed**. |
| **Z16** | `CESETTINGS`. Change a value, then press **Cancel**. Reopen. Repeat with **Escape**. | Both times the value is **unchanged**. |
| **Z17** | `CENOTES`. Press **Refresh**, select a note, then **Escape**. | Refresh works, the selected note shows, Escape closes. |
| **Z18** | From the Structural panel, open **Project Setup** and **Properties**; close each with **Escape**. | Both open and close; nothing saved. |
| **Z19** | `CESHEETS`. Go to **Issue / Publish** with **no sheet ticked** and press **Publish**. Then **Cancel**. | A plain validation message says what is missing; **nothing is published**; Cancel closes. |
| **Z20** | In a COPY of a structural job: `SBEAM`, draw one steel beam; `RCBEAM`, draw one concrete beam. Then `U` once for each. | Both draw normally; each `U` removes that beam whole. |
| **Z21** | PowerShell: list the files in `CE_STRUC_SUITE.bundle\Contents\Win64\Modern\`. | **No `CE_SHARED.dll`** there. Structural does not use the common library. |

---

## PART M — AutoCAD 2022, Monday 28 Sep, on a colleague's PC — NOT for Codex

Tim arranges 30 minutes on a colleague's 2022 PC (Tim, 23 Sep: *"Yes, Monday"*). **Tim or the colleague runs these, not Codex** — this PC has AutoCAD 2027 only.

**Why it matters:** nobody has ever opened Civil 3.0 in AutoCAD 2022. This is also the first real run of the hand install and the going-back steps (area REL, REL-09) on a colleague's PC.

**Default:** the colleague goes back to their July version at the end (step M9), because Tuesday's pilot is a 2027 colleague. Tim can say keep it instead.

| ID | Step | What "right" looks like |
|---|---|---|
| **M1** | Before anything: open AutoCAD 2022, type `CEMANAGER` (or look at the CE About box). Write down the versions shown. Close AutoCAD. | Their July versions (expected Civil 2.1.14, Manager 1.0.2, Structural 1.0.40). Whatever it says, write it down. |
| **M2** | Task Manager: no `acad.exe`, no `accoreconsole.exe`. Then the REL-09 install: in `%APPDATA%\Autodesk\ApplicationPlugins` rename the three CE folders by adding `_PRE_V3.backup`; check `C:\ProgramData\Autodesk\ApplicationPlugins`: a CE `.bundle` folder there **with a live `PackageContents.xml`** means stop and tell Tim (an old July Manager there carries common library 1.0.0 and would load first); one whose `PackageContents.xml` is renamed or missing is harmless: note it and carry on. Then copy in the three new `.bundle` folders. | Three new folders, three `_PRE_V3.backup` folders, no live CE bundle in ProgramData. |
| **M3** | Open AutoCAD 2022. Read the command line from start-up. | CE ribbon tab loads with Civil, Manager and Structural. **No** "unable to load", no error box. |
| **M4** | `CEMANAGER`. | Shows Civil **3.0.0**, Manager **1.1.0**, Structural **1.0.74**. |
| **M5** | On a COPY of a drainage job: `CD`, draw one pipe between two pits with levels. Double-click it, change the diameter, OK. `U` once. | Pipe, text, arrow and levels land; the text shows the new size; one `U` takes the edit back. |
| **M6** | `PITSCHEDULE` on the same copy. | Opens and lists the pits. |
| **M7** | On a COPY of a structural job: `SBEAM`, draw one beam. | Draws normally. |
| **M8** | **Mixed versions:** open a COPY of a drawing Tim has worked on in Version 3 on AutoCAD 2027 (pipes converted with `CDC7UPGRADE`). Click a pipe. | **Write down exactly what shows** — the pipe draws, can be picked, and what the Properties palette calls it. A warning about missing objects is information, not a failure. |
| **M9** | Close AutoCAD. Note any crash message (BUG-164). Then go back: delete the three new folders, remove `_PRE_V3.backup` from the three old names, open AutoCAD, `CEMANAGER`. | The July versions from M1 are back and the ribbon loads. |

**Send Claude:** the M1 and M4 versions, a photo of anything unexpected, and what M8 showed.

---

## What happens with your report

The release chat reads it, fixes FAILs one area at a time (CDWT, CD, PIT first, as Tim ordered on 16 Sep), and hands those back to you for Part Z8. **Nothing you record goes to a colleague as "accepted" — Tim decides what ships.**
