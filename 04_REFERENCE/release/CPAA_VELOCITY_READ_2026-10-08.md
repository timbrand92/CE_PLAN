# CPAA Hydraulics Design Manual — pipe speed read (8 Oct 2026)

Written by: Team DESIGN worker, design run 2 (headless, Opus), for INT-068 item 1.
Status: **PROPOSED only. Nothing here is Confirmed. No code or Settings were changed.** Tim ticks Confirmed himself.

---

## FOR TIM — the answer

1. **The manual gives no speed limit for uPVC pipe at all.** It is the concrete pipe makers' manual ("Hydraulics of Precast Concrete Conduits"). The only plastic it mentions is a PVC *lining* inside concrete sewer pipes (4.5 m/s, see item 3 below). So it cannot be the source for the uPVC 3 m/s figure.
2. **For concrete pipe it says 8 m/s**, not the 6 m/s CE uses today. 6 m/s in the manual is for in-situ concrete and hard rock channels, not precast pipe.
3. **Minimum (self-cleaning) speed: about 0.5 to 1 m/s** at full and half-full flow. CE's 0.6 m/s sits inside that range.
4. **Nothing on pit-outlet speed (the AS/NZS 3500.3 1.5 / 2.0 m/s figures) and nothing on detention-pipe grade.** Those stay sourced from AS/NZS 3500.3 and the CE guide as already ruled.

Three questions for you are at the end (section E).

---

## Sources read

1. **2013 edition (text readable):** `Civil Stuff\books\cpaa_design_manual_hydraulics_jan13.pdf`, 65 pages. Cover says first published 1983, reprinted 1986, 1991, 2007 and 2012 with minor modifications. Page numbers below are the printed page number, with the PDF page in brackets.
2. **Older edition (scanned pictures):** `Civil Stuff\CPAA_Hydraulics_Design_Manual.pdf`, 68 pages. Almost every page is a picture, so the text cannot be searched. I rendered the key pages and read them by eye: Table 3.2 (printed p.37), sewer maximum grade (p.55) and pressure mains (p.61). They give the **same figures** as the 2013 edition; only the standard numbers are older (AS 1342 / AS 1547 instead of AS/NZS 4058 / AS 1597). I did **not** read every scanned page of the older edition by eye; the stormwater minimum/maximum clause (4.1.2) was read in the 2013 edition only.

---

## A. Maximum speed by material — what the manual says

