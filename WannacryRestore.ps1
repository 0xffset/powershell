<#

 Wannacry Restore 

.DESCRIPTION
    The following powershell script try to remove .


.EXAMPLE
    The example below does blah
    PS C:\> Example


.NOTES
    Author: rolEYder
    Github: https://github.com/RolEYder
    Last Edit: yyyy-mm-dd
    Current Version: v1.0.0

#>


<# Create a new Excution Policy to trust commands #>
powershell.exe  -Command "Set-ExecutionPolicy RemoteSigned"


$header = @"

Author: rolEYder
Github: https://github.com/RolEYder

| |  | |                                         | ___ \        | |                 
| |  | | __ _ _ __  _ __   __ _  ___ _ __ _   _  | |_/ /___  ___| |_ ___  _ __ ___  
| |/\| |/ _` | '_ \| '_ \ / _` |/ __| '__| | | | |    // _ \/ __| __/ _ \| '__/ _ \ 
\  /\  / (_| | | | | | | | (_| | (__| |  | |_| | | |\ \  __/\__ \ || (_) | | |  __/ 
 \/  \/ \__,_|_| |_|_| |_|\__,_|\___|_|   \__, | \_| \_\___||___/\__\___/|_|  \___| 
                                           __/ |                                    
                                          |___/                                   
"@


<# Print the header#>
Write-Host $header -ForegroundColor green
Write-Host "[+] Removing tmp file..." -f green 
Start-Sleep -Seconds 3

<# Remove recursivity the tmp folder #>
Remove-Item -path C:\Users\rolEYder\Desktop\remove -recurse -force

<# Listing startup applications #>
Write-Host "[+] Listing startup applications..." -f green 
Start-Sleep -Seconds 3
Get-WmiObject Win32_StartupCommand | Select-Object Name, command, Location, User | Format-List
$commands += Get-WmiObject Win32_StartupCommand | Select-Object Name, command   

foreach($e in $commands) {
    <#If One of the start up programs match with 'tasksche.exe' then will be disable #>
   if($e -match 'tasksche.exe') {
     Write-Host "[+] Wannacry Detected!" -f green 
     $e
     Write-Host "[!] Disableting Wannacry..." -f Yellow
     Start-Sleep -Seconds 3
     Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name $e.Name -Value ([byte[]](0x33, 0x32, 0xFF))       
     Write-Host "[+]  Wannacry is Disabled..." -f green
    }
    else {
       Start-Sleep -Seconds 3
        Write-Host "[!] Wannacry is Not Startup Program in " $e -f Yellow
    } 
}


<# Restaring the system #>
Write-Host "Restaring the system... " -f green
Restart-Computer 