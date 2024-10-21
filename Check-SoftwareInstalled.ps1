#Function to Check if a software is installed
Function Check-SoftwareInstalled
{
    param(
        [Parameter(Mandatory=$true)] [string]$ApplicationName,
        [Parameter(Mandatory=$true)] [string]$Version,
        [Parameter(Mandatory=$False)] [ValidateSet("32-Bit", "64-bit","Current User")] [string]$Scope =  "32-Bit"
        )
 
    #Array to collect Installed Software details
    $InstalledSoftware = New-Object System.Collections.ArrayList
 
    #Get all 32-Bit version of Apps
    $32BitApps = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object {$_.DisplayName -ne $null} | Select-Object DisplayName, DisplayVersion
    $32BitApps | ForEach-Object { 
        $InstalledSoftware.Add([PSCustomObject]@{
            ApplicationName     = $_.DisplayName
            Version = if ($null -eq $_.DisplayVersion -or [string]::Empty -eq $_.DisplayVersion) { "N/A" } else { $_.DisplayVersion }
            Scope = "32-Bit"
        }) | Out-Null
    }
  
    #Get 64 bit versions
    $64BitApps = Get-ChildItem "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object {$_.DisplayName -ne $null} | Select-Object DisplayName, DisplayVersion
    $64BitApps | ForEach-Object { 
       $InstalledSoftware.Add([PSCustomObject]@{
            ApplicationName     = $_.DisplayName
            Version = if ($null -eq $_.DisplayVersion -or [string]::Empty -eq $_.DisplayVersion) { "N/A" } else { $_.DisplayVersion }
            Scope = "64-Bit"
        })| Out-Null
    }
    #Get Software installed in Current user scope
    $CurrentUserApps = Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object {$_.DisplayName -ne $null} | Select-Object DisplayName, DisplayVersion
    $CurrentUserApps | ForEach-Object { 
          $InstalledSoftware.Add([PSCustomObject]@{
            ApplicationName     = $_.DisplayName
            Version = if ($null -eq $_.DisplayVersion -or [string]::Empty -eq $_.DisplayVersion) { "N/A" } else { $_.DisplayVersion }
            Scope           = "Current User"
        }) | Out-Null
    }
 
    #Check if a particular software is installed
    $SoftwareInstalled = $InstalledSoftware | Sort-Object -Property ApplicationName, Version, Scope -Unique | Where {$_.ApplicationName -eq $ApplicationName -and $_.Version -eq $Version -and $_.Scope -eq $Scope}
    If($null -eq $SoftwareInstalled)
    {
        Return $false
    }
    Else
    {
        Return $True
    }
}
 
#Call the function to check if a particular software is installed.
Check-SoftwareInstalled -ApplicationName "AgentInstall-x64_16_0" -Version "16.0.10100.60204"
