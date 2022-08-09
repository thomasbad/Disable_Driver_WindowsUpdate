@echo off
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required. Now will try to auto run as Administrator.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)


:: ----------------------------------------------------------
:: ---Do not include drivers with Windows Updates (revert)---
:: ----------------------------------------------------------
echo --- Do not include drivers with Windows Updates (revert)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 0 /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -Prevent Windows Update for device driver search (revert)-
:: ----------------------------------------------------------
echo --- Prevent Windows Update for device driver search (revert)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 1 /f
:: ----------------------------------------------------------


pause
exit /b 0
