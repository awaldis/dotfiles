oh-my-posh init pwsh --config "$HOME\source\repos\dotfiles\oh-my-posh\montys.omp.json" | Invoke-Expression

# PSReadLine configuration for history search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Gather info to print at shell start.
& {
    $now = Get-Date
  
    # Default OS string
    $osString = $PSVersionTable.OS

    # Windows-specific "Pretty" version
    if ($IsWindows -or $PSVersionTable.PSEdition -eq 'Desktop') {
        try {
            $cv = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -ErrorAction Stop
            $osString = "$($cv.ProductName) $($cv.DisplayVersion) (Build $($cv.CurrentBuild).$($cv.UBR))"
        }
        catch {
            # Fallback if registry access fails
        }
    }

    Write-Host "Shell started at : $($now.ToString('ddd MMM dd HH:mm:ss UTCzzz yyyy')) Week $(Get-Date $now -UFormat %V)" -ForegroundColor Cyan
    Write-Host "OS Version       : $osString" -ForegroundColor Cyan
}
