# Tim's ruling, Sat 24 Oct 2026 about 03:00 Melbourne: Claude's own AutoCAD testing counts as accepted for things that need no looking

**Tim's words (24 Oct 2026):** "allow claude testing of the autocad testing of things that can be done without being seen count towards accepted percentage only when feature works as intended and can be fully tested by claude properly, does that make sense?"

**Desk answer:** yes. It is question 1 of `areas/RELEASE_9NOV_GAP_PLAN_2026-10-22.md` section 5 ("a drawing value or log line counts as accepted when the runner passes it in two separate AutoCAD sessions; windows still need a Codex look at the picture"), now answered. The RULES.md amendment is in `C:\TimOS\RULES.md` (24 Oct, after 13.3).

**What counts as "Claude-accepted" (all four must hold):**
1. The check needs nothing seen on screen: a drawing value, a command-line line, a CE log line, a file hash, a count.
2. It passed in two separate AutoCAD sessions on the same installed build.
3. It fails on the build before the fix or on a deliberately broken variant of the case (red before green).
4. An independent reviewer (Opus, or Tim) compared the case with its card or bug entry and wrote that in the case's `reviewed_against` line.
5. The whole feature works as intended and the case fully covers it. A case that covers part of an item counts for the part only (the recount counts whole items).

**Still needed as before:** a Codex look for anything the drafter must see (window, picture, label position, preview); Tim's word for engineering judgement (council values, design rules, sizing choices). Tim can still reject anything. Written "FIXED (Claude-accepted, build, date)", never plain FIXED; never close or delete an entry (D6).

**Effect on the numbers:** the accepted figure in the recount now counts runner passes that meet the four conditions. Today the 10 runner cases (R01-R10) are PASS-UNREVIEWED: R01-R05, R07 and R10 passed twice; only R08 and R10 have a recorded broken variant; `reviewed_against` is empty on all ten. An Opus review job fills `reviewed_against` and lists what is still missing.
