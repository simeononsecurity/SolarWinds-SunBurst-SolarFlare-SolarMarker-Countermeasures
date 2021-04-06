#Continue on error
$ErrorActionPreference= 'silentlycontinue'

#Require elivation for script run
#Requires -RunAsAdministrator
Write-Output "Elevating priviledges for this process"
do {} until (Elevate-Privileges SeTakeOwnershipPrivilege)

ForEach ($Policy in (Get-ChildItem ./Files/).FullName){
   Set-AppLockerPolicy -XMLPolicy "$Policy" -Merge
}

# Appplocker service running?
Set-Service -Name AppIdsvc -StartupType Automatic
Start-Service AppIdsvc
Get-Service -Name AppIdsvc | fl St*

#Print Conf
Get-AppLockerPolicy -Local

#https://www.fireeye.com/blog/threat-research/2020/12/evasive-attacker-leverages-solarwinds-supply-chain-compromises-with-sunburst-backdoor.html
#https://www.crowdstrike.com/blog/solarmarker-backdoor-technical-analysis/
Write-Output "Blocking C2 Domain Names with Host File"
$hosts_file = "$env:systemroot\System32\drivers\etc\hosts"
$domains = @(
   "6a57jk2ba1d9keg15cbg.appsync-api.eu-west-1.avsvmcloud.com"
   "7sbvaemscs0mc925tb99.appsync-api.us-west-2.avsvmcloud.com"
   "gq1h856599gqh538acqn.appsync-api.us-west-2.avsvmcloud.com"
   "ihvpgv9psvq02ffo77et.appsync-api.us-east-2.avsvmcloud.com"
   "k5kcubuassl3alrf7gm3.appsync-api.eu-west-1.avsvmcloud.com"
   "mhdosoksaccf9sni9icp.appsync-api.eu-west-1.avsvmcloud.com"
   "vincentolife.com"
)
Write-Output "" | Out-File -Encoding ASCII -Append $hosts_file
foreach ($domain in $domains) {
    if (-Not (Select-String -Path $hosts_file -Pattern $domain)) {
        Write-Output "0.0.0.0 $domain" | Out-File -Encoding ASCII -Append $hosts_file
    }
}

Write-Output "Blocking C2 IPs"
$ips = @(
   "13.59.205.66"
   "131.228.12.0/22"
   "139.99.115.204"
   "144.86.226.0/24"
   "167.114.213.199"
   "20.140.0.0/15"
   "204.188.205.176"
   "34.203.203.23"
   "5.252.177.21"
   "5.252.177.25"
   "51.89.125.18"
   "54.193.127.66"
   "54.215.192.52"
   "96.31.172.0/24"
   "45.135.232.131"
)
Remove-NetFirewallRule -DisplayName "Block Telemetry IPs" -ErrorAction SilentlyContinue | Out-Null
New-NetFirewallRule -DisplayName "Block Telemetry IPs" -Direction Outbound `
    -Action Block -RemoteAddress ([string[]]$ips) | Out-Null
New-NetFirewallRule -DisplayName "Block Telemetry IPs" -Direction Inbound `
    -Action Block -RemoteAddress ([string[]]$ips) | Out-Null
