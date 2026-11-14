# Queue for Tim: things that are yours to decide

**Started Sun 15 Nov 2026 by the controller (CE_ACAD / trust plan / plan / 01), on Tim's word: "i want you to work autonomously so dont get bogged down by waiting for me, just queue stuff for me and continue loops as necessary".**

**How this works:** nothing here stops the run. Each item has a recommended answer, which is in use as the controller's default until you answer. Answer any item by its number, in any chat. Newest at the bottom. Answered items move to the end with your words.

## Open

1. **Does typing a number in the Design flow box work for a person?** (Edit Pipe, More…, Design flow.) Codex could not type in it; its keys went to the wrong window.
   - **Yes, it types fine** (assumed for now). Example: you type 10, press OK, and CDRUNSOLVE uses 10 L/s for that pipe.
   - **No, it will not take it.** Example: the box ignores your keys; then it is a fault to fix before CDRUNSOLVE can count.
   - **STILL OPEN.** Asked in the ask chat Sun 15 Nov 2026 01:47 PC clock; Tim clicked "Not tried yet". Not an answer; the assumption stays the controller's.
4. **Pit Schedule's new top line** ("3 plastic pits are not in this schedule: none of them has a number…"). A screenshot from real AutoCAD will be put here when batch 3 has run. Under your screen rules, wording you see needs your eye.
   - **Wording is fine** (assumed for now).
   - **Change it to:** your words.
   - Not asked yet by the ask chat: waiting for the real AutoCAD screenshot.

