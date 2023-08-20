Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object Windows.Forms.Form
$Form.Text = "User Management"
$Form.Size = New-Object Drawing.Size(400, 350)

$Label = New-Object Windows.Forms.Label
$Label.Text = "Enter SamAccountName:"
$Label.Location = New-Object Drawing.Point(20, 20)

$TextBox = New-Object Windows.Forms.TextBox
$TextBox.Location = New-Object Drawing.Point(20, 50)
$TextBox.Size = New-Object Drawing.Size(200, 20)

$SearchButton = New-Object Windows.Forms.Button
$SearchButton.Text = "Search"
$SearchButton.Location = New-Object Drawing.Point(240, 48)
$SearchButton.Add_Click({
    $SamAccountName = $TextBox.Text
    $global:User = Get-ADUser -Filter { SamAccountName -eq $SamAccountName } -Properties Name, UserPrincipalName, Enabled

    if ($User) {
        $NameLabel.Text = "Name: " + $User.Name
        $UPNLabel.Text = "UserPrincipalName: " + $User.UserPrincipalName
        $EnabledLabel.Text = "Enabled: " + $User.Enabled
        $DisableButton.Enabled = $User.Enabled
        $DisableButton.BackColor = if ($User.Enabled) { [System.Drawing.SystemColors]::Control } else { [System.Drawing.Color]::Gray }
    } else {
        $NameLabel.Text = "Name: User not found"
        $UPNLabel.Text = "UserPrincipalName: "
        $EnabledLabel.Text = "Enabled: "
        $DisableButton.Enabled = $false
        $DisableButton.BackColor = [System.Drawing.SystemColors]::Control
    }
})

$NameLabel = New-Object Windows.Forms.Label
$NameLabel.Location = New-Object Drawing.Point(20, 100)
$NameLabel.AutoSize = $true

$UPNLabel = New-Object Windows.Forms.Label
$UPNLabel.Location = New-Object Drawing.Point(20, 130)
$UPNLabel.AutoSize = $true

$EnabledLabel = New-Object Windows.Forms.Label
$EnabledLabel.Location = New-Object Drawing.Point(20, 160)
$EnabledLabel.AutoSize = $true

$DisableButton = New-Object Windows.Forms.Button
$DisableButton.Text = "Disable User, Move to New OU, and Update Description"
$DisableButton.Location = New-Object Drawing.Point(20, 190)
$DisableButton.Enabled = $false
$DisableButton.Add_Click({
    if ($global:User) {
        
        # Update user description
        Set-ADUser -Identity $User -Description "No Longer Employed"
        
        # Disable user
        Disable-ADAccount -Identity $User

        # Move user to a different OU
        $TargetOU = ""
        Move-ADObject -Identity $User.DistinguishedName -TargetPath $TargetOU

        $NameLabel.Text = "Name: User disabled, moved to new OU, and description updated"
        $EnabledLabel.Text = "Enabled: False"
        $DisableButton.Enabled = $false
        $DisableButton.BackColor = [System.Drawing.SystemColors]::Control
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please search and select a user before proceeding.")
    }
})

$Form.Controls.Add($Label)
$Form.Controls.Add($TextBox)
$Form.Controls.Add($SearchButton)
$Form.Controls.Add($NameLabel)
$Form.Controls.Add($UPNLabel)
$Form.Controls.Add($EnabledLabel)
$Form.Controls.Add($DisableButton)

$Form.ShowDialog()
