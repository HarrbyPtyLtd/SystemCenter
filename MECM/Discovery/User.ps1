$SiteCode = "S01"
$Schedule = @{
    RecurCount    = 7 
    RecurInterval = "Days"
}
$DiscoverySchedule = New-CMSchedule @Schedule

$DiscoveryMethod = @{
    SiteCode                                  = $SiteCode
    Name                                      = "ActiveDirectoryUserDiscovery"
    AddActiveDirectoryContainer               = @("ldap://ou=rdu users,dc=mts,dc=com","ldap://ou=clt users,dc=mts,dc=com")
    AddAdditionalAttribute                    = @("Department","Division")
    Enabled                                   = $true
    EnableDeltaDiscovery                   = $true
    DeltaDiscoveryMins                = 15
    PollingSchedule                           = $DiscoverySchedule
}
Set-CMDiscoveryMethod  @DiscoveryMethod

(Get-CMDiscoveryMethod -Name ActiveDirectoryUserDiscovery).EmbeddedPropertyLists."AD Containers"
(Get-CMDiscoveryMethod -Name ActiveDirectoryUserDiscovery).Properties.Props | Where-Object PropertyName -eq "Startup Schedule"
(Get-CMDiscoveryMethod -Name ActiveDirectoryUserDiscovery).Properties.Props | Where-Object PropertyName -eq "Full Sync Schedule"
Convert-CMSchedule -ScheduleString "0001200000114000"
Convert-CMSchedule -ScheduleString "0001170000100038"

Invoke-CMUserDiscovery -SiteCode RDU

Get-CMUser | Select-Object -Property Name