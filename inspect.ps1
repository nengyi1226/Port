$allRules = netsh advfirewall firewall show rule name=all

$matchedRules = $allRules | Where-Object { $_ -match "Block (Inbound|Outbound) Port (\d+) \((UDP|TCP)\)" }

echo "Blocked Ports:"
$matchedRules | ForEach-Object {
    if ($_ -match "Block (Inbound|Outbound) Port (\d+) \((UDP|TCP)\)") {
        echo "$($matches[1]) Port: $($matches[2]) Protocol: $($matches[3])"
    }
}