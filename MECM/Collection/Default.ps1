$SiteCode = "S01"
$CollectionAllClients = @{
    Name                   = "All Clients"
    LimitingCollectionName = "All Systems"
    RefreshSchedule        = (New-CMSchedule -RecurInterval Days -RecurCount 7)
    RefreshType            = Both
}
New-CMDeviceCollection @CollectionAllClients

$CollectionSiteClients = @{
    Name                   = "$SiteCode Clients"
    LimitingCollectionName = "All Clients"
    RefreshSchedule        = (New-CMSchedule -RecurInterval Days -RecurCount 7)
    RefreshType            = Both
}
New-CMDeviceCollection @CollectionSiteClients

$CollectionSiteServers = @{
    Name                   = "MECM Servers"
    LimitingCollectionName = "All Systems"
    RefreshSchedule        = (New-CMSchedule -RecurInterval Days -RecurCount 7)
    RefreshType            = Periodic
}
New-CMDeviceCollection @CollectionSiteServers

$QueryRuleAllClients = @{
    CollectionName  = "All Clients"
    QueryExpression = "SELECT * FROM SMS_R_System WHERE SMS_R_System.OperatingSystemNameandVersion LIKE 'Microsoft Windows NT Workstation %'"
    RuleName        = "All Clients"
}
Add-CMDeviceCollectionQueryMembershipRule @QueryRuleAllClients

$QueryRuleSiteClients = @{
    CollectionName  = "$SiteCode Clients"
    QueryExpression = "SELECT * FROM SMS_R_System WHERE SMS_R_System.OperatingSystemNameandVersion LIKE 'Microsoft Windows NT Workstation %' AND SMS_R_System.SystemOUName = 'MTS.COM/$SiteCode Clients'"
    RuleName        = "$SiteCode Clients"
}
Add-CMDeviceCollectionQueryMembershipRule @QueryRuleSiteClients

Add-CMDeviceCollectionDirectMembershipRule -CollectionName "MECM Servers" -Resource (Get-CMDevice -Name "LON-CM-01")
Add-CMDeviceCollectionDirectMembershipRule -CollectionName "MECM Servers" -Resource (Get-CMDevice -Name "LON-SVR-01")


Set-CMCollectionMembershipEvaluationComponent -SiteCode RDU -MinutesInterval 30
Get-CMDeviceCollection
Get-CMDeviceCollection | Format-Table -Property Name,CollectionId,LimitToCollectionName,MemberCount