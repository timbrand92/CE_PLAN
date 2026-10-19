$paths = @(
  'C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees',
  'C:\Lisp Files\_TEST_COPIES_20260923',
  'C:\Lisp Files\_ACAD_DRIVER',
  'C:\ce_rc_drv', 'C:\ce_rc_scratch', 'C:\ce-hunt',
  "$env:USERPROFILE\.nuget\packages",
  "$env:LOCALAPPDATA\Temp",
  "$env:LOCALAPPDATA\NuGet",
  'C:\Autodesk', 'C:\Tools'
)
foreach ($p in $paths) {
  if (-not (Test-Path $p)) { continue }
  $s = (Get-ChildItem -LiteralPath $p -Recurse -File -Force -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum
  '{0,7:N1} GB  {1}' -f ($s / 1GB), $p
}
