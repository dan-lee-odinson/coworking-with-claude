<#
.SYNOPSIS
    Gaming + AI laptop tune-up for Windows 11.

.DESCRIPTION
    Applies a curated set of safe, reversible performance tweaks to a Windows 11
    laptop intended for both gaming and local AI / ML workloads (e.g. NVIDIA RTX
    + Intel CPU). See README.md for the rationale behind each step.

    THIS SCRIPT INTENTIONALLY DOES NOT:
      * Disable Memory Integrity (HVCI). On 12th-gen Intel and newer the FPS
        cost is small, and disabling it weakens kernel malware protection.
      * Disable Hyper-V or VBS. They are required for Cowork, WSL2, Docker
        Desktop, Windows Sandbox, and the Android emulator.
      * Uninstall third-party apps. Audio enhancers and bundled antivirus
        should be removed via Settings > Apps so Windows handles dependencies.
      * Update GPU drivers. Vendor apps frequently fail; download manually.

    What it DOES do (all reversible):
      1. Switch to (or create) the Ultimate Performance power plan.
      2. Disable Game DVR (background recorder).
      3. Enable Game Mode (scheduler hint).
      4. Tune the Multimedia Class Scheduler "Games" profile.
      5. Set a fixed pagefile (8 GB initial, 16 GB max).
      6. Verify Hyper-V / VBS is still active so Cowork keeps working.

    Generated from a Cowork session with Claude.
    Anonymized: contains no personal or system-specific identifiers.

.NOTES
    Author : coworking-with-claude (anonymized)
    Run as : Administrator
    Reboot : Recommended after completion
#>

#Requires -RunAsAdministrator

$ErrorActionPreference = 'Stop'

Write-Host ""
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "  Gaming + AI Laptop Tune-up for Windows 11" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host ""

# ---------------------------------------------------------------------------
# Step 1/6: Ultimate Performance power plan
# ---------------------------------------------------------------------------
Write-Host "[1/6] Setting Ultimate Performance power plan..." -ForegroundColor Yellow

$ultMatch = powercfg /list | Select-String 'Ultimate Performance'
if (-not $ultMatch) {
    # GUID below is the Microsoft-published Ultimate Performance scheme template.
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
    $ultMatch = powercfg /list | Select-String 'Ultimate Performance'
}

# Extract the GUID (4th whitespace-delimited token of "Power Scheme GUID: <guid>  (Ultimate Performance) *")
$ultGuid = ([regex]::Match($ultMatch.Line, '([0-9a-fA-F-]{36})')).Value
if ($ultGuid) {
    powercfg /setactive $ultGuid
    Write-Host "      Active scheme GUID: $ultGuid" -ForegroundColor Green
} else {
    Write-Host "      Could not parse Ultimate Performance GUID. Skipping." -ForegroundColor Red
}

# ---------------------------------------------------------------------------
# Step 2/6: Disable Game DVR (background recorder)
# ---------------------------------------------------------------------------
Write-Host "[2/6] Disabling Game DVR..." -ForegroundColor Yellow

$gameDvrUserPath = 'HKCU:\System\GameConfigStore'
if (-not (Test-Path $gameDvrUserPath)) { New-Item -Path $gameDvrUserPath -Force | Out-Null }
Set-ItemProperty -Path $gameDvrUserPath -Name 'GameDVR_Enabled'         -Value 0 -Type DWord -Force
Set-ItemProperty -Path $gameDvrUserPath -Name 'GameDVR_FSEBehaviorMode' -Value 2 -Type DWord -Force

$gameDvrPolicyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR'
if (-not (Test-Path $gameDvrPolicyPath)) { New-Item -Path $gameDvrPolicyPath -Force | Out-Null }
Set-ItemProperty -Path $gameDvrPolicyPath -Name 'AllowGameDVR' -Value 0 -Type DWord -Force

Write-Host "      Game DVR disabled (user + machine policy)." -ForegroundColor Green

# ---------------------------------------------------------------------------
# Step 3/6: Enable Game Mode
# ---------------------------------------------------------------------------
Write-Host "[3/6] Enabling Game Mode..." -ForegroundColor Yellow

$gameBarPath = 'HKCU:\Software\Microsoft\GameBar'
if (-not (Test-Path $gameBarPath)) { New-Item -Path $gameBarPath -Force | Out-Null }
Set-ItemProperty -Path $gameBarPath -Name 'AutoGameModeEnabled' -Value 1 -Type DWord -Force
Set-ItemProperty -Path $gameBarPath -Name 'AllowAutoGameMode'   -Value 1 -Type DWord -Force

Write-Host "      Game Mode enabled." -ForegroundColor Green

