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
| _$obj.func_name_ 	| _Expanded Name_             	| _Parameters_                                                                                                                                                                              	|
|------------------	|-----------------------------	|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| **InitAll**      	| Initialise All              	| void InitAll(int pto, ipaddress dA, ipaddress bA, System.Net.Sockets.AddressFamily AddressFamily, System.Net.Sockets.SocketType SocketType, System.Net.Sockets.ProtocolType ProtocolType) 	|
| **CreateSocket** 	| Create Socket               	| void CreateSocket(System.Net.Sockets.AddressFamily AddressFamily, System.Net.Sockets.SocketType SocketType, System.Net.Sockets.ProtocolType ProtocolType)                                 	|
| **SetAddresses** 	| Set Destination & Source IP 	| void SetAddresses(ipaddress bA, ipaddress dA)                                                                                                                                             	|
| **Bind**         	| Bind Source IP to Socket    	| void Bind()                                                                                                                                                                               	|
| **Receive**      	| Receive On Binded Socket    	| void Receive()                                                                                                                                                                            	|
| **ConfPing**     	| Configure Ping Options      	| void ConfPing(int pto)                                                                                                                                                                    	|
| **sBytes**       	| Send Bytes                  	| void sBytes(string m)        
