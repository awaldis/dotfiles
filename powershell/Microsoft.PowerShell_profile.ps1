oh-my-posh init pwsh --config "$HOME\source\repos\dotfiles\oh-my-posh\awaldis.omp.json" | Invoke-Expression

# PSReadLine configuration for history search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

& {
    #----------------------------------------------------------------------
    # Gather info to print at shell start.
    #----------------------------------------------------------------------
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

    # Start-time info
    $dateStr = $now.ToString('ddd MMM dd HH:mm:ss UTCzzz yyyy')
    $weekNum = Get-Date $now -UFormat %V

    #----------------------------------------------------------------------
    # Print the info gathered above.
    #----------------------------------------------------------------------
    Write-Host "Shell            : PowerShell $($PSVersionTable.PSVersion)" -ForegroundColor Cyan
    Write-Host "TTY              : $($Host.Name) $($Host.Version)"          -ForegroundColor Cyan
    Write-Host "OS Version       : $osString"                               -ForegroundColor Cyan
    Write-Host "Shell started at : $dateStr Week $weekNum"                  -ForegroundColor Cyan
}
