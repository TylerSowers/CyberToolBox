Import-Module ActiveDirectory
$groupName = Read-Host "Enter AD Group Name"
$groupMembers = Get-ADGroupMember -Identity $groupName | Select-Object Name, SamAccountName
$groupMembers | Out-GridView
