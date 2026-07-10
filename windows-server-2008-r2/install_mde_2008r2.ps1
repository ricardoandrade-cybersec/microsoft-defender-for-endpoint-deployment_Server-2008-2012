
# Microsoft Defender for Endpoint (Legacy)
# Windows Server 2008 R2 Enterprise

$WorkspaceID = "<WORKSPACE_ID>"
$WorkspaceKey = "<WORKSPACE_KEY>"

Write-Host "Starting Microsoft Defender for Endpoint Legacy installation..." -ForegroundColor Green

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "ERROR: Run this script as Administrator." -ForegroundColor Red
    Exit 1
}

$MMAInstaller = "C:\xdr\MMASetup-AMD64.exe"
$Onboarding = "C:\xdr\WindowsDefenderATPLocalOnboardingScript.cmd"

Write-Host "Installation ready." -ForegroundColor Green
