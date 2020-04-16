echo "Enter mode {Auto | Manual}: "
$mode = Read-Host
if ($mode -eq "Auto") {
    Set-NetIPInterface -InterfaceAlias 'Ethernet' -Dhcp Enabled
    Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ResetServerAddresses
}
if ($mode -eq "Manual") {
    New-NetIPAddress –InterfaceAlias “Ethernet” –IPAddress “192.168.1.10” –PrefixLength 24 -DefaultGateway 192.168.1.1
    Set-DnsClientServerAddress -InterfaceAlias “Ethernet” -ServerAddresses 8.8.8.8
}