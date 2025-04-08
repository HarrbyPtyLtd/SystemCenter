Get-CMDiscoveryMethod
Get-CMDiscoveryMethod | Where-Object { $_.ComponentName -like "SMS_AD*" }
Get-CMDiscoveryMethod | Where-Object { $_.ComponentName -like "SMS_AD*" } | Select-Object -Property ComponentName, Flag
Get-CMDiscoveryMethod | Where-Object { $_.ComponentName -like "SMS_AD*" } | Select-Object ComponentName, @{l = "Status"; e = { switch ($_.Flag) {
            2 { Write-Output "Disabled" }
            6 { Write-Output "Enabled" }
        }
    }
}