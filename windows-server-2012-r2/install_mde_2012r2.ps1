
# ============================================
# Microsoft Defender for Endpoint
# Windows Server 2012 R2
# ============================================

Write-Host "Starting Microsoft Defender for Endpoint installation..." -ForegroundColor Green

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "ERROR: Run this script as Administrator." -ForegroundColor Red
    Exit 1
}

$Installer = "C:\xdr\md4ws.msi"
$Onboarding = "C:\xdr\WindowsDefenderATPLocalOnboardingScript.cmd"

If (!(Test-Path $Installer)) {
    Write-Host "ERROR: Installer not found." -ForegroundColor Red
    Exit 1
}

If (!(Test-Path $Onboarding)) {
    Write-Host "ERROR: Onboarding script not found." -ForegroundColor Red
    Exit 1
}

Write-Host "Installing MDE..." -ForegroundColor Yellow

Start-Process `
    -FilePath "msiexec.exe" `
    -ArgumentList "/i `"$Installer`" /quiet /norestart" `
    -Wait `
    -NoNewWindow

Start-Sleep -Seconds 20

Write-Host "Executing onboarding..." -ForegroundColor Yellow

Start-Process `
    -FilePath $Onboarding `
    -Wait `
    -NoNewWindow

Start-Sleep -Seconds 15

$service = Get-Service -Name Sense -ErrorAction SilentlyContinue

If ($service -and $service.Status -eq "Running") {
    Write-Host "SUCCESS: Sense service is running." -ForegroundColor Green
}
Else {
    Write-Host "WARNING: Sense service is not running." -ForegroundColor Yellow
}
