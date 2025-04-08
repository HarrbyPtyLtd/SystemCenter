$SiteCode = "S01"
New-CMBoundaryGroup -Name "RDU Boundary Group"
New-CMBoundaryGroup -Name "CLT Boundary Group"

Add-CMBoundaryToGroup -BoundaryGroupName "RDU Boundary Group" -BoundaryName "MTS.COM/RDU"
Add-CMBoundaryToGroup -BoundaryGroupName "CLT Boundary Group" -BoundaryName "CLT Subnet 1"
Add-CMBoundaryToGroup -BoundaryGroupName "CLT Boundary Group" -BoundaryName "CLT Subnet 2"

Set-CMBoundaryGroup -Name "RDU Boundary Group" -DefaultSiteCode $SiteCode
Set-CMBoundaryGroup -Name "CLT Boundary Group" -DefaultSiteCode $SiteCode

Set-CMDistributionPoint -SiteSystemServerName "RDU-CM-01.MTS.COM" -AddBoundaryGroupName "RDU Boundary Group"

Get-CMBoundaryGroup
Get-CMBoundaryGroup | Select-Object Name,DefaultSiteCode,MemberCount,SiteSystemCount