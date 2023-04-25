# Define the desired list of NTP servers
$ntpServers = "0.north-america.pool.ntp.org,1.north-america.pool.ntp.org,2.north-america.pool.ntp.org,3.north-america.pool.ntp.org"

# Verify that the Windows Time service is running
$serviceName = "w32time"
$serviceStatus = (Get-Service -Name $serviceName).Status
if ($serviceStatus -ne "Running") {
    Write-Output "Starting Windows Time service..."
    Start-Service $serviceName
}

# Set the NTP server list and the AnnounceFlags value in the registry
Write-Output "Setting NTP server list and AnnounceFlags value..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\w32time\Parameters" -Name "NtpServer" -Value $ntpServers -Type "MultiString"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\w32time\Config" -Name "AnnounceFlags" -Value 5 -Type "DWord"

# Restart the Windows Time service to apply the changes
Write-Output "Restarting Windows Time service..."
Restart-Service $serviceName
