# Define the desired list of NTP servers
$ntpServers = "0.north-america.pool.ntp.org,1.north-america.pool.ntp.org,2.north-america.pool.ntp.org,3.north-america.pool.ntp.org"

# Get the current NTP server list from the Windows Time service registry key, and convert it to an array of strings
$currentNtpServers = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\w32time\Parameters" -Name "NtpServer").NtpServer -split ' '

# Compare the current NTP server list with the desired list, and check if they are the same
$diff = Compare-Object $ntpServers $currentNtpServers
if ($diff.Count -eq 0) {
    Write-Output "NTP servers are already correctly configured."
    exit 0 # NTP servers are already correctly configured
} else {
    Write-Output "NTP servers are not correctly configured."
    exit 1 # NTP servers are not correctly configured
}
