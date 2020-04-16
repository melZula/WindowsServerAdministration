$TextFile = "c:\config.txt"
Get-Content -Path $TextFile
$file = Get-Content -Path $TextFile
 
Install-WindowsFeature DHCP -IncludeManagementTools
Add-DhcpServerv4Scope -name $file[0] -StartRange $file[1] -EndRange $file[2] -SubnetMask $file[3] -State Active
Add-DhcpServerv4ExclusionRange -ScopeID $file[4] -StartRange $file[5] -EndRange $file[6]
Set-DhcpServerv4Scope -ScopeId $file[7] -LeaseDuration $file[8]
Set-DhcpServerv4OptionValue -DnsDomain $file[9] -DnsServer $file[10] -Router $file[11]
Add-DhcpServerv4Failover -Name Failover -PartnerServer $file[12] -ScopeId $file[13] -Force -MaxClientLeadTime $file[14] -ReservePercent $file[15] -ServerRole Active -SharedSecret $file[16] -StateSwitchInterval $file[17]