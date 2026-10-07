# DESIGN CARD BUG-251: Kingston commercial jobs use the residential PSD figures (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** One thing to supply and two engineering calls.

## What you would see in AutoCAD

1. On a Kingston job set to Commercial land use, the storage storm is already 1 in 10 (K02 page 14). The PSD storm, pre-development C and time of concentration are still the residential ones, and the proposal report prints "Q minor (1-in-5 yr)". A note tells you to check them.
2. With the fix, a Kingston commercial job uses PSD storm 1 in 10 and the commercial C and Tc, each citing K02 page 14.
3. Residential Kingston jobs and every other council stay exactly as they are.

## What you must supply

1. **Where the Kingston K02 PDF is on your PC or the server.** It is "Civil Design Requirements for Developers, Part A", version 5. It was opened and checked in September, but its folder was not recorded. Tonight's search of your user folder, Lisp Files and CE_PLAN did not find it. Reply with the folder, or say "same as before" if it is on the office server.

## Questions

1. **For commercial Kingston lots under 1000 m², is Tc 7 minutes?**
   - **Recommended:** yes, 7 minutes for commercial lots under 1000 m², on the Settings page, once a builder has read it on K02 page 14. For lots of 1000 m² and over it stays Unknown and CE asks you, because the designer sets the critical duration.
   - **Job:** an 800 m² shop lot gets Tc 7 min. A 1,500 m² warehouse lot shows "Tc: Unknown, designer to set" until you type it. The 7 minutes is in the office's Kingston notes but was not in the part of page 14 checked in September.
2. **What pre-development C does CE use on a commercial Kingston lot?**
   - **Recommended:** the lower of the existing site C and 0.7, as K02 says. CE asks for the existing site C, and until you type it the pre-development C shows Unknown with a warning. It never assumes 0.7.
   - **Job:** an existing sealed car park at C 0.9 gives 0.7. An existing house lot at C 0.5 gives 0.5. An existing C nobody has typed shows "Pre-development C: Unknown, type the existing site C".

## What stays safe

1. Esc in the setup or calculation windows changes nothing. Saving the land use is one Undo.
2. Nothing is drawn by this change, so no locked layer or Xref is involved. Sheets placed later follow the normal rules.
3. Every figure (1 in 10, 7 minutes, the 0.7 cap and the 1000 m² limit) sits on the Settings page against K02, not fixed in the plugin.
4. CE warns and carries on. An unknown C or Tc is shown as Unknown, never as a quiet default.

## Once you approve

1. **Builders:** read K02 page 14 from the PDF you point to, then add the commercial PSD storm, Tc and C rule to the Kingston council figures. The report's "Q minor" line follows the land use.
2. **Test that proves it:** on a copy, set a Kingston job to Commercial. CDCALC shows PSD 1 in 10 and Tc 7 min, each citing page 14, and pre-development C as Unknown until you type the existing C. Type 0.9 and it shows 0.7. Set it back to Residential and it shows 1 in 5, C 0.4 and Tc 5 min. A Glen Eira job is unchanged.

---
For builders (Tim need not read): BUG_CARPARK BUG-251 (after #433 land use and #427 Kingston 5 years); add `psdAriBySiteCase` and `tcMinutesBySiteCase` to the profile model, same `siteCaseByLandUse` mapping; 22-council sweep unchanged. Sources: `docs/workflows/COUNCIL_KINGSTON_ISSUE5_2025.md` section 2 (commercial 10 % AEP, C = lower of existing or 0.7, Tc 7 min under 1000 m²) and `docs/workflows/KINGSTON_K02_SOURCE_REGIONS_2026-09-10.md` (SHA-256 47d5c743...f6b1; the inspected page 14 region covers ARI and the C bullet only, NOT Tc; the PDF path is deliberately not in the repo). Searched 7 Oct, not found: C:\Users\TimothyBrand, C:\Lisp Files, C:\CE_PLAN (filename "Civil-Design-requirements-for-Developers*").
