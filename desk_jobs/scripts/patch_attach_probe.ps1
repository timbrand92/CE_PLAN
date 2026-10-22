# Desk 23 Oct 2026: replace the broken attach probe in launch_codex_retry.ps1 with the corrected one (Codex Computer Use is the tool mcp__node_repl__js; check it through codex_cu_probe.sh).
$f = 'C:\CE_PLAN\desk_jobs\launch_codex_retry.ps1'
$t = [IO.File]::ReadAllText($f)
$i = $t.IndexOf('function AttachProbe {')
$j = $t.IndexOf('for ($i = 1; $i -le $Tries; $i++) {')
if ($i -lt 0 -or $j -le $i) { 'anchors not found'; return }
$bash = 'C:/Program Files/Git/bin/bash.exe'
$new = @"
function AttachProbe {
  # 23 Oct 2026 (corrected): Codex Computer Use is the tool mcp__node_repl__js. The earlier probe asked for a tool literally named node_repl and always said MISSING. This probe asks a throw-away session to list its tool names through its exec tool and passes only when a node_repl or sky tool is there.
  `$o = (& '$bash' 'C:/CE_PLAN/desk_jobs/codex_cu_probe.sh' 2>`$null | Out-String)
  `$ok = (`$o -match 'CU_OK')
  `$helpers = @(Get-Process codex-computer-use -ErrorAction SilentlyContinue).Count
  `$lastEnd = (Get-Content (Join-Path `$d 'queue.log') -Tail 40 -ErrorAction SilentlyContinue | Where-Object { `$_ -match ' END ' } | Select-Object -Last 1)
  Add-Content 'C:\CE_PLAN\desk_jobs\codex_attach_log.csv' ("{0},{1},{2},{3},{4}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), `$(if (`$ok) { 'ATTACHED' } else { 'MISSING' }), `$helpers, `$name, (`$lastEnd -replace ',', ' '))
  return `$ok
}

"@
$t = $t.Substring(0, $i) + $new + $t.Substring($j)
[void][scriptblock]::Create($t)
[IO.File]::WriteAllText($f, $t, (New-Object Text.UTF8Encoding($false)))
'launcher patched, syntax ok'
