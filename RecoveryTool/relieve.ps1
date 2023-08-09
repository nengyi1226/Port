# Run this script as an Administrator

Set-ExecutionPolicy RemoteSigned -Force

$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Define the ports that were blocked (including port 136)
$ports = @('135', '136', '137', '138', '139', '145', '161', '162', '389','445', '636', '3268', '3269', '3389')

# Start unblocking ports
Write-Host "Starting to unblock ports..."

$timestamp = Get-Date -Format FileDateTime
$logFile = "C:\FirewallRules_Unblock_$timestamp.log"

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

    # remove inbound and outbound rules for TCP and UDP
    foreach ($protocol in @('TCP', 'UDP')) {
        $inboundRuleName = "Block Inbound Port $port ($protocol)"
        $outboundRuleName = "Block Outbound Port $port ($protocol)"
        
        LogMessage "Removing firewall rule $inboundRuleName..."
        Get-NetFirewallRule -DisplayName $inboundRuleName | Remove-NetFirewallRule
        
        LogMessage "Removing firewall rule $outboundRuleName..."
        Get-NetFirewallRule -DisplayName $outboundRuleName | Remove-NetFirewallRule
    }
}

LogMessage "All specified ports have been unblocked."