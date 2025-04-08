$SiteCode = "S01"
New-CMBoundary -Name "CLT Subnet 1" -Type IPSubnet -Value "172.17.32.0"
New-CMBoundary -Name "CLT Subnet 2" -Type IPSubnet -Value "172.17.48.0"

Get-CMBoundary
Get-CMBoundary | Select-Object DisplayName,-Value