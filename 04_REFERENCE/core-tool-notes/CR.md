# TOOL NOTE: Copy and rotate (CR)

**Core since:** not yet (on trial with MR)
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Copies the objects you select and then rotates the copy** about the destination point.
2. **On AutoCAD 2027** it is CE's own copy-rotate, which accepts only eight plain kinds of object.
3. **On AutoCAD 2022 to 2026** it runs the office LISP (AutoCAD's COPY, MOVE and ROTATE) by default. An opt-in switch (off) makes CE's own code drive the same AutoCAD commands instead.

## 2. What it changes in the drawing

1. **Adds the rotated copy;** the originals stay.
2. **CE's clean-up after a copy** runs in a CE drawing: a copied pit gets its own number and schedule row; a copied downpipe is completed if CE has the exact copy record, otherwise it is given its own new tag (switch on) and you are told to check where it connects.
3. **No whole-drawing record update.**

## 3. What it will not do

1. **No start-up checks** for a read-only drawing, Paper Space or a Structural drawing.
2. **On 2027, only these kinds:** line, circle, arc, ellipse, lightweight polyline, single-line text, multiline text, block. Hatches, CE's pipe object (pipes drawn on 2027), pipe outlines, leaders and dimensions stop it.
3. **On 2027 it refuses** REFEDIT, anything or any attribute on a locked layer, Xref and overlay blocks, and anything not in the current space.

## 4. What it asks you, and what Enter means

1. **On 2027:** "Select objects" (Enter with nothing ends), "Specify base point" (Enter or Esc ends), "Specify destination point" (Enter not accepted), "Specify rotation angle <0>" (**Enter = 0**, the copy is kept unrotated).
2. **Esc ends quietly** at every question.
3. **On 2022 to 2026:** AutoCAD's own COPY, MOVE and ROTATE questions.

## 5. When it says Unknown or "needs checking"

1. **A refusal on 2027** shows a code word, then "This trial accepts ordinary local lines, arcs, circles, ellipses, lightweight polylines, text and blocks only ...". It does not name the object.
2. **Copied downpipe:** "The copied downpipe was given its own tag DP3 (the original stays DP2). Check where it connects."

## 6. How to undo it

1. **On 2027: U once** is expected (one change). Whether a failure after the copy is made can leave copies behind despite "rolled back" is not proven.
2. **On 2022 to 2026:** no undo grouping, so probably several U steps (not proven).

## 7. Known faults

**Still there in this build**
1. **BUG-1245** (filed under MR, same code): the refusal shows a code word and "This trial ...", without naming the object.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1246:** a copied downpipe that CE could not link is now given its own tag (switch on). If that fails, the old "could not be given its own link" line remains. Tim saw this on the 2027 route, but the code comment says only 2022 to 2024; the cause there could not be confirmed.

**New in code, no bug covers it**
1. **No start-up checks** on any AutoCAD version.
2. **Cannot copy pipes drawn on 2027** (CE's pipe object is not on the list).

## 8. On AutoCAD 2022 to 2024

1. **A different tool:** by default the office LISP copy-rotate, also on 2025 and 2026, with no object-type limits beyond AutoCAD's own. CE's 2027 code is under `#if NET10_0_OR_GREATER`; 2025 and 2026 are the net8 build, not 2027.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\`.

1. **1.1, 1.2, 3.2, 3.3:** `Shared.Transform.Native2027\TransformCommands.cpp:140-176`, `256-338` (copy at 304); `Drainage\Commands\CopyRotateCommands.cs:1-66`.
2. **1.3, 8.1:** `Drainage\Commands\CopyRotateCommands.cs:1` (`#if NET10_0_OR_GREATER`), `67-137`, `374-390` (the opt-in switch, default off, or a unified host, picks the CE-written version), `399-424`; `Drainage\Models\UserSettings.cs:2318-2325`; `Drainage\CE_CVL_SUITE.csproj:4` (net48 = 2022 to 2024, net8 = 2025 and 2026, net10 = 2027).
3. **2.2, 5.2, 7 BUG-1246:** `Drainage\Services\ExternalMutationCommandPolicy.cs:45`; `Drainage\Services\LinkService.Utilities.cs:231-248`; `Drainage\Services\LinkService.CopiedSourceOwnTag.cs:19-100`; `Drainage\Rules\CopiedSourceOwnTagRule.cs:60-70`; `Drainage\Rules\CloneSourceCopyRule.cs:28-35`; `UserSettings.cs:1360-1372`.
4. **3.1, 7 new 1:** no `CommandPreFlight` in `CopyRotateCommands.cs`.
5. **3.2, 7 new 2:** `TransformCommands.cpp:162-167`; `Drainage.NativeObjects2027\CeCvlPipeObject.h:27`.
6. **4.1, 4.2:** `TransformCommands.cpp:113-127`, `205-215`, `266`, `288`, `294`.
7. **5.1, 7 BUG-1245:** `TransformCommands.cpp:322-336`.
8. **6.1:** `TransformCommands.cpp:269, 304, 322`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:20; corrected after independent review. Nothing was run in AutoCAD.
