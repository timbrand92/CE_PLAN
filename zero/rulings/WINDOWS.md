# Current rulings: Windows (frame, cards, padlock, preview, colour scheme, screens, Inspect, buttons)

Current rulings as of 18 Nov 2026, 5:30 pm (Melbourne), from decisions D-001 to D-297. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### How a tool is driven

1. **Every placement starts with a short typed command, and the choices are made in a small pop-up window the way Hatch does it,** not in a long row of ribbon buttons or command-line prompts (D-058).
2. **The window opens every time,** already filled in with what was used last (D-060). **Refined by D-234 and D-263 (18 Nov):** it opens when the name is typed, then pick after pick; pipes follow what they join and start from the office default from nothing; pits, inlets and tanks open with last used (item 24).
3. **Editing a drawn thing:** AutoCAD's Properties, or double-click to get the same window it was placed with (D-061).
4. **One pit's or pipe's facts show in AutoCAD's own Properties palette under a CE heading, editable there;** a CE side panel is for whole-job things (D-048). (See the possible CONFLICT below.) **Changed by D-288 DQ-103 (18 Nov; planning chat's call from his rulings; his to overturn):** the Properties route is rows in AutoCAD's own Properties with nothing registered, pending a night proof.
5. **Nothing depends on a hidden action** such as a right-click; a flip must be discoverable (D-049 item 5).

### One UI plan for every window

6. **One UI plan:** a single set of rules for how every window looks and behaves whatever the command; the Hatch Edit window is a starting point, not a template (D-063, correcting the reading of D-062).
7. **The approved Pit and Pipe windows are the pattern every other window must match:** "approve those new pit and pipe windows, all other windows should match" (D-070, written up as `design\UI_PLAN.md`). **Look parts superseded by D-295 (18 Nov):** the approved style (Detention mock-up version 4) is now the pattern every window matches; the Pit and Pipe windows are brought to it when next touched (D-286 rule 3).
8. **Approved structure:** about 80% window; numbered choices in decision order; "What else changes" strip; Inspect and Match on the left, Cancel and OK on the right; live preview; both screen sizes (D-068). **Layout order and look superseded by D-295 (18 Nov):** where this differs from the approved style (three numbered steps, the answer band, the preview at the left) the approved style governs (SCREENS_AND_STYLE).
9. **Cards read like a maths teacher's working:** one bold answer per card, the working shown as a sum, a small side view in the Levels card, status pills with a word (D-069), following Tim's UI rules (D-032, `UI_UX_RULES.md`).
10. **The preview:** the exact object, changing live as it is manipulated, showing the effect on everything around it; layout consistent across windows; the order of choices makes the next decision easy; language easy but logical for an engineer who uses AutoCAD (D-064).
11. **Preview content, in every window:** the drawing as AutoCAD shows it from the office layers, colours, text and arrow; a small site locator in the corner for "where on the plan"; a strip under the preview showing the run as a chain with this object lit for "where in the system"; the thing being changed highlighted the same way in all three (D-167, answering D-163; following D-162 "RENDER CLOSER TO TEH REAL OBJECTS").
12. **Two window styles:** square preview for a thing at one spot, wide horizontal preview for a thing along a line (D-066, D-067); the preview's shape follows the shape of the thing, so a tall subject such as the pit schedule has its preview on the left at full height (D-113). **Superseded by D-296 (18 Nov):** one rule, the preview at the left in every window; the square and wide styles no longer decide where it sits, and its size and form are OPEN under D-297.
13. **Padlock on every number:** "padlock = held, open = worked out" reads at a glance (D-128); windows rebuilt on the foundation were "better ... on the right track" (D-087).

### Size and screens

14. **Every window takes about 80% of the screen and works at 1920 x 1080 and 2560 x 1440** (D-065).
15. **On the larger screen the drawings grow;** cards and text keep a comfortable size (D-151).
16. **Some laptops are used for drafting,** so windows must also fit a laptop screen and Windows scaling above 100%; on a small screen the cards go into tabs so nothing is cut off and nothing scrolls (D-193).
17. **Every window always has an Inspect button** that hides the window so the drawing can be seen and brings it back with everything typed still there (D-065).

### Colour

