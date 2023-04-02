
#https://www.youtube.com/watch?v=QT4u74JWbOM

$Servers = Get-Content "C:\script\pcname.csv"
$Folder= "\\<server.ip>\$ins\acrobat.exe" , "\\<server.ip>\$ins\7zip.msi"

foreach ($Server in $Servers){
$Test = Test-path -path "\\$Server\C$\Temp\"
of ($Test -eq $$True){Write-Host "Path exists,hence installing softwars on $Server."}
Else {(Write-Host "Path doesnt exists, hence creating foldet on $Server and starting installation") , New-Item -ItemType Directory -name Temp -Path "\\$Server
