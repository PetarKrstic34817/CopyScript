SET destinationPath=C:\RealisticGames\hitthetop
SET sourcePath=W:\KL_Workshop\Pr_Hit the Top\Work\_preFinal\Motion\_output

Powershell.exe -noexit -executionpolicy bypass -command "& './CopyAssets.ps1' -DestinationPath '%destinationPath%' -SourcePath '%sourcePath%'"