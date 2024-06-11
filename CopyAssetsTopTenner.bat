SET destinationPath=C:\RealisticGames\toptenner
SET sourcePathSpine=W:\KL_Workshop\Pr_Top Tenner\_____FINAL_CONTENT\spine\_output
SET sourcePathMotion=W:\KL_Workshop\Pr_Top Tenner\_____FINAL_CONTENT\Motion\_output

Powershell.exe -noexit -executionpolicy bypass -command "& './CopyAssets.ps1' -DestinationPath '%destinationPath%' -SourcePath '%sourcePathSpine%' -SourcePathSecond '%sourcePathMotion%'"