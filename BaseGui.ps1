# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$LocalPrinterForm                    = New-Object system.Windows.Forms.Form

# Define the size, title and background color
$LocalPrinterForm.ClientSize         = '600,600'
$LocalPrinterForm.text               = "Base GUI Powerhell"
$LocalPrinterForm.BackColor          = "#D3D3D3"

# Display the form
[void]$LocalPrinterForm.ShowDialog()
