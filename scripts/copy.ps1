<#
.SYNOPSIS
This script creates a Windows Forms application for processing and copying commands.

.DESCRIPTION
Edit and copy SSH command

.AUTHOR
Andres Cortes

.VERSION
1.0
#>

# Load the Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Bastion OCI Processing"
$form.Size = New-Object System.Drawing.Size(400, 150)
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

# Create a text box for entering the command
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10, 10)
$textBox.Size = New-Object System.Drawing.Size(350, 25)
$form.Controls.Add($textBox)

# Create a button for processing and copying the command
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10, 50)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Process"
$button.Add_Click({
    # Get the text from the text box
    $command = $textBox.Text
    
    # Split the command at the first colon (if exists)
    $parts = $command -split ":", 2
    
    if ($parts.Length -eq 2) {
        # Rebuild the command with the modified text
        $newCommand = $parts[1].Trim()
        $finalCommand = "SSH :$newCommand"
        
        # Set the text box text to the modified command
        $textBox.Text = $finalCommand
        
        # Change the button text to "Execute" and enable copying
        $button.Text = "Execute"
        $button.Add_Click({
            CopyToClipboard
            $computer = "127.0.0.1:2024"
            
            # Execute command
            Start-Process powershell.exe -ArgumentList "-NoExit -Command $finalCommand"
            Start-Sleep -Seconds 2
            Start-Process -FilePath "mstsc.exe" -ArgumentList "/v:$computer"
        })
    }
})
$form.Controls.Add($button)

# Create a button for resetting the form
$resetButton = New-Object System.Windows.Forms.Button
$resetButton.Location = New-Object System.Drawing.Point(120, 50)
$resetButton.Size = New-Object System.Drawing.Size(100, 30)
$resetButton.Text = "Reset Form"
$resetButton.Add_Click({
    # Clear the text box and reset button text and behavior
    $textBox.Text = ""
    $button.Text = "Process"
    $button.Remove_Click($null)
})
$form.Controls.Add($resetButton)

function CopyToClipboard {
    [System.Windows.Forms.Clipboard]::SetText($textBox.Text)
}

# Show the form
$form.Add_Shown({ $textBox.Focus() })
$result = $form.ShowDialog()

# Clean up
$form.Dispose()
