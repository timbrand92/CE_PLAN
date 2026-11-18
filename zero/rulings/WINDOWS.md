# Current rulings: Windows (frame, cards, padlock, preview, colour scheme, screens, Inspect, buttons)

Current rulings as of 18 Nov 2026, 1:20 pm (Melbourne), from decisions D-001 to D-225. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### How a tool is driven

1. **Every placement starts with a short typed command, and the choices are made in a small pop-up window the way Hatch does it,** not in a long row of ribbon buttons or command-line prompts (D-058).
2. **The window opens every time,** already filled in with what was used last (D-060).
3. **Editing a drawn thing:** AutoCAD's Properties, or double-click to get the same window it was placed with (D-061).
4. **One pit's or pipe's facts show in AutoCAD's own Properties palette under a CE heading, editable there;** a CE side panel is for whole-job things (D-048). (See the possible CONFLICT below.)
5. **Nothing depends on a hidden action** such as a right-click; a flip must be discoverable (D-049 item 5).

### One UI plan for every window

6. **One UI plan:** a single set of rules for how every window looks and behaves whatever the command; the Hatch Edit window is a starting point, not a template (D-063, correcting the reading of D-062).
7. **The approved Pit and Pipe windows are the pattern every other window must match:** "approve those new pit and pipe windows, all other windows should match" (D-070, written up as `design\UI_PLAN.md`).
8. **Approved structure:** about 80% window; numbered choices in decision order; "What else changes" strip; Inspect and Match on the left, Cancel and OK on the right; live preview; both screen sizes (D-068).
9. **Cards read like a maths teacher's working:** one bold answer per card, the working shown as a sum, a small side view in the Levels card, status pills with a word (D-069), following Tim's UI rules (D-032, `UI_UX_RULES.md`).
10. **The preview:** the exact object, changing live as it is manipulated, showing the effect on everything around it; layout consistent across windows; the order of choices makes the next decision easy; language easy but logical for an engineer who uses AutoCAD (D-064).
11. **Preview content, in every window:** the drawing as AutoCAD shows it from the office layers, colours, text and arrow; a small site locator in the corner for "where on the plan"; a strip under the preview showing the run as a chain with this object lit for "where in the system"; the thing being changed highlighted the same way in all three (D-167, answering D-163; following D-162 "RENDER CLOSER TO TEH REAL OBJECTS").
12. **Two window styles:** square preview for a thing at one spot, wide horizontal preview for a thing along a line (D-066, D-067); the preview's shape follows the shape of the thing, so a tall subject such as the pit schedule has its preview on the left at full height (D-113).
13. **Padlock on every number:** "padlock = held, open = worked out" reads at a glance (D-128); windows rebuilt on the foundation were "better ... on the right track" (D-087).

### Size and screens

14. **Every window takes about 80% of the screen and works at 1920 x 1080 and 2560 x 1440** (D-065).
15. **On the larger screen the drawings grow;** cards and text keep a comfortable size (D-151).
16. **Some laptops are used for drafting,** so windows must also fit a laptop screen and Windows scaling above 100%; on a small screen the cards go into tabs so nothing is cut off and nothing scrolls (D-193).
17. **Every window always has an Inspect button** that hides the window so the drawing can be seen and brings it back with everything typed still there (D-065).

### Colour

18. **One colour scheme only, no light and dark versions;** the window background is a grey like AutoCAD's own (D-166).
19. **The accent is rose, #FF70B3 with dark text on it,** used for OK, the box in use, the thing being changed, the selected choice, ticked boxes, the held padlock, the "changed" chip and the underline of each card's answer (D-168; values in UI_PLAN).
20. **The button and highlight colour is unlike any colour used in the drawing on screen** (D-166).
21. **The brand gives the base (black, white, grey, the type, the CE mark) and colour is used on purpose by normal UI convention to draw the eye;** status keeps its own colours; no colourless option (D-164).
22. **Status:** red "Wrong" for cover less than the minimum, never blocking (D-140); amber "Needs a look" (D-149); grey for a check that cannot run because a figure is missing, like "not known yet" (D-219); "not joined yet" in grey (D-176).

### Mock-ups

23. **Mock-ups shown to Tim are full size and show the true content of the window** (D-065).

## Changed along the way

