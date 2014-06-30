$loadscript = "${env:PSCustomScripts}\Profile\PowerShellEnvironment.ps1"
if (Test-Path $loadscript)
{
    .$loadscript
}