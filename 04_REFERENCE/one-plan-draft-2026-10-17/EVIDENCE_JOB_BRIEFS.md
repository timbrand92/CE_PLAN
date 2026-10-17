# Evidence job briefs for the desk — 17 Oct 2026 (planning chat, rulings H1-H3)

Both jobs are **read-only research**, run on Tim's PC while he is away (ruling E1). Cheapest model that can do it
(Sonnet 5.5 orchestration; AutoCAD core console does the reading). Never two AutoCAD writers at once; check the
AutoCAD lock and the Codex heartbeat first. Nothing is written into any office folder (lock files `.dwl/.dwl2`
show some details are open by someone: open copies only, never the originals).

## Job 1 — CE detail library catalogue (H2: Tim "i want to start building the library")

1. **Source (office standards, not client data):**
   `C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Drafting\Standard Details\` — 184 DWG,
   9 DXF, 16 PDF on 17 Oct. Sub-folders: Alterations & Additions; Block, Fence and Retaining Wall Details; Civil;
   Custom; Footing Details; Framing and Bracing Details; Industrial & Commercial; PDF Images; Retention and
   Suspended Slab Details; Stairs; Swimming Pool Details; plus `CE Custom Details.dwg`, `CE Job Specific Details.dwg`,
   `CE Computation Sheet.dwg`. Skip `0_SUPERSEDED` except to list it. Also read the templates in
   `...\Creative Engineering - Drafting\Drawings Templates\`.
2. **Copy** to a local working folder outside every repo, then headless-read each DWG: every detail (title text,
   detail number if any, scale), blocks, layers, text styles and heights, linetypes, dimension styles, extents;
   plot one PNG per detail for the picture atlas.
3. **Output:** a local index (JSON + PNGs) in a local-only folder; in CE_PLAN only a generic summary: counts per
   category, the office standards found (text heights, layers, linetypes, dim styles), duplicates and near
   duplicates, details that exist in both Civil and Structural folders, and anything odd. No person or company
   names from file names in the repo.
4. **Done when:** every DWG is listed as read or "could not read (reason)"; zero silent skips.
5. **Then (ruling I1):** turn the index into picture cards for Tim to confirm at Monday sessions (keep / fix /
   retire, about 20 per session, grouped by category), and list what is missing. Details harvested by job 2 join
   the same card queue as "found on real jobs, not in the library".

## Job 2 — CE drawing atlas across job types (H1: Tim "yes")

1. **Source (client data, DATA-01):** `C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Projects`.
   Tim authorised (17 Oct, H1) reading about 60 real issued jobs, read-only, from copies.
2. **Pick the sample:** recent issued jobs spread across job types: single dwelling, alterations and additions,
   townhouses / multi-unit, basements, commercial, industrial, retaining walls and pools, subdivisions or civil-only
   jobs, and any type found that is not on this list. Report how many jobs of each type exist in total.
3. **For each job (issued PDFs and the final DWGs):** sheet list and order; which standard details were used and
   which details were custom (drawn for this job); schedules used and their layout; architectural background
   set-up (how many Xref inserts, clips, colour overrides per level, any cleaned template xref); layers, text
   heights, linetypes, title block variant; Civil vs Structural sheets in the same set. **Harvest every detail
   drawn on the job (ruling I1):** picture + title + which job type, matched against the library index; unmatched
   and repeated custom details become library candidates.
4. **Output for Tim:** a picture atlas (per job type: typical sheet set, typical details, what is special) and per
   element "is this our standard?" pictures. Client-identifying material stays in the local-only store; only job
   numbers and generic lessons go to CE_PLAN. Ready for Tim's Monday 26 Oct session (about 20 minutes).
5. **Done when:** the atlas covers every job type found, with counts, and lists what could not be read.

## Job 3 — feeds the plan (planning chat)

The planning chat rebuilds the job walkthroughs, the background set-up flow, the detail flow and the Structural
half on the atlas results. Nothing in the "By 9 Nov" Civil list waits on these jobs except backgrounds and
details (H4).
