[xml]$item = get-content quote.xml
$item.SelectNodes('//EclipseLineItem')| where { $_.Description -ne "Factory integrated" } | select ProductNumber, Quantity, Description > hr_quote.txt
