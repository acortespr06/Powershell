##############################
# Created By: AC047483
#
# Query powershell for hotfix
##############################
#Variables
$ip = ipconfig
$date = date	
$clean = clear
$computername1 = hostname


#Start
Write-Output ""
Write-Output "Please wait..."
Write-Output ""

"kb4022722", "kb4022717", "kb4024402" | ForEach { $hotfix = Get-HotFix -Id $_ -ErrorAction SilentlyContinue
    If ($hotfix) {
        Write-Host "-------------------------------------------------------------------------------------"
        Write-Host -ForegroundColor Green "- $_ is installed on $computername1 Query Date $date"
        Write-Host ""
        Write-Host "Below the details gathered"
        Get-HotFix -Id $_
        Write-Host "-------------------------------------------------------------------------------------"	
    } else {
        Write-Host ""
		Write-Host -ForegroundColor Red " - $_ NOT installed on $computername1"
		Write-Host ""
    }
}

$title = ""
$message = "Do you wish to open Windows Update"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes"

$no =  New-Object System.Management.Automation.Host.ChoiceDescription "&No"

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($result)
    {
        0 {C:\Windows\System32\control.exe /name Microsoft.WindowsUpdate}
        1 {}
    }
