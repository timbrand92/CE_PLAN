# TRUST-05: the hidden sync made visible

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card and lifts the HOLD for it.
**Class:** Modify. Nothing is retired; CDSYNC and CDREBUILD keep working as typed commands.
**Source:** Tim, 5 Nov: "it does random stuff for them and I can't explain why it does it". Trust rule 1: nothing changes a drawing without showing you first. Step 5 of `areas\trust-plan.md`.

---

## FOR TIM

**CE keeps a record of the pits and pipes inside the drawing. Today that record is quietly updated from inside ordinary tools, about 60 places in all, and nothing tells you. This card does two things only: tools that say they only read stop updating it, and every update that does happen prints one line.**

```before
You run CE Health to look at a job.
CE quietly re-reads the whole drawing and rewrites its record.
Two pipes on the pipe layer become "100 dia UPVC". No line is printed.
```

```after
You run CE Health. Nothing is changed.
If the drawing and the record have drifted: "CE: needs checking. 2 lines on the pipe layer are not in the record."
Later you open Edit Pit, which still updates the record for now:
"CE updated its record: 2 pipes added, 1 pit removed, 3 cover levels read from the drawing."
```

**What this card does not do:**

1. **It does not stop the update inside everyday tools** (PIT, CD, CDEDIT, sources, CDSL). That is step 8. Here they only start telling you.
2. **It does not remove the guesses.** The line will show them happening. Removing them is step 6.
3. **It does not change what CDSYNC or CDREBUILD do.**

## 1. What you'd see

1. **The four tools that claim to only read** (CDGRAPH, CE Health, CDDIAG, the dashboard): they read what is stored and change nothing. If the stored record is behind the drawing they say so in one line and point to the check.
2. **Any tool that updates the record:** one line, only when something actually changed, counting what was added, removed, re-attached and re-read. Plain words, no software words.
3. **Nothing changed:** no line. Silence means nothing happened.
4. **CDRECOVERINVERTS** prints the same line for the update it runs before it starts.
5. **Windows that update the record** (Pit Schedule relink, calculations, long section, Inspector) show the same line on the command line.

## 2. The full experience

1. **Trigger:** unchanged; these are tools you already run.
2. **Cancel and Escape:** a cancelled read-only tool leaves nothing behind, because it now writes nothing.
3. **Undo:** the line must only promise what is true. Today CDSYNC prints "One U undoes it" and that has never been proven. **A probe on a copy comes first** (probe P2 in the plan): run an update, press U once, compare the record. The line says "U undoes it" only if the probe shows it does.
4. **Save and reopen:** read-only tools must cause no "save changes?" question on close. Checked with AutoCAD's changed-drawing counter, as step 1 does.
5. **Locked layers, Xrefs, REFEDIT:** the read-only tools touch nothing. The update inside everyday tools is unchanged in what it touches.
6. **AutoCAD 2022 to 2024:** same lines. No ribbon needed.
7. **Speed:** read-only tools should get faster, since they no longer re-read the whole drawing.

## 3. Settings

1. **"Tools that only read never update the record":** on or off. Default on. Off returns today's behaviour.
2. **"Say what changed whenever the record is updated":** on or off. Default on.

Both are the undo for this card. Rows on the Settings page are Codex's window work; until then they live in the settings file.

## 4. What it reuses

1. **The read-only check behind CDCHECKCURRENT** (step 1), which already proves it changed nothing.
2. **The counts the update already writes to the log:** pits removed, items re-attached, pits and pipes added, inverts filled.

**New work, stated plainly:** the update returns nothing today, so the counting has to be added to it. Three things are not counted anywhere yet: pipes dropped, pipes re-joined to a different pit, and cover or invert levels changed from drawing text. The read-only check also cannot yet see drawn pits or pipe-layer lines that are missing from the record; that has to be added for the "needs checking" line to be honest.

## 5. How it gets proven

**Before any code:** probe P2 (Undo after an update), on a copy.

**Robot, in real AutoCAD on copies:**

1. For each of the four read-only tools: read the stored record, run the tool, read it again. Identical, and AutoCAD's changed counter has not moved.
2. A copy with one extra line on the pipe layer: the read-only tool says "needs checking" and the count matches CDCHECKCURRENT.
3. Edit Pit on that copy: the line reads "1 pipe added", and the record really gained exactly one pipe.
4. A copy with nothing to update: no line at all.
5. Erase a pit, then run PIT: the line counts 1 pit removed and its pipes.
6. Move a cover level text, run a tool: the line counts 1 cover level read from the drawing.
7. A deliberately broken version whose line says 2 when 3 changed must fail.

**Codex:** reads the lines on screen for plain words and length.

**Tim, about three working days:** work normally. Right = every line matches what you just did or what you know about the job, and no line appears when you changed nothing.

## 6. Decisions for Tim

1. **Scope:** this card stops the update only in the four read-only tools plus CDRECOVERINVERTS's hidden first step, and adds the line everywhere. Everyday tools keep updating until step 8. Recommended. OPEN.
2. **How loud:** one line on the command line. Not a window, not a sound. Recommended. OPEN.
3. **CDRECOVERINVERTS:** should its first-step update be removed as well, so that it works from the stored record and refuses a pipe whose size is not known? Recommended yes, because today the hidden update fills the size with "100" just before the tool checks whether the size is known. OPEN.

## 7. Not known yet

1. How AutoCAD's U treats an update made from inside a tool or a window. The code cannot answer this.
2. Whether any of the four read-only tools shows wrong information when it no longer updates first.
3. How often each of the roughly 60 places fires on real jobs. The count is one reader's; this card does not rely on the exact number.
4. Whether CDREBUILD always runs a full update or sometimes skips it.

Written from reading Civil 3.0.90 (commit cf059dcf). Nothing here was run in AutoCAD.
