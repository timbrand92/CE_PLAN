# TOOL NOTE: Tag or retag a source (CDTAG)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Gives a block a source tag** (for example DP, WT1, IO) so CE treats it as a source, or **changes or removes** the tag on a source.
2. **One block per command.**
3. **From a double-click on a source** it opens the Edit source window instead of the questions.

## 2. What it changes in the drawing

1. **First tag on an untagged block:** writes the tag, a label on GUIDELINES (if you say Yes), and a connection point at the block's insertion point. Then splits the nearest pipe (a DP number records a junction instead) and rejoins every pipe end in the record.
2. **Retag or remove:** in one step, tag, label, connection point (reset to the insertion point), affected pipe ends, any pipe split, the project record and linked schedule cells.
3. **Remove** erases the label, the connection marker and the tag.
4. **No whole-drawing record update.** The record is read and written inside the change.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **Xref block:** "CDTAG cannot change this source - external-reference content is protected. Nothing was changed."
3. **Block, label or marker on a locked layer** (checked after the pick, before the questions): "... the source or its CE label is on a locked layer. Nothing was changed."
4. **Locked GUIDELINES:** "CDTAG cannot change this source - the GUIDELINES label layer is locked. Nothing was changed."
5. **A numbered name already used** (for example WT2): "CDTAG: WT2 is already on another source. Choose a different number. Nothing was changed." This comes after you have typed the tag and answered the label question.
6. **A pit picked for a retag:** refused as "another kind of object (such as a pit)". On a first tag no pit check was found.
7. **Tags with spaces** cannot be typed (the question stops at a space).

## 4. What it asks you, and what Enter means

1. **A source already selected:** exactly one tagged source is used straight away (no Set or Remove question). An untagged block, a pit or a mixed selection is ignored and it asks you to pick.
2. **"Pick the source to label":** only a block is accepted. Esc ends quietly.
3. **"Action for tag "X" [Set/Remove] <Set>"** (already tagged): Enter = Set.
4. **"Enter tag (e.g., DP, WT1, IO)":** Enter keeps the current tag on a tagged block; on an untagged block an empty answer leaves it without a tag.
5. **"Show the tag label on the drawing? [Yes/No] <Yes>":** Enter = Yes.
6. **Edit source window (double-click):** Enter = OK. Cancel: "Nothing was changed." A third button removes the tag.
7. **Esc at any question ends quietly,** with no message.

## 5. When it says Unknown or "needs checking"

1. **No pipes connected:** says so (twice on a first tag; see 7).
2. **Retag rolled back:** "The source change was rolled back. No drawing changes were saved; see the CE log." (for example when GUIDELINES is missing or plots).

## 6. How to undo it

1. **U once** is expected (one command). The first-tag route writes in several steps inside it; the retag route is one step.

## 7. Known faults

**Partly fixed**
1. **BUG-821:** one selected tagged source is now used straight away. An untagged block, a pit or a mixed selection is still ignored and you are asked to pick (the record says this part is WONT FIX).
2. **BUG-927:** first-tag messages are now plain. Retag and remove still print "Source and pipe changes saved together."; a first tag says "no pipes connected" twice.

**Still there in this build**
1. **BUG-740 (CDTAG part):** a multi-word tag cannot be typed, the Edit window refuses a tag with a space, and a retag drops the number from a generic source's label.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-742:** a used numbered name is refused (switch on).
2. **BUG-814 (CDTAG part):** retag refusals are in plain words (switch on).

**New in code, no bug covers it**
1. **Retag with "No" to the label** leaves the old label showing the old text.
2. **A retag resets a nudged connection point** to the insertion point.
3. **A retag of a downpipe on a run may cut the main** (no downpipe exception on that route; not proven).
4. **First tag relinks every pipe in the record,** one step each.
5. **Used-name refusal comes after all the questions.**

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 1.2:** `Commands\SourceTagCommand.cs:106`, `165-198`, `200-404`.
2. **1.3, 4.6:** `SourceTagCommand.cs:104, 233-240`; `Dialogs\SourceEditDialog.xaml:48, 58, 63`; `Models\DoubleClickSettings.cs:35, 42`.
3. **2.1, 7 new 4:** `SourceTagCommand.cs:367-386`; `Services\LinkService.Split.cs:66-93`; `Services\LinkService.Geometry.cs:19-51`.
4. **2.2:** `Services\LinkService.SourceChangeApply.cs:54-216`.
5. **2.3:** `Services\SourceTagService.cs:468-504`.
6. **2.4:** no update or bind call in `SourceTagCommand.cs:106-198`; record read and written at `LinkService.SourceChangeApply.cs:59, 156`.
7. **3.1:** `SourceTagCommand.cs:117`; `Services\DrawingSafetyService.cs:61-131`.
8. **3.2, 3.3:** `SourceTagCommand.cs:215-219`, `506-548`.
9. **3.4:** `SourceTagCommand.cs:335-337`, `561-565`.
10. **3.5, 7 new 5:** `SourceTagCommand.cs:351-359`; `Rules\SourceTagNameFreeRule.cs:14-29`.
11. **3.6:** `Services\SourceChangeRefusalText.cs:42`.
12. **3.7, 7 BUG-740:** `SourceTagCommand.cs:290`; `Rules\SourceEditWindowRule.cs:47-53`; `Services\SourceTagService.SourceChangeApply.cs:33`.
13. **4.1, 7 BUG-821:** `SourceTagCommand.cs:137-157`; `Commands\HubCommands.cs:403-440`.
14. **4.2 to 4.5, 4.7:** `SourceTagCommand.cs:148-157`, `258-271`, `288-331`.
15. **5.1, 7 BUG-927:** `Services\SourceTagMessages.cs:9-16`; `SourceTagCommand.cs:86-87, 311, 391-393`.
16. **5.2:** `SourceTagService.SourceChangeApply.cs:10-21`; `SourceTagCommand.cs:90-91`.
17. **7 BUG-742:** `Models\UserSettings.cs:1128`. **7 BUG-814:** `SourceTagCommand.cs:173-174, 196`; `UserSettings.cs:1027`.
18. **7 new 1, 2:** `SourceTagService.SourceChangeApply.cs:33, 67-68`; `SourceTagCommand.cs:345-348`.
19. **7 new 3:** `Services\SourceChangeCapture.cs:139-148` against `LinkService.Split.cs:69-71`.
20. **8.1:** no `#if` in the CDTAG files.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:43. Nothing was run in AutoCAD.
