# ICMP-Class 🌐
- An Intuitive PowerShell Class Module, for Creating Network Sockets, And to Receive and Send Information via ICMP packets.

# General 💭

### How To Import The Module Class ⏬
- You Can Do it Manually by Downloading The Class Module From This Git Repo

- Or you can do it via Powershell Commandline, or In your powershell Script. You Can Do this By

 `
 iwr -Uri "https://raw.githubusercontent.com/jh1sc/Powershell-ICMP-Class/main/PoSh-Icmp-Class.psm1" -OutFile "Icmp.psm1"
 Using Module "./Icmp.psm1"
 `
 
 
### How To use it 👨‍💻
- First, To Create the Icmp Obj (After You import it obviously), You can
`$obj = [Icmp]::new()`

- Second, Now you have the freedom of all the uses within the class
- $obj.InitAll | Expanded name | Parameters | 
- **InitAll** => Initialise All ====>
- **CreateSocket** => Create Socket ====>
- **SetAddresses** => Set Destination & Source IP ====>
- **Bind** => Bind Source IP to Socket ====>
- **Receive** => Receive On Binded socket ====>
- **ConfPing** => Configure Ping ====>
- **sBytes** => Send Bytes ====>

