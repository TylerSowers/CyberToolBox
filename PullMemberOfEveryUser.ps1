Import-Module ActiveDirectory
$users = Get-ADUser -Filter * -Properties MemberOf
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false

# Create a new workbook
$workbook = $excel.Workbooks.Add()
$sheet = $workbook.ActiveSheet
$sheet.Cells.Item(1,1) = "User"
$sheet.Cells.Item(1,2) = "Member Of"

$row = 2

# Loop through each user and retrieve their "Member Of" groups
foreach ($user in $users) {
    $userName = $user.Name
    $memberOf = $user.MemberOf | Get-ADGroup | Select-Object -ExpandProperty Name
    
    # Write the user and their "Member Of" groups to Excel
    $sheet.Cells.Item($row,1) = $userName
    $sheet.Cells.Item($row,2) = $memberOf -join ","
    
    $row++
}

$sheet.Columns.Item(1).AutoFit()
$sheet.Columns.Item(2).AutoFit()
$savePath = "C:\tmp\file.xlsx"
$workbook.SaveAs($savePath)
$workbook.Close()
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($sheet) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($workbook) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()
Write-Host "Data exported to: $savePath"
