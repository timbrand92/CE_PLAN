# DATA-01 — Corpus privacy, de-identification and provider clearance

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** blocked at Gate 0
**AutoCAD verification:** not started
**Design rules enforced:** privacy fail-closed; synthetic by default; provenance; sanitised evidence; no
unapproved provider access
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-25`

## Mandatory findings already verified

- The current tracked corpus subtree contains 141 files.
- Obvious project/address-bearing snapshot filenames remain in current files and committed history.
- The audit found 142 unique historical corpus paths and 163 historical corpus objects.
- The corpus remains reachable at the tips of 65 local/remote refs in this clone.
- A current-working-tree rename or deletion cannot clear the exposure.

## Gate 0 ruling

DATA-01 remains **failed** until all approved controls are evidenced, including:

- synthetic/de-identified content;
- arbitrary/local coordinate translation while preserving relative geometry;
- metadata removal;
- privacy-preserving scan output;
- review of warning-positive representative samples;
- provider-specific permission;
- committed-history remediation or an approved history-access restriction.

A history rewrite is disruptive: it changes commit hashes and requires coordinated clone/branch/remote handling.
It must be a separately planned and explicitly authorised operation. No rewrite is performed by PC-01.

## Approved source card — verbatim

## DATA-01 — current state

| Item | Finding | Required state |
|---|---|---|
| AutoCAD AI palette | `CDASK` works; final hang retest remains | Modify and retain alias |
| Read-only reviews | Some still reconcile drawing data | Rebuild around frozen snapshots |
| MCP connection | Planned only | Build later |
| Repository candidates | **153 files** | Privacy classification required |
| Main `corpus/` | **26 tracked files** | Not yet proven safe |
| Text examined | **150 files** | Automated and human clearance |
| Binary candidates | **2 PNG files; no candidate DWG/PDF detected** | Inspect metadata/content |
| Warning matches | 110 address-like, 9 project/client labels, 7 user paths, 10 phone-like | Investigate and sanitise |

These are warning matches, not proof of real client data. Until cleared, the classification should be **Unverified / Restricted**.

## DATA1–DATA15 recommendations

| ID | Recommended decision | Practical example |
|---|---|---|
| DATA1 | Treat the present corpus as **Restricted** until approved. | Ask CE cannot read it yet. |
| DATA2 | Codex may see normal source files, but corpus and fixtures stay excluded until cleared. | Coding access does not automatically include drawing examples. |
| DATA3 | Separate data into **private source**, **sanitised examples** and **synthetic tests**. | Original subdivision stays private; invented subdivision enters testing. |
| DATA4 | Use synthetic examples by default. | “SITE-001 / ROAD-A / PIT-01”, not a real project. |
| DATA5 | Replace names, addresses, job numbers, title details, paths, emails and phone numbers with stable labels. | The same client becomes `CLIENT-001` everywhere. |
| DATA6 | Treat distinctive site geometry as potentially identifying. | Crop or simplify a recognisable subdivision layout. |
| DATA7 | Never expose raw DWG, PDF, survey or site images automatically. | AI receives an approved pipe/pit snapshot—not the DWG. |
| DATA8 | Strip hidden metadata from approved files. | Remove author, computer name and original file path. |
| DATA9 | Every approved example gets a small clearance record. | Source type, sanitisation date, permitted provider and reviewer. |
| DATA10 | AI connections receive only specifically approved folders. | Private folders remain inaccessible even if someone requests them. |
| DATA11 | Run privacy checks at the real access boundary; warnings fail closed. | Suspicious fixture is blocked before Claude/Codex sees it. |
| DATA12 | Check repository history separately. Current-file deletion alone is insufficient. | An old committed address may still exist in earlier versions. |
| DATA13 | Record which providers and purposes may use each example. | Approved for local tests does not mean approved for OpenAI. |
| DATA14 | Logs show file counts and reason codes—not captured client text. | “Address warning: 3 files,” without displaying addresses. |
| DATA15 | Acceptance requires automated clearance plus Timothy reviewing only three representative sanitised samples. | No file-by-file or AutoCAD drawing test required. |

**Recommendation:** approve DATA-01 as presented. This closes the AI13 × AI15 seam while minimising Timothy’s testing.

No files changed, no build run and no deployment performed. The consolidated planning-record update remains pending; when authorised, I recommend detailed cards under the existing `docs/workflows` structure with a short locked-status index in `CLEAN_SLATE_REBUILD.md`.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-26

✅ Approve DATA-01 as presented
This closes the AI13×AI15 seam thoroughly — and it goes deeper than most privacy processes, which stop at text redaction. DATA6 (distinctive site geometry is a fingerprint), DATA8 (hidden metadata), DATA12 (git history), and DATA14 (the scanner mustn't leak what it finds) are all real identifiers that a surface scrub misses. Good card.

🚨 DATA12 is the critical one — and it's the SEC-001 lesson again
"Current-file deletion is insufficient" is exactly why the leaked Azure key had to be rotated, not just deleted — git history keeps every version ever committed. Concrete consequence for the corpus:

If those 26 corpus files ever held real client data in an earlier commit, sanitising the current files leaves it in history — and Codex-with-repo-access can reach it via git checkout <old-commit>.

So DATA12 means: scan the corpus's history, not just its current state. A positive result forces the same decision SEC-001 did — scrub the history (BFG/filter-repo) or restrict Codex from history. And flag this clearly: a history scrub rewrites commit hashes and force-pushes — it's disruptive to every clone and can't be done casually. Plan it as a deliberate action, don't let it happen mid-stream.

🎯 The sharpest addition — real coordinates are geolocatable
DATA6 says distinctive layouts are identifying. Push it one step: the corpus JSONs encode real site geometry as actual coordinates (eastings/northings, AHD RLs). Those numbers are text — so a text scan sees them as harmless — but real survey coordinates locate the real site on a map. Stripping the client name doesn't help if the coordinates pin it to a street.

Sanitisation should translate coordinates to a local/arbitrary origin — keep the relative geometry (so the tests still exercise real network shapes) while removing the absolute location. That's DATA6 applied to the numbers, not just the picture.

📝 One refinement to DATA15
When you review the 3 representative samples, choose them to include files that had warning hits (address-like, phone-like), not just already-clean ones. The point of your spot-check is to prove the redaction actually caught the real matches — so validate it where it had work to do, not where there was nothing to catch. Reviewing three clean files proves nothing.

✅ The two most sophisticated calls
DATA6 treating geometry as identifying is something most privacy reviews get wrong — a subdivision's shape survives text redaction. Right catch.
DATA14 (the scanner logs "address warning: 3 files", never the address itself) prevents the privacy tool from becoming a leak vector — especially since logs flow into support bundles. That's privacy-preserving privacy-scanning. Genuinely well thought through.
🔒 Locked, nothing starts
Fail-closed (DATA1/10/11), synthetic-by-default (DATA4), per-provider consent (DATA13), and history-aware (DATA12) — this is the right way to clear the corpus before any AI touches it.

(Still tracking the record-preservation you flagged: SH-04, AI-01 and now DATA-01 are chat-approved but not yet in the committed docs. The offer to fold them all in as one consolidated pass stands whenever you want it — just name the destination.)
