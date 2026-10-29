<#
Lunch-window helper (Desk 29 Oct 2026, CE_ACAD / robot / build / 23).
Tim, Thu 29 Oct 2026: "if autocad is open at 2pm you need to save everything and close it during lunch then reopen everything at 3pm as it was".

  -Action Close   at 14:00 on a weekday: if Tim's AutoCAD is open AND the robot has work waiting (or LUNCH_CLOSE.flag exists),
                  save every drawing (QSAVE), check each one reads Saved, record the open drawings, then ask AutoCAD to quit (never kill it).
                  It refuses, and leaves AutoCAD exactly as it is, when: a never-saved drawing has content or changes, a drawing is
                  read-only with changes, a save fails, or AutoCAD stays busy (a command or dialog running, or Tim at the keyboard) for 10 minutes.
  -Action Reopen  at 15:00: if today's state says "closed", wait (up to 10 min) for the robot, Codex and the driver lock to be clear, then start
                  AutoCAD with the recorded command line and profile, open the drawings in the recorded order, activate the recorded active
                  drawing and restore maximised/normal. If AutoCAD is already running (Tim started it) it does nothing.
  -Action Status  prints counts only.
  -DryRun         decides and reports, but saves, closes, launches and writes nothing.

PRIVATE DATA (RULES 11): drawing paths live ONLY in the local state folder C:\ce_rc_scratch\lunch (outside OneDrive and every git repo,
checked at run time). The repo log desk_jobs\lunch_window.log gets counts only; Write-RepoLog refuses any line that looks like a path or a drawing name.
Tests: lunch_window_tests.ps1 in C:\ce_rc_scratch\lunch\tests (offline, mocked AutoCAD). Dot-source with -Action Lib to load the functions only.
#>
param(
    [ValidateSet('Close', 'Reopen', 'Status', 'Lib')] [string]$Action = 'Status',
    [switch]$DryRun,
    [switch]$IgnoreClock,
    [string]$StateDir = 'C:\ce_rc_scratch\lunch',
    [string]$DeskDir = 'C:\CE_PLAN\desk_jobs',
    [string]$LockFile = 'C:\ce_rc_drv\ACAD_LOCK.json'
)

$script:StateDir = $StateDir
$script:DeskDir = $DeskDir
$script:LockFile = $LockFile
$script:StateFile = Join-Path $StateDir 'lunch_state.json'
$script:DetailLog = Join-Path $StateDir 'lunch_detail.log'     # local only: may name drawings
$script:RepoLog = Join-Path $DeskDir 'lunch_window.log'        # in the CE_PLAN repo: counts only
$script:BusyWaitSec = 600       # 10 minutes of retries before giving up (Close: leave AutoCAD open; Reopen: leave it closed)
$script:BusyStepSec = 30
$script:QuitWaitSec = 180       # how long to wait for acad.exe to go after Quit
$script:LaunchWaitSec = 300     # how long to wait for a fresh AutoCAD to answer
$script:TypingIdleMs = 120000   # someone typed or moved the mouse in the last 2 minutes = Tim is still working: treat as busy

# ------------------------------------------------------------------ the outside world (replaced by mocks in the offline tests)
$script:Sys = @{
    GetAcad    = { Get-RunningAcad }
    AcadProcs  = { @(Get-CimInstance Win32_Process -Filter "Name='acad.exe'" | ForEach-Object { [pscustomobject]@{ Id = [int]$_.ProcessId; CommandLine = [string]$_.CommandLine; Path = [string]$_.ExecutablePath } }) }
    OtherProcs = { @(Get-CimInstance Win32_Process | ForEach-Object { [pscustomobject]@{ Id = [int]$_.ProcessId; Name = [string]$_.Name; CommandLine = [string]$_.CommandLine } }) }
    PidAlive   = { param($id) [bool](Get-Process -Id $id -ErrorAction SilentlyContinue) }
    Sleep      = { param($s) Start-Sleep -Seconds $s }
    Now        = { Get-Date }
    IdleMs     = { Get-IdleMs }
    Profile    = { Get-AcadProfileName }
    StartAcad  = { param($exe, $argLine) Start-Process -FilePath $exe -ArgumentList $argLine -PassThru | Out-Null }
    FileLocked = { param($p) Test-FileLocked $p }
}

