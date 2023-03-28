## Windows Update Report PowerShell Script

This PowerShell script retrieves all Windows updates that need to be installed and generates a report in PDF format. The report includes the name of each update, the update ID, and a description.

### Prerequisites

To run this script, you'll need to have PowerShell installed on your Windows machine. You'll also need to install the `psWritePDF` module, which can be installed using the following command:

```powershell
Install-Module -Name 'psWritePDF' -Force
