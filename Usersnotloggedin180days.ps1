$daysInactive = 180
$time = (Get-Date).AddDays(-($daysInactive))
$searchedOU = "DC=manheim,DC=utilitykeystone,DC=com"
$users = Get-ADUser -Filter {LastLogonTimeStamp -le $time} -SearchBase $searchedOU -Properties LastLogonTimeStamp
foreach ($user in $users)
{
    Write-Output "$($user.Name) hasn't logged in for $daysInactive days."
}

