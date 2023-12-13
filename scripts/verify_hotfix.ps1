##############################
# Author: AC047483
#
# Query powershell for hotfix
##############################
#Variables
$ip = ipconfig
$date = date	
$clean = clear
$computername1 = hostname

#Write log 
$Logfile = "C:\Temp\$(gc env:computername)_hotfix_check_log.log"
Function LogWrite{   Param ([string]$logstring)
Add-content $Logfile -value $logstring}


#Start
Write-Output ""
Write-Output "Please wait..."
Write-Output ""

Get-Content -Path "C:\Temp\Hotfix_check.txt"  | ForEach { $hotfix = Get-HotFix -Id $_ -ErrorAction SilentlyContinue
    If ($hotfix) {
        #Write-Host ""
        LogWrite "$_ Installed"
        Write-Host -ForegroundColor Green "- $_ is installed on $computername1"
        #Write-Host ""
    } else {
        #Write-Host ""
		Write-Host -ForegroundColor Red "- $_ NOT installed on $computername1"
        LogWrite "$_ Not Installed"
		#Write-Host ""
    }
}