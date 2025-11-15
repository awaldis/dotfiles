oh-my-posh init pwsh --config 'C:\Users\awald\source\repos\dotfiles\oh-my-posh\montys.omp.json' | Invoke-Expression

# PSReadLine configuration for history search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