# ---------------------------------------------------------------------------
# Step 4/6: Multimedia Class Scheduler tweaks
# ---------------------------------------------------------------------------
Write-Host "[4/6] Tuning the Multimedia Class Scheduler 'Games' profile..." -ForegroundColor Yellow

$mmRoot = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile'
Set-ItemProperty -Path $mmRoot -Name 'SystemResponsiveness'    -Value 0          -Type DWord -Force
Set-ItemProperty -Path $mmRoot -Name 'NetworkThrottlingIndex'  -Value 0xffffffff -Type DWord -Force

$gamesProfile = "$mmRoot\Tasks\Games"
if (-not (Test-Path $gamesProfile)) { New-Item -Path $gamesProfile -Force | Out-Null }
Set-ItemProperty -Path $gamesProfile -Name 'GPU Priority'        -Value 8      -Type DWord  -Force
Set-ItemProperty -Path $gamesProfile -Name 'Priority'            -Value 6      -Type DWord  -Force
Set-ItemProperty -Path $gamesProfile -Name 'Scheduling Category' -Value 'High' -Type String -Force
Set-ItemProperty -Path $gamesProfile -Name 'SFIO Priority'       -Value 'High' -Type String -Force

Write-Host "      Games profile tuned." -ForegroundColor Green

# ---------------------------------------------------------------------------
# Step 5/6: Fixed pagefile (8 GB initial / 16 GB max) on C:
# ---------------------------------------------------------------------------
Write-Host "[5/6] Pinning pagefile at 8192 MB initial / 16384 MB max on C:..." -ForegroundColor Yellow

$cs = Get-CimInstance -ClassName Win32_ComputerSystem
if ($cs.AutomaticManagedPagefile) {
    Set-CimInstance -InputObject $cs -Property @{ AutomaticManagedPagefile = $false } | Out-Null
    Write-Host "      Disabled automatic pagefile management." -ForegroundColor Green
}

$existing = Get-CimInstance -ClassName Win32_PageFileSetting -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -like 'C:\*' }
if ($existing) {
    $existing | Remove-CimInstance
}

New-CimInstance -ClassName Win32_PageFileSetting -Property @{
    Name        = 'C:\pagefile.sys'
    InitialSize = 8192
    MaximumSize = 16384
} | Out-Null

Write-Host "      Fixed pagefile applied (effective after reboot)." -ForegroundColor Green

# ---------------------------------------------------------------------------
# Step 6/6: Verify VBS / Hyper-V status (DO NOT change — required for Cowork)
# ---------------------------------------------------------------------------
Write-Host "[6/6] Verifying Hyper-V / VBS status..." -ForegroundColor Yellow

try {
    $vbs = Get-CimInstance -ClassName Win32_DeviceGuard `
                            -Namespace 'root\Microsoft\Windows\DeviceGuard' `
                            -ErrorAction Stop
    switch ($vbs.VirtualizationBasedSecurityStatus) {
        2 { Write-Host "      VBS is RUNNING. Cowork / WSL2 / Docker will keep working." -ForegroundColor Green }
        1 { Write-Host "      VBS is enabled but not running. Reboot may be required." -ForegroundColor Yellow }
        0 { Write-Host "      WARNING: VBS is OFF. Cowork / WSL2 / Docker may fail to start." -ForegroundColor Red }
        default { Write-Host "      VBS status unknown ($($vbs.VirtualizationBasedSecurityStatus))." -ForegroundColor Yellow }
    }
} catch {
    Write-Host "      Could not query VBS status: $($_.Exception.Message)" -ForegroundColor Yellow
}

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "  Tune-up complete. Reboot recommended." -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Manual follow-ups (intentionally not automated):" -ForegroundColor White
Write-Host "  * Update GPU driver from the vendor site if the vendor app fails." -ForegroundColor Gray
Write-Host "    NVIDIA: https://www.nvidia.com/drivers" -ForegroundColor Gray
Write-Host "    AMD:    https://www.amd.com/support" -ForegroundColor Gray
Write-Host "  * In your OEM gaming app (Legion Space / Armoury Crate / etc.):" -ForegroundColor Gray
Write-Host "      - GPU mode:     Discrete" -ForegroundColor Gray
Write-Host "      - Power profile: Performance" -ForegroundColor Gray
Write-Host "  * Uninstall vendor bloatware (Nahimic, MaxxAudio, McAfee, etc.)" -ForegroundColor Gray
Write-Host "    via Settings > Apps." -ForegroundColor Gray
Write-Host "  * Leave Memory Integrity ON. The FPS cost on 12th-gen Intel and newer" -ForegroundColor Gray
Write-Host "    is small, and it provides meaningful kernel malware protection." -ForegroundColor Gray
Write-Host ""
