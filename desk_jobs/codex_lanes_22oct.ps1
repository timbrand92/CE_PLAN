# Desk 22 Oct 2026 (Tim: use Codex up to the announced reset, a few astra passes plus building alongside): three parallel NON-AutoCAD Codex lanes beside the AutoCAD conveyor. Each lane runs two jobs one after another through queue3.sh. Cap 98 percent. After the reset (usage drops) the desk goes back to pace management.
$bash = 'C:\Program Files\Git\bin\bash.exe'
$dir = 'C:/Lisp Files/_CODEX_RUNNER'
$wt = 'C:/Lisp Files/_CODEX_RUNNER'
$lanes = @(
  @("cx_audit_civil|$wt|gpt-6-astra|high|98|6", "cx_build_ignore_undo|$wt|gpt-6.1-sol|high|98|6"),
  @("cx_audit_struct|$wt|gpt-6-astra|high|98|6", "cx_cases_draft|$wt|gpt-6.1-sol|high|98|6"),
  @("cx_audit_gate|$wt|gpt-6-astra|high|98|6", "cx_build_settings_rows|$wt|gpt-6.1-sol|high|98|6")
)
$n = 0
foreach ($l in $lanes) {
  $n++
  $args = ($l | ForEach-Object { '"' + $_ + '"' }) -join ' '
  $cmd = 'cd "' + $dir + '" && MAXC=6 bash queue3.sh ' + $args + ' >> "C:/CE_PLAN/desk_jobs/codex_lane' + $n + '.out" 2>&1'
  Start-Process -FilePath $bash -ArgumentList @('-lc', $cmd) -WindowStyle Hidden
  Add-Content 'C:\CE_PLAN\desk_jobs\codex_lanes_22oct.log' ("{0} lane {1} started: {2}" -f (Get-Date -Format 'ddd HH:mm'), $n, ($l -join ' ; '))
  Start-Sleep 20
}
