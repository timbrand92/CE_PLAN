# Decision — CE AutoCAD Settings Transfer goes inside the plugin (30 Sep 2026)

Recorded by chat `CE_ACAD / general / fix / 01` (the settings-transfer chat), in the same reply as the decision.

## Tim's words, in order

1. 30 Sep 2026 ~10:15: "NEED TO MAKE SURE THIS IS UPTO DATE, READY TO TRANSFER FROM AUTOCAD 2022 TO AUTOCAD 2027 AND FROM ONE PCS 2027 TO ANOTHER PCS 2027. NOT NOW BUT AT SOME POINT I WANT TO ADD THIS TO OUR CE ACAD PLUGIN, LETS FIX IT MAKE SURE ITS WORKING AND THEN ADD IT IN WITH A PROMPT LATER"
2. ~10:25: "NEED AUTOCAD 2027 TO AUTOCAD 2026, USE ALL THE SDKS AS WELL"
3. ~10:35: "make sure my expereience isnt interrupted and my current setup isnt deleted"
4. ~11:25, after importing his real 2027 settings on a 2026 PC and checking AutoCAD 2026: "it works" (Tim-accepted: 2027 -> 2026).
5. ~11:30: chose "Yes, update it now" — the 2026 pass counts; the IT Admin copy was replaced the same minute (old 9 Jun copy kept in `IT Admin\CE_ACADSETTINGS\previous\`).
6. ~11:40, asked "if we wanted to implement this into the plugin how would it wokr?" — answered with the shape below.
7. ~11:45: "yes ship it inside the plugin, write the prompt"

## What was decided

1. **One engine.** The tested standalone tool stays the engine; the plugin adds a doorway. No rewrite inside AutoCAD.
2. **Shipped inside the plugin** (not opened from IT Admin): the tool travels in the Manager bundle (about 72 MB, self-contained single file), so it works on any PC with the plugin, synced or not. The IT Admin copy stays for PCs without the plugin yet.
3. **The shape Tim said yes to:** a Manager-tab button **Move My Settings** with three choices — **Save my settings**, **Load my settings**, **Undo last settings move**. Each one says "AutoCAD will close so your palettes are saved. Save your drawings first.", closes AutoCAD, runs the tool (packages default to the user's OneDrive), and ends with a **Start AutoCAD** button that reopens on the right profile. Undo loads the automatic pre-import backup.

## Open (not decided — do not fill)

1. The exact OneDrive folder name for packages.
2. Whether staff see the button or only admins.

## Build prompt

`C:\CE_PLAN\CHAT_PROMPT_MANAGER_SETTINGS_TRANSFER_01.md`
