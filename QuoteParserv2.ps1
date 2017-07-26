Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "XML (*.xml)| *.xml"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}

Write-Host "Open your Avnet XML quote" -ForegroundColor Green

$wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop

$i = $wshell.Popup("Please open your quote from Avnet",0,"Open please",64+0) 

$inputfile = Get-FileName "~"

$input = [xml](Get-Content -Path $inputfile)

$input.SelectNodes('//EclipseLineItem')| where { $_.Description -ne "Factory integrated" } | select ProductNumber, Quantity, Description | Out-GridView -Title "Line Items" -Wait


$output = $input.SelectNodes('//EclipseLineItem')| where { $_.Description -ne "Factory integrated" } | select ProductNumber, Quantity, Description

#Write-Host $output

if ($inputfile -ne ""){
 
#Write-Host "Save your output?" -ForegroundColor Green  

$wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop

$i = $wshell.Popup("Would you like to save the human readable table?",0,"Save?",32+4)

if ($i -eq 6){
    #Write-Host "Where would you like to save?" -ForegroundColor Green  
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $SaveFileDialog.initialDirectory = Split-Path -Path $inputfile
    $SaveFileDialog.title = "Save File"
    $SaveFileDialog.filter = "Text Files|*.txt|All Files|*.*" 
    $j = $SaveFileDialog.ShowDialog() #| Out-Null
    #$SaveFileDialog.filename

    if( $j -eq "OK")    {    
           #Write-Host "Selected File and Location:"  -ForegroundColor Green  
           #$SaveFileDialog.filename   
            echo $output > $SaveFileDialog.filename
        } 
        else { Write-Host "File Save Dialog Cancelled!" -ForegroundColor Yellow}
}}


#Write-Host "Press any key to continue ..." -ForegroundColor Green

#$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
