# Version taken from "Display.Driver\*.inf"
$NvidiaDriver = $(Get-WmiObject Win32_PnPSignedDriver | Where-Object { $_.DeviceName -match "Nvidia Quadro" }).DriverVersion
If ($NvidiaDriver) {
    If ([version]::Parse($NvidiaDriver) -ge [version]::Parse('27.21.14.6259') ) {
        Write-Host "Installed"
    }
}