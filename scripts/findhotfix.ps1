##############################
# Created By: AC047483
#
# Query powershell for hotfix
##############################
clear
#load the popup box
[void][system.reflection.assembly]::loadwithpartialname('Microsoft.VisualBasic')
[system.reflection.assembly]::loadwithpartialname('Microsoft.VisualBasic') | Out-Null
#inputbox for hotfixid
$textinput1 = [Microsoft.VisualBasic.interaction]::inputbox('Enter KB item','MS KB update','EX 4014661')
#inputbox for servername
$computername1 = [Microsoft.VisualBasic.interaction]::inputbox('Enter Server Name','Server identifier','LCAHNCR...')
Write-Output "Please wait"
Write-Output ""
$date = date
#hotfixid property
$hotfix = Get-hotfix | where-object -property hotfixid -match $textinput1 
#If the HotFix was found
if($hotfix) {
    Write-Output "$computername1 $date"
	ipconfig vg
	$hotfix	
} else {
    Write-Output "$computername1 is missing hotfix"
	Write-Output ""
	Write-Output "Manually verify if hotfix is installed"
	Write-Output ""
	Write-Output ""
}