function Initialize-LunchNative {
    if (-not ('LunchCom' -as [type])) {
        Add-Type -TypeDefinition @'
using System; using System.Runtime.InteropServices;
public static class LunchCom {
    [DllImport("ole32.dll")] static extern int CLSIDFromProgID([MarshalAs(UnmanagedType.LPWStr)] string progId, out Guid clsid);
    [DllImport("oleaut32.dll")] static extern int GetActiveObject(ref Guid rclsid, IntPtr reserved, [MarshalAs(UnmanagedType.IUnknown)] out object ppunk);
    [StructLayout(LayoutKind.Sequential)] struct LASTINPUTINFO { public uint cbSize; public uint dwTime; }
    [DllImport("user32.dll")] static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);
    [DllImport("kernel32.dll")] static extern uint GetTickCount();
    public static object GetRunning(string progId) { Guid g; if (CLSIDFromProgID(progId, out g) != 0) return null; object o; if (GetActiveObject(ref g, IntPtr.Zero, out o) != 0) return null; return o; }
    public static long IdleMs() { LASTINPUTINFO li = new LASTINPUTINFO(); li.cbSize = (uint)Marshal.SizeOf(typeof(LASTINPUTINFO)); GetLastInputInfo(ref li); return (long)(uint)(GetTickCount() - li.dwTime); }
}
'@
    }
}
function Get-RunningAcad {
    Initialize-LunchNative
    foreach ($prog in 'AutoCAD.Application.26', 'AutoCAD.Application') { $a = [LunchCom]::GetRunning($prog); if ($a) { return $a } }
    return $null
}
function Get-IdleMs { try { Initialize-LunchNative; [LunchCom]::IdleMs() } catch { [long]::MaxValue } }
function Get-AcadProfileName {
    # AutoCAD 2027: HKCU\Software\Autodesk\AutoCAD\R26.0\<CurVer>\Profiles, default value = the current profile name
    try {
        $r = 'HKCU:\Software\Autodesk\AutoCAD\R26.0'; $cv = (Get-ItemProperty $r -ErrorAction Stop).CurVer
        return [string](Get-ItemProperty "$r\$cv\Profiles" -ErrorAction Stop).'(default)'
    } catch { return '' }
}
function Test-FileLocked([string]$p) {
    try { $fs = [IO.File]::Open($p, 'Open', 'Read', 'None'); $fs.Close(); return $false } catch { return $true }
}

