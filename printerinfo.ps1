$printers = Get-WmiObject -Class Win32_Printer

$outputFile = "printer_info.csv"
$outputData = @()

foreach ($printer in $printers) {
    $printerData = [PSCustomObject]@{
        "Printer Name" = $printer.Name
        "Printer Port" = $printer.PortName
        "Printer Driver Name" = $printer.DriverName
        "Printer Status" = $printer.PrinterStatus
    }
    $outputData += $printerData
}

$outputData | out-gridview
