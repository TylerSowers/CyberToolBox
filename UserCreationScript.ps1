#this script creates a gui in powershell for creating a user in active directory and assigns certain properties like position. Can easily be modified for any enviornment for quick user creation 

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Import-Module ActiveDirectory

# Start of the form this is where I can modify the overall size of the popout windoe
$form = New-Object System.Windows.Forms.Form
$form.Text = "Employee Information"
$form.Size = New-Object System.Drawing.Size(500, 500)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

# Label Section, for orgranization purposes it's a lot easier to group labels all in one section 
$labelFirstName = New-Object System.Windows.Forms.Label
$labelFirstName.Text = "First Name:"
$labelFirstName.Location = New-Object System.Drawing.Point(20, 20)
$labelFirstName.AutoSize = $true

$labelLastName = New-Object System.Windows.Forms.Label
$labelLastName.Text = "Last Name:"
$labelLastName.Location = New-Object System.Drawing.Point(20, 60)
$labelLastName.AutoSize = $true

$labelDepartment = New-Object System.Windows.Forms.Label
$labelDepartment.Text = "Department:"
$labelDepartment.Location = New-Object System.Drawing.Point(20, 100)
$labelDepartment.AutoSize = $true

$labelPosition = New-Object System.Windows.Forms.Label
$labelPosition.Text = "Position:"
$labelPosition.Location = New-Object System.Drawing.Point(20, 140)
$labelPosition.AutoSize = $true


# textboxes
$textBoxFirstName = New-Object System.Windows.Forms.TextBox
$textBoxFirstName.Location = New-Object System.Drawing.Point(120, 20)
$textBoxFirstName.Size = New-Object System.Drawing.Size(150, 20)

$textBoxLastName = New-Object System.Windows.Forms.TextBox
$textBoxLastName.Location = New-Object System.Drawing.Point(120, 60)
$textBoxLastName.Size = New-Object System.Drawing.Size(150, 20)

# dropdown list for department
$comboBoxDepartment = New-Object System.Windows.Forms.ComboBox
$comboBoxDepartment.Location = New-Object System.Drawing.Point(120, 100)
$comboBoxDepartment.Size = New-Object System.Drawing.Size(150, 20)

# Add department options to the dropdown list
$departments = @("Accounting", "Executive", "Hospitality", "HR", "Maintenance", "Marketing", "Operations")
$comboBoxDepartment.Items.AddRange($departments)

# Create dropdown list for position
$comboBoxPosition = New-Object System.Windows.Forms.ComboBox
$comboBoxPosition.Location = New-Object System.Drawing.Point(120, 140)
$comboBoxPosition.Size = New-Object System.Drawing.Size(150, 20)

# Event handler for when the department selection changes
$comboBoxDepartment.add_SelectedIndexChanged({
    $selectedDepartment = $comboBoxDepartment.SelectedItem

    # Populate positions based on the selected department
    switch ($selectedDepartment) {
        "Accounting" {
            $positions = @()
        }
        "Executive" {
            $positions = @()
        }
        "Hospitality" {
            $Positions = @()
        }
        "HR" {
            $Positions = @()
        }
        "Maintenance" {
            $Positions = @()
        }
        "Marketing" {
            $Positions = @()
        }
        "Operations" {
            $Positions = @()
        }
        "Parts" {
            $Positions = @()
        }
        "" {
            $Positions = @()
        }
        "Sales" {
            $Positions = @()
        }
        "Service" {
            $Positions = @()
        }
        "" {
            $Positions = @()
        }
        default {
            $positions = @()
        }
    }

    # Clear and update the position dropdown list
    $comboBoxPosition.Items.Clear()
    $comboBoxPosition.Items.AddRange($positions)
})

$positionToGroupMap = @{
    "position" =@("Name of Group")

    
}

   

# OK button
$buttonOK = New-Object System.Windows.Forms.Button
$buttonOK.Text = "OK"
$buttonOK.Location = New-Object System.Drawing.Point(120, 240)
$buttonOK.DialogResult = [System.Windows.Forms.DialogResult]::OK

# click for ok button
$buttonOK.Add_Click({
    $firstName = $textBoxFirstName.Text
    $lastName = $textBoxLastName.Text
    $department = $comboBoxDepartment.SelectedItem
    $position = $comboBoxPosition.SelectedItem

    # Check if all fields are filled
    if ($firstName -eq "" -or $lastName -eq "" -or $department -eq "" -or $position -eq "") {
        [System.Windows.Forms.MessageBox]::Show("Please fill all fields.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    # Create the user in Active Directory
    try {
        $ADName = $firstName + $lastName 
        $username = $firstName.Substring(0, 1) + $lastName
        $ouPath = ""

        New-ADUser -SamAccountName $username -Name $ADName -GivenName $firstName -Surname $lastName -Description $position -Department $department -Title $position -Enabled $true -AccountPassword (ConvertTo-SecureString "Ukts1976!" -AsPlainText -Force) -Path $ouPath

        # Get the corresponding group name for the position from the hashtable
        $groupNames = $positionToGroupMap[$position]

        # Add the user to the appropriate group in Active Directory
        if ($groupNames) {
            foreach ($groupName in $groupNames){
            Add-ADGroupMember -Identity $groupName -Members $username
        }
        }

        [System.Windows.Forms.MessageBox]::Show("User '$username' created successfully.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Error creating the user. " + $_.Exception.Message, "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})


# Add controls to the form
$form.Controls.Add($labelFirstName)
$form.Controls.Add($textBoxFirstName)
$form.Controls.Add($labelLastName)
$form.Controls.Add($textBoxLastName)
$form.Controls.Add($labelDepartment)
$form.Controls.Add($comboBoxDepartment)
$form.Controls.Add($labelPosition)
$form.Controls.Add($comboBoxPosition)
$form.Controls.Add($buttonOK)

# Show the form
$result = $form.ShowDialog()


# Dispose the form
$form.Dispose()
