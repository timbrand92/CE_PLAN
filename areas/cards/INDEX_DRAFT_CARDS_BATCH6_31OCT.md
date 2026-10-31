# Index: draft cards, batch 6 (31 Oct 2026, job n20)

All five are DRAFT FOR TIM. No code, no build, no test, no PR. Each follows the command review gate in the repo AGENTS.md. Source: Tim's decisions 182, 183 and 185 in C:\CE_PLAN\decisions\2026-10-29_TIM_ANSWERS.md.

## Batch A: CEMEMBER (decision 185, "yes to all four"; Structural)

CEMEMBER is still a typed command, not on the ribbon. All four faults are still there on the installed line (Structural 1.0.125), read in the code, not seen in AutoCAD. Each change gets its own Settings switch, shipped ON; OFF gives today's drawing exactly.

1. **A1, the member follows the UCS (BUG-909).** File: CARD_CEMEMBER_UCS_BUG909_DRAFT_31OCT.md. Questions for Tim:
   1. Approve the card? (recommend yes)
   2. A tilted 3D UCS: follow it like LINE does, or refuse? (recommend follow it)
   3. Two picks at different heights: draw level at point 1 with a warning? (recommend yes)
   4. Leave the old SBEAM alone? (recommend yes)
2. **A2, break marks at paper size on layouts (BUG-910).** File: CARD_CEMEMBER_LAYOUT_BREAKS_BUG910_DRAFT_31OCT.md. Questions:
   1. Approve the card? (recommend yes)
   2. The member itself on a layout stays full size, with one line telling the drafter? (recommend yes)
   3. Drop the LTSCALE warning on layouts? (recommend yes)
   4. LBUH and LBH in a separate small card under the same rule? (recommend yes)
3. **A3, either leg of an unequal angle upright (BUG-1124).** File: CARD_CEMEMBER_UA_LEG_BUG1124_DRAFT_31OCT.md. Questions:
   1. Approve the card? (recommend yes)
   2. Default Long, so lintels stay as today? (recommend yes)
   3. Ask after the "Sits" question? (recommend yes)
4. **A4, an RHS laid flat (BUG-1125).** File: CARD_CEMEMBER_RHS_FLAT_BUG1125_DRAFT_31OCT.md. Questions:
   1. **GUESS to confirm:** happy to drop "one orientation" for RHS and add Standing/Flat? (recommend yes)
   2. Approve the card? (recommend yes)
   3. Default Standing? (recommend yes)

## Card B: installer and CEMARKUPRUN downloads (decision 183, "yes"; Manager, installer, Structural)

5. **B, downloads (BUG-553, BUG-554).** File: CARD_INSTALLER_DOWNLOADS_BUG553_554_DRAFT_31OCT.md. Two findings first: the installer program has not downloaded WebView2 since 22 Jul (the code is switched off; the 9 Oct audit read switched-off code), and CEMARKUPRUN's download has been OFF by default for new PCs since 9 Oct (installed). First-install route and repair (BUG-883, BUG-888) are after the pilot (decision 182). Questions:
   1. Approve the card? (recommend yes)
   2. PCs that stored "download automatically" ON before 9 Oct: leave them, with clearer Settings wording? (recommend leave)
   3. WebView2: check and warn only, or bundle Microsoft's signed installer? (recommend check and warn only)
   4. Is Structural in Max's pilot? If not, the CEMARKUPRUN part is after the pilot too. (recommend after the pilot if no Structural)
   5. Leave the switched-off download code in the file until BUG-883, with a guard test? (recommend yes)
