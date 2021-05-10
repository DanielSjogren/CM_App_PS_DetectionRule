Function Get-ProcessBit {
    Begin {} 
    Process { 
        If ($([Environment]::Is64BitProcess)) {
            Return "64-bit"
        } else {
            Return "32-bit"
        }
    }
    End {}
}

$ProcessBit = Get-ProcessBit
If ($ProcessBit -eq "32-bit") {
    $InstalledApplications = gp HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | ? {![string]::IsNullOrWhiteSpace($_.DisplayName) } | select DisplayName, DisplayVersion
} Else {
    $InstalledApplications = gp HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | ? {![string]::IsNullOrWhiteSpace($_.DisplayName) } | select DisplayName, DisplayVersion
}

$ApplicationToSearchFor  = $InstalledApplications | Where {$_.DisplayName -eq 'TeamViewer Host'}
If ($ApplicationToSearchFor)  {
    ForEach ($App in $ApplicationToSearchFor) {
        If ([version]::Parse($App.DisplayVersion) -ge [version]::Parse('15.17.7.0') ) {
            Write-Host "Installed"
        }
    }
}