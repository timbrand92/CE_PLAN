# How to report a problem

**DRAFT, Thu 22 Oct 2026.** [CHECK] = still to be confirmed before hand-over.

---

## Answer first: send these six things

1. **The command name** you typed or clicked, for example `CD` or `PITSCHEDULE`.
2. **What you expected** to happen, in one line.
3. **What happened instead.** Copy the exact words from the command line or the window.
4. **The CE support zip:** type `CESUPPORT` (steps below).
5. **A screenshot** of the screen when it went wrong.
6. **A COPY of the drawing, only if Tim asks for it.** Never the original job file.

---

## 1. Make the CE support zip (1 minute)

1. **Type `CESUPPORT`** in AutoCAD and press Enter.
2. **CE prints** "[CESUPPORT] Creating support bundle...", then the place it saved the zip.
3. **The zip is in a "CE Support" folder on your Desktop.** Its name is coded, for example `CE_SUPPORT_xxxx_20261109_101500.zip`. [CHECK: Desktop folder name on 3.0.70]
4. **It never sends itself anywhere.** Your login and PC name are coded inside. Drawing paths are cut back to job numbers.
5. **The zip lists what it holds** in a file called `WHAT_IS_IN_THIS_ZIP.txt`.

## 2. Finding the log yourself (if CESUPPORT fails)

1. **Type `CEMANAGERLOGS`.** It opens the CE log folder.
2. **Or open File Explorer** and paste `%APPDATA%\CE_CVL_SUITE\logs` into the address bar. Press Enter.
3. **The Civil log is `CE_CVL_SUITE.log`.** Older days may sit beside it as separate files. Send the newest one, and today's if there are several. [CHECK: how the file rolls over each day]
4. **Do not delete or edit any log file.**

## 3. Take a screenshot

1. **Press Windows + Shift + S.**
2. **Drag a box** around the AutoCAD window, including the command line.
3. **Paste it** (Ctrl+V) into an email or a Word document, or save it from the notification.

## 4. The drawing: copies only

1. **Never send or upload the original job drawing.**
2. **If Tim asks for the drawing,** use File > Save As to save a copy in a new folder, and send the copy.
3. **No client names or street addresses** in file names, folder names, emails or notes. Use the job number only.

## 5. Where to send it

1. **Save the zip, the screenshot and the form below** in a sub-folder named by the date (for example `2026-11-09`) in the **CE Plugin Pilot Results** folder in the Engineering library. [CHECK: Tim to confirm Max has write access; the desk cannot set this]
2. **Then send Tim a short message** saying it is there.
3. **If you cannot save there,** send it to Tim directly. Do not use any other shared place.

## 6. What happens next

1. **Tim or the CE desk logs it** in the one CE bug list with your words.
2. **You hear back** whether it is a bug, a setting, or how CE is meant to work. [CHECK: Tim to set the expected reply time]
3. **A fix arrives in a later version,** installed the same way as the first one (page 02).

---

## One-page problem form (copy, fill in, save with the zip)

1. **Your name:**
2. **Date and time (Melbourne):**
3. **CE versions** (type `CE_VERSION`, copy the numbers): Civil ______ Manager ______
4. **AutoCAD year:** 2027 / other: ______
5. **Job number (no client name):**
6. **Drawing name (copy only):**
7. **Command typed or button clicked:**
8. **What I clicked and typed, step by step:**
   1.
   2.
   3.
9. **What I expected:**
10. **What happened (exact words from the screen):**
11. **What one `U` did afterwards:**
12. **Does it happen again if I repeat the steps?** Yes / No / Not tried
13. **Is it blocking my work?** Yes, I stopped / No, I worked around it (how): ______
14. **Attached:** support zip ☐ screenshot ☐ drawing copy (only if Tim asked) ☐
