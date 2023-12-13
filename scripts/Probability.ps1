# Function to calculate probability
function Calculate-Probability {
    param (
        [Parameter(Mandatory=$true)]
        [int[]]$NumberList,
        [Parameter(Mandatory=$true)]
        [int[]]$C6Numbers
    )

    # Calculate total count of numbers
    $TotalCount = $NumberList.Count

    # Create a hashtable to store the count of each unique number
    $NumberCounts = @{}

    # Count occurrences of each number
    foreach ($Number in $NumberList) {
        if ($NumberCounts.ContainsKey($Number)) {
            $NumberCounts[$Number]++
        } else {
            $NumberCounts[$Number] = 1
        }
    }

    # Format the results into a table
    $ResultsTable = @()
    foreach ($Number in $NumberCounts.Keys) {
        $Count = $NumberCounts[$Number]
        $Probability = [math]::Round(($Count / $TotalCount), 4) * 100
        $ResultsTable += [PSCustomObject]@{
            Number = $Number
            Probability = $Probability
        }
    }

    # Sort the results by Probability in descending order
    $ResultsTable = $ResultsTable | Sort-Object -Property Probability -Descending

    # Display the results as a table
    $ResultsTable | Format-Table -AutoSize

    # Display the six numbers with the highest probability
    $TopNumbers = $ResultsTable[0..4].Number
    Write-Host "`nThe highest probability on the Powerball: $($TopNumbers -join ', ')"
    $TopNextNumbers = $ResultsTable[5..9].Number
    Write-Host "`nThe next highest probability on the Powerball: $($TopNextNumbers -join ', ')"

    # Find and display the single number with the highest probability for C6Numbers
    $HighestProbabilityNumber = $C6Numbers | ForEach-Object {
        [PSCustomObject]@{
            Number = $_
            Probability = Calculate-Single-Number-Probability -NumberList $C6Numbers -TotalCount $TotalCount
        }
    } | Sort-Object -Property Probability -Descending | Select-Object -First 1

    Write-Host "`nThe number with the highest probability for Powerball is: $($HighestProbabilityNumber.Number)"
    Write-Host ""
}

# Function to calculate the probability of a single number
function Calculate-Single-Number-Probability {
    param (
        [Parameter(Mandatory=$true)]
        [int[]]$NumberList,
        [Parameter(Mandatory=$true)]
        [int]$TotalCount
    )

    # Create a hashtable to store the count of the unique number
    $NumberCounts = @{}

    # Count occurrences of the number
    foreach ($Number in $NumberList) {
        if ($NumberCounts.ContainsKey($Number)) {
            $NumberCounts[$Number]++
        } else {
            $NumberCounts[$Number] = 1
        }
    }

    # Calculate the probability of the number
    $Count = $NumberCounts[$NumberList[0]]
    $Probability = [math]::Round(($Count / $TotalCount), 4) * 100

    return $Probability
}

# Function to read numbers from a CSV file
function Read-NumbersFromCsv {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    # Read data from CSV file
    $CsvData = Import-Csv -Path $FilePath

    # Initialize arrays to store numbers
    $AllNumbers = @()
    $C6Numbers = @()

    # Iterate through each row and concatenate numbers from 6 columns
    foreach ($Row in $CsvData) {
        $AllNumbers += $Row.'C1', $Row.'C2', $Row.'C3', $Row.'C4', $Row.'C5' | ForEach-Object { [int]$_ }
        $C6Numbers += $Row.'C6' | ForEach-Object { [int]$_ }
    }

    return $AllNumbers, $C6Numbers
}

# Example usage: Read numbers from a CSV file and calculate probability
$FilePath = "C:\Users\andres\Downloads\2023power.csv"
$AllNumbers, $C6Numbers = Read-NumbersFromCsv -FilePath $FilePath
Calculate-Probability -NumberList $AllNumbers -C6Numbers $C6Numbers
