<#
.SYNOPSIS
  Create local admin account

.DESCRIPTION
  Creates a local administrator account Requires RunAs permissions

.OUTPUTS
  none

.NOTES
  Version:        1.0
  Author:         Sandor K. - TC2
  Creation Date:  13 feb 2024
  Purpose/Change: Initial script development
#>

# Configuration
$username = "sanchezr"
$fullname = "Rick Sanchez"
$description = "C137"

$password = ConvertTo-SecureString "IDDQD!" -AsPlainText -Force  # Super strong plane text password

$logFile = "C:\temp\user_creation_log.txt"

Function Create-LogPath {
    If(!(test-path -PathType container "C:\temp"))
    {   
      New-Item -ItemType Directory -Path "C:\temp"
    }
}

Function Write-Log {
  param(
      [Parameter(Mandatory = $true)][string] $message,
      [Parameter(Mandatory = $false)]
      [ValidateSet("INFO","WARN","ERROR")]
      [string] $level = "INFO"
  )
  # Create timestamp
  $timestamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")

  # Append content to log file
  Add-Content -Path $logFile -Value "$timestamp [$level] - $message"
}

Function Create-LocalAdmin {
    process {
      try {
        New-LocalUser "$username" -Password $password -FullName "$fullname" -Description "$description" -ErrorAction stop
        Write-Log -message "$username local user created"

        # Add new user to administrator group
        Add-LocalGroupMember -Group "Administrators" -Member "$username" -ErrorAction stop
        Write-Log -message "$username added to the local administrators group"
      }catch{
        Write-log -message "Creating local account failed" -level "ERROR"
      }
    }    
}

Create-LogPath

Write-Log -message "----------"
Write-Log -message "$env:COMPUTERNAME - Create local admin account"

Create-LocalAdmin

Write-Log -message "----------"
