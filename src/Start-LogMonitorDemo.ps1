<#
.SYNOPSIS
    Script which logs to stdout, a log file, and to the event log to demonstrate what the LogMonitor.exe tool
    is able to capture all of this information from a running container
.NOTES
    Assumes that the event log source has been created (New-EventLog -LogName 'Application' -Source 'LogMonitorDemo')
    https://github.com/rleap-m/windows-container-log-monitor
#>
[CmdletBinding()]
param (
    [string] $LogPath = (Join-Path -Path $PSScriptRoot -ChildPath 'SampleLog.log'),
    [string] $EventLogSource = 'LogMonitorDemo',
    [string] $Message = "This is a sample log message."
)

do {
    Write-Verbose -Message $Message
    Write-Host "[stdout] $Message"
    Add-Content -Value "[$(Get-Date -Format s)][$env:COMPUTERNAME] $Message" -Path $LogPath
    Write-EventLog -LogName 'Application' -Source $EventLogSource -EntryType Information -EventId 1 -Message $Message
    Write-Host
    Start-Sleep -Seconds 5
} while ($true)