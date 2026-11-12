# TRUST-M2: going back a version, written and rehearsed

**Status: DRAFT.** Not approved, not run. Nothing is installed on any PC until Tim approves this card and names where the rehearsal happens.
**Class:** Missing (a procedure, no code). Manager's own Roll Back button is not used.
**Source:** Tim, 5 Nov: "EVERYTIME I GIVE SOMEONE A RELEASE IT MAKES THEIR EXPERIENCE WORSE". The 5 Nov plan: "hand roll back written down and rehearsed once". Trust plan section 3 line 5. Step M2 of `areas\trust-plan-manager.md`.

---

## FOR TIM

**If a release goes wrong on a colleague's PC, someone has to put the previous CE back in minutes, without touching drawings. The steps exist on paper (colleague pack page 2, section 7) and have never been tried. This card tries them once, on a PC set up like a colleague's, and writes down exactly what happened.**

```before
Going back: written in the colleague pack, never run.
Manager's Roll Back button: hidden, administrator only, never tried on a colleague PC.
Unknown: does a drawing saved on the newer CE open on the older one?
Unknown: does the older CE read the settings the newer one wrote?
```

```after
A one-page record: "Rehearsed <date> on a spare login, AutoCAD 2027:
newer build in, made-up drawing saved, older build back in 2 minutes,
drawing opened, CEHEALTH clean, settings read correctly."
The colleague pack's going-back page with every [CHECK] answered.
```

## 1. What happens, in order

1. **Set up:** a second Windows login on a spare office PC with AutoCAD 2027, holding the build a colleague has today (decision 1). Never Tim's own login.
2. **Record the starting point:** the fingerprint of each CE plugin file, CE_VERSION, CEHEALTH, a copy of the five CE settings folders.
3. **Install the newer build** by the colleague pack's steps (rename the old folders to `.backup`, copy in the new ones, Civil and Manager together).
4. **Use it:** open a made-up test drawing, place a few pits, pipes and supports, change one setting, save.
5. **Go back** by the pack's steps: close AutoCAD, rename the new folders aside, take `.backup` off the old ones, put the settings copies back only if needed.
6. **Check:** fingerprints match the starting point; CE_VERSION and CEHEALTH clean; the made-up drawing opens; the robot reads the same pits, pipes and supports from it; the changed setting is either kept or plainly reset.
7. **Do it a second time** from a clean start, timed, by following only the written page.
8. **Write the record** and correct the colleague pack wherever reality differed.

## 2. The full experience

1. **AutoCAD closed:** checked twice in Task Manager before each swap, as the installer itself insists (Verified, `Installer\SafeBundleInstaller.cs:402`).
2. **Drawings:** never touched by going back. Only made-up drawings are used.
3. **Old folders:** renamed, never deleted, at every step.
4. **The all-users plugin folder:** checked for an old CE copy that would load first (colleague pack page 2, step 5).
5. **AutoCAD 2022 to 2024:** not in this rehearsal (decision 3).

## 3. Settings

None changed by the rehearsal except the one setting changed on purpose in step 4.

## 4. What it reuses

1. **The colleague pack, page 2, sections 2 and 7.**
2. **The installer's own kept copy** of the old plugin, as a second way back (Verified, `SafeBundleInstaller.cs:315-317`), noted but not relied on.
3. **The robot's reading** of a drawing, for the before-and-after check.

## 5. How it gets proven

1. **Robot:** fingerprints before and after each swap; the made-up drawing read under both builds gives the same pits, pipes and supports.
2. **Codex:** looks at the ribbon and CEHEALTH after each swap, with screenshots kept.
3. **Tim:** reads the one-page record. Right = the steps fit on one page and took about 2 minutes the second time.

## 6. Decisions for Tim

1. **Where it happens.** Recommended: a second Windows login on a spare office PC. Example: five swaps on your own login, and one slip leaves you without CE on a job morning. OPEN.
2. **Who may go back on a colleague's PC.** Recommended: the release keeper only (you, for the first three releases). Example: a colleague who renames folders alone could leave Civil new and Manager old, and lose the CE ribbon. OPEN (release process E1, E3).
3. **AutoCAD year.** Recommended: 2027 only for now, matching your answer that the first colleague is on 2027. OPEN.
4. **Manager's Roll Back button.** Recommended: stays hidden; tried once on the spare login only after this hand rehearsal has passed twice. OPEN.

## 7. Not known yet

1. **Whether a spare office PC exists.**
2. **Whether a drawing saved on the newer CE opens cleanly on the older one.** This card answers it.
3. **Whether the older CE reads the settings the newer one wrote.** This card answers it.
4. **Whether the AutoCAD security prompt appears** on a login that has never loaded CE 3.0.

Written from reading Manager 1.1.89 (commit cf059dcf) and the colleague pack. Nothing here was run.
