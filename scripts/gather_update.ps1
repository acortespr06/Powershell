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


#Clean screen
$clean

#Start
Write-Output ""
Write-Output "Please wait..."
Write-Output ""

#hotfixid property
$hotfix = Get-hotfix -id kb4022722 -ErrorAction SilentlyContinue
$hotfix2 = Get-hotfix -id kb4022717 -ErrorAction SilentlyContinue
$hotfix3 = Get-hotfix -id kb4024402 -ErrorAction SilentlyContinue

Write-Output "test"

#If the HotFix was found
if($hotfix) {
	if($hotfix) {
    Write-Host -ForegroundColor Green "$computername1 $date" 
    #$ip
	$hotfix
    } else {
    Write-Host -ForegroundColor Red "Condition does not apply"
    }

} elseif($hotfix2){
	Write-Host -ForegroundColor Green "Server $computername1 $date" 
	#$ip
	$hotfix2
} elseif($hotfix3){
	Write-Host -ForegroundColor Green "$computername1 $date"
	#$ip
	$hotfix3
} else {
	$clean
	Write-Output ""
    Write-Output "$computername1 hotfix not found"
	Write-Output ""
	Write-Output "Manually verify if hotfix is Installed"
	Write-Output ""
	Write-Output ""
	C:\Windows\System32\control.exe /name Microsoft.WindowsUpdate
}
