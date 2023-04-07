# Create event log for script execution
$source = "WindowsUpdate"
if (-not (Get-EventLog -LogName Application -Source $source -ErrorAction SilentlyContinue)) {
    New-EventLog -LogName Application -Source $source
}

# Log event for script execution
Write-EventLog -LogName Application -Source $source -EventID 1001 -EntryType Information -Message "Windows Update script executed"

# Run Windows Update
function Run-WindowsUpdate {
    $AutoUpdates = new-object -com Microsoft.Update.AutoUpdate
    $AutoUpdates.DetectNow()
}

Run-WindowsUpdate

# Check if server is pending an update
$updateSession = New-Object -ComObject Microsoft.Update.Session
$updateSearcher = $updateSession.CreateUpdateSearcher()
$pendingUpdates = $updateSearcher.Search("IsInstalled=0")
if ($pendingUpdates.Updates.Count -gt 0) {
    # Create scheduled task to reboot server at 11:59 PM
    $action = New-ScheduledTaskAction -Execute 'shutdown.exe' -Argument '/r /t 0'
    $trigger = New-ScheduledTaskTrigger -At '23:59' -Once
    $settings = New-ScheduledTaskSettingsSet
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskName 'RebootAfterWindowsUpdate' -Settings $settings

    # Log event for task creation
    Write-EventLog -LogName Application -Source $source -EventID 1002 -EntryType Information -Message "Scheduled task created to reboot after Windows Update"
}
