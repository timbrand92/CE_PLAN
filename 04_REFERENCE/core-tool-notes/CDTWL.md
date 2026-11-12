# TOOL NOTE: Top water level (CDTWL)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Works out whether a detention volume fits** below a top water level you choose, through the detention pits and pipes upstream of the outlet.
2. **Offers a list of candidate levels** (pit lids, pipe tops) and lets you pick one or type a level.
3. **Answers on the command line only.** It draws nothing.

## 2. What it changes in the drawing

1. **Marks the drawing as a CE drawing** before any question (Structural drawings are skipped). Its own note says it never changes the drawing; this mark is the exception.
2. **Nothing else.** No blocks, text or layers; nothing stored.
3. **No whole-drawing record update;** it reads CE's record as already loaded.

## 3. What it will not do

1. **No start-up checks** (read-only, REFEDIT, Paper Space, drawing type); it changes nothing else anyway.
2. **No CE records loaded:** "No CE drainage records yet". After switching drawings with no CE command run, it may say this when the drawing has records (not proven).
3. **Pipes drawn since CE last brought its record up to date may be missing** from the working (not proven).

## 4. What it asks you, and what Enter means

1. **"Which one is the outlet?"** (only with more than one detention pit): Enter takes the first pit (or row 1 when marks repeat). Esc ends quietly.
2. **"Detention volume required, in cubic metres (from the STORM report)":** Enter takes the CDCALC volume if there is one. Esc: "Cancelled. Nothing was worked out."
3. **"Which level is the top water level? Type its number, or type a level in metres (e.g. 18.54)":** no default; an empty answer is not a level ("Nothing was worked out."). A whole number in the list picks that row; a number with a decimal point is a level. Esc: "Cancelled - no top water level was chosen ...".

## 5. When it says Unknown or "needs checking"

1. **Candidate above the lowest lid:** "ABOVE the lowest lid (water would come out)".
2. **The answer** is one comparison line; the working's own warnings are not printed.

## 6. How to undo it

1. **Nothing to undo** except the CE mark.

## 7. Known faults

**Still there in this build**
1. **BUG-1021:** a pit with no floor or size is left out, so its lid never counts as the lowest lid.
2. **BUG-1056:** no habitable floor level is asked or checked, so it can say "That is enough" with the water just below a floor.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-545:** the two freeboard values now resolve through one rule (150 by default).
2. **BUG-871:** metre drawings are handled (switch on).
3. **BUG-970:** rows are numbered by set when marks repeat.
4. **BUG-1032:** plain wording; pipe names, not handles.

**Fix present but switched off**
1. **BUG-777:** the default can be the highest pipe top, but only with a switch that is off by default; as installed it still suggests "highest invert plus its pipe".

**New in code, no bug covers it**
1. **The CE mark is written before any question** while the command's own note says it never changes the drawing.
2. **An unnamed pipe may read "a pipe a pipe"** in the list (not proven).
3. **Fixed numbers:** 0.5 L "enough" margin, 10 m ceiling above the floor when there is no lid.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1 to 1.3:** `Commands\DetentionTwlCommand.cs:31-80`; `Services\DetentionTwlService.cs`.
2. **2.1, 7 new 1:** `DetentionTwlCommand.cs:21, 42`; `Services\ProjectDataService.Persistence.cs:903-961`.
3. **2.3, 3.2:** `DetentionTwlCommand.cs:44-47`; `DetentionTwlService.cs:412`; `Services\ProjectDataService.cs:160-176`.
4. **3.1:** no `CommandPreFlight` in `DetentionTwlCommand.cs:31-80`.
5. **4.1:** `DetentionTwlCommand.cs:99-135`. **4.2:** `DetentionTwlCommand.cs:258-280`. **4.3:** `DetentionTwlCommand.cs:199-236`; `Rules\TopWaterLevelChoice.cs:42-44`.
6. **5.1:** `Rules\TopWaterLevelCandidates.cs:34-37`. **5.2:** `DetentionTwlService.cs:287-288`.
7. **7 BUG-1021:** `Rules\DetentionBranchCollector.cs:198-208`; `TopWaterLevelCandidates.cs:231-236`.
8. **7 BUG-1056:** `DetentionTwlCommand.cs:57-63`.
9. **7 BUG-545:** `DetentionTwlService.cs:416-423`; `Rules\RulebookValues.cs:355-362`; `Rules\DetentionFreeboardRule.cs:13-24`.
10. **7 BUG-871:** `DetentionTwlService.cs:194, 207`; `DetentionBranchCollector.cs:351-352`; `Models\UserSettings.cs:3363`.
11. **7 BUG-970:** `DetentionTwlCommand.cs:107-135`; `DetentionTwlService.cs:171-183`.
12. **7 BUG-1032:** `TopWaterLevelCandidates.cs:34-37`; `DetentionBranchCollector.cs:266-273`.
13. **7 BUG-777:** `TopWaterLevelCandidates.cs:97-118`; `UserSettings.cs:1346`.
14. **7 new 2:** `TopWaterLevelCandidates.cs:244-248`. **7 new 3:** `DetentionTwlService.cs:262`; `Rules\DetentionTwlSolver.cs:147`.
15. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:08. Nothing was run in AutoCAD.
