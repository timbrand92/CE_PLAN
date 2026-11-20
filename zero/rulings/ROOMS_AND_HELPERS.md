# Current rulings: Rooms and helpers (the chats, Codex, the Team account, models, weekly usage, what the planning chat may do on its own)

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (this page holds D-302 to D-360 on its subject). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

(Added subject, 20 Nov 2026: how the work is organised did not fit one named page. CHAT_AND_TIM keeps how to talk to Tim; HOW_WE_WORK keeps built, tested, installed, accepted; the merge gate and the night test safety rules have their own pages.)

## What is decided now

### The rooms

1. **Three live chats, then five rooms (D-353, D-360):** Tim asked (D-353): "can you create a plan on how many sessions/side sessions work with you as the control room, then maybe add one for tim interviews and general chat so we dont waste your context. ideally i want to just keep getting interviewed on the plan and how things work so you dont have any unknowns at all. i want to get this right, how will we do so. also in that chat we need something research and thinking outside the box to fix bugs, improve speed of build and testing, improve functionality, improve simplicitiy for end user and anything else". Written as `ROOMS.md`. Then (D-360): "i asked for you to plan out all the side sessions including new ones or logical ones to help you keep on top all the different areas of the building, testing and whatever else and archive what you no longer need making sure everything is saved." Done as `ROOMS.md` section 0: five rooms:
   - **Control room:** this planning chat; files Tim's words as decisions.
   - **Tim's room:** interviews him down a list of unknowns, his general chat, and research and fresh thinking; records his words in `interview\ANSWERS_TIM.md` (TR numbers); never edits the decisions, the plan or the code.
   - **Build room:** builders and the merge only.
   - **Check room** ("CE_ACAD / check / 01"): the gate (see MERGE_GATE).
   - **AutoCAD test room** ("CE_ACAD / acad test / 01"): night tests and pictures inside a test AutoCAD; it shadows the night of 20 Nov and runs the nights after (see NIGHT_TEST_SAFETY).
2. **The old plan's leftovers (D-360):** asked whether to switch off two hourly scheduled jobs from 30 Sep and the weekly Monday-questions job and archive their idle chats: "do what you recommend". Done: `ce-holiday-watchdog`, `ce-desk-hourly-check` and `ce-monday-questions` switched off (they can be switched on again in the scheduled tasks list); 36 idle chats archived (they can be brought back from the Archived list). Not archived: the trials chat (it shares the control room's working folder) and the tools interview chat (paused, not ended).

### Models

3. **The right model and thinking for each job (D-303):** "use the correct models and thinking and if you use codex cli make sure you use astra and sol 6.2 recently added". R-68: Sonnet builds and draws, Opus reviews, Haiku scans and does mechanical edits; high thinking only for reviews of sums, checks and anything that can put a wrong figure on a sheet; low or medium for mechanical work. Codex CLI: `gpt-6.2-sol` for building, driving and testing, `gpt-6.2-astra` for reviews and sweeps (read from its own model list on this PC on 18 Nov); not the older 6.1 or 6 models.
4. **Update Codex first, 6.1 only as a fallback (D-304):** "you might need to update codex to get it working if not use 6.1 but try to update it first".

### Codex, the Team account and usage

