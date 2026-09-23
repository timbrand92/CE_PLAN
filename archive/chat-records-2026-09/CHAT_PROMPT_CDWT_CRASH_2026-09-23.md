# Chat brief — the CDWT crash (BUG-163), and the suspected crash on close (BUG-164), 23 September 2026

Paste everything from RUN CONFIG down into the tanks chat ("CE Civil - LPD & Pits, Tanks, Level") or a new chat.

---

## RUN CONFIG

- **Model: the strongest available (Claude Opus). Thinking: high.**
- **Why:** a crash that AutoCAD reports and CE never logs. The answer is in the crash report and in how AutoCAD is driven. A wrong guess about AutoCAD's internals costs a colleague a crash on Tuesday.
- **Downgrade option:** none for the diagnosis. A cheaper model is fine only for writing the test steps afterwards.

---

## 0. Why now, and the deadline

**Tim, 23 Sep 2026:** start on the CDWT crash now, without waiting for Codex's report. Version 3 goes to **one colleague on Tuesday 29 Sep**. A crash in front of that colleague is the worst outcome.

1. **Anything merged to `master` by Thursday 24 Sep, 5:30pm (Melbourne) goes to the colleague.** After that it waits for the next release.
2. **Do not install anything on Tim's PC.** Installs go only through the release chats (`CE_ACAD / release-v3-colleagues / deploy / 01` and `/ plan / 01`), and Codex is testing the installed build.
3. **Every `dotnet build` / `dotnet test`: `-p:SkipDevBundle=true -nr:false --disable-build-servers`.** Without the flag, the Drainage net10 build overwrites Tim's live bundle under Codex's test.
4. Branch from `master`. Read `C:\TimOS\RULES.md`, then `C:\CE_PLAN\START_HERE.md`, then `C:\CE_PLAN\areas\civil-G-water-tanks-cdwt.md`.

## 1. The two bugs

1. **BUG-163** — `CDWT`: **"AutoCAD cannot continue"** at the callout point while placing a tank. First seen by Tim on 16 Sep. Reproduced by Codex on 17 Sep (W4): 4500 L underground, 1000 L detention, underdeck plan, Place tank; insertion and callout prompts appear, **no ghost of the tank follows the cursor**, and picking the callout position crashes AutoCAD. **No CE log line exists for it.** Full entry in `C:\CE_PLAN\BUG_CARPARK.md`.
2. **BUG-164, suspected** — AutoCAD may be crashing **when it is closed**. Five crash reports sit beside install times (16 Sep 16:03 and 22:32; 23 Sep 09:33, 11:05, 11:25). Not reported by Tim. Settle it: is it real, and is CE in it?

## 2. The evidence already on disk

1. **Crash reports:** `C:\Users\TimothyBrand\AppData\Local\CrashDumps\acad.exe.*.dmp`, eight files, 77–95 MB each. The 16 Sep ones (11:52, 12:17, 16:03, 17:57, 22:32) may include BUG-163.
2. **Codex's W4 record:** `C:\TimOS\retired\_TEST_COPIES_20260917\package\FAILURE_EVIDENCE_REGISTER_2026-09-17.md`, section W4, with `evidence\w4-crash.jpg` and `evidence\w4-capture-window.log`.
3. **Codex's crash probe** runs in today's list as step **B-T8** (press Enter at the callout prompt instead of picking). Its result lands in `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_2026-09-23.md`.

**PRIVATE DATA:** the crash reports hold AutoCAD's memory, which can include drawing content and job names. The 17 Sep evidence folder may name real jobs. **Read them where they are. Never copy them, or anything read out of them that names a job, into a repository, a commit or a GitHub issue.**

## 3. How to read a crash report — ask Tim first

1. **No debugger is installed on this PC.** Only `dotnet-trace` is.
2. `dotnet-dump` (Microsoft, from NuGet) can read the .NET side of a full dump, and AutoCAD 2027 runs on .NET 10. **Installing it is a download: ask Tim first, naming the tool, the source and the size.** Do not install anything without his yes.
3. Separate what the dump **shows** from what you **think**. **Never state what AutoCAD does internally.** If the dump does not settle it, say "insufficient information" and propose the probe that would.

## 4. What to deliver

1. **The cause**, labelled documented fact / observed in the dump or log / hypothesis.
2. **A fix or a containment** (if the cause is out of reach, CE must at least not reach the crashing path), merged by Thursday 5:30pm **only if finished and tested**, with a `REGRESSION_LOG.md` entry.
3. **Codex steps** that prove it, added to `C:\CE_PLAN\PENDING_TESTS.md` and sent to `CE_ACAD / release-v3-colleagues / plan / 01` for Codex's second pass.
4. **BUG-163 and BUG-164 kept current** in `BUG_CARPARK.md`. **Never mark FIXED** until Tim has confirmed it in AutoCAD.
5. **Stage files by name** in every commit. Never `git add -A` or `git add -u` in `C:\CE_PLAN`: other chats leave unsaved edits there.