# ------------------------------------------------------------------ logging and the private-data guard
function Test-LooksPrivate([string]$t) {
    # a drive path, a UNC path, or a drawing/file name: never allowed in the repo log
    return ($t -match '[A-Za-z]:\\' -or $t -match '\\\\' -or $t -match '(?i)\.(dwg|dwt|dxf|dws|bak|sv\$)\b')
}
function Write-RepoLog([string]$t) {
    if (Test-LooksPrivate $t) { $t = 'line withheld: it looked like a path or a drawing name (see the local detail log)' }
    $line = '{0} {1}' -f ((& $script:Sys.Now).ToString('ddd dd MMM HH:mm')), $t
    Add-Content -LiteralPath $script:RepoLog -Value $line
    Write-Output $line
}
function Write-DetailLog([string]$t) {
    $line = '{0} {1}' -f ((& $script:Sys.Now).ToString('yyyy-MM-dd HH:mm:ss')), $t
    Add-Content -LiteralPath $script:DetailLog -Value $line
}
function Test-LocalOnlyFolder([string]$dir) {
    # true only when the folder is outside OneDrive, outside C:\CE_PLAN and C:\Lisp Files, and not inside any git working copy
    $full = [IO.Path]::GetFullPath($dir).TrimEnd('\') + '\'
    $bad = @($env:OneDrive, $env:OneDriveCommercial, $env:OneDriveConsumer, 'C:\CE_PLAN', 'C:\Lisp Files', 'C:\TimOS') | Where-Object { $_ }
    foreach ($b in $bad) { if ($full.StartsWith(([IO.Path]::GetFullPath($b).TrimEnd('\') + '\'), [StringComparison]::OrdinalIgnoreCase)) { return $false } }
    if ($full -match '(?i)\\OneDrive') { return $false }
    $p = $full.TrimEnd('\')
    while ($p) {
        if (Test-Path -LiteralPath (Join-Path $p '.git')) { return $false }
        $parent = Split-Path $p -Parent; if (-not $parent -or $parent -eq $p) { break }; $p = $parent
    }
    return $true
}
function Initialize-StateDir {
    if (-not (Test-LocalOnlyFolder $script:StateDir)) { throw 'the state folder is synced or inside a repo: refusing to write drawing paths there' }
    if (-not (Test-Path -LiteralPath $script:StateDir)) { New-Item -ItemType Directory -Path $script:StateDir -Force | Out-Null }
}

# ------------------------------------------------------------------ COM helpers (work the same on real AutoCAD and on the mocks)
function Get-DocList($acad) {
    $docs = $acad.Documents; $n = [int]$docs.Count; $out = @()
    for ($i = 0; $i -lt $n; $i++) { $out += , $docs.Item($i) }
    return $out
}
function Get-DocVar($doc, [string]$name) { $doc.GetVariable($name) }

# Is AutoCAD free to be saved and closed? A command running in any drawing, a dialog open (COM calls are refused), or Tim typing = busy.
function Test-AcadBusy($acad) {
    try {
        if ((& $script:Sys.IdleMs) -lt $script:TypingIdleMs) { return 'someone is using the keyboard or mouse' }
        foreach ($d in (Get-DocList $acad)) { if ([int](Get-DocVar $d 'CMDACTIVE') -ne 0) { return 'a command is running' } }
        return ''
    } catch { return 'AutoCAD is not answering (a dialog may be open)' }
}

# The snapshot: one record per open drawing, in Documents order. Untitled drawings get path ''.
function Get-AcadSnapshot($acad) {
    $active = $acad.ActiveDocument; $activeName = [string]$active.Name
    $list = @(); $i = 0
    foreach ($d in (Get-DocList $acad)) {
        $full = [string]$d.FullName
        $titled = $true; try { $titled = ([int](Get-DocVar $d 'DWGTITLED') -ne 0) } catch { }
        if (-not $full) { $titled = $false }
        $saved = [bool]$d.Saved
        $dbmod = 0; try { $dbmod = [int](Get-DocVar $d 'DBMOD') } catch { }
        $items = 0; try { $items = [int]$d.ModelSpace.Count } catch { }
        $list += [pscustomobject]@{
            order = $i; path = $(if ($titled) { $full } else { '' }); name = [string]$d.Name; titled = $titled
            read_only = [bool]$d.ReadOnly; modified = ((-not $saved) -or $dbmod -ne 0); has_content = ($items -gt 0)
            active = ([string]$d.Name -eq $activeName -and ([string]$d.FullName -eq [string]$active.FullName))
        }
        $i++
    }
    return $list
}

# The close decision, before any save. Returns '' when closing is allowed, otherwise the reason (counts only, no names).
function Get-CloseRefusal($snap) {
    $untitledWork = @($snap | Where-Object { -not $_.titled -and ($_.modified -or $_.has_content) }).Count
    if ($untitledWork -gt 0) { return "left open: $untitledWork never-saved drawing(s) hold work (no save location is ever invented)" }
    $roMod = @($snap | Where-Object { $_.titled -and $_.read_only -and $_.modified }).Count
    if ($roMod -gt 0) { return "left open: $roMod read-only drawing(s) have changes that cannot be saved" }
    if (@($snap | Where-Object titled).Count -eq 0) { return 'left open: no saved drawings are open (nothing to restore at 15:00)' }
    return ''
}

# Is the robot going to use the window? (RULES 11 "nothing runs just to run")
function Test-RobotWantsWindow {
    if (Test-Path -LiteralPath (Join-Path $script:DeskDir 'LUNCH_CLOSE.flag')) { return $true }
    if (Test-Path -LiteralPath (Join-Path $script:DeskDir 'HOLD_ROBOT.flag')) { return $false }
    $q = Join-Path $script:DeskDir 'ROBOT_QUEUE.txt'; if (-not (Test-Path -LiteralPath $q)) { return $false }
    foreach ($line in Get-Content -LiteralPath $q) {
        $l = $line.Trim(); if ($l -eq '' -or $l.StartsWith('#')) { continue }
        if (-not (Test-Path -LiteralPath "$l.done")) { return $true }
    }
    return $false
}

# Is the robot, Codex or a driver session still busy with AutoCAD? (same lock rule as acad_driver_v3 Get-V3LockState)
function Get-RobotActivity {
    if (Test-Path -LiteralPath $script:LockFile) {
        try {
            $l = Get-Content -LiteralPath $script:LockFile -Raw | ConvertFrom-Json
            $nowUnix = ([DateTimeOffset](& $script:Sys.Now)).ToUnixTimeSeconds()
            $live = $l.who -and [long]$l.expires -gt $nowUnix
            if ($live -and [int]$l.pid -gt 0 -and -not (& $script:Sys.PidAlive ([int]$l.pid))) { $live = $false }
            if ($live) { return 'the AutoCAD lock is held' }
        } catch { }
    }
    $p = @(& $script:Sys.OtherProcs | Where-Object { $_.CommandLine -match '(?i)codex(\.exe|\.cmd|\.js)?["]?\s+exec|tester_run[0-9]|chain_runner_run|case_runner\.ps1|acad_driver_v3|acad_driver_witness|desk_install_[cs][0-9]' })
    if ($p.Count -gt 0) { return 'a robot, Codex or driver process is running' }
    return ''
}

function Test-InWindow([datetime]$t, [int]$fromMin, [int]$toMin) {
    if ($t.DayOfWeek -in 'Saturday', 'Sunday') { return $false }
    $m = $t.Hour * 60 + $t.Minute; return ($m -ge $fromMin -and $m -le $toMin)
}
function Read-State { if (Test-Path -LiteralPath $script:StateFile) { Get-Content -LiteralPath $script:StateFile -Raw | ConvertFrom-Json } else { $null } }
function Save-State($s) { Initialize-StateDir; $s | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $script:StateFile -Encoding utf8 }

# ------------------------------------------------------------------ CLOSE (14:00)
function Invoke-LunchClose {
    $now = & $script:Sys.Now
    if (-not $IgnoreClock -and -not (Test-InWindow $now (13 * 60 + 55) (14 * 60 + 20))) { return (Write-RepoLog 'close: not a weekday 13:55-14:20, nothing done') }
    $acadP = @(& $script:Sys.AcadProcs)
    if ($acadP.Count -eq 0) { return (Write-RepoLog 'close: AutoCAD is not open, nothing to do') }
    if ($acadP.Count -gt 1) { return (Write-RepoLog "close: left open: $($acadP.Count) AutoCAD sessions are running (one expected)") }
    if (-not (Test-RobotWantsWindow)) { return (Write-RepoLog 'close: left open: no robot job is waiting (or HOLD_ROBOT.flag is set) and LUNCH_CLOSE.flag is absent') }
    $acad = & $script:Sys.GetAcad
    if (-not $acad) { return (Write-RepoLog 'close: left open: AutoCAD is running but would not answer (COM attach failed)') }

    # wait for AutoCAD (and Tim) to be idle: retry every 30 s for 10 minutes, never force
    $waited = 0
    while ($true) {
        $why = Test-AcadBusy $acad
        if (-not $why) { break }
        if ($waited -ge $script:BusyWaitSec) { return (Write-RepoLog "close: left open: AutoCAD busy ($why) for $([int]($waited/60)) minutes, nothing touched") }
        & $script:Sys.Sleep $script:BusyStepSec; $waited += $script:BusyStepSec
    }

    $snap = @(Get-AcadSnapshot $acad)
    $refuse = Get-CloseRefusal $snap
    if ($refuse) { return (Write-RepoLog "close: $refuse") }
    $titled = @($snap | Where-Object titled)

    $proc = $acadP[0]
    $state = [ordered]@{
        status = 'captured'; captured_at = $now.ToString('yyyy-MM-dd HH:mm:ss'); captured_day = $now.ToString('yyyy-MM-dd')
        acad_pid = $proc.Id; acad_exe = $proc.Path; acad_cmdline = $proc.CommandLine; profile = [string](& $script:Sys.Profile)
        window_state = $(try { [int]$acad.WindowState } catch { 0 })
        documents = @($titled | ForEach-Object { [ordered]@{ order = $_.order; path = $_.path; read_only = $_.read_only; active = $_.active } })
        untitled_empty_skipped = @($snap | Where-Object { -not $_.titled }).Count
    }
    if ($DryRun) { return (Write-RepoLog "close (dry run): would save and close $($titled.Count) drawing(s); nothing saved, closed or written") }

    # save each titled, writable drawing (QSAVE), then check every one reads Saved
    $docs = @(Get-DocList $acad); $fail = 0
    foreach ($d in $docs) {
        if (-not [string]$d.FullName) { continue }
        if ([bool]$d.ReadOnly) { continue }       # read-only and unchanged (changed ones were refused above)
        try { [void]$d.Save() } catch { $fail++; Write-DetailLog "save failed: $([string]$d.FullName): $($_.Exception.Message)" }
    }
    $unsaved = @($docs | Where-Object { [string]$_.FullName -and -not [bool]$_.Saved }).Count
    if ($fail -gt 0 -or $unsaved -gt 0) { return (Write-RepoLog "close: left open: $fail save(s) failed, $unsaved drawing(s) not reading saved; AutoCAD not closed") }

    $state.status = 'saved'; Save-State $state
    Write-DetailLog "captured $($titled.Count) drawing(s): $(($titled | ForEach-Object { $_.path }) -join ' | ')"
    try { [void]$acad.Quit() } catch { Write-DetailLog "Quit raised: $($_.Exception.Message)" }
    $acad = $null; [GC]::Collect(); [GC]::WaitForPendingFinalizers()

    $t = 0
    while ((& $script:Sys.PidAlive $proc.Id) -and $t -lt $script:QuitWaitSec) { & $script:Sys.Sleep 5; $t += 5 }
    if (& $script:Sys.PidAlive $proc.Id) {
        $state.status = 'quit-pending'; Save-State $state
        return (Write-RepoLog "close: saved $($titled.Count) drawing(s) and asked AutoCAD to quit, but it is still running after $($script:QuitWaitSec) s; NOT killed")
    }
    $state.status = 'closed'; $state.closed_at = (& $script:Sys.Now).ToString('yyyy-MM-dd HH:mm:ss'); Save-State $state
    return (Write-RepoLog "close: closed $($titled.Count) drawing(s), active one recorded, AutoCAD gone")
}

# ------------------------------------------------------------------ REOPEN (15:00)
function Invoke-LunchReopen {
    $now = & $script:Sys.Now
    if (-not $IgnoreClock -and -not (Test-InWindow $now (14 * 60 + 55) (15 * 60 + 30))) { return (Write-RepoLog 'reopen: not a weekday 14:55-15:30, nothing done') }
    $s = Read-State
    if (-not $s -or $s.status -ne 'closed' -or $s.captured_day -ne $now.ToString('yyyy-MM-dd')) { return (Write-RepoLog 'reopen: nothing was closed today, nothing to do') }

    $waited = 0
    while ($true) {
        $why = Get-RobotActivity
        if (-not $why) { break }
        if ($waited -ge $script:BusyWaitSec) { return (Write-RepoLog "reopen: left closed: $why after $([int]($waited/60)) minutes (state kept; run -Action Reopen -IgnoreClock to reopen by hand)") }
        & $script:Sys.Sleep $script:BusyStepSec; $waited += $script:BusyStepSec
    }
    if (@(& $script:Sys.AcadProcs).Count -gt 0) {
        $s.status = 'skipped-acad-running'; Save-State $s
        return (Write-RepoLog 'reopen: AutoCAD is already running (Tim or another session started it): nothing opened')
    }

    $docs = @($s.documents | Sort-Object { [int]$_.order })
    $missing = 0; $locked = 0; $toOpen = @()
    foreach ($d in $docs) {
        if (-not (Test-Path -LiteralPath $d.path)) { $missing++; Write-DetailLog "missing: $($d.path)"; continue }
        if (& $script:Sys.FileLocked $d.path) { $locked++; Write-DetailLog "locked: $($d.path)"; continue }
        $toOpen += , $d
    }
    if ($DryRun) { return (Write-RepoLog "reopen (dry run): would start AutoCAD and open $($toOpen.Count) drawing(s); $missing missing, $locked locked") }

    $argLine = Get-RelaunchArgs ([string]$s.acad_cmdline) ([string]$s.profile)
    & $script:Sys.StartAcad ([string]$s.acad_exe) $argLine
    $acad = $null; $t = 0
    while ($t -lt $script:LaunchWaitSec) {
        $acad = & $script:Sys.GetAcad
        if ($acad) { try { [void]$acad.Documents.Count; break } catch { $acad = $null } }
        & $script:Sys.Sleep 5; $t += 5
    }
    if (-not $acad) { return (Write-RepoLog "reopen: AutoCAD was started but did not answer within $($script:LaunchWaitSec) s; no drawings opened (state kept)") }

    $startDocs = @(Get-DocList $acad)   # the blank Drawing1 AutoCAD may open on start
    $opened = 0; $failed = 0; $activeDoc = $null
    foreach ($d in $toOpen) {
        $ok = $false; $tries = 0
        while (-not $ok -and $tries -lt 12) {
            try { $doc = $acad.Documents.Open([string]$d.path, [bool]$d.read_only); $ok = $true } catch { $tries++; & $script:Sys.Sleep 5 }
        }
        if ($ok) { $opened++; if ($d.active) { $activeDoc = $doc } } else { $failed++; Write-DetailLog "open failed: $($d.path)" }
    }
    foreach ($b in $startDocs) {
        try { if (-not [string]$b.FullName -and [bool]$b.Saved -and $opened -gt 0) { [void]$b.Close($false) } } catch { }
    }
    if ($activeDoc) { try { [void]$activeDoc.Activate() } catch { } }
    if ([int]$s.window_state -gt 0) { try { $acad.WindowState = [int]$s.window_state } catch { } }

    $s.status = 'reopened'; $s | Add-Member -NotePropertyName reopened_at -NotePropertyValue ((& $script:Sys.Now).ToString('yyyy-MM-dd HH:mm:ss')) -Force; Save-State $s
    $notBack = $missing + $locked + $failed
    if ($notBack -gt 0) { return (Write-RepoLog "reopen: reopened $opened drawing(s); could not reopen $notBack drawing(s) ($missing missing, $locked locked, $failed failed)") }
    return (Write-RepoLog "reopen: reopened $opened drawing(s) in order, active one restored")
}

# the recorded acad.exe command line minus the exe itself, with the profile added when it was not already named
function Get-RelaunchArgs([string]$cmdline, [string]$profileName) {
    $rest = $cmdline.Trim()
    if ($rest.StartsWith('"')) { $rest = $rest.Substring($rest.IndexOf('"', 1) + 1) } else { $sp = $rest.IndexOf(' '); $rest = $(if ($sp -ge 0) { $rest.Substring($sp) } else { '' }) }
    $rest = $rest.Trim()
    if ($profileName -and $rest -notmatch '(?i)(^|\s)/p\s') { $rest = ($rest + ' /p "' + $profileName + '"').Trim() }
    return $rest
}

# ------------------------------------------------------------------ STATUS
function Invoke-LunchStatus {
    $s = Read-State
    if (-not $s) { return 'lunch window: no state recorded' }
    $n = @($s.documents).Count; $ro = @($s.documents | Where-Object read_only).Count
    $missing = @($s.documents | Where-Object { -not (Test-Path -LiteralPath $_.path) }).Count
    return "lunch window: status $($s.status), captured $($s.captured_at), $n drawing(s) recorded ($ro read-only), $missing missing on disk now, robot wants the window: $(Test-RobotWantsWindow)"
}

switch ($Action) {
    'Lib' { }
    'Status' { Invoke-LunchStatus }
    'Close' { try { Invoke-LunchClose } catch { Write-RepoLog "close: stopped on an error, AutoCAD left as it was: $($_.Exception.GetType().Name)" } }
    'Reopen' { try { Invoke-LunchReopen } catch { Write-RepoLog "reopen: stopped on an error: $($_.Exception.GetType().Name)" } }
}