18. **One colour scheme only, no light and dark versions;** the window background is a grey like AutoCAD's own (D-166). **Values superseded by D-294 and D-295 (18 Nov):** the one scheme is the approved dark scheme (window #2B2D30, cards #383B40, preview ground #16181B; "lighter grey" of D-292 replaced); still one scheme, no light version.
19. **The accent is rose, #FF70B3 with dark text on it,** used for OK, the box in use, the thing being changed, the selected choice, ticked boxes, the held padlock, the "changed" chip and the underline of each card's answer (D-168; values in UI_PLAN). **Rose stands (D-292, D-295); where it is used is narrowed by D-286 rule 15 and the approved style:** OK and the one selected choice only; ticks, padlocks and icons are grey-white; "Changed" is a grey outline.
20. **The button and highlight colour is unlike any colour used in the drawing on screen** (D-166).
21. **The brand gives the base (black, white, grey, the type, the CE mark) and colour is used on purpose by normal UI convention to draw the eye;** status keeps its own colours; no colourless option (D-164).
22. **Status:** red "Wrong" for cover less than the minimum, never blocking (D-140); amber "Needs a look" (D-149); grey for a check that cannot run because a figure is missing, like "not known yet" (D-219); "not joined yet" in grey (D-176). **Colours refined by D-295 (18 Nov):** each status is a solid fill with dark text and its word: green Suits; amber Needs a look and Needs you; orange-red #FF6B4A Short and Wrong, kept clear of the rose.

### Mock-ups

23. **Mock-ups shown to Tim are full size and show the true content of the window** (D-065).

### Added 18 Nov 2026, D-230 to D-297 (the full screen rules and the approved style are on SCREENS_AND_STYLE)

