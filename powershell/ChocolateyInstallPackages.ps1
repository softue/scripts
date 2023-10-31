$SERVER_NAME = ""

param([string[]]$grupo="default")

$configWindowStyle="Hidden"
$configWindowStyle="Normal"

Invoke-WebRequest -Uri "https://$SERVER_NAME/chocolatey/grupos/$grupo.txt" -OutFile "c:\temp\$grupo.txt"
$programas = Get-Content -Path c:\temp\$grupo.txt

Write-Host "choco upgrade"
Write-Host "Grupo: $grupo"
Write-Host "Programas: $programas"

$programas | Foreach-Object {
    Start-Process -FilePath "C:\ProgramData\chocolatey\bin\choco.exe" -Verb RunAs -WindowStyle $configWindowStyle -Wait -ArgumentList "upgrade", "-y", "--log-file='c:\temp\choco.log'", $_
}