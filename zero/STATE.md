# State of the zero plan (read this to pick up cold)

**Written:** Mon 16 Nov 2026, late afternoon, by the chat "CE_ACAD / zero plan / 01" (Claude Fable 5.2, high thinking). Update it whenever the state changes.

## Where we are

1. **Stage 1 (how we design and draw), civil:** studied and explained (`pictures\how_we_design_and_draw_civil.html`). Tim has not said "approve"; he moved on to the design.
2. **Stage 2 (what the plugin should do):** concept draft 2 in progress. Tim's corrections so far: pipes and pits are separate elements that work together, not one glued object (D-031); muscle memory (D-032); as many grips as today (D-033); a pipe starts exactly on the pit wall in line with the click (D-034); the page must show use, process and foundations (D-035); EVERY element must be covered before anything progresses (D-036).
3. **Not started:** Stages 3 (parts bin), 4 (research), 5 (how we work), 6 (the plan). No code, builds or installs have been done, and none may be in this chat.

## What was running when this was written (check each before telling Tim it is done)

1. **Reference library builder:** filing all evidence into `reference\` (job kinds K-, sums S-, limits L-, elements E-, councils C-, tools T-, standards CSV files). It did not have study D; a second pass must add `evidence\STUDY_D_GAPS_CLOSED.md`. Check: no markdown tables, every item has an Evidence line, no client or staff names, then commit.
2. **Concept page fixer:** fixing `pictures\new_plugin_concept_v2.html` against an independent critic's 12 faults (phone width clipping, sums that disagree with headlines, words-only cards, cluttered grips picture, bold labels, units, IT words, accent colour on non-buttons, no dark theme). Check by photographing: `pwsh -File C:\CE_WORK\scratch\zero_study\tools\shoot_page.ps1 -Html <page> -Name <name>` then view the slices in `C:\CE_WORK\scratch\zero_see\shots\`.
3. **Elements page:** `pictures\new_plugin_elements.html`, one card per element kind (pits, pipes, inlets / source blocks, tanks, line drains, discharge point, levels, areas, background items, later kinds, sheet items). Check it the same way, and have a separate critic check it (Tim's UI rules require a critic who did not build it).

## What to do next, in order

1. Look at both pages yourself (photographs), run a separate critic on the elements page, fix what fails.
2. Send Tim both pages with SendUserFile. Tell him plainly what was and was not checked.
3. Commit by file name and push (`zero/...` only; other sessions have uncommitted files elsewhere in C:\CE_PLAN, never stage those).
4. Raise P-04 again (the live drawing that shows nothing without the plugin): does he want it looked at now.
5. When Tim accepts the concept: Stage 3 (parts bin), then Stage 4 research, starting with Q-201 and Q-202.

## Things that are easy to get wrong

1. **Never send Tim a page that has not been photographed and looked at, and critiqued by a separate check** (his UI rules; two pages went out unseen on 16 Nov).
2. **No client names, addresses, job numbers or staff names** in anything under `C:\CE_PLAN`. Study copies with real names live only in `C:\CE_WORK\scratch\zero_see` and `zero_study`.
3. **AutoCAD:** do not start or close it; re-read `C:\Users\TimothyBrand\.timos\autocad.json`. The headless engine can convert a copy of a drawing to DXF but cannot plot (P-03).
4. **Tim's rules of talking:** answer first, FOR TIM above a line, no tables, numbered lists with bold labels, clickable choices with one Recommended, pictures as HTML files.
5. **Honest correction on record:** an orifice check quoted to Tim as 5.99 l/s used the plate height as the head; the job's own sum gives 5.84 at 345.5 head. Tim ruled (D-023) the sheet keeps printing the plate height under "HEAD".
6. `evidence\STUDY_D_GAPS_CLOSED.md` was read by the planning chat to line 277 (sections 1 to 5.2); sections 5.3 to 7 are known only from the helper's summary. Read the rest before relying on it.