9. **CDRUNSOLVE proposed levels that put pipe tops above the lids.** Seen on 3.0.90.4 in real AutoCAD (design flows 8, 8, 15, 22, 22 L/s set by the test on the standard drawing's run P4 to the stub, not typed). The preview raised P2 to P1 from 17.08 to 19.30 ("DN100 at 1:9, 2.80 m/s") and showed its own red lines: "COVER: pipe from 'P2' upstream obvert cover -488 mm < minimum 300 mm" (and -889 mm at P3). Nothing is applied until you press Apply. Evidence: `C:\CE_WORK\scratch\trust_install\rsq5_preview.tree.txt`.
   - **As now: the warnings show in the preview and you decide** (assumed for now). Example: you see the red COVER lines and press Cancel, or change pipe sizes first.
   - **CE should try a bigger pipe before steepening past cover.** Example: it proposes DN150 at a flatter grade instead of DN100 at 1:9.
   - **Never propose a level with negative cover.** Example: it says "cannot keep cover on this run" and proposes nothing.
   - Raised by trust-acad-evidence, Sun 15 Nov 2026 ~01:58 PC clock.
   - **ANSWERED, see "Answered" below:** as now.
(Items 2, 3 and 5 were answered on Sun 15 Nov and are under "Answered" below. Numbers are kept, not re-used.)

10. **Older AutoCAD years (2022 to 2024): how far does "stop work" go?** You said stop; I have stopped all fixing, testing and proving for them. The one open point is the build itself.
   - **Keep making the older-year files in each batch, untested** (recommended, in use). Example: tonight's batches still carry all three sets, exactly as before, so nothing about your bundle changes; no time is spent on them.
   - **Take them out of the build.** Example: a batch carries the 2027 files only; that means changing the build script and the install checks, and first checking what your own PC does with a bundle that has them missing.
   - Either way the repo's written rules still say "both builds required"; say if you want that text changed.
   - **ANSWERED, see "Answered" below:** take them out of the build; change the rule text to match. NOT the recommended default that was in use.

11. **CDRUNSOLVE: is this a sensible proposal?** (Engineering, yours alone.) Seen in real AutoCAD on Civil 3.0.90.4, flows set by the test on the standard drawing's run P4 to the stub (8, 8, 15, 22, 22 L/s). The preview proposed a 100 dia run at 1 in 9, 2.80 m/s, levels climbing from the stub (for example P2 to P1 upstream 17.08 to 19.30), and showed red COVER warnings of about -488, -889 and -518 mm: pipe tops above the lids. Nothing was applied. Preview text: `C:\CE_WORK\scratch	rust_installsq5_preview.tree.txt`.
   - **It is doing the right thing: it shows the warnings and I decide** (assumed; matches your item 9 answer). Example: you see red cover lines and choose a bigger pipe yourself.
   - **It should not offer that at all.** Example: where every option breaks cover, CDRUNSOLVE says so and proposes nothing.
   - **It should try the next pipe size up before proposing.** Example: it offers 150 dia at a flatter grade as a second row for you to tick.

## Older, still open (asked before 15 Nov, defaults in use)

8. **Ribbon in job order** (Start, Sources, Network, Levels, Check, Sheet). Default: not built into any batch until you have seen a mock-up.
   - **PARTLY ANSWERED, STILL OPEN.** Tim, Sun 15 Nov 2026 01:51 PC clock, ask chat, after a words-only sketch of the six panels, clicked: "Yes, show me a proper mock-up (Recommended)". Choice text he saw: "a new drafter reads the ribbon left to right as the method. Next step is a real picture for your OK; nothing is built before that." Ask chat's reading (mine): he agrees with job order as the direction; the layout itself is NOT approved until he has seen and OK'd a proper mock-up. Owed to Tim: that mock-up. Nothing to be built from this answer.

(Items 6 and 7 were answered on Sun 15 Nov and are under "Answered" below.)

## Answered

- **CDRUNSOLVE design flow = Q typed in Pipe Edit, for now.** Tim, 14 Nov: "1. yes".
- **Codex PASS plus a before-and-after record check counts where the robot cannot pick.** Tim, 14 Nov: "2. yes".
- **Standing approval for trial installs.** Tim, 14 Nov: "3. yes you have my approval to do it whenever you want to", then "yes standing".
- **Item 2. A bare line on the pipe layer does NOT count as a CE pipe.** Tim, Sun 15 Nov 2026 01:47 PC clock, ask chat, clicked: "No, only recorded pipes (Recommended)". Choice text he saw: "a stray construction line left on the pipe layer cannot become the outlet pipe, and Edit Pit will not turn it into '100 dia UPVC'. Matches your earlier 'candidate pipe' ruling." Not chosen: "Yes, the layer is enough"; "Offer it, I confirm". Ask chat's reading (mine, not Tim's words): this covers CDLPD's outlet pipe and Edit Pit, the two cases the question named, and agrees with CV8-10; it does not settle how Check this drawing lists such lines (older question Q13, still open).
- **Item 3. Reaches follow the drawing's units: keep it on.** Tim, Sun 15 Nov 2026 01:47 PC clock, ask chat, clicked: "Keep on, I'll check one (Recommended)". Choice text he saw: "on a survey base drawn in metres, a label 2 m from its pit is now matched to it, instead of CE looking only 2 mm away. You look at one metre drawing when it suits." Still owed: Tim's own look at one metre drawing; no date given.
- **Item 5. One accent colour, CE blue, in both modes; gold is dropped.** Tim, Sun 15 Nov 2026 01:47 PC clock, ask chat, clicked: "One accent, CE blue (Recommended)". Choice text he saw: "the main button and the selected row are CE blue in both dark and light windows; gold is dropped." Not chosen: "Keep the guidebook's two"; "One accent, but gold". This supersedes the Design Guidebook v1.3 two-accent rule (gold on dark, CE blue on light) from 15 Nov 2026; the guidebook text is kept, marked superseded on this point.
- **Item 6. A template opened on purpose, then CLEAN: CLEAN still saves into it, with one plain line.** Tim, Sun 15 Nov 2026 01:51 PC clock, ask chat, clicked: "Yes, with one line (Recommended)". Choice text he saw: "you open the A1 civil template to fix a title block, run CLEAN, and it saves with one plain line: 'This is a template. Saved.'" Not chosen: "Ask me first each time"; "Never save a template". The exact wording of the line was an example, not approved wording.
- **Item 7. The usual job for the walk-through is a site stormwater plan for council.** Tim, Sun 15 Nov 2026 01:51 PC clock, ask chat, clicked: "Site stormwater for council (Recommended)". Choice text he saw: "a house or small unit site: downpipes, pits, pipes, a tank, the legal point of discharge, a Pit Schedule and calcs for the council submission." Not chosen: "Larger multi-unit site"; "A different job". This also answers open item 1 in section 6 of `areas\TRUST_ONE_DRAFTER_CIVIL_DAY_14NOV.md`.
- **Item 9. CDRUNSOLVE proposing levels with negative cover: as now, the red warnings show in the preview and Tim decides.** Tim, Sun 15 Nov 2026 01:59 PC clock, ask chat, clicked: "As now: show red, I decide (Recommended)". Choice text he saw: "you see the red COVER lines in the preview and press Cancel, or change the pipe sizes first and solve again. Nothing is written unless you press Apply." Not chosen: "Try a bigger pipe first"; "Never propose negative cover". He was shown the case first: P2 to P1 raised from 17.08 to 19.30 (DN100 at 1 in 9), cover -488 mm against a 300 mm minimum. This is an engineering-judgement item and it has his own word.
- **Item 10. Older AutoCAD years (2022 to 2024): the older-year files come OUT of the build, and the written rules are changed to match.** Tim, Sun 15 Nov 2026 02:32 PC clock, ask chat, two clicks.
  - **The files:** he clicked "Take them out of the build". **This was NOT the recommended choice, and NOT the default the controller had in use** ("Keep making them, untested"). Choice text he saw: "a batch carries the 2027 files only. That means changing the build script and install checks, and first checking what your own PC does with a bundle that has the older files missing."
  - **The rule text:** he clicked "Yes, match what I said (Recommended)". Choice text he saw: "the rules read 'AutoCAD 2027 is proven; older-year files are still made but not tested, until Tim says', so no chat is told two different things." Not chosen: "Leave the text alone".
  - **Ask chat's reading (mine):** batches carry AutoCAD 2027 files only, until he says otherwise (his 02:28 ruling was "until you say"; see `TIM_INTERVIEW_15NOV.md` section 11, Q56 follow-up). The example wording for the rule text was written for the other choice ("still made but not tested") and no longer fits; the text should say the older-year files are not made, and its wording is the rule owners' to draft from his two clicks, not his approved wording.
  - **Carried by his own click, so not optional:** the choice he picked said the check of what his own PC does with a bundle missing the older files comes FIRST, before a 2027-only batch is installed. His click also covers changing the existing build script and install checks for this purpose; it is not a word for a new script.