5. **Overnight 18 to 19 Nov (D-302):** "can you keep things moving overnight test and maybe fix as many bugs as possible or doing something else useful whilst managing weekly usage i will do a reset tomorrow just use the time in a useful manner and consider you can use codex and its weekly usage and you have access to autocad and whatever you need". Claude weekly allowance read at 11:47 pm: all models 88 per cent used, Fable 45 per cent. Planning chat's reading (his to overturn): "whatever you need" does not lift rule 1.9, the no-install rule or the client-data rules.
6. **Codex does the heavy work while Claude usage is short (D-307, 19 Nov, until Fri 20 Nov midday):** "so i reset but we only have 26% remaining until tomorrow at midday can you leverage codex until then and manage our usage"; "codex has 72% remaining so plenty of room there". Codex does the building, fixing, testing and reviewing; the Claude chats are a thin layer; no AutoCAD in his working hours.
7. **Codex abides by the rulings (D-308):** "make sure codex abides by our rules and decisions". Every Codex job carries `CODEX_STANDING_BRIEF.md` at the top, names the rulings it touches, is reviewed against them, and is checked by the build chat before merging; a run that breaks a line is thrown away.
8. **The Team account in use again until Sat 21 Nov midday (D-329, lifting his hold of 5 Nov):** "and i have 50% usage remaining on team account until saturday midday so we can leverage that as well. i wouldnt mind something checking what codex is doing and it can also do work of its own". One Team checker (Opus) reads every Codex result against the rulings, separate from Codex's own review; Team Sonnet builders may do work of their own, on their own branches, never the same files as a running Codex job. Login tested 8:19 am on 19 Nov: works; the sign-in ends between 24 and 27 Nov and he will need to sign in again before then. (In D-307 he had asked whether the Team account could be used; his hold of 5 Nov stood until D-329.)
9. **Codex flat out until its weekly limit reset (D-342, 19 Nov):** "codex weekly limit ends in 6 hours 11 minutes can you leverage the heck out of it and use as much of that usage as possible". Codex run in parallel, as many jobs as the machine allows, until about 9:45 pm, on the one-job release only; every bar stands (standing brief, failing test first, its own review and the Team check before the main line; AutoCAD only after 5:30 pm on test copies under rule 1.9).
10. **Codex may drive the mouse in AutoCAD (D-326):** "yes whenever it needs it and it doesnt interfere with my work". Planning chat's reading (his to widen): test copies only, a test AutoCAD the robot started, never while his own AutoCAD is open or he is using the PC (in practice outside his hours or when he says he is away); rule 1.9 in full in every brief; a licence or sign-in window stops everything; no PIT, PP or CD typed and no function keys until the supervised check (D-325) is done. Narrowed further by D-364 (NIGHT_TEST_SAFETY).

### What the chats may do on their own

11. **Install the tools the work needs (D-304):** "you can test and build and install whatever you need to, to keep progress going". Planning chat's reading (his to widen): tools such as Codex and test or build tooling; not the new plug-in into his own AutoCAD, not the old plug-in, not rule 1.9.
12. **The held-back things, on the planning chat's judgement (D-306):** after he asked "why cant you do the things nobody will do?" (D-305; that question alone gave no yes), he said: "i think you should be able to if you think you need it to keep work progressing". The planning chat may install into his AutoCAD, touch his AutoCAD or the old plug-in, type PIT, PP or CD, retire the old desk robot or put q back WHEN it judges the work needs it, and must say what it did and how to undo it. Its own record of using it on 19 Nov, 12:10 am: the old desk robot retired and q put back (DONE); installing the new plug-in into his AutoCAD, changing any AutoCAD setting, profile or licence, touching the old plug-in, or letting a robot type PIT, PP or CD or press function keys NOT done, because the work did not need it (see AUTOCAD_RULES item 19). Rule 1.9 still applies.

## Changed along the way

1. **His hold of 5 Nov on the Team account (stood in D-307) was lifted by D-329 (19 Nov)** until Sat 21 Nov midday.
2. **The planning chat's reading of D-304 (no install into his AutoCAD) was widened by D-306 (19 Nov):** on its own judgement when the work needs it, saying what and how to undo.
3. **Three live chats (D-353) became five rooms (D-360, 20 Nov).**
4. **"Codex 6.2 models" (D-303) with "6.1 if the update fails" (D-304):** 6.1 is a fallback only.

## Still open on this subject

1. **The Team sign-in ends between 24 and 27 Nov;** he must sign in again before then (D-329). Waits on: Tim.
2. **The Team account after Sat 21 Nov midday** is not ruled (D-329). Waits on: Tim.
3. **Whether the trials chat and the tools interview chat are archived later** (D-360). Waits on: the control room.

## Where the detail lives

1. `DECISIONS.md` D-302 to D-308, D-326, D-329, D-342, D-353, D-360.
2. `ROOMS.md` (section 0); `CODEX_STANDING_BRIEF.md`; `interview\ANSWERS_TIM.md`; `RULES.md` R-68.