1. **Precast concrete pipe (AS/NZS 4058): 8.0 m/s.** Table 3.2, p.34 (PDF 35), "maximum recommended flow velocities for various conduit materials". The manual says absolute erosion limits cannot be given, because they depend on how smooth the pipe is, what debris it carries and how often the peak flow happens; the table lists values commonly adopted from experience. Section 4.1.2, p.42 (PDF 43) repeats it for stormwater drains: keep below 8 m/s if possible.
2. **Precast box culvert (AS 1597): 8.0 m/s.** Same table.
3. **In-situ concrete and hard-packed rock (300 mm minimum): 6.0 m/s.** Same table. This is a lined channel / cast-in-place value, **not** a pipe value.
4. **Open-channel and outlet linings (same table, for scour protection at culvert outlets, not pipes):** beaching or boulders 5.0; stones 150–100 mm 3.0–2.5; grass 1.8; stiff sandy clay 1.3–1.5; coarse gravel 1.3–1.8; coarse sand 0.5–0.7; fine sand 0.2–0.5 m/s.
5. **PVC-lined concrete sewer pipe: 4.5 m/s.** Section 5.3.2, p.53 (PDF 54). The manual says minor damage has been seen around the lining's joint strips when speed went above 4.5 m/s. This is a concrete pipe with a PVC lining, **not a uPVC pipe**.
6. **Concrete sewer pipe:** same 8 m/s as stormwater, with the note that some authorities prefer to stay well below it. Section 5.3.2, p.53.
7. **Cavitation (any pipe):** does not occur in full-flowing pipes below about 7.5–8 m/s (about 12 m/s in open conduits); very fast flows over 18–20 m/s cause it unless the surface is very smooth. Section 3.4.3, p.34.
8. **Pumped (pressure) mains:** usually under 2 m/s for cost reasons, up to 8 m/s acceptable where head is available. Section 6.2.6, p.60 (PDF 61). Not relevant to gravity stormwater.
9. **uPVC / PVC pipe: not in the manual.**
10. **HDPE / PE pipe: not in the manual.**
11. **Steel, cast iron, ductile iron (CE's "metal" row): not in the manual.**
12. **Fibre-reinforced cement (FRC) and GRP: not in the manual.**
13. **Vitrified clay: not in the manual.**

---

## B. Minimum (self-cleaning) speed

1. **Stormwater drains:** to get some self-cleaning of debris heavier than water, the manual recommends a minimum of **about 0.5 to 1 m/s at full and at half-full flow**, or a wall shear of 1.5 N/m². Section 4.1.2, p.42 (PDF 43). It does not split this by pipe material.
2. **Culverts:** below 0.5 m/s fine to medium sand settles out. Section 3.4.4, p.35 (PDF 36).
3. **Sewers (not stormwater, for comparison only):** minimum grade set by wall shear (1.3–2.5 N/m² for self-cleaning, 3–4 N/m² for slime control), roughly grade × diameter above 0.0008 m when flowing above 20 % full. Section 5.3.1, p.52–53.
4. **The manual's own view:** wall shear is a better control on erosion and silting than speed; speed is what traditionally gets used. Section 1.4, p.14 (PDF 15).

---

## C. PROPOSED Settings — manual figure against today's CE value

Today's CE values are read from the plugin's scour table (`Modules\Drainage\Models\UserSettings.cs`, `ScourVelocityByMaterial`, read 8 Oct 2026) and the 0.6 m/s pipe-sizing minimum. "Agree" means the CE figure is at or inside the manual figure.

1. **uPVC / PVC** — Manual: **none**. CE today: 3.0 m/s. Agree? **Cannot say: no manual figure.** Proposed: keep 3.0 m/s, still marked *unconfirmed, source not the CPAA manual*.
2. **HDPE / PE** — Manual: **none**. CE today: 3.0 m/s. Agree? **Cannot say.** Proposed: keep 3.0 m/s, unconfirmed.
3. **Concrete (RCP / RRJ / CONCRETE / CONC)** — Manual: **8.0 m/s** (Table 3.2). CE today: 6.0 m/s. Agree? **No — CE is 2 m/s stricter.** Proposed: 8.0 m/s if you want the manual's figure; 6.0 m/s if you want CE to stay cautious (see question 2).
4. **Box culvert** — Manual: **8.0 m/s**. CE today: no separate row (falls to concrete 6.0 if the material reads as concrete, otherwise unknown 6.0). Agree? **No.** Proposed: no new row; follow the concrete answer.
5. **Metal (CAST / DI / STEEL)** — Manual: **none**. CE today: 4.0 m/s. Agree? **Cannot say.** Proposed: keep 4.0 m/s, unconfirmed.
6. **GRP / FRC / clay** — Manual: **none**. CE today: no row, so the unknown value (6.0 m/s) applies. Agree? **Cannot say.** Proposed: leave as unknown.
7. **Unknown material** — Manual: **none** (the manual has no "unknown" rule). CE today: 6.0 m/s (Maximum pipe velocity). Agree? **Not a manual question.** Proposed: keep 6.0 m/s.
8. **Minimum speed (all materials)** — Manual: **about 0.5 to 1 m/s** at full and half-full flow. CE today: 0.6 m/s. Agree? **Yes, inside the range** (at the lenient end). Proposed: keep 0.6 m/s and note the source as CPAA 4.1.2.

---

## D. What the manual does not say (gaps — not filled)

1. **No maximum speed for any plastic pipe** (uPVC, PVC, HDPE, PE, GRP). The 3 m/s uPVC figure needs a different source (for example the pipe maker's literature or the council's code). It stays the single unconfirmed value, as INT-068 already said.
2. **No maximum speed for steel, cast iron, ductile iron, FRC or clay pipe.**
3. **Pit-outlet speed:** the manual has **no speed limit at pits**. It only uses the pit-outlet speed to work out pit energy loss (loss = k × outlet velocity head, k mostly 0 to 2; section 4.4, p.44, PDF 45) and to size the invert drop where the outlet pipe is smaller than the inlet (section 4.4.4, p.46, PDF 47). **Nothing relates to the AS/NZS 3500.3 1.5 m/s recommended / 2.0 m/s maximum.** Those two figures stay sourced from AS/NZS 3500.3 Clause 5.4.11.2(d) only.
4. **Detention-pipe minimum grade:** **not in the manual** (no detention or on-site storage section; "storage" appears only in a pressure-main example about a dam). The 1 in 200 for 225 mm and larger stays sourced from the CE guide only.
5. **No minimum speed by material.** The 0.5–1 m/s range applies to stormwater drains in general.

---

## E. Questions for Tim

1. **Where does the uPVC 3 m/s come from, if not CPAA?**
   What I found: the CPAA manual is about concrete pipe and gives no uPVC figure at all.
   **Recommendation: keep 3 m/s as a warning, labelled "unconfirmed — no standard found", until you or a colleague names the source** (a pipe maker's table or a council code you design to). On a job this means a uPVC pipe running at 3.5 m/s still gets the scour warning, exactly as today.
   Choices: (a) keep 3 m/s unconfirmed; (b) give me the document to read; (c) treat uPVC like unknown (6 m/s).

2. **Concrete pipe: manual 8 m/s or CE's 6 m/s?**
   What I found: the manual's figure for precast concrete pipe is 8 m/s; 6 m/s is its figure for in-situ concrete or rock channels.
   **Recommendation: keep 6 m/s as CE's office limit, and label the source "CE office rule (CPAA allows 8 m/s)".** It is only a warning, and a 7 m/s concrete pipe on a steep road job is worth a second look anyway; staying cautious costs nothing because it never blocks.
   Choices: (a) keep 6 m/s, labelled as office rule; (b) change to 8 m/s, the manual figure.

3. **Minimum speed: keep 0.6 m/s?**
   What I found: the manual recommends about 0.5 to 1 m/s at full and half-full flow. CE checks 0.6 m/s.
   **Recommendation: keep 0.6 m/s and record the source as CPAA 4.1.2.** Raising it to 1 m/s would flag many flat car-park and estate pipes that are fine in practice.
   Choices: (a) keep 0.6 m/s; (b) raise to 1.0 m/s.

Tick here when decided: Confirmed by Tim: ☐  (date and Tim's words go in the decisions file)
