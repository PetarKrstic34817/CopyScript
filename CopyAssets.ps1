Param(
	[Parameter(Mandatory, HelpMessage = "Provide the Destination path (Local game folder)")]
	[string]$DestinationPath,
	[Parameter(Mandatory, HelpMessage = "Provide the Source path (output folder on server)")]
	[string]$SourcePath,
	[Parameter(HelpMessage = "Provide a second Source path (output folder on server)")]
	[string]$SourcePathSecond
)
Write-Host "`nSource path is: $SourcePath`nDestination path is: $DestinationPath`n"

$twoPaths = $false

if($PSBoundParameters.ContainsKey('SourcePathSecond'))
{
	Write-Host "`nSecond source path is: $SourcePathSecond`n"
    $twoPaths = $true
}

$confirmation = Read-Host "Are these the correct source and destination paths?`n[Y] Yes [N] No"
if (-not($confirmation -eq 'Y'))
{
	Write-Host "Exiting"
	Exit			
}

$DestinationPath = $DestinationPath + "\src\assets"

if(-not(Test-Path $DestinationPath))
{
	Write-Host "Destination Path is not valid check that the path is to the main game folder"
    if(-not(Test-Path $SourcePath))
    {
	    Write-Host "Source Path does not exist. (Check that you have access to the server)"
	    Exit			
    }
    elseif($twoPaths -and -not(Test-Path $SourcePathSecond))
    {
	    Write-Host "Second source Path does not exist. (Check that you have access to the server)"
	    Exit
    }
    else
    {
        Exit
    }
}

if(-not(Get-ChildItem $SourcePath))
{
    Write-Host "Source folder is empty"
	Exit
}



$srcTestString1 = $SourcePath + "*\1";

Get-ChildItem $SourcePath | ForEach-Object {
    $srcTestString1 = $_.FullName + "\1"
    $srcTestString075 = $_.FullName + "\0.75"
    $srcTestString05 = $_.FullName + "\0.5"
    $srcTestStringJSON = $_.FullName + "\*.json"
    if (!(Test-Path $srcTestString1))
    {
        Write-Host "`nNot all source subfolders contain a `"1`" folder"
	    Exit
    }
    if (!(Test-Path $srcTestString075))
    {
        Write-Host "`nNot all source subfolders contain a `"0.75`" folder"
	    Exit
    }
    if (!(Test-Path $srcTestString05))
    {
        Write-Host "`nNot all source subfolders contain a `"0.5`" folder"
	    Exit
    }
    if (!(Test-Path $srcTestStringJSON))
    {
        Write-Host "`nNot all source subfolders contain at least 1 `".json`" file"
	    Exit
    }
}

if($twoPaths)
{
    Get-ChildItem $SourcePathSecond | ForEach-Object {
    $srcTestString1 = $_.FullName + "\1"
    $srcTestString075 = $_.FullName + "\0.75"
    $srcTestString05 = $_.FullName + "\0.5"
    $srcTestStringJSON = $_.FullName + "\*.json"
    if (!(Test-Path $srcTestString1))
    {
        Write-Host "`nNot all source subfolders contain a `"1`" folder"
	    Exit
    }
    if (!(Test-Path $srcTestString075))
    {
        Write-Host "`nNot all source subfolders contain a `"0.75`" folder"
	    Exit
    }
    if (!(Test-Path $srcTestString05))
    {
        Write-Host "`nNot all source subfolders contain a `"0.5`" folder"
	    Exit
    }
    if (!(Test-Path $srcTestStringJSON))
    {
        Write-Host "`nNot all source subfolders contain at least 1 `".json`" file"
	    Exit
    }
}
}

Write-Host "`n`nALL CHECKS PASSED STARTING COPY`n`n";
Start-Sleep -Seconds 2

$lastSplit = "";

Get-ChildItem $SourcePath -depth 2 | ForEach-Object {
	$splitString = $_.FullName.Split("\");
            if ($_.PSIsContainer -and $_.FullName -like "*\0.5")
            {
		Write-Host "`n";
		$infoOut = "Currently searching the " + $splitString[-2] + " project";
		Write-Host $infoOut
		$output = "info: Found the 0.5 folder of the: " + $splitString[-2] + " project";
                Write-Host $output;
                Copy-Item -Path $_.FullName -Destination $DestinationPath -Recurse -Force
            }
	    if ($_.PSIsContainer -and $_.FullName -like "*\0.75")
            {
		$output = "info: Found the 0.75 folder of the: " + $splitString[-2] + " project";
                Write-Host $output;
                Copy-Item -Path $_.FullName -Destination $DestinationPath -Recurse -Force
            }
	    if ($_.PSIsContainer -and $_.FullName -like "*\1")
            {
		$output = "info: Found the 1 folder of the: " + $splitString[-2] + " project";
                Write-Host $output;
                Copy-Item -Path $_.FullName -Destination $DestinationPath -Recurse -Force
            }
            if($_.FullName -like "*.json")
            {
                $output = "info: Found json file with name: " + $_.Name
                Write-Host $output
                $DestinationPath1 = $DestinationPath + "\1"
                $DestinationPath075 = $DestinationPath + "\0.75"
                $DestinationPath05 = $DestinationPath + "\0.5"
                Copy-Item $_.FullName -Destination $DestinationPath1 -Force
                Copy-Item $_.FullName -Destination $DestinationPath075 -Force
                Copy-Item $_.FullName -Destination $DestinationPath05 -Force
            }
}

if($twoPaths)
{
    Get-ChildItem $SourcePathSecond -depth 2 | ForEach-Object {
	$splitString = $_.FullName.Split("\");
            if ($_.PSIsContainer -and $_.FullName -like "*\0.5")
            {
		Write-Host "`n";
		$infoOut = "Currently searching the " + $splitString[-2] + " project";
		Write-Host $infoOut
		$output = "info: Found the 0.5 folder of the: " + $splitString[-2] + " project";
                Write-Host $output;
                Copy-Item -Path $_.FullName -Destination $DestinationPath -Recurse -Force
            }
	    if ($_.PSIsContainer -and $_.FullName -like "*\0.75")
            {
		$output = "info: Found the 0.75 folder of the: " + $splitString[-2] + " project";
                Write-Host $output;
                Copy-Item -Path $_.FullName -Destination $DestinationPath -Recurse -Force
            }
	    if ($_.PSIsContainer -and $_.FullName -like "*\1")
            {
		$output = "info: Found the 1 folder of the: " + $splitString[-2] + " project";
                Write-Host $output;
                Copy-Item -Path $_.FullName -Destination $DestinationPath -Recurse -Force
            }
            if($_.FullName -like "*.json")
            {
                $output = "info: Found json file with name: " + $_.Name
                Write-Host $output
                $DestinationPath1 = $DestinationPath + "\1"
                $DestinationPath075 = $DestinationPath + "\0.75"
                $DestinationPath05 = $DestinationPath + "\0.5"
                Copy-Item $_.FullName -Destination $DestinationPath1 -Force
                Copy-Item $_.FullName -Destination $DestinationPath075 -Force
                Copy-Item $_.FullName -Destination $DestinationPath05 -Force
            }
    }
}

Write-Host "`n`n`nCOPY COMPLETE!"