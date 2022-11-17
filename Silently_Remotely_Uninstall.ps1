
$Servers = Get-content "C:\script\Remotely_Uninstall.txt"
Foreach($Server in $Servers){
Invoke-Command -ComputerName $Server -ScriptBlock {
(Get-Package -Name "AnyDesk*" | Uninstall-Package -ErrorAction SilentlyContinue) ,
(Get-Package -Name "AnyDesk*" | Uninstall-Package -ErrorAction SilentlyContinue) ,

}}
