# TRUST-S2: Structural safety fixes (CLEAN, save reminder, SBEAM, Reset)

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card.
**Class:** Modify (fixes to existing tools). Nothing is retired.
**Source:** the week of 5 Nov: about 3 hours of drawing work lost (CLEAN had stopped saving, no reminder), an AutoCAD crash in SBEAM (BUG-1275), no CE backup for hours (BUG-1276). Tim, 6 Nov: "the clean and save fix is for me". Step S2 of `areas\trust-plan-structural.md`.
**Overlap:** card TRUST-04 lists the Structural reminder, SBEAM and bracing fixes. This card takes the reminder and SBEAM from it and adds three CLEAN pieces and Reset Defaults. The bracing fixes (BUG-497, 498, 499) stay with card TRUST-04, where they are built as drafts (pull requests 2044, 2046, 2047); step S4 covers only what is left (corrected 13 Nov after review). TRUST-04's Structural half points here once Tim approves.

---

## FOR TIM

**CLEAN saves again on your PC (1.0.126). What is left: CLEAN's words disagree with what it does, it can say "saved" without being sure, one locked object stops a whole step, there is no reminder or backup copy when work goes unsaved, SBEAM crashed AutoCAD on 5 Nov, and Reset Defaults wipes every Structural setting without asking.**

```before
CLEAN tooltip: "Does not save: save the drawing yourself."  (it does save)
Settings page: "CE never saves."
One text on a locked layer: the whole text clean-up step fails.
Two hours without a save: a small palette label, nothing on the command line.
Reset Defaults: closes at once, every Structural setting back to factory.
```

```after
CLEAN tooltip: "Cleans up, then saves the drawing and says so."
CLEAN: "1 text on locked layer TITLE left as it was." ... "Saved."
  or "NOT SAVED: save the drawing yourself." when it cannot confirm.
After 25 minutes unsaved: "Not saved for 25 minutes." (one plain line)
Every 10 minutes: a backup copy of the unsaved work in the CE backup folder,
  never over your drawing.
Reset Defaults: "Put every Structural setting back? A copy of your current
  settings is kept." Yes / No.
```

## Decisions for Tim (read these first)

1. **CLEAN meets a locked object.** Recommended: skip it, list it, carry on and save. Example: a locked title-block layer no longer stops the text clean-up. OPEN.
2. **Reminder and backup copies: DECIDED, not a question.** Your decision 223 (`decisions\2026-10-29_TIM_ANSWERS.md`, line 830), answering item 133: "c" = both, recorded as: build the "Not saved for 25 minutes" reminder (a plain line; the 25 Sep ruling) AND timed backup copies of unsaved work, to the CE backup folder only, never over your drawing and nothing written behind your back to the drawing file. The record notes you named neither number: 25 minutes comes from your 25 Sep ruling; a backup every 10 minutes is the desk's default (marked GUESS there). Both are Settings values. Card TRUST-04 still recommends 15 minutes for Civil; it should follow the same decision.
3. **One small Structural safety build** with S2 and S4 together, after each fix passed alone. Recommended, because two installs one after the other can wipe each other (RULES 8.5). OPEN.

## 1. What you'd see, fix by fix

1. **CLEAN's words.** The tooltip, its long help and the Settings page all say CLEAN saves. Verified today: tooltip and long help disagree (`Assets\Config\command-registry.json:4145-4146`); the Settings page says "CE never saves" (`UI\Dialogs\CeSettingsDialog.xaml:557`).
2. **CLEAN only says "saved" when the save happened.** Today, if CE's own save fails, it sends QSAVE and counts the save as done without checking (Verified, `Services\CleanPipelineService.cs:167-169`). After: it reads the drawing's saved time back; if it did not change, "NOT SAVED".
3. **CLEAN and locked layers.** Today the text and ByLayer steps open each object for change with no locked-layer allowance, so one locked object fails the whole step (Verified by reading: `CleanPipelineService.cs:409, 526` open each object for change with no locked-layer allowance; any error ends the step at `232-236` before its changes are kept. Not seen in AutoCAD). After: locked objects are skipped and listed (decision 1). Nothing is ever unlocked.
4. **The save reminder and backup copies (BUG-1276, Structural half; decision 223).** One plain line, "Not saved for 25 minutes", on the command line. Separately, a backup copy of the unsaved work every 10 minutes into the CE backup folder only: never over your drawing, never written into the drawing file. Today the timed save is removed and its interval settings sit unused (Verified, `Services\DrawingAutoSaveService.cs:1112-1118`); the existing backup copies only copy the last saved file (same lines). CE never saves your drawing for you.
5. **SBEAM: a guard is added; the crash itself is not reproduced or proven fixed (BUG-1275).** The guard on the held S-46 build stops SBEAM opening an object that is gone or belongs to another drawing. The crash-dump note says that guard does not account for the 5 Nov crash, so this card makes no claim that the crash is fixed, and SBEAM stays typed only (TRUST-S1) until the crash is reproduced on a copy and shown not to happen.
6. **Reset Defaults asks first and keeps a copy.** Today it saves brand-new settings and closes with no question (Verified, `UI\Dialogs\CeSettingsDialog.xaml.cs:475-478`).

