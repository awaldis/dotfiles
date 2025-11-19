oh-my-posh init pwsh --config 'C:\Users\awald\source\repos\dotfiles\oh-my-posh\montys.omp.json' | Invoke-Expression

# PSReadLine configuration for history search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Print the current date and time on startup
$tz = (Get-TimeZone).Id
Write-Host "Shell started at: $(Get-Date -Format 'ddd MMM dd HH:mm:ss') $tz $(Get-Date -Format 'yyyy')" -ForegroundColor Cyan