24. **When a window opens and what it opens with (D-234, D-263):** "When I type the name; then pick after pick": typing the short name opens the window filled in with last time's choices, Enter accepts, then each click places and numbers one, Enter finishes; one window per run, not per object; changes afterwards by Properties, a grip or double-click (D-234). Then (D-263), his words: "MONDAYS CHOICES, WITH THE REMEMBERING LAST CHOICES, CAN THIS BE A SETTING AND THEN WHAT HAPPENS WITH PIPE?" and, on the proposal, "Smart: pipe follows what it joins (Recommended)". A pipe drawn off an existing pipe or pit opens with the size of the pipe it continues (never smaller downstream); a pipe from nothing opens on the office default (100 dia at 1 in 100); pits, inlets and tanks open with last used, kept between AutoCAD sessions in a small CE file of its own (not an AutoCAD setting, profile or registry entry); a setting lets anyone switch any tool to "always office default" or "always last used". This settles D-060 against D-143 and D-174.
25. **Every screen, page and window matches Tim's 31 screen design rules (D-286):** "Every screen, page and window in this project is to match these." Process (his rules 1 to 3): change nothing yet, list every screen in groups marked meets / fails / not checked with a count "N of M"; show him ONE mock-up of the worst offender fixed and his look approves the style; then fix by risk (a wrong figure or anything pretending to work first), the rest when each screen is next touched, no rebuilds. A separate checker looks at every screen before he sees it (rule 31). Where these rules disagree with earlier UI rulings (the rose accent on padlocks and step marks of D-168, the light and dark versions on the bench, cards of words, UI_PLAN) these rules win, and each disagreement is listed in the audit.
26. **The approved window style (D-295):** version 4 of the Detention mock-up, asked "Is this the style for every window?": "Yes, this is the style". From here a separate checker's look is enough for other windows in this style (D-295; `design\STYLE_APPROVED_18NOV.md`).
27. **The preview always sits at the left (D-296):** "Left side, as shown (Recommended)": the drawing at the left, the figures at the right, in every window, including Pipe and Long section. This replaces the two-style ruling of D-067 for where the preview sits.
28. **What "changes needed" meant (D-294, on the third mock-up):** the eye goes first to what the drafter must TYPE and to what is CRITICAL (a worked-out figure must not look like a box to fill); a first-time reader can tell where to start, what order to read in and why each part is there ("if i was to look at these windows for the first time i wouldnt know where to look and why its all there?"); the PREVIEW comes back ("also what happened to the previews"), the drawing as AutoCAD shows it with where on the plan and where in the system (D-167); the DARK ground is preferred ("i actually think i like the dark background the best"); figures in an ordinary font, no slashed-zero typewriter figures ("The number font looks odd").
29. **Grey and button colour (D-292):** "Lighter grey, rose button". The accent stays ROSE (his D-168 pick confirmed over the CE off-white), used only on OK and the selected item. The "lighter grey" part is replaced by D-294 (dark ground). Planning chat's note, not his words: the checker found rose close to the red warning, so the red status colour is kept clearly apart from rose in the next version.
30. **Build calls touching the windows (D-261, D-271, D-277, D-288; planning chat's call from his rulings; his to overturn):** DQ-018 the Pit tool's messages keep their draft words until the release wording pass; DQ-019 small boxes read "unknown" in grey, the words say "not known yet", the sheet prints TBC (D-176, D-178, D-219) [Planning chat's reading (board item 68; his to overturn): D-286 rule 24 and the approved style win: a window says exactly 'Not known', the sheet 'TBC'; 'unknown' and 'not known yet' are brought into line when each window is next touched]; DQ-032 the window showing only four pipes is for tests only, repeating rows before first real use since runs past four pits are normal and no window scrolls; DQ-035 held figures reopen held; DQ-054 a crowded long section preview is drawn less tall, cards are only as tall as their lines, nothing scrolls; DQ-097 Escape cancels the whole window; DQ-103 rows in AutoCAD's own Properties with nothing registered, pending a night proof, no registry change either way (superseded the earlier plan; board item 24).

## Changed along the way

1. **The Hatch Edit window as the template (D-062, 16 Nov) was corrected to a starting point only (D-063, 16 Nov).**
2. **The three small window styles (`pick_a_window_style.html`) were set aside by D-065 (16 Nov).**
3. **"Dark or light all through, following AutoCAD" (D-069, D-070, UI_PLAN section 5, 16 Nov) was replaced by one scheme on AutoCAD's grey (D-166, 18 Nov).** UI_UX_RULES "Dark and light both designed properly" and R-44 no longer govern plug-in windows on this point.
4. **Accent CE deep blue #1E5AA8 (UI_PLAN section 5) was replaced by rose #FF70B3 (D-168, 18 Nov);** schemes A, B, C of the first sheet were not picked (D-166).
5. **The look of the first full-size mock-ups was "pretty average" (D-068) and was redone to the rules (D-069).**
6. **Two window styles deciding where the preview sits (D-067) were replaced by "left side" everywhere (D-296, 18 Nov).**
7. **The Pit and Pipe windows as the pattern (D-070) were replaced for the look by the approved Detention-window style (D-295, 18 Nov);** structure stands.
8. **"Lighter grey" (D-292) was replaced by the dark ground two hours later (D-294, 18 Nov);** the rose button stands.
9. **The colour values of D-168 were replaced by the approved style's values, except the rose accent (D-295);** rose is now OK and the selected choice only.
10. **"Filled in with what was used last, every time" (D-060) became "when I type the name, then pick after pick" (D-234) and then the smart rule (D-263), 18 Nov.**

## Still open on this subject

1. **POSSIBLE CONFLICT: where whole-job things live.** D-048 puts job facts, levels, storage, checks and sheet in a CE side panel; D-099 makes one Detention window for the job and D-171 one Job window typed once per job. Neither marks D-048 changed. Waits on: Tim.
2. **The content of each window (which choices, their order and words) has not been gone through line by line** (D-070; UI_PLAN section 9 item 1). Waits on: Tim.
3. **How the preview and the site locator are produced inside AutoCAD** (D-167; UI_PLAN section 9 item 3); trial 6 passed at 1920 x 1080, 2560 x 1440 simulated only, pan and zoom during Inspect not tested. Waits on: a test.
4. **Drawn details in the preview not taken from a real sheet** (pit inner wall line, pit tag circle, which side the flow arrow sits) to be checked against how the office draws (D-167). Waits on: the planning chat.
5. **Tim's concern that previews might not update in real time** when things change in the window (D-163). Waits on: a test.
6. **The office's own AutoCAD model background colour is not known** (assumed #212830) (UI_PLAN colour scheme item 8). Waits on: Tim.
7. **Watch rose beside red "Wrong" and red invert text in use** (UI_PLAN colour scheme item 10). Waits on: a test. The checker found rose close to the warning colour and the next version keeps them clearly apart (D-292 note); not yet seen in AutoCAD.
8. **Actual laptop resolutions and Windows scaling in the office** (D-193); smallest supported screen recommended 1920 x 1080 at 125% (SITUATIONS Q17). Waits on: Tim.
9. **Whether facts can show and be edited in AutoCAD's own Properties palette:** trial 5 BLOCKED (showing the palette changes a saved setting); fallback is an own side panel (THE_PLAN section 6). Waits on: a test.
10. **Match is not wired; a draft offered back after Cancel; OK always saves; several selected shows "Varies"** (SITUATIONS G3, G4, G6, G2). Waits on: the build chat.
11. **Escape cancels the whole window** (BUILD_LOG DRAFT 8). Waits on: Tim. **Taken by D-288 DQ-097 (planning chat's call from his rulings; his to overturn).**
12. **How a typed figure is marked given, measured or assumed:** the bench has no visible way except the Detention site area (SITUATIONS A3). Waits on: the build chat.
13. **Preview shapes for windows that are neither style** (job facts, checks, issue, Manager) are decided when each is designed (UI_PLAN section 3 item 4). Waits on: the planning chat.
14. **UI_PLAN section 5 still reads blue and "follows AutoCAD" theme;** only the "Added 18 Nov" section corrects it (SITUATIONS document conflicts). Waits on: the planning chat.
15. **Motion has not been tested by anyone** (UI_PLAN section 6 item 4). Waits on: a test.
16. **Mouse pan and zoom in Inspect, scaling and a second monitor, OSNAP, ORTHO and transparent zoom** (SITUATIONS G5, G7, G13). Waits on: a test.
17. **AutoCAD windows need their own equivalents of the web parts named in UI_UX_RULES** (named in Stage 4) (UI_UX_RULES reading item 2). Waits on: the build chat.
18. **THE PREVIEW PANEL IS OPEN (D-297):** "IM NOT CONVINCED THAT WINDOW WILL SHOW THE PREVIEW WELL ENOUGH". How big it is and how it shows a real job well enough is not approved; pictures of the same window with the preview done other ways (bigger; enlarging on a click; the window standing beside the real drawing, which zooms to and lights up the system) are owed for his choice. No window's preview is built to the 380 px panel until he rules. Waits on: the planning chat, then Tim.
19. **Moving the rarely-changed settings off the placing windows into Properties** (D-241): "EXPLAIN THIS TO ME A BIT BETTER"; to be explained with pictures of the windows both ways before he is asked again. Waits on: the planning chat.
20. **The audit of every screen** (meets / fails / not checked, "N of M") and the list of where the 31 rules disagree with earlier UI rulings (D-286). Waits on: the planning chat.
21. **Click budgets, undo and motion per tool;** how a window looks at 1080 and 1440 and over real model space (the mock-up was checked at one size, 1536 by 864); the plain names of the two detention methods are the planning chat's and not confirmed (STYLE_APPROVED section 5). Waits on: a test.
22. **POSSIBLE CONFLICT: the wording of a missing value.** D-261 DQ-019 (planning chat's call from his rulings; his to overturn) says "unknown" in small boxes and "not known yet" in words; D-286 rule 24 and the approved style say exactly "Not known" on a window and "TBC" on the sheet. Planning chat's reading (board item 68; his to overturn): D-286 rule 24 and the approved style win: a window says exactly 'Not known', the sheet 'TBC'; 'unknown' and 'not known yet' are brought into line when each window is next touched. Waits on: Tim.

**Closed (D-230 to D-297):** whether the Detention mock-up style is the style for every window (closed by D-295, except the preview panel which stays open under D-297); where the preview sits (closed by D-296); what was wrong with the layout and colours (answered by D-286 and D-294); whether Escape cancels the whole window (answered "Escape cancels the whole window" in D-288 DQ-097; planning chat's call from his rulings; his to overturn).

## Where the detail lives

Added 18 Nov 2026: `DECISIONS.md` D-234, D-241, D-261, D-263, D-271, D-277, D-286, D-288, D-291 to D-297; `design\SCREEN_RULES_18NOV.md`; `design\STYLE_APPROVED_18NOV.md`; `pictures\detention_fixed_mockup.html`.

1. `DECISIONS.md` D-032, D-048, D-049, D-058, D-060 to D-070, D-087, D-113, D-128, D-140, D-151, D-162 to D-168, D-193, D-219.
2. `design\UI_PLAN.md`; `UI_UX_RULES.md`; `RULES.md` R-39 to R-53.
3. `pictures\pit_window_full_size.html`, `pictures\pipe_window_full_size.html`, `pictures\pick_a_ce_scheme_2.html`.
4. `stage4\TRIAL_RESULTS.md` trials 5 and 6; `design\SITUATIONS.md` section G.
