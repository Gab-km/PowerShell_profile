$psdir="${env:PSCustomScripts}"
Get-ChildItem $psdir\autoload | where Extension -eq ".ps1" | %{.$_.FullName}
 
Write-Host "Custom PowerShell Environment Loaded" -ForegroundColor Cyan