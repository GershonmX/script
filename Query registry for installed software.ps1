#This is a PowerShell script that retrieves a list of installed software on a Windows machine by accessing the "Uninstall" registry key under "HKLM:\Software\Microsoft\Windows\CurrentVersion".
#The script starts by assigning the output of the "Get-ChildItem" command to the $InstalledSoftware variable. This command retrieves all the child items under the "Uninstall" key, which contains information about installed software on the system.
#The script then uses a foreach loop to iterate through each object in the $InstalledSoftware array. For each object, it retrieves the value of the "DisplayName" and "DisplayVersion" properties using the "GetValue" method, and displays them using the "write-host" cmdlet. The "-NoNewline" parameter ensures that the output for each software is displayed on a single line.
#Overall, this script provides a simple way to retrieve a list of installed software on a Windows machine using PowerShell.

$InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
foreach($obj in $InstalledSoftware){write-host $obj.GetValue('DisplayName') -NoNewline; write-host " - " -NoNewline; write-host $obj.GetValue('DisplayVersion')}
