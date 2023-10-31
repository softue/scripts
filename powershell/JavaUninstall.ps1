$SERVER_NAME = ""
function Install-Liberica {
    Write-Host 'Install-Liberica'
    Invoke-WebRequest -Uri "https://$SERVER_NAME/powershell/programas/bellsoft-jre8u382+6-windows-amd64-full.msi" -OutFile 'c:\temp\bellsoft-jre8.msi'
    Start-Process -Wait -Verb RunAs 'msiexec.exe' -ArgumentList "/i", "c:\temp\bellsoft-jre8.msi", "/QN", "/L*V", "c:\temp\bellsoft-jre8.log"
}

function Uninstall-MSI {
    param (
        [string[]]$GUID
    )
    Write-Host 'Uninstall-MSI...', $GUID
    Start-Process -Wait -Verb RunAs 'msiexec.exe' -ArgumentList "/x", "$GUID", " /q"
}

$temJava = 0
$temLiberica = 0
$programas = Get-WmiObject Win32_Product

Write-Host 'Iniciando script...'

$programasTable = $programas | Format-Table IdentifyingNumber, Name, Vendor -HideTableHeaders | Out-String
Write-Host $programasTable

foreach ($programa in $programas) {
    Write-Host $programa.Name
    if ( ($programa.Name -Like 'Java*') -and ($programa.Vendor -Like 'Oracle*') ) { 
        $Global:temJava = 1
        Uninstall-MSI -GUID $programa.IdentifyingNumber
    }
    if ( ($programa.Name -Like 'Liberica*') -and ($programa.Vendor -Like 'BellSoft*') ) { $Global:temLiberica = 1 }
}

Write-Host 'Tem java?', $temJava
Write-Host 'Tem Liberica?', $temLiberica
if ($temJava -or -not($temLiberica) ) { Install-Liberica }

Write-Host 'Fim do script.'