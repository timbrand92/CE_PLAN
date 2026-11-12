# The test set: about 10 real past jobs, and what counts as a pass

**Status: DRAFT (12 Nov 2026).** No job is picked. Nothing was opened. Part of area TRUST (`areas\trust-plan.md`).
**Source:** voice talk, 6 Nov: about 10 real past jobs, messy ones included; pass = CE correctly reads pits, pipes, downpipes, tanks and the LPD. Testing order: Codex on the test set, then Tim on real jobs for about 3 days, then colleagues.

**Privacy rule for this whole file and everything made from it:** no client name, street address or job address goes into any file in a repository, any commit message, any screenshot file name or any log line. Jobs are called T01 to T10 everywhere. The list that says which real job is T01 lives on Tim's PC only.

---

# FOR TIM

**You pick about 10 past jobs. For each one, the right answers get written down once. From then on every step of the plan is checked against those answers, before and after, so nothing that worked can quietly stop working.**

## 1. What you pick at your PC (about 20 minutes)

Pick about 10 jobs that between them cover this list. One job can cover several lines.

1. **A clean current job** drawn start to finish with the current tools. This is the control.
2. **A revision** of a job first drawn months ago and reopened since.
3. **An old LISP-era job** with no CE record at all.
4. **A job drawn partly on AutoCAD 2022 to 2024 and partly on 2027,** so some pipes are the new one-piece pipe and some are ordinary lines. Optional: on 12 Nov Tim did not list this kind among the revisions that come back (answer B1). He did list old LISP-era jobs, early plugin jobs and hand-drawn jobs with no CE tools, so lines 3 and 14 matter most.
5. **A job with plastic pits** (350 x 350) as well as concrete pits.
6. **A job with a pit that has more than one pipe in** and one with more than one pipe out.
7. **A job with downpipes** connected by charged or suspended pipes.
8. **A job with a water tank,** its feeding pipes and its overflow.
9. **A job with two legal points of discharge,** if you have one.
10. **A metre drawing,** if any job was drawn in metres.
11. **A large job,** your biggest drainage plan.
12. **The messiest job you can think of:** copied from another job, labels moved, things exploded.
13. **One a colleague drew,** not you.
14. **A hand-drawn job with no CE tools at all:** pits and pipes as plain AutoCAD blocks and lines (added from answer B1, 12 Nov). Right for this job = CE claims nothing as Sure and invents nothing.

For each job, the file that gets used is the last issued drawing, not a working copy.

## 2. Where the copies live

1. **Local only:** `C:\CE_WORK\testset\T01` to `T10`. Never in a repository, never in OneDrive.
2. **The originals are never opened by a test.** Each run starts from a fresh copy of the copy.
3. **The key** (which real job is T01) is one text file in that folder on your PC.

## 3. The answer sheet for each job

One sheet per job, kept beside the copy, local only. It is the truth the reader is marked against.

1. **Pits:** how many; for each, its number, its size, its cover level, its invert, which pipes come in and which go out.
2. **Pipes:** how many; for each, diameter, invert at each end, which way it flows, what it joins at each end.
3. **Downpipes:** how many; for each, the pipe leaving it and where that ends up.
4. **Tanks:** size, which pipes feed it, where the overflow goes.
5. **LPD:** where it is, which pit or pipe it belongs to; both, on a two-outlet job.
6. **Known oddities:** anything you know is wrong or unusual on that drawing. A reader that reports a real fault is right, not wrong.

**How the sheet gets filled with the least of your time (recommended):** the answers are first taken from the issued Pit Schedule and the labels on the plan, by reading them. You then check each sheet once and correct it. You do not type them from scratch. Your confirmation is what makes it the truth; until then it is a draft.

## 4. How one item is marked

Every item on the sheet gets exactly one of four marks:

1. **Right:** CE's reading equals the sheet.
2. **Unknown:** CE says Unknown for something the sheet has. Honest, but a miss.
3. **Wrong:** CE states a value as a fact and it differs from the sheet. This is the fault that costs trust.
4. **Invented:** CE reports something that is not in the drawing at all (a pipe that is a construction line, a pit that is not there).

## 5. What counts as a pass (recommended; question A1 and B3 are OPEN)

**For one job:**

1. **Zero Wrong and zero Invented.** One of either fails the job.
2. **Unknowns within the limit you set.** Recommended starting limit: no Unknown on anything that carries CE's own identity (those must be Right), and Unknowns allowed only where the drawing truly lacks the information.
3. **The drawing is unchanged by reading it.** Checked each time.
4. **The same answer twice.** Two runs on fresh copies give identical readings.

**For the set:**

1. **Every job passes.** Not nine of ten.
2. **On AutoCAD 2027 and on 2024.**
3. **A result reads:** "T03: pits 11 of 11 Right; pipes 13 of 14 Right, 1 Unknown, 0 Wrong, 0 Invented; downpipes 6 of 6; tanks 1 of 1; LPD Right. PASS."

## 6. How the set is used through the plan

1. **Now, before any code (when you lift the hold for it):** probe P3 opens each copy read-only and lists every block name and attribute on the drainage layers. That list becomes the reader's table of older versions.
2. **Step 1:** the opening line's counts are compared with the sheets.
3. **Every step:** all jobs are read before and after. Nothing that was Right may become anything else.
4. **Step 6:** zero Invented, and identical readings in millimetre and metre copies.
5. **Step 8:** the full pass rules above. This is the gate for the first colleague release.
6. **After release:** any drawing a colleague reports a problem on is offered to you as a new test job (T11 onward), with your yes.

## 7. Who does what

1. **Tim:** picks the jobs; confirms each answer sheet once; rules on engineering questions the sheets raise.
2. **Robot (Claude):** everything that can be read from the drawing as a value.
3. **Codex:** everything that must be seen: the list window, the plan after Apply, the schedule placed on the sheet.
4. **Nobody** marks a job as passed from a build result. A pass is the marks above, counted.

## 8. Not known yet

1. Whether you have a two-outlet job or a metre job to put in. If not, those two cases use made-up drawings, said plainly as made-up.
2. How long the answer sheets take. Ten jobs of about 15 pits each is roughly 150 pits and 200 pipes to confirm.
3. Whether reading a schedule off an issued drawing is accurate enough to draft the sheets, or whether you would rather mark up a print.
4. What old LISP drawings contain. No old LISP tools were found on this PC, so those jobs are the only source.
