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
#Outbound Rules
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 13.59.205.66" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 13.59.205.66
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 131.228.12.0/22" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 131.228.12.0/22
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 139.99.115.204" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 139.99.115.204
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 144.86.226.0/24" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 144.86.226.0/24
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 167.114.213.199" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 167.114.213.199
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 20.140.0.0/15" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 20.140.0.0/15
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 204.188.205.176" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 204.188.205.176
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 34.203.203.23" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 34.203.203.23
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 5.252.177.21" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 5.252.177.21
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 5.252.177.25" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 5.252.177.25
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 51.89.125.18" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 51.89.125.18
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 54.193.127.66" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 54.193.127.66
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 54.215.192.52" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 54.215.192.52
New-NetFirewallRule -DisplayName "Block Outbound Solarwinds 96.31.172.0/24" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 96.31.172.0/24
#Inbound Rules
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 13.59.205.66" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 13.59.205.66
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 131.228.12.0/22" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 131.228.12.0/22
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 139.99.115.204" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 139.99.115.204
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 144.86.226.0/24" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 144.86.226.0/24
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 167.114.213.199" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 167.114.213.199
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 20.140.0.0/15" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 20.140.0.0/15
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 204.188.205.176" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 204.188.205.176
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 34.203.203.23" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 34.203.203.23
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 5.252.177.21" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 5.252.177.21
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 5.252.177.25" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 5.252.177.25
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 51.89.125.18" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 51.89.125.18
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 54.193.127.66" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 54.193.127.66
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 54.215.192.52" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 54.215.192.52
New-NetFirewallRule -DisplayName "Block Inbound Solarwinds 96.31.172.0/24" -Direction Inbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 96.31.172.0/24
