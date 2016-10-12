


#VARIABLES
$Date = Get-Date



Write-Host "Welcome to Windows Footprint Tracker" -foregroundcolor green -backgroundcolor black
Write-Host "Today is $Date"	
	
Write-Host 	"1) Recover Deleted Files"				-foregroundcolor green -backgroundcolor black
Write-Host	"2) Parse Internet Browser History"		-foregroundcolor green -backgroundcolor black
Write-Host	"3) Exact Data Matching (EDM) Search"	-foregroundcolor green -backgroundcolor black

Write-Host	"Please input the number corresponding to the Feature: (1-3)"	-foregroundcolor green -backgroundcolor black

$user_Input = Read-Host -Prompt 'Enter Option #: '