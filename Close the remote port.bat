@echo off
netsh advfirewall firewall add rule name="Block_RDP" dir=in protocol=TCP localport=3389 action=block
netsh advfirewall firewall add rule name="Block_SMB" dir=in protocol=TCP localport=445 action=block
netsh advfirewall firewall add rule name="Block_NetBIOS" dir=in protocol=UDP localport=137-138 action=block
netsh advfirewall firewall add rule name="Block_NetBIOS" dir=in protocol=TCP localport=139 action=block
netsh advfirewall firewall add rule name="Block_WinRM" dir=in protocol=TCP localport=5985 action=block
netsh advfirewall firewall add rule name="Block_WinRM" dir=in protocol=TCP localport=5986 action=block
echo All specified ports have been blocked.
pause