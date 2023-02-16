
$outcsv = "c:\temp\tasks_$env:computername.csv"

$taskPath = "\coda\*"

Get-ScheduledTask -TaskPath $taskPath |
    ForEach-Object { [pscustomobject]@{
     Name = $_.TaskName
     Path = $_.TaskPath
     LastResult = $(($_ | Get-ScheduledTaskInfo).LastTaskResult)
     NextRun = $(($_ | Get-ScheduledTaskInfo).NextRunTime)
     Status = $_.State
     Command = $_.Actions.execute
     Arguments = $_.Actions.Arguments }
     } |  Export-Csv -Path $outcsv -NoTypeInformation

gc $outcsv
ls $outcsv
