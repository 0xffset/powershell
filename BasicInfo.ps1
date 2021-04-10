Write-Output "Computer name is":
Get-Content env:computername
Write-Output "Windows version is:"
(Get-WmiObject -Class Win32_OperatingSystem)
Get-WmiObject Win32_Processor | findstr "Name"
Write-Output "Total Memory is":
[Math]::Round((Get-WmiObject -Class win32_computersystem -ComputerName localhost).TotalPhysicalMemory1Gb)
Write-Output "Diks":
Get-WmiObject -Class Win32_logicaldisk -Filter "DriveType = '3'"
Write-Output "IPV4 addresses"
Get-NetIPAddress -AddressFamily IPv4 | Sort-Object -Property InterfaceIndex | Format-Table