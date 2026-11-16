# Stage 5: how we work (draft on Tim's answers of 16 Nov 2026)

**Status:** the four rulings below are Tim's (D-089 to D-092). The rest is the planning chat's write-up from his standing rules (`RULES.md`, R-18, R-65, R-68) for him to correct. Not yet approved as a stage.

## "Done" is four separate facts (R-18)

1. **Built:** the code exists and its own machine checks pass.
2. **Tested:** something that did NOT build it has driven it, in real AutoCAD where that matters, and written down what it saw.
3. **Installed:** it is on Tim's PC, once, and the loaded version has been read back.
4. **Accepted:** Tim says so, or a full robot pass in real AutoCAD when he is busy (D-089: "Me, or a robot pass if I am busy"). A robot-accepted tool says "robot-accepted" until Tim has used it; he spot-checks.
No status line may merge these. A tool is described by all four, each yes or no.

## The rules of the road

1. **One tool at a time, each finished before the next** (D-091): mock-up approved, built, tested by something that did not build it, installed once, accepted; then the next.
2. **Nothing new is started while a tool on the ribbon is broken** (D-090). Fix it or take it off the ribbon first.
3. **Order:** the trials; the foundation (facts, holds, sums, joins, the office list, self-check on open, no-plugin proof, one-click update); then Pit, Pipe, Levels along a run, inlets, tank, pit schedule, title and issue, CE tools; then one real job carried start to issue; then colleagues.
4. **Every tool starts from the foundation and the UI plan** (`design\FOUNDATION.md`, `design\UI_PLAN.md`): a full-size working mock-up at both screen sizes and both themes, looked at by the lead, checked by a separate UI critic, then shown to Tim.
5. **The scalability test on every change (R-65):** a new variable, thing or council rule must be a new line in a list. If it needs a new piece of screen or a special case, stop and fix the foundation instead.

## Who does what (R-68)

1. **Lead chat (strongest model):** interviews Tim, decides, checks. Does not build.
2. **Builder (Sonnet):** one at a time, from a tight written brief.
3. **Reviewer and UI critic (Opus):** never the one that built it.
4. **Scans and counts (Haiku):** never AutoCAD or program logic.
5. **Robot tester in real AutoCAD:** the existing Codex arrangement; it makes evidence.
6. The lead reads the usage meter at the start of each sitting and names the model on every helper.

## When the real AutoCAD may be used (D-092)

1. Tim: "anytime between 5:30pm and 8:30am weekdays and all day weekends".
2. Test copies only, never a live job.
3. **The hours win over the switch file (D-093).** Inside those hours, trials for the zero plan may start AutoCAD on test copies whatever `C:\Users\TimothyBrand\.timos\autocad.json` says, as long as no AutoCAD window of Tim's is already open. If one is open: do not touch it, do not close it; wait and tell Tim. Outside those hours the switch file rules as before.

## Not settled

1. Which chat builds, and how the build chat is named and briefed (Stage 6).
2. The usage budget per tool.
3. What the robot pass must contain to count as accepted (which everyday actions, on which test drawings).
