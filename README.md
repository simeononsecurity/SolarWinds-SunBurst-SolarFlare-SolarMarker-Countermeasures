# SolarWinds-Orion-Mitigations

Block DLLs mentioned in [MSRC Guidance](https://msrc-blog.microsoft.com/2020/12/13/customer-guidance-on-recent-nation-state-cyber-attacks/) from Loading.

For guidance on the solarwinds issue please see [DHS](https://cyber.dhs.gov/ed/21-01/), [SolarWinds](https://www.solarwinds.com/securityadvisory), [FireEYE](https://www.fireeye.com/blog/threat-research/2020/12/evasive-attacker-leverages-solarwinds-supply-chain-compromises-with-sunburst-backdoor.html), [MSRC](https://msrc-blog.microsoft.com/2020/12/13/customer-guidance-on-recent-nation-state-cyber-attacks/), and [Microsoft](https://www.microsoft.com/en-us/wdsi/threats/malware-encyclopedia-description?Name=Trojan:MSIL/Solorigate.B!dha). 

Advanced users, please see the [FireEYE repo](https://github.com/fireeye/sunburst_countermeasures) on this issue.

## Executables:
The DLL in question is ```SolarWinds.Orion.Core.BusinessLayer.dll``` and was signed as a ligitimate part of the SolarWinds suite, bypassing application control technologies. It is installed as a service.

The malicious code was injected into a legitimate DLL and is loaded into memory when the application runs. The code runs before the legitimate code. According to Microsoft, the code is activated when ```SolarWinds.BusinessLayerHost.exe``` executable runs, but may the following may also load it:
- ```ConfigurationWizard.exe```
- ```NetflowDatabaseMaintenance.exe```
- ```NetFlowService.exe```
- ```SolarWinds.Administration.exe```
- ```SolarWinds.BusinessLayerHost.exe```
- ```SolarWinds.Collector.Service.exe```
- ```SolarwindsDiagnostics.exe```

## Network information:
**General Ranges**
- DNS CNAMEs for C2:
  - ```.appsync-api.eu-west-1[.]avsvmcloud[.]com```
  - ```.appsync-api.us-west-2[.]avsvmcloud[.]com```
  - ```.appsync-api.us-east-1[.]avsvmcloud[.]com```
  - ```.appsync-api.us-east-2[.]avsvmcloud[.]com```
- IP Ranges for C2:
  - ```20.140.0.0/15```
  - ```96.31.172.0/24```
  - ```131.228.12.0/22```
  - ```144.86.226.0/24```
**Specifically Identified**
- DNS Names associated with C2:
  - ```6a57jk2ba1d9keg15cbg.appsync-api.eu-west-1.avsvmcloud[.]com```
  - ```7sbvaemscs0mc925tb99.appsync-api.us-west-2.avsvmcloud[.]com```
  - ```gq1h856599gqh538acqn.appsync-api.us-west-2.avsvmcloud[.]com```
  - ```ihvpgv9psvq02ffo77et.appsync-api.us-east-2.avsvmcloud[.]com``` 
  - ```k5kcubuassl3alrf7gm3.appsync-api.eu-west-1.avsvmcloud[.]com``` 
  - ```mhdosoksaccf9sni9icp.appsync-api.eu-west-1.avsvmcloud[.]com```
- IPs assosciated with C2:
  - ```13.59.205.66```
  - ```54.193.127.66```
  - ```54.215.192.52```
  - ```34.203.203.23``` 
  - ```139.99.115.204``` 
  - ```5.252.177.25```
  - ```5.252.177.21```
  - ```204.188.205.176```	
  - ```51.89.125.18```
  - ```167.114.213.199```
  
## Malicious DLL Table:
| SHA256                                                           | File Version      | Date first seen |
|------------------------------------------------------------------|-------------------|-----------------|
| 32519b85c0b422e4656de6e6c41878e95fd95026267daab4215ee59c107d6c77 | 2019.4.5200.9083  | March 2020      |
| dab758bf98d9b36fa057a66cd0284737abf89857b73ca89280267ee7caf62f3b | 2020.2.100.12219  | March 2020      |
| eb6fab5a2964c5817fb239a7a5079cabca0a00464fb3e07155f28b0a57a2c0ed | 2020.2.100.11831  | March 2020      |
| c09040d35630d75dfef0f804f320f8b3d16a481071076918e9b236a321c1ea77 | Not available     | March 2020      |
| ac1b2b89e60707a20e9eb1ca480bc3410ead40643b386d624c5d21b47c02917c | 2020.4.100.478    | April 2020      |
| 019085a76ba7126fff22770d71bd901c325fc68ac55aa743327984e89f4b0134 | 2020.2.5200.12394 | April 2020      |
| ce77d116a074dab7a22a0fd4f2c1ab475f16eec42e1ded3c0b0aa8211fe858d6 | 2020.2.5300.12432 | May 2020        |
| a25cadd48d70f6ea0c4a241d99c5241269e6faccb4054e62d16784640f8e53bc | 2019.4.5200.8890  | October 2019    |
| d3c6785e18fba3749fb785bc313cf8346182f532c59172b69adfb31b96a5d0af | 2019.4.5200.8890  | October 2019    |


