# Desk 23 Oct 2026 (Tim: "sort codex out ... manage it so we actually get somewhere"; Codex reset expected before about 05:00 Sat Melbourne): builds queue4.sh (queue3.sh plus FAST MODE flags) and the FILLER queue the supervisor feeds in parallel to the AutoCAD conveyor: 32 build jobs cx_lf01..32 (ledger fixes BUG-873..1029, five bugs each) and 6 astra review jobs cx_rv01..06 (independent review of the open draft PRs).
$dir = 'C:\Lisp Files\_CODEX_RUNNER'
$enc = New-Object Text.UTF8Encoding($false)
$q3 = [IO.File]::ReadAllText("$dir\queue3.sh")
$q4 = $q3.Replace('codex exec --skip-git-repo-check --dangerously-bypass-approvals-and-sandbox -m "$model"', 'codex exec --skip-git-repo-check --dangerously-bypass-approvals-and-sandbox -c service_tier="fast" -c features.fast_mode=true -m "$model"')
if ($q4 -eq $q3) { 'queue4: replace anchor not found' } else { [IO.File]::WriteAllText("$dir\queue4.sh", $q4.Replace("`r`n", "`n"), $enc); 'queue4.sh written (fast mode flags)' }
$b1 = [IO.File]::ReadAllText("$dir\cx_b01_automation_ids.txt")
$pre = $b1.Substring(0, $b1.IndexOf('TASK:'))
$h1 = [IO.File]::ReadAllText("$dir\cx_h01_undo.txt")
$apre = $h1.Substring(0, $h1.IndexOf('AREA:'))
$lines = @()
$wt = 'C:/Lisp Files/_CODEX_RUNNER'
for ($i = 0; $i -lt 32; $i++) {
  $a = 873 + 5 * $i; $b = [Math]::Min($a + 4, 1029); $n = '{0:00}' -f ($i + 1)
  $task = "TASK: LEDGER FIX BATCH $n : carpark bugs BUG-$a to BUG-$b (the 23 Oct findings ledger, C:\CE_PLAN\areas\FINDINGS_LEDGER_22OCT.md; entries in C:\CE_PLAN\BUG_CARPARK.md: grep each id). For EACH bug: (1) check it is not already covered: gh pr list --state all --search <BUG id>, the FIX_WAVE2_BATCH*_REPORT.md, FIX_ROUND_*_REPORT.md and CODEX_BUILD_*_REPORT files in C:\CE_PLAN\areas and the branch list (git branch -r | grep -i <id>); if covered, say so and skip; (2) skip and write the reason if it needs files on the protected list in C:\Lisp Files\_CODEX_RUNNER\common.txt, Tim's engineering or design word (QUESTIONS_FOR_MONDAY.md), a Structural-only decision, or if the cause is not in the code at the base; (3) otherwise verify the cause at the base origin/claude/rel-20261023l (installed Civil 3.0.71 / Manager 1.1.71; Structural base origin/claude/rel-20261023s), implement the smallest safe fix with a test that fails before and passes after, a REGRESSION_LOG.md entry, branch cx2/bug-<id>-<short>, DRAFT pull request against that base with the plain 'What Tim will see'; a switch that guards a BUG FIX ships ON (document its default with a /// Default: on. line). Every commit message names each bug number in full. Report C:\CE_PLAN\areas\CODEX_LEDGER_FIX_BATCH${n}_23OCT.md (ANSWER FIRST: per bug: PR number, head, tests, totals, or skipped and why) pushed by name from C:\CE_PLAN."
  [IO.File]::WriteAllText("$dir\cx_lf$n.txt", $pre + "`n" + $task + "`n", $enc)
  $lines += "cx_lf$n|$wt|gpt-6.1-sol|high|97|8"
}
for ($i = 1; $i -le 6; $i++) {
  $n = '{0:00}' -f $i
  $t = $apre + "AREA: INDEPENDENT REVIEW OF DRAFT PRs, GROUP $i OF 6. List the open draft PRs of the CE repo: gh pr list --state open --limit 200 --json number,title,headRefName,headRefOid,baseRefName,isDraft ; keep those whose branch starts with fw2/ , cx/ , cx2/ , fix/ or b04/ , sort by PR number, split into six equal consecutive groups and review group $i. Opus has already reviewed many of them (C:\CE_PLAN\areas\REVIEW_CODEX_PRS_A_2026-10-23.md, REVIEW_CODEX_PRS_B_2026-10-23.md, REVIEW_FIXWAVE2_A_2026-10-23.md, REVIEW_FIXWAVE2_B_2026-10-23.md): you are the SECOND independent reviewer: read the diff of each PR against its base, check the Opus verdict item by item and find what the review missed (wrong default for a bug-fix switch, missing test, a write in a read-only path, clash with another PR, wording, units, redo-safety). Give per PR: agree / disagree with the Opus verdict and the exact reason. FINDINGS FILE: C:\CE_PLAN\areas\CODEX_PR_REVIEW_GROUP${n}_23OCT.md`n"
  [IO.File]::WriteAllText("$dir\cx_rv$n.txt", $t, $enc)
  $lines += "cx_rv$n|$wt|gpt-6-astra|high|97|3"
}
# interleave reviews early: put the six reviews first, then the builds
$rv = $lines | Where-Object { $_ -match '^cx_rv' }; $lf = $lines | Where-Object { $_ -match '^cx_lf' }
Set-Content 'C:\CE_PLAN\desk_jobs\FILLER_QUEUE.txt' (@($rv) + @($lf)) -Encoding utf8
"filler queue: $($rv.Count) reviews + $($lf.Count) builds"
