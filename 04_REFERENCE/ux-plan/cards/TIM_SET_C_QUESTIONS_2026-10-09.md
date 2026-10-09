# Tim: Set C, eight places where two numbers disagree (Fri 9 Oct 2026)

Reply "all recommended", or "all recommended except 3: <what you want>". These are the places where the code's built-in number and your Settings number differ, so a fix would change a number you see on screen. The builders left them alone for exactly that reason.

1. **When does a pipe label say FLAT?** Today only when the two levels are exactly equal. The "essentially flat" warning uses your 5 mm Settings value. So a 3 mm fall on a 10 m pipe is labelled "1 IN 3333" while the warning calls it flat. **Recommend:** the label follows the same 5 mm Settings value. Example: a 3 mm fall on 10 m reads FLAT in both places.
2. **Long section speeds.** The long section uses its own roughness list (concrete 0.013, steel 0.012, everything else 0.010), so cast iron shows 0.010 there but 0.012 in CDRULES. **Recommend:** the long section reads your Settings roughness table, so the speed is the same everywhere.
3. **Detention Design tab starting values.** It starts with before-development C 0.30; your Settings say 0.35. **Recommend:** start from Settings (0.35). Example: open the tab on a new job and see 0.35.
4. **Pipe flow tab roughness.** It starts at 0.013 until you pick a pipe; your Settings say 0.010 for uPVC. **Recommend:** start from the Settings figure.
5. **Minimum cover.** Some places still use a built-in 600 mm while your Settings say 300 mm (CDRUNSOLVE and CDDESIGN already replace it with the rulebook cover, but a few other tools do not). **Recommend:** every tool reads the same Settings value. Which is your office minimum cover, 300 or 600?
6. **Pipe sizes the X-Civil import recognises.** Its own list is 100 to 900 with no 675, so a 675 pipe counts as "not standard" and the colour rule can overwrite its size. **Recommend:** read your Settings size list (the list you already have).
7. **Old SPS pits with no recorded radius.** They use 700; new ones offer your Settings 900. **Recommend:** read the Settings radius.
8. **LandXML circular pits.** CE reads a circular structure's size from a field called diamWidth, but the LandXML standard calls it diameter, so every standards-correct circular pit comes in at 600 x 600. **Recommend:** read "diameter" first, then diamWidth. Do your consultants' LandXML files use diameter?
