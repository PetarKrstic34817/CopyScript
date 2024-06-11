REM Only these 2 set lines need to be changed the rest of the batch file should just work if it's in the same folder as the ps1 file

REM Example destinationPath C:\RealisticGames\toptenner
REM Example sourcePath W:\KL_Workshop\Pr_Top Tenner\_____FINAL_CONTENT\spine\_output

SET destinationPath=C:\DestinationFolder
SET sourcePath=C:\SourceFolder

Powershell.exe -noexit -executionpolicy bypass -command "& './CopyAssets.ps1' -DestinationPath '%destinationPath%' -SourcePath '%sourcePath%'"