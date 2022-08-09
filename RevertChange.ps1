# This tool require administrator right, please allow it to start the tool correctly

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
$host.UI.RawUI.WindowTitle = "Firefox Common Lock Tool"

Write-Host @'
----------------------------------------------------------
-------Do not include drivers with Windows Updates--------
----------------------------------------------------------
--- Do not include drivers with Windows Updates
'@
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value "0" -Force
Write-Host '----------------------------------------------------------'

Write-Host @'
----------------------------------------------------------
-----Prevent Windows Update for device driver search------
----------------------------------------------------------
--- Do not include drivers with Windows Updates
'@
Write-Host '--- Prevent Windows Update for device driver search'
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -PropertyType DWord -Value "1" -Force

Write-Host 'Please restart the computer to ensure the change have been made'
Pause
Exit
