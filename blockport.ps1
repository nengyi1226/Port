# Run this script as an Administrator

Set-ExecutionPolicy RemoteSigned -Force

$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Define the port to block
$ports = @('135', '137', '138', '139', '145', '161', '162', '389','445', '636', '3268', '3269', '3389')

# Start blocking ports
Write-Host "Starting to block ports..."

$timestamp = Get-Date -Format FileDateTime

$logFile = "C:\FirewallRules_$timestamp.log"

function LogMessage {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    Write-Host $Message
    Add-Content -Path $logFile -Value $Message
}

# loop
foreach ($port in $ports) {
    LogMessage "Processing port $port..."

    # Whether the port number is valid
    if ($port -lt 1 -or $port -gt 65535) {
        LogMessage "Invalid port number: $port. Skipping..."
        continue
    }

    # create inbound and outbound rules for TCP and UDP
    foreach ($protocol in @('TCP', 'UDP')) {
        foreach ($direction in @('Inbound', 'Outbound')) {
            LogMessage "Creating $direction rule for $protocol on port $port..."

            try {
                # Create the firewall rule
                $ruleName = "Block $direction Port $port ($protocol)"
                New-NetFirewallRule -DisplayName $ruleName -Direction $direction -LocalPort $port -Protocol $protocol -Action Block -ErrorAction Stop

                LogMessage "Successfully created rule '$ruleName'"
            }
            catch {
                LogMessage "Failed to create rule '$ruleName'"
                LogMessage $_.Exception.Message
            }
        }
    }

    LogMessage "Finished processing port $port"
}

# Finished blocking ports
LogMessage "Finished blocking ports"