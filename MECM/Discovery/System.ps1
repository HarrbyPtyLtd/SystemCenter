$SiteCode = "S01"
$Schedule = @{
    RecurCount    = 14 
    RecurInterval = "Days"
}
$DiscoverySchedule = New-CMSchedule @Schedule

$DiscoveryMethod = @{
    SiteCode                                  = $SiteCode
    Name                                      = "ActiveDirectorySystemDiscovery"
    AddActiveDirectoryContainer               = @("ldap://ou=rdu clients,dc=mts,dc=com", "ldap://ou=rdu servers,dc=mts,dc=com")
    AddAdditionalAttribute                    = @("Department")
    Enabled                                   = $true
    EnableActiveDirectorySiteBoundaryCreation = $true
    DeltaDiscoveryIntervalMins                = 15
    PollingSchedule                           = $DiscoverySchedule
}
Set-CMDiscoveryMethod  @DiscoveryMethod

(Get-CMDiscoveryMethod -Name ActiveDirectorySystemDiscovery).EmbeddedPropertyLists."AD     Containers"
(Get-CMDiscoveryMethod -Name ActiveDirectorySystemDiscovery).Properties.Props | Where-Object PropertyName -eq "Startup Schedule"
Convert-CMSchedule -ScheduleString "000120000011E000"

(Get-CMDiscoveryMethod -Name ActiveDirectorySystemDiscovery).Properties.Props | Where-Object PropertyName -eq "Full Sync Schedule"
Convert-CMSchedule -ScheduleString "0001200000100070"

Invoke-CMSystemDiscovery -SiteCode RDU

Get-CMDevice | Select-Object -Property Name