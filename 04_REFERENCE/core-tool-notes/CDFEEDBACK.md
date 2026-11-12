# TOOL NOTE: Report a problem (CDFEEDBACK)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Opens a short form** (type, title, description) to report a problem or idea.
2. **Send report saves a copy on this PC** and, if the office IT Admin folder is on this PC, a copy in the office feedback folder, in one step.
3. **Nothing is sent over the internet.**

## 2. What it changes in the drawing

1. **Nothing in the drawing.**
2. **Writes a small report file:** type, title, description, CE and AutoCAD versions, a coded drawing name, a coded computer name and the time. No drawing, screenshot or log is attached.
3. **Where:** your own CE feedback folder on this PC; and the office feedback folder under your OneDrive "IT Admin" folder, only if that folder already exists.

## 3. What it will not do

1. **Cuts a report over 2,000 characters** silently at save (the window only warns).
2. **No start-up checks** (it does not touch the drawing).

## 4. What it asks you, and what Enter means

1. **Enter = Send report** (only once title and description are filled; in the description box Enter adds a line).
2. **Esc or Cancel:** "CDFEEDBACK cancelled." Nothing is written.

## 5. When it says Unknown or "needs checking"

1. **After sending:** "Report sent to the office feedback folder", or "Saved on this PC only ... Email this file to ..." with the file's place.

## 6. How to undo it

1. **Nothing to undo in the drawing.** The window closes before saving, so if the save fails the typed text is lost.

## 7. Known faults

**Still there in this build**
1. **BUG-1166:** Civil looks for the office folder only under your user folder; Manager's installer looks in the OneDrive business folder first. On a PC where they differ, reports may stay local.

**Partly fixed**
1. **BUG-1215:** Help now describes the one-step send; the window footer, the command list and the ribbon still say "save a local file, then email it".

**New in code, no bug covers it**
1. **Typed text lost** if the save fails (the window has already closed).
2. **The 2,000-character cut** is silent.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1, 4.2:** `Commands\FeedbackCommand.cs:30-52`; `Dialogs\FeedbackDialog.xaml:178, 183`; `ViewModels\FeedbackViewModel.cs:68-69`.
2. **1.2, 2.3, 7 BUG-1166:** `Services\FeedbackService.cs:34-39, 57-69, 116, 192-200`; Manager `Modules\Manager\Services\CePluginInstallerService.cs:54-77`.
3. **1.3:** no network call in `FeedbackService.cs`.
4. **2.2:** `FeedbackService.cs:132-145`.
5. **3.1, 7 new 2:** `FeedbackService.cs:126-130`; `Dialogs\FeedbackDialog.xaml.cs:31`.
6. **5.1:** `FeedbackCommand.cs:25-28`.
7. **6.1, 7 new 1:** `FeedbackCommand.cs:44-52, 66-70`.
8. **7 BUG-1215:** `Assets\Help\guide-content.js:100`; `Dialogs\FeedbackDialog.xaml:159`; `Assets\Config\command-registry.json:372`; `Services\CeCvlRibbonContributor.cs:169`.
9. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:03. Nothing was run in AutoCAD.
