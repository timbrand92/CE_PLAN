# Desk 23 Oct 2026 (Tim: "if not push it harder"): 16 sliced read-only astra code sweeps over the installed code (every .cs file of Civil/Manager/Structural/Shared in slices), lanes 17-20 (four sweeps each). Output: areas/CODEX_SWEEP_Snn_23OCT.md.
$dir = 'C:\Lisp Files\_CODEX_RUNNER'
$enc = New-Object Text.UTF8Encoding($false)
Set-Location 'C:\Lisp Files\CE_ACAD_PLUGIN'
git fetch -q origin 2>$null
$h = [IO.File]::ReadAllText("$dir\cx_h01_undo.txt")
$pre = $h.Substring(0, $h.IndexOf('AREA:'))
function Files($ref, $paths) { $o = @(); foreach ($p in $paths) { $o += git ls-tree -r --name-only $ref $p 2>$null | Where-Object { $_ -match '\.(cs|xaml)$' } }; $o | Sort-Object }
$civ = 'origin/claude/rel-20261022m'; $str = 'origin/claude/rel-20261022s2'
$sets = @()
$svc = Files $civ @('Modules/Drainage/Services/'); $k = [Math]::Ceiling($svc.Count / 6)
for ($i = 0; $i -lt 6; $i++) { $sets += ,@("Civil Services slice $($i+1) of 6", $civ, ($svc | Select-Object -Skip ($i*$k) -First $k)) }
$rul = Files $civ @('Modules/Drainage/Rules/'); $k = [Math]::Ceiling($rul.Count / 2)
for ($i = 0; $i -lt 2; $i++) { $sets += ,@("Civil Rules slice $($i+1) of 2", $civ, ($rul | Select-Object -Skip ($i*$k) -First $k)) }
$sets += ,@('Civil Commands', $civ, (Files $civ @('Modules/Drainage/Commands/')))
$ui = Files $civ @('Modules/Drainage/ViewModels/', 'Modules/Drainage/Dialogs/', 'Modules/Drainage/Controls/', 'Modules/Drainage/Helpers/', 'Modules/Drainage/Core/'); $k = [Math]::Ceiling($ui.Count / 2)
for ($i = 0; $i -lt 2; $i++) { $sets += ,@("Civil windows, helpers and core slice $($i+1) of 2", $civ, ($ui | Select-Object -Skip ($i*$k) -First $k)) }
$sets += ,@('Civil Models', $civ, (Files $civ @('Modules/Drainage/Models/')))
$ss = Files $str @('Modules/Structural/Services/'); $k = [Math]::Ceiling($ss.Count / 2)
for ($i = 0; $i -lt 2; $i++) { $sets += ,@("Structural Services slice $($i+1) of 2", $str, ($ss | Select-Object -Skip ($i*$k) -First $k)) }
$sets += ,@('Structural UI, Commands, Models, Core', $str, (Files $str @('Modules/Structural/UI/', 'Modules/Structural/Commands/', 'Modules/Structural/Models/', 'Modules/Structural/Core/')))
$sets += ,@('Manager and Shared', $civ, (Files $civ @('Modules/Manager/', 'Shared/')))
$n = 0
foreach ($s in $sets) {
  $n++
  $id = 'S{0:00}' -f $n
  $list = ($s[2] -join "`n")
  $t = $pre + "AREA: CODE SWEEP $id : $($s[0]). Read EVERY file in the list below at git ref $($s[1]) (git show $($s[1]):<path>), the largest and most central first, and hunt for real defects of any kind a drafter or colleague could meet: logic errors, wrong units or signs, off-by-one, null handling that throws, exceptions swallowed so a failure looks like success, wrong default when a settings key is absent, writes in code that should be read-only, work done in the wrong order (check-then-write), state shared across documents, locked layer / Xref / REFEDIT / paper space handling, performance traps, and wording that is false. Prefer fewer, proven findings over many guesses. $($s[2].Count) files:`n$list`nFINDINGS FILE: C:\CE_PLAN\areas\CODEX_SWEEP_$($id)_23OCT.md`n"
  [IO.File]::WriteAllText("$dir\cx_s$('{0:00}' -f $n).txt", $t, $enc)
}
$wt = 'C:/Lisp Files/_CODEX_RUNNER'
$lane = 17
for ($i = 0; $i -lt $n; $i += 4) {
  $jobs = @(); for ($j = $i; $j -lt [Math]::Min($i + 4, $n); $j++) { $jobs += ('"cx_s{0:00}|{1}|gpt-6-astra|high|98|6"' -f ($j + 1), $wt) }
  $sh = "#!/usr/bin/env bash`ncd `"C:/Lisp Files/_CODEX_RUNNER`"`nMAXC=12 bash queue3.sh $($jobs -join ' ') >> `"C:/CE_PLAN/desk_jobs/codex_lane$lane.out`" 2>&1`n"
  [IO.File]::WriteAllText("C:\CE_PLAN\desk_jobs\codex_lane$lane.sh", $sh, $enc)
  $lane++
}
"written $n sweeps; lanes 17-$($lane-1)"
