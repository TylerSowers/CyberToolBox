$printServer = "PrintServer1"

Get-WmiObject -Class Win32_Printer -ComputerName $printServer | Select-Object Name, DriverName, Description, SystemName
