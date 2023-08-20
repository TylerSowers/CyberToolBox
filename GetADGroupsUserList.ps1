Import-Module ActiveDirectory
$outputFile = "C:\tmp\user_groups_output.csv"  #List the usernames 1 per line 
$usernamesFile = "C:\tmp\usernames.txt"
$usernames = Get-Content $usernamesFile
$results = @()

# Loop through each username and retrieve the "Member Of" AD object
# The output is going to be the following "item1", "item2", "item3"
foreach ($username in $usernames) {
    $user = Get-ADUser -Identity $username -Properties MemberOf

    if ($user) {
        $memberOf = $user.MemberOf | Get-ADGroup | Select-Object -ExpandProperty Name

        $quotedMemberOf = $memberOf | ForEach-Object { "`"$_`"" }
        $memberOfString = $quotedMemberOf -join ', '

        $result = [PSCustomObject]@{
            'Username' = $username
            'MemberOf' = $memberOfString
        }
    } else {
        $result = [PSCustomObject]@{
            'Username' = $username
            'MemberOf' = 'User not found'
        }
    }

    $results += $result
}

$results | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "Output has been written to: $outputFile"