1. **The Hatch Edit window as the template (D-062, 16 Nov) was corrected to a starting point only (D-063, 16 Nov).**
2. **The three small window styles (`pick_a_window_style.html`) were set aside by D-065 (16 Nov).**
3. **"Dark or light all through, following AutoCAD" (D-069, D-070, UI_PLAN section 5, 16 Nov) was replaced by one scheme on AutoCAD's grey (D-166, 18 Nov).** UI_UX_RULES "Dark and light both designed properly" and R-44 no longer govern plug-in windows on this point.
4. **Accent CE deep blue #1E5AA8 (UI_PLAN section 5) was replaced by rose #FF70B3 (D-168, 18 Nov);** schemes A, B, C of the first sheet were not picked (D-166).
5. **The look of the first full-size mock-ups was "pretty average" (D-068) and was redone to the rules (D-069).**

## Still open on this subject

1. **POSSIBLE CONFLICT: where whole-job things live.** D-048 puts job facts, levels, storage, checks and sheet in a CE side panel; D-099 makes one Detention window for the job and D-171 one Job window typed once per job. Neither marks D-048 changed. Waits on: Tim.
2. **The content of each window (which choices, their order and words) has not been gone through line by line** (D-070; UI_PLAN section 9 item 1). Waits on: Tim.
3. **How the preview and the site locator are produced inside AutoCAD** (D-167; UI_PLAN section 9 item 3); trial 6 passed at 1920 x 1080, 2560 x 1440 simulated only, pan and zoom during Inspect not tested. Waits on: a test.
4. **Drawn details in the preview not taken from a real sheet** (pit inner wall line, pit tag circle, which side the flow arrow sits) to be checked against how the office draws (D-167). Waits on: the planning chat.
5. **Tim's concern that previews might not update in real time** when things change in the window (D-163). Waits on: a test.
6. **The office's own AutoCAD model background colour is not known** (assumed #212830) (UI_PLAN colour scheme item 8). Waits on: Tim.
7. **Watch rose beside red "Wrong" and red invert text in use** (UI_PLAN colour scheme item 10). Waits on: a test.
8. **Actual laptop resolutions and Windows scaling in the office** (D-193); smallest supported screen recommended 1920 x 1080 at 125% (SITUATIONS Q17). Waits on: Tim.
9. **Whether facts can show and be edited in AutoCAD's own Properties palette:** trial 5 BLOCKED (showing the palette changes a saved setting); fallback is an own side panel (THE_PLAN section 6). Waits on: a test.
10. **Match is not wired; a draft offered back after Cancel; OK always saves; several selected shows "Varies"** (SITUATIONS G3, G4, G6, G2). Waits on: the build chat.
11. **Escape cancels the whole window** (BUILD_LOG DRAFT 8). Waits on: Tim.
12. **How a typed figure is marked given, measured or assumed:** the bench has no visible way except the Detention site area (SITUATIONS A3). Waits on: the build chat.
13. **Preview shapes for windows that are neither style** (job facts, checks, issue, Manager) are decided when each is designed (UI_PLAN section 3 item 4). Waits on: the planning chat.
14. **UI_PLAN section 5 still reads blue and "follows AutoCAD" theme;** only the "Added 18 Nov" section corrects it (SITUATIONS document conflicts). Waits on: the planning chat.
15. **Motion has not been tested by anyone** (UI_PLAN section 6 item 4). Waits on: a test.
16. **Mouse pan and zoom in Inspect, scaling and a second monitor, OSNAP, ORTHO and transparent zoom** (SITUATIONS G5, G7, G13). Waits on: a test.
17. **AutoCAD windows need their own equivalents of the web parts named in UI_UX_RULES** (named in Stage 4) (UI_UX_RULES reading item 2). Waits on: the build chat.

## Where the detail lives

1. `DECISIONS.md` D-032, D-048, D-049, D-058, D-060 to D-070, D-087, D-113, D-128, D-140, D-151, D-162 to D-168, D-193, D-219.
2. `design\UI_PLAN.md`; `UI_UX_RULES.md`; `RULES.md` R-39 to R-53.
3. `pictures\pit_window_full_size.html`, `pictures\pipe_window_full_size.html`, `pictures\pick_a_ce_scheme_2.html`.
4. `stage4\TRIAL_RESULTS.md` trials 5 and 6; `design\SITUATIONS.md` section G.
