class Icmp {
    $ping = [System.Net.NetworkInformation.Ping]::new() #Ping Stoof Obj
    $pingOpt = [System.Net.NetworkInformation.PingOptions]::new() #Ping Stoof Obj Options
    $pingTimeout = 20  #Ping Stoof Obj Timeour
    $EL = $this.EL #End Char
    [byte[]]$buffer #byte buffer
    [ipaddress]$d_IP #Binding IP Address
    [ipaddress]$b_IP #Binding IP Address
    [System.Net.Sockets.Socket] $Socket #Socket For Communication
    InitAll (
        [int]$pto,
        [ipaddress]$dA,
        [ipaddress]$bA,
        [System.Net.Sockets.AddressFamily]$AddressFamily,
        [System.Net.Sockets.SocketType]$SocketType,
        [System.Net.Sockets.ProtocolType]$ProtocolType
    ) {
        $this.pingTimeout = $pto
        $this.d_IP = $dA; $this.b_IP = $bA
        $this.Socket = New-Object System.Net.Sockets.Socket( $AddressFamily, $SocketType, $ProtocolType )
        $this.Socket.bind([system.net.IPEndPoint]::new([system.net.IPAddress]::Parse($this.b_IP), 0))
        $this.Socket.IOControl([Net.Sockets.IOControlCode]::ReceiveAll, [BitConverter]::GetBytes(1), $null)
        [byte[]]$this.buffer = 0..($this.Socket.ReceiveBufferSize) | % { 0 }
        $this.pingOpt.DontFragment = $true
        Write-Verbose "Intialised"
    }
    CreateSocket([System.Net.Sockets.AddressFamily]$AddressFamily, [System.Net.Sockets.SocketType]$SocketType, [System.Net.Sockets.ProtocolType]$ProtocolType) {
        $this.Socket = New-Object System.Net.Sockets.Socket( $AddressFamily, $SocketType, $ProtocolType )
        Write-Verbose "Socket Intialised"
    }
    SetAddresses([ipaddress]$bA, [ipaddress]$dA) {
        if (Test-Connection -ComputerName $dA -Count 1 -BufferSize 256) {
            $this.d_IP = $dA
            Write-Verbose "Binding IP Address Set."
        }
        else {
            Write-Error "Failed To Connect to [$($bA)]"
        }
        if (Test-Connection -ComputerName $bA -Count 1 -BufferSize 256) {
            $this.d_IP = $bA
            Write-Verbose "Binding IP Address Set."
        }
        else {
            Write-Error "Failed To Connect to [$($bA)]"
        }
    }
    Bind() {
        try {
            $this.Socket.bind([system.net.IPEndPoint]::new([system.net.IPAddress]::Parse($this.b_IP), 0))
            $this.Socket.IOControl([Net.Sockets.IOControlCode]::ReceiveAll, [BitConverter]::GetBytes(1), $null)
            [byte[]]$this.buffer = 0..($this.Socket.ReceiveBufferSize) | % { 0 }
        }
        catch { Write-Error "Tried and Failed To Bind To $($this.b_IP)"; $error[0] | Out-String; $error.clear() }
    }
    Receive () {
        [byte[]]$this.buffer = 0..($this.Socket.ReceiveBufferSize) | % { 0 }
        $this.Socket.Receive($this.buffer) | Out-Null
        Write-Verbose "Received"
    }
    [String] Flush () {
        $FeedBack = ([System.Text.Encoding]::Unicode.GetString($this.buffer[28..$this.Socket.ReceiveBufferSize]))
        $FeedBack = ($FeedBack.Substring(0, ($FeedBack.IndexOf($this.EL)))) 
        Write-Verbose "Received"
        return $FeedBack
    }
    ConfPing ([int]$pto) {
        $this.pingTimeout = $pto
        $this.pingOpt.DontFragment = $true
    }
    sBytes ([string]$m) {
        $this.ping.Send(
            [ipaddress]($this.d_IP), $this.pingTimeout, (([text.encoding]::Unicode).GetBytes($m + ($this.EL))), $this.pingOpt
        )
    }
}