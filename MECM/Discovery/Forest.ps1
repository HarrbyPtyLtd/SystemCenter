$SiteCode = "S01"
$Schedule = @{
    RecurCount    = 14 
    RecurInterval = "Days"
}
$DiscoverySchedule = New-CMSchedule @Schedule

$DiscoveryMethod = @{
    SiteCode                                  = $SiteCode
    Name                                      = "ActiveDirectoryForestDiscovery"
    Enabled                                   = $true
    EnableActiveDirectorySiteBoundaryCreation = $true 
    PollingSchedule                           = $DiscoverySchedule
    
}
Set-CMDiscoveryMethod  @DiscoveryMethod

(Get-CMDiscoveryMethod -Name ActiveDirectoryForestDiscovery).Properties.Props
(Get-CMDiscoveryMethod -Name ActiveDirectoryForestDiscovery).Properties.Props | Where-Object PropertyName -eq "Startup Schedule"
Convert-CMSchedule -ScheduleString "0001200000100070"

Invoke-CMForestDiscovery
Get-CMBoundary