## 2. The full experience

1. **Cancel and Escape:** Esc during CLEAN leaves the drawing as AutoCAD leaves it after an Esc; no half-saved file. The reminder has nothing to cancel.
2. **Undo:** CLEAN's changes are one U, as today (to be proven, never assumed). The reminder never touches the drawing.
3. **Save and reopen:** after CLEAN, close and reopen: the cleaned drawing is what opens.
4. **Locked layers, Xrefs, REFEDIT:** never unlocked, never detached; Xref drawings themselves are skipped, as today.
5. **AutoCAD 2022 to 2024:** each fix checked there too.

## 3. Settings

1. **Save reminder:** on or off, and the minutes. Default on, 25 minutes (decision 223).
2. **Backup copies of unsaved work:** on or off, the minutes and the folder. Default on, every 10 minutes, the existing CE backup folder (decision 223; the 10 is a default, not your number).
3. **CLEAN locked-layer behaviour:** no switch; skipping and listing is the native protection rule, not an option.
4. **No switch for the wording, the save check or the SBEAM guard.** A fix to a wrong result does not get an off switch.

## 4. What it reuses

1. **CE's own save** inside CLEAN (B-178).
2. **The held fixes** on the S-46 branch for BUG-1275 and BUG-1276, each re-read and re-reviewed before lifting.
3. **The palette's save timer,** which already counts minutes since the last save.

## 5. How it gets proven

**Robot, AutoCAD 2027, each with a broken twin that must fail:**

1. CLEAN on a made-up copy: the file's saved time moves; the line says "Saved".
2. CLEAN on a copy the robot has locked open in another program, with AutoCAD's file dialogs switched off (FILEDIA 0) so a Save As window cannot appear and stall the run: "NOT SAVED" and the file is unchanged. Twin: a build that says "Saved" anyway must fail. (Corrected 13 Nov after review: a read-only file would make CE's fallback QSAVE open the Save As window, because CLEAN does not refuse a read-only drawing first.)
3. CLEAN on a copy with one text on a locked layer: that text unchanged, every other text cleaned, the line names it.
4. Edit a copy without saving past the set time: exactly one "Not saved for 25 minutes" line, the drawing's changed-flag untouched by CE, the drawing file on disk unchanged.
5. Edit a copy without saving for 10 minutes: one backup copy appears in the CE backup folder and holds the unsaved work; the drawing file on disk is unchanged. Twin: a build that writes over the drawing must fail.
6. SBEAM with a deliberately stale object: the guard refuses with a plain line. This proves the guard only, not the 5 Nov crash.
7. Reset Defaults, No: settings file unchanged. Yes: copy kept beside it.

**Codex:** reads every new line and the Reset question.

**Tim, about three working days:** CLEAN at the end of each session. Right = it always says Saved or NOT SAVED, and you never lose work.

## 6. Not known yet

1. **Why CE made no backup for hours on 5 Nov** (BUG-1276 cause). The reminder is a guard, not the cure.
2. **What caused the 5 Nov SBEAM crash.** The guard does not explain it, by the crash-dump note. Not reproduced.
3. **Whether CLEAN's changes are truly one U.** Never robot-checked.

Written from reading Structural 1.0.126 (commit 8de95c34). Nothing here was run in AutoCAD.
