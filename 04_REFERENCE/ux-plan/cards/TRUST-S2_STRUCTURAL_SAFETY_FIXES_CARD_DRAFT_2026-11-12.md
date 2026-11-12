# TRUST-S2: Structural safety fixes (CLEAN, save reminder, SBEAM, Reset)

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card.
**Class:** Modify (fixes to existing tools). Nothing is retired.
**Source:** the week of 5 Nov: about 3 hours of drawing work lost (CLEAN had stopped saving, no reminder), an AutoCAD crash in SBEAM (BUG-1275), no CE backup for hours (BUG-1276). Tim, 6 Nov: "the clean and save fix is for me". Step S2 of `areas\trust-plan-structural.md`.
**Overlap:** card TRUST-04 lists the Structural reminder, SBEAM and bracing fixes. This card takes the reminder and SBEAM from it and adds three CLEAN pieces and Reset Defaults; the bracing fixes are card S4. TRUST-04's Structural half points here once Tim approves.

---

## FOR TIM

**CLEAN saves again on your PC (1.0.126). What is left: CLEAN's words disagree with what it does, it can say "saved" without being sure, one locked object stops a whole step, there is no reminder when work goes unsaved, SBEAM can crash AutoCAD, and Reset Defaults wipes every Structural setting without asking.**

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
After 20 minutes unsaved: "CE: 20 minutes of work not saved in this drawing."
Reset Defaults: "Put every Structural setting back? A copy of your current
  settings is kept." Yes / No.
```

## 1. What you'd see, fix by fix

1. **CLEAN's words.** The tooltip, its long help and the Settings page all say CLEAN saves. Verified today: tooltip and long help disagree (`Assets\Config\command-registry.json:4145-4146`); the Settings page says "CE never saves" (`UI\Dialogs\CeSettingsDialog.xaml:557`).
2. **CLEAN only says "saved" when the save happened.** Today, if CE's own save fails, it sends QSAVE and counts the save as done without checking (Verified, `Services\CleanPipelineService.cs:167-169`). After: it reads the drawing's saved time back; if it did not change, "NOT SAVED".
3. **CLEAN and locked layers.** Today the text and ByLayer steps open each object for change with no locked-layer allowance, so one locked object fails the whole step (Verified by reading: `CleanPipelineService.cs:409, 526` open each object for change with no locked-layer allowance; any error ends the step at `232-236` before its changes are kept. Not seen in AutoCAD). After: locked objects are skipped and listed (decision 1). Nothing is ever unlocked.
4. **The save reminder (BUG-1276, Structural half).** One line on the command line after a set time with no save, then every 10 minutes. Uses the interval setting that already exists and is unused (Verified, `Services\DrawingAutoSaveService.cs:1112-1118`). CE never saves for you.
5. **SBEAM no longer crashes on a stale object (BUG-1275).** The fix is lifted alone out of the held S-46 build and re-read first. If it does not cover the 5 Nov crash, SBEAM stays typed only (TRUST-S1).
6. **Reset Defaults asks first and keeps a copy.** Today it saves brand-new settings and closes with no question (Verified, `UI\Dialogs\CeSettingsDialog.xaml.cs:475-478`).

## 2. The full experience

1. **Cancel and Escape:** Esc during CLEAN leaves the drawing as AutoCAD leaves it after an Esc; no half-saved file. The reminder has nothing to cancel.
2. **Undo:** CLEAN's changes are one U, as today (to be proven, never assumed). The reminder never touches the drawing.
3. **Save and reopen:** after CLEAN, close and reopen: the cleaned drawing is what opens.
4. **Locked layers, Xrefs, REFEDIT:** never unlocked, never detached; Xref drawings themselves are skipped, as today.
5. **AutoCAD 2022 to 2024:** each fix checked there too.

## 3. Settings

1. **Save reminder:** on or off, and the minutes. Default on, 20 minutes (decision 2).
2. **CLEAN locked-layer behaviour:** no switch; skipping and listing is the native protection rule, not an option.
3. **No switch for the wording, the save check or SBEAM.** A fix to a wrong result does not get an off switch.

## 4. What it reuses

1. **CE's own save** inside CLEAN (B-178).
2. **The held fixes** on the S-46 branch for BUG-1275 and BUG-1276, each re-read and re-reviewed before lifting.
3. **The palette's save timer,** which already counts minutes since the last save.

## 5. How it gets proven

**Robot, AutoCAD 2027, each with a broken twin that must fail:**

1. CLEAN on a made-up copy: the file's saved time moves; the line says "Saved".
2. CLEAN on a read-only copy: "NOT SAVED" and the file is unchanged. Twin: a build that says "Saved" anyway must fail.
3. CLEAN on a copy with one text on a locked layer: that text unchanged, every other text cleaned, the line names it.
4. Edit a copy without saving past the set time: exactly one reminder, the drawing's changed-flag untouched by CE, no file written.
5. SBEAM with a deliberately stale object: no crash, a plain line.
6. Reset Defaults, No: settings file unchanged. Yes: copy kept beside it.

**Codex:** reads every new line and the Reset question.

**Tim, about three working days:** CLEAN at the end of each session. Right = it always says Saved or NOT SAVED, and you never lose work.

## 6. Decisions for Tim

1. **CLEAN meets a locked object.** Recommended: skip it, list it, carry on and save. Example: a locked title-block layer no longer stops the text clean-up. OPEN.
2. **Reminder time.** Recommended: 20 minutes, then every 10 (TRUST-04 recommends 15 for Civil; one number for both is better, so this is one decision for both cards). OPEN.
3. **One small Structural safety build** with S2 and S4 together, after each fix passed alone. Recommended, because two installs one after the other can wipe each other (RULES 8.5). OPEN.

## 7. Not known yet

1. **Why CE made no backup for hours on 5 Nov** (BUG-1276 cause). The reminder is a guard, not the cure.
2. **Whether the held BUG-1275 fix covers the exact crash** of 5 Nov.
3. **Whether CLEAN's changes are truly one U.** Never robot-checked.

Written from reading Structural 1.0.126 (commit 8de95c34). Nothing here was run in AutoCAD.
