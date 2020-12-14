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
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 144.86.226.0/24" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 144.86.226.0/24
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 131.228.12.0/22" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 131.228.12.0/22
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 96.31.172.0/24" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 96.31.172.0/24
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 20.140.0.0/15" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 20.140.0.0/15
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 144.86.226.0/24" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 144.86.226.0/24
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 131.228.12.0/22" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 131.228.12.0/22
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 96.31.172.0/24" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 96.31.172.0/24
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 20.140.0.0/15" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 20.140.0.0/15
