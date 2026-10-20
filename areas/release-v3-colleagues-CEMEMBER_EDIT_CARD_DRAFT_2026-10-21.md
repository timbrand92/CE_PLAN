# CEMEMBER edit card (DRAFT, written 21 Oct 2026 by build/02 under the review gate; built on the recommended answers; Tim has not seen it)

Why this card exists: the lane orders of 20 and 21 Oct say "SBEAMEDIT edits CEMEMBER members" (desk answer 20 Oct: reuse SbeamAtomicPlacementWriter and the compound store). The CEMEMBER approval card (19 Oct "yes") has no editing section. The review gate (AGENTS.md) says a card comes before code, so this is the card. Classification: **Missing** (CEMEMBER members cannot be edited today; old SBEAMEDIT only reads SBEAM members).

## 1. What the drafter sees (the recommended answers)
1. **After CEMEMBER draws a member, it remembers it.** Nothing visible changes on the drawing. (Same idea as SBEAM: the lines of one member belong together.)
2. **SBEAMEDIT** (the name Tim and the desk already use; CEMEMBEREDIT is NOT added): pick any line of a CEMEMBER member. CE says what it is ("CEMEMBER 310UB32, side elevation, points on Centreline, break lines Both") and asks the same questions CEMEMBER asked, with the current answers as the defaults (Enter keeps). Section name, how it sits, points on, break lines for an elevation; Front/Beyond and base point for a section. The two picked points (or the base point) are not asked again: they stay where they were.
3. **Result:** the old lines of that member are replaced by the new ones in one step. One U puts the old member back. Cancel or Escape at any question changes nothing.
4. **Old SBEAM members:** SBEAMEDIT keeps editing them exactly as it does today. A line that is neither an SBEAM nor a CEMEMBER member gets today's plain refusal.
5. **A member drawn before this change** (no saved record): SBEAMEDIT says "that member was drawn before CEMEMBER could edit members; draw it again with CEMEMBER". It never guesses a record from loose lines (RULES 12.2).

## 2. What it must never do (native protection, R-27)
1. Never unlock a layer, detach an Xref, explode, or edit inside REFEDIT or an Xref. If any layer the old or the new lines sit on is locked or an Xref layer, or the space is an Xref/REFEDIT, the whole edit is refused before anything is erased, with one plain line.
2. Never block on a warning (scale mismatch warns and carries on, as CEMEMBER does).
3. Never leave a half-edited member: erase and redraw happen in one transaction; if the redraw fails the old lines stay.
4. Lines the drafter added by hand to the member's group are not touched (only the entities CEMEMBER made are replaced).

## 3. Where it is saved (design, for the Opus review)
1. Each member keeps one text record (schema 1: member id, section name, view, how it sits, points on, break lines, drawing scale, the two points, section position, base point; all in drawing coordinates, numbers in the invariant culture) on each of its lines (XData application CE_CEMEMBER), plus the member id used to find the other lines. This is the same pattern the SBEAM compound store uses (Group + Xrecord + XData); the SBEAM store itself cannot hold a CEMEMBER member because its plan type is SBEAM-shaped (Section/Elevation lines of the old rules, no lips, no Z purlin). So CEMEMBER gets its own record type and its own application name, **reusing the SBEAM store's group, drawing-record and write helpers** and the SBEAM writer's native-protection checks. SBEAMEDIT chooses by the application name it finds.
2. Option (b), not chosen: extend SbeamPlacementPlan with CEMEMBER's line rules. Bigger, and changes the SBEAM contract that is already shipped and pinned by tests.
3. Saving the record is a Settings switch, **CeMember.SaveEditRecord, ON** (CEMEMBER is a new hidden command; nothing old changes). OFF draws loose lines as today and SBEAMEDIT says (5).

## 4. Slices (each a DRAFT PR, RED test first, needs Opus review)
1. **(h) the pure half. BUILT 21 Oct: CeMemberRecord (the saved fields, read back strictly) and CeMemberReplanner (draw it again from the record with the same planners, say what changed).** No drawing code.
2. **(i) saving the record** when CEMEMBER draws (group, drawing record, XData), switch ON. Needs an AutoCAD look (robot or Codex): draw, save, reopen, record still readable.
3. **(j) SBEAMEDIT recognises a CEMEMBER member** and runs the questions and the replace (one transaction, one U). Needs the robot or Codex pass in AutoCAD (copies only).
4. **Window:** the same questions in a window are Codex's (window owed). The command-line route works without it.

## 5. Questions for Tim (none blocks the build; the recommended answer is what is built)
1. **Edit with the same command name SBEAMEDIT?** Recommended: yes (one name for editing, SBEAM goes away when CEMEMBER is accepted). Alternative: a new CEMEMBEREDIT. Example: a drafter who learnt SBEAMEDIT keeps typing it.
2. **A member drawn before records existed:** recommended "draw it again" (never guessed). Alternative: a repair command that reads loose lines back. Example: old test drawings.
3. **COPY and MOVE, and why the save step (i) needs its own design read:** XData follows a COPY, so a copied member would carry the same member id as the original; a Group (what SBEAM uses) copies as a separate unnamed group. The save step must therefore bind the record to the member's own group and entity handles, not only to an id, and SBEAMEDIT must refuse when the handles do not match the lines it was given. That is why slice (i) is NOT started: it is the one step that touches stored drawing data and needs an Opus design read first.
4. **Moving the member after it is drawn** (MOVE, ROTATE): the saved points would be stale. Recommended: SBEAMEDIT reads the member's current position from its lines (the first and last 25cont end lines), not from the saved points, once slice (j) is built. Until then the saved points are used and SBEAMEDIT warns if the lines are no longer where the record says.

## 6. Tests and checks
1. Pure: record round trip, strict refusal of bad or foreign records, replan uses the saved points and the new section, the wrong section-list row is refused, "what changed" wording. (Slice h, 12 tests.)
2. Robot or Codex in AutoCAD (copies only), after slices (i) and (j): CEMEMBER 310UB32 side elevation, save, reopen, SBEAMEDIT, change to 460UB82.1 and break lines None: member replaced at the same two points; U restores; a locked 25CONT layer refuses before anything changes; Escape at each question changes nothing.
