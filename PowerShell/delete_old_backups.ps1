<#
.SYNOPSIS
  Delete old backup files

.DESCRIPTION
  Delete backup files older than 2 days

.OUTPUTS
  none

.NOTES
  Version:        1.0
  Author:         Sandor K. - TC2
  Creation Date:  16 feb 2024
  Purpose/Change: Initial script development
#>

# Configuration
$limit = (Get-Date).AddDays(-3)
$bckp_path = "B:\backup\D04"

# Delete files older than the $limit.
Get-ChildItem -Path $bckp_path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force
