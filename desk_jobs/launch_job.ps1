# Desk helper (plan/02, 8 Oct 2026): launch ONE headless Team worker on the Team account.
# Usage: pwsh -NoProfile -File launch_job.ps1 -JobFile <full path to the job .txt> -Model sonnet|opus
# The job text is fed to `claude -p`; the log goes beside the job file (<job>.log). Below Normal priority, hidden window.
param([Parameter(Mandatory=$true)][string]$JobFile, [string]$Model = 'sonnet', [switch]$Main)
if ($Main) { Remove-Item Env:CLAUDE_CONFIG_DIR -ErrorAction SilentlyContinue } else { $env:CLAUDE_CONFIG_DIR = "$env:USERPROFILE\.claude-team" }  # -Main DOES NOT WORK (9 Oct 08:30: 'OAuth session expired and could not be refreshed' for headless claude -p on the Max config): spend the Max meter with background Agent subagents from the desk chat instead
$log = [IO.Path]::ChangeExtension($JobFile, '.log')
$cmd = "claude -p --model $Model --permission-mode bypassPermissions --output-format text < `"$JobFile`" > `"$log`" 2>&1"
$p = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru
try { (Get-Process -Id $p.Id).PriorityClass = 'BelowNormal' } catch {}
"$JobFile started pid $($p.Id) ($Model)